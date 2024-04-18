Return-Path: <linux-kernel+bounces-150403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7D8A9E98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8AE1C22116
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5C16E89D;
	Thu, 18 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="NnQEteed"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FA16C453;
	Thu, 18 Apr 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454645; cv=none; b=V4RmFJuHJWCBY7tdW0PjAc24ZmwCuMl6UQ9IGRZLm9fwGuis31V7twgxZSg3pkcdMMvkwgfWE5fTAQHILGnajrcqrrmA/GauUH1Ocs0vVRu9drSTm9GNdfcDMuQOfcZ4Hr7E/AE+fSyZRT/ybYhmvF1oQ0Bwn3VY5loMrNQqVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454645; c=relaxed/simple;
	bh=6FcMwAVQ1oQ13VSGE3/gSNaKF921zwjZHklsSqpjmWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV4RpglWXOW/P0qQZ7mgWedKsxDy77TsoJj1PSIIw/JJuVTSckgK6aO38LC3a/7nzv2WDrK7tst9H8tquV885bTIsHJLT7HhTPgvlpoD1XXbxtINDbLN684Qjm2nPUwsiAYqMx7dMW/I9kbFY+0+7qPcIuwlYXUtzAyobUK5LTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=NnQEteed; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713454633; x=1714059433; i=parker@finest.io;
	bh=91znGsyHENCtexZoIjuZ12Bug2BwW+jFHp+nXCy9hyc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NnQEteedl2hKmnSz3UYcDsE5k/E07G585K6/SqcIc8jbV2HjynREsfJNoze5byqL
	 ObsiZWDnq3HJfb499Hi5HoIAcKTNLw8hxmCdSYt+n6BpfAklhz15NDBmSDzTlgKUD
	 HVu9IsMjqqXtBxjGAejN89ox2+53Zhfak5W3yf8tb69vxpUwGehZyfsQSaSkI48Mm
	 SN+VG7qsBccIfu+UpG2sF2UWjk5rDC3tOZ7oufhCuptdLXzPcwHKqLtddxdH+k1Gu
	 ayk1n6vD20iUmd0HGR1HkItZXS1oYVI/uuDowWdnSKkEYZwou93/uErGt3r63/0mR
	 YjX4uBL4RUxu9xrrrg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LoWNw-1sdwBO3kOg-00ow5j; Thu, 18 Apr
 2024 17:37:12 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 2/4] serial: exar: use return dev_err_probe instead of returning error code
Date: Thu, 18 Apr 2024 11:36:29 -0400
Message-ID: <69dce254723c80f69d4deef8512323a38aeeb7d1.1713452766.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:OoBam/oCzCOWDp5lY5iLVRbMrH/n35wBO3b0Jd7iTs6B+2WesgK
 xU1Z19cRezihSxiEIByqixoh5j199KAuBRQJcmt9JqV3vM6tjZcpePwevO3KMQfooiRaZmo
 Who3DLSRjsq0lp10ffCM+pAXI6yI2JnYfzBZ97pxC7PbVryL1LOILERMuJR7cp20a4M8J/0
 FZqV14wfgyEc2CE3Pd8kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AJoWJ7re4O0=;Ym4TddEyOePSxmlkoPMl3fc/KCL
 vvwZk7uSSM52cZp1Q+HK1xv3gh35/qA2y17pinMZ4V448Ljic10Idg0MzgKrrmuilAIHYZDmR
 00Kuh7bsL+uXjebFN/nY1VUR0xZ18EkQM/EMvmR1RrBuu+pcdAU18OeF9A4/OKto8ElzIp1+o
 FfXUumtws1BpSkWZ4ZVVHvf9l2xfxuNWXOaydtjVuzZc0gFDljHuprchLTs2H59uqD9wGePyg
 A6701EMDd914ica0W1bGDIV+Ifsd2S6mrPzIyFuRGl8uTlZxInewfQbFuM/s7eRCFnXG7SN/i
 q5z8DFJsgLHN9e9m4t45agZgk5l51LgaZQBd2fCdNxGbYQb722JH5EqGWb1nWue2M/h1aqE/c
 V7JhY9phe4oEGPVV5/3xE3luEDTq7yY6DxZxfuLK7yvwjQ/tidqJJsLlMf+/rOWl3F8zwbg53
 mhjNSUVboTUh3UeeI4Ya/L7mUJsm4Nmrq60gk6aRLInkpDqIfCIWNs2uPY8OIVpMsyAZMcuRp
 kmEBI6ZXCzZ71MBKoENPxKth448r86UNBqKoOgLTyOCrZHENa4K1NPQ6rahav+iCIMlScEmDC
 o3reyF6NIK3xBWKRaHWSNjIJrsBdomhDAT9QfA0snpMUzAyvFO+hA4u4zLaVW5VwL61CDes/o
 CO+7KIohshlnw/pJLd/B7OcshAYI9fvPrVAD5g6N/lVmh4hsSHnNt64zP+I13gstcbh9RRP80
 46nryXfvP+IwNwELMz7l4RpWJNESt4Ig0FZH9Mozns+7+8cZIJcPeQ=

From: Parker Newman <pnewman@connecttech.com>

Change to returning dev_err_probe() instead of returning the error code
after calling dev_err_probe().

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index a180741da634..01748ddbf729 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1551,9 +1551,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)

 	nr_ports =3D exar_get_nr_ports(board, pcidev);
 	if (nr_ports =3D=3D 0) {
-		dev_err_probe(&pcidev->dev, -ENODEV,
+		return dev_err_probe(&pcidev->dev, -ENODEV,
 				"failed to get number of ports\n");
-		return -ENODEV;
 	}

 	priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), G=
FP_KERNEL);
@@ -1587,9 +1586,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)
 	if (board->board_init) {
 		rc =3D board->board_init(priv, pcidev);
 		if (rc) {
-			dev_err_probe(&pcidev->dev, rc,
+			return dev_err_probe(&pcidev->dev, rc,
 					"failed to init serial board\n");
-			return rc;
 		}
 	}

=2D-
2.43.2


