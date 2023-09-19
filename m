Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B947A672B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjISOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjISOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:46:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9FF4;
        Tue, 19 Sep 2023 07:46:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rqkv06FVFz6HJh1;
        Tue, 19 Sep 2023 22:43:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 15:45:56 +0100
Date:   Tue, 19 Sep 2023 15:45:55 +0100
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
Message-ID: <20230919154555.00002f22@Huawei.com>
In-Reply-To: <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
        <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
        <20230917113518.7c4bb1a0@jic23-huawei>
        <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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

On Mon, 18 Sep 2023 15:56:42 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/17/23 13:35, Jonathan Cameron wrote:
> > On Fri, 15 Sep 2023 09:56:19 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
> >> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
> >> averaging and internal FIFO. The sensor does also provide temperature
> >> measurements.
> >>
> >> Sensor does also contain IIR filter implemented in HW. The data-sheet
> >> says the IIR filter can be configured to be "weak", "middle" or
> >> "strong". Some RMS noise figures are provided in data sheet but no
> >> accurate maths for the filter configurations is provided. Hence, the IIR
> >> filter configuration is not supported by this driver and the filter is
> >> configured to the "middle" setting (at least not for now).
> >>
> >> The FIFO measurement mode is only measuring the pressure and not the
> >> temperature. The driver measures temperature when FIFO is flushed and
> >> simply uses the same measured temperature value to all reported
> >> temperatures. This should not be a problem when temperature is not
> >> changing very rapidly (several degrees C / second) but allows users to
> >> get the temperature measurements from sensor without any additional logic.
> >>
> >> This driver allows the sensor to be used in two muitually exclusive ways,
> >>
> >> 1. With trigger (data-ready IRQ).
> >> In this case the FIFO is not used as we get data ready for each collected
> >> sample. Instead, for each data-ready IRQ we read the sample from sensor
> >> and push it to the IIO buffer.
> >>
> >> 2. With hardware FIFO and watermark IRQ.
> >> In this case the data-ready is not used but we enable watermark IRQ. At
> >> each watermark IRQ we go and read all samples in FIFO and push them to the
> >> IIO buffer.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Hi Matti,
> > 
> > I think this is coming together nicely. A few comments inline.  
> 
> Thanks for the review (once again) :)
> 
> >   
> >>
> >> ---
> >> Revision history:
> >> v1 => v2:
> >> - prefer s64 over int64_t
> >> - drop not needed handling of 2's complements
> >> - plenty of styling changes
> >> - drop dead code (write_raw)
> >> - fix typos in comments
> >> - explain trigger and FIFO usage in commit message
> >> - do better job at cheking the return values
> >> - ensure there's no race when checking if triggered buffer is used
> >>    before enabling the FIFO
> >> - print warning if register read fails at IRQ handler
> >> - drop unnecessary warning if IRQ is not given
> >> - explain why we prefer asynchronous probing
> >> ---  
> >   
> >> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> >> new file mode 100644
> >> index 000000000000..d3cc229d1688
> >> --- /dev/null
> >> +++ b/drivers/iio/pressure/rohm-bm1390.c
> >> @@ -0,0 +1,899 @@  
> > 
> > ...
> >   
> >> +
> >> +static const unsigned long bm1390_scan_masks[] = {
> >> +	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0  
> > Why?  Doesn't look hard to support just one or the other?
> > Normally we only do this sort of limitation when there is a heavily
> > optimized read routine for a set of channels and it is better
> > to grab them all and throw away the ones we don't care about.
> > That doesn't seem to be true here. So if the fifo grabbed both
> > temp and pressure it would makes sense here, but doesn't seem
> > like it does.  
> 
> I have a feeling I have misunderstood how this mask works. I have 
> assumed all the channels with corresponding mask bit _can_ be enabled 
> simultaneously, but I have not understood they _must_ all be enabled. I 
> think I must go back studying this, but if all channels really _must_ be 
> enabled, then you are correct. It actually makes a lot of sense to 
> support the pressure values alone, as, according to the data-sheet, the 
> HW is doing a "MEMS temperature compensation" to the pressure values. 
> So, my assuimption is the temperature data may not be required to be 
> captured.
> 
> This also means I should revise the scan masks for the BU27008, BU27010 
> and BU27034 light sensors as I don't think all the users want all the 
> channels enabled. I wonder how I have not noticed any problems when I 
> tested those things - did I really always enable all the channels...? @_@

If you didn't enable them all, the IIO core would then grab them all anyway
but demux the data out that you actually wanted.  So you would only notice
if you looked at the data transfers happening which were probably larger
than necessary.


> 
> Anyways, Thanks.

> >> +static int bm1390_read_raw(struct iio_dev *idev,
> >> +			   struct iio_chan_spec const *chan,
> >> +			   int *val, int *val2, long mask)
> >> +{
> >> +	struct bm1390_data *data = iio_priv(idev);
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		if (chan->type == IIO_TEMP) {
> >> +			*val = 31;
> >> +			*val2 = 250000;
> >> +
> >> +			return IIO_VAL_INT_PLUS_MICRO;
> >> +		} else if (chan->type == IIO_PRESSURE) {
> >> +			*val = 0;
> >> +			/*
> >> +			 * pressure in hPa is register value divided by 2048.
> >> +			 * This means kPa is 1/20480 times the register value,
> >> +			 * which equals to 48828.125 * 10 ^ -9
> >> +			 * This is 48828.125 nano kPa.
> >> +			 *
> >> +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
> >> +			 * get 48828 - which means we lose some accuracy. Well,
> >> +			 * let's try to live with that.
> >> +			 */
> >> +			*val2 = 48828;
> >> +
> >> +			return IIO_VAL_INT_PLUS_NANO;  
> > 
> > IIO_VAL_FRACTIONAL?  Mind you I'm not sure that will result in enough precision
> > either here.   For in kernel use it will have full precision though as will be
> > kept as a fraction.  I guess question of whether it is worse than what you have
> > here.  There hasn't been much demand for IIO_VAL_INTO_PLUS_PICO, but if we have
> > to look at that we can - with proviso that existing userspace software won't know
> > anything about it.  
> 
> I must take a look at the IIO_VAL_FRACTIONAL. I think either it or the 
> NANO at this point. I have no understanding what is the precision that 
> is enough. Hmm.. Would adding the PICO really require a change in 
> user-space or could we hide it in-kernel when formatting the value we 
> emit via sysfs?

More digits would turn up :) Otherwise you are correct and I wasn't thinking
this through. You'd hope that the code reading them would be fine.

I had a patch adding to precision of IIO_VAL_FRACTION_LOG2 a while
back on basis we'd 'get away with it'.
https://lore.kernel.org/linux-iio/20220626122938.582107-2-jic23@kernel.org/

Not sure I ever picked it up though :( 


...

> 
> >   
> >> +	 * called as a result of a read operation from userspace and hence
> >> +	 * before the watermark interrupt was triggered, take a timestamp
> >> +	 * now. We can fall anywhere in between two samples so the error in this
> >> +	 * case is at most one sample period.
> >> +	 * We need to have the IRQ disabled or we risk of messing-up
> >> +	 * the timestamps. If we are ran from IRQ, then the
> >> +	 * IRQF_ONESHOT has us covered - but if we are ran by the
> >> +	 * user-space read we need to disable the IRQ to be on a safe
> >> +	 * side. We do this usng synchronous disable so that if the
> >> +	 * IRQ thread is being ran on other CPU we wait for it to be
> >> +	 * finished.  
> > 
> > That irq disable is potentially expensive.
> > Why not just pass the current timestamp into the __bm1390_fifo_flush >
> > The locks should prevent other races I think..  
> 
> Gah. I hate you Jonathan ;) (Not really!)
> 
> Actually, thank you (as always) for pointing this out. I don't instantly 
> see why it wouldn't work, but going throught the IRQ races is never 
> trivial (for me). It's work I've learned not to do at afternoon as my 
> brains work better at the morning :) So, I will still go through this as 
> a first thing tomorrow when I start my work day...

...


> >   
> >> +
> >> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
> >> +					      &iio_pollfunc_store_time,
> >> +					      &bm1390_trigger_handler,
> >> +					      &bm1390_buffer_ops);  
> > 
> > Why doesn't this still apply even if we don't have an irq for this device?
> > Can use a sysfs or hrtimer trigger or an irq on another device.
> >   
> 
> Another good question. I know I wrote the code only thinking that when 
> the trigger is used, it will be the data-ready from the device. I think 
> I even used the trigger validation function which requires us to use the 
> device's own trigger.
> 
> Now, whether it would make sense to allow other triggers, and whether 
> the trigger handler has any data-ready specific handling here is 
> something I need to revise. What does slightly bug me with allowing 
> other triggers is that as far as I remmeber the BM1390 had no way to 
> indicate that a single sample was actually ready. So, when we use any 
> other trigger it may be we don't have a valid sample to read. (The 
> read_raw uses a delay which should be long enough to guarantee a sample).

