Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2D76CA86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHBKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjHBKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:10:26 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 03:10:15 PDT
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DB2701
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:10:15 -0700 (PDT)
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Aug
 2023 18:09:10 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Aug 2023 18:09:10 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <alexandre.belloni@bootlin.com>, <billy_tsai@aspeedtech.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] i3c/master: cmd_v1: Fix the exit criteria for the daa procedure
Date:   Wed, 2 Aug 2023 18:09:09 +0800
Message-ID: <20230802100909.2568215-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: Fail (TWMBX02.aspeed.com: domain of billy_tsai@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exit criteria for the DAA should check if the data length is equal to
1, instead of checking if the response status is equal to 1.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index d97c3175e0e2..6a781f89b0e4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -339,7 +339,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 			break;
 		}
 		if (RESP_STATUS(xfer[0].response) == RESP_ERR_NACK &&
-		    RESP_STATUS(xfer[0].response) == 1) {
+		    RESP_DATA_LENGTH(xfer->response) == 1) {
 			ret = 0;  /* no more devices to be assigned */
 			break;
 		}
-- 
2.25.1

