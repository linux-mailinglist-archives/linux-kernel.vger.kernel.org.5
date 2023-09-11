Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E848C79C124
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjILAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjILAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:32:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE47BFFDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:59:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5778fe9d183so646062a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694473068; x=1695077868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeGuOibt2OS/It6GbdxOqwbldEV/5WEBCr8BGa7QoJw=;
        b=TwujOsV1zOiWnnhFMhDP+gcb1XtT52MglKovdkpxBYI7vx9VIlm2/RiF6+qAbHmOKb
         mLQu5AE4MQN4eezKsEwTRnlK2H5Q4DL8Lbz+y4S2GLnAwybvsoNuqVc6KACvqQ1gHxCX
         emDGfysg2zicNAXWL8ZM6Qp8UD/aNAx7RjEgFwTcSdoUWyy+UYCtSZwNdFLHw0oBdadc
         2oVi/lvSPu8rM7GC0NyGDEPFf2g4dEkcy10gWCGZxDuFsASIsNDtcXBESItKg45MoMZV
         ohLmHsYbcfilZvu9kK1KFU4GQQlc6KnkcWhBBMNfYvJnEQd7KXmzosZKXVmy2isiRnyt
         hPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473068; x=1695077868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeGuOibt2OS/It6GbdxOqwbldEV/5WEBCr8BGa7QoJw=;
        b=OGIW38QrhfOoIZcqFM3qdeAwkYANRzCjWD6arLV1E0HYeTQGyJGG7jmcoDhyFmNcSg
         mgIxrOc3Vo69EsPeBJt8uGnqskCeQBzkFxyzt/tOtAwd5IAxRWdqulmnfnO0T/VbmHVf
         SFfVbk4DPXJayGhdIHntPigcR5FViB5FpcVCT+Sm0c+994SrbcbzcyTY2SYEWBQw6vSw
         nkyXu4WL9g+dbupboJo/Yvw/iJjuYYVVOA1iWYhvGhPtxn3eUdq2Kw3fuQM+rysOQxsq
         VA+qyR3cWw13XWUSvJcZzYdWruz3qCuCPO2MsNhWkL4gxQ4Oo1J512q2DCRFeBABa2uX
         5/Dg==
X-Gm-Message-State: AOJu0Ywq/xK2kagXGY+4iMo08VtKsxnq6jyfbJp4toPrOaBmgd1sTYa7
        MW9zB2YBWHFfWagzkVMVm5dhDE2KyrH8HAZDm+s=
X-Google-Smtp-Source: AGHT+IGDbksywbMagPGWzl+7dENygL3I/FG+niWbl9mvxgcV6ss9ETkcm+Z7EzsigG2LQOmTdh97eg==
X-Received: by 2002:a05:6a20:3d24:b0:14b:d28e:e947 with SMTP id y36-20020a056a203d2400b0014bd28ee947mr10640767pzi.48.1694473067801;
        Mon, 11 Sep 2023 15:57:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b0066a2e8431a0sm6021038pfm.183.2023.09.11.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:57:47 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 11 Sep 2023 15:57:13 -0700
Subject: [PATCH v4 3/5] riscv: Vector checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-optimize_checksum-v4-3-77cc2ad9e9d7@rivosinc.com>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
In-Reply-To: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
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
index a09a4053fb87..a99c1f61e795 100644
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
@@ -42,6 +46,77 @@ static inline __sum16 csum_fold(__wsum sum)
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

