Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA87F7EFDFC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 07:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjKRGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 01:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRGSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 01:18:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBDD4D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 22:18:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9194CC433C8;
        Sat, 18 Nov 2023 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700288323;
        bh=V3VJI3SjIz+jkP5XcrMr2bBpfkub6tGz8QbK7xtABC4=;
        h=From:To:Cc:Subject:Date:From;
        b=WSiso1oaCQ9IPq67kO9DUYnHtccq3qFXNFWvLoWB1dl6nYscEM9Nl1KUl89qi1Y2w
         Nx+j6es2fEkdbSrZkJaW1dnDGmc0Zy8t5pH0C2bLeFse2D54bpRMpNOcA6+L/T3gdd
         IhSv9CeyypWnLJ1Oojk6+2UnpS5tM/fc1oXdGGr7um69XiUu8iTgm4PgxBkwOjGWCK
         UNZB/YlgMn50Bxrt0Z/kKBZucshqANRb2MeTIxxpoVZqvNGwdeaOT2ak5lkKN5bzRO
         7If+az3XoqeEx9KmreQBxHVP8neMM9YZ03xrsN6L21uTN/u7vDoPv+ZytJdbZipJY5
         c/404DcyXcZzw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: remove error check for xrealloc()
Date:   Sat, 18 Nov 2023 15:18:36 +0900
Message-Id: <20231118061836.1294582-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xrealloc() never returns NULL as it is checked in the callee.

This is a left-over of commit d717f24d8c68 ("kconfig: add xrealloc()
helper").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4fe39b4bc5ed..1ee33e36459c 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -289,16 +289,12 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 #define LINE_GROWTH 16
 static int add_byte(int c, char **lineptr, size_t slen, size_t *n)
 {
-	char *nline;
 	size_t new_size = slen + 1;
+
 	if (new_size > *n) {
 		new_size += LINE_GROWTH - 1;
 		new_size *= 2;
-		nline = xrealloc(*lineptr, new_size);
-		if (!nline)
-			return -1;
-
-		*lineptr = nline;
+		*lineptr = xrealloc(*lineptr, new_size);
 		*n = new_size;
 	}
 
-- 
2.40.1

