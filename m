Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5F7A6752
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjISOxw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjISOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:53:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C52FBE;
        Tue, 19 Sep 2023 07:53:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rql5G0QwDz67VkC;
        Tue, 19 Sep 2023 22:52:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 15:53:41 +0100
Date:   Tue, 19 Sep 2023 15:53:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230919155340.0000076f@Huawei.com>
In-Reply-To: <c987f401-81c4-00e5-51a7-88a6a38a2ca2@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
        <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
        <20230917113518.7c4bb1a0@jic23-huawei>
        <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
        <c987f401-81c4-00e5-51a7-88a6a38a2ca2@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 14:28:29 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/18/23 15:56, Matti Vaittinen wrote:
> > On 9/17/23 13:35, Jonathan Cameron wrote:  
> >> On Fri, 15 Sep 2023 09:56:19 +0300
> >> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>  
> >>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
> >>> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
> >>> averaging and internal FIFO. The sensor does also provide temperature
> >>> measurements.
> >>>
> >>> Sensor does also contain IIR filter implemented in HW. The data-sheet
> >>> says the IIR filter can be configured to be "weak", "middle" or
> >>> "strong". Some RMS noise figures are provided in data sheet but no
> >>> accurate maths for the filter configurations is provided. Hence, the IIR
> >>> filter configuration is not supported by this driver and the filter is
> >>> configured to the "middle" setting (at least not for now).
> >>>
> >>> The FIFO measurement mode is only measuring the pressure and not the
> >>> temperature. The driver measures temperature when FIFO is flushed and
> >>> simply uses the same measured temperature value to all reported
> >>> temperatures. This should not be a problem when temperature is not
> >>> changing very rapidly (several degrees C / second) but allows users to
> >>> get the temperature measurements from sensor without any additional 
> >>> logic.
> >>>
> >>> This driver allows the sensor to be used in two muitually exclusive 
> >>> ways,
> >>>
> >>> 1. With trigger (data-ready IRQ).
> >>> In this case the FIFO is not used as we get data ready for each 
> >>> collected
> >>> sample. Instead, for each data-ready IRQ we read the sample from sensor
> >>> and push it to the IIO buffer.
> >>>
> >>> 2. With hardware FIFO and watermark IRQ.
> >>> In this case the data-ready is not used but we enable watermark IRQ. At
> >>> each watermark IRQ we go and read all samples in FIFO and push them 
> >>> to the
> >>> IIO buffer.
> >>>
> >>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> 
> ...
> 
> >>> +
> >>> +static const unsigned long bm1390_scan_masks[] = {
> >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0  
> >> Why?  Doesn't look hard to support just one or the other?
> >> Normally we only do this sort of limitation when there is a heavily
> >> optimized read routine for a set of channels and it is better
> >> to grab them all and throw away the ones we don't care about.
> >> That doesn't seem to be true here. So if the fifo grabbed both
> >> temp and pressure it would makes sense here, but doesn't seem
> >> like it does.  
> > 
> > I have a feeling I have misunderstood how this mask works. I have 
> > assumed all the channels with corresponding mask bit _can_ be enabled 
> > simultaneously, but I have not understood they _must_ all be enabled. I 
> > think I must go back studying this, but if all channels really _must_ be 
> > enabled, then you are correct. It actually makes a lot of sense to 
> > support the pressure values alone, as, according to the data-sheet, the 
> > HW is doing a "MEMS temperature compensation" to the pressure values. 
> > So, my assuimption is the temperature data may not be required to be 
> > captured.
> > 
> > This also means I should revise the scan masks for the BU27008, BU27010 
> > and BU27034 light sensors as I don't think all the users want all the 
> > channels enabled. I wonder how I have not noticed any problems when I 
> > tested those things - did I really always enable all the channels...? @_@
> > 
> > Anyways, Thanks.  
> 
> Hi Jonathan,
> 
> There's something in IIO scan_masks / buffer demuxing that I don't quite 
> understand. I noticed following things:
> 
> 1) Strict available scan mask check seems to be in use only for 
> INDIO_BUFFER_HARDWARE stuff.
> 
> https://elixir.bootlin.com/linux/v6.6-rc2/source/drivers/iio/industrialio-buffer.c#L881
> 

That is referring to the fact that you can't start the buffer if it
doesn't match (because we can't mess with the data stream in
that type of buffer as we don't necessarily see it in software!)

> So, the:
> 
>  >>> +static const unsigned long bm1390_scan_masks[] = {
>  >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0  
> 
> is not exclusive for BM1390 as long as it is not setting the 
> INDIO_BUFFER_HARDWARE.
> 
> My test seems to agree with the code:
> 
> // Only enable the temperature:
> root@arm:/sys/bus/iio/devices/iio:device0# echo 1 > 
> scan_elements/in_temp_en
> 
> // Run the geneeric buffer without -a:
> root@arm:/sys/bus/iio/devices/iio:device0# /iio_generic_buffer -c 20 -N 
> 0 -t bm1390data-rdy-dev0
> iio device number being used is 0
> iio trigger number being used is 0
> /sys/bus/iio/devices/iio:device0 bm1390data-rdy-dev0
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 22968.750000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23000.000000
> 23031.250000
> 23000.000000
> 23000.000000
> root@arm:/sys/bus/iio/devices/iio:device0#

> 
> In above case the temperature values and only the temperature values 
> were shown. I must admit I did not spend enough time with the 
> iio_generic_buffer.c or IIO demuxing code to really understand all the 
> details (I got headache very quickly ;) ). I still believe the 
> iio_generic_buffer expects to see only the enabled channel data in the 
> buffer - so, it seems to me the kernel is also only adding the enabled 
> channel data to the buffer. Also, judging the values, the demuxing is 
> correctly extracting the temperature data from data the driver pushes here:
> 
> iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
> 
> The bm1390 driver as sent in v2 does not do demuxing but always pushes 
> whole chunk of data and trusts IIO to do demuxing.

