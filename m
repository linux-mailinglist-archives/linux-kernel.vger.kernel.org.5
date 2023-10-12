Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C47C6AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbjJLKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjJLKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:17:25 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FBA9;
        Thu, 12 Oct 2023 03:17:23 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C7bZTp017956;
        Thu, 12 Oct 2023 03:17:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=d+djpV289X90GjGTImlyzR3rGGKFxtvJnllV5lv1v8M=;
 b=k6JFntva6WFn24kjphD5nkC99GQjwno96LU2hXXwicvzLPJQXVDBvX3sS2jobt318uo+
 BE4KzyPuIgZl1ZC1WPDFkeNc0PEEb5yWGk6OhrmPPlDJ5xIgGKR/fyJlFNgv+cWq8Ldm
 /yuc1td3yPf5+TF2iFL8QBHXGI1ANl8FflFrpe6tF35vYzcc1XBVGtTz+6Gn60WE8w98
 ab7QFDyvjBT9J8pCWFYjfS8PHLAjR1uaY4a4LpLiF5XEQjXowNIDkWECRi8If1xqAfAZ
 c47tDTcmURoWtu1KdyjCMZJZ0DiSY4WW372N6gFVRkbTctN3Ylob5pNovUUgc43CFYav Bg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tp2pajs97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 03:17:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 12 Oct
 2023 03:17:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 12 Oct 2023 03:17:10 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 629AA3F7089;
        Thu, 12 Oct 2023 03:17:10 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
        <hgani@marvell.com>, <kuba@kernel.org>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <srasheed@marvell.com>,
        <sedara@marvell.com>, <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: [net PATCH v2] octeon_ep: update BQL sent bytes before ringing doorbell
Date:   Thu, 12 Oct 2023 03:17:06 -0700
Message-ID: <20231012101706.2291551-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o_Q5_OqbUIffA3x3swIX-MUTG36zW6eh
X-Proofpoint-ORIG-GUID: o_Q5_OqbUIffA3x3swIX-MUTG36zW6eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes Tx is completed immediately after doorbell is updated, which
causes Tx completion routing to update completion bytes before the
same packet bytes are updated in sent bytes in transmit function, hence
hitting BUG_ON() in dql_completed(). To avoid this, update BQL
sent bytes before ringing doorbell.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V1 -> V2: Call netdev_tx_sent_queue before memory barrier

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index dbc518ff8276..15420325aef3 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -715,6 +715,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
+	netdev_tx_sent_queue(iq->netdev_q, skb->len);
 	/* Flush the hw descriptor before writing to doorbell */
 	wmb();
 
@@ -726,7 +727,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		wi = 0;
 	iq->host_write_index = wi;
 
-	netdev_tx_sent_queue(iq->netdev_q, skb->len);
 	iq->stats.instr_posted++;
 	skb_tx_timestamp(skb);
 	return NETDEV_TX_OK;
-- 
2.25.1

