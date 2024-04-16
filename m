Return-Path: <linux-kernel+bounces-146840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36348A6BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688FB1F2277E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A312F5B6;
	Tue, 16 Apr 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="YDhR+HoH"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55812C481;
	Tue, 16 Apr 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272219; cv=none; b=kKhKfhMjq2ijTt9vqRGMf9OO9klrmvT12HPCBB1lUawpSArWrnvr2hogAhSnvkObNjNL7UcQwCMTPprAGFeKN8wnOMYlROFahMithIMIUA++ZyqmFv1rr2b9O5vlIObUuXLkjPUeyQY7Z1CusWgt9769fMXLHinZTTA+g9DiH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272219; c=relaxed/simple;
	bh=Ee0mh9zJHRHJ/thfsQwqLWlbicUqzPC2wsy8v427GvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkFSaigWMTGWiTIh7QadvEdDt85yLUfACGAfnzYBiczdrCwRZPpm64lW7Rn5ggkM2yTvYo25EnTzkz/ordlaf0Ml2ZV+dwobHzL0Rr6ZwSYepc0do9AZZhJ5wotpIZiUlwqvwNnkcCUGfLAxctwS1+US71ZfJMo9SLVwxWQW6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=YDhR+HoH; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272198; x=1713876998; i=parker@finest.io;
	bh=TP6izmejSm0dqraIyubEFkmdTGvEQiIfOdtuKK+awsc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YDhR+HoHBhrBRFS5sRZ2F5zCT/QEK5VToj5FfgPP8OF52Q2JWYj05uV5tehmmSd9
	 mx3lTzyjcTFwH8FpJCysObAQMboGLF9ANYebWDxixQEJtAWZy2UZbPni3QG7TDSPv
	 HU12VaYFLFxDlc8fn2PiFmewWO109N2kdsAbBWcf+9d2LtY0hjMWIE8GarKOjayRO
	 fv7AZlM1D2lXwjs2RI4LDtrDCH6ibrUj9NoKIhbQLYWmNHLwfmcetTxXKvL9bnAty
	 qiGvMYTTww7YEpqFUGy81LFsUTMfvW2EAoEeNgx56GC7kNhFcD7gNt+r3Jli8ENjR
	 9aeBCVHCXKG1Cvf75A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LufTy-1swLRN3hx2-00sReX; Tue, 16 Apr
 2024 14:56:38 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 7/8] serial: exar: add CTI specific setup code
Date: Tue, 16 Apr 2024 08:55:34 -0400
Message-ID: <354ff4aa9d8bdea1a21c503e685e81ac3df48eb8.1713270624.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713270624.git.pnewman@connecttech.com>
References: <cover.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4dqS34pM6W9Ed5Cd1Hbd9xsYoxWRtlbcvyxcIF4pda4nrm7c6Xn
 qUzBPAFS0ylXQ/HjKphPcW+K/oH/2dkbAKFIEzBQo/SmpIbjL+GktcH6Vxsso0pymBVlwPg
 UM6eyGLGx0H5KDrULAhADOc2XyHwf2I4ABQ4EiIip2rE2i6EJ3R5/ZY9V5tfKs0fOBtsWz3
 mZVnqDQAhzuH3wpGzNnsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S4jDoc/5iW0=;C2sf9UqaYauMY/sth4/lR2nCb2g
 SGn77d9JnlkzB8hcgr+H4CUjTo+yfDg++k/k0KTgPNAFuH5LqGFhsYUJSJNK0jYbh6+aTJ5De
 Rp+WuKJYlOCjfKnjW+Tzo81ogqgQtGey1LJ9PydCRrUcg5IKSTFA6MTtMh2HQg0CjuRGYa84p
 nrZ83BdsghhhMjBjSXG7XFdTJyyRFuoqtmedxPq/6LAOdtCkQ3CDvD9Pw2laE/7SRy6u874TB
 WP1Ah5toTf10jTbHthjU+3Tu+O95im6UmmgO87nvdsQKowNPlQBLKEV/VJ6+VmP2h5HV3/G91
 bes3rt3Rl91nYB7GlDV1uf1EWTUiOzFYiynEmPGXqUWF9WZ3QZV4FqoHkGpYjNInF6RgMQOgg
 wepuyg9B0DHFQD5aCWpEfV1r1/JGnxS5inqA886tT5j0kJaLCoSeHrhUZBb/sHFVsSsgbyCsS
 7xKl4k//kzxaku5vAifJEsltEUp+GnMab5PYAdJaXAAPP1YyGjLVP8IzWQK8yrKHHimZ9eyM5
 +mWiM9yQJCpDU/uif+Q/0PzEheBzLB22Ng9zgXOwx2ANW2lRf5jocHjMK9DJsrW+5CCHmWmdS
 vbfgCfFgsyLmthyeT8vK8DoQVKFce8P4NnNlQE5PAY32RvYLP46CPMVFp1MBUrQ/q+dzA34m7
 oKV01BB9FiedZDjFcZ+3whAslgyv8nm6OrFfbIHuTDng1tGkRLZiCEpFRsDXOVelF3sZ7uaOa
 X1TPudsYT4MFfwH+0m73Vw1AWSrTxRVGJNi2oxiVa3MhmgNw3biO2M=

