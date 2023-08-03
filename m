Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9614F76E38F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjHCIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjHCIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:48:09 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6773FC;
        Thu,  3 Aug 2023 01:48:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VoyDIp8_1691052474;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VoyDIp8_1691052474)
          by smtp.aliyun-inc.com;
          Thu, 03 Aug 2023 16:48:03 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] 8250_men_mcb: Fix unsigned comparison with less than zero
Date:   Thu,  3 Aug 2023 16:47:53 +0800
Message-Id: <20230803084753.51253-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data->line[i] is defined as unsigned int type, if(data->line[i] < 0)
is invalid, so replace data->line[i] with res.

./drivers/tty/serial/8250/8250_men_mcb.c:223:6-19: WARNING: Unsigned expression compared with zero: data->line[i] < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6088
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 5f301195575d..c27c52d18dfa 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -222,11 +222,13 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 					    + data->offset[i];
 
 		/* ok, register the port */
-		data->line[i] = serial8250_register_8250_port(&uart);
-		if (data->line[i] < 0) {
+		res = serial8250_register_8250_port(&uart);
+		if (res < 0) {
 			dev_err(&mdev->dev, "unable to register UART port\n");
-			return data->line[i];
+			return res;
 		}
+
+		data->line[i] = res;
 		dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data->line[i]);
 	}
 
-- 
2.20.1.7.g153144c

