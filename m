Return-Path: <linux-kernel+bounces-93828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D51F873543
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592F5287556
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71647316F;
	Wed,  6 Mar 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="C9t6H1Fi"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053575FDDC;
	Wed,  6 Mar 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722948; cv=none; b=i+dmJoq40fEYAVY5iKg3vxjn9pMgfpJtkvLrMBwW9nJJHxLtWTq6hFtpz2oIoKj61opfFQT+6VFzM2UlCRDWV+31QrKkEJxHxqmHYs3hhnSqIcYlQLBtrAlhIEFcpCHR6iepaxY2b+Ym6tw6W+mWqOCBAYIUIc19+FPdd3NDYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722948; c=relaxed/simple;
	bh=ygeqKWDT5AUJTASqGDnzwYh7qL3fkE+eprFpeq8/5qE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LfkGlGSYz3vRnZZhveBbqE09uu/toyJa7b8csisLXLGzGn6Z2Kh8E5tkNeHEyImHP9hk3r/wJtIMGpZCDprTLCoZqLsZHxSuP+SFbIx1gWDFmSpobcJqVbmK7Jhwq4bDgQWkjD6Hl+w5Tgta9gc480PKZVQ/96/G9meNlL9aJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=C9t6H1Fi; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 78EF5100003;
	Wed,  6 Mar 2024 14:01:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1709722918; bh=GrRSzn9Rpz5WKnpCUHJQlFPcoyVDSZorDUnPZWrVOLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=C9t6H1FiPnk/xI3wNj1felIYHPoyg5MAhnESLm9uEPMj6EWA6homM1qDxruIkVjKe
	 aPAMwCB61MU++fPi/5/7XYFGsT+O1+Uusrih1Ofqh6mG/vttndwTyxn/wppgdLXIqH
	 bmNm1b16k5uHfsu4ulmu1RI/YlRdNLf2rSWFnzkGAHbehpQoeG57KTB2bmTKMm6Qil
	 cto0U56VhDkFG0qtDTaIe5+BIx+kFmQfSovlyPovn1xkAppbNeYtXkrAhydOEMAgxh
	 UPXAuLlzizRDN9OnVsb1gXjNPVYLK7VDM1QEvYmLSRXjXewnJaS0Se88/W7gwWg27u
	 XoHLmWjwtEXMQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:01:13 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Mar 2024
 14:00:48 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "David S. Miller"
	<davem@davemloft.net>, Steve Lin <steven.lin1@broadcom.com>, Rob Rice
	<rob.rice@broadcom.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] crypto: bcm/spu2
Date: Wed, 6 Mar 2024 14:00:22 +0300
Message-ID: <20240306110022.21574-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 183989 [Mar 06 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/06 10:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/06 07:15:00 #24010220
X-KSMG-AntiVirus-Status: Clean, skipped

In spu2_dump_omd() value of ptr is increased by ciph_key_len
instead of hash_iv_len which could lead to going beyond the
buffer boundaries.

Fix this bug by changing ciph_key_len to hash_iv_len.

Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
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


