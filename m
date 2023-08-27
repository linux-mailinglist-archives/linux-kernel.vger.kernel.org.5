Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1A789AD0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjH0B1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjH0B0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:26:54 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113F1B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:52 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56d8bc0d909so1332493eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693099611; x=1693704411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie5AvS87bg127Kdu5s03kcc9obiNPBZ0JNqYthYsEyc=;
        b=zUD1vsSrIt6NDaAmeB/rl4JKwtjqbf5Uby30fzjowl93TMiabkcelrdn0e50bqpdm0
         1h4Gw18y3jK3WKRYljthTXqRU9bAfqMQryNerDQAh8mIa+QDvXoihH5oM9WWlfHtMlDo
         sgiR403FrWrNlom1heS9q9yEFb3GtxSznQIFRERg7lTwUx80bycVJjSHzai+JIQXZMao
         8MiAePd6Cbl1EOPsVTPcCopM4Z23kLD1NS4gUaR0v2QMiPupe1AHOC7sEO8x7yxpqO9B
         gId8JcItLuzUQCzAcpnd0xH5/2WE0dmhbTHwkuoB9pjpuvZRoDJsfTOIFInXdnXv17l8
         pOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099611; x=1693704411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie5AvS87bg127Kdu5s03kcc9obiNPBZ0JNqYthYsEyc=;
        b=WhqX9BfNHwh65WK2GDNXGenhPEEiZDTmyrW8PBo6E/f3rF1lTvJ37Pzyei7Uk1uYFw
         xc1v0ZRsEyGwhfIiosv9m6idWvPbV2xV18PLHroX5Ds5x53tR9H+ENVX51WF5QIb9rcx
         SKUE6TW7XKzRMzSawD1fFd3Cpn65Mk84yv2E5Fgy4i4VapJ2RuS4d2aqU/vSUnKycm36
         wtAzBeG1LBfFTbnEd/VvEVvY7SWvoZYmb+UV4KNk+9G+whn/uMJlfIlgI/Lqon0+ECJl
         U0otvrjfBE47Pm5wO0FDMey6owMtCNZS44tlAzQQ569EkgCWdmx5UANAz7GWUyjN0p2P
         yovg==
X-Gm-Message-State: AOJu0YwWVqOA/mnWQVut/EaCkyV2roKJaRNpw5Ck3y+FjqAfFELalZkv
        k91oxalMjmkW8hLCfR57YBWjFpi/d4WCF23ru0E=
X-Google-Smtp-Source: AGHT+IEoNs4BNtH12YP5V6L4J0N/KuUw1MFS8fSEwjeImsFFj1jnKWjJsURig57J3YVMHkIW5mJN+A==
X-Received: by 2002:a05:6358:4319:b0:13a:4855:d885 with SMTP id r25-20020a056358431900b0013a4855d885mr24823282rwc.10.1693099611417;
        Sat, 26 Aug 2023 18:26:51 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b869410ed2sm4357404plb.72.2023.08.26.18.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:26:50 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Sat, 26 Aug 2023 18:26:09 -0700
Subject: [PATCH 4/5] riscv: Vector checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230826-optimize_checksum-v1-4-937501b4522a@rivosinc.com>
References: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
In-Reply-To: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not ready for merge as vector support in the kernel is
limited. However, the code has been tested in QEMU so the algorithms
do work. When Vector support is more mature, I will do more thorough
testing of this code. It is written in assembly rather than using
the GCC vector instrinsics because they did not provide optimal code.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/lib/csum.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 2037041ce8a0..049a10596008 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -12,6 +12,10 @@
 
 #include <net/checksum.h>
 
+#ifdef CONFIG_RISCV_ISA_V
+#include <riscv_vector.h>
+#endif
+
 /* Default version is sufficient for 32 bit */
 #ifdef CONFIG_64BIT
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
@@ -64,6 +68,166 @@ typedef unsigned long csum_t;
  * the bytes that it shouldn't. The same thing will occur on the tail-end of the
  * read.
  */
