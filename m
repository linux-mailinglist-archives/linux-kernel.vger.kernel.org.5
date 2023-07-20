Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88BD75B015
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGTNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGTNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88A272A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:04 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36KAupUk002185;
        Thu, 20 Jul 2023 08:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=E
        W9xH6EwUI4+VhEi1xFvO7JxFFGjIaaBEXgWEdpAp04=; b=CE/WQuhzd1FAsmcsx
        sTIOcKPgqAI61BLWn4l35syr+xP61mC/pdYdORuogKHE4EPMgYOT4ierPYqxFl+i
        /nsqz0xi1efiZqpEsOlOBIQu/iQFCvB5K5bqxgFfE5uy/dZeDYAPppu46VnVV7mk
        ALzA4aeVjVMARBahuP5TIeDfxoFjHzOB3BLSSKK50raOY/NTUq1oML19xwByXH0B
        RSmvcEOhO/YjpcCRh1/E1ApOl3DMrZbsxNOt4zKYo2Is4E90BbXuOnVZNHciabis
        gsmPSdgBw2EHb1YDGWYJOIX9KE3LtaTy4OVNziejwQOf9vWvMgs7ntfzyt+TsC2q
        59ksw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:10 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 20 Jul 2023 14:32:08 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 83BCD475;
        Thu, 20 Jul 2023 13:32:08 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 00/11]  Fix support for System Suspend for CS35L41 HDA
Date:   Thu, 20 Jul 2023 14:31:36 +0100
Message-ID: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: L7QWUw1uIwSJqQtgQ4fIz73mWyeWFijy
X-Proofpoint-GUID: L7QWUw1uIwSJqQtgQ4fIz73mWyeWFijy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Stefan Binding (11):
  ALSA: cs35l41: Use mbox command to enable speaker output for external
    boost
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
  ALSA: hda/realtek: Support pre-/post- playback hooks for cs35l41
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

