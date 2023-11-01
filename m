Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA47DDDF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjKAJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjKAJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:02:34 -0400
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C88F7;
        Wed,  1 Nov 2023 02:02:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1092362|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00441527-0.000454537-0.99513;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VCeegrp_1698829343;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.VCeegrp_1698829343)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 17:02:26 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, liweilei@awinic.com,
        u.kleine-koenig@pengutronix.de, yang.lee@linux.alibaba.com,
        nathan@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] ASoC: codecs: Modify the wrong judgment of re value
Date:   Wed,  1 Nov 2023 17:02:09 +0800
Message-ID: <20231101090211.177125-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101090211.177125-1-wangweidong.a@awinic.com>
References: <20231101090211.177125-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

An error code should be return when the re is greater
than the maximum value or less than the minimum value

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88399.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 1d6228cb1cc2..54f8457e8497 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -486,8 +486,8 @@ static int aw_dev_update_cali_re(struct aw_cali_desc *cali_desc)
 	u32 cali_re;
 	int ret;
 
-	if ((aw_dev->cali_desc.cali_re <= AW88399_CALI_RE_MAX) ||
-			(aw_dev->cali_desc.cali_re >= AW88399_CALI_RE_MIN))
+	if ((aw_dev->cali_desc.cali_re >= AW88399_CALI_RE_MAX) ||
+			(aw_dev->cali_desc.cali_re <= AW88399_CALI_RE_MIN))
 		return -EINVAL;
 
 	cali_re = AW88399_SHOW_RE_TO_DSP_RE((aw_dev->cali_desc.cali_re +
-- 
2.41.0

