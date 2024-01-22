Return-Path: <linux-kernel+bounces-33249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28400836742
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C41C22988
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C94250256;
	Mon, 22 Jan 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB3pN6Pi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5050264;
	Mon, 22 Jan 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935493; cv=none; b=NHXtjLf+kIRs3yy1ppMsGXfqid0o0S0vNZIKIhs3oQWEFS88UkuiibM61ycYFHJQCt339exC42UU6maO4hrzKEc0hZ3U+f/gHYkSFuEyQPeOkYFvgaIsbGhYPv4Cy6hTFbzW0aYFRZBLIqa0xwWUULbbzJzgJozq2PM/rspZJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935493; c=relaxed/simple;
	bh=lYQ0v9BNAg7b1crERIXnaGONdNgAR+yxdq9wdPYxpoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc93Y67vZUSlo/NSru/7+Tf35y1YBK/8xlpzW0LauTjzzWVEIhI2sDVON8QH1SunuljW5eP2wfAMT7I8BqJvMB42Yn1Zb7hvZU6i/5m1arGXA7aIkLthBdR7hXNxVXa0mqd+tX/8xwlalMr46+BxVafoKQwpeFB9wy6kvTYExgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB3pN6Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F424C43390;
	Mon, 22 Jan 2024 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935493;
	bh=lYQ0v9BNAg7b1crERIXnaGONdNgAR+yxdq9wdPYxpoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB3pN6Pi9ysWv5ciEN0U0fEKUScG7lOahpj6kpV4mwq39VX/9VlT8BCBv9gIH2pli
	 oIcne8IcrhplipO5Vs6cLyKVAdFPhKccBpMXxNm9OBhUc6s8TWWKEArQoPg0KqwW7Z
	 6F7IVY82vDTnQxaiEdRhj0OyMdQYnpMQvM1h6O3ZOpcvSWg6kX4/Boo2SuCktxVWjB
	 2mo9jLbZNZopD3A6NmiHXbw8q15tqI9m3rB8/NyAzEk3hDgxUCkJ9rUFEOIDrexxEA
	 6ZavPHgE+hCfvYBIS3LMdt0BrmMrn8C/2IedX5UMCWPtuhJh3Cz7qqGtfV3j7ZCKOd
	 9Q6yZ0SND/ufA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	amadeuszx.slawinski@linux.intel.com,
	bradynorander@gmail.com,
	markhas@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 31/88] ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
Date: Mon, 22 Jan 2024 09:51:04 -0500
Message-ID: <20240122145608.990137-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 7a9d6bbe8a663c817080be55d9fecf19a4a8fd8f ]

Same usual filters, SOF is required for DMIC and/or SoundWire support.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231204212710.185976-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 756fa0aa69bb..6a384b922e4f 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -521,6 +521,16 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_MTL,
 	},
+	/* ArrowLake-S */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL_S,
+	},
+	/* ArrowLake */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL,
+	},
 #endif
 
 /* Lunar Lake */
-- 
2.43.0


