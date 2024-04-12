Return-Path: <linux-kernel+bounces-142795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22618A302D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59240283978
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02F85C59;
	Fri, 12 Apr 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjTPLif3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DB84DF6;
	Fri, 12 Apr 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930966; cv=none; b=kZX7x007jKgioNwxgtErPvaDhDhEXh0IHdtgs/VkdewnharF6M+pDNG7G2962nxFdeeNCQtUtDn785KCVA3vH9WWk/yLi0jdO59PseJxWFps0damHnuWCgttHInfw5vuhsfLUv5kXJoAwoR8vD2SpHSL6G4HNC6+/T9ZZNEroIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930966; c=relaxed/simple;
	bh=LNDniFsjs1ZYh5GEE0d+0cT2PkMGkVIsvDyiUbczwKI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uxclIivBhmipMPAobLQ11186M7p3FX0mw6jjjygBcTCdPMH6Pkw3XzgGuv1tRL7yN5Q4QDxGrtI2kOUVcb4ZCszgn9E4T4gvR93z7jkU+AO89ql8IURm5qbp8Y2tsELMvBhpyHx9HsQwmabLxRsA+ZNL9/J/CCgL5c4HwrvKxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjTPLif3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712930965; x=1744466965;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LNDniFsjs1ZYh5GEE0d+0cT2PkMGkVIsvDyiUbczwKI=;
  b=YjTPLif39trZ+fArdduOHXLlwY3+7T8EUQJHW3qvAvDnOSyfSoYrpuZI
   P6onz5dASMimAy6z+mMye5YuWCYf+zK2P6vD9CvosHFVJjOVwxRLPKSS5
   s8oa/5XIC+1vPfy5jJcEbc9EqYNrgqnTfVATo4t9bsCaNAlyVf2pdYrD0
   sA3MmE5YXpPz7NsjCcylE1COYo6Jye0naGtZZmevR6yhf5qL3Sjzw9sxq
   BPaU0e84IAIpRGZPI+Fw2o9FjKmxJFN/CaAnS1I8zZULgkHv75HEW7pw5
   VzQIPp3g0SBf7PUaOWyBaTYeEeANSZKiMzvb5VmIoM9rQpoShvZYYneY9
   Q==;
X-CSE-ConnectionGUID: h1N1caA+TaOf0ms6qfBXCA==
X-CSE-MsgGUID: NgVQWdWuTj6XXCsuyVES2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="25901158"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25901158"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:09:24 -0700
X-CSE-ConnectionGUID: NKAvbdP4Q7uzHb5/ERSz3g==
X-CSE-MsgGUID: enpviaGBRd+uVo6TTBHlhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="52397634"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:09:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 17:09:16 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 5/7] serial: exar: add some CTI helper functions
In-Reply-To: <20240412095719.3dd3ffa5@SWDEV2.connecttech.local>
Message-ID: <f2efb5b0-54e6-6e70-2778-657400267463@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <f610d699b6d0495c76e732fb93afd2216aacbb85.1712863999.git.pnewman@connecttech.com> <6bb475fd-0d71-1600-d76b-3dad5187c6fe@linux.intel.com> <20240412095719.3dd3ffa5@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-981758125-1712930956=:1014"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-981758125-1712930956=:1014
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 12 Apr 2024, Parker Newman wrote:

