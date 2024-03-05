Return-Path: <linux-kernel+bounces-92520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C17872190
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA4B1F24C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AF86ACB;
	Tue,  5 Mar 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJ6ffO+C"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325385C604;
	Tue,  5 Mar 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649420; cv=none; b=GLwr6kM3IsNKB2A+g7K9BwuFjpKX77jRdXAMBtR9ZLpUjB+fe+07n3K4/YJQGIWQvmSqKrk4640Ou+gjyxZRvYYOgBO3RR1mn5OPuYyzC4/39RiZip8QIwNtnHbnUsuvnEfYAgvItjsgP8clvmZscRZU2WUQpnC8TKowIgvPkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649420; c=relaxed/simple;
	bh=SwNaoU3CBtRTGn1ioD3u0Iy6Q4qsPnB7HbJQlo257Mw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P9KRE23w4cPfVjZe5Kz8yfND0PXzJCLwXFCh/AM5CinNwMN1j2IE+e6SMyRwF1Czcw5A44mKYElg5rPYGcXW8+SXyZftYL0F6FhVf9rM/aXKdn+LaDi6EUB+AASKkVpFAaf0fgeZKFm+eFspX6dmwY5kwxiIFQIGfs99M99ZLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJ6ffO+C; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6A66C000C;
	Tue,  5 Mar 2024 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709649415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TJg4ITKqKfYu+30cWlqLbE1/5HrZuqX0Hab1UwoC7W4=;
	b=EJ6ffO+CilUDoGxB6CXLFXWxSLqvfHX6mSvkQL+hZx3IYr2FmSHrBFgZIckvbT7Asl9Ctb
	UGpIpgZxrTVBb2CIFN6b1gQzUW81pExICbPLuWNQJje8etp+4KnVVg+6Uoy0Jaw/krF4pB
	NwRnwyPMt9boxfyUuaOfwqo66wmHKfvi4DmFipPYLMS/qU4JicNflfk6aGulZOX8zVHdzr
	FeQ7etZ/gKV/uoAeMLuBx9Y+uIMkK29joDUL+pHhhXfWkRkA9INGzty22Btj1SFcJzDtiw
	z3W1D9fOOx5cv6JnBuw4AAT9e3RhdOWwEYGJ4H5lB2jsHA2HvqDnY/t5+xXi6A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v4 0/7] Add support for the internal RK3308 audio codec
Date: Tue, 05 Mar 2024 15:36:27 +0100
Message-Id: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOst52UC/33NzQ6CMAzA8VchPTtTtoHgyfcwHsY+pFGZ2XDRE
 N7dQeLFGI//pv11gmgD2Qj7YoJgE0XyQw65KUD3ajhbRiY3cOSi5GXLwkUIbJh6GPJMe2M1U1V
 VNZ1qWtkayIf3YB09V/R4yt1THH14rT8SX6Z/ucQZMr1DgzXmFVkfOu/HKw1b7W+wgEl8EImcl
 z8RkRHjlJCqc9q6L2Se5zdMgvqQ+wAAAA==
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.13.0
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

Patches 2-4 add the codec driver along with the bindings and a new helper
macro.

Patches 5-7 add to the SoC DT file two I2S controllers (those which are
internally connected to the internal codec) and the codec itself and enable
the driver in the ARM64 defconfig.

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v4:
- several cleanups in the codec probe function
- Link to v3: https://lore.kernel.org/r/20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com

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

 .../bindings/sound/rockchip,rk3308-codec.yaml      |  98 +++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  56 ++
 arch/arm64/configs/defconfig                       |   1 +
 include/sound/soc.h                                |  12 +
 sound/soc/codecs/Kconfig                           |  11 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/rk3308_codec.c                    | 974 +++++++++++++++++++++
 sound/soc/codecs/rk3308_codec.h                    | 579 ++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.c              | 352 +-------
 10 files changed, 1746 insertions(+), 346 deletions(-)
---
base-commit: dfda120c512b3edca1436f770924e91b14f93a98
change-id: 20231219-rk3308-audio-codec-a5558ba8949d

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


