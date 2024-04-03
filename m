Return-Path: <linux-kernel+bounces-130042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4B897375
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9181F21F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B114B098;
	Wed,  3 Apr 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="xOPStgyr"
Received: from mail-108-mta239.mxroute.com (mail-108-mta239.mxroute.com [136.175.108.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C358149DFD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156850; cv=none; b=cxWXg2zeu3CG1g3p/9acdIlqHWwPD1XDhp/gji7GMcD20fQtHe/huJUJhTBaMVMrdBjnrl8CekQ+n1KSZCNpkxauiwP5RDbkBiB9U5/eeVQ2U9VlehGm3qxqQ1GIeg/Wa3iYWzUX5VbYpbRCOqgwvBw5/8UpJ9UxvTxHcn+jHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156850; c=relaxed/simple;
	bh=S3kpHO0g2xg+kIl0Dx1H7DWyFi2/EytItBP5x0iTg40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mPNWDb3lxpuXoTreRSl7y3DYVNjxbrGVgAYUD1sYsWnMMAAVZPzgxVSq6m0tLNpaJJco4QPjGmqdydZD+CSXr4cssPPWjBSkAYDzLukcgLNuUmzMUtgBKAhSJv/Q7q8Sx10XkCvP+fqCm/s3an8BRpKtHE+FVYxJTBTf5W3Wj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=xOPStgyr; arc=none smtp.client-ip=136.175.108.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta239.mxroute.com (ZoneMTA) with ESMTPSA id 18ea48004f60003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 15:07:17 +0000
X-Zone-Loop: 737f6fb37d3afefa8874f0c6c537cd9efd5c94f7ccc9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WRuA32YXbuD3ex7baB9NU/bUpw7+cDp5UcFgRIWbhkg=; b=xOPStgyrtsjcNC5TcLXSPoSDvy
	naIw8uAfgqJCMXYuZvG+DpnXTblU1bvntuIoRvU41p7ocpqhaLaApSBwlBUKE7/SrahoCc9+xkBQ4
	QbEma0uhAiwiJiZGU1HijPzrzicIz6OI8NQ532VsBRYM10VoMwekxPdUxOL6rPpmpQa3tlZAEGKI9
	zn4g+uijgAdsr7p4QvyZBcE0eijJQA0/OWnwW/VhpwqFr8ex1IO6z1t7jSwyJP+h15zAxNuTdvwlv
	VVhGk5wrfQtjkqW1pWoU6X8d21s3LP8PfdmuO8THfTcuPvlc9I0q++ilsA4qzGunJEa7KiY3wsW4x
	5tbKBmbQ==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v3 00/25] imx258 improvement series 
Date: Wed,  3 Apr 2024 09:03:29 -0600
Message-ID: <20240403150355.189229-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luis Garcia <git@luigi311.com>

v3 Luis Garcia

- Add Use v4l2_link_freq_to_bitmap helper patch per Sakari Ailus
- Separate dt-bindings for powerdown per Rob Herring
- Fix dt-bindings for imx258.yaml
- Fix sign offs per Dang Huynh 
- Fix versioning per Conor Dooley and Kieran Bingham
- Use scripts to validate and fix patches
- Implemented feedback from Sakari Ailus
  - media: i2c: imx258: Add support for 24MHz clock
  - media: i2c: imx258: Add support for running on 2 CSI data lanes

- Implemented feedback from Rob Herring
  - dt-bindings: media: imx258: Add alternate compatible strings



v2 Luis Garcia

- Add use macros patch 
- Add support for powerdown gpio patch
- Add support for reset gpio patch
- Dropped Add support for long exposure modes patch
- Implemented feedback from Jacopo Mondi
  - media: i2c: imx258: Add regulator control
  - media: i2c: imx258: Add support for 24MHz clock
  - media: i2c: imx258: Add support for running on 2 CSI data lanes
  - media: i2c: imx258: Add get_selection for pixel array information
  - media: i2c: imx258: Issue reset before starting streaming
  - media: i2c: imx258: Set pixel_rate range to the same as the value
  - dt-bindings: media: imx258: Add alternate compatible strings
  - media: i2c: imx258: Change register settings for variants of the sensor
  - media: i2c: imx258: Make HFLIP and VFLIP controls writable

This adds a few more patches and drops one. The long exposure mode patch
was dropped due to the bug that Jacopo found. The powerdown and reset gpio
patches were added as that fixes support for the Pinephone Pro, without
them the sensor doesn't initialize correctly.

Tested on a Pinephone Pro by forcing 24 mhz clock and was able to access 
all 3 resolutions. The two lower resolutions had some artifacts but that
is expected as more changes are required to fix them for the
Pinephone Pro specifically, kept all registers the same as Dave's original
patch since that works on dedicated imx258 hardware and the artifacts are
PPP specific so it shouldn't be a regression.



v1 Dave Stevenson

This is a set of patches for imx258 that allow it to work with alternate
clock frequencies, over either 2 or 4 lanes, and generally adding
flexibility to the driver.

Tested with an IMX258 module from Soho Enterprises that has a 24MHz
oscillator. Both 2 and 4 lane configurations work with correct link
frequencies and pixel rates.

Jacopo has tested on a PinePhone Pro which has an ~19.2MHz clock fed from
the SoC, He confirms that the two lower resolution modes work, but not the
full res mode. Comparing to the BSP it looks like they have some weird
clock configuration in the 4208x3120 mode (nominally 1224Mb/s/lane instead
of 1267). As it has never previously worked directly with the mainline
driver this isn't a regression but may indicate that there is a need for
support of additional link frequencies in the future.

The last patch that makes HFLIP and VFLIP configurable may be contentious
as I've retained the default configuration of inverted from the original
driver. I know this was discussed recently, but I can't recall the final
outcome.

I am relying on someone from Intel testing this out, as correcting the
cropping and supporting flips has changed the Bayer order. Seeing as this
is all above board in V4L2 terms I really hope that the layers above it
behave themselves.

Cheers
  Dave

Dave Stevenson (20):
  media: i2c: imx258: Remove unused defines
  media: i2c: imx258: Make image geometry meet sensor requirements
  media: i2c: imx258: Disable digital cropping on binned modes
  media: i2c: imx258: Remove redundant I2C writes.
  media: i2c: imx258: Add regulator control
  media: i2c: imx258: Make V4L2_CID_VBLANK configurable.
  media: i2c: imx258: Split out common registers from the mode based
    ones
  media: i2c: imx258: Add support for 24MHz clock
  media: i2c: imx258: Add support for running on 2 CSI data lanes
  media: i2c: imx258: Follow normal V4L2 behaviours for clipping
    exposure
  media: i2c: imx258: Add get_selection for pixel array information
  media: i2c: imx258: Allow configuration of clock lane behaviour
  media: i2c: imx258: Correct max FRM_LENGTH_LINES value
  media: i2c: imx258: Issue reset before starting streaming
  media: i2c: imx258: Set pixel_rate range to the same as the value
  media: i2c: imx258: Support faster pixel rate on binned modes
  dt-bindings: media: imx258: Rename to include vendor prefix
  dt-bindings: media: imx258: Add alternate compatible strings
  media: i2c: imx258: Change register settings for variants of the
    sensor
  media: i2c: imx258: Make HFLIP and VFLIP controls writable

Luis Garcia (5):
  drivers: media: i2c: imx258: Use macros
  dt-bindings: media: imx258: Add binding for powerdown-gpio
  drivers: media: i2c: imx258: Add support for powerdown gpio
  drivers: media: i2c: imx258: Add support for reset gpio
  media:i2c: imx258: Use v4l2_link_freq_to_bitmap helper

 .../i2c/{imx258.yaml => sony,imx258.yaml}     |   15 +-
 MAINTAINERS                                   |    2 +-
 drivers/media/i2c/imx258.c                    | 1156 +++++++++++------
 3 files changed, 753 insertions(+), 420 deletions(-)
 rename Documentation/devicetree/bindings/media/i2c/{imx258.yaml => sony,imx258.yaml} (86%)

-- 
2.42.0


