Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077657D9794
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbjJ0MRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345804AbjJ0MRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:17:05 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3E129;
        Fri, 27 Oct 2023 05:17:02 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5TnCT012403;
        Fri, 27 Oct 2023 05:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=NgILK9wtLyMUAwzUUpKcc8XDHZhA7pOaSTnLVOywbdQ=;
 b=j+y6QEijy0fZMfGbAOS4xBaehRxdN8Ze6q+Ts8jT+fxvSFTezgdCg7gHqlRV/FSnxZXl
 4aL3cZpb+LiTKnb9PdvSwPXTubnmaSatKKhRka+UT+YME7g18qES6qW/B8i8KTVZUXaX
 sFz5JUqS8sYKerEjQEMh2WsMU7YiGh6a3gbjDFpMcDdRavHX1EpFnzmrZeIdpRqckneM
 odY5GzbsJNc/hu3T56igKotHe3OWFTSQnurScM7UdOYT6lYUX/HNJXpBMoe9lOfdSWK+
 df4jNVajIyjxFteVuOAToI1uB3usBaVweG4xt2piqnBz7msLuU0zB0I45zCM8Qi6dE5o BQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tywr83b2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 05:16:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 27 Oct
 2023 05:16:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 27 Oct 2023 05:16:54 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id D8F7D3F7050;
        Fri, 27 Oct 2023 05:16:53 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v3 1/4] octeon_ep: add padding for small packets
Date:   Fri, 27 Oct 2023 05:16:36 -0700
Message-ID: <20231027121639.2382565-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027121639.2382565-1-srasheed@marvell.com>
References: <20231027121639.2382565-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3qNwm5EDD6Rh59n-SfkWgtZXvZghafBr
X-Proofpoint-ORIG-GUID: 3qNwm5EDD6Rh59n-SfkWgtZXvZghafBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pad small packets to ETH_ZLEN before transmit, as hardware
cannot pad and requires software padding to ensure
minimum ethernet frame length.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Updated changelog to provide more info.
V2: https://lore.kernel.org/all/20231024145119.2366588-2-srasheed@marvell.com/
  - Introduced the patch

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 552970c7dec0..2c86b911a380 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -820,6 +820,9 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	u16 nr_frags, si;
 	u16 q_no, wi;
 
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+
 	q_no = skb_get_queue_mapping(skb);
 	if (q_no >= oct->num_iqs) {
 		netdev_err(netdev, "Invalid Tx skb->queue_mapping=%d\n", q_no);
-- 
2.25.1

