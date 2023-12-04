Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65F680327F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjLDMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjLDMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:23:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC2100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:23:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FAC433C8;
        Mon,  4 Dec 2023 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692597;
        bh=VoegbZtlGEE+YOCixMcNCzHVYsgNLyvCC0B36pZHRl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F0RqIcPPKLUl064QkUhYGTS9EllbUb9s6eU+USIgBLOvyxCtNRBIbTV5bYKdX+52W
         kV6+xp4A4VeL9nN8uI8oobmhex+sWPpciLjJ9tXFIYbroCUkzIeQ+kro1KPTRF5IR+
         6d7SFCVZSSPiUGcCx3awIbGpFF5Tj7f72+vbArRj2K90M/nudyszGg4lOF15EAXCnj
         xAqOkrMrx4ErtkEvdTwr1Ge2duUNPsUK7bSlp6qj3IpL84Or3pDZpyFeld9jniqJ4q
         GWqpOB9i4UDFmJ/LfyGCTYiopptkhOuasnoSibCk8lPop7Pic/DV510ylmbDaPWYCH
         ob+qIrUbla9Vw==
Date:   Mon, 4 Dec 2023 12:23:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <20231204122309.4b1b6de7@jic23-huawei>
In-Reply-To: <20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com>
References: <20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com>
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

On Mon, 27 Nov 2023 08:38:22 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Oddly this doesn't apply. Also some comments inline.
> ---
> Changes in v2:
> - Return directly instead of goto label
> - Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
> ---
>  drivers/iio/adc/mcp3911.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 974c5bd923a6..30836725ef9a 100644
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
> @@ -168,13 +169,13 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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
This should go further.  Return early in the good paths as well
		return IIO_VAL_INT;
a few lines later than this.

