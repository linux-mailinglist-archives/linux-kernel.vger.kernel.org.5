Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1540A7EA2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjKMSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjKMSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:24:09 -0500
Received: from mx4.spacex.com (mx4.spacex.com [192.31.242.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D10C10EC;
        Mon, 13 Nov 2023 10:24:04 -0800 (PST)
Received: from pps.filterd (mx4.spacex.com [127.0.0.1])
        by mx4.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADG7t2E018529;
        Mon, 13 Nov 2023 10:24:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=9PwXSZhs5eN9izx+6WlQZ4f+IkcEvevGOy44aiqLgPQ=;
 b=jzeqyVKER4b6yH0ug3KoFg7uCZ+Y5srFQFq2lSl+WHCdycYLY0OYYQIXNjW1gUaioNTR
 Lr36yYalnhS9V4B8uynUQ9dS+nzOauZiY2QZovzeUta6kfK9j7KCW0An3ankt+eWkb9S
 ucAJanCb3ql82muodP3b9AZL2jFMjwcU6TqkW6zPUGc5rEm8mkCiAp2KczN/NRFHmryu
 NqcMLRMRMgWnGzx9nwJltUEWe1GWnwbPo4UPp9xWECoax/oLao5DmhRj3lgeLVZQrLpf
 DkWaHcI24l4zMp+raHfuUi4D0cDVvV/m/+j9aOlKNVO3s7yqf8vOe6aV+cXr+WSxLcPG 9Q== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx4.spacex.com (PPS) with ESMTPS id 3ua7wsa7dn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Nov 2023 10:24:02 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 10:24:01 -0800
From:   <alexey.pakhunov@spacex.com>
To:     <mchan@broadcom.com>
CC:     <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <siva.kallam@broadcom.com>,
        <prashant@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH v4 2/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date:   Mon, 13 Nov 2023 10:23:50 -0800
Message-ID: <20231113182350.37472-2-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
References: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d4-n3.spacex.corp (10.34.3.241) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-GUID: 4DJbNHEJmv9hTcKcCt7qYG5kG963TETl
X-Proofpoint-ORIG-GUID: 4DJbNHEJmv9hTcKcCt7qYG5kG963TETl
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index dcaf97198ac2..8f22b4cdc31f 100644
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

