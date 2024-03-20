Return-Path: <linux-kernel+bounces-109334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF68817C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542EF1C2138B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B4D85926;
	Wed, 20 Mar 2024 19:17:47 +0000 (UTC)
Received: from mailscanner05.zoner.fi (mailscanner05.zoner.fi [5.44.246.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073B8562D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962267; cv=none; b=ZHFrDkKEhiIMqh6OXzMn3idIqOdUdb5nmKMIOD5H2lgU5Eb8x3zHA3h7UaN6Hl8rMerul4Mllhzuccz8sB/t80BKdSIvI0Z/45R+6Pcjsw27DoTs+ppAo3moPcwfYG7fuuuAoC3tBhuUvNh+m9+afTSxdkkd+GMGOcK+cXl1gUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962267; c=relaxed/simple;
	bh=1STaSSKFT9aWSutIcaXf5t9tigM61VZiBi4b8crf1L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmN9DiQpAin3kMEyS0OMvSXEaf+hGjkdFf910gbk0snFPzm/2gVtu8dqDn12wZem5PRY89UgKlo750rNSoh72mzGbMbcU3dRoEoZHoWJlO6FRPAtUEFO4d1KpaAIWIZ6DR21kRUcLI0SHE81QY8VOt06gH+9Cn2NMi/Bghjfcb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner05.zoner.fi (Postfix) with ESMTPS id 4D5E3211A4;
	Wed, 20 Mar 2024 21:17:42 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qU-0001dW-2g;
	Wed, 20 Mar 2024 20:39:26 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] xz: Use 128 MiB dictionary and force single-threaded mode
Date: Wed, 20 Mar 2024 20:38:43 +0200
Message-ID: <20240320183846.19475-11-lasse.collin@tukaani.org>
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

This only affects kernel image compression, not any other xz usage.

Desktop kernels on x86-64 are already around 60 MiB. Using a dictionary
larger than 32 MiB should have no downsides nowadays as anyone building
the kernel should have plenty of RAM. 128 MiB dictionary needs 1346 MiB
of RAM with xz versions 5.0.x - 5.6.x in single-threaded mode. On archs
that use xz_wrap.sh, kernel decompression is done in single-call mode so
a larger dictionary doesn't affect boot-time memory requirements.

xz >= 5.6.0 uses multithreaded mode by default which compresses slightly
worse than single-threaded mode. Kernel compression rarely used more
than one thread anyway because with 32 MiB dictionary size the default
block size was 96 MiB in multithreaded mode. So only a single thread
was used anyway unless the kernel was over 96 MiB.

Comparison to CONFIG_KERNEL_LZMA: It uses "lzma -9" which mapped to
32 MiB dictionary in LZMA Utils 4.32.7 (the final release in 2008).
Nowadays the lzma tool on most systems is from XZ Utils where -9 maps
to 64 MiB dictionary. So using a 32 MiB dictionary with CONFIG_KERNEL_XZ
may have compressed big kernels slightly worse than the old LZMA option.

Comparison to CONFIG_KERNEL_ZSTD: zstd uses 128 MiB dictionary.

Reviewed-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 scripts/xz_wrap.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index bb760b721b2c..c8c36441ab70 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -16,4 +16,15 @@ case $SRCARCH in
 	sparc)          BCJ=--sparc ;;
 esac
 
-exec $XZ --check=crc32 $BCJ --lzma2=$LZMA2OPTS,dict=32MiB
+# Use single-threaded mode because it compresses a little better
+# (and uses less RAM) than multithreaded mode.
+#
+# For the best compression, the dictionary size shouldn't be
+# smaller than the uncompressed kernel. 128 MiB dictionary
+# needs less than 1400 MiB of RAM in single-threaded mode.
+#
+# On the archs that use this script to compress the kernel,
+# decompression in the preboot code is done in single-call mode.
+# Thus the dictionary size doesn't affect the memory requirements
+# of the preboot decompressor at all.
+exec $XZ --check=crc32 --threads=1 $BCJ --lzma2=$LZMA2OPTS,dict=128MiB
-- 
2.44.0


