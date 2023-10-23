Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B617D29D2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjJWF4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWF4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:56:13 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E11A4;
        Sun, 22 Oct 2023 22:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698040567; bh=ZHgQD3EHuvEsSv6gBLoiwQtRPAFx9VbaGxJ6R9uNK1M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TPpfXnLrzXfpGeVDsdb9mh51NIEHDq6b5jj4KfrSrnNiLviLPsuKVRgl1fel6Qd5F
         kzMb+bx0OAjXrdq5eNGvvf48W9G0K3HPg1GfXvWepo50KrvUQgDx1rPLrvqPj78FZE
         WHSSMAuXEO9LDAsBeniV8hwecnj/C7srkOPjkXVs=
Date:   Mon, 23 Oct 2023 07:55:52 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Anshul Dalal <anshulusr@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Message-ID: <00d2fcbc-3fd8-477d-8df1-afec20b458b6@t-8ch.de>
In-Reply-To: <ZTWza+S+t+UZKlwu@nixie71>
References: <20231017034356.1436677-1-anshulusr@gmail.com> <20231017034356.1436677-2-anshulusr@gmail.com> <ZTWza+S+t+UZKlwu@nixie71>
Subject: Re: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <00d2fcbc-3fd8-477d-8df1-afec20b458b6@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Oct 23, 2023 01:42:47 Jeff LaBundy <jeff@labundy.com>:

> Hi Anshul,
>
> On Tue, Oct 17, 2023 at 09:13:45AM +0530, Anshul Dalal wrote:
>> Adds a driver for a mini gamepad that communicates over i2c, the gamepad
>> has bidirectional thumb stick input and six buttons.
>>
>> The gamepad chip utilizes the open framework from Adafruit called 'Seesa=
w'
>> to transmit the ADC data for the joystick and digital pin state for the
>> buttons. I have only implemented the functionality required to receive t=
he
>> thumb stick and button state.
>>
>> Steps in reading the gamepad state over i2c:
>> =C2=A0 1. Reset the registers
>> =C2=A0 2. Set the pin mode of the pins specified by the `BUTTON_MASK` to=
 input
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `BUTTON_MASK`: A bit-map for the six digi=
tal pins internally
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connected to the joystick buttons.
>> =C2=A0 3. Enable internal pullup resistors for the `BUTTON_MASK`
>> =C2=A0 4. Bulk set the pin state HIGH for `BUTTON_MASK`
>> =C2=A0 5. Poll the device for button and joystick state done by:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `seesaw_read_data(struct i2c_client *clie=
nt, struct seesaw_data *data)`
>>
>> Product page:
>> =C2=A0 https://www.adafruit.com/product/5743
>> Arduino driver:
>> =C2=A0 https://github.com/adafruit/Adafruit_Seesaw
>>
>> Driver tested on RPi Zero 2W
>>
>> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>> ---
>>
>> Changes for v5:
>> - Added link to the datasheet
>> - Added debug log message when `seesaw_read_data` fails
>>
>> Changes for v4:
>> - Changed `1UL << BUTTON_` to BIT(BUTTON_)
>> - Removed `hardware_id` field from `struct seesaw_gamepad`
>> - Removed redundant checks for the number of bytes written and received =
by
>> =C2=A0 `i2c_master_send` and `i2c_master_recv`
>> - Used `get_unaligned_be32` to instantiate `u32 result` from `read_buf`
>> - Changed=C2=A0 `result & (1UL << BUTTON_)` to
>> =C2=A0 `test_bit(BUTTON_, (long *)&result)`
>> - Changed `KBUILD_MODNAME` in id-tables to `SEESAW_DEVICE_NAME`
>> - Fixed formatting issues
>> - Changed button reporting:
>> =C2=A0=C2=A0=C2=A0 Since the gamepad had the action buttons in a non-sta=
ndard layout:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (X)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Y)=C2=A0=C2=A0 (A)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (B)
>> =C2=A0=C2=A0=C2=A0 Therefore moved to using generic directional action b=
utton event codes
>> =C2=A0=C2=A0=C2=A0 instead of BTN_[ABXY].
>>
>> Changes for v3:
>> - no updates
>>
>> Changes for v2:
>> adafruit-seesaw.c:
>> - Renamed file from 'adafruit_seesaw.c'
>> - Changed device name from 'seesaw_gamepad' to 'seesaw-gamepad'
>> - Changed count parameter for receiving joystick x on line 118:
>> =C2=A0=C2=A0=C2=A0 `2` to `sizeof(write_buf)`
>> - Fixed invalid buffer size on line 123 and 126:
>> =C2=A0=C2=A0=C2=A0 `data->y` to `sizeof(data->y)`
>> - Added comment for the `mdelay(10)` on line 169
>> - Changed inconsistent indentation on line 271
>> Kconfig:
>> - Fixed indentation for the help text
>> - Updated module name
>> Makefile:
>> - Updated module object file name
>> MAINTAINERS:
>> - Updated file name for the driver and bindings
>>
>> MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> drivers/input/joystick/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
>> drivers/input/joystick/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> drivers/input/joystick/adafruit-seesaw.c | 273 +++++++++++++++++++++++
>> 4 files changed, 290 insertions(+)
>> create mode 100644 drivers/input/joystick/adafruit-seesaw.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6c4cce45a09d..a314f9b48e21 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -441,6 +441,13 @@ W: http://wiki.analog.com/AD7879
>> W: https://ez.analog.com/linux-software-drivers
>> F: drivers/input/touchscreen/ad7879.c
>>
>> +ADAFRUIT MINI I2C GAMEPAD
>> +M: Anshul Dalal <anshulusr@gmail.com>
>> +L: linux-input@vger.kernel.org
>> +S: Maintained
>> +F: Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>> +F: drivers/input/joystick/adafruit-seesaw.c
>> +
>> ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
>> M: Jiri Kosina <jikos@kernel.org>
>> S: Maintained
>> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kco=
nfig
>> index ac6925ce8366..df9cd1830b29 100644
>> --- a/drivers/input/joystick/Kconfig
>> +++ b/drivers/input/joystick/Kconfig
>> @@ -412,4 +412,13 @@ config JOYSTICK_SENSEHAT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choos=
e M here: the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be called sensehat_joystick.
>>
>> +config JOYSTICK_SEESAW
>> +=C2=A0=C2=A0 tristate "Adafruit Mini I2C Gamepad with Seesaw"
>> +=C2=A0=C2=A0 depends on I2C
>> +=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0 Say Y here if you want to use the Adafruit Min=
i I2C Gamepad.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choose M h=
ere: the module will be
>> +=C2=A0=C2=A0=C2=A0=C2=A0 called adafruit-seesaw.
>> +
>> endif
>> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Ma=
kefile
>> index 3937535f0098..9976f596a920 100644
>> --- a/drivers/input/joystick/Makefile
>> +++ b/drivers/input/joystick/Makefile
>> @@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +=3D n64joy.o
>> obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)=C2=A0 +=3D psxpad-spi.o
>> obj-$(CONFIG_JOYSTICK_PXRC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D pxrc.o
>> obj-$(CONFIG_JOYSTICK_QWIIC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D qw=
iic-joystick.o
>> +obj-$(CONFIG_JOYSTICK_SEESAW)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D adafru=
it-seesaw.o
>> obj-$(CONFIG_JOYSTICK_SENSEHAT)=C2=A0=C2=A0=C2=A0 +=3D sensehat-joystick=
.o
>> obj-$(CONFIG_JOYSTICK_SIDEWINDER)=C2=A0 +=3D sidewinder.o
>> obj-$(CONFIG_JOYSTICK_SPACEBALL)=C2=A0=C2=A0 +=3D spaceball.o
>> diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/jo=
ystick/adafruit-seesaw.c
>> new file mode 100644
>> index 000000000000..2a1eae8d2861
>> --- /dev/null
>> +++ b/drivers/input/joystick/adafruit-seesaw.c
>> @@ -0,0 +1,273 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
>> + *
>> + * Driver for Adafruit Mini I2C Gamepad
>> + *
>> + * Based on the work of:
>> + * Oleh Kravchenko (Sparkfun Qwiic Joystick driver)
>> + *
>> + * Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.p=
df
>> + * Product page: https://www.adafruit.com/product/5743
>> + * Firmware and hardware sources: https://github.com/adafruit/Adafruit_=
Seesaw
>> + */
>> +
>> +#include <asm-generic/unaligned.h>
>> +#include <linux/bits.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +/* clang-format off */
>
> I don't think we need this directive; at least, no other input drivers ha=
ve
> it, or really any drivers for that matter.
>
>> +#define SEESAW_DEVICE_NAME "seesaw-gamepad"
>> +
>> +#define SEESAW_STATUS_BASE 0
>> +#define SEESAW_GPIO_BASE=C2=A0=C2=A0 1
>> +#define SEESAW_ADC_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9
>> +
>> +#define SEESAW_GPIO_DIRCLR_BULK=C2=A0=C2=A0=C2=A0 3
>> +#define SEESAW_GPIO_BULK=C2=A0=C2=A0 4
>> +#define SEESAW_GPIO_BULK_SET=C2=A0=C2=A0 5
>> +#define SEESAW_GPIO_PULLENSET=C2=A0 11
>> +
>> +#define SEESAW_STATUS_HW_ID=C2=A0=C2=A0=C2=A0 1
>> +#define SEESAW_STATUS_SWRST=C2=A0=C2=A0=C2=A0 127
>> +
>> +#define SEESAW_ADC_OFFSET=C2=A0 7
>> +
>> +#define BUTTON_A=C2=A0=C2=A0 5
>> +#define BUTTON_B=C2=A0=C2=A0 1
>> +#define BUTTON_X=C2=A0=C2=A0 6
>> +#define BUTTON_Y=C2=A0=C2=A0 2
>> +#define BUTTON_START=C2=A0=C2=A0 16
>> +#define BUTTON_SELECT=C2=A0 0
>
> Please namespace these (e.g. SEESAW_BUTTON_A) to make it clear they refer
> to device-specific bits and not standard keycodes (e.g. BTN_A). In fact,
> these seem better off as part of an array of structs; more on that below.
>
>> +
>> +#define ANALOG_X=C2=A0=C2=A0 14
>> +#define ANALOG_Y=C2=A0=C2=A0 15
>
> Please namespace these as well.
>
>> +
>> +#define SEESAW_JOYSTICK_MAX_AXIS=C2=A0=C2=A0 1023
>> +#define SEESAW_JOYSTICK_FUZZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +#define SEESAW_JOYSTICK_FLAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>> +
>> +#define SEESAW_GAMEPAD_POLL_INTERVAL=C2=A0=C2=A0 16
>> +#define SEESAW_GAMEPAD_POLL_MIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 8
>> +#define SEESAW_GAMEPAD_POLL_MAX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 32
>> +/* clang-format on */
>> +
>> +u32 BUTTON_MASK =3D BIT(BUTTON_A) | BIT(BUTTON_B) | BIT(BUTTON_X) |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(BUTTON_Y) | BIT(BU=
TTON_START) | BIT(BUTTON_SELECT);
>> +
>> +struct seesaw_gamepad {
>> +=C2=A0=C2=A0 char physical_path[32];
>> +=C2=A0=C2=A0 struct input_dev *input_dev;
>> +=C2=A0=C2=A0 struct i2c_client *i2c_client;
>> +};
>> +
>> +struct seesaw_data {
>> +=C2=A0=C2=A0 __be16 x;
>> +=C2=A0=C2=A0 __be16 y;
>> +=C2=A0=C2=A0 u8 button_a, button_b, button_x, button_y, button_start, b=
utton_select;
>
> Please keep these each on a separate line.
>
>> +};
>
> Please declare this struct as __packed, as that is how it appears to be u=
sed.
>
>> +
>> +static int seesaw_read_data(struct i2c_client *client, struct seesaw_da=
ta *data)
>> +{
>> +=C2=A0=C2=A0 int err;
>
> Please use 'ret' for return variables that can indicate a positive value =
on success.
>
>> +=C2=A0=C2=A0 unsigned char write_buf[2] =3D { SEESAW_GPIO_BASE, SEESAW_=
GPIO_BULK };
>> +=C2=A0=C2=A0 unsigned char read_buf[4];
>
> Please use standard kernel type definitions (i.e. u8 in this case).
>
>> +
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, write_buf, sizeof(write_bu=
f));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>
> You correctly return err (or rather, ret) for negative values, but you sh=
ould also
> check that ret matches the size of the data sent. For 0 <=3D ret < sizeof=
(writebuf),
> return -EIO.

The driver did this originally.
I then requested it to be removed as this case
can never happen.
i2c_master_send will either return size of(writebuf) or an error.

>> +=C2=A0=C2=A0 err =3D i2c_master_recv(client, read_buf, sizeof(read_buf)=
);
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>
> And here.
>
>> +
>> +=C2=A0=C2=A0 u32 result =3D get_unaligned_be32(&read_buf);
>
> Please do not mix declarations and code; all declarations must be at the
> top of the function.
>
>> +
>> +=C2=A0=C2=A0 data->button_a =3D !test_bit(BUTTON_A, (long *)&result);
>> +=C2=A0=C2=A0 data->button_b =3D !test_bit(BUTTON_B, (long *)&result);
>> +=C2=A0=C2=A0 data->button_x =3D !test_bit(BUTTON_X, (long *)&result);
>> +=C2=A0=C2=A0 data->button_y =3D !test_bit(BUTTON_Y, (long *)&result);
>> +=C2=A0=C2=A0 data->button_start =3D !test_bit(BUTTON_START, (long *)&re=
sult);
>> +=C2=A0=C2=A0 data->button_select =3D !test_bit(BUTTON_SELECT, (long *)&=
result);
>> +
>> +=C2=A0=C2=A0 write_buf[0] =3D SEESAW_ADC_BASE;
>> +=C2=A0=C2=A0 write_buf[1] =3D SEESAW_ADC_OFFSET + ANALOG_X;
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, write_buf, sizeof(write_bu=
f));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 err =3D i2c_master_recv(client, (char *)&data->x, sizeof(d=
ata->x));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>
> This is starting to look like a 16-bit register map. To that end, please
> consider using regmap instead of open-coding each of these standard write=
-
> then-read operations.
>
> Using regmap would also save you the trouble of managing the endianness
> yourself, as well as having to check for incomplete transfers since its
> functions return zero or a negative error code only.
>
>> +=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0 * ADC reads left as max and right as 0, must be reve=
rsed since kernel
>> +=C2=A0=C2=A0=C2=A0 * expects reports in opposite order.
>> +=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0 data->x =3D SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(data->x=
);
>> +
>> +=C2=A0=C2=A0 write_buf[1] =3D SEESAW_ADC_OFFSET + ANALOG_Y;
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, write_buf, sizeof(write_bu=
f));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 err =3D i2c_master_recv(client, (char *)&data->y, sizeof(d=
ata->y));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 data->y =3D be16_to_cpu(data->y);
>> +
>> +=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static void seesaw_poll(struct input_dev *input)
>> +{
>> +=C2=A0=C2=A0 struct seesaw_gamepad *private =3D input_get_drvdata(input=
);
>> +=C2=A0=C2=A0 struct seesaw_data data;
>> +=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0 err =3D seesaw_read_data(private->i2c_client, &data);
>> +=C2=A0=C2=A0 if (err !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(&input->dev, "failed to re=
ad joystick state: %d\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err);
>
> This should be dev_err_ratelimited().
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0 input_report_abs(input, ABS_X, data.x);
>> +=C2=A0=C2=A0 input_report_abs(input, ABS_Y, data.y);
>> +=C2=A0=C2=A0 input_report_key(input, BTN_EAST, data.button_a);
>> +=C2=A0=C2=A0 input_report_key(input, BTN_SOUTH, data.button_b);
>> +=C2=A0=C2=A0 input_report_key(input, BTN_NORTH, data.button_x);
>> +=C2=A0=C2=A0 input_report_key(input, BTN_WEST, data.button_y);
>> +=C2=A0=C2=A0 input_report_key(input, BTN_START, data.button_start);
>> +=C2=A0=C2=A0 input_report_key(input, BTN_SELECT, data.button_select);
>
> I think you can make this much cleaner and smaller by defining an array
> of structs, each with a key code and bit position. You can then simply
> iterate over the array and call input_report_key() once per element as
> in the following:
>
> struct seesaw_btn_desc {
> =C2=A0=C2=A0=C2=A0 unsigned int code;
> =C2=A0=C2=A0=C2=A0 unsigned int shift;
> };
>
> static const struct seesaw_btn_desc seesaw_btns[] =3D {
> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .code =3D BTN_EAST,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask =3D 5,
> =C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0 [...]
> };
>
> And then:
>
> =C2=A0=C2=A0=C2=A0 btn_status =3D ...;
>
> =C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(seesaw_btns); i++)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_report_key(input, seesaw=
_btns[i].code,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 btn_status & seesaw_btns[i].mask);
>
> This would also make it easier to quickly discern what keycodes are mappe=
d
> to which bits in the register.
>
>> +=C2=A0=C2=A0 input_sync(input);
>> +}
>> +
>> +static int seesaw_probe(struct i2c_client *client)
>> +{
>> +=C2=A0=C2=A0 int err;
>> +=C2=A0=C2=A0 struct seesaw_gamepad *private;
>
> I'd rather this be called something like 'seesaw' rather than private.
>
>> +=C2=A0=C2=A0 unsigned char register_reset[] =3D { SEESAW_STATUS_BASE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SEESAW_STATUS_SWR=
ST, 0xFF };
>> +=C2=A0=C2=A0 unsigned char get_hw_id[] =3D { SEESAW_STATUS_BASE, SEESAW=
_STATUS_HW_ID };
>> +
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, register_reset, sizeof(reg=
ister_reset));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +=C2=A0=C2=A0 /* Wait for the registers to reset before proceeding */
>> +=C2=A0=C2=A0 mdelay(10);
>> +
>> +=C2=A0=C2=A0 private =3D devm_kzalloc(&client->dev, sizeof(*private), G=
FP_KERNEL);
>> +=C2=A0=C2=A0 if (!private)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, get_hw_id, sizeof(get_hw_i=
d));
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +=C2=A0=C2=A0 unsigned char hardware_id;
>
> Same comment as earlier with regard to mixed declarations.
>
>> +
>> +=C2=A0=C2=A0 err =3D i2c_master_recv(client, &hardware_id, 1);
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +=C2=A0=C2=A0 dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware I=
D: %02x\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hardware_id);
>> +
>> +=C2=A0=C2=A0 private->i2c_client =3D client;
>> +=C2=A0=C2=A0 scnprintf(private->physical_path, sizeof(private->physical=
_path),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i2c/%s", dev_name(&cl=
ient->dev));
>
> This seems overly complex; can we not simply set input_dev->phys to the
> literal "i2c/seesaw-gamepad"? Why to copy at runtime and incur the cost
> of carrying 'physical_path' throughout the life of the module?
>
>> +=C2=A0=C2=A0 i2c_set_clientdata(client, private);
>> +
>> +=C2=A0=C2=A0 private->input_dev =3D devm_input_allocate_device(&client-=
>dev);
>> +=C2=A0=C2=A0 if (!private->input_dev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0 private->input_dev->id.bustype =3D BUS_I2C;
>> +=C2=A0=C2=A0 private->input_dev->name =3D "Adafruit Seesaw Gamepad";
>> +=C2=A0=C2=A0 private->input_dev->phys =3D private->physical_path;
>> +=C2=A0=C2=A0 input_set_drvdata(private->input_dev, private);
>> +=C2=A0=C2=A0 input_set_abs_params(private->input_dev, ABS_X, 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SEESAW_JOYSTICK_FLAT);
>> +=C2=A0=C2=A0 input_set_abs_params(private->input_dev, ABS_Y, 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SEESAW_JOYSTICK_FLAT);
>> +=C2=A0=C2=A0 input_set_capability(private->input_dev, EV_KEY, BTN_EAST)=
;
>> +=C2=A0=C2=A0 input_set_capability(private->input_dev, EV_KEY, BTN_SOUTH=
);
>> +=C2=A0=C2=A0 input_set_capability(private->input_dev, EV_KEY, BTN_NORTH=
);
>> +=C2=A0=C2=A0 input_set_capability(private->input_dev, EV_KEY, BTN_WEST)=
;
>> +=C2=A0=C2=A0 input_set_capability(private->input_dev, EV_KEY, BTN_START=
);
>> +=C2=A0=C2=A0 input_set_capability(private->input_dev, EV_KEY, BTN_SELEC=
T);
>
> Same comment with regard to creating an array of structs, and hence only
> having to call input_set_capability() from within a small loop.
>
>> +
>> +=C2=A0=C2=A0 err =3D input_setup_polling(private->input_dev, seesaw_pol=
l);
>> +=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&client->dev, "failed to s=
et up polling: %d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0 input_set_poll_interval(private->input_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SEESAW_GAMEPAD_POLL_INTERVAL);
>> +=C2=A0=C2=A0 input_set_max_poll_interval(private->input_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SEESAW_GAMEPAD_POLL_MAX);
>> +=C2=A0=C2=A0 input_set_min_poll_interval(private->input_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SEESAW_GAMEPAD_POLL_MIN);
>> +
>> +=C2=A0=C2=A0 err =3D input_register_device(private->input_dev);
>> +=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&client->dev, "failed to r=
egister joystick: %d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0 /* Set Pin Mode to input and enable pull-up resistors */
>> +=C2=A0=C2=A0 unsigned char pin_mode[] =3D { SEESAW_GPIO_BASE,=C2=A0 SEE=
SAW_GPIO_DIRCLR_BULK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUTTON_MASK >> 24, BUTTON_MAS=
K >> 16,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUTTON_MASK >> 8,=C2=A0 BUTTO=
N_MASK };
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, pin_mode, sizeof(pin_mode)=
);
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 pin_mode[1] =3D SEESAW_GPIO_PULLENSET;
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, pin_mode, sizeof(pin_mode)=
);
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0 pin_mode[1] =3D SEESAW_GPIO_BULK_SET;
>> +=C2=A0=C2=A0 err =3D i2c_master_send(client, pin_mode, sizeof(pin_mode)=
);
>> +=C2=A0=C2=A0 if (err < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>
> Please configure the HW before the input device is live and being polled.
>
>> +
>> +=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_seesaw_match[] =3D {
>> +=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .compatible =3D "adafruit,seesaw-g=
amepad",
>> +=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0 { /* Sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_seesaw_match);
>> +#endif /* CONFIG_OF */
>
> Please correct me if I am wrong, but it does not seem that OF support is
> required by this driver. There are no properties beyond the standard ones
> understood by the I2C core, which can match based on the ID table below.
>
>> +
>> +/* clang-format off */
>> +static const struct i2c_device_id seesaw_id_table[] =3D {
>> +=C2=A0=C2=A0 { SEESAW_DEVICE_NAME, 0 },
>> +=C2=A0=C2=A0 { /* Sentinel */ }
>> +};
>> +/* clang-format on */
>
> Again, I don't see any need for these directives.
>
>> +
>
> Nit: unnecessary NL.
>
>> +MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
>> +
>> +static struct i2c_driver seesaw_driver =3D {
>> +=C2=A0=C2=A0 .driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D SEESAW_DEVICE_NAME,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .of_match_table =3D of_match_ptr(o=
f_seesaw_match),
>> +=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0 .id_table =3D seesaw_id_table,
>> +=C2=A0=C2=A0 .probe =3D seesaw_probe,
>> +};
>> +module_i2c_driver(seesaw_driver);
>> +
>> +MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
>> +MODULE_DESCRIPTION("Adafruit Mini I2C Gamepad driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.42.0
>>
>
> Kind regards,
> Jeff LaBundy

