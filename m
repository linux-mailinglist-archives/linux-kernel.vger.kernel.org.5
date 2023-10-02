Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED267B5372
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjJBMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjJBMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:51:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D17A6;
        Mon,  2 Oct 2023 05:51:23 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3926VdoF031278;
        Mon, 2 Oct 2023 07:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=W
        j4F+bHn9pzMOzyfsWKN+qDwvvtBojn1C4VrichB830=; b=Z+4B7QxW3O+5r0D20
        RXAuYgp7xfEdj6x0LSOwdKWBdBdi58oBiXsq5DEp3yKdYNv9N0M494I/UyJjtlKp
        5aFefbLHjFF+2x4yG5gngZCN895MgEeYY2QF9GGXlwCE+uD4tceDNvd/Of7cM4Mm
        WBi6u97mBXpDqG9AG86w2nB1NWm+ZXi73vlRId69I3SnkhySK9MxxvqandBXp8Y3
        x9J640ZE9pEW2nnR5P6V6cb69aDYSdzhDFrrIIWLVsOQIqDw1f/qHkIhJK/MFfs+
        n/zR0RMaTUw/S/0WH0p3xMvRjg25wMgBBnnIpCNhdrESg+z4JUp87vnKK+RVdpPg
        vllDw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3teh2xtv0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 07:51:02 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 2 Oct
 2023 13:51:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 2 Oct 2023 13:51:00 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.13])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DC63FB2F;
        Mon,  2 Oct 2023 12:50:59 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <stable@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 6.5] ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()
Date:   Mon, 2 Oct 2023 13:50:59 +0100
Message-ID: <20231002125059.4091982-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xm7Z10fTc1btYr-LSqioz1irOK1SGnBg
X-Proofpoint-ORIG-GUID: xm7Z10fTc1btYr-LSqioz1irOK1SGnBg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ec03804552e9a723569e14d2512f36a8e70dc640 upstream

Driver remove() must call pm_runtime_dont_use_autosuspend().

Drivers that call pm_runtime_use_autosuspend() must disable
it in driver remove(). Unfortunately until recently this was
only mentioned in 1 line in a 900+ line document so most
people hadn't noticed this. It has only recently been added
to the kerneldoc of pm_runtime_use_autosuspend().

Backport note: This is the same change as the upstream
commit but the cs35l56->base.dev argument in the upstream
code is cs35l56->dev in older releases.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230908101716.2658582-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Please apply to 6.5.
---
 sound/soc/codecs/cs35l56.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index fd06b9f9d496..7e241908b5f1 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1594,6 +1594,7 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 	flush_workqueue(cs35l56->dsp_wq);
 	destroy_workqueue(cs35l56->dsp_wq);
 
+	pm_runtime_dont_use_autosuspend(cs35l56->dev);
 	pm_runtime_suspend(cs35l56->dev);
 	pm_runtime_disable(cs35l56->dev);
 
-- 
2.30.2

