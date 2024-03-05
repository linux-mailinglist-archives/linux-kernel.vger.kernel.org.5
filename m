Return-Path: <linux-kernel+bounces-92523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E29872196
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632492851DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736C1272A2;
	Tue,  5 Mar 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JSYcxPM0"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FE86AD4;
	Tue,  5 Mar 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649423; cv=none; b=dPbxVHRhhmS12zp9sdr+fqkJ83yJAO2DawJikHgS9wbH1tk56qM1n1vHB4iSFX6zxsVthcWtHEFrYQKLPU0RDqpNbl1fC2VneQusOfDVYvPMfeVYVdLcmrajwkRwQvRqbtC865ApUcqzpWqjAQnNkMWyXjmDTPi4l4kFpF4WJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649423; c=relaxed/simple;
	bh=VqibmGC3Jl/dxCE8AV7JqAdCOckz+GBMN1nkxkHyhc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUCL5E4n51am7VIfmKJXoBgY64YESN2M+dkMQO4nX5RpAOmS9df56mFbVSKQ94bAA1XZQM9LUBUrzFC6HjHn8gqySEl2VuU01Vh07Bcnr8gd6HWyWnOkNpc76kqjHjLcyyFAygBq3/dchQyD1nRxfHlQFyGJKxtpaptkXy0d78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JSYcxPM0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8196EC0007;
	Tue,  5 Mar 2024 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709649419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nOGJSWM5DMTY+8OJI5pb0eawfVnNHkYI1yq5zzD180=;
	b=JSYcxPM0+0rhLj26E5SZB3FUzzRurNnAaU1CH+3UgpdNQ6wPRIE4OKy7o/X9iaLQS3j6Ik
	tBAcgFXvpizqQJAg+YN4CVZIQOOqM5lCOe/HFuyRx/Zvy1YV5hzi8HtYccvvlfWeiLx+Iy
	IZZMkJfUurV8XVmYr+xZ/TujhXifNHOu9nfWPfUf7i/rIHGCbPAs8hhm+l6neQoES2mVT0
	uO0myHxI/y0sLaBkTHNPD7OYbMPtpej+6lKHLfE9gDDt8ETFyZoy8mUyZtTFlcGaZRDv6Y
	Zi4XdHThllDRIJ+ZZTGQTmwTserdcjXUUGC6N0ImwtGSnHVMycw38I4HHFZkzw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 05 Mar 2024 15:36:30 +0100
Subject: [PATCH v4 3/7] ASoC: core: add SOC_DOUBLE_RANGE_TLV() helper macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-rk3308-audio-codec-v4-3-312acdbe628f@bootlin.com>
References: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
In-Reply-To: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

No macro currently allows handling a stereo control that has left and right
in the same register and whose minimum register value is not zero. Add one
that does that.

Note that even though the snd_soc_*_volsw_range() look more appropriate
given the _range suffix, they are not suitable because they don't honor the
two shift values. The snd_soc_*_volsw() look more generic and are suitable
for the task.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v4: nothing
Changed in v3: nothing

This patch is new in v2.
---
 include/sound/soc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6defc5547ff9..7492315ce0b8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -149,6 +149,18 @@
 		{.reg = xreg, .rreg = xreg, \
 		.shift = shift_left, .rshift = shift_right, \
 		.max = xmax, .min = xmin} }
+#define SOC_DOUBLE_RANGE_TLV(xname, xreg, xshift_left, xshift_right, xmin, xmax, \
+			     xinvert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xreg, \
+		 .shift = xshift_left, .rshift = xshift_right, \
+		 .min = xmin, .max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\

-- 
2.34.1


