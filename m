Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2424F7A898C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjITQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjITQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:34:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782DE5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:34:00 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38KFt6MX023727;
        Wed, 20 Sep 2023 11:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=/
        BLxOc/tkBmcLEyGBDmhNnSyPG+SVhl9atiXF3hiU6g=; b=KfC4n0lHvxP+ihzuD
        IkYtwTBsPjnPqZMaHby2Byy6Ny1bZhHhNPBb/f2V8/mS9y3i5OEJzAI97GpRFu2Q
        E4oaJ4KFn8BWUHdsC0itH5kOLNwSmmN/fvATnd0Ngaxm1mJfnKfNVY+O72ThkLVT
        YyM2A+BXkT/AsWxbKshA0KnqZ4dV2L3C0F3VANiiSzfjk1zRkq7M7vonBlQBSrXs
        9oXHPElq5MkRyE8xSAlN7M9tLvBp9/ihRQfsLDQNrBY/xyrMpq2oE9UM+uhOxgC5
        bt0t6e/MrUpD7A6/Bq50abi2ZozhQLxdgYSdui3kA0Ey8DCBWFT1rwowLtG2oley
        5Syqw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shvnd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 11:33:38 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 20 Sep
 2023 17:33:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 20 Sep 2023 17:33:36 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D9FC458;
        Wed, 20 Sep 2023 16:33:36 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 0/4] Support mute notifications for CS35L41 HDA
Date:   Wed, 20 Sep 2023 16:54:46 +0100
Message-ID: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uF6gvtROUZ6B4XvAkqDpBQLy8315B14s
X-Proofpoint-ORIG-GUID: uF6gvtROUZ6B4XvAkqDpBQLy8315B14s
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems use a special keyboard shortcut to mute speaker audio.
On systems using CS35L41 HDA which have this shortcut, add a
mechanism which uses ACPI notifications to determine when the
shortcut is pressed, and then mute the amps inside the driver.

Since this is not a normal mute mechanism, it does not go through
userspace. To allow userspace to be able to track this special
state, add an ALSA control which tracks the state of this forced
mute

Changes since v2:
- Fixed compile issue when CONFIG_ACPI is missing

Changes since v3:
- Split first patch into 3 separate patches
- Ensure all acpi code is protected by check for CONFIG_ACPI in
realtek driver

Stefan Binding (4):
  ALSA: hda: cs35l41: Add notification support into component binding
  ALSA: hda/realtek: Support ACPI Notification framework via component
    binding
  ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA
  ALSA: hda: cs35l41: Add read-only ALSA control for forced mute

 sound/pci/hda/cs35l41_hda.c   | 132 ++++++++++++++++++++++++++++++----
 sound/pci/hda/cs35l41_hda.h   |   3 +
 sound/pci/hda/hda_component.h |   4 ++
 sound/pci/hda/patch_realtek.c |  83 ++++++++++++++++++++-
 4 files changed, 208 insertions(+), 14 deletions(-)

-- 
2.34.1

