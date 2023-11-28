Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDB7FC844
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376440AbjK1VH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjK1VHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:07:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F046D1BE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C88DC433CA;
        Tue, 28 Nov 2023 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205624;
        bh=6HoEwbrM1RqIbQiSdb1WvbUbUd/R80KpCgilb0WBcy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1IHwzGwuMwlZFdiVwho1/BLiw3+Q5yEdxgfXuoJOfrM0Hux/GcBzGvL7TecLwgDQ
         eiEGH3o3m+R+SjIYmZzHGnHjvD3mYFX2N0Oz4u+LT5/yDA6326iwXMPGVctXPn5IJh
         LhTbWXnPsd99QDK3g0XKiOG1HR5D/WCMylBxFDOKUohGbyurm4/WocCXcF7JRDhXJh
         zRA3lxPMqhGuH1qU9AC1N/kZzS1zceyjVuIzMM5uMlS/YHpjZs0/XMu4IkuRd1PcIB
         tx0GUHm3agxEYob/wPhUvBwZNtDp+kJaAdw1DEHk/djNNYshRK97fzD8Zfz2O1gNHS
         JkV17Ju4u4fsw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        tangyouling@loongson.cn, xry111@xry111.site, wangrui@loongson.cn,
        zhangqing@loongson.cn, loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 20/40] LoongArch: Silence the boot warning about 'nokaslr'
Date:   Tue, 28 Nov 2023 16:05:26 -0500
Message-ID: <20231128210615.875085-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 902d75cdf0cf0a3fb58550089ee519abf12566f5 ]

The kernel parameter 'nokaslr' is handled before start_kernel(), so we
don't need early_param() to mark it technically. But it can cause a boot
warning as follows:

Unknown kernel command line parameters "nokaslr", will be passed to user space.

When we use 'init=/bin/bash', 'nokaslr' which passed to user space will
even cause a kernel panic. So we use early_param() to mark 'nokaslr',
simply print a notice and silence the boot warning (also fix a potential
panic). This logic is similar to RISC-V.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/relocate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 288b739ca88dd..1acfa704c8d09 100644
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
2.42.0

