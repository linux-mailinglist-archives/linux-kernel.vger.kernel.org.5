Return-Path: <linux-kernel+bounces-109300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE388175F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306D8B20FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848485291;
	Wed, 20 Mar 2024 18:39:40 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3C6A8A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959979; cv=none; b=lpPQDWlbB0XW4OwEZBa3OzSMDbKatceJJYQOK7JX/W+S36Jx1G2ezUgnDs32flLl+LD+pk8v2bLmKLCxDSpG3LMsZ3bvboEtbuz1t2zLd9hV9/bbpsEY1z52oiWXH1GZHyhOWbdzLkqXW4J9znLLR1yWvIxxVqBFkDy21VIslDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959979; c=relaxed/simple;
	bh=aVTXMepemamYIgEqhcZaCqWZdKxJee31zHLwpcDfTPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Onkh/z4DLnXcxtrZnsYnVWCw5NocFF+gWdmLOtU1MNbgZbknOEEh3oPk1tzCXCm2Yzd57GZihoeKizWCcQFjW4jQq3R5c8iW2is9RZtKLoRA/P/KCfbbI2oSGMKZnvDmJTlZI462KCnUiR+MBHKZRSO0BPZb5IW9FPjWMh7XLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id E55284254A;
	Wed, 20 Mar 2024 20:39:26 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qU-0001dW-2N;
	Wed, 20 Mar 2024 20:39:26 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] xz: Add RISC-V BCJ filter
Date: Wed, 20 Mar 2024 20:38:42 +0200
Message-ID: <20240320183846.19475-10-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320183846.19475-1-lasse.collin@tukaani.org>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This filter can be used by Squashfs without modifications to the Squashfs
kernel code (only needs support in userspace Squashfs-tools).

Co-developed-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/xz/Kconfig       |   5 +++
 lib/xz/xz_dec_bcj.c  | 105 ++++++++++++++++++++++++++++++++++++++++++-
 lib/xz/xz_dec_syms.c |   4 +-
 lib/xz/xz_private.h  |   6 ++-
 4 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index 1166627a87dc..20aa459bfb3e 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -40,6 +40,11 @@ config XZ_DEC_SPARC
 	default y
 	select XZ_DEC_BCJ
 
+config XZ_DEC_RISCV
+	bool "RISC-V BCJ filter decoder" if EXPERT
+	default y
+	select XZ_DEC_BCJ
+
 config XZ_DEC_MICROLZMA
 	bool "MicroLZMA decoder"
 	default n
diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index 941198a8a55b..c04767d357bd 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -5,6 +5,7 @@
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
  *          Igor Pavlov <https://7-zip.org/>
+ *          Jia Tan <jiat0218@gmail.com>
  */
 
 #include "xz_private.h"
