Return-Path: <linux-kernel+bounces-146834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094AD8A6B94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADEB1C21CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11A12C49A;
	Tue, 16 Apr 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="nOxbeoRm"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77628E6;
	Tue, 16 Apr 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272216; cv=none; b=Gitk+3BrnqYkjjcG4MNaJl9Ey20E7UbErwvlxg2/7kbvLvAZ0AqxhlrO2TuBpcZCVBl0OBKGHVcKf58WCwEaQUt+ymkvlE/tY4f5DWDxt5As9NtxAdmv+71rLSnT1Tl0QS22geLWlrzBFa7Bu24BYL6yRnyb1XLbYCkTsv/G11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272216; c=relaxed/simple;
	bh=p0pbcjOGrW9R0+xZei0K9xOJ4ALbve9BFZcsgFbKluk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae0poVs9sM5Xo7eYAS2haEpyIO6HPO6Cdz0eX0OLzkvK63V2ZK2h6ROywqy6bRhFdR+/Bk0oly98lAVao7yZQI84ZaCgLo8Xols3inKK4ftVwx+m79yMfozswUYVyB9VWATv9syu3qerVrch82d0tO08Kpz7S79MplC4E6g3VjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=nOxbeoRm; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272196; x=1713876996; i=parker@finest.io;
	bh=IIhBmpy4z0+P4cIvEA/H163fhCoG79SjvbrHTTat3eE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nOxbeoRmjImYJx18ovcJd9LmW8W7QjtH7lNq1KvBzQJPfEhnQJ4YwnFf7ab3hdcC
	 xwk8tTg8ctqG9ySZm9Q916CVCz15Guyu8X0i19LGf/wnIhCNCbBwXLRRgD4LEiMjO
	 YL54fSJdirtkv5RqPZxsTBQJkeA4NAKuFWBvnr7IwNR97EPmXBOww1jtNg6mzM27i
	 JHNIBgF2jhH4j3InIKHoQghAKknacahZE2vP95tNE8dMYgOxN/+oknfRSmqW9a8oP
	 NwjkxbSG99N6bDMQSm0Z/dRqMUrpIQ9FeAco5+7sa5ZfQTl54M6FHPUCotw+Z+b+D
	 soa1X1leyzOs4Qe5nA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M87rr-1sjR8X1Up7-015JhU; Tue, 16 Apr
 2024 14:56:36 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 2/8] serial: exar: remove old Connect Tech setup
Date: Tue, 16 Apr 2024 08:55:29 -0400
Message-ID: <e85dc81f8cecfb8dc416fd845089f7f2ba3338ba.1713270624.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:tUm/cSDLboyH1ISWswfOkWKv27rJSe9V8B/rZvcDNSuobuuQYpd
 lvvyW3yEbQRVS7uA2VfbI1RR4cQ+WF4G3p4THBjga0M9GlaeKZk90iqlT4N2f6EZnVoRbDk
 minojfnFEP8flDehuE/1Gvm1Oz+r+A5G7XgoD9YGPrESP989cLZdPVLquhEYYGplc0+fS/0
 m39kdFlVtbotjlx6nuX6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:obspGj4EhAw=;JJTplzmRPYtAgS6qB35fBIkvE//
 BeTnDT8OFK8HkAKi6Xs6BUdWEbOdKyWq1kk7jykPmoDP/RK3BRnme4qKLD8CdKkczYAy1baux
 8NX+vbZAtaXqQVahvntl3VuBfLcgRCYg3UBVgXyKChlYBVQFBEugpj2Gb8aGVgoR1cmY2AKsG
 jviVEJjlwM2ZJ/kAPwU6QLwppG4A75B0IPexF+DZzonk0ZrfUi0hSsa+9h/odJo8Q225qiiqQ
 nEoZnOmLRsooeOnUko/ErZ5ahgVhzsQtREGm75zkxX6ZAM3VEjSRhb9sr6hG0QePhktWVzo2/
 we2Y2rE2trC1u/BsX68spkDAlgUZGUlTqmQM7StQhLnoPxFU9ouQMEjT2DLFlidIP2LCtsAUP
 9aad47PU6m0yGl9f7L7ZA4IlcPDzbd6UQkjtK/m+Go0xj/OV8eEqmnWnSaEqit7gnlfg13cx5
 J4xZyDb5n4sPJDvDUve9hiWej/uIhNl+Ze21baK2/bh84PFXH3g/TsidlXssSNZz8jFMoqEpu
 HFKioHHmNIQwoe4SqcVGJDT53LNdaSnGIPwWf1o30cEfmRz0d1aeFz36oATqsWrL0Pyo1snIK
 h7w/wfyGZQmDKsdelNA8wCMzBiN+evBPYNgDA7DRijenOvm96HSSdIWEYdfISF0lJUOt5Klp6
 3DTS5XPoraUTfJsJlvAhbrnN5RgDXX0RvP79fBmIPfy7mqS9lm9e1MHINJZ/g+Ifu0D/eeACL
 nDIi0pYXsKQ1O+ZhaQKDEm+OsIeW6Gyf0CRB7b2NKUyC5BL/o+qGc4=

From: Parker Newman <pnewman@connecttech.com>

Preparatory patch removing existing Connect Tech setup code and
CONNECT_DEVICE macro.

Changes in v3:
- Split code removals to own patch

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 37 -----------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 4d1e07343d0b..3565b880f512 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -357,17 +357,6 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pc=
i_dev *pcidev,
 	return 0;
 }

-static int
-pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
-		       struct uart_8250_port *port, int idx)
-{
-	unsigned int offset =3D idx * 0x200;
-	unsigned int baud =3D 1843200;
-
-	port->port.uartclk =3D baud * 16;
-	return default_setup(priv, pcidev, idx, offset, port);
-}
-
 static int
 pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
@@ -848,10 +837,6 @@ static const struct exar8250_board pbn_fastcom335_8 =
=3D {
 	.setup		=3D pci_fastcom335_setup,
 };

-static const struct exar8250_board pbn_connect =3D {
-	.setup		=3D pci_connect_tech_setup,
-};
-
 static const struct exar8250_board pbn_exar_ibm_saturn =3D {
 	.num_ports	=3D 1,
 	.setup		=3D pci_xr17c154_setup,
@@ -896,15 +881,6 @@ static const struct exar8250_board pbn_exar_XR17V8358=
 =3D {
 	.exit		=3D pci_xr17v35x_exit,
 };

-#define CONNECT_DEVICE(devid, sdevid, bd) {				\
-	PCI_DEVICE_SUB(							\
-		PCI_VENDOR_ID_EXAR,					\
-		PCI_DEVICE_ID_EXAR_##devid,				\
-		PCI_SUBVENDOR_ID_CONNECT_TECH,				\
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid), 0, 0,	\
-		(kernel_ulong_t)&bd					\
-	}
-
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) =
}

 #define IBM_DEVICE(devid, sdevid, bd) {			\
@@ -934,19 +910,6 @@ static const struct pci_device_id exar_pci_tbl[] =3D =
{
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
-
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),

 	/* USRobotics USR298x-OEM PCI Modems */
=2D-
2.43.2


