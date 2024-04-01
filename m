Return-Path: <linux-kernel+bounces-126649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE0893AED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE4F281A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791043839A;
	Mon,  1 Apr 2024 12:24:48 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9B28DC0;
	Mon,  1 Apr 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974288; cv=none; b=epKoaITwzc5QhdJlU7RzenYmsjiPzDIUcxcwQFgt2gs8U6vH9lhvWYIquyuij1P9H1qbCXNhVXLLYl0PVsDRgZr3QmhNE5EU2Bx974f6rm+w4JmFLMdSsa7LLdReNY/lXdxlqjz6J0nNDOa2wmOkRVIIfdXFgoYC2gaFmorXJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974288; c=relaxed/simple;
	bh=S17umzcSkzJVxMkeDGKprCS0QF3nLYcojO97hIZGnQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uONZXgq5dUymxqCl93YesnRGXmxUXSGMQYjBdjztovezYm3ZmUYnQAs00uwqT43ainkmDRccK/zkkdybwU3SpwUGb6ahHyJ4t4UnWaHzcJX4+9dGiUnEvPV2V+imoElKrUGyYbZn1pTX6Q4pbJ34Bo8GNnjHDHV5Dwwt70dJY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msk1wst434n.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 1 Apr
 2024 15:24:33 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>
CC: Roman Smirnov <r.smirnov@omp.ru>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] crypto: algboss: remove NULL check in cryptomgr_schedule_probe()
Date: Mon, 1 Apr 2024 15:22:58 +0300
Message-ID: <20240401122258.111414-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/01/2024 12:04:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 184505 [Apr 01 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;msk1wst434n.omp.ru:7.1.1;81.22.207.138:7.1.2
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
X-KSE-Antiphishing-Bases: 04/01/2024 12:07:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/1/2024 9:49:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The for loop will be executed at least once, so i > 0. If the loop
is interrupted before i is incremented (e.g., when checking len for NULL),
i will not be checked.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 crypto/algboss.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/crypto/algboss.c b/crypto/algboss.c
index 0de1e6697949..1aa5f306998a 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -138,9 +138,6 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
 			goto err_free_param;
 	}
 
-	if (!i)
-		goto err_free_param;
-
 	param->tb[i + 1] = NULL;
 
 	param->type.attr.rta_len = sizeof(param->type);
-- 
2.34.1


