Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8B79D659
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjILQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjILQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:32:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D610EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:32:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CFSmv7002448;
        Tue, 12 Sep 2023 11:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Y
        zq9Xw4dTcc5E2TJ7dbQo9WUoZ24uQ0OYS9i7lTvOIE=; b=o/iE9Cum2iFUEYrLR
        KjePNT74rq72mj66a4QBGI2U7JYIBOm/Z8FRWkM0sNRZw28mE9epAptvjy3JITKI
        IJvADMAXIrOmyvmGXQg1a3BW7nhPYkkBLsaOtEMIgCbFhIk9GOgLyYkoPhbVjyoN
        QkpkQNPjk5FtgsksT2r58iNDyI8r9WL73+PAv52CngHXpzZKDUa3S1bFtV6DcoDX
        +KZicOPf9yamOqfWuq9cDB0zT1KT59/UcHm7Qyx8Y4g2/Z/rFXo/4j2BIc1LMX2n
        krPN09BFmVfP4iyFpZfTTuVg8X80DuCw3QkcIFp/fg+BHYEpTD5in4alZfP0O09N
        DDxRg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t0p3xkxda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:32:10 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 12 Sep
 2023 17:32:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 17:32:08 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E5B9815B4;
        Tue, 12 Sep 2023 16:32:07 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/4] ASoC: cs35l56: Use PCI SSID to select specific firmware
Date:   Tue, 12 Sep 2023 17:32:03 +0100
Message-ID: <20230912163207.3498161-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SBbUJ2GtAPPLx8gAMzW7KuSaoCNZSC6r
X-Proofpoint-GUID: SBbUJ2GtAPPLx8gAMzW7KuSaoCNZSC6r
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI device registers contain a subsystem ID (SSID), that is
separate from the silicon ID. The PCI specification defines it thus:

"They provide a mechanism for board vendors to distiguish their
 boards from one another even thought the boards may have the same
 PCI controller on them."

This allows the driver for the silicon part to apply board-speficic
settings based on this SSID.

The CS35L56 driver uses this to select the correct firmware file for
the board. The actual ID is part of the PCI register set of the
host audio interface so this set of patches includes extracting the
SSID from the Intel audio controller and passing it to the machine
driver and then to ASoC components. Other PCI audio controllers
will have the same SSID registers, so can use the same mechanism to
pass the SSID.

Richard Fitzgerald (4):
  ASoC: soc-card: Add storage for PCI SSID
  ASoC: SOF: Pass PCI SSID to machine driver
  ASoC: Intel: sof_sdw: Copy PCI SSID to struct snd_soc_card
  ASoC: cs35l56: Use PCI SSID as the firmware UID

 include/sound/soc-acpi.h         |  7 ++++++
 include/sound/soc-card.h         | 37 ++++++++++++++++++++++++++++++++
 include/sound/soc.h              | 11 ++++++++++
 include/sound/sof.h              |  8 +++++++
 sound/soc/codecs/cs35l56.c       | 11 ++++++++++
 sound/soc/intel/boards/sof_sdw.c |  6 ++++++
 sound/soc/sof/sof-audio.c        |  7 ++++++
 sound/soc/sof/sof-pci-dev.c      |  8 +++++++
 8 files changed, 95 insertions(+)

-- 
2.30.2

