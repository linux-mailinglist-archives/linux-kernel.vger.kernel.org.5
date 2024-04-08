Return-Path: <linux-kernel+bounces-135848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175289CC08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F301C219CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232F3146A71;
	Mon,  8 Apr 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhNQ54mo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCD14601F;
	Mon,  8 Apr 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602524; cv=none; b=Td5fJCFblRaA9ftT0PSfgkOINMYNCXCNl7k+qEoQevsSrxrokfLwdD+xyWbwcb3Lc882jolqKD2y/H0GdDgeiBYZ4QVdPIYYDVJ7e2gO69vv8+dKSXpM9KyT3ZwwCTEEI88VUI8p1S5d2Nmx5J+xHe1BnqgFZFBXZBdwQgk/jvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602524; c=relaxed/simple;
	bh=WZI+UPEDXKp0AGVon/G5dC3J9SoMCzRad9Ln6loXDDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvATP8OlPp3TqvK+hhrL4e7Te4dK6cmxzk9GzO3fXcqSmqGgoEiklMnPf2u7I4L16dx3YMd9txNGmTC9mj/S1mIQj03a0yKbSjIUh+ixCw00HdjozwtkhFZPi1UT6G/QlSVhPddSYJxKICMpB6yCIiDJ/z8d1dwN/G6XOkcnGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhNQ54mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73412C43142;
	Mon,  8 Apr 2024 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602523;
	bh=WZI+UPEDXKp0AGVon/G5dC3J9SoMCzRad9Ln6loXDDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhNQ54moQZojEdG9F2dwxx5Fj/5G+xI1NEfku+X5s7NrIxMeVWLg5uo9tZZMmbIjY
	 gYoOYnEE+MlAzD820ldnRyIliImxOraEiLVEmChssnmX64QRIt2wImmnpUuF3SGH1J
	 EBQMsqnD5Cz7CFi680qKwbkDKbUqvZY/M5o9ekREt4QB20zTkqywcTiUfsXCcsQBm0
	 uW4YLbgr2QkjMGuMrg2fpFAOH5+lmrdL1U1k8FOxc6EimtlxeexrpdFxMbr1/qXHwD
	 hcO5dlODNHLsSb0ihBA9LEtLI/4PDnN7k3l1JVnoxcKsnBu16K9nhnsiVOQcD9yiWf
	 vSRbo+JMkzhmQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 4/9] tools/include: Sync uapi/sound/asound.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:15 -0700
Message-ID: <20240408185520.1550865-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes from:

  85df6b5a6658 ("ALSA: pcm: clarify and fix default msbits value for all formats")

This should be used to beautify sound syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/sound/asound.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index d5b9cfbd9cea..628d46a0da92 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -142,7 +142,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 16)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 17)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -416,7 +416,7 @@ struct snd_pcm_hw_params {
 	unsigned int rmask;		/* W: requested masks */
 	unsigned int cmask;		/* R: changed masks */
 	unsigned int info;		/* R: Info flags for returned setup */
-	unsigned int msbits;		/* R: used most significant bits */
+	unsigned int msbits;		/* R: used most significant bits (in sample bit-width) */
 	unsigned int rate_num;		/* R: rate numerator */
 	unsigned int rate_den;		/* R: rate denominator */
 	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
-- 
2.44.0.478.gd926399ef9-goog


