Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830D763323
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGZKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjGZKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:07:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B951BFB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:07:04 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9qH707gKztRSb;
        Wed, 26 Jul 2023 18:03:47 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 18:07:01 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <u.kleine-koenig@pengutronix.de>,
        <javierm@redhat.com>, <dianders@chromium.org>,
        <benjamin.mugnier@foss.st.com>, <kabel@kernel.org>,
        <anarsoul@gmail.com>, <duwe@suse.de>, <mripard@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] drm/bridge: fix -Wunused-const-variable= warning
Date:   Wed, 26 Jul 2023 18:06:26 +0800
Message-ID: <20230726100626.167490-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, the following warning occurs.

drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c:48:17: warning: ‘anx781x_i2c_addresses’ defined but not used [-Wunused-const-variable=]
 static const u8 anx781x_i2c_addresses[] = {
                 ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c:40:17: warning: ‘anx7808_i2c_addresses’ defined but not used [-Wunused-const-variable=]
 static const u8 anx7808_i2c_addresses[] = {

The definition of above two data variables is included by the
macro CONFIG_OF, so we also include the data variable
definitions in the macro CONFIG_OF. And in addition the data
variable anx78xx_match_table is included in the macro CONFIG_OF,
so we add CONFIG_OF to the place where it is used.

Fixes: 5d97408e0d70 ("drm/bridge: move ANA78xx driver to analogix subdirectory")

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 06a3e3243e19..799b33cebdd5 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -37,6 +37,7 @@
 
 #define XTAL_CLK		270 /* 27M */
 
+#if IS_ENABLED(CONFIG_OF)
 static const u8 anx7808_i2c_addresses[] = {
 	[I2C_IDX_TX_P0] = 0x78,
 	[I2C_IDX_TX_P1] = 0x7a,
@@ -52,6 +53,7 @@ static const u8 anx781x_i2c_addresses[] = {
 	[I2C_IDX_RX_P0] = 0x7e,
 	[I2C_IDX_RX_P1] = 0x80,
 };
+#endif
 
 struct anx78xx_platform_data {
 	struct regulator *dvdd10;
@@ -1387,7 +1389,9 @@ MODULE_DEVICE_TABLE(of, anx78xx_match_table);
 static struct i2c_driver anx78xx_driver = {
 	.driver = {
 		   .name = "anx7814",
+#if IS_ENABLED(CONFIG_OF)
 		   .of_match_table = of_match_ptr(anx78xx_match_table),
+#endif
 		  },
 	.probe = anx78xx_i2c_probe,
 	.remove = anx78xx_i2c_remove,
-- 
2.17.1

