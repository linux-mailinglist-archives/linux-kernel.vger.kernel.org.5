Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B07F939E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKZQBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:01:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74C0AB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:01:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9C7C433C8;
        Sun, 26 Nov 2023 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701014514;
        bh=ojbTytmDrmvBpWToBOJDxQo1SDGxW+cyWawjA18EqUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TPiKmWHwFq1+fCiMUADHi8EYlSLTCwhuZwzeo2tSvtp5udI5SU1wbXdEfPUSCbiRm
         zJTaVpVgm2YteiZxh7/QkPD7AzEaLdy0x1CNFns344zsxn+gA+Y/IVAg5TCfZ/z2mT
         ClXTlhlLGnsIBbyTULGTl+A9bWNSkacsLeMfHN7CL1zfo/AzV6APE+szm8A0dMMgXo
         0oiZUtJrbJ+1HpVy2mPl2FsrlmvSSpp1MHtLHHzV6p0PwerAfp2k2JWJaLhRIBghGM
         RNQnN8A5XhbZ0gloyzERmDRkejBd5pgr68E2r1MxmDQvLvTyB7SEdV87EAPlNvJ8Zb
         PvqDHx4f1F5dw==
Date:   Sun, 26 Nov 2023 16:01:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature
 sensor
Message-ID: <20231126160147.65636cc5@jic23-huawei>
In-Reply-To: <CAKv63us6yi2qaGLi3UgT=pfQ7QnxyM02FreD-qHnzTnKGSkRFw@mail.gmail.com>
References: <cover.1700648164.git.cmo@melexis.com>
        <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
        <20231125175318.25c0d6ea@jic23-huawei>
        <CAKv63us6yi2qaGLi3UgT=pfQ7QnxyM02FreD-qHnzTnKGSkRFw@mail.gmail.com>
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

On Sat, 25 Nov 2023 22:26:46 +0100
Crt Mori <cmo@melexis.com> wrote:

