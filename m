Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245E5802253
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjLCJtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjLCJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:49:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4530CED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:49:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41B7C433CC;
        Sun,  3 Dec 2023 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701596996;
        bh=rmsWponTX5RKX19qzp5R0zCYaOiow+z0DQeDMbnv4hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krGY099aw4XVTLnHqechM+QYTTiVpi77Y5Sg9sl2m20KUWYFikFGob/yeUNdPDMvv
         mgL2T/dyKctjBYe85UnYisBy0M2w6RF8eyks00H1v2cEq/PNLT2vbw4Mj2fKyWo8N/
         JwwI/sZKc1f1xcAziikHBfx/kdu/y1JwYg4bi5F4gj+/3oRg8/alQrKu+nAZeHVaF2
         PWnaplfhFxxhvlxy9pk0fAS+zw1DaDb0noGL+ok4nxxUhYPT+K9cpVzhxLcW9SX+h5
         KsDXXZiroAkKy0hAhm3AZiQiFiUDB1nqv+UAPqgtImF0L2OdDi9TqeSSTXZMlM2nTW
         JNVr0n4xoXzPg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] modpost: inform compilers that fatal() never returns
Date:   Sun,  3 Dec 2023 18:49:32 +0900
Message-Id: <20231203094934.1908270-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203094934.1908270-1-masahiroy@kernel.org>
References: <20231203094934.1908270-1-masahiroy@kernel.org>
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

The function fatal() never returns because modpost_log() calls exit(1)
when LOG_FATAL is passed.

Inform compilers of this fact so that unreachable code flow can be
identified at compile time.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

Changes in v2:
  - Use noreturn attribute together with alias

 scripts/mod/modpost.c | 3 +++
 scripts/mod/modpost.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ca0a90158f85..c13bc9095df3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -90,6 +90,9 @@ void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 		error_occurred = true;
 }
 
+void __attribute__((alias("modpost_log")))
+modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
+
 static inline bool strends(const char *str, const char *postfix)
 {
 	if (strlen(str) < strlen(postfix))
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 9fe974dc1a52..835cababf1b0 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -200,6 +200,9 @@ enum loglevel {
 void __attribute__((format(printf, 2, 3)))
 modpost_log(enum loglevel loglevel, const char *fmt, ...);
 
+void __attribute__((format(printf, 2, 3), noreturn))
+modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
+
 /*
  * warn - show the given message, then let modpost continue running, still
  *        allowing modpost to exit successfully. This should be used when
@@ -215,4 +218,4 @@ modpost_log(enum loglevel loglevel, const char *fmt, ...);
  */
 #define warn(fmt, args...)	modpost_log(LOG_WARN, fmt, ##args)
 #define error(fmt, args...)	modpost_log(LOG_ERROR, fmt, ##args)
-#define fatal(fmt, args...)	modpost_log(LOG_FATAL, fmt, ##args)
+#define fatal(fmt, args...)	modpost_log_noret(LOG_FATAL, fmt, ##args)
-- 
2.40.1

