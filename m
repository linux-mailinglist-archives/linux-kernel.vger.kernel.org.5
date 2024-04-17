Return-Path: <linux-kernel+bounces-149183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771848A8CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D77286234
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B48481BE;
	Wed, 17 Apr 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="bYxcPUO5"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E244C8B;
	Wed, 17 Apr 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385922; cv=none; b=cFWU9ofShr/YETchO+wKmlVdJ/tr7cHY+WEzUeNtCrHdWLNZ92EHIu9p+EMNfDBC25b2IE9p5KnnAOLrMSrOsy1fql1gx/F+lmlGaslHe8h/HFyf/ACpSSEDH5RqoBVEZZ73kKBTe8emHKImGlvvkPVp5pmR5JyB62fz6KDjF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385922; c=relaxed/simple;
	bh=AGfQ1vH4ziuzqG5ajV83OU6e/9coaYTCg7Z/7ojNInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sogaxjzpf63EA6t1Cq1QcwGQ1GoFyGKyuTGRB8CNC70M7+YGNUBJQp0IUU3EiIUoHo10K9miAoHaIdKmQpUVMtRZ1gtOIzca+tbEUEYL6gZ8BvQZNIeAnm/e0cHKdnmAud1JLuLFB4dQdAtQK22WIWytH+Pk0rIZqVlTsvZ412w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=bYxcPUO5; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385915; x=1713990715; i=parker@finest.io;
	bh=Z9AbLZEBOkDvrJrfG/E6jqiIitDCq87/g7vX9tqZDiw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bYxcPUO5Qp4D4rvd8088kE87aI/lPlK76dq9VEFD6NyqQsfOVXRS/gcKFVIvjOFs
	 T2/pU+iZ5o1zKYqnZqv+RCDj3r/6uGfLewgiDK66+T/H+qqV36Y6p6Yv4YECv7EHF
	 5l+dtxslN+qPPQH0f6CHm7pE84JjIufZWndQJPmybfe8RqSFhEkXfbPH10bxjZ4nK
	 XBm6m/fjnOAw6wx+PgENOTmAtmco9jOMF2qBWaRUii5mw8lXoTIFuyJ54jJ3t9wsA
	 mYB6I2/bpGKAjb8Y5F5AAHcPFIQQ/k3gKcu6Ub9leHgbQRcAaHEChri7z7isTI8Fu
	 UT8PHUcn4s556ikHxQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MxE9c-1sumjz0sSu-00xdro; Wed, 17 Apr
 2024 22:31:55 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 4/7] serial: exar: moved generic_rs485 further up in 8250_exar.c
Date: Wed, 17 Apr 2024 16:31:26 -0400
Message-ID: <a7bf2a42de759908c058246ec15f60bde9a5dc65.1713382717.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713382717.git.pnewman@connecttech.com>
References: <cover.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+hpOLbZKCVK1NoaArMhv+73t32rBcfbUsYZPyRUPiiIU0hqKy83
 q076np94c4pmFMV4vh+U7HZ8W1WiNTnQj+F+Z1923DNH4QOtgp29V3WLT0I95rMkHLtfv30
 9yr0DkzEJkosiQ8kJU0vUlAGD1xP6IjOHKz0B3RPahuryIxNMRcuyepJqEeUCECGg/xyaiH
 nmEFvAWCQo7lxDDheAb9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mx0TjLfV/CQ=;vIIrygbyWdnlaJ/s4Jea8H0fTKU
 D7oKZEIK/ztumR/B/4iuMy7z6AyB3olY8J2SwyAl0vmaB3kWdh7bKbR7V2tcjWzvJyn09VAfQ
 e794Wl5u6tXEPYjWE9SxbJF/oXRseeFKGSSNIByZtsC4wMJytPrANgIYNOuDDPJPtVrdp1BLv
 REO7XYvEVgHoIgA+B9SfZjuOScCPSyw6FmiM1C6hFaLPs+idfQpN5JxkmQughzNi5P1J29QIr
 z+R6N6IrsV4qJushuIx0OO61iIlCuFRwxCh4jiiCMHT9MX+v3CvGewB9x2mWl5QHwVwYkp/26
 em9EBl//JMs2pBMFzDQCbguVbt8gTsL4zpNZL3JVbrsVvxMDXN+GSu0ujIrFXEz/RVeivYiEc
 ZsKCaefTFLVS+8QrX0TNTNWP9wNL4v42DTiRy2Ep0+j4GoooxbJJZZ5tGoVY3DQfSAPlRZvxg
 +RJ8cXG4sB/X8Y+EXFV1K6G2ubn6pfTyKfIyMJfclo3llyN3QOb2+QRATsmB8mrQPszubMRQm
 mq+r56zqOE02UTC9Vc7Hbj11BN9s4DgKzANW2b1Qcr47fgdStRMlSu/3ZTu02V8M3ZLpLlyeE
 2zeflT0ruzarQKCeQ+2Br78GB4mizdAAcjJ1bC0ediK3WsMZetqgNorU5EfokGOKw3iC9YmPL
 m6ZzR53Lw5K3vYaW93IcrlzWGekYpaJwNSR667CUBGiv/Ta2OkaEx/QXr5isBD0hWK8BQtpkI
 gr1y39CSlQ3webvt5BQFd3NfpBjef4xImIbu4GtX9l430GnUBY3aYc=

From: Parker Newman <pnewman@connecttech.com>

Preparatory patch moving generic_rs485_config and
generic_rs485_supported higher in the file to allow for CTI setup
functions to use them.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
 - split into separate preparatory patch

 drivers/tty/serial/8250/8250_exar.c | 50 ++++++++++++++---------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index f14f73d250bb..e68029a59122 100644
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
@@ -459,27 +484,6 @@ static void xr17v35x_unregister_gpio(struct uart_8250=
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
@@ -518,10 +522,6 @@ static int sealevel_rs485_config(struct uart_port *po=
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


