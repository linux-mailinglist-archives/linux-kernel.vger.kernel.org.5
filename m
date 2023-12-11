Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB080CC22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbjLKN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjLKNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:55:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE15E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:54:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F70CC433C7;
        Mon, 11 Dec 2023 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302851;
        bh=gmWXl8OnCsDxGnfCAvvdJ9/lz1xt84JHADheam84Pw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvBl+m+09oDNEHo5Q4aH4aSNYq1uuGpreTCXZSr+fq6/zGeVIrqeesF+pDMbTWPQz
         Mty/KJfz/VOiqPxs0kzdlmduh1GRgdiNrg7udScux6bWlfH/1eajcWbom7LejGz1lh
         Lvdn/CHmwXZpBjjagkDYpW5nboFbbd4uYFO93as7Iduh+QjJ631ExDl+CJngjFQTw5
         3ECbZyz3lWwqMoGNdSPECQZhZziinpGJ7aWmopuGw7tNLW6qxqwZcSafcaov140a6g
         IIZJTW7ciKxEdxDSg1kULVGdLxpdGSNwsyZBOI9UFlRmJ5yxw4qSt/xkFIyUa2qW1q
         qRWJQYfttmrMA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hengqi Chen <hengqi.chen@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        yangtiezhu@loongson.cn, loongarch@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.6 47/47] LoongArch: Preserve syscall nr across execve()
Date:   Mon, 11 Dec 2023 08:50:48 -0500
Message-ID: <20231211135147.380223-47-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Hengqi Chen <hengqi.chen@gmail.com>

[ Upstream commit d6c5f06e46a836e6a70c7cfd95bb38a67d9252ec ]

Currently, we store syscall nr in pt_regs::regs[11] and syscall execve()
accidentally overrides it during its execution:

    sys_execve()
      -> do_execve()
        -> do_execveat_common()
          -> bprm_execve()
            -> exec_binprm()
              -> search_binary_handler()
                -> load_elf_binary()
                  -> ELF_PLAT_INIT()

ELF_PLAT_INIT() reset regs[11] to 0, so in syscall_exit_to_user_mode()
we later get a wrong syscall nr. This breaks tools like execsnoop since
it relies on execve() tracepoints.

Skip pt_regs::regs[11] reset in ELF_PLAT_INIT() to fix the issue.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index b9a4ab54285c1..9b16a3b8e7060 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -293,7 +293,7 @@ extern const char *__elf_platform;
 #define ELF_PLAT_INIT(_r, load_addr)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
-	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
+	_r->regs[9] = _r->regs[10] /* syscall n */ = _r->regs[12] = 0;	\
 	_r->regs[13] = _r->regs[14] = _r->regs[15] = _r->regs[16] = 0;	\
 	_r->regs[17] = _r->regs[18] = _r->regs[19] = _r->regs[20] = 0;	\
 	_r->regs[21] = _r->regs[22] = _r->regs[23] = _r->regs[24] = 0;	\
-- 
2.42.0

