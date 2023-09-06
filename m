Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E82793478
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjIFErS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbjIFErQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:47:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3728CE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 21:47:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a529e1974so2148944b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 21:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693975632; x=1694580432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFV9eKDRL/UI9X8ku3j8I3nR0nMSzd2mz74uOzTK7yw=;
        b=LhokdP04s6Ee4gHKKO2If38B2FH+H1b2fvE8Bz+AkNOL6ZCuXBAm4fBSZwb+v/MYR7
         8H/Vm3xrFie4K5UwJSUaPztpQg5PjeLa55nkpgwN5WGTk+OKHWEptKOXyzlK1fYdPNS7
         NEMNxc7OiIKwTfe6W4CBGEr/73920x18up3zTA2Krgv47Q1IeK/1vHUqhTo77nP7aQLo
         cpJTJtCIHlafpPH7vNWObDyVhre01HCS3ZxPb+r5TFt++BwFjzPBTMzpbhdTkQar5pa3
         AK0VK/r7I13AD0axXsQphbl0Djd1DwI5vs13pfpAMu0+Df7ILWFV1BJIIjxm4CzcWHMI
         ZlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693975632; x=1694580432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFV9eKDRL/UI9X8ku3j8I3nR0nMSzd2mz74uOzTK7yw=;
        b=eEemKsNLTMb1HoWBHE6o1LhUo/bK7tTBZKyjTsUw0UyIsPHeze6dHCC3VrhtWUX7Uo
         3uWrQx9H/8YrL+4D3D+ucZ4uI79v3L8TDKdOl433VARGGs1kBp+AHuENlBUnZ/N2jdOF
         hdfqOD6XiayC1ETevS1HHKqCqBguusnfYTsHthf5Hh4AkxYUpPKzWUJp8IBaHs6VCTvY
         YG0neYsi9YrXtrTKmDjnVRcTMnk8Zr7QwzkbJQDPoiiR7ysPOB9EjsJIZ9YqCeRnJ8k2
         gLL1qQMLCM2awPxKTCdt/DL9zIx48xE3M3UAuv7pnnZES8PY59+/xV1NvNawZx1U7ZXh
         RYLg==
X-Gm-Message-State: AOJu0YzsGrEzCQfgB7PM5yItK7kA2V/5QDyhEpahkyDSgIamMTvSa42w
        pql74Jj68yVxhFp5PHdCRVPLn63ZAXNDWx9uWXI=
X-Google-Smtp-Source: AGHT+IGS9NkG+PXPovJpK4ZJ8/CvYTRAdbGX2XNpOJgee0lGFdDcWjhDajvCdKdYrutdpTp/c4tHpQ==
X-Received: by 2002:a05:6a20:158e:b0:13e:9dba:ea52 with SMTP id h14-20020a056a20158e00b0013e9dbaea52mr15423327pzj.13.1693975632238;
        Tue, 05 Sep 2023 21:47:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001bc56c1a384sm10087313plt.277.2023.09.05.21.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 21:47:11 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 05 Sep 2023 21:46:50 -0700
Subject: [PATCH v2 1/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-optimize_checksum-v2-1-ccd658db743b@rivosinc.com>
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

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 96 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..573714b9ea15
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,96 @@
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
+#ifdef CONFIG_32BIT
+		csum += csum < ((const unsigned int *)iph)[pos];
+#endif // !CONFIG_32BIT
+	} while (++pos < ihl);
+
+#ifdef CONFIG_RISCV_ISA_ZBB
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		csum_t fold_temp;
+
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+		    :
+		    :
+		    :
+		    : no_zbb);
+#ifdef CONFIG_32BIT
+		asm(".option push				\n\
+		.option arch,+zbb				\n\
+			rori %[fold_temp],%[csum],16		\n\
+			add %[csum],%[fold_temp],%[csum]	\n\
+		.option pop"
+		: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+#else // !CONFIG_32BIT
+		asm(".option push				\n\
+		.option arch,+zbb				\n\
+		    rori %[fold_temp], %[csum], 32		\n\
+		    add %[csum], %[fold_temp], %[csum]		\n\
+		    srli %[csum], %[csum], 32			\n\
+		    roriw %[fold_temp], %[csum], 16		\n\
+		    addw %[csum], %[fold_temp], %[csum]		\n\
+		.option pop"
+		: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+#endif // !CONFIG_32BIT
+		return ~(csum >> 16);
+	}
+	/*
+	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
+	 * worth checking if supported without Alternatives.
+	 */
+no_zbb:
+#endif // CONFIG_RISCV_ISA_ZBB
+#ifdef CONFIG_32BIT
+#else // !CONFIG_32BIT
+	csum += (csum >> 32) | (csum << 32);
+	csum >>= 16;
+#endif // !CONFIG_32BIT
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

