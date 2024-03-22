Return-Path: <linux-kernel+bounces-111268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1C8869E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E01B21C40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC92D630;
	Fri, 22 Mar 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uKNCIuEC"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9412E648;
	Fri, 22 Mar 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101913; cv=none; b=ddywX4byW9pXFLdAom11QzT5YysTCrc7rwsQINnK5WCumcG0m11ofCgDPbrGeHNpG/e2XkrrrZSegQa3wi69map4VDLaTs/TkRbBKv4Np2ajnWcYrSyjPYpGCpVB5IK565BQhzFpwq2UwuNDYNm2dRiR5qdbXSU4IbIRmLNhG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101913; c=relaxed/simple;
	bh=DU4C6ZnSVjEOzuxtOUUtZGkQexs4RZVz4JduuXYhlmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIjuYaN6W+yKEPC5+1JJd7djuBFljjXEdMhBmex9Ej8kZId4NnnL8UJd2mRWVjRGY0UVaLFE4J7ISLVT5I1SQ+WVOafHqxyXXf9pm7845YnJV2jVJjlu0zIgDEL1b9KqVaojZ7KP2zfot33P/1RzN9FAxHI5sTwjqgWhDpAX8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uKNCIuEC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42MA4prq120425;
	Fri, 22 Mar 2024 05:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711101891;
	bh=wxmqxb97DIpuCkv7FzBoW5vCyp0JMEHH0BIft+uHWtY=;
	h=From:To:CC:Subject:Date;
	b=uKNCIuECes+3/mEfav50g7Ac6G81U+ypdQPiE+N5PZD0+U6TiIC+fNUJwO6rZONBJ
	 Q8mnxq7DELAZ26Xa9LGe2PlzTW0mKiyqh7ryzBIMHpJe4DIU2MRKmSh4LMoqgRWETt
	 5LUTQQFWBir/QOiklMKEDZzpcbs1e1OMFhWou94Q=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42MA4pUc005727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Mar 2024 05:04:51 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 05:04:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 05:04:51 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42MA4lAP058877;
	Fri, 22 Mar 2024 05:04:48 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <r-gunasekaran@ti.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
Subject: [PATCH net] net: hsr: hsr_slave: Fix the promiscuous mode in offload mode
Date: Fri, 22 Mar 2024 15:34:47 +0530
Message-ID: <20240322100447.27615-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

commit e748d0fd66ab ("net: hsr: Disable promiscuous mode in
offload mode") disables promiscuous mode of slave devices
while creating an HSR interface. But while deleting the
HSR interface, it does not take care of it. It decreases the
promiscuous mode count, which eventually enables promiscuous
mode on the slave devices when creating HSR interface again.

Fix this by not decrementing the promiscuous mode count while
deleting the HSR interface when offload is enabled.

Fixes: e748d0fd66ab ("net: hsr: Disable promiscuous mode in offload mode")
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 net/hsr/hsr_slave.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index e5742f2a2d52..1b6457f357bd 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -220,7 +220,8 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		netdev_rx_handler_unregister(port->dev);
-		dev_set_promiscuity(port->dev, -1);
+		if (!port->hsr->fwd_offloaded)
+			dev_set_promiscuity(port->dev, -1);
 		netdev_upper_dev_unlink(port->dev, master->dev);
 	}
 
-- 
2.17.1


