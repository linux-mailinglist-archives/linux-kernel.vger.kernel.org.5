Return-Path: <linux-kernel+bounces-43091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0431840B76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB94E28F607
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2C159591;
	Mon, 29 Jan 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IoVGstZ9"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA31586CD;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545686; cv=none; b=tBQJ/gYRy5mqtKItrOtPsEFl6NS/nqE2qS1a2B2PPRYXTUdRRPHRWKQgz+1KFdBs5XJXXwLtY+F7qcpPIFTkx+Fg7GoW3yTe4ZVYFN+pq/Uq1AasuZiPSR+k7oCJ326yQVaLY8vEfId8s3FlzdLGQTnUE3IFk3mTq44LbfRZ/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545686; c=relaxed/simple;
	bh=iSzhA3JrzRMsulGlvr7cg4RdMLMlNOjtRT6xe6yJDns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Agps8RH776xQOpCA0Y8m0fuA++TEFsugdt+6wDPovouO62yfzkuiiAHG7J1GjSO/ncFLnu9g+Likc3S6d7n1X8GEAO3Vx5x9R972XHVIAW9kVnxXjEXfO1DkVRfLuqNrnXXCPqmbdwGjaiZZ9yhffLypj7u+5PAMkEKhYue/72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IoVGstZ9; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0I006968;
	Mon, 29 Jan 2024 10:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=JOCmxyosFFenj0dlq8WFGlARIYiWw78ly3nw8gUSm9c=; b=
	IoVGstZ9cg2+mJKWoUM/BUXndzMAilt7Ai0fnHEZsfOKXBcUV+ZFjfJiVIndF2OK
	X67Kb2H4CP2YAMiC3GX+U5UXZawTUNQDC/B5HVgnBPr3tdJX3NRW6OAUFBemslEu
	9JPJJbPc9SfVODOxUmyaRvNSFk3CEZf73z0rrlKpTXGeCy/zPbs12mSqCKwZMl2m
	Y5BH5qWZv4DBw+ajZWrVPxA/c+XDJEdSiE5wehsMZYfiR7XIWKbuNTCBBQTVPkfd
	/U0m4d5cxivuAnuDW7Khqu4QYZwgNd+bRm+626LG+cq7Mlnyaf6s5EchgTuWEbOP
	M98BSbnr7DUkbpSURKdigQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:55 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:46 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:46 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 432DE82024A;
	Mon, 29 Jan 2024 16:27:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 14/18] ASoC: cs35l56: Allow more time for firmware to boot
Date: Mon, 29 Jan 2024 16:27:33 +0000
Message-ID: <20240129162737.497-15-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: iGGh7-3BJYiH3wWj9EE_jgdJchl-ROK_
X-Proofpoint-GUID: iGGh7-3BJYiH3wWj9EE_jgdJchl-ROK_
X-Proofpoint-Spam-Reason: safe

The original 50ms timeout for firmware boot is not long enough for
worst-case time to reboot after a firmware download. Increase the
timeout to 250ms.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 include/sound/cs35l56.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 23da6298ab37..b24716ab2750 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -242,7 +242,7 @@
 
 #define CS35L56_CONTROL_PORT_READY_US			2200
 #define CS35L56_HALO_STATE_POLL_US			1000
-#define CS35L56_HALO_STATE_TIMEOUT_US			50000
+#define CS35L56_HALO_STATE_TIMEOUT_US			250000
 #define CS35L56_RESET_PULSE_MIN_US			1100
 #define CS35L56_WAKE_HOLD_TIME_US			1000
 
-- 
2.39.2


