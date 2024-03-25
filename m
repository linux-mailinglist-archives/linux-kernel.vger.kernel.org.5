Return-Path: <linux-kernel+bounces-117284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677488A998
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43522E404D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF975A4D3;
	Mon, 25 Mar 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VxFmgjjn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5C3FB09;
	Mon, 25 Mar 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377902; cv=none; b=TmYLgXpulLIZyrg/iZFoknnmIJmp7qdHmkZTk1vmG8Pxea3ixPNyrk2ndP5FwZTQDHwXVuqdYpnDEZPrHRFkAnVZvGTbJp4CurRFg7S9j65tLIt+355+ZmlajCg0ttZD7zWa6i29uFUG0e4zzsgELhTnBhfdT4XqiFMGl8RGGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377902; c=relaxed/simple;
	bh=gBX8YfXgY1iMfwDEeoUVHzA6nko45l9jsRdBGQAMaQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwAbAV3MffYCBM0IE34hd64+fMJhnnXKWfOAyJrtI4OzvCSUNXdF6sGMqh9o/eYTkucKapNrYTP5pNEdfD8A1WNLu/LkGNY3oEk5QWubMNsoM/j+rBpPWrssYPv7CIoh2mjrdspYiyD1iW53Qb2AA3Y0bcnAqV6XVZ1fAiagocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VxFmgjjn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P4qktd007553;
	Mon, 25 Mar 2024 09:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=s
	M4jHgZg6/v208T765YpJQoPIlY6ESlG7oOC2AjF6z4=; b=VxFmgjjnmJ9L5nxd2
	it1jI8YbPahhGFRu4ozXJZgI4CRlBkS9s2Wzg+hLHyd8VOu6SVY+VKUNtIT9tzFh
	nqpvsb5pC7U0NfcQu3PLyIMKTqdnWNKw+iF/FXwiY1xTmNntfwEBMYSTZuTPALSa
	RzudieqW9kulq6qp43REUXZbaVLp1FcGQeMOFywQgWnypm5GQgonNQVdPWu27zdu
	wdG59L4sLvIvd6rIecltEhWFsergszbV24nTpd82JxJOYi7kodRcycwEZ4snz45r
	Exu9xAURY+XWVQcPXPoyYI7laj/AUJTIHfokdUhct72+fUrkLXnKhCuAxf2uuvXq
	N7JIA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfybhxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 09:44:53 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 14:44:51 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 14:44:51 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DACA6820244;
	Mon, 25 Mar 2024 14:44:50 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs-amp-lib: Check for no firmware controls when writing calibration
Date: Mon, 25 Mar 2024 14:44:50 +0000
Message-ID: <20240325144450.293630-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GgbbWgh-nZxqA48C84fnxwXmq9jvAe4f
X-Proofpoint-GUID: GgbbWgh-nZxqA48C84fnxwXmq9jvAe4f
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

When a wmfw file has not been loaded the firmware control descriptions
necessary to write a stored calibration are not present. In this case
print a more descriptive error message.

The message is logged at info level because it is not fatal, and does
not necessarily imply that anything is broken.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 01ef4db5407d..287ac01a3873 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -56,6 +56,11 @@ static int _cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 	dev_dbg(dsp->dev, "Calibration: Ambient=%#x, Status=%#x, CalR=%d\n",
 		data->calAmbient, data->calStatus, data->calR);
 
+	if (list_empty(&dsp->ctl_list)) {
+		dev_info(dsp->dev, "Calibration disabled due to missing firmware controls\n");
+		return -ENOENT;
+	}
+
 	ret = cs_amp_write_cal_coeff(dsp, controls, controls->ambient, data->calAmbient);
 	if (ret)
 		return ret;
-- 
2.39.2


