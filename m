Return-Path: <linux-kernel+bounces-92847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5538726D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BC71C208A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF11A5BA;
	Tue,  5 Mar 2024 18:44:07 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330A1C01
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664246; cv=none; b=MBGjpCTUH3lSeMOgSH9F31UFYIROGUeDYzZ0bVxdF9zifTW1GqL0jbfJ0jK9HNM5CjmAXYtn9faTxIjbKf6d1VxMIgjd71RTfNeNInw1/mIDzmaYXFlykt2ZbTmtKkoAi5/G+B/jpgLRlo+7S2HzQSQhI6LdJXE8zSh1rSuv+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664246; c=relaxed/simple;
	bh=YSepaJODTP6f0jj2gdYgSOGN1WTX0Y0medx8vbhJYBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q64eb/Ls8mtRr0Sb2y8l8RvcV+JfrbyLizxk7AyM8f8PnPU24CfJUgHcVdyaUwWlf1LGfkKkEnWM2R20plzniYYrg6uvzeUW2adHLOmgdynqP3LIRcf3HDKiRHYCNkxGAk9cif1iKjyK4iwv6hpuq5NOaT8KmxaBDl4jPgnronE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (171.25.167.209) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 21:43:51 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Karina Yankevich <k.yankevich@omp.ru>, "David S. Miller"
	<davem@davemloft.net>, <s.shtylyov@omp.ru>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] crypto: drbg - make drbg_kcapi_{ctr_bcc,kcapi_sym}() return void
Date: Tue, 5 Mar 2024 21:43:16 +0300
Message-ID: <20240305184322.337015-1-k.yankevich@omp.ru>
X-Mailer: git-send-email 2.44.0
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/05/2024 18:25:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183976 [Mar 05 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: k.yankevich@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 8 0.3.8 4a99897b35b48c45ee5c877607d26a2d9f419920
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 171.25.167.209 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 171.25.167.209
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/05/2024 18:31:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/5/2024 3:17:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

drgb_kcapi_sym() always returns 0, so make it return void instead.
Consequently, make drbg_ctr_bcc() return void too.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
---
 crypto/drbg.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 3addce90930c..2402ca788899 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -295,8 +295,8 @@ MODULE_ALIAS_CRYPTO("drbg_nopr_ctr_aes128");
 
 static void drbg_kcapi_symsetkey(struct drbg_state *drbg,
 				 const unsigned char *key);
-static int drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
-			  const struct drbg_string *in);
+static void drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
+			   const struct drbg_string *in);
 static int drbg_init_sym_kernel(struct drbg_state *drbg);
 static int drbg_fini_sym_kernel(struct drbg_state *drbg);
 static int drbg_kcapi_sym_ctr(struct drbg_state *drbg,
@@ -305,11 +305,10 @@ static int drbg_kcapi_sym_ctr(struct drbg_state *drbg,
 #define DRBG_OUTSCRATCHLEN 256
 
 /* BCC function for CTR DRBG as defined in 10.4.3 */
-static int drbg_ctr_bcc(struct drbg_state *drbg,
-			unsigned char *out, const unsigned char *key,
-			struct list_head *in)
+static void drbg_ctr_bcc(struct drbg_state *drbg,
+			 unsigned char *out, const unsigned char *key,
+			 struct list_head *in)
 {
-	int ret = 0;
 	struct drbg_string *curr = NULL;
 	struct drbg_string data;
 	short cnt = 0;
@@ -326,9 +325,7 @@ static int drbg_ctr_bcc(struct drbg_state *drbg,
 			/* 10.4.3 step 4.2 */
 			if (drbg_blocklen(drbg) == cnt) {
 				cnt = 0;
-				ret = drbg_kcapi_sym(drbg, out, &data);
-				if (ret)
-					return ret;
+				drbg_kcapi_sym(drbg, out, &data);
 			}
 			out[cnt] ^= *pos;
 			pos++;
@@ -338,9 +335,7 @@ static int drbg_ctr_bcc(struct drbg_state *drbg,
 	}
 	/* 10.4.3 step 4.2 for last block */
 	if (cnt)
-		ret = drbg_kcapi_sym(drbg, out, &data);
-
-	return ret;
+		drbg_kcapi_sym(drbg, out, &data);
 }
 
 /*
@@ -387,7 +382,6 @@ static int drbg_ctr_df(struct drbg_state *drbg,
 		       unsigned char *df_data, size_t bytes_to_return,
 		       struct list_head *seedlist)
 {
-	int ret = -EFAULT;
 	unsigned char L_N[8];
 	/* S3 is input */
 	struct drbg_string S1, S2, S4, cipherin;
@@ -458,9 +452,7 @@ static int drbg_ctr_df(struct drbg_state *drbg,
 		 */
 		drbg_cpu_to_be32(i, iv);
 		/* 10.4.2 step 9.2 -- BCC and concatenation with temp */
-		ret = drbg_ctr_bcc(drbg, temp + templen, K, &bcc_list);
-		if (ret)
-			goto out;
+		drbg_ctr_bcc(drbg, temp + templen, K, &bcc_list);
 		/* 10.4.2 step 9.3 */
 		i++;
 		templen += drbg_blocklen(drbg);
@@ -481,9 +473,7 @@ static int drbg_ctr_df(struct drbg_state *drbg,
 		 * implicit as the key is only drbg_blocklen in size based on
 		 * the implementation of the cipher function callback
 		 */
-		ret = drbg_kcapi_sym(drbg, X, &cipherin);
-		if (ret)
-			goto out;
+		drbg_kcapi_sym(drbg, X, &cipherin);
 		blocklen = (drbg_blocklen(drbg) <
 				(bytes_to_return - generated_len)) ?
 			    drbg_blocklen(drbg) :
@@ -493,13 +483,10 @@ static int drbg_ctr_df(struct drbg_state *drbg,
 		generated_len += blocklen;
 	}
 
-	ret = 0;
-
-out:
 	memset(iv, 0, drbg_blocklen(drbg));
 	memset(temp, 0, drbg_statelen(drbg) + drbg_blocklen(drbg));
 	memset(pad, 0, drbg_blocklen(drbg));
-	return ret;
+	return 0;
 }
 
 /*
@@ -1807,15 +1794,14 @@ static void drbg_kcapi_symsetkey(struct drbg_state *drbg,
 	crypto_cipher_setkey(tfm, key, (drbg_keylen(drbg)));
 }
 
-static int drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
-			  const struct drbg_string *in)
+static void drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
+			   const struct drbg_string *in)
 {
 	struct crypto_cipher *tfm = drbg->priv_data;
 
 	/* there is only component in *in */
 	BUG_ON(in->len < drbg_blocklen(drbg));
 	crypto_cipher_encrypt_one(tfm, outval, in->buf);
-	return 0;
 }
 
 static int drbg_kcapi_sym_ctr(struct drbg_state *drbg,
-- 
2.44.0


