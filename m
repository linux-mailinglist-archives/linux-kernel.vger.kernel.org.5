Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F51793043
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbjIEUrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbjIEUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:47:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2BC2113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:47:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 524A511FB;
        Tue,  5 Sep 2023 13:48:22 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 446B13F64C;
        Tue,  5 Sep 2023 13:47:43 -0700 (PDT)
Date:   Tue, 5 Sep 2023 21:46:42 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka1@gmail.com>,
        Matthew Croughan <matthew.croughan@nix.how>
Subject: Re: [PATCH v2] mfd: axp20x: Generalise handling without interrupt
Message-ID: <20230905214642.1127f7cf@slackpad.lan>
In-Reply-To: <22003475.EfDdHjke4D@archlinux>
References: <20230828213229.20332-1-andre.przywara@arm.com>
        <22003475.EfDdHjke4D@archlinux>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2023 22:28:10 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

> On Monday, August 28, 2023 11:32:29 PM CEST Andre Przywara wrote:
> > At the moment we allow the AXP15060 and the AXP806 PMICs to omit the
> > interrupt line to the SoC, and we skip registering the PEK (power key)
> > driver in this case, since that crashes when no IRQ is described in the
> > DT node.
> > The IRQ pin potentially not being connected to anything does affect more
> > PMICs, though, and the PEK driver is not the only one requiring an
> > interrupt: at least the AC power supply driver crashes in a similar
> > fashion.
> > 
> > Generalise the handling of AXP MFD devices when the platform tables
> > describe no interrupt, by allowing each device to specify an alternative
> > MFD list for this case. If no specific alternative is specified, we go
> > with the safe default of "just the regulators", which matches the current
> > situation.
> > 
> > This enables new devices using the AXP313a PMIC, but not connecting the
> > IRQ pin.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> > Changelog v2 .. v1:
> > - drop reordering approach, use separate cell lists
> > 
> >  drivers/mfd/axp20x.c | 44 ++++++++++++++++++++++++--------------------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index c03bc5cda080a..239e7f18956ae 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -1133,6 +1133,8 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  	struct device *dev = axp20x->dev;
> >  	const struct acpi_device_id *acpi_id;
> >  	const struct of_device_id *of_id;
> > +	const struct mfd_cell *cells_no_irq = NULL;
> > +	int nr_cells_no_irq = 0;
> > 
> >  	if (dev->of_node) {
> >  		of_id = of_match_device(dev->driver->of_match_table,   
> dev);
> > @@ -1207,14 +1209,15 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		 * if there is no interrupt line.
> >  		 */
> >  		if (of_property_read_bool(axp20x->dev->of_node,
> > -					  "x-powers,self-  
> working-mode") &&
> > -		    axp20x->irq > 0) {
> > +					  "x-powers,self-  
> working-mode")) {
> >  			axp20x->nr_cells =   
> ARRAY_SIZE(axp806_self_working_cells);
> >  			axp20x->cells = axp806_self_working_cells;
> >  		} else {
> >  			axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
> >  			axp20x->cells = axp806_cells;
> >  		}
> > +		nr_cells_no_irq = ARRAY_SIZE(axp806_cells);
> > +		cells_no_irq = axp806_cells;
> >  		axp20x->regmap_cfg = &axp806_regmap_config;
> >  		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
> >  		break;
> > @@ -1238,24 +1241,8 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
> >  		break;
> >  	case AXP15060_ID:
> > -		/*
> > -		 * Don't register the power key part if there is no   
> interrupt
> > -		 * line.
> > -		 *
> > -		 * Since most use cases of AXP PMICs are Allwinner   
> SOCs, board
> > -		 * designers follow Allwinner's reference design and   
> connects
> > -		 * IRQ line to SOC, there's no need for those variants   
> to deal
> > -		 * with cases that IRQ isn't connected. However,   
> AXP15660 is
> > -		 * used by some other vendors' SOCs that didn't connect   
> IRQ
> > -		 * line, we need to deal with this case.
> > -		 */
> > -		if (axp20x->irq > 0) {
> > -			axp20x->nr_cells =   
> ARRAY_SIZE(axp15060_cells);
> > -			axp20x->cells = axp15060_cells;
> > -		} else {
> > -			axp20x->nr_cells =   
> ARRAY_SIZE(axp_regulator_only_cells);
> > -			axp20x->cells = axp_regulator_only_cells;
> > -		}
> > +		axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
> > +		axp20x->cells = axp15060_cells;
> >  		axp20x->regmap_cfg = &axp15060_regmap_config;
> >  		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
> >  		break;
> > @@ -1263,6 +1250,23 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >  		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x-
> >variant);
> >  		return -EINVAL;
> >  	}
> > +
> > +	/*
> > +	 * Use an alternative cell array when no interrupt line is   
> connected,
> > +	 * since IRQs are required by some drivers.
> > +	 * The default is the safe "regulator-only", as this works fine   
> without
> > +	 * an interrupt specified.
> > +	 */
> > +	if (axp20x->irq <= 0) {
> > +		if (cells_no_irq) {
> > +			axp20x->nr_cells = nr_cells_no_irq;
> > +			axp20x->cells = cells_no_irq;
> > +		} else {
> > +			axp20x->nr_cells =   
> ARRAY_SIZE(axp_regulator_only_cells);
> > +			axp20x->cells = axp_regulator_only_cells;  
> 
> axp806_cells (old value for AXP806_ID without irq) and 
> axp_regulator_only_cells differs in id field. Is that an issue?

Yes, an annoying one, which led me to introduce the ability to let each
PMIC override this default. So the case AXP806_ID: above sets the local
variable cells_no_irq to axp806_cells, and the check above sees that it
has been changed from the NULL initialisation and uses that instead of
the default. At least that was my plan, let me know if I messed that
up somehow, or if it deserves more comments.

Cheers,
Andre

> 
> Best regards,
> Jernej
> 
> > +		}
> > +	}
> > +
> >  	dev_info(dev, "AXP20x variant %s found\n",
> >  		 axp20x_model_names[axp20x->variant]);  
> 
> 
> 
> 
> 

