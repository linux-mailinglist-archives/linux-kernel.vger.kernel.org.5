Return-Path: <linux-kernel+bounces-150405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA58A9E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA48E1F219AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20916F8F6;
	Thu, 18 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="jhPHWx7m"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91216D4C8;
	Thu, 18 Apr 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454646; cv=none; b=qVn8JhLrRIoOWDIeC3gOawUY6uN06MalM8B0GB218zooe4jboTF4xNZgDPL2YXXG9R0eZ/4f92ibp0C2bQd7bCMdC7asgRLk3i+6Z2Kw7Apxw2CTXUIdt/N7nQPDG7zCtBQAX5AToGHD95hiTlJnOiwwb7tVLf5tlrQMnmUNhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454646; c=relaxed/simple;
	bh=1hWgt+DDvdbCIJN5SNmYKxsnzYxa5HptIF5iVF4grog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbD6Lsu03mW9Yz20HlCzekNGMw+nT3Lc6AZUs6X1L6pRpY0+BL+aoweY1azssH6A9aDxe+QBbEctvCjaD07cksYIb+K2PQs6Qd5L1NBTviflw5SJt1DCqgEPHWSrFY4wLQ/X5BVcH/VYMvBHYPB+s95Pf4VERsUNc5QI8uDq/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=jhPHWx7m; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713454633; x=1714059433; i=parker@finest.io;
	bh=VlwHH/iE5BKx32sm64UdmIJpAec9xlGVHnH28Qxf16I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jhPHWx7moDfvuucdBuRCTPfL+zexxKhgFg+vXQgcjiOAUQVwihGERqLWaaXsGs3X
	 h735TdjEMYTygcpt7szMVGtFREqirKM9O2cL0dBIcGDNgm5j6ifXZUwSLWlaIdL0t
	 IhSJ9XPKZZhmXpUkqVrcyvdlCfMYPp2wE1aERAklURc9+KqjB3WR0yyxyttkKKvlS
	 HJ0e/vxC2zH/hqoMPDiU4G3Z1Fled1wH5Z3nE8YICwhh+rk1hsXgXp0P9qV0cFNAU
	 p4wOOTD0pK+qVcG1t3SSXek8Df9oitw8mQe3T0Q53p+P8SKCWOyNmlG1tSWnLiths
	 hx4vPyV2rqqAMF0dfQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M1DzC-1sqfuD0sf2-012jsX; Thu, 18 Apr
 2024 17:37:13 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 3/4] serial: exar: remove unneeded parenthesis
Date: Thu, 18 Apr 2024 11:36:30 -0400
Message-ID: <1dbe1847d92dd34d223c6dc6b5cd0731b78e98e5.1713452766.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713452766.git.pnewman@connecttech.com>
References: <cover.1713452766.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bQEu5KI4PU9uazHVFAhyTCDEJ1cPLFKE43t9UspK+M1wWQnWe2B
 LzfV4GxATnu372R0rlrJw02M3X9EhYb58v1nKwnePnuBENb3W7TayDDpI0k4prAEuiCemJ3
 If0Y5TsB5iojbiQuT9e3MP50HdhQ4DJV8/UUcNiH1iHuh6tdzsPtCHluBsGq2KREmJ98A4+
 t5H8Kei4tYnCFmPFVxSpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vtyhNxCu1RU=;Dfn7KD6YNLoSkqEspF9rKAzceAJ
 rDC23iZIjdJlTLU7qndrM6zfTMRUvhzWhHXUXzjC8viMrtcSUjLlEVMwy0FbUVDUB+wrrq8xN
 WaIWq+kqbdtC35FnAR5d0nzArrMkA9pjQjXy66Lfrp2me6rWiW5wJ/rdm4pqeSZSbxhmMxS6n
 UTZ63MVn78aoV+8COqFNEFClbcrxDcppbO1q6nUc/O0GZCqdJX+Z7OvUAKpiaRmyyg+VxiGcE
 /P/B2tswXQgETYGsM56QmyVwFUVLYQYSKWQTyn5b7UMuKuRD5eUkD4H4SRS0Zc+tE0WMyNRT1
 JX0ACxSdSiEmm4xiIvW9ESiT7r46RXjDljvyAKjtjPARneQS/03IEazVdrhHeWBcpu4jZ/oRo
 YeQOiQpJBfAT7m4Zlbj4FUoXBT/LqLmwpfk1965aLpcYmzVruXrJNcUMyFQzgP5uXkPZNXQ7u
 9RTGXHFNHlj16JNOyQz1BzGd6ENiPk5R6NXnhkn8H6y6oqKUpJqM6qVLBIZdMzUGFGaqj2LQn
 t77445dvWsbL7i60n1VqvZ6hkeEQuP0YfCxkhVncaBGcI2c28SuSYxAEDnjvKMkd7fscQegeq
 E3wv0qbA6/3LzZpJaG9apPRY2pD9/u2KX1MorhStVFYN2ubmIkbeSc6mXx37dacV3Wny4y4V4
 D48ikG5I4+X65/P0rj4tHcpMwqhfLSghIa0A+bMKDAGJkzaz+JfFhmMuc0U3uiDHJYSKmgoGt
 H0kGS7GoArdsobYRyc6T9HXw+q6PVkIIZPSoNjddA2JvWaof6/RsjQ=

