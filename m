Return-Path: <linux-kernel+bounces-125961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B318F892EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8C81F212E6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF16FD5;
	Sun, 31 Mar 2024 05:37:25 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAD6FB2;
	Sun, 31 Mar 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863444; cv=none; b=Dlu1TmEw7MS4RDkvkBakHqa39dMnDH6OfEjY3vaS0C11tlYX5NsJQ4wSReiOUk+CH3B/qKshuWtWcYRrn7MYtYvr2ylYL7UbxFcm/Hb7M++625PyNnDiEQeApsSXTpibI6B9ZWt4wiwJWEP+/lQzvXiAKPwnA4naQ8p14Nl78zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863444; c=relaxed/simple;
	bh=nxx+6xNwnVOmWpIQMEjVW/rRZuWaUlN8c6YVrXlsBh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpMP9f9Z3rsFywTSaApOr1Flcq6aAevdG27Ak/yXjXx01cXvhi1OBwPwA096rdqKKp6/HB2SuFNGSQ1iPW0diO7rNZb5Y3r7MtXYLOrImSlrCPXnURips5is7H4yqvXXgOLWE22ORGkeTKqZrA6LeJJF723McJ1SLfyDmuq4R6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1711863362tp4jo7vv
X-QQ-Originating-IP: 1n8l4ALh9WiJP6dd4Vqjjg2n3vV6oK56OsALArkr0dA=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 31 Mar 2024 13:36:01 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3hJk2d/iE1l8M7/xX9AiPOvpZgXK4zA8yArofRwWfr63wL+fu12a
	kkxymzrJlfg8UhRnrd7HjT/aqE+NFAdWiu2IJnOjhT4iePMDukh+e6VxPFUPNt50TQOoRI6
	F69k3j/xMD7wn3BI6rejwFuTbfM7SEbgo5C408pa7je2hQTakW3frIH1RwMQYfaMa1jNpp4
	hDIykph0ygNn2KwTHbTBExTuLaYnDAICkXMU+S6vk478oqWqxnmAhpiobE6+Y02/KKP01dk
	EEc23nBmmqHpNQX1P2BvH16FmD4x/yg6aTlkrS4s6yNwXDJojARS9eEbfV8esu+W/KmU6Zi
	6yOKikBXQ8gIE1ZW85c8SK9lZ2fh6cmXUbAEws85gxFuevlxQCTE1ECh//5QdJpGEILYwKC
	y5stMRazGpc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3312073214826077322
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
Subject: [PATCH net-next v2 2/2] net/dpaa2: Avoid explicit cpumask var allocation on stack
Date: Sun, 31 Mar 2024 13:34:41 +0800
Message-Id: <20240331053441.1276826-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331053441.1276826-1-dawei.li@shingroup.cn>
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
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


