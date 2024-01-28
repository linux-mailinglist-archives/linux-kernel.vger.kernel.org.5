Return-Path: <linux-kernel+bounces-41930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A941383F9B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AB61F21A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253783C46B;
	Sun, 28 Jan 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MZpOhqET"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE713219F;
	Sun, 28 Jan 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472694; cv=none; b=qQ9wGpFbUsAT3jMwf801TeIZDCnfFwkzTWd76ajRPgPGkPPbjrDkiz/Cc5xrUNnWb7IwicTDuKsGu9L1jyYApq97coJATWsndpRqK62SjNGKmtEnJ4+epooSBQmirq3zE03ihySMtCjJ4P/KZShYvfHo1Lu/yTgn+SBHX3U+wW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472694; c=relaxed/simple;
	bh=NdM5m5BreW0faIZS4cTcvHWKX6LbtdeWVP2uCpexkPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LE35Ui3IsUenkGoJqjtk5Z46BAR0Nbe08LfgESJRHavhNQMIOi0XmaK/ztas+jCdGKEgP0NpFtVnn2Ls0gB8+RHr3OMsFghBx2ZywAC2x/Sq4LGQwdOz6oyvoRagoZq9I+l/qsHco08rG3babEiAQalWcCg4Kts70X+sgHH5AMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MZpOhqET; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472678; x=1707077478; i=wahrenst@gmx.net;
	bh=NdM5m5BreW0faIZS4cTcvHWKX6LbtdeWVP2uCpexkPc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=MZpOhqET4EeKHDvfCXZLbDdMj8wtDxw2G6yZ5LZiZNLXOBBEd+cNbz7QIiC4JK7i
	 E+DVJ8MqfHiCwKHTcNx+pOuY17J/P9c69wRDH4nOUK6LnvTJ5BlcSUTLpoXNaRj60
	 YyJOkqcCiCWBlEUL/oQWE+YJYpAKMNnw6/c3dAuqMQvBzgnkKe6Q7rXT9Xg6wPeCl
	 pagqcQX6CXAflS/LNIiFMpIpcX3F4NwqgcHIxSVruSc28NjHSTLsPnzFL2rpRJkK9
	 5/qYw9DEqahXma1sC+wGJ9zEQy5MpNDBoLaPJx4/otc6z/6BAvkmSZXTsImyzqnZ1
	 tpQB4VXBvRg5wNq0zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1qqzKi36NC-00hiIe; Sun, 28
 Jan 2024 21:11:18 +0100
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
Subject: [PATCH V4 01/15 net-next] qca_spi: Add check for kthread_stop
Date: Sun, 28 Jan 2024 21:10:45 +0100
Message-Id: <20240128201059.6259-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:AfxYoHf5IGBDGU2Xrvj5CO4LhdvOjncPUGYKr98mfwYamLDzI+5
 0B4phhl/JO2X3U0/6wMUDbZ/2wBN2UR9m+Xyn2R6twnCA7rnkO7wzMDCWySEceDTF1DmHQm
 hCO55vd6zFtK0QHHTD2DOP3Bgh/bpj6MtqOpTQoMjLyemR+OPHwu2fOLIM21QQYWekaReFb
 KfMoxxFvFB+9vI5AS3nOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QNuBhD05qr0=;kRf4KuQNIURDBXsBf1vEyWebEVO
 vnLFEtdvfZEbiFNTgMCzW3FJUFEcRV9jvZhu+SDxuzlbuy7iajUofiI4hKwSMYVhoXpQzYMOY
 HD41X8PLnl0MKBToHjPce7jmtcbDSMsIZ/6OqHYiIWqtQIQzSFMI6VnCYrs6N0CZ8VSCw12Lp
 oPv/KMelu8VGCbUA249EjH9gacuPqv7cdkiww9/YiCtlF0nA/he6KFSyeQ9T14Ybt6PLfWcGR
 vknbEjHIXbMpjQxZ5IJlfdubIOZDGcBkzgUR8NH6bmzjAiDaE24ouUNL5tXAGwILvrcWn/1af
 wzTFgvMhElfjtfl+s7TpvHjHba2IdMu2hosiYdffo2dsWiHX11XFhbynKCqV8tXO4wrlSHtPO
 OyFWCANck+alfz7e9fdM2iTRpRcvM3vCezRRjCedS7pX1X4Cv4zOOe7jCxny62jk2QO7O0OSN
 sAv1UT8mCJZuczaOi8nclDvJEKBnpn4MnRMkXP4ey8CMm2wNgaxphDzrsDQIEdiDifaQkYK0f
 cU+oMeknw53te3mPexYNP/lnFAJ2GLzvnIWREPA6oIa8s6AKuT+Z3VHy6wHfc+nd1kSzYh/iL
 pdn8I1uzNOTFi4r0epPGt9GzP4N/mSCuavwgDGjjfyJkj1VSTNJUll85VdimGNqOAUr4oJ6Yi
 Gpuq5snTjPh47u32bMVhJZbVNN3YqWF+q8XKPuCy1+IWfN2OqXO9mbtWyJDzWIoij0IrjPVrc
 5MtLFy0+diAtHIR24EouQT6UKZTL+Y2F1LkZS9NYrjusbfhRWDHUiZsR6hBGqKZOMAnkGzri1
 cG1/iMQzd7Nzo/yX/dmdoFzYZDWHFS11yC5jdPW2brUKEJLjawG0p0BqZ2VO4BxehtDTOgW2M
 oufYvLDHWaFQYotvJpdhA8ahr96xREDiziIusRCGzrbudb1kGY0ILnj31qfp224SGCdcZ4vkT
 eoRYMw==

We better not rely on that spi_thread points to a running
thread. So add an check for this.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 5f3c11fb3fa2..77bab8bf5203 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -730,8 +730,10 @@ qcaspi_netdev_close(struct net_device *dev)
 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
 	free_irq(qca->spi_dev->irq, qca);

-	kthread_stop(qca->spi_thread);
-	qca->spi_thread =3D NULL;
+	if (qca->spi_thread) {
+		kthread_stop(qca->spi_thread);
+		qca->spi_thread =3D NULL;
+	}
 	qcaspi_flush_tx_ring(qca);

 	return 0;
=2D-
2.34.1


