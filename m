Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7D7E9F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjKMO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:58:01 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62668132;
        Mon, 13 Nov 2023 06:57:57 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ADB72Xl018219;
        Mon, 13 Nov 2023 15:57:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=leYW5zo
        NQ+ApABUs14mu1OjZ7G1VzudQ+i7kL1VaH9Y=; b=X6Nd/GUtFsddjGOAuGw+JSn
        CA9LzJfviWzSLHi9EE3Iz8OnaJgcLbGFndBuhT0VZGsBTuWspFErBRFF25aG9Gw1
        +aH977PuOnXxCjhee8RRwCVJOPPx124SwrsmCsBpG6sVuDuLjo9clfHIMHhqvaCv
        T0awNCvTGqa4NOhViOvu8eVJAzH/4VvCJ3VPsQSU93gmicCSUFYX5TMDA5ga4SVI
        Nnf4YaOqv1iZGHHiNecYAg2EO8GbtoOphTJeoZgTcqY4cn49f9Z+L9WScERcoMz+
        7vUMjEg+1AWDQOk+dRmaD4bPqlPXeZm6SFEdpMyhJfveCuP4jMGq7wCFBtLRp6w=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1cgypa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 15:57:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44CA910005B;
        Mon, 13 Nov 2023 15:57:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3AC6D21ED28;
        Mon, 13 Nov 2023 15:57:46 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 13 Nov
 2023 15:57:46 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
CC:     <stable@vger.kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: i2c: st-mipid02: correct format propagation
Date:   Mon, 13 Nov 2023 15:57:30 +0100
Message-ID: <20231113145731.89796-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_05,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a copy of the struct v4l2_subdev_format when propagating
format from the sink to source pad in order to avoid impacting the
sink format returned to the application.

Thanks to Jacopo Mondi for pointing the issue.

Fixes: 6c01e6f3f27b ("media: st-mipid02: Propagate format from sink to source pad")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/st-mipid02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index fa27638edc07..dab14787116b 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -770,6 +770,7 @@ static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_format *format)
 {
 	struct mipid02_dev *bridge = to_mipid02_dev(sd);
+	struct v4l2_subdev_format source_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 
 	format->format.code = get_fmt_code(format->format.code);
@@ -781,8 +782,12 @@ static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
 
 	*fmt = format->format;
 
-	/* Propagate the format change to the source pad */
-	mipid02_set_fmt_source(sd, sd_state, format);
+	/*
+	 * Propagate the format change to the source pad, taking
+	 * care not to update the format pointer given back to user
+	 */
+	source_fmt = *format;
+	mipid02_set_fmt_source(sd, sd_state, &source_fmt);
 }
 
 static int mipid02_set_fmt(struct v4l2_subdev *sd,
-- 
2.25.1

