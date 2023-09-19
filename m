Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702A7A6686
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjISOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjISOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:23:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F652181
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:23:07 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38J4KMPD022193;
        Tue, 19 Sep 2023 09:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=y
        mCJde178UwL4TYnW7s7IyEfWXED9q+z5lMLNLuhi3A=; b=rABvyKCR5r1jR97Q4
        BeNNTwSLu/LgjfN+q7Lx69h3dJSeSC2qZNbNIQYxgPtuyFSX0Ikn+14d7myfs+UJ
        tBYfeax4dAt71X6oR/n9XSK55T08fNAm8grc9yBRi3ypMlwpB5wVBT24oPkirBix
        YktCYnEDOGwg2MoxKRQLANYHBQlMa5DA7WLWTqGlLhfDqIV7ndmxKwC/fxJK8laO
        4fL4DBOtyCOutmW0sVaFc6s16AZplGNXSfn5UgJ0j0GvVGY0NWK6ck+d8fTB49zK
        SiECPNIJxbc7Lk/FOP+eqYJlG/kgF87ajuHKyIe2VGnieav4AOgfRv3cT+PybzF9
        fGWMg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry3y7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 09:22:52 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 19 Sep
 2023 15:22:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 19 Sep 2023 15:22:49 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B11C811AB;
        Tue, 19 Sep 2023 14:22:49 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 0/2] Support mute notifications for CS35L41 HDA
Date:   Tue, 19 Sep 2023 15:22:38 +0100
Message-ID: <20230919142240.467682-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sBpAx-564mdkuf1hDpvQdlgRriHoT1e_
X-Proofpoint-ORIG-GUID: sBpAx-564mdkuf1hDpvQdlgRriHoT1e_
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

Stefan Binding (1):
  ALSA: hda: cs35l41: Add read-only ALSA control for forced mute

Vitaly Rodionov (1):
  ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA

 sound/pci/hda/cs35l41_hda.c   | 132 ++++++++++++++++++++++++++++++----
 sound/pci/hda/cs35l41_hda.h   |   3 +
 sound/pci/hda/hda_component.h |   4 ++
 sound/pci/hda/patch_realtek.c |  85 +++++++++++++++++++++-
 4 files changed, 210 insertions(+), 14 deletions(-)

-- 
2.34.1

