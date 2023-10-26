Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB57D858A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjJZPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbjJZPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC71AB;
        Thu, 26 Oct 2023 08:06:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUrg011654;
        Thu, 26 Oct 2023 10:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=y/+iYEq7Uz9EyfpgC4lWXIhIUHrMcz4eog7gtduIurE=; b=
        Y2tQxHdDaqXmoe9FKYwcQLqkwBNM+NVEnK9gUoMq/ETN2DvzZsr9CQ8n+A6u3aCX
        wsOkXO21KwIsAlL60f1vFpDIvkxI8DA6GtIL6DXKXDaKIV9A5wGVNWn7FZE8KaYh
        +2wVTmiptV7q0qOxZ19mBcxJgf2kLVJb5x9H+qEc4/W4USgOkUHK+oK3wxjL6/CH
        lz161+ZhDMBS07gpwSRd7AD6/5HuD4InZu8dE3oHgz9GAEPPIO/EQ34PliRQwdVd
        CtEX7nedCc7JImkhLHU1foWNI10h0bUUbKOgOgSl9VcOhQKwe/bTV6aR5ab+kFA7
        3tuWIUoLsjzfyL4nYQkDXQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 26 Oct 2023 16:06:08 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E0E5611AA;
        Thu, 26 Oct 2023 15:06:07 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 3/8] ALSA: hda: cs35l41: Assert Reset prior to de-asserting in probe and system resume
Date:   Thu, 26 Oct 2023 16:05:53 +0100
Message-ID: <20231026150558.2105827-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NaKD-yWniZCNpH7nPU9j1Sl85JO_MLNV
X-Proofpoint-ORIG-GUID: NaKD-yWniZCNpH7nPU9j1Sl85JO_MLNV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure we are in a known state, exiting from reset at the point of
probe or in system resume, assert reset before we de-assert it.

Since the BIOS may enter into a pre-boot environment to control the
amps (for example for boot beep), we need to ensure we start from a
known, reset state prior to probe or system resume.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 919e38213975..1ac721085fb5 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -840,6 +840,7 @@ static int cs35l41_system_resume(struct device *dev)
 	}
 
 	if (cs35l41->reset_gpio) {
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 		usleep_range(2000, 2100);
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
 	}
@@ -1693,6 +1694,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		}
 	}
 	if (cs35l41->reset_gpio) {
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 		usleep_range(2000, 2100);
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
 	}
-- 
2.34.1

