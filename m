Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2157C7DF217
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjKBMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKBMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:16:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D6189;
        Thu,  2 Nov 2023 05:03:28 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6ef6c1ec2so9815981fa.2;
        Thu, 02 Nov 2023 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698926606; x=1699531406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZgopjRBSehJcywZRSRRjwXmQo1kSprJEg6i4E+ED6Q=;
        b=Q2AE6KZK+FF/beg3fAugilfpGyXxcASJvrzyt/n8I3zepJXl7sNDqFWj+Zj4tYpZ0k
         ZhS6CGPuBDt9MTA4tQlGUPxU6WwSMVVnvDCWok4dskSyfXZ1zCPv5KVkv68uYU4YBG3N
         WCQOYvTGyII2XhcxLpLiZa3JZee00rlXyfokp89PmxpQwn6J9gsBLV42VpgexcnTvEN4
         Fbhlf5JoYlaODIWA85EvJPreKK+gs0/chzgCrkfhLspE4G2TWRAibFBp/ryuuIbVllQX
         tRaYmA4yhIUTUVG368Zm5tmwl70Qb4gGhJnHXmbJSd3de6ZbCIEYP4E5r8W4EWl9+e+O
         1POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926606; x=1699531406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZgopjRBSehJcywZRSRRjwXmQo1kSprJEg6i4E+ED6Q=;
        b=tuKj1Mzvcn/tkATDb6QEkhKUl6L0s13ZrtlHRxdZygeMcCMcwhspqkCFuquuKQgoCJ
         GvypbVwpauSzVYxKzMcjldOFIB4ML2DrbhSNHX4EQZGqmUWm69TPzswfOJka9MSwhQIV
         TTsonzwqcztmlo48zNVAZMQWWyPbWLEA81j9A/74PnCbM9PK7SaexHMfhcERs7N7KkRS
         74Cn3yCYz10T92MKM/4YrCCRnU14Tj9Wih4Y105ZLqAgqCs9kcz36I0i3OUa/2Lll80H
         AMajqYUA4EI45FZzQ+lvLiAEOp5exLirPB8BReBwz+V+fmvsGk17Bfo79JvesZ/vxhak
         chtg==
X-Gm-Message-State: AOJu0YzzeoZTfBe6U597QcC2S5yBjFoFcTiNqxaL/Zq8cL6bCn24WI0g
        hhms7sGinPdwZY0u/loQe6o=
X-Google-Smtp-Source: AGHT+IFMKQuxZDDL7Ub8z/ytNkVS7YNsxF9774I/AhaWO33gRuWb1DDnfHgznfOcdXVqK50Pb+6MQw==
X-Received: by 2002:a05:651c:c97:b0:2bc:e330:660b with SMTP id bz23-20020a05651c0c9700b002bce330660bmr20292141ljb.9.1698926605812;
        Thu, 02 Nov 2023 05:03:25 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651c038d00b002b9e0d19644sm455838ljp.106.2023.11.02.05.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:03:25 -0700 (PDT)
Date:   Thu, 2 Nov 2023 15:03:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
Message-ID: <b4mpa62b2juln47374x6xxnbozb7fcfgztrc5ounk4tvscs3wg@mixnvsoqno7j>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <j37ktiug7vwbb7h7s44zmng5a2bjzbd663p7pfowbehapjv3by@vrxfmapscaln>
 <AS8P193MB1285473EE92FEDB65C08C131E4A0A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285473EE92FEDB65C08C131E4A0A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:10:24PM +0100, Bernd Edlinger wrote:
> 
> 
> On 10/31/23 11:32, Serge Semin wrote:
> > On Mon, Oct 30, 2023 at 07:01:11AM +0100, Bernd Edlinger wrote:
> >> otherwise the synopsys_id value may be read out wrong,
> >> because the GMAC_VERSION register might still be in reset
> >> state, for at least 1 us after the reset is de-asserted.
> > 
> > From what have you got that delay value?
> > 
> 
> Just try and error, with very old linux versions and old gcc versions
> the synopsys_id was read out correctly most of the time (but not always),
> with recent linux versions and recnet gcc versions it was read out
> wrongly most of the time, but again not always.
> I don't have access to the VHDL code in question, so I cannot
> tell why it takes so long to get the correct values, I also do not
> have more than a few hardware samples, so I cannot tell how long
> this timeout must be in worst case.
> Experimentally I can tell that the register is read several times
> as zero immediately after the reset is de-asserted, also adding several
> no-ops is not enough, adding a printk is enough, also udelay(1) seems to
> be enough but I tried that not very often, and I have not access to many
> hardware samples to be 100% sure about the necessary delay.
> And since the udelay here is only executed once per device instance,
> it seems acceptable to delay the boot for 10 us.
> 
> BTW: my hardware's synopsys id is 0x37.

Well, the delay value is highly hardware-dependent depending on the
IP-core version, generation (MAC1000, GMAC, QoS Eth, XGMAC, XLGMAC,
etc), IP-core synthesize parameters and finally the platform-specific
ref clocks implementation and their rates. So no matter how many you
try to figure out a safest value I guess you won't be able to find out
the common value for all the devices. Though seeing nobody has
reported so far any problem with that then it seems rare among the DW
*MAC* devices. So since you get to a add a very small delay in just a
perf non-critical path it won't hurt for the rest of the platforms.
But please very thoroughly define the problem in the commit message:
what hardware you have (SoC, platform, etc), in what conditions you
see the problem (what you already described in your reply to me), how
you've got to the 10us value, etc. It will be useful in case if
somebody would want for instance make the delay platform-dependent or
whatever.

-Serge(y)

> 
> 
> Bernd.
> 
> > -Serge(y)
> > 
> >>
> >> Add a wait for 10 us before continuing to be on the safe side.
> >>
> >> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> >> ---
> >>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> index 5801f4d50f95..e485f4db3605 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> @@ -7398,6 +7398,9 @@ int stmmac_dvr_probe(struct device *device,
> >>  		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
> >>  			ERR_PTR(ret));
> >>  
> >> +	/* Wait a bit for the reset to take effect */
> >> +	udelay(10);
> >> +
> >>  	/* Init MAC and get the capabilities */
> >>  	ret = stmmac_hw_init(priv);
> >>  	if (ret)
> >> -- 
> >> 2.39.2
> >>
> >>
