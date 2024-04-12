Return-Path: <linux-kernel+bounces-142673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A58A2EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BD9284334
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E95A0FE;
	Fri, 12 Apr 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="USwubd8x"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AB59154;
	Fri, 12 Apr 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926720; cv=none; b=qf4I4ZypYJJT13/D7ILUfE2aeoCC5Y325+z9g7o+P4HJjNekOr+ShwDmDw96c0nhOzDRXPxNV0zLuKWIU2p9/na5spYbJpPznDK0zuod1pRhFLcNiQaDrS6mat6WWdy00RVgo2i6sRGn/jqKIDnoaSrKTWphLnp1kd77jUxiMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926720; c=relaxed/simple;
	bh=DYumRxwpyTIHbuXghhBvDgCxHwdJLGz/jFTaXNdaz48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/b+jO8hI7pMLGwpA2daF8BYgu+EK+5YBDc0IAyS/IzgwCHI2K+nq9yL9RgTTvCheOvO+hFA7koNN1jv1b6CZpixK7gFIm+ztILhIcrfz5L3mZQADv034iuqB2LsrMHUIn8hxHJCmqcY281roRayq63sdP1aEm5nx9b9GT0PnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=USwubd8x; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712926712; x=1713531512; i=parker@finest.io;
	bh=lVdC8pcchcL7vtNWyPl4aWWOAmUFpAxqksbY/+7Aluc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=USwubd8xk6TH1aA2ivIQH65mtazlRLNaZBK1pNBTyEqxsQ/ciY/PeW47ZKQPpPtl
	 7/MwGmf6wgApmY+tomwH0nVpoKt1uVIMn0ZreO7VzPbfe8zg6bMgc8m7C1QTQsf3o
	 KJOJbX/qEtru45Tj9uB3prrIy+YEKUEWd8yuXChLWgbHlp8KTkd4VSB6b1bFMODPY
	 flsR8DSjiBwp1EsLuizflccdU/+sYiw1DHUXWxljTorgF9m18r0Zj3Kq9StSf1LBO
	 5TsPzl/dlETjoorEq/b099MmR+DeafUomNf3NUpo+2PIHyrKF16ycKLXbaQKhZLB4
	 QdMBmhd7rVaWGrHOuA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MGhVm-1s0C9i00Pa-00DsG6; Fri, 12 Apr 2024 14:58:32 +0200
Date: Fri, 12 Apr 2024 08:58:30 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 2/7] serial: exar: add support for reading from Exar
 EEPROM
Message-ID: <20240412085830.54935b1b@SWDEV2.connecttech.local>
In-Reply-To: <2024041247-clamor-bottom-ae36@gregkh>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>
	<2024041247-clamor-bottom-ae36@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EBx8kFH4IwIAbyerGiPz4vhJLRp1AQKC5/bRtcf61tYVRYShGfb
 D1ugCymdRivUfo/LCHIGXGlLJ6XxyFtbP/pOPqi1S/1J39WC7CZB6pPZYka64NHecXNX8mz
 OsRWFvzU9B/eTzRqP+F2uA1IqYqcHCQbJM1Cnesj7c79EXAcpsu0LM6kap+MX1yD2jK7D+a
 shb0nExiETAaqQoW41/hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1PjHRcd3OtE=;9U5Afp4m+Fn+eIwhgszcOUPhjRK
 f0EWuKcShEJSQjMHGjXydB0iIDRWDuMxZqr/GLbPg0cCyucn/rDxKqJPXj/cfYOtsP6aZNljq
 VqXwbUU4O92h1NR/lj/vTpvS8199GHPGBJG9GcTOl07Av7drZMPpxjmFDPpdRRvG+P2iSreCc
 3HafG4q4ByYKZx2qZuEcqxVF8NaHxEMhAW2tfc2E3P/30z1QXvGMiciU9e2M6H7czvWCinXHN
 QugUL/UJfCL4hmxN2KRrbXmAGhKvT/OKTDT6SuJQiWLQllzMXuuC1KNLf6zU6N4c89IKfPYmg
 aqIXXqadm3qaJJF1fbhRVA4Yx/OPQfLgkxWP3VANa8q5vel0iXdACgYsdR9cjtkIIe0zRr73x
 XN0N/Wi6Pk7IrdpK+rMh8uXmHc37j3vHOQFX28fGDuumUad3GeEERSwpmG5ZZSiNdPaskEtLo
 jNLrPFWk9FTIy7jC5Sf7rnlCKcvlXJ/nr6akDOCOjblxpNESHhaGr69a/Zo/ijSt4pGnSXaYh
 U3Ndps75+7rT22yi4HwrXLHqDNlGLc+bcpIGXct2E294ZjrGE9DcKIODY/AcTTDm+GXvEvjgZ
 nKeuuljqM7BoXnHxexgPB+Ck9bQ4Gv7VDNr6TpDtxFqrEbH+GObRq8Og0gJQ1Sr4Br/YkcwWp
 fA72J52x1lgkY990fjQ8fIIkf8wzhmZ1Zf21scYCdrtxJymX8WN5XLAkD066buJbq/9prRba1
 NsAzg2m7JmNA3PybnMwfaks209FEygPL2T0roF/2R0/grsIpRvJVPI=

