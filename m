Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B17592C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGSKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjGSKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:22:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5530C6;
        Wed, 19 Jul 2023 03:21:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4gS0r008449;
        Wed, 19 Jul 2023 10:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=H1tWmuhbuVnxEhxL5TNv7ayIR5yNwafgkSHF+1A4gYI=;
 b=eeSbcJvx12vKU91V4jypzzaD/+nSAmDCLacmZzS6+d7y4AWLk1uHzVucAk/aYB20LMsf
 csitA4xqSl486y+VCty0F5oxGfYxdXCfcDfh/IlvmLrPc4VmgP5os7N2+hsM+pT7s13V
 NB29nGeII3nV4mgwnNny+bPsGWN+niQ8gTmgYCWLgYG76JwtJH5e1zjGDqoKamZsIv4y
 LROvKZExJVvhWvgszbyuQ35Atd4L6+XWcfIC1iWeqJ1MifsO7RsehJaIoaJs+tWZFIGe
 6OkE8I2DVvyHh4g0h87WOYRcd3cq1jQDuB30ei6IgwHtSJlbea4UAhx2dqyD36ojiS02 kw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrk1yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:21:02 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36JAKxBb008071;
        Wed, 19 Jul 2023 10:20:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm2ngb-1;
        Wed, 19 Jul 2023 10:20:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JAKwlN008066;
        Wed, 19 Jul 2023 10:20:59 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vpernami-hyd.qualcomm.com [10.213.107.240])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36JAKwkW008065;
        Wed, 19 Jul 2023 10:20:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 2370923)
        id 8C5794BFF; Wed, 19 Jul 2023 15:50:57 +0530 (+0530)
From:   Vivek Pernamitta <quic_vpernami@quicinc.com>
To:     mhi@lists.linux.dev
Cc:     mrana@quicinc.com, quic_qianyu@quicinc.com,
        manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_krichai@quicinc.com, quic_skananth@quicinc.com,
        andersson@kernel.org, simon.horman@corigine.com, dnlplm@gmail.com,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3] net: mhi : Add support to enable ethernet interface
Date:   Wed, 19 Jul 2023 15:50:54 +0530
Message-Id: <1689762055-12570-1-git-send-email-quic_vpernami@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aZkQJcWMLG1M_zCuv_KJlx3G7RdfW1lV
X-Proofpoint-ORIG-GUID: aZkQJcWMLG1M_zCuv_KJlx3G7RdfW1lV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=873 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190093
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to enable ethernet network device for MHI NET driver
currenlty we have support only NET driver.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
---
 drivers/net/mhi_net.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index 3d322ac..5bb8d99 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/etherdevice.h>
 
 #define MHI_NET_MIN_MTU		ETH_MIN_MTU
 #define MHI_NET_MAX_MTU		0xffff
@@ -38,10 +39,12 @@ struct mhi_net_dev {
 	u32 rx_queue_sz;
 	int msg_enable;
 	unsigned int mru;
+	bool ethernet_if;
 };
 
 struct mhi_device_info {
 	const char *netname;
+	bool ethernet_if;
 };
 
 static int mhi_ndo_open(struct net_device *ndev)
@@ -140,6 +143,14 @@ static void mhi_net_setup(struct net_device *ndev)
 	ndev->tx_queue_len = 1000;
 }
 
+static void mhi_ethernet_setup(struct net_device *ndev)
+{
+	ndev->netdev_ops = &mhi_netdev_ops;
+	ether_setup(ndev);
+	ndev->min_mtu = ETH_MIN_MTU;
+	ndev->max_mtu = ETH_MAX_MTU;
+}
+
 static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
 				       struct sk_buff *skb)
 {
@@ -209,16 +220,22 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 			mhi_netdev->skbagg_head = NULL;
 		}
 
-		switch (skb->data[0] & 0xf0) {
-		case 0x40:
-			skb->protocol = htons(ETH_P_IP);
-			break;
-		case 0x60:
-			skb->protocol = htons(ETH_P_IPV6);
-			break;
-		default:
-			skb->protocol = htons(ETH_P_MAP);
-			break;
+		if (mhi_netdev->ethernet_if) {
+			skb_copy_to_linear_data(skb, skb->data,
+						mhi_res->bytes_xferd);
+			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
+		} else {
+			switch (skb->data[0] & 0xf0) {
+			case 0x40:
+				skb->protocol = htons(ETH_P_IP);
+				break;
+			case 0x60:
+				skb->protocol = htons(ETH_P_IPV6);
+				break;
+			default:
+				skb->protocol = htons(ETH_P_MAP);
+				break;
+			}
 		}
 
 		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
@@ -301,11 +318,17 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
 }
 
-static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
+static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
 {
 	struct mhi_net_dev *mhi_netdev;
 	int err;
 
+	if (eth_dev) {
+		eth_hw_addr_random(ndev);
+		if (!is_valid_ether_addr(ndev->dev_addr))
+			return -EADDRNOTAVAIL;
+	}
+
 	mhi_netdev = netdev_priv(ndev);
 
 	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
@@ -313,6 +336,7 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
 	mhi_netdev->mdev = mhi_dev;
 	mhi_netdev->skbagg_head = NULL;
 	mhi_netdev->mru = mhi_dev->mhi_cntrl->mru;
+	mhi_netdev->ethernet_if = eth_dev;
 
 	INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
 	u64_stats_init(&mhi_netdev->stats.rx_syncp);
@@ -356,13 +380,14 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 	int err;
 
 	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
-			    NET_NAME_PREDICTABLE, mhi_net_setup);
+			    NET_NAME_PREDICTABLE, info->ethernet_if ?
+			    mhi_ethernet_setup : mhi_net_setup);
 	if (!ndev)
 		return -ENOMEM;
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
-	err = mhi_net_newlink(mhi_dev, ndev);
+	err = mhi_net_newlink(mhi_dev, ndev, info->ethernet_if);
 	if (err) {
 		free_netdev(ndev);
 		return err;
@@ -380,10 +405,12 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
 
 static const struct mhi_device_info mhi_hwip0 = {
 	.netname = "mhi_hwip%d",
+	.ethernet_if = false,
 };
 
 static const struct mhi_device_info mhi_swip0 = {
 	.netname = "mhi_swip%d",
+	.ethernet_if = false,
 };
 
 static const struct mhi_device_id mhi_net_id_table[] = {
-- 
2.7.4

