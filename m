Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B103D7A898B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjITQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbjITQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:34:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E66BEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:34:01 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38KFt6MY023727;
        Wed, 20 Sep 2023 11:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Y3EIDH5LrEXvcmQyYpV3oyEsOlmFpfWoLzUShrGqrvI=; b=
        WQfrfPIwknAdmMjAkIipOz0NasrRePbhVvI29Qq/g1WupNYodOszLw8A62lZpdaa
        3OkOQL0EegGIVpQawZxuWjEmVgXNMKeCezqmVYAiYDdpUbx3MqjoglnHDg9UTTkg
        UAwPciDj0Ln6Fjsf/ZWCt7VbBBaHAvMS12ljDwyjMyMSTEmWSYCfh7MpMbgC5AFz
        hTXJSAh38oVSmpM9+CRckVhe9YOJgJf+lWhWefXb60SLNpq/06szw0x+rFq2UC1O
        LpCaxbXrmLgs8hNejQTDJJJOZuhQy0aIw6bE1C8VFQoC6ioFcisuMHW8GOgC+Fwm
        0pRewo2qT/xc/yjsr4K6gg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shvnd5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 11:33:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 20 Sep
 2023 17:33:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 20 Sep 2023 17:33:37 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CAE3F458;
        Wed, 20 Sep 2023 16:33:36 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 2/4] ALSA: hda/realtek: Support ACPI Notification framework via component binding
Date:   Wed, 20 Sep 2023 16:54:48 +0100
Message-ID: <20230920155450.576287-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
References: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6fw_6BTS-k4AARnC7Tuk2tinWb8WdIw5
X-Proofpoint-ORIG-GUID: 6fw_6BTS-k4AARnC7Tuk2tinWb8WdIw5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For systems which have support for ACPI notifications, add a mechanism to
register a handler for ACPI notifications and then call the acpi_notify
api on the bound components.

Registering a handler in the Realtek HDA driver, allows a single handler to
be registered, which then calls into all the components, rather than
attempting to register the same handler multiple times, once for each
component.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 83 ++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 751783f3a15c..1cd897ac6586 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10,6 +10,7 @@
  *                    Jonathan Woithe <jwoithe@just42.net>
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -6704,12 +6705,91 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
+#ifdef CONFIG_ACPI
+static void comp_acpi_device_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct hda_codec *cdc = data;
+	struct alc_spec *spec = cdc->spec;
+	int i;
+
+	codec_info(cdc, "ACPI Notification %d\n", event);
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (spec->comps[i].dev && spec->comps[i].acpi_notify)
+			spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
+						   spec->comps[i].dev);
+	}
+}
+
+static int comp_bind_acpi(struct device *dev)
+{
+	struct hda_codec *cdc = dev_to_hda_codec(dev);
+	struct alc_spec *spec = cdc->spec;
+	bool support_notifications = false;
+	struct acpi_device *adev;
+	int ret;
+	int i;
+
+	adev = spec->comps[0].adev;
+	if (!acpi_device_handle(adev))
+		return 0;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++)
+		support_notifications = support_notifications ||
+			spec->comps[i].acpi_notifications_supported;
+
+	if (support_notifications) {
+		ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+						comp_acpi_device_notify, cdc);
+		if (ret < 0) {
+			codec_warn(cdc, "Failed to install notify handler: %d\n", ret);
+			return 0;
+		}
+
+		codec_dbg(cdc, "Notify handler installed\n");
+	}
+
+	return 0;
+}
+
+static void comp_unbind_acpi(struct device *dev)
+{
+	struct hda_codec *cdc = dev_to_hda_codec(dev);
+	struct alc_spec *spec = cdc->spec;
+	struct acpi_device *adev;
+	int ret;
+
+	adev = spec->comps[0].adev;
+	if (!acpi_device_handle(adev))
+		return;
+
+	ret = acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					 comp_acpi_device_notify);
+	if (ret < 0)
+		codec_warn(cdc, "Failed to uninstall notify handler: %d\n", ret);
+}
+#else
+static int comp_bind_acpi(struct device *dev)
+{
+	return 0;
+}
+
+static void comp_unbind_acpi(struct device *dev)
+{
+}
+#endif
+
 static int comp_bind(struct device *dev)
 {
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
 	struct alc_spec *spec = cdc->spec;
+	int ret;
+
+	ret = component_bind_all(dev, spec->comps);
+	if (ret)
+		return ret;
 
-	return component_bind_all(dev, spec->comps);
+	return comp_bind_acpi(dev);
 }
 
 static void comp_unbind(struct device *dev)
@@ -6717,6 +6797,7 @@ static void comp_unbind(struct device *dev)
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
 	struct alc_spec *spec = cdc->spec;
 
+	comp_unbind_acpi(dev);
 	component_unbind_all(dev, spec->comps);
 }
 
-- 
2.34.1

