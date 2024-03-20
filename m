Return-Path: <linux-kernel+bounces-108743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D86880F75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FF1B21398
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11863C68C;
	Wed, 20 Mar 2024 10:17:27 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92C3BBE3;
	Wed, 20 Mar 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929847; cv=none; b=Ij6Ph5sstfNlOMZREln0RX9Ns02y9BNTBmQd9Qd2+QDuo766XUjoPEt0TZsGB+ejETScaDww8TUbkyfMkpJ6MHqW3UN0wUEIAeM6R0dKwx99ol7ThcrJ8amwOZQwXAJyL1IiCud5/vagu8rv19jvjtGmyAk+EDGGHwNJJPqJPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929847; c=relaxed/simple;
	bh=KO/DTQF0MTDWkExPdXz8c7XPsBWPP2JWcChOvtx8zeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dW72SisthITu0QSZ1qTnPqIibr2UxnzD3UYoHBAooSnMwRvykef9CilW0DIGxiTF9HTB9Eo5Cc4vnuJnqwn4ZZ5XlBR8raoG44dHXIp+CNd/rCO/TgV0ts/IAn/4jXMzmVq4wm4B9iCx3VXWyWSrvKS3tfseAYBDB9sIFn5VYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: Fz53Zk0t0EsU7YNZvzfL2kRSkgKfcKXrLS1QbXWWHY8sp51KZim++lWWbrWyj7amxwc4ssHdYG
 FVjs7X2yBVtw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 20 Mar 2024 15:46:10 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: eblanc@baylibre.com
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
Subject: Re: [PATCH v3 09/11] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Wed, 20 Mar 2024 15:45:56 +0530
Message-Id: <20240320101556.464137-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CZTFR87IG7MI.11DN441APOPE3@baylibre.com>
References: <CZTFR87IG7MI.11DN441APOPE3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 14 Mar 2024 12:28:00 +0100, Esteban Blanc wrote:
> On Fri Mar 8, 2024 at 11:34 AM CET, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >
> > Add support for TPS65224 regulators (bucks and LDOs) to TPS6594 driver as
> > they have significant functional overlap. TPS65224 PMIC has 4 buck
> > regulators and 3 LDOs. BUCK12 can operate in dual phase.
> > The output voltages are configurable and are meant to supply power to the
> > main processor and other components.
> >
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > ---
> >  drivers/regulator/Kconfig             |   4 +-
> >  drivers/regulator/tps6594-regulator.c | 236 +++++++++++++++++++++++---
> >  2 files changed, 215 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
> > index b7f0c8779..37d76c483 100644
> > --- a/drivers/regulator/tps6594-regulator.c
> > +++ b/drivers/regulator/tps6594-regulator.c
> > @@ -412,14 +562,20 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
> >  	struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
> >  	struct tps6594_regulator_irq_type *irq_type;
> >  	u8 buck_configured[BUCK_NB] = { 0 };
> > +	u8 ldo_configured[LDO_NB] = { 0 };
> >  	u8 buck_multi[MULTI_PHASE_NB] = { 0 };
> >  	static const char * const multiphases[] = {"buck12", "buck123", "buck1234", "buck34"};
> 
> `multiphases` should prefixed like the new one.
> 

Sure! This will be fixed in the next version.

> > +	static const char * const tps65224_multiphases[] = {"buck12"};
> 
> > @@ -495,25 +660,30 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
> >  	if (!irq_data)
> >  		return -ENOMEM;
> >  
> > -	for (i = 0; i < MULTI_PHASE_NB; i++) {
> > +	for (i = 0; i < multi_phase_cnt; i++) {
> >  		if (buck_multi[i] == 0)
> >  			continue;
> >  
> > +		const struct regulator_desc *multi_regs = (tps->chip_id == TPS65224) ?
> > +							   tps65224_multi_regs :
> > +							   tps6594_multi_regs;
> 
> This should be declared at the top of the function.
> 
> >  		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
> > -		if (IS_ERR(rdev))
> > -			return dev_err_probe(tps->dev, PTR_ERR(rdev),
> > -					     "failed to register %s regulator\n",
> > -					     pdev->name);
> > +			if (IS_ERR(rdev))
> > +				return dev_err_probe(tps->dev, PTR_ERR(rdev),
> > +						     "failed to register %s regulator\n",
> > +						     pdev->name);
> 
> The indentation of the `if` looks odd. You should revert this.
> 

Sure, will fix this in the next version.

> > @@ -537,21 +707,34 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
> >  		if (buck_configured[i] == 1)
> >  			continue;
> >  
> > -		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
> > +		const struct regulator_desc *buck_cfg = (tps->chip_id == TPS65224) ?
> > +							 tps65224_buck_regs : buck_regs;
> 
> Same here, should be at the top of the function.
> 
> > -	/* LP8764 dosen't have LDO */
> > +	/* LP8764 doesn't have LDO */
> >  	if (tps->chip_id != LP8764) {
> > -		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
> > +		for (i = 0; i < LDO_NB; i++) {
> > +			if (ldo_configured[i] == 1)
> > +				continue;
> > +
> > +			struct tps6594_regulator_irq_type **ldos_irq_types =
> > +						(tps->chip_id == TPS65224) ?
> > +						tps65224_ldos_irq_types : tps6594_ldos_irq_types;
> > +
> > +			const struct regulator_desc *ldo_regs =
> > +						(tps->chip_id == TPS65224) ?
> > +						tps65224_ldo_regs : tps6594_ldo_regs;
> 
> Should be at the top of the function, please fix this in the whole file.

Thanks! In the next version will move declaration to start of the function.

> 
> Best regards,
> 
> -- 
> Esteban "Skallwar" Blanc
> BayLibre

Regards,
Bhargav

