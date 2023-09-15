Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09187A1495
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjIODuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjIODtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:49:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34A196
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5657add1073so1271962a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694749785; x=1695354585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyaSMvzVf/GL9jUMPj8Pe5Mgy8bVy6kL5NApChG9qVE=;
        b=1ZC0/CG4l6EAa4xaxELV0LTLj+qEtnoMewuE5R8+xeWu/dUHq5wQA7v+hkQXMi9+2H
         MrZCv3oa57aQKlwgUsQk3+nOBz5smjQ5sco+BgbjEJl+oaAbmYdacgJO0w4xEuWi10MU
         ckMAcuLNfC5JupgQxTh16S4nncfRR+LdwaVhMIltGTNgU3OGRPc+kJN7YWiM0F/OncEJ
         86PQ8Bw0SIkBUVZ9AD7ZojaKlRpzGPwuzCydvfnMPhX35EFUQz445hOi7hLlJd6LwPjm
         m3JFIkW3eoa2y8qZAHusuhvBqIjy4vv+K94Nn4oD9jXe0EqTtI56grDWpXgUJqwSIyXI
         EaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749785; x=1695354585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyaSMvzVf/GL9jUMPj8Pe5Mgy8bVy6kL5NApChG9qVE=;
        b=HI2dbOUW8O+JYn+H4qpu9V9aLoMWenruO4U1TqTNdWMlMGFK63JX4TrU8VPJH3q5Pf
         x26HQJtAnj7fFJwrW+u/DrISlajKqNxcjrNTWHPeuC4TeynqcRe88m+Z3Re42KabpDt7
         c2+uBy4mLxUgY86TJHNtuvUmUEdKvYD0/SM0zPNjg1Clua8ezbbZwScy0Hy7kYgUpX2v
         cvYw0MKW5x+SUiOR5hZVBgKx9FnP0/jOQNC0w3cZ5nr7RGXB8NcTuqfBWv6ntFKbOGnD
         A9vkCKfaZw1Vr38s6KcH//gpprVmZ+nUpOCgaPePIpvKS83bFRzDmM3hdbrwzFFAj2Wq
         zCDA==
X-Gm-Message-State: AOJu0YwfotTIJCAywD03rrWa6oSo7/n3K16tlJHMjOST65+gHtz1WEK6
        t/w3vOVBJ7FhhVIwkBJmppObxuSOHA7+irGSS98=
X-Google-Smtp-Source: AGHT+IG8l2ff2fjLOIKGzkLdUaUXWPF7qWzbLfj8TW8lJXDEqGesj3MWvBJuyy7F0rvq3Dy5/Djasg==
X-Received: by 2002:a17:90a:a602:b0:26d:689f:4253 with SMTP id c2-20020a17090aa60200b0026d689f4253mr5159733pjq.6.1694749784779;
        Thu, 14 Sep 2023 20:49:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b002739282db53sm3881409pjx.32.2023.09.14.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:49:44 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 14 Sep 2023 20:49:39 -0700