That is a fairly common problem with using other triggers. Will we get no
data, or stale data?  If just stale, but some guarantee on not too stale
then usually fine to just return that.

> 
> >> +
> >> +	if (ret)
> >> +		return dev_err_probe(data->dev, ret,
> >> +				     "iio_triggered_buffer_setup FAIL\n");
> >> +
> >> +	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d", idev->name,
> >> +					    iio_device_id(idev));
> >> +	if (!itrig)
> >> +		return -ENOMEM;
> >> +
> >> +	data->trig = itrig;
> >> +	idev->available_scan_masks = bm1390_scan_masks;  
> > 
> > Mixing trigger and buffer stuff in here. I'd rather see them
> > separate - so move this up to where you set the buffer up.  
> 
> Thanks for pointing this out. In my mind the trigger and buffer went 
> hand to hand with this device. Now, after your previous comment, I need 
> to rethink if they really can be sepated. Anyways, moving this makes sense.
> 
That separation is often messy / unclear.  So it is kind of best effort
+ making it work with external triggers if possible.

> >   
> >> +
> >> +	itrig->ops = &bm1390_trigger_ops;
> >> +	iio_trigger_set_drvdata(itrig, data);
> >> +
> >> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
> >> +			      dev_name(data->dev));  
> > 
> > Check the allocation.  Definitely don't want name not defined here.  
> 
> The request_threaded_irq will use the dev_name() if NULL is passed to 
> it. I think it should be fine - but I think this is not worth fighting 
> if you strongly prefer the check :)

