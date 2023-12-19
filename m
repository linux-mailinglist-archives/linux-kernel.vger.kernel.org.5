Return-Path: <linux-kernel+bounces-5431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A68818A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE28F2897D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04831CF86;
	Tue, 19 Dec 2023 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eR0TgaFv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205E374EC;
	Tue, 19 Dec 2023 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F93940008;
	Tue, 19 Dec 2023 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702997685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/kiy+EyoHiEM1ZV0AcyGmIqSBGfNRYrAo9pwLUdKJo=;
	b=eR0TgaFv74SLX0l5Cita7+vpYSlCMvCJaQ9tObGKdHHAJA5hsBg6vthhimj+cRldwreQym
	rZaisRyMrMktg+0PHFV0Vsb0JQgbqaAnqQnz/7fnGO/a4i8wKOgDkC7T/uhbf43bj9b5rB
	5d8kRsnvwxhDmhBy4xwfdxtX5vDUrxpTvzYrOkF/6XlYwG64ISTIZKokRm7BIlUa9j+RV/
	IyFT2h5WRWJArYi4nlbG+EvVCjSuIFwivplFC4Flgt3zx3GDLCL0cj3sSWDD40RmOUV1BS
	zNuN2JEYcPbgN7ip5QD24wiQY7Do5g9pOeQMafrWiCQcGP6AKSOyCVObSp6f3w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/6] Add support for the internal RK3308 audio codec
Date: Tue, 19 Dec 2023 15:54:15 +0100
Message-Id: <20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeugWUC/x3MQQqAIBBA0avIrBtITdCuEi1MpxqCDKUIorsnL
 d/i/wcKZaYCvXgg08WF016hGgFh9ftCyLEaVKu0VNJh3rRuLfozcsKQIgX0xhg7ees6F6GGR6a
 Z7386jO/7ASkiTjpkAAAA
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

This series of patches adds support to use the internal audio codec of the
Rockchip RK3308 SoC. This codec is internally connected to the I2S
peripherals on the same chip, and it has some peculiarities arising from
that interconnection.

For proper bidirectional operation with the internal codec, the I2S
peripheral needs two clock sources (tx and rx), while connection with an
external codec commonly needs only one. Since v5.16 there is a driver for
the I2S in sound/soc/rockchip/rockchip_i2s_tdm.c, but it does not correctly
handle receiving those two clocks via the .set_sysclk op. Patch 1 fixes
that.

Patches 2-4 adds the codec driver along with the bindings and a new helper
macro.

Patches 5-6 add to the SoC DT file two I2S controllers (those which are
internally connected to the internal codec) and the codec itself.

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changed in v2:
 - largely rewrote the codec driver to use DAPM and lots of improvements
   and cleanups   
 - removed the RK3308 audio card and related patches, will be sent later
 - various other changes, listed per-patch

---
Luca Ceresoli (6):
      ASoC: rockchip: i2s-tdm: Fix clk_id usage in .set_sysclk()
      ASoC: dt-bindings: Add Rockchip RK3308 internal audio codec
      ASoC: core: add SOC_DOUBLE_RANGE_TLV() helper macro
      ASoC: codecs: Add RK3308 internal audio codec driver
      arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
      arm64: dts: rockchip: add the internal audio codec

 .../bindings/sound/rockchip,rk3308-codec.yaml      |   98 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |   68 ++
 include/sound/soc.h                                |   12 +
 sound/soc/codecs/Kconfig                           |   11 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/rk3308_codec.c                    | 1012 ++++++++++++++++++++
 sound/soc/codecs/rk3308_codec.h                    |  593 ++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.c              |   22 +-
 9 files changed, 1819 insertions(+), 6 deletions(-)
---
base-commit: f89a0253ea1f519e6866689f0e83857ca276a2e9
change-id: 20231219-rk3308-audio-codec-a5558ba8949d

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


