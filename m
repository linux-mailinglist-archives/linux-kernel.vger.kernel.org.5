Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1976E71B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjHCLj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjHCLjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:39:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8F1BF0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:39:53 -0700 (PDT)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGn130RlBzrS9j;
        Thu,  3 Aug 2023 19:38:47 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:39:51 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 19:39:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <okan.sahin@analog.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] regulator: max77857: fix build error in max77857-regulator.c
Date:   Thu, 3 Aug 2023 19:36:54 +0800
Message-ID: <20230803113654.818640-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using low verion gcc(7.5) to build the max77857-regulator driver,
got the following error:

drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not constant
  .ramp_delay = max77857_ramp_table[0][0],

To fix this by introducing a macro RAMAP_DELAY_INIT_VAL to define the
value of max77857_ramp_table[0[0].

Fixes: af71cccadece ("regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
I notice this build error has been in -next a while, and it hasn't been fixed yet,
so I tried to fix this. If it was already fixed in other way, ignore this patch.
---
 drivers/regulator/max77857-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index f2141b5be780..44a510547318 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -293,8 +293,10 @@ static const unsigned int max77857_switch_freq[] = {
 	1200000, 1500000, 1800000, 2100000
 };
 
+#define RAMAP_DELAY_INIT_VAL 1333
+
 static const unsigned int max77857_ramp_table[2][4] = {
-	{ 1333, 667, 333, 227 }, /* when switch freq is 1.8MHz or 2.1MHz */
+	{ RAMAP_DELAY_INIT_VAL, 667, 333, 227 }, /* when switch freq is 1.8MHz or 2.1MHz */
 	{ 1166, 667, 333, 167 }, /* when switch freq is 1.2MHz or 1.5MHz */
 };
 
@@ -309,7 +311,7 @@ static struct regulator_desc max77857_regulator_desc = {
 	.n_ramp_values = ARRAY_SIZE(max77857_ramp_table[0]),
 	.ramp_reg = MAX77857_REG_CONT3,
 	.ramp_mask = GENMASK(1, 0),
-	.ramp_delay = max77857_ramp_table[0][0],
+	.ramp_delay = RAMAP_DELAY_INIT_VAL,
 	.owner = THIS_MODULE,
 };
 
-- 
2.25.1

