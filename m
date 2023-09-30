Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F087B4187
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjI3PPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjI3PPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:15:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9486E3;
        Sat, 30 Sep 2023 08:15:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782CDC433C7;
        Sat, 30 Sep 2023 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696086944;
        bh=hRndYACHXPOhZ82VVELJZJz9qqQwJ4BMoQZVmLoxOE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrydavIhS8QQ9TlkbXK+yVpFh3YPFwrS3tuIMBB2w66IUjLewjHQV762t4nHG/K4L
         /x4Dy2M9r4EHegkKRYNWgMIa6VMyERVR5CFJwqnwdnVGGkszZuMavwYd2xUkqiE5A3
         nS/F3DjG7Jn6s9x0AcI/OQ5dPFxRIn3wwgEWEyjJeffzjF7xnL4zXwLsHz/T9aVV8i
         ELtylheIik7oGvzEzsNlSPMTL84i15+Jkt8Wuc/nAc8E425UJmeBANCITbR78+KS4l
         eHQB1gibLBZ56QPxHx9r7A0U0/Hq+jfZA39Sq/eK2rRTCRp0hRf0+Hm+vc1FXlksiH
         LbFaPkLz1HfBQ==
Date:   Sat, 30 Sep 2023 16:15:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/27] staging: iio: resolver: ad2s1210: convert
 resolution to devicetree property
Message-ID: <20230930161543.22c3833e@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-18-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-18-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> Selecting the resolution was implemented as the `bits` sysfs attribute.
> However, the selection of the resolution depends on how the hardware
> is wired and the specific application, so this is rather a job for
> devicetree to describe.
> 
> A new devicetree property `adi,resolution` to specify the resolution
> required for each chip is added and the `bits` sysfs attribute is
> removed.

Description need updating to reflect property having a different name.

Otherwise this LGTM
> 
> Since the resolution is now supplied by a devicetree property, the
> resolution-gpios are now optional and we can allow for the case where
> the resolution pins on the AD2S1210 are hard-wired instead of requiring
> them to be connected to gpios.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
...

>  
> +static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
Doesn't match patch description of what this is called.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"failed to read assigned-resolution-bits property\n");
> +
> +	if (val < 10 || val > 16)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "resolution out of range: %u\n", val);
> +
> +	st->resolution = (val - 10) >> 1;
> +
> +	return 0;
> +}
> +

