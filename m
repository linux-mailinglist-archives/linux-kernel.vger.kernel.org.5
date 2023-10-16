Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5653C7CA852
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjJPMq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjJPMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:46:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13425101
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:46:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMyu-0002vE-Om; Mon, 16 Oct 2023 14:46:00 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMys-0025WN-VP; Mon, 16 Oct 2023 14:45:58 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMys-00EkA2-SI; Mon, 16 Oct 2023 14:45:58 +0200
Date:   Mon, 16 Oct 2023 14:45:58 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v7 07/26] PM / devfreq: rockchip-dfi: introduce channel
 mask
Message-ID: <20231016124558.GL235829@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-8-s.hauer@pengutronix.de>
 <859b0091-e361-6060-2977-4aba13af418a@kernel.org>
 <20231016112216.GY3359458@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016112216.GY3359458@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:22:16PM +0200, Sascha Hauer wrote:
> On Sat, Oct 07, 2023 at 02:21:10AM +0900, Chanwoo Choi wrote:
> > Hi,
> > 
> > On 23. 7. 4. 18:32, Sascha Hauer wrote:
> > > Different Rockchip SoC variants have a different number of channels.
> > > Introduce a channel mask to make the number of channels configurable
> > > from SoC initialization code.
> > > 
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/devfreq/event/rockchip-dfi.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> > > index 126bb744645b6..82de24a027579 100644
> > > --- a/drivers/devfreq/event/rockchip-dfi.c
> > > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > > @@ -18,10 +18,11 @@
> > >  #include <linux/list.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/bits.h>
> > >  
> > >  #include <soc/rockchip/rk3399_grf.h>
> > >  
> > > -#define RK3399_DMC_NUM_CH	2
> > > +#define DMC_MAX_CHANNELS	2
> > >  
> > >  /* DDRMON_CTRL */
> > >  #define DDRMON_CTRL	0x04
> > > @@ -44,7 +45,7 @@ struct dmc_count_channel {
> > >  };
> > >  
> > >  struct dmc_count {
> > > -	struct dmc_count_channel c[RK3399_DMC_NUM_CH];
> > > +	struct dmc_count_channel c[DMC_MAX_CHANNELS];
> > >  };
> > >  
> > >  /*
> > > @@ -61,6 +62,7 @@ struct rockchip_dfi {
> > >  	struct regmap *regmap_pmu;
> > >  	struct clk *clk;
> > >  	u32 ddr_type;
> > > +	unsigned int channel_mask;
> > >  };
> > >  
> > >  static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
> > > @@ -95,7 +97,9 @@ static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dm
> > >  	u32 i;
> > >  	void __iomem *dfi_regs = dfi->regs;
> > >  
> > > -	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> > > +	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
> > > +		if (!(dfi->channel_mask & BIT(i)))
> > > +			continue;
> > >  		count->c[i].access = readl_relaxed(dfi_regs +
> > >  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> > >  		count->c[i].total = readl_relaxed(dfi_regs +
> > > @@ -145,9 +149,14 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
> > >  	rockchip_dfi_read_counters(edev, &count);
> > >  
> > >  	/* We can only report one channel, so find the busiest one */
> > > -	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> > > -		u32 a = count.c[i].access - last->c[i].access;
> > > -		u32 t = count.c[i].total - last->c[i].total;
> > > +	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
> > 
> > Instead of DMC_MAX_CHANNELS defintion,
> > you can initialize the max channel in each rkXXXX_dfi_init() like 'dfi->channel_count'.
> > It reduces the unnecessary loop by initializing the proper max channel.
> 
> That is not easily possible. Some SoCs, eg the RK3588 have four
> channels, but not all channels are necessarily enabled it also
> might not be the first channels that are enabled. On a RK3588
> the channel mask might for example be 0b0101.

Nah, forget this comment. Of course I can initialize a variable with a
maximum value of channels that could be available on this SoC and only
iterate over these. Will do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
