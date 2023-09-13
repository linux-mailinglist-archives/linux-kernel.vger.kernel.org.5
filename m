Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBCB79EBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbjIMPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjIMPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:00:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CABAB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:00:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CMxBYt012824;
        Wed, 13 Sep 2023 10:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=+LN7H2ZDQ/GaX+MwOCAMgy5391uuwKBA1IrMvUwY3qs=; b=
        SrDA4BfB2uV8qNacwofFkUbvvaLLLcc4YLfurmkb44JHzZs93ie6W8cnjT/9K2sc
        hv3WwgJUoPwaJnmtnNXOI0DNhOrBKmBFA/5l3fAaDhH6SE3gDBRxIKRgmzeoWZ5k
        7aLZZ7XErk44HU7qIf5dnnKdwb9U9JVeGkLIOGCwIyUxH5MLkhNFMFOv/q80g98B
        13zLM9dN73TF2JSkVvoyVLuhtTRp9dv+yMquDBPuBwdC7UU02U3DR0rzpQN2M/oG
        wWKXg7Jicu13QPaOAdMk3fGXJoAukl7iUnrVUZUPm4+pyVmGmEXbwVOY/9zqTT/5
        dVsl+3aA9QxN1GrLzfNH4g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u125q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:00:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 16:00:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 13 Sep 2023 16:00:21 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.120])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B965711AA;
        Wed, 13 Sep 2023 15:00:20 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 3/3] ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset
Date:   Wed, 13 Sep 2023 16:00:12 +0100
Message-ID: <20230913150012.604775-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
References: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: br98W4FxGg-rapGOWLx5CksctckCik3G
X-Proofpoint-ORIG-GUID: br98W4FxGg-rapGOWLx5CksctckCik3G
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

In SoundWire mode leave hard RESET asserted when exiting probe,
and wait for an UNATTACHED notification before deasserting RESET.

If the boot state of the reset GPIO was deasserted it is possible
that the SoundWire core had already enumerated the CS42L42 before
cs42l42_sdw_probe() is called. When cs42l42_common_probe() hard
resets the CS42L42 it triggers a race condition:

1) After cs42l42_sdw_probe() returns the thread that called it
   will call cs42l42_sdw_update_status() to report the last
   status recorded by the SoundWire core.

2) The SoundWire bus master will see a PING with the CS42L42
   now reporting as unenumerated and will trigger the core
   SoundWire code to start enumerating CS42L42.

These two threads are racing against each other. If (1)
happens before (2) a stale ATTACHED notification will be
reported to the cs42l42 driver when in fact the status of
cs42l42 is now unattached.

To avoid this race condition:

- Leave RESET asserted on exit from cs42l42_sdw_probe().
  This ensures that an UNATTACHED notification must be
  sent to the cs42l42 driver. If cs42l42 was already
  enumerated it will be seen to drop off the bus, causing
  an UNATTACH notification. If it was never enumerated the
  status is already UNATTACHED and this will be reported
  by thread (1).

- When the UNATTACH notification is received, release RESET.
  This will cause CS42L42 to be enumerated and eventually
  report an ATTACHED notification.

- The ATTACHED notification is now valid.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42-sdw.c | 20 ++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 11 ++++++++++-
 sound/soc/codecs/cs42l42.h     |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
index eeab07c850f9..974bae4abfad 100644
--- a/sound/soc/codecs/cs42l42-sdw.c
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -344,6 +344,16 @@ static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
 	switch (status) {
 	case SDW_SLAVE_ATTACHED:
 		dev_dbg(cs42l42->dev, "ATTACHED\n");
+
+		/*
+		 * The SoundWire core can report stale ATTACH notifications
+		 * if we hard-reset CS42L42 in probe() but it had already been
+		 * enumerated. Reject the ATTACH if we haven't yet seen an
+		 * UNATTACH report for the device being in reset.
+		 */
+		if (cs42l42->sdw_waiting_first_unattach)
+			break;
+
 		/*
 		 * Initialise codec, this only needs to be done once.
 		 * When resuming from suspend, resume callback will handle re-init of codec,
@@ -354,6 +364,16 @@ static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
 		break;
 	case SDW_SLAVE_UNATTACHED:
 		dev_dbg(cs42l42->dev, "UNATTACHED\n");
+
+		if (cs42l42->sdw_waiting_first_unattach) {
+			/*
+			 * SoundWire core has seen that CS42L42 is not on
+			 * the bus so release RESET and wait for ATTACH.
+			 */
+			cs42l42->sdw_waiting_first_unattach = false;
+			gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+		}
+
 		break;
 	default:
 		break;
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index dc93861ddfb0..2961340f15e2 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2330,7 +2330,16 @@ int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 		/* Ensure minimum reset pulse width */
 		usleep_range(10, 500);
 
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+		/*
+		 * On SoundWire keep the chip in reset until we get an UNATTACH
+		 * notification from the SoundWire core. This acts as a
+		 * synchronization point to reject stale ATTACH notifications
+		 * if the chip was already enumerated before we reset it.
+		 */
+		if (cs42l42->sdw_peripheral)
+			cs42l42->sdw_waiting_first_unattach = true;
+		else
+			gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 4bd7b85a5747..7785125b73ab 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -53,6 +53,7 @@ struct  cs42l42_private {
 	u8 stream_use;
 	bool hp_adc_up_pending;
 	bool suspended;
+	bool sdw_waiting_first_unattach;
 	bool init_done;
 };
 
-- 
2.34.1

