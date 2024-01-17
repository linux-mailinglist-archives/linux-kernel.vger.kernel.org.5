Return-Path: <linux-kernel+bounces-28905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF1830470
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686FA1C21500
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5511DDE9;
	Wed, 17 Jan 2024 11:21:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3D1DDD0;
	Wed, 17 Jan 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490510; cv=none; b=i/d1pDgG6G4XKjQvtH8oPLQatMuSprUlUx6A8bf/dNsSS+YJU8Z6ORbj5sUst9CfUj4AR/UK/mkNFMggSeKVvv7r+NPBmWWvi93TzYmGyRpjxAp6sSNAqjk6nzMNE08d3ImXg8Cv/BeqqlkFbYG6ppFYKIfjhZzocYZg+B+sULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490510; c=relaxed/simple;
	bh=gjmhFLfVIjTrWYOJ8noTikA7SMvBkr6Bxk3ZP9FL/+E=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy; b=K0FuLiCzVSCwL2maITubEb1Ew9vI6XC7wAzKz3PbbvTikVSttKXWFwFXV3Wnka6E0yEi4Po+ZgRdkGi/0eiv+SIaTWO04WZDQfbnk2j84SbSvHXH+YTPdJDm9ogKNhFCj6rshRxQz0HU2Vv2lpd+F3MW8HsCr4d98TQTj9w3UnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TFNjH2kwwz1Q81Z;
	Wed, 17 Jan 2024 19:20:51 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id EAA1314110D;
	Wed, 17 Jan 2024 19:21:44 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 19:21:44 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net v3] tun: add missing rx stats accounting in tun_xdp_act
Date: Wed, 17 Jan 2024 19:21:43 +0800
Message-ID: <1705490503-28844-1-git-send-email-wangyunjian@huawei.com>
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

The TUN can be used as vhost-net backend, and it is necessary to count
the packets transmitted from TUN to vhost-net/virtio-net. However, there
are some places in the receive path that were not taken into account
when using XDP. The commit 8ae1aff0b331 ("tuntap: split out XDP logic")
only includes dropped counter for XDP_DROP, XDP_ABORTED, and invalid
XDP actions. It would be beneficial to also include new accounting for
successfully received bytes using dev_sw_netstats_rx_add and introduce
new dropped counter for XDP errors on XDP_TX and XDP_REDIRECT.

Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
v3: update commit log and code
v2: add Fixes tag
---
 drivers/net/tun.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index afa5497f7c35..0704a17e74e1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1625,18 +1625,15 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 		       struct xdp_buff *xdp, u32 act)
 {
-	int err;
+	unsigned int datasize = xdp->data_end - xdp->data;
+	int err = 0;
 
 	switch (act) {
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
-		if (err)
-			return err;
 		break;
 	case XDP_TX:
 		err = tun_xdp_tx(tun->dev, xdp);
-		if (err < 0)
-			return err;
 		break;
 	case XDP_PASS:
 		break;
@@ -1651,6 +1648,13 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 		break;
 	}
 
+	if (err < 0) {
+		act = err;
+		dev_core_stats_rx_dropped_inc(tun->dev);
+	} else if (act == XDP_REDIRECT || act == XDP_TX) {
+		dev_sw_netstats_rx_add(tun->dev, datasize);
+	}
+
 	return act;
 }
 
-- 
2.41.0


