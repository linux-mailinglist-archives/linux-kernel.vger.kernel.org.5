Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C397F94C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjKZSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:09:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F56C8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 10:09:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548EEC433C7;
        Sun, 26 Nov 2023 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701022182;
        bh=SLuAs/HbMN7WsDzAJGn90eTqZkD8vv1/cK9ItXh77Lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZCtTUJfZDgKAZfLHMXglWI/EFreOBt6VY3oj5Ly2RV4hT2e+ZeSieTCTHF40TK0yz
         r/9DDlQNcn9UD7uRq6dYz5wgPO4lNU5+gvYr6z1WKH77KiFNhsIf6b3fQ7ESuv7Img
         WQHE/yfkYMEWysyyWnf2Htrl/hZr6NMvbMPr5I5uEfK9t3eWbKLv8toHEjKQ0Iv3/M
         C9Z6ZBal7s3kEEq9pu89LTukGhNS+cyhiJbhzxFH6UnpOWYoUSxN6wcXFaEP4mdfwa
         Cgo8COHLTKpK0Gt1Fa8YBPIVqhWEvFWt6aYkA5JE5U+iibFBnGouIK5Zt3IbiuEvc5
         mr87fyIc1rkTQ==
Date:   Sun, 26 Nov 2023 18:09:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <20231126180935.0c1cc663@jic23-huawei>
In-Reply-To: <20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com>
References: <20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com>
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

On Sat, 25 Nov 2023 19:57:24 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hi Marcus,

Great to see this being used, but there is a little more you can do
here to take advantage fully.

> ---
>  drivers/iio/adc/mcp3911.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 974c5bd923a6..85bb13eb6f3b 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -168,7 +169,7 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = mcp3911_read(adc,
> @@ -207,7 +208,6 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  out:
> -	mutex_unlock(&adc->lock);
>  	return ret;
No point in having the label down here after the change. Just return directly
wherever you see an error.

Same for other cases.

>  }
>  
> @@ -218,7 +218,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> @@ -263,7 +263,6 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  	}
>  
>  out:
> -	mutex_unlock(&adc->lock);
>  	return ret;
>  }
>  
> @@ -350,7 +349,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  	int i = 0;
>  	int ret;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
>  	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
>  	if (ret < 0) {
> @@ -368,7 +367,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
>  					   iio_get_time_ns(indio_dev));
>  out:
> -	mutex_unlock(&adc->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231125-mcp3911-guard-866591e2c947
> 
> Best regards,

