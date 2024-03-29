Return-Path: <linux-kernel+bounces-125095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F6891FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45DE28AEC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CF14A089;
	Fri, 29 Mar 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AlQT6bTQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F8524D4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723610; cv=none; b=jtJjBsdKIBU9mCasK9I4iDZuluu+I7qJqrt85TQ2101h8ZVY5getmLBQFRHW0yrkTMeYjTP5b9tYzPKyy+8VjqaRb0TLBds9LV/jBECwOe19T2eF4/p+v/A1jEzeJXuiRTTBCVnQwm0vaYMNc0SaokDL1XpGUhJEXnb+qvtUx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723610; c=relaxed/simple;
	bh=Ebu7Nja/CsvCaH8Zg6K3AEgu5UPCsgR4+PVY8UjRTp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PPyGAynnefT2U7pNNpiraNtAWY1dBM78X+3RK3qAnBqmJeUpSmuacvjM9AEN5pYSRvvA33AyuRk8Mmu5pMj9S23RK2SxaW5zigYOe/EfJ5e3ixWau6nATV/kAZcYDGoQR/TPjWbch00oEd+x4v8+nXnVjMMvgTweoNnfyCA0Es4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AlQT6bTQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T6rtYf020844;
	Fri, 29 Mar 2024 09:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=u
	41Ueo2hntlhbckZBV2j/z9KwKYVCVg4hCzURDD7muI=; b=AlQT6bTQVR9or4vZO
	l3Jj4xm+xbnO5kHYH00OfZzVJsmKgS4Dr4YgxObzsZ9celLeyq/sKbVdfAlmeHlv
	Kt+Ljz68MFVbXZS3vJKDubAdWhy8tEepngpBEnQd1L7u+nX+VdUHk3mW2mJOVjry
	UuBclKeG2RFZsQzflXpBFSlYh4e0rpx673awzIqE1OycqAuxZQ4hVSBKE/H0huwa
	6QJbSSQZwteHYMnhzfbNqgFnekq7L9FYAC3y4NeyFqzwjKyphukc2I+w31wryjiv
	NynpUMjQ34FkvJXiOpBCCrEY2WRN8x2k6AV/SmID98bziBlSIHttRNsxIusdDIIH
	mWGOg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x4k7k4e3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 09:46:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 14:46:31 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Fri, 29 Mar 2024 14:46:31 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E825C820244;
	Fri, 29 Mar 2024 14:46:30 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] regmap: maple: Fix uninitialized symbol 'ret' warnings
Date: Fri, 29 Mar 2024 14:46:30 +0000
Message-ID: <20240329144630.1965159-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0wnGGyLUPBYIrxH1jyWyIxvhr5mciDWs
X-Proofpoint-ORIG-GUID: 0wnGGyLUPBYIrxH1jyWyIxvhr5mciDWs
X-Proofpoint-Spam-Reason: safe

Fix warnings reported by smatch by initializing local 'ret' variable
to 0.

drivers/base/regmap/regcache-maple.c:186 regcache_maple_drop()
error: uninitialized symbol 'ret'.
drivers/base/regmap/regcache-maple.c:290 regcache_maple_sync()
error: uninitialized symbol 'ret'.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
---
Hope to send a KUnit test update for this and my cache-corruption fix
sometime next week.
---
 drivers/base/regmap/regcache-maple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 0243fa485af5..e42433404854 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -112,7 +112,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	unsigned long *entry, *lower, *upper;
 	unsigned long lower_index, lower_last;
 	unsigned long upper_index, upper_last;
-	int ret;
+	int ret = 0;
 
 	lower = NULL;
 	upper = NULL;
@@ -244,7 +244,7 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	unsigned long lmin = min;
 	unsigned long lmax = max;
 	unsigned int r, v, sync_start;
-	int ret;
+	int ret = 0;
 	bool sync_needed = false;
 
 	map->cache_bypass = true;
-- 
2.39.2


