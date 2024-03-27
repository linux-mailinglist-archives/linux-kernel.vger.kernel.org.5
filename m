Return-Path: <linux-kernel+bounces-121380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38188E737
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B677E2C8E00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82E15B10F;
	Wed, 27 Mar 2024 13:41:23 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213413E6A7;
	Wed, 27 Mar 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546882; cv=none; b=D8FI8YPwA6eb0eDS4KxlXck6C88aZgMN4ikv9dsXU+zvMtjk8kwLFbj8v60b0WGOW5D6hHWLPUm5xT89Sjx7tI98oMEZMtC0Aqa0rtjQM2WzDsYjnc6E044vOyLdR4wb7FL01Td4kOjRTaTZO3PBqQhYAZ2WfOOWb0s+UMmdh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546882; c=relaxed/simple;
	bh=/S4IWm1bOUDdQzjRcd0RwcMn1ixl8bXGZC9Ys5RBy54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qqJ23E7eYdJM+7aVlCTGftqKqssneE271Xku2OgZshvCV7a+UQjjO3NHVCgzn6/CIqqqMB2lX0mM92v/a8boS2BTe0w8OxnS//nhBQR/I3YMoUNmSr4NYtV64P9rnsRTKBRlsfzx/veeM8TkEPhXYdyXBG92J+MB/Jb3XxGArD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id E969D101AF33; Wed, 27 Mar 2024 14:41:16 +0100 (CET)
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
Subject: [PATCH v2 0/2] Enable JPEG encoding on rk3588
Date: Wed, 27 Mar 2024 14:41:10 +0100
Message-ID: <20240327134115.424846-1-linkmauve@linkmauve.fr>
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

Changes since v1:
- Dropped patches 1 and 4.
- Use the proper compatible form, since this device should be fully
  compatible with the VEPU of rk356x.
- Describe where the VEPU121 name comes from, and list other encoders
  and decoders present in this SoC.
- Properly test the device tree changes, I previously couldn’t since I
  was using a too recent version of python-jsonschema…

Emmanuel Gil Peyrot (2):
  media: dt-binding: media: Document rk3588’s VEPU121
  arm64: dts: rockchip: Add VEPU121 to rk3588

 .../bindings/media/rockchip,rk3568-vepu.yaml  |  8 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 80 +++++++++++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.44.0


