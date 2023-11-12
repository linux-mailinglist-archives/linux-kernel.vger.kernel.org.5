Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9B7E8E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjKLGQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjKLGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:16:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E54696
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:16:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F126C43395;
        Sun, 12 Nov 2023 06:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769782;
        bh=c/XztdxeZEb8IqwcMkuoEz/d2lH7K8y6SAjCB4w9a8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boE1zCDRZd99yF7fq4wSEnK3GZSGwQ3y48zx3AyteCaYr2xiZaQ3Cqta7dphkuQav
         JsXrIEmI7/L+FoOIP7vXpjhKk60uSnEj6qWvRdCgOCqtBWvh3jO3cmJlurSuxTVGgt
         Cuil7yr8pjzmWRurKglAKkTYEKfu9r3uer2cCuDhvPEawE+gmnGt3FsMMjwaUKGYYJ
         mG6BLk/AWF0pFnFwuXpzxrxmp1s2n8KlOH/XxpnEGtmjJQCIpwZpQ7qpdkmYDxJysN
         tO9TKi5TlnSZF+zanRFWdm38dyJmfonLs13kI4VPKhFNaqvQEqXKXbYOdO4rdwcDRl
         aqilmLVLIsaTA==
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
Subject: [RFC PATCH V2 09/38] riscv: u64ilp32: Add xlen_t in user_regs_struct
Date:   Sun, 12 Nov 2023 01:14:45 -0500
Message-Id: <20231112061514.2306187-10-guoren@kernel.org>
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

The u64ilp32 xlen is 64-bit, not the size of long, so change the
elements of user_regs_struct with xlen_t to match different
__riscv_xlen.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/uapi/asm/ptrace.h | 72 +++++++++++++++-------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index e17c550986a6..39e8d10eebaf 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -10,6 +10,14 @@
 
 #include <linux/types.h>
 
+#if __riscv_xlen == 64
+typedef __u64 xlen_t;
+#elif __riscv_xlen == 32
+typedef __u32 xlen_t;
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
 /*
  * User-mode register state for core dumps, ptrace, sigcontext
  *
@@ -17,38 +25,38 @@
  * struct user_regs_struct must form a prefix of struct pt_regs.
  */
 struct user_regs_struct {
-	unsigned long pc;
-	unsigned long ra;
-	unsigned long sp;
-	unsigned long gp;
-	unsigned long tp;
-	unsigned long t0;
-	unsigned long t1;
-	unsigned long t2;
-	unsigned long s0;
-	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
-	unsigned long s2;
-	unsigned long s3;
-	unsigned long s4;
-	unsigned long s5;
-	unsigned long s6;
-	unsigned long s7;
-	unsigned long s8;
-	unsigned long s9;
-	unsigned long s10;
-	unsigned long s11;
-	unsigned long t3;
-	unsigned long t4;
-	unsigned long t5;
-	unsigned long t6;
+	xlen_t pc;
+	xlen_t ra;
+	xlen_t sp;
+	xlen_t gp;
+	xlen_t tp;
+	xlen_t t0;
+	xlen_t t1;
+	xlen_t t2;
+	xlen_t s0;
+	xlen_t s1;
+	xlen_t a0;
+	xlen_t a1;
+	xlen_t a2;
+	xlen_t a3;
+	xlen_t a4;
+	xlen_t a5;
+	xlen_t a6;
+	xlen_t a7;
+	xlen_t s2;
+	xlen_t s3;
+	xlen_t s4;
+	xlen_t s5;
+	xlen_t s6;
+	xlen_t s7;
+	xlen_t s8;
+	xlen_t s9;
+	xlen_t s10;
+	xlen_t s11;
+	xlen_t t3;
+	xlen_t t4;
+	xlen_t t5;
+	xlen_t t6;
 };
 
 struct __riscv_f_ext_state {
-- 
2.36.1

