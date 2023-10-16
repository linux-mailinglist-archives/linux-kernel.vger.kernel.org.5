Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F27CA8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjJPNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjJPNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:11:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14417172D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:10:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsNMZ-0007X1-Dt; Mon, 16 Oct 2023 15:10:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qsNMX-0025bR-6v; Mon, 16 Oct 2023 15:10:25 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsNMX-00EkKQ-3o; Mon, 16 Oct 2023 15:10:25 +0200
Date:   Mon, 16 Oct 2023 15:10:25 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Chanwoo Choi <chanwoo@kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
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
Subject: Re: [PATCH v7 08/26] PM / devfreq: rk3399_dmc,dfi: generalize
 DDRTYPE defines
Message-ID: <20231016131025.GD3359458@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-9-s.hauer@pengutronix.de>
 <f142ae65-0609-ccf2-5908-663cd2ecab73@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f142ae65-0609-ccf2-5908-663cd2ecab73@kernel.org>
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

Heiko,

On Sat, Oct 07, 2023 at 02:43:04AM +0900, Chanwoo Choi wrote:
> On 23. 7. 4. 18:32, Sascha Hauer wrote:
> > The DDRTYPE defines are named to be RK3399 specific, but they can be
> > used for other Rockchip SoCs as well, so replace the RK3399_PMUGRF_
> > prefix with ROCKCHIP_. They are defined in a SoC specific header
> > file, so when generalizing the prefix also move the new defines to
> > a SoC agnostic header file. While at it use GENMASK to define the
> > DDRTYPE bitfield and give it a name including the full register name.
> > 
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---

[...]

> > +	ROCKCHIP_DDRTYPE_LPDDR2	= 5,
> > +	ROCKCHIP_DDRTYPE_LPDDR3	= 6,
> > +	ROCKCHIP_DDRTYPE_LPDDR4	= 7,
> > +};
> > +
> > +#endif /* __SOC_ROCKCHIP_GRF_H */
> 
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch must require Ack of rockchip Maintainer (Heiko Stuebner)
> because of include/soc/rockchip.

Could you provide your Acked-by: for this patch?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
