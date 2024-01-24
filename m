Return-Path: <linux-kernel+bounces-37755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F283B4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C352288B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10313BEAC;
	Wed, 24 Jan 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="X8MZ59Fa"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35410137C25;
	Wed, 24 Jan 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135601; cv=none; b=KWZINK5jcJmhG1KcHFgmQK5NJArzrL/gQeLJw3ZvLAKVSxjJqhFPv0oeTPqN/ta3A09pDx1meI8YcyQvSUthp1wrAG3stn6aLI6ODxCZBWRyrRLvYubv/QeBYlNo4H7dtr30g3mxzRE72KfUag+0n8ewvZV+wQoKv+Zw+E08+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135601; c=relaxed/simple;
	bh=k46vRpXLmQ05TSStQTxL2RYgiONz7SsdmJja7gLHbZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6UmxBEG5NUk5Ft0BjUqzjWHoyiBwt4ovup94lmX88Ti7COLlFt219gUKSNU3/7TGKPLbP1nvUy3XeIgzdAX77u7RGnKAaJ0R4JstFhuryq/nZVNttQMkYrVQvcHQ6ZY9a2Xt7gOpJYfcMjuuIF5lnaguAPoHVoxjKbQ4/LeN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=X8MZ59Fa; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135561; x=1706740361; i=wahrenst@gmx.net;
	bh=k46vRpXLmQ05TSStQTxL2RYgiONz7SsdmJja7gLHbZI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=X8MZ59Faskn5zwSgJ4RtSebhqtXQS2S77BE98/tKPG0AIbacw4j86O48LCNPxE0d
	 E9d/VEE9F1SckTZPw8mNSMMJk3IQiiRzkQwAFHDqmx2nYlT4CZ2K5rd9v+i1AEfb2
	 w0MwKmYkqzXw9Rx2xt5eZAejhzVFcomRGztOD3rh059xp+Houa+P2I9diecV5wVAs
	 FeDXFbDcN+z/SmOOj7XjbJIPBQDtWznL9RwBnXccMVjtR0RDs7C7/1eUuyOmvBjAa
	 PH6amBrXnpVw1E4XrwSMqS1NiVcM0mhpkYo+EX81FaMTiwrEPQtSdQpHX6JtA7B1h
	 q3B91IH2RNlKJMVBZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1rL6pp0pDo-009uJ6; Wed, 24
 Jan 2024 23:32:41 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V3 09/14 next] qca_spi: Log expected signature in error case
Date: Wed, 24 Jan 2024 23:32:06 +0100
Message-Id: <20240124223211.4687-10-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124223211.4687-1-wahrenst@gmx.net>
References: <20240124223211.4687-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dLdi0zahvxkgjsOoYMSSrmqPRETKk4DjTwif4r/ZSXb0u0dQBlS
 F6wY4N0xMyiwVx3G/OTTEsoGdIWcXpMaMP0OtLKPmqjAWXkykedj71s7SqFleMG9AoD9fHp
 zqZpQzGAa6rqOtkeLGy4ut7Vsz3iG3eaEDMdlDa7f1cTgGuiU3i+qbbLn38v2iwjv00BT+A
 IP+gckdJkiy4EOZ9S3SWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:njsc23fLaME=;k/DZ59u1mWpIhnxuR4KdZft2Xds
 ghqXGQ6gHi8/C94swPgvN3kx5tSMOpOsVt1BX2lbRa0YrSQTyjTNusmuAR6tOSdWpwaviN4dF
 CdoKTr44H2y9hevuJhVyoc0etyPOtJZxBKj61crvuuHmfdTXhHlsIfUzygzcLE/YY3ODKfdu5
 U8CnNGS7ShP+uSiZ1HBtL0cpGtYuSXuwywdnsvs5aMby4/ztQ//azFxbXcmtlphn+zMaNTPkE
 7OxPx487wd1TXoCTNij1Wj6bzOs5vP64RWHbQjzwc96EsM7E4qopzmgO4taH+LWqVFx0ffmvC
 kF0rHQHhXWh7ppdRUZHPGPRtX3I5XjJMZ3eYSXWN4T+LxQgkxyW/sn5eMOjlfCsL+Ghlg1K2H
 1DQOlM/FomaswwhxcDuwi981hFDuMErm9ZZq2XR4gmzFUhDqdOkVgmBTKIYmCbbgSN1C3TUgk
 17iSoYsnXic4bogKQoTkxQz0YY6tJM18uVDYwmPXTD/eE/a8H6kX8HIAUgYxxUCECW7MAvvKq
 qdYF1TLxH0xwaX2VH5NSVGvpikXDr0h+aMXqTW0x8ZMxoEjDbFkEDqpfGjGGzc+/NZw8W9u0F
 O2rEfnD5aRkV1Fu4m7/7qYLTKSxzeHRYCHoVq2EF8IFD7MArrrVieMr2jd97zFJUEmWhpiDIr
 EYnor44Z3CNZTs0QUEen0wWSLwoXFy50TkLw5rIteGqOTaXrRlNMBY8QK1hPQdC4kmQOHK2ln
 AgtJ9AI/Bt2Pgw5wGUE0c0pqJxOrAgsOAjJAf0KFn/+bBcLYPAaummvLxjQKEBS6G5BjHTY30
 s7j0rS/bEZcTCMYTOKqgQNoRZO8NyAJz/ns6oo6CeIYhmZrnERkWOCeLyrrhC+wXJ8CCxGHut
 jMRAnPiZuhnDbn0U4rFXgR4PFYInIrfsx2fm1Xn5k4XrICJtT7URedge88XsqyPxqA18XbRKn
 0Bc4FQ==

Most of the users doesn't know the expected signature of the QCA700x.
So provide it within the error message. Btw use lowercase for hex as
in the rest of the driver.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 6d2859aad921..c5d240fe4146 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1005,8 +1005,8 @@ qca_spi_probe(struct spi_device *spi)
 		qcaspi_read_register(qca, SPI_REG_SIGNATURE, &signature);

 		if (signature !=3D QCASPI_GOOD_SIGNATURE) {
-			dev_err(&spi->dev, "Invalid signature (0x%04X)\n",
-				signature);
+			dev_err(&spi->dev, "Invalid signature (expected 0x%04x, read 0x%04x)\n=
",
+				QCASPI_GOOD_SIGNATURE, signature);
 			free_netdev(qcaspi_devs);
 			return -EFAULT;
 		}
=2D-
2.34.1


