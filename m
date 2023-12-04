Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B254E803B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjLDRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDRWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:22:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD383
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:22:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC89FC433C8;
        Mon,  4 Dec 2023 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701710550;
        bh=fISovsUAugtGVbrmngMLVuIQZSTyx2zTDMISleFijck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=plB2EjoZ+u/2syhFMHyNS5e/d88O7CerbI1EU1u4/BiPpQfkSJvSn4B97CmuDCFsp
         L6H+kucPJ9VYXMxMfyW16EMFywm2q2a0rxJj2AasuwrIagBWlNHRuhoerrRdRaryKn
         cpa+gyDxggZNMIPaKcJLzE9O/s94aywh5Hdb2YEzBwEqvsX6rY4KoRrfZfv44H4M0h
         zXBO9wApaoD+ATliMWLwEszY1GHhc/wkft2QFbIxm8N1hzJte8AeI1LxAFleXCRf6v
         3NCJ9u6JP638aZN5ZjEpSoVEaIQ99nAihmRHTqUc7npqXH7IFBxnEmP4sNUNmBEKie
         0aCDnrfskgJcw==
Date:   Mon, 4 Dec 2023 17:22:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231204172217.6be90ae4@jic23-huawei>
In-Reply-To: <9dbb81f8-7c75-411d-a77c-b670302f0dfe@gmail.com>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
        <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
        <20231125172125.1b0f1ae7@jic23-huawei>
        <9dbb81f8-7c75-411d-a77c-b670302f0dfe@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 18:49:21 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 11/25/23 19:21, Jonathan Cameron wrote:
> > On Thu, 23 Nov 2023 17:23:22 +0200
> > mitrutzceclan <mitrutzceclan@gmail.com> wrote:
> >   
> >> From: Dumitru Ceclan <mitrutzceclan@gmail.com>  
> 
> ...
> >> +	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
> >> +	st->regulators[1].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
> >> +	st->regulators[2].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
> >> +
> >> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> >> +				      st->regulators);  
> > 
> > If only some of them are supplied, the driver works fine as long as no channel is using them?
> > If so should probably get the optionally then check for availability of the ones you
> > want.  I'm sure someone will just wire up ref.  Incidentally, ref2 isn't there for all chips
> > I think, so we should not get it on the ones where it can't exist.
> >   
> 
> 
> This sets a dummy regulator in place if no proper supply is found. Then
> the call regulator_get_voltage() on the dummy will fail. About getting
> ref2, sure, I'll set the string only with the right ID.
> 
> ...
> >> +		ret = ad7173_get_ref_voltage_milli(st, (u8)ref_sel);
> >> +		if (ret < 0)
> >> +			return dev_err_probe(dev, ret,
> >> +					     "Cannot use reference %u", ref_sel);  
> 
> Here the probe would not continue if a channel selects a supply that is
> not available in the DT.
Ok. It's a little ugly though - so maybe a comment at the bulk_get to say
it will fail cleanly a bit later.
