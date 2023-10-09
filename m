Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC767BD29A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 06:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbjJIElE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 00:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJIElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 00:41:02 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0BAA4;
        Sun,  8 Oct 2023 21:41:00 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3991owPD016392;
        Sun, 8 Oct 2023 21:40:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=e1E4yBbuRVcGbbzNG/kLtyea/YcE+LVDiDlx6i6u478=;
 b=AlPKvwJ7PUEjT3IinleEIg6ZYrJVKMaxC3X5Hfau6Vx0SxTviufzcP3+A+V3JMhWwMK8
 AWGIkJpPx+N9Jz5lKHIkknpb+XFerEyoAoNJHCVK07TQ4TR0BHADoCa0IJAcjzTj+gSk
 xLx6YT/SNS/4bHb0La2pEKBIR7H2XOMWK2zSgCIhfiQLCpVk08w2GUH2H9bTv3cMqieN
 OTmKVUDlenp8MmzXjhsOX9NADaYWYykTGJJd7W/3Xnouvre1H7UUQR9L0FBGeNgm5lU5
 y1WLEE8WnfEntMTtxn6wvwRCA6iRnA8bIJuxrjPK8QUAw7FYEqg3mHNw9pfvhK2yxOdy vQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tkh9sjvqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 08 Oct 2023 21:40:47 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Oct
 2023 21:40:45 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.48 via Frontend Transport; Sun, 8 Oct 2023 21:40:43 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <inux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     George Cherian <george.cherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 2/2] drivers: watchdog: marvell_gti: Program the max_hw_heartbeat_ms
Date:   Mon, 9 Oct 2023 10:10:37 +0530
Message-ID: <20231009044037.514570-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009044037.514570-1-bbhushan2@marvell.com>
References: <20231009044037.514570-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rwdaYs0aa5hyAwzRWiuQo8KHa-EKl7bv
X-Proofpoint-ORIG-GUID: rwdaYs0aa5hyAwzRWiuQo8KHa-EKl7bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_02,2023-10-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Cherian <george.cherian@marvell.com>

Program the max_hw_heartbeat_ms value so that the watchdog_pretimeout
worker is activated. This kernel worker thread makes sure to ping the
watchdog in case the userspace is unable to do so. This kernel worker
ping will be done only till the full watchdog timeout there by
maintaining the watchdog functionality in case of a real hang.

Signed-off-by: George Cherian <george.cherian@marvell.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/watchdog/marvell_gti_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
index 25b7ce0f0738..bfe0c819248c 100644
--- a/drivers/watchdog/marvell_gti_wdt.c
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -299,6 +299,7 @@ static int gti_wdt_probe(struct platform_device *pdev)
 
 	/* Maximum timeout is 3 times the pretimeout */
 	wdog_dev->max_timeout = max_pretimeout * 3;
+	wdog_dev->max_hw_heartbeat_ms = max_pretimeout * 1000;
 	/* Minimum first timeout (pretimeout) is 1, so min_timeout as 3 */
 	wdog_dev->min_timeout = 3;
 	wdog_dev->timeout = wdog_dev->pretimeout;
-- 
2.34.1

