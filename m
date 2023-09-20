Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF17A898F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjITQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjITQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:34:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC2D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:34:07 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38K3qoWl031049;
        Wed, 20 Sep 2023 11:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=EJ5ed+ITbEi3A3t572jlfnIzGCe9Zx/6EDGQBJFmsQs=; b=
        iEA0VVrL2eZNmVmuWR9A+erQ+xj0eT7auZuK9JmP9ECgmq1WQzi3oXDbfT1tJhfq
        BgJYXz/n0/HWDb/35PpWqSA49giivSRNSerSDw+fh5ijjLf9HvQVdmjMTg/LLLCE
        fzMuTKy4O1RBjNhpiU8NSAaSyYAunCAmEG0xm5R8dzep1fGkc/M0/7eWHdI2vjIH
        90Gj+DXTQrIY0T420OHVcdQCMCWCQgkWPwPXjDw5z5h77JjRX4CctXKf/brcWb+Y
        eHJJZ1qh5eDFIfCUZitfRGR8CNKY8JhtdueonEZdKBV+xrXNcz+zOUYkhC5nvVOd
        YZk4gbB3pPJ5B5H01fr2LA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry5sr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 11:33:38 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 20 Sep
 2023 17:33:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 20 Sep 2023 17:33:36 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9AF3711CD;
        Wed, 20 Sep 2023 16:33:36 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 1/4] ALSA: hda: cs35l41: Add notification support into component binding
Date:   Wed, 20 Sep 2023 16:54:47 +0100
Message-ID: <20230920155450.576287-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
References: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E-6Negf5VwOxcjlf6n5al58UGsIvUc7q
X-Proofpoint-ORIG-GUID: E-6Negf5VwOxcjlf6n5al58UGsIvUc7q
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems support a notification from ACPI, which can be used
for different things.

Only one handler can be registered for the acpi notification, but all
amps need to receive that notification, we can register a single handler
inside the component master, so that it can then notify through the
component framework.

This is required to support mute notifications from ACPI.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/hda_component.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index f170aec967c1..bbd6f0ed16c1 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -6,6 +6,7 @@
  *                    Cirrus Logic International Semiconductor Ltd.
  */
 
+#include <linux/acpi.h>
 #include <linux/component.h>
 
 #define HDA_MAX_COMPONENTS	4
@@ -15,6 +16,9 @@ struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
 	struct hda_codec *codec;
+	struct acpi_device *adev;
+	bool acpi_notifications_supported;
+	void (*acpi_notify)(acpi_handle handle, u32 event, struct device *dev);
 	void (*pre_playback_hook)(struct device *dev, int action);
 	void (*playback_hook)(struct device *dev, int action);
 	void (*post_playback_hook)(struct device *dev, int action);
-- 
2.34.1

