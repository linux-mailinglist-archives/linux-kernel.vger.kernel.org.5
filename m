Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAF81077E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378192AbjLMBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378150AbjLMBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:18:40 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A81193
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:46 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9d84019c5so4771665a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702430325; x=1703035125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa7K/oxZt25h94PBFoFutl7qSG1BTlKxow4+QMuXCwE=;
        b=MbLqDLhoBW65vE5EhXl8dGCIHqzjeuJG3IEftG5mA66iF/aIZP5xXJvqF+TO9jpliK
         mVfI+6amyXF8VM7SRECQPn3Xp7E5Rmt3i8iF8SUQ/SazlxnI5s+2N3WyZooIK6pOstZA
         h/klbIonHmeVGmhquwAx9O6fOPj/RDH/Y9eqqx8vsUAFmGEaaQ4HjjVjnyX38JrI4MbK
         apyoFxKr2hqqVkfjCw8+hhMPocjatvJos13qqddDlhHii/AmImT66vKnEIFnRmfj3110
         cdejgShBfCxbwXl63aH71hzb5gFpdXuBvY6m+WZOFcwAaanVyXcq/klMmyHsLRZJTfQC
         J/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430325; x=1703035125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa7K/oxZt25h94PBFoFutl7qSG1BTlKxow4+QMuXCwE=;
        b=CrQf9LmtOK5xAuJmerF0lhlLPDdUBX2EbpDw62+uuS5IMD51uMyPbLvkCOcoel+PFC
         D6p2SMOxbvIL1lHfI44uBW5l6U9/e0OPROIXjTpiBP3QkSnhpQqSHfHmUVT/pQOwbDLf
         F6r6ezqI0vCt6tM1nL2e2VTNyaYMk6SQTz3dUo8ReWMxJo5reE7WvnBDCbt4Fcd9WzYM
         FwglbbPuKGabIlmLo9oR7mGeMmWRRhIMWDGl/iJbcNbEtv9CZWff5DI3wM7dQsCSii96
         Kx8NlXt8CbrL90QptIGvpfm8Gw0wGaOg7+L8lW9zIeFvWl5UnVec9s/rVb56w+YuVW2Y
         P0yw==
X-Gm-Message-State: AOJu0Ywwybl3nLrVnew5TmDaEykxeLOet6KMQ4f9rMeR34BSjA4i7Ilj
        OtUaOGufhW0TkJnW99XAa7wOCw==
X-Google-Smtp-Source: AGHT+IGUifEiBrI94UV6VOlOXiYP5d8umLFsp21qF3BeVhm5H9xbMNi+1ScQ8UHQjpGy45tus138oQ==
X-Received: by 2002:a9d:6c56:0:b0:6d9:e15c:79bc with SMTP id g22-20020a9d6c56000000b006d9e15c79bcmr7215551otq.68.1702430325687;
        Tue, 12 Dec 2023 17:18:45 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056830699a00b006d9a339773csm172548otb.27.2023.12.12.17.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:18:45 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 12 Dec 2023 17:18:40 -0800
Subject: [PATCH v12 3/5] riscv: Add checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-optimize_checksum-v12-3-419a4ba6d666@rivosinc.com>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
In-Reply-To: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702430319; l=3074;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=adYqZ1MwkI2tixiO6Vqw0pA42pYvaEcycoXrFZjPpmw=;
 b=4z6EVBErljGKcQ6ywUy9p67X640GJzGAFaxbGt7gS99Jj7/mlk/GsHCbAxkR6srBT0KNEL31G
 eknW7cffrFTCzO5tfzpRKWsA02wygpgNME7+EVpuGtD9DRR31izxRFl
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/checksum.h | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..2fcf864186e7
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Checksum routines
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
+/* Define riscv versions of functions before importing asm-generic/checksum.h */
+#include <asm-generic/checksum.h>
+
+/**
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ *
+ * @ihl: the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph: assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
+ *  riscv, defining IP headers to be aligned.
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
+	csum += ror64(csum, 32);
+	csum >>= 32;
+#endif
+	return csum_fold((__force __wsum)csum);
+}
+
+#endif /* __ASM_RISCV_CHECKSUM_H */

-- 
2.43.0

