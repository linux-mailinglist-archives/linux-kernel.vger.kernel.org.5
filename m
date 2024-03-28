Return-Path: <linux-kernel+bounces-93428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28F872F99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC001C20C87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC05C8F3;
	Wed,  6 Mar 2024 07:29:44 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C4F4E2;
	Wed,  6 Mar 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710183; cv=none; b=e7jVEDFBxl7DXXaBPQLSNQ1RenidU9aN1J3oQscOuVKMraBIhNdsYAIdjiwdxuX8Yn/n6djztBhJq9W9PjDCiYwk9twTOAqCueGyxGDGlYv0q+X+uVy+y+4uBnza8uv6d8MgQyNhPttewwOX6dP3yCSaXQyYYSTjJJ628eUsul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710183; c=relaxed/simple;
	bh=5vkLVH4W2suH2i15pu3k1KbCeweYu1gW0CcodmLh1Gw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi59wSMeiBQ1I4HLv2HoLPE2oiDZ0pfp8JubYDVRGRboAna0FXtv/dxJKSZUK1i0RAGCdPJkCdpZ20cNnW9AM+IzDshLRX472C4Xx9pyPQIYHhY8EIdNTVtsfQQosygpmbnYmwLeUN75/fGpuHykEQUVF9Z/ELG5NlBcOLy+Ykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 10:29:28 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] crypto: algboss: remove NULL check in cryptomgr_schedule_probe()
Date: Wed, 6 Mar 2024 10:29:08 +0300
Message-ID: <20240306072908.5234-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/06/2024 07:05:24
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183983 [Mar 06 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 8 0.3.8 4a99897b35b48c45ee5c877607d26a2d9f419920
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 78.37.41.175 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;78.37.41.175:7.4.1,7.7.3;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 78.37.41.175
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/06/2024 07:11:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/6/2024 3:22:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The variable i will never be zero, so the check can be removed.

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


