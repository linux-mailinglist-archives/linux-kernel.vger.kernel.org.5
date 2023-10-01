Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150CB7B488F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjJAQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjJAQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:10:54 -0400
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47989DA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:10:51 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qmz1l-0008CX-Ob; Sun, 01 Oct 2023 18:10:41 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sun, 01 Oct 2023 18:09:56 +0200
Subject: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
X-B4-Tracking: v=1; b=H4sIANOZGWUC/x3MQQqAIBBA0avIrBNGhaiuEhGWUw2RhkoE0d2Tl
 m/x/wOJIlOCTjwQ6eLEwReoSsC8Wb+SZFcMGrVRiErafTzs6imHgzJFOWFtsG2w0c5Bqc5IC9/
 /sR/e9wOgT7D+YQAAAA==
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicity specify array indices to fix mapping between
asahi_compass_chipset and ak_def_array.
While at it, remove unneeded AKXXXX.

Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables")
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/iio/magnetometer/ak8975.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8cfceb007936..dd466c5fa621 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -204,7 +204,6 @@ static long ak09912_raw_to_gauss(u16 data)
 
 /* Compatible Asahi Kasei Compass parts */
 enum asahi_compass_chipset {
-	AKXXXX		= 0,
 	AK8975,
 	AK8963,
 	AK09911,
@@ -248,7 +247,7 @@ struct ak_def {
 };
 
 static const struct ak_def ak_def_array[] = {
-	{
+	[AK8975] = {
 		.type = AK8975,
 		.raw_to_gauss = ak8975_raw_to_gauss,
 		.range = 4096,
@@ -273,7 +272,7 @@ static const struct ak_def ak_def_array[] = {
 			AK8975_REG_HYL,
 			AK8975_REG_HZL},
 	},
-	{
+	[AK8963] = {
 		.type = AK8963,
 		.raw_to_gauss = ak8963_09911_raw_to_gauss,
 		.range = 8190,
@@ -298,7 +297,7 @@ static const struct ak_def ak_def_array[] = {
 			AK8975_REG_HYL,
 			AK8975_REG_HZL},
 	},
-	{
+	[AK09911] = {
 		.type = AK09911,
 		.raw_to_gauss = ak8963_09911_raw_to_gauss,
 		.range = 8192,
@@ -323,7 +322,7 @@ static const struct ak_def ak_def_array[] = {
 			AK09912_REG_HYL,
 			AK09912_REG_HZL},
 	},
-	{
+	[AK09912] = {
 		.type = AK09912,
 		.raw_to_gauss = ak09912_raw_to_gauss,
 		.range = 32752,
@@ -348,7 +347,7 @@ static const struct ak_def ak_def_array[] = {
 			AK09912_REG_HYL,
 			AK09912_REG_HZL},
 	},
-	{
+	[AK09916] = {
 		.type = AK09916,
 		.raw_to_gauss = ak09912_raw_to_gauss,
 		.range = 32752,

---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20231001-ak_magnetometer-b063098082dd

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

