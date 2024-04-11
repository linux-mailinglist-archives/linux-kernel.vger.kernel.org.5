Return-Path: <linux-kernel+bounces-141576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045618A2033
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE72928DB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45F33E47A;
	Thu, 11 Apr 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="dTfP+P6H"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664524A03;
	Thu, 11 Apr 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867168; cv=none; b=LiRUISjsZF6vJ1uxpFz1P3zDnzXHJbJ7Jo/dGN2TIr4AR0aOtkNrUAzXL9n6Z/FTGocIVBRr0K0jj7vtYUnmvcwwG3xcag+cazPyC2muZMyhQU1aJJQ4peZRPgZ/wS79Z07rJXuXGTsqUVEpB6EJVMR2W4KovHXLK5QK4Ql1C9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867168; c=relaxed/simple;
	bh=D2glbP7cm0TmfFFPGqKUcqu4qF4AR8nZgHoZ7dH9Yj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwOfhWcPYuOn/2cVs5ZNhCSyOM+iXu7mQfj3RYKfh4AR+OBxJHLjGa85I4PpYX3Qj8SSAEEYjQDujPJ6BxlfsdG8qdxd8iPsQEoxKixWpovpffLZEMP1RC0nTj9nQ/fAAO7zOibzborNvQqTRHISJhXf85HkCJK4LOcgpXN795Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=dTfP+P6H; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867158; x=1713471958; i=parker@finest.io;
	bh=zGQMmuknO7H4DJSGj8qu3qo3rQdck9vuC74qN0BKFcU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dTfP+P6HSU78bTJCP4BFePeVHMdDRJ1EoXqBt67U/dtZfOvn00zdtw7Boiv5sjyf
	 UGbrOg8Y+g2J4B2RHLZvtFHfyX++ctDOtPq2+q86lFq2YVBj9+lNFff35Z/YzRn4r
	 3w/BP7Tu4IZ9jKCRXim1VGXU1a7gqEkUvIZQDBkKF6dvRaJTcKd5IeWhdRo17MZFn
	 oeFZeeIuzHr52QHa0IuMW3MbNESXBwsIpSbipNidjOcvQYdXaKIMe9F8tVj7VInO7
	 seq1TNtpfMZGv5DRcctoixHBYX58XsrfwjCldBQlZ4NBi40DAWO4v7NbOWD7OJmT+
	 o8q9olcBrAp0b0md7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M4oTz-1sgfzn22iz-016Swv; Thu, 11 Apr
 2024 22:25:58 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 5/7] serial: exar: add some CTI helper functions
Date: Thu, 11 Apr 2024 16:25:43 -0400
Message-ID: <f610d699b6d0495c76e732fb93afd2216aacbb85.1712863999.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712863999.git.pnewman@connecttech.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G8KyqjAnDXTvX433vE0YOEvvWG9V3POi5snH3U7eXwdL4rS5k58
 AGHssuToSCSdvBkU5/Iat6i7Oue8+KDS5iQpxvT07rcr/Xtznt9V0O+AJmXymVWZtdkseeI
 d4ghQppfCam/ylkZ1yHuCNonDvmFfJo+XfI+y0X3sIV3KlCoOJsrdCgMsE266zz4m5LCgEF
 eJtvY4G2MBgyv9H2ZH2hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yQRd95HKEdQ=;uBBGFxvJX/vFGu7XBrBjxDdVOCM
 +96aFLBOKeh8YFeow/t2iebzML158DYHQpjbDZ4YdZaevM9JzZBj483XexIpx7duTQXGUrigC
 M/azsSDhP2zIOr36cSY0C4Gefwxd/CaJUxaeSVOhCj0JAmVGrAQFnsPYkygcHEhfzAZmucFJY
 jFUt8JNIO7TefplGuTS2a67kcXSu2eC3O47VpxxvFj9AQWG4WQ2//M9FU7RVJ2HcjjuOYgM8l
 ft/qeYdukE7Gu48LUS3dwT55OfZuEcBYvY14efzq4aewjRLzDQqIxkY0TitKSAYSGKNjt6eGI
 80KGfOSoz6RtFmT0oTW8VNsaLPMDiHbAmwcvqZRafTvAd5Ecp7y5ohWYAKXS+safEkzYqRm8H
 naHowAa548CT1ApNm0Mz9sYCzdKz0Qk+pIM1IM0SPwrDVRY4AyNGd8+9ZgXAkKhoe2SheY+s5
 WAtRW5XZGJmi889ZwGdoKeEdSccKtoLWn3mRWc9rlBjYJGNXgoihv8lBJoaTn4rI/LT5NbXsn
 vA2UfiZ4K1Y5bxsnrZZod1Xncw1adZTAwCumSVGW6N4FzRtxpFAJfnW07BOcfh8ILHy1RM0Qq
 zs0ZidIBf1uUx/f3Ic0MO523jVVRuWT3M8YJT3p5V9umVNbF4PnlgfVDCNZ5tiQMPYvMU45Yb
 ye88QcBoYq4P4ldP3YZubIPrOg91jHA63vSWZeQUYn4SUE5C1XLaFh9Ka51goLZtCIYoh60gr
 U39MPXQhTVmVojIKuiTqjEr9UOeUIztsh6lmSdztGRrNDHCMWbXoR4=

