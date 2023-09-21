Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698F67A9102
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjIUCoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUCoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:44:08 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2308DDD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1695264238; x=1695523438;
        bh=pUfZmlN/jrzc+iTIgsPamn1gI4JvJXvElpcBUe6gbYA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=iL8lDJtMs2Cmceaq2xfSsaLYclmXhP86+kBajGH70VxhRXJSHzmIZYJ5JMgkJj8A6
         zULFVKNE/GL1P0dOkrkGu57g8k55E5C9Pgh+I+4eYWLwGP/m+u2KGpP2IKQGeq505e
         x0mNYO6X6SW1w2rCB4x5tJUiZ70R2pgmlg9l6J/1CB+Np7jOOBMeKupJAvZ9igDHfi
         KTZUQ+1ba5rXzQeUBan9c57GGl4vAC+/vaQVwrwfm4SG1weV1DNTpmUtenLiItGtU2
         zOBIB1Z8/73oSs3tZRVFVLSMFCFQ6TGA/R8Hq90iMLzy0JAkto8zXkXlXzJ7UosVOl
         rmZZ/DcOIE+yw==
Date:   Thu, 21 Sep 2023 02:43:45 +0000
To:     Johannes Roith <johannes@gnu-linux.rocks>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v6] HID: mcp2200: added driver for GPIOs of MCP2200
Message-ID: <87sf78nt44.fsf@protonmail.com>
In-Reply-To: <20230918151644.568998-1-johannes@gnu-linux.rocks>
References: <20230918151644.568998-1-johannes@gnu-linux.rocks>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Mon, 18 Sep, 2023 17:16:44 +0200 "Johannes Roith" <johannes@gnu-linux.ro=
cks> wrote:
> Added a gpiochip compatible driver to control the 8 GPIOs of
> the MCP2200 by using the HID interface.
>
> Using GPIOs with alternative functions (GP0<->SSPND, GP1<->USBCFG,
> GP6<->RXLED, GP7<->TXLED) will reset the functions, if set (unset by
> default).
>
> The driver was tested while also using the UART of the chip. Setting
> and reading the GPIOs has no effect on the UART communication. However,
> a reset is triggered after the CONFIGURE command. If the GPIO Direction
> is constantly changed, this will affect the communication at low baud
> rates. This is a hardware problem of the MCP2200 and is not caused by
> the driver.
>
> Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>
> ---
>  drivers/hid/Kconfig       |   9 +
>  drivers/hid/Makefile      |   1 +
>  drivers/hid/hid-ids.h     |   1 +
>  drivers/hid/hid-mcp2200.c | 390 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 401 insertions(+)
>  create mode 100644 drivers/hid/hid-mcp2200.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 0cea301cc9a9..3c14644b593d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1298,6 +1298,15 @@ config HID_ALPS
>  =09Say Y here if you have a Alps touchpads over i2c-hid or usbhid
>  =09and want support for its special functionalities.
>
> +config HID_MCP2200
> +=09tristate "Microchip MCP2200 HID USB-to-GPIO bridge"
> +=09depends on USB_HID && GPIOLIB
> +=09help
> +=09  Provides GPIO functionality over USB-HID through MCP2200 device.
> +
> +=09  To compile this driver as a module, choose M here: the module
> +=09  will be called hid-mcp2200.ko.
> +
>  config HID_MCP2221
>  =09tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
>  =09depends on USB_HID && I2C
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 8a06d0f840bc..082a728eac60 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_HID_LOGITECH_HIDPP)=09+=3D hid-logitech-hi=
dpp.o
>  obj-$(CONFIG_HID_MACALLY)=09+=3D hid-macally.o
>  obj-$(CONFIG_HID_MAGICMOUSE)=09+=3D hid-magicmouse.o
>  obj-$(CONFIG_HID_MALTRON)=09+=3D hid-maltron.o
> +obj-$(CONFIG_HID_MCP2200)=09+=3D hid-mcp2200.o
>  obj-$(CONFIG_HID_MCP2221)=09+=3D hid-mcp2221.o
>  obj-$(CONFIG_HID_MAYFLASH)=09+=3D hid-mf.o
>  obj-$(CONFIG_HID_MEGAWORLD_FF)=09+=3D hid-megaworld.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7e499992a793..bb87ad4eb2aa 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -915,6 +915,7 @@
>  #define USB_DEVICE_ID_PICK16F1454=090x0042
>  #define USB_DEVICE_ID_PICK16F1454_V2=090xf2f7
>  #define USB_DEVICE_ID_LUXAFOR=09=090xf372
> +#define USB_DEVICE_ID_MCP2200=09=090x00df
>  #define USB_DEVICE_ID_MCP2221=09=090x00dd
>
>  #define USB_VENDOR_ID_MICROSOFT=09=090x045e
> diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
> new file mode 100644
> index 000000000000..477a3915d2f0
> --- /dev/null
> +++ b/drivers/hid/hid-mcp2200.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MCP2200 - Microchip USB to GPIO bridge
> + *
> + * Copyright (c) 2023, Johannes Roith <johannes@gnu-linux.rocks>
> + *
> + * Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22228A.pd=
f
> + * App Note for HID: https://ww1.microchip.com/downloads/en/DeviceDoc/93=
066A.pdf
> + */
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/hid.h>
> +#include <linux/hidraw.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include "hid-ids.h"
> +
> +/* Commands codes in a raw output report */
> +#define SET_CLEAR_OUTPUTS=090x08
> +#define CONFIGURE=09=090x10
> +#define READ_EE=09=09=090x20
> +#define WRITE_EE=09=090x40
> +#define READ_ALL=09=090x80
> +
> +/* MCP GPIO direction encoding */
> +enum MCP_IO_DIR {
> +=09MCP2200_DIR_OUT =3D 0x00,
> +=09MCP2200_DIR_IN  =3D 0x01,
> +};
> +
> +/* Altternative pin assignments */
> +#define TXLED=09=092
> +#define RXLED=09=093
> +#define USBCFG=09=096
> +#define SSPND=09=097
> +#define MCP_NGPIO=098
> +
> +/* CMD to set or clear a GPIO output */
> +struct mcp_set_clear_outputs {
> +=09u8 cmd;
> +=09u8 dummys1[10];
> +=09u8 set_bmap;
> +=09u8 clear_bmap;
> +=09u8 dummys2[3];
> +} __packed;
> +
> +/* CMD to configure the IOs */
> +struct mcp_configure {
> +=09u8 cmd;
> +=09u8 dummys1[3];
> +=09u8 io_bmap;
> +=09u8 config_alt_pins;
> +=09u8 io_default_val_bmap;
> +=09u8 config_alt_options;
> +=09u8 baud_h;
> +=09u8 baud_l;
> +=09u8 dummys2[6];
> +} __packed;
> +
> +/* CMD to read all parameters */
> +struct mcp_read_all {
> +=09u8 cmd;
> +=09u8 dummys[15];
> +} __packed;
> +
> +/* Response to the read all cmd */
> +struct mcp_read_all_resp {
> +=09u8 cmd;
> +=09u8 eep_addr;
> +=09u8 dummy;
> +=09u8 eep_val;
> +=09u8 io_bmap;
> +=09u8 config_alt_pins;
> +=09u8 io_default_val_bmap;
> +=09u8 config_alt_options;
> +=09u8 baud_h;
> +=09u8 baud_l;
> +=09u8 io_port_val_bmap;
> +=09u8 dummys[5];
> +} __packed;
> +
> +struct mcp2200 {
> +=09struct hid_device *hdev;
> +=09struct mutex lock;
> +=09struct completion wait_in_report;
> +=09u8 gpio_dir;
> +=09u8 gpio_val;
> +=09u8 gpio_inval;
> +=09u8 baud_h;
> +=09u8 baud_l;
> +=09u8 config_alt_pins;
> +=09u8 gpio_reset_val;
> +=09u8 config_alt_options;
> +=09int status;
> +=09struct gpio_chip gc;
> +=09u8 hid_report[16];
> +};
> +
> +/* this executes the READ_ALL cmd */
> +static int mcp_cmd_read_all(struct mcp2200 *mcp)
> +{
> +=09struct mcp_read_all *read_all;
> +=09int len, t;
> +
> +=09reinit_completion(&mcp->wait_in_report);
> +
> +=09mutex_lock(&mcp->lock);
> +
> +=09read_all =3D (struct mcp_read_all *) mcp->hid_report;
> +=09read_all->cmd =3D READ_ALL;
> +=09len =3D hid_hw_output_report(mcp->hdev, (u8 *) read_all,
> +=09=09=09=09   sizeof(struct mcp_read_all));
> +
> +=09mutex_unlock(&mcp->lock);
> +
> +=09if (len !=3D sizeof(struct mcp_read_all))
> +=09=09return -EINVAL;
> +
> +=09t =3D wait_for_completion_timeout(&mcp->wait_in_report,
> +=09=09=09=09=09msecs_to_jiffies(4000));
> +=09if (!t)
> +=09=09return -ETIMEDOUT;
> +
> +=09/* return status, negative value if wrong response was received */
> +=09return mcp->status;
> +}
> +
> +static void mcp_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +=09=09=09     unsigned long *bits)
> +{
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +=09u8 value;
> +=09int status;
> +=09struct mcp_set_clear_outputs *cmd;
> +
> +=09mutex_lock(&mcp->lock);
> +=09cmd =3D (struct mcp_set_clear_outputs *) mcp->hid_report;
> +
> +=09value =3D mcp->gpio_val & ~*mask;
> +=09value |=3D (*mask & *bits);
> +
> +=09cmd->cmd =3D SET_CLEAR_OUTPUTS;
> +=09cmd->set_bmap =3D value;
> +=09cmd->clear_bmap =3D ~(value);
> +
> +=09status =3D hid_hw_output_report(mcp->hdev, (u8 *) cmd,
> +=09=09       sizeof(struct mcp_set_clear_outputs));
> +
> +=09if (status =3D=3D sizeof(struct mcp_set_clear_outputs))
> +=09=09mcp->gpio_val =3D value;
> +
> +=09mutex_unlock(&mcp->lock);
> +}
> +
> +static void mcp_set(struct gpio_chip *gc, unsigned int gpio_nr, int valu=
e)
> +{
> +=09unsigned long mask =3D 1 << gpio_nr;
> +=09unsigned long bmap_value =3D value << gpio_nr;
> +
> +=09mcp_set_multiple(gc, &mask, &bmap_value);
> +}
> +
> +static int mcp_get_multiple(struct gpio_chip *gc, unsigned long *mask,
> +=09=09unsigned long *bits)
> +{
> +=09u32 val;
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +=09int status;
> +
> +=09status =3D mcp_cmd_read_all(mcp);
> +=09if (status)
> +=09=09return status;
> +
> +=09val =3D mcp->gpio_inval;
> +=09*bits =3D (val & *mask);
> +=09return 0;
> +}
> +
> +static int mcp_get(struct gpio_chip *gc, unsigned int gpio_nr)
> +{
> +=09unsigned long mask =3D 0, bits =3D 0;
> +
> +=09mask =3D (1 << gpio_nr);
> +=09mcp_get_multiple(gc, &mask, &bits);
> +=09return bits > 0;
> +}
> +
> +static int mcp_get_direction(struct gpio_chip *gc, unsigned int gpio_nr)
> +{
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +
> +=09return (mcp->gpio_dir & (MCP2200_DIR_IN << gpio_nr))
> +=09=09? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int mcp_set_direction(struct gpio_chip *gc, unsigned int gpio_nr,
> +=09=09=09     enum MCP_IO_DIR io_direction)
> +{
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +=09struct mcp_configure *conf;
> +=09int status;
> +=09/* after the configure cmd we will need to set the outputs again */
> +=09unsigned long mask =3D ~(mcp->gpio_dir); /* only set outputs */
> +=09unsigned long bits =3D mcp->gpio_val;
> +=09/* Offsets of alternative pins in config_alt_pins, 0 is not used */
> +=09u8 alt_pin_conf[8] =3D {SSPND, USBCFG, 0, 0, 0, 0, RXLED, TXLED};
> +=09u8 config_alt_pins =3D mcp->config_alt_pins;
> +
> +=09/* Read in the reset baudrate first, we need it later */
> +=09status =3D mcp_cmd_read_all(mcp);
> +=09if (status !=3D 0)
> +=09=09return status;
> +
> +=09mutex_lock(&mcp->lock);
> +=09conf =3D (struct mcp_configure  *) mcp->hid_report;
> +
> +=09/* configure will reset the chip! */
> +=09conf->cmd =3D CONFIGURE;
> +=09conf->io_bmap =3D (mcp->gpio_dir & ~(1 << gpio_nr))
> +=09=09| (io_direction << gpio_nr);
> +=09/* Don't overwrite the reset parameters */
> +=09conf->baud_h =3D mcp->baud_h;
> +=09conf->baud_l =3D mcp->baud_l;
> +=09conf->config_alt_options =3D mcp->config_alt_options;
> +=09conf->io_default_val_bmap =3D mcp->gpio_reset_val;
> +=09/* Adjust alt. func if necessary */
> +=09if (alt_pin_conf[gpio_nr])
> +=09=09config_alt_pins &=3D ~(1 << alt_pin_conf[gpio_nr]);
> +=09conf->config_alt_pins =3D config_alt_pins;
> +
> +=09status =3D hid_hw_output_report(mcp->hdev, (u8 *) conf,
> +=09=09=09=09      sizeof(struct mcp_set_clear_outputs));
> +
> +=09if (status =3D=3D sizeof(struct mcp_set_clear_outputs)) {
> +=09=09mcp->gpio_dir =3D conf->io_bmap;
> +=09=09mcp->config_alt_pins =3D config_alt_pins;
> +=09} else {
> +=09=09mutex_unlock(&mcp->lock);
> +=09=09return -EIO;
> +=09}
> +
> +=09mutex_unlock(&mcp->lock);
> +
> +=09/* Configure CMD will clear all IOs -> rewrite them */
> +=09mcp_set_multiple(gc, &mask, &bits);
> +=09return 0;
> +}
> +
> +static int mcp_direction_input(struct gpio_chip *gc, unsigned int gpio_n=
r)
> +{
> +=09return mcp_set_direction(gc, gpio_nr, MCP2200_DIR_IN);
> +}
> +
> +static int mcp_direction_output(struct gpio_chip *gc, unsigned int gpio_=
nr,
> +=09=09=09=09int value)
> +{
> +=09int ret;
> +=09unsigned long mask, bmap_value;
> +
> +=09mask =3D 1 << gpio_nr;
> +=09bmap_value =3D value << gpio_nr;
> +
> +=09ret =3D mcp_set_direction(gc, gpio_nr, MCP2200_DIR_OUT);
> +=09if (!ret)
> +=09=09mcp_set_multiple(gc, &mask, &bmap_value);
> +=09return ret;
> +}
> +
> +static const struct gpio_chip template_chip =3D {
> +=09.label=09=09=09=3D "mcp2200",
> +=09.owner=09=09=09=3D THIS_MODULE,
> +=09.get_direction=09=09=3D mcp_get_direction,
> +=09.direction_input=09=3D mcp_direction_input,
> +=09.direction_output=09=3D mcp_direction_output,
> +=09.set=09=09=09=3D mcp_set,
> +=09.set_multiple=09=09=3D mcp_set_multiple,
> +=09.get=09=09=09=3D mcp_get,
> +=09.get_multiple=09=09=3D mcp_get_multiple,
> +=09.base=09=09=09=3D -1,
> +=09.ngpio=09=09=09=3D MCP_NGPIO,
> +=09.can_sleep=09=09=3D true,
> +};
> +
> +/*
> + * MCP2200 uses interrupt endpoint for input reports. This function
> + * is called by HID layer when it receives i/p report from mcp2200,
> + * which is actually a response to the previously sent command.
> + */
> +static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report =
*report,
> +=09=09u8 *data, int size)
> +{
> +=09struct mcp2200 *mcp =3D hid_get_drvdata(hdev);
> +=09struct mcp_read_all_resp *all_resp;
> +
> +=09switch (data[0]) {
> +=09case READ_ALL:
> +=09=09all_resp =3D (struct mcp_read_all_resp *) data;
> +=09=09mcp->status =3D 0;
> +=09=09mcp->gpio_inval =3D all_resp->io_port_val_bmap;
> +=09=09mcp->baud_h =3D all_resp->baud_h;
> +=09=09mcp->baud_l =3D all_resp->baud_l;
> +=09=09mcp->gpio_reset_val =3D all_resp->io_default_val_bmap;
> +=09=09mcp->config_alt_pins =3D all_resp->config_alt_pins;
> +=09=09mcp->config_alt_options =3D all_resp->config_alt_options;
> +=09=09break;
> +=09default:
> +=09=09mcp->status =3D -EIO;
> +=09=09break;
> +=09}
> +
> +=09complete(&mcp->wait_in_report);
> +=09return 0;
> +}
> +
> +static int mcp2200_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
> +=09int ret;
> +=09struct mcp2200 *mcp;
> +
> +=09mcp =3D devm_kzalloc(&hdev->dev, sizeof(*mcp), GFP_KERNEL);
> +=09if (!mcp)
> +=09=09return -ENOMEM;
> +
> +=09ret =3D hid_parse(hdev);
> +=09if (ret) {
> +=09=09hid_err(hdev, "can't parse reports\n");
> +=09=09return ret;
> +=09}
> +
> +=09ret =3D hid_hw_start(hdev, 0);
> +=09if (ret) {
> +=09=09hid_err(hdev, "can't start hardware\n");
> +=09=09return ret;
> +=09}
> +
> +=09hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n", hdev->version =
>> 8,
> +=09=09=09hdev->version & 0xff, hdev->name, hdev->phys);
> +
> +=09ret =3D hid_hw_open(hdev);
> +=09if (ret) {
> +=09=09hid_err(hdev, "can't open device\n");
> +=09=09hid_hw_stop(hdev);
> +=09=09return ret;
> +=09}
> +
> +=09mutex_init(&mcp->lock);
> +=09init_completion(&mcp->wait_in_report);
> +=09hid_set_drvdata(hdev, mcp);
> +=09mcp->hdev =3D hdev;
> +
> +=09mcp->gc =3D template_chip;
> +=09mcp->gc.parent =3D &hdev->dev;
> +
> +=09ret =3D devm_gpiochip_add_data(&hdev->dev, &mcp->gc, mcp);
> +=09if (ret < 0) {

You will want to call mcp2200_remove here in this error path.

> +=09=09hid_err(hdev, "Unable to register gpiochip\n");
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void mcp2200_remove(struct hid_device *hdev)
> +{
> +=09hid_hw_close(hdev);
> +=09hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id mcp2200_devices[] =3D {
> +=09{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_MCP2200) },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(hid, mcp2200_devices);
> +
> +static struct hid_driver mcp2200_driver =3D {
> +=09.name=09=09=3D "mcp2200",
> +=09.id_table=09=3D mcp2200_devices,
> +=09.probe=09=09=3D mcp2200_probe,
> +=09.remove=09=09=3D mcp2200_remove,
> +=09.raw_event=09=3D mcp2200_raw_event,
> +};
> +
> +/* Register with HID core */
> +module_hid_driver(mcp2200_driver);
> +
> +MODULE_AUTHOR("Johannes Roith <johannes@gnu-linux.rocks>");
> +MODULE_DESCRIPTION("MCP2200 Microchip HID USB to GPIO bridge");
> +MODULE_LICENSE("GPL");

This patch looks great. I just have one minor comment with regards to
the refactor now that devm is not being used to handle hid cleanup.

--
Thanks,

Rahul Rameshbabu