+#ifdef CONFIG_RISCV_ISA_V
+#ifdef CONFIG_32BIT
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
+{
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int shift;
+	unsigned int vl, high_result, low_result, csum, offset;
+	unsigned int tail_seg;
+	const unsigned int *ptr;
+
+	if (len <= 0)
+		return 0;
+
+	/*
+	 * To align the address, grab the whole first byte in buff.
+	 * Directly call KASAN with the alignment we will be using.
+	 */
+	offset = (unsigned int)buff & OFFSET_MASK;
+	kasan_check_read(buff, len);
+	ptr = (const unsigned int *)(buff - offset);
+	len += offset;
+
+	// Read the tail segment
+	tail_seg = len % 4;
+	csum = 0;
+	if (tail_seg) {
+		shift = (4 - tail_seg) * 8;
+		csum = *(unsigned int *)((const unsigned char *)ptr + len - tail_seg);
+		csum = ((unsigned int)csum << shift) >> shift;
+		len -= tail_seg;
+	}
+
+	unsigned long start_mask = (unsigned int)(~(~0U << offset));
+
+	asm("vsetvli %[vl], %[len], e8, m1, ta, ma			\n\
+	# clear out mask and vector registers since we switch up sizes	\n\
+	vmclr.m v0							\n\
+	vmclr.m %[prev_buffer]						\n\
+	vmclr.m %[curr_buffer]						\n\
+	# Mask out the leading bits of a misaligned address		\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.s.x %[prev_buffer], %[csum]					\n\
+	vmv.s.x v0, %[start_mask]					\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	vmnot.m v0, v0							\n\
+	vle8.v %[curr_buffer], (%[buff]), v0.t				\n\
+	j 2f								\n\
+	# Iterate through the buff and sum all words			\n\
+	1:								\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	vle8.v %[curr_buffer], (%[buff])				\n\
+	2:								\n\
+	vsetvli x0, x0, e32, m1, ta, ma					\n\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
+	sub %[len], %[len], %[vl]					\n\t"
+#ifdef CONFIG_RISCV_ISA_ZBA
+	"sh2add %[iph], %[vl], %[iph]					\n\t"
+#else
+	"slli %[vl], %[vl], 2						\n\
+	add %[iph], %[vl], %[iph]					\n\t"
+#endif
+	"bnez %[len], 1b						\n\
+	vsetvli x0, x0, e64, m1, ta, ma					\n\
+	vmv.x.s %[result], %[prev_buffer]				\n\
+	addi %[vl], x0, 32						\n\
+	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
+	vmv.x.s %[high_result], %[prev_buffer]"
+	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+		[curr_buffer] "=&vd" (curr_buffer),
+		[high_result] "=&r" (high_result),
+		[low_result] "=&r" (low_result)
+	: [buff] "r" (ptr), [len] "r" (len), [start_mask] "r" (start_mask),
+		[csum] "r" (csum));
+
+	high_result += low_result;
+	high_result += high_result < low_result;
+	result = (unsigned int)result + (((unsigned int)result >> 16) | ((unsigned int)result << 16));
+	if (offset & 1)
+		return (unsigned short)swab32(result);
+	return result >> 16;
+}
+#else
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
+{
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int shift;
+	unsigned long vl, result, csum, offset;
+	unsigned int tail_seg;
+	const unsigned long *ptr;
+
+	if (len <= 0)
+		return 0;
+
+	/*
+	 * To align the address, grab the whole first byte in buff.
+	 * Directly call KASAN with the alignment we will be using.
+	 */
+	offset = (unsigned long)buff & 7;
+	kasan_check_read(buff, len);
+	ptr = (const unsigned long *)(buff - offset);
+	len += offset;
+
+	// Read the tail segment
+	tail_seg = len % 4;
+	csum = 0;
+	if (tail_seg) {
+		shift = (4 - tail_seg) * 8;
+		csum = *(unsigned int *)((const unsigned char *)ptr + len - tail_seg);
+		csum = ((unsigned int)csum << shift) >> shift;
+		len -= tail_seg;
+	}
+
+	unsigned long start_mask = (unsigned int)(~(~0U << offset));
+
+	asm("vsetvli %[vl], %[len], e8, m1, ta, ma			\n\
+	# clear out mask and vector registers since we switch up sizes	\n\
+	vmclr.m v0							\n\
+	vmclr.m %[prev_buffer]						\n\
+	vmclr.m %[curr_buffer]						\n\
+	# Mask out the leading bits of a misaligned address		\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.s.x %[prev_buffer], %[csum]					\n\
+	vmv.s.x v0, %[start_mask]					\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	vmnot.m v0, v0							\n\
+	vle8.v %[curr_buffer], (%[buff]), v0.t				\n\
+	j 2f								\n\
+	# Iterate through the buff and sum all words			\n\
+	1:								\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	vle8.v %[curr_buffer], (%[buff])				\n\
+	2:								\n\
+	vsetvli x0, x0, e32, m1, ta, ma					\n\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
+	subw %[len], %[len], %[vl]					\n\t"
+#ifdef CONFIG_RISCV_ISA_ZBA
+	"sh2add %[iph], %[vl], %[iph]					\n\t"
+#else
+	"slli %[vl], %[vl], 2						\n\
+	addw %[iph], %[vl], %[iph]					\n\t"
+#endif
+	"bnez %[len], 1b						\n\
+	vsetvli x0, x0, e64, m1, ta, ma					\n\
+	vmv.x.s %[result], %[prev_buffer]"
+	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+		[curr_buffer] "=&vd" (curr_buffer), [result] "=&r" (result)
+	: [buff] "r" (ptr), [len] "r" (len), [start_mask] "r" (start_mask),
+		[csum] "r" (csum));
+
+	result += (result >> 32) | (result << 32);
+	result >>= 32;
+	result = (unsigned int)result + (((unsigned int)result >> 16) | ((unsigned int)result << 16));
+	if (offset & 1)
+		return (unsigned short)swab32(result);
+	return result >> 16;
+}
+#endif
+#else
 unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 {
 	unsigned int offset, shift;
@@ -116,3 +280,4 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 		return (unsigned short)swab32(csum);
 	return csum >> 16;
 }
+#endif

-- 
2.41.0

