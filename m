Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC97C016E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjJJQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjJJQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A41719;
        Tue, 10 Oct 2023 09:07:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B71FC433C7;
        Tue, 10 Oct 2023 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954037;
        bh=I4Mq5KNftOzU1QBiwC1aaENLB1oSctS1fFgLbP5jObs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C8pMnBKmhfF9gR8nBxQrzAvEp/Cv9arKFw390ivCleHFQ1/MAASwykuxa+TwODwId
         2VFfDi1rKlynETRTcGzP8V9eApjafe4wU1/5M5/LHF6DkrBBqPlDJ8EHkhX+/a9gKd
         nNrlbSb2IcDLJzbKAPUnB22snxRfHCEdrIXPe+jZqpnCG1ppqF8vgDJS2PCL2+Rm8N
         SKQH3yaB1axT+jUb3IzlWRVsnt3r9rVQSwIC1V8MjIfOEFgdvPwW38kfO42xgcNXYZ
         zXz+Zpw/ANPXI++kVrdFTtvEa7LdY3icNOlDGMygaUdXVpH3gj8QyCLHcaAnToFqVI
         erLAvSPAGpz4A==
Date:   Tue, 10 Oct 2023 17:07:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/17] staging: iio: resolver: ad2s1210: add
 register/fault support summary
Message-ID: <20231010170727.524a5820@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-14-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-14-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The ad2s1210 driver shoe-horns the register and fault support into IIO
> events. The mapping between the registers/faults and the events is not
> obvious. To save users from having to read the entire driver to figure
> out how to use it, add a summary of the register/fault support to the
> top of the file.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
This is indeed useful to have.

Applied.

Thanks,

Jonathan

> ---
> 
> v4 changes: New patch in v4.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 40 +++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index d9d51bbbade8..51490fea1647 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -4,7 +4,47 @@
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
>   * Copyright (c) 2023 BayLibre, SAS
> + *
> + * Device register to IIO ABI mapping:
> + *
> + * Register                    | Addr | IIO ABI (sysfs)
> + * ----------------------------|------|-------------------------------------------
> + * DOS Overrange Threshold     | 0x89 | events/in_altvoltage0_thresh_rising_value
> + * DOS Mismatch Threshold      | 0x8A | events/in_altvoltage0_mag_rising_value
> + * DOS Reset Maximum Threshold | 0x8B | events/in_altvoltage0_mag_rising_reset_max
> + * DOS Reset Minimum Threshold | 0x8C | events/in_altvoltage0_mag_rising_reset_min
> + * LOT High Threshold          | 0x8D | events/in_angl1_thresh_rising_value
> + * LOT Low Threshold [1]       | 0x8E | events/in_angl1_thresh_rising_hysteresis
> + * Excitation Frequency        | 0x91 | out_altvoltage0_frequency
> + * Control                     | 0x92 | *as bit fields*
> + *   Phase lock range          | D5   | events/in_phase0_mag_rising_value
> + *   Hysteresis                | D4   | in_angl0_hysteresis
> + *   Encoder resolution        | D3:2 | *not implemented*
> + *   Resolution                | D1:0 | *device tree: assigned-resolution-bits*
> + * Soft Reset                  | 0xF0 | [2]
> + * Fault                       | 0xFF | *not implemented*
> + *
> + * [1]: The value written to the LOT low register is high value minus the
> + * hysteresis.
> + * [2]: Soft reset is performed when `out_altvoltage0_frequency` is written.
> + *
> + * Fault to event mapping:
> + *
> + * Fault                                   |    | Channel     | Type   | Direction
> + * ----------------------------------------|----|---------------------------------
> + * Sine/cosine inputs clipped [3]          | D7 | altvoltage1 | mag    | either
> + * Sine/cosine inputs below LOS            | D6 | altvoltage0 | thresh | falling
> + * Sine/cosine inputs exceed DOS overrange | D5 | altvoltage0 | thresh | rising
> + * Sine/cosine inputs exceed DOS mismatch  | D4 | altvoltage0 | mag    | rising
> + * Tracking error exceeds LOT              | D3 | angl1       | thresh | rising
> + * Velocity exceeds maximum tracking rate  | D2 | anglvel0    | mag    | rising
> + * Phase error exceeds phase lock range    | D1 | phase0      | mag    | rising
> + * Configuration parity error              | D0 | *writes to kernel log*
> + *
> + * [3]: The chip does not differentiate between fault on sine vs. cosine so
> + * there will also be an event on the altvoltage2 channel.
>   */
> +
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/clk.h>
> 

