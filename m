Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB0803200
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbjLDL6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjLDL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C801730
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC81C433CA;
        Mon,  4 Dec 2023 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691051;
        bh=l3hz5mRSkD7DYuIne0Jscf5nMuXOjPSpfpHitUXLfNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYju0IOlb2TZrxG39W4fehNxMRmqlATtHntDxpY+g2sbOW2vqYsLSabsIN85X2IKB
         522QAmTLBVu3ccT3mp1eO35f9ihoS8ikt6C71Q7laTkABSBmgOze/5ZU1siNfxrL61
         wLZhksMb3BVJ1GH/1CER0bvdgTak3ycLpRy4a1X8N4smggealQfRClDU4Z+/HXv4As
         YHsH3CJxKh7SbOhBmpVJXnmDXpcblovN3gQzGtQrReuy+QcI1koELRFD76t4ZHnpSF
         WzoaLZrAxPg5gTIHb8aiBU/X04pEQnBdaV/eN8tzdncKEhW0gIHqFIGcHZJShlFico
         Opnidked/E+qA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 06/20] mips: mark local function static if possible
Date:   Mon,  4 Dec 2023 12:56:56 +0100
Message-Id: <20231204115710.2247097-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These two functions are global but have no extern prototypes or other
callers, so it's best to mark them as static, avoiding these warnings:

arch/mips/kernel/mips-cm.c:204:13: error: no previous prototype for '__mips_cm_l2sync_phys_base' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1827:12: error: no previous prototype for 'r4k_cache_init_pm' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/mips-cm.c | 2 +-
 arch/mips/mm/c-r4k.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 3f00788b0871..84b3affb9de8 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -201,7 +201,7 @@ phys_addr_t __mips_cm_phys_base(void)
 phys_addr_t mips_cm_phys_base(void)
 	__attribute__((weak, alias("__mips_cm_phys_base")));
 
-phys_addr_t __mips_cm_l2sync_phys_base(void)
+static phys_addr_t __mips_cm_l2sync_phys_base(void)
 {
 	u32 base_reg;
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 187d1c16361c..0619e5296ff3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1828,7 +1828,7 @@ static struct notifier_block r4k_cache_pm_notifier_block = {
 	.notifier_call = r4k_cache_pm_notifier,
 };
 
-int __init r4k_cache_init_pm(void)
+static int __init r4k_cache_init_pm(void)
 {
 	return cpu_pm_register_notifier(&r4k_cache_pm_notifier_block);
 }
-- 
2.39.2