Subject: [PATCH v5 3/4] riscv: Add checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-optimize_checksum-v5-3-c95b82a2757e@rivosinc.com>
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

Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
will load from the buffer in groups of 32 bits, and when compiled for
64-bit will load in groups of 64 bits.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h |  12 +++
 arch/riscv/lib/Makefile           |   1 +
 arch/riscv/lib/csum.c             | 198 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 2f0f224682bd..52e7926ff3ce 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -12,6 +12,18 @@
 
 #define ip_fast_csum ip_fast_csum
 
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+
+/* Default version is sufficient for 32 bit */
+#ifdef CONFIG_64BIT
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+#endif
+
+// Define riscv versions of functions before importing asm-generic/checksum.h
 #include <asm-generic/checksum.h>
 
 /*
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 26cb2502ecf8..2aa1a4ad361f 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -6,6 +6,7 @@ lib-y			+= memmove.o
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
+lib-y			+= csum.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
new file mode 100644
index 000000000000..06e1d16b29ca
--- /dev/null
+++ b/arch/riscv/lib/csum.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IP checksum library
+ *
+ * Influenced by arch/arm64/lib/csum.c
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kernel.h>
+
+#include <net/checksum.h>
+
+/* Default version is sufficient for 32 bit */
+#ifndef CONFIG_32BIT
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum csum)
+{
+	unsigned int ulen, uproto;
+	unsigned long sum = csum;
+
+	sum += saddr->s6_addr32[0];
+	sum += saddr->s6_addr32[1];
+	sum += saddr->s6_addr32[2];
+	sum += saddr->s6_addr32[3];
+
+	sum += daddr->s6_addr32[0];
+	sum += daddr->s6_addr32[1];
+	sum += daddr->s6_addr32[2];
+	sum += daddr->s6_addr32[3];
+
+	ulen = htonl((unsigned int)len);
+	sum += ulen;
+
+	uproto = htonl(proto);
+	sum += uproto;
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		unsigned long fold_temp;
+
+		/*
+		 * Zbb is likely available when the kernel is compiled with Zbb
+		 * support, so nop when Zbb is available and jump when Zbb is
+		 * not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+				  :
+				  :
+				  :
+				  : no_zbb);
+		asm(".option push					\n\
+		.option arch,+zbb					\n\
+			rori	%[fold_temp], %[sum], 32		\n\
+			add	%[sum], %[fold_temp], %[sum]		\n\
+			srli	%[sum], %[sum], 32			\n\
+			not	%[fold_temp], %[sum]			\n\
+			roriw	%[sum], %[sum], 16			\n\
+			subw	%[sum], %[fold_temp], %[sum]		\n\
+		.option pop"
+		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
+		return (__force __sum16)(sum >> 16);
+	}
+no_zbb:
+	sum += (sum >> 32) | (sum << 32);
+	sum >>= 32;
+	return csum_fold((__force __wsum)sum);
+}
+EXPORT_SYMBOL(csum_ipv6_magic);
+#endif // !CONFIG_32BIT
+
+#ifdef CONFIG_32BIT
+#define OFFSET_MASK 3
+#elif CONFIG_64BIT
+#define OFFSET_MASK 7
+#endif
+
+/*
+ * Perform a checksum on an arbitrary memory address.
+ * Algorithm accounts for buff being misaligned.
+ * If buff is not aligned, will over-read bytes but not use the bytes that it
+ * shouldn't. The same thing will occur on the tail-end of the read.
+ */
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
+{
+	unsigned int offset, shift;
+	unsigned long csum = 0, data;
+	const unsigned long *ptr;
+
+	if (unlikely(len <= 0))
+		return 0;
+	/*
+	 * To align the address, grab the whole first byte in buff.
+	 * Since it is inside of a same byte, it will never cross pages or cache
+	 * lines.
+	 * Directly call KASAN with the alignment we will be using.
+	 */
+	offset = (unsigned long)buff & OFFSET_MASK;
+	kasan_check_read(buff, len);
+	ptr = (const unsigned long *)(buff - offset);
+	len = len + offset - sizeof(unsigned long);
+
+	/*
+	 * Clear the most signifant bits that were over-read if buff was not
+	 * aligned.
+	 */
+	shift = offset * 8;
+	data = *ptr;
+	if (IS_ENABLED(__LITTLE_ENDIAN))
+		data = (data >> shift) << shift;
+	else
+		data = (data << shift) >> shift;
+
+	/*
+	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
+	 * faster than doing 32-bit reads on architectures that support larger
+	 * reads.
+	 */
+	while (len > 0) {
+		csum += data;
+		csum += csum < data;
+		len -= sizeof(unsigned long);
+		ptr += 1;
+		data = *ptr;
+	}
+
+	/*
+	 * Perform alignment (and over-read) bytes on the tail if any bytes
+	 * leftover.
+	 */
+	shift = len * -8;
+	if (IS_ENABLED(__LITTLE_ENDIAN))
+		data = (data << shift) >> shift;
+	else
+		data = (data >> shift) << shift;
+
+	csum += data;
+	csum += csum < data;
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
+		unsigned int fold_temp;
+
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			asm_volatile_goto(".option push			\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 16	\n\
+				andi	%[offset], %[offset], 1		\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				beq	%[offset], zero, %l[end]	\n\
+				rev8	%[csum], %[csum]		\n\
+				zext.h	%[csum], %[csum]		\n\
+			.option pop"
+				: [csum] "+r" (csum),
+				  [fold_temp] "=&r" (fold_temp)
+				: [offset] "r" (offset)
+				:
+				: end);
+
+			return csum;
+		} else {
+			asm_volatile_goto(".option push			\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 32	\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				srli	%[csum], %[csum], 32		\n\
+				roriw	%[fold_temp], %[csum], 16	\n\
+				addw	%[csum], %[fold_temp], %[csum]	\n\
+				andi	%[offset], %[offset], 1		\n\
+				beq	%[offset], zero, %l[end]	\n\
+				rev8	%[csum], %[csum]		\n\
+				srli	%[csum], %[csum], 32		\n\
+				zext.h	%[csum], %[csum]		\n\
+			.option pop"
+				: [csum] "+r" (csum),
+				  [fold_temp] "=&r" (fold_temp)
+				: [offset] "r" (offset)
+				:
+				: end);
+
+			return csum;
+		}
+end:
+			return csum >> 16;
+	}
+
+#ifndef CONFIG_32BIT
+	csum += (csum >> 32) | (csum << 32);
+	csum >>= 32;
+#endif
+	csum = (unsigned int)csum + (((unsigned int)csum >> 16) | ((unsigned int)csum << 16));
+	if (offset & 1)
+		return (unsigned short)swab32(csum);
+	return csum >> 16;
+}

-- 
2.42.0

