Return-Path: <linux-kernel+bounces-101139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4587A2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50E82830AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36614AAE;
	Wed, 13 Mar 2024 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K55qBZTE"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420ABA5E;
	Wed, 13 Mar 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311613; cv=none; b=iQN874hRelOakZ2oVA01IjdSLBPNqIsx02KjNNNrGu6HcehjJIlHLKRHeusrQHoe1mb4cESLec0HYXr+0Hg0TsVfGMFLMIfMOOqPvK6PvmqooYWuPPvB2n4HPQleD7dWo7Vg8KCRldgGZVhLS6OCGpAhuaV3sNEYlCDC4Ygm4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311613; c=relaxed/simple;
	bh=9Zs1KGyWNWhmAejwgtyMJIfOriycRX1MdIXZB6Zlp3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gl9vpSibE20QeeO1jI8uhIcfhKbqN/hh/iOB9iV7InDIX/IBaVcV376Q9QHiXqxTyKC4q4vBIM8xMdKM+Bbc0ZVObZSFpw5LMlRq86OQgBcoYJDphHDcDn8SoDW+1RQ0tbyFuN0u1Iba8FCsjqoEJ9NH/iUdOHJcxdwlUFhvzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K55qBZTE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D3BMFs015050;
	Tue, 12 Mar 2024 23:33:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=j9SqWvWQBt7wm9bpLwobyyiq2bV0O/zls6CGCynDx8Y=; b=K55
	qBZTE9x/5sDJTAQVAm3g0N1cdtJRKM6EhZROyGBYBJDHRu/bLBsaXXNyIbONqQAs
	Xijzg6lyorOllNfL1Pmvibw40DAl0/gebPKpZpOpfiwyaiGNWp6E1wJmRvV2BGtl
	loV/rq2uCNb3jTGjYcuUjVdyg4XeKDFlur3avGbEq2TCJ4yrJS8wvgDXjOjZ38u5
	N7yPYyEvBi6g95DTTOTYkFA9CaWZpXiTyNR+dGFsiYr6yhBThSrRB92IFDJkxnC7
	a3SwK2uXrLUkibMIE+yd18Ovc/PcMVsIVc+lG53j48PAbV9xuwmZ/Z8GuZrCQoBU
	XuTDVl3ZFZpj+UkABsA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wtt8htq8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:33:11 -0700 (PDT)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 12 Mar
 2024 23:33:10 -0700
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 12 Mar 2024 23:33:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 12 Mar 2024 23:33:10 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 3CA103F7082;
	Tue, 12 Mar 2024 23:33:06 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [v2 net PATCH] octeontx2-pf: Disable HW TSO for seg size < 16B
Date: Wed, 13 Mar 2024 12:03:06 +0530
Message-ID: <20240313063306.32571-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ysWmEXmgCdF5PXVpake7vdK5iiKJ0SAA
X-Proofpoint-GUID: ysWmEXmgCdF5PXVpake7vdK5iiKJ0SAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_06,2024-03-12_01,2023-05-22_02

Current NIX hardware do not support TSO for the
segment size less 16 bytes. This patch disable hw
TSO for such packets.

Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

v1-v2:
 - As suggested by Eric Dumazet used ndo_features_check().
 - Moved the max fargments support check to ndo_features_check.

 .../marvell/octeontx2/nic/otx2_common.c        | 18 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_common.h        |  3 +++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c   |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 11 -----------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c   |  1 +
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 02d0b707aea5..de61c69370be 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -221,6 +221,24 @@ int otx2_set_mac_address(struct net_device *netdev, void *p)
 }
 EXPORT_SYMBOL(otx2_set_mac_address);
 
+netdev_features_t
+otx2_features_check(struct sk_buff *skb, struct net_device *dev,
+		    netdev_features_t features)
+{
+	/* Due to hw issue segment size less than 16 bytes
+	 * are not supported. Hence do not offload such TSO
+	 * segments.
+	 */
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_size < 16)
+		features &= ~NETIF_F_GSO_MASK;
+
+	if (skb_shinfo(skb)->nr_frags + 1 > OTX2_MAX_FRAGS_IN_SQE)
+		features &= ~NETIF_F_SG;
+
+	return features;
+}
+EXPORT_SYMBOL(otx2_features_check);
+
 int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 {
 	struct nix_frs_cfg *req;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 06910307085e..6a4bf43bc77e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -961,6 +961,9 @@ void otx2_get_mac_from_af(struct net_device *netdev);
 void otx2_config_irq_coalescing(struct otx2_nic *pfvf, int qidx);
 int otx2_config_pause_frm(struct otx2_nic *pfvf);
 void otx2_setup_segmentation(struct otx2_nic *pfvf);
+netdev_features_t otx2_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features);
 
 /* RVU block related APIs */
 int otx2_attach_npa_nix(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e5fe67e73865..2364eb8d6732 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2737,6 +2737,7 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_xdp_xmit           = otx2_xdp_xmit,
 	.ndo_setup_tc		= otx2_setup_tc,
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
+	.ndo_features_check	= otx2_features_check,
 };
 
 static int otx2_wq_init(struct otx2_nic *pf)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index f828d32737af..9b89aff42eb0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1158,17 +1158,6 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 
 	num_segs = skb_shinfo(skb)->nr_frags + 1;
 
-	/* If SKB doesn't fit in a single SQE, linearize it.
-	 * TODO: Consider adding JUMP descriptor instead.
-	 */
-	if (unlikely(num_segs > OTX2_MAX_FRAGS_IN_SQE)) {
-		if (__skb_linearize(skb)) {
-			dev_kfree_skb_any(skb);
-			return true;
-		}
-		num_segs = skb_shinfo(skb)->nr_frags + 1;
-	}
-
 	if (skb_shinfo(skb)->gso_size && !is_hw_tso_supported(pfvf, skb)) {
 		/* Insert vlan tag before giving pkt to tso */
 		if (skb_vlan_tag_present(skb))
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 35e06048356f..04aab04e4ba2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -483,6 +483,7 @@ static const struct net_device_ops otx2vf_netdev_ops = {
 	.ndo_tx_timeout = otx2_tx_timeout,
 	.ndo_eth_ioctl	= otx2_ioctl,
 	.ndo_setup_tc = otx2_setup_tc,
+	.ndo_features_check	= otx2_features_check,
 };
 
 static int otx2_wq_init(struct otx2_nic *vf)
-- 
2.25.1


