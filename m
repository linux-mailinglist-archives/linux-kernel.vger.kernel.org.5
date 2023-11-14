Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4577EB125
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjKNNqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjKNNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:45:58 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1215E1B6;
        Tue, 14 Nov 2023 05:45:55 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE84dfn017588;
        Tue, 14 Nov 2023 05:45:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=NgILK9wtLyMUAwzUUpKcc8XDHZhA7pOaSTnLVOywbdQ=;
 b=A/d4yDKMlXNQi07eAhEsK9oKc01xK93KL2ojqhPWri1VLYy8pPUl5hoXI6cUwdIiZ4ib
 EDPPmxjgSa2LXFQaUB1XSWLh+t4xBo4F6PbXLUhowZcQjeEfbH4FcsVwlv8llxoTQhMs
 laxs5TcQfV8d8fFdJ6UDGKu9It4mhvEuEl9KAMknPDDBNy6V7HteiZzZeiTEhZO5/GJc
 iqZ8vLDBQbAkjhl+8tXL7l0N+k63VRRQenUAeEU3IEYuTko6I6ocMK9XaO+Wo68rnly4
 w6qhHnVFkEesF2ZvyU67qFL3kDQcoHAwktNLpZCfgQhaGWS0czfU+z9i54AUnRAJ5keA 2Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uc52eh2g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 05:45:42 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 14 Nov
 2023 05:45:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 14 Nov 2023 05:45:41 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 9942C3F7055;
        Tue, 14 Nov 2023 05:45:40 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v3 RESEND 1/4] octeon_ep: add padding for small packets
Date:   Tue, 14 Nov 2023 05:45:32 -0800
Message-ID: <20231114134535.2455051-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114134535.2455051-1-srasheed@marvell.com>
References: <20231114134535.2455051-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GikNC_wqM2QJ-1u8si3NPMUdv7dHLvYj
X-Proofpoint-ORIG-GUID: GikNC_wqM2QJ-1u8si3NPMUdv7dHLvYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

