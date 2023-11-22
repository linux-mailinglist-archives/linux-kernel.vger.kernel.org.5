Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387AA7F3C63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjKVD04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbjKVD0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:26:54 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80719D1;
        Tue, 21 Nov 2023 19:26:51 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4828178a12.3;
        Tue, 21 Nov 2023 19:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700623611; x=1701228411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gyE+nnGI5QjTthItALD6eI6iRC86scX04yNpna6SY=;
        b=gL/vdMT+4P0gcWVxld8gkVpd00QBKuChio9WoNBl16ucWojzmtcGDrOKzB9puL6UmQ
         ZggXta1pDiWk3ou2/ufHZbJqZs6P3Ciulqx32naTQB2ti8dVsdzNO1MGk/1cm4Yzy9dO
         /O/eM/lL+XKPTHZNLT36Jqd0T+1EosPALxiVHObdKDO1yKHThzSadxFCENJCJ9UHcuvx
         qT6VB4PvusdjBcO9wuaRuVBR3R4mKDOCIrcaVaSD24Z69DNC2LIjexSH8emRH0X5QO4B
         Kao1NK44xzssmV+d0a0+3mUvKOFcyfpXhrNya9XUR5OjUc24UIODHn5qg0KYPsVh1Qi3
         FlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700623611; x=1701228411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9gyE+nnGI5QjTthItALD6eI6iRC86scX04yNpna6SY=;
        b=gxQz6D5oAEms8b4LbzkbHiSxVQiBfvNjraFOqDhldCnRA/INHO7hyIGneodyuBvhrJ
         xSL/qEm3nVR66tl67CDytCeKwgU6y1CT+MolG4oo3cqO8Q5n+Znt85yL/oB6B8lSmOOD
         ledaVkdzEOhQQgE/6AniZV66rQ+2dYLppq54i0Et5tNogPSLfxTIhurAw2N+Fkpk5K68
         QYV81WI0ZYcORrGfJlag+iCn3EL9ABGsJsrlb2oHS6Bzjn/sPk+31S1ECNmaz3nZBfN+
         emy9RlUbP6F6PvDNaIHMIyd4BX9VqDyC2KcKwqdvUiBOw1zg3/56Utt+afK/LkTnuWJi
         4BCw==
X-Gm-Message-State: AOJu0YzLaR881yxu3knS7tf347y/WjlNOj2hfoQTxhIOLb48yBG88m/1
        Cb1YAhpYZyTL1kGBOe53tKI=
X-Google-Smtp-Source: AGHT+IFf4iHbpjsD/zActaFjI53Jn5hNpfUpZ6KKYh1FWaYytEFyRxrGvZIz1j9k074tOwMP3JCv1A==
X-Received: by 2002:a05:6a20:8423:b0:187:f083:2cb2 with SMTP id c35-20020a056a20842300b00187f0832cb2mr1410689pzd.31.1700623610863;
        Tue, 21 Nov 2023 19:26:50 -0800 (PST)
Received: from localhost.localdomain ([154.85.62.239])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001c5bcc9d916sm8576720pli.176.2023.11.21.19.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:26:50 -0800 (PST)
From:   Yusong Gao <a869920004@gmail.com>
To:     jarkko@kernel.org, davem@davemloft.net, dhowells@redhat.com,
        dwmw2@infradead.org, juergh@proton.me, zohar@linux.ibm.com,
        herbert@gondor.apana.org.au, lists@sapience.com,
        dimitri.ledkov@canonical.com
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v4] sign-file: Fix incorrect return values check
Date:   Wed, 22 Nov 2023 03:26:27 +0000
Message-Id: <20231122032627.41094-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some wrong return values check in sign-file when call OpenSSL
API. The ERR() check cond is wrong because of the program only check the
return value is < 0 instead of <= 0. For example:
1. CMS_final() return 1 for success or 0 for failure.
2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
3. i2d_TYPEbio() return 1 for success and 0 for failure.
4. BIO_free() return 1 for success and 0 for failure.

Link: https://www.openssl.org/docs/manmaster/man3/
Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a raw signature")
Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
V1, V2: Clarify the description of git message.
V3: Removed redundant empty line.
---
 scripts/sign-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..dcebbcd6bebd 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 				     CMS_NOSMIMECAP | use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) <= 0,
 		    "CMS_final");
 
 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) <= 0,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) <= 0,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) <= 0, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) <= 0, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) <= 0, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
-- 
2.34.1

