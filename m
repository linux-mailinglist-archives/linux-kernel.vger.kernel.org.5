Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8779D3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjILOiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjILOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:38:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C6DCC3;
        Tue, 12 Sep 2023 07:38:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlR3g076Pz67Lmq;
        Tue, 12 Sep 2023 22:36:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 15:38:10 +0100
Date:   Tue, 12 Sep 2023 15:38:08 +0100
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
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230912153808.00002857@Huawei.com>
In-Reply-To: <fc509b73-35df-89e0-5cc0-4bf852d6da7d@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
        <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
        <20230910142225.5863a850@jic23-huawei>
        <fc509b73-35df-89e0-5cc0-4bf852d6da7d@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> >> The FIFO measurement mode is only measuring the pressure and not the
> >> temperature. The driver measures temperature when FIFO is flushed and
> >> simply uses the same measured temperature value to all reported
> >> temperatures. This should not be a problem when temperature is not
> >> changing very rapidly (several degrees C / second) but allows users to
> >> get the temperature measurements from sensor without any additional logic.  
> > 
> > IIRC this is a bit different from what we've typically done in the past
> > where we just take the view that a slow moving thing like temperature
> > can be read from sysfs or that enabling it disables the watermark.
> > 
> > However, what you have seems like valid use of the ABI to me so I'm
> > fine with this approach if it makes sense for your expected users
> > (which you get to guess at ;)
> > 
> > Given there are multiple ways of handling combination of FIFO hardware
> > and triggers, it's good to add a little bit of info on that in this
> > patch description (I misunderstood what you were doing initially)
> >   
> My idea is that the sensor can either be used in two ways,
> 
> 1. With trigger (data-ready IRQ). In this case the FIFO is not used as 
> we get data ready for each collected sample. Instead, for each 
> data-ready IRQ we read the sample from sensor and push it to the IIO buffer.
> 
> 2. With hardware FIFO and watermark IRQ. In this case the data-ready is 
> not used but we enable watermark IRQ. At each watermark IRQ we go and 
> read all samples in FIFO and push them to the IIO buffer.
> 
> Do you mean the commit message should explain this?
yes


> >> +
> >> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >> +			       bool irq)
> >> +{
> >> +	/* The fifo holds maximum of 4 samples */  
> > 
> > Whilst useful info - why have comment here?  
> 
> It really looks like it's missplaced. I may have suffled some code to 
> other place without moving the comment. I'll drop or move it - thanks!
> 
> >   
> >> +	struct bm1390_data *data = iio_priv(idev);
> >> +	struct bm1390_data_buf buffer;
> >> +	int smp_lvl, ret, i;
> >> +	u64 sample_period;
> >> +	__be16 temp = 0;
> >> +
> >> +	/*
> >> +	 * If the IC is accessed during FIFO read samples can be dropped.
> >> +	 * Prevent access until FIFO_LVL is read
> >> +	 */
> >> +	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
> >> +		ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
> >> +				       sizeof(temp));
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	ret = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
> >> +
> >> +	if (smp_lvl > 4) {
> >> +		/*
> >> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
> >> +		 * bit errors in I2C line. Don't overflow if this happens.
> >> +		 */
> >> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
> >> +		smp_lvl = 4;
> >> +	}
> >> +
> >> +	if (!smp_lvl)
> >> +		return ret;
> >> +
> >> +	sample_period = data->timestamp - data->old_timestamp;
> >> +	do_div(sample_period, smp_lvl);
> >> +
> >> +	if (samples && smp_lvl > samples)
> >> +		smp_lvl = samples;
> >> +
> >> +	for (i = 0; i < smp_lvl; i++) {
> >> +		ret = bm1390_pressure_read(data, &buffer.pressure);
> >> +		if (ret)
> >> +			break;
> >> +
> >> +		buffer.temp = temp;
> >> +		/*
> >> +		 * Old timestamp is either the previous sample IRQ time,
> >> +		 * previous flush-time or, if this was first sample, the enable
> >> +		 * time. When we add a sample period to that we should get the
> >> +		 * best approximation of the time-stamp we are handling.
> >> +		 *
> >> +		 * Idea is to always keep the "old_timestamp" matching the
> >> +		 * timestamp which we are currently handling.
> >> +		 */
> >> +		data->old_timestamp += sample_period;
> >> +
> >> +		iio_push_to_buffers_with_timestamp(idev, &buffer,
> >> +						   data->old_timestamp);
> >> +	}
> >> +	/* Reading the FIFO_LVL closes the FIFO access sequence */
> >> +	regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);  
> > 
> > ret =  
> 
> I didn't want to determine success of getting the data by success of 
> this read. Instead, I wanted to ret to contain the success of reading 
> the pressure in the for-loop. We might spill out a warning if this reads 
> fails though.

