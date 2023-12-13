Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCD810E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjLMKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjLMKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C699
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702463943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7rbywSJ96wW9dFZf5YYYGCHOwBB3IiK91ZMT119qoHk=;
        b=d00MKPi2mfcf3Z4bQOLrphg0xk29RbdhlbR1ksqr/1jgLfJusuaFMJBLjy+H5AqmWtbj3b
        x8YH29vQcKuillORRHAZah3JfoMCvbWnXaDwVeouosiSeuCVTZ9QgXDi2lpzHRfI9K1KLa
        lfE2XVjVXv2Pi58GiVqzIq4N0JwtxQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-K423LaHkPz29mNRoosG6eQ-1; Wed, 13 Dec 2023 05:39:00 -0500
X-MC-Unique: K423LaHkPz29mNRoosG6eQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A0F785CEA2;
        Wed, 13 Dec 2023 10:38:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 901B8C157C0;
        Wed, 13 Dec 2023 10:38:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Yusong Gao <a869920004@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        jarkko@kernel.org, davem@davemloft.net, dwmw2@infradead.org,
        juergh@proton.me, zohar@linux.ibm.com, herbert@gondor.apana.org.au,
        lists@sapience.com, dimitri.ledkov@canonical.com,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] sign-file: Fix incorrect return values check
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <308938.1702463908.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 13 Dec 2023 10:38:56 +0000
Message-ID: <308966.1702463936@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you apply this, please?

David
---

From: Yusong Gao <a869920004@gmail.com>

sign-file: Fix incorrect return values check
    =

There are some wrong return values check in sign-file when call OpenSSL
API. The ERR() check cond is wrong because of the program only check the
return value is < 0 which ignored the return val is 0. For example:
1. CMS_final() return 1 for success or 0 for failure.
2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
3. i2d_TYPEbio() return 1 for success and 0 for failure.
4. BIO_free() return 1 for success and 0 for failure.

Link: https://www.openssl.org/docs/manmaster/man3/
Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a =
raw signature")
Signed-off-by: Yusong Gao <a869920004@gmail.com>
Reviewed-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20231213024405.624692-1-a869920004@gmail.c=
om/ # v5
---
 scripts/sign-file.c |   12 ++++++------
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
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) !=3D 1,
 		    "CMS_final");
 =

 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b =3D BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) !=3D 1,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) !=3D 1,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 =

 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) !=3D 1, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) !=3D 1, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", des=
t_name);
 =

-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) !=3D 1, "%s", dest_name);
 =

 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)

