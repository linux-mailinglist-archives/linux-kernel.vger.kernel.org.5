Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171377FC887
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbjK1VHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346822AbjK1VHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:07:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7890F2132
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA97BC433BA;
        Tue, 28 Nov 2023 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205619;
        bh=X6PK4oBFo/KwYkDeQ/y95m2BXrZFZdq9RKhHH1b3Ycg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJwLSoz/hojYq3yJZkbkmwjvC0x/glN70tyFJ6kX2rRpc079OtNFQv3QarLDfNUCP
         9Aa/HzK/Z7IYDcUwYoRF32Oom36FA+CNO787BmDSKyZc5+yM5bxG9sYW9IG+CHG+U+
         LTolSAAVK5NXcXPslfExwncrjfrN5F9LaZuKbVFjGhoUJbRV0/DMa7uY7jPNbJLcv1
         MeiwLRr+C0k+qRH3qjy7cz+YdBVvcn7Q2nX5cB2vesRFT1awQ8zSTwHGw+zpe1hQJy
         fxsXY/9YPZ7mQzSP26eg2krpmkzKysr6+veUsLqWunWxmTG+NQnEUPeK9rqMY/8AcW
         zK7Kc/pJlMtGw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     WANG Rui <wangrui@loongson.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        ndesaulniers@google.com, tangyouling@loongson.cn, git@xen0n.name,
        huqi@loongson.cn, xry111@xry111.site, zhoubinbin@loongson.cn,
        zhangqing@loongson.cn, chenfeiyang@loongson.cn,
        hejinyang@loongson.cn, loongarch@lists.linux.dev,
        llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 19/40] LoongArch: Record pc instead of offset in la_abs relocation
Date:   Tue, 28 Nov 2023 16:05:25 -0500
Message-ID: <20231128210615.875085-19-sashal@kernel.org>
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

From: WANG Rui <wangrui@loongson.cn>

[ Upstream commit aa0cbc1b506b090c3a775b547c693ada108cc0d7 ]

To clarify, the previous version functioned flawlessly. However, it's
worth noting that the LLVM's LoongArch backend currently lacks support
for cross-section label calculations. With this patch, we enable the use
of clang to compile relocatable kernels.

Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/asmmacro.h | 3 +--
 arch/loongarch/include/asm/setup.h    | 2 +-
 arch/loongarch/kernel/relocate.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index c9544f358c339..655db7d7a4279 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -609,8 +609,7 @@
 	lu32i.d	\reg, 0
 	lu52i.d	\reg, \reg, 0
 	.pushsection ".la_abs", "aw", %progbits
-	768:
-	.dword	768b-766b
+	.dword	766b
 	.dword	\sym
 	.popsection
 #endif
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index a0bc159ce8bdc..ee52fb1e99631 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -25,7 +25,7 @@ extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len
 #ifdef CONFIG_RELOCATABLE
 
 struct rela_la_abs {
-	long offset;
+	long pc;
 	long symvalue;
 };
 
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 6c3eff9af9fb1..288b739ca88dd 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -52,7 +52,7 @@ static inline void __init relocate_absolute(long random_offset)
 	for (p = begin; (void *)p < end; p++) {
 		long v = p->symvalue;
 		uint32_t lu12iw, ori, lu32id, lu52id;
-		union loongarch_instruction *insn = (void *)p - p->offset;
+		union loongarch_instruction *insn = (void *)p->pc;
 
 		lu12iw = (v >> 12) & 0xfffff;
 		ori    = v & 0xfff;
-- 
2.42.0

