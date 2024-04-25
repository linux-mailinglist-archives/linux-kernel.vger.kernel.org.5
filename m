Return-Path: <linux-kernel+bounces-158822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3A8B255C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA7AB23DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625B14BFBC;
	Thu, 25 Apr 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LbP6KbGP"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EF14B086;
	Thu, 25 Apr 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059627; cv=none; b=WU1EQ51rCLuQW4jfe5BYu5rtzSw0emZeZi6AL/JGviPr5NNb76+15ivA8/6c8V17TW0Rv7I7Vem1iNN//Ar1eErjO3NUMIhfusGaET9k2VffzH3TP6d507eCN/fwNCQV3wTVjM2rfu0Re4JBtnx860XiATSGBDY2uGEDnBQJ1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059627; c=relaxed/simple;
	bh=NeAGDssrBE1nQvK6n7Y2DS9FDrRvGrFq+guTHdUb4h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnzCeei0YJhm5ip8dfgH5iGwiEWX91XcqLTkFlOzgl1D8sQBN4FN8+KKgzVevlk+oLwUeEoe2Ot15UlcCBirRzEW16gURfIqNGOB+6wd8Nei56If1hYETA0X1MZihpM3ECf1dQdmtL0/DmlQWVJQc4mMgwhAL5zyRZxunp513Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LbP6KbGP; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1C0FC88FBA;
	Thu, 25 Apr 2024 17:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714059617;
	bh=u//hZdEDeqpd2RqtJe+A8Jdt/tG07v39FbGKhW8tvuk=;
	h=From:To:Cc:Subject:Date:From;
	b=LbP6KbGPMWulym3/278+9gtPppW5KiwrVyc3Y5STTU1TGaYIzT+aHVdfvVpJ/BA4/
	 LzFp3/LGj/wgm/f5MTkKoDlD4q9MuyMxxhf8GOfxYgvR4TC90pcDgrC+qxvSgPkxiK
	 ehF3jh3z1KrKckCgUpGhi2OIfjZol2kGdxcu8HXBDKLQjuT01KuiLp7OcwGbPHAXFx
	 IWfp+iN+XLcGQXiTuGRKQ2vlBhXrlN680HfLCzFGScECzZkrbEoU27ads0pATEQIjB
	 P83M+koOxY1vdI+wkGApQJmaWuKhKjR9R4ytV+CiuTU8pP0zovTj/2tPQRzND/KY5x
	 F5WhymIsutHmA==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Casper Andersson <casper.casan@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next PATCH] hsr: Simplify code for announcing HSR nodes timer setup
Date: Thu, 25 Apr 2024 17:39:58 +0200
Message-Id: <20240425153958.2326772-1-lukma@denx.de>
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

Up till now the code to start HSR announce timer, which triggers sending
supervisory frames, was assuming that hsr_netdev_notify() would be called
at least twice for hsrX interface. This was required to have different
values for old and current values of network device's operstate.

This is problematic for a case where hsrX interface is already in the
operational state when hsr_netdev_notify() is called, so timer is not
configured to trigger and as a result the hsrX is not sending supervisory
frames to HSR ring.

This error has been discovered when hsr_ping.sh script was run. To be
more specific - for the hsr1 and hsr2 the hsr_netdev_notify() was
called at least twice with different IF_OPER_{LOWERDOWN|DOWN|UP} states
assigned in hsr_check_carrier_and_operstate(hsr). As a result there was
no issue with sending supervisory frames.
However, with hsr3, the notify function was called only once with
operstate set to IF_OPER_UP and timer responsible for triggering
supervisory frames was not fired.

The solution is to use netif_oper_up() helper function to assess if
network device is up and then setup timer. Otherwise the timer is
activated.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_device.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index cd1e7c6d2fc0..e91d897e2cee 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -61,39 +61,34 @@ static bool hsr_check_carrier(struct hsr_port *master)
 	return false;
 }
 
-static void hsr_check_announce(struct net_device *hsr_dev,
-			       unsigned char old_operstate)
+static void hsr_check_announce(struct net_device *hsr_dev)
 {
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(hsr_dev);
-
-	if (READ_ONCE(hsr_dev->operstate) == IF_OPER_UP && old_operstate != IF_OPER_UP) {
+	if (netif_oper_up(hsr_dev)) {
 		/* Went up */
 		hsr->announce_count = 0;
 		mod_timer(&hsr->announce_timer,
 			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
-	}
-
-	if (READ_ONCE(hsr_dev->operstate) != IF_OPER_UP && old_operstate == IF_OPER_UP)
+	} else {
 		/* Went down */
 		del_timer(&hsr->announce_timer);
+	}
 }
 
 void hsr_check_carrier_and_operstate(struct hsr_priv *hsr)
 {
 	struct hsr_port *master;
-	unsigned char old_operstate;
 	bool has_carrier;
 
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	/* netif_stacked_transfer_operstate() cannot be used here since
 	 * it doesn't set IF_OPER_LOWERLAYERDOWN (?)
 	 */
-	old_operstate = READ_ONCE(master->dev->operstate);
 	has_carrier = hsr_check_carrier(master);
 	hsr_set_operstate(master, has_carrier);
-	hsr_check_announce(master->dev, old_operstate);
+	hsr_check_announce(master->dev);
 }
 
 int hsr_get_max_mtu(struct hsr_priv *hsr)
-- 
2.20.1


