Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2B1807290
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378953AbjLFOgC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 09:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378971AbjLFOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:35:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C610D2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:36:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1rAt0G-000789-Ha; Wed, 06 Dec 2023 15:35:56 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1rAt0F-00Dz2R-IV; Wed, 06 Dec 2023 15:35:55 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1rAt0F-000EYR-1c;
        Wed, 06 Dec 2023 15:35:55 +0100
Message-ID: <d45a52e356766b6f90122e75d53089cd17a0e9d3.camel@pengutronix.de>
Subject: Re: [PATCH] net: rfkill: gpio: set GPIO direction
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josua Mayer <josua@solid-run.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Wed, 06 Dec 2023 15:35:55 +0100
In-Reply-To: <6e3049e37b00e2e5a5f02bff7b75d6c9282973b5.camel@pengutronix.de>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
         <cd25fd96fa391d3c8a5811d995d166cbb0b0efe5.camel@sipsolutions.net>
         <6e3049e37b00e2e5a5f02bff7b75d6c9282973b5.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

On Mi, 2023-12-06 at 14:24 +0100, Rouven Czerwinski wrote:
> Hi Johannes,
> 
> On Wed, 2023-12-06 at 14:16 +0100, Johannes Berg wrote:
> > On Wed, 2023-12-06 at 14:13 +0100, Rouven Czerwinski wrote:
> > > 
> > > +++ b/net/rfkill/rfkill-gpio.c
> > > @@ -126,6 +126,16 @@ static int rfkill_gpio_probe(struct
> > > platform_device *pdev)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	if (rfkill->reset_gpio)
> > > +		ret = gpiod_direction_output(rfkill->reset_gpio,
> > > true);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (rfkill->shutdown_gpio)
> > > +		ret = gpiod_direction_output(rfkill-
> > > > shutdown_gpio, true);
> > > +	if (ret)
> > > +		return ret;
> > > 
> > 
> > That's weird, you need ret to be inside the if. It's even entirely
> > uninitialized if you don't have ACPI, if you don't have
> > reset/shutdown.
> 
> Thanks for the review, you are totally right, I didn't look at the ret
> initialization. I moved it inside the if for v2.

The if-block is not required at all, gpiod_direction_output(NULL, ...)
will just return 0 from VALIDATE_DESC().

regards
Philipp
