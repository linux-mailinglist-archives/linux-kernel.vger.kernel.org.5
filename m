Return-Path: <linux-kernel+bounces-76136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7985F35B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D548D284512
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2007636B15;
	Thu, 22 Feb 2024 08:44:33 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972C36AED;
	Thu, 22 Feb 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591472; cv=none; b=RJD8yOC/3wcUnLQyn9UHt0SiQXcJTB29AIuBhZb5rDaDMqfT2yNiARxX54ZGhceTCeN3tKm6KFXCeEtTA4Jeukt/18sA9nMc6eWC4nhU8mE1CwVnbF6yJjZeTGN5J5mvF2fhSzHpFxD2nN7kC5dl6L+2YVO/koBIoMQVxK6z1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591472; c=relaxed/simple;
	bh=aAHuEmErw6Xhwk48sQ2yXHjadNeRu84HgxsVgDkNpw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fE47ufrJJUTIh4R9MDGg3u/XdThXcFGRpYLZvfugiglYBvm1rhV9PDPfMh0wxkXTdO8ggHiNg4ThIiV4lI6SwKWx4zeKGtd4Qw71jmFMrla6YwoXaidbbMQ4oWc2uDYmnniC+HaHCaCMmcBALnnp/dKAz54ZC+XTZiuVHrv9SZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: xSdWhlzWQNfyCNiMvHcoX/EBWrRv49Ekw2KBJdYXwzUq61c2mhFMhdOSy0AV+QXomotupaWb7v
 LPe0QjzGuR8w==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 22 Feb 2024 14:13:16 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: khilman@kernel.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [RESEND PATCH v1 05/13] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Thu, 22 Feb 2024 14:13:09 +0530
Message-Id: <20240222084309.6008-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7hcysy6ho6.fsf@baylibre.com>
References: <7hcysy6ho6.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Kevin,
On Wed, 14 Feb 2024 10:10:17 -0800, Kevin wrote:
> Bhargav Raviprakash <bhargav.r@ltts.com> writes:
> 
> > Add support for TPS65224 PMIC in the TPS6594 driver as they share
> > significant functional overlap.
> >
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > ---
> >  drivers/mfd/tps6594-spi.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
> > index 5afb1736f..7ec66d31b 100644
> > --- a/drivers/mfd/tps6594-spi.c
> > +++ b/drivers/mfd/tps6594-spi.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * SPI access driver for TI TPS6594/TPS6593/LP8764 PMICs
> > + * SPI access driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
> >   *
> >   * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
> >   */
> > @@ -66,7 +66,7 @@ static int tps6594_spi_reg_write(void *context, unsigned int reg, unsigned int v
> >  	return spi_write(spi, buf, count);
> >  }
> >  
> > -static const struct regmap_config tps6594_spi_regmap_config = {
> > +static struct regmap_config tps6594_spi_regmap_config = {
> >  	.reg_bits = 16,
> >  	.val_bits = 8,
> >  	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
> > @@ -81,6 +81,7 @@ static const struct of_device_id tps6594_spi_of_match_table[] = {
> >  	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> >  	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> >  	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> > +	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
> > @@ -101,15 +102,18 @@ static int tps6594_spi_probe(struct spi_device *spi)
> >  	tps->reg = spi_get_chipselect(spi, 0);
> >  	tps->irq = spi->irq;
> >  
> > -	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
> > -	if (IS_ERR(tps->regmap))
> > -		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
> > -
> >  	match = of_match_device(tps6594_spi_of_match_table, dev);
> >  	if (!match)
> >  		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
> >  	tps->chip_id = (unsigned long)match->data;
> >  
> > +	if (tps->chip_id == TPS65224)
> > +		tps6594_spi_regmap_config.volatile_table = &tps65224_volatile_table;
> 
> Similar to my comment on the i2c series, but to be more specific:
> 
> Rather than use the .data pointer in the of_match_table as simply a
> chip_id, instead make that into a struct that can contain chip-specific
> values/pointers etc, and then each compatible can have a custom struct
> (if needed.)
> 
> This way, at probe/match time, all the chip-specific data is setup using
> that struct, so that at runtime, there doesn't need to be any "if
> (chip_id)" checking.
> 
> Kevin

Thanks for the feedback!
We will implement the same in the next version.

Regards,
Bhargav

