Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB67E8080
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjKJSMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKJSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:14 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1EB83ED;
        Thu,  9 Nov 2023 23:18:23 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45d90e1333fso781218137.3;
        Thu, 09 Nov 2023 23:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699600702; x=1700205502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn6MUDiWEFfbX9oPQpdiJgdcxG5eK/ICtFVVPS0LXu0=;
        b=QVGj73XSG+3qofv5XV1fLsFz+lKWCi5I8pOUZnuw68ulaJD/HztLklNmGPAmLGhaB1
         2PfgHcObL0ojoDlxlnatOug+mOV6ISMOio9HyV+Gbtl62u/uNzZfHjw2Bdix4XgOkiGx
         +gZB0iKh961nwl8+SHkznwaPDLiHa2OzUvSdAfjsI6hL8yOa7ZfsOX48ELte9xYAMkzl
         zXgBw2GPBw9CTXOEfu+TO4KNW1a4nePuTvlNylwnAiPPrV6+PEm1vbHhZNjb3TsFJVin
         rK8YKPLsa+oquD1UghKOZenr8eWO186h1tDPOHi7cD4i83t58NwUaWum8OqlAPfmrnZQ
         gKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600702; x=1700205502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pn6MUDiWEFfbX9oPQpdiJgdcxG5eK/ICtFVVPS0LXu0=;
        b=Qq2twGxCCOot8oRq7/KtsLgugkJZYfa9SOF6VWfPdmDp5d1dPwg0LfM5+YtuYCECJe
         QVWwgeZ1R7YTLi5sA+ZRd6CLiD5VfwhZ244giLpNqXDJqSlC3F1BLcBHvDV7L1Jcqr1i
         gdGCQ1tr8Hnb2Kr9elzdMUNH3ccHxB/FjkGyfi2f/AttBfn0PYrpx7kPfiA2tqIyAW6T
         ycT9lRTktecO5aq828uLOFuiZM8AMTT7yeijYF5fXqdOWdEK/YW/mbYg0TzM09DBbp6j
         80f052UkwaFM8qBtJ8viV7SbA7gCbOZ0rYAGKWV3sdh2nNDCZcs+Axhrs3Bi7WBdcEEx
         ef3Q==
X-Gm-Message-State: AOJu0YwUMexPK4L2As3a3OQAGsoROQ8soAORLepenZp3O0dk/KyKLdZ/
        IVcvV746O+LchafmNuuJ/C0=
X-Google-Smtp-Source: AGHT+IF7nOo7LYHhHizC9muNzUETAtfsA5nQCD8wsu25SN/o3qbFo4u0zymwbRQmsYONC9thL+REUg==
X-Received: by 2002:a67:b206:0:b0:45e:f8af:79cc with SMTP id b6-20020a67b206000000b0045ef8af79ccmr7165852vsf.8.1699600702472;
        Thu, 09 Nov 2023 23:18:22 -0800 (PST)
Received: from localhost.localdomain ([154.85.62.239])
        by smtp.gmail.com with ESMTPSA id x4-20020a63db44000000b005b8ea15c338sm5822726pgi.62.2023.11.09.23.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:18:22 -0800 (PST)
From:   Yusong Gao <a869920004@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, herbert@gondor.apana.org.au,
        lists@sapience.com, dimitri.ledkov@canonical.com
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] sign-file: Fix incorrect return values check
Date:   Fri, 10 Nov 2023 07:18:12 +0000
Message-Id: <20231110071812.280144-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yusong Gao <a869920004@163.com>

There are some wrong return values check in sign-file when call OpenSSL
API. For example the CMS_final() return 1 for success or 0 for failure.
The ERR() check cond is wrong because of the program only check the
return value is < 0 instead of <= 0.

Link:
https://www.openssl.org/docs/manmaster/man3/CMS_final.html
https://www.openssl.org/docs/manmaster/man3/i2d_CMS_bio_stream.html
https://www.openssl.org/docs/manmaster/man3/i2d_PKCS7_bio.html
https://www.openssl.org/docs/manmaster/man3/BIO_free.html

Signed-off-by: Yusong Gao <a869920004@gmail.com>
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

