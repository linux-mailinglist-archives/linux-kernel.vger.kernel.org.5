Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627567EFE64
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjKRH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKRH7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:59:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D02D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:59:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD1C433C7;
        Sat, 18 Nov 2023 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700294356;
        bh=FUJGT7Wxv+A9qlisbFn6Z/VU7oX5Ys4xFHdHW9fEVFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SqkBXj4ROG6o8h/47chPS34ducc2BQrT+TZDy8Ool3IvQ0UiqmYgaVQm838jnb9h/
         dh2Eod92LXLdxcInnHoEBD6/o0f7gRxdA0me2vM/GcgoEkfYg5dVH5+O6SQoRYGCG5
         OE7qeFXedj3McK0OrSTq9mPaVbsQu4dPSscNaDuFZ5ztZ7zDXynQ0Dqxba7zGfHmor
         0jhLRNRP6HcpIdgjxxn4XSAourXfi3o1KRvDq3Tzi28o8o3wW1d1sa8Ca0pB4Ptd+D
         nGiYYCsO15qTJzRHCoNpxDdraZWrTqt3cC0s8BuZxaTn8aGGdel0soxC3u//6YlTYs
         QhV+yQDtLVH6Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/6] kconfig: require a space after '#' for valid input
Date:   Sat, 18 Nov 2023 16:59:07 +0900
Message-Id: <20231118075912.1303509-1-masahiroy@kernel.org>
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

Currently, when an input line starts with '#', (line + 2) is passed to
memcmp() without checking line[1].

It means that line[1] can be any arbitrary character. For example,
"#KCONFIG_FOO is not set" is accepted as valid input, functioning the
same as "# CONFIG_FOO is not set".

More importantly, this can potentially lead to a buffer overrun if
line[1] == '\0'. It occurs if the input only contains '#', as
(line + 2) points to an uninitialized buffer.

Check line[1], and skip the line if it is not a space.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 2ba4dfdd1aee..556b7f087dbb 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -426,6 +426,8 @@ int conf_read_simple(const char *name, int def)
 		conf_lineno++;
 		sym = NULL;
 		if (line[0] == '#') {
+			if (line[1] != ' ')
+				continue;
 			if (memcmp(line + 2, CONFIG_, strlen(CONFIG_)))
 				continue;
 			p = strchr(line + 2 + strlen(CONFIG_), ' ');
-- 
2.40.1

