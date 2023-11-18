Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5761A7EFE6B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjKRH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjKRH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:59:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA29D5D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:59:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CCEC433C7;
        Sat, 18 Nov 2023 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700294362;
        bh=ltXpZxzZisF0fheB2Pyv5Oadd/1xNAmgjgKDKLE8PmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYhntA+bM5EgGMr+Y1nx358VbjA5Rv+51e6CcZ80YMxkhU4lpcKO0p/3dXATjkqjV
         /A1qhJ7XQkypaUyXWtwXiCmMBogTlAQtzTj4GhE0d6JAn48m0X7xA1JtoIT+0mxmaO
         xLlQdKJPc5vBZsuV/S/WrCVEPfl2eD2/Xxfo25ky6sqqDeAOgQzKXzhBtyKiIFY5d/
         FvVHKy7p8qFn1VA9K5Et/c2VCYldtOXiadTCumf/TzhQYwkisLzvhsM8Js4cT59mjk
         08gXBP+1qpMPsNY66BX4/pCAn+uMqbwPBVt8eB6+HkBKA1+r5/1CLv9FlWlKHEB3vU
         xU+XFBgSIXhQQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/6] kconfig: massage the loop in conf_read_simple()
Date:   Sat, 18 Nov 2023 16:59:12 +0900
Message-Id: <20231118075912.1303509-6-masahiroy@kernel.org>
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

Make the while-loop code a little more readable.

The gain is that "CONFIG_FOO" without '=' is warned as unexpected data.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 958be12cd621..bd14aae1db58 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -443,6 +443,10 @@ int conf_read_simple(const char *name, int def)
 
 	while (getline_stripped(&line, &line_asize, in) != -1) {
 		conf_lineno++;
+
+		if (!line[0]) /* blank line */
+			continue;
+
 		if (line[0] == '#') {
 			if (line[1] != ' ')
 				continue;
@@ -458,17 +462,20 @@ int conf_read_simple(const char *name, int def)
 				continue;
 
 			val = "n";
-		} else if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
+		} else {
+			if (memcmp(line, CONFIG_, strlen(CONFIG_))) {
+				conf_warning("unexpected data: %s", line);
+				continue;
+			}
+
 			sym_name = line + strlen(CONFIG_);
 			p = strchr(sym_name, '=');
-			if (!p)
+			if (!p) {
+				conf_warning("unexpected data: %s", line);
 				continue;
+			}
 			*p = 0;
 			val = p + 1;
-		} else {
-			if (line[0] != '\0')
-				conf_warning("unexpected data: %s", line);
-			continue;
 		}
 
 		sym = sym_find(sym_name);
-- 
2.40.1

