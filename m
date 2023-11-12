Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3567E8E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjKLGQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjKLGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:16:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2EA3840
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:16:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415FC433CC;
        Sun, 12 Nov 2023 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769788;
        bh=x2yNl81rtMLNR83PEs3HCmEpsQ4/7rJymYTh7H6aEEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB1Tkw1ZePpU08PhgrQFyDzSgHHkUjmbXxR/MUfG9bEVV+Iqk7O9UI0yiAixM8Jim
         ijdKADfSY75NGC29rcYC1mdguX3mcb7TwbXCv5XJbBQy0Szp1r0s50Ul50mA7JJS0O
         nLfC/bApQGYZcDd7S8pGBd2WNctZpvQ2G4sr3FE+v+cbbKJcQ154u+YzChQk2HyUZO
         QMl52JlYFGIXKd1n7CaPK5ahUUZ3kDSEhDiIoMq5PhRfUHho2veayBgIf8qrZBZYJS
         dEMpUJibV+TeKlPUnHb0iDewAmVuzxXifFf3b86rqSS9CRpgB19LbEZjFi810Jl04U
         Ds4QiYJ1/SScw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 10/38] riscv: u64ilp32: Remove the restriction of UXL=32
Date:   Sun, 12 Nov 2023 01:14:46 -0500
Message-Id: <20231112061514.2306187-11-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

The u64ilp32 needn't hardware support UXL=32, so remove the
restriction when EF_RISCV_64ILP32 is detected.

Reported-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e32d737e039f..93057ca2e2a7 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -88,7 +88,7 @@ static bool compat_mode_supported __read_mostly;
 
 bool compat_elf_check_arch(Elf32_Ehdr *hdr)
 {
-	return compat_mode_supported &&
+	return (compat_mode_supported || (hdr->e_flags & EF_RISCV_64ILP32)) &&
 	       hdr->e_machine == EM_RISCV &&
 	       hdr->e_ident[EI_CLASS] == ELFCLASS32;
 }
-- 
2.36.1

