Return-Path: <linux-kernel+bounces-41931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6483F9B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5661F21A17
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA83C6BA;
	Sun, 28 Jan 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="otzzt1QX"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A433CFB;
	Sun, 28 Jan 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472695; cv=none; b=M52Vncg9xWS4rr4Jxn30icz3IwtakOnKmyjheC3+cGdqC/+OSjMLuZOe1V7FXuxYJnHlyoqcJ5rkhu2N6flYV78CRSwuVxEUn5Fg6AoZfSaO4qNapTOXOmQCf33zH4TVoOV9Q9+TDIAZz49cYzKRoLhWryD8Ji7HnHZSXIYzm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472695; c=relaxed/simple;
	bh=/a3XjCwkev4UaYRviAJl/ZXYOyQ9EIrLw/7tcHWkLhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUIzD6w3XHnNyOaYvjlQdtklJ/8dZ947B/7rzKJWLoGgrtZsSXE22YePyn3K21s/tkB6M+SR2gxBZFuDPtcufg0OLN+iRGFmSViAdsBdCXgpF2JGMVZ6xuz2bSZBMNzi4fy1yMJaJvPHSjKOml37Lp08ay9PuM0guhSmaqOlZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=otzzt1QX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472679; x=1707077479; i=wahrenst@gmx.net;
	bh=/a3XjCwkev4UaYRviAJl/ZXYOyQ9EIrLw/7tcHWkLhU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=otzzt1QXppw4obX+GPdGZOxii8Z06Ewhus1r+tAKsXsNVZI+YbF3nglLyJNw0sEc
	 L6lP24L+lXB25FKKkQoPULoShQSiQPn50bpvktfw5/CyA7F72gZtLIbMROh0IvJNR
	 B9WofLgHBen6tX43YgC0jerpWJil1m5C7XSYiAz9B8hhHiKr+17E8WW3wh1WYbb5u
	 twPEyVRpaEKnjcRh5I3aKRDHVSjyDTnL2y4EsaE/BhnyIXoxLQXzHyKMNo8b+hutO
	 c/AhaG4A2Y6eb7+96sJeKm1tKk4RqyAgKItmg2H/e2saBglO+0q+85E44sdLo+u5s
	 G3zad8iM8KuS9JoD5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1qzXcc0i5B-014Qt9; Sun, 28
 Jan 2024 21:11:19 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 02/15 net-next] qca_spi: Improve SPI thread creation
Date: Sun, 28 Jan 2024 21:10:46 +0100
Message-Id: <20240128201059.6259-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aSIglkDEsq3lvXRURyTBI5gPLVY4vpipUM2fSsP0gU2Uz2gH2rB
 1QEncOnqSzk4xWAl1JueiJ09GmqadnIBEAKZuxMOnLj/8G2sphgbPHJREFxkRrhbmFb5y+X
 CDRpswJNhoV3znHHrSRZPGUnjQa2Xe97OGn6Q+OXAPD54sY7prCxeRhyoeHYt1AWYY6CxtU
 nDgCVAS6OZp9fH/Pq4jUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rKY1ZPzsqiU=;x6UvKh/oCtolnBl8IPtzKpMzoJu
 0XtzR/eXHTLA7bk/ONfy1zL84PIvnpg7bSR3kxHIohnoXh5joLpx/hBvR0TqyLAfVyVW28/4A
 J/F/UWZIwvwuXypZVXUip+wyly/2ZQupVjcjq1k7ULjUbM4w6rzsHHKlid72yEUfN13ZfPsif
 c+p2wY3z6Dat2Fa8xUmexn+Jbrc6133UcLPYTM4AVZzJOfoLGfceNZwwRRy49F1xSDJjB5Kny
 m835jvDSf5sPl7sJCbYrvjfFiMOv3h1p8NWwEwm7ofIze/wlAvPS4T4kFXhwuWBqHQLa5p5PI
 6bO7xL7svKzVCbIShMAuvM2eymn4OEfz1/ts0ghgpj7AvJhNE7c7jim0a47tUr9mZwUgkHQ46
 kAotx6zQLzqaMsAf5CjcRK3j7ecLWOxSOg9uuy07rp8V1Y7/752ptKLwq13viZbbNY++zgryL
 3Isxlu24//mR2UWN0V12S5+WtkI4T7QYiKwfKaMBxQXpD9xrZPpRDpYM9/FXhjGVWWQXmCXHO
 lDEJ2/nVU8teTSKKNscKc7ROgTPvWCgmNnGztQIVJHI7FnjGAZ4QtqIz4jTt5/3eBJvGGCSZ+
 +0vx5Q2X4mLrJQh0NX/JhMr1Lt/650kOY6BV2l58GovHW4TD3xEr+W8MfnthagavvO94W5hXN
 ihAYbgR5IxZkIA4ZuplhkD+ea4fGLfoVOj8kLG4EyBxfQBSLanUQx7Ct8ntPQdVM/f6wT3T8e
 HzCOEBe/AIrS8z9AD+Qlz6dTQYpVugqO8vTrrWbWC0smMCQqTxVzZ6NxfyNDQahtBcDjmBxXx
 TL69+J61mNhld67uurJi8qjtTeT9A19qnoOZX0PyNjHP6EV0bjYzybfJ7+Y1DolbmAL/xMCrY
 NeWawaLU5X0iPrlha7xxU8cvaxllGkaj9GH075BNv3jPCP4yYgEK33p1Gwh4889hzOzot9dTN
 ojYiHA==

Directly storing the result of kthread_run within the private
driver data makes it harder to identify if the pointer has a
running thread or not. So better use a local variable for
the result check and we don't have to care about error pointer
in the rest of the code.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 77bab8bf5203..fe50c2dd7cc8 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -687,6 +687,7 @@ static int
 qcaspi_netdev_open(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
+	struct task_struct *thread;
 	int ret =3D 0;

 	if (!qca)
@@ -697,15 +698,17 @@ qcaspi_netdev_open(struct net_device *dev)
 	qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);

-	qca->spi_thread =3D kthread_run((void *)qcaspi_spi_thread,
-				      qca, "%s", dev->name);
+	thread =3D kthread_run((void *)qcaspi_spi_thread,
+			     qca, "%s", dev->name);

-	if (IS_ERR(qca->spi_thread)) {
+	if (IS_ERR(thread)) {
 		netdev_err(dev, "%s: unable to start kernel thread.\n",
 			   QCASPI_DRV_NAME);
-		return PTR_ERR(qca->spi_thread);
+		return PTR_ERR(thread);
 	}

+	qca->spi_thread =3D thread;
+
 	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
 			  dev->name, qca);
 	if (ret) {
=2D-
2.34.1


