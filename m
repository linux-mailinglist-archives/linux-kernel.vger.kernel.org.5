Return-Path: <linux-kernel+bounces-133883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04E89AA44
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B9282A0A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53702561D;
	Sat,  6 Apr 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuzQFO2v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAD25624;
	Sat,  6 Apr 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712397735; cv=none; b=Dpq4muDsJRMCLuLLEBYKriODSygynuV32UfLHNMK2dTwWYkTV7h7ugLxRk1+y1VbsswB/SPVs5YU2vsN6Y9941yt1lof8DZ6yCRV5jYnIwA/+qn6afQJcFP1qdAtLHShQH9wCjzwnKHHE1xZAYz0bdO+Xq/bLn1GyuxCP2LZZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712397735; c=relaxed/simple;
	bh=RThzb9B1/GnucNi4mwjnzRAVjwP5fL2qSfrvJiOywRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McgpwJ5lTpGzGa+VW1wz7fGixyu4HvS4IC0IAWIGXV044iSHeCOdFXs9mi7eQMSv3sQnNYQH6ZFIqYcz1tklPm2u/MRtcRVa7ogbQhzdhSra8PKNNf6e3llWGpngB5IIXvtb0ksj1warkHneeRzVgGUOBmQ+g9RoTT+mS5vhEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuzQFO2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D70C433F1;
	Sat,  6 Apr 2024 10:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712397735;
	bh=RThzb9B1/GnucNi4mwjnzRAVjwP5fL2qSfrvJiOywRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LuzQFO2vTW+oDaIdWB+SAlgfVj1vU69HVAAgkKJFFnyjF2abapKOv07CDtjEy1nqE
	 4J+CWFqSN9Fc5LupXHSBXFOUnDtOEdFH2ZAs0FhdK5sd5TohAnpWtInoKfGqcRF7cA
	 aPawIPP2BRoltULRySbUqKgUcKiFaUubSdIMjykKozrRNl3VHKozpsiJGNhrQjJXtG
	 kcYOuTCwMj8WZFxawY8j3sdoYqEsOczyF8CeUnCM1qLi4XypT14gkaHyJVYwgqvvf+
	 PTxqzxgf2pZhZYwxYvxBZdHSwl0LWzSBNwPfECHy1FOvqUXo3wEsJz7kvcmXYaVPhS
	 oRN9ec1VEobPQ==
Date: Sat, 6 Apr 2024 11:02:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: Generalize
 read_{temp/press/humid}() functions
Message-ID: <20240406110200.4439715e@jic23-huawei>
In-Reply-To: <20240402175553.GA18068@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-4-vassilisamir@gmail.com>
	<20240324113616.02f9f391@jic23-huawei>
	<20240402175553.GA18068@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 19:55:53 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, Mar 24, 2024 at 11:36:16AM +0000, Jonathan Cameron wrote:
> > On Tue, 19 Mar 2024 01:29:22 +0100
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >  =20
> > > Add the coefficients for the IIO standard units and the return
> > > IIO value inside the chip_info structure.
> > >=20
> > > Remove the calculations with the coefficients for the IIO unit
> > > compatibility from inside the read_{temp/press/humid}() functions
> > > and move it to the general read_raw() function.
> > >=20
> > > Execute the calculations with the coefficients inside the read_raw()
> > > oneshot capture function.
> > >=20
> > > In this way, all the data for the calculation of the value are
> > > located in the chip_info structure of the respective sensor.
> > >=20
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com> =20
> > Hi,
> >=20
> > Perhaps it's later in the series, but I still don't much like the hidde=
n nature
> > of t_fine. I'd much rather that was explicitly 'returned' by the functi=
on
> > - by that I mean read_temp takes an s32 *t_fine and provides that if th=
e pointer
> > isn't NULL.
> >=20
> > Then drop the cached value in bmp280_data which I think just serves to =
make
> > this code less readable than it could be.
> >=20
> > Then bmp280_compensate_pressure() can take a struct bmp280_calib, s32 a=
dc_press and
> > s32 t_fine so it just has the data it needs.
> > Something similar for bmp280_compenstate_temp()
> >=20
> > Obviously this is cleaning up stuff that's been there a long time, but
> > given you are generalizing these functions this seems like the time to
> > make these other changes.
> >=20
> > As it stands, I don't think this code works as t_fine isn't updated
> > everywhere it needs to be and that is hidden away by it being updated
> > as a side effect of other calls.
> >=20
> > Jonathan
> >  =20
>=20
> Hi Jonathan,
>=20
> I am replying a bit late but I was off for quite some days.
>=20
> In general the t_fine variable is calculated inside the bmpxxx_compensate=
_temp().
> The t_fine variable is a function of the various varX variables and the a=
dc_temp.
> So by reading a new temp value from
> the sensor and calculating its compensated value, the new t_fine variable=
 is
