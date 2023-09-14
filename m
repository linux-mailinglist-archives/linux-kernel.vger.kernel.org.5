Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259467A06EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbjINOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbjINOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:09:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A91BF8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:09:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38E3ihQq012982;
        Thu, 14 Sep 2023 09:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=4
        HgihXxVrhiu2Qr7o1AFiNL6OECM0mNgN7UuJbdBwcg=; b=LxEo36sUTZ9NjyabM
        APBU5ZX9VP3h7y/Ta68+R0QT17lDzPTbi5ppoD9d2Yi1KY3Vg5emY1/qgBDF17K7
        JujFfWW/VZqkxmtvtIY6dYQI5oj6G86X+T6lo1teMmhG23vX6F4hxAAQZk48Mqb0
        6n7kpxtPrea/DxIWp1967yGbyG6F68pSqvhh2f/xBe/q+k744mon1YLNYjB3VtIc
        XLhDIDP/vn7CL8K26uLNeiyF64d/x3Bymf2PBPKQcK92tU6Mh8jL1ma+NysSxHrW
        IdoczHSn7HYGwogKxVbBcpQLHQW63atRQzJ/+vrYkbcAaddRmUC5PeOCAPOj1uIV
        kJ8Dg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u2gp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:56 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 15:08:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 14 Sep 2023 15:08:54 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 48E9C15B4;
        Thu, 14 Sep 2023 14:08:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Don't 'return ret' if ret is always zero
Date:   Thu, 14 Sep 2023 15:08:52 +0100
Message-ID: <20230914140852.7112-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: npi1-VwBihTbS2d2xtl1agzUXGFvtmK9
X-Proofpoint-ORIG-GUID: npi1-VwBihTbS2d2xtl1agzUXGFvtmK9
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final return in cs35l56_hda_posture_get() was returning the
value of 'ret', but ret is always zero at this point. So this
can be a simple 'return 0'.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index a9844336bdc9..c64600280f02 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -216,11 +216,11 @@ static int cs35l56_hda_posture_get(struct snd_kcontrol *kcontrol,
 	if (ret)
 		return ret;
 
 	ucontrol->value.integer.value[0] = pos;
 
-	return ret;
+	return 0;
 }
 
 static int cs35l56_hda_posture_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-- 
2.30.2

