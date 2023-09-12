Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2ED79D65C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjILQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjILQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:32:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD70115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:32:25 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CFSmvB002448;
        Tue, 12 Sep 2023 11:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=zuTD6xUOqe5ttLHRaL7ledsFp6jAZIFBIzNeGgXzKvE=; b=
        mOg3F+2qsNELUfeanFVa1JWQI/QI5yLIsitAFFHbQq305NxzzHM0O1gmS9m0sCph
        6bBYKrWXMhOuVn3WOwQVUXDGUMGeOBYyeUHogp0GWauI1PkRO4i3vatt/JGvyleA
        eRZfOP6QNciZTgOsrbkXQJnQL20Xajv52GeHWQZTmw8q3IHZ+QOtw/B/APLMr6Ee
        CQ/2wyGqCS6UyB0u3CPb8nf6HZR+93gt8y3DsG1MBduRCwKDyIfT7rpXfzbHnCVg
        yGyeQt8k3ukSpPrNHoNhD/dzSy7Ae4DjDR0eIzdWZXXKAmiApskWeNc9Xq93kVpI
        IxdA15J465rIjgg3/mcFIA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t0p3xkxdb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:32:12 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 12 Sep
 2023 17:32:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 17:32:08 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1CAD9357E;
        Tue, 12 Sep 2023 16:32:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/4] ASoC: cs35l56: Use PCI SSID as the firmware UID
Date:   Tue, 12 Sep 2023 17:32:07 +0100
Message-ID: <20230912163207.3498161-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230912163207.3498161-1-rf@opensource.cirrus.com>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7hYpPUTJ90bkPvCtkdDOjw6LX3fN5cDL
X-Proofpoint-GUID: 7hYpPUTJ90bkPvCtkdDOjw6LX3fN5cDL
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver properties do not define a cirrus,firmware-uid try to get the
PCI SSID as the UID.

On PCI-based systems the PCI SSID is used to uniquely identify the specific
sound hardware. This is the standard mechanism for x86 systems and is the
way to get a unique system identifier for systems that use the CS35L56 on
SoundWire.

For non-SoundWire systems there is no Windows equivalent of the ASoC driver
in I2C/SPI mode. These would be:

1. HDA systems, which are handled by the HDA subsystem.
2. Linux-specific systems.
3. Composite devices where the cs35l56 is not present in ACPI and is
   configured using software nodes.

Case 2 can use the firmware-uid property, though the PCI SSID is supported
as an alternative, as it is the standard PCI mechanism.

Case 3 is a SoundWire system where some other codec is the SoundWire bridge
device and CS35L56 is not listed in ACPI. As these are SoundWire systems
they will normally use the PCI SSID.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index f2e7c6d0be46..e6e366333a47 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -772,9 +772,20 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 	struct dentry *debugfs_root = component->debugfs_root;
+	unsigned short vendor, device;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_tx_input_texts) != ARRAY_SIZE(cs35l56_tx_input_values));
 
+	if (!cs35l56->dsp.system_name &&
+	    (snd_soc_card_get_pci_ssid(component->card, &vendor, &device) == 0)) {
+		cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
+							  GFP_KERNEL,
+							  "%04x%04x",
+							  vendor, device);
+		if (!cs35l56->dsp.system_name)
+			return -ENOMEM;
+	}
+
 	if (!wait_for_completion_timeout(&cs35l56->init_completion,
 					 msecs_to_jiffies(5000))) {
 		dev_err(cs35l56->base.dev, "%s: init_completion timed out\n", __func__);
-- 
2.30.2