I do :)  Mostly because I don't want readers to have to know it doesn't
matter.  It will never fail anyway in reasonable systems.


> >   
> >> +
> >> +	ret = devm_request_threaded_irq(data->dev, irq, bm1390_irq_handler,
> >> +					&bm1390_irq_thread_handler,
> >> +					IRQF_ONESHOT, name, idev);
> >> +	if (ret)
> >> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> >> +
> >> +
> >> +	ret = devm_iio_trigger_register(data->dev, itrig);
> >> +	if (ret)
> >> +		return dev_err_probe(data->dev, ret,
> >> +				     "Trigger registration failed\n");
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int bm1390_probe(struct i2c_client *i2c)
> >> +{
> >> +	struct bm1390_data *data;
> >> +	struct regmap *regmap;
> >> +	struct iio_dev *idev;
> >> +	struct device *dev;
> >> +	unsigned int part_id;
> >> +	int ret;
> >> +
> >> +	dev = &i2c->dev;  
> > 
> > Given it's unconditionally set and no line length issue, I'd prefer this
> > done on the local variable definitions block above.  
> 
> I can change this if you feel strong about it. Still, I personally find 
> assignments in declarations less clear and so I tend to avoid them. 
> (There's a few exceptions like repeated private data pointer getting).

Don't care that much.  Though I'll probably forget I said that
and moan about it in next version :)



Jonathan
