Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06503798582
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjIHKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjIHKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:12:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170A1BEE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:12:33 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3885cugZ025352;
        Fri, 8 Sep 2023 05:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Z
        JkzVi89kTdSUWvlVXK/bb8Ue3nL1QfrlwR8JcnKNZ8=; b=lFc2aiwvlS+FNBqAO
        6II5AROoLG27GlC5y7UsrPGQdfzm+OdC7PLOrEegozNQK7QC5StoztWnNNUoNsSg
        EVX3N6FfZj/EA1I+hrIsDO4guRsagb57E2dVclq3jPa8Ytk/vmM8D5kIxFnNW7JU
        +r5Av7tq619wKyRnEnMnr0P2HHdUYAId3kkjFzm/S4EKLc3pcBUzeIPGHlcwSgIO
        hvyGz6SsFKfYVQksgn5ivEjqTKQqLbD+UAMSgZmyJu798dPRuoffX4SR1HujnUtN
        ZCnESVX1xtclD+O8DA+UUTjpHVaJD1bvgUIm55dCyZy/AEMo3sfhqcouj/j0rPXa
        jbdwg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex7vq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 05:12:25 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 8 Sep
 2023 11:12:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 8 Sep 2023 11:12:23 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A54B415B6;
        Fri,  8 Sep 2023 10:12:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Call pm_runtime_dont_use_autosuspend()
Date:   Fri, 8 Sep 2023 11:12:23 +0100
Message-ID: <20230908101223.2656901-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VwBTvCevhKQ7XB3gtlaJijQR5Pk2HvvR
X-Proofpoint-GUID: VwBTvCevhKQ7XB3gtlaJijQR5Pk2HvvR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver remove() must call pm_runtime_dont_use_autosuspend().

Drivers that call pm_runtime_use_autosuspend() must disable
it in driver remove(). Unfortunately until recently this was
only mentioned in 1 line in a 900+ line document so most
people hadn't noticed this. It has only recently been added
to the kerneldoc of pm_runtime_use_autosuspend().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2a930a6da8ec ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 76b9c685560b..9e4976bdb5e0 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1003,6 +1003,7 @@ void cs35l56_hda_remove(struct device *dev)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 
+	pm_runtime_dont_use_autosuspend(cs35l56->base.dev);
 	pm_runtime_get_sync(cs35l56->base.dev);
 	pm_runtime_disable(cs35l56->base.dev);
 
-- 
2.30.2

