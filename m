Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71C17A4663
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbjIRJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjIRJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:51:48 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16521115
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:51:42 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I6K0DO017792;
        Mon, 18 Sep 2023 04:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=O
        ekxzRcVaZo051lSiRKtMaMlNmQuGAT/oxmqstQ4suc=; b=gfd3uiuOnWYePPdhl
        bCXvCzRs1/ROHAIha7pMHyteS/I6mlruBwTeyXRtpgxlgeLKNQXE907/VaAk7CTM
        OvccVfFLSL6ymPd2HLqjpBw4h/OvRDxRspctV1f6eS8Bsh3zqt1DY45BbCt9LTLV
        DDUNDmkS9RMMTCDYMHs3kO3z222qocZOR3MO4XY3ReiEFxVr3odd8f8qSK+XQltL
        w+xDCkMRPKVx8rLyc+NeplW8p3G0LWGRm+tWZiW/aqlU9ldAvZmjOcurFg+ZfwiF
        F/ashZ07xeRG3U1oZ2LVtRdILoWjjPyJHWfuFAxt5WyfSmhUNcL5bjuyc7SDXHcZ
        SplWQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry256c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 04:51:35 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 10:51:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 18 Sep 2023 10:51:33 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.90.238.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9DE0611AA;
        Mon, 18 Sep 2023 09:51:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ALSA: hda: cs35l56: Handle speaker id GPIOs
Date:   Mon, 18 Sep 2023 10:51:27 +0100
Message-ID: <20230918095129.440-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lvXNau_bsidQSZVhdqEAskyfFpke2A4r
X-Proofpoint-ORIG-GUID: lvXNau_bsidQSZVhdqEAskyfFpke2A4r
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some manufacturers use multiple sources of speakers. Motherboard
GPIOs are set to indicate which type of speaker is fitted so that
the correct tunings can be loaded. Patch #1 adds support for this
and patch #2 adds a KUnit test for the new code.

Richard Fitzgerald (2):
  ALSA: hda: cs35l56: Add support for speaker id
  ALSA: hda: cirrus_scodec: Add KUnit test

 MAINTAINERS                        |   1 +
 sound/pci/hda/Kconfig              |  17 ++
 sound/pci/hda/Makefile             |   4 +
 sound/pci/hda/cirrus_scodec.c      |  73 ++++++
 sound/pci/hda/cirrus_scodec.h      |  13 +
 sound/pci/hda/cirrus_scodec_test.c | 370 +++++++++++++++++++++++++++++
 sound/pci/hda/cs35l56_hda.c        |  24 +-
 7 files changed, 501 insertions(+), 1 deletion(-)
 create mode 100644 sound/pci/hda/cirrus_scodec.c
 create mode 100644 sound/pci/hda/cirrus_scodec.h
 create mode 100644 sound/pci/hda/cirrus_scodec_test.c

-- 
2.30.2

