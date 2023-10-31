Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B027DC78D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjJaHqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbjJaHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:46:00 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9261FF1;
        Tue, 31 Oct 2023 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EteBa
        //SMZcb/2FTv07A9wc8ZWg6lHHk08GTm5LnHF8=; b=jiPJS0IGr7o3hxanmw0nD
        wuyPuzruCbrlHPsSwSz2gkzsD56wYRf8u/PM2NR4HbvuuRHiD8pI3LIEwYzKd9os
        AOauRQx+Jy+MVql/QU+j7AmbrSCForGyak7gR+Tl8MMA7E+13jThWDImwXbE/aoy
        +xRNBwvKRbkuD8pqKtdUxc=
Received: from localhost.localdomain (unknown [106.13.245.201])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3_1yXsEBlr83VBw--.26819S2;
        Tue, 31 Oct 2023 15:45:34 +0800 (CST)
From:   Yusong Gao <a869920004@163.com>
To:     dhowells@redhat.com, dwmw2@infradead.org
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yusong Gao <a869920004@163.com>
Subject: [PATCH] sign-file: Correct return value check for sign-file
Date:   Tue, 31 Oct 2023 07:45:17 +0000
Message-Id: <20231031074517.858183-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_1yXsEBlr83VBw--.26819S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF48Zw4kCr1UXFW8ur4rXwb_yoW8Kr47pr
        4Fk3WSyFWxJrWqyay7K3W0kF45Kr4kt3Wru3Z8Jw1YyFyYq3yIgr4v9a4rXr95XF45ur15
        XF97Jay5Aa45JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zReOJrUUUUU=
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/xtbB0wYa6VXl18I-LgAAsS
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some wrong return value check in sign-file when call OpenSSL
API. For example the CMS_final() return 1 for success or 0 for failure
The ERR() check cond is wrong because of the program only check the
return value is < 0 instead of <= 0, so correct it.

Reference:
https://www.openssl.org/docs/manmaster/man3/CMS_final.html
https://www.openssl.org/docs/manmaster/man3/i2d_CMS_bio_stream.html
https://www.openssl.org/docs/manmaster/man3/i2d_PKCS7_bio.html
https://www.openssl.org/docs/manmaster/man3/BIO_free.html

Signed-off-by: Yusong Gao <a869920004@163.com>
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

