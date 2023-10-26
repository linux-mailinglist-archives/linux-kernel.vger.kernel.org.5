Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF67D858B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbjJZPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345380AbjJZPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D61B2;
        Thu, 26 Oct 2023 08:06:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUrf011654;
        Thu, 26 Oct 2023 10:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=wdJIvP71kd5paaffy0gTBO9L9MC9c1x6VHLNrVDIlu8=; b=
        aoy8gLob0n1gsE5hx65kSnrRIzX7GY+l4uEKFt50502Nn3zHqPNsbTlVTlJedENh
        yXFqXGjsowQumsR8up5m9R8Quv82AVNPLJaA0ZUeJsJz0YFB6PQGZB+/U1kVlsHh
        okgtgrORXOsL9ujKuRmKgo2eDDUeCQMqepQJpqLPpkhy+9SvR0EAYQzg0mWcuZcF
        tcz02AZmTfCJcWQeTSfFhCfPMrdLceKJ+tYKDU+/cXKsxYMd9675duCu12lWNbv6
        dEEwr++VX4jfICoZ4bQaG2Nf8fAUSJ49NDD15CAWGlNxOx3/WfMIeyddJeoU3tf9
        fQ2C2wEnZVrv9GQGuJTAkA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:11 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 26 Oct 2023 16:06:07 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 99D1A2A1;
        Thu, 26 Oct 2023 15:06:07 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/8] ALSA: hda: cs35l41: Assert reset before system suspend
Date:   Thu, 26 Oct 2023 16:05:52 +0100
Message-ID: <20231026150558.2105827-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PrOE1fxLidsnV9ZeqmoNDjFQsX_MJZuV
X-Proofpoint-ORIG-GUID: PrOE1fxLidsnV9ZeqmoNDjFQsX_MJZuV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some system suspend modes may remove power supplies.
To ensure we are not running during this time, we should assert reset.

Note: since the amps use a shared reset, asserting reset prior to
system suspend only works if the amps are suspended in the reverse
order to probe.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 28cb10ddd191..919e38213975 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -813,14 +813,17 @@ static int cs35l41_system_suspend(struct device *dev)
 
 	/* Shutdown DSP before system suspend */
 	ret = cs35l41_ready_for_reset(cs35l41);
-
 	if (ret)
 		dev_err(dev, "System Suspend Failed, not ready for Reset: %d\n", ret);
 
-	/*
-	 * Reset GPIO may be shared, so cannot reset here.
-	 * However beyond this point, amps may be powered down.
-	 */
+	if (cs35l41->reset_gpio) {
+		dev_info(cs35l41->dev, "Asserting Reset\n");
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+		usleep_range(2000, 2100);
+	}
+
+	dev_dbg(cs35l41->dev, "System Suspended\n");
+
 	return ret;
 }
 
-- 
2.34.1

