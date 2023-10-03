Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0314E7B6B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjJCOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjJCOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:22:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29393
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:22:17 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 393DCOkb031857;
        Tue, 3 Oct 2023 09:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=B
        b3GpnlgSqQLro9IisI3/aE52cZDpykC3Lf7qb/4cGc=; b=RVybI8Rhe1c3GAYCQ
        sBWTBAInWeD3BHnOKW0tXBn0j6muCVIYLPKZVyz8jKw6cL0LmB+vJRfnhVrhGQsA
        GC4pcysTKpeq/k/WtqzJmBfgbC3BJa4FFnGEb+o6R4/w2HoAiu8DkH+NQ1s2NJao
        yqqwiGmyx7FgfdPSLMukCegBySUJPBKYgCO0ype9Na1CzsCR2TJTN8IpFPKIKQXR
        qKoJBdlmpFmwxQulK+izZ6yrRkiqbKoGxlcLE8ohBZE3NaUV5XhjQju4y9h13lOW
        vHyR0fCtsSEY1OL9seugl3WjA8/XLuEiIIymihasSjaf5BgSOsVmfx9tSN7Lfgck
        Smoaw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3teg3k41wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 09:21:50 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 3 Oct
 2023 15:21:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 3 Oct 2023 15:21:48 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.165])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7E0D211AC;
        Tue,  3 Oct 2023 14:21:48 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@linaro.org>
Subject: [PATCH v1] ALSA: hda: cs35l41: Cleanup and fix double free in firmware request
Date:   Tue, 3 Oct 2023 15:21:38 +0100
Message-ID: <20231003142138.180108-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2yldpt3QjVh-CIwuzVOKdDE5ttRfCRio
X-Proofpoint-ORIG-GUID: 2yldpt3QjVh-CIwuzVOKdDE5ttRfCRio
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unlikely but possible double free when loading firmware,
and a missing free calls if a firmware is successfully requested but
the coefficient file request fails, leading to the fallback firmware
request occurring without clearing the previously loaded firmware.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309291331.0JUUQnPT-lkp@intel.com/

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 115 +++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index dd10b4cd3d1a..28cb10ddd191 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -188,10 +188,14 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 					    cs35l41->speaker_id, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
-		return cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						     CS35L41_FIRMWARE_ROOT,
-						     cs35l41->acpi_subsystem_id, cs35l41->amp_name,
-						     cs35l41->speaker_id, "bin");
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+
+		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
@@ -200,10 +204,14 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
-		return cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						     CS35L41_FIRMWARE_ROOT,
-						     cs35l41->acpi_subsystem_id, cs35l41->amp_name,
-						     cs35l41->speaker_id, "bin");
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+
+		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-spkidN>.wmfw */
@@ -218,10 +226,14 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
-			return cs35l41_request_firmware_file(cs35l41, coeff_firmware,
-							     coeff_filename, CS35L41_FIRMWARE_ROOT,
-							     cs35l41->acpi_subsystem_id, NULL,
-							     cs35l41->speaker_id, "bin");
+			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware,
+							    coeff_filename, CS35L41_FIRMWARE_ROOT,
+							    cs35l41->acpi_subsystem_id, NULL,
+							    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+
+		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
@@ -236,12 +248,50 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 						    cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
-			return cs35l41_request_firmware_file(cs35l41, coeff_firmware,
-							     coeff_filename, CS35L41_FIRMWARE_ROOT,
-							     cs35l41->acpi_subsystem_id, NULL,
-							     cs35l41->speaker_id, "bin");
+			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware,
+							    coeff_filename, CS35L41_FIRMWARE_ROOT,
+							    cs35l41->acpi_subsystem_id, NULL,
+							    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+	}
+
+	return ret;
+coeff_err:
+	release_firmware(*wmfw_firmware);
+	kfree(*wmfw_filename);
+	return ret;
+}
+
+static int cs35l41_fallback_firmware_file(struct cs35l41_hda *cs35l41,
+					  const struct firmware **wmfw_firmware,
+					  char **wmfw_filename,
+					  const struct firmware **coeff_firmware,
+					  char **coeff_filename)
+{
+	int ret;
+
+	/* Handle fallback */
+	dev_warn(cs35l41->dev, "Falling back to default firmware.\n");
+
+	/* fallback try cirrus/part-dspN-fwtype.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
+	if (ret)
+		goto err;
+
+	/* fallback try cirrus/part-dspN-fwtype.bin */
+	ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
+	if (ret) {
+		release_firmware(*wmfw_firmware);
+		kfree(*wmfw_filename);
+		goto err;
 	}
+	return 0;
 
+err:
+	dev_warn(cs35l41->dev, "Unable to find firmware and tuning\n");
 	return ret;
 }
 
@@ -257,7 +307,6 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 		ret = cs35l41_request_firmware_files_spkid(cs35l41, wmfw_firmware, wmfw_filename,
 							   coeff_firmware, coeff_filename);
 		goto out;
-
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
@@ -270,6 +319,9 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 						    -1, "bin");
+		if (ret)
+			goto coeff_err;
+
 		goto out;
 	}
 
@@ -289,32 +341,23 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 							    CS35L41_FIRMWARE_ROOT,
 							    cs35l41->acpi_subsystem_id, NULL, -1,
 							    "bin");
+		if (ret)
+			goto coeff_err;
 	}
 
 out:
-	if (!ret)
-		return 0;
+	if (ret)
+		/* if all attempts at finding firmware fail, try fallback */
+		goto fallback;
 
-	/* Handle fallback */
-	dev_warn(cs35l41->dev, "Falling back to default firmware.\n");
+	return 0;
 
+coeff_err:
 	release_firmware(*wmfw_firmware);
 	kfree(*wmfw_filename);
-
-	/* fallback try cirrus/part-dspN-fwtype.wmfw */
-	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
-	if (!ret)
-		/* fallback try cirrus/part-dspN-fwtype.bin */
-		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
-
-	if (ret) {
-		release_firmware(*wmfw_firmware);
-		kfree(*wmfw_filename);
-		dev_warn(cs35l41->dev, "Unable to find firmware and tuning\n");
-	}
-	return ret;
+fallback:
+	return cs35l41_fallback_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					      coeff_firmware, coeff_filename);
 }
 
 #if IS_ENABLED(CONFIG_EFI)
-- 
2.34.1

