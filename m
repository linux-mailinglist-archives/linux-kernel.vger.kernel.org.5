Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A175B01C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGTNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGTNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056E272B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:05 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36KAupUn002185;
        Thu, 20 Jul 2023 08:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=bnOAAEmWyve6CI2E3qxgDsyTBy0nDrUWAehd/iigJAs=; b=
        kbnguTSpJGBDJPZ0lK8V8J8j3shpQC6PT/E+31+BLEsuv1w6Qx/4NjIZE5knsrsG
        qFY+rR7gWaKiyXaN9By2PmB1xcRu7TZpXkQN8T+4L+FlPs+DOIBOnFcfTTSNtSAk
        nPfL6OVbHhhMoThacPEjeXPgkCN86PhAcChWthpRpolDF5ycqy37SpkhVMZctMSD
        lOqiJQv5vDLshsspejuPXK8J0zDxQwoL4dSt9hINd5VBDVr7guQ2VPjop9tvIaL3
        vL9/wY2d2KkrF58VYM2Z70HQqqSZkJAAqaAYeYcwNdt24lyUJBA5Qm/m/LS6kdX8
        XOTf7LtnYnZ3t/VXie6XTw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:12 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 20 Jul 2023 14:32:10 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 992BE356C;
        Thu, 20 Jul 2023 13:32:10 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 06/11] ALSA: hda: hda_component: Add pre and post playback hooks to hda_component
Date:   Thu, 20 Jul 2023 14:31:42 +0100
Message-ID: <20230720133147.1294337-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BRvf9KiVnvmrbAwiCK7SOMreFWg9xIXB
X-Proofpoint-GUID: BRvf9KiVnvmrbAwiCK7SOMreFWg9xIXB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These hooks can be used to add callbacks that would be run before and after
the main playback hooks. These hooks would be called for all amps, before
moving on to the next hook, i.e. pre_playback_hook would be called for
all amps, before the playback_hook is called for all amps, then finally
the post_playback_hook is called for all amps.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/hda_component.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 534e845b9cd1d..f170aec967c18 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -15,5 +15,7 @@ struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
 	struct hda_codec *codec;
+	void (*pre_playback_hook)(struct device *dev, int action);
 	void (*playback_hook)(struct device *dev, int action);
+	void (*post_playback_hook)(struct device *dev, int action);
 };
-- 
2.34.1

