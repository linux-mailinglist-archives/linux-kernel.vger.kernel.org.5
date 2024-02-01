Return-Path: <linux-kernel+bounces-48074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE678456EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FADF1C21A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954E16086E;
	Thu,  1 Feb 2024 12:05:41 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356F15DBA2;
	Thu,  1 Feb 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789135; cv=none; b=nydZYFVhKTpqoc/T0JhgtZtWzoKK6GfZRM0MM1l5VCGugfx08JRBSQn/r6g5jLEj0WmxcQvwKoZLbpSrrdtynP7k1GICNARJoE9j2TMvVekv9P52mtkJnmKNnPCBaXFobaN1XdWdjMeijhdYZCTLN2+bUk9lmtOfu7De0+txx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789135; c=relaxed/simple;
	bh=4b6J3WQy1ZuklldGS5umROhnm/eI6zxFrBGfBb5XyAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/Za/jpuuKj6IlMBct/n+a4+W0K1CV+KS7B1WAZ+JpWhw9NHaV7WXEGzcwF2fkc8GUG5bQD/zkV0uF0YMuLq3y5Z8LgbNZo1b16/eSEOjUQbaR0rWVZiE2fMzGaNPKJbbWI+Gs5ymfkhdWF4KNy/u0UTLDFipz54GXpdzaiYKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TQctg25F5z1FK5w;
	Thu,  1 Feb 2024 20:00:59 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id BAE4C1A016B;
	Thu,  1 Feb 2024 20:05:25 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 20:05:25 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next] tun: Implement ethtool's get_channels() callback
Date: Thu, 1 Feb 2024 20:05:09 +0800
Message-ID: <1706789109-36556-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500008.china.huawei.com (7.185.36.136)

Implement the tun .get_channels functionality. This feature is necessary
for some tools, such as libxdp, which need to retrieve the queue count.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/tun.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index afa5497f7c35..7cf448ff93ee 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3638,12 +3638,22 @@ static int tun_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static void tun_get_channels(struct net_device *dev,
+			     struct ethtool_channels *channels)
+{
+	struct tun_struct *tun = netdev_priv(dev);
+
+	channels->combined_count = tun->numqueues;
+	channels->max_combined = MAX_TAP_QUEUES;
+}
+
 static const struct ethtool_ops tun_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_drvinfo	= tun_get_drvinfo,
 	.get_msglevel	= tun_get_msglevel,
 	.set_msglevel	= tun_set_msglevel,
 	.get_link	= ethtool_op_get_link,
+	.get_channels   = tun_get_channels,
 	.get_ts_info	= ethtool_op_get_ts_info,
 	.get_coalesce   = tun_get_coalesce,
 	.set_coalesce   = tun_set_coalesce,
-- 
2.33.0


