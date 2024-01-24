Return-Path: <linux-kernel+bounces-37744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44A83B4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152012851C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB6136656;
	Wed, 24 Jan 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QLwRG93g"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35D130E3D;
	Wed, 24 Jan 2024 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135597; cv=none; b=ciWrwkX0btv4BEmgyh+ZE2qTfjw7F2oViXY1s2DRLvj3VuZs409/CoWAktlZ+a+T+TYnc56+7/gNVenshADACmuS6VG3S0zFFNrgZIXro4Mk8BC7T1Tmwyl+KZdcQ47vxbWSKYShFN8IbQEVBxjbG33SSDnB5qdND0x6gfcNYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135597; c=relaxed/simple;
	bh=aPLUUURCdX8yefR9B+X+EaFFqrqIchv4U4ygOF8Vdzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmDXALMz2gAt1iAD9Da5zrxzt1kN91Oy+w/HgdymDH7z9NBIUOYSMfnurHqbH6JA9iNOEQIWolIjDRfFpBiLDY8DiJHffi2g+wjJJkD6CFt2zDatzf5rqWWBLBI26DqEgg42a5q+qYEO1qAZxDqRF4ztU9AasLJCm2/4rpzxJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QLwRG93g; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135561; x=1706740361; i=wahrenst@gmx.net;
	bh=aPLUUURCdX8yefR9B+X+EaFFqrqIchv4U4ygOF8Vdzc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=QLwRG93gvugH69luDdbo1sna8wmWggF6jXwuflJC9Zaig0l1InFcAmQ4XagZ73UE
	 HrqvtGHUdjWh9C6hI2evhPS6dRVwdvRn/gnkMzC1RozhoHoSTg6nbZ5AEfkq3yaxZ
	 z06+9W9ICdN8Ws1dcgi5rNvTPoD4aZMsZwRYAXui8eb4mszpdAUekd5RimcN0Y9l/
	 te/Q5sPlc0vqtwHdyUjFkmZFN2NG4Fd94UgwBunGS5oMN5vRAbkZbMYUX1jOR4xhI
	 ke7dMkASvAdTgLjVAMVRzSLxPAiPbVZ3KDJbIiDITGWqkMY96FvF/m+jPeXawAaA1
	 79d7a+8HZw5zJ5mqew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1rGyEw2jN1-00F9Ux; Wed, 24
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
Subject: [PATCH V3 10/14 next] qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
Date: Wed, 24 Jan 2024 23:32:07 +0100
Message-Id: <20240124223211.4687-11-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:RKnQJ8mFyiEBeynNQ4tWzggzqo0rymb9752Iu0YtU45KsP6H+TG
 oDZpwW3VdD5CuZOXwKB4LGdYx4qXDa5a/tmMqUBHk5uULAwzMzkHhHPXh2byWyJTUUSgyd4
 o2NgSxCCOW6xmlUtjp1ZXXGBu4CYVd6jPFvC22DmV6tTTX5cixPnNqA/VaPPvoAZgbFPtX2
 aK5fKIWCvBfArcFwiQP5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ugjREs5rMqw=;0rqJ9cyuQ05gzrybB2cW0gMwyRI
 VqY+YM0/rwxeISipI4WR+P6DR20f6BEKSp39Kt3Fu412Un9ffHFr7Pzx97B6dHjGHC2wYFKXN
 d/HDEf8yza0+Z8pXSzeVA7hHMb5QDJBaFzXw3HBvSqk7mNfwdOzsB9VHEsv6EQamQ/KHPWV+I
 ZgaudVXhBOsN/YPHxd4WHwtnZSs8ZwW+OUhnvemOtwh2qL9NRr7PRLGO73u0tyQcILMZO8q76
 o/pyu32qjp8JfP3th+QV+p9p1NkwAp2pwkhi48PuDesvw7vkgpbgGmMskQ7fdLz3Ls3vMjM9s
 oPryfuIbsO9JtTiTRUz6cktknpirmmGCJz9jwtpVZ02fz38DPKrbNuB/Bp3JdnMWFS0XdlYES
 +ZbrzIcp+KY8wdkiYe92OGYtXQ8M/cX3ecStR8i4ACYuETbdXfCrfkBmD3H0ig42ObXJZ91M8
 Cfay/Yr7Vep4nM9af7LrNEsek/WH++8Vkgx2yjAG7Iz/vW/Ir8ClWojVSKpwj9uZLd90x78s3
 mSjaRypq5yjswP2QwjzTqH0gxCPIEMoNPjeiTS0eqjAzEDYFQInmUhFZZ/xSbXQe5/st68MJ0
 q6VM5DR2nGpEbLg0WEWrMmFjq7wrKRID0Nsz3jtIyjrBCW/4KtoC9NfoD/3etQIqz87taa+rJ
 1Tk69fiamUJVk8dEqxbI7tvvWcJDnDWStIZX234Vy3ozWafxc6ejmBBcQXfWzTet7NWmG6bTl
 BwPUKrbQOvWy9trA/j0Y+uSFKf8MVoKDsFBLu1ZqQnK6X6Cgjyie8ai2V0WqQnh7IsADr7nX2
 t6kPO3sNAGx33FDoMJbiAFjjKmiM/T97vgqQrRfaXoIVUifbXXNFmAa4YJ+sP29vVNOXz1ucU
 z+tSW6QLvlpTuHg1FlW0xFa/23ikmt8/6sp1+B/IXPHDrYSwa6xKa36bnoU9g/qv1gJD8bF7Z
 hUW0FOoJERHoqMzxMkC90uDddqk=

All known SPI registers of the QCA700x are 16 bit long. So adjust
the formater width accordingly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index c5d240fe4146..d3109eb24b4d 100644
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


