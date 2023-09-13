Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7479E27A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjIMIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbjIMIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:45:17 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4CF19A7;
        Wed, 13 Sep 2023 01:45:09 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 508A686545;
        Wed, 13 Sep 2023 10:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694594707;
        bh=ZlWhPmQz1RldSvKuhGgzm2U7P11OPn+ykHmTOEnCUEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V6Y2A9PVmlquHLOQ8EF6Yfvgiy8PKQQFKKTaLThSgRp+qtSbsdseTkgIVpYwAPC98
         knY0wJrI3ZDgQpM9Pcc5OqZ+61n+Fi5ioyKa2XnPChG8OZ4AfvuNwH3fysVxsjllJp
         EEjLsESz+N67lz5/0K9J454skccedSSF2ixJQvOfoWIOP3mBDctkA3rllVcYzgm0nd
         8mmpdj4OuMAzDKMlhmnlGgWxrp0KiS37gY1ewug02EPf2r3JMSB5VNeQjj2mXIsGsH
         V1OswQs3CpANNGqewDmBIHN3D0rGVniCmMwccY0ci/q6kKzv7BExXy+l93wIPAqmJy
         ZBsrhrkQLIvHw==
Date:   Wed, 13 Sep 2023 10:44:58 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <20230913104458.1d4cdd51@wsk>
In-Reply-To: <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
        <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DJo1IhAiFfHPBz=pE_nTB6W";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DJo1IhAiFfHPBz=pE_nTB6W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

> Register MAC-PHY interrupt and handle reset complete interrupt. Reset
> complete bit is set when the MAC-PHY reset complete and ready for
> configuration. When it is set, it will generate a non-maskable
> interrupt to alert the SPI host. Additionally reset complete bit in
> the STS0 register has to be written by one upon reset complete to
> clear the interrupt.

I'm using the MicroE module with LAN8651 device connected to nucleo
STM32G4 microcontroller.

Maybe not directly related to Linux, but I would like to ask for some
clarification.

