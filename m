Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A099802254
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjLCJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:49:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B8DA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:49:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F62C433C9;
        Sun,  3 Dec 2023 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701596995;
        bh=DQgligyVko6JOkpsukWsLHEde1ox5xe3QB7/zY+o3mc=;
        h=From:To:Cc:Subject:Date:From;
        b=MdCQBWpJATcuy0G8YGsVOOdYN6tVbI+HTba5TIrjOmIdUpI/IfuDMiUCCkk7sxNOq
         f3f/l9bHGyWii4wNCS7cbYACpBT403QtK+zJ5DgB2ui3BjGnMUuALVc3pH6EgBV+ZI
         bQoRQ43aqM5VVIqg4x2SgfId0j9Na0Kpei38vJLAFyQZjbZpa6FY388+nCMt+T9mz2
         WCCxyX4ceHbHSwI6nMxJRsjNCwtJZZe417YofNj8Ew+3LU0mvm/YcM1BqlurDizojU
         D/xH2D1K9j8HnYPQ3I/ptSgdJbp5bvb3/ejDqp5Cz9+Qw3776utGljLpRllPyvimkF
         cOzThHeNnVlxg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] modpost: move __attribute__((format(printf, 2, 3))) to modpost.h
Date:   Sun,  3 Dec 2023 18:49:31 +0900
Message-Id: <20231203094934.1908270-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attribute must be added to the function declaration in a header
for comprehensive checking of all the callsites.

Fixes: 6d9a89ea4b06 ("kbuild: declare the modpost error functions as printf like")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v1)

 scripts/mod/modpost.c | 3 +--
 scripts/mod/modpost.h | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cb6406f485a9..ca0a90158f85 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -60,8 +60,7 @@ static unsigned int nr_unresolved;
 
 #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
 
-void __attribute__((format(printf, 2, 3)))
-modpost_log(enum loglevel loglevel, const char *fmt, ...)
+void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 {
 	va_list arglist;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 69baf014da4f..9fe974dc1a52 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -197,7 +197,8 @@ enum loglevel {
 	LOG_FATAL
 };
 
-void modpost_log(enum loglevel loglevel, const char *fmt, ...);
+void __attribute__((format(printf, 2, 3)))
+modpost_log(enum loglevel loglevel, const char *fmt, ...);
 
 /*
  * warn - show the given message, then let modpost continue running, still
-- 
2.40.1

