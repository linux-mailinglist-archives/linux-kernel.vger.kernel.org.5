Return-Path: <linux-kernel+bounces-31015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9D832794
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B9FB2376A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECA93D0D9;
	Fri, 19 Jan 2024 10:22:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DF3CF4F;
	Fri, 19 Jan 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659766; cv=none; b=fPL9+vuqODGSr0Vo5/WhIiqT0Jbg3KmsPMSvqjcqfLSMg6xgyPwdfiV3vE+mPu/3reFWZb9Q6nwo9pbyj7b0/Nz8BpZ07AoEJv4syeNPCYwH0918jS4BpTDXKm0E39GRcu2BZFuuMKW159TqQDO0xxZG0iqfpVfkkjg8oVPs/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659766; c=relaxed/simple;
	bh=s18ppnGo5XugcpIC11YfHzdsPrSQi1CfkjQOubpKxYs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3vkSWq8I03DC7jIxU8EJJzZzSqOAk7GU4l2DxYckZ3nTx7I5Zzv65QRzuchqQ/nm54H6w95ao3/eS1InaY5jw+YTaQcW/ssHyV3D+VJ5d3YMyDhfmHxGopQ2a0RfQN3NhiM7qNCEjxyoGgUPzBQGU1SnSnn2uIPqBOPKwbkZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TGbHK3nRMz29kL2;
	Fri, 19 Jan 2024 18:21:01 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A45618002F;
	Fri, 19 Jan 2024 18:22:41 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 18:22:41 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net 1/2] tun: fix missing dropped counter in tun_xdp_act
Date: Fri, 19 Jan 2024 18:22:35 +0800
Message-ID: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
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

The commit 8ae1aff0b331 ("tuntap: split out XDP logic") includes
dropped counter for XDP_DROP, XDP_ABORTED, and invalid XDP actions.
Unfortunately, that commit missed the dropped counter when error
occurs during XDP_TX and XDP_REDIRECT actions. This patch fixes
this issue.

Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/tun.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index afa5497f7c35..237fef557ba5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1630,13 +1630,17 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 	switch (act) {
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
-		if (err)
+		if (err) {
+			dev_core_stats_rx_dropped_inc(tun->dev);
 			return err;
+		}
 		break;
 	case XDP_TX:
 		err = tun_xdp_tx(tun->dev, xdp);
-		if (err < 0)
+		if (err < 0) {
+			dev_core_stats_rx_dropped_inc(tun->dev);
 			return err;
+		}
 		break;
 	case XDP_PASS:
 		break;
-- 
2.41.0