Yup. That should work.  But in this case you can trivially decide not to read
or fill in the temperature and hence save some bus cycles.

> 
> 2) I noticed the 'available_scan_masks' was marked as an optional field. 
> So, I think that if there is no restrictions to which of the channels 
> can be enabled, then we can omit setting it. This is what I tried.
> 
> It appears that when we do not populate the 'available_scan_masks' with the:
>  >>> +static const unsigned long bm1390_scan_masks[] = {
>  >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0  
> 
> things change. When I tested enabling only temperature and ran the 
> iio_generic_buffer -c 20 -N 0 -t bm1390data-rdy-dev0 - the reported 
> values seemed completely random.

You need to pack the data correctly yourself in the driver.
So it adds small amount of code complexity but potentially saves bus
traffic.


> 
> When I initialized the pressure data in driver:
> data->buf.pressure = 1;
> before doing the:
> iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
> 
> I saw following:
> 
> root@arm:/# cd /sys/bus/iio/devices/iio\:device0
> root@arm:/sys/bus/iio/devices/iio:device0# echo 1 > 
> scan_elements/in_temp_en
> root@arm:/sys/bus/iio/devices/iio:device0# /iio_generic_buffer -c 20 -N 
> 0 -t bm1390data-rdy-dev0
> iio device number being used is 0
> iio trigger number being used is 0
> /sys/bus/iio/devices/iio:device0 bm1390data-rdy-dev0
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> 8000.000000
> root@arm:/sys/bus/iio/devices/iio:device0# cat in_temp_scale
> 31.250000
> 
> If we calculate 8000/31.250000 we will get value 256. This looks like 
> value '1' in BE16 format.

> 
> Based on this experimenting (and headache obtained from reading the 
> demuxing code) - the IIO framework does not do channel demuxing if the 
> 'available_scan_masks' is not given? To me this was somewhat unexpected.

Yes.  If you don't tell it what channel setups are available (note there can
be lots) you are saying that we support any random combination and have
to do the data packing by hand.

> 
> Finally, when the watermark IRQ is used, we can't omit reading the 
> pressure data because clearing the WMI is done based on the pressure 
> data in FIFO.

Hmm. That is a good reason to keep the available scan masks set.
Add a comment on that next to the mask.

> 
> So, I would propose we do:
> 
> static const unsigned long bm1390_scan_masks[] = {
> 	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
> 	BIT(BM1390_CHAN_PRESSURE), 0

Makes sense given need to read the pressure channel.
> 
> which better reflects what the hardware is capable of - and, unless I am 
> missing something, also allows us to offload the buffer demuxing to the IIO.
> 
> Still, as mentioned in 1), the
> 
>  >>> +static const unsigned long bm1390_scan_masks[] = {
>  >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0  
> 
> does not seem to prevent enabling only the temperature channel - so in 
> the driver buffer handler we still must unconditionally read the 
> pressure data regardles the active_scan_mask.

active_scan_mask should match the above - it's separate from what is enabled.
active_scan_mask is on the data capture side of the demux - the buffers
are then fed repacked data reflecting what is enabled.

> 
> >>  
> >>> +     * called as a result of a read operation from userspace and hence
> >>> +     * before the watermark interrupt was triggered, take a timestamp
> >>> +     * now. We can fall anywhere in between two samples so the error 
> >>> in this
> >>> +     * case is at most one sample period.
> >>> +     * We need to have the IRQ disabled or we risk of messing-up
> >>> +     * the timestamps. If we are ran from IRQ, then the
> >>> +     * IRQF_ONESHOT has us covered - but if we are ran by the
> >>> +     * user-space read we need to disable the IRQ to be on a safe
> >>> +     * side. We do this usng synchronous disable so that if the
> >>> +     * IRQ thread is being ran on other CPU we wait for it to be
> >>> +     * finished.  
> >>
> >> That irq disable is potentially expensive.
> >> Why not just pass the current timestamp into the __bm1390_fifo_flush >
> >> The locks should prevent other races I think..  
> > 
> > Gah. I hate you Jonathan ;) (Not really!)
> > 
> > Actually, thank you (as always) for pointing this out. I don't instantly 
> > see why it wouldn't work, but going throught the IRQ races is never 
> > trivial (for me). It's work I've learned not to do at afternoon as my 
> > brains work better at the morning :) So, I will still go through this as 
> > a first thing tomorrow when I start my work day...  
> 
> After staring this for a while, I see no reason why we couldn't do as 
> you suggested. Thanks! It really improves this :)

No problem.

Jonathan

> 
> Yours,
> 	-- Matti
> 

