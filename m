Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1307AB394
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjIVO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjIVO3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:29:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E296180
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:28:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38ME9ncC026380;
        Fri, 22 Sep 2023 09:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=P
        9lo6NrtT7bVqMoFP5TYebIw4AWc4lUSCngfC5n9hv0=; b=C3Rb0QScSzVl/qDjO
        fc41mqDhuTc4ELuU1yXb3m0px5+Pi9vVHBj25znr6IVQi0Zsp3UvNGRQmevn4Ya2
        0wzQwkgQL9JAoXPUqi1wDJTyD2kZ0KarChH8PYLFUc7OnEeh/vBkVr/9ndEMSpFn
        VN00Wu628VI1zfZEuFu7KhQUJup7Ks6F/dJEobPlYmeXCMrdNHLSmuqdXh+JKULX
        iurOMZey6OkSNp612N/0MX1Ke5RfslqcdxWQtgRnfWMcNt1ln2gJSymuwyA1zLWl
        ASf1Ew8y40+xB8LrsoysEROKnIrzN7b6fFxADnr9aN7s/5h0OzzZbx7hdSPLqbru
        PSM8w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t8tt7h2pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:28:29 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 22 Sep
 2023 15:28:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 22 Sep 2023 15:28:28 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B79683561;
        Fri, 22 Sep 2023 14:28:27 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] ALSA: cs35l41: prevent old firmwares using unsupported commands
Date:   Fri, 22 Sep 2023 15:28:16 +0100
Message-ID: <20230922142818.2021103-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IFvwBFG7EHdNpFDfh6PwYPNjvliZgZ-r
X-Proofpoint-ORIG-GUID: IFvwBFG7EHdNpFDfh6PwYPNjvliZgZ-r
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems use older firmware which does not support newer commands
which are used to enable external boost. For those systems, we can
workaround this by writing the registers directly.

We can use the firmware version, stored inside cs_dsp, to determine
whether or not the command is supported.
To achieve this, it requires a cleanup in the api, to pass the cs_dsp
struct into the function.

We can also remove the redundant boolean firmware_running from the HDA
driver, and use the equivalent state inside cs_dsp.

This chain is based on Mark's branch, since the api change was made to
the function in sound/soc/codecs/cs35l41-lib.c.

Stefan Binding (2):
  ALSA: hda: cs35l41: Remove unnecessary boolean state variable
    firmware_running
  ALSA: cs35l41: Fix for old systems which do not support command

 include/sound/cs35l41.h        |  2 +-
 sound/pci/hda/cs35l41_hda.c    | 28 ++++++++++++----------------
 sound/pci/hda/cs35l41_hda.h    |  1 -
 sound/soc/codecs/cs35l41-lib.c |  6 ++++--
 sound/soc/codecs/cs35l41.c     |  4 ++--
 5 files changed, 19 insertions(+), 22 deletions(-)

-- 
2.34.1

