Return-Path: <linux-kernel+bounces-141575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6A8A2034
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC9EB25100
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0A3E47E;
	Thu, 11 Apr 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="bULBQNhe"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E421105;
	Thu, 11 Apr 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867168; cv=none; b=Tq8dcIN8PK8QH9Mu3j7PlvUnwSeQdC+Zjw1YRW8gNFpk6nZrXX37zfcPDfoZdQj7n/j3WNua75nKbEJ+HvISb4kYL+e/ZY7VPCQj0lvFAnRYT+48DJ+nWvzf2uVDvqtPJrlWVvKF7qZDl8tidDbzwmV++D7S6ggl2B/QUgoSy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867168; c=relaxed/simple;
	bh=vMRkyS/nU3uMmQ0YX45/F5RdIM2oxYF6Fbc7JHqcG3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkNgnJ9AsXzEsFOgUIJhilrSQNISdjJ6TUmk+OGduKiqoSuKSjqDZDZrtT5bQNpxinUW3ypf7dm4IOd3Ai53fTgx9+dlnAGhDX1Q2KOCiLr0Wl0Kj+iH1P3wzIZRPhbQ/r48QZv00PnPq+NVCdib7AfN41uFzjpIlGdMtu4/wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=bULBQNhe; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867159; x=1713471959; i=parker@finest.io;
	bh=pKbKQ5Mt2Wd95+QbmtpBW0rcpjwWKIHjnsw/dZ/hMZA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=bULBQNhe7FVJZGFDFn7vyr1FyNjRtpCHkce7CcBpFrhLBj3DEiQ2hVWcSiwQqbxj
	 AcKL9w5ozFH1r0+cCUvqVc/crH+NVGw7ViVis0x+lb3K9LcVhX4MO99Jq9tFy71Gd
	 cSQnaCovIwdkWvnW636F5iJB+YqBIcQe9Z7yVfQYO0Z8KtLI65VDihrEc6pXBtUV7
	 2flTSRkvl4fcAyTqUhGJYUa2ut057LtavXl51Y3hRFdAM7K3IYpZGz+PSlCnxBYvN
	 LyYd6qKTe7IB5tHAI5aMY9KnvUAIRc9D0qwnQge3HuTXmUGmNQi7xp/2OqTtzyDc5
	 gdlfoXtB6fIXNWrjMQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MfWg9-1s6nDJ3NP9-00YmI7; Thu, 11 Apr
 2024 22:25:58 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 6/7] serial: exar: add CTI board and port setup functions
Date: Thu, 11 Apr 2024 16:25:44 -0400
Message-ID: <ca94454e54504c1621f17f5e3933cad299f61344.1712863999.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:PuX4ZS5iXPbMFe9bDBhe2tElBc3yuus6SpjeF8+ywaH4HTsBdLK
 fPR+0DVLwsRtF26zRFpi44Fpu76SSLizqJacWBL9/LsFsFoGTk447jHwUmJ4uQ3xClEX3RW
 2S9t4aOTF3Ooe94zEDFzwNkf/yDDRNqe9EakHz/T9D2o4q9J0a/jBWUMzq7OiTCvOpa4a6T
 31K9IruQP1n1IVO0Hd6Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P1iin8ZiPWo=;BkVVieI7Dmbrb0IV/vWwDTCzDHJ
 gCD9HMMnReIti58n1UaB0nRPXczFzu5VY7wm6WULGOylhZkxj8Ev9NWVT0I+ePuwoouURIGIJ
 d3D/UHkYLX6DpN5fxZfY2dYss4cz2+yWJNomel9U2nztHktTYLsuKqAW2jiNneMabyWS0eCcC
 MJizDvqfstVer949HQt8+f8jvRuoXkFpIUV/OAmu82JSMZnpd8CZBlXCqid57rtn3qpWF9rok
 fPRwYCdwGyO9QOJrzBu1G8ukB3zLYpaQJ2/qVS6unS9UjoEyu8soih+WX4C28UA9DS0y2x97z
 T8IXoO75xK2gBSCQMax5d+ZjUx/WU13dqIbQiSDQrFhatE6hCxrAYtvRAcS5e2+Nu3YgTy68E
 X+KYPSN2ZVJxg3CBNyzLH4WYqOlAN8YlekfG/zJiyibjITsoqFIalH1UEgDAU3+IueuDmesFQ
 5Gp2YiZlF9wlYFpUtyh0LGMXo8L9ODdqiPcOEFSEJRm76mG/qfI/z8zx4wWM08QQGY2I2CxU5
 xtFq1T9znqCVHOLoZiIvW7xphX4MAT+C3x6NHfpKtT6RvrWqS3NBA12ZaVw3UEPkFJN+9Plig
 gZsxvJKhjItHkaT8klykN8uTbfVaM6kT0i93fNTpE63dX+HoO1KrK4UNakFcMzqypb59HmTef
 hiMgWqIH9KfmGhpBhU8gJu8H1ImF+quNLEXOORz2LGjCryKoZem1U0T3fiNOWqqwU7JK8dKiQ
 yiM1Ogu9f44/5s7Gbp/zC3vLGo0Sa0DXjxAya8lHkY6w5TCgY4RZbc=

