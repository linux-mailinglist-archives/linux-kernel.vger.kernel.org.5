Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1307D352D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjJWLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjJWLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:45:31 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4127F1705;
        Mon, 23 Oct 2023 04:45:26 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MLgvgB028356;
        Mon, 23 Oct 2023 04:45:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=UH9OxHXbOjRhxSx5V7Clo000R+zwqhWrGr3Zie/QOlk=;
 b=IeSKqjleSZ24eHARBpDON5VP4jPWkfz1nV/B8MxS/ZwUUXzl67bPyTFk9RjCKBN9Bj3L
 iqpF10YXvBzFpSUkTsuWViT5JeQ8ZRN1oeGIJ3y/Ejc8+mqUgmJPMLOOU/hnYrBfgrFk
 WVSUTT8L3+WDQjFjcb05XO4ohWwSBC2g8hQ88VEKwVRT1HEwwEl7AtG7g0R4k0ggiyFR
 eaA7IiFjhesuGo6S/BsbN9SgJfVZYr7Ouh+S/LQsDiOrEZsm+Ozb85QKLhMRmmxzDm4l
 IRcw77pJeYWuBLkcMwy4s3KDjRbXxkxQmrVDqcuP/LYSXgEdsVNI54e7iobGKQq6JEA2 ug== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tve5mwjmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 04:45:07 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 04:45:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 23 Oct 2023 04:45:05 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 6F3A43F7051;
        Mon, 23 Oct 2023 04:45:05 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 1/3] octeon_ep: remove dma sync in trasmit path
Date:   Mon, 23 Oct 2023 04:44:46 -0700
Message-ID: <20231023114449.2362147-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023114449.2362147-1-srasheed@marvell.com>
References: <20231023114449.2362147-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DdNf9PQmRGDudRphlSMWOwySR6GRBYSI
X-Proofpoint-GUID: DdNf9PQmRGDudRphlSMWOwySR6GRBYSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_09,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup dma sync calls for scatter gather
mappings in trasmit path

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 552970c7dec0..bf1e376a4232 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -869,9 +869,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		if (dma_mapping_error(iq->dev, dma))
 			goto dma_map_err;
 
-		dma_sync_single_for_cpu(iq->dev, tx_buffer->sglist_dma,
-					OCTEP_SGLIST_SIZE_PER_PKT,
-					DMA_TO_DEVICE);
 		memset(sglist, 0, OCTEP_SGLIST_SIZE_PER_PKT);
 		sglist[0].len[3] = len;
 		sglist[0].dma_ptr[0] = dma;
@@ -891,10 +888,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 			frag++;
 			si++;
 		}
-		dma_sync_single_for_device(iq->dev, tx_buffer->sglist_dma,
-					   OCTEP_SGLIST_SIZE_PER_PKT,
-					   DMA_TO_DEVICE);
-
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
-- 
2.25.1

