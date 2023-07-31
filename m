Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C9769D69
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjGaQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjGaQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6421738
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:45 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36VDp2Y2022362;
        Mon, 31 Jul 2023 11:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=uIxcNFIlhCWl+DHFeYj1CnUBImgYJ6FmRvXCKssmj0Y=; b=
        pgWhXHhoM571lbT5+7eFEG99yK8Y0Zy/5q+7ey11g/2RUMB61bfa+ZPtP/QZQFgj
        4qOVAYm0ddVNUMwRT+qy3pnq3eKqSEK/twLAKrBD3y+OqBitRA/Ln6NT2/m2URPq
        82iucUFPpcWd6v2EO1TRKcOfEgnQdXFVzcg2IxaveqeGpdtFrgahQ+2ygmQ/mU/b
        lYPxP0OPA5K3Zz8ZcWRc/R9ITGfrSECvXkNxzn8jWq50qmY8PVMKyxsfaNLLalPk
        oCPwI/fCNefjCz4Cvv7jO5XafoWSREB3BI8xrY1W4CAIHj3YkMku0Pt1g9Uo5yCi
        Up6yWGbLEeXqLSYqGzEksw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:33 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 31 Jul 2023 17:57:31 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 70B6311D3;
        Mon, 31 Jul 2023 16:57:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/9] ALSA: hda/cs35l56: Call cs_dsp_power_down() before calling cs_dsp_remove()
Date:   Mon, 31 Jul 2023 17:57:22 +0100
Message-ID: <20230731165726.7940-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GwJk94tO8R7z1VWfOhv5pfJ5SXsoxW-V
X-Proofpoint-ORIG-GUID: GwJk94tO8R7z1VWfOhv5pfJ5SXsoxW-V
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cs35l56_hda_unbind() cs_dsp_power_down() must be called to cleanup
before calling cs_dsp_remove cs_dsp_remove().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 2870f82bfa45..e8c41a4a0c40 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -649,6 +649,9 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	debugfs_remove_recursive(cs35l56->debugfs_root);
 #endif
 
+	if (cs35l56->base.fw_patched)
+		cs_dsp_power_down(&cs35l56->cs_dsp);
+
 	cs_dsp_remove(&cs35l56->cs_dsp);
 
 	if (comps[cs35l56->index].dev == dev)
-- 
2.30.2