From: Parker Newman <pnewman@connecttech.com>

- Removed old port setup function and replaced with UART specific ones
- Added board setup functions for CTI boards
- Replaced CONNECT_DEVICE macro with CTI_EXAR_DEVICE and CTI_PCI_DEVICE
- Moved "generic rs485" support up in the file

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 454 ++++++++++++++++++++++++----
 1 file changed, 401 insertions(+), 53 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 6f3697e34722..d8425113a9f1 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -440,6 +440,31 @@ static int exar_mpio_set(struct exar8250 *priv,
 	return 0;
 }

+static int generic_rs485_config(struct uart_port *port, struct ktermios *=
termios,
+				struct serial_rs485 *rs485)
+{
+	bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
+	u8 __iomem *p =3D port->membase;
+	u8 value;
+
+	value =3D readb(p + UART_EXAR_FCTR);
+	if (is_rs485)
+		value |=3D UART_FCTR_EXAR_485;
+	else
+		value &=3D ~UART_FCTR_EXAR_485;
+
+	writeb(value, p + UART_EXAR_FCTR);
+
+	if (is_rs485)
+		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
+
+	return 0;
+}
+
+static const struct serial_rs485 generic_rs485_supported =3D {
+	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+};
+
 static void exar_pm(struct uart_port *port, unsigned int state, unsigned =
int old)
 {
 	/*
@@ -875,15 +900,332 @@ static enum cti_port_type cti_get_port_type_xr17v35=
x(struct exar8250 *priv,
 	return port_type;
 }

-static int
-pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
-		       struct uart_8250_port *port, int idx)
+static int cti_rs485_config_mpio_tristate(struct uart_port *port,
+					struct ktermios *termios,
+					struct serial_rs485 *rs485)
 {
-	unsigned int offset =3D idx * 0x200;
-	unsigned int baud =3D 1843200;
+	struct exar8250 *priv;
+	int ret;

-	port->port.uartclk =3D baud * 16;
-	return default_setup(priv, pcidev, idx, offset, port);
+	priv =3D (struct exar8250 *)port->private_data;
+	if (!priv)
+		return -EINVAL;
+
+	ret =3D generic_rs485_config(port, termios, rs485);
+	if (ret)
+		return ret;
+
+	//disable power-on tri-state via MPIO
+	return cti_set_tristate(priv, port->port_id, false);
+}
+
+static int cti_port_setup_common(struct exar8250 *priv,
+				int idx, unsigned int offset,
+				struct uart_8250_port *port)
+{
+	int ret;
+
+	if (!priv || !port)
+		return -EINVAL;
+
+	if (priv->osc_freq =3D=3D 0)
+		return -EINVAL;
+
+	port->port.port_id =3D idx;
+	port->port.uartclk =3D priv->osc_freq;
+
+	ret =3D serial8250_pci_setup_port(priv->pcidev, port, 0, offset, 0);
+	if (ret) {
+		pci_err(priv->pcidev,
+			"failed to setup pci for port %d err: %d\n", idx, ret);
+		return ret;
+	}
+
+	port->port.private_data =3D (void *)priv;
+	port->port.pm =3D exar_pm;
+	port->port.shutdown =3D exar_shutdown;
+
+	return 0;
+}
+
+static int cti_port_setup_fpga(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+
+	port_type =3D cti_get_port_type_fpga(priv, idx);
+
+	//FPGA shares port offests with XR17C15X
+	offset =3D idx * UART_EXAR_XR17C15X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17D15X;
+
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		port->port.rs485_config =3D generic_rs485_config;
+		port->port.rs485_supported =3D generic_rs485_supported;
+	}
+
+	return cti_port_setup_common(priv, idx, offset, port);
+}
+
+static int cti_port_setup_xr17v35x(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+	int ret;
+
+	port_type =3D cti_get_port_type_xr17v35x(priv, idx);
+
+	offset =3D idx * UART_EXAR_XR17V35X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17V35X;
+
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	switch (port_type) {
+	case CTI_PORT_TYPE_RS422_485:
+	case CTI_PORT_TYPE_RS232_422_485_HW:
+		port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
+		port->port.rs485_supported =3D generic_rs485_supported;
+		break;
+	case CTI_PORT_TYPE_RS232_422_485_SW:
+	case CTI_PORT_TYPE_RS232_422_485_4B:
+	case CTI_PORT_TYPE_RS232_422_485_2B:
+		port->port.rs485_config =3D generic_rs485_config;
+		port->port.rs485_supported =3D generic_rs485_supported;
+		break;
+	default:
+		break;
+	}
+
+	ret =3D cti_port_setup_common(priv, idx, offset, port);
+	if (ret)
+		return ret;
+
+	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
+	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
+	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
+	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);
+
+	return 0;
+}
+
+static int cti_port_setup_xr17v25x(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+	int ret;
+
+	port_type =3D cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
+
+	offset =3D idx * UART_EXAR_XR17V25X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17D15X;
+
+	//xr17v25x supports fractional baudrates
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		switch (priv->pcidev->subsystem_device) {
+		//These cards support power on 485 tri-state via MPIO
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+			port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
+			break;
+		//Otherwise auto or no power on 485 tri-state support
+		default:
+			port->port.rs485_config =3D generic_rs485_config;
+			break;
+		}
+
+		port->port.rs485_supported =3D generic_rs485_supported;
+	}
+
+	ret =3D cti_port_setup_common(priv, idx, offset, port);
+	if (ret)
+		return ret;
+
+	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
+	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
+	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
+	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);
+
+	return 0;
+}
+
+static int cti_port_setup_xr17c15x(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+
+	port_type =3D cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
+
+	offset =3D idx * UART_EXAR_XR17C15X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17D15X;
+
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		switch (priv->pcidev->subsystem_device) {
+		//These cards support power on 485 tri-state via MPIO
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+			port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
+			break;
+		//Otherwise auto or no power on 485 tri-state support
+		default:
+			port->port.rs485_config =3D generic_rs485_config;
+			break;
+		}
+
+		port->port.rs485_supported =3D generic_rs485_supported;
+	}
+
+	return cti_port_setup_common(priv, idx, offset, port);
+}
+
+static int cti_board_setup_xr17v35x(struct exar8250 *priv)
+{
+	if (!priv)
+		return -EINVAL;
+
+	//XR17V35X use the PCIe clock rather than crystal
+	priv->osc_freq =3D CTI_DEFAULT_PCIE_OSC_FREQ;
+
+	return 0;
+}
+
+static int cti_board_setup_xr17v25x(struct exar8250 *priv)
+{
+	int osc_freq;
+
+	if (!priv)
+		return -EINVAL;
+
+	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17V25X_OSC_FREQ);
+	if (osc_freq < 0) {
+		pci_warn(priv->pcidev,
+			"failed to read osc freq from EEPROM, using default\n");
+		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
+	}
+
+	priv->osc_freq =3D osc_freq;
+
+	/* enable interupts on cards that need the "PLX fix" */
+	switch (priv->pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+		cti_set_plx_int_enable(priv, true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cti_board_setup_xr17c15x(struct exar8250 *priv)
+{
+	int osc_freq;
+
+	if (!priv)
+		return -EINVAL;
+
+	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17C15X_OSC_FREQ);
+	if (osc_freq <=3D 0) {
+		pci_warn(priv->pcidev,
+			"failed to read osc freq from EEPROM, using default\n");
+		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
+	}
+
+	priv->osc_freq =3D osc_freq;
+
+	/* enable interrupts on cards that need the "PLX fix" */
+	switch (priv->pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+		cti_set_plx_int_enable(priv, true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cti_board_setup_fpga(struct exar8250 *priv)
+{
+	int ret;
+	uint16_t cfg_val;
+
+	if (!priv)
+		return -EINVAL;
+
+	//FPGA OSC is fixed to the 33MHz PCI clock
+	priv->osc_freq =3D CTI_DEFAULT_FPGA_OSC_FREQ;
+
+	//Enable external interrupts in special cfg space register
+	ret =3D pci_read_config_word(priv->pcidev, 0x48, &cfg_val);
+	if (ret)
+		return ret;
+
+	cfg_val |=3D BIT(15);
+
+	ret =3D pci_write_config_word(priv->pcidev, 0x48, cfg_val);
+	if (ret)
+		return ret;
+
+	//RS485 gate needs to be enabled; otherwise RTS/CTS will not work
+	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
+
+	return 0;
 }

 static int
@@ -985,27 +1327,6 @@ static void xr17v35x_unregister_gpio(struct uart_825=
0_port *port)
 	port->port.private_data =3D NULL;
 }

-static int generic_rs485_config(struct uart_port *port, struct ktermios *=
termios,
-				struct serial_rs485 *rs485)
-{
-	bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
-	u8 __iomem *p =3D port->membase;
-	u8 value;
-
-	value =3D readb(p + UART_EXAR_FCTR);
-	if (is_rs485)
-		value |=3D UART_FCTR_EXAR_485;
-	else
-		value &=3D ~UART_FCTR_EXAR_485;
-
-	writeb(value, p + UART_EXAR_FCTR);
-
-	if (is_rs485)
-		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
-
-	return 0;
-}
-
 static int sealevel_rs485_config(struct uart_port *port, struct ktermios =
*termios,
 				  struct serial_rs485 *rs485)
 {
@@ -1044,10 +1365,6 @@ static int sealevel_rs485_config(struct uart_port *=
port, struct ktermios *termio
 	return 0;
 }

-static const struct serial_rs485 generic_rs485_supported =3D {
-	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
-};
-
 static const struct exar8250_platform exar8250_default_platform =3D {
 	.register_gpio =3D xr17v35x_register_gpio,
 	.unregister_gpio =3D xr17v35x_unregister_gpio,
@@ -1408,8 +1725,24 @@ static const struct exar8250_board pbn_fastcom335_8=
 =3D {
 	.setup		=3D pci_fastcom335_setup,
 };

-static const struct exar8250_board pbn_connect =3D {
-	.setup		=3D pci_connect_tech_setup,
+static const struct exar8250_board pbn_cti_xr17c15x =3D {
+	.board_setup	=3D cti_board_setup_xr17c15x,
+	.setup		=3D cti_port_setup_xr17c15x,
+};
+
+static const struct exar8250_board pbn_cti_xr17v25x =3D {
+	.board_setup	=3D cti_board_setup_xr17v25x,
+	.setup		=3D cti_port_setup_xr17v25x,
+};
+
+static const struct exar8250_board pbn_cti_xr17v35x =3D {
+	.board_setup	=3D cti_board_setup_xr17v35x,
+	.setup		=3D cti_port_setup_xr17v35x,
+};
+
+static const struct exar8250_board pbn_cti_fpga =3D {
+	.board_setup	=3D cti_board_setup_fpga,
+	.setup		=3D cti_port_setup_fpga,
 };

 static const struct exar8250_board pbn_exar_ibm_saturn =3D {
@@ -1456,15 +1789,27 @@ static const struct exar8250_board pbn_exar_XR17V8=
358 =3D {
 	.exit		=3D pci_xr17v35x_exit,
 };

-#define CONNECT_DEVICE(devid, sdevid, bd) {				\
-	PCI_DEVICE_SUB(							\
-		PCI_VENDOR_ID_EXAR,					\
-		PCI_DEVICE_ID_EXAR_##devid,				\
-		PCI_SUBVENDOR_ID_CONNECT_TECH,				\
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid), 0, 0,	\
-		(kernel_ulong_t)&bd					\
+//For Connect Tech cards with Exar vendor/device PCI IDs
+#define CTI_EXAR_DEVICE(devid, bd) {                    \
+	PCI_DEVICE_SUB(                                 \
+		PCI_VENDOR_ID_EXAR,                     \
+		PCI_DEVICE_ID_EXAR_##devid,             \
+		PCI_SUBVENDOR_ID_CONNECT_TECH,          \
+		PCI_ANY_ID), 0, 0,                      \
+		(kernel_ulong_t)&bd                     \
+	}
+
+//For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA ba=
sed)
+#define CTI_PCI_DEVICE(devid, bd) {                     \
+	PCI_DEVICE_SUB(                                 \
+		PCI_VENDOR_ID_CONNECT_TECH,             \
+		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
+		PCI_ANY_ID,                             \
+		PCI_ANY_ID), 0, 0,                      \
+		(kernel_ulong_t)&bd                     \
 	}

+
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) =
}

 #define IBM_DEVICE(devid, sdevid, bd) {			\
@@ -1494,18 +1839,21 @@ static const struct pci_device_id exar_pci_tbl[] =
=3D {
 	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),

-	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_1_1, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_2_2, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_4_4, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_2, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_2_485, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
+	CTI_EXAR_DEVICE(XR17C152,       pbn_cti_xr17c15x),
+	CTI_EXAR_DEVICE(XR17C154,       pbn_cti_xr17c15x),
+	CTI_EXAR_DEVICE(XR17C158,       pbn_cti_xr17c15x),
+
+	CTI_EXAR_DEVICE(XR17V252,       pbn_cti_xr17v25x),
+	CTI_EXAR_DEVICE(XR17V254,       pbn_cti_xr17v25x),
+	CTI_EXAR_DEVICE(XR17V258,       pbn_cti_xr17v25x),
+
+	CTI_EXAR_DEVICE(XR17V352,       pbn_cti_xr17v35x),
+	CTI_EXAR_DEVICE(XR17V354,       pbn_cti_xr17v35x),
+	CTI_EXAR_DEVICE(XR17V358,       pbn_cti_xr17v35x),
+
+	CTI_PCI_DEVICE(XR79X_12_XIG00X, pbn_cti_fpga),
+	CTI_PCI_DEVICE(XR79X_12_XIG01X, pbn_cti_fpga),
+	CTI_PCI_DEVICE(XR79X_16,        pbn_cti_fpga),

 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),

=2D-
2.43.2


