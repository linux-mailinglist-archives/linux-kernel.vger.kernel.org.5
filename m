Return-Path: <linux-kernel+bounces-124422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CD891757
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C801D2893B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D356A33A;
	Fri, 29 Mar 2024 10:59:17 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195E6A034;
	Fri, 29 Mar 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709956; cv=none; b=Rioe8QRGYcwlwQk4+bCwRvmshfXuDpUzo0+r+W/i2UT0RHgIEQkStE20rzOgQ6GUpcjrp902b6zKk6xekGYUKzm4H6/IqVSair5dOvstRsQq3pGnpHfWZ7bmny8AVb+K4CGYOOhZ+3AhVleJA3K1pnqZSmms9KdS68m6GXRLQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709956; c=relaxed/simple;
	bh=nxx+6xNwnVOmWpIQMEjVW/rRZuWaUlN8c6YVrXlsBh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUkZ8XgYsON73kfruYhcZ4jTE9dS9qEKdhcM543GUOgNUkOBW0QcqLKeYfnj4z0tK2UEnckQNk9wlX3JiaTHoiz0hYQ/SemXjTXiiYfRG9s/7qXSz9vrQvkXdZcpNu+N8lVKE5lq241GoXLyiHJOIErPp100DXcntzYKcoL6fwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1711709854t315a8p1
X-QQ-Originating-IP: H8w4LcerRMqb3ebuPNSs3LfNThRRyFFZSFHvYx23/XE=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Mar 2024 18:57:32 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3i4lw8jCv5pRXp7qaLjIhH0Nom7X39gKEaZDUM6z97qAS+K1xyiV
	uPemEmElYeZZ9MUIMSmYEYFWjkUfeioSa/IBg8MTJgqd5mJTURBXQkRogmBUVfa0DjxpoHT
	/ct1PrtM9lkrVLQEXtIVpFge1a0v1UwWuAEAkcE6ylNn/zRf5ZZ5DHHc+c2uN4RUKu15lJ9
	fQqIU0EpHK4oYC8Ury5lbzEOO5wdG3fgWm4LjJyOSbUpP+dDW4/+iFemu+VY178tutQ133a
	XrCMHstzq/eYYgILgAj4Oe3+U14R3IEbJEg/fqmbsCkFxNWNwbVhKBXH6H4Ug0H2PonnIbA
	u0f1zayFQkLzJK6Hr+sf6XBpYTpE9W8E6OaHFChg5v/COuEruju3laTNc6ky9N1Y6NB0dkZ
	AeybAHcHGbw=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6166159861030876298
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ioana.ciornei@nxp.com,
	wintera@linux.ibm.com,
	twinkler@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next 2/2] net/dpaa2: Avoid explicit cpumask var allocation on stack
Date: Fri, 29 Mar 2024 18:56:10 +0800
Message-Id: <20240329105610.922675-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240329105610.922675-1-dawei.li@shingroup.cn>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 888509cf1f21..40e881829595 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2896,11 +2896,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *net_dev, int n,
 static int update_xps(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev = priv->net_dev;
-	struct cpumask xps_mask;
-	struct dpaa2_eth_fq *fq;
 	int i, num_queues, netdev_queues;
+	struct dpaa2_eth_fq *fq;
+	cpumask_var_t xps_mask;
 	int err = 0;
 
+	if (!alloc_cpumask_var(&xps_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	num_queues = dpaa2_eth_queue_count(priv);
 	netdev_queues = (net_dev->num_tc ? : 1) * num_queues;
 
@@ -2910,16 +2913,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 	for (i = 0; i < netdev_queues; i++) {
 		fq = &priv->fq[i % num_queues];
 
-		cpumask_clear(&xps_mask);
-		cpumask_set_cpu(fq->target_cpu, &xps_mask);
+		cpumask_clear(xps_mask);
+		cpumask_set_cpu(fq->target_cpu, xps_mask);
 
-		err = netif_set_xps_queue(net_dev, &xps_mask, i);
+		err = netif_set_xps_queue(net_dev, xps_mask, i);
 		if (err) {
 			netdev_warn_once(net_dev, "Error setting XPS queue\n");
 			break;
 		}
 	}
 
+	free_cpumask_var(xps_mask);
 	return err;
 }
 
-- 
2.27.0


