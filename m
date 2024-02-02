Return-Path: <linux-kernel+bounces-49387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938F8469D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BDC1F26D62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C417BDD;
	Fri,  2 Feb 2024 07:53:51 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8C17C64;
	Fri,  2 Feb 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860430; cv=none; b=T6NiBtqTbNo67yEsJQPLqKQlVvjBFcOSQnYAiVjY1SY9hf7VU8zV3eISNF5b+peJO21XT8B6Y2qeFWJMQBNKrMVr0tPRFXNA2mhfmvYWOKYQsQeolhtdZT/7hUVnFQ7+KKQGd9DL6DiuYq8GdRyO3hdkDHdb1tarnOYI2RnlUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860430; c=relaxed/simple;
	bh=udxviX13manDkpnOlukyrX/hjFf+xqpC/T6OYP3DU6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5NlCiu5DyJAJmPdw1RG0Ee1q12WLZ4KhP7Eie+oXotKd+K6hh9n4nscB9Mv2Yu6Y4kobQ577lbwaHkPJ8mTsPR+1/ae0fJ1Janydz0nULE5lUQcG5eWZSSQUmGlTIZd8LYbKtuFzaQWa04hTOgDqG3SQgr1BDl9G7NfFwlmZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TR7Fh6QPvz1FKDX;
	Fri,  2 Feb 2024 15:49:12 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 056571400CC;
	Fri,  2 Feb 2024 15:53:44 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 15:53:43 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next v2] tun: Implement ethtool's get_channels() callback
Date: Fri, 2 Feb 2024 15:53:20 +0800
Message-ID: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500008.china.huawei.com (7.185.36.136)

Implement the tun .get_channels functionality. This feature is necessary
for some tools, such as libxdp, which need to retrieve the queue count.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
  v2: add conditional on IFF_MULTI_QUEUE
---
 drivers/net/tun.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index afa5497f7c35..0b6d25ede7fc 100644
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
+	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
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


