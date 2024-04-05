Return-Path: <linux-kernel+bounces-133408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D393689A353
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AC3B25F25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829C172764;
	Fri,  5 Apr 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eVDQ7fDg"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CB16F8E7;
	Fri,  5 Apr 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337125; cv=none; b=ZHhqr1cXgPR0DqTcXMXpa5p/+CJAzfAZmaVg2eVYocExSBY5P4fnSFE6wB90+u/8e3Mxx6fqpRiYwb8jvwXZNnzkUs450MBa7ZrJeeOC9+n+51/fzhs98GKqFUCUsJXL50qzSwn9+jxX1S6Kew+YFGL8Av5BkuebMwy/NZxmtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337125; c=relaxed/simple;
	bh=jp/ItmKjNW3lwD3HqdoO06DYpz1adMSLKDyVPElM/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fW2nq8efJPwoo6g4OzPKX1kqlvEH8v5KQK8j1jgJuTBF2anRIj3IS5Pv04QdNlE43DjROhvHKkih6YxFfjBMTKdENu5XN8fgwWpGbuZCcBbgB+TaOuM3cBGQp1mmUClFfvDfAazMdwCgXj/muZcYbK4erzcY0H70ZRE74pFgkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eVDQ7fDg; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [178.176.73.54])
	by mail.ispras.ru (Postfix) with ESMTPSA id 33E7440737DC;
	Fri,  5 Apr 2024 17:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 33E7440737DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1712337118;
	bh=zxli1M6t4+mmVUuqsEAwsb92XAAipwuHZ0h0RJ1Q04E=;
	h=From:To:Cc:Subject:Date:From;
	b=eVDQ7fDg7MTjYAXLcnt/MpMf1pjj9763Prk9QR8SbfcHQDleljuaSVRU5eRdI3Ldu
	 AHjNVIpvKJBaE2WOH9fFa900b5O5CoF32/I3cC7gHHTpsiUqS3zdGC95FFvSDvg48M
	 MdE2Sds5BvS+ruCEmn7RDKwFLXyUbUYCKXi3FGrc=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
	Venkata Prasad Potturu <quic_potturu@quicinc.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: qcom: Fix out of bounds access
Date: Fri,  5 Apr 2024 20:11:47 +0300
Message-ID: <20240405171148.12665-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Case values introduced in commit
5f78e1fb7a3e ("ASoC: qcom: Add driver support for audioreach solution")
cause out of bounds access in arrays of sc7280 driver data (e.g. in case
of RX_CODEC_DMA_RX_0 in sc7280_snd_hw_params()).

Redefine LPASS_MAX_PORTS to consider the maximum possible port id for
q6dsp as sc7280 driver utilizes some of those values.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 77d0ffef793d ("ASoC: qcom: Add macro for lpass DAI id's max limit")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
---
 sound/soc/qcom/lpass.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 27a2bf9a6613..10a507c95312 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -13,10 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <dt-bindings/sound/qcom,lpass.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "lpass-hdmi.h"
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
-#define LPASS_MAX_PORTS			(LPASS_CDC_DMA_VA_TX8 + 1)
+#define LPASS_MAX_PORTS			(QUINARY_MI2S_TX + 1)
 #define LPASS_MAX_MI2S_PORTS			(8)
 #define LPASS_MAX_DMA_CHANNELS			(8)
 #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)
-- 
2.44.0


