Return-Path: <linux-kernel+bounces-122758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BD88FCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C011C2EED2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7F7D07E;
	Thu, 28 Mar 2024 10:16:56 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02455C3C;
	Thu, 28 Mar 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621016; cv=none; b=C6+aG4LjHhUb5XPtf6aawhfeDgzQbORiWyiXGpEw6+ehUO/OuSnf64QABsH2ym8XGwZNHahFU6ArJ7oNHt5mn1/5WYSciR6vZd4pZT2pvsyLFxp8i8AhzaVODJh2ufA8QMc8d4VSN2kgQ7imipsUOk1HzcHcRQYv8FusGByHe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621016; c=relaxed/simple;
	bh=RCifofXQJmYOX/loLRJBDORorzU/xHKu1Zqk4In1r1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxdQ2CiwkXICxbtSGhTNJ9E1PhRyMEYpMywOqwa3EwkKk5/mf4Xs2oRZ5qpqXu9MJfmfuYF7f9Ws+lMevC8hvxTTWWFazNJ3Y4wfGpchzXKbp+SjFIIvZCl2Q0zbkdP6FJ08jKobezvdUF81nmEjsD7aMLEzbbHP516RW2ZQAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: siBrV/GRU4tROfmdsRhausV0kzp2F9d9mAAoWZ6PlIzZ7cVAbJCZlxQ6rHX9i7WN2G+WAPfj9D
 otBjLtVqty4A==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 28 Mar 2024 15:46:42 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: broonie@kernel.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	eblanc@baylibre.com,
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
Subject: Re: [PATCH v4 09/11] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Thu, 28 Mar 2024 15:46:31 +0530
Message-Id: <20240328101631.146291-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a3ec3c14-eed3-429d-b3f6-0764bcfb8dc4@sirena.org.uk>
References: <a3ec3c14-eed3-429d-b3f6-0764bcfb8dc4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Wed, 20 Mar 2024 16:38:20 +0000, Mark Brown wrote:
> On Wed, Mar 20, 2024 at 03:55:57PM +0530, Bhargav Raviprakash wrote:
> 
> > +static struct tps6594_regulator_irq_type tps65224_buck1_irq_types[] = {
> > +	{ TPS65224_IRQ_NAME_BUCK1_UVOV, "BUCK1", "voltage out of range",
> > +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> > +};
> 
> These all look like they should be _REGULATION_OUT given that the
> interrupt names are _UVOV which look like they could be either under or
> over voltage.
> 
> Otherwise this all looks good.

Thanks for the feedback! We will fix it in the next version.

Regards,
Bhargav

