Return-Path: <linux-kernel+bounces-37254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2283AD56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1924828294F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59427C09F;
	Wed, 24 Jan 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="m3cpJ6vr"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD27A707;
	Wed, 24 Jan 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110228; cv=none; b=X7qe0K3Ndjt09ljaNlki6+QWrYbk8BSKltBixlRrBaLvJfvLZeaTWQ28pfhBz+xVjQCZsYcrNWPNLylVnZbYuJxQJ6pmwHGJ2vhaM8Y4NwtWyOrbrkL//OzASy3/9FUJBt+EycMWRvG4/nOsHFuQgU//uFNG4Ox2eK5PAJqcH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110228; c=relaxed/simple;
	bh=dwNSFLpQJ15WSNLHQJc0HWdI5vgJK4PLbibeEt3onbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9yqIV4h6u4ESD1wXfBMaPlb6umB5pyVHbkIEG+3RaN+sQI5icuQmsWg3V3YVitzRnZvSYgxCfr/kP1U2tAIIc9UHMnV77V+xASAVs0QOlZreJfqOxYsvhpajXgb5jVYc4GU46GnTPRflzWejqNdDqrT4oYCuwi8TLQofXTx4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=m3cpJ6vr; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8MvMn030107;
	Wed, 24 Jan 2024 09:30:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=3wVnz+qTDhd7ewymUmUS+IuKvNXLSEtQi0GPLXhpiT0=; b=
	m3cpJ6vr/YsEf11Pw5ubyLoyQUN5DQGyV0NH7Y41V7Z+oRk9aHEoKwSwzexEUK+T
	EpjpRsej/rMkxErRj58nk8ZN5ZrtmA2W6x+fL87NIAwmC7iaasUxbks6xhkxHFfm
	G/m2gSluhoAvxmwQUyg4r6M3F4jVt/HBAjETHak8vCn5n0jVVVdtBO5ofltWUoCV
	4Pi3EDoA5xIUQOgPAgmBZ9NonPEJ/mDsvQx6ZK4ET/nknOQEGMM5wPA2YuhPoeN5
	o2fQAudasr+J+A6vFf0AbT73RC+O+95f//oy6Wx8mibsVwT/SU0ELKKaNcKMf//b
	dqt51C/Rc6q4cqV+G0OG1w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryqc-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:30:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:30:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:30:16 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CAFCB82024B;
	Wed, 24 Jan 2024 15:30:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable
Date: Wed, 24 Jan 2024 15:30:16 +0000
Message-ID: <20240124153016.1541616-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: c8Z7e5c67-GQC_sft4G-zoF0go-TruDf
X-Proofpoint-ORIG-GUID: c8Z7e5c67-GQC_sft4G-zoF0go-TruDf
X-Proofpoint-Spam-Reason: safe

As it devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

 drivers/mfd/cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index aea0f8f485785..56bd9dbbe10b0 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1065,7 +1065,9 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 	 * the boot work runs.
 	 */
 	pm_runtime_get_noresume(cs42l43->dev);
-	devm_pm_runtime_enable(cs42l43->dev);
+	ret = devm_pm_runtime_enable(cs42l43->dev);
+	if (ret)
+		return ret;
 
 	queue_work(system_long_wq, &cs42l43->boot_work);
 
-- 
2.30.2


