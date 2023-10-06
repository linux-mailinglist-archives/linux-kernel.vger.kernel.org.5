Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5027BB5FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjJFLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJFLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2850DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:10:52 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3965fxce025983;
        Fri, 6 Oct 2023 06:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=RlyXKyITjmeNbb6voK2kiPtwUMgBnTpkOA+RxMPoLIg=; b=
        QPOi9KeQqQpZRQU+r2xbZi+XuvNxhBp7qpe46+J1LFQhcf0/TUgjngZ5WnC1dnW2
        gYhQ9YcSo4/Lj6Y2CNNPiLvyLgp9tksCwUT7n2UHjSwcCk7B8jvZQvOrN+jAuAmB
        mkDOMtxjmgHBp1/gPqjLCDucE+6LtoPA4bRyVzLcU1map4KgGMGOQe6x5UZ+XUq9
        b5hk5qlUyPjs1Xrp5MRUW8y8yMEZCiPLlGJLrCSdMm30r0ftzWsDAO/Si20qGmW1
        +JbzZHVcbOTPWMfXfIjlqOud9ngfcf2ITJdHQgORXlHAR60lE26Rc8JiLgtpPzFn
        JDNBkwUumvXylA4ki2IZLQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3th2dtbmxb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 06:10:45 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 6 Oct
 2023 12:10:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 6 Oct 2023 12:10:42 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A1CEA11AA;
        Fri,  6 Oct 2023 11:10:42 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/4] ASoC: cs35l56: Wake transactions need to be issued twice
Date:   Fri, 6 Oct 2023 12:10:37 +0100
Message-ID: <20231006111039.101914-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006111039.101914-1-rf@opensource.cirrus.com>
References: <20231006111039.101914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vfrFDBZ8iX4B25Cg-1VZgT8UXHnE1qt4
X-Proofpoint-GUID: vfrFDBZ8iX4B25Cg-1VZgT8UXHnE1qt4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

As the dummy wake is a toggling signal (either I2C or SPI activity) it
is not guaranteed to meet the minimum asserted hold time for a wake
signal. In this case the wake must guarantee rising edges separated by
at least the minimum hold time.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 51 +++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 762b96b29211..8c18e8b6d27d 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -243,6 +243,7 @@
 #define CS35L56_HALO_STATE_POLL_US			1000
 #define CS35L56_HALO_STATE_TIMEOUT_US			50000
 #define CS35L56_RESET_PULSE_MIN_US			1100
+#define CS35L56_WAKE_HOLD_TIME_US			1000
 
 #define CS35L56_SDW1_PLAYBACK_PORT			1
 #define CS35L56_SDW1_CAPTURE_PORT			3
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 68dc93b82789..953ba066bab1 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -446,6 +446,32 @@ static const struct reg_sequence cs35l56_hibernate_wake_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_WAKEUP),
 };
 
+static void cs35l56_issue_wake_event(struct cs35l56_base *cs35l56_base)
+{
+	/*
+	 * Dummy transactions to trigger I2C/SPI auto-wake. Issue two
+	 * transactions to meet the minimum required time from the rising edge
+	 * to the last falling edge of wake.
+	 *
+	 * It uses bypassed write because we must wake the chip before
+	 * disabling regmap cache-only.
+	 *
+	 * This can NAK on I2C which will terminate the write sequence so the
+	 * single-write sequence is issued twice.
+	 */
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+					cs35l56_hibernate_wake_seq,
+					ARRAY_SIZE(cs35l56_hibernate_wake_seq));
+
+	usleep_range(CS35L56_WAKE_HOLD_TIME_US, 2 * CS35L56_WAKE_HOLD_TIME_US);
+
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+					cs35l56_hibernate_wake_seq,
+					ARRAY_SIZE(cs35l56_hibernate_wake_seq));
+
+	cs35l56_wait_control_port_ready();
+}
+
 int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int val;
@@ -500,17 +526,9 @@ int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_sou
 	if (!cs35l56_base->can_hibernate)
 		goto out_sync;
 
-	if (!is_soundwire) {
-		/*
-		 * Dummy transaction to trigger I2C/SPI auto-wake. This will NAK on I2C.
-		 * Must be done before releasing cache-only.
-		 */
-		regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-						cs35l56_hibernate_wake_seq,
-						ARRAY_SIZE(cs35l56_hibernate_wake_seq));
-
-		cs35l56_wait_control_port_ready();
-	}
+	/* Must be done before releasing cache-only */
+	if (!is_soundwire)
+		cs35l56_issue_wake_event(cs35l56_base);
 
 out_sync:
 	regcache_cache_only(cs35l56_base->regmap, false);
@@ -578,13 +596,14 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	unsigned int devid, revid, otpid, secured;
 
 	/*
-	 * If the system is not using a reset_gpio then issue a
-	 * dummy read to force a wakeup.
+	 * When the system is not using a reset_gpio ensure the device is
+	 * awake, otherwise the device has just been released from reset and
+	 * the driver must wait for the control port to become usable.
 	 */
 	if (!cs35l56_base->reset_gpio)
-		regmap_read(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
-
-	cs35l56_wait_control_port_ready();
+		cs35l56_issue_wake_event(cs35l56_base);
+	else
+		cs35l56_wait_control_port_ready();
 
 	/*
 	 * The HALO_STATE register is in different locations on Ax and B0
-- 
2.30.2