Does it mean the next read is going to fail?  I'm too lazy to look at
datasheet to see what you mean by FIFO access sequence.
If it does I'd rather we reported error as early as possible.

Mind you I can't remember if errors in here result in anything useful anyway.




> >> +static int bm1390_set_watermark(struct iio_dev *idev, unsigned int val)
> >> +{
> >> +	struct bm1390_data *data = iio_priv(idev);
> >> +
> >> +	if (val < BM1390_WMI_MIN || val > BM1390_WMI_MAX)
> >> +		return -EINVAL;  
> > 
> > It's definitely possible to argue a watermark of 1 is also supported - just
> > run in bypass mode with data ready interrupt.  Not sure we care enough to
> > make that supported in this interface though.  Driver doesn't need to
> > support everything possible.  
> 
> True. I'm not sure this is worth the complexity though. It'd mean we had 
> to support DRDY when in FIFO mode - iff watermark is 1. Currently we 
> don't need to bother the DRDY or FIFO disabling when in FIFO mode.

Ok.


> 
> >> +	if (ret || !dummy)
> >> +		return IRQ_NONE;
> >> +
> >> +	dev_dbg(data->dev, "DRDY trig status 0x%x\n", dummy);
> >> +
> >> +	ret = bm1390_pressure_read(data, &data->buf.pressure);
> >> +	if (ret) {
> >> +		dev_warn(data->dev, "sample read failed %d\n", ret);
> >> +		return IRQ_NONE;  
> > As below.  Still our interrupt even if we couldn't read the data
> > As such, IRQ_HANDLED; is current reutrn value.  
> 
> I've learned a hard way that it can be a very good idea to return 
> IRQ_NONE if HW access fails in IRQ handling. If we don't (can't) ack the 
> IRQ line, we'll be sitting in IRQ handler. The feature which disables 
> local IRQ after <N> unhandled IRQs has made a huge difference when I've 
> received bug reports from people. Being able to access the device when 
> the 'wild' IRQ gets disabled and being able to retrieve the logs is 
> priceless. Also, seeing the 'nobody cares, disabling IRQ' in the log is 
> a really valuable hint :)

Hmm.  Usually the warn splat works out as enough to provide
a hint. Kind of depends on whether the particular failure blocks correct
handling or not.  Some devices don't care if you successfully
read the buffer or not.  Its always annoyed me that there is no
IRQ_ERROR return.


