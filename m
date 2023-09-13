Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299D279EDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjIMQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIMQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:03:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C792
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:03:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DFQNmf015064;
        Wed, 13 Sep 2023 11:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=4
        dxWaJPvr2QnmomnbN1/XJKlzqqGpJ4ZCyl1FkfwbuU=; b=erKjCEdlTFErWs6yb
        /6S5kNShx40qWneHewW/2h5stjBXxq2lL9yJNGgmlmIryCpOKXZqhfuG/zQueSjU
        ZyoaIcmixgPDBa1EENn1dqZAmnFNkIbV/CCrQqqIQ1ZJUwHFhTAyPeNE54ks2ios
        tghEtHGb0Z3wPQWWcu+b9M2pJ4JiSRhe/dfqNW4QEM0mbiCJGxXxNs4YapYjjB/A
        r00svrhucWYpBKOLYhdXMZOJ8VdW7cBn/j0GiTvRycpZ5gXJZA7YF5mAYoxhTNyp
        gzkdsI2hf+d9cOdDzktRbCfqIZYL7xnIO8L93vdSb7DjwDWEC/eOhXherWvzHo2A
        yJNcg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u155j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:02:52 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 17:02:50 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 13 Sep 2023 17:02:50 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 393F915B9;
        Wed, 13 Sep 2023 16:02:50 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()
Date:   Wed, 13 Sep 2023 17:02:50 +0100
Message-ID: <20230913160250.3700346-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Zy09iuh4OJHrYMobOncWbEkyA3PD04ba
X-Proofpoint-ORIG-GUID: Zy09iuh4OJHrYMobOncWbEkyA3PD04ba
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wm_adsp_read_ctl() and wm_adsp_write_ctl() must hold the cs_dsp pwr_lock
mutex when calling cs_dsp_coeff_read_ctrl() and cs_dsp_coeff_write_ctrl().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
These functions aren't currently used so this fix doesn't need
to be backported.
---
 sound/soc/codecs/wm_adsp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6fc34f41b175..d1b9238d391e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -687,7 +687,10 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
+	mutex_lock(&dsp->cs_dsp.pwr_lock);
 	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
+	mutex_unlock(&dsp->cs_dsp.pwr_lock);
+
 	if (ret < 0)
 		return ret;
 
@@ -703,8 +706,14 @@ EXPORT_SYMBOL_GPL(wm_adsp_write_ctl);
 int wm_adsp_read_ctl(struct wm_adsp *dsp, const char *name, int type,
 		     unsigned int alg, void *buf, size_t len)
 {
-	return cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg),
-				      0, buf, len);
+	int ret;
+
+	mutex_lock(&dsp->cs_dsp.pwr_lock);
+	ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg),
+				     0, buf, len);
+	mutex_unlock(&dsp->cs_dsp.pwr_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_read_ctl);
 
-- 
2.30.2

