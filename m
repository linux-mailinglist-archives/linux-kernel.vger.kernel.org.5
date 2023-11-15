Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2A7EC4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjKOOP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbjKOOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:15:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CDB3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:15:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D367FC433C7;
        Wed, 15 Nov 2023 14:15:48 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Silence the boot warning about 'nokaslr'
Date:   Wed, 15 Nov 2023 22:15:30 +0800
Message-Id: <20231115141530.2534778-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel parameter 'nokaslr' is handled before start_kernel(), so we
don't need early_param() to mark it technically. But it can cause a boot
warning as follows:

Unknown kernel command line parameters "nokaslr", will be passed to user space.

When we use 'init=/bin/bash', 'nokaslr' which passed to user space will
even cause a kernel panic. So we use early_param() to mark 'nokaslr',
simply print a notice and silence the boot warning (also fix a potential
panic). This logic is similar to RISC-V.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/relocate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 6c3eff9af9fb..c2f5c2bdeb7f 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -102,6 +102,14 @@ static inline __init unsigned long get_random_boot(void)
 	return hash;
 }
 
+static int __init nokaslr(char *p)
+{
+	pr_info("KASLR is disabled.\n");
+
+	return 0; /* Print a notice and silence the boot warning */
+}
+early_param("nokaslr", nokaslr);
+
 static inline __init bool kaslr_disabled(void)
 {
 	char *str;
-- 
2.39.3