> 
> >   
> >> +	}
> >> +
> >> +	mutex_unlock(&data->mutex);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int bm1390_set_drdy_irq(struct bm1390_data *data, bool en)
> >> +{
> >> +	if (en)
> >> +		return regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
> >> +				       BM1390_MASK_DRDY_EN);
> >> +	return regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
> >> +				 BM1390_MASK_DRDY_EN);
> >> +}
> >> +
> >> +static int bm1390_trigger_set_state(struct iio_trigger *trig,
> >> +				    bool state)
> >> +{
> >> +	struct bm1390_data *data = iio_trigger_get_drvdata(trig);
> >> +	int ret = 0;
> >> +
> >> +	mutex_lock(&data->mutex);
> >> +
> >> +	if (data->trigger_enabled == state)
> >> +		goto unlock_out;
> >> +
> >> +	if (data->state == BM1390_STATE_FIFO) {
> >> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");  
> > 
> > Why not?  Spec reference ideally.  I haven't gotten my head around this
> > but I'd expect an attempt to set the trigger state to indicate that we don't
> > want to use the fifo and as such it should be disabled in this path.  
> 
> This may be my limited understanding of how IIO is typically used. To me 
> it sounded a bit strange that someone setting trigger could abort an 
> ongoing buffered measurement. I would have expected the buffering to be 
> explicitly disabled by user before allowing the trigger to be used.

We mostly try to enable as many userspace paths as possible.  If they
ask for something and we can easily do it (even if it stops something
else) then we are fine with it.  
 
> Especially because the trigger and FIFO are pretty much exclusive 
> features (as with data-ready trigger you'll get each individual sample 
> read). My assumption was that an attempt to enable data-ready when FIFO 
> was in use is a misconfiguration.

I agree, but doesn't mean we aren't nice to them anyway :)  Expectation
is they should go back to a sensible state before setting up something new
and complex.


Now if it's tricky to handle in code then we can indeed use an error.

I have better understood how you are are handing fifo vs data ready
now hence I'm not that bothered by this spitting out an error.  It's the same
as changing a trigger when a buffer is running which makes little sense,
though it only applies in INDIO_BUFFER_TRIGGERED mode.
Perhaps we should broaden that and then we'll block much earlier.
 
...



> > 
> >   
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
> >> +
> >> +	regmap = devm_regmap_init_i2c(i2c, &bm1390_regmap);
> >> +	if (IS_ERR(regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(regmap),
> >> +				     "Failed to initialize Regmap\n");
> >> +
> >> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> >> +	if (!idev)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = devm_regulator_get_enable(dev, "vdd");
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> >> +
> >> +	data = iio_priv(idev);
> >> +
> >> +	ret = regmap_read(regmap, BM1390_REG_PART_ID, &part_id);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> >> +
> >> +	if (part_id != BM1390_ID)
> >> +		dev_warn(dev, "unknown device 0x%x\n", part_id);
> >> +
> >> +	data->regmap = regmap;
> >> +	data->dev = dev;
> >> +	data->irq = i2c->irq;
> >> +	/*
> >> +	 * Default watermark to WMI_MAX. We could also allow setting WMI to 0,
> >> +	 * and interpret that as "WMI is disabled, use FIFO_FULL" but I've
> >> +	 * no idea what is assumed if watermark is 0. Does it mean each sample
> >> +	 * should trigger IRQ, or no samples should do that?  
> > 
> > In my head at least, if we are using fifo_full it is still a watermark but one
> > that matches size of buffer.
> > I think for previous drivers we've had 0 and 1 both meaning it's a dataready
> > interrupt (i.e. one entry in the fifo).  That would be fine here as well
> > and would correspond to putting the device in bypass mode.  
> 
> Thanks for the explanation. It makes sense.
> Meanwhile I was reading the spec and I think the FIFO_FULL usage with 
> this IC is like asking for a nose-bleed. FIFO_FULL IRQ is acked by 
> reading the status - and if data is not read from the FIFO, then the 
> status will remain cleared (and I assume also the IRQ line will stay 
> low). I assume it's easy enough to write a code that acks the IRQ while 
> leaving the buffer full - and effectively killing the FIFO_FULL IRQ. No 
> more samples for you then.

Its not a level IRQ?  What fun. Indeed silly corner case.

> 
> > 	  
> >> +	 *
> >> +	 * Well, for now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
> >> +	 * discard every other configuration when triggered mode is not used.
> >> +	 */
> >> +	data->watermark = BM1390_WMI_MAX;
> >> +	mutex_init(&data->mutex);
> >> +
> >> +	idev->channels = bm1390_channels;
> >> +	idev->num_channels = ARRAY_SIZE(bm1390_channels);
> >> +	idev->name = "bm1390";
> >> +	idev->info = &bm1390_info;
> >> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;  
> > 
> > The triggered buffer setup should set the second of these inside
> > the IIO core code (as it always needs to be set if that code is called).  
> 
> Right. Thanks.

Oops. I'm wrong in this.  I'd forgotten the distinction between
INDIO_BUFFER_TRIGGERED and INDIO_BUFFER_SOFTWARE.

You should set this as you have done.

...

> >> +static struct i2c_driver bm1390_driver = {
> >> +	.driver = {
> >> +		.name = "bm1390",
> >> +		.of_match_table = bm1390_of_match,
> >> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,  
> > 
> > I don't mind seeing this but I do want it to have a comment saying 'why'.
> > I assume there is something really slow involved in probing this?  
> 
> I wouldn't say there is anything really slow. What I have gathered is:
> 
> 1) The grand idea is that at the end of the day (week, month, year) 
> async probing should be the default when it causes no problems.

Agreed.

> 
> 2) Problems are rare (although they may exist).
> 
> 3) All regulator drivers were changes (or suggested to be changed) to do 
> async probing because for example the ramp-rates may be slow.
> 
> 4) This driver enables the VDD supply - with potentially slow ramp-rate 
> (well, the I need to guess user's setups statement holds again) so it 
> may potentially take a while (probably not long though).
> 
> 5) We have a few msleeps() in bm1390_chip_init() - which are likely to 
> result a sleep tens of milliseconds. So there is some delay.
> 
>  From those 5 things I derived assumption that async probe would be the 
> right thing to start with. We can drop it if it causes a problem in an 
> actual setup :)
> 
I don't mind having it - I'd just like a little comment including what
minimum sleep time is and that a VDD supply enable may add time to it.

So set the bounds.

Jonathan

