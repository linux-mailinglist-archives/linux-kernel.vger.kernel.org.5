Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FA7ACAE4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjIXRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIXRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:15:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F0C6;
        Sun, 24 Sep 2023 10:15:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF742C433C7;
        Sun, 24 Sep 2023 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695575718;
        bh=sVhGlOD14LMROhYEMLTXgJ2FHDbAiYFrk0XMDjt5gpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Go7f/62peC6gUtxUozVC56G0Vym5HJPl9O5fY1aaMKfHyKGNIp/EKDW1s+Cgy/0M6
         ACpBdaC44RW9makSGqkk9Y7FKU0CPa2AC/nu0WfRd+ZykRjk5vY97tKNJGjw37dhRE
         LOR/5fcIBH9IqCdsmVdYtLYM91WHCLjuNcUWlZOzf7pc6DE4sLy/nmNDMXIQKU4+Gt
         imD96HBRIoKwV/LCc2M/uRz4scE9ZfO1q3tz4fJV6YazJpVYhaodqU8qKKPZSEEbrN
         ghRyyOaJV6J8vjkx3sqjVIdKBid0Gj1cF93Kb3mCJGtvGgQYKe0Dx2fUdLnV7laQeK
         7rhE0JfmnCxoQ==
Date:   Sun, 24 Sep 2023 18:15:10 +0100
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
Subject: Re: [PATCH v2 02/19] staging: iio: Documentation: document IIO
 resolver AD2S1210 sysfs attributes
Message-ID: <20230924181510.1fb89e74@jic23-huawei>
In-Reply-To: <20230921144400.62380-3-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-3-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds documentation for the device-specific sysfs attributes of the
> iio/resolver/ad2s1210 driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Hi David,

I'm fine with carrying these docs in staging, but I think we need to resolve
mapping as many of these as possible to standard ABI if we can for
all the normal reasons about software having no idea how to deal
with custom ABI.

Anyhow, I'll use this as an opportunity to comment on the individual
files.



> ---
>  .../sysfs-bus-iio-resolver-ad2s1210           | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210 b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
> new file mode 100644
> index 000000000000..32890c85168e
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
> @@ -0,0 +1,109 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_mis_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Mismatch
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.

I mention in the cover letter, but I wonder if we can map this to a threshold
on a differential channel between the cosine and sine channels (use labels for
the channels to identify them). It's a stretch but perhaps better than
completely custom as at least we have event tooling to read it.

If nothing else we need these to have standard units and the
unit to be obvious from the name.  Voltages in IIO are mV (because
we copied hwmon a long time back)

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_ovr_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Overrange
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.
Not clear what this actually is to me, but it's a threshold on something!
Probably two channels which is always a pain as we'll have indicate two events
if they are enabled.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_rst_max_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Reset Maximum
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.

No idea what this one is.  What does 'reset' have to do with it?
Ah I went and looked.  This is the reset value used for the running maximum / minimum
values.  They matter because they fault detection is difference between the values
and if we say init the minimum to lower than actually seen that will make the
error more likely (I think!).

So not sure what we map this to.  Maybe this just has to be custom ABI but
it should be associated with the threshold event - though I'd not registered
that's on a running minimum and maximum rather than some 'windowed' version
for recent values...

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_rst_min_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Reset Minimum
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fault

This fails the sniff test for a sysfs attribute giving multiple things.
If we do use this sort of reporting rather than an event, maybe a fault
directory (sysfs group) with 8 files in it.
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a hex value containing the fault bit flags.
> +
> +		Bit	Description
> +		---	-----------
> +		D7	Sine/cosine inputs clipped
> +		D6	Sine/cosine inputs below LOS threshold
> +		D5	Sine/cosine inputs exceed DOS overrange threshold
> +		D4	Sine/cosine inputs exceed DOS mismatch threshold
> +		D3	Tracking error exceeds LOT threshold
> +		D2	Velocity exceeds maximum tracking rate
> +		D1	Phase error exceeds phase lock range
> +		D0	Configuration parity error
> +
> +		Writing any value will clear any fault conditions.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/excitation_frequency

Hmm. I though we already had this.  Turns up in various types of device.
But nope, can't find it.  I'm fine with this one being added to the main ABI.

> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Excitation Frequency in Hz. Writing
> +		sets the Excitation Frequency and performs a software reset on
> +		the device to apply the change. Valid values are 2000 (2kHz) to
> +		20000 (20kHz).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/los_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Loss of Signal Reset Threshold
> +		value. Writing sets the value. Valid values are 0 (0V) to
> +		127 (4.826V). To convert the value to volts, multiply by 0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/lot_high_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Loss of Position Tracking Detection
> +		High Threshold value. Writing sets the value. Valid values are
> +		0 (0 deg) to 127 (9/18/45 deg). The interpretation of the value
> +		depends on the selected resolution. To convert the value to
> +		degrees, multiply by 0.35 for 10-bit resolution, multiply by
> +		0.14 for 12-bit resolution or multiply by 0.09 for 14 and 16-bit
> +		resolution.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/lot_low_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Loss of Position Tracking Detection
> +		Low Threshold value. Writing sets the value. Valid values are
> +		0 (0 deg) to 127 (9/18/45 deg). The interpretation of the value
> +		depends on the selected resolution. To convert the value to
> +		degrees, multiply by 0.35 for 10-bit resolution, multiply by
> +		0.14 for 12-bit resolution or multiply by 0.09 for 14 and 16-bit
> +		resolution.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/phase_lock_range

For what it's worth Phases in IIO (phase_raw in ABI docs) are defined
in radians so this will want to be appropriately scaled if we keep it around.

This one feels like a threshold on phase which is already in the IIO ABI
(for 3 phase power monitors IIRC)

Jonathan


> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Phase lock range in degrees. Writing
> +		sets the value in the configuration register.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/phase_lock_range_available
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the possible values for the phase_lock_range
> +		attribute, namely 44 and 360.

