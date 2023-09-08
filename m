Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334D798179
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbjIHFO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjIHFOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:14:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3214319B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:14:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf5c314a57so13416705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694150059; x=1694754859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAPQF3AIxfJJMuNhHMSqprX+We7Y3OynQxSaHAD1HDU=;
        b=F3oqGUiCSwQuLH2rWZCP02+NVhHTW9lfNg83WN627J69wK+2KGKJANmDWZ9iK3bLCG
         iWJRa23Lfw7/FI+tFQDX6i49jqPvhTPPfYm539dzIPLz7IQ9sWk4STUcXbeAtotDW7dD
         2mm54nK42e/dXJl+hRSKtKmJIYUwN172UGwalCcimBcUmC3lGNmRQ3wyZ3l3MqjSSTcx
         nM34QWLbo579KzNBJekGre+J2LuV1YP28aStIpLw18ahL6kMHKvzytEjAFHnZF6bwIQ0
         gDE9dS/MVAwM/TYKGJpok9DvX+IcA3Mf/D+OzyADcEmw4d9p42s8Na4TyoAUaLOib1AR
         JsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150059; x=1694754859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAPQF3AIxfJJMuNhHMSqprX+We7Y3OynQxSaHAD1HDU=;
        b=tlLWllnHP9NFSU1IyZr8Cka3dmcHanMJQWrNg4ozYE11lelS1lZLa1HCxVml3kvZ2B
         iDu3a7FcTTGEoTL9HO1cBA3RdqVz+B4bSu3jkrHd+bkISzzW3JLRvB3PBA4DrxFj+Ika
         6rIbt+IRTYkyOb59tD5oyv4ItPcAXGEWOrkX2FIuSnAMJZIki2TEYzaFnjAepoIdFITE
         oksx674sm2momgrnbXblZ5pDAVvIHPlX8JS2Ct+/fvYclmVxBeE4e/ccD+6rxq1ZsN2J
         Bdr21JgoznjNh4E0RNI+GmnsGckKOZA4GzYODNBoOiqKxOzxrXlFwUTHjOlseznz1UhC
         Ga+w==
X-Gm-Message-State: AOJu0YzKZOulosfy7F52GbOJZ6eJbRiohOd2xl7nG5uYPAMfHxlyQpl7
        9lZ7gjtB8op9TSB1Z4qVZ8sgj5QxCcugh87qQ9o=
X-Google-Smtp-Source: AGHT+IHy7GkNs8U+4q0Hv5tz6kPg8Ph8HBLXgUXU2m+5HmcZxobqeSlNyK2YC1YdejSfPfIHRa0L6g==
X-Received: by 2002:a17:903:2789:b0:1b6:af1a:7dd3 with SMTP id jw9-20020a170903278900b001b6af1a7dd3mr1625686plb.23.1694150059689;
        Thu, 07 Sep 2023 22:14:19 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001a5fccab02dsm616482plt.177.2023.09.07.22.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:14:19 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 07 Sep 2023 22:14:07 -0700
Subject: [PATCH v3 4/5] riscv: Vector checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-optimize_checksum-v3-4-c502d34d9d73@rivosinc.com>
References: <20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com>
In-Reply-To: <20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
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
do work. This code requires the kernel to be compiled with C vector
support, but that is not yet possible. It is written in assembly
rather than using the GCC vector instrinsics because they did not
provide optimal code.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 1402da888bb4..58dd44f7c6f9 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -12,6 +12,10 @@
 
 #include <net/checksum.h>
 
+#ifdef CONFIG_RISCV_ISA_V
+#include <riscv_vector.h>
+#endif
+
 /* Default version is sufficient for 32 bit */
 #ifndef CONFIG_32BIT
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
@@ -114,6 +118,94 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	offset = (csum_t)buff & OFFSET_MASK;
 	kasan_check_read(buff, len);
 	ptr = (const csum_t *)(buff - offset);
