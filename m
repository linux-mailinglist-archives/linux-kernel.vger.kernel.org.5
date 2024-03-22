Return-Path: <linux-kernel+bounces-112026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BCF887450
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475101C21E73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D887FBB4;
	Fri, 22 Mar 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="YcJreD3M"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9C1E53A;
	Fri, 22 Mar 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141276; cv=none; b=n8RN25344mT8G761FO8bqh92VwKHE6WfqZ6k6pfO0SjNasxy+B+dkuJYIemfwrrOg+vbiPwouOYq9vnd2DwdsPxejP3I5OgAvM+KL78jUPjbnv6f/4b7nZwdqX5Yt/Yf8FuHVH8rYFLMb3B652MPlQka4/lknDUQJc2A8g/KDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141276; c=relaxed/simple;
	bh=qHZQxL/07nk39dovZ4jroYtYQAGKCNn3FZb5dLi7uuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bf0K8UvM6gJ9IQYHOxjvlP/mbUQ9Iu2bBVmQy0psxwY4+qCyl94VIUm2GYH0ghTqJFD4+9rIAi1y5oz2tyHjo2ww2sVTgt3nZnHNdfkaiV3AQvJyfJjhqieVKKQguoalNRg3FcPzSea/KUy/XO13sMC1kXuXm03Bv4TVJo7iwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=YcJreD3M; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id E2E7F100002;
	Sat, 23 Mar 2024 00:00:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711141252; bh=AHaDfWqKeTOZ0MS8fprzUVNZEFZ6lLX0Zn06/jjcUO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YcJreD3M2b03HXR8f2Z8GrN2oP2kikzXvI0qZ0/hl6wggjnME5zguGAmROJ3jqrvc
	 tgSCw1+6K4B/drfyHlkKKE8HQc2kDNShSsTo+26o50fUvo0S0bfLUxW1qUQDt3yAqO
	 Z9FX0XWPKbuMyEYo2G9JB9GDlBNYX8ofGuQP0EfncSEODxXc7dC0kpL8GbP8ByipPw
	 H45jEZyfyAqaS56042t7QjL2ogau2+kSNYDeWyReekqKE2sXsaGEsgegkg8lOZtI2Z
	 03rnvt0dOiGfcUq7Mr6b9I20eJedYvnko4V9vNbeqpkbHfjURG5YKALPqSIw7CsV4Q
	 Wrb/+V+w6ZtIg==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Sat, 23 Mar 2024 00:00:05 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 22 Mar
 2024 23:59:45 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "David S. Miller"
	<davem@davemloft.net>, Steve Lin <steven.lin1@broadcom.com>, Rob Rice
	<rob.rice@broadcom.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] crypto: bcm/spu2 - Add buffer size check
Date: Fri, 22 Mar 2024 23:59:15 +0300
Message-ID: <20240322205915.13305-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240306110022.21574-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184367 [Mar 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/22 20:48:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/22 14:30:00 #24353062
X-KSMG-AntiVirus-Status: Clean, skipped

In spu2_dump_omd() value of ptr is increased by ciph_key_len
instead of hash_iv_len which could lead to going beyond the
buffer boundaries.
Fix this bug by changing ciph_key_len to hash_iv_len.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Fix commit message according to the Linux kernel rules

 drivers/crypto/bcm/spu2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/bcm/spu2.c b/drivers/crypto/bcm/spu2.c
index 07989bb8c220..3fdc64b5a65e 100644
--- a/drivers/crypto/bcm/spu2.c
+++ b/drivers/crypto/bcm/spu2.c
@@ -495,7 +495,7 @@ static void spu2_dump_omd(u8 *omd, u16 hash_key_len, u16 ciph_key_len,
 	if (hash_iv_len) {
 		packet_log("  Hash IV Length %u bytes\n", hash_iv_len);
 		packet_dump("  hash IV: ", ptr, hash_iv_len);
-		ptr += ciph_key_len;
+		ptr += hash_iv_len;
 	}
 
 	if (ciph_iv_len) {
-- 
2.30.2