> On Fri, 12 Apr 2024 13:48:56 +0300 (EEST)
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Thu, 11 Apr 2024, parker@finest.io wrote:
> >=20
> > > From: Parker Newman <pnewman@connecttech.com>
> > >=20
> > > - Adds various helper functions for CTI boards.
> > > - Add osc_freq and pcidev to struct exar8250
> > > - Added a exar_get_nr_ports function
> > >=20
> > > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_exar.c | 363 ++++++++++++++++++++++++++=
+-
> > >  1 file changed, 357 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial=
/8250/8250_exar.c
> > > index b30f3855652a..6f3697e34722 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -137,6 +137,9 @@
> > >  #define UART_EXAR_REGB_EE_ADDR_SIZE     6
> > >  #define UART_EXAR_REGB_EE_DATA_SIZE     16
> > >=20
> > > +#define UART_EXAR_XR17C15X_PORT_OFFSET  0x200
> > > +#define UART_EXAR_XR17V25X_PORT_OFFSET  0x200
> > > +#define UART_EXAR_XR17V35X_PORT_OFFSET  0x400
> > >=20
> > >  /*
> > >   * IOT2040 MPIO wiring semantics:
> > > @@ -173,6 +176,46 @@
> > >  #define IOT2040_UARTS_ENABLE=09=090x03
> > >  #define IOT2040_UARTS_GPIO_HI_MODE=090xF8=09/* enable & LED as outpu=
ts */
> > >=20
> > > +/* CTI EEPROM offsets */
> > > +#define CTI_EE_OFF_XR17C15X_OSC_FREQ=090x04  /* 2 words (4 bytes) */
> > > +#define CTI_EE_OFF_XR17V25X_OSC_FREQ    0x08  /* 2 words (4 bytes) *=
/
> > > +#define CTI_EE_OFF_XR17C15X_PART_NUM    0x0A  /* 4 words (8 bytes) *=
/
> > > +#define CTI_EE_OFF_XR17V25X_PART_NUM    0x0E  /* 4 words (8 bytes) *=
/
> > > +#define CTI_EE_OFF_XR17C15X_SERIAL_NUM  0x0E  /* 1 word  (2 bytes) *=
/
> > > +#define CTI_EE_OFF_XR17V25X_SERIAL_NUM  0x12  /* 1 word  (2 bytes) *=
/
> > > +#define CTI_EE_OFF_XR17V35X_SERIAL_NUM  0x11  /* 2 word  (4 bytes) *=
/
> > > +#define CTI_EE_OFF_XR17V35X_BOARD_FLAGS 0x13  /* 1 word  (2 bytes) *=
/ =20
> >=20
> > I'm not convinced but words and bytes is really needed.
> >=20
> > > +#define CTI_EE_OFF_XR17V35X_PORT_FLAGS=090x14  /* 1 word (per port) =
*/ =20
> >=20
> > There's something wrong with alignment of more than one define above.
> >=20
> > > +
> > > +#define CTI_FPGA_RS485_IO_REG=09=090x2008
> > > +
> > > +#define CTI_DEFAULT_PCI_OSC_FREQ=0929491200
> > > +#define CTI_DEFAULT_PCIE_OSC_FREQ=09125000000
> > > +#define CTI_DEFAULT_FPGA_OSC_FREQ=0933333333
> > > +
> > > +/*
> > > + * CTI Serial port line types. These match the values stored in the =
first
> > > + * nibble of the CTI EEPROM port_flags word.
> > > + */
> > > +enum cti_port_type {
> > > +=09CTI_PORT_TYPE_NONE =3D 0,
> > > +=09CTI_PORT_TYPE_RS232,            //RS232 ONLY
> > > +=09CTI_PORT_TYPE_RS422_485,        //RS422/RS485 ONLY
> > > +=09CTI_PORT_TYPE_RS232_422_485_HW, //RS232/422/485 HW ONLY Switchabl=
e
> > > +=09CTI_PORT_TYPE_RS232_422_485_SW, //RS232/422/485 SW ONLY Switchabl=
e
> > > +=09CTI_PORT_TYPE_RS232_422_485_4B, //RS232/422/485 HW/SW (4bit ex. B=
CG004)
> > > +=09CTI_PORT_TYPE_RS232_422_485_2B, //RS232/422/485 HW/SW (2bit ex. B=
BG008)
> > > +=09CTI_PORT_TYPE_MAX,
> > > +};
> > > +
> > > +#define CTI_PORT_TYPE_VALID(_port_type) \
> > > +=09(((_port_type) > CTI_PORT_TYPE_NONE) && \
> > > +=09((_port_type) < CTI_PORT_TYPE_MAX))
> > > +
> > > +#define CTI_PORT_TYPE_RS485(_port_type) \
> > > +=09(((_port_type) > CTI_PORT_TYPE_RS232) && \
> > > +=09((_port_type) < CTI_PORT_TYPE_MAX))
> > > +
> > >  struct exar8250;
> > >=20
> > >  struct exar8250_platform {
> > > @@ -202,6 +245,8 @@ struct exar8250_board {
> > >=20
> > >  struct exar8250 {
> > >  =09unsigned int=09=09nr;
> > > +=09unsigned int            osc_freq;
> > > +=09struct pci_dev=09=09*pcidev;
> > >  =09struct exar8250_board=09*board;
> > >  =09void __iomem=09=09*virt;
> > >  =09int=09=09=09line[];
> > > @@ -557,6 +602,279 @@ pci_fastcom335_setup(struct exar8250 *priv, str=
uct pci_dev *pcidev,
> > >  =09return 0;
> > >  }
> > >=20
> > > +/**
> > > + * cti_set_tristate() - Enable/Disable RS485 transciever tristate
> > > + * @priv: Device's private structure
> > > + * @port_num: Port number to set tristate on/off
> > > + * @enable: Enable tristate if true, disable if false
> > > + *
> > > + * Most RS485 capable cards have a power on tristate jumper/switch t=
hat ensures
> > > + * the RS422/RS485 transciever does not drive a multi-drop RS485 bus=
 when it is
> > > + * not the master. When this jumper is installed the user must set t=
he RS485
> > > + * mode to disable tristate prior to using the port.
> > > + *
> > > + * Some Exar UARTs have an auto-tristate feature while others requir=
e setting
> > > + * an MPIO to disable the tristate.
> > > + *
> > > + * Return: 0 on success, negative error code on failure
> > > + */
> > > +static int cti_set_tristate(struct exar8250 *priv,
> > > +=09=09=09unsigned int port_num, bool enable)
> > > +{
> > > +=09int ret =3D 0;
> > > +
> > > +=09if (!priv || (port_num >=3D priv->nr))
> > > +=09=09return -EINVAL;
> > > +
> > > +=09//Only Exar based cards use MPIO, return 0 otherwise
> > > +=09if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > > +=09=09return 0;
> > > +
> > > +=09pci_dbg(priv->pcidev, "%s tristate for port %u\n",
> > > +=09=09(enable ? "enabling" : "disabling"), port_num); =20
> >=20
> > dev_dbg()
> >=20
> > Rephrasing the string slightly, you could consider using=20
> > str_enable_disable() from linux/string_choices.h
> >=20
> > > +
> > > +=09ret =3D exar_mpio_set(priv, port_num, !enable);
> > > +=09if (ret)
> > > +=09=09return ret;
> > > +
> > > +=09//ensure MPIO is an output
> > > +=09ret =3D exar_mpio_config(priv, port_num, true);
> > > +
> > > +=09return ret;
> > > +}
> > > +
> > > +/**
> > > + * cti_set_plx_int_enable() - Enable/Disable PCI interrupts
> > > + * @priv: Device's private structure
> > > + * @enable: Enable interrupts if true, disable if false
> > > + *
> > > + * Some older CTI cards require MPIO_0 to be set low to enable the P=
CI
> > > + * interupts from the UART to the PLX PCI->PCIe bridge.
> > > + *
> > > + * Return: 0 on success, negative error code on failure
> > > + */
> > > +static int cti_set_plx_int_enable(struct exar8250 *priv, bool enable=
)
> > > +{
> > > +=09int ret =3D 0;
> > > +
> > > +=09if (!priv)
> > > +=09=09return -EINVAL;
> > > +
> > > +=09//Only Exar based cards use MPIO, return 0 otherwise
> > > +=09if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > > +=09=09return 0;
> > > +
> > > +=09pci_dbg(priv->pcidev, "%s plx fix\n",
> > > +=09=09(enable ? "enabling" : "disabling"));
> > > +
> > > +=09//INT enabled when MPIO0 is LOW
> > > +=09ret =3D exar_mpio_set(priv, 0, !enable);
> > > +=09if (ret)
> > > +=09=09return ret;
> > > +
> > > +=09//ensure MPIO is an output
> > > +=09ret =3D exar_mpio_config(priv, 0, true);
> > > +
> > > +=09return ret;
> > > +}
> > > +
> > > +/**
> > > + * cti_read_osc_freq() - Read the UART oscillator frequency from EEP=
ROM
> > > + * @priv: Device's private structure =20
> >=20
> > Missing second parameter.
> >=20
> > > + *
> > > + * CTI XR17x15X and XR17V25X cards have the serial boards oscillator=
 frequency
> > > + * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/P=
CIe clock.
> > > + *
> > > + * Return: frequency on success, negative error code on failure
> > > + */
> > > +static int cti_read_osc_freq(struct exar8250 *priv, uint8_t eeprom_o=
ffset)
> > > +{
> > > +=09int osc_freq;
> > > +
> > > +=09if (!priv)
> > > +=09=09return -EINVAL;
> > > +
> > > +=09osc_freq =3D (exar_ee_read(priv, eeprom_offset)); =20
> >=20
> > Unnecessary parenthesis.
> >=20
> > > +=09osc_freq |=3D (exar_ee_read(priv, (eeprom_offset + 1)) << 16); =
=20
> >=20
> > Add the field #define with GENMASK() and use FIELD_PREP() here? Perhaps=
=20
> > both lines should use FIELD_PREP() even if one of them has 0 shift.
> >=20
> > > +
> > > +=09//check if EEPROM word was blank
> > > +=09if ((osc_freq =3D=3D 0xFFFF) || (osc_freq =3D=3D 0x0000))
> > > +=09=09return -EIO;
> > > +
> > > +=09pci_dbg(priv->pcidev, "osc_freq from EEPROM %d\n", osc_freq);
> > > +
> > > +=09return osc_freq;
> > > +}
> > > +
> > > +/**
> > > + * cti_get_port_type_xr17c15x_xr17v25x() - Get the port type of a xr=
17c15x
> > > + * or xr17v25x card =20
> >=20
> > I suppose this shorter version would be enough to provide the same amou=
nt =20
> > information:
> >=20
> > Get the port type of xr17c15x/xr17v25x
> >=20
> > > + * =20
> >=20
> > No empty line.
> >=20
> > > + * @priv: Device's private structure
> > > + * @port_num: Port to get type of
> > > + *
> > > + * CTI xr17c15x and xr17v25x based cards port types are based on PCI=
 IDs
> > > + *
> > > + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> > > + */
> > > +static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct=
 exar8250 *priv,
> > > +=09=09=09=09=09=09=09unsigned int port_num)
> > > +{
> > > +=09enum cti_port_type port_type;
> > > +
> > > +=09if (!priv)
> > > +=09=09return CTI_PORT_TYPE_NONE; =20
> >=20
> > Can this happen?
> >=20
> > > +=09switch (priv->pcidev->subsystem_device) {
> > > +=09//RS232 only cards
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
> > > +=09=09port_type =3D CTI_PORT_TYPE_RS232;
> > > +=09=09break;
> > > +=09//1x RS232, 1x RS422/RS485
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> > > +=09=09port_type =3D (port_num =3D=3D 0) ?
> > > +=09=09=09CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > > +=09=09break;
> > > +=09//2x RS232, 2x RS422/RS485
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
> > > +=09=09port_type =3D (port_num < 2) ?
> > > +=09=09=09CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > > +=09=09break;
> > > +=09//4x RS232, 4x RS422/RS485
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> > > +=09=09port_type =3D (port_num < 4) ?
> > > +=09=09=09CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > > +=09=09break;
> > > +=09//RS232/RS422/RS485 HW (jumper) selectable
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> > > +=09=09port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
> > > +=09=09break;
> > > +=09//RS422/RS485 HW (jumper) selectable
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> > > +=09=09port_type =3D CTI_PORT_TYPE_RS422_485;
> > > +=09=09break;
> > > +=09//6x RS232, 2x RS422/RS485
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> > > +=09=09port_type =3D (port_num < 6) ?
> > > +=09=09=09CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > > +=09=09break;
> > > +=09//2x RS232, 6x RS422/RS485
> > > +=09case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> > > +=09=09port_type =3D (port_num < 2) ?
> > > +=09=09=09CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > > +=09=09break;
> > > +=09default:
> > > +=09=09pci_err(priv->pcidev, "unknown/unsupported device\n");
> > > +=09=09port_type =3D CTI_PORT_TYPE_NONE;
> > > +=09}
> > > +
> > > +=09return port_type;
> > > +}
> > > +
> > > +/**
> > > + * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
> > > + * @priv: Device's private structure
> > > + * @port_num: Port to get type of
> > > + *
> > > + * FPGA based cards port types are based on PCI IDs
> > > + *
> > > + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> > > + */
> > > +static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *pr=
iv,
> > > +=09=09=09=09=09=09unsigned int port_num)
> > > +{
> > > +=09enum cti_port_type port_type;
> > > +
> > > +=09if (!priv)
> > > +=09=09return CTI_PORT_TYPE_NONE;
> > > +
> > > +=09switch (priv->pcidev->device) {
> > > +=09case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> > > +=09case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> > > +=09case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> > > +=09=09port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
> > > +=09=09break;
> > > +=09default:
> > > +=09=09pci_err(priv->pcidev, "unknown/unsupported device\n"); =20
> >=20
> > dev_err()
> >=20
> > > +=09=09return CTI_PORT_TYPE_NONE;
> > > +=09}
> > > +
> > > +=09return port_type;
> > > +}
> > > +
> > > +/**
> > > + * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
> > > + * @priv: Device's private structure
> > > + * @port_num: port offset
> > > + *
> > > + * CTI XR17V35X based cards have the port types stored in the EEPROM=
=2E
> > > + * This function reads the port type for a single port.
> > > + *
> > > + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> > > + */
> > > +static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250=
 *priv,
> > > +=09=09=09=09=09=09unsigned int port_num)
> > > +{
> > > +=09uint16_t port_flags;
> > > +=09uint8_t offset;
> > > +=09enum cti_port_type port_type;
> > > +
> > > +=09if (!priv)
> > > +=09=09return CTI_PORT_TYPE_NONE;
> > > +
> > > +=09offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
> > > +=09port_flags =3D exar_ee_read(priv, offset);
> > > +
> > > +=09port_type =3D (port_flags & 0x00FF); =20
> >=20
> > Add named define with GENMASK() and use FIELD_GET()
> >=20
> > > +
> > > +=09if (!CTI_PORT_TYPE_VALID(port_type)) {
> > > +=09=09/*
> > > +=09=09 * If the port type is missing the card assume it is a
> > > +=09=09 * RS232/RS422/RS485 card to be safe.
> > > +=09=09 *
> > > +=09=09 * There is one known board (BEG013) that only has
> > > +=09=09 * 3 of 4 port types written to the EEPROM so this
> > > +=09=09 * acts as a work around.
> > > +=09=09 */
> > > +=09=09pci_warn(priv->pcidev, =20
> >=20
> > dev_warn(). Please fix all pci_xx() logging, I won't flag them from thi=
s=20
> > point onwards.
> >=20
> > > +=09=09=09"failed to get port %d type from EEPROM\n", port_num);
> > > +=09=09port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
> > > +=09}
> > > +
> > > +=09return port_type;
> > > +}
> > > +
> > >  static int
> > >  pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev=
,
> > >  =09=09       struct uart_8250_port *port, int idx)
> > > @@ -914,6 +1232,39 @@ static irqreturn_t exar_misc_handler(int irq, v=
oid *data)
> > >  =09return IRQ_HANDLED;
> > >  }
> > >=20
> > > +static unsigned int exar_get_nr_ports(struct exar8250_board *board,
> > > +=09=09=09=09=09struct pci_dev *pcidev)
> > > +{
> > > +=09unsigned int nr_ports =3D 0;
> > > +
> > > +=09if (!board || !pcidev)
> > > +=09=09return 0;
> > > +
> > > +=09if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO) {
> > > +=09=09nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
> > > +=09} else if (board->num_ports > 0) {
> > > +=09=09//Check if board struct overrides number of ports
> > > +=09=09nr_ports =3D board->num_ports;
> > > +=09} else if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
> > > +=09=09//Exar encodes # ports in last nibble of PCI Device ID ex. 035=
8
> > > +=09=09nr_ports =3D pcidev->device & 0x0f;
> > > +=09} else  if (pcidev->vendor =3D=3D PCI_VENDOR_ID_CONNECT_TECH) {
> > > +=09=09//Handle CTI FPGA cards
> > > +=09=09switch (pcidev->device) {
> > > +=09=09case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> > > +=09=09case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> > > +=09=09=09nr_ports =3D 12;
> > > +=09=09=09break;
> > > +=09=09case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> > > +=09=09=09nr_ports =3D 16;
> > > +=09=09default:
> > > +=09=09=09break;
> > > +=09=09}
> > > +=09}
> > > +
> > > +=09return nr_ports;
> > > +}
> > > +
> > >  static int
> > >  exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *e=
nt)
> > >  {
> > > @@ -933,18 +1284,18 @@ exar_pci_probe(struct pci_dev *pcidev, const s=
truct pci_device_id *ent)
> > >=20
> > >  =09maxnr =3D pci_resource_len(pcidev, bar) >> (board->reg_shift + 3)=
;
> > >=20
> > > -=09if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
> > > -=09=09nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
> > > -=09else if (board->num_ports)
> > > -=09=09nr_ports =3D board->num_ports;
> > > -=09else
> > > -=09=09nr_ports =3D pcidev->device & 0x0f;
> > > +=09nr_ports =3D exar_get_nr_ports(board, pcidev);
> > > +=09if (nr_ports =3D=3D 0) { =20
> >=20
> > Can you please do this refactoring in a preparatory patch, and only add=
=20
> > the new stuff in this patch into exar_get_nr_ports() patch.
> >=20
>=20
> I will fix above.=20
>=20
> Just to clarify By "do this refactoring in a preparatory patch" do you me=
an:=20
> 1. Move existing code to new function in "preparatory patch"
> 2. Add new code to new function in another patch

Yes.

In general, when a patch gets large, moving such trivial changes out=20
of it will help review tremendously (and also if somebody has to look into=
=20
the commit history 5-15 years from now).

--=20
 i.

--8323328-981758125-1712930956=:1014--

