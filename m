Return-Path: <linux-kernel+bounces-4486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D8817E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88811F24AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606937CCF7;
	Mon, 18 Dec 2023 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="j5poxOSK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBE768E4;
	Mon, 18 Dec 2023 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942020; x=1703546820; i=wahrenst@gmx.net;
	bh=w4b5GD95/9d+6IhJ8/OG/JDuLp2gM7nWOD5+NDHeCCI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=j5poxOSKUe5Ycemi8UwL5vIXNvO+fPVhtaH+x+4wrViMgzyPQJ0PoZpjZCtearM6
	 eJS+tHgVsxD9PvMvtkZsGUOtREOibkJQmwlKDJWkVHb9BuhoA5gR5NPkrBc5wZUgs
	 +JPYqukN2mwbZCaGyld/Iz4BA84LzH+kBqJuxjYcS0XmISO3/w4ywyRjcrq9kFUIJ
	 GbXGrg5JFQ0ayqezNBU/ZcMP9WUvP2Ecu3izj5SjtdaHl+KW1nUwUyCcP1pDQk3Up
	 04MRcIVlH+KmIAqYhwxVmZxi0oGl7I9ALxbiouIJcZjPX+9EOb7PJgAREnexfy+FC
	 uJ78PikYUyK9LJNJVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1qwHpH17NL-00pgLY; Tue, 19
 Dec 2023 00:27:00 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 09/12 net-next] qca_spi: Log expected signature in error case
Date: Tue, 19 Dec 2023 00:26:36 +0100
Message-Id: <20231218232639.33327-10-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hHYoGwnG/npWO0LqVEcfYmPh48WImgUrw+j/hmc0KLzJsPrY2LT
 hc5SpWm5dI8Vi/jnIl+dnxvH9QU1MYWyEDtaUyuaT4ygq+HLcvpgJLovEnIr/FhsbbmcQuD
 mUThOs/+PL5ELCwlLsJq3oxv2RXJWG2LWS1SgGFdKm9y9BILfeHlxZmTr5aZ9efnxxdS5CK
 Ez0oZHZ7IaRVqVKMPKQYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MOBIsssI/sU=;H9N5eHivkxr2nG+qwXfBJJpkRfK
 kHRwBRHensCZCs6rc/CG7EdnOcDNDIDP3SBPVOgw3Nrc+efwRFWLSAUjrKsF6QVQkH1bLxc0M
 kwMOmaT5dvTRNSUUFhxpdn43KMlXcI7o5PIo6SK4Up8tkOb3maoeQzcL0WPatv4nSKWKk2YDA
 hjmnH5ViGE96BLF70mTyNzZFxD4aK0KyhFcxkvAEn/fmT7a/h5C3ZIH3Cj2tMAFvkv03Fif5T
 nhkTF3TFUze3loPNEXmC4AA+lW6rgrO2Uf7or8QT3KU1pAGNKj3i/cP1t8FmGfAO7HeAXErDP
 21qOPl+lzzQrVeXr7Per1jdbm5PmhF3WpvAkDu95cJDfsAy2dpbkIm3Ksm5L5+qWTnXa79kdF
 OZFmAy5WCpmsN5dUGvkJc2nC6gkNk3PcH1mVFdB2aLL+Z4jw2T1ZQ7NVrWC6GtwDYVHsdY2zE
 sz2o/jKlAkYTkNkoeJguWb78gLD0y5yPfrZd97yhKQS8yYZFh0UcVVyxwswbl9hpIk/sGNYpD
 AA9QGLKsqcfSGewGgCWfSvMN/KPEHxn5IKe+ih/3FOcteQ/sFA890Pqe9H94ynKZiqxulQ8wD
 wCj+mY16XQK/kNkG0rklB68VsWjbn2Q0gJ7E5k7MbyQX4Ergau5nDljpKMkx1cBbaYm5QPVgG
 nqzt7h88gGPXJFzXbFcLh/UDE9d9nf2IBO6hEw3AD17gGDGetrsyzUymn7UHDbqyrxW6i8Kus
 TOsmYX/oElT3jMMLZd+P462HKBaZBwJ6d8os0jw1RnMdbGLKs/rXkWoniDf89I9oZAVbh00px
 8789wVvJAGiX63RcAeqbQSZ/gQUpwO3F5YHToZLl0UYbmGV8g74JjHSGoe5Lqp/piLmC0rspx
 qkeU4w/rPzMAgIPX0Sbj6x0fgK52eDuGHQZ0V2R/1mkdLoVySKPmOsGR0FqBczBJhZxh/tjb9
 73+8cw==

Most of the users doesn't know the expected signature of the QCA700x.
So provide it within the error message. Btw use lowercase for hex as
in the rest of the driver.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


