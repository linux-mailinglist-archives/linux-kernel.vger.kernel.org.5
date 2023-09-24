Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D87ACAD0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjIXQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 12:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 12:51:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB4FD;
        Sun, 24 Sep 2023 09:51:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D30C433C8;
        Sun, 24 Sep 2023 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695574291;
        bh=rKfvvK2fWtROu5dnahrRZoarOaavt6eOxye7CB3KXic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HwB/B5ZPJ6jTFkWe3POgACEQRFjxdgbrHbDdAtg6slmTKz5mkHC1YrqTVjSDJ2tx0
         LfM6kX1EkOT9wloJ5Jex0Ve+Cx8skibbINQzSJ29aN3SB1sk0fq7f+8DK0Gb7qVQKP
         1j7RwZXD1FPnZ/Kbb9w52I5FLPWDZHDBXWXtEpPnlgG1IB4pA89G3ntPzazB4Gx68T
         vnxMnVUBvHNImQyiOMpKnB2IgiKIrWsR8Ay2pApC91ifFp/QCRuTIrOwiZCuSDy3Dj
         S04JSSTZ5V2guwC1af2wT0zq6dz/sl3rHCeRiMTagTUMSqVw0WXhmR8jVql9iixM3Q
         17XGVm2VD9A1A==
Date:   Sun, 24 Sep 2023 17:51:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 00/19] iio: resolver: move ad2s1210 out of staging
Message-ID: <20230924175123.268e8de4@jic23-huawei>
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Resending v2 with proper `PATCH v2` prefix.
> 
> Changes since v1:
> * Address initial device tree patch feedback
> * Drop "iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro" (related cleanups
>   also dropped for now, will address in a future series if needed)
> * Apply improvements as a series as patches to the staging driver. It is not
>   quite ready for the move out of staging patch yet.
> 
> This series has been tested on actual hardware using a EVAL-AD2S1210 evaluation
> board. (Note: not all device tree features have been implemented in the driver
> since the eval board doesn't support them out of the box. We plan to add them
> later if needed.)

Thanks for breaking it up.

> 
> One thing left over from the staging driver that probably needs more attention
> still is the fault handling (both the fault threshold attributes and how
> userspace gets notified of fault conditions). We considered adding these as
> events, but the fault conditions are related to internal measurements in the
> chip that aren't available as channels.
> 
> Since the chip is designed to read the fault register each time we read the
> data registers for one of the two channels it seems like faults should be
> associated with channels one way or another. Would it make sense to add extra
> channels for the internal signals that only have fault events (mostly with
> IIO_EV_TYPE_THRESH)? Or would it make sense to add a new "flags" channel type
> where the "raw" value is bit flags? Or something else?

Fault reporting is a continuing problem across all similar subsystems.
Every now and then there is a discussion about something 'generic' as
in most cases you want faults to surface separately from the main datastream.
Unfortunately no one ever did more than talk about it as far as I know.

I'm not keen on the flags channel because it's effectively custom to a particular
driver.  Describing the various possible bits in a way generic software can
interpret them is really challenging.  Faults tend to be a lot less 'consistent
in form' than actual data.  You are correct that at least some of these
could be mapped to channels though.

> 
> Here is the table of available faults for context. Sine/cosine inputs are
> internal signals.

Some of these we could consider 'normal' events.
> 
> | Bit | Description
> +-----+------------
> | D7  |  Sine/cosine inputs clipped

Not really related to any channel.  It's pushing the boundaries
a little but you could add an alternating voltage channel and
describe this as a threshold being crossed on that.  It's a bit
of a stretch but it is something existing tooling should handle
even if it's not easy to interpret the error.

> | D6  |  Sine/cosine inputs below LOS threshold
Also a threshold on the input alternative voltage channel.
Problem here is that IIO only supports one threshold. So you
would need to figure out how to handle this vs the clip detection.

> | D5  |  Sine/cosine inputs exceed DOS overrange threshold
Not 100% sure I understood this one right, but could it be considered
an over threshold condition?
> | D4  |  Sine/cosine inputs exceed DOS mismatch threshold
My knowledge of resolvers is a little limited, but this could
be considered an event on a differential channel (between
sine and cosine inputs.

> | D3  |  Tracking error exceeds LOT threshold
Not sure if this one is expected to occur except at reset.
It describes it as result of a step change in rotational position
which feels like something that doesn't happen other than when
device is reset... Could be wrong though!

> | D2  |  Velocity exceeds maximum tracking rate
This one is I think just a threshold on velocity matching what the
hardware is capable of.

> | D1  |  Phase error exceeds phase lock range


> | D0  |  Configuration parity error
This one has nothing to do with the data. I'd spit a log message
out if you see it. Chances are device is dead. You 'could' keep
a cache of what you think should be in the registers and try
a full reset and re configuration.  Like any other parity error
though you will want to have something watching for repeats that
mean the part needs replacing.

> 
> David Lechner (19):
>   dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
>   staging: iio: Documentation: document IIO resolver AD2S1210 sysfs
>     attributes
>   staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
>   staging: iio: resolver: ad2s1210: fix not restoring sample gpio in
>     channel read
>   staging: iio: resolver: ad2s1210: fix probe
>   staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
>   staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
>   staging: iio: resolver: ad2s1210: use devicetree to get fclkin
>   staging: iio: resolver: ad2s1210: use regmap for config registers
>   staging: iio: resolver: ad2s1210: add debugfs reg access
>   staging: iio: resolver: ad2s1210: remove config attribute
>   staging: iio: resolver: ad2s1210: rework gpios
>   staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
>   staging: iio: resolver: ad2s1210: refactor setting excitation
>     frequency
>   staging: iio: resolver: ad2s1210: read excitation frequency from
>     control register
>   staging: iio: resolver: ad2s1210: rename fexcit attribute
>   staging: iio: resolver: ad2s1210: convert resolution to devicetree
>     property
>   staging: iio: resolver: ad2s1210: add phase_lock_range attributes
>   staging: iio: resolver: ad2s1210: add triggered buffer support
> 
>  .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 +++
>  .../sysfs-bus-iio-resolver-ad2s1210           | 109 ++
>  drivers/staging/iio/resolver/Kconfig          |   1 +
>  drivers/staging/iio/resolver/ad2s1210.c       | 948 +++++++++++-------
>  4 files changed, 857 insertions(+), 351 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
>  create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
> 

