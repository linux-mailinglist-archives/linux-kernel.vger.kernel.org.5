Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E5778F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjHKMTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:19:48 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 05:19:29 PDT
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64803271E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:19:29 -0700 (PDT)
Received: from lvc-arm12.ispras.local (unknown [83.149.199.126])
        by mail.ispras.ru (Postfix) with ESMTPSA id ECB6A40762DB;
        Fri, 11 Aug 2023 12:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru ECB6A40762DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1691755933;
        bh=FYU5ywb+iDJpD2nOYlRwiaFT+3X+tORKUJKk3DU03Vw=;
        h=From:To:Cc:Subject:Date:From;
        b=XXeonAHoyXH483pHucKVcGbJVfeP8VBBLj/yk+XEZlNrNv+Obm0/QOksG4XZbOnZI
         jsW5eZoWPWhV8RbJ31uPKvPJyLftR4LrX9UaAx09Hii5gAeihMdKm4D5dJLWIk1ggw
         /lQHPyNFp/TJwKtAdACEy7W36tzFnQ9nL6trdBnY=
From:   Katya Orlova <e.orlova@ispras.ru>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Katya Orlova <e.orlova@ispras.ru>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] ASN.1: Avoid fall-through warning
Date:   Fri, 11 Aug 2023 15:10:58 +0300
Message-Id: <20230811121058.3918-1-e.orlova@ispras.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two FALL_THROUGH warnings in asn1_compiler.c.

The patch fixes one of them with adding 'fallthough' annotation
copied from include/linux/compiler_attributes.h.

The second one is in function render_element() in line 1487:
    case TYPE_REF:
        if (e-class == ASN1_UNIV && e->method == ASN1_prim && e->tag == 0)
            goto dont_render_tag;
    default:

Is this break omission in the else branch made on purpose or is it a
mistake?

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4520c6a49af8 ("X.509: Add simple ASN.1 grammar compiler")
Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
---
 scripts/asn1_compiler.c | 5 +++++
 1 file changed, 5 insertions(+), 0 deletions(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index 4c3f645065a4..73e1675a852b 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -17,6 +17,12 @@
 #include <sys/stat.h>
 #include <linux/asn1_ber_bytecode.h>
 
+#if __has_attribute(__fallthrough__)
+# define fallthrough                __attribute__((__fallthrough__))
+#else
+# define fallthrough                do {} while (0) /* fallthrough */
+#endif

 enum token_type {
 	DIRECTIVE_ABSENT,
 	DIRECTIVE_ALL,
@@ -965,6 +971,7 @@ static struct element *parse_type(struct token **_cursor, struct token *end,
 
 	case DIRECTIVE_EXTERNAL:
 		element->method = ASN1_CONS;
+		fallthrough;
 
 	case DIRECTIVE_BMPString:
 	case DIRECTIVE_GeneralString:
-- 
2.30.2