>=20
> Signed-off-by: Parthiban Veerasooran
> <Parthiban.Veerasooran@microchip.com> ---
>  drivers/net/ethernet/oa_tc6.c | 141
> ++++++++++++++++++++++++++++++++-- include/linux/oa_tc6.h        |
> 16 +++- 2 files changed, 150 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/oa_tc6.c
> b/drivers/net/ethernet/oa_tc6.c index 613cf034430a..0019f70345b6
> 100644 --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/bitfield.h>
> +#include <linux/interrupt.h>
>  #include <linux/oa_tc6.h>
> =20
>  static int oa_tc6_spi_transfer(struct spi_device *spi, u8 *ptx, u8
> *prx, @@ -160,10 +161,16 @@ int oa_tc6_perform_ctrl(struct oa_tc6
> *tc6, u32 addr, u32 val[], u8 len, if (ret)
>  		goto err_ctrl;
> =20
> -	/* Check echoed/received control reply */
> -	ret =3D oa_tc6_check_control(tc6, tx_buf, rx_buf, len, wnr,
> ctrl_prot);
> -	if (ret)
> -		goto err_ctrl;
> +	/* In case of reset write, the echoed control command
> doesn't have any
> +	 * valid data. So no need to check for error.
> +	 */
> +	if (addr !=3D OA_TC6_RESET) {
> +		/* Check echoed/received control reply */
> +		ret =3D oa_tc6_check_control(tc6, tx_buf, rx_buf, len,
> wnr,
> +					   ctrl_prot);
> +		if (ret)
> +			goto err_ctrl;
> +	}
> =20
>  	if (!wnr) {
>  		/* Copy read data from the rx data in case of ctrl
> read */ @@ -186,6 +193,88 @@ int oa_tc6_perform_ctrl(struct oa_tc6
> *tc6, u32 addr, u32 val[], u8 len, return ret;
>  }
> =20
> +static int oa_tc6_handler(void *data)
> +{
> +	struct oa_tc6 *tc6 =3D data;
> +	u32 regval;
> +	int ret;
> +
> +	while (likely(!kthread_should_stop())) {
> +		wait_event_interruptible(tc6->tc6_wq, tc6->int_flag
> ||
> +					 kthread_should_stop());
> +		if (tc6->int_flag) {
> +			tc6->int_flag =3D false;
> +			ret =3D oa_tc6_perform_ctrl(tc6, OA_TC6_STS0,
> &regval, 1,
> +						  false, false);
> +			if (ret) {
> +				dev_err(&tc6->spi->dev, "Failed to
> read STS0\n");
> +				continue;
> +			}
> +			/* Check for reset complete interrupt status
> */
> +			if (regval & RESETC) {

Just maybe mine small remark. IMHO the reset shall not pollute the IRQ
hander. The RESETC is just set on the initialization phase and only
then shall be served. Please correct me if I'm wrong, but it will not
be handled during "normal" operation.

> +				regval =3D RESETC;
> +				/* SPI host should write RESETC bit
> with one to
> +				 * clear the reset interrupt status.
> +				 */
> +				ret =3D oa_tc6_perform_ctrl(tc6,
> OA_TC6_STS0,
> +							  &regval,
> 1, true,
> +							  false);

Is this enough to have the IRQ_N deasserted (i.e. pulled HIGH)?

The documentation states it clearly that one also needs to set SYNC bit
(BIT(15)) in the OA_CONFIG0 register (which would have the 0x8006 value).

Mine problem is that even after writing 0x40 to OA_STATUS0 and 0x8006
to OA_CONFIG0 the IRQ_N is still LOW (it is pulled up via 10K resistor).

(I'm able to read those registers and those show expected values)

> +				if (ret) {
> +					dev_err(&tc6->spi->dev,
> +						"Failed to write
> STS0\n");
> +					continue;
> +				}
> +				complete(&tc6->rst_complete);
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t macphy_irq(int irq, void *dev_id)
> +{
> +	struct oa_tc6 *tc6 =3D dev_id;
> +
> +	/* Wake tc6 task to perform interrupt action */
> +	tc6->int_flag =3D true;
> +	wake_up_interruptible(&tc6->tc6_wq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
> +{
> +	long timeleft;
> +	u32 regval;
> +	int ret;
> +
> +	/* Perform software reset with both protected and
> unprotected control
> +	 * commands because the driver doesn't know the current
> status of the
> +	 * MAC-PHY.
> +	 */
> +	regval =3D SW_RESET;
> +	reinit_completion(&tc6->rst_complete);
> +	ret =3D oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1,
> true, false);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "RESET register write
> failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1,
> true, true);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "RESET register write
> failed\n");
> +		return ret;
> +	}
> +	timeleft =3D

Was it on purpose to not use the RST_N pin to perform GPIO based reset?

When I generate reset pulse (and keep it for low for > 5us) the IRQ_N
gets high. After some time it gets low (as expected). But then it
doesn't get high any more.

> wait_for_completion_interruptible_timeout(&tc6->rst_complete,
> +
> msecs_to_jiffies(1));

Please also clarify - does the LAN8651 require up to 1ms "settle down"
(after reset) time before it gets operational again?

> +	if (timeleft <=3D 0) {
> +		dev_err(&tc6->spi->dev, "MAC-PHY reset failed\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val[],
> u8 len) {
>  	return oa_tc6_perform_ctrl(tc6, addr, val, len, true,
> tc6->ctrl_prot); @@ -201,6 +290,7 @@
> EXPORT_SYMBOL_GPL(oa_tc6_read_register); struct oa_tc6
> *oa_tc6_init(struct spi_device *spi) {
>  	struct oa_tc6 *tc6;
> +	int ret;
> =20
>  	if (!spi)
>  		return NULL;
> @@ -211,12 +301,51 @@ struct oa_tc6 *oa_tc6_init(struct spi_device
> *spi)=20
>  	tc6->spi =3D spi;
> =20
> +	/* Used for triggering the OA TC6 task */
> +	init_waitqueue_head(&tc6->tc6_wq);
> +
> +	init_completion(&tc6->rst_complete);
> +
> +	/* This task performs the SPI transfer */
> +	tc6->tc6_task =3D kthread_run(oa_tc6_handler, tc6, "OA TC6
> Task");
> +	if (IS_ERR(tc6->tc6_task))
> +		goto err_tc6_task;
> +
> +	/* Set the highest priority to the tc6 task as it is time
> critical */
> +	sched_set_fifo(tc6->tc6_task);
> +
> +	/* Register MAC-PHY interrupt service routine */
> +	ret =3D devm_request_irq(&spi->dev, spi->irq, macphy_irq, 0,
> "macphy int",
> +			       tc6);
> +	if ((ret !=3D -ENOTCONN) && ret < 0) {
> +		dev_err(&spi->dev, "Error attaching macphy irq
> %d\n", ret);
> +		goto err_macphy_irq;
> +	}
> +
> +	/* Perform MAC-PHY software reset */
> +	if (oa_tc6_sw_reset(tc6))
> +		goto err_macphy_reset;
> +
>  	return tc6;
> +
> +err_macphy_reset:
> +	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> +err_macphy_irq:
> +	kthread_stop(tc6->tc6_task);
> +err_tc6_task:
> +	kfree(tc6);
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_init);
> =20
> -void oa_tc6_deinit(struct oa_tc6 *tc6)
> +int oa_tc6_deinit(struct oa_tc6 *tc6)
>  {
> -	kfree(tc6);
> +	int ret;
> +
> +	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> +	ret =3D kthread_stop(tc6->tc6_task);
> +	if (!ret)
> +		kfree(tc6);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_deinit);
> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 5e0a58ab1dcd..315f061c2dfe 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -17,15 +17,29 @@
>  #define CTRL_HDR_LEN	GENMASK(7, 1)	/* Length */
>  #define CTRL_HDR_P	BIT(0)		/* Parity Bit */
> =20
> +/* Open Alliance TC6 Standard Control and Status Registers */
> +#define OA_TC6_RESET	0x0003		/* Reset Control
> and Status Register */ +#define OA_TC6_STS0	0x0008
> 	/* Status Register #0 */ +
> +/* RESET register field */
> +#define SW_RESET	BIT(0)		/* Software Reset */
> +
> +/* STATUS0 register field */
> +#define RESETC		BIT(6)		/* Reset
> Complete */ +
>  #define TC6_HDR_SIZE	4		/* Ctrl command header
> size as per OA */ #define TC6_FTR_SIZE	4		/*
> Ctrl command footer size ss per OA */=20
>  struct oa_tc6 {
>  	struct spi_device *spi;
>  	bool ctrl_prot;
> +	struct task_struct *tc6_task;
> +	wait_queue_head_t tc6_wq;
> +	bool int_flag;
> +	struct completion rst_complete;
>  };
> =20
>  struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
> -void oa_tc6_deinit(struct oa_tc6 *tc6);
> +int oa_tc6_deinit(struct oa_tc6 *tc6);
>  int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 value[],
> u8 len); int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32
> value[], u8 len);




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/DJo1IhAiFfHPBz=pE_nTB6W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUBdooACgkQAR8vZIA0
zr0+qAgAijD2xWlrJP0Q+Q/4BmtBBN4mFK4gnhBpJTT7O8jEXM8YEDznoZ/pK5IN
RePC1m2cKz5HwcLIXvUI6LWSFJ0Zz8Q3Uxdatb43lgHeuVZRPRHLlcfJUvk76zUb
5oxoYFGPcOOWoPbRSlvnnVFmN6IS9IilKRlIQ8MkD6LVRknbR6guZEXc9HBA/JRL
MP+FxZDGu3iZ95Ov7QM449odOPSArZw14L9uawrNeL0hTcvBhlOGTSukKDI4lOzJ
K0qJM8n9ksx27FyjeW4bMQdCnDX2pp+tRiKlahxvaFU462dfoU5tLLxyKz6ROrnN
kM6jfLtY/JotZ2x3X99l7YO0aVaMew==
=jGDj
-----END PGP SIGNATURE-----

--Sig_/DJo1IhAiFfHPBz=pE_nTB6W--
