Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8687DE3BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjKAPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjKAPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:04:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B390FD;
        Wed,  1 Nov 2023 08:04:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776A1C433CD;
        Wed,  1 Nov 2023 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851093;
        bh=T11bWBI9YO8ZTft74BUB8/taHx/JC1055+wmzAKgdGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSetNX/jH2BNa0lWJSuJnaYZBfiymurs+qWOk5lWteXDlTxsv38TqRr+T7Fb4K/7x
         MP4yPOU4yr9/mhixWyj0vhxBUi1ly9S/fpTPhJM0M3TmOAQR/W/lXDSer/o0nxbPC1
         gbpd2tTQO791y7tiAngRVYUXvjQ5+kZcIcR4WnPGmprrJLZzX5ZpMjBOK6F134AaSN
         xxzgMZAhCoGaOebkddesidDXGiBo1gpQV8hINS6z+AqkMixcI3rQJ71niMms18Li1C
         soVRSRB8ZRz/p+423aUyHILsRaool04Y7ASoDPgEx2sjiECdagGo5sDz2xgUXx0SWX
         uECLz7tTfdbdQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/7] modpost: move sym_name() to modpost.h
Date:   Thu,  2 Nov 2023 00:03:58 +0900
Message-Id: <20231101150404.754108-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101150404.754108-1-masahiroy@kernel.org>
References: <20231101150404.754108-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sym_name() to modpost.h so it can be used in other source files.

Also, add the 'const' qualifier to the function arguments.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 --------
 scripts/mod/modpost.h | 9 +++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 973b5e5ae2dd..896ecfa8483f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -710,14 +710,6 @@ static char *get_modinfo(struct elf_info *info, const char *tag)
 	return get_next_modinfo(info, tag, NULL);
 }
 
-static const char *sym_name(struct elf_info *elf, Elf_Sym *sym)
-{
-	if (sym)
-		return elf->strtab + sym->st_name;
-	else
-		return "(unknown)";
-}
-
 /*
  * Check whether the 'string' argument matches one of the 'patterns',
  * an array of shell wildcard patterns (glob).
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1392afec118c..9834ac44846d 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -156,6 +156,15 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 	return index;
 }
 
+static inline const char *sym_name(const struct elf_info *elf,
+				   const Elf_Sym *sym)
+{
+	if (sym)
+		return elf->strtab + sym->st_name;
+	else
+		return "(unknown)";
+}
+
 /*
  * If there's no name there, ignore it; likewise, ignore it if it's
  * one of the magic symbols emitted used by current tools.
-- 
2.40.1

