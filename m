Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C57E8EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjKLGSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjKLGRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:17:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872DA469C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:17:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44E8C433C8;
        Sun, 12 Nov 2023 06:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769843;
        bh=bke8fOXFDjV1zILAGkdyjNPTOfL1ZR2nFogEIcEnLNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMoW3pc7nxmWk9TC7awLImserdou0qBcPtBdvsgWteW/xYXDxcUp9v4CpLyETmaoe
         p3F6oi8kTZDV31QvjU85h0OvOvaSmokczVTFAn8MOVlJv4xAOqyCkEWTSCOVQhiVaO
         +VMnKyi2Y49C1IwpIkWtL55An0Wh21zTNPPdJbECeOst0TfGqO1q1Qa46RZy2jqKZX
         dkCnLhdQYPdb1O6P/jSu/4/wlIY0OIQVhM8E5enAcQkeavsiof2vH1S9rtjvuMoXtF
         BckquD1HmBgApzGOgJxELfdlsEjtlWU1xrlEjpMdpe78xyEva6NJTvqonnWbhS/bzu
         Qk8o+iazacIow==
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
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kerenl.org>
Subject: [RFC PATCH V2 19/38] riscv: s64ilp32: Add ELF32 support
Date:   Sun, 12 Nov 2023 01:14:55 -0500
Message-Id: <20231112061514.2306187-20-guoren@kernel.org>
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

Use abi_len to distinct ELF32 and ELF64 because s64ilp32 is xlen=64 and
abi_len=32 (__SIZEOF_POINTER__=4). And s64ilp32 is an ELF32 based the
same as s32ilp32.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kerenl.org>
---
 arch/riscv/include/uapi/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..962e8ec8fe05 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -24,7 +24,7 @@ typedef __u64 elf_fpreg_t;
 typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
 
-#if __riscv_xlen == 64
+#if __SIZEOF_POINTER__ == 8
 #define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
 #define ELF_RISCV_R_TYPE(r_info)	ELF64_R_TYPE(r_info)
 #else
-- 
2.36.1

