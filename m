Return-Path: <linux-kernel+bounces-146701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07428A698B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45921B21DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D21292CF;
	Tue, 16 Apr 2024 11:23:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A76128396;
	Tue, 16 Apr 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266592; cv=none; b=Jg4vsstHDUkhpp7M1EGumffXYrgP4005rzzo4hHLurscgORRRY9CNDdFKuCNYMdf4WCODn2gWIosrmLmoApbU7gvh/g9zp/5/rF46u/WcjhqpEGLDpK4ODSP0eems+txicsSwl2m5VGx/gACGntKZwLmGlBj6nCGa78Ig5R8AVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266592; c=relaxed/simple;
	bh=Y3llxjIXmfW7rF8sJgQDYyWp+vAUQOKaIP1rcLgHknU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMrPqxhYjwLG9531j5F/AXA7cDhVmdcZInL5MTHvtpGPRcXdrlN54XOgQJB43SGNXAc8+5EifCvz6EYmtSPYz5q9nFoMdTVpnNm9n6Ga668DqTDOvv9Rjd9Ik8p9MPQPK2TmXRgqlbMGankC731XXliKJujDTUR2bItS8rtKebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 463A2339;
	Tue, 16 Apr 2024 04:23:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B96B3F738;
	Tue, 16 Apr 2024 04:23:08 -0700 (PDT)
Date: Tue, 16 Apr 2024 12:23:05 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: John Watts <contact@jookia.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Ryan
 Walklin <ryan@testtoast.com>, Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH 1/4] regulator: axp20x: AXP717: fix LDO supply rails and
 off-by-ones
Message-ID: <20240416122305.3ffc2bda@donnerap.manchester.arm.com>
In-Reply-To: <ZhuNCUnJri4hBOxx@titan>
References: <20240329235033.25309-1-andre.przywara@arm.com>
	<20240329235033.25309-2-andre.przywara@arm.com>
	<ZhuNCUnJri4hBOxx@titan>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 18:00:09 +1000
John Watts <contact@jookia.org> wrote:

Hi John,

many thanks for the detailed review (also on the other two patches), much
appreciated!

> On Fri, Mar 29, 2024 at 11:50:30PM +0000, Andre Przywara wrote:
> > The X-Powers AXP717 PMIC has separate input supply pins for each group
> > of LDOs, so they are not all using the same DCDC1 input, as described
> > currently.
> > 
> > Replace the "supply" member of each LDO description with the respective
> > group supply name, so that the supply dependencies can be correctly
> > described in the devicetree.
> > Also fix two off-by-ones in the regulator macros, after some double
> > checking the numbers against the datasheet.
> > 
> > Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> 
> Hi,
> 
> > ---
> >  drivers/regulator/axp20x-regulator.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> > index 34fcdd82b2eaa..3907606b091f6 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -140,7 +140,7 @@
> >  
> >  #define AXP717_DCDC1_NUM_VOLTAGES	88
> >  #define AXP717_DCDC2_NUM_VOLTAGES	107
> > -#define AXP717_DCDC3_NUM_VOLTAGES	104
> > +#define AXP717_DCDC3_NUM_VOLTAGES	103
> >  #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
> >  #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
> >  
> > @@ -766,7 +766,7 @@ static const struct linear_range axp717_dcdc1_ranges[] = {
> >  static const struct linear_range axp717_dcdc2_ranges[] = {
> >  	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
> >  	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> > -	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
> > +	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
> >  };  
> 
> I'm not entirely sure these are correct after reading the datasheet.
> 
> From what I can tell REGULATOR_LINEAR_RANGE is inclusive, so for DCDC1
> we have these ranges (we agree DCDC1 is correct, it is not affected by
> this patch):
> 
> #define AXP717_DCDC1_NUM_VOLTAGES	88
> static const struct linear_range axp717_dcdc1_ranges[] = {
> 	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
> 	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
> };
> 
> The datasheet says this for the register:
> 
> 0.5~1.2V,10mV/step,71steps
> 1.22~1.54V,20mV/step,17steps
> 0000000: 0.50V
> 0000001: 0.51V
> ...
> 1000110: 1.20V
> 1000111: 1.22V
> 1001000: 1.24V
> ...
> 1010111: 1.54V
> 1011000~1111111: Reserve
> 
> Converting to decimal:
> 
> 0: 0.50V (range 1 start)
> 1: 0.51V
> ...
> 70: 1.20V (range 1 end)
> 71: 1.22V (range 2 start)
> 72: 1.24V
> ...
> 87: 1.54V (range 2 end)
> 88 onwards: reserved
> 
> The maximum voltages are the last value plus one (to include voltage zero).
> 
> For DCDC2 after applying this patch we get:
> 
> #define AXP717_DCDC2_NUM_VOLTAGES	107
> static const struct linear_range axp717_dcdc2_ranges[] = {
> 	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
> 	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> 	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
> };
> 
> The datasheet marks the maximum value as 1101011: 3.40V, so 106 (the old
> value for range) seems correct, but the NUM_VOLTAGES seems like it
> should be bumped up to 108. I think you fixed the wrong thing here.

I see what you mean, though I actually looked at the number of steps
mentioned in the first part of the register description. Now
triple-checking this I came up with this table (generated by a spreadsheet
to minimise human error):
voltage	decimal	binary	
1600	88	1011000
1700	89	1011001
1800	90	1011010
1900	91	1011011
2000	92	1011100
2100	93	1011101
2200	94	1011110
2300	95	1011111
2400	96	1100000
2500	97	1100001
2600	98	1100010
2700	99	1100011
2800	100	1100100
2900	101	1100101
3000	102	1100110
3100	103	1100111
3200	104	1101000
3300	105	1101001
3400	106	1101010

Which means the final binary value in the datasheet is wrong, as 1101011
would mean 3.5V.
Also  1101010 = 106
     -1011000 = 88
=============
      0010010 = 18
and 18 * 100 + 1600 = 3400, right?

This *is* admittedly quite bonkers, especially since the representations
between the manual and the code are so different, but can you check that
this makes sense?

I discovered some other issue in the original patch (missed declaring the
range of IRQ acknowledge registers in the MFD part), so I will send a v2 of
this series soonish.

> For DCDC3 after applying this patch we get:
> 
> #define AXP717_DCDC3_NUM_VOLTAGES	103
> static const struct linear_range axp717_dcdc3_ranges[] = {
> 	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
> 	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
> };
> 
> The datasheet marks the maximum value as 1100110: 1.84V, which is 102.
> So this patch to correct the AXP717_DCDC3_NUM_VOLTAGES is correct here.

I agree ;-) thanks for checking!

