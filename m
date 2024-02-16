Return-Path: <linux-kernel+bounces-68933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C044C858211
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54500284C74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019AD12F5AF;
	Fri, 16 Feb 2024 16:01:39 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFC28E23;
	Fri, 16 Feb 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099298; cv=none; b=oabcs3+7j2YpijA7+xku2B2VxsSRT/t6Iu4GXWcWLcyv2yRsSqotD9XCZKOg0JRwwwHYMmmdsuu8v5GJkvkmhoOnqi8LIXDnSJJOrfod5Eq/LOhgNdH8aYG9zZSqrNm7uyMrACJeuLaqzJ9ctO+0MT1WIvRf0kfK083o/NRuBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099298; c=relaxed/simple;
	bh=DV0cf4a5CP+++OA4yCCHPN8FrX65afzSkNcxaEoEVQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/8hKYUm47mXaMrkakQFkkR74rXxVBNQJuOFv1/2QuVA0jSKo9RkKUQQaUqOCxLsGt0Z6uuKeo7GTshdBohwU5FJdgLav6dObCHmNrk9EhCKiZvl2nDWix+mHa6qRzmPCobKEFT9HE6JlYI6LV6QUZd9KBkkHMj9o1axyFZQ0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst022.omp.ru (109.73.39.18) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 16 Feb
 2024 19:01:24 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Michael Krufky <mkrufky@linuxtv.org>
CC: Karina Yankevich <k.yankevich@omp.ru>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] [media] tda18271: add missing result checking of tda18271_lookup_map()
Date: Fri, 16 Feb 2024 19:01:10 +0300
Message-ID: <20240216160110.2735117-1-k.yankevich@omp.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/16/2024 15:45:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183509 [Feb 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: k.yankevich@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;109.73.39.18:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;spb1wst022.omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 109.73.39.18
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/16/2024 15:51:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/16/2024 3:14:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

tda18271_lookup_map() may return negative error code, but
tda18271c2_rf_tracking_filters_correction() doesn't check it
as the other callers.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
---
 drivers/media/tuners/tda18271-fe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/tuners/tda18271-fe.c b/drivers/media/tuners/tda18271-fe.c
index f0371d004b36..ff5b22134414 100644
--- a/drivers/media/tuners/tda18271-fe.c
+++ b/drivers/media/tuners/tda18271-fe.c
@@ -279,7 +279,9 @@ static int tda18271c2_rf_tracking_filters_correction(struct dvb_frontend *fe,
 	if (approx > 255)
 		approx = 255;
 
-	tda18271_lookup_map(fe, RF_CAL_DC_OVER_DT, &freq, &dc_over_dt);
+	ret = tda18271_lookup_map(fe, RF_CAL_DC_OVER_DT, &freq, &dc_over_dt);
+	if (tda_fail(ret))
+		goto fail;
 
 	/* calculate temperature compensation */
 	rfcal_comp = dc_over_dt * (s32)(tm_current - priv->tm_rfcal) / 1000;
-- 
2.25.1


