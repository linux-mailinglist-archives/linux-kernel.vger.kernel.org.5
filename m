Return-Path: <linux-kernel+bounces-95194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412EF874A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25442817E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76358839EB;
	Thu,  7 Mar 2024 09:14:38 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCB839F5;
	Thu,  7 Mar 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802878; cv=none; b=pQNL9eFoMFfZqyD954H7RwetzLX//3ZstMbCBaQ4QZS+1Csd7mukNlqrPXbfxyPUxQgxQvfX7pj3krMUd6L845PWObYHmT7Rwz8Q/zJtSPVJ4WzPvzd1DQo4TIn9LxY6McgAitw6rvGzcJhvg4sq41GEmK48WOB/eHLzpOjt1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802878; c=relaxed/simple;
	bh=GgPdsLh+LLVbt+yHYClc0oACft8tabX3zjgU9HP6rHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBCsqgWci3P3lpZZELkZQ6u++s53qQC4v0LCp92pc9x0xkd1GsdEdMT8L31yG4Gw8DylfHkFwNH0sdw1y6bhLhiINKExRiR834tl42ELIFsYfGO/+SNeZ4O5Qdy/Oqk8aYMq4AuIAVUvKoDVpJ1NRPTlpMSBIQTqPp6LUciLzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: JGxyyw0lc7IFuJCHQ3LYoxMFm0DAC7ho0mS6XnXtNk48t8PoXqA4Uiq2HE7CSOKgC9JrCS4p7G
 lSl8Dc4KL3BA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 07 Mar 2024 14:43:20 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: jpanis@baylibre.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: Re: [PATCH v2 08/14] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
Date: Thu,  7 Mar 2024 14:43:10 +0530
Message-Id: <20240307091310.170807-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8f09bc42-b85d-446f-bd9d-77155060a4b8@baylibre.com>
References: <8f09bc42-b85d-446f-bd9d-77155060a4b8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Mon, 26 Feb 2024 13:43:51 +0100, Julien Panis wrote:
> On 2/23/24 10:36, Bhargav Raviprakash wrote:
> > Add support for TPS65224 PFSM in the TPS6594 PFSM driver
> > as they share significant functionality.
> >
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > ---
> >   drivers/misc/tps6594-pfsm.c | 55 +++++++++++++++++++++++++++----------
> >   1 file changed, 40 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
> > index 88dcac814..4fa071093 100644
> > --- a/drivers/misc/tps6594-pfsm.c
> > +++ b/drivers/misc/tps6594-pfsm.c
> > @@ -1,6 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /*
> > - * PFSM (Pre-configurable Finite State Machine) driver for TI TPS6594/TPS6593/LP8764 PMICs
> > + * PFSM (Pre-configurable Finite State Machine) driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
> >    *
> >    * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
> >    */
> > @@ -34,15 +34,17 @@
> >   
> >   #define TPS6594_FILE_TO_PFSM(f) container_of((f)->private_data, struct tps6594_pfsm, miscdev)
> >   
> > -/**
> > +/*
> 
> Here it should be /** for the structure documentation, I think.
> Please check in kernel doc.
>

Thanks for pointing it out! Will fix it in the next version.

> [...]
> 
> > @@ -210,8 +230,12 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
> >   			return ret;
> >   
> >   		/* Modify NSLEEP1-2 bits */
> > -		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> > -					TPS6594_BIT_NSLEEP2B);
> > +		if (pfsm->chip_id == TPS65224)
> > +			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> > +						TPS6594_BIT_NSLEEP1B);
> > +		else
> > +			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> > +						TPS6594_BIT_NSLEEP2B);
> 
> Instead of this if/else, a ternary operator might do the trick here:
> regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
>                                pfsm->chip_id == TPS65224 ? TPS6594_BIT_NSLEEP1B : TPS6594_BIT_NSLEEP2B)
>
> Julien

Sure, this looks neat :-). We will use ternary operator here in the next version.
Thanks!

Regards,
Bhargav

