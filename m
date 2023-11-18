Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB07EFE69
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjKRH72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjKRH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:59:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D628D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:59:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F603C433CA;
        Sat, 18 Nov 2023 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700294359;
        bh=7B9xzLj7sIaqmkQ1H5s+m9dY9DubmYm9c00xpE/4MPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKXRv4Zt8qe0WCMduKIxPCC67/0jUCspqh1jRXrxruCDwXj1rPlOzGpHrKK393xgV
         XTbNFN58g73dfeBmmoTv6FNn7csho25HIDWOeOi+JgP0pMzHqk7ConchAkFCgfuGjs
         HHJw1tmEiM3RHF2DXXudpFiZzd2Vm61Nx++tNS7T/B1EbekHZ0OQOzgdQE3CPJt36k
         xNkz32DDAi0EsbjFpix58JEKrDgUaMT0DPKBDoTxSwUS4eP2pt0kHq6H6PM9OVNoqm
         dYGidN2bS39UrtgQq10pWPvs5mXvAKFXRouaC0ZZVjMZiNiqYLGBS6YdKI+eOcrC+U
         zhRh0mjghKVPw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/6] kconfig: introduce getline_stripped() helper
Date:   Sat, 18 Nov 2023 16:59:10 +0900
Message-Id: <20231118075912.1303509-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118075912.1303509-1-masahiroy@kernel.org>
References: <20231118075912.1303509-1-masahiroy@kernel.org>
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

Currently, newline characters are stripped away in multiple places
on the caller.

Doing that in the callee is helpful for further cleanups.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 40 +++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index b6a90f6baea1..795ac6c9378f 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -337,12 +337,32 @@ static ssize_t compat_getline(char **lineptr, size_t *n, FILE *stream)
 	return -1;
 }
 
+/* like getline(), but the newline character is stripped away */
+static ssize_t getline_stripped(char **lineptr, size_t *n, FILE *stream)
+{
+	ssize_t len;
+
+	len = compat_getline(lineptr, n, stream);
+
+	if (len > 0 && (*lineptr)[len - 1] == '\n') {
+		len--;
+		(*lineptr)[len] = '\0';
+
+		if (len > 0 && (*lineptr)[len - 1] == '\r') {
+			len--;
+			(*lineptr)[len] = '\0';
+		}
+	}
+
+	return len;
+}
+
 int conf_read_simple(const char *name, int def)
 {
 	FILE *in = NULL;
 	char   *line = NULL;
 	size_t  line_asize = 0;
-	char *p, *p2, *val;
+	char *p, *val;
 	struct symbol *sym;
 	int i, def_flags;
 	const char *warn_unknown, *werror, *sym_name;
@@ -421,7 +441,7 @@ int conf_read_simple(const char *name, int def)
 		}
 	}
 
-	while (compat_getline(&line, &line_asize, in) != -1) {
+	while (getline_stripped(&line, &line_asize, in) != -1) {
 		conf_lineno++;
 		if (line[0] == '#') {
 			if (line[1] != ' ')
@@ -443,19 +463,11 @@ int conf_read_simple(const char *name, int def)
 			p = strchr(sym_name, '=');
 			if (!p)
 				continue;
-			*p++ = 0;
-			val = p;
-			p2 = strchr(p, '\n');
-			if (p2) {
-				*p2-- = 0;
-				if (*p2 == '\r')
-					*p2 = 0;
-			}
+			*p = 0;
+			val = p + 1;
 		} else {
-			if (line[0] != '\r' && line[0] != '\n')
-				conf_warning("unexpected data: %.*s",
-					     (int)strcspn(line, "\r\n"), line);
-
+			if (line[0] != '\0')
+				conf_warning("unexpected data: %s", line);
 			continue;
 		}
 
-- 
2.40.1

