Return-Path: <linux-kernel+bounces-159604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2988B30E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B0328158C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0513AA5E;
	Fri, 26 Apr 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXrtk8Jo"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66325567F;
	Fri, 26 Apr 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114597; cv=none; b=Ysr0DF7YUR3T6J44PfKhOHZLAqdRWrbJ0E2SjUSgy9MNs0cfsp9ItS9QsmKj9Oa9m8j+t00of4+20jY04+7NOnMPEnCNhGYeLgTUZdpIowDZGb0Lv4kjOUfneoM1Ge7k7LiVOVTGC/LkEF1xsx2E8OW/19+/ud5skDKtPpaDnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114597; c=relaxed/simple;
	bh=kmVkiJtKjgKE3HUGAO6uSs76lQGWVy1VJwufY6kaDVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r50WKvj5N0kTe/VpHwPFjpPRpqernfHrUW7eEX7mg8x3DrrEFUS3vXBZBZg80cVKOAka23/kn5MKQoJlLO/xF/GpeLgbpPxEniTCwZwRODfteN0DS3iR/0PCVMI/KhIv8ax5Ww1SUU9ji8PdI6D/NfqrE0yppJVIKcdWLWxzZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXrtk8Jo; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso27078431fa.1;
        Thu, 25 Apr 2024 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714114593; x=1714719393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsIIEm6c7dt+xQGAgjsctI5v6SxbZdKG3MW9oAOlyP4=;
        b=NXrtk8Job3XOlzvza0Hm1YvFDH3+8nTNIxNJkoXw+yjyeD5KGAoHS0tBObIJtMFb9K
         liP7Np0oSKgIAQ/oN/oxB03erghDYa0VGn57SvPjLXZmBrh13ZLCEpWERFoBlOgdBpQL
         n8bgxvDFseAR8LMP0z2zKvP1O+0gYbo7r/IpOAwmUc860E1ZXnYQ7d5NpaZyMKEQI/mo
         +d+GAfiulfWSLSFp5o0hGIJDDJ6PNBJS8sE9mr2ps3f5jhxS+8/fERhWVSIPGJGu9xe6
         KM7rMZ+PsZgRq1PlGEHc9No8bDnP9cHYrz/HuvF9RtJ48jrJM7dNzuDX/CTpaSdM6rKu
         bXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714114593; x=1714719393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsIIEm6c7dt+xQGAgjsctI5v6SxbZdKG3MW9oAOlyP4=;
        b=fJxpR6FnIQJvAwINQibDFK1cvX3bb6gEbt1jZn2Hu3Rd3XULu/mSJAC2LR1GRS1G5y
         lk7IL3hCSWkcASootvbZIAF5V2A8rytU9tW578AMEnwf09xQ1t8cbAfcrUmAUWrpHH2H
         cBzWmMw/nmBV0PBlv7dbVviaUvfEMDfbGHE5lIfaempUu0AlH4wmjb7ccYK5g+szdlJq
         /LqdxjHMRRPFJk+Rn46XbdkTm5mZX3MwRcPczfnWl2FDpraSCTvJidUZos9mvEMy+Z4s
         65BG/5ZDpa+3r8eReGPdhGfLYnNeLnFFRYP5UeUBxFf+IADF2eUQr/LNvs0XExJKnplP
         rmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1ApnkrHbawUp7DAFco59Pw/gHcl7THZmrdiIpD2B+MfYHbxU/GxK4Nyju0V9ML/ZX8U02AvVFwK/kuJDqE65selG+HJwp/XXWELxaDyQSLvY2WUY49eeizDG0yxQH6otCRy1qZqz6dyzI
X-Gm-Message-State: AOJu0Yz7CDcKk0VMXUjW6qRzzCNN5VHmJz1f4HgAnDBBjZizcPrHqFuQ
	6cy19u+HUX3sVmMc43ZjSp7voez1DjdtotgwGi4eBJTct3lrx0S++KsbSObkrHEHtsf2DWcuUx8
	5P5sCEc3GQSYTSooytMWQWfg6eas=
