Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE34F7D9796
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbjJ0MRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345802AbjJ0MRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:17:05 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0EC0;
        Fri, 27 Oct 2023 05:17:03 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5TnXB012400;
        Fri, 27 Oct 2023 05:16:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=fSqhxtS/1AmnssqhTQOzpYaNfkzU3t8Jj5QZNarTP9M=;
 b=ERFzmM95gEeY82VS4DxohelNb97pXld4kfoPOxb11uVV1myYkkaFKA4aS7mPh7s6KV9d
 EXGBX9wtBA7KT5XNrxCxRc8nbZhvBv/UmK4nbyIoL3PAtl715wVCJzS9cvjzm8e2SSAS
 kbyRmLdrWN5MstcVGDLETlfL0lt9oRy0YQFiMOwxl811K7mjfquCkEaSnKMdQR7ZWrE4
 iFXO75vdZiK7YjaLBdFD88K5tHsL9RqddaI0rzcg/RuBBrFi+bzaTi5xeGBrog0o25xY
 skC7I7b43lWIMyilleCSMmmankLTh1zfK48vt8VxdsYFvQeBtwQ1//bN1LjSy2w4I8xX lQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tywr83b33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 05:16:57 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 27 Oct
 2023 05:16:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 27 Oct 2023 05:16:56 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id E71B03F7050;
        Fri, 27 Oct 2023 05:16:55 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v3 2/4] octeon_ep: remove dma sync in trasmit path
Date:   Fri, 27 Oct 2023 05:16:37 -0700
Message-ID: <20231027121639.2382565-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027121639.2382565-1-srasheed@marvell.com>
References: <20231027121639.2382565-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1-PWzt5bDtpitJb4IAJ7x93ZNFmBZOYr
X-Proofpoint-ORIG-GUID: 1-PWzt5bDtpitJb4IAJ7x93ZNFmBZOYr
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

Cleanup dma sync calls for scatter gather
mappings, since they are coherent allocations
and do not need explicit sync to be called.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - No changes.
V2: https://lore.kernel.org/all/20231024145119.2366588-3-srasheed@marvell.com/
  - Provided more details in changelog
V1: https://lore.kernel.org/all/20231023114449.2362147-2-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 2c86b911a380..1c02304677c9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -872,9 +872,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		if (dma_mapping_error(iq->dev, dma))
 			goto dma_map_err;
 
-		dma_sync_single_for_cpu(iq->dev, tx_buffer->sglist_dma,
-					OCTEP_SGLIST_SIZE_PER_PKT,
-					DMA_TO_DEVICE);
 		memset(sglist, 0, OCTEP_SGLIST_SIZE_PER_PKT);
 		sglist[0].len[3] = len;
 		sglist[0].dma_ptr[0] = dma;
@@ -894,10 +891,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
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

