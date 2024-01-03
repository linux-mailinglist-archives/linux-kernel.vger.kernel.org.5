Return-Path: <linux-kernel+bounces-15032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2225B822669
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342E81C22C71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74E1100;
	Wed,  3 Jan 2024 01:12:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE417981;
	Wed,  3 Jan 2024 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636813:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 03 Jan 2024 09:11:56 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Wed, 3 Jan
 2024 09:11:56 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Wed, 3 Jan 2024 09:11:56 +0800
Date: Wed, 3 Jan 2024 09:11:56 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: rtq6056: Add support for the whole
 RTQ6056 family
Message-ID: <20240103011156.GA7587@linuxcarl2.richtek.com>
References: <cover.1704189363.git.cy_huang@richtek.com>
 <bc97e776171d589c9d97541cc7ce8d74c899bc92.1704189363.git.cy_huang@richtek.com>
 <20240102195340.33de9a02@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102195340.33de9a02@jic23-huawei>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 02, 2024 at 07:53:40PM +0000, Jonathan Cameron wrote:
> On Tue, 2 Jan 2024 19:28:22 +0800
> <cy_huang@richtek.com> wrote:
> 
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > RTQ6053 and RTQ6059 are the same series of RTQ6056.
> > 
> > The respective differences with RTQ6056 are listed below
> > RTQ6053
> > - chip package type
> > 
> > RTQ6059
> > - Reduce the pinout for vbus sensing pin
> > - Some internal ADC scaling change
> > 
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> 
> I replied to your question on v2. As a general rule don't send a new version
> out quite so quickly.  Better to let all questions be answered (or a week or so
> to pass) before sending a new version.  That way it saves on review time.
OK. I'll send the new one after all the answers were got.
> 
> Anyhow, some follow up comments and one or two things I didn't notice before.
>
All wii be fixed in v4. 
> Jonathan
> 
> > ---
> > v3
> > - Resotre the enum for control field.
> > - Put all the predefined datas/callbacks in dev_data.
> > - Remove the unused 'rtq6059_info'.
> > - Change 'default_conv_time' to 'default_conv_time_us'.
> > - Move the comment for default config above the dev_data setting line.
> > 
> > v2
> > - Remove rtq6053 in DT match table and make rtq6053 fallback compatible
> >   with rtq6056
> > ---
> >  drivers/iio/adc/rtq6056.c | 270 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 251 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
> > index ad4cea6839b2..c87d78e161ce 100644
> > --- a/drivers/iio/adc/rtq6056.c
> > +++ b/drivers/iio/adc/rtq6056.c
> > @@ -39,6 +39,16 @@
> >  #define RTQ6056_DEFAULT_CONFIG	0x4127
> >  #define RTQ6056_CONT_ALLON	7
> >  
> > +#define RTQ6059_DEFAULT_CONFIG	0x3C47
> > +#define RTQ6059_VBUS_LSB_OFFSET	3
> > +#define RTQ6059_AVG_BASE	8
> > +
> > +enum {
> > +	RICHTEK_DEV_RTQ6056 = 0,
> > +	RICHTEK_DEV_RTQ6059,
> > +	RICHTEK_DEV_MAX
> > +};
> > +
> 
> No longer used so drop this enum.
> 
> >  static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> >  				    struct iio_chan_spec const *ch,
> >  				    int *val)
> >  {
> > +	const struct richtek_dev_data *devdata = priv->devdata;
> >  	struct device *dev = priv->dev;
> >  	unsigned int addr = ch->address;
> >  	unsigned int regval;
> > @@ -168,10 +287,21 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> >  		return ret;
> >  
> >  	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
> > -	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
> > +	switch (addr) {
> > +	case RTQ6056_REG_BUSVOLT:
> > +		regval >>= devdata->vbus_offset;
> >  		*val = regval;
> > -	else
> > +		break;
> Can just return directly here
> 		return IIO_VAL_INT;
> > +	case RTQ6056_REG_POWER:
> > +		*val = regval;
> > +		break;
> 		return IIO_VAL_INT;
> > +	case RTQ6056_REG_SHUNTVOLT:
> > +	case RTQ6056_REG_CURRENT:
> >  		*val = sign_extend32(regval, 16);
> > +		break;
> 		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> >  
> >  	return IIO_VAL_INT;
> And drop this.
> >  }
> > @@ -199,6 +329,28 @@ static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
> >  	}
> >  }
> >  
> 
> > @@ -334,6 +518,7 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> >  				 int val2, long mask)
> >  {
> >  	struct rtq6056_priv *priv = iio_priv(indio_dev);
> > +	const struct richtek_dev_data *devdata = priv->devdata;
> >  	int ret;
> >  
> >  	ret = iio_device_claim_direct_mode(indio_dev);
> > @@ -342,10 +527,13 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
> > +		if (devdata->fixed_samp_freq)
> > +			ret = -EINVAL;
> 
> Slight preference here for following form to make it easy to see nothing is done
> in error paths beyond breaking out of the switch statement.
> 
> 		if (devdata->fixed_samp_freq) {
> 			ret = -EINVAL;
> 			break;
> 		}
> 
> 		ret = rtq....
> 		break;
> 
> > +		else
> > +			ret = rtq6056_adc_set_samp_freq(priv, chan, val);
> >  		break;
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > -		ret = rtq6056_adc_set_average(priv, val);
> > +		ret = devdata->set_average(priv, val);
> >  		break;
> >  	default:
> >  		ret = -EINVAL;
> ;
> > @@ -598,8 +793,8 @@ static int rtq6056_probe(struct i2c_client *i2c)
> >  
> >  	indio_dev->name = "rtq6056";
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > -	indio_dev->channels = rtq6056_channels;
> > -	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
> > +	indio_dev->channels = devdata->channels;
> > +	indio_dev->num_channels = RTQ6056_MAX_CHANNEL + 1;
> 
> You have added devdata->num_channels but seem to have forgotten to use it.
> 
> >  	indio_dev->info = &rtq6056_info;
> >  
> >  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > @@ -640,8 +835,45 @@ static int rtq6056_runtime_resume(struct device *dev)
> >  static DEFINE_RUNTIME_DEV_PM_OPS(rtq6056_pm_ops, rtq6056_runtime_suspend,
> >  				 rtq6056_runtime_resume, NULL);
> >  

