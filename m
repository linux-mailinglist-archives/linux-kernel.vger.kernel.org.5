Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75E77957D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjHKRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjHKRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7811FE3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0313565816
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BF6C433CC;
        Fri, 11 Aug 2023 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773257;
        bh=erurmBk6eYQvncO35/wgAhKngMgxH6cwdYjQXfYK+oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KedcF9hvhoiTuwvwmjKJlSSKEawCZwEKWmHJ6+4HPVPxmFuWODvSihQVsIlxVDdEK
         j2eFLIFuxieQuQL/D8VMiGtY9AAsI2NsHptzs0cFPjhp+flYNfGCrgFHvOjD8dsuMw
         2J0E7jS4x3RebYPuezSCYxWADvoWlaqUTpY0MB/Rlo7acpO0mmH8SI/mn8qOE+e62S
         bLdD7ZjPSZlxKPEIv78y+xLAt0R3Q4ihSud4LIcd2pshg2vEDyWcZjN1gTdncJO7l7
         fUj4hhvlQqUI93iJ9lb8c+sm1IPpcregD/9taiXt9gWl3FroW81kFREy2WF9fa1atG
         8oJo73E1HIvVA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 01/10] x86: Add a comment about the "magic" behind shadow sti before mwait
Date:   Fri, 11 Aug 2023 19:00:40 +0200
Message-Id: <20230811170049.308866-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811170049.308866-1-frederic@kernel.org>
References: <20230811170049.308866-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note to make sure we never miss and break the requirements behind
it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..341ee4f1d91e 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -87,6 +87,15 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
+/*
+ * Re-enable interrupts right upon calling mwait in such a way that
+ * no interrupt can fire _before_ the execution of mwait, ie: no
+ * instruction must be placed between "sti" and "mwait".
+ *
+ * This is necessary because if an interrupt queues a timer before
+ * executing mwait, it would otherwise go unnoticed and the next tick
+ * would not be reprogrammed accordingly before mwait ever wakes up.
+ */
 static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
-- 
2.34.1

