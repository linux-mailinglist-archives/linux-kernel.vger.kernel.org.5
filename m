Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF8789162
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjHYWFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjHYWFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:05:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12F8619B7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:05:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7A9D75;
        Fri, 25 Aug 2023 15:05:57 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8393F762;
        Fri, 25 Aug 2023 15:05:15 -0700 (PDT)
Date:   Fri, 25 Aug 2023 23:04:18 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Shengyu Qu <wiagn233@outlook.com>, martin.botka1@gmail.com,
        Matthew Croughan <matthew.croughan@nix.how>
Subject: Re: [PATCH] mfd: axp20x: Generalise handling without interrupts
Message-ID: <20230825230418.47c93fa5@slackpad.lan>
In-Reply-To: <20230817115529.GD986605@google.com>
References: <20230807133930.94309-1-andre.przywara@arm.com>
        <20230817115529.GD986605@google.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 12:55:29 +0100
Lee Jones <lee@kernel.org> wrote:

Hi Lee,

> On Mon, 07 Aug 2023, Andre Przywara wrote:
> 
> > At the moment we allow the AXP15060 and the AXP806 PMICs to omit the
> > interrupt line to the SoC, and we skip registering the PEK (power key)
> > driver in this case, since that crashes when no IRQ is described in the
> > DT node.
> > The IRQ pin potentially not being connected to anything does affect more
> > PMICs, though, and the PEK driver is not the only one requiring an
> > interrupt: at least the AC power supply driver crashes in a similar
> > fashion, for instance.
> > 
> > Generalise the handling of AXP MFD devices when the platform tables
> > describe no interrupt, by putting devices requiring an IRQ *last* in
> > the MFD cell array. We then can easily cut short the number of devices
> > to be registered in this case.
> > 
> > This patch just enables that for three PMIC models for now: the two
> > already handled, plus the AXP313a, for which we now have mulitple examples
> > of boards without the IRQ pin connected.
> > To stay consistent with the current behaviour, we still (try to) register
> > all devices for the other PMICs, even though this will probably crash
> > without an interrupt specified, if those problematic drivers are loaded.
> > But this new approach can now easily be extended to other PMICs with more
> > devices, should the need arise: currently all in-tree users are fine.
> > 
> > This fixes operation on the first boards using the AXP313a, which do not
> > bother to connect the PMIC's IRQ pin.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Reported-by: Shengyu Qu <wiagn233@outlook.com>
> > ---
> >  drivers/mfd/axp20x.c | 48 +++++++++++++++++---------------------------
> >  1 file changed, 18 insertions(+), 30 deletions(-)  
> 
> Relying on the ordering of static struct elements is fragile.
> 
> Please separate into new structs.

Well, I was hoping to avoid this churn, since the IRQ-less lists are
purely a subset of the original structs. At first I thought about some
filtering (marking IRQ-required cells somehow), but looking at the
current scope (just needed for three simple PMICs at the moment), I
found an easier solution, which is both simple (avoids specifying both
lists for *all* PMICs), but also flexible.
Will tests this and post ASAP.

Cheers,
Andre

