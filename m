Return-Path: <linux-kernel+bounces-74252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59D885D1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B311C22C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82033B199;
	Wed, 21 Feb 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IN4Evyml"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12383A27B;
	Wed, 21 Feb 2024 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501425; cv=none; b=LSYxKp+X2Aln7+y2tAuD5U846/dZYs2GgYA0juSnbRGtk70QKewQaQtYHDq2qInJ1/vBFd1Fpf7oHjGsRnD4xdfqixIdNbz5rHDdOroGL5E5bsS1i0VGoeIEMO40Sust9ZDPsT0b0uEmd3P7liznbzd1xPEl9G2gzuPRqkqGoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501425; c=relaxed/simple;
	bh=ltTht77zSLOZYTaO34bNZ2vXR72J5XsBwuQr3EcrxMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggRw21H5DaIsYUuwptXtx2/1nzbu2pkYObOETXm7dZfHavwk2ubCtbm2GJ3DkFmiRDic0ElzuDZZ1WMojNnHD47rPiA4vIzT7oDNlxBjj4KXqBA5oyjC6k1dMZyOTXgLiIcTjt8ZtxN1BUiiK2K88Ap1BQhmQf1ZyAHg0IkPEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IN4Evyml; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501424; x=1740037424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ltTht77zSLOZYTaO34bNZ2vXR72J5XsBwuQr3EcrxMc=;
  b=IN4EvymlP0JQktO7IAo5rzmlKPFPRmf6miSjyG0RhqiRAnajMwRBy8te
   gRBSnSTROSNu7S5rpQXTP08NeCZEUs5jBGg3M4lOlq5Rx3SJBOwtmSEp7
   yQEoTu1CU7qZFSiK64Yn5/TcfsZj2eT2xombxbSo/ss2S0gS0kJSpJ3rf
   aR7J2hXs3XNHvfETiunp4vTPUty9jGXy2nsB6tGijqVFmhm/4CHQuyhTm
   KwitqLmc+kPXJTnLYQQ6mzoRnbXLtSB3Qu4u0jEsfKKtGeY2/q8f7klED
   Lblp1iRuU6ql/RAubWgeFVFeC2uqWGGHBO3DNNDo53FF7EWVAdmtD12qL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13267305"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="13267305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="827300778"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="827300778"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:43:34 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B6E6511F855;
	Wed, 21 Feb 2024 09:43:31 +0200 (EET)
Date: Wed, 21 Feb 2024 07:43:31 +0000
From: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
To: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <ZdWpow0JIM18Hc4u@kekkonen.localdomain>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
 <20240204061538.2105-3-zhi.mao@mediatek.com>
 <20240206184542.GE2827@pendragon.ideasonboard.com>
 <598f62bbb55157eec1e23dd1dbc307fea3851b21.camel@mediatek.com>
 <20240220030104.GF20376@pendragon.ideasonboard.com>
 <115698c0c549e747026cc8841a3bd571533f8e6f.camel@mediatek.com>
 <ZdRUB92gkbRGPyr_@kekkonen.localdomain>
 <063fa9763efb1570295cfef385829714dd5e42cf.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <063fa9763efb1570295cfef385829714dd5e42cf.camel@mediatek.com>

Hi Zhi,

