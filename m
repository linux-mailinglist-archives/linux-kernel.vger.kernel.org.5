Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B600780608
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbjHRG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358113AbjHRG4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66723AB2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C00862019
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FA6C433C8;
        Fri, 18 Aug 2023 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692341788;
        bh=1oGqmSEyDntjlRGycwCGFF20u6ulfIZHH0OCa4SL2bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ws/c86tdm/fRlUKLWh31OjThj4Vx+/Fmf57kgZOCRpZ9sDjH3wYIYW6Ux7Gr+cr5J
         hD3W6Mp9JVwPtzrmX6hhb8wkVGKxgRqIR0tihN5FaMnjx747itBCI0Om3RIKO9+ttG
         ja6DamX6iTryiAPk0tgHD6q7HLpjTcyG3nnFoQsT88zcRvXBmrjF1IKeRUgysNIzGT
         cUXXAALJJuHPJl6Y7OUSJ/K1iMmk5PRmGH9lgiAp/G16DYcXNz4Zkb/mSK6nNkO/go
         SCgG/xk2YIZtFBt/2bLVQOm/Y6o+YLFyKbT/TmaRJkRS93v+iigGU66G94kIxUx85G
         7E0thQfxwnViw==
Date:   Fri, 18 Aug 2023 07:56:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Werner <andre.werner@systec-electronic.com>
Cc:     werneazc@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: (tps65086): Read DEVICE ID register 1 from
 device
Message-ID: <20230818065624.GM986605@google.com>
References: <20230809101429.7885-1-andre.werner@systec-electronic.com>
 <20230817170223.GI986605@google.com>
 <c4df3803-854a-8c88-f174-18eb98fed195@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4df3803-854a-8c88-f174-18eb98fed195@systec-electronic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023, Andre Werner wrote:

