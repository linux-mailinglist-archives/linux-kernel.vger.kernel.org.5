Return-Path: <linux-kernel+bounces-146836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566128A6B96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8814E1C21751
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76612C7FB;
	Tue, 16 Apr 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="ieObK0E0"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D212BF15;
	Tue, 16 Apr 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272217; cv=none; b=PvCEHE55no3KhZo1CaZOBoID4/36D9g5SxY3ktU3/3tK5cDgqLZFcTuSQzvxdvVD5o+wqSJFjJoCF3OSYjKnw8C39W3SbBA4CwPDfodEItS2fDAa/anvJSA+ni8cLQu4EMHK7TTAJncGpLwbZOzZBK/weVSHb01NHD8w4KmdIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272217; c=relaxed/simple;
	bh=L0bwfC7QPhgn8nVwSuegcUdEIriV44jAxrlwA2aq5c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYKwgar4jXvlR7ghaWaQid5R+6pFIwb2l7b9zV+LfH6kncQQhGSBGANhdAtu6GWV44UsmpFI4Ge0H7Z/qwWo3DDQ39i3wrJBEd3XavbcsVg1kqk0ucCnsfeod1a4Z2Y3qpwuVb8b5s/GBKSTZdjUsW2Woi5r+Wx8gZcfyE3/RFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=ieObK0E0; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272197; x=1713876997; i=parker@finest.io;
	bh=mTpO0cGiHBKqJRh0o/22NMtUp4Gs856K6CxolXkEPh8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ieObK0E0v6lboH7g9dZor/h29uZfJqxU/0wuV78NzDvtJdYCauN9mBkF0XEOkLmh
	 yL6uNVrod1j2xx+ZRWzRhawLCJ4Wnfo3PERzokjla7LFdp4+SgUoeq7HeUcdHOGR+
	 SwKgfCqAxDqdtVlA7p0z7r8oB/xvdF4RsfW3tyYJznhue9rNre+BMWTtheN6mGZQj
	 1nKx9oAt9v+ME/39GHVxD7hCYU4bUXp69wBsS2INhwT5b2dovbJut5qjRZsLYvT3D
	 IlTByh/+1shVDVyss6+kdUotk1G8/FEpQSRjlGS9dapOW3e4h093+7BuG6tfs93da
	 5jTkw1AazMIv/5x1rA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LkNen-1sTaH81BE3-00m0QQ; Tue, 16 Apr
 2024 14:56:37 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 5/8] serial: exar: moved generic_rs485 further up in 8250_exar.c
Date: Tue, 16 Apr 2024 08:55:32 -0400
Message-ID: <dc518985c106c010e5091ad8250937d68f748ecb.1713270624.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:GqCZO7Z93IKq1C/aerb2hYCsxQYB1t8YENfP/S8qxEtpnUdsE0H
 Tn0jVn6erNub9waiGGs7+IUub0CryZOSn0+zwk1BRe1WZU1P+LNXfbwn51wSFkl6Zk6lVwG
 0A8N36FJdhlGVWHaOc61gNnAyI3pYbZhi+j9gi7+32+ICow6yDoDVHY5rxpfctCY2hnkHlh
 0fpx6hlDLjznNBPiZ2WCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J5uH9/3EKuQ=;U9TNMJS12lgnpmTEANSvnUuQjMY
 cJGgBTZV8u4iHkjBxWEpVLdD27Udc2q1Cgjc+UcAfz1fVg5ZRH0JZNqUpTb2EtIF25O/vYXEp
 1i6MKG3jM9UaxeZhamV4s9ojgibrdaG52g/138SdmDLeKNkjkGDbVy0O1Ea2lHWhVg5z1NiLS
 0lgBNJWpkt79gozRMsq7aYiQ8cqmMm6XUBo2w7fjNuKoMuAjcCIfNP7wa/+Mk8edz5YmL5lWF
 yHHU19DNCMYvKNNj9ONaZGupFfh82LOwVunEpb2ubOHKmVFtkAyv7dCi3nFj9OF2wVDtOxTS9
 PTCiPMAJtnJt1ikuPcTSRNpsRuqNYRRt4RzRYVeKBVk/R981kkXVxsSxItOIhEKVVj92iINSH
 UOnYiHlXk8ZT1wENtpDO96yDvwGLvUpJCha+gBx13v+W/W3cjKPjJZwNpNTGpm1me+geBD61J
 IjnAvokY32/CoNsvy1l2WeAb05s7yqIDvYlMCNsAwkS7vOE7y1PIU84dtnw8fYOPlDMx5BaMo
 1vaGT+V/KKprbi34RKn9qVbNUH89PPWWSSCiO0spakfy5SM4UFR9pi3N0JAksOSptsogCbzD2
 qN25iIIbwIakp1DC6TpCZM2UNltqSE9R36EJ8FPL1jn1ad0wtZcWlFI3MayjJdtOvXIAQOcs5
 zFkbva+meSjOdCkhaNRtCpNDGm4Z+XXpH7Goou9XYo0hc8qFBQsseZ4tMGdRD6mIK7dURfeBC
 A0Cp3UsNai7tBzTJE72KnvmOx50oc17/f2uLPEC6dOyYNSiwWPsyX8=

From: Parker Newman <pnewman@connecttech.com>

Preparatory patch moving generic_rs485_config and
generic_rs485_supported higher in the file to allow for CTI setup
functions to use it.

Changes in v3:
- split into separate preparatory patch

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 50 ++++++++++++++---------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index cf7900bd2974..7e47a4145c7b 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -197,6 +197,31 @@ struct exar8250 {
 	int			line[];
 };

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
@@ -458,27 +483,6 @@ static void xr17v35x_unregister_gpio(struct uart_8250=
_port *port)
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
@@ -517,10 +521,6 @@ static int sealevel_rs485_config(struct uart_port *po=
rt, struct ktermios *termio
 	return 0;
 }

-static const struct serial_rs485 generic_rs485_supported =3D {
-	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
-};
-
 static const struct exar8250_platform exar8250_default_platform =3D {
 	.register_gpio =3D xr17v35x_register_gpio,
 	.unregister_gpio =3D xr17v35x_unregister_gpio,
=2D-
2.43.2


