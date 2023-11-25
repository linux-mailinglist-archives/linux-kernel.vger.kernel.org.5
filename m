Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F467F8D09
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjKYSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKYSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:22:27 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6946C5;
        Sat, 25 Nov 2023 10:22:33 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3APCHQIm014841;
        Sat, 25 Nov 2023 19:21:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=/goBROYTeH/F32rKxIN/0DnppG1ZihAuto8o1t5kprE=; b=aS
        38ssEeprTn0MvTM/CvCVJc+dFdKvppmM1tqn5BKxm8yWFK0Vi3U2rBulkbTxZvPX
        uGsGEDUYL9Vu86fBMaM4cbM3pb5EkGcbZ6z/V+YTsvC9+cHcbKL0ijzjZejk3R5U
        28+Bd7mPl59PX3Zw4uzahmXBTfAF0QGk7G7s2ljvqkQUWWvLYDzlRW6x/z6VUh2o
        /eL3WjHFq6tx20rHoT4AqhW9llHtXnQvNdM8/d5wcG94EDt8aQg6l8y9UBSYHTUW
        4+ul+5KTZtpL0lWAExwlm9keF8LJBqVLukonyPrzi8gGWEr94JXNB9wYx9uj3QSz
        0YqMLqxBgz7ugnJvij3Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk951hvn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 19:21:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42D0510002A;
        Sat, 25 Nov 2023 19:21:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3972823C6A4;
        Sat, 25 Nov 2023 19:21:57 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 19:21:58 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] media: i2c: st-mipid02: don't keep track of streaming status
Date:   Sat, 25 Nov 2023 19:20:50 +0100
Message-ID: <20231125182057.1379357-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231125182057.1379357-1-alain.volmat@foss.st.com>
References: <20231125182057.1379357-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_17,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in the following series, subdev do not have to keep
track of their streaming status:

https://lore.kernel.org/linux-media/20230914181704.4811-1-laurent.pinchart@ideasonboard.com/

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index b699f0b4efe7..1efaa54866a8 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -112,7 +112,6 @@ struct mipid02_dev {
 	} r;
 	/* lock to protect all members below */
 	struct mutex lock;
-	bool streaming;
 	struct v4l2_mbus_framefmt fmt;
 };
 
@@ -629,22 +628,13 @@ static int mipid02_s_stream(struct v4l2_subdev *sd, int enable)
 	struct i2c_client *client = bridge->i2c_client;
 	int ret = 0;
 
-	dev_dbg(&client->dev, "%s : requested %d / current = %d", __func__,
-		    enable, bridge->streaming);
-	mutex_lock(&bridge->lock);
-
-	if (bridge->streaming == enable)
-		goto out;
+	dev_dbg(&client->dev, "%s : requested %d\n", __func__, enable);
 
 	ret = enable ? mipid02_stream_enable(bridge) :
 		       mipid02_stream_disable(bridge);
-	if (!ret)
-		bridge->streaming = enable;
-
-out:
-	dev_dbg(&client->dev, "%s current now = %d / %d", __func__,
-		    bridge->streaming, ret);
-	mutex_unlock(&bridge->lock);
+	if (ret)
+		dev_err(&client->dev, "failed to stream %s (%d)\n",
+			enable ? "enable" : "disable", ret);
 
 	return ret;
 }
@@ -777,20 +767,14 @@ static int mipid02_set_fmt(struct v4l2_subdev *sd,
 
 	mutex_lock(&bridge->lock);
 
-	if (bridge->streaming) {
-		ret = -EBUSY;
-		goto error;
-	}
-
 	if (format->pad == MIPID02_SOURCE)
 		mipid02_set_fmt_source(sd, sd_state, format);
 	else
 		mipid02_set_fmt_sink(sd, sd_state, format);
 
-error:
 	mutex_unlock(&bridge->lock);
 
-	return ret;
+	return 0;
 }
 
 static const struct v4l2_subdev_video_ops mipid02_video_ops = {
-- 
2.25.1

