Return-Path: <linux-kernel+bounces-146831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6328A6B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE051C21868
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01E12BF24;
	Tue, 16 Apr 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="pq0JdfAd"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF712BE8C;
	Tue, 16 Apr 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272215; cv=none; b=Gw/zlyq4EfdnFFEEOqSwW9sMjItTHXtqFS1RWr1MSG3TWe0qg3Rwko84gOAGnXHhup1Niizf+dlog2ijqvnhTdWp87Xop7Rod0sZ1SjfKGi7P6nflsG3N4W5yg3P5ldEvnwWwD0yrkDuj+j3cF717fG6OQtK3tfNdfbnlznoV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272215; c=relaxed/simple;
	bh=NQhqySD6CGl5aYpely4K4CDmCz7g+Tp64db5QcIZwkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSCAM/NeKEbAuSC2FCnBdeD5Hj+kJSYW+gjTw8WLJqLQqtGszVsh6Q58NzfQQJjXuU1E3MIBlf69yzjqjuMXNZM9hb7IYNs7TzUW5IgkOFoUNHRl/maJI64kPDhtBwQpHNe+7YxcwrrPkCcMKqpfEk9zEOolWgPZ7Shm6NUMi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=pq0JdfAd; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272197; x=1713876997; i=parker@finest.io;
	bh=Jg2iUTNZaxVM82ZeLG5nTJdBzN9Va8k9uedQo1Tu3c0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pq0JdfAdfAXKRDyi2Xb5zwWcsZeQBHzdyO59T2wgOoZphary/IuoRO1NV4KqhiXC
	 pd79AzNT03/jAP/qpKFXxLCzMo2vfX2TspJAboGyn9rnMhF1kiOGfpjY1135x3ay9
	 IXfGieliU5A4c47zh426fDB9zXZIe85r2gfu2MXWVkFR3VO0JgPXICvtCLlss2FGM
	 S4V0wcVp397xPlsxcUn46499F/VXMgFl7vywHjYoyP9w2oROOqOCQG4n2Mc4eYOGl
	 xxqEBtotCHzxZBiplWjpXy83ujp55pkJPq4L5XjQMGb0ZfyC0Q5lkETydi3iM2Z8F
	 QUeyxf043RRarLe4rw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LoWNw-1sOtRv2QTy-00qfGJ; Tue, 16 Apr
 2024 14:56:37 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 6/8] serial: exar: add CTI cards to exar_get_nr_ports
Date: Tue, 16 Apr 2024 08:55:33 -0400
Message-ID: <4045adb4efcd58805337c66b2e9a37c3fbb8a1e4.1713270624.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:ihE7blmgy2JmCjhCCpsYoBPhluDQ00QwZs2aBO0f/JtL6fwU4op
 L0ZBbWi2LYOclN9ethy7ylQu2+bsEtRvAzePDCGTdCW5CQyW60cOL6sFZ8QyC0WgwdXVjEr
 xaAwl+ncg+K/rq5zh4jF0nw3Le06f+LIE1ZQGkDOo8Ug8CE8p51J0niL/NLf0Tj31V8nM7F
 39XXgiLG6KsJ/xUCi8IPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4aGe6+SarkE=;OQcrbcjZyb3Y7WWdMF3fwcK6slb
 ZrET/fO36iOnVfJRG883oUNZlyIBWra8tnLyRVNDUuHOJYP1bPaWwAmmDtZWI/jYZqhpA190w
 hj9/6PeeQXcW93wUzBIXMzFIBica6yI0Yr4IBwCFfqVDB4qSX1Kzm2f1Ama5BIqoI6fSYRQKa
 XwprR9r3zt2WEBFrMbFKhLZldfZbETVPFqUIRrnbxBl5+6R53AiyHIve895KzXOuOlCoP9r94
 SuCUvzVhfIV5CJATxwwXbZaz8PhU/KcwSp1CR9WUjnTFGKlhI5IJsf8qEuvFvPyZJ/71eKIDH
 Y6vH9q4jXYEH4Lp17569me08LFC75ONHwHySrOtKxy2p/yWPBp/9HrdthFPu4Kby4p2kGpp7r
 qeZ8m+141mi9fAF5xA8BnxUCONex5kb+16cqu8QkbA9UAJ//b4dAKaRgftiGk8jZTLoIlVS42
 qZMdU2LudwzeaV8pFDpPuA1x16QMtC69lLFF/VCM1U9SIZ9z/Vc0k+6F6CRi+ynJtRlB16aQr
 Bg/4F2AxvS1fP4hpBnQVw5XVLedvdjOrsOvm4LzZ6ttqLGuxE+DdjBSDNwIIQjJ1BmpaGda4U
 5v7wV7MyF+0ZbchWGjcI03yhwC9EB4aUkFfuEcHzVAw8iXg9lmmJWCmdFOJ70whgPBVdbdbzH
 hJXyI54NO2LYsG73ElJPmOfskiv6NqnHp/QQ4sABJ6M7yIuU6NbO644iRQtu5zckB+4buoptO
 nQzF2sOo2fdP4gr2Mi5EG8540/3C5O2k0mzupb+/5OPBoPIguwFJPM=

From: Parker Newman <pnewman@connecttech.com>

Add code for getting number of ports of CTI cards to exar_get_nr_ports()

Changes in v3:
- moved to separate patch
- added spaces to single line comments

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 7e47a4145c7b..ada01c6394a3 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -710,12 +710,28 @@ static unsigned int exar_get_nr_ports(struct exar825=
0_board *board,
 {
 	unsigned int nr_ports =3D 0;

-	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
+	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO) {
 		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
-	else if (board->num_ports)
+	} else if (board->num_ports > 0) {
+		// Check if board struct overrides number of ports
 		nr_ports =3D board->num_ports;
-	else
+	} else if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
+		// Exar encodes # ports in last nibble of PCI Device ID ex. 0358
 		nr_ports =3D pcidev->device & 0x0f;
+	} else  if (pcidev->vendor =3D=3D PCI_VENDOR_ID_CONNECT_TECH) {
+		// Handle CTI FPGA cards
+		switch (pcidev->device) {
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+			nr_ports =3D 12;
+			break;
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+			nr_ports =3D 16;
+			break;
+		default:
+			break;
+		}
+	}

 	return nr_ports;
 }
=2D-
2.43.2


