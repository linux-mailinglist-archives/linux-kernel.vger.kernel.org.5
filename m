Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40217FEA06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344739AbjK3H6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344719AbjK3H6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:58:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A2A3;
        Wed, 29 Nov 2023 23:58:38 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU7NER1027662;
        Wed, 29 Nov 2023 23:58:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=w6KvSFjmYmnKUl+4DYgSmLN/LV4utOciJLD5bCbmYHo=;
 b=DNrz249xa/pVTvuee6x20b9dhBYF1pl8BZ37/eVURo/CkzpAVQz6PIen6KC2nsWO+c6A
 pyQH1NkqEa97Ey5mCBNGwb5FkDOEL16xFLjITGy/GnACHvCdS82xXvcigq8JSkGI0QEC
 fCStx7G9XBimv6ILNZC6hnZFp8arHahEmdchaRJh8jTb4pzitNHLwhhayQrc4jlvkbyq
 jsR9g8NV4DH45A2sC3PL+Ctp0cxoE+HuIa8GY0o+V1sad0A4q74Z83rxdxX+dzhtgPeB
 9a3045GTqCJmI9h0d5yd626Gsaa9MsZ9797XKnnGG3gmG7czHkFCwdwGGFubcmWe85rj oA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3upc1v2hyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 23:58:33 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 23:58:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 29 Nov 2023 23:58:31 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 0EA6E3F7044;
        Wed, 29 Nov 2023 23:58:27 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v3 PATCH 2/5] octeontx2-af: Fix mcs sa cam entries size
Date:   Thu, 30 Nov 2023 13:28:15 +0530
Message-ID: <20231130075818.18401-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130075818.18401-1-gakula@marvell.com>
References: <20231130075818.18401-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: oQNxiL4JNiyNpS35ro75VEZcBEh7VomU
X-Proofpoint-ORIG-GUID: oQNxiL4JNiyNpS35ro75VEZcBEh7VomU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_05,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On latest silicon versions SA cam entries increased to 256.
This patch fixes the datatype of sa_entries in mcs_hw_info
struct to u16 to hold 256 entries.

Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port related operations")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 6845556581c3..5df42634ceb8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1945,7 +1945,7 @@ struct mcs_hw_info {
 	u8 tcam_entries;	/* RX/TX Tcam entries per mcs block */
 	u8 secy_entries;	/* RX/TX SECY entries per mcs block */
 	u8 sc_entries;		/* RX/TX SC CAM entries per mcs block */
-	u8 sa_entries;		/* PN table entries = SA entries */
+	u16 sa_entries;		/* PN table entries = SA entries */
 	u64 rsvd[16];
 };
 
-- 
2.25.1