On Wed, Feb 21, 2024 at 02:37:27AM +0000, Zhi Mao (毛智) wrote:
> Hi Laurent & sakari,
> 
> Thanks for your feedback.
> 
> On Tue, 2024-02-20 at 07:25 +0000, sakari.ailus@linux.intel.com wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi Zhi,
> > 
> > On Tue, Feb 20, 2024 at 05:45:54AM +0000, Zhi Mao (毛智) wrote:
> > > Hi Laurent,
> > > 
> > > Thanks for you reply.
> > > I'd like to ask for advice about how to contrl "reset-pin", please
> > > check the below comments.
> > > 
> > > On Tue, 2024-02-20 at 05:01 +0200, Laurent Pinchart wrote:
> > > >   
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  Hi Zhi,
> > > > 
> > > > On Tue, Feb 20, 2024 at 02:12:26AM +0000, Zhi Mao (毛智) wrote:
> > > > > On Tue, 2024-02-06 at 20:45 +0200, Laurent Pinchart wrote:
> > > > > > On Sun, Feb 04, 2024 at 02:15:38PM +0800, Zhi Mao wrote:
> > > > > > > Add a V4L2 sub-device driver for Galaxycore GC08A3 image
> > > > sensor.
> > > > > > >
> > > > > > > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > > > > > > ---
> > > > > > >  drivers/media/i2c/Kconfig  |   10 +
> > > > > > >  drivers/media/i2c/Makefile |    1 +
> > > > > > >  drivers/media/i2c/gc08a3.c | 1448
> > > > ++++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 1459 insertions(+)
> > > > > > >  create mode 100644 drivers/media/i2c/gc08a3.c
> > > > 
> > > > [snip]
> > > > 
> > > > > > > diff --git a/drivers/media/i2c/gc08a3.c
> > > > b/drivers/media/i2c/gc08a3.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..3fc7fffb815c
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/media/i2c/gc08a3.c
> > > > > > > @@ -0,0 +1,1448 @@
> > > > 
> > > > [snip]
> > > > 
> > > > > > > +static int gc08a3_power_on(struct device *dev)
> > > > > > > +{
> > > > > > > +struct i2c_client *client = to_i2c_client(dev);
> > > > > > > +struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > > > > > > +struct gc08a3 *gc08a3 = to_gc08a3(sd);
> > > > > > > +int ret;
> > > > > > > +
> > > > > > > +ret =
> > regulator_bulk_enable(ARRAY_SIZE(gc08a3_supply_name),
> > > > > > > +    gc08a3->supplies);
> > > > > > > +if (ret < 0) {
> > > > > > > +dev_err(gc08a3->dev, "failed to enable regulators: %d\n",
> > > > ret);
> > > > > > > +return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +ret = clk_prepare_enable(gc08a3->xclk);
> > > > > > > +if (ret < 0) {
> > > > > > > +regulator_bulk_disable(ARRAY_SIZE(gc08a3_supply_name),
> > > > > > > +       gc08a3->supplies);
> > > > > > > +dev_err(gc08a3->dev, "clk prepare enable failed\n");
> > > > > > > +return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
> > > > > > > +
> > > > > > > +gpiod_set_value_cansleep(gc08a3->reset_gpio, 1);
> > > > > >
> > > > > > Are you asserting reset when powering on ? That sounds wrong,
> > you
> > > > should
> > > > > > de-assert reset here (and acquire the reset gpio in probe()
> > with
> > > > > > GPIOD_OUT_HIGH). Drivers should use logical levels for GPIOs,
> > > > setting a
> > > > > > GPIO named "reset" to 1 should assert the reset signal, even
> > if
> > > > the
> > > > > > physical signal is active low. You may have the wrong
> > polarity in
> > > > the
> > > > > > device tree.
> > > > >
> > > > > According to the sensor power sequence sepc, "reset" pin should
> > be
> > > > pull
> > > > > from low to high after "dovdd/dvdd/avdd" power on, so I follow
> > this
> > > > > power sequece to pull "reset" pin high in software flow.
> > > > 
> > > > From a hardware point of view that's right, but the Linux kernel
> > > > handles
> > > > logical level of GPIOs. If a GPIO is named "reset", it is
> > expected
> > > > that
> > > > calling
> > > > 
> > > > gpiod_set_value_cansleep(gc08a3->reset_gpio, 1);
> > > > 
> > > > will "assert" the reset signal, setting it to a logical "reset =
> > > > true"
> > > > level. This maps to the hardware 0V output level, as the signal
> > is
> > > > active-low. To achieve this, define the reset GPIO as active low
> > in
> > > > DT,
> > > > and the GPIO framework will invert the signal for you. You should
> > > > then
> > > > call
> > > > 
> > > > gpiod_set_value_cansleep(gc08a3->reset_gpio, 1);
> > > > 
> > > > in the driver when you want to assert reset (set it to 0V), and
> > > > 
> > > > gpiod_set_value_cansleep(gc08a3->reset_gpio, 0);
> > > > 
> > > > when you want to deassert it (set it to 3.3V, or whatever the I/O
> > > > voltage for the signal is).
> > > > 
> > > > This way all driver use logical states, and the inversion is
> > handled
> > > > in
> > > > DT.
> > > > 
> > > 
> > > Sensor power sequence as below:
> > >                       ------------------
> > >                      | | |
> > >                      | | | 
> > > dvdd/avdd/dovdd  --------
> > >                                ---------
> > >                               |
> > >                               |
> > > reset-pin        -------------
> > > 
> > > In order to match this power sequece, "reset-pin" contrl flow is
> > below:
> > > 1. config the "reset-pin" is "active-high" in DTS:
> > >     reset-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
> > > 
> > > 2. image sensor driver probe function:
> > > gc08a3->reset_gpio = devm_gpiod_get(dev, "reset",
> > > GPIOD_OUT_LOW);  //init "reset-pin" is low
> > > 
> > > 3. image sensor driver power_on function:
> > > gpiod_set_value_cansleep(gc08a3->reset_gpio, 1); //pull "reset-pin"
> > > high 
> > > 
> > > so, the expect state of "reset-pin" is from low to high.
> > > If I am wrong, please correct me.
> > 
> > 
> > From Documentation/driver-api/gpio/consumer.rst:
> > 
> > As a consumer should not have to care about the physical line
> > level, all of the gpiod_set_value_xxx() or
> > gpiod_set_array_value_xxx() functions operate with the *logical*
> > value. With this they take the active low property into account.
> > This means that they check whether the GPIO is configured to be
> > active low, and if so, they manipulate the passed value before the
> > physical line level is driven.
> > 
> > I.e. when you want to enable reset, you set the value to 1 in the
> > driver. I
> > think you're now setting the value to 0 in that case. The opposite
> > for
> > disabling it of course.
> > 
> After checking "Documentation/driver-api/gpio/consumer.rst":
> To summarize::
>   Function (example)                 line property          physical
> line
> ...
>   gpiod_set_value(desc, 1);          default (active high)  high
>   gpiod_set_value(desc, 0);          active low             high
> ...
> 
> 
> From my understanding, it seems that "reset-pin" is using the
> following(active_high) case in current code: 
> "gpiod_set_value(desc, 1);          default (active high)  high" 
> 
> Do you mean, we should use the "active_low" case:
> "gpiod_set_value(desc, 0);          active low             high"
> Code should be changed as below:
> 1. config the "reset-pin" is "active-low" in DTS:
>    - reset-gpios = <&pio 19 GPIO_ACTIVE_LOW>
> 2. image sensor driver power_on function:
>    - gpiod_set_value_cansleep(gc08a3->reset_gpio, 0); //pull high 
> Is that so?

Correct.

-- 
Regards,

Sakari Ailus