@@ -24,7 +25,8 @@ struct xz_dec_bcj {
 		BCJ_ARM = 7,        /* Little endian only */
 		BCJ_ARMTHUMB = 8,   /* Little endian only */
 		BCJ_SPARC = 9,      /* Big or little endian */
-		BCJ_ARM64 = 10      /* AArch64 */
+		BCJ_ARM64 = 10,     /* AArch64 */
+		BCJ_RISCV = 11      /* RV32GQC_Zfh, RV64GQC_Zfh */
 	} type;
 
 	/*
@@ -388,6 +390,99 @@ static size_t bcj_arm64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 }
 #endif
 
+#ifdef XZ_DEC_RISCV
+static size_t bcj_riscv(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
+{
+	size_t i;
+	uint32_t b1;
+	uint32_t b2;
+	uint32_t b3;
+	uint32_t instr;
+	uint32_t instr2;
+	uint32_t instr2_rs1;
+	uint32_t addr;
+
+	if (size < 8)
+		return 0;
+
+	size -= 8;
+
+	for (i = 0; i <= size; i += 2) {
+		instr = buf[i];
+
+		if (instr == 0xEF) {
+			/* JAL */
+			b1 = buf[i + 1];
+			if ((b1 & 0x0D) != 0)
+				continue;
+
+			b2 = buf[i + 2];
+			b3 = buf[i + 3];
+
+			addr = ((b1 & 0xF0) << 13) | (b2 << 9) | (b3 << 1);
+			addr -= s->pos + (uint32_t)i;
+
+			buf[i + 1] = (uint8_t)((b1 & 0x0F)
+					| ((addr >> 8) & 0xF0));
+
+			buf[i + 2] = (uint8_t)(((addr >> 16) & 0x0F)
+					| ((addr >> 7) & 0x10)
+					| ((addr << 4) & 0xE0));
+
+			buf[i + 3] = (uint8_t)(((addr >> 4) & 0x7F)
+					| ((addr >> 13) & 0x80));
+
+			i += 4 - 2;
+
+		} else if ((instr & 0x7F) == 0x17) {
+			/* AUIPC */
+			instr |= (uint32_t)buf[i + 1] << 8;
+			instr |= (uint32_t)buf[i + 2] << 16;
+			instr |= (uint32_t)buf[i + 3] << 24;
+
+			if (instr & 0xE80) {
+				/* AUIPC's rd doesn't equal x0 or x2. */
+				instr2 = get_unaligned_le32(buf + i + 4);
+
+				if (((instr << 8) ^ (instr2 - 3)) & 0xF8003) {
+					i += 6 - 2;
+					continue;
+				}
+
+				addr = (instr & 0xFFFFF000) + (instr2 >> 20);
+
+				instr = 0x17 | (2 << 7) | (instr2 << 12);
+				instr2 = addr;
+			} else {
+				/* AUIPC's rd equals x0 or x2. */
+				instr2_rs1 = instr >> 27;
+
+				if ((uint32_t)((instr - 0x3117) << 18)
+						>= (instr2_rs1 & 0x1D)) {
+					i += 4 - 2;
+					continue;
+				}
+
+				addr = get_unaligned_be32(buf + i + 4);
+				addr -= s->pos + (uint32_t)i;
+
+				instr2 = (instr >> 12) | (addr << 20);
+
+				instr = 0x17 | (instr2_rs1 << 7)
+					| ((addr + 0x800) & 0xFFFFF000);
+			}
+
+			put_unaligned_le32(instr, buf + i);
+			put_unaligned_le32(instr2, buf + i + 4);
+
+			i += 8 - 2;
+		}
+	}
+
+	return i;
+}
+#endif
+
 /*
  * Apply the selected BCJ filter. Update *pos and s->pos to match the amount
  * of data that got filtered.
@@ -439,6 +534,11 @@ static void bcj_apply(struct xz_dec_bcj *s,
 	case BCJ_ARM64:
 		filtered = bcj_arm64(s, buf, size);
 		break;
+#endif
+#ifdef XZ_DEC_RISCV
+	case BCJ_RISCV:
+		filtered = bcj_riscv(s, buf, size);
+		break;
 #endif
 	default:
 		/* Never reached but silence compiler warnings. */
@@ -615,6 +715,9 @@ XZ_EXTERN enum xz_ret xz_dec_bcj_reset(struct xz_dec_bcj *s, uint8_t id)
 #endif
 #ifdef XZ_DEC_ARM64
 	case BCJ_ARM64:
+#endif
+#ifdef XZ_DEC_RISCV
+	case BCJ_RISCV:
 #endif
 		break;
 
diff --git a/lib/xz/xz_dec_syms.c b/lib/xz/xz_dec_syms.c
index 495d2cc2e6e8..8f4925af9737 100644
--- a/lib/xz/xz_dec_syms.c
+++ b/lib/xz/xz_dec_syms.c
@@ -22,6 +22,6 @@ EXPORT_SYMBOL(xz_dec_microlzma_end);
 #endif
 
 MODULE_DESCRIPTION("XZ decompressor");
-MODULE_VERSION("1.1");
-MODULE_AUTHOR("Lasse Collin <lasse.collin@tukaani.org> and Igor Pavlov");
+MODULE_VERSION("1.2");
+MODULE_AUTHOR("Lasse Collin, Igor Pavlov, Jia Tan");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 307e0de8c260..a8b1cbe8d21d 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -39,6 +39,9 @@
 #		ifdef CONFIG_XZ_DEC_ARM64
 #			define XZ_DEC_ARM64
 #		endif
+#		ifdef CONFIG_XZ_DEC_RISCV
+#			define XZ_DEC_RISCV
+#		endif
 #		ifdef CONFIG_XZ_DEC_MICROLZMA
 #			define XZ_DEC_MICROLZMA
 #		endif
@@ -102,7 +105,8 @@
 #	if defined(XZ_DEC_X86) || defined(XZ_DEC_POWERPC) \
 			|| defined(XZ_DEC_IA64) \
 			|| defined(XZ_DEC_ARM) || defined(XZ_DEC_ARMTHUMB) \
-			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64)
+			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64) \
+			|| defined(XZ_DEC_RISCV)
 #		define XZ_DEC_BCJ
 #	endif
 #endif
-- 
2.44.0


