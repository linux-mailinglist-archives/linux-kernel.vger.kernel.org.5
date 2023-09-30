Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD27B4200
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjI3QN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjI3QNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:13:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA013B3;
        Sat, 30 Sep 2023 09:13:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321E3C433C7;
        Sat, 30 Sep 2023 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696090402;
        bh=wVXYsglMzhC/ua2WBQHbIYUMFlVbNUJUOsG06rBlkjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XszE8ewyUsPXwUscV7B8kWrLlWcv8ehRWnv8+Al+dmy8dsdNwHjEvRNeVi9Dey8GM
         flTBUlkReuHxtjypQj0PBRNao67mCnq5sAQ1kYvF4FkoolytgBwxCOR4E49WDE/he3
         TbSvivHTeI/ZR42kWXViGsxjjFm1meOE3Tb1rYNufufHEurn6XeWcRts/BVS7ikj0r
         LwWUlpTpm7bJrSY3dGFRuAOgcI/Mwmd2QFxcuknRae3vXrXEJ/1BGuTa+XYgsPS7IA
         wWLFLUNKe/I2bFQ248cvs8LuOEipi7H1W+kwfF28sIVXvoPsmgw2t9Kdaz8Ar1KVzr
         aRHsHiQZ4+Lrg==
Date:   Sat, 30 Sep 2023 17:13:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20230930171321.3afbada2@jic23-huawei>
In-Reply-To: <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-3-jagathjog1996@gmail.com>
        <20230924153055.0b3486f9@jic23-huawei>
        <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
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


> 
> > > +struct bmi323_data {
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct iio_mount_matrix orientation;
> > > +     enum bmi323_irq_pin irq_pin;
> > > +     struct iio_trigger *trig;
> > > +     bool drdy_trigger_enabled;
> > > +     enum bmi323_state state;
> > > +     s64 fifo_tstamp, old_fifo_tstamp;
> > > +     u32 odrns[2];
> > > +     u32 odrhz[2];
> > > +     unsigned int feature_events;
> > > +
> > > +     /*
> > > +      * Lock to protect the members of device's private data from concurrent
> > > +      * access and also to serialize the access of extended registers.
> > > +      * See bmi323_write_ext_reg(..) for more info.
> > > +      */
> > > +     struct mutex mutex;
> > > +     int watermark;
> > > +     __le16 fifo_buff[BMI323_FIFO_FULL_IN_WORDS] __aligned(IIO_DMA_MINALIGN);
> > > +     struct {
> > > +             __le16 channels[6];
> > > +             s64 ts __aligned(8);  
> >
> > Hopefully Andy's aligned_s64 set will land soon and we can tidy this up.
> > I'm a bit unsure of this, but can you overlap some of these buffers or are
> > they used concurrently? (if they are then we have problems with DMA safety.)
> >
> > Perhaps an anonymous union is appropriate?  
> 
> Yes both buffers are used at the same time. In fifo_flush
> fifo_buff is used to store all fifo data, and buffer is
> used to push a single data frame to iio buffers, overlapping
> will corrupt the data, so I used separate buffers for both.

Ah. So the structure is used in 2 ways.

1. As a target for DMA, which means it should live in the cacheline we
are saving for that purpsoe.
2. As a place to build up data.  

In general we should be careful with doing 2 as that could race with
DMA and end up with data corruption, however you only use it that
way in flush_fifo where both the DMA and this usage under under 
the mutex.  Hence I think you are fine.


> 
> > > +static IIO_DEVICE_ATTR_RW(in_accel_gyro_averaging, 0);
> > > +static IIO_CONST_ATTR(in_accel_gyro_averaging_available, "2 4 8 16 32 64");
> > > +
> > > +static struct attribute *bmi323_attributes[] = {
> > > +     &iio_dev_attr_in_accel_gyro_averaging.dev_attr.attr,
> > > +     &iio_const_attr_in_accel_gyro_averaging_available.dev_attr.attr,  
> >
> > So averaging often maps directly to oversampling.  Kind of different names
> > for the same thing.  Perhaps that standard ABI can be used?
> > It tends to make sampling frequency reporting need to take it into account
> > though as that drops as divided by oversampling ratio.  
> 
> Yes, oversampling can be used, but changing the average
> value doesn't alter the sampling frequency. The sampling
> frequency is same even with the increase in averaging value.

Ok.  That's unusual so good to know.
> > > +static int bmi323_feature_engine_enable(struct bmi323_data *data, bool en)
> > > +{
> > > +     unsigned int feature_status;
> > > +     int ret, i;
> > > +
> > > +     if (en) {
> > > +             ret = regmap_write(data->regmap, BMI323_FEAT_IO2_REG,
> > > +                                0x012c);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = regmap_write(data->regmap, BMI323_FEAT_IO_STATUS_REG,
> > > +                                BMI323_FEAT_IO_STATUS_MSK);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = regmap_write(data->regmap, BMI323_FEAT_CTRL_REG,
> > > +                                BMI323_FEAT_ENG_EN_MSK);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             i = 5;  
> >
> > Why 5?  
> 
> No specific reason, during testing the feature engine was
> taking around 4 milliseconds, so I thought of checking
> every 2 milliseconds and max of 5 trials.

That's a good reason. Just add a comment to that say that.



> 
> > > + * From BMI323 datasheet section 4: Notes on the Serial Interface Support.
> > > + * Each SPI register read operation requires to read one dummy byte before
> > > + * the actual payload.
> > > + */
> > > +static int bmi323_regmap_spi_read(void *context, const void *reg_buf,
> > > +                               size_t reg_size, void *val_buf,
> > > +                               size_t val_size)
> > > +{
> > > +     struct spi_device *spi = context;
> > > +     u8 reg, *buff = NULL;
> > > +     int ret;
> > > +
> > > +     buff = kmalloc(val_size + BMI323_SPI_DUMMY, GFP_KERNEL);  
> >
> > Hmm.  Regmap has pad_bits (which can be multiple bytes) but this case
> > is unusual in that they only apply to reads.
> >
> > I wonder if we can make this cheaper though rather than having
> > to handle either some context or having dynamic allocations in here.
> >
> > How about making the write bigger?  Does that have any effect?
> > Looks like don't care state in Figure 31.  If that's the case,
> > send some zeros on that as it's known fixed size (2 bytes including
> > the padding) and then you can directly use the read buffer without
> > yet another memcpy.  
> 
> For spi with pad_bits=8 and without any custom read and
> write functions, regmap_read() works but regmap_write()
> does not. Write is also adding 8 bits of padding and
> the device is treating it as data.
> (7.2.3 SPI Protocol Figure 30)

Understood. I looked it up too before suggesting this local hack.
You'll still need a custom regmap, but at least this trick would
allow you to avoid allocating a buffer in the read function.

Jonathan


