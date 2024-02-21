Return-Path: <linux-kernel+bounces-74517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7985D563
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D81B22D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99C3E468;
	Wed, 21 Feb 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+C7gWTC"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26B3C493;
	Wed, 21 Feb 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510992; cv=none; b=tGODcfk9yy+pnb815/p/dMKTINj4bLn/n8Ywpt9M1EJ+AsZ6pZJV9Zi/w+6iCyUdMKLNy1ThKk3rzMf0xf08anzre14TWbegYl7MpEMUHKHajinfRmgtEXFhWkDVd1+vkufkHvfPpCdmv1xhNwTrDWdI/RBv0XkgtTADdiGDxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510992; c=relaxed/simple;
	bh=IytAcFRRXdFL1b3NOGD/mw27EjHnUb9QOtyz0ZGguz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mIQxnFwkT2HtyhTc6+4sj3dKiXAtxPB367ICRovNOvOXb93SOY6cIYtBokjFBhTSCKi4hpbS68JJb5+KiEqjtFOjQDTe/HnEu01la2KSCdW3j8eEqAC1JEZhSlxFs3f47AS0d5oGU1M8yYdtjCPB58L4IgZokLihDh6CZGAfj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+C7gWTC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25C7C240007;
	Wed, 21 Feb 2024 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708510987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c7Q53kbT3bjQcV8xVao/3i3dAchySM+PlajClMKqNFk=;
	b=Z+C7gWTCwj5OYnsG/9n0xIlEKB4Ifk6Fka8R41FN6StbxnGXofHNAlizuI7zZEahLoJGtl
	HkYdnSkJfREYGwbNBHwqAyHXb212nK7HprNQiGZz9VG3MybFFtdjvY0f5tJ65xnIZErUzn
	UERW1wX8uGgvDrLZ9ICO0gl0R4F5PaPc6lxwCGkoqMZ/4pakqlw59CLhJ9ymM+5A19LSqb
	9PdqyFq+mFYBM+ngEEXvfnFcymrdIQK54coO0Sj0hOJQ++wOSv0MJC3cM3XpmTTdIPWQ0n
	MSuHg3E4LbNKtKP5Vcxy6+yRXIZfTIQsQa/+fZJ9qP84+o25j9u82Rk1ybJMsg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 0/7] Add support for the internal RK3308 audio codec
Date: Wed, 21 Feb 2024 11:22:44 +0100
Message-Id: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPTO1WUC/32NQQ7CIBBFr9LM2jEU2tq68h6mCwpoJypjoBJNw
 93FHsDl+/n//RWiC+QiHKsVgksUiX0BtavAzNpfHZItDFJIVct6wHBTSvSoX5YYDVtnULdt20+
 6H5rBQhk+g7vQe5Oex8IzxYXDZ/tI8pf+1SWJAs1BWNGJUmm608S83MnvDT9gzDl/AXuYUoO2A
 AAA
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

This series adds a driver for the internal audio codec of the Rockchip
RK3308 SoC, along with some related patches. This codec is internally
connected to the I2S peripherals on the same chip, and it has some
peculiarities arising from that interconnection.

For proper bidirectional operation with the internal codec at any possible
combination of sampling rates, the I2S peripheral needs two clock sources
(tx and rx), while connection with an external codec commonly needs only
one.

Since v5.16 there is a driver for the I2S in
sound/soc/rockchip/rockchip_i2s_tdm.c, but in some cases it does not
configure correctly the clocks, resulting in an unnecessarily inaccurate
rate. Patch 1 fixes this.

Patches 2-4 adds the codec driver along with the bindings and a new helper
macro.

Patches 5-7 add to the SoC DT file two I2S controllers (those which are
internally connected to the internal codec) and the codec itself and enable
the driver in the ARM64 defconfig.

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v3:
 - Add the I2S clock fix patch and remove a previous fix which is now superseded
 - Codec driver: fix silent playback until a given amplitude of sigital
   value, seen at >= 96 kHz rate
 - various other changes, listed per-patch
 - Link to v2: https://lore.kernel.org/r/20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com

Changes in v2:
 - largely rewrote the codec driver to use DAPM and lots of improvements
   and cleanups
 - removed the RK3308 audio card and related patches
 - various other changes, listed per-patch
 - Link to v1: https://lore.kernel.org/all/20220907142124.2532620-1-luca.ceresoli@bootlin.com/

---
Luca Ceresoli (7):
      ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates
      ASoC: dt-bindings: Add Rockchip RK3308 internal audio codec
      ASoC: core: add SOC_DOUBLE_RANGE_TLV() helper macro
      ASoC: codecs: Add RK3308 internal audio codec driver
      arm64: defconfig: enable Rockchip RK3308 internal audio codec driver
      arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
      arm64: dts: rockchip: add the internal audio codec

 .../bindings/sound/rockchip,rk3308-codec.yaml      |  98 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  56 ++
 arch/arm64/configs/defconfig                       |   1 +
 include/sound/soc.h                                |  12 +
 sound/soc/codecs/Kconfig                           |  11 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/rk3308_codec.c                    | 993 +++++++++++++++++++++
 sound/soc/codecs/rk3308_codec.h                    | 579 ++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.c              | 352 +-------
 10 files changed, 1765 insertions(+), 346 deletions(-)
---
base-commit: 20fb305a716356265e9479719502b5a012e0d869
change-id: 20231219-rk3308-audio-codec-a5558ba8949d

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


