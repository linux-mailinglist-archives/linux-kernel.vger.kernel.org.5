Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3261810850
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378290AbjLMCoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjLMCoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:44:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C3A5;
        Tue, 12 Dec 2023 18:44:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so5511200b3a.2;
        Tue, 12 Dec 2023 18:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702435459; x=1703040259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EMpI1CYWqKj7MUlM6DndrADvL2mEOMt5kPq+h2tOYg=;
        b=mpiyXYjkajrjBzn5Q9eIvv0ERYmr9L+HGX0CGVo44qiVd6R91WPcokzdyOgk+FzbJG
         oGU67f+XSC587oH6hhpXClxYj0q0c8ynICp2lGz9hnLjGZy0uab41EUNBFrzG51Wj7A2
         t+grx3pdWPkWbIT/1vraNpF4my1OGxFX28jmNCnnc3k7p0Mio1V3Pw4+zye52Ok7EEru
         mgOxbg1EWcmAem9JLUpQqX8w00gCYZ2jzqCgblg1jQTB5S1l1xf6Z4hrMl6H5C1b/Wqh
         RW/WmAfx3rEfvwxnMnb0iYk0P06U80D3cXyjwi6Qnq0NvFEaD0DmYAFreGDmjBJrbyon
         1Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435459; x=1703040259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EMpI1CYWqKj7MUlM6DndrADvL2mEOMt5kPq+h2tOYg=;
        b=L+refIUTvpKacWf4xUkohB1gWJX9fO1oUvk2MjEC30Uedig62DzNgef6J8/W5jnwki
         tprhXnC9vw086gFYSg3qc0cnpp/o4KVu/TtMb8lGmhLaZcwxXd9WhKfTh6B9Tvog7D/y
         W1nCeRvairquAoO3Ip2JvyHcHo6x/AhPB9H7xWaXWTLWAUHjQTe6makxs624YE5OL0b7
         8G1HDlkEhJToIK3yXqJL9h3nMD0wx9ZXxIDyWcyEMEwqR38EvoZxAShLqzUxXNgfQcAL
         ItIkJE/z4fud/e+iV9PjkEJvnq55Nz4Ohqc+IoEdiyV0mVz5r0K021OLC7yaWRTnI64K
         QO8w==
X-Gm-Message-State: AOJu0YzjtHGlGoWH+SXsmDfgWVdr3cvgRcTXiF7i4AtYdaIe5mtzJ4Re
        qu6daNSAaPTQ6e+nhYScbq0=
X-Google-Smtp-Source: AGHT+IEfyKmeAy5pP2WpkZKm6Z3lR4fAjoqWGHt5r7ZnkXAVHFOAt5V3bWctWrcMB4xYGyZtGYaiMw==
X-Received: by 2002:a05:6a00:170d:b0:6ce:5431:6e43 with SMTP id h13-20020a056a00170d00b006ce54316e43mr9617190pfc.33.1702435459190;
        Tue, 12 Dec 2023 18:44:19 -0800 (PST)
Received: from localhost.localdomain ([106.13.249.127])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006ce4c7ba448sm8839523pff.25.2023.12.12.18.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 18:44:18 -0800 (PST)
From:   Yusong Gao <a869920004@gmail.com>
To:     jarkko@kernel.org, davem@davemloft.net, dhowells@redhat.com,
        dwmw2@infradead.org, juergh@proton.me, zohar@linux.ibm.com,
        herbert@gondor.apana.org.au, lists@sapience.com,
        dimitri.ledkov@canonical.com
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v5 RESEND] sign-file: Fix incorrect return values check
Date:   Wed, 13 Dec 2023 02:44:05 +0000
Message-Id: <20231213024405.624692-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some wrong return values check in sign-file when call OpenSSL
API. The ERR() check cond is wrong because of the program only check the
return value is < 0 which ignored the return val is 0. For example:
1. CMS_final() return 1 for success or 0 for failure.
2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
3. i2d_TYPEbio() return 1 for success and 0 for failure.
4. BIO_free() return 1 for success and 0 for failure.

Link: https://www.openssl.org/docs/manmaster/man3/
Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a raw signature")
Signed-off-by: Yusong Gao <a869920004@gmail.com>
Reviewed-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
V5: No change.
V4: Change to more strict check mode.
V3: Removed redundant empty line.
V1, V2: Clarify the description of git message.
---
 scripts/sign-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..3edb156ae52c 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 				     CMS_NOSMIMECAP | use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
 		    "CMS_final");
 
 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) != 1, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
-- 
2.34.1

