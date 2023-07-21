Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834BE75CB5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGUPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjGUPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:19:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F535A3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:18:54 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36LDppwg011284;
        Fri, 21 Jul 2023 10:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=q
        LMLNLcgrkd2GN4RsPHG93N6pllAVjaH9PciQbGF2GI=; b=hG97G1q0jmVRFcCEu
        ipDMdI45xiz0n5K6P42Ka3Ks6pJm912kVIRkgQuzZ0MOdU9RmOaTMZA5xH+jHUce
        tPoqOmRL1tBazSuD6jqHgVeziGrnmM5kj7qpPlzBt53srqyUxJUv4TN9lBIDq0+S
        ZvZLTrpjDfa3A1anL0pCGntGeruHAGYOISYSa7dojd08pncB2DrIhN8qY35vUo6u
        5KYiQxMY1ar9TxiOCw7fGGX7LeJIjuai05NHNMms15mUwN3ImWtI/VblS8qmMjjR
        x/HSqiJbetT+8ux0sn6j8uHTShLlckFSxa58KA0Lb289+P8zWl9b7zz84PzeErBb
        D1vng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62y8g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:18:27 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 16:18:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 16:18:25 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6CC2946B;
        Fri, 21 Jul 2023 15:18:25 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 00/11] Fix support for System Suspend for CS35L41 HDA
Date:   Fri, 21 Jul 2023 16:18:05 +0100
Message-ID: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: em39YRvIjjJex4WMzgHbAZ1cq77NiW6z
X-Proofpoint-ORIG-GUID: em39YRvIjjJex4WMzgHbAZ1cq77NiW6z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a couple of customer reports of intermittant issues after
system resume, where sometimes the DSP firmware stops responding.
Investigations into this issue show that there is a race between receiving
a prepare from the HDA core, and the firmware reload which is started by
the system resume. This can causes the Global Enable on the CS35L41 to be
enabled during the firmware load, which can sometimes cause issues in the
DSP.

The existing system resume behaviour also did not resume the audio, if
audio was previously playing when it was suspended.
In addition, during investigation, it was found there were additional
problems in the System Resume sequence, as well as the Playback sequence
with External Boost, where the driver does not correctly follow its
enable sequence for this mode. This can cause additional issues such as
pops and clicks.

This chain intends to correct the sequences for playback and system
suspend/resume so that the driver: obeys the external boost enable sequence;
resumes audio on system resume; and avoids the race condition on firmware
load and playback during system resume.

Changes since v1:
- Split patch 1 into 2 separate patches
- Combine Patches 6 and 9

Stefan Binding (11):
  ALSA: cs35l41: Use mbox command to enable speaker output for external
    boost
  ALSA: cs35l41: Poll for Power Up/Down rather than waiting a fixed
    delay
  ALSA: hda: cs35l41: Check mailbox status of pause command after
    firmware load
  ALSA: hda: cs35l41: Ensure we correctly re-sync regmap before system
    suspending.
  ALSA: hda: cs35l41: Ensure we pass up any errors during system
    suspend.
  ALSA: hda: cs35l41: Move Play and Pause into separate functions
  ALSA: hda: hda_component: Add pre and post playback hooks to
    hda_component
  ALSA: hda: cs35l41: Use pre and post playback hooks
  ALSA: hda: cs35l41: Rework System Suspend to ensure correct call
    separation
  ALSA: hda: cs35l41: Add device_link between HDA and cs35l41_hda
  ALSA: hda: cs35l41: Ensure amp is only unmuted during playback

 include/sound/cs35l41.h        |   5 +-
 sound/pci/hda/cs35l41_hda.c    | 288 +++++++++++++++++++++++++--------
 sound/pci/hda/hda_component.h  |   2 +
 sound/pci/hda/patch_realtek.c  |  10 +-
 sound/soc/codecs/cs35l41-lib.c | 118 ++++++++++++--
 sound/soc/codecs/cs35l41.c     |  18 +--
 6 files changed, 343 insertions(+), 98 deletions(-)

-- 
2.34.1

