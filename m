Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD17DE66C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbjKATeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbjKATeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:34:16 -0400
Received: from mx5.spacex.com (mx5.spacex.com [192.31.242.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7581E1A4;
        Wed,  1 Nov 2023 12:33:58 -0700 (PDT)
Received: from pps.filterd (mx5.spacex.com [127.0.0.1])
        by mx5.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Hu1q0017139;
        Wed, 1 Nov 2023 12:19:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=u5nTFczinMbKC419gGXDYXffxQCYXXRjYzsEU4unQ0k=;
 b=NvmSdSR5ABbSrmavaorKKMYNLxlpyZiRkOehW7qqkPQIevR9BBQh8pxfAQIG1SDXZ5hM
 SrCDyZe+Ce+96TAUaC9vOb8MvSomI4VSJR82CdjRxQ+NLMqoUWhpWv731FzwwGu17IzJ
 TPqeaOe4aw3joLcKFiGThnFh35jR7zCPdKvOrVXLQPxLiUVcJsZnv1ZfCjA3briCcJF0
 Ywh0PR4PpAaXwk4jjiBZbzNq/nJi1Z9ycWdnWnH+DRm+gMEJNxhIE7jauqgkDM6m/qxv
 ESOLDMkI8kpFP+zbmHu7FFUwMlbyHcdvxbPR7ZRq66YBofy/YDTnFT9M7q8CDGZdBXjc yA== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx5.spacex.com (PPS) with ESMTPS id 3u0yqn5n2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Nov 2023 12:19:19 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 12:19:19 -0700
From:   <alexey.pakhunov@spacex.com>
To:     <siva.kallam@broadcom.com>
CC:     <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prashant@broadcom.com>,
        <mchan@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH 1/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date:   Wed, 1 Nov 2023 12:18:57 -0700
Message-ID: <20231101191858.2611154-2-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231101191858.2611154-1-alexey.pakhunov@spacex.com>
References: <20231101191858.2611154-1-alexey.pakhunov@spacex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d3-n1.spacex.corp (10.34.3.236) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: _FrkX1jLAm5N8w2rcLZE7T7uOHpH8E4K
X-Proofpoint-GUID: _FrkX1jLAm5N8w2rcLZE7T7uOHpH8E4K
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremeneted accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..99638e6c9e16 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7874,8 +7874,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tp->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.39.3

