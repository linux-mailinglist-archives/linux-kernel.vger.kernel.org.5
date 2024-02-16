Return-Path: <linux-kernel+bounces-68705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADD857EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE69B25C15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268612CDAB;
	Fri, 16 Feb 2024 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="F4OzVQbF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253E175A6;
	Fri, 16 Feb 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092358; cv=none; b=bb7hVTLiuIM+qUNlsjsr+n4XnwtnAPCLKwdAKaIapVXeUtBRDLVm8mbbV5hbgv4ZuB4HgFLxH8RY7zi7KuPqUj2Q85TdybHtcCtj0QcF0qmJxoVeHvlL0RI3k+QRtk/QvWf+OUHnuIOGPQGuXTld9e0JWKMbSzPJSjw/X91ibZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092358; c=relaxed/simple;
	bh=E6q5xrMcVV+0iqJ33ckm74DzEhM3R6Lm5oDsVEfUaZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4Ay+3rAE7thwbxBtU7zQ1HZKE3KKuLIbDPMgJDphxXLKEWdIDEZ7b7YVGf+FM5qO16djpZ+HTQJj8YWlYTdFCRYdFY8Qi8/YZA+Y7x2eHbNv1j9q76sXsYmdoxZUuyNKibqmNvHh30gpNOTfbeLlWWL/yqE/YdQwG4Zjqpn+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=F4OzVQbF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G5u5hg027308;
	Fri, 16 Feb 2024 08:05:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=D
	w280V9Ji8JnDWHiX49rYuBF9Ede07pNOdQW29T5Qag=; b=F4OzVQbFi4ewdFUlT
	uU1W+e+bVKsiFUa31R6u5z4IXVO27zdEmSOltdY5Iw+YBDHCYfKgI+BNTVv2m0sQ
	+BPskYVslty0imzHDz/rFu9mxnUjPiGcohi/EOzqpU6W/6N+6ytpwttGbUVh+TOE
	w5NB1ogPposbebzRFBJ67zw/kbA6gFnqe5ZjAUAlrKeSgF5NmltUlzWa+Ka8g3vb
	HQYQXno0cP2/mOeIhQl1Wy7kZhmL0ewC7ZiFnQVVAgrt5wakA61yHCOaq1F0La0Y
	A/Pw89vj0ZboxE9wI/TR9/GtCkXucbD7Ctp8zxw4RJ+1VMcR/djaVzqCbdekpcLC
	ojMag==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w67e2738b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 08:05:37 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 14:05:35 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 14:05:35 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5FA17820242;
	Fri, 16 Feb 2024 14:05:35 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET
Date: Fri, 16 Feb 2024 14:05:35 +0000
Message-ID: <20240216140535.1434933-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _z1cWPfNfG1gpNOCgIy6EkY_CyfG-Cwr
X-Proofpoint-GUID: _z1cWPfNfG1gpNOCgIy6EkY_CyfG-Cwr
X-Proofpoint-Spam-Reason: safe

The driver must write 0 to HALO_STATE before sending the SYSTEM_RESET
command to the firmware.

HALO_STATE is in DSP memory, which is preserved across a soft reset.
The SYSTEM_RESET command does not change the value of HALO_STATE.
There is period of time while the CS35L56 is resetting, before the
firmware has started to boot, where a read of HALO_STATE will return
the value it had before the SYSTEM_RESET. If the driver does not
clear HALO_STATE, this would return BOOT_DONE status even though the
firmware has not booted.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
---
 sound/soc/codecs/cs35l56-shared.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 995d979b6d87..cb4e83126b08 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -335,6 +335,7 @@ void cs35l56_wait_min_reset_pulse(void)
 EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, SND_SOC_CS35L56_SHARED);
 
 static const struct reg_sequence cs35l56_system_reset_seq[] = {
+	REG_SEQ0(CS35L56_DSP1_HALO_STATE, 0),
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
-- 
2.30.2


