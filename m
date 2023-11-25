Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8FA7F8DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjKYT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:29:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13011B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:29:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9390C433C8;
        Sat, 25 Nov 2023 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700940556;
        bh=wnRXRAGuX2vqNrxepLLfxWBVjVl7h3q7QguFF9pzdsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CMay7EW+gjmUQa1C/JnH0mCFbV+upKUxR2TM1XfsOZa1aQZr0HF3Ut9/UL66wNSrS
         OvV5JICiOA9Q4Ti9LD2BCGCjJn9ZCz0euHvzNtJ3QoOqT0rARYMpTdUQWNDn8P8l0n
         22RWzyQOSCvtbiR/ssxGbMu2M2pXm4LNr1752UnRiebXjRrC0LaRsfj7VA+1w1RugF
         k2WSVSacbmUTmluV+fbPNjcXoc0XjYMRcsCeITAx6Y4F+782TqICjqx7Mga2idELVu
         5Q8GxmVjOu/DTSCYHesSjFPNHldCcnu2j0MAz5vdehCGrbaQu9lDd+Bc4IHOZtOzBS
         130HY5sBm3lkQ==
Date:   Sat, 25 Nov 2023 19:29:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hiten Chauhan <hiten.chauhan@siliconsignals.io>
Cc:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
Message-ID: <20231125192908.4f10b458@jic23-huawei>
In-Reply-To: <MAXPR01MB4118176054665C88E3C6FAE7EABFA@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
References: <20231117151446.49738-1-hiten.chauhan@siliconsignals.io>
        <FR3P281MB17576C325FD416F14DCE4B7FCEB4A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
        <MAXPR01MB4118176054665C88E3C6FAE7EABFA@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 07:05:50 +0000
Hiten Chauhan <hiten.chauhan@siliconsignals.io> wrote:

> Hello Jean,
>=20
> Thanks for your support,
>=20
> For the first issue can I use "struct iio_event_spec" for tilt interrupt =
instead of a custom sysfs file?
Yes - that will cover the configuration aspects.

It should ultimately be reported via iio_push_event()
which reports to userspace via a chardev. See the example code in tools/iio=
/iio_event_monitor.c

Jonathan

