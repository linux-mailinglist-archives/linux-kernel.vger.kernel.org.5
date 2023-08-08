Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB5774B02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjHHUjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjHHUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:38:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A417758A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:20:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378F5h5f030864;
        Tue, 8 Aug 2023 11:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=enamRFxwNNWkXUDA7dzl08MLaVLqHvLONRfo2RP3k/s=; b=
        Uh5hncoUkCW4siX1GIoA5jmqucwjEnu6mmXnnq+6QKnWEmEgxlJTxVxhEBpBKdbY
        KiQZwoN7exjyAYQ8VIeUcpF+VdaCZhNGShtxeQPurpLb/YlUUWJ3cwoOCHyx4Rfj
        Arew95VJCXsrxfKFxfdIpJJfXDZME/9ldJGfA07f/H6QVXWeXAF3jFkQtOIq8IXD
        h1QUlrzCGc206T3vzz1lh9SZWZiz06/eVpHJvPn8j1RllIxZLMFeiUiF+gU/BsJM
        cIbTCVVvzP6375TZbjAlZoM4/ZImDFFO/CwM/onAtlsHa71fhWcXosDy+JbT6oSR
        GqdpgHleG90miPDhwCb5/Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtucq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:47:07 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 17:47:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 17:47:06 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1C6B03578;
        Tue,  8 Aug 2023 16:47:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: cs35l56: Call wm_adsp_power_down() before reloading firmware
Date:   Tue, 8 Aug 2023 17:47:02 +0100
Message-ID: <20230808164702.21272-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808164702.21272-1-rf@opensource.cirrus.com>
References: <20230808164702.21272-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -S0Cs10N98DiKe82HW-XpWhskMJfyFLR
X-Proofpoint-ORIG-GUID: -S0Cs10N98DiKe82HW-XpWhskMJfyFLR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

When cs35l56_system_resume() needs to reload firmware it should call
wm_adsp_power_down() to put cs_dsp into a powered-down state before
cs35l56_secure_patch() or cs35l56_patch() calls wm_adsp_power_up().

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 094bcbd0a174..80e7fddae926 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -976,6 +976,7 @@ int cs35l56_system_resume(struct device *dev)
 		return ret;
 
 	cs35l56->base.fw_patched = false;
+	wm_adsp_power_down(&cs35l56->dsp);
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	/*
-- 
2.30.2

