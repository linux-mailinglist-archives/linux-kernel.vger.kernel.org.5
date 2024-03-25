Return-Path: <linux-kernel+bounces-116626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A015E88ACF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80535B647E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3A158A3E;
	Mon, 25 Mar 2024 09:37:04 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B7A803D82DA;
	Mon, 25 Mar 2024 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338124; cv=none; b=MU0kzQRnTDWBEHcK1F/uoAHjjp4uS17lkAwTXNUMzxHoFMG5s/tZE+QKvYnZeGVXDT6bHM6PIS6deSEA0HJKwuegLIyZtpXSPyD5TTRISdn8wNX/1EIS2F+nJor1L1++6DPjch/qyODJ43mJXLYLyR2FXnx/77k3MG0sCIPO31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338124; c=relaxed/simple;
	bh=KGBViHtyWl4RTc5Yv34/CbkultLm1irMrCSdjeeHfsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkvEsWa9A6bFiOf7IvQYN4L8r1Opoj0CAZEplhi4HHi4Qu4VJYzzX/Sx1Y+WOtyZkRJ4kDfuVOsfedd13Z6ZCQr3NdIiRqasXlH3auEdQQ2+ERsffpoSrNp06NxMtvKE0M0Sd+r9OytHCPNruTkbMeQVYeMTuK199LZuO5LrTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 4E0ED6026BC81;
	Mon, 25 Mar 2024 11:41:22 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: sti: uniperif: fix the undefined bitwise shift behavior problem
Date: Mon, 25 Mar 2024 11:40:33 +0800
Message-Id: <20240325034032.1031885-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build):
sound/soc/sti/uniperif_player.c:1115:12: warning:
The result of the left shift is undefined because the right operand is
negative [core.UndefinedBinaryOperatorResult]

When UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip) equals to -1, the result of
SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(ip) is undefined.

Here are some results of using different compilers.
		1UL >> -1	1UL << -1
gcc 10.2.1	0x2		0
gcc 11.4.0	0		0x8000000000000000
clang 14.0.0	0x64b8a45d72a0	0x64b8a45d72a0
clang 17.0.0	0x556c43b0f2a0	0x556c43b0f2a0

Add some macros to ensure that when right opreand is negative or other
invalid values, the results of bitwise shift is zero.

Fixes: e1ecace6a685 ("ASoC: sti: Add uniperipheral header file")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 sound/soc/sti/uniperif.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 2a5de328501c..1cbff01fbff0 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -12,17 +12,28 @@
 
 #include <sound/dmaengine_pcm.h>
 
+#define SR_SHIFT(a, b)		({unsigned long __a = (a); \
+				unsigned int __b = (b); \
+				__b < BITS_PER_LONG ? \
+				__a >> __b : 0; })
+
+#define SL_SHIFT(a, b)		({unsigned long __a = (a); \
+				unsigned int __b = (b); \
+				__b < BITS_PER_LONG ? \
+				__a << __b : 0; })
+
 /*
  * Register access macros
  */
 
 #define GET_UNIPERIF_REG(ip, offset, shift, mask) \
-	((readl_relaxed(ip->base + offset) >> shift) & mask)
+	(SR_SHIFT(readl_relaxed(ip->base + offset), shift) & mask)
 #define SET_UNIPERIF_REG(ip, offset, shift, mask, value) \
 	writel_relaxed(((readl_relaxed(ip->base + offset) & \
-	~(mask << shift)) | (((value) & mask) << shift)), ip->base + offset)
+	~SL_SHIFT(mask, shift)) | SL_SHIFT(((value) & mask), shift)),\
+	ip->base + offset)
 #define SET_UNIPERIF_BIT_REG(ip, offset, shift, mask, value) \
-	writel_relaxed((((value) & mask) << shift), ip->base + offset)
+	writel_relaxed(SL_SHIFT(((value) & mask), shift), ip->base + offset)
 
 /*
  * UNIPERIF_SOFT_RST reg
-- 
2.30.2


