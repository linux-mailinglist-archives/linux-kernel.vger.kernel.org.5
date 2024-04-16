Return-Path: <linux-kernel+bounces-146722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6098A69E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D911C2149D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BE129E76;
	Tue, 16 Apr 2024 11:45:56 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769E129A73;
	Tue, 16 Apr 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267956; cv=none; b=RY68/1bhZ4gv76DJubTP+33V/RzQPpCeAwOzRzNCMwl9OCz5bXVm5Fw4wRZaCXtghoyMSOD8991/1WxHw3fbtr4UKUcEbdclTZEoKpwzdL7ecL4JJMalTnuzcPyVHbscprJLnM6YXAHwy7hJJh183dBn76sGBJjpnQnemb/Xg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267956; c=relaxed/simple;
	bh=2EiEuGAYLJcLczJGOTsB1MV+9H93nFB6tDeDt5gKoFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lfiTO4lA+cqxKGzakB4NtpXLwU7gSPJ0UFqSRxfnf/Pfro3+e4LHiGSsfIiqcop6QV8Xh0hKcFJR9V4qH3oKnf/roF5BazgF9kIvSiAp4yJL0sDseiNfzThd1jHP4XyL+jdLNl4DyQhCQzKN85IL77wSBhZIG50/b//iXu6NS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msk1wst434n.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 14:45:37 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Michael Krufky <mkrufky@linuxtv.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>
CC: Roman Smirnov <r.smirnov@omp.ru>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 1/3] media: tuners: tda18271: fix error code handling in tda18271_attach()
Date: Tue, 16 Apr 2024 14:45:07 +0300
Message-ID: <20240416114509.198069-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/16/2024 11:28:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 184736 [Apr 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 17 0.3.17
 f2153f38d75b12894d9cf445f96cd15c9ef63a9d
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	msk1wst434n.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/16/2024 11:34:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/16/2024 8:38:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

tda18271_attach() uses the hybrid_tuner_request_state() macro.
It may return the error code -ENOMEM, but the function handle
the value 0 instead.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: b9302fa7ed97 ("media: tuners: fix error return code of hybrid_tuner_request_state()")
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 drivers/media/tuners/tda18271-fe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/tda18271-fe.c b/drivers/media/tuners/tda18271-fe.c
index a7e721baaa99..23432210f06a 100644
--- a/drivers/media/tuners/tda18271-fe.c
+++ b/drivers/media/tuners/tda18271-fe.c
@@ -1255,7 +1255,7 @@ struct dvb_frontend *tda18271_attach(struct dvb_frontend *fe, u8 addr,
 					      hybrid_tuner_instance_list,
 					      i2c, addr, "tda18271");
 	switch (instance) {
-	case 0:
+	case -ENOMEM:
 		goto fail;
 	case 1:
 		/* new tuner instance */
-- 
2.34.1