On Fri, 12 Apr 2024 07:26:49 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 11, 2024 at 04:25:40PM -0400, parker@finest.io wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > - Adds support for reading a word from the Exar EEPROM.
> > - Adds exar_write_reg/exar_read_reg for reading and writing to the UAR=
T's
> > config registers.
>
> First off, thanks for splitting this up, looks much better.
>
> Some minor nits here:
>
> >
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 110 +++++++++++++++++++++++++++=
+
> >  1 file changed, 110 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/=
8250/8250_exar.c
> > index 4d1e07343d0b..49d690344e65 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -128,6 +128,16 @@
> >  #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
> >  #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polar=
ity */
> >
> > +/* EEPROM registers */
> > +#define UART_EXAR_REGB                  0x8e
> > +#define UART_EXAR_REGB_EECK             BIT(4)
> > +#define UART_EXAR_REGB_EECS             BIT(5)
> > +#define UART_EXAR_REGB_EEDI             BIT(6)
> > +#define UART_EXAR_REGB_EEDO             BIT(7)
> > +#define UART_EXAR_REGB_EE_ADDR_SIZE     6
> > +#define UART_EXAR_REGB_EE_DATA_SIZE     16
>
> Use tabs after the define name and before the value?

There should be tabs there... I will re-tab them in v3 to make sure.

>
> > +
> > +
> >  /*
> >   * IOT2040 MPIO wiring semantics:
> >   *
> > @@ -195,6 +205,106 @@ struct exar8250 {
> >  	int			line[];
> >  };
> >
> > +static inline void exar_write_reg(struct exar8250 *priv,
> > +				unsigned int reg, uint8_t value)
> > +{
> > +	if (!priv || !priv->virt)
> > +		return;
> > +
> > +	writeb(value, priv->virt + reg);
> > +}
> > +
> > +static inline uint8_t exar_read_reg(struct exar8250 *priv, unsigned i=
nt reg)
> > +{
> > +	if (!priv || !priv->virt)
> > +		return 0;
>
> How can either of these ever happen?  You control when this is called,
> right?  So just make sure that isn't an issue.

I think I was a bit over paranoid here. I was considering there are other
3rd party cards supported in this driver that use uart_port->private_data
differently or don't set it. I agree they aren't really needed in the end.

> > +
> > +	return readb(priv->virt + reg);
> > +}
> > +
> > +static inline void exar_ee_select(struct exar8250 *priv, bool enable)
> > +{
> > +	uint8_t value =3D 0x00;
>
> This is the kernel, please use kernel types, not userspace types (i.e.
> u8 not uint8_t).  Yes, there are lots of places in the kernel that have
> userspace types, but let's not add to the mess please.

Yes there is some confusion on which should be used.
Thanks for the clarification. I will convert in v3.

>
> > +
> > +	if (enable)
> > +		value |=3D UART_EXAR_REGB_EECS;
> > +
> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
>
> Why wait this amount of time?  A comment would be nice.  Why not just
> do a read to ensure the write happened instead?

The Exar UART uses a bit-bang I2C interface for the EEPROM so a delay is
needed for the I2C bit time (2us =3D 500khz). This is legacy code so I wil=
l
double check this is actually needed and add comments if it is.

> > +}
> > +
> > +static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
> > +{
> > +	uint8_t value =3D UART_EXAR_REGB_EECS;
>
> Same comment about the type, here and everywhere else.
>
> > +
> > +	if (bit)
> > +		value |=3D UART_EXAR_REGB_EEDI;
> > +
> > +	//Clock out the bit on the i2c interface
>
> Comments using // are fine, but please put a space after the "//" to
> make them readable

I will fix.

> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
>
> Same commment about the time value, here and everywhere else.  Why slow
> things down if you don't have to?
>
> thanks,
>
> greg k-h

Thanks for the feedback!
- Parker

