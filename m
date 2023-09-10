Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF1799E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjIJODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIJODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:03:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886CCC5;
        Sun, 10 Sep 2023 07:03:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D5BC433C8;
        Sun, 10 Sep 2023 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694354621;
        bh=wTbYtIegKrFF/yYFdEQr8XdRy/kc5XFbBENiOAM+JqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p3NjNXxPNA5C4jMAi6Srjy+TK7wk0Z132c3j2OizyvcaStnONMzt5nCQ8N5BIh17N
         AY3gYWnfjVMwaRwUwo0YmlwXCP758rWn1MgWEoSIh+KPCAMgegcg8G0NdE7YKOejWr
         NlJD5r3kyYFf1niD+dxXPW8ALs2iT3XoPhAl+aX8tMGWoY1r76O3uXzR3KMAQY80Eu
         KVTGH6xus/uTXGhKD8lUEFM1Y1maQNCQf2+dUsi2yzgVsBFkjAD9L8TPVMsObetjY8
         OwkmPsLVDd6+1HIC2z47bbD9mv67JzevLiZQ2inCmtYpSaCMwyvRLOsbSpU9dAjm0L
         +V48XEFEiQIcw==
Date:   Sun, 10 Sep 2023 15:03:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add ltc2309 support
Message-ID: <20230910150333.472437be@jic23-huawei>
In-Reply-To: <20230903124341.360c95fe@jic23-huawei>
References: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
        <20230828-ltc2309-v3-2-338b3a8fab8b@gmail.com>
        <20230903124341.360c95fe@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2023 12:43:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 28 Aug 2023 22:41:35 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
> 
> > The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> > 
> > This implements support for all single-ended and differential channels,
> > in unipolar mode only.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>  
> Hi Liam,
> 
> A few really small editorial bits in here.  I'll fix them whilst applying.
> Series applied to the togreg branch of iio.git
> 
> Note I will be rebasing the tree on rc1 once available and in the meantime
> this will only be pushed out as testing.

A couple more static analysis reports came in (unreachable return in one pace
and a missing static.  I've fixed up in my tree.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > +/**
> > + * struct ltc2309 - internal device data structure
> > + * @dev:	Device reference
> > + * @client:	I2C reference
> > + * @vref:	External reference source
> > + * @lock:	Lock to serialize data access
> > + * @vref_mv	Internal voltage reference  
> 
> Missing : which is what the bot picked up on.
> 
> > + */
> > +struct ltc2309 {
> > +	struct device		*dev;
> > +	struct i2c_client	*client;
> > +	struct regulator	*vref;
> > +	struct mutex		lock; /* serialize data access */
> > +	int			vref_mv;
> > +};  
> 
> > +
> > +void ltc2309_regulator_disable(void *regulator)
> > +{
> > +	struct regulator *r = (struct regulator *)regulator;  
> 
> Never any need to explicitly cast from a void * to any other pointer type.
> (C spec says it is always fine to do this :)
> 
> Given type is obvious from use, can just do
> 	regulator_disable(regulator);
> and lose the local variable.
> 
> > +
> > +	regulator_disable(r);
> > +}  
> 
> ..
> > +
> > +static const struct of_device_id ltc2309_of_match[] = {
> > +	{ .compatible = "lltc,ltc2309" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ltc2309_of_match);
> > +
> > +static const struct i2c_device_id ltc2309_id[] = {
> > +	{ "ltc2309" },
> > +	{}  
> 
> Trivial but space between { and } for consistency.
> 
> 

