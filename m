Return-Path: <linux-kernel+bounces-43094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4588F840B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784C81C20FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE71586E1;
	Mon, 29 Jan 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PVklpkRx"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD4158D74;
	Mon, 29 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545687; cv=none; b=Jr4p7ahR1D44CA8TcCBr4A8P3E3XVKwYuMmNjgV22eFMYGgfcypog129+k/6xR1dG82a7A++kfbLVjcnb+GDK2ZHlBMWuPG1NGBea3nBj/4QHJ0V4+TlOYIlv3zcNo4jXXtlEoKxumHckRzrdaezqNPB6ExYVq1NNNYHskGMDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545687; c=relaxed/simple;
	bh=WMa+E/IsJJh0xMAdW5rdDO4TW2hkjRiEiK+MOHP5ggk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZEPWk4I+qCiwsLJ5p1QHeVoG/Sy5o/99S+p7UjY3MTEWc5I6y/N92ALS9BPckJm23/nJycSVlUcpPiCXZAVDR3/214iV/KUCEHU4uRlHv3w61YbWGKChoQGuPNzrK2/YVoAr1jZhA5uay+inP3PF0Ym/aqS4IO6i/LRKIBTr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PVklpkRx; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0M006968;
	Mon, 29 Jan 2024 10:27:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=vihQFlaLo0Ij7ZEe+g2FSTJscOtY5rr5pKJ4XAH0JCQ=; b=
	PVklpkRxDTh3yGR7YMlXPOk4A8IFPVQq5VIOmM8WT9athbXVZxai1sleFKtpIk/0
	mZXgBI6OdaSDRP27LB7QwqPIOHQl4Sqmr1GtrsQEvRqePyPKt6p/vv53AZtd0w4L
	3dhJADG9h5V0K0ehKJ0swkuHkx8Cj1IES0tiSZxgpXo9RLltiGdR1w/opNmW5BB8
	H9zKKVz2h46XtblBhUj1DkPPX4gBYWLnyZUblGn474nTjUGgDs76SlpinbnUzzSz
	FPFq6Xy6xhYzhG4wYfnZlR9uIjWHS2CYUU9JYfp1W3EAtYUugeNTaT9LhWp/OZLJ
	cZsFcP8dxJH/Nr8k3t9gIg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:56 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:47 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:47 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E4894820270;
	Mon, 29 Jan 2024 16:27:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 16/18] ALSA: hda: cs35l56: Fix filename string field layout
Date: Mon, 29 Jan 2024 16:27:35 +0000
Message-ID: <20240129162737.497-17-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: XVN8exbvxqmaOu5Io8r8DbmpZkHf9mda
X-Proofpoint-GUID: XVN8exbvxqmaOu5Io8r8DbmpZkHf9mda
X-Proofpoint-Spam-Reason: safe

Change the filename field layout to:
  cs35l56-rev[-s]-dsp1-misc[-sub].[wmfw|bin]

This is to keep the same firmware file naming scheme as the
CS35L56 ASoC driver.

This is not a compatibility break because no firmware files have
been published.

The original field layout matched the ASoC driver, but the way the
ASoC driver used the wm_adsp driver config to form this filename
was bugged. Fixing the ASoC driver to use the correct wm_adsp config
strings means that the 's' flag (to indicate a secured part) has to
move to somewhere after the first '-'.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 7ba7234d8d9c..081479f65fe7 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -405,16 +405,19 @@ static int cs35l56_hda_request_firmware_file(struct cs35l56_hda *cs35l56,
 	int ret = 0;
 
 	if (system_name && amp_name)
-		*filename = kasprintf(GFP_KERNEL, "%scs35l56%s-%02x-dsp1-misc-%s-%s.%s", dir,
-				      cs35l56->base.secured ? "s" : "", cs35l56->base.rev,
+		*filename = kasprintf(GFP_KERNEL, "%scs35l56-%02x%s-dsp1-misc-%s-%s.%s", dir,
+				      cs35l56->base.rev,
+				      cs35l56->base.secured ? "-s" : "",
 				      system_name, amp_name, filetype);
 	else if (system_name)
-		*filename = kasprintf(GFP_KERNEL, "%scs35l56%s-%02x-dsp1-misc-%s.%s", dir,
-				      cs35l56->base.secured ? "s" : "", cs35l56->base.rev,
+		*filename = kasprintf(GFP_KERNEL, "%scs35l56-%02x%s-dsp1-misc-%s.%s", dir,
+				      cs35l56->base.rev,
+				      cs35l56->base.secured ? "-s" : "",
 				      system_name, filetype);
 	else
-		*filename = kasprintf(GFP_KERNEL, "%scs35l56%s-%02x-dsp1-misc.%s", dir,
-				      cs35l56->base.secured ? "s" : "", cs35l56->base.rev,
+		*filename = kasprintf(GFP_KERNEL, "%scs35l56-%02x%s-dsp1-misc.%s", dir,
+				      cs35l56->base.rev,
+				      cs35l56->base.secured ? "-s" : "",
 				      filetype);
 
 	if (!*filename)
-- 
2.39.2


