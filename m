Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77DE75C675
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGUMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGUMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:04:40 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C13A94;
        Fri, 21 Jul 2023 05:04:17 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L9YEJh006034;
        Fri, 21 Jul 2023 14:04:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=yMYPnlq3CX+IDIIWlWaS3qUmcJLHPYtyYe6d6EzMC/U=;
 b=16U4ld99ILMHnT9772VvZEQEP4HamPG2eZE+s7Z1bGxFvlpzQ+kC1hrdcQRq5eiUoK9X
 6UdhZVl69O+3I0qtVaWXAW/3HcFDwfvluGlkYVLqkRw1gyh+qPb2tKLTaAp0N2UN7a/C
 K1H8qk7sfuz3FsEuF9QLl0Cyl6fSVlHVaaKyYOx8e4BrK8e2QAEhivhh9Ti1NZibc5bs
 gBO3dXFRwSCJO7FDctE7HjCbEPRBZYoFz9/Ac2N3fHe19MLHRXS8vaPoOUqXtzG0hnzv
 4t0Bs+5P06cyn80VSfy3R4rUuCRf9845X8nu530HPOD4DGtz6M5bBCX9mRVAq6FJ5/oy fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ryqgms5gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 14:04:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C70D610003D;
        Fri, 21 Jul 2023 14:04:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0EF2229A68;
        Fri, 21 Jul 2023 14:04:10 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 21 Jul
 2023 14:04:10 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] media: i2c: st_mipid02: cascade s_stream call to the source subdev
Date:   Fri, 21 Jul 2023 14:03:14 +0200
Message-ID: <20230721120316.1172445-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721120316.1172445-1-alain.volmat@foss.st.com>
References: <20230721120316.1172445-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_07,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cascade the s_stream call to the source subdev whenever the bridge
streaming is enable / disabled.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
v2: correct uninitialized ret variable in mipid02_stream_disable

 drivers/media/i2c/st-mipid02.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 906553a28676..ee456bd4cf76 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -545,7 +545,14 @@ static int mipid02_configure_from_code(struct mipid02_dev *bridge)
 static int mipid02_stream_disable(struct mipid02_dev *bridge)
 {
 	struct i2c_client *client = bridge->i2c_client;
-	int ret;
+	int ret = -EINVAL;
+
+	if (!bridge->s_subdev)
+		goto error;
+
+	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 0);
+	if (ret)
+		goto error;
 
 	/* Disable all lanes */
 	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
@@ -633,6 +640,10 @@ static int mipid02_stream_enable(struct mipid02_dev *bridge)
 	if (ret)
 		goto error;
 
+	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 1);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
-- 
2.25.1

