Return-Path: <linux-kernel+bounces-141569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108E8A2027
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379B028C4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB5182BD;
	Thu, 11 Apr 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="i6iH4hiR"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83C17C6A;
	Thu, 11 Apr 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867164; cv=none; b=OY9nNew8rvDe2UXmFjHs7D701mse/RXBqxWDVImACtkMB95eqGN6lcQJsRrq3cVNADYYi1lCABCDNL88mh8i4pKM2YhorQh+/tbLo6CXkEgFCVM6fy0WrUNLf7fSU7I+LQlht8H0LUOqVjB41/qzCxWPjy0qbnjqulmqdqH4gxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867164; c=relaxed/simple;
	bh=XoApVgnrMaufCiheBxdu3E9GYzATKwq4UZrsxBcGihY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6ay3ACy4qtH4Qlxhm+l9hUiE5hPbAeHugJX6tILNOtL8UBxtukQnZM87MvchzzKLHtwzBiIhonQrotT4TfKSJKnyHN+HtZhz68aZDXqb/n3rnj9dfRTrrEviREGXa4i4UPtUUDL2L/OLDwGCxMu1FG/RlSaeLd4X4MQcGsmUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=i6iH4hiR; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867157; x=1713471957; i=parker@finest.io;
	bh=jDtycroHBuO6M79KMq7clDQ2cxUyLfrUzN08PqttkGg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i6iH4hiRs01wemE31sWZqXm9UzqsGXcoMWH40UXGf87cxkc4vgpIlSVCD5w33i9m
	 dbQ94CkdYq+SHgQMAXS8gScBsPVIws82OklIJ2P1AaiV8tPJk0baVSEv6bogmRhu+
	 sLQZ8uugaJQMvhTQnnB5GEim7xdlukv4DMw5u4ajDN90HKkNxZ9e2DAZFOg5DCMk8
	 ecPVGmdWGwXdtiQ7hp03WuItPd/Acy42+Eet4Btcoz1r67LPRqxteKbfofqPDR7i3
	 LgUaneB2sDr84RJA89zB/4XVWVhI0sqnI2X7rtsRjr3FJERT7dsde11k4ffWv57D1
	 6GkuvLO5+puSYpmqyA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M9IQC-1s3Ijb2DOw-0032Yw; Thu, 11 Apr
 2024 22:25:57 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 2/7] serial: exar: add support for reading from Exar EEPROM
Date: Thu, 11 Apr 2024 16:25:40 -0400
Message-ID: <d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:Y4RPmjxQqQ4vafUt1kFgZGKHOYLk7BwGDAxQV2jDQxdTtiQcTRO
 jvRby1j2c6/Af1yc47C6LccmwT122stXSxmqbTNJNn2nm0a5DDuKlKRYE00rQahWTVbczBc
 dXRwLDjhGFFBZWA8PHZq/xju+DgjcKQctbyWObDTTg+0X2/NL4cLxorIDOyNDr3oPPnXKNV
 8p4ZcyyChahMvX1BOv6eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:upnVXHs+xiY=;fYUxVut5gLhHQy/JpxbZcD7qSbs
 4cbk4AK2b1I5gwNvVC+EeRHtKx14bxGJHpt0WQ0vG5Qt+jGTIR1dj7eWdSZMCTDXv5NDS/2is
 6PR2GsZLUI/Qag0jzBa3FGDfs9tnIyjy+5fk62fEHtKru5yz1ICGnm8F04PwId4/kqxAGMbyU
 Wfr2RJ2vHKv/ttcTiuz65gzLRe3TFKjxOenjz3C7sd59tAG9EJf9YTPwSR4qedk6ihKUIk0ka
 EbbP1gCXUMdFid0HHrPGn5VtqxJqdxdYDG4zTtKJ1qo/JTpDRc60wyWGraygSwFjY/mi5oOhS
 jNZ70TZR0fe6E99PVjHaD8COPBWQ6C25zTjn6JgTyiA/9TlQhKD2LancAH10s4WK4E+FjcLGy
 3iZdNDsGS21OVZwPbCxtRu3UxsopzOWm3GT8/N8DnnuVpRvVRPdvBCCtzbWFwWFidMHhU3a61
 4waDD5zen4HIu80vqrVs2fSDRh9NWoEQnXvpeHDdw4r4ZlBCjB9tIGPwiibjY6EpgK//32jmz
 otdicFyp9ZZRwifxuduQPF0caLXEiKqLZXfZGqrIbV3teoQ05XtX5gRhMboFlAXQToBggrNi7
 T4qq8aN3pwdbIB1waQfRfUUCgUzkgsDe9QW1mYlxQmqA7efWd54FTf6s8GvxTXBe3K+u/kou+
 b9pFs3ahCHv6rfYbl3s8wA7UmSdS39+euk89JsdY20lGtRw1MWHqg3AMFdQvhpLwP+TIwAgWp
 0KcBYk/CU/JokSjUBshOKaHiK2I6xt9xPrm/VBS0jCb0zbZ4Q8F/3s=

