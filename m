Return-Path: <linux-kernel+bounces-90335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61AF86FDD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80BA1C22725
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA2210EE;
	Mon,  4 Mar 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="B4wQlWFu"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F37225A6;
	Mon,  4 Mar 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545179; cv=none; b=suPzyaffOaVkq8Fn5v5+3rhKEwBcwW/GGXsIIPInwwH4s7zwEdKlXcSgygcetRA8H+kuBh3c7fRm/DqjXqlAP5H6X1LMJ7QH03otBb3ZHMMtGPC+HyHnXVvH6GZwkjMVEE251rcC6Z0zSzxsqtR1rYeAZrCxiXKmPFeP9CjORD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545179; c=relaxed/simple;
	bh=so6Y8pkPttl1YpSq6PwnluDXvxHzVQSAipo3aqdm4rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soebuzgKQ686Go6zfVK385q4NAal2oMSMHdJqmvqCnl9wUHtEuTSbs2cboSisQKxnCrb0Lk4JYoQstz1/57qSq7SDzF1xq+uGa6KZxMPBws1W0IaylJmyza44jk2x9BrleSrV0RgvPJAZXUZWzA5wjZDnpRP6LT7nXvJSIxfB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=B4wQlWFu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 919D887F3B;
	Mon,  4 Mar 2024 10:32:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709544765;
	bh=3mjYo148TYL75N4xxdKNBZ+5b0p2poE7mksZ1cmgcGs=;
	h=From:To:Cc:Subject:Date:From;
	b=B4wQlWFu0TlrMAXRRHiJ/1D7JCdBO1NarLWib8Jp+Nk6JODFxrlROIIUmhG1zslwL
	 vVzhbFk4FkUG4JVX42gDd7V7UA8LrUlycBjXlMeM4JCsTPPT8gpLve94Dlk9Li0S/B
	 6txGU93/SmS2Su6kl4O5MNVqql9M9bCx6xA8g+PIHjVnkVHMVn/IL3o43k8e2QOWIQ
	 umRoNYNWsKzxKxo2M5pSMH10UUHY7cs4X+pt+Gd0/wOWrRB1/4YXM2HlShpxogktVo
	 tX9X5qn2A/TWwqZXX9QRDktxma70W7MIpaRpS4aZPTUtCb7hgaSTHWtldk5IaX0H/W
	 P78wKhYTHk9KA==
From: Lukasz Majewski <lukma@denx.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] net: hsr: Use full string description when opening HSR network device
Date: Mon,  4 Mar 2024 10:32:20 +0100
Message-Id: <20240304093220.4183179-1-lukma@denx.de>
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
 net/hsr/hsr_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 9d71b66183da..9a60489fba96 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -142,30 +142,29 @@ static int hsr_dev_open(struct net_device *dev)
 {
 	struct hsr_priv *hsr;
 	struct hsr_port *port;
-	char designation;
+	char *designation = NULL;
 
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


