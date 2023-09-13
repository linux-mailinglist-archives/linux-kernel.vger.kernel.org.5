Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3920379E9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbjIMNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241060AbjIMNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:45:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770419B1;
        Wed, 13 Sep 2023 06:45:12 -0700 (PDT)
Received: from ideasonboard.com (unknown [IPv6:2001:b07:5d2e:52c9:72c3:346:a663:c82d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94F0072E;
        Wed, 13 Sep 2023 15:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694612618;
        bh=1Utp4+wXedh3YwkwcOGvZuEmlvqMt4KuKWejkPVuL9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGNpFzcZluIVT/SGm+cu7SzzCm0XUa1er6ku4n1qpbQGJBkX0tA2Ae9jkV7Gdca4o
         zt5gAmNqbSWIY/MKzEA3ow5Lnk1d48kIjqynX/Z8C0HRfR8rGM9wm266YWHbOfnDnJ
         pkOeX4qzXTV+uUOXDUvIWWJGmnNyUNsMscNP2iLY=
Date:   Wed, 13 Sep 2023 15:45:07 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] media: mt9p031: Extend match support for OF tables
Message-ID: <l2uzd3oxclnaokvs2wkuobt27pg3dixrhc3dvp2ucwciczuhq4@6ruxrnyiyko4>
References: <20230910160126.70122-1-biju.das.jz@bp.renesas.com>
 <20230910160126.70122-2-biju.das.jz@bp.renesas.com>
 <tlaikk73c5gc6y3bk6evuwtlizletaws7tuc5nk36hz2adkydp@duv2tjpqnios>
 <OS0PR01MB59226056EAA42B93D123CFB586F2A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <spi52a754wa4ghwvfa6hkoqiz5rws27jlrdfnintx7dfm5ccqv@cngal3bh6eje>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <spi52a754wa4ghwvfa6hkoqiz5rws27jlrdfnintx7dfm5ccqv@cngal3bh6eje>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again

On Mon, Sep 11, 2023 at 11:25:03AM +0200, Jacopo Mondi wrote:
> Hi Biju
>
> On Mon, Sep 11, 2023 at 09:14:35AM +0000, Biju Das wrote:
> > Hi Jacopo Mondi,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH 1/2] media: mt9p031: Extend match support for OF tables
> > >
> > > Hi Biju
> > >
> > > On Sun, Sep 10, 2023 at 05:01:25PM +0100, Biju Das wrote:
> > > > The driver has an OF match table, still, it uses an ID lookup table
> > > > for retrieving match data. Currently, the driver is working on the
> > > > assumption that an I2C device registered via OF will always match a
> > > > legacy I2C device ID. The correct approach is to have an OF device ID
> > > > table using i2c_get_match_data() if the devices are registered via OF/ID.
> > > >
> > > > Unify the OF/ID table by using MEDIA_BUS_FMT as match data for both
> > > > these tables and replace the ID lookup table for the match data by
> > > > i2c_get_match_data() and simplifly probe() and mt9p031_init_cfg()
> > > >
> > > > Drop mt9p031_init_cfg as there is no user.
> > > >
> > > > While at it, remove the trailing comma in the terminator entry for the
> > > > OF table making code robust against (theoretical) misrebases or other
> > > > similar things where the new entry goes _after_ the termination
> > > > without the compiler noticing.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > >  drivers/media/i2c/mt9p031.c | 33 +++++++++++----------------------
> > > >  1 file changed, 11 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
> > > > index 348f1e1098fb..540cb519915c 100644
> > > > --- a/drivers/media/i2c/mt9p031.c
> > > > +++ b/drivers/media/i2c/mt9p031.c
> > > > @@ -112,11 +112,6 @@
> > > >  #define MT9P031_TEST_PATTERN_RED			0xa2
> > > >  #define MT9P031_TEST_PATTERN_BLUE			0xa3
> > > >
> > > > -enum mt9p031_model {
> > > > -	MT9P031_MODEL_COLOR,
> > > > -	MT9P031_MODEL_MONOCHROME,
> > > > -};
> > > > -
> > > >  struct mt9p031 {
> > > >  	struct v4l2_subdev subdev;
> > > >  	struct media_pad pad;
> > > > @@ -129,7 +124,7 @@ struct mt9p031 {
> > > >  	struct clk *clk;
> > > >  	struct regulator_bulk_data regulators[3];
> > > >
> > > > -	enum mt9p031_model model;
> > > > +	u32 code;
> > > >  	struct aptina_pll pll;
> > > >  	unsigned int clk_div;
> > > >  	bool use_pll;
> > > > @@ -714,12 +709,7 @@ static int mt9p031_init_cfg(struct v4l2_subdev
> > > *subdev,
> > > >  	crop->height = MT9P031_WINDOW_HEIGHT_DEF;
> > > >
> > > >  	format = __mt9p031_get_pad_format(mt9p031, sd_state, 0, which);
> > > > -
> > > > -	if (mt9p031->model == MT9P031_MODEL_MONOCHROME)
> > > > -		format->code = MEDIA_BUS_FMT_Y12_1X12;
> > > > -	else
> > > > -		format->code = MEDIA_BUS_FMT_SGRBG12_1X12;
> > > > -
> > > > +	format->code = mt9p031->code;
> > > >  	format->width = MT9P031_WINDOW_WIDTH_DEF;
> > > >  	format->height = MT9P031_WINDOW_HEIGHT_DEF;
> > > >  	format->field = V4L2_FIELD_NONE;
> > > > @@ -1104,7 +1094,6 @@ mt9p031_get_pdata(struct i2c_client *client)
> > > >
> > > >  static int mt9p031_probe(struct i2c_client *client)  {
> > > > -	const struct i2c_device_id *did = i2c_client_get_device_id(client);
> > > >  	struct mt9p031_platform_data *pdata = mt9p031_get_pdata(client);
> > > >  	struct i2c_adapter *adapter = client->adapter;
> > > >  	struct mt9p031 *mt9p031;
> > > > @@ -1129,7 +1118,7 @@ static int mt9p031_probe(struct i2c_client *client)
> > > >  	mt9p031->pdata = pdata;
> > > >  	mt9p031->output_control	= MT9P031_OUTPUT_CONTROL_DEF;
> > > >  	mt9p031->mode2 = MT9P031_READ_MODE_2_ROW_BLC;
> > > > -	mt9p031->model = did->driver_data;
> > > > +	mt9p031->code = (uintptr_t)i2c_get_match_data(client);
> > > >
> > > >  	mt9p031->regulators[0].supply = "vdd";
> > > >  	mt9p031->regulators[1].supply = "vdd_io";
> > > > @@ -1226,19 +1215,19 @@ static void mt9p031_remove(struct i2c_client
> > > *client)
> > > >  }
> > > >
> > > >  static const struct i2c_device_id mt9p031_id[] = {
> > > > -	{ "mt9p006", MT9P031_MODEL_COLOR },
> > > > -	{ "mt9p031", MT9P031_MODEL_COLOR },
> > > > -	{ "mt9p031m", MT9P031_MODEL_MONOCHROME },
> > > > -	{ }
> > > > +	{ "mt9p006", MEDIA_BUS_FMT_SGRBG12_1X12 },
> > > > +	{ "mt9p031", MEDIA_BUS_FMT_SGRBG12_1X12 },
> > > > +	{ "mt9p031m", MEDIA_BUS_FMT_Y12_1X12 },
> > > > +	{ /* sentinel */ }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(i2c, mt9p031_id);
> > > >
> > > >  #if IS_ENABLED(CONFIG_OF)
> > > >  static const struct of_device_id mt9p031_of_match[] = {
> > > > -	{ .compatible = "aptina,mt9p006", },
> > > > -	{ .compatible = "aptina,mt9p031", },
> > > > -	{ .compatible = "aptina,mt9p031m", },
> > > > -	{ /* sentinel */ },
> > > > +	{ .compatible = "aptina,mt9p006", .data = (void
> > > *)MEDIA_BUS_FMT_SGRBG12_1X12 },
> > > > +	{ .compatible = "aptina,mt9p031", .data = (void
> > > *)MEDIA_BUS_FMT_SGRBG12_1X12 },
> > > > +	{ .compatible = "aptina,mt9p031m", .data = (void
> > > *)MEDIA_BUS_FMT_Y12_1X12 },
> > > > +	{ /* sentinel */ }
> > >
> > > I know it might sound not necessary, but isn't it better to wrap the
> > > format in some sort of per-model structure. It would avoid a few type
> > > casts too. Up to you though
> >
> > The problem with structure is, it will have one
> > variable entry. I got some feedback related to similar
> > patches not to add a single variable to structure
> > and use the value directly instead.
> >
>
> Ok then, a matter of preferences I think. Up to you, really.

Seems like I forgot to send a tag after your reply!

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

>
> Cheers
>   j
>
> > Cheers,
> > Biju
> >
> > >
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, mt9p031_of_match);
> > > >  #endif
> > > > --
> > > > 2.25.1
> > > >
