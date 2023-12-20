Return-Path: <linux-kernel+bounces-6842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A432C819E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46541C222EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC3219F0;
	Wed, 20 Dec 2023 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LjpY4eVm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8622303;
	Wed, 20 Dec 2023 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703072640; x=1703677440; i=wahrenst@gmx.net;
	bh=sDa+OPxR4DSE606VnJ3UhR/fFNpyHYQTxIzktag2M2o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=LjpY4eVmL/OhOIs85lUQ/YT6vqjCrdd17V2/O5xQJ/mi9Z6o7GsrUdtDBjTxEKs4
	 WsFYJ2+ctyUXI1hlc7gvOc0pwiVsE/O2O2ZMdOUv1W1l6xBDPZFt2Pwkpt7H+IRf2
	 8f4cGGZ4d0jwH4AsjXY1RBlbsj5qHtwfyHlSZZ4/4Hfq80jhvRfqvBTL20GziEDul
	 HMtW9Z0yT5nOsd3wRDkwpmPaKm21Yj/EN5iE1PH8QT/XrMm34N86Ex8Qip1n217Mx
	 Rmy47M2vrRjR4zuPWRH67YKe10Fsp5riuGNBOOVp3rBRBRkfRBfwniHxeigys/27z
	 Gw3LKr6BIx2oUq/HJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1rc6XO3TSj-00MMiu; Wed, 20
 Dec 2023 12:43:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Adrien Thierry <athierry@redhat.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	linux-serial@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] serial: 8250_bcm2835aux: Restore clock error handling
Date: Wed, 20 Dec 2023 12:43:34 +0100
Message-Id: <20231220114334.4712-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yzlm2lrwbBQOtRVkOBr2Xan/fuR2+K2CEDDsKjiPM7TE+KsoKGx
 +CVuohtU2kAC42xRkRbhF6cxNAygQHCttOjxSZsZ5Vd9baCTEi0bdrP5VkIDXQKAmW4Tgjz
 nivr2tzl2mWMlUdjiYDYN1x16jHJVkKr8nu/VMy2kkZkz5Wx86F2zDKlq1sg5ddzA1hJEfv
 ZAmrfpMmBn+gNx56l+hhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7HCk4+z6YSs=;QmKBCXvjMqHAKzUSIvwU64N7Em+
 4miVrpmBvnbAHBIlPR9TzVzsQyqPhua6sV21LcR+5+m1X8kvH/IdNDIapZeAOvVa5y6LnbvrU
 omc58O9hM4CsPYTlBz8IWuMFGzeqFEQinvlcnac0KztsKcgafKyYpPv0TX9lxn1XUF2su2V67
 AFJlU2aAeKAe8qyJJFCGB06iRXDN28slKLX8Iod+nhue/LRM55z9NebrGRQJ9hqGaWvHPYNxi
 esmUdDYRflmUXzd9Jgz9vxlMxQMY/Ya6akOFseqsG+0Sd2knjVd0/fcDP3V4HvFn4c7o/CZve
 gwcI6MzpH+RCzZwKHug1wPDMge5LRBtJPkmjUAjid6hFTvqHcEyPajxAtxXp0ai5yUoeRhVNs
 jKwsY0DrUWaG5QdgnqDYFEhGUdXdcgLb65eKKJuYNYoTtTbW8lQp7GefO1L307EiBKqIH1sOY
 7JZ2c94nQ7IU/MTSNEo5KULG572x9PRBErCaq7EJtwo0l+XB5/UgxbzGmghQ0/rpxJhFNvN+I
 qnVhi7ABlsBY/aOX8Yw1R2aP/61sqcLekwlakpz18gyvcet2SIXvJqsTsg1y4K2ylMPC7ljpw
 qUTCGgoGBMq7JKF+vPF3Gu3V6rx9AnGT59AEYWriiLlfzphDMGBJDOrmksztYYMN5FjPeQctm
 Rc1K5QWCdGOOwmy6EE1rGSfMjGplbSLGHXoiaQ7OkSR7L7HVkplT/+a2IRxZFVjRDfnzfGcD8
 bHanB3ccoYYA8jEka4EFyRoJW6tEx7YxwTP7t0wOUna2rBkl+4pMQkK3t0j6mUHFG0DD3/mq3
 7a2wfkH65jOE2eCnGk635zljiFtGfxbqnWB/Z6ZJ83JU1Grlrn/hM1U7AWrE4zcqHeXOUtyfJ
 q6r2XJGWmrtOAPd4SKRxlWtWBBkoKJdux02h/RFWOZmLaYNX50g+XjD3IWkoxwlf9TZzpOrJE
 9XoMhw==

The commit fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
dropped the error handling for clock acquiring. But even an optional
clock needs this.

Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/tty/serial/8250/8250_bcm2835aux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/seria=
l/8250/8250_bcm2835aux.c
index 15a2387a5b25..4f4502fb5454 100644
=2D-- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -119,6 +119,8 @@ static int bcm2835aux_serial_probe(struct platform_dev=
ice *pdev)

 	/* get the clock - this also enables the HW */
 	data->clk =3D devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(data->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk=
\n");

 	/* get the interrupt */
 	ret =3D platform_get_irq(pdev, 0);
=2D-
2.34.1


