Return-Path: <linux-kernel+bounces-89715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D702086F49F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F316B21765
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2DBE62;
	Sun,  3 Mar 2024 11:41:57 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A90C8947B;
	Sun,  3 Mar 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709466116; cv=none; b=SBogJzuMU0g3R7MjkO4gLswiMab7se7kgVWbN4QqGzzW2pjlLdM4MuUiYg6+46TUgzBb2Owwjr/jVJa47HhOOkjFmQlyE9Q7WmFMxZFe85wJat37KlduVeoXPlTR3FdmUJr4vlxUoLp5BnYCdGpHyjPCAA1U9zaeVU2aOSvtydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709466116; c=relaxed/simple;
	bh=C/+o4R/chXHt1BeBmz9g4eN1rRdlLEMe/HGROgdm+KY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RnTtpEEXtJkvc8MCTlildvr8+i4OggMNiJlzOqir+Cf1MD3T03VbWCWj5wecn1cITd/mDBavLR+j4oBmyB9MkDbNjL4oktikl3KPPpDWrk8jl5bhczTqddDC7Q4H//ikfeW3XaexNgx2MrBM4mLd/0YvogYKaOzEs9sWg8gov7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 8D86818B346E49;
	Sun,  3 Mar 2024 19:41:45 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 19:41:44 +0800
Date: Sun, 3 Mar 2024 19:41:39 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: fuyuanli <fuyuanli@didiglobal.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fuyuanli@didiglobal.com>
Subject: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
Message-ID: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
Mail-Followup-To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, fuyuanli@didiglobal.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Since fields of rtnl_link_stats64 have been set to zero in the previous
dev_get_stats function, there is no need to set them again in the
ndo_get_stats64 function.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-ThinkCentre-M920t-N000/
---
v2:
1) check and fix error of spelling and grammar in the commit message.
---
 drivers/net/nlmon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index 5e19a6839dea..9b205b152734 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -56,10 +56,8 @@ nlmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	dev_lstats_read(dev, &packets, &bytes);
 
 	stats->rx_packets = packets;
-	stats->tx_packets = 0;
 
 	stats->rx_bytes = bytes;
-	stats->tx_bytes = 0;
 }
 
 static u32 always_on(struct net_device *dev)
-- 
2.17.1