X-Google-Smtp-Source: AGHT+IEL2jUSMgGbQD0I1W/OS/ToQ8aqf1WqbNHJYAnezYE7uWNT3EIO7Iwe0vPoUoiiO622pft9ypPAV/6xszr+H9I=
X-Received: by 2002:a05:651c:201b:b0:2d8:68ef:9454 with SMTP id
 s27-20020a05651c201b00b002d868ef9454mr1144033ljo.47.1714114593079; Thu, 25
 Apr 2024 23:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425183251.174412-1-rilian.la.te@ya.ru> <20240425183251.174412-4-rilian.la.te@ya.ru>
 <20240425171924.839ec71e2b34dee959444091@hugovil.com>
In-Reply-To: <20240425171924.839ec71e2b34dee959444091@hugovil.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 26 Apr 2024 09:58:55 +0300
Message-ID: <CAF1WSuz-AyBi18JP5vwror8HNtOqEsRcARCtYgFN8d1eNEO8ng@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Herve Codina <herve.codina@bootlin.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Anup Patel <apatel@ventanamicro.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:19=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> On Thu, 25 Apr 2024 21:32:35 +0300
> Konstantin Pugin <rilian.la.te@ya.ru> wrote:
>
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > XR20M1172 register set is mostly compatible with SC16IS762, but it
> > supports for additional division rates with special DLD register.
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> > ---
> >  drivers/tty/serial/Kconfig         |  3 +-
> >  drivers/tty/serial/sc16is7xx.c     | 61 ++++++++++++++++++++++++++++--
> >  drivers/tty/serial/sc16is7xx.h     |  1 +
> >  drivers/tty/serial/sc16is7xx_i2c.c |  1 +
> >  drivers/tty/serial/sc16is7xx_spi.c |  1 +
> >  5 files changed, 62 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 4fdd7857ef4d..9d0438cfe147 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1029,7 +1029,7 @@ config SERIAL_SC16IS7XX_CORE
> >       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> >       select SERIAL_SC16IS7XX_I2C if I2C
> >       help
> > -       Core driver for NXP SC16IS7xx UARTs.
> > +       Core driver for NXP SC16IS7xx and compatible UARTs.
> >         Supported ICs are:
> >
> >           SC16IS740
> > @@ -1038,6 +1038,7 @@ config SERIAL_SC16IS7XX_CORE
> >           SC16IS752
> >           SC16IS760
> >           SC16IS762
> > +         XR20M1172 (Exar)
> >
> >         The driver supports both I2C and SPI interfaces.
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index dfcc804f558f..2b40600243a9 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -10,6 +10,7 @@
> >  #undef DEFAULT_SYMBOL_NAMESPACE
> >  #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -68,6 +69,7 @@
> >  /* Special Register set: Only if ((LCR[7] =3D=3D 1) && (LCR !=3D 0xBF)=
) */
> >  #define SC16IS7XX_DLL_REG            (0x00) /* Divisor Latch Low */
> >  #define SC16IS7XX_DLH_REG            (0x01) /* Divisor Latch High */
> > +#define XR20M117X_DLD_REG            (0x02) /* Divisor Fractional (req=
uires EFR[4] =3D 1) */
> >
> >  /* Enhanced Register set: Only if (LCR =3D=3D 0xBF) */
> >  #define SC16IS7XX_EFR_REG            (0x02) /* Enhanced Features */
> > @@ -221,6 +223,20 @@
> >  #define SC16IS7XX_TCR_RX_HALT(words) ((((words) / 4) & 0x0f) << 0)
> >  #define SC16IS7XX_TCR_RX_RESUME(words)       ((((words) / 4) & 0x0f) <=
< 4)
> >
> > +/*
> > + * Divisor Fractional Register bits (EXAR extension).
> > + * EXAR hardware is mostly compatible with SC16IS7XX, but supports add=
itional feature:
> > + * 4x and 8x divisor, instead of default 16x. It has a special registe=
r to program it.
> > + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 =
bits of
> > + * uartclk * (16 / divisor) / baud, in case of default it will be uart=
clk / baud.
> > + * Bits 4 and 5 used as switches, and should not be set to 1 simultane=
ously.
> > + */
> > +
> > +#define XR20M117X_DLD_16X                    0
> > +#define XR20M117X_DLD_DIV_MASK                       GENMASK(3, 0)
> > +#define XR20M117X_DLD_8X                     BIT(4)
> > +#define XR20M117X_DLD_4X                     BIT(5)
> > +
> >  /*
> >   * TLR register bits
> >   * If TLR[3:0] or TLR[7:4] are logical 0, the selectable trigger level=
s via the
> > @@ -523,6 +539,13 @@ const struct sc16is7xx_devtype sc16is762_devtype =
=3D {
> >  };
> >  EXPORT_SYMBOL_GPL(sc16is762_devtype);
> >
> > +const struct sc16is7xx_devtype xr20m1172_devtype =3D {
> > +     .name           =3D "XR20M1172",
> > +     .nr_gpio        =3D 8,
> > +     .nr_uart        =3D 2,
> > +};
> > +EXPORT_SYMBOL_GPL(xr20m1172_devtype);
> > +
> >  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int=
 reg)
> >  {
> >       switch (reg) {
> > @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device =
*dev, unsigned int reg)
> >       return reg =3D=3D SC16IS7XX_RHR_REG;
> >  }
> >
> > +static bool sc16is7xx_has_dld(struct device *dev)
> > +{
> > +     struct sc16is7xx_port *s =3D dev_get_drvdata(dev);
> > +
> > +     if (s->devtype =3D=3D &xr20m1172_devtype)
> > +             return true;
> > +     return false;
> > +}
> > +
> >  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> >  {
> >       struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > -     u8 lcr;
> > +     unsigned long clk =3D port->uartclk, div, div16;
> > +     bool has_dld =3D sc16is7xx_has_dld(port->dev);
> > +     u8 dld_mode =3D XR20M117X_DLD_16X;
> >       u8 prescaler =3D 0;
> > -     unsigned long clk =3D port->uartclk, div =3D clk / 16 / baud;
> > +     u8 divisor =3D 16;
> > +     u8 lcr;
> > +
> > +     if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
> > +             divisor =3D rounddown_pow_of_two(DIV_ROUND_CLOSEST(clk, b=
aud));
> > +
> > +     div16 =3D (clk * 16) / divisor / baud;
> > +     div =3D div16 / 16;
> >
> >       if (div >=3D BIT(16)) {
> >               prescaler =3D SC16IS7XX_MCR_CLKSEL_BIT;
> >               div /=3D 4;
> >       }
> >
> > +     /* Count additional divisor for EXAR devices */
> > +     if (divisor =3D=3D 8)
> > +             dld_mode =3D XR20M117X_DLD_8X;
> > +     if (divisor =3D=3D 4)
> > +             dld_mode =3D XR20M117X_DLD_4X;
> > +     dld_mode |=3D FIELD_PREP(XR20M117X_DLD_DIV_MASK, div16);
> > +
> >       /* Enable enhanced features */
> >       sc16is7xx_efr_lock(port);
> >       sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> > @@ -587,12 +635,14 @@ static int sc16is7xx_set_baud(struct uart_port *p=
ort, int baud)
> >       regcache_cache_bypass(one->regmap, true);
> >       sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
> >       sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
> > +     if (has_dld)
> > +             sc16is7xx_port_write(port, XR20M117X_DLD_REG, dld_mode);
> >       regcache_cache_bypass(one->regmap, false);
> >
> >       /* Restore LCR and access to general register set */
> >       sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
> >
> > -     return DIV_ROUND_CLOSEST(clk / 16, div);
> > +     return DIV_ROUND_CLOSEST(clk / divisor, div);
>
> While trying to review your code, it made me realize there is a bug
> with the current return value. I will send a patch to fix it, and you
> will be able to rebase your patchset on it after that.

