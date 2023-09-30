Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4A7B3FA8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjI3JRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3JRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:17:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B7195
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:16:56 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mW5lqciwUlLhemW5mqgUyK; Sat, 30 Sep 2023 11:16:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696065415;
        bh=HqO0OJ0xpYTouMij+n4RJh5b8XJeCUxxVmU/L5T7xtU=;
        h=From:To:Cc:Subject:Date;
        b=EpHIjI+HuMMZ8HK0f8SwmZJ28a0d+04wdYHD9bRONTstCAVZiuB6avxQIos6ZEItc
         nVbK0FhaDctKX08sYwo+8tmAJEnv6ltQgDnG9fYwZpZoBVUgsKFrz+BMHupi59MPeM
         lgimnXmj+nnzQTAeRwa0bWoRLIp/jaeZ1pwjp3cFsxAdixy+FaKMD6mojz70CMqFDW
         MqyCIxpgCkZeOjHqiuGZYZcPItC1BeAai4TnekU0s1DSIfshfJMrRT8p3JZGtV0XHt
         MrFDwIJTX7PV+l0ZqFNDsYVj+zmnJRpnzwhfzLuVIWS231jkCTFUOwZBBvYjegsqtY
         7l1TLWdCU9YMw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 Sep 2023 11:16:55 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
Date:   Sat, 30 Sep 2023 11:14:47 +0200
Message-Id: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a work done in parallel of what is currently worked
on by Kees Cook.

My patches are only related to corner cases that do NOT match the
semantic of his Coccinelle script[1].

In this case, it is been spotted because of comedi_alloc_spriv().
All other usages of struct comedi_lrange seem to be static definition of
the structure that explicitly set the .length field.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
---
 include/linux/comedi/comedidev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index 0a1150900ef3..c08416a7364b 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -633,7 +633,7 @@ extern const struct comedi_lrange range_unknown;
  */
 struct comedi_lrange {
 	int length;
-	struct comedi_krange range[];
+	struct comedi_krange range[] __counted_by(length);
 };
 
 /**
-- 
2.34.1