> calculated. So the combination of reading temp from sensor + compensating=
 the
> temp value =3D updated t_fine as a result of the compensated temperature.=
 I agree that
> this has a hidden nature. I can solve it by disintegrating the read()+com=
pensate()
> functions as follows:
>=20
> bmpxxx_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)
> {
> 	/* reads adc temperature from the sensor */
> }
>=20
> bmpxxx_calc_t_fine(struct bmp280_calib *calib, s32 *adc_temp)
> {
> 	/* calculate t_fine from adc_temp */
> }
>=20
> bmpxxx_get/update_t_fine(struct bmp280_data *data, ...)
> {
> 	u32 adc_temp;
> 	s32 t_fine;
>=20
> 	bmpxxx_read_temp_adc(adc_temp); //get adc_temp
> 	if (ret)
> 		return ret;
>=20
> 	*t_fine =3D bmpxxx_calc_t_fine(&data->bmp280_calib.bmpxxx_calib, adc_tem=
p);
> }
>=20
> bmpxxx_read_temp(struct bmp280_data *data, s32 *comp_temp)
> {
> 	int ret;
> 	s32 t_fine;
>=20
> 	ret =3D bmpxxx_get/update_t_fine(&data, &t_fine);
> 	if (ret)
> 		return ret;
>=20
> 	*comp_temp =3D /* rest of the calculations to compensate temperature */
>=20
> 	return 0
> }
>=20
> Another question is, should this be applied to the pressure/humidity read=
ings as=20
> well? Maybe, read_{humidity/press}_adc() functions could be introduced ju=
st to
> have consistency with the temperature readings. Currently the adc_{humid/=
press}()
> reading is done inside the read_{humid/press}() functions which already
> incorporates the compensate_{humid/press}() functions.

=46rom a quick look there isn't the same issue with hidden data, but if it ma=
kes
sense from the point of view of consistency that is fine.
> =20
> >  =20
> > > ---
> > >  drivers/iio/pressure/bmp280-core.c | 189 +++++++++++++++------------=
--
> > >  drivers/iio/pressure/bmp280.h      |  13 +-
> > >  2 files changed, 106 insertions(+), 96 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressur=
e/bmp280-core.c
> > > index f7a13ff6f26c..6d6173c4b744 100644
> > > --- a/drivers/iio/pressure/bmp280-core.c
> > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > @@ -363,10 +363,9 @@ static u32 bmp280_compensate_press(struct bmp280=
_data *data,
> > >  	return (u32)p;
> > >  }
> > > =20
> > > -static int bmp280_read_temp(struct bmp280_data *data,
> > > -			    int *val, int *val2)
> > > +static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
> > >  {
> > > -	s32 adc_temp, comp_temp;
> > > +	s32 adc_temp;
> > >  	int ret;
> > > =20
> > >  	ret =3D regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > > @@ -382,29 +381,20 @@ static int bmp280_read_temp(struct bmp280_data =
*data,
> > >  		dev_err(data->dev, "reading temperature skipped\n");
> > >  		return -EIO;
> > >  	}
> > > -	comp_temp =3D bmp280_compensate_temp(data, adc_temp);
> > > =20
> > > -	/*
> > > -	 * val might be NULL if we're called by the read_press routine,
> > > -	 * who only cares about the carry over t_fine value.
> > > -	 */
> > > -	if (val) {
> > > -		*val =3D comp_temp * 10;
> > > -		return IIO_VAL_INT;
> > > -	}
> > > +	if (comp_temp)
> > > +		*comp_temp =3D bmp280_compensate_temp(data, adc_temp); =20
> >=20
> > As below, I don't think this is updating t_fine.
> > Another reason to make that update very obvious rather than burried
> > in this function call.
> >  =20
> > > =20
> > >  	return 0;
> > >  }
> > > =20
> > > -static int bmp280_read_press(struct bmp280_data *data,
> > > -			     int *val, int *val2)
> > > +static int bmp280_read_press(struct bmp280_data *data, u32 *comp_pre=
ss)
> > >  {
> > > -	u32 comp_press;
> > >  	s32 adc_press;
> > >  	int ret;
> > > =20
> > >  	/* Read and compensate temperature so we get a reading of t_fine. */
> > > -	ret =3D bmp280_read_temp(data, NULL, NULL);
> > > +	ret =3D bmp280_read_temp(data, NULL);
> > >  	if (ret < 0)
> > >  		return ret;
> > > =20
> > > @@ -421,22 +411,19 @@ static int bmp280_read_press(struct bmp280_data=
 *data,
> > >  		dev_err(data->dev, "reading pressure skipped\n");
> > >  		return -EIO;
> > >  	}
> > > -	comp_press =3D bmp280_compensate_press(data, adc_press);
> > > =20
> > > -	*val =3D comp_press;
> > > -	*val2 =3D 256000;
> > > +	*comp_press =3D bmp280_compensate_press(data, adc_press);
> > > =20
> > > -	return IIO_VAL_FRACTIONAL;
> > > +	return 0;
> > >  }
> > > =20
> > > -static int bmp280_read_humid(struct bmp280_data *data, int *val, int=
 *val2)