From: Parker Newman <pnewman@connecttech.com>

- Adds various helper functions for CTI boards.
- Add osc_freq and pcidev to struct exar8250
- Added a exar_get_nr_ports function

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 363 +++++++++++++++++++++++++++-
 1 file changed, 357 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index b30f3855652a..6f3697e34722 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -137,6 +137,9 @@
 #define UART_EXAR_REGB_EE_ADDR_SIZE     6
 #define UART_EXAR_REGB_EE_DATA_SIZE     16

+#define UART_EXAR_XR17C15X_PORT_OFFSET  0x200
+#define UART_EXAR_XR17V25X_PORT_OFFSET  0x200
+#define UART_EXAR_XR17V35X_PORT_OFFSET  0x400

 /*
  * IOT2040 MPIO wiring semantics:
@@ -173,6 +176,46 @@
 #define IOT2040_UARTS_ENABLE		0x03
 #define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */

+/* CTI EEPROM offsets */
+#define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words (4 bytes) */
+#define CTI_EE_OFF_XR17V25X_OSC_FREQ    0x08  /* 2 words (4 bytes) */
+#define CTI_EE_OFF_XR17C15X_PART_NUM    0x0A  /* 4 words (8 bytes) */
+#define CTI_EE_OFF_XR17V25X_PART_NUM    0x0E  /* 4 words (8 bytes) */
+#define CTI_EE_OFF_XR17C15X_SERIAL_NUM  0x0E  /* 1 word  (2 bytes) */
+#define CTI_EE_OFF_XR17V25X_SERIAL_NUM  0x12  /* 1 word  (2 bytes) */
+#define CTI_EE_OFF_XR17V35X_SERIAL_NUM  0x11  /* 2 word  (4 bytes) */
+#define CTI_EE_OFF_XR17V35X_BOARD_FLAGS 0x13  /* 1 word  (2 bytes) */
+#define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word (per port) */
+
+#define CTI_FPGA_RS485_IO_REG		0x2008
+
+#define CTI_DEFAULT_PCI_OSC_FREQ	29491200
+#define CTI_DEFAULT_PCIE_OSC_FREQ	125000000
+#define CTI_DEFAULT_FPGA_OSC_FREQ	33333333
+
+/*
+ * CTI Serial port line types. These match the values stored in the first
+ * nibble of the CTI EEPROM port_flags word.
+ */
+enum cti_port_type {
+	CTI_PORT_TYPE_NONE =3D 0,
+	CTI_PORT_TYPE_RS232,            //RS232 ONLY
+	CTI_PORT_TYPE_RS422_485,        //RS422/RS485 ONLY
+	CTI_PORT_TYPE_RS232_422_485_HW, //RS232/422/485 HW ONLY Switchable
+	CTI_PORT_TYPE_RS232_422_485_SW, //RS232/422/485 SW ONLY Switchable
+	CTI_PORT_TYPE_RS232_422_485_4B, //RS232/422/485 HW/SW (4bit ex. BCG004)
+	CTI_PORT_TYPE_RS232_422_485_2B, //RS232/422/485 HW/SW (2bit ex. BBG008)
+	CTI_PORT_TYPE_MAX,
+};
+
+#define CTI_PORT_TYPE_VALID(_port_type) \
+	(((_port_type) > CTI_PORT_TYPE_NONE) && \
+	((_port_type) < CTI_PORT_TYPE_MAX))
+
+#define CTI_PORT_TYPE_RS485(_port_type) \
+	(((_port_type) > CTI_PORT_TYPE_RS232) && \
+	((_port_type) < CTI_PORT_TYPE_MAX))
+
 struct exar8250;

 struct exar8250_platform {
@@ -202,6 +245,8 @@ struct exar8250_board {

 struct exar8250 {
 	unsigned int		nr;
+	unsigned int            osc_freq;
+	struct pci_dev		*pcidev;
 	struct exar8250_board	*board;
 	void __iomem		*virt;
 	int			line[];
@@ -557,6 +602,279 @@ pci_fastcom335_setup(struct exar8250 *priv, struct p=
ci_dev *pcidev,
 	return 0;
 }

+/**
+ * cti_set_tristate() - Enable/Disable RS485 transciever tristate
+ * @priv: Device's private structure
+ * @port_num: Port number to set tristate on/off
+ * @enable: Enable tristate if true, disable if false
+ *
+ * Most RS485 capable cards have a power on tristate jumper/switch that e=
nsures
+ * the RS422/RS485 transciever does not drive a multi-drop RS485 bus when=
 it is
+ * not the master. When this jumper is installed the user must set the RS=
485
+ * mode to disable tristate prior to using the port.
+ *
+ * Some Exar UARTs have an auto-tristate feature while others require set=
ting
+ * an MPIO to disable the tristate.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int cti_set_tristate(struct exar8250 *priv,
+			unsigned int port_num, bool enable)
+{
+	int ret =3D 0;
+
+	if (!priv || (port_num >=3D priv->nr))
+		return -EINVAL;
+
+	//Only Exar based cards use MPIO, return 0 otherwise
+	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	pci_dbg(priv->pcidev, "%s tristate for port %u\n",
+		(enable ? "enabling" : "disabling"), port_num);
+
+	ret =3D exar_mpio_set(priv, port_num, !enable);
+	if (ret)
+		return ret;
+
+	//ensure MPIO is an output
+	ret =3D exar_mpio_config(priv, port_num, true);
+
+	return ret;
+}
+
+/**
+ * cti_set_plx_int_enable() - Enable/Disable PCI interrupts
+ * @priv: Device's private structure
+ * @enable: Enable interrupts if true, disable if false
+ *
+ * Some older CTI cards require MPIO_0 to be set low to enable the PCI
+ * interupts from the UART to the PLX PCI->PCIe bridge.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int cti_set_plx_int_enable(struct exar8250 *priv, bool enable)
+{
+	int ret =3D 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	//Only Exar based cards use MPIO, return 0 otherwise
+	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	pci_dbg(priv->pcidev, "%s plx fix\n",
+		(enable ? "enabling" : "disabling"));
+
+	//INT enabled when MPIO0 is LOW
+	ret =3D exar_mpio_set(priv, 0, !enable);
+	if (ret)
+		return ret;
+
+	//ensure MPIO is an output
+	ret =3D exar_mpio_config(priv, 0, true);
+
+	return ret;
+}
+
+/**
+ * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
+ * @priv: Device's private structure
+ *
+ * CTI XR17x15X and XR17V25X cards have the serial boards oscillator freq=
uency
+ * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe c=
lock.
+ *
+ * Return: frequency on success, negative error code on failure
+ */
+static int cti_read_osc_freq(struct exar8250 *priv, uint8_t eeprom_offset=
)
+{
+	int osc_freq;
+
+	if (!priv)
+		return -EINVAL;
+
+	osc_freq =3D (exar_ee_read(priv, eeprom_offset));
+	osc_freq |=3D (exar_ee_read(priv, (eeprom_offset + 1)) << 16);
+
+	//check if EEPROM word was blank
+	if ((osc_freq =3D=3D 0xFFFF) || (osc_freq =3D=3D 0x0000))
+		return -EIO;
+
+	pci_dbg(priv->pcidev, "osc_freq from EEPROM %d\n", osc_freq);
+
+	return osc_freq;
+}
+
+/**
+ * cti_get_port_type_xr17c15x_xr17v25x() - Get the port type of a xr17c15=
x
+ * or xr17v25x card
+ *
+ * @priv: Device's private structure
+ * @port_num: Port to get type of
+ *
+ * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar=
8250 *priv,
+							unsigned int port_num)
+{
+	enum cti_port_type port_type;
+
+	if (!priv)
+		return CTI_PORT_TYPE_NONE;
+
+	switch (priv->pcidev->subsystem_device) {
+	//RS232 only cards
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
+		port_type =3D CTI_PORT_TYPE_RS232;
+		break;
+	//1x RS232, 1x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
+		port_type =3D (port_num =3D=3D 0) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//2x RS232, 2x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
+		port_type =3D (port_num < 2) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//4x RS232, 4x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		port_type =3D (port_num < 4) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//RS232/RS422/RS485 HW (jumper) selectable
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+		break;
+	//RS422/RS485 HW (jumper) selectable
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+		port_type =3D CTI_PORT_TYPE_RS422_485;
+		break;
+	//6x RS232, 2x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		port_type =3D (port_num < 6) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//2x RS232, 6x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		port_type =3D (port_num < 2) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	default:
+		pci_err(priv->pcidev, "unknown/unsupported device\n");
+		port_type =3D CTI_PORT_TYPE_NONE;
+	}
+
+	return port_type;
+}
+
+/**
+ * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
+ * @priv: Device's private structure
+ * @port_num: Port to get type of
+ *
+ * FPGA based cards port types are based on PCI IDs
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
+						unsigned int port_num)
+{
+	enum cti_port_type port_type;
+
+	if (!priv)
+		return CTI_PORT_TYPE_NONE;
+
+	switch (priv->pcidev->device) {
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+		break;
+	default:
+		pci_err(priv->pcidev, "unknown/unsupported device\n");
+		return CTI_PORT_TYPE_NONE;
+	}
+
+	return port_type;
+}
+
+/**
+ * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
+ * @priv: Device's private structure
+ * @port_num: port offset
+ *
+ * CTI XR17V35X based cards have the port types stored in the EEPROM.
+ * This function reads the port type for a single port.
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *pri=
v,
+						unsigned int port_num)
+{
+	uint16_t port_flags;
+	uint8_t offset;
+	enum cti_port_type port_type;
+
+	if (!priv)
+		return CTI_PORT_TYPE_NONE;
+
+	offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
+	port_flags =3D exar_ee_read(priv, offset);
+
+	port_type =3D (port_flags & 0x00FF);
+
+	if (!CTI_PORT_TYPE_VALID(port_type)) {
+		/*
+		 * If the port type is missing the card assume it is a
+		 * RS232/RS422/RS485 card to be safe.
+		 *
+		 * There is one known board (BEG013) that only has
+		 * 3 of 4 port types written to the EEPROM so this
+		 * acts as a work around.
+		 */
+		pci_warn(priv->pcidev,
+			"failed to get port %d type from EEPROM\n", port_num);
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+	}
+
+	return port_type;
+}
+
 static int
 pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		       struct uart_8250_port *port, int idx)
