Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767BF7B4142
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjI3Ows (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjI3Owq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:52:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAEBBA;
        Sat, 30 Sep 2023 07:52:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345ADC433C7;
        Sat, 30 Sep 2023 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696085564;
        bh=THPze5AUjQwvb2AK0QGXQIyXlQBsto61AATNgwXhGU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PsY2NRb32noFVYu5LmNxffRjMbM3KQx5dx3WJfPsCr6k8QUI7rRK4jc8mTvXhbH1v
         ORGyxj6zu8aFa21wGJoaUCxfgm4r6ttCHr0AaD1BnrjYqG5wu3LOi0U97lBsJSB6SU
         jYxzYXnnvHTItWIXEzAeBuV+FyvFwjzleQYbjNPg6ttNwCqDTaWceVGhhvPOtkhu+x
         uofotm4lDN2A+sZ4wH7Mn69Lou0Y2OPwnesmtzz/YAeUrT6F7JqT16NACR6Rat5SkX
         ZVWfx5/EWkEeI7yVtrTtrdmmbm7/Mno9rx9D9JGqYhYtmRpJ6xeVt2Bb5kmg8+m9Mx
         QC5o0Paotqwlg==
Date:   Sat, 30 Sep 2023 15:52:42 +0100
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
Subject: Re: [PATCH v3 11/27] staging: iio: resolver: ad2s1210: add debugfs
 reg access
Message-ID: <20230930155242.6490bcab@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-11-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-11-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This add an implementation of debugfs_reg_access for the AD2S1210
> driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I never really care if a driver implements this or not.
However, if you find it useful that's fine, so applied.

Thanks,

Jonathan

> ---
> 
> v3 changes: None
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 0663a51d04ad..31415fbb6384 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -614,9 +614,29 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	return ret;
>  }
>  
> +static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
> +				       unsigned int reg, unsigned int writeval,
> +				       unsigned int *readval)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info ad2s1210_info = {
>  	.read_raw = ad2s1210_read_raw,
>  	.attrs = &ad2s1210_attribute_group,
> +	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
>  };
>  
>  static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
> 