>=20
> In the second issue I have just disabled tilt related register so when I =
turn tilt off other functionality on the accelerometer will work fine. can =
you please cross-check?
>=20
> Thanks & Regards,
> Hiten Chauhan
> ________________________________
> From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Sent: Monday, November 20, 2023 7:48 PM
> To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; jic23@kernel.org <ji=
c23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.o=
rg <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@=
vger.kernel.org>
> Cc: kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
>=20
> Hello Hiten,
>=20
> thanks for your patch.
>=20
> I see first a big issue at the root. Tilt event is something that should =
be reported as an IIO event, not in a custom sysfs file. Jonathan can confi=
rm this, but this is my understanding.
>=20
> Second issue, there is no multiplexing between the tilt and normal data s=
ampling. Meaning turning tilt off will stop the data output of the chip if =
it was on. And turning data output off will stop tilt functionnality. All t=
hese things have to be multiplexed together and chip power off/on must be c=
entralized.
>=20
> Thanks for your work.
>=20
> Best regards,
> JB
>=20
> From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> Sent: Friday, November 17, 2023 16:14
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel=
.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.=
kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux=
-kernel@vger.kernel.org>
> Cc: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; kernel test robot <l=
kp@intel.com>
> Subject: [PATCH v3] Added tilt interrupt support in inv_icm42600
>=20
> Description: Add new device attribute to enable and disable Tilt interrup=
t from kernel user space Signed-off-by: Hiten Chauhan <hiten.=E2=80=8Achauh=
an@=E2=80=8Asiliconsignals.=E2=80=8Aio> Reported-by: kernel test robot <lkp=
@=E2=80=8Aintel.=E2=80=8Acom> Closes: https:=E2=80=8A//urldefense.=E2=80=8A=
com/v3/__https:=E2=80=8A//lore.=E2=80=8Akernel.=E2=80=8Aorg/oe-kbuild-all/2=
02311170235.=E2=80=8AHaVJnmWa-lkp@=E2=80=8Aintel.=E2=80=8Acom/__;!!FtrhtPsW=
DhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZy=
tNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[.=E2=80=8A]kernel[.=E2=80=8A]org]
> ZjQcmQRYFpfptBannerStart
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
>=20
> ZjQcmQRYFpfptBannerEnd
> Description:
> Add new device attribute to enable and disable
> Tilt interrupt from kernel user space
>=20
> Signed-off-by: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all=
/202311170235.HaVJnmWa-lkp@intel.com/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy=
7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg=
_rGWg$[lore[.]kernel[.]org]
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  24 ++++
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 129 ++++++++++++++++++
>  2 files changed, 153 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h
> index 0e290c807b0f..39ed39e77deb 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -187,6 +187,8 @@ struct inv_icm42600_state {
>  #define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL           \
>                  FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 2)
>=20
> +#define INV_ICM42600_REG_MASK        GENMASK(7, 0)
> +
>  /* all sensor data are 16 bits (2 registers wide) in big-endian */
>  #define INV_ICM42600_REG_TEMP_DATA                      0x001D
>  #define INV_ICM42600_REG_ACCEL_DATA_X                   0x001F
> @@ -239,6 +241,7 @@ struct inv_icm42600_state {
>  #define INV_ICM42600_REG_PWR_MGMT0                      0x004E
>  #define INV_ICM42600_PWR_MGMT0_TEMP_DIS                 BIT(5)
>  #define INV_ICM42600_PWR_MGMT0_IDLE                     BIT(4)
> +#define INV_ICM42600_PWR_ACCEL_MODE                    BIT(1)
>  #define INV_ICM42600_PWR_MGMT0_GYRO(_mode)              \
>                  FIELD_PREP(GENMASK(3, 2), (_mode))
>  #define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)             \
> @@ -306,6 +309,21 @@ struct inv_icm42600_state {
>  #define INV_ICM42600_WHOAMI_ICM42622                    0x46
>  #define INV_ICM42600_WHOAMI_ICM42631                    0x5C
>=20
> +/* Register configs for tilt interrupt */
> +#define INV_ICM42605_REG_APEX_CONFIG4                  0x4043
> +#define INV_ICM42605_APEX_CONFIG4_MASK                 GENMASK(7, 0)
> +
> +#define INV_ICM42605_REG_APEX_CONFIG0                  0x0056
> +#define INV_ICM42605_APEX_CONFIG0_TILT_ENABLE          BIT(4)
> +#define INV_ICM42605_APEX_CONFIG0                      BIT(1)
> +
> +#define INV_ICM42605_REG_INTF_CONFIG1                   0x404D
> +#define INV_ICM42605_INTF_CONFIG1_MASK                  GENMASK(5, 0)
> +#define INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_EN      BIT(3)
> +
> +#define INV_ICM42605_REG_INT_STATUS3                   0x0038
> +
> +
>  /* User bank 1 (MSB 0x10) */
>  #define INV_ICM42600_REG_SENSOR_CONFIG0                 0x1003
>  #define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE          BIT(5)
> @@ -364,6 +382,8 @@ typedef int (*inv_icm42600_bus_setup)(struct inv_icm4=
2600_state *);
>  extern const struct regmap_config inv_icm42600_regmap_config;
>  extern const struct dev_pm_ops inv_icm42600_pm_ops;
>=20
> +extern uint8_t inv_icm42605_int_reg;
> +
>  const struct iio_mount_matrix *
>  inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
>                                const struct iio_chan_spec *chan);
> @@ -395,4 +415,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_ic=
m42600_state *st);
>=20
>  int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
>=20
> +int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state *st);
> +
> +int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st);
> +
>  #endif
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c
> index b1e4fde27d25..311f6ea09e64 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -47,6 +47,8 @@
>                  .ext_info =3D _ext_info,                                =
  \
