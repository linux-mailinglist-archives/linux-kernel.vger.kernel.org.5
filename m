Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28C7E4E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjKHBBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjKHBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:01:47 -0500
Received: from mx3.spacex.com (mx3.spacex.com [192.31.242.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08D181;
        Tue,  7 Nov 2023 17:01:44 -0800 (PST)
Received: from pps.filterd (mx3.spacex.com [127.0.0.1])
        by mx3.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7NjQoC029456;
        Tue, 7 Nov 2023 17:01:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=FEotA3f6EOvh2XKa4biciMIfyU1qQG5shB11DIutpz4=;
 b=iNaKXBIesqVEw95Hkoosgd0VB8d4X19erlMUq6iJz8JT8AQTDmeRwVWp79Iuqj3RbXkM
 HzlkgSjQ/ZKroYFVAqbp4oNOenJE3j7g0q6ErEgReneMa2hlj7+Pkg/2L2DxRIKFEDcI
 4RdjcxyIgdxp7pc0NFpa0/wSyx2QX5GNwM1Uzz97vuZAYIGROsWM1PBDwCfqawsFIg3p
 GaTI2VQEZJnBBA6LGx6VMHYE8KeoS61DaS9DMxcXLGHvr9EP3MTMfESpv4WMRXxFvpZv
 98mua/POh0Uckojr3kc9gGujqbEZD0epmrzi30WSBiUYdWlJBvJcvEefrka5+9B/gv39 tw== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx3.spacex.com (PPS) with ESMTPS id 3u7w328a1a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Nov 2023 17:01:42 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 17:01:42 -0800
From:   <alexey.pakhunov@spacex.com>
To:     <mchan@broadcom.com>
CC:     <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <siva.kallam@broadcom.com>,
        <prashant@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH 2/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date:   Tue, 7 Nov 2023 17:01:29 -0800
Message-ID: <20231108010129.2009947-2-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231108010129.2009947-1-alexey.pakhunov@spacex.com>
References: <20231108010129.2009947-1-alexey.pakhunov@spacex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d3-n2.spacex.corp (10.34.3.237) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: ip6jfA7HNXAtq2rAybYH6DAmWGt8XBT-
X-Proofpoint-GUID: ip6jfA7HNXAtq2rAybYH6DAmWGt8XBT-
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 09acc2504965..264d6aff67e7 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7874,8 +7874,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.39.3