From: Parker Newman <pnewman@connecttech.com>

- Adds support for reading a word from the Exar EEPROM.
- Adds exar_write_reg/exar_read_reg for reading and writing to the UART's
config registers.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 110 ++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 4d1e07343d0b..49d690344e65 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -128,6 +128,16 @@
 #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
 #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity =
*/

+/* EEPROM registers */
+#define UART_EXAR_REGB                  0x8e
+#define UART_EXAR_REGB_EECK             BIT(4)
+#define UART_EXAR_REGB_EECS             BIT(5)
+#define UART_EXAR_REGB_EEDI             BIT(6)
+#define UART_EXAR_REGB_EEDO             BIT(7)
+#define UART_EXAR_REGB_EE_ADDR_SIZE     6
+#define UART_EXAR_REGB_EE_DATA_SIZE     16
+
+
 /*
  * IOT2040 MPIO wiring semantics:
  *
@@ -195,6 +205,106 @@ struct exar8250 {
 	int			line[];
 };

+static inline void exar_write_reg(struct exar8250 *priv,
+				unsigned int reg, uint8_t value)
+{
+	if (!priv || !priv->virt)
+		return;
+
+	writeb(value, priv->virt + reg);
+}
+
+static inline uint8_t exar_read_reg(struct exar8250 *priv, unsigned int r=
eg)
+{
+	if (!priv || !priv->virt)
+		return 0;
+
+	return readb(priv->virt + reg);
+}
+
+static inline void exar_ee_select(struct exar8250 *priv, bool enable)
+{
+	uint8_t value =3D 0x00;
+
+	if (enable)
+		value |=3D UART_EXAR_REGB_EECS;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+}
+
+static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
+{
+	uint8_t value =3D UART_EXAR_REGB_EECS;
+
+	if (bit)
+		value |=3D UART_EXAR_REGB_EEDI;
+
+	//Clock out the bit on the i2c interface
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+
+	value |=3D UART_EXAR_REGB_EECK;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+}
+
+static inline uint8_t exar_ee_read_bit(struct exar8250 *priv)
+{
+	uint8_t regb;
+	uint8_t value =3D UART_EXAR_REGB_EECS;
+
+	//Clock in the bit on the i2c interface
+	exar_write_reg(priv, UART_EXAR_REGB, value);
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
+ * Read a single 16bit word from an Exar UART's EEPROM
+ *
+ * Return: EEPROM word on success, negative error code on failure
+ */
+static int exar_ee_read(struct exar8250 *priv, uint8_t ee_addr)
+{
+	int i;
+	int data =3D 0;
+
+	exar_ee_select(priv, true);
+
+	//Send read command (opcode 110)
+	exar_ee_write_bit(priv, 1);
+	exar_ee_write_bit(priv, 1);
+	exar_ee_write_bit(priv, 0);
+
+	//Send address to read from
+	for (i =3D 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>=3D 1)
+		exar_ee_write_bit(priv, (ee_addr & i));
+
+	//Read data 1 bit at a time
+	for (i =3D 0; i <=3D UART_EXAR_REGB_EE_DATA_SIZE; i++) {
+		data <<=3D 1;
+		data |=3D exar_ee_read_bit(priv);
+	}
+
+	exar_ee_select(priv, false);
+
+	return data;
+}
+
 static void exar_pm(struct uart_port *port, unsigned int state, unsigned =
int old)
 {
 	/*
=2D-
2.43.2


