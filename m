Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7C7F8CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjKYRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjKYRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:46:42 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A6127;
        Sat, 25 Nov 2023 09:46:48 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AP4ek2x032078;
        Sat, 25 Nov 2023 18:46:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=YgwDhWRiHXXOSB0ComoQD4DlrpUixDI/UziY9MZKeIM=; b=xc
        Cp3+kLTmPPl7tn6XXuhabrMKkdZQEf2dgR6/hfBI5jMHJ9R6dQeSuf+96hEUDQk1
        Tp0a25tgSoo2rAVcvgH9ixpDYwvAJ2gIBQss3Qlflwz4jDfPVkJs+lstFeekQSi+
        W+05Qo/5O+lscQiNqeW/z0JAtPLBTBg51SRBSIjtUkmiS4tSuKafLIJgZBFDcuWe
        hEnB0myFFg9md6IyhSbJzdn/RpLr/5EjUTg5wV+yQfCA0UjisBe7aUL9Hnj09nTh
        6DOUY/PtU6cXXBQrkQav7j9P4qZWGaumRdyoaPKnvfE4c9pUVJBuhQmE4DobkVtk
        1yAYaho8Qjls+2H6gvJw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uhr8amubt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 18:46:40 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25E7710002A;
        Sat, 25 Nov 2023 18:46:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1839323695C;
        Sat, 25 Nov 2023 18:46:40 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 18:46:40 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] media: i2c: st-vgxy61: add v4l2_fwnode ctrls parse and addition
Date:   Sat, 25 Nov 2023 18:46:03 +0100
Message-ID: <20231125174604.1378485-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231125174604.1378485-1-alain.volmat@foss.st.com>
References: <20231125174604.1378485-1-alain.volmat@foss.st.com>
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

Allow parsing of the v4l2_fwnode properties from the DT and addition
of those properties (such as orientation, rotation).

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-vgxy61.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
index 93885ed167cb..d27a1bf7690a 100644
--- a/drivers/media/i2c/st-vgxy61.c
+++ b/drivers/media/i2c/st-vgxy61.c
@@ -1403,6 +1403,7 @@ static int vgxy61_init_controls(struct vgxy61_dev *sensor)
 	const struct v4l2_ctrl_ops *ops = &vgxy61_ctrl_ops;
 	struct v4l2_ctrl_handler *hdl = &sensor->ctrl_handler;
 	const struct vgxy61_mode_info *cur_mode = sensor->current_mode;
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl *ctrl;
 	int ret;
 
@@ -1457,6 +1458,14 @@ static int vgxy61_init_controls(struct vgxy61_dev *sensor)
 		goto free_ctrls;
 	}
 
+	ret = v4l2_fwnode_device_parse(&sensor->i2c_client->dev, &props);
+	if (ret)
+		goto free_ctrls;
+
+	ret = v4l2_ctrl_new_fwnode_properties(hdl, ops, &props);
+	if (ret)
+		goto free_ctrls;
+
 	sensor->sd.ctrl_handler = hdl;
 	return 0;
 
-- 
2.25.1

