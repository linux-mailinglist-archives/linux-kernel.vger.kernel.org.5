Return-Path: <linux-kernel+bounces-141574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B28A2032
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B2528D974
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B03D977;
	Thu, 11 Apr 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="ix8tw4bK"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DA18030;
	Thu, 11 Apr 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867167; cv=none; b=T/HENZC5bmKA+GU055elSgMUypfbVmFVYc0pgpbfW8rK6C6MJHSPohsVbbq5UPTN3++uM72IJr6QqYQJL+ErX2qoRA6F8XkcEc2+6BwfEN/eKUX5gSmGNFAN46XgLq8FaWJ/ey9WSFx0p6ca9HXwvDHGw6N47e0K3J8xMdUMKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867167; c=relaxed/simple;
	bh=OyiwdrslugF9xn2I0IrJDXL7cDDj3UpTmiAZkhP4QoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9Eh0kDJPr5fewNFqic7Za3eGfoJbOyHL5S1AKfyEmerJH4B8CyK9LelIcZ7zCSXfEuZ2kVcjRkcAU8SZ23Rk+UrTfuxPs2vhY+vLpTX52fGFZ7SvoBiw5hvZaBOvxc+TkcnDcPZnnNGOmax60K6QLPHG0eCfvtPmmmJMzvOfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=ix8tw4bK; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867159; x=1713471959; i=parker@finest.io;
	bh=vaELCzZnSbZPiv+n/DYJ9hiAKVejhtPPQdvjQgpLFGM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ix8tw4bKi/WKkO7/oGnNp19593x3C8aBKaf4+ueWgCm1jgBHZlc0Rx1cYDMx7zEO
	 K0C+A3ydGzuhCpB4DoejnwLY6vzvfBiVXzLt7MTWq6uZfj2k8Xm7j4QTOXWUWx0WN
	 zG2Mxy3A7gX0KI36QzSmHQFAK4essD6SERYwOAyHMZwT0PET1Srj7fvzwKFAgxnR2
	 pzTCZu4NPsAHpz1tsNLalG0q0UND6Ul/dOC3plgbn5Gc1T2cL5NE2VIlhIeGp5aoA
	 f44XBiQJsF0NRQfOM2V2MlpsUurM/8kawdeXgSSSVzHvRBwwSu8VqBzPEwnM4xnC7
	 5mnzWar1BZqx8kMFtw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MXriD-1sIuhc0Yzf-00Mdkl; Thu, 11 Apr
 2024 22:25:59 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 7/7] serial: exar: fix: fix crash during shutdown if setup fails
Date: Thu, 11 Apr 2024 16:25:45 -0400
Message-ID: <9af149b983592a7b8763132c64ca269909b4b8d3.1712863999.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:s1qZqYeeCh/p55n0hx6/aal+F/Q4pAG+Wd3llXFjndMKaBsI6W7
 Qhes136f0gHDTPSamEW9VgEwV9Vk5kGq06drYjuPtHmKimt3LZUTWWI7zQML2URCGJwZn86
 07PD0QSb4ddP/TlJqqvQi//4ZMuXgfY5AujJSMzuX+JBv3zbNTtETBflaPr39v4FoxBfIyX
 tWJ9KBqy3yimxtK6dHmgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kyFkFkRSoq0=;eeDmdpPDU1OJ7YPEsz61CCfLQFe
 zwVOh3DvjJoO6wJkHveiEkrZg+D/CF/Df2JKSIeMZh3TOmADpzfSp+HpQxX2YqmIzL0/KUCM/
 qewwFjewvrHNcVmDBrLL1kXKcb0WWkHNWoj5SN6foAFfN/WagtWS3743O/4u8XcAUsrCOQAjg
 Lhz5I9cIj6fPHi0i2Z/TICA9ifKDH4UHBM2Y+X2GsfkD4H4daY3346NAC6xkBqmeU4MtXnsXs
 3LU/ORoCgBkgjVYnn5KaDbDToeN7j8UJ3D6QRJXRBIMyiH1WUvZWedTBTzLXARwyKCrPCYc/9
 vIyT8XCPtyEKNc9qJqbx5Nw23WUbIE8RCaS2TC3dYH9h4o50O5JINfTiGro4Q0R3vb3bdA2nY
 8d0BjrSWYaR1z0fn8vcAXHtDIkdPUGTEdZC/9zEuiOQ0z+o8qV67G4vf/bB53JwXtcWUC7Inq
 J+dZJ1fwmif0UJul3v1LkK8oTu1oFjYp91IbKfI/RIZQ7r6gihYeuH6wJ+n8y0FG3OZkUTARN
 6mNaj8F6KO+YOVPyEPIlSU0Xuilwx5dznAcAEEuc0xwcxL8wUju3hwKS6AY7JDDq3/KOg2d8Y
 sObNF4plZQjOIV3lvLRaZ9bR3ZmjpUP1HOrCi4Axwiv25qtGxaVh9um7f+mc7iuZxfN04kaHo
 esJYhcpI4fVxDaTLIvJbvjsiJdQ/6xZjrEqP+14ckltGm8Huuq420VEoSs6B1xQgx6m0q4xSa
 hX6Mud+2fBLwxtVQkmJZDKbdm8IHXifHdwtYOcR9uz8rEfsu0QR6dU=

From: Parker Newman <pnewman@connecttech.com>

If a port fails to register with serial8250_register_8250_port the
kernel can crash when shutting down or module removal.

This is because "priv->line[i]" will be set to a negative error code
andin the exar_pci_remove function serial8250_unregister_port is called
without checking if the "priv->line[i]" value is valid.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index d8425113a9f1..1c6343ed76e9 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1675,7 +1675,8 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	unsigned int i;

 	for (i =3D 0; i < priv->nr; i++)
-		serial8250_unregister_port(priv->line[i]);
+		if (priv->line[i] >=3D 0)
+			serial8250_unregister_port(priv->line[i]);

 	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
=2D-
2.43.2


