Return-Path: <linux-kernel+bounces-41932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023F83F9BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215B81F21A32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7245973;
	Sun, 28 Jan 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="K8HEBIe3"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21033C684;
	Sun, 28 Jan 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472697; cv=none; b=GmEiQR4wM/Sp96It4zVSPinEBOxdehnuhiNB4wtdJCKXP1bvhSRbpIs704mKa0y00I0SQ0j3ZsNYwCSuJ0Addx13qH+SRiPIBBidrf/VOpTvkoReP3mTxtDx3WeSWBtfmVsax6DaGOtCJdtrc/iYnUdTzcW0s727zA8CsNoVT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472697; c=relaxed/simple;
	bh=JpsH264rChdlD49OAGFAPCLKSi7oz0Y/8/+8WGun5XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0BzibXnKM1m8fLh1ChOnKo8UVtMESFmFGBCmZZF9AnTNzfUfvpn/+uchngCVzESU2hQ5XqjlVGzYztRXH4XzQg3Z2S6xzfwJClOUzm3N330ufszEM9VCgGzVLjBxntIhlaewav9bXCIO9ze9L3fa/7bSsK6aI+l7kBdpaSzUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=K8HEBIe3; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472680; x=1707077480; i=wahrenst@gmx.net;
	bh=JpsH264rChdlD49OAGFAPCLKSi7oz0Y/8/+8WGun5XU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=K8HEBIe300lnhZp+w9MtRCT/QwnURiPXWa5au52TH6EDnVLrPjK+2cWAxAFFkjGd
	 gauuozhTYMUgrIO7KizXk0qPIrS4hyf5RewzwE4U7NjihsnZGlf5hVW893TdeXiF9
	 f4W5E6UiPQ39SpfP480cyoA5hSmIWEHUBW3LdQNngN9mQTyE1XqgjykuvfgmZNzpB
	 ihctsY5Tgp2J0c/wxOrVDeGJRt2xY20hFw91P/8PF1h5G+prp5w7e1zgEc2bVfrsA
	 EoK7Kbe1fgH7SgXlQ1CfYCfqEAbSb78sikcU1uOAssoTQtaq3ClM25bdBK1cj63uE
	 tsAe3bhBP6W1PNNm2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1r0e5F2yPF-017jkF; Sun, 28
 Jan 2024 21:11:20 +0100
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
Subject: [PATCH V4 04/15 net-next] qca_spi: Avoid skb_copy_expand in TX path
Date: Sun, 28 Jan 2024 21:10:48 +0100
Message-Id: <20240128201059.6259-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Tfke7F+thVAsXv0rFm40+OARM7IFVXTugVggjAqduJPvzj2kySu
 0EZjDhM6wOQ2h946AFuFWZGLE/Lzu1TyIW0nzXPhIAFot2cLglm/uXEM03Izi3zVMvd71xJ
 eQPkPN5CJyNv2UQd8kllxwCs53YwdpXo0xMuqo3lf0OVS5VkAX0s4ieUsjuKrH0XIk2XwqC
 fK8u1L5kkcq4dFU/NHulw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3o1O60aU1+A=;eV2YbaWMVAVEQyv/yT1ngGE1N+/
 p30oBDsIlTsRgnYLifM8q9N+/7BNcmGQeavvqz5PLtr0LWC8oQFDClIU+CJ8pbGhUUU0BBgKp
 9eqja3GHLLHxedltoJSsHd8LnNu8H2ZRv/i1lb8TCbQCbibgbk3Lhaq9TVqwd8Ngs+WIDLM4u
 PArchYfmOdOhK2NeQe85+U/VSYpbdaW9IpLbBAxD9mVEC6Dgfbe6QJdrW3PT1/2mU+dFz5ARV
 +GxuAPBcFHgPYKVHgFKMvXwSxUMUApcEUDuoEI4VxPtyI41IIeBxBr59UkePr6UjKB360tyug
 2G1TGnCF9usQeGWWzJoiy1GBF/6uoFj+1M9CmHolvedQR7c+340Nfbqovu8pWbDCtfIoxRLWv
 x57njfk6AV80DCejePiU3pa4xHFy0u4F+BjTbjDrApNFJQy0ZTn0r5ueL4/roSxP12EtYLmgB
 ktThIWKmrRrJhtYP3ATBxGAO/fBW1oiNgIEmDnaFRBAD10XOWuryzy9yM/rNU1AWN4IPJeqkH
 5ThB14OuSKTnMCgQozQQhIb0YiGzRjkfHCEk5SZrsvQhOMkKTZzgWylS6EYh3wBzee+/SiG48
 mamEwtUosHbtMW7NmGWsLy7wd0WTAfWXGZlWtlTTkX2gtWnAkxZYncne4xfjz6BgBLZTBGozI
 2HMs1AfVthhQjVGHfj23m71P7sHcvIMO7DQl+VTeLfFJ0uWg54kbJytEiV6Nl8qYDDKnwlK2N
 +stCPSUOKlTmD8hHroVMANWVIwyezjB6ybPNONXxJHT+iYUqiDktvLe5ckZeGTWcns9qyUPo3
 jPVE2WQ9ZQRwhHjJq+BFfofiO1oWwkseCDNxIjT2eG1r8xHcT6fALOIbRfhMNeYmotZZ9bqgs
 K0GXJKhDfpfCQcNzpb0a3sSXdtov7FqSVtk3EH229/WCCsvI7nuiCRAmf3PGP9qv2BySDAXBe
 eYJ22g7Mwk+IpX0bKlc5ICeE25M=

The skb spare room needs to be expanded for SPI header, footer
and possible padding within the TX path. So announce the necessary
space in order to avoid expensive skb_copy_expand calls.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 3f7e38a11ba0..5fabb40cca05 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -878,6 +878,8 @@ qcaspi_netdev_setup(struct net_device *dev)
 	qcaspi_set_ethtool_ops(dev);
 	dev->watchdog_timeo =3D QCASPI_TX_TIMEOUT;
 	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
+	dev->needed_tailroom =3D ALIGN(QCAFRM_FOOTER_LEN + QCAFRM_MIN_LEN, 4);
+	dev->needed_headroom =3D ALIGN(QCAFRM_HEADER_LEN, 4);
 	dev->tx_queue_len =3D 100;

 	/* MTU range: 46 - 1500 */
=2D-
2.34.1