From: Parker Newman <pnewman@connecttech.com>

This is a large patch but is only additions. All changes and removals
are made in previous patches in this series.

- Add CTI board_init and port setup functions for each UART type
- Add CTI_EXAR_DEVICE() and CTI_PCI_DEVICE() macros
- Add support for reading a word from the Exar EEPROM.
- Add support for configuring and setting a single MPIO
- Add various helper functions for CTI boards.
- Add osc_freq, pcidev, dev to struct exar8250

Changes in v3:
- Moved all base driver changes and refactoring to preparatory patches
- Switched any user space types to kernel types
- Switched all uses of pci_xxx print functions to dev_xxx
- Added struct device pointer in struct exar8250 to simplify above
- Switched osc_freq and port_flag parsing to use GENMASK() and
  FIELD_GET()/FIELD_PREP()
- Renamed board_setup function pointer to board_init
- Removed some unneeded checks for priv being NULL
- Added various convenience functions instead of relying on bools ex:
  exar_mpio_set_low()/exar_mpio_set_high() instead of exar_mpio_set()
- Renamed some variables and defines for clarity
- Numerous minor formatting fixes

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 899 ++++++++++++++++++++++++++++
 1 file changed, 899 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index ada01c6394a3..501b9f3e9c89 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -20,6 +20,8 @@
 #include <linux/property.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/string_choices.h>
+#include <linux/bitfield.h>

 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
@@ -128,6 +130,19 @@
 #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
 #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity =
*/

+/* EEPROM registers */
+#define UART_EXAR_REGB			0x8e
+#define UART_EXAR_REGB_EECK		BIT(4)
+#define UART_EXAR_REGB_EECS		BIT(5)
+#define UART_EXAR_REGB_EEDI		BIT(6)
+#define UART_EXAR_REGB_EEDO		BIT(7)
+#define UART_EXAR_REGB_EE_ADDR_SIZE	6
+#define UART_EXAR_REGB_EE_DATA_SIZE	16
+
+#define UART_EXAR_XR17C15X_PORT_OFFSET	0x200
+#define UART_EXAR_XR17V25X_PORT_OFFSET	0x200
+#define UART_EXAR_XR17V35X_PORT_OFFSET	0x400
+
 /*
  * IOT2040 MPIO wiring semantics:
  *
@@ -163,6 +178,52 @@
 #define IOT2040_UARTS_ENABLE		0x03
 #define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */

