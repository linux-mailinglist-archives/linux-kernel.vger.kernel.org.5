Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C757C9EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjJPFfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjJPFfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:35:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A5911D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:35:18 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G5ZBztC2174365, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G5ZBztC2174365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 13:35:11 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 16 Oct 2023 13:35:12 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Oct 2023 13:35:10 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Mon, 16 Oct 2023 13:35:10 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH extcon-next] extcon: realtek: add the error handler for nvmem_cell_read
Date:   Mon, 16 Oct 2023 13:35:04 +0800
Message-ID: <20231016053510.28881-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS06.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are following smatch warning:
drivers/extcon/extcon-rtk-type-c.c:905 __updated_type_c_parameter_by_efuse()
error: 'buf' dereferencing possible ERR_PTR()

The nvmem_cell_read may fail to read. So, driver must handle failure cases.

Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a469dd51-f5d5-4e8f-ba36-6c7cea046fb8@moroto.mountain/
Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/extcon/extcon-rtk-type-c.c | 86 +++++++++++++++---------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 00465cfba23e..a592bab77538 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -901,25 +901,26 @@ static int __updated_type_c_parameter_by_efuse(struct type_c_data *type_c)
 		int value_mask = (BIT(value_size) - 1);
 
 		buf = nvmem_cell_read(cell, &buf_size);
-
-		cc1_0p2v = get_value((buf[0] >> value_size * 0) & value_mask);
-		cc1_0p8v = get_value((buf[0] >> value_size * 1) & value_mask);
-		cc1_2p6v = get_value((buf[1] >> value_size * 0) & value_mask);
-		cc1_0p66v = get_value((buf[1] >> value_size * 1) & value_mask);
-		cc1_1p23v = get_value((buf[2] >> value_size * 0) & value_mask);
-
-		cc2_0p2v = get_value((buf[3] >> value_size * 0) & value_mask);
-		cc2_0p8v = get_value((buf[3] >> value_size * 1) & value_mask);
-		cc2_2p6v = get_value((buf[4] >> value_size * 0) & value_mask);
-		cc2_0p66v = get_value((buf[4] >> value_size * 1) & value_mask);
-		cc2_1p23v = get_value((buf[5] >> value_size * 0) & value_mask);
-
-		cc1_4p7k = get_value((buf[6] >> value_size * 0) & value_mask);
-		cc1_12k = get_value((buf[6] >> value_size * 1) & value_mask);
-		cc2_4p7k = get_value((buf[7] >> value_size * 0) & value_mask);
-		cc2_12k = get_value((buf[7] >> value_size * 1) & value_mask);
-
-		kfree(buf);
+		if (!IS_ERR(buf)) {
+			cc1_0p2v = get_value((buf[0] >> value_size * 0) & value_mask);
+			cc1_0p8v = get_value((buf[0] >> value_size * 1) & value_mask);
+			cc1_2p6v = get_value((buf[1] >> value_size * 0) & value_mask);
+			cc1_0p66v = get_value((buf[1] >> value_size * 1) & value_mask);
+			cc1_1p23v = get_value((buf[2] >> value_size * 0) & value_mask);
+
+			cc2_0p2v = get_value((buf[3] >> value_size * 0) & value_mask);
+			cc2_0p8v = get_value((buf[3] >> value_size * 1) & value_mask);
+			cc2_2p6v = get_value((buf[4] >> value_size * 0) & value_mask);
+			cc2_0p66v = get_value((buf[4] >> value_size * 1) & value_mask);
+			cc2_1p23v = get_value((buf[5] >> value_size * 0) & value_mask);
+
+			cc1_4p7k = get_value((buf[6] >> value_size * 0) & value_mask);
+			cc1_12k = get_value((buf[6] >> value_size * 1) & value_mask);
+			cc2_4p7k = get_value((buf[7] >> value_size * 0) & value_mask);
+			cc2_12k = get_value((buf[7] >> value_size * 1) & value_mask);
+
+			kfree(buf);
+		}
 		nvmem_cell_put(cell);
 	}
 
@@ -984,29 +985,30 @@ static int __updated_type_c_parameter_by_efuse_v2(struct type_c_data *type_c)
 		int value_mask = (BIT(value_size) - 1);
 
 		buf = nvmem_cell_read(cell, &buf_size);
-
-		value_size = 5;
-		value_mask = (BIT(value_size) - 1);
-		cc1_4p7k = buf[0] & value_mask;
-		cc1_12k = buf[1] & value_mask;
-		cc2_4p7k = buf[2] & value_mask;
-		cc2_12k = buf[3] & value_mask;
-
-		value_size = 4;
-		value_mask = (BIT(value_size) - 1);
-		cc1_0p2v = (buf[4] >> value_size * 0) & value_mask;
-		cc1_0p66v = (buf[4] >> value_size * 1) & value_mask;
-		cc1_0p8v = (buf[5] >> value_size * 0) & value_mask;
-		cc1_1p23v = (buf[5] >> value_size * 1) & value_mask;
-		cc1_2p6v = (buf[6] >> value_size * 0) & value_mask;
-
-		cc2_0p2v = (buf[6] >> value_size * 1) & value_mask;
-		cc2_0p66v = (buf[7] >> value_size * 0) & value_mask;
-		cc2_0p8v = (buf[7] >> value_size * 1) & value_mask;
-		cc2_1p23v = (buf[8] >> value_size * 0) & value_mask;
-		cc2_2p6v = (buf[8] >> value_size * 1) & value_mask;
-
-		kfree(buf);
+		if (!IS_ERR(buf)) {
+			value_size = 5;
+			value_mask = (BIT(value_size) - 1);
+			cc1_4p7k = buf[0] & value_mask;
+			cc1_12k = buf[1] & value_mask;
+			cc2_4p7k = buf[2] & value_mask;
+			cc2_12k = buf[3] & value_mask;
+
+			value_size = 4;
+			value_mask = (BIT(value_size) - 1);
+			cc1_0p2v = (buf[4] >> value_size * 0) & value_mask;
+			cc1_0p66v = (buf[4] >> value_size * 1) & value_mask;
+			cc1_0p8v = (buf[5] >> value_size * 0) & value_mask;
+			cc1_1p23v = (buf[5] >> value_size * 1) & value_mask;
+			cc1_2p6v = (buf[6] >> value_size * 0) & value_mask;
+
+			cc2_0p2v = (buf[6] >> value_size * 1) & value_mask;
+			cc2_0p66v = (buf[7] >> value_size * 0) & value_mask;
+			cc2_0p8v = (buf[7] >> value_size * 1) & value_mask;
+			cc2_1p23v = (buf[8] >> value_size * 0) & value_mask;
+			cc2_2p6v = (buf[8] >> value_size * 1) & value_mask;
+
+			kfree(buf);
+		}
 		nvmem_cell_put(cell);
 	}
 
-- 
2.34.1

