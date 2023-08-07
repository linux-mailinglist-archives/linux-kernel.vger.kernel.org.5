Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B0772646
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjHGNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjHGNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:43:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75BE54
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:42:40 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKHTT2fHmzNmlS;
        Mon,  7 Aug 2023 21:38:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 21:42:04 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] regulator: rpi-panel-attiny-regulator: Remove redundant of_match_ptr()
Date:   Mon, 7 Aug 2023 21:41:27 +0800
Message-ID: <20230807134127.2380390-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here, and __maybe_unused can also be removed.

Even for drivers that do not depend on CONFIG_OF, it's almost always
better to leave out the of_match_ptr(), since the only thing it can
possibly do is to save a few bytes of .text if a driver can be used both
with and without it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index e9719a378a0b..ed046cc998c6 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -397,7 +397,7 @@ static struct i2c_driver attiny_regulator_driver = {
 	.driver = {
 		.name = "rpi_touchscreen_attiny",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(attiny_dt_ids),
+		.of_match_table = attiny_dt_ids,
 	},
 	.probe = attiny_i2c_probe,
 	.remove	= attiny_i2c_remove,
-- 
2.34.1