>          }
>=20
> +uint8_t inv_icm42605_int_reg;
> +
>  enum inv_icm42600_accel_scan {
>          INV_ICM42600_ACCEL_SCAN_X,
>          INV_ICM42600_ACCEL_SCAN_Y,
> @@ -60,6 +62,68 @@ static const struct iio_chan_spec_ext_info inv_icm4260=
0_accel_ext_infos[] =3D {
>          {},
>  };
>=20
> +static ssize_t tilt_interrupt_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
> +{
> +       struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D regmap_read(st->map, inv_icm42605_int_reg, &val);
> +
> +       if (ret !=3D 0)
> +               return ret;
> +
> +       snprintf(buf, PAGE_SIZE, "Read reg %x value %x\n", inv_icm42605_i=
nt_reg, val);
> +
> +       return strlen(buf);
> +}
> +
> +static ssize_t tilt_interrupt_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf,
> +               size_t count)
> +{
> +       struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> +       int ret;
> +       int value;
> +
> +       if (!st)
> +               return -EINVAL;
> +
> +       if (kstrtoint(buf, 10, &value))
> +               return -EINVAL;
> +
> +       inv_icm42605_int_reg =3D INV_ICM42605_REG_INT_STATUS3;
> +
> +       switch (value) {
> +       case 1:
> +               ret =3D inv_icm42605_generate_tilt_interrupt(st);
> +               if (ret !=3D 0)
> +                       return -EIO;
> +               break;
> +       case 0:
> +               ret =3D inv_icm42605_disable_tilt_interrupt(st);
> +               if (ret !=3D 0)
> +                       return -EIO;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RW(tilt_interrupt);
> +
> +static struct attribute *icm42605_attrs[] =3D {
> +       &dev_attr_tilt_interrupt.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group icm42605_attrs_group =3D {
> +       .attrs =3D icm42605_attrs,
> +};
> +
>  static const struct iio_chan_spec inv_icm42600_accel_channels[] =3D {
>          INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
>                                  inv_icm42600_accel_ext_infos),
> @@ -702,6 +766,7 @@ static const struct iio_info inv_icm42600_accel_info =
=3D {
>          .update_scan_mode =3D inv_icm42600_accel_update_scan_mode,
>          .hwfifo_set_watermark =3D inv_icm42600_accel_hwfifo_set_watermar=
k,
>          .hwfifo_flush_to_buffer =3D inv_icm42600_accel_hwfifo_flush,
> +       .attrs =3D &icm42605_attrs_group,
>  };
>=20
>  struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
> @@ -791,3 +856,67 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *in=
dio_dev)
>=20
>          return 0;
>  }
> +
> +int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state *st)
> +{
> +       int ret;
> +       int val;
> +       char sleep =3D 10;
> +
> +       ret =3D regmap_update_bits(st->map, INV_ICM42605_REG_APEX_CONFIG4,
> +                                INV_ICM42605_APEX_CONFIG4_MASK, 0);
> +       if (ret)
> +               return ret;
> +
> +       val =3D INV_ICM42600_PWR_ACCEL_MODE;
> +       ret =3D regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, val);
> +       if (ret)
> +               return ret;
> +
> +       val =3D INV_ICM42605_APEX_CONFIG0;
> +       ret =3D regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, val);
> +       if (ret)
> +               return ret;
> +
> +       val =3D INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET;
> +       ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,=
 val);
> +       if (ret)
> +               return ret;
> +
> +       msleep(sleep);
> +
> +       val =3D INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN;
> +       ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,=
 val);
> +       if (ret)
> +               return ret;
> +
> +       val =3D INV_ICM42605_APEX_CONFIG0_TILT_ENABLE |
> +             INV_ICM42605_APEX_CONFIG0;
> +       ret =3D regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, val);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->map, INV_ICM42605_REG_INTF_CONFIG1,
> +                                INV_ICM42605_INTF_CONFIG1_MASK,
> +                                INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_=
EN);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st)
> +{
> +       int ret;
> +
> +       ret =3D regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->map, INV_ICM42605_REG_INTF_CONFIG1,
> +                       INV_ICM42605_INTF_CONFIG1_MASK, 0);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
>=20
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> --
> 2.25.1
>=20

