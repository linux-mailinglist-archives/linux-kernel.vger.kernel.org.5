Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B961798178
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbjIHFOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjIHFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:14:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3119AB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:14:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf6ea270b2so12616385ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 22:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694150055; x=1694754855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe+25j0FlfcBEBJLM6tn940z0gL7txI9g8Ukkd+3JzY=;
        b=avpKMveflLP6+/v+RwZqphDqwTSfG78ud94IVUX1ZGGfFtgc1iaqnzjOn41jFh1ccy
         IfkDTb4oYFZAeLVk24PixmVC1cNlPqXOtBPcMn2NP0YuFCCCpVh14NkC8Xg7LWIJagVX
         CaAkmtXXysQebIaqEXeVdVFVVklCuGC4aPtylvmJKRKwiC09NfW7DKWoSTWYIMv/sdcd
         ZSNpsoXI3deAeBuJ2YoVjG1CQXhKn51lDOVwYiwJ6sC4gE/nLS7gjaW3DQZo+qTkjcwK
         RDEcUVHHDus5H8pX8rfpN881pZ7b3zv00Rx90mXcpZUeJtIuSzNLoL1R9SXnkM6qjHPY
         PjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150055; x=1694754855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe+25j0FlfcBEBJLM6tn940z0gL7txI9g8Ukkd+3JzY=;
        b=GjDJSy33GrDVhI7xMm0CNlNcKCNBIWwmpooLmLL2x3RJBs9KiaRGHB76AwJRfhRY+w
         7Rs5KxhHy988QXNqYh9mYOTurloEi47avKSBdKLwAV5YHQQL5RsbzKWqQ8Z8heXXv59X
         L8j19GvVB2GSGIzJ8FSAESZt6L9e/x3t9bfxF7qxQMqJc7d2blUKOgz00Y8gnrT3N5Ag
         TmYm0JEKTiLXkJ8EOdoui2hcfGFw7skt8xim2ZG2MNtR+YTd4mvqNz5nmrcfQ2anSIeZ
         wZlJAQD1lFjYKbBkugrP5aFTqe7AWrepXlMTWQeQ6bf5zQqYtLUT75IppEwAgXYBcAE6
         D82w==
X-Gm-Message-State: AOJu0Yy/9SqiponusGXcpIY9+PqGucRgzurQOtjvKBp0s7u+tOSGpOfj
        ayacHuQjNKEQ6GHgsAXdzuhTBA==
X-Google-Smtp-Source: AGHT+IFWbgY1Hxyt2+Y2+Zlz+3d2qFtQqnOR1On5xLS0tR1B5QSJEZ1a87MvoIQu6JS8NbWMhhA1DQ==
X-Received: by 2002:a17:903:124c:b0:1bf:66c3:d4d4 with SMTP id u12-20020a170903124c00b001bf66c3d4d4mr1894945plh.16.1694150055603;
        Thu, 07 Sep 2023 22:14:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001a5fccab02dsm616482plt.177.2023.09.07.22.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:14:15 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 07 Sep 2023 22:14:04 -0700
Subject: [PATCH v3 1/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-optimize_checksum-v3-1-c502d34d9d73@rivosinc.com>
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

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..bddfc571f93f
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * IP checksum routines
+ *
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#ifndef __ASM_RISCV_CHECKSUM_H
+#define __ASM_RISCV_CHECKSUM_H
+
+#include <linux/in6.h>
+#include <linux/uaccess.h>
+
+#ifdef CONFIG_32BIT
+typedef unsigned int csum_t;
+#else
+typedef unsigned long csum_t;
+#endif
+
+/*
+ *	Fold a partial checksum without adding pseudo headers
+ */
+static inline __sum16 csum_fold(__wsum sum)
+{
+	sum += (sum >> 16) | (sum << 16);
+	return (__force __sum16)(~(sum >> 16));
+}
+
+#define csum_fold csum_fold
+
+/*
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph is assumed to be word aligned.
+ */
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	csum_t csum = 0;
+	int pos = 0;
+
+	do {
+		csum += ((const unsigned int *)iph)[pos];
+		if (IS_ENABLED(CONFIG_32BIT))
+			csum += csum < ((const unsigned int *)iph)[pos];
+	} while (++pos < ihl);
+
+	/*
+	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
+	 * worth checking if supported without Alternatives.
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		csum_t fold_temp;
+
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+		    :
+		    :
+		    :
+		    : no_zbb);
+
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp],%[csum],16		\n\
+				add	%[csum],%[fold_temp],%[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		} else {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 32	\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				srli	%[csum], %[csum], 32		\n\
+				roriw	%[fold_temp], %[csum], 16	\n\
+				addw	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		}
+		return ~(csum >> 16);
+	}
+no_zbb:
+#ifndef CONFIG_32BIT
+		csum += (csum >> 32) | (csum << 32);
+		csum >>= 32;
+#endif
+	return csum_fold((__force __wsum)csum);
+}
+
+#define ip_fast_csum ip_fast_csum
+
+#include <asm-generic/checksum.h>
+
+#endif // __ASM_RISCV_CHECKSUM_H

-- 
2.42.0

