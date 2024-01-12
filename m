Return-Path: <linux-kernel+bounces-24906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE082C481
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EAA1F24AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E922609;
	Fri, 12 Jan 2024 17:14:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497917C83;
	Fri, 12 Jan 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBSkn3kDJz6K5sk;
	Sat, 13 Jan 2024 01:12:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CB7D9140B2A;
	Sat, 13 Jan 2024 01:13:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 17:13:57 +0000
Date: Fri, 12 Jan 2024 17:13:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/6] iio: pressure: hsc030pa add sleep mode
Message-ID: <20240112171356.00003e88@Huawei.com>
In-Reply-To: <20240110172306.31273-7-petre.rodan@subdimension.ro>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
	<20240110172306.31273-7-petre.rodan@subdimension.ro>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jan 2024 19:22:41 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Some custom chips from this series require a wakeup sequence before the
> measurement cycle is started.
>=20
> Quote from the product datasheet:
> "Optional sleep mode available upon special request."
>=20
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/pressure/hsc030pa.c     |  4 ++++
>  drivers/iio/pressure/hsc030pa.h     |  4 ++++
>  drivers/iio/pressure/hsc030pa_i2c.c | 19 +++++++++++++++++
>  drivers/iio/pressure/hsc030pa_spi.c | 32 +++++++++++++++++++++++++++--
>  4 files changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc03=
0pa.c
> index 3faa0fd42201..9e66fd561801 100644
> --- a/drivers/iio/pressure/hsc030pa.c
> +++ b/drivers/iio/pressure/hsc030pa.c
> @@ -501,6 +501,10 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn=
 recv)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "pressure limits are invalid\n");
>=20
> +	ret =3D device_property_read_bool(dev, "honeywell,sleep-mode");
> +	if (ret)
> +		hsc->capabilities |=3D HSC_CAP_SLEEP;
	if (device_property_read_bool())
		hsc->cap...

The return value is not an int so it's inappropriate to stash it in ret.

> +
>  	ret =3D devm_regulator_get_enable(dev, "vdd");
>  	if (ret)
>  		return dev_err_probe(dev, ret, "can't get vdd supply\n");
> diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc03=
0pa.h
> index 6c635c42d85d..4e356944d67d 100644
> --- a/drivers/iio/pressure/hsc030pa.h
> +++ b/drivers/iio/pressure/hsc030pa.h
> @@ -15,6 +15,8 @@
>  #define HSC_REG_MEASUREMENT_RD_SIZE 4
>  #define HSC_RESP_TIME_MS            2
>=20
> +#define HSC_CAP_SLEEP               0x1
> +
>  struct device;
>=20
>  struct iio_chan_spec;
> @@ -29,6 +31,7 @@ typedef int (*hsc_recv_fn)(struct hsc_data *);
>   * struct hsc_data
>   * @dev: current device structure
>   * @chip: structure containing chip's channel properties
> + * @capabilities: chip specific attributes
>   * @recv_cb: function that implements the chip reads
>   * @is_valid: true if last transfer has been validated
>   * @pmin: minimum measurable pressure limit
> @@ -45,6 +48,7 @@ typedef int (*hsc_recv_fn)(struct hsc_data *);
>  struct hsc_data {
>  	struct device *dev;
>  	const struct hsc_chip_data *chip;
> +	u32 capabilities;
>  	hsc_recv_fn recv_cb;
>  	bool is_valid;
>  	s32 pmin;
> diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/h=
sc030pa_i2c.c
> index b3fd230e71da..62bdae272012 100644
> --- a/drivers/iio/pressure/hsc030pa_i2c.c
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -24,8 +24,27 @@ static int hsc_i2c_recv(struct hsc_data *data)
>  {
>  	struct i2c_client *client =3D to_i2c_client(data->dev);
>  	struct i2c_msg msg;
> +	u8 buf;
>  	int ret;
>=20
> +	if (data->capabilities & HSC_CAP_SLEEP) {
> +		/*
> +		 * Send the Full Measurement Request (FMR) command on the CS
> +		 * line in order to wake up the sensor as per
> +		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
> +		 * technical note (consult the datasheet link in the header).
> +		 *
> +		 * These specifications require a dummy packet comprised only by
> +		 * a single byte that contains the 7bit slave address and the
> +		 * READ bit followed by a STOP.
> +		 * Because the i2c API does not allow packets without a payload,
> +		 * the driver sends two bytes in this implementation.
> +		 */
> +		ret =3D i2c_master_recv(client, &buf, 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	msleep_interruptible(HSC_RESP_TIME_MS);
>=20
>  	msg.addr =3D client->addr;
> diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/h=
sc030pa_spi.c
> index 737197eddff0..1c139cdfe856 100644
> --- a/drivers/iio/pressure/hsc030pa_spi.c
> +++ b/drivers/iio/pressure/hsc030pa_spi.c
> @@ -25,12 +25,40 @@ static int hsc_spi_recv(struct hsc_data *data)
>  	struct spi_device *spi =3D to_spi_device(data->dev);
>  	struct spi_transfer xfer =3D {
>  		.tx_buf =3D NULL,
> -		.rx_buf =3D data->buffer,
> -		.len =3D HSC_REG_MEASUREMENT_RD_SIZE,
> +		.rx_buf =3D NULL,
> +		.len =3D 0,
>  	};
> +	u16 orig_cs_setup_value;
> +	u8 orig_cs_setup_unit;
> +
> +	if (data->capabilities & HSC_CAP_SLEEP) {
> +		/*
> +		 * Send the Full Measurement Request (FMR) command on the CS
> +		 * line in order to wake up the sensor as per
> +		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
> +		 * technical note (consult the datasheet link in the header).
> +		 *
> +		 * These specifications require the CS line to be held asserted
> +		 * for at least 8=B5s without any payload being generated.
> +		 */
> +		orig_cs_setup_value =3D spi->cs_setup.value;
> +		orig_cs_setup_unit =3D spi->cs_setup.unit;
> +		spi->cs_setup.value =3D 8;
> +		spi->cs_setup.unit =3D SPI_DELAY_UNIT_USECS;
> +		/*
> +		 * Send a dummy 0-size packet so that CS gets toggled.
> +		 * Trying to manually call spi->controller->set_cs() instead
> +		 * does not work as expected during the second call.
> +		 */

Do you have a reference that says the CS must be toggled on 0 length transf=
er?
If that's not specified in the SPI core somewhere then you will need to send
something...

> +		spi_sync_transfer(spi, &xfer, 1);
> +		spi->cs_setup.value =3D orig_cs_setup_value;
> +		spi->cs_setup.unit =3D orig_cs_setup_unit;
> +	}
>=20
>  	msleep_interruptible(HSC_RESP_TIME_MS);
>=20
> +	xfer.rx_buf =3D data->buffer;
> +	xfer.len =3D HSC_REG_MEASUREMENT_RD_SIZE;
>  	return spi_sync_transfer(spi, &xfer, 1);
>  }
>=20
> --
> 2.41.0
>=20
>=20


