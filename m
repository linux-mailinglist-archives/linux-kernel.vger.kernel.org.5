Return-Path: <linux-kernel+bounces-89422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9ED86F020
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20111F23CA4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BB171BF;
	Sat,  2 Mar 2024 10:55:45 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D84A56AD6;
	Sat,  2 Mar 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709376944; cv=none; b=dk8ZzPzVQ9PW9R3EzqJYMRGpO6wzOSs9EQuY0YEUro88RoCeVmH5efsuekkoUIEJb4RN7Tg7oVkYJvnDZ9ivcqnQJfLlfD9YbOX9T4Nnlp50yx5EMk5RL62r3XcByhMk66SDI3MYuzU8MMTmkEX8ErvUNIDP4pGDFiSnXauHnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709376944; c=relaxed/simple;
	bh=3XioTpY8UndFIGe5+xld28+YcpEE3AwYivnNJ176usg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ql455zOUIxmYB479Er+jiemCHw4HuZ5tMlzIZJx+Ui/+jxyTDi6Lk856FWk8pn1TbMWkG3GunoiSFYkM3QSTXpiGmaJqJ2mBP3IW2L4JUlfsasIZtG4b9mjvTP6WwRo2KeAvX4M+bDLU+MYijsL/6Q9315/LqOD4dA8PLZTYsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 9CBCC18B4B6941;
	Sat,  2 Mar 2024 18:52:30 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 18:52:29 +0800
Date: Sat, 2 Mar 2024 18:52:24 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: fuyuanli <fuyuanli@didiglobal.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fuyuanli@didiglobal.com>
Subject: [PATCH net-next] net/nlmon: Cancel setting filelds of statistics to
 zero.
Message-ID: <20240302105224.GA7223@didi-ThinkCentre-M920t-N000>
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

Since filelds of rtnl_link_stats64 have been set to zero in previous
dev_get_stats function, there is no need to set again in ndo_get_stats64
function.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
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


