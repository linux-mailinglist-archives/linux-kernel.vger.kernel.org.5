Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556617BD29B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 06:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbjJIElH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 00:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjJIElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 00:41:02 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAEDA6;
        Sun,  8 Oct 2023 21:41:01 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 398Nn9vR001402;
        Sun, 8 Oct 2023 21:40:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=uuIo5XIor/wjVh0dvrOlKs3utXBrgZ7EaOP9tSaS5x8=;
 b=VCzAjk2kTFWnsK10/pF6EgAnpvTI3dqpLuB50W+kNpH8p5E1QXj87iFupsejXhLihahw
 1YNEchwtJazPGjQRpCBa2c81yhwFmVqsjmk7yvS0lvq8QcSpI51caWOaEGYAKx9XFwqG
 0WXFDcFKlBWHpv3HsDep1b5p1ugCYqTQBtjixzDVg0ckjlBbO3lRPZqyrnlV72hPP92U
 J9n3Xx8LaDShRbxk+bQxT/gZSB8BSQdaY+pXNwwPszM5maaWX4cNY7gF0xXVi2NDdXDD
 Z2DsSmBUgrwvGRIyyp5lkhTqSwaGx0/qUGOBXMIUoD6jIQxtRg3RtfYdoxnZ58v/JOz+ JQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tkh7caxpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 08 Oct 2023 21:40:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Oct
 2023 21:40:42 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.48 via Frontend Transport; Sun, 8 Oct 2023 21:40:40 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <inux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2] drivers: watchdog: marvell_gti: fix zero pretimeout handling
Date:   Mon, 9 Oct 2023 10:10:36 +0530
Message-ID: <20231009044037.514570-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q5ADRS9OT7OBc5vrGjQku54tNrjeuH8z
X-Proofpoint-ORIG-GUID: q5ADRS9OT7OBc5vrGjQku54tNrjeuH8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_03,2023-10-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pretimeout is set to 0 then do not reprogram timer
with zero timeout, this will reset device immediately.
Also disable interrupt to stop pretimeout notification.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/watchdog/marvell_gti_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
index d7eb8286e11e..25b7ce0f0738 100644
--- a/drivers/watchdog/marvell_gti_wdt.c
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -190,6 +190,13 @@ static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
 	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
 	struct watchdog_device *wdog_dev = &priv->wdev;
 
+	if (!timeout) {
+		/* Disable Interrupt */
+		writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
+		       priv->base + GTI_CWD_INT_ENA_CLR);
+		return 0;
+	}
+
 	/* pretimeout should 1/3 of max_timeout */
 	if (timeout * 3 <= wdog_dev->max_timeout)
 		return gti_wdt_settimeout(wdev, timeout * 3);
-- 
2.34.1