From: Parker Newman <pnewman@connecttech.com>

Remove unneeded parenthesis from several locations.

Based on feedback from:
Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6be831=
61288@linux.intel.com

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 01748ddbf729..10725ad0f3ef 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -317,7 +317,7 @@ static inline u8 exar_ee_read_bit(struct exar8250 *pri=
v)

 	regb =3D exar_read_reg(priv, UART_EXAR_REGB);

-	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
+	return regb & UART_EXAR_REGB_EEDO ? 1 : 0;
 }

 /**
@@ -741,18 +741,18 @@ static enum cti_port_type cti_get_port_type_xr17c15x=
_xr17v25x(struct exar8250 *p
 		break;
 	// 1x RS232, 1x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
-		port_type =3D (port_num =3D=3D 0) ?
+		port_type =3D port_num =3D=3D 0 ?
 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 		break;
 	// 2x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
-		port_type =3D (port_num < 2) ?
+		port_type =3D port_num < 2 ?
 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 		break;
 	// 4x RS232, 4x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
-		port_type =3D (port_num < 4) ?
+		port_type =3D port_num < 4 ?
 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 		break;
 	// RS232/RS422/RS485 HW (jumper) selectable
@@ -789,12 +789,12 @@ static enum cti_port_type cti_get_port_type_xr17c15x=
_xr17v25x(struct exar8250 *p
 		break;
 	// 6x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
-		port_type =3D (port_num < 6) ?
+		port_type =3D port_num < 6 ?
 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 		break;
 	// 2x RS232, 6x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
-		port_type =3D (port_num < 2) ?
+		port_type =3D port_num < 2 ?
 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 		break;
 	default:
@@ -981,10 +981,10 @@ static int cti_port_setup_xr17v35x(struct exar8250 *=
priv,
 	if (ret)
 		return ret;

-	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
-	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
-	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
-	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);
+	exar_write_reg(priv, offset + UART_EXAR_8XMODE, 0x00);
+	exar_write_reg(priv, offset + UART_EXAR_FCTR, UART_FCTR_EXAR_TRGD);
+	exar_write_reg(priv, offset + UART_EXAR_TXTRG, 128);
+	exar_write_reg(priv, offset + UART_EXAR_RXTRG, 128);

 	return 0;
 }
@@ -1037,10 +1037,10 @@ static int cti_port_setup_xr17v25x(struct exar8250=
 *priv,
 	if (ret)
 		return ret;

-	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
-	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
-	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
-	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);
+	exar_write_reg(priv, offset + UART_EXAR_8XMODE, 0x00);
+	exar_write_reg(priv, offset + UART_EXAR_FCTR, UART_FCTR_EXAR_TRGD);
+	exar_write_reg(priv, offset + UART_EXAR_TXTRG, 32);
+	exar_write_reg(priv, offset + UART_EXAR_RXTRG, 32);

 	return 0;
 }
=2D-
2.43.2