It is good. What bug are you observed?

> Hugo.
>
>
> >  }
> >
> >  static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int r=
xlen,
> > @@ -1002,6 +1052,8 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >                                 const struct ktermios *old)
> >  {
> >       struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > +     bool has_dld =3D sc16is7xx_has_dld(port->dev);
> > +     u8 divisor =3D has_dld ? 4 : 16;
> >       unsigned int lcr, flow =3D 0;
> >       int baud;
> >       unsigned long flags;
> > @@ -1084,7 +1136,7 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >       /* Get baud rate generator configuration */
> >       baud =3D uart_get_baud_rate(port, termios, old,
> >                                 port->uartclk / 16 / 4 / 0xffff,
> > -                               port->uartclk / 16);
> > +                               port->uartclk / divisor);
> >
> >       /* Setup baudrate generator */
> >       baud =3D sc16is7xx_set_baud(port, baud);
> > @@ -1684,6 +1736,7 @@ void sc16is7xx_remove(struct device *dev)
> >  EXPORT_SYMBOL_GPL(sc16is7xx_remove);
> >
> >  const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] =3D {
> > +     { .compatible =3D "exar,xr20m1172",       .data =3D &xr20m1172_de=
vtype, },
> >       { .compatible =3D "nxp,sc16is740",        .data =3D &sc16is74x_de=
vtype, },
> >       { .compatible =3D "nxp,sc16is741",        .data =3D &sc16is74x_de=
vtype, },
> >       { .compatible =3D "nxp,sc16is750",        .data =3D &sc16is750_de=
vtype, },
> > diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is=
7xx.h
> > index afb784eaee45..eb2e3bc86f15 100644
> > --- a/drivers/tty/serial/sc16is7xx.h
> > +++ b/drivers/tty/serial/sc16is7xx.h
> > @@ -28,6 +28,7 @@ extern const struct sc16is7xx_devtype sc16is750_devty=
pe;
> >  extern const struct sc16is7xx_devtype sc16is752_devtype;
> >  extern const struct sc16is7xx_devtype sc16is760_devtype;
> >  extern const struct sc16is7xx_devtype sc16is762_devtype;
> > +extern const struct sc16is7xx_devtype xr20m1172_devtype;
> >
> >  const char *sc16is7xx_regmap_name(u8 port_id);
> >
> > diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc=
16is7xx_i2c.c
> > index 3ed47c306d85..839de902821b 100644
> > --- a/drivers/tty/serial/sc16is7xx_i2c.c
> > +++ b/drivers/tty/serial/sc16is7xx_i2c.c
> > @@ -46,6 +46,7 @@ static const struct i2c_device_id sc16is7xx_i2c_id_ta=
ble[] =3D {
> >       { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
> >       { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },
> >       { "sc16is762",  (kernel_ulong_t)&sc16is762_devtype, },
> > +     { "xr20m1172",  (kernel_ulong_t)&xr20m1172_devtype, },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
> > diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc=
16is7xx_spi.c
> > index 73df36f8a7fd..2b278282dbd0 100644
> > --- a/drivers/tty/serial/sc16is7xx_spi.c
> > +++ b/drivers/tty/serial/sc16is7xx_spi.c
> > @@ -69,6 +69,7 @@ static const struct spi_device_id sc16is7xx_spi_id_ta=
ble[] =3D {
> >       { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
> >       { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },
> >       { "sc16is762",  (kernel_ulong_t)&sc16is762_devtype, },
> > +     { "xr20m1172",  (kernel_ulong_t)&xr20m1172_devtype, },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
> > --
> > 2.44.0
> >
> >
> >
>
>
> --
> Hugo Villeneuve

