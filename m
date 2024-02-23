Return-Path: <linux-kernel+bounces-78319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E538611D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445DC1C20C90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB127E79D;
	Fri, 23 Feb 2024 12:46:13 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34D73F0A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692373; cv=none; b=Vr7zbccQ3V0z4yvUPUMadTEOy6ubhiMSrANB1XNWmLcN00Uqfz+Jkp0AbSjQ37SxRCtlk0oDuVZfCmCeRvF0ioMsrSIDxK3edtKzKh3bhhzgHsxKr6FX/S7PNw67lQGnzG/MjZdamY2tvP0JsDUlNa7GQB5MNKZj4CgItHeXpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692373; c=relaxed/simple;
	bh=oZmKnh899g7Ve8UaEWRKSGcDpbmmpXhJYkdPoVN2API=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbcL5wScLR+IblVew64HZlZm7qUmjus8g690XLqbkneeVmo+IdxQ+feYS1LKZNo4XhYeo6yWrHvRVbY39UP3Q0ttxw4+FzrfmMXEIiG6lj6TIdc7HKS87JqTrSDIvQuFqxwB6szolWm9m4TtLSc5fDPDlVIM9FBnxXmfP9trejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th8rT5Sg8zMrtd6;
	Fri, 23 Feb 2024 13:46:01 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th8rS6knNzwNb;
	Fri, 23 Feb 2024 13:46:00 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 23 Feb 2024 13:45:21 +0100
Subject: [PATCH 1/3] iio: adc: rockchip_saradc: fix bitmask for channels on
 SARADCv2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-saradcv2-chan-mask-v1-1-84b06a0f623a@theobroma-systems.com>
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
In-Reply-To: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The SARADCv2 on RK3588 (the only SoC currently supported that has an
SARADCv2) selects the channel through the channel_sel bitfield which is
the 4 lowest bits, therefore the mask should be GENMASK(3, 0) and not
GENMASK(15, 0).

Fixes: 757953f8ec69 ("iio: adc: rockchip_saradc: Add support for RK3588")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index dd94667a623b..2da8d6f3241a 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -52,7 +52,7 @@
 #define SARADC2_START			BIT(4)
 #define SARADC2_SINGLE_MODE		BIT(5)
 
-#define SARADC2_CONV_CHANNELS GENMASK(15, 0)
+#define SARADC2_CONV_CHANNELS GENMASK(3, 0)
 
 struct rockchip_saradc;
 

-- 
2.43.2


