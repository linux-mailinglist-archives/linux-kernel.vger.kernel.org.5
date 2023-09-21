Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA57A97AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjIUR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIUR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C640E5A03A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:02 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38LFWYi4009262;
        Thu, 21 Sep 2023 11:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=e
        3g90nWLjtNABPYClsTtG/D+b84N6Jv+agCdGIxC/PQ=; b=OjnBaORp20nxdEDIw
        1IFcyP1N+7dgbWF2zrp81Pjudw7RhyfYkzXz/WqcpFeshKRiSNKio5yxK+ei71FI
        bBrwEbO6iAOAglBRgvO4BOjLku+177AMmBIphmHSprkbMsi6W4UEY6rF7bCLkYr0
        IJY850T2NgdprR1IeqtE4qRPXseI3J94q4E6L3W5xriH/WorOdPV6klHeaMeBWj0
        vb3HIHWuSqyHgZxjfZaNb/qdZZiiZYFzG12ujmEYhNE1Hq+imYePQgrI4+U1N6cv
        XdbfXOdpe7XujiJr5nAap9VybszkVtl4kDzFc8VoNbH84p532SjMf2pI22NLRQB0
        ERX6w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shx0ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 11:28:58 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 21 Sep
 2023 17:28:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 21 Sep 2023 17:28:57 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BD7CE15B9;
        Thu, 21 Sep 2023 16:28:56 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v5 0/4] Support mute notifications for CS35L41 HDA
Date:   Thu, 21 Sep 2023 17:28:45 +0100
Message-ID: <20230921162849.1988124-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WjyAt0Wl6uRkGUrCaIW0-gF334ZDtVLI
X-Proofpoint-ORIG-GUID: WjyAt0Wl6uRkGUrCaIW0-gF334ZDtVLI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v4:
- Rebase onto for-next branch

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

