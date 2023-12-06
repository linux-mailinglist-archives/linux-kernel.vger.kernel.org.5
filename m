Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8658806DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378166AbjLFLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378049AbjLFLVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:21:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC9C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:21:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1rApxY-0001hA-I4; Wed, 06 Dec 2023 12:20:56 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1rApxV-00Dwmh-8D; Wed, 06 Dec 2023 12:20:53 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1rApxV-005XuA-5K; Wed, 06 Dec 2023 12:20:53 +0100
Date:   Wed, 6 Dec 2023 12:20:53 +0100
From:   Sascha Hauer <sha@pengutronix.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     Andy Yan <andyshrk@163.com>, heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
Subject: Re: [PATCH v3 12/14] drm/rockchip: vop2: Add debugfs support
Message-ID: <20231206112053.GA1318922@pengutronix.de>
References: <20231130122001.12474-1-andyshrk@163.com>
 <20231130122449.13432-1-andyshrk@163.com>
 <20231205091541.GV1057032@pengutronix.de>
 <593f1092-3f5b-42ab-bc6e-dbd0fc8fb8ba@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593f1092-3f5b-42ab-bc6e-dbd0fc8fb8ba@rock-chips.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 06:20:58PM +0800, Andy Yan wrote:
> Hi Sascha:
> 
> > > +	unsigned int n = vop2->data->regs_dump_size;
> > 
> > 'n' is used only once, it might be clearer just to use the value where
> > needed and drop the extra variable.
> 
> Okay, will do.
> > 
> > > +	unsigned int i;
> > > +
> > > +	drm_modeset_lock_all(drm_dev);
> > > +
> > > +	if (vop2->enable_count) {
> > > +		for (i = 0; i < n; i++) {
> > > +			dump = &vop2->data->regs_dump[i];
> > > +			vop2_regs_print(vop2, s, dump, false);
> > > +		}
> > > +	} else {
> > > +		seq_printf(s, "VOP disabled:\n");
> > 
> > There's nothing following after the ':', right? Then this should be
> > "VOP: disabled\n" or without the colon at all.
> 
> the colon will be droped in next versin.
> 
> > 
> > > +	}
> > > +	drm_modeset_unlock_all(drm_dev);
> > 
> > This code is repeated in vop2_active_regs_show() below. Maybe factor
> > this out to a common function?
> > 
> 
> 
> Do you mean all the code between drm_modeset_lock_all and drm_modeset_unlock_all ?

Including drm_modeset_lock_all() and drm_modeset_unlock_all(), yes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
