Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2C7CA7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjJPMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:04:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B7ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:04:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMK9-0004KA-HN; Mon, 16 Oct 2023 14:03:53 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMK7-0024Zf-Fz; Mon, 16 Oct 2023 14:03:51 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMK7-00EjhX-D1; Mon, 16 Oct 2023 14:03:51 +0200
Date:   Mon, 16 Oct 2023 14:03:51 +0200
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
Subject: Re: [PATCH v7 09/26] PM / devfreq: rockchip-dfi: Clean up DDR type
 register defines
Message-ID: <20231016120351.GA3359458@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-10-s.hauer@pengutronix.de>
 <1eaa8d5b-af6b-71bb-df7a-d438b483f5bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eaa8d5b-af6b-71bb-df7a-d438b483f5bb@kernel.org>
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

On Sat, Oct 07, 2023 at 04:11:22AM +0900, Chanwoo Choi wrote:
> On 23. 7. 4. 18:32, Sascha Hauer wrote:
> > Use the HIWORD_UPDATE() define known from other rockchip drivers to
> > make the defines look less odd to the readers who've seen other
> > rockchip drivers.
> > 
> > The HIWORD registers have their functional bits in the lower 16 bits
> > whereas the upper 16 bits contain a mask. Only the functional bits that
> > have the corresponding mask bit set are modified during a write. Although
> > the register writes look different, the end result should be the same,
> > at least there's no functional change intended with this patch.
> > 
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/devfreq/event/rockchip-dfi.c | 33 ++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> > index 6bccb6fbcfc0c..6b3ef97b3be09 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -26,15 +26,19 @@
> >  
> >  #define DMC_MAX_CHANNELS	2
> >  
> > +#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
> > +
> >  /* DDRMON_CTRL */
> >  #define DDRMON_CTRL	0x04
> > -#define CLR_DDRMON_CTRL	(0x1f0000 << 0)
> > -#define LPDDR4_EN	(0x10001 << 4)
> > -#define HARDWARE_EN	(0x10001 << 3)
> > -#define LPDDR3_EN	(0x10001 << 2)
> > -#define SOFTWARE_EN	(0x10001 << 1)
> > -#define SOFTWARE_DIS	(0x10000 << 1)
> > -#define TIME_CNT_EN	(0x10001 << 0)
> > +#define DDRMON_CTRL_DDR4		BIT(5)
> > +#define DDRMON_CTRL_LPDDR4		BIT(4)
> > +#define DDRMON_CTRL_HARDWARE_EN		BIT(3)
> > +#define DDRMON_CTRL_LPDDR23		BIT(2)
> > +#define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
> > +#define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
> > +#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_DDR4 | \
> > +					 DDRMON_CTRL_LPDDR4 | \
> > +					 DDRMON_CTRL_LPDDR23)
> >  
> >  #define DDRMON_CH0_COUNT_NUM		0x28
> >  #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
> > @@ -73,16 +77,20 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
> >  	void __iomem *dfi_regs = dfi->regs;
> >  
> >  	/* clear DDRMON_CTRL setting */
> > -	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
> > +	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_SOFTWARE_EN |
> > +		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
> 
> You mentioned that there are no behavior changes even if the different value is written.
> But, it looks strange. Could you please explain more detailed about it?

Many registers on Rockchip SoCs are effectively only 16 bits wide. The
lower 16 bits are the functional bits. The upper 16 bits contain a mask
value. The lower 16 bits are only modified when the coresponding bit in
the upper 16bits is set.

For example writing 0x0001dead has the same effect as writing
0x00010001: The lower bit is set, the remaining are unchanged due to the
mask value being 0.

> 
> 
> CLR_DDRMON_CTRL is 0x1f0000

This clears the lower 5 bits.

> vs.
> HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN) = (0 | (BIT(0)|BIT(1)|BIT(3))<<16) = 0xb0000

This clears BIT(0), BIT(1) and BIT(3), so it clears:

DDRMON_CTRL_TIMER_CNT_EN, DDRMON_CTRL_SOFTWARE_EN and DDRMON_CTRL_HARDWARE_EN.

In fact it doesn't clear DDRMON_CTRL_LPDDR23 and DDRMON_CTRL_LPDDR4 like
the operation with CLR_DDRMON_CTRL does, but the LPDDR type bits are
handled below:

> 			
> >  
> >  	/* set ddr type to dfi */
> >  	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
> > -		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> > +		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK),
> > +			       dfi_regs + DDRMON_CTRL);
> 
> LPDDR3_EN	(0x10001 << 2) = 0x40004

This sets BIT(2) aka DDRMON_CTRL_LPDDR23

> vs.
> HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK) = (BIT(2) | (BIT(5)|BIT(4)|BIT(2))<<16) = 0x340004

This sets BIT(2) and *clears* BIT(4) (DDRMON_CTRL_LPDDR4) and BIT(5)
(DDRMON_CTRL_DDR4). So effectively we no longer clear BIT(4) in the
first register access as we do with CLR_DDRMON_CTRL, but in the second
register access instead.

This also clears BIT(5) which was untouched previously, but this bit had
never been set by the driver, so should be 0 anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
