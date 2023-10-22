Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4207D24CB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjJVRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjJVRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24290124;
        Sun, 22 Oct 2023 10:06:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8BBC433CB;
        Sun, 22 Oct 2023 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994386;
        bh=0RQilyl14YGAa058AYczk30yG3OUTMcYtlZHlUX70hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNFDAuiCn2GLpHPgqk2Ge5JuSaOfxg26Z+bkCMzZ63rmPLZHj6mC/hz0NC3fVYIlh
         IukOuF4yIOjYjxvQSRuz77rMkUBIA6mnCRjgkrWT+C1Gd2pGzWYnOuGNTzBRXVEaOU
         rQIPLtZIrj8zy1VLz3MHxTa0TUEldyksYYINhtBD9yUv5mQ3abWTxnxG8NQwHJC5wM
         G9RsctmxaRx6UhB7jf/gfJsHM9LaGCnssZXUUox2OX7qNnvaOgh0BAv6aWcU9WXp4H
         Zkrzfb5Iu6SHeJvOHiTik3R5+qeq1TFAuo4q2pvT8CmMHDWEgNERGJiGStBYYF8T2M
         cj5WoppkBuiaw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 07/10] modpost: disallow the combination of EXPORT_SYMBOL and __meminit*
Date:   Mon, 23 Oct 2023 02:06:10 +0900
Message-Id: <20231022170613.2072838-7-masahiroy@kernel.org>
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

Theoretically, we could export conditionally-discarded code sections,
such as .meminit*, if all the users can become modular under a certain
condition. However, that would be difficult to control and such a tricky
case has never occurred.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f73835b8f1f9..8f4bddbbc52b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1164,7 +1164,7 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 	    ELF_ST_TYPE(sym->st_info) == STT_LOPROC)
 		s->is_func = true;
 
-	if (match(secname, PATTERNS(INIT_SECTIONS)))
+	if (match(secname, PATTERNS(ALL_INIT_SECTIONS)))
 		warn("%s: %s: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.\n",
 		     mod->name, name);
 	else if (match(secname, PATTERNS(ALL_EXIT_SECTIONS)))
-- 
2.40.1

