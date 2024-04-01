Return-Path: <linux-kernel+bounces-126642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CB893AD3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6051F21FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF3383BD;
	Mon,  1 Apr 2024 12:17:04 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B11374CF;
	Mon,  1 Apr 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973820; cv=none; b=lGa265E4sH3LYL8H1D4MoJsszAPFmXL87SuVbY11TS8ELK7r+uchGB3msFdOoNWQzca++1/oUT4+3BvR28zT1Ig4RFa4Kla3gg+ln6EG4hUWimO1kXU+cZxkdU8nPvw8SMVdj/3JoRL2GYNyUpSDfSDquvZl65XE/PLkkaYylyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973820; c=relaxed/simple;
	bh=SqzT1Q13/cs3mhKcKxl3aaKQyX7VYa865bsan6scvqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRU3E2uPRtHTzSDtiQSHIdQOahM2DHwZc9F/HhWwUqUaTjMvw+uJ3dBYpb7h1fkFs7Ty9gUjT4/WPLQVf8RT7MNfWE8eNcmKsFaTorYkqvam4DuL2MFM7a2cPT5L18hoikeYm+dCBtIH7oVK/wIfumwIGI8banwGI7LU/BqChSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msk1wst434n.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 1 Apr
 2024 15:16:36 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>
CC: Roman Smirnov <r.smirnov@omp.ru>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] crypto: ecc: remove checks in crypto_ecdh_shared_secret() and ecc_make_pub_key()
Date: Mon, 1 Apr 2024 15:16:23 +0300
Message-ID: <20240401121623.110263-1-r.smirnov@omp.ru>
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

With the current state of the code, ecc_get_curve() cannot return
NULL in crypto_ecdh_shared_secret() and ecc_make_pub_key(). This is
conditioned by the fact that they are only called from ecdh_compute_value(),
which implements the kpp_alg::{generate_public_key,compute_shared_secret}()
methods. Also ecdh implements the kpp_alg::init() method, which is called
before the other methods and sets ecdh_ctx::curve_id to a valid value.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 crypto/ecc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af99..5028f7b9d7c7 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1515,7 +1515,7 @@ int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
 	u64 priv[ECC_MAX_DIGITS];
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
-	if (!private_key || !curve || ndigits > ARRAY_SIZE(priv)) {
+	if (!private_key || ndigits > ARRAY_SIZE(priv)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1617,7 +1617,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	unsigned int nbytes;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
-	if (!private_key || !public_key || !curve ||
+	if (!private_key || !public_key ||
 	    ndigits > ARRAY_SIZE(priv) || ndigits > ARRAY_SIZE(rand_z)) {
 		ret = -EINVAL;
 		goto out;
-- 
2.34.1


