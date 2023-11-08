Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496337E5CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjKHRuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKHRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:50:13 -0500
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 09:50:10 PST
Received: from mailscanner06.zoner.fi (mailscanner06.zoner.fi [5.44.246.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0A01FC8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:50:10 -0800 (PST)
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner06.zoner.fi (Postfix) with ESMTPS id C975621215;
        Wed,  8 Nov 2023 19:44:48 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1r0mbg-00089D-21;
        Wed, 08 Nov 2023 19:44:48 +0200
Date:   Wed, 8 Nov 2023 19:44:48 +0200
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/xz: Add ARM64 BCJ filter
Message-ID: <20231108194448.674cd0ad@kaneli>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lasse Collin <lasse.collin@tukaani.org>

ARM64 kernel decompression is done by bootloaders but
the filter can still be useful, for example, for Squashfs.

A duplicated check for XZ_DEC_ARM in xz_private.h was omitted too.

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---

 lib/xz/Kconfig      |    5 +++++
 lib/xz/xz_dec_bcj.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/xz/xz_private.h |    7 +++++--
 3 files changed, 59 insertions(+), 3 deletions(-)

diff -rup linux-6.6.orig/lib/xz/Kconfig linux-6.6/lib/xz/Kconfig
--- linux-6.6.orig/lib/xz/Kconfig	2023-10-30 04:31:08.000000000 +0200
+++ linux-6.6/lib/xz/Kconfig	2023-11-08 16:27:17.661462876 +0200
@@ -34,6 +34,11 @@ config XZ_DEC_ARMTHUMB
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
diff -rup linux-6.6.orig/lib/xz/xz_dec_bcj.c linux-6.6/lib/xz/xz_dec_bcj.c
--- linux-6.6.orig/lib/xz/xz_dec_bcj.c	2023-10-30 04:31:08.000000000 +0200
+++ linux-6.6/lib/xz/xz_dec_bcj.c	2023-11-08 16:29:37.949475877 +0200
@@ -24,7 +24,8 @@ struct xz_dec_bcj {
 		BCJ_IA64 = 6,       /* Big or little endian */
 		BCJ_ARM = 7,        /* Little endian only */
 		BCJ_ARMTHUMB = 8,   /* Little endian only */
-		BCJ_SPARC = 9       /* Big or little endian */
+		BCJ_SPARC = 9,      /* Big or little endian */
+		BCJ_ARM64 = 10      /* AArch64 */
 	} type;
 
 	/*
@@ -334,6 +335,45 @@ static size_t bcj_sparc(struct xz_dec_bc
 }
 #endif
 
+#ifdef XZ_DEC_ARM64
+static size_t bcj_arm64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
+{
+	size_t i;
+	uint32_t instr;
+	uint32_t addr;
+
+	for (i = 0; i + 4 <= size; i += 4) {
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
@@ -381,6 +421,11 @@ static void bcj_apply(struct xz_dec_bcj
 		filtered = bcj_sparc(s, buf, size);
 		break;
 #endif
+#ifdef XZ_DEC_ARM64
+	case BCJ_ARM64:
+		filtered = bcj_arm64(s, buf, size);
+		break;
+#endif
 	default:
 		/* Never reached but silence compiler warnings. */
 		filtered = 0;
@@ -554,6 +599,9 @@ XZ_EXTERN enum xz_ret xz_dec_bcj_reset(s
 #ifdef XZ_DEC_SPARC
 	case BCJ_SPARC:
 #endif
+#ifdef XZ_DEC_ARM64
+	case BCJ_ARM64:
+#endif
 		break;
 
 	default:
diff -rup linux-6.6.orig/lib/xz/xz_private.h linux-6.6/lib/xz/xz_private.h
--- linux-6.6.orig/lib/xz/xz_private.h	2023-10-30 04:31:08.000000000 +0200
+++ linux-6.6/lib/xz/xz_private.h	2023-11-08 16:31:17.155717209 +0200
@@ -37,6 +37,9 @@
 #		ifdef CONFIG_XZ_DEC_SPARC
 #			define XZ_DEC_SPARC
 #		endif
+#		ifdef CONFIG_XZ_DEC_ARM64
+#			define XZ_DEC_ARM64
+#		endif
 #		ifdef CONFIG_XZ_DEC_MICROLZMA
 #			define XZ_DEC_MICROLZMA
 #		endif
@@ -98,9 +101,9 @@
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
