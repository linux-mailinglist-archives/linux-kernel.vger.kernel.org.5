Return-Path: <linux-kernel+bounces-27182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86582EBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D382854F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07212E42;
	Tue, 16 Jan 2024 09:36:28 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89812B72;
	Tue, 16 Jan 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TDkQq5CPpz1wnCL;
	Tue, 16 Jan 2024 17:36:03 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 578A914011F;
	Tue, 16 Jan 2024 17:36:22 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 17:36:21 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net] tun: add missing rx stats accounting in tun_xdp_act
Date: Tue, 16 Jan 2024 17:36:20 +0800
Message-ID: <1705397780-11364-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500008.china.huawei.com (7.185.36.136)

There are few places on the receive path where packet receives and packet
drops were not accounted for. This patch fixes that issue.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/tun.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index afa5497f7c35..232e5319ac77 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1626,17 +1626,14 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 		       struct xdp_buff *xdp, u32 act)
 {
 	int err;
+	unsigned int datasize = xdp->data_end - xdp->data;
 
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


