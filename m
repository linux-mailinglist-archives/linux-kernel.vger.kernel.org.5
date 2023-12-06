Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D56807733
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379058AbjLFSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378992AbjLFSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:01:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C950139
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:01:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD92C433C7;
        Wed,  6 Dec 2023 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701885693;
        bh=H5aehIkSq278H36IsVkzvOoDv3gkPy7Av2ps6FIv0zE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jTlpYh08jw2nAFSqYhqehungn9Mnu0V+inN0V6ZwgJ7uLp4iI+oxXCQLd0zFOjIoI
         2J3Q1NHO3KKZOqpxWSO8gGw9xcLBG12LRq3AQ/c8JVU5rvNMTcyzf9vtVvIvb2cyrg
         yRaYDhO45Nyrju3g6u4NyQMExg3eKJtcnSdZjp04zh+lipRvWYG48INnZbgQmBKbt/
         05BibzMRGO2IgZyyNGWiuNeCjP05NlV/cbT+GCSiWhZx3QINrpBZ3fD9MKWGZO8QG9
         FQznCSleYsfVqqxBG9iie2mQrLv1UuIYSx4bEgHwoIhHqebaynRbjMNpTdMzjsOS94
         JjeGM13X5Xrmw==
Date:   Wed, 6 Dec 2023 18:01:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <20231206180126.6e78ed29@jic23-huawei>
In-Reply-To: <20231205-mcp3911-guard-v3-1-df83e956d1e9@gmail.com>
References: <20231205-mcp3911-guard-v3-1-df83e956d1e9@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Tue, 05 Dec 2023 12:16:33 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hi Marcus,

One follow up issue inline.

> ---
> Changes in v3:
> - Return early in good paths as well
> - Rebase against master
> - Link to v2: https://lore.kernel.org/r/20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com
> 
> Changes in v2:
> - Return directly instead of goto label
> - Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
> ---
>  drivers/iio/adc/mcp3911.c | 47 +++++++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index d864558bc087..f4822ecece89 100644
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
> @@ -318,44 +319,34 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = mcp3911_read(adc,
>  				   MCP3911_CHANNEL(channel->channel), val, 3);
>  		if (ret)
> -			goto out;
> +			return ret;
>  
>  		*val = sign_extend32(*val, 23);
> -
> -		ret = IIO_VAL_INT;
> +		return IIO_VAL_INT;
>  		break;
Why keep the break? It's unreachable code.
Same for other similar cases.

Jonathan


>  

