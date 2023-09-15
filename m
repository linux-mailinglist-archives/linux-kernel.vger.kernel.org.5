Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687367A1493
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjIODtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIODts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:49:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48B196
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fba57030fso1611265b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694749784; x=1695354584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loF04Ge9lKLb+XrqXIoFKE9WVQmjWi5jnw1M425dhYA=;
        b=KgYPGLwEJzwwUmsbuY6i3ycZWSwxwzzpcO7Od/pqoXUp6/R/9CsjjYSB24w+aEMEPR
         PeXJsV5RXZimI466+bTHJgWD+kbt+xnYexl6qrOvGj+ogLvMoZ7guCKghvwxlY4F4J/S
         D+hp4kapjUy99+UypRG/kfD7cUGZ+Wiv9JDdq5HNoDN79FUUZLis1E3E55qCG7R8YvDs
         NZVrWv+jULKdpUn41aGFEknbQWsqwvpuJ6tLDzMilJqgtD266bMeApeM4g6qE7v1s7uM
         xlfvWFLG96eobw8OYT8Ruyvgs7IWLTmavChSMHDKCwQ2cHC+euBl6r+NuF7QaiW0E03O
         rxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749784; x=1695354584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loF04Ge9lKLb+XrqXIoFKE9WVQmjWi5jnw1M425dhYA=;
        b=SZPbQH5pgKX3CBin2X7vS9VgL511OABHL4WykgD2bAU20acgwpbqTr+WjmjVjq4Pff
         cjpO1NkKw9ufgshzUjGZOi9Zeu9XvMTViUBRsjRA7Sp15BzSZ+1GSy9aLGIlATzwdUCq
         cM1UtPKIRx0js4fuEwShSX5g13vjmmcL3KRvfAfhCMtu/heeNVhOutG+DthCstUtOmWb
         tVWppYZ9YxkSpXTff2VoIpmTBU9Ahasf3Fa3z+SfJQ8euZLGpoNVM/dakteVwkR5wEM9
         j3mB6LN2mZ6oaoUwdPdKscJYYIAPcfRR/O+nz3tq8r6Y6BBFW0hHthO2et2dbfKyPCrs
         A9cg==
X-Gm-Message-State: AOJu0YxkNyr0vMtN/w1M2Fx7rEQKREYEH5zR7Km8v8qJ7YYVjxn3S8DY
        yGKjEOmcWFV1ghPO+NlWDFPv7eat/v2RSy9kQ0U=
X-Google-Smtp-Source: AGHT+IFbAxds1ogYAZNnrFhtnRIySDzg/EjsBxuqHF6okLHp2Hbgj4q11UlBPAqmzFrKZN6TGlO9nQ==
X-Received: by 2002:a05:6a20:244e:b0:137:e595:830f with SMTP id t14-20020a056a20244e00b00137e595830fmr740531pzc.57.1694749783712;
        Thu, 14 Sep 2023 20:49:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b002739282db53sm3881409pjx.32.2023.09.14.20.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:49:43 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 14 Sep 2023 20:49:38 -0700
Subject: [PATCH v5 2/4] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-optimize_checksum-v5-2-c95b82a2757e@rivosinc.com>
References: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
In-Reply-To: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 79 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..2f0f224682bd
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,79 @@
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
+#define ip_fast_csum ip_fast_csum
+
+#include <asm-generic/checksum.h>
+
+/*
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph is assumed to be word aligned.
+ */
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	unsigned long csum = 0;
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
+		unsigned long fold_temp;
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
+#endif // __ASM_RISCV_CHECKSUM_H

-- 
2.42.0

