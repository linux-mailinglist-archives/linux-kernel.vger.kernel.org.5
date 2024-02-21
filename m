Return-Path: <linux-kernel+bounces-74520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555DA85D569
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD52288824
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845923F8E6;
	Wed, 21 Feb 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T3fUK25O"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2F3E470;
	Wed, 21 Feb 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510995; cv=none; b=H4ANatPPscqMNKGh38OpX2eJ0oHSnNeo9TAksqDHY0/RNDvTVfUwmOouiXZ/cyPsDk4WA3elSbK0Ymyu1u5HpENHbnFQ/BipHt5rqDe/VZB04N3Sy43KYPFqRijOZsUum9JSLj4Am/dmmSQo35TiAHqaN79jqbqANE0GbdS6U84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510995; c=relaxed/simple;
	bh=wSlFXJNr/cmsVO2H+EFpGOVDsAhGPl+1vkHJEhpG3ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a++UT7n1n6zwe3M08UZ8NHTk9EwWCZu/b2GO1KpcPBijmSF1KK90f6xUAd+FyCnyJYugYvVVvlxJb+tiPagzSsWk2ISGRfbc7xUUoMdTzhrtrJPkvrXNIHRVdyTTyoY3EdJpA8qmu46fstiUBjPNIvGp1RDlTKRZyoJY75BVTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T3fUK25O; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67DCF240003;
	Wed, 21 Feb 2024 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708510991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUrik2L/XdfT2NBxFB5is5OzPEkx0nf8lGt/JdUz6EE=;
	b=T3fUK25OtBYlXiQ83D6l9qjN93jlVX6k3Kec8Ptp0EUERId6w8rla6gdrSKst+wK+d/olU
	Q90Lv7Of5QpOxyCm13N3TOSKhcCgemYWUIx/uYP9rFE/QzC9OgdLVJgWuIu1LWfUEzCxtI
	MxWSf6AJmLLGKmXMYNzTd9ZOwOhurcXnvMaUtSvLW7itf1dg86CA4BjplAZ5356+HTVSXL
	X9tbFw2uIU8upxI5cNYFgzweonS5yNewyzMMrIoZuAqW/CY/cAVQaPndAiq1vW8ziB5K66
	yXbNeWU90Gtw1/WXGJ/xjCQix7HOuYHadzGKov1DxDdIevZs0bwMbDM/ixYCeA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 21 Feb 2024 11:22:47 +0100
Subject: [PATCH v3 3/7] ASoC: core: add SOC_DOUBLE_RANGE_TLV() helper macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-rk3308-audio-codec-v3-3-dfa34abfcef6@bootlin.com>
References: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
In-Reply-To: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
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