Cheers,
Andre

> >  static const struct linear_range axp717_dcdc3_ranges[] = {
> > @@ -790,40 +790,40 @@ static const struct regulator_desc axp717_regulators[] = {
> >  	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
> >  		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
> >  		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> > -	AXP_DESC(AXP717, ALDO1, "aldo1", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
> >  		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
> > -	AXP_DESC(AXP717, ALDO2, "aldo2", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, ALDO2, "aldo2", "aldoin", 500, 3500, 100,
> >  		 AXP717_ALDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(1)),
> > -	AXP_DESC(AXP717, ALDO3, "aldo3", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, ALDO3, "aldo3", "aldoin", 500, 3500, 100,
> >  		 AXP717_ALDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(2)),
> > -	AXP_DESC(AXP717, ALDO4, "aldo4", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, ALDO4, "aldo4", "aldoin", 500, 3500, 100,
> >  		 AXP717_ALDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(3)),
> > -	AXP_DESC(AXP717, BLDO1, "bldo1", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, BLDO1, "bldo1", "bldoin", 500, 3500, 100,
> >  		 AXP717_BLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(4)),
> > -	AXP_DESC(AXP717, BLDO2, "bldo2", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, BLDO2, "bldo2", "bldoin", 500, 3500, 100,
> >  		 AXP717_BLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(5)),
> > -	AXP_DESC(AXP717, BLDO3, "bldo3", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, BLDO3, "bldo3", "bldoin", 500, 3500, 100,
> >  		 AXP717_BLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(6)),
> > -	AXP_DESC(AXP717, BLDO4, "bldo4", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, BLDO4, "bldo4", "bldoin", 500, 3500, 100,
> >  		 AXP717_BLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(7)),
> > -	AXP_DESC(AXP717, CLDO1, "cldo1", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, CLDO1, "cldo1", "cldoin", 500, 3500, 100,
> >  		 AXP717_CLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(0)),
> > -	AXP_DESC(AXP717, CLDO2, "cldo2", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, CLDO2, "cldo2", "cldoin", 500, 3500, 100,
> >  		 AXP717_CLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(1)),
> > -	AXP_DESC(AXP717, CLDO3, "cldo3", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, CLDO3, "cldo3", "cldoin", 500, 3500, 100,
> >  		 AXP717_CLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(2)),
> > -	AXP_DESC(AXP717, CLDO4, "cldo4", "vin1", 500, 3500, 100,
> > +	AXP_DESC(AXP717, CLDO4, "cldo4", "cldoin", 500, 3500, 100,
> >  		 AXP717_CLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
> >  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(3)),
> >  	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,
> > -- 
> > 2.35.8
> >   


