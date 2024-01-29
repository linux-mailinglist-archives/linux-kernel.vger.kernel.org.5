Return-Path: <linux-kernel+bounces-43080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72844840B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1282E1F2222D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2315699E;
	Mon, 29 Jan 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k3BSmIxC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B2155A5D;
	Mon, 29 Jan 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545680; cv=none; b=g6l1oH9GzYKbPRG9UVs8RLvwuWEIAvU5ZPrrQ/CUrROCPJdUQvdfpOtefESApi5bSlAL0OYF6bNLF2BS227/qFRtxwDOGpp8iv0Zr3YKgrzikpvykm9PIt2ScwKe/vpt2mVZ3UI07ebGKEl1L1R2p3bp7OzZQz0FJ5ebPS6n1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545680; c=relaxed/simple;
	bh=YNy1JWOtLJKU45sFmv/JhPh9ECD5YpTQr0LWjodMVxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOtSRQxOBBl4DFZUemEBtORjGE+qONu92eQPz0A5og79nnrH3SFSh5oIeeC/KH7OHKJ0pizXtBrF6RPNQ21MAsYGfHFx87ZnFgGCWrfxPmlgP/e/L9t880lgc6WLV383kPIf6z7PNMnN3qYOSpi2uEsxA6gU0dahGtE5eliSGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=k3BSmIxC; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM09006968;
	Mon, 29 Jan 2024 10:27:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=/NhAJ3fdwCVsLA5bc0/RGJ1iAFv0wBsPiSTQRRzHFRo=; b=
	k3BSmIxCWwDFA19lGaxa3gbUzVbGUSbyGf/g4TssO3co6eK/j1wz7ISQOvXv/aMK
	4tS3mAAuOZssTMwWPPzq4utImA2J4yZBMgmMncABsP/9LQbRJwGIlIAJukK87bST
	2Rj/rvZ48T/YgWbZzXsD+cZQHSj9A2KrHv00EOHu4RRGsQlvCj/gl2flVExxy3pD
	vx6fajVZt14CmLZ+fETtj99eMq9UMSAB4mHT//9aXXyvhklSllaGorew5FsKOI8F
	aCf9AHOftRi5r/gmQehSJ12YPHOGB6iamnlWN/hCUK8H25D9x09gdqj1mtk7rh3w
	AiAOQnxRR6a38JBHM5Zruw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:51 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:42 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:42 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B6772820247;
	Mon, 29 Jan 2024 16:27:41 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 01/18] ASoC: wm_adsp: Fix firmware file search order
Date: Mon, 29 Jan 2024 16:27:20 +0000
Message-ID: <20240129162737.497-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AAA_zOVOg9JmAI51yfuMMNJEDPvciKib
X-Proofpoint-GUID: AAA_zOVOg9JmAI51yfuMMNJEDPvciKib
X-Proofpoint-Spam-Reason: safe

Check for the cases of system-specific bin file without a
wmfw before falling back to looking for a generic wmfw.

All system-specific options should be tried before falling
back to loading a generic wmfw/bin. With the original code,
the presence of a fallback generic wmfw on the filesystem
would prevent using a system-specific tuning with a ROM
firmware.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 0e7d82cbea8b ("ASoC: wm_adsp: Add support for loading bin files without wmfw")
---
 sound/soc/codecs/wm_adsp.c | 44 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c01e31175015..bd60ceebb6a9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -823,6 +823,23 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 		}
 	}
 
+	/* Check system-specific bin without wmfw before falling back to generic */
+	if (dsp->wmfw_optional && system_name) {
+		if (asoc_component_prefix)
+			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+						      cirrus_dir, system_name,
+						      asoc_component_prefix, "bin");
+
+		if (!*coeff_firmware)
+			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+						      cirrus_dir, system_name,
+						      NULL, "bin");
+
+		if (*coeff_firmware)
+			return 0;
+	}
+
+	/* Check legacy location */
 	if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
 					   "", NULL, NULL, "wmfw")) {
 		wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
@@ -830,38 +847,15 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 		return 0;
 	}
 
+	/* Fall back to generic wmfw and optional matching bin */
 	ret = wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
 					    cirrus_dir, NULL, NULL, "wmfw");
-	if (!ret) {
+	if (!ret || dsp->wmfw_optional) {
 		wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
 					      cirrus_dir, NULL, NULL, "bin");
 		return 0;
 	}
 
-	if (dsp->wmfw_optional) {
-		if (system_name) {
-			if (asoc_component_prefix)
-				wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
-							      cirrus_dir, system_name,
-							      asoc_component_prefix, "bin");
-
-			if (!*coeff_firmware)
-				wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
-							      cirrus_dir, system_name,
-							      NULL, "bin");
-		}
-
-		if (!*coeff_firmware)
-			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
-						      "", NULL, NULL, "bin");
-
-		if (!*coeff_firmware)
-			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
-						      cirrus_dir, NULL, NULL, "bin");
-
-		return 0;
-	}
-
 	adsp_err(dsp, "Failed to request firmware <%s>%s-%s-%s<-%s<%s>>.wmfw\n",
 		 cirrus_dir, dsp->part, dsp->fwf_name, wm_adsp_fw[dsp->fw].file,
 		 system_name, asoc_component_prefix);
-- 
2.39.2


