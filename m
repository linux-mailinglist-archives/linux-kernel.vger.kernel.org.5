Return-Path: <linux-kernel+bounces-31017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B093832798
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA1285C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781E3CF78;
	Fri, 19 Jan 2024 10:23:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988123CF40;
	Fri, 19 Jan 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659786; cv=none; b=o2ytE4xZgCWMed1d5B/KUKEZL1QfSDD7BHx9RJO4fbLTNe8Jadyn9dgvRUYwE6FSHg4AJFNOjsPeCIuji7d/AiUJi3xRA+ibPq5aXx376/Xs42VpY3uPj4yWXz0M/s8T8HTcaATWiHlHylsy/Nso6UTFzpzwEryPnnZqjXdRnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659786; c=relaxed/simple;
	bh=H+L7PUjG/moR9/SE/ZV68ckNWu2AYzqZAphFxrn/bCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UrqF/5xUbsOP1+fKAqAkdPdwPEP5LI0NdbmUAMY9Zw9b3go5bWP9rWxoW1rm07reno90ZlVAmvrYJpcKx4R125pXi11aLBNo5yvwi5OE6rXBO0YNRCnfkYeVFAlGi5cAvmQdrZ6o/qp7ADcGunlBA5ygALIaCf3EEJ7XtUqPucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGbJP4ZpSzXgTX;
	Fri, 19 Jan 2024 18:21:57 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 695F4140153;
	Fri, 19 Jan 2024 18:23:02 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 18:23:02 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net 2/2] tun: add missing rx stats accounting in tun_xdp_act
Date: Fri, 19 Jan 2024 18:22:56 +0800
Message-ID: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500008.china.huawei.com (7.185.36.136)

The TUN can be used as vhost-net backend, and it is necessary to
count the packets transmitted from TUN to vhost-net/virtio-net.
However, there are some places in the receive path that were not
taken into account when using XDP. It would be beneficial to also
include new accounting for successfully received bytes using
dev_sw_netstats_rx_add.

Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/tun.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 237fef557ba5..4a4f8c8e79fa 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1634,6 +1634,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 			dev_core_stats_rx_dropped_inc(tun->dev);
 			return err;
 		}
+		dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
 		break;
 	case XDP_TX:
 		err = tun_xdp_tx(tun->dev, xdp);
@@ -1641,6 +1642,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 			dev_core_stats_rx_dropped_inc(tun->dev);
 			return err;
 		}
+		dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
 		break;
 	case XDP_PASS:
 		break;
-- 
2.41.0


