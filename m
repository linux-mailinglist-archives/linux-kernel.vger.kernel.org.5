Return-Path: <linux-kernel+bounces-109317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A29881785
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04A2B21615
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0528562D;
	Wed, 20 Mar 2024 18:49:14 +0000 (UTC)
Received: from mailscanner09.zoner.fi (mailscanner09.zoner.fi [5.44.246.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD485623
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960554; cv=none; b=SgDwIC4JT2jqbnIV5Eu/BykbzQHfqds9HnknT2oTZ8bkRsG/GvbWSXVfeXhkvrYrHKBn2LSDKbeHy2W1/uR5L4RW/ZWIKC9lrGjQ55fPpwATGhmYA5cXo9ASbHdwEnNBpSw8T6Mb9cjNrxTMkOuilgAPXOBFX1b3bORBoApyvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960554; c=relaxed/simple;
	bh=ByoVqAuRdD1oD3TBj0N5QxLkM+fd/TEn0WNYkz4c3B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3/lONLuUwx12vz/L/Om0skqGmAf9ZnmLwWZOMw9bUaw1v0SKcMM42GFoEsmAwMhBifIqhN220fp9eE4ozELF5/RZgkHYPpop/qVEAKsXTJNIuJWLk6xUxlrx20fmSmSpBMeVjTvFPklifyOe57uDQ8SZQ4sbT1dUsFYlK9QywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner09.zoner.fi (Postfix) with ESMTPS id CC5652108E;
	Wed, 20 Mar 2024 20:39:26 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qU-0001dW-23;
	Wed, 20 Mar 2024 20:39:26 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] xz: Add ARM64 BCJ filter
Date: Wed, 20 Mar 2024 20:38:41 +0200
Message-ID: <20240320183846.19475-9-lasse.collin@tukaani.org>
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

Also omit a duplicated check for XZ_DEC_ARM in xz_private.h.

This filter can be used by Squashfs without modifications to the Squashfs
kernel code (only needs support in userspace Squashfs-tools).

Reviewed-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---

Notes:
    Compared to the first patch I submitted on 2023-11-08
    (see <https://lore.kernel.org/lkml/20231108194448.674cd0ad@kaneli/>),
    this has a minor tweak to make the for-loop condition faster.
    
    Squashfs-tools Git repository already has support for creating
    file systems that use the ARM64 filter.

 lib/xz/Kconfig      |  5 +++++
 lib/xz/xz_dec_bcj.c | 52 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/xz/xz_private.h |  7 ++++--
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index 6b80453d8f54..1166627a87dc 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -30,6 +30,11 @@ config XZ_DEC_ARMTHUMB
 	default y
 	select XZ_DEC_BCJ
 
+config XZ_DEC_ARM64
+	bool "ARM64 BCJ filter decoder" if EXPERT
+	default y
+	select XZ_DEC_BCJ
+
 config XZ_DEC_SPARC
 	bool "SPARC BCJ filter decoder" if EXPERT
 	default y
diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index e0b4bf4999c0..941198a8a55b 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -23,7 +23,8 @@ struct xz_dec_bcj {
 		BCJ_IA64 = 6,       /* Big or little endian */
 		BCJ_ARM = 7,        /* Little endian only */
 		BCJ_ARMTHUMB = 8,   /* Little endian only */
-		BCJ_SPARC = 9       /* Big or little endian */
+		BCJ_SPARC = 9,      /* Big or little endian */
+		BCJ_ARM64 = 10      /* AArch64 */
 	} type;
 
 	/*
@@ -346,6 +347,47 @@ static size_t bcj_sparc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 }
 #endif
 
+#ifdef XZ_DEC_ARM64
+static size_t bcj_arm64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
+{
+	size_t i;
+	uint32_t instr;
+	uint32_t addr;
+
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
+		instr = get_unaligned_le32(buf + i);
+
+		if ((instr >> 26) == 0x25) {
+			/* BL instruction */
+			addr = instr - ((s->pos + (uint32_t)i) >> 2);
+			instr = 0x94000000 | (addr & 0x03FFFFFF);
+			put_unaligned_le32(instr, buf + i);
+
+		} else if ((instr & 0x9F000000) == 0x90000000) {
+			/* ADRP instruction */
+			addr = ((instr >> 29) & 3) | ((instr >> 3) & 0x1FFFFC);
+
+			/* Only convert values in the range +/-512 MiB. */
+			if ((addr + 0x020000) & 0x1C0000)
+				continue;
+
+			addr -= (s->pos + (uint32_t)i) >> 12;
+
+			instr &= 0x9000001F;
+			instr |= (addr & 3) << 29;
+			instr |= (addr & 0x03FFFC) << 3;
+			instr |= (0U - (addr & 0x020000)) & 0xE00000;
+
+			put_unaligned_le32(instr, buf + i);
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
@@ -392,6 +434,11 @@ static void bcj_apply(struct xz_dec_bcj *s,
 	case BCJ_SPARC:
 		filtered = bcj_sparc(s, buf, size);
 		break;
+#endif
+#ifdef XZ_DEC_ARM64
+	case BCJ_ARM64:
+		filtered = bcj_arm64(s, buf, size);
+		break;
 #endif
 	default:
 		/* Never reached but silence compiler warnings. */
@@ -565,6 +612,9 @@ XZ_EXTERN enum xz_ret xz_dec_bcj_reset(struct xz_dec_bcj *s, uint8_t id)
 #endif
 #ifdef XZ_DEC_SPARC
 	case BCJ_SPARC:
+#endif
+#ifdef XZ_DEC_ARM64
+	case BCJ_ARM64:
 #endif
 		break;
 
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 811add814ae4..307e0de8c260 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -36,6 +36,9 @@
 #		ifdef CONFIG_XZ_DEC_SPARC
 #			define XZ_DEC_SPARC
 #		endif
+#		ifdef CONFIG_XZ_DEC_ARM64
+#			define XZ_DEC_ARM64
+#		endif
 #		ifdef CONFIG_XZ_DEC_MICROLZMA
 #			define XZ_DEC_MICROLZMA
 #		endif
@@ -97,9 +100,9 @@
  */
 #ifndef XZ_DEC_BCJ
 #	if defined(XZ_DEC_X86) || defined(XZ_DEC_POWERPC) \
-			|| defined(XZ_DEC_IA64) || defined(XZ_DEC_ARM) \
+			|| defined(XZ_DEC_IA64) \
 			|| defined(XZ_DEC_ARM) || defined(XZ_DEC_ARMTHUMB) \
-			|| defined(XZ_DEC_SPARC)
+			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64)
 #		define XZ_DEC_BCJ
 #	endif
 #endif
-- 
2.44.0


