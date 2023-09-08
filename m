Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46190798E78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbjIHSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbjIHSxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:53:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CECE7;
        Fri,  8 Sep 2023 11:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AF7C433AD;
        Fri,  8 Sep 2023 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694198681;
        bh=54le3/Cy0uRtUqARvRssTdBLQ27zribaLxs8ZjCQXs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u2kHb6RALOxH7JEqgn8+ldF2mfhmrwc1dzZwOTlcjXQO0yl1QSUn6bJLg2BqZUYtg
         XnIRmeyxylySDH86fJoWIyVEfIIgf7n2rO9WvfS3BMVAULbBjZaFDH3+HZfmNKAGQr
         t7IoCawLmL0K9KJ1wQMgoF9DyoESAuBsAZVhreUNm0I8sLQsrRFH8FWvxumzxMrqi0
         ebqVLieiSJE4zXtRjqBxsbCQ9W+2+hr9yqx4hH+Pt2QIvMwR9va4D3dT1HLha+ypKO
         xkx29lcCk6dIhBKK4iUwSLUjWAuM0G8tE5VwI9FeXimRnj4UFdZSMxx7nH2UqSgI7u
         1DzUkvGQvLsIw==
Date:   Fri, 8 Sep 2023 19:45:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230908194509.6a4f4adc@jic23-huawei>
In-Reply-To: <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
        <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
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


> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
> +{
> +	u8 temp_reg[2] __aligned(2);
> +	__be16 *temp_raw;
> +	int ret;
> +	s16 val;
> +	bool negative;
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
> +			       sizeof(temp_reg));
> +	if (ret)
> +		return ret;
> +
> +	if (temp_reg[0] & 0x80)
> +		negative = true;
> +	else
> +		negative = false;
> +
> +	temp_raw = (__be16 *)&temp_reg[0];
> +	val = be16_to_cpu(*temp_raw);
> +
> +	if (negative) {
> +		/*
> +		 * Two's complement. I am not sure if all supported
> +		 * architectures actually use 2's complement represantation of

AFAIK they do. Many IIO drivers would be broken if not..

> +		 * signed ints. If yes, then we could just do the endianes
> +		 * conversion and say this is the s16 value. However, as I
> +		 * don't know, and as the conversion is pretty simple. let's
> +		 * just convert the signed 2's complement to absolute value and
> +		 * multiply by -1.
> +		 */
> +		val = ~val + 1;
> +		val *= -1;
> +	}
> +
> +	*temp = val;
> +
> +	return 0;
> +}
