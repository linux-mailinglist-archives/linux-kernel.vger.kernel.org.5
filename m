Return-Path: <linux-kernel+bounces-118587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687E88BCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018EF2E4696
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6218AEA;
	Tue, 26 Mar 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vaGqkT2q"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295A18E10;
	Tue, 26 Mar 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443443; cv=none; b=RpdOwg1xlgKpKkErGBlHK102+bAI0ytC3EUvJ1sngEvJ5JUveqr/4VIlkqW0ghePEjoqD+5GDaCYWhScGTlNNtxebgOnbUS2W7jStZp7oRTNI17mCTuR/1HELbQvZG1AQirZseEOsHbUSVyVbeROdxVQKC2m2WXEBx1405Pn7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443443; c=relaxed/simple;
	bh=BENuy8j7wXC0Qc1uJxgZCCef0znJuM5TRoWGT9cIC4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hkv4Cf0kZ7+EyytftZqUtxPh137bJg0njKnfwr5b28J/Yhf4d45reCjACCgA1Vv4zJybH0Wl60fl1kL9tsbrZhOHWLxKsV0I9CIWCRUBk3pKFDcMCcocwN73hsFXMi+ew+Ba1mgfIVzOCZFM704L3mzEQLBdf77HpG29Gyl7v1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vaGqkT2q; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EEA9A87FA9;
	Tue, 26 Mar 2024 09:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711443434;
	bh=X8U3EfMwaJPc8Zo1AopiOETqF5i172Fbd+eIvg24Efw=;
	h=From:To:Cc:Subject:Date:From;
	b=vaGqkT2qC9l9zLYQUpVR3hZKYj+ndhJk/NGf+S5ZHI9vlQ3fpBrS+9gnfTbZwd4pZ
	 lIInGO1U6ifxg7u9I154TQ/203fZij2fAE5xDtIvRdGTAzFu34dSGBUVWmR4r1f7hk
	 UxGENBYXE8TIeZ5k4jz9J3vfiGK98v+ihgohSrqYv23xWwctpmAGlP+F9GaJJjzEha
	 0pvxpL1bcoqXKwZJdieaGvdD2+9yeZ6CHvsF8VUl4wMgITnhkHB9zAr9bI7Jao3YIf
	 yYFWKbuQKo+FXGU0XEf+leo/XTYsBZrNZzLNgj9v7akky8S7D236hF9M+MzSSbqwin
	 JYiuqUCKfy+sg==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 RESEND] net: hsr: Use full string description when opening HSR network device
Date: Tue, 26 Mar 2024 09:56:49 +0100
Message-Id: <20240326085649.3259424-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Up till now only single character ('A' or 'B') was used to provide
information of HSR slave network device status.

As it is also possible and valid, that Interlink network device may
be supported as well, the description must be more verbose. As a result
the full string description is now used.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Use const char * instead of char * - to assure that pointed string is
  immutable (.rodata allocated).
---
 net/hsr/hsr_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index c98b5b71ad7c..e9d45133d641 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -132,30 +132,29 @@ static int hsr_dev_open(struct net_device *dev)
 {
 	struct hsr_priv *hsr;
 	struct hsr_port *port;
-	char designation;
+	const char *designation = NULL;
 
 	hsr = netdev_priv(dev);
-	designation = '\0';
 
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
-			designation = 'A';
+			designation = "Slave A";
 			break;
 		case HSR_PT_SLAVE_B:
-			designation = 'B';
+			designation = "Slave B";
 			break;
 		default:
-			designation = '?';
+			designation = "Unknown";
 		}
 		if (!is_slave_up(port->dev))
-			netdev_warn(dev, "Slave %c (%s) is not up; please bring it up to get a fully working HSR network\n",
+			netdev_warn(dev, "%s (%s) is not up; please bring it up to get a fully working HSR network\n",
 				    designation, port->dev->name);
 	}
 
-	if (designation == '\0')
+	if (!designation)
 		netdev_warn(dev, "No slave devices configured\n");
 
 	return 0;
-- 
2.20.1


