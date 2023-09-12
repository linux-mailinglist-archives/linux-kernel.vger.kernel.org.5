Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884607BC87D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbjJGPDp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Oct 2023 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJGPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:03:43 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB58B9;
        Sat,  7 Oct 2023 08:03:42 -0700 (PDT)
Received: from p5dc58360.dip0.t-ipconnect.de ([93.197.131.96] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qp8q5-004cjc-Ky; Sat, 07 Oct 2023 17:03:33 +0200
Date:   Tue, 12 Sep 2023 20:56:47 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 4/5] clk: twl: add clock driver for TWL6032
Message-ID: <20230912205647.4be3b753@aktux>
In-Reply-To: <a9b646c7-2c02-8a69-a4c8-7e981a630eef@wanadoo.fr>
References: <20230911221346.1484543-1-andreas@kemnade.info>
        <20230911221346.1484543-5-andreas@kemnade.info>
        <a9b646c7-2c02-8a69-a4c8-7e981a630eef@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 19:15:54 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 12/09/2023 à 00:13, Andreas Kemnade a écrit :
> > The TWL6032 has some clock outputs which are controlled like
> > fixed-voltage regulators, in some drivers for these chips
> > found in the wild, just the regulator api is abused for controlling
> > them, so simply use something similar to the regulator functions.
> > Due to a lack of hardware available for testing, leave out the
> > TWL6030-specific part of those functions.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/clk/Kconfig   |   9 ++
> >   drivers/clk/Makefile  |   1 +
> >   drivers/clk/clk-twl.c | 197 ++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 207 insertions(+)
> >   create mode 100644 drivers/clk/clk-twl.c
> >   
> 
> ...
> 
> > +static int twl_clks_probe(struct platform_device *pdev)
> > +{
> > +	struct clk_hw_onecell_data *clk_data;
> > +	const struct twl_clks_data *hw_data;
> > +
> > +	struct twl_clock_info *cinfo;
> > +	int ret;
> > +	int i;
> > +	int count;
> > +
> > +	hw_data = twl6032_clks;
> > +	for (count = 0; hw_data[count].init.name; count++)
> > +		;  
> 
> Nit: does removing the /* sentinel */ and using 
> ARRAY_SIZE(twl_clks_data) would make sense and be simpler?
> 
well, I would like to have it prepared for different arrays
passed in some device data in the future, so I am choosing that
approach.

Regards,
Andreas
