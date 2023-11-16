Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCBB7EDC52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjKPHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:50:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26721120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:50:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r3X8l-0007e8-Pq; Thu, 16 Nov 2023 08:50:19 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1r3X8h-009P0C-AH; Thu, 16 Nov 2023 08:50:15 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r3X8h-002J9d-7Q; Thu, 16 Nov 2023 08:50:15 +0100
Date:   Thu, 16 Nov 2023 08:50:15 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     Andy Yan <andyshrk@163.com>, heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
Subject: Re: [PATCH 09/11] drm/rockchip: vop2: Add support for rk3588
Message-ID: <20231116075015.GG3359458@pengutronix.de>
References: <20231114112534.1770731-1-andyshrk@163.com>
 <20231114112855.1771372-1-andyshrk@163.com>
 <20231115090823.GY3359458@pengutronix.de>
 <229557d7-beec-44e0-9ee6-4a962b33ec79@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <229557d7-beec-44e0-9ee6-4a962b33ec79@rock-chips.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:24:54PM +0800, Andy Yan wrote:
> > 	case ROCKCHIP_VOP2_EP_HDMI0:
> > 	case ROCKCHIP_VOP2_EP_HDMI1:
> > 		...
> > }
> > 
> > would look a bit better overall.
> > 
> > > +		/*
> > > +		 * K = 2: dclk_core = if_pixclk_rate > if_dclk_rate
> > > +		 * K = 1: dclk_core = hdmie_edp_dclk > if_pixclk_rate
> > > +		 */
> > > +		if (output_mode == ROCKCHIP_OUT_MODE_YUV420) {
> > > +			dclk_rate = dclk_rate >> 1;
> > > +			K = 2;
> > > +		}
> > > +
> > > +		if_pixclk_rate = (dclk_core_rate << 1) / K;
> > > +		if_dclk_rate = dclk_core_rate / K;
> > > +
> > > +		*if_pixclk_div = dclk_rate / if_pixclk_rate;
> > > +		*if_dclk_div = dclk_rate / if_dclk_rate;
> > Not sure if this will change with future extensions, but currently
> > *if_pixclk_div will always be 2 and *if_dclk_div will alway be 4,
> > so maybe better write it like this
> 
> 
> Yes, the calculation of *if_pixclk_div is always 2 and *if_dclk_div is always 4,
> 
> I think calculation formula can give us a clear explanation why is 2 or 4.
> 
> considering the great power of rk3588, i think it can calculate it very easy.

Sure it can. My concern is not the CPU time it takes to do that
equation, but more the readability of the code. For me as a reader it
might be more easily acceptable that both dividers have fixed values
than it is to understand the equation.

Your mileage may vary, I won't insist on this.

> 
> > 
> > 
> > > +		*dclk_core_div = dclk_rate / dclk_core_rate;
> > *dclk_core_div is calculated the same way for all cases. You could pull
> > this out of the if/else.
> Okay, will do.
> > 
> > > +	} else if (vop2_output_if_is_edp(id)) {
> > > +		/* edp_pixclk = edp_dclk > dclk_core */
> > > +		if_pixclk_rate = v_pixclk / K;
> > > +		if_dclk_rate = v_pixclk / K;
> > if_dclk_rate is unused here.
> 
> 
> It will be removed in next version.
> 
> > 
> > > +		dclk_rate = if_pixclk_rate * K;
> > > +		*dclk_core_div = dclk_rate / dclk_core_rate;
> > > +		*if_pixclk_div = dclk_rate / if_pixclk_rate;
> > > +		*if_dclk_div = *if_pixclk_div;
> > Both *if_pixclk_div and *if_dclk_div will always be 1.
> 
> Actually,  they will be the value of K here,  if it work at split mode(two
> 
> edp connect to one VP, one show the image for left half, one for right half,
> 
> a function like a dual channel mipi dsi).
> 
> I know it split mode is not supported by the current mainline, but i think keep

Ok.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
