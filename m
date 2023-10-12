Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7147C6827
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjJLIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJLIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45AB7;
        Thu, 12 Oct 2023 01:25:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7425DC433C8;
        Thu, 12 Oct 2023 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697099110;
        bh=yemEo7k0irT6KnTVPLYInzEHy0ZlJatDXe+f9KzZto8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EIknBPTEzh3WzWamy4isXY6N/MfOi1NML+iRhIUaiizbSQAc5TaOdomXMsS46TPwx
         XD4OHQsnNG1+DKTsojVetWe9uLFaaAo1WwpVn3XEmrQG+wZvug0MT6dP+TqNkTV8+t
         3eTxkdJVddDCiZo63AniNqx4iase9xvjc4lt7wqWgGKTOdz8e33w3Cy9lTXbay5MNv
         cwfeQ1cCe8o2b254uzF4hDkuVICCblpkUpOFAIE0ZKX6gHHACrrGHiTWoaEqvGtdmv
         LnCI16g9lK5AFWm6eXChaRQrS5OSs0ocBdleO/OvLu5zaj/8IrqQneS+vs0PeTm4hq
         bgRxW8QH7JyBA==
Date:   Thu, 12 Oct 2023 09:25:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: resolver: ad2s1210: move out of staging
Message-ID: <20231012092522.27ef48dd@jic23-huawei>
In-Reply-To: <20231010-ad2s1210-mainline-v5-4-35a0f6ffa04a@baylibre.com>
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
        <20231010-ad2s1210-mainline-v5-4-35a0f6ffa04a@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 16:12:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This moves the ad2s1210 resolver driver out of staging. The driver has
> been fixed up and is ready to graduate.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes: New patch in v5.
> 
> Diff was made with file rename detection turned off so we can see the full
> driver code for one last check through. sysfs-bus-iio-resolver-ad2s1210 and
> ad2s1210.c are just moved (no changes).

Excellent.  Great work btw - this looks really nice now.

I did a final scan through (most of the code was familiar for some reason :)
I've called out a few things that I'd like to see tidied up in follow up patches
but definitely nothing that prevents us making the move out of staging.

If you are happy to do a patch dropping of_match_ptr() then great, if not I'll
send one out at somepoint soon.  I didn't want to just sneak it in here as an
edit whilst applying because I like the clean copy of identical code in these
move patches.

If anyone else wants to review, unless they see anything critical / ABI changing
I'd like any follow on work that comes up to be done as patches on a normal / non
staging driver.

Removing another directory in staging/iio is great as well :)

Applied to the togreg branch of iio.git, but pushed out initially as testing to
let 0-day take a quick look.

Thanks

Jonathan

> 
>  .../testing/sysfs-bus-iio-resolver-ad2s1210   |   27 +
>  drivers/iio/resolver/Kconfig                  |   13 +
>  drivers/iio/resolver/Makefile                 |    1 +
>  drivers/iio/resolver/ad2s1210.c               | 1522 +++++++++++++++++
>  .../sysfs-bus-iio-resolver-ad2s1210           |   27 -
>  drivers/staging/iio/Kconfig                   |    1 -
>  drivers/staging/iio/Makefile                  |    1 -
>  drivers/staging/iio/resolver/Kconfig          |   19 -
>  drivers/staging/iio/resolver/Makefile         |    6 -
>  drivers/staging/iio/resolver/ad2s1210.c       | 1522 -----------------
>  10 files changed, 1563 insertions(+), 1576 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210
>  create mode 100644 drivers/iio/resolver/ad2s1210.c
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
>  delete mode 100644 drivers/staging/iio/resolver/Kconfig
>  delete mode 100644 drivers/staging/iio/resolver/Makefile
>  delete mode 100644 drivers/staging/iio/resolver/ad2s1210.c
> 

> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> new file mode 100644
> index 000000000000..bd4a90c222b5
> --- /dev/null
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -0,0 +1,1522 @@

> +
> +#define DRV_NAME "ad2s1210"
> +
Nice to tidy up:
This is a pet hate of mine.   Why have a define for DRV_NAME that is only
used in one or two places?  That's where we will go to find out what it is
called, so define just makes that take one more step!

> +/*
> + * Toggles the SAMPLE line on the AD2S1210 to latch in the current position,
> + * velocity, and faults.
> + *
> + * Must be called with lock held.
> + */
> +static void ad2s1210_toggle_sample_line(struct ad2s1210_state *st)
> +{
> +	/*
> +	 * Datasheet specifies minimum hold time t16 = 2 * tck + 20 ns. So the
> +	 * longest time needed is when CLKIN is 6.144 MHz, in which case t16
> +	 * ~= 350 ns. The same delay is also needed before re-asserting the
Potential issue in long term but wait and see:
Hmm. The about equal makes me a little nervous long term.  Far too much history of
parts being produced that don't quite meet the documented timing.  Still can fix
it if we see any problems.

> +	 * SAMPLE line.
> +	 */
> +	gpiod_set_value(st->sample_gpio, 1);
> +	ndelay(350);
> +	gpiod_set_value(st->sample_gpio, 0);
> +	ndelay(350);
> +}


> +
> +static struct spi_driver ad2s1210_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(ad2s1210_of_match),
Fix this in a follow up patch:

Don't guard a of_match_table with of_match_ptr().  All that does is prevent
any chance of using another firmware (ACPI PRP0001 for example) that
uses this table to match.


> +	},
> +	.probe = ad2s1210_probe,
> +	.id_table = ad2s1210_id,
> +};
> +module_spi_driver(ad2s1210_driver);
