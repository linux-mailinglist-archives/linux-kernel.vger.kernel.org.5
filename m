Return-Path: <linux-kernel+bounces-41940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663283F9CF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5961F21D51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3652F8B;
	Sun, 28 Jan 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Rkr4vVE/"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551A44C96;
	Sun, 28 Jan 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472700; cv=none; b=lllsnzAHnUE9say4jh2ROErCkT7/+jQdSOrXY2cY+5Ff6TZIfaRjzpfTMky3CmSv9z5NlaRMtvGZxoGYIERFu8tAwfSN6W1XMc1VAe2S1HpFs883JA9RcpRYk9f9e8sZhSiG7V8dyuhYpK9AR3uBJwDejp1fH4G85oou3wVfYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472700; c=relaxed/simple;
	bh=uST46aVMcO0oxyeJtONHXSQTVv+FoojlsknYZY7TYrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWrP34QEaZYg1GU3IgblH3hy+ruTRrUzVaVTg/ujPPKw+8SdTKyFOelN2ZP+ZHMmDn8My2UAvjyfPlcX4GkVrSDdIg0M2HaDRzDhHWnrCisr2dB+iFYpSVdhR4gAMAdjhGI+szvxzdCg/J8YDF7OZbcKbv+mAiRLeaH2+e3oHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Rkr4vVE/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472684; x=1707077484; i=wahrenst@gmx.net;
	bh=uST46aVMcO0oxyeJtONHXSQTVv+FoojlsknYZY7TYrs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Rkr4vVE/iVXJPyyEUuFCsm5viHcodBnVccQwHRv8uSbBxjQfwcneAc6gIv4Zo8kM
	 bc0RRa5YbKagFZn1wLdtLTtRwKeKiZU74UcaXd5bX+dzOO8ygVFjMxdvwa4yGqeFe
	 AevJnB7O3VvSJwyf0tS/iBRKmc9swVy5NFzndVtT5AUUkimNq9lKV+1qZ07BCbvIL
	 EjT3X6CuHeC5rWVBzeX8Co4EwE6AEPADkYh6uGUxfwDgtcuYAM0s0KIdol/s7/ABk
	 Nkrqan06+28l5EOhEk1VZLdoaqRc2rM5lGpr4fcnJQs50FlUw+9oKyJeY5m3mIK78
	 55qAhwHayAXcNkNHzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1rYKTY3mWB-00Ve2D; Sun, 28
 Jan 2024 21:11:24 +0100
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
Subject: [PATCH V4 11/15 net-next] qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
Date: Sun, 28 Jan 2024 21:10:55 +0100
Message-Id: <20240128201059.6259-12-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:9bSTfWo2H7bN9GNATqokZKzrpAXj8qGdG0JIg7kD+UeFZ7XESL2
 DYOotE9tBV19InmYeRqOQkBsUSO7taaThvh4grA3yzUCyju3tcAfwc+faXk+ljC7ToqXk4l
 l5XMf7fcisL8XerUPKFc3cEVQ0HP6j5g+Us6QHRCCXFQtU+YwnkatORDAwP5tjXc8pM/OY1
 LxrvpYPyn73nLPksGqlHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k+PyFEjTasg=;ZZNtwmw/ebZFR1tBph1IF7AV9zW
 su3Wah4RuT3qktXo6mNIYHwxJXecSAZSnKpYs+rWzWyOVTdhAaXH/8BOgyeTJ0ZBeBJZPA56D
 62t/gIVuf86CpP51jnBM/kebi3+lXu75j4pwcw6/QiI1DAJu/5lFNS08O1EI0b4xNTeomOPDG
 soueA7KU3XdeOULGNT8mH9BNWbW9l7C0ouFUxa+MDv1nP4LqlqVyAI2naumEu9fee4nLRoWa6
 hlN+l4PzFFgc02NT/Sr4bZzG8T1i7iOEe1hXcOayGgIb8+1PpW2kck1ryKmzD9qFafeweKbol
 RfNjq1SZ4A/WZeGqTVGYMsF5j5OktiBCMFmGbolBWh0Jpaf1GYwjt4BkRa2v07VRGadJkOtCV
 zUibMHr72SMlOS9Fo+r35hI/ZzkYeiQODTGuC4Y6R7AiDO4Z9l55AdsoNihJfMSKkaSulgh63
 lu6vG8z8+K+tK0gR9K0BloH3+Zj3oC/mgevXPIAjF6IhuDXrRvR7BHL730FlcsMiGBeldbkRj
 e+w92kAVaAZNC5yBjsNhu+RnIKV2q7xvmX4DsDagPOWnvAXCfi4bVvaB8R83Y+7AmUZ223coF
 dGn01PDHabqUC/YiY3sL11JD+yeNk2UMLqyxIG7Tuq0hM2+YnMp6sPW3rg7rwNmOF9vjoM+LX
 v8ZBrNZRbidJfREFGFReKCx9nrp2q46evypZOLVAx65prm3wDsjwjQS9KneRAij7CT7E1En46
 OMu8yt6IxVy4XjPP6+0P7BIgDtP4SE8KRofZIwdJ2XN0ytQ5sQRbk0oN+xPbfoAP7+3vYeQ1u
 7siQnsEHg4GlyrB17whn5lEM1G5etZHpg2dChlmQnlwwHi5pJK/onr/57iWZv3914qBUBSI71
 +kyNhkQRDSQfTKHVkOTGsR4hGC/TzFt0NerzIGBQeMEGTlJRmhl2wMJa2BNHhlVxsRd6VddEX
 HvOsbA==

All known SPI registers of the QCA700x are 16 bit long. So adjust
the formater width accordingly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index d2d68c20b32c..ca8c0596a992 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -359,7 +359,7 @@ qcaspi_receive(struct qcaspi *qca)
 	/* Read the packet size. */
 	qcaspi_read_register(qca, SPI_REG_RDBUF_BYTE_AVA, &available);

-	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %08x=
\n",
+	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %04x=
\n",
 		   available);

 	if (available > QCASPI_HW_BUF_LEN + QCASPI_HW_PKT_LEN) {
=2D-
2.34.1


