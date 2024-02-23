Return-Path: <linux-kernel+bounces-78331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41770861201
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5CB3B233C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CFA7D408;
	Fri, 23 Feb 2024 12:54:19 +0000 (UTC)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13063104
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692858; cv=none; b=g3yD7FdnfGMzjdiiJgmPkty9dfGcY/ZgYJqGadyey57GGUo4cYCw8uHOLupOju6sHoT6XfGPBLN4bNd4Dexl77jwt1azjuzg/TxxR0bvkhTTbLUBvj5ctsYRvataqj1mpGJIbbNQ1Ax66K3jdGX8Vdq7G4193xGFuxnZIWPV9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692858; c=relaxed/simple;
	bh=G7JhRkmmJzhTv/nbROWOJ+QozMPIQrIGjBMDxlq8nVw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atxcb1tSY5SkkGvZuCHU5F2qVRso89kV8k1WZzkEkCJXnfyorGDZy+fHuenDgc46SAvaZfX6FHOhuAda3SQS3d7MkIed77p7vDZSKtgfoGVtfICz41bPzj5HUT5Ma/skJC3puh0MugYgggRowV3Zq68ZSUgyWtRlZZvRwOwu2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th8rS6rJ3z5mK;
	Fri, 23 Feb 2024 13:46:00 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th8rR5kDjzyKs;
	Fri, 23 Feb 2024 13:45:59 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/3] iio: adc: rockchip_saradc: fix bitmasking and remove
 custom logic for getting reset
Date: Fri, 23 Feb 2024 13:45:20 +0100
Message-Id: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGT2GUC/x2M2wpAUBAAf0X7bItlhV+RhxOLTS6drZOSf3d4n
 KaZG0y8ikGb3OAlqOmxR8jTBIbF7bOgjpGBMiozIkJz3o1DIPw0bs5W5KbgmuuKiSuI4ell0uu
 fdv3zvF0lV5dkAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

The mask for the channel selection is incorrect as it's specified to be
16b wide by is actually only 4.

Also, the 16 lower bits in the SARADC_CONV_CON register are write
protected. Whatever their value is can only be written to the hardware
block if their associated bit in the higher 16 bits is set. Considering
that the channel bitmask is 4b wide but that we can write e.g. 0 in
there, we shouldn't use the value shifted by 16 as a mask but rather the
bitmask for that value shifted by 16. This is currently NOT an issue
because the only SoC with SARADCv2 IP is the RK3588 which has a reset
defined in the SoC DTSI. When that is the case, the reset is asserted
before every channel conversion is started. This means the registers are
reset so effectively, we do not need to write zeros so the wrong mask
still works because where we should be writing zeroes, there are already
zeroes. However, let's fix this in case there comes a day there's an SoC
which doesn't require to reset the controller before every channel
conversion is started.

Lastly, let's use the appropriate function from the reset subsystem
for getting an optional exclusive reset instead of rolling out our own
logic.

Those three patches should not be changing any behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Quentin Schulz (3):
      iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2
      iio: adc: rockchip_saradc: use mask for write_enable bitfield
      iio: adc: rockchip_saradc: replace custom logic with devm_reset_control_get_optional_exclusive

 drivers/iio/adc/rockchip_saradc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-saradcv2-chan-mask-593585865256

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


