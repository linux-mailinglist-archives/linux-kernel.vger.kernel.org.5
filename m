Return-Path: <linux-kernel+bounces-113413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39C888420
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0EE287F57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FE1A7049;
	Sun, 24 Mar 2024 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW+0COhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86C1A7030;
	Sun, 24 Mar 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320215; cv=none; b=nplpiB1iC4XdZ2IOJ6wY8Wj4ARCKBmfQrJi4CmPM157MbfSe1ZEX+3jnaTvXi1A3oET22WlVGvpjm1g2IvHQDbGx5YzjNAGBEzfhX9U9NfrROVoWp6qzLLnj13FjIGlOnSrNh8EhXXsjCN0Xi5gugfYLnQ3wJ6DlqZi7+mbwaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320215; c=relaxed/simple;
	bh=j0Fk3xen+y6Fjp8MaIWIF4jWLasG0U8KGYm4HDJ18Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RePXJLl/zuKBUmF73sQHZbOo1jPuJA3ggoMaEM6DIcMoIqplb3/hV/ba4/bBXc9UD31dOez5pS9V/4CUEt/uolxuk7yO9QUB113KrI+ETVLaVZ7T2Clklm4slAcvftDGg+AbaSRRj1JF5fR6+DGjHFCcm8i46xJBmfP4Ld51EyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW+0COhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ECAC433F1;
	Sun, 24 Mar 2024 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320215;
	bh=j0Fk3xen+y6Fjp8MaIWIF4jWLasG0U8KGYm4HDJ18Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mW+0COhCNXO0G5UJkEZH1ZENKtZhtuVA1ZMmV7I42orDdrw0UzMJZXGODG94nhODw
	 a70wHoxPiBFv1qstgI75k/12xSgGxI2z9juPUflxNJ3YByVnyTPM/RdbswRQH39fZ0
	 nXjsSRVDimvTctqQjVTL+6t5hqn4SSSDzcC9Qme4Ip3s55YvI79of+9uhLGSokphYX
	 aCw73lge4vjvhJF/QGMJijDB5Lz9hXnv6Bzb+q43yZBqV+OJqenVQbwlOxhoBebN89
	 FqVIONrciypZwlHqTWDfEKU1+L1boSI4tw05tQi+cNWnW+Oz5/0ukDtLk67k2HFgNF
	 wF+LisI5GQO/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 522/715] backlight: hx8357: Fix potential NULL pointer dereference
Date: Sun, 24 Mar 2024 18:31:41 -0400
Message-ID: <20240324223455.1342824-523-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b1ba8bcb2d1ffce11b308ce166c9cc28d989e3b9 ]

The "im" pins are optional. Add missing check in the hx8357_probe().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/642e1230-3358-4006-a17f-3f297897ae74@moroto.mountain
Fixes: 7d84a63a39b7 ("backlight: hx8357: Convert to agnostic GPIO API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240114143921.550736-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/hx8357.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index d7298376cf74d..bf18337ff0c2c 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -609,11 +609,13 @@ static int hx8357_probe(struct spi_device *spi)
 	lcd->im_pins = devm_gpiod_get_array_optional(dev, "im", GPIOD_OUT_LOW);
 	if (IS_ERR(lcd->im_pins))
 		return dev_err_probe(dev, PTR_ERR(lcd->im_pins), "failed to request im GPIOs\n");
-	if (lcd->im_pins->ndescs < HX8357_NUM_IM_PINS)
-		return dev_err_probe(dev, -EINVAL, "not enough im GPIOs\n");
+	if (lcd->im_pins) {
+		if (lcd->im_pins->ndescs < HX8357_NUM_IM_PINS)
+			return dev_err_probe(dev, -EINVAL, "not enough im GPIOs\n");
 
-	for (i = 0; i < HX8357_NUM_IM_PINS; i++)
-		gpiod_set_consumer_name(lcd->im_pins->desc[i], "im_pins");
+		for (i = 0; i < HX8357_NUM_IM_PINS; i++)
+			gpiod_set_consumer_name(lcd->im_pins->desc[i], "im_pins");
+	}
 
 	lcdev = devm_lcd_device_register(&spi->dev, "mxsfb", &spi->dev, lcd,
 					&hx8357_ops);
-- 
2.43.0