> 
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index c03bc5cda080a..c9623604bf6c1 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -1031,12 +1031,12 @@ static const struct mfd_cell axp803_cells[] = {
> >  };
> >  
> >  static const struct mfd_cell axp806_self_working_cells[] = {
> > +	{	.name		= "axp20x-regulator" },
> >  	{
> >  		.name		= "axp221-pek",
> >  		.num_resources	= ARRAY_SIZE(axp806_pek_resources),
> >  		.resources	= axp806_pek_resources,
> >  	},
> > -	{	.name		= "axp20x-regulator" },
> >  };
> >  
> >  static const struct mfd_cell axp806_cells[] = {
> > @@ -1090,19 +1090,11 @@ static const struct mfd_cell axp813_cells[] = {
> >  };
> >  
> >  static const struct mfd_cell axp15060_cells[] = {
> > +	{	.name		= "axp20x-regulator", },
> >  	{
> >  		.name		= "axp221-pek",
> >  		.num_resources	= ARRAY_SIZE(axp15060_pek_resources),
> >  		.resources	= axp15060_pek_resources,
> > -	}, {
> > -		.name		= "axp20x-regulator",
> > -	},
> > -};
> > -
> > -/* For boards that don't have IRQ line connected to SOC. */
> > -static const struct mfd_cell axp_regulator_only_cells[] = {
> > -	{
> > -		.name		= "axp20x-regulator",
> >  	},
> >  };
> >  
> > @@ -1133,6 +1125,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  	struct device *dev = axp20x->dev;
> >  	const struct acpi_device_id *acpi_id;
> >  	const struct of_device_id *of_id;
> > +	int nr_cells_no_irq = 0;
> >  
> >  	if (dev->of_node) {
> >  		of_id = of_match_device(dev->driver->of_match_table, dev);
> > @@ -1191,6 +1184,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		break;
> >  	case AXP313A_ID:
> >  		axp20x->nr_cells = ARRAY_SIZE(axp313a_cells);
> > +		nr_cells_no_irq = 1;
> >  		axp20x->cells = axp313a_cells;
> >  		axp20x->regmap_cfg = &axp313a_regmap_config;
> >  		axp20x->regmap_irq_chip = &axp313a_regmap_irq_chip;
> > @@ -1207,14 +1201,14 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		 * if there is no interrupt line.
> >  		 */
> >  		if (of_property_read_bool(axp20x->dev->of_node,
> > -					  "x-powers,self-working-mode") &&
> > -		    axp20x->irq > 0) {
> > +					  "x-powers,self-working-mode")) {
> >  			axp20x->nr_cells = ARRAY_SIZE(axp806_self_working_cells);
> >  			axp20x->cells = axp806_self_working_cells;
> >  		} else {
> >  			axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
> >  			axp20x->cells = axp806_cells;
> >  		}
> > +		nr_cells_no_irq = 1;
> >  		axp20x->regmap_cfg = &axp806_regmap_config;
> >  		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
> >  		break;
> > @@ -1238,24 +1232,9 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
> >  		break;
> >  	case AXP15060_ID:
> > -		/*
> > -		 * Don't register the power key part if there is no interrupt
> > -		 * line.
> > -		 *
> > -		 * Since most use cases of AXP PMICs are Allwinner SOCs, board
> > -		 * designers follow Allwinner's reference design and connects
> > -		 * IRQ line to SOC, there's no need for those variants to deal
> > -		 * with cases that IRQ isn't connected. However, AXP15660 is
> > -		 * used by some other vendors' SOCs that didn't connect IRQ
> > -		 * line, we need to deal with this case.
> > -		 */
> > -		if (axp20x->irq > 0) {
> > -			axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
> > -			axp20x->cells = axp15060_cells;
> > -		} else {
> > -			axp20x->nr_cells = ARRAY_SIZE(axp_regulator_only_cells);
> > -			axp20x->cells = axp_regulator_only_cells;
> > -		}
> > +		axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
> > +		nr_cells_no_irq = 1;
> > +		axp20x->cells = axp15060_cells;
> >  		axp20x->regmap_cfg = &axp15060_regmap_config;
> >  		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
> >  		break;
> > @@ -1263,6 +1242,15 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
> >  		return -EINVAL;
> >  	}
> > +
> > +	/*
> > +	 * Skip registering some MFD cells if there is no interrupt
> > +	 * line, as IRQs might be required by some drivers.
> > +	 * Those components must be the last in the cell array.
> > +	 */
> > +	if (axp20x->irq <= 0)
> > +		axp20x->nr_cells -= nr_cells_no_irq;
> > +
> >  	dev_info(dev, "AXP20x variant %s found\n",
> >  		 axp20x_model_names[axp20x->variant]);
> >  
> > -- 
> > 2.25.1
> >   
> 

