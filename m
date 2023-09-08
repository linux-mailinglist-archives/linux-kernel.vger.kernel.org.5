Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BA798175
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjIHFO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbjIHFOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:14:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F019AB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:14:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c364fb8a4cso15302005ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 22:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694150058; x=1694754858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tb8pM+MPCYZ04bq/QFSvT9K0qDHTT+G01Hk2Be9XTNw=;
        b=TEyC4Nl8OVuV9hb1GmuyZr6VahQcmkNulwNrRdGNJ0GWa9P8IW6AEncYi3hrw5AdS4
         WUKRe9magM6+M7fzGOQmyz/jg2/93YKWMqLxIc8/QXd1DeFXDssaXG586FFHka3+y1Ml
         Vor8WB6kl6F53Qh7B1z1odzE61cMaQemXriPaGCOP1pio/Zs4ymUVUoRhIQ8prDkT3S1
         8i5+CFFBBbPILDkMamnOh9TlaPNypcYsCOOrbmEgfZKNIhvk0Z/nR+NWtWovb1SZ8oe2
         2+i43vrg+DoHX2vuzAhszsSS/Legj/axDHs6vQiCX8zpurMJvsmGAjjDlDcunITCqQ/x
         +nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150058; x=1694754858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb8pM+MPCYZ04bq/QFSvT9K0qDHTT+G01Hk2Be9XTNw=;
        b=qof9Ie2RXkeIj3NfsIVtakpxrU0c+uA/84K8PhUC58oIXo2NOeC8+FberE+rul3eLv
         ruGVBEXOGRRwcAvcX+Q8o1LBfdbJDyEtm1cgLo9DZ3jrpSHpGoAwbHfx+ClU4hs+Gkk6
         XaXGXCY23NZ5yqri3TlWWOr8NIG7USg0BN6FmB3TtSDSsg4j2bqb2HpQNgZXmaVmWz6E
         /yYFgVgmC0PNdWPCfddBgyVwwXa2MUP5mAsuPyQihlOIH+pNkDPWLeYOTniziODJ3fXi
         g+LapmJp5tmR1ZBlX/JbLkahZhdCYMy3YC9AW0243EPVTR/I4AqzEfkLjRj1J6D2YPVm
         NQqw==
X-Gm-Message-State: AOJu0YyVUo/swPuloRrF0tlVRFRTpncrvKc/5uUBsHv7WQGLBKftlVGP
        N7M6R/9VPVdKfsERGBZG8zIoaA==
X-Google-Smtp-Source: AGHT+IFBqUUWXwXlL8D68eWvUTcpwF+xAzJRUMAJ/rVJU/Bq3kgu1zeZuihVaei+WLU5e8PNJRGlNw==
X-Received: by 2002:a17:903:188:b0:1c3:188c:a347 with SMTP id z8-20020a170903018800b001c3188ca347mr1763284plg.54.1694150058335;
        Thu, 07 Sep 2023 22:14:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001a5fccab02dsm616482plt.177.2023.09.07.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:14:17 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 07 Sep 2023 22:14:06 -0700
Subject: [PATCH v3 3/5] riscv: Vector checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-optimize_checksum-v3-3-c502d34d9d73@rivosinc.com>
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

Vector code is written in assembly rather than using the GCC vector
instrinsics because they did not provide optimal code. Vector
instrinsic types are still used so the inline assembly can
appropriately select vector registers. However, this code cannot be
merged yet because it is currently not possible to use vector
instrinsics in the kernel because vector support needs to be directly
enabled by assembly.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 75 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index ced276dcd6be..f7b328553a07 100644
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
@@ -43,6 +47,77 @@ static inline __sum16 csum_fold(__wsum sum)
  */
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
+#ifdef CONFIG_RISCV_ISA_V
+	if (!has_vector())
+		goto no_vector;
+
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int vl;
+
+	if (IS_ENABLED(CONFIG_32BIT)) {
+		csum_t high_result, low_result;
+
+		kernel_vector_begin();
+		asm(".option push						\n\
+		.option arch, +v						\n\
+		vsetivli	x0, 1, e64, ta, ma				\n\
+		vmv.v.i		%[prev_buffer], 0				\n\
+		1:								\n\
+		vsetvli		%[vl], %[ihl], e32, m1, ta, ma			\n\
+		vle32.v		%[curr_buffer], (%[iph])			\n\
+		vwredsumu.vs	%[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
+		sub %[ihl],	%[ihl], %[vl]					\n\
+		slli %[vl],	%[vl], 2					\n\
+		add %[iph],	%[vl], %[iph]					\n\
+		# If not all of iph could fit into vector reg, do another sum	\n\
+		bne		%[ihl], zero, 1b				\n\
+		vsetivli	x0, 1, e64, m1, ta, ma				\n\
+		vmv.x.s		%[low_result], %[prev_buffer]			\n\
+		addi		%[vl], x0, 32					\n\
+		vsrl.vx		%[prev_buffer], %[prev_buffer], %[vl]		\n\
+		vmv.x.s		%[high_result], %[prev_buffer]			\n\
+		.option pop"
+		: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+			[curr_buffer] "=&vd" (curr_buffer),
+			[high_result] "=&r" (high_result),
+			[low_result] "=&r" (low_result)
+		: [iph] "r" (iph), [ihl] "r" (ihl));
+		kernel_vector_end();
+
+		high_result += low_result;
+		high_result += high_result < low_result;
+	} else {
+		csum_t result;
+
+		kernel_vector_begin();
+		asm(".option push						\n\
+		.option arch, +v						\n\
+		vsetivli	x0, 1, e64, ta, ma				\n\
+		vmv.v.i		%[prev_buffer], 0				\n\
+		1:								\n\
+		# Setup 32-bit sum of iph					\n\
+		vsetvli		%[vl], %[ihl], e32, m1, ta, ma			\n\
+		vle32.v		%[curr_buffer], (%[iph])			\n\
+		# Sum each 32-bit segment of iph that can fit into a vector reg	\n\
+		vwredsumu.vs	%[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
+		subw %[ihl],	%[ihl], %[vl]					\n\
+		slli %[vl],	%[vl], 2					\n\
+		addw %[iph],	%[vl], %[iph]					\n\
+		# If not all of iph could fit into vector reg, do another sum	\n\
+		bne		%[ihl], zero, 1b				\n\
+		vsetvli	x0, x0, e64, m1, ta, ma					\n\
+		vmv.x.s	%[result], %[prev_buffer]				\n\
+		.option pop"
+		: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+			[curr_buffer] "=&vd" (curr_buffer),
+			[result] "=&r" (result)
+		: [iph] "r" (iph), [ihl] "r" (ihl));
+		kernel_vector_end();
+	}
+no_vector:
+#endif // !CONFIG_RISCV_ISA_V
+
 	csum_t csum = 0;
 	int pos = 0;
 

-- 
2.42.0

