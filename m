Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21B879C283
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjILCPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjILCPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:15:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD573EBB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:59:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fba57030fso1500659b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694473065; x=1695077865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWK2rC7AH/5QC0BAtsZIFXgYiFb16S6BYTYadGvqcj4=;
        b=KXaQ50m21o6aX4mWUGjb2EQDvBsgnZuprk2DkRCtURP+U7B22dYitH93lWMq/BdqcZ
         Szy0cwUxmS1jLZFUeJ+t7+WlVrQqOdSAqusFNE243cl9nDTLz4EXGKgZdUvq53/kFMR5
         7/sLZ/GtLcJfkHuokEc6t+Jq9Uw6bB8+Ttu/qN7kjrgXUfOVFPPHRPSftgEnOpZG0Lst
         dk+1ojlAna2enCNEpcTpjncuGmXMc9wztmVqSmdvqWoVAUXds79EIbtFBwJbf88OU36N
         S5gvlPaYnTmU6XOn2EVdhv5/qYictO4vmmnCF6xephofhIwZVqozFjmhs6+UdcH9EmcH
         eKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473065; x=1695077865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWK2rC7AH/5QC0BAtsZIFXgYiFb16S6BYTYadGvqcj4=;
        b=Rm5n5Uxy9llM9bITAQlt+tYUbzbM0u9Y5O/CZLTNzr8M9yJyRThoUWsYtDSgAUsh9F
         JBAFsPq5Dktggpe8hxGaLa42u6d0BEqG/u2GiFzBsqKQWzbfFKR93VwDI3LIabNHb8TL
         o5nmW6bhdRMbVfzaCg551c4K0SdAKWIfSzJXpz8033nFsPIT0xo4sWWaw4o7+wBWTkeZ
         zDSX1Xm/gy8E+JjViLGx/GBL0Qlov9+kZMfWbe1OPQHsr+mYi9hGXX/MvSdPklR5/K/C
         k5m3Q2n71Hvf9fImD2dCbi8hOkPtBCqGkAUsGikgNbBxXYdaJTVXD3G5z/aocxOmiFcV
         y8xA==
X-Gm-Message-State: AOJu0YyCPytyDomuDL6RgKbpu+EOKXtqmDkAJFCJFDZjtthmDMrftjEO
        8VH98Nx+24Iqhj9z4AIp2urTcabRzTJZHIL5MNY=
X-Google-Smtp-Source: AGHT+IFnYLoSY71pjx795OD72WJm3LoOlQc659rJWf9PZ/mVw1d/FuaAEl4qKAGzcfIok62Oq6t2dQ==
X-Received: by 2002:a05:6a00:194c:b0:682:4ef7:9b17 with SMTP id s12-20020a056a00194c00b006824ef79b17mr9868013pfk.32.1694473065340;
        Mon, 11 Sep 2023 15:57:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b0066a2e8431a0sm6021038pfm.183.2023.09.11.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:57:44 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 11 Sep 2023 15:57:11 -0700
Subject: [PATCH v4 1/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-optimize_checksum-v4-1-77cc2ad9e9d7@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/riscv/include/asm/checksum.h | 95 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..0d7fc8275a5e
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,95 @@
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
+	return (~sum - ror32(sum, 16)) >> 16;
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
+				not	%[fold_temp], %[csum]		\n\
+				rori	%[csum], %[csum], 16		\n\
+				sub	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		} else {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 32	\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				srli	%[csum], %[csum], 32		\n\
+				not	%[fold_temp], %[csum]		\n\
+				roriw	%[csum], %[csum], 16		\n\
+				subw	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		}
+		return csum >> 16;
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