+#ifdef CONFIG_RISCV_ISA_V
+	if (!has_vector())
+		goto no_vector;
+
+	len += offset;
+
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int shift, cl, tail_seg;
+	csum_t vl, csum;
+	const csum_t *ptr;
+
+#ifdef CONFIG_32BIT
+	csum_t high_result, low_result;
+#else
+	csum_t result;
+#endif
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
+	unsigned int start_mask = (unsigned int)(~(~0U << offset));
+
+	kernel_vector_begin();
+	asm(".option push						\n\
+	.option arch, +v						\n\
+	vsetvli	 %[vl], %[len], e8, m1, ta, ma				\n\
+	# clear out mask and vector registers since we switch up sizes	\n\
+	vmclr.m	 v0							\n\
+	vmclr.m	 %[prev_buffer]						\n\
+	vmclr.m  %[curr_buffer]						\n\
+	# Mask out the leading bits of a misaligned address		\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.s.x	 %[prev_buffer], %[csum]				\n\
+	vmv.s.x	 v0, %[start_mask]					\n\
+	vsetvli	 %[vl], %[len], e8, m1, ta, ma				\n\
+	vmnot.m	 v0, v0							\n\
+	vle8.v	 %[curr_buffer], (%[buff]), v0.t			\n\
+	j	 2f							\n\
+	# Iterate through the buff and sum all words			\n\
+	1:								\n\
+	vsetvli	 %[vl], %[len], e8, m1, ta, ma				\n\
+	vle8.v	 %[curr_buffer], (%[buff])				\n\
+	2:								\n\
+	vsetvli x0, x0, e32, m1, ta, ma					\n\
+	vwredsumu.vs	%[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\t"
+#ifdef CONFIG_32BIT
+	"sub	 %[len], %[len], %[vl]					\n\
+	slli	 %[vl], %[vl], 2					\n\
+	add	 %[buff], %[vl], %[buff]				\n\
+	bnez	 %[len], 1b						\n\
+	vsetvli	 x0, x0, e64, m1, ta, ma				\n\
+	vmv.x.s	 %[result], %[prev_buffer]				\n\
+	addi	 %[vl], x0, 32						\n\
+	vsrl.vx	 %[prev_buffer], %[prev_buffer], %[vl]			\n\
+	vmv.x.s	 %[high_result], %[prev_buffer]				\n\
+	.option  pop"
+	    : [vl] "=&r"(vl), [prev_buffer] "=&vd"(prev_buffer),
+	      [curr_buffer] "=&vd"(curr_buffer),
+	      [high_result] "=&r"(high_result), [low_result] "=&r"(low_result)
+	    : [buff] "r"(ptr), [len] "r"(len), [start_mask] "r"(start_mask),
+	      [csum] "r"(csum));
+
+	high_result += low_result;
+	high_result += high_result < low_result;
+#else // !CONFIG_32BIT
+	"subw	 %[len], %[len], %[vl]					\n\
+	slli	 %[vl], %[vl], 2					\n\
+	addw	 %[buff], %[vl], %[buff]				\n\
+	bnez	 %[len], 1b						\n\
+	vsetvli  x0, x0, e64, m1, ta, ma				\n\
+	vmv.x.s  %[result], %[prev_buffer]				\n\
+	.option pop"
+	    : [vl] "=&r"(vl), [prev_buffer] "=&vd"(prev_buffer),
+	      [curr_buffer] "=&vd"(curr_buffer), [result] "=&r"(result)
+	    : [buff] "r"(ptr), [len] "r"(len), [start_mask] "r"(start_mask),
+	      [csum] "r"(csum));
+#endif // !CONFIG_32BIT
+	kernel_vector_end();
+no_vector:
+#endif // CONFIG_RISCV_ISA_V
 	len = len + offset - sizeof(csum_t);
 
 	/*

-- 
2.42.0

