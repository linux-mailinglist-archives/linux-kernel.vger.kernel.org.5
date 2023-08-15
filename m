Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A68E77D103
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjHORaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbjHOR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:29:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714551BE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:29:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FBQqSb031201;
        Tue, 15 Aug 2023 12:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=I3Fk0jyQibU+2gLz/QupGqZPG9XmKM9A8Y4dKFuUElI=; b=
        dV1g9oFfQRA9nIGVtvpMRFFEybskAkT4GaZ4Hg/8hvFDzx+uXZjRBRmFsheU57Al
        xE5LmqtkpToRJJ+I9cvSuqRAIf157QydGELOd5+SSXSC09km1BJ5BZ/XxbzQp43/
        +p++L414hmNHWH0tcJhYL7mhZTUObkaEn3X+h3gMqWZp1g9ziGMFNC4X3yuvmaSv
        5rUrdSdc+VT0iAsSv9w07SHzrFM0nvyq7RhyYQFNFaNQWQZRcT5uPJp6+fSZgSgs
        IhKAtclgyKESPlzalD/oWwntPYC3vK2dDxfolTzrH7T7A+VjGIrVmIu5/+QYBGQr
        XV50Igmha+YDci4nmq6k6A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kquw86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 12:29:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 18:29:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 15 Aug 2023 18:29:34 +0100
Received: from vkarpovich-ThinkStation-P620.ad.cirrus.com (unknown [141.131.76.171])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0F5F8475;
        Tue, 15 Aug 2023 17:29:32 +0000 (UTC)
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Ricardo Rivera-Matos" <ricardo.rivera-matos@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Fix new control name check
Date:   Tue, 15 Aug 2023 12:29:08 -0500
Message-ID: <20230815172908.3454056-1-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
References: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q6KsHZ6MeHQIKEx9WXCuAxqCmfnqpRdl
X-Proofpoint-GUID: Q6KsHZ6MeHQIKEx9WXCuAxqCmfnqpRdl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before adding a new FW control, its name is checked against
existing controls list. But the string length in strncmp used
to compare controls names is taken from the list, so if beginnings
of the controls are matching,  then the new control is not created.
For example, if CAL_R control already exists, CAL_R_SELECTED
is not created.
The fix is to compare string lengths as well.

Fixes: 6477960755fb ("ASoC: wm_adsp: Move check for control existence")
Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 81cc3d0f6eec..81c5f94b1be1 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -939,7 +939,8 @@ static int cs_dsp_create_control(struct cs_dsp *dsp,
 		    ctl->alg_region.alg == alg_region->alg &&
 		    ctl->alg_region.type == alg_region->type) {
 			if ((!subname && !ctl->subname) ||
-			    (subname && !strncmp(ctl->subname, subname, ctl->subname_len))) {
+			    (subname && (ctl->subname_len == subname_len) &&
+			     !strncmp(ctl->subname, subname, ctl->subname_len))) {
 				if (!ctl->enabled)
 					ctl->enabled = 1;
 				return 0;
-- 
2.25.1

