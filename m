Return-Path: <linux-kernel+bounces-109318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2013881786
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975881F22BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD885637;
	Wed, 20 Mar 2024 18:49:26 +0000 (UTC)
Received: from mailscanner11.zoner.fi (mailscanner11.zoner.fi [5.44.246.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726185623
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960565; cv=none; b=g6Ppy4rqDsEuTKc6zteajNdOwe/Xv4B/rPxbW5xmuT+Y3OI5KelHj8rzKCMrGWnOaMZS+s8UrZrW+TQKtkrJ5sAMUJHN9pe3rhQy+UNeDY5dLiP4IhhjGfN3BcHdZAHTb6IcC1gRJlFUsBv5yO3VZbB9vgtgXeL764ZGIqoPIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960565; c=relaxed/simple;
	bh=j0isJCYION1kfv7Iyxp5a8hbbdmD6XkxP4eup1q1PPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MELP9MvPXEDmF2azPSQDySp7qKZr8MBPNE9WuP9n71RXw9L4jgZhKDnnflFHbN2PewSgW7aPQBgZ1DLj2h8iT41dagdhUSk23MogMLKFL4O3bAZZ50XA+Y0Fb064c4rFb1xx83lTBLJHdeqazuXhSVju0UCyMtLehYQA9/D2i3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner11.zoner.fi (Postfix) with ESMTPS id 8C1E320ED0;
	Wed, 20 Mar 2024 20:39:26 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qU-0001dW-1H;
	Wed, 20 Mar 2024 20:39:26 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] xz: Cleanup CRC32 edits from 2018
Date: Wed, 20 Mar 2024 20:38:39 +0200
Message-ID: <20240320183846.19475-7-lasse.collin@tukaani.org>
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

The commit faa16bc404d72a5a ("lib: Use existing define with polynomial")
in 2018 added a dependency on <linux/crc32poly.h> to avoid duplicating
the same constant in multiple files. Two months later it was found to be
a bad idea and the commit 242cdad873a75652 ("lib/xz: Put CRC32_POLY_LE
in xz_private.h") added the definition of CRC32_POLY_LE macro into
xz_private.h to avoid including <linux/crc32poly.h>.

xz_private.h is a wrong place for it too. Revert back to the upstream
version which has the poly in xz_crc32_init() in xz_crc32.c.

Reviewed-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/xz/xz_crc32.c   | 2 +-
 lib/xz/xz_private.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 30b8a27110b1..effdf34ec48d 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -28,7 +28,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
 
 XZ_EXTERN void xz_crc32_init(void)
 {
-	const uint32_t poly = CRC32_POLY_LE;
+	const uint32_t poly = 0xEDB88320;
 
 	uint32_t i;
 	uint32_t j;
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 2412a5d54801..811add814ae4 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -104,10 +104,6 @@
 #	endif
 #endif
 
-#ifndef CRC32_POLY_LE
-#define CRC32_POLY_LE 0xedb88320
-#endif
-
 /*
  * Allocate memory for LZMA2 decoder. xz_dec_lzma2_reset() must be used
  * before calling xz_dec_lzma2_run().
-- 
2.44.0