> > > +static int bmp280_read_humid(struct bmp280_data *data, u32 *comp_hum=
idity)
> > >  {
> > > -	u32 comp_humidity;
> > >  	s32 adc_humidity;
> > >  	int ret;
> > > =20
> > >  	/* Read and compensate temperature so we get a reading of t_fine. */
> > > -	ret =3D bmp280_read_temp(data, NULL, NULL);
> > > +	ret =3D bmp280_read_temp(data, NULL);
> > >  	if (ret < 0)
> > >  		return ret;
> > > =20
> > > @@ -453,11 +440,10 @@ static int bmp280_read_humid(struct bmp280_data=
 *data, int *val, int *val2)
> > >  		dev_err(data->dev, "reading humidity skipped\n");
> > >  		return -EIO;
> > >  	}
> > > -	comp_humidity =3D bmp280_compensate_humidity(data, adc_humidity);
> > > =20
> > > -	*val =3D comp_humidity * 1000 / 1024;
> > > +	*comp_humidity =3D bmp280_compensate_humidity(data, adc_humidity);
> > > =20
> > > -	return IIO_VAL_INT;
> > > +	return 0;
> > >  }
> > > =20
> > >  static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
> > > @@ -465,6 +451,8 @@ static int bmp280_read_raw_guarded(struct iio_dev=
 *indio_dev,
> > >  				   int *val, int *val2, long mask)
> > >  {
> > >  	struct bmp280_data *data =3D iio_priv(indio_dev);
> > > +	int chan_value;
> > > +	int ret;
> > > =20
> > >  	guard(mutex)(&data->lock);
> > > =20
> > > @@ -472,11 +460,29 @@ static int bmp280_read_raw_guarded(struct iio_d=
ev *indio_dev,
> > >  	case IIO_CHAN_INFO_PROCESSED:
> > >  		switch (chan->type) {
> > >  		case IIO_HUMIDITYRELATIVE:
> > > -			return data->chip_info->read_humid(data, val, val2);
> > > +			ret =3D data->chip_info->read_humid(data, &chan_value);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			*val =3D data->chip_info->humid_coeffs[0] * chan_value;
> > > +			*val2 =3D data->chip_info->humid_coeffs[1];
> > > +			return data->chip_info->humid_coeffs_type;
> > >  		case IIO_PRESSURE:
> > > -			return data->chip_info->read_press(data, val, val2);
> > > +			ret =3D data->chip_info->read_press(data, &chan_value);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			*val =3D data->chip_info->press_coeffs[0] * chan_value;
> > > +			*val2 =3D data->chip_info->press_coeffs[1];
> > > +			return data->chip_info->press_coeffs_type;
> > >  		case IIO_TEMP:
> > > -			return data->chip_info->read_temp(data, val, val2);
> > > +			ret =3D data->chip_info->read_temp(data, &chan_value);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			*val =3D data->chip_info->temp_coeffs[0] * chan_value;
> > > +			*val2 =3D data->chip_info->temp_coeffs[1];
> > > +			return data->chip_info->temp_coeffs_type;
> > >  		default:
> > >  			return -EINVAL;
> > >  		}
> > > @@ -787,6 +793,8 @@ static int bmp280_chip_config(struct bmp280_data =
*data)
> > > =20
> > >  static const int bmp280_oversampling_avail[] =3D { 1, 2, 4, 8, 16 };
> > >  static const u8 bmp280_chip_ids[] =3D { BMP280_CHIP_ID };
> > > +static const int bmp280_temp_coeffs[] =3D { 10, 1 };
> > > +static const int bmp280_press_coeffs[] =3D { 1, 256000 };
> > > =20
> > >  const struct bmp280_chip_info bmp280_chip_info =3D {
> > >  	.id_reg =3D BMP280_REG_ID,
> > > @@ -815,6 +823,11 @@ const struct bmp280_chip_info bmp280_chip_info =
=3D {
> > >  	.num_oversampling_press_avail =3D ARRAY_SIZE(bmp280_oversampling_av=
ail),
> > >  	.oversampling_press_default =3D BMP280_OSRS_PRESS_16X - 1,
> > > =20
> > > +	.temp_coeffs =3D bmp280_temp_coeffs,
> > > +	.temp_coeffs_type =3D IIO_VAL_FRACTIONAL,
> > > +	.press_coeffs =3D bmp280_press_coeffs,
> > > +	.press_coeffs_type =3D IIO_VAL_FRACTIONAL,
> > > +
> > >  	.chip_config =3D bmp280_chip_config,
> > >  	.read_temp =3D bmp280_read_temp,
> > >  	.read_press =3D bmp280_read_press,
> > > @@ -841,6 +854,7 @@ static int bme280_chip_config(struct bmp280_data =
*data)
> > >  }
> > > =20
> > >  static const u8 bme280_chip_ids[] =3D { BME280_CHIP_ID };
> > > +static const int bme280_humid_coeffs[] =3D { 1000, 1024 };
> > > =20
> > >  const struct bmp280_chip_info bme280_chip_info =3D {
> > >  	.id_reg =3D BMP280_REG_ID,
> > > @@ -863,6 +877,14 @@ const struct bmp280_chip_info bme280_chip_info =
=3D {
> > >  	.num_oversampling_humid_avail =3D ARRAY_SIZE(bmp280_oversampling_av=
ail),
> > >  	.oversampling_humid_default =3D BMP280_OSRS_HUMIDITY_16X - 1,
> > > =20
> > > +	.temp_coeffs =3D bmp280_temp_coeffs,
> > > +	.temp_coeffs_type =3D IIO_VAL_FRACTIONAL,
> > > +	.press_coeffs =3D bmp280_press_coeffs,
> > > +	.press_coeffs_type =3D IIO_VAL_FRACTIONAL,
> > > +	.humid_coeffs =3D bme280_humid_coeffs,
> > > +	.humid_coeffs_type =3D IIO_VAL_FRACTIONAL,
> > > +
> > > + =20
> > One blank line is almost always enough.
> >  =20
> > >  	.chip_config =3D bme280_chip_config,
> > >  	.read_temp =3D bmp280_read_temp,
> > >  	.read_press =3D bmp280_read_press,
> > > @@ -988,9 +1010,8 @@ static u32 bmp380_compensate_press(struct bmp280=
_data *data, u32 adc_press)
> > >  	return comp_press;
> > >  }
> > > =20
> > > -static int bmp380_read_temp(struct bmp280_data *data, int *val, int =
*val2)
> > > +static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
> > >  {
> > > -	s32 comp_temp;
> > >  	u32 adc_temp;
> > >  	int ret;
> > > =20
> > > @@ -1006,29 +1027,20 @@ static int bmp380_read_temp(struct bmp280_dat=
a *data, int *val, int *val2)
> > >  		dev_err(data->dev, "reading temperature skipped\n");
> > >  		return -EIO;
> > >  	}
> > > -	comp_temp =3D bmp380_compensate_temp(data, adc_temp);
> > > =20
> > > -	/*
> > > -	 * Val might be NULL if we're called by the read_press routine,
> > > -	 * who only cares about the carry over t_fine value.
> > > -	 */
> > > -	if (val) {
> > > -		/* IIO reports temperatures in milli Celsius */
> > > -		*val =3D comp_temp * 10;
> > > -		return IIO_VAL_INT;
> > > -	}
> > > +	if (comp_temp)
> > > +		*comp_temp =3D bmp380_compensate_temp(data, adc_temp);
> > >   =20
> >=20
> > I'm confused. If comp_temp is not provided then t_fine isn't updated
> > so this function isn't doing anything?
> >  =20
> > >  	return 0;
> > >  }
> > > =20
> > > -static int bmp380_read_press(struct bmp280_data *data, int *val, int=
 *val2)
> > > +static int bmp380_read_press(struct bmp280_data *data, u32 *comp_pre=
ss)
> > >  {
> > > -	s32 comp_press;
> > >  	u32 adc_press;
> > >  	int ret;
> > > =20
> > >  	/* Read and compensate for temperature so we get a reading of t_fin=
e */ =20
> >=20
> > As above, I don't think it does.=20
> >  =20
> > > -	ret =3D bmp380_read_temp(data, NULL, NULL);
> > > +	ret =3D bmp380_read_temp(data, NULL);
> > >  	if (ret)
> > >  		return ret;
> > > =20
> > > @@ -1044,13 +1056,10 @@ static int bmp380_read_press(struct bmp280_da=
ta *data, int *val, int *val2)
> > >  		dev_err(data->dev, "reading pressure skipped\n");
> > >  		return -EIO;
> > >  	}
> > > -	comp_press =3D bmp380_compensate_press(data, adc_press);
> > > =20
> > > -	*val =3D comp_press;
> > > -	/* Compensated pressure is in cPa (centipascals) */
> > > -	*val2 =3D 100000;
> > > +	*comp_press =3D bmp380_compensate_press(data, adc_press);
> > > =20
> > > -	return IIO_VAL_FRACTIONAL;
> > > +	return 0;
> > >  }
> > >   =20
> >=20
> > J =20