@@ -914,6 +1232,39 @@ static irqreturn_t exar_misc_handler(int irq, void *=
data)
 	return IRQ_HANDLED;
 }

+static unsigned int exar_get_nr_ports(struct exar8250_board *board,
+					struct pci_dev *pcidev)
+{
+	unsigned int nr_ports =3D 0;
+
+	if (!board || !pcidev)
+		return 0;
+
+	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO) {
+		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
+	} else if (board->num_ports > 0) {
+		//Check if board struct overrides number of ports
+		nr_ports =3D board->num_ports;
+	} else if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
+		//Exar encodes # ports in last nibble of PCI Device ID ex. 0358
+		nr_ports =3D pcidev->device & 0x0f;
+	} else  if (pcidev->vendor =3D=3D PCI_VENDOR_ID_CONNECT_TECH) {
+		//Handle CTI FPGA cards
+		switch (pcidev->device) {
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+			nr_ports =3D 12;
+			break;
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+			nr_ports =3D 16;
+		default:
+			break;
+		}
+	}
+
+	return nr_ports;
+}
+
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -933,18 +1284,18 @@ exar_pci_probe(struct pci_dev *pcidev, const struct=
 pci_device_id *ent)

 	maxnr =3D pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);

-	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
-		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
-	else if (board->num_ports)
-		nr_ports =3D board->num_ports;
-	else
-		nr_ports =3D pcidev->device & 0x0f;
+	nr_ports =3D exar_get_nr_ports(board, pcidev);
+	if (nr_ports =3D=3D 0) {
+		pci_err(pcidev, "failed to get number of ports\n");
+		return -ENODEV;
+	}

 	priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), G=
FP_KERNEL);
 	if (!priv)
 		return -ENOMEM;

 	priv->board =3D board;
+	priv->pcidev =3D pcidev;
 	priv->virt =3D pcim_iomap(pcidev, bar, 0);
 	if (!priv->virt)
 		return -ENOMEM;
=2D-
2.43.2


