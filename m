Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB627DABCE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjJ2Iju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2Ijt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 04:39:49 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A57C5;
        Sun, 29 Oct 2023 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1698568782; bh=jshvNIqxMYoT/ULUAbI8yGv7q+uWD6fD9TWA7ycDSzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcmT3ZFoGS4Wn7NEbHO/rDx7sMRezjkBVA9QKpKvheLhkrAJ14kdtE7UVW7X98Z5b
         eEYsVtvgT8SJW/adGFnRChIXqFhprggUnVJgYCkn/iskG1ji9EDa878C/0qXq1UiRP
         T5qpclCapL0emeKRN2JPPEfbep0arK2fWVms+bFsSFCa0IcBf7+nBOhp+D4C14Fz/3
         jauRzGNThUJUDZHfcGBGndR0HKKOJ1mENbCOV+WlKo9jFn2zZLFGcf9ArWhUyZvO1E
         oQHY3FyPnlyyFcycbCp7Atj3YdhxkqAr66eO3HgH3WyiCmwBjTV1dmVFJsbGZJDdJp
         8+AvbG9UizOtg==
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 270501000FA; Sun, 29 Oct 2023 08:39:42 +0000 (GMT)
Date:   Sun, 29 Oct 2023 08:39:42 +0000
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <ZT4aTsQJ_LUzGYay@gofer.mess.org>
References: <cover.1698398004.git.sean@mess.org>
 <0b35ca65d6f4d53d3beb1411a64970ea5f969060.1698398004.git.sean@mess.org>
 <20231027133818.f5zpeqxfw7ghs7sk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027133818.f5zpeqxfw7ghs7sk@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Fri, Oct 27, 2023 at 03:38:18PM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 27, 2023 at 10:20:46AM +0100, Sean Young wrote:
> > +	pc->rate = clk_get_rate(pc->clk);
> > +	if (!pc->rate) {
> > +		dev_err(pc->dev, "failed to get clock rate\n");
> > +		ret = -EINVAL;
> 
> Other error paths in this driver use dev_err_probe(). The most compact
> way here would be:
> 
> 	ret = dev_err_probe(pc->dev, -EINVAL, "....");
> 
> but maybe
> 
> 	ret = -EINVAL;
> 	dev_err_probe(pc->dev, ret, "...");
> 
> is a bit easier to parse for a human?!

Using the same dev_err_probe() function for all error paths is nice, so
I will change it for the next version. This change will print the EINVAL
error as well which does not really add anything, but no harm done there.

Thanks,

Sean
