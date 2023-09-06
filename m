Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17A79347A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbjIFErY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjIFErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:47:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357CACEA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 21:47:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf57366ccdso3808485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693975634; x=1694580434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKepWMR7L/st0e7dK85RxCwPDS5lGnT9CeWsgI7Pxpk=;
        b=WKrSWh3ujkTAOZcoFaDy8X11uVa5uXsEMLy1yJsuDB0uQ95kGZgVyCrQJMBy+e1XQI
         unYwH/bSdNvQ1K9JNIKyR+iqccYzZN9qbcjnpanZTKHoOILGktouNbCLFfcWOVbzrbWA
         XmYRHvE1wOWe/BDrmRju0uVmoHa12zjA0ohHmdnHuT5663GmNQRl5z/wuZtjMRTmnpOZ
         rg0Lx5y8z3Mk6bqRwvywTVP8ijgy3XiphmsbpW+Mlttdk6gKulfvqwMkBZGemlI3DX+q
         VmOA/JIP1TXv2km4Fn7/FJbUPI3STbTuEmEP+sRgHqhti/cw8ooeDHlOYWxUoE1COtzR
         1qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693975634; x=1694580434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKepWMR7L/st0e7dK85RxCwPDS5lGnT9CeWsgI7Pxpk=;
        b=kPugUHIDiCcZddE3ebM2VW3Il/mynYz/pUfViQNrWy05Lt+BYPmOx0qnwX7u6jvfY8
         HF0sk85rZ/GRK1ys4skzQD95aWqwgNt7eryaQaV6Ycn451ysBy5ACnCk67sEcOgKrQOa
         9wRUi0PKgJAJo1t4fOMCUE/KQs1dsn5vpngwJCZU1AiMS2IMfQDOEFuRYHRSSIw91Vpn
         49NMhNprwasXynPbGOuMkw74b0uLwH+gyvbFh/cZsDS3Qh9EgPKQ4gKSskst0B6DHKnd
         1hFcvcwjiNIzd7HkG/TtC34cfFBMGv4+Uybx/GfZ5Q4TxlQvleuQ5+uNQ9ULLgSZpweB
         MMIw==
X-Gm-Message-State: AOJu0Yz9anYI83bfNWNf1FpD3wNOWV7Z/8Lggv7XC+uMLvxgC5srjX8t
        zzuvuTLBAQkt2r6tG1cIA/ni0A==
X-Google-Smtp-Source: AGHT+IEnVGL6EVCHtqmJQZd9MBj+H77yMjPJYr2OukkM1ehZQOTYrTZwBtUMkgrC914b6Pa5BB/iPg==
X-Received: by 2002:a17:902:d510:b0:1c3:22a9:8643 with SMTP id b16-20020a170902d51000b001c322a98643mr15387341plg.31.1693975634686;
        Tue, 05 Sep 2023 21:47:14 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001bc56c1a384sm10087313plt.277.2023.09.05.21.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 21:47:14 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 05 Sep 2023 21:46:52 -0700
Subject: [PATCH v2 3/5] riscv: Vector checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-optimize_checksum-v2-3-ccd658db743b@rivosinc.com>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
In-Reply-To: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
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

Vector code is written in assembly rather than using the GCC vector
instrinsics because they did not provide optimal code. Vector
instrinsic types are still used so the inline assembly can
appropriately select vector registers. However, this code cannot be
merged yet because it is currently not possible to use vector
instrinsics in the kernel because vector support needs to be directly
enabled by assembly.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 87 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 3f9d5a202e95..1d6c23cd1221 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -10,6 +10,10 @@
 #include <linux/in6.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_RISCV_ISA_V
+#include <riscv_vector.h>
+#endif
+
 #ifdef CONFIG_32BIT
 typedef unsigned int csum_t;
 #else
@@ -43,6 +47,89 @@ static inline __sum16 csum_fold(__wsum sum)
  */
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
+#ifdef CONFIG_RISCV_ISA_V
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		/*
+		 * Vector is likely available when the kernel is compiled with
+		 * vector support, so nop when vector is available and jump when
+		 * vector is not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_vector]", "nop", 0,
+					      RISCV_ISA_EXT_v, 1)
+				  :
+				  :
+				  :
+				  : no_vector);
+	} else {
+		if (!__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_v))
+			goto no_vector;
+	}
+
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int vl;
+#ifdef CONFIG_32_BIT
+	csum_t high_result, low_result;
+
+	riscv_v_enable();
+	asm(".option push						\n\
+	.option arch, +v						\n\
+	vsetivli x0, 1, e64, ta, ma					\n\
+	vmv.v.i %[prev_buffer], 0					\n\
+	1:								\n\
+	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
+	vle32.v %[curr_buffer], (%[iph])				\n\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
+	sub %[ihl], %[ihl], %[vl]					\n\
+	slli %[vl], %[vl], 2						\n\
+	add %[iph], %[vl], %[iph]					\n\
+	# If not all of iph could fit into vector reg, do another sum	\n\
+	bne %[ihl], zero, 1b						\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.x.s %[low_result], %[prev_buffer]				\n\
+	addi %[vl], x0, 32						\n\
+	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
+	vmv.x.s %[high_result], %[prev_buffer]				\n\
+	.option pop"
+	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+		[curr_buffer] "=&vd" (curr_buffer),
+		[high_result] "=&r" (high_result),
+		[low_result] "=&r" (low_result)
+	: [iph] "r" (iph), [ihl] "r" (ihl));
+	riscv_v_disable();
+
+	high_result += low_result;
+	high_result += high_result < low_result;
+#else // !CONFIG_32_BIT
+	csum_t result;
+
+	riscv_v_enable();
+	asm(".option push						\n\
+	.option arch, +v						\n\
+	vsetivli x0, 1, e64, ta, ma					\n\
+	vmv.v.i %[prev_buffer], 0					\n\
+	1:								\n\
+	# Setup 32-bit sum of iph					\n\
+	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
+	vle32.v %[curr_buffer], (%[iph])				\n\
+	# Sum each 32-bit segment of iph that can fit into a vector reg	\n\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]     \n\
+	subw %[ihl], %[ihl], %[vl]					\n\
+	slli %[vl], %[vl], 2						\n\
+	addw %[iph], %[vl], %[iph]					\n\
+	# If not all of iph could fit into vector reg, do another sum	\n\
+	bne %[ihl], zero, 1b						\n\
+	vsetvli x0, x0, e64, m1, ta, ma					\n\
+	vmv.x.s %[result], %[prev_buffer]				\n\
+	.option pop"
+	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+		[curr_buffer] "=&vd" (curr_buffer), [result] "=&r" (result)
+	: [iph] "r" (iph), [ihl] "r" (ihl));
+	riscv_v_disable();
+#endif // !CONFIG_32_BIT
+no_vector:
+#endif // !CONFIG_RISCV_ISA_V
+
 	csum_t csum = 0;
 	int pos = 0;
 

-- 
2.42.0

