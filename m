Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082EC7D24C8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjJVRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjJVRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E205119;
        Sun, 22 Oct 2023 10:06:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE55C433BB;
        Sun, 22 Oct 2023 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994385;
        bh=JGaUnTUZE4/t01Gqe9nbznjUqklvDlxx4Gf2S+Ki0Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTY/zbtuzdasxDR9cQ0LmqDv4FTLNY6HGgn4Qym261RFNer3DIcCMu2+SQzeJs717
         KWBYy/Pc9bVNrOExQBVDa4r00WPBK2ZAotcvwSu2Z/QsbmNXADt4OZsQYxCaPntqNw
         GaFXuRIvcf5mmZkUXNCayIVzNxKdfuHga8qzf+XccbVoK1ebJUCa0M2af0zYRlqR7Z
         uVhCguL/iJL2T4n9f8v77c91IfGDob5oz46yRFDu5O+ych2/GjUpreMUQxZUGJehSs
         tJ1Avsz3VEMgMHwjSaRVZRVwBuBPcgk2dnepot1fmndkw0BRqEpQeXffvzGI34Hygt
         RNMYcKRUU2qiA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 06/10] modpost: remove EXIT_SECTIONS macro
Date:   Mon, 23 Oct 2023 02:06:09 +0900
Message-Id: <20231022170613.2072838-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231022170613.2072838-1-masahiroy@kernel.org>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALL_EXIT_SECTIONS and EXIT_SECTIONS are the same. Remove the latter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 626ab599eea2..f73835b8f1f9 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -808,7 +808,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define ALL_XXXINIT_SECTIONS ".meminit.*"
 
 #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
-#define ALL_EXIT_SECTIONS EXIT_SECTIONS
+#define ALL_EXIT_SECTIONS ".exit.*"
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
@@ -819,8 +819,6 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define INIT_SECTIONS      ".init.*"
 
-#define EXIT_SECTIONS      ".exit.*"
-
 #define ALL_TEXT_SECTIONS  ALL_INIT_TEXT_SECTIONS, ALL_EXIT_TEXT_SECTIONS, \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
@@ -1006,7 +1004,7 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 	 */
 	if (!extra_warn &&
 	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
-	    match(tosec, PATTERNS(EXIT_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_EXIT_SECTIONS)) &&
 	    match(fromsym, PATTERNS("*driver")))
 		return 0;
 
@@ -1169,7 +1167,7 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 	if (match(secname, PATTERNS(INIT_SECTIONS)))
 		warn("%s: %s: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.\n",
 		     mod->name, name);
-	else if (match(secname, PATTERNS(EXIT_SECTIONS)))
+	else if (match(secname, PATTERNS(ALL_EXIT_SECTIONS)))
 		warn("%s: %s: EXPORT_SYMBOL used for exit symbol. Remove __exit or EXPORT_SYMBOL.\n",
 		     mod->name, name);
 }
-- 
2.40.1