> On Thu, 17 Aug 2023, Lee Jones wrote:
> 
> > On Wed, 09 Aug 2023, werneazc@gmail.com wrote:
> > 
> > > From: Andre Werner <andre.werner@systec-electronic.com>
> > > 
> > > This commit prepares a following commit for the regulator part of the MFD.
> > > The driver should support different device chips that differ in their
> > > register definitions, for instance to control LDOA1 and SWB2.
> > > So it is necessary to use a dedicated regulator description for a
> > > specific device variant. Thus, the content from DEVICEID Register 1 is
> > > used to choose a dedicated configuration between the different device
> > > variants.
> > > 
> > > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > > ---
> > >  drivers/mfd/tps65086.c       | 37 ++++++++++++++++++++++++++++++------
> > >  include/linux/mfd/tps65086.h | 27 ++++++++++++++++++++------
> > >  2 files changed, 52 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
> > > index 6a21000aad4a..38f8572c265e 100644
> > > --- a/drivers/mfd/tps65086.c
> > > +++ b/drivers/mfd/tps65086.c
> > > @@ -64,7 +64,7 @@ MODULE_DEVICE_TABLE(of, tps65086_of_match_table);
> > >  static int tps65086_probe(struct i2c_client *client)
> > >  {
> > >  	struct tps65086 *tps;
> > > -	unsigned int version;
> > > +	unsigned int version, id;
> > >  	int ret;
> > > 
> > >  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> > > @@ -81,16 +81,41 @@ static int tps65086_probe(struct i2c_client *client)
> > >  		return PTR_ERR(tps->regmap);
> > >  	}
> > > 
> > > -	ret = regmap_read(tps->regmap, TPS65086_DEVICEID, &version);
> > > +	ret = regmap_read(tps->regmap, TPS65086_DEVICEID1, &id);
> > >  	if (ret) {
> > > -		dev_err(tps->dev, "Failed to read revision register\n");
> > > +		dev_err(tps->dev, "Failed to read revision register 1\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* Store device ID to load regulator configuration that fit to IC variant */
> > > +	switch (id) {
> > > +	case TPS6508640_ID:
> > > +		tps->chip_id = TPS6508640;
> > 
> > Why not use the meaningful TPS6508640_ID for the chip_id instead of an
> > arbitrary enum?
> 
> In the regulator part for this MFD I use this enum ID to select the
> right configuration from an array. So the intention is using the enum as
> the index for this table. I can move this selection into the regulator
> part and store the meaningful TPS65086 IDs in the MFD data if you
> prefer?

That would make more sense for the reader I feel.  Thanks.

> > > +		break;
> > > +	case TPS65086401_ID:
> > > +		tps->chip_id = TPS65086401;
> > > +		break;
> > > +	case TPS6508641_ID:
> > > +		tps->chip_id = TPS6508641;
> > > +		break;
> > > +	case TPS65086470_ID:
> > > +		tps->chip_id = TPS65086470;
> > > +		break;
> > > +	default:
> > > +		dev_err(tps->dev, "Unknown device ID. Cannot determine regulator config.\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	ret = regmap_read(tps->regmap, TPS65086_DEVICEID2, &version);
> > > +	if (ret) {
> > > +		dev_err(tps->dev, "Failed to read revision register 2\n");
> > >  		return ret;
> > >  	}
> > > 
> > >  	dev_info(tps->dev, "Device: TPS65086%01lX, OTP: %c, Rev: %ld\n",
> > > -		 (version & TPS65086_DEVICEID_PART_MASK),
> > > -		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
> > > -		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
> > > +		 (version & TPS65086_DEVICEID2_PART_MASK),
> > > +		 (char)((version & TPS65086_DEVICEID2_OTP_MASK) >> 4) + 'A',
> > > +		 (version & TPS65086_DEVICEID2_REV_MASK) >> 6);
> > > 
> > >  	if (tps->irq > 0) {
> > >  		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
> > > diff --git a/include/linux/mfd/tps65086.h b/include/linux/mfd/tps65086.h
> > > index 16f87cccc003..88df344b38df 100644
> > > --- a/include/linux/mfd/tps65086.h
> > > +++ b/include/linux/mfd/tps65086.h
> > > @@ -13,8 +13,9 @@
> > >  #include <linux/regmap.h>
> > > 
> > >  /* List of registers for TPS65086 */
> > > -#define TPS65086_DEVICEID		0x01
> > > -#define TPS65086_IRQ			0x02
> > > +#define TPS65086_DEVICEID1		0x00
> > > +#define TPS65086_DEVICEID2		0x01
> > > +#define TPS65086_IRQ		0x02
> > >  #define TPS65086_IRQ_MASK		0x03
> > >  #define TPS65086_PMICSTAT		0x04
> > >  #define TPS65086_SHUTDNSRC		0x05
> > > @@ -75,16 +76,29 @@
> > >  #define TPS65086_IRQ_SHUTDN_MASK	BIT(3)
> > >  #define TPS65086_IRQ_FAULT_MASK		BIT(7)
> > > 
> > > -/* DEVICEID Register field definitions */
> > > -#define TPS65086_DEVICEID_PART_MASK	GENMASK(3, 0)
> > > -#define TPS65086_DEVICEID_OTP_MASK	GENMASK(5, 4)
> > > -#define TPS65086_DEVICEID_REV_MASK	GENMASK(7, 6)
> > > +/* DEVICEID1 Register field definitions */
> > > +#define TPS6508640_ID			0x00
> > > +#define TPS65086401_ID			0x01
> > > +#define TPS6508641_ID			0x10
> > > +#define TPS65086470_ID			0x70
> > > +
> > > +/* DEVICEID2 Register field definitions */
> > > +#define TPS65086_DEVICEID2_PART_MASK	GENMASK(3, 0)
> > > +#define TPS65086_DEVICEID2_OTP_MASK	GENMASK(5, 4)
> > > +#define TPS65086_DEVICEID2_REV_MASK	GENMASK(7, 6)
> > > 
> > >  /* VID Masks */
> > >  #define BUCK_VID_MASK			GENMASK(7, 1)
> > >  #define VDOA1_VID_MASK			GENMASK(4, 1)
> > >  #define VDOA23_VID_MASK			GENMASK(3, 0)
> > > 
> > > +enum tps65086_ids {
> > > +	TPS6508640,
> > > +	TPS65086401,
> > > +	TPS6508641,
> > > +	TPS65086470,
> > > +};
> > > +
> > >  /* Define the TPS65086 IRQ numbers */
> > >  enum tps65086_irqs {
> > >  	TPS65086_IRQ_DIETEMP,
> > > @@ -100,6 +114,7 @@ enum tps65086_irqs {
> > >  struct tps65086 {
> > >  	struct device *dev;
> > >  	struct regmap *regmap;
> > > +	unsigned int chip_id;
> > > 
> > >  	/* IRQ Data */
> > >  	int irq;
> > > --
> > > 2.41.0
> > > 
> > 
> > -- 
> > Lee Jones [李琼斯]
> > 
> 
> Regards,
> 
> André


-- 
Lee Jones [李琼斯]
