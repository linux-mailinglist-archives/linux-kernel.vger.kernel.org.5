Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A32804BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbjLEIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344765AbjLEIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:04:53 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069D18B;
        Tue,  5 Dec 2023 00:04:57 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56OhYJ010808;
        Tue, 5 Dec 2023 00:04:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=w6KvSFjmYmnKUl+4DYgSmLN/LV4utOciJLD5bCbmYHo=;
 b=dCBP0ZjC8aNxrVcBEkaR+M2sFaOseTOSuy8C4JrFlmB+5l2rJrfklAITjApeS2QDK+u7
 dsuLAwSWn02J33pfnzht3N35wTXR8yKC35lN1yJZhznmIWMl8JjQ+qOeEwRTyNL8jHRX
 0He4+tzHDR9OOlb2PBchgNzxy9nlZdzdDHEb9vtJ/YQflrnQNQlyPMTbWgI9HeTt8uFE
 ak3InvzUlVrLz1eBj9kibnNgq3yChbV6KKqTrDHbgFHPdQslrCHvVYiIzkh6KA6MYXIW
 q3p3RX12Z1T6O811BnKmVqzYDVV/QdC+QxPTc/QxCwx0a/33IBxldB18pM8hIC9dowok aw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ur4yrrq4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 00:04:50 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 00:04:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Dec 2023 00:04:48 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 815CE3F70A6;
        Tue,  5 Dec 2023 00:04:44 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v4 PATCH 2/5] octeontx2-af: Fix mcs sa cam entries size
Date:   Tue, 5 Dec 2023 13:34:31 +0530
Message-ID: <20231205080434.27604-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231205080434.27604-1-gakula@marvell.com>
References: <20231205080434.27604-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: pRBXSOufZGn4a9gYFu7Dx5SGjRzxHkvO
X-Proofpoint-ORIG-GUID: pRBXSOufZGn4a9gYFu7Dx5SGjRzxHkvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
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