> On Sat, 25 Nov 2023 at 18:53, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 22 Nov 2023 11:24:06 +0100
> > Crt Mori <cmo@melexis.com> wrote:
> >  
> > > MLX90635 is an Infra Red contactless temperature sensor most suitable
> > > for consumer applications where measured object temperature is in range
> > > between -20 to 100 degrees Celsius. It has improved accuracy for
> > > measurements within temperature range of human body and can operate in
> > > ambient temperature range between -20 to 85 degrees Celsius.
> > >
> > > Driver provides simple power management possibility as it returns to
> > > lowest possible power mode (Step sleep mode) in which temperature
> > > measurements can still be performed, yet for continuous measuring it
> > > switches to Continuous power mode where measurements constantly change
> > > without triggering.
> > >
> > > Signed-off-by: Crt Mori<cmo@melexis.com>  
> > Hi Crt,
> >
> > Very nice. A few minor bits inline.
> >
> > Note (as normal for me), I haven't sanity checked any calibration maths - just assuming
> > you got that bit right as don't want to spend ages comparing datasheet maths to what
> > you have coded up + I'm not sure I can get the datasheet anyway :)
> >
> > Jonathan
> >  
> Hi Jonathan,
> Maths I have unit tests where I did floating point (which will be
> released as embedded library same as for 90632) to integer conversion
> and ensure that the delta is less then the error of the sensor. So
> math I take full responsibility :)
> 
> Datasheet will be public probably in March, when hopefully the sensor
> is already part of the main Android kernel as well. But your review is
> anyway very valuable and detailed. Thanks for all the remarks - there
> is just one discussion below I would love to complete for future
> reference.
> 
> Best regards,
> Crt
> >> ...
> > > +     if (ret < 0) {
> > > +             dev_err(&data->client->dev, "Powering EEPROM failed\n");
> > > +             return ret;
> > > +     }
> > > +     usleep_range(MLX90635_TIMING_EE_ACTIVE_MIN, MLX90635_TIMING_EE_ACTIVE_MAX);
> > > +
> > > +     regcache_mark_dirty(data->regmap);
> > > +
> > > +     ret = regcache_sync(data->regmap);
> > > +     if (ret < 0) {
> > > +             dev_err(&data->client->dev,
> > > +                     "Failed to cache everything: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret = regcache_sync_region(data->regmap, MLX90635_EE_Ha, MLX90635_EE_Gb);  
> >
> > Why is this needed given you just synced the whole thing?
> >  
> 
> Well, this is the discussion I wanted to have. I expected
> regcache_sync to perform i2c read of all the read_regs defined in
> regmap to get them to cache - but it didn't. Then I expected the same
> from sync_region, but it didn't, so I manually read them below.
> 
> So discussion I want to have is: why would we regcache_sync, if no
> reads are performed? 

I think the intent is to minimise the reads from the device.

If we look at the implmentation (which is probably the default here)
you can see that it's only doing writes where non volatile registers are out
of date. I don't think there are any reads from the device done.
https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regcache.c#L310

If you want to ensure the cache contains the correct values
a read will need to be forced.

> And second one is why would we return EBUSY for
> volatile register range when cache_only is active?

I'd say that's correct. We are in a state where any attempt to read a
volatile register can't get the current correct value, so returning
-EBUSY which basically says come back later is the correct
behaviour.

> 
> Current driver implementation is very specific in bypassing all these,
> so I am quite certain this regcache_sync_region here is not needed and
> below regmap_async_complete as well, but I cannot be sure, since
> regcache_sync doesn't really do the job I would expect it to do. I
> looked into the code, but could not find the reason, why I do not see
> any reads on oscilloscope and why I need to physically read registers
> below, so that they are cached. 

I agree the docs are a little vague, but looking at the code there
aren't any reads, only writes to the device so I think this behaviour
is by design.  The cache is considered correctly synced if an entry
is simply not cached (valid I suppose as no wrong values cached).

> regmap totally knows which registers
> it should cache, but it does not at init, nor at regcache_sync
> request. And if you remember in 90632 I had a similar remark, but
> could not reproduce as EEPROM was readable in most powermodes (well
> all used in driver), now I checked with scope and since I know this
> chip does not allow EEPROM reading during the step sleep mode, so
> everything was much easier to conclude.

I think the key here is that the cache isn't really meant to provide
access to values when the device is powered down; it is there to
reduce bus traffic. Hence the last thing you normally want to do is
read back all the values.  There is a way to get that to happen
on init though.

You want to hit this path:
https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regcache.c#L183
I think you set num_reg_defaults_raw = Number of registers, but don't provide any
default values, so as to indicate they should be read from the device.


> ...
> > > +     mlx90635 = iio_priv(indio_dev);
> > > +     i2c_set_clientdata(client, indio_dev);
> > > +     mlx90635->client = client;
> > > +     mlx90635->regmap = regmap;
> > > +     mlx90635->powerstatus = MLX90635_PWR_STATUS_SLEEP_STEP;
> > > +
> > > +     mutex_init(&mlx90635->lock);
> > > +     indio_dev->name = id->name;  
> >
> > Not keen on doing this as it can be fragile if id and of tables get out of sync
> > or we are using backwards compatibles in dt bindings.
> >
> > Given only one part supported, just hard code the name for now.
> >  
> 
> Can you elaborate? Because I have the same thing in 90632 and I would
> fix there as well. I assumed this is for linking to dt, to ensure it
> is defined there?

Exactly, the dt table and the i2c_id one can end up out of sync - perhaps
deliberately and when compatible = "device1", "device2" is used
I'm not sure exactly which one will turn up in this id if the dt table
only includes device2.

So rather than arguing that out and pinning down the expected behaviour
we tend to avoid using id->name in new drivers.
It's probably not broken to do so but lets make life easier for any
future cases by not doing it.


> 
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > +     indio_dev->info = &mlx90635_info;
> > > +     indio_dev->channels = mlx90635_channels;
> > > +     indio_dev->num_channels = ARRAY_SIZE(mlx90635_channels);
> > > +  
> ...
> >  
> > > +     if (MLX90635_DSP_VERSION(dsp_version) == MLX90635_ID_DSPv1) {
> > > +             dev_dbg(&client->dev,
> > > +                     "Detected DSP v1 calibration %x\n", dsp_version);
> > > +     } else if ((dsp_version & MLX90635_DSP_FIXED) == MLX90635_DSP_FIXED) {  
> >
> > FIELD_GET() for that bit then just check if it is 0 or 1
> >  
> > > +             dev_dbg(&client->dev,
> > > +                     "Detected Unknown EEPROM calibration %lx\n", MLX90635_DSP_VERSION(dsp_version));
> > > +     } else {
> > > +             dev_err(&client->dev,
> > > +                     "Wrong fixed top bit %lx (expected 0x8X0X)\n",
> > > +                     dsp_version & MLX90635_DSP_FIXED);  
> >
> > I'd like to understand what breaks if this happens but we carry on anyway?
> > I'd 'hope' that any future DSP version is backwards compatible or that there was some way to know if
> > the difference between backwards compatible versions and ones that aren't.
> >  
> The top bit in high nibble is fixed to 1, to ensure that we have
> endianness correct in the wild. We did the same later on in 90632
> where we had plenty of trouble the way people read 16 bits. So if that
> top bit is not there (bottom nibble has it hardcoded to 0), then for
> certain we do not have the correct chip. And as for compatible DSP
> versions: when we release incompatible one, I will upgrade the driver,
> otherwise we have some more slack in the driver to keep on working,
> because that was also lesson learnt from my side in 90632 as there are
> compatible DSP versions possible and used, but we are still honest and
> bump also the DSP version here.

So there isn't a clear division between 'minor and major' version numbers
as used in many similar cases? Minor can tick without a driver change as the
interface only grows (nothing breaks), but major implies incompatible.

Anyhow, sounds like you carry on with just a dbg print if an unexpected version
seen. That's fine.


Jonathan


