Return-Path: <linux-kernel+bounces-153190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D94208ACAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59553B21C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E8145FE8;
	Mon, 22 Apr 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VSUE9Bti"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AE14EC5B;
	Mon, 22 Apr 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781954; cv=none; b=ai7NlPIttUyVvseFsyXCIS/Yp+KlS36pCMOUT1GS7WDpLgSn2L4hYFrkswHZBG1MhjwIy78FoK6ETMAhYDPcipykaSWJv69RXFSSZlyjk/SPXq37+LmwiYF7vqvLTybvhiNRQFqQtnGGEHU975r0QZkzoe/i25zxqRhD+mb4oCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781954; c=relaxed/simple;
	bh=vG/0fLXhL9US68X2wfcTn3OalcGWddrMe6MQ6+UgZ6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEhPa7HHSc2G4rR6tHVbiSbGkUW4qrMGsqB/Xhk5BibF5wUTSRwr7JwzXyTyKKTZ6DoBiwIqONuTTzRTPl0NGHRegrv5XJLhlgggzNj3cbaaFHtLzHDPW6gV4ess5ls4bMTbOtLi1GFXuOmc84dATDc8WhMIDNtR0OZhVz6t/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VSUE9Bti; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M6stke006883;
	Mon, 22 Apr 2024 05:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=S
	vws7KLOMCFKfcP6/baNnM0W4JCe1O1rsfsw8WhjRWE=; b=VSUE9Btit+dd8qRLw
	jyI5BPmSDVPV66kk6HYmj6DzA3t7O0grHI5gC3XDMEtvEXDC0uWwxf+z7iEh0ws+
	1eXCHnvNhnmRx9xnscdgT9iIA9kGvburg5aSKZJTny+5vWxJP4xV+r1LmZ5oAIGu
	sKfh6y2cfGS57fqoKQz61F3vXChOwk2FNUaX2ja8VH0uRFxbdusHuTweicf31FGL
	ufRVWKYsfgwc87RcLOjuVlS9PmBntgzNJJ+Tur+YCFDkzTD3AxfiYM4gUe+ZIiZi
	2a1rr5w2Q3qn6RD+QYE1XZ8iGdSgNrCnl+NgLPLreXmTuDthcQ9Lj04Y7sx8mES1
	sqVhg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xmqmh0wgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:32:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 11:32:11 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 22 Apr 2024 11:32:11 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 78D91820242;
	Mon, 22 Apr 2024 10:32:11 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Avoid static analysis warning of uninitialised variable
Date: Mon, 22 Apr 2024 11:32:11 +0100
Message-ID: <20240422103211.236063-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t9vjsIWd4Aavgih1LBWDMcsrcStnFBr0
X-Proofpoint-GUID: t9vjsIWd4Aavgih1LBWDMcsrcStnFBr0
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Static checkers complain that the silicon_uid variable passed by
pointer to cs35l56_read_silicon_uid() could later be used
uninitialised when calling cs_amp_get_efi_calibration_data().

cs35l56_read_silicon_uid() must have succeeded to call
cs_amp_get_efi_calibration_data() and that would have populated the
variable.

However, initialise the value so we are not haunted by it forevermore.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Fixes: e1830f66f6c6 ("ASoC: cs35l56: Add helper functions for amp calibration")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 3aa39f5923eb..8af89a263594 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -707,7 +707,7 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_calibration_controls, SND_SOC_CS35L56_SHARED);
 
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 {
-	u64 silicon_uid;
+	u64 silicon_uid = 0;
 	int ret;
 
 	/* Driver can't apply calibration to a secured part, so skip */
-- 
2.39.2


