Return-Path: <linux-kernel+bounces-150256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB78A9C62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CAB23839
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4875168AE6;
	Thu, 18 Apr 2024 14:15:33 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364215F409;
	Thu, 18 Apr 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449733; cv=none; b=tb+FZE4XKXu8FlgyGLsR2a7Nn8+2+bdm6HatZqJ7+l+FeXCc4cvLokMqR8WLxpcx9pvMKLl4tUYCjMsKyirUdS8l4d7fUdKHZJjeMjCWp0rrJ6UIhzPx6JWzKl0uxiUY3RALG6T0kwcRIKhbAxMA/ZBgkD8lXZr2rWJqWedMClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449733; c=relaxed/simple;
	bh=AfVNwDYbzeFDLaM4p6iwnL35iuV7G6HpflaIZ8I/n7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JkuyUas6yi29yEwDd9zdQ5jMHHZ3VdDL6GxqHenD8AQL+heqXq5/V5GvUWa/TZ+MAwrENRtipqpjBppWJaWIOVHIq9kBEgkKX2DT/j35cTB36HpMmAIrlbGNQfGtE8nTq439DTOrZhEnxsb7FEY9ka1tGb8XBGC6oQeofUd6E4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 53F9810D1B03; Thu, 18 Apr 2024 16:15:14 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: linux-kernel@vger.kernel.org
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 0/2] Enable JPEG encoding on rk3588
Date: Thu, 18 Apr 2024 16:15:04 +0200
Message-ID: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only the JPEG encoder is available for now, although there are patches
for the undocumented VP8 encoder floating around[0].

This has been tested on a rock-5b, resulting in four /dev/video*
encoders.  The userspace program I’ve been using to test them is
Onix[1], using the jpeg-encoder example, it will pick one of these four
at random (but displays the one it picked):
% ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
% jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg

[0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=789885
[1] https://crates.io/crates/onix

Changes since v3:
- Keep all the previous tags, sorry I forgot to do that in the previous
  version.
- Remove an extra media: in the first patch.

Changes since v2:
- Only expose a single VEPU121, since the driver doesn’t yet support
  exposing them all as a single video node to userspace.

Changes since v1:
- Dropped patches 1 and 4.
- Use the proper compatible form, since this device should be fully
  compatible with the VEPU of rk356x.
- Describe where the VEPU121 name comes from, and list other encoders
  and decoders present in this SoC.
- Properly test the device tree changes, I previously couldn’t since I
  was using a too recent version of python-jsonschema…

Emmanuel Gil Peyrot (2):
  media: dt-binding: Document rk3588’s VEPU121
  arm64: dts: rockchip: Add one VEPU121 to rk3588

 .../bindings/media/rockchip,rk3568-vepu.yaml  |  8 +++--
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 29 +++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.44.0


