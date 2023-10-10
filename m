Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7926A7C0080
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJJPiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjJJPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:38:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CEB0;
        Tue, 10 Oct 2023 08:38:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1E1C433C8;
        Tue, 10 Oct 2023 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952291;
        bh=+kmHcwODZk6UkOu99a2F6yiTO4YQ3ydma7Qh6cgxTNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=djM/amio/lahxFk6SYm+/ih9uTYv006zWzslUaZPO3MWVV0tH+fr65xaYxQDGOloQ
         170Sn3vaacdM0NZOs2oZ32jlE4L0fHNz6qEuRnHS/5gb79hHBSRVJREJ/570Zz4m7k
         5wcNCTGzmRwuKGxHTR4VwgYM/oS3HdWLr5XVpg+p+l+LHObHJvzmOPAo5YuW6Yhe5K
         a5EUQk+IoaHVkkDdxLtAXcgaJBUOH3WTrcTMshE7od3J7Q6voScwT24IBN6uWQY/ap
         43c3LHXeDrn7WNLaHXJUgqf683ZCn1XAke6Mw44BB25BffJ6Kqx1qFEZ/NoZ0WqXBx
         lwWJF/B3AvH+A==
Date:   Tue, 10 Oct 2023 16:38:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/17] staging: iio: resolver: ad2s1210: do not use
 fault register for dummy read
Message-ID: <20231010163823.00612bdd@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-1-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-1-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> When reading registers on the AD2S1210 chip, we have to supply a "dummy"
> address for the second SPI tx byte so that we don't accidentally write
> to a register. This register will be read and the value discarded on the
> next regmap read or write call.
> 
> Reading the fault register has a side-effect of clearing the faults
> so we should not use this register for the dummy read.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
ouch.

Applied to the togreg branch of iio.git and pushed out as testing for 0day
to take a look at it.

Thanks,

Jonathan

> ---
> 
> v4 changes: New patch
> 
> (this probably should have been done before "staging: iio: resolver:
> ad2s1210: use regmap for config registers" but was overlooked until now)
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 67d8af0dd7ae..8fbde9517fe9 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -166,9 +166,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
>  	st->tx[0] = reg;
>  	/*
>  	 * Must be valid register address here otherwise this could write data.
> -	 * It doesn't matter which one.
> +	 * It doesn't matter which one as long as reading doesn't have side-
> +	 * effects.
>  	 */
> -	st->tx[1] = AD2S1210_REG_FAULT;
> +	st->tx[1] = AD2S1210_REG_CONTROL;
>  
>  	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
>  	if (ret < 0)
> 

