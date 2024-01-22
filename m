Return-Path: <linux-kernel+bounces-32986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B668362D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3261F23A49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E13B2A4;
	Mon, 22 Jan 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Vxsnss3X"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED743BB21;
	Mon, 22 Jan 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925518; cv=none; b=Wr269FIAXPaiIegy3wOgwq2cftxr1M8U/zVBm2d5r5uqvEfZTQMGJanACOIRQxaWJlb9+gpr0O21GvtmgtlVq97uisZ1qI358aPu115eRchoBDMAl1id+vvITxZ4/h//g1AXLpRluFmR+B/n1jGhEPhq99tmGINU8W8PT4Kyp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925518; c=relaxed/simple;
	bh=TPVj2fxS1zs2uqfH2OqzpWSshq8vUs1z/gIbUq8u8zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gH3sDj9hFC3+rr8BPOgdFe5CGH17f5imSSZGcEt5itECuYnrkRQZxYaWrPE3eUD7fxk1p4InSCC1cPw2LTHW4aTcyyZoz1yRg2ZlWnLP3Dx8sCSAx84XNQav91Xvma/JLdL5RoAg0IeLaDlfpUjXAS1m/cTZXgqBIaY5hAQEKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=Vxsnss3X; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1705925076;
	bh=Zemy8ZJn5fD/HAJy6AeSeL43fUsG/BaVJW5l8hEuiYo=;
	h=From:To:Cc:Subject:Date:From;
	b=Vxsnss3Xelc4d4COJPjkA/pP8rIdNLk5/pq1UjfwXrdTnCm8bxQ3sbyrBlIdp1OtJ
	 NEs/p3pmHMCzkEAUKi1ZQzD/6c/H3DHuDlkcMz9reQAhyHTTBD3D2iHNQ4JlbSPTn9
	 QMBw33r5e1U9X2sDxwIQZId8Aog2Hx0rduTSRoJ0=
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
	by uho.ysoft.cz (Postfix) with ESMTP id 59ED3A00CE;
	Mon, 22 Jan 2024 13:04:36 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petr.benes@ysoft.com,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH net] net: dsa: qca8k: fix illegal usage of GPIO
Date: Mon, 22 Jan 2024 13:04:09 +0100
Message-Id: <1705925049-5756-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When working with GPIO, its direction must be set either when the GPIO is
requested by gpiod_get*() or later on by one of the gpiod_direction_*()
functions. Neither of this is done here which result in undefined behavior
on some systems.

As the reset GPIO is used right after it is requested here, it makes sense
to configure it as GPIOD_OUT_HIGH right away.

Fixes: a653f2f538f9 ("net: dsa: qca8k: introduce reset via gpio feature")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4ce68e655a63..83b19c2d7b97 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2037,8 +2037,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->dev = &mdiodev->dev;
 	priv->info = of_device_get_match_data(priv->dev);
 
-	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
-						   GPIOD_ASIS);
+	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset_gpio))
 		return PTR_ERR(priv->reset_gpio);
 
-- 
2.1.4


