Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0A7987FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbjIHNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjIHNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:35:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19711FF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:35:14 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 388DVCU1024816;
        Fri, 8 Sep 2023 08:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=7
        Q1bMdFF8qssB8HbjyNHSdSroHRT5TGY85PxL9LdwiA=; b=TzAcFcrsuHgE4yGiD
        E8V5H7arzjx9fbO0M5zZnXG5XUgDyDMAWoQIx4cStt5qRUBo6JCJqw1cK1lqY2Nd
        6wu2UKbPMStQh6ugjpmjNh8QNCSdHBkC7xfWsIzmBbH0hYAT1pFodpZBf6FzUInT
        E+9lRy5ppq2Modqf5QOFBVQAB47MiDqkrSKyHed674H05ewBu3lovSWK30GBCZYk
        isQzLDCThfoQEKCcGbS5jx9n8xBka/2eq3SbSgqBNBdopszXJTXxP41aJprOGCnB
        w7haC+rJIDgfII4HQxgaOdPqjpryEYYNSLMHksJc5r5JxXesm4Aqrqu1tJmNBDRq
        7rvhQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t04h1g089-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:34:39 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 8 Sep
 2023 14:34:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 8 Sep 2023 14:34:30 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.124])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1CF5946B;
        Fri,  8 Sep 2023 13:34:30 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/2] Support mute notifications for CS35L41 HDA
Date:   Fri, 8 Sep 2023 14:34:19 +0100
Message-ID: <20230908133421.2483508-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gGxLBr66fjl9RbikcD5VzG6UR9hTq_Fs
X-Proofpoint-GUID: gGxLBr66fjl9RbikcD5VzG6UR9hTq_Fs
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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

Stefan Binding (1):
  ALSA: hda: cs35l41: Add read-only ALSA control for forced mute

Vitaly Rodionov (1):
  ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA

 sound/pci/hda/cs35l41_hda.c   | 132 ++++++++++++++++++++++++++++++----
 sound/pci/hda/cs35l41_hda.h   |   3 +
 sound/pci/hda/hda_component.h |   4 ++
 sound/pci/hda/patch_realtek.c |  57 ++++++++++++++-
 4 files changed, 182 insertions(+), 14 deletions(-)

-- 
2.34.1

