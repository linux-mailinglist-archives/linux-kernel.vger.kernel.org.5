Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAA7BEAED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378480AbjJITw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378496AbjJITw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:52:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC2BA;
        Mon,  9 Oct 2023 12:52:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E3C433C8;
        Mon,  9 Oct 2023 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696881173;
        bh=kgSu1Cqs2OuHn6PG4+EYDe0mVAXd0o16yDhpNDyy/To=;
        h=Date:From:To:Cc:Subject:From;
        b=mhdPJ8HqdLGlIJNxp5NZVxMUyfblvMGfJcgBLM0kNarSBE75oieRwZWrOIO27fbc6
         l0atd0yFegWWyHlQfkdsxSbycNJlTb0v04VY3kDgV7PoBm/t8xrdTEy7A4G4clJheF
         oHJuOjuOB76WiT5tHFPqQWbJySM3f675Yif/JuxgcRyYt3dEGfI/PAGClsLDn1KPzS
         IU7YB7Z1KKoyr2D/ThRqwfXZdFAGRUJ/Lt+cn7xgb0p4NWOsYcrpCFrwzhsgA4M0MS
         f+Kp7rQ7WL0KoYbH0IjnPkVAXI1xcR0qVBj/Eltue5vb8Tx9Cw6x3pTOfVOqoWjb3Q
         YALHEZ71AkBfQ==
Date:   Mon, 9 Oct 2023 13:52:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ima: Add __counted_by for struct modsig and use struct_size()
Message-ID: <ZSRaDcJNARUUWUwS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Also, relocate `hdr->raw_pkcs7_len = sig_len;` so that the __counted_by
annotation has effect, and flex-array member `raw_pkcs7` can be properly
bounds-checked at run-time.

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/integrity/ima/ima_modsig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 3e7bee30080f..3265d744d5ce 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -29,7 +29,7 @@ struct modsig {
 	 * storing the signature.
 	 */
 	int raw_pkcs7_len;
-	u8 raw_pkcs7[];
+	u8 raw_pkcs7[] __counted_by(raw_pkcs7_len);
 };
 
 /*
@@ -65,10 +65,11 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	buf_len -= sig_len + sizeof(*sig);
 
 	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
-	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
+	hdr = kzalloc(struct_size(hdr, raw_pkcs7, sig_len), GFP_KERNEL);
 	if (!hdr)
 		return -ENOMEM;
 
+	hdr->raw_pkcs7_len = sig_len;
 	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
 	if (IS_ERR(hdr->pkcs7_msg)) {
 		rc = PTR_ERR(hdr->pkcs7_msg);
@@ -77,7 +78,6 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	}
 
 	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
-	hdr->raw_pkcs7_len = sig_len;
 
 	/* We don't know the hash algorithm yet. */
 	hdr->hash_algo = HASH_ALGO__LAST;
-- 
2.34.1

