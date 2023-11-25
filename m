Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD237F8C86
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjKYQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKYQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:45:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE67106
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:45:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D65C433C7;
        Sat, 25 Nov 2023 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700930741;
        bh=kC67tlW47eQO8hIkRqPMLcnEKgkghYrvxLkHQPnjYIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PG5WG1cil8UVXUZ+TJ6SDZt0pEnC8sBNnLwATz+ip+qJd0BYmRHf9mourflb6J2RG
         rgYDKodTH+9brjJQE6wjDkvHBDF5lQ3Wl/jocRE77W4YriCE5aHFYpTFfav4n2ljiN
         QxbAIZ8jIi00mapBRw/I/rt2pf+HCkhQQ3cyUJS0yOFaKuIKF50JKAQJysq7/6sxyn
         /NTAFTxqkZ7o4LlfZvvf14l2sK4MPbp9YArbCoYWMGIUmW6zHOjeu6xeLKF18ucVkD
         vmJ0gKCDxazeaYdWWQAwyeUTZ8cKGWr0D/t5p7B3CO3tidA4wL0szbFRCiC+OasbE0
         65adPTDu9VAtg==
Date:   Sat, 25 Nov 2023 16:45:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: add VEML6075 UVA and UVB light
 sensor driver
Message-ID: <20231125164533.57abf756@jic23-huawei>
In-Reply-To: <659d5d74-4861-45c4-8b95-218f3a7e60cf@gmail.com>
References: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
        <20231110-veml6075-v2-3-d04efbc8bf51@gmail.com>
        <20231125151116.6d9b6e46@jic23-huawei>
        <659d5d74-4861-45c4-8b95-218f3a7e60cf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 17:17:06 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 25.11.23 16:11, Jonathan Cameron wrote:
> > On Sat, 25 Nov 2023 12:56:57 +0100
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
> >> light sensor with I2C interface and noise compensation (visible and
> >> infrarred).
> >>
> >> Every UV channel generates an output signal measured in counts per
> >> integration period, where the integration time is configurable.
> >>
> >> This driver adds support for both UV channels and the ultraviolet
> >> index (UVI) inferred from them according to the device application note
> >> with open-air (no teflon) coefficients.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > 
> > Hi Javier,
> > 
> > A few more minor things. Looks good in general.
> > 
> > Jonathan
> >   
> >> +struct veml6075_data {
> >> +	struct i2c_client *client;
> >> +	struct regmap *regmap;
> >> +	struct mutex lock; /* integration time/measurement trigger lock */  
> > 
> > Could perhaps be clearer. Maybe something like
> > 	/* Prevent integration time changing during a measurement */
> >   
> It prevents integration time changing as well as measurement triggers
> while a measurement is underway. I just wanted to cover both usages with
> a short comment in the same line.

Ah.  Well I misunderstood it, so burn a few more lines :)

> >> +
> >> +static int veml6075_uva_comp(int raw_uva, int comp1, int comp2)
> >> +{
> >> +	int comp1a_c, comp2a_c, uva_comp;
> >> +
> >> +	comp1a_c = (comp1 * VEML6075_A_COEF) / 1000U;
> >> +	comp2a_c = (comp2 * VEML6075_B_COEF) / 1000U;
> >> +	uva_comp = raw_uva - comp1a_c - comp2a_c;
> >> +
> >> +	return clamp_val(uva_comp, 0, U16_MAX);
> >> +}
> >> +
> >> +static int veml6075_uvb_comp(int raw_uvb, int comp1, int comp2)
> >> +{
> >> +	int comp1b_c, comp2b_c, uvb_comp;
> >> +
> >> +	comp1b_c = (comp1 * VEML6075_C_COEF) / 1000U;  
> > 
> > Any of units.h appropriate here?  I'm not sure if the / 1000U is a units
> > thing or not.
> >   
> These divisions are used to scale the coefficients down, as they are
> defined as entire numbers. These coefficients have no units and the
> resulting value is a count.
Fair enough.
> 
> I have nothing to add to the rest of your comments. I will start working
> on v3.
> 
> Thanks again for your thorough review.
> 
> Best regards,
> Javier Carrasco

