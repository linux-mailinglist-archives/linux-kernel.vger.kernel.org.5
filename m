Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AA7F5CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjKWKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344824AbjKWKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:48:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD5D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:48:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456EDC433C8;
        Thu, 23 Nov 2023 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736498;
        bh=bnImJ/ObQ6B/nPGCBESa5sKS25GC8i0wwxIop7YcLiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF/smYE6w5t3Qu/JkXRjWHikWmWDZmaBN5EAC0TUMncJwqfZpU4hZRIOLkZvfaEB7
         mm+xLV+CyHdSJjMBRUaiN3Xb26CVJGT5Rbc6Iqsf8EioYjGQdfjA3bQn2Llibv7KcB
         wxDRkP+Skv7hD8WFmKTzR4O17Zr5+T4R9K1U3GIyPxAE57goc21d5V7iNvRg/HK01R
         M5JBj2jvncyqmoXhXTq2ovGGOOL+zKKWz/kuGzcn0L5WXG9DPX2lzz6jK5UlZGnEGZ
         LB1pRNtB2JwMDzAG9D/hc/+Q+YR1ZZ9kF9JeBFGGZND7JWtJzZ6UycYqQGDJVw7Clc
         8MCN4mafoiABw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] powerpc: powermac: mark smp_psurge_{give,take}_timebase static
Date:   Thu, 23 Nov 2023 11:48:01 +0100
Message-Id: <20231123104801.15537-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123104801.15537-1-arnd@kernel.org>
References: <20231123104801.15537-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These functions are only called locally and should be static like the
other corresponding functions are:

arch/powerpc/platforms/powermac/smp.c:416:13: error: no previous prototype for 'smp_psurge_take_timebase' [-Werror=missing-prototypes]
  416 | void __init smp_psurge_take_timebase(void)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/platforms/powermac/smp.c:432:13: error: no previous prototype for 'smp_psurge_give_timebase' [-Werror=missing-prototypes]
  432 | void __init smp_psurge_give_timebase(void)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/powermac/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c83d1e14077e..15644be31990 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -413,7 +413,7 @@ static void __init smp_psurge_setup_cpu(int cpu_nr)
 		printk(KERN_ERR "Couldn't get primary IPI interrupt");
 }
 
-void __init smp_psurge_take_timebase(void)
+static void __init smp_psurge_take_timebase(void)
 {
 	if (psurge_type != PSURGE_DUAL)
 		return;
@@ -429,7 +429,7 @@ void __init smp_psurge_take_timebase(void)
 	set_dec(tb_ticks_per_jiffy/2);
 }
 
-void __init smp_psurge_give_timebase(void)
+static void __init smp_psurge_give_timebase(void)
 {
 	/* Nothing to do here */
 }
-- 
2.39.2