+/* CTI EEPROM offsets */
+#define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words */
+#define CTI_EE_OFF_XR17V25X_OSC_FREQ	0x08  /* 2 words */
+#define CTI_EE_OFF_XR17C15X_PART_NUM	0x0A  /* 4 words */
+#define CTI_EE_OFF_XR17V25X_PART_NUM	0x0E  /* 4 words */
+#define CTI_EE_OFF_XR17C15X_SERIAL_NUM	0x0E  /* 1 word */
+#define CTI_EE_OFF_XR17V25X_SERIAL_NUM	0x12  /* 1 word */
+#define CTI_EE_OFF_XR17V35X_SERIAL_NUM	0x11  /* 2 word */
+#define CTI_EE_OFF_XR17V35X_BRD_FLAGS	0x13  /* 1 word */
+#define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */
+
+#define CTI_EE_MASK_PORT_FLAGS_TYPE	GENMASK(7, 0)
+#define CTI_EE_MASK_OSC_FREQ_LOWER	GENMASK(15, 0)
+#define CTI_EE_MASK_OSC_FREQ_UPPER	GENMASK(31, 16)
+
+#define CTI_FPGA_RS485_IO_REG		0x2008
+#define CTI_FPGA_CFG_INT_EN_REG		0x48
+#define CTI_FPGA_CFG_INT_EN_EXT_BIT	BIT(15) /* External int enable bit */
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
+	CTI_PORT_TYPE_RS232,            // RS232 ONLY
+	CTI_PORT_TYPE_RS422_485,        // RS422/RS485 ONLY
+	CTI_PORT_TYPE_RS232_422_485_HW, // RS232/422/485 HW ONLY Switchable
+	CTI_PORT_TYPE_RS232_422_485_SW, // RS232/422/485 SW ONLY Switchable
+	CTI_PORT_TYPE_RS232_422_485_4B, // RS232/422/485 HW/SW (4bit ex. BCG004)
+	CTI_PORT_TYPE_RS232_422_485_2B, // RS232/422/485 HW/SW (2bit ex. BBG008)
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
@@ -192,11 +253,214 @@ struct exar8250_board {

 struct exar8250 {
 	unsigned int		nr;
+	unsigned int		osc_freq;
+	struct pci_dev		*pcidev;
+	struct device		*dev;
 	struct exar8250_board	*board;
 	void __iomem		*virt;
 	int			line[];
 };

+static inline void exar_write_reg(struct exar8250 *priv,
+				unsigned int reg, u8 value)
+{
+	writeb(value, priv->virt + reg);
+}
+
+static inline u8 exar_read_reg(struct exar8250 *priv, unsigned int reg)
+{
+	return readb(priv->virt + reg);
+}
+
+static inline void exar_ee_select(struct exar8250 *priv)
+{
+	// Set chip select pin high to enable EEPROM reads/writes
+	exar_write_reg(priv, UART_EXAR_REGB, UART_EXAR_REGB_EECS);
+	// Min ~500ns delay needed between CS assert and EEPROM access
+	udelay(1);
+}
+
+static inline void exar_ee_deselect(struct exar8250 *priv)
+{
+	exar_write_reg(priv, UART_EXAR_REGB, 0x00);
+}
+
+static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
+{
+	u8 value =3D UART_EXAR_REGB_EECS;
+
+	if (bit)
+		value |=3D UART_EXAR_REGB_EEDI;
+
+	// Clock out the bit on the EEPROM interface
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	// 2us delay =3D ~500khz clock speed
+	udelay(2);
+
+	value |=3D UART_EXAR_REGB_EECK;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+}
+
+static inline u8 exar_ee_read_bit(struct exar8250 *priv)
+{
+	u8 regb;
+	u8 value =3D UART_EXAR_REGB_EECS;
+
+	// Clock in the bit on the EEPROM interface
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	// 2us delay =3D ~500khz clock speed
+	udelay(2);
+
+	value |=3D UART_EXAR_REGB_EECK;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+
+	regb =3D exar_read_reg(priv, UART_EXAR_REGB);
+
+	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
+}
+
+/**
+ * exar_ee_read() - Read a word from the EEPROM
+ * @priv: Device's private structure
+ * @ee_addr: Offset of EEPROM to read word from
+ *
+ * Read a single 16bit word from an Exar UART's EEPROM.
+ *
+ * Return: EEPROM word
+ */
+static u16 exar_ee_read(struct exar8250 *priv, u8 ee_addr)
+{
+	int i;
+	u16 data =3D 0;
+
+	exar_ee_select(priv);
+
+	// Send read command (opcode 110)
+	exar_ee_write_bit(priv, 1);
+	exar_ee_write_bit(priv, 1);
+	exar_ee_write_bit(priv, 0);
+
+	// Send address to read from
+	for (i =3D 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>=3D 1)
+		exar_ee_write_bit(priv, (ee_addr & i));
+
+	// Read data 1 bit at a time
+	for (i =3D 0; i <=3D UART_EXAR_REGB_EE_DATA_SIZE; i++) {
+		data <<=3D 1;
+		data |=3D exar_ee_read_bit(priv);
+	}
+
+	exar_ee_deselect(priv);
+
+	return data;
+}
+
+/**
+ * _exar_mpio_config() - Configure an Exar MPIO as input or output
+ * @priv: Device's private structure
+ * @mpio_num: MPIO number/offset to configure
+ * @output: Configure as output if true, inout if false
+ *
+ * Configure a single MPIO as an input or output and disable tristate.
+ * If configuring as output it is reccomended to set value with
+ * exar_mpio_set_high()/exar_mpio_set_low() prior to calling this functio=
n to
+ * ensure default MPIO pin state.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int _exar_mpio_config(struct exar8250 *priv,
+			unsigned int mpio_num, bool output)
+{
+	unsigned int mpio_offset;
+	u8 sel_reg; // MPIO Select register (input/output)
+	u8 tri_reg; // MPIO Tristate register
+	u8 value;
+
+	if (mpio_num < 8) {
+		sel_reg =3D UART_EXAR_MPIOSEL_7_0;
+		tri_reg =3D UART_EXAR_MPIO3T_7_0;
+		mpio_offset =3D mpio_num;
+	} else if (mpio_num >=3D 8 && mpio_num < 16) {
+		sel_reg =3D UART_EXAR_MPIOSEL_15_8;
+		tri_reg =3D UART_EXAR_MPIO3T_15_8;
+		mpio_offset =3D mpio_num - 8;
+	} else {
+		return -EINVAL;
+	}
+
+	// Disable MPIO pin tri-state
+	value =3D exar_read_reg(priv, tri_reg);
+	value &=3D ~BIT(mpio_offset);
+	exar_write_reg(priv, tri_reg, value);
+
+	value =3D exar_read_reg(priv, sel_reg);
+	if (output)
+		value &=3D ~BIT(mpio_offset);
+	else
+		value |=3D BIT(mpio_offset);
+	exar_write_reg(priv, sel_reg, value);
+
+	return 0;
+}
+
+static int exar_mpio_config_output(struct exar8250 *priv,
+				unsigned int mpio_num)
+{
+	return _exar_mpio_config(priv, mpio_num, true);
+}
+
+/**
+ * _exar_mpio_set() - Set an Exar MPIO output high or low
+ * @priv: Device's private structure
+ * @mpio_num: MPIO number/offset to set
+ * @high: Set MPIO high if true, low if false
+ *
+ * Set a single MPIO high or low. exar_mpio_config_output() must also be =
called
+ * to configure the pin as an output.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int _exar_mpio_set(struct exar8250 *priv,
+			unsigned int mpio_num, bool high)
+{
+	unsigned int mpio_offset;
+	u8 lvl_reg;
+	u8 value;
+
+	if (mpio_num < 8) {
+		lvl_reg =3D UART_EXAR_MPIOLVL_7_0;
+		mpio_offset =3D mpio_num;
+	} else if (mpio_num >=3D 8 && mpio_num < 16) {
+		lvl_reg =3D UART_EXAR_MPIOLVL_15_8;
+		mpio_offset =3D mpio_num - 8;
+	} else {
+		return -EINVAL;
+	}
+
+	value =3D exar_read_reg(priv, lvl_reg);
+	if (high)
+		value |=3D BIT(mpio_offset);
+	else
+		value &=3D ~BIT(mpio_offset);
+	exar_write_reg(priv, lvl_reg, value);
+
+	return 0;
+}
+
+static int exar_mpio_set_low(struct exar8250 *priv, unsigned int mpio_num=
)
+{
+	return _exar_mpio_set(priv, mpio_num, false);
+}
+
+static int exar_mpio_set_high(struct exar8250 *priv, unsigned int mpio_nu=
m)
+{
+	return _exar_mpio_set(priv, mpio_num, true);
+}
+
 static int generic_rs485_config(struct uart_port *port, struct ktermios *=
termios,
 				struct serial_rs485 *rs485)
 {
@@ -384,6 +648,582 @@ pci_fastcom335_setup(struct exar8250 *priv, struct p=
ci_dev *pcidev,
 	return 0;
 }

+/**
+ * _cti_set_tristate() - Enable/Disable RS485 transciever tristate
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
+static int _cti_set_tristate(struct exar8250 *priv,
+			unsigned int port_num, bool enable)
+{
+	int ret =3D 0;
+
+	if (port_num >=3D priv->nr)
+		return -EINVAL;
+
+	// Only Exar based cards use MPIO, return 0 otherwise
+	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	dev_dbg(priv->dev, "%s tristate for port %u\n",
+		str_enable_disable(enable), port_num);
+
+	if (enable)
+		ret =3D exar_mpio_set_low(priv, port_num);
+	else
+		ret =3D exar_mpio_set_high(priv, port_num);
+	if (ret)
+		return ret;
+
+	// Ensure MPIO is an output
+	ret =3D exar_mpio_config_output(priv, port_num);
+
+	return ret;
+}
+
+static int cti_tristate_disable(struct exar8250 *priv, unsigned int port_=
num)
+{
+	return _cti_set_tristate(priv, port_num, false);
+}
+
+/**
+ * _cti_set_plx_int_enable() - Enable/Disable PCI interrupts
+ * @priv: Device's private structure
+ * @enable: Enable interrupts if true, disable if false
+ *
+ * Some older CTI cards require MPIO_0 to be set low to enable the PCI
+ * interupts from the UART to the PLX PCI->PCIe bridge.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int _cti_set_plx_int_enable(struct exar8250 *priv, bool enable)
+{
+	int ret =3D 0;
+
+	// Only Exar based cards use MPIO, return 0 otherwise
+	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	if (enable)
+		ret =3D exar_mpio_set_low(priv, 0);
+	else
+		ret =3D exar_mpio_set_high(priv, 0);
+	if (ret)
+		return ret;
+
+	// Ensure MPIO is an output
+	ret =3D exar_mpio_config_output(priv, 0);
+
+	return ret;
+}
+
+static int cti_plx_int_enable(struct exar8250 *priv)
+{
+	return _cti_set_plx_int_enable(priv, true);
+}
+
+/**
+ * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
+ * @priv: Device's private structure
+ * @eeprom_offset: Offset where the oscillator frequency is stored
+ *
+ * CTI XR17x15X and XR17V25X cards have the serial boards oscillator freq=
uency
+ * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe c=
lock.
+ *
+ * Return: frequency on success, negative error code on failure
+ */
+static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
+{
+	u16 lower_word;
+	u16 upper_word;
+	int osc_freq;
+
+	lower_word =3D exar_ee_read(priv, eeprom_offset);
+	// Check if EEPROM word was blank
+	if (lower_word =3D=3D 0xFFFF)
+		return -EIO;
+
+	upper_word =3D exar_ee_read(priv, (eeprom_offset + 1));
+	if (upper_word =3D=3D 0xFFFF)
+		return -EIO;
+
+	osc_freq =3D FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
+		FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
+
+	dev_dbg(priv->dev, "osc_freq from EEPROM %d\n", osc_freq);
+
+	return osc_freq;
+}
+
+/**
+ * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17=
v25x
+ * @priv: Device's private structure
+ * @port_num: Port to get type of
+ *
+ * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar=
8250 *priv,
+							unsigned int port_num)
+{
+	enum cti_port_type port_type;
+
+	switch (priv->pcidev->subsystem_device) {
+	// RS232 only cards
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
+		port_type =3D CTI_PORT_TYPE_RS232;
+		break;
+	// 1x RS232, 1x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
+		port_type =3D (port_num =3D=3D 0) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	// 2x RS232, 2x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
+		port_type =3D (port_num < 2) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	// 4x RS232, 4x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		port_type =3D (port_num < 4) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	// RS232/RS422/RS485 HW (jumper) selectable
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
+	// RS422/RS485 HW (jumper) selectable
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+		port_type =3D CTI_PORT_TYPE_RS422_485;
+		break;
+	// 6x RS232, 2x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		port_type =3D (port_num < 6) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	// 2x RS232, 6x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		port_type =3D (port_num < 2) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	default:
+		dev_err(priv->dev, "unknown/unsupported device\n");
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
+ * FPGA based cards port types are based on PCI IDs.
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
+						unsigned int port_num)
+{
+	enum cti_port_type port_type;
+
+	switch (priv->pcidev->device) {
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+		break;
+	default:
+		dev_err(priv->dev, "unknown/unsupported device\n");
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
+	enum cti_port_type port_type;
+	u16 port_flags;
+	u8 offset;
+
+	offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
+	port_flags =3D exar_ee_read(priv, offset);
+
+	port_type =3D FIELD_GET(CTI_EE_MASK_PORT_FLAGS_TYPE, port_flags);
+	if (!CTI_PORT_TYPE_VALID(port_type)) {
+		/*
+		 * If the port type is missing the card assume it is a
+		 * RS232/RS422/RS485 card to be safe.
+		 *
+		 * There is one known board (BEG013) that only has
+		 * 3 of 4 port types written to the EEPROM so this
+		 * acts as a work around.
+		 */
+		dev_warn(priv->dev,
+			"failed to get port %d type from EEPROM\n", port_num);
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+	}
+
+	return port_type;
+}
+
+static int cti_rs485_config_mpio_tristate(struct uart_port *port,
+					struct ktermios *termios,
+					struct serial_rs485 *rs485)
+{
+	struct exar8250 *priv =3D (struct exar8250 *)port->private_data;
+	int ret;
+
+	ret =3D generic_rs485_config(port, termios, rs485);
+	if (ret)
+		return ret;
+
+	// Disable power-on RS485 tri-state via MPIO
+	return cti_tristate_disable(priv, port->port_id);
+}
+
+static int cti_port_setup_common(struct exar8250 *priv,
+				int idx, unsigned int offset,
+				struct uart_8250_port *port)
+{
+	int ret;
+
+	if (priv->osc_freq =3D=3D 0)
+		return -EINVAL;
+
+	port->port.port_id =3D idx;
+	port->port.uartclk =3D priv->osc_freq;
+
+	ret =3D serial8250_pci_setup_port(priv->pcidev, port, 0, offset, 0);
+	if (ret) {
+		dev_err(priv->dev,
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
+	// FPGA shares port offests with XR17C15X
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
+	// XR17V25X supports fractional baudrates
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		switch (priv->pcidev->subsystem_device) {
+		// These cards support power on 485 tri-state via MPIO
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
+		// Otherwise auto or no power on 485 tri-state support
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
+		// These cards support power on 485 tri-state via MPIO
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
+		// Otherwise auto or no power on 485 tri-state support
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
+static int cti_board_init_xr17v35x(struct exar8250 *priv)
+{
+	// XR17V35X uses the PCIe clock rather than an oscillator
+	priv->osc_freq =3D CTI_DEFAULT_PCIE_OSC_FREQ;
+
+	return 0;
+}
+
+static int cti_board_init_xr17v25x(struct exar8250 *priv)
+{
+	int osc_freq;
+
+	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17V25X_OSC_FREQ);
+	if (osc_freq < 0) {
+		dev_warn(priv->dev,
+			"failed to read osc freq from EEPROM, using default\n");
+		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
+	}
+
+	priv->osc_freq =3D osc_freq;
+
+	/* enable interupts on cards that need the "PLX fix" */
+	switch (priv->pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+		cti_plx_int_enable(priv);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cti_board_init_xr17c15x(struct exar8250 *priv)
+{
+	int osc_freq;
+
+	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17C15X_OSC_FREQ);
+	if (osc_freq <=3D 0) {
+		dev_warn(priv->dev,
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
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+		cti_plx_int_enable(priv);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cti_board_init_fpga(struct exar8250 *priv)
+{
+	int ret;
+	u16 cfg_val;
+
+	// FPGA OSC is fixed to the 33MHz PCI clock
+	priv->osc_freq =3D CTI_DEFAULT_FPGA_OSC_FREQ;
+
+	// Enable external interrupts in special cfg space register
+	ret =3D pci_read_config_word(priv->pcidev,
+				CTI_FPGA_CFG_INT_EN_REG, &cfg_val);
+	if (ret)
+		return ret;
+
+	cfg_val |=3D CTI_FPGA_CFG_INT_EN_EXT_BIT;
+	ret =3D pci_write_config_word(priv->pcidev,
+				CTI_FPGA_CFG_INT_EN_REG, cfg_val);
+	if (ret)
+		return ret;
+
+	// RS485 gate needs to be enabled; otherwise RTS/CTS will not work
+	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
+
+	return 0;
+}
+
 static int
 pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
@@ -767,6 +1607,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct p=
ci_device_id *ent)
 		return -ENOMEM;

 	priv->board =3D board;
+	priv->pcidev =3D pcidev;
+	priv->dev =3D &pcidev->dev;
 	priv->virt =3D pcim_iomap(pcidev, bar, 0);
 	if (!priv->virt)
 		return -ENOMEM;
@@ -879,6 +1721,26 @@ static const struct exar8250_board pbn_fastcom335_8 =
=3D {
 	.setup		=3D pci_fastcom335_setup,
 };

+static const struct exar8250_board pbn_cti_xr17c15x =3D {
+	.board_init	=3D cti_board_init_xr17c15x,
+	.setup		=3D cti_port_setup_xr17c15x,
+};
+
+static const struct exar8250_board pbn_cti_xr17v25x =3D {
+	.board_init	=3D cti_board_init_xr17v25x,
+	.setup		=3D cti_port_setup_xr17v25x,
+};
+
+static const struct exar8250_board pbn_cti_xr17v35x =3D {
+	.board_init	=3D cti_board_init_xr17v35x,
+	.setup		=3D cti_port_setup_xr17v35x,
+};
+
+static const struct exar8250_board pbn_cti_fpga =3D {
+	.board_init	=3D cti_board_init_fpga,
+	.setup		=3D cti_port_setup_fpga,
+};
+
 static const struct exar8250_board pbn_exar_ibm_saturn =3D {
 	.num_ports	=3D 1,
 	.setup		=3D pci_xr17c154_setup,
@@ -923,6 +1785,27 @@ static const struct exar8250_board pbn_exar_XR17V835=
8 =3D {
 	.exit		=3D pci_xr17v35x_exit,
 };

+// For Connect Tech cards with Exar vendor/device PCI IDs
+#define CTI_EXAR_DEVICE(devid, bd) {                    \
+	PCI_DEVICE_SUB(                                 \
+		PCI_VENDOR_ID_EXAR,                     \
+		PCI_DEVICE_ID_EXAR_##devid,             \
+		PCI_SUBVENDOR_ID_CONNECT_TECH,          \
+		PCI_ANY_ID), 0, 0,                      \
+		(kernel_ulong_t)&bd                     \
+	}
+
+// For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA b=
ased)
+#define CTI_PCI_DEVICE(devid, bd) {                     \
+	PCI_DEVICE_SUB(                                 \
+		PCI_VENDOR_ID_CONNECT_TECH,             \
+		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
+		PCI_ANY_ID,                             \
+		PCI_ANY_ID), 0, 0,                      \
+		(kernel_ulong_t)&bd                     \
+	}
+
+
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) =
}

 #define IBM_DEVICE(devid, sdevid, bd) {			\
@@ -952,6 +1835,22 @@ static const struct pci_device_id exar_pci_tbl[] =3D=
 {
 	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),

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
+
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),

 	/* USRobotics USR298x-OEM PCI Modems */
=2D-
2.43.2


