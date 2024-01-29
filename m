Return-Path: <linux-kernel+bounces-43089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D0840B71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628961C2295B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7024158D7F;
	Mon, 29 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SylP/xHn"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E07157E71;
	Mon, 29 Jan 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545685; cv=none; b=PrJ4QyuZ2hjJpTZbyU0Vb3PwVlKse3P4m8+aM36DURD902nRflFuiwpNzhCsxZtcPX9q+dW1JHfK2tcCx3gjDI1lM/8NCPCZAeXi5Khz2Rhf0IvALom3URpSITmJER7ofB6V6VEJnMFSdbTKjPkaR+gjzs71RZNWfJ4fFnFY180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545685; c=relaxed/simple;
	bh=R1QHxOx4Sr0JtnBQnCXuCrel+1OfZI23IoUuIh6UYDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfpM5c6iWWz2yGjPoFWUq9MQ64NMDdwqJB34N03xDyfJ2Xsiw8dfUR9eO0V/9+jOU8ex7KUptSrjgzaKLkCgfK8cBK0IV/ErPEjhIzCoQaS4q7fVXNJytNsJ6jheqbcaMvR4xPJkjQc94yN2it/K0vUkXShUdANZCQuG/4cJOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SylP/xHn; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0K006968;
	Mon, 29 Jan 2024 10:27:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=bTDeZPKMjF1LZBgDZqWVGGUorkGwCKYk0L/1ww1B5x4=; b=
	SylP/xHnYdV3I9AghlABCYVmcIN5Mi2dzL5HGIY6qUAh5Ih4PWmCGsbGJ2MHMkVA
	zfTe96hSsjctZ9Mwitm3DwRSrjuDBxmfJluxvT8767VN3Cu9GT6iNGR64uYxddCq
	lWZnCumuC/Uz/CUhpOHGMx94Rxo56hPjxNKaMZSIbGO6Egc6rtsbU/jsVZ0uohhu
	zjHTdFe8Ajsto5btI2C5bXV/2LiG2QTRTcjlZPWqbMxjrkMofFvExaYwgU2JSpq8
	r7isA70bciKodcvnpmbzLbUdMRPbRe+AVd3Tuwkg2K7nXz15HL3TiUhoGAZUtDL4
	Urjo3u4Rm4ehcCXX4Z5k8A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:55 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:46 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:46 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 91CB082024B;
	Mon, 29 Jan 2024 16:27:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 15/18] ALSA: hda: cs35l56: Fix order of searching for firmware files
Date: Mon, 29 Jan 2024 16:27:34 +0000
Message-ID: <20240129162737.497-16-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: PmhZbXe5gxq0nalhv0POwxT439SOX2jp
X-Proofpoint-GUID: PmhZbXe5gxq0nalhv0POwxT439SOX2jp
X-Proofpoint-Spam-Reason: safe

Check for the cases of system-specific bin file without a
wmfw before falling back to looking for a generic wmfw.

All system-specific options should be tried before falling
back to loading a generic wmfw/bin. With the original code,
the presence of a fallback generic wmfw on the filesystem
would prevent using a system-specific tuning with a ROM
firmware.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index f22bcb104a4e..7ba7234d8d9c 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -483,6 +483,20 @@ static void cs35l56_hda_request_firmware_files(struct cs35l56_hda *cs35l56,
 								  NULL, "bin");
 			return;
 		}
+
+		/*
+		 * Check for system-specific bin files without wmfw before
+		 * falling back to generic firmware
+		 */
+		if (amp_name)
+			cs35l56_hda_request_firmware_file(cs35l56, coeff_firmware, coeff_filename,
+							  cirrus_dir, system_name, amp_name, "bin");
+		if (!*coeff_firmware)
+			cs35l56_hda_request_firmware_file(cs35l56, coeff_firmware, coeff_filename,
+							  cirrus_dir, system_name, NULL, "bin");
+
+		if (*coeff_firmware)
+			return;
 	}
 
 	ret = cs35l56_hda_request_firmware_file(cs35l56, wmfw_firmware, wmfw_filename,
@@ -493,16 +507,6 @@ static void cs35l56_hda_request_firmware_files(struct cs35l56_hda *cs35l56,
 		return;
 	}
 
-	/* When a firmware file is not found must still search for the coeff files */
-	if (system_name) {
-		if (amp_name)
-			cs35l56_hda_request_firmware_file(cs35l56, coeff_firmware, coeff_filename,
-							  cirrus_dir, system_name, amp_name, "bin");
-		if (!*coeff_firmware)
-			cs35l56_hda_request_firmware_file(cs35l56, coeff_firmware, coeff_filename,
-							  cirrus_dir, system_name, NULL, "bin");
-	}
-
 	if (!*coeff_firmware)
 		cs35l56_hda_request_firmware_file(cs35l56, coeff_firmware, coeff_filename,
 						  cirrus_dir, NULL, NULL, "bin");
-- 
2.39.2


