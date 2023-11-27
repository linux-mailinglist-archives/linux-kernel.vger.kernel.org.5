Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4738C7FA161
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjK0Nvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjK0Nvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:51:48 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F3136;
        Mon, 27 Nov 2023 05:51:53 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ARDYkX8032119;
        Mon, 27 Nov 2023 14:51:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=DF2OIEe
        wUh5+1ayOsbMuAkChSkmhZv8jd9YCZXorCH4=; b=5OG6liUXwAr/1RNi9KgJuX3
        UOFkgaYgx27+LxqYd5z354DlUdDEymjVoCyB5J236sasptrXjFFYfeN3Ddr1m4p6
        DMdFfugctWVTh+mK1Egx118djBRK8Ulo8dd/4pG1zNAWx0aWfLaHF/+aH+ovpCY2
        oTsKcJry/tDf+DpLGhrdLF2K9gg2eTpaoM7QtHg7oyVNtpVOJUHgliS9ulh33nnr
        //VWDwLd5P/meoEXA1IERPOIDFFNj8PrB/6F0kSjtKwZ05Cx2FRlLbwMvT8YECt4
        dTDlAtj2u84sGB1pUoff7V9Zbd9AUcTZJR3yqbtJEZx7mouJhSLDFdekBFY2CJA=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk951qxbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:51:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 668AC10002A;
        Mon, 27 Nov 2023 14:51:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E07F2291B5;
        Mon, 27 Nov 2023 14:51:44 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 27 Nov
 2023 14:51:44 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] media: i2c: st-vgxy61: add subdev events & fwnode ctrls
Date:   Mon, 27 Nov 2023 14:51:10 +0100
Message-ID: <20231127135113.1424113-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_11,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct v4l2-compliance test by adding flag V4L2_SUBDEV_FL_HAS_EVENTS
and subscribe hooks and add fwnode properties in order to be able to
expose sensor properties such as orientation & rotation.

v2: rebased on top of Sakari's tree master branch, needed due to merge
    conflict following internal_ops addition (init_state)

Alain Volmat (2):
  media: i2c: st-vgxy61: Add V4L2_SUBDEV_FL_HAS_EVENTS and subscribe
    hooks
  media: i2c: st-vgxy61: add v4l2_fwnode ctrls parse and addition

 drivers/media/i2c/st-vgxy61.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
2.25.1

