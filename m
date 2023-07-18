Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C81A757B29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjGRMDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjGRMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:03:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93896E47;
        Tue, 18 Jul 2023 05:03:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44A0B218EE;
        Tue, 18 Jul 2023 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689681806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG3nbQZ6NQlPAmYzpmo6KoCjwuY3FXsibXeDJl7sMQM=;
        b=lTrh5HE3QZv5mu8b5Ytjm53UsTjwxmdJXanRewoKmSbJN24dQqbuMqfhMYWeHgvbViNcDB
        M+//oXkd7rJY+dVTdqdEubM3GCCZtelXUNQ5W7cq6ZOj+qzcjqLYSHEfdyGboOvgEQ7K8b
        yemZJtS5cx+14bgzWi4Ud8xb2u8pnJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689681806;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG3nbQZ6NQlPAmYzpmo6KoCjwuY3FXsibXeDJl7sMQM=;
        b=svYsuHjD3AqEe3A9+vR3sCejz0Mq2M3b8oE9C3L0wq4+p2+G3cW+GVjFdGDgvTx7ZVJd8I
        m0EVY4KErmmORzDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id EECE32C143;
        Tue, 18 Jul 2023 12:03:25 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH kmod v5 1/5] configure: Detect openssl sm3 support
Date:   Tue, 18 Jul 2023 14:01:52 +0200
Message-ID: <b97e20faa07e9e31c6eaf96683011aa24e80760c.1689681454.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689681454.git.msuchanek@suse.de>
References: <cover.1689589902.git.msuchanek@suse.de> <cover.1689681454.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older openssl versions do not support sm3. The code has an option to
disable the sm3 hash but the lack of openssl support is not detected
automatically.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6064dee77ae6..331cc8a1ffd5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -123,6 +123,13 @@ AC_ARG_WITH([openssl],
 AS_IF([test "x$with_openssl" != "xno"], [
 	PKG_CHECK_MODULES([libcrypto], [libcrypto >= 1.1.0], [LIBS="$LIBS $libcrypto_LIBS"])
 	AC_DEFINE([ENABLE_OPENSSL], [1], [Enable openssl for modinfo.])
+	AC_COMPILE_IFELSE([AC_LANG_SOURCE([[#include <openssl/ssl.h>
+		int nid = NID_sm3;]])], [
+		AC_MSG_NOTICE([openssl supports sm3])
+	], [
+		AC_MSG_NOTICE([openssl sm3 support not detected])
+		CPPFLAGS="$CPPFLAGS -DOPENSSL_NO_SM3"
+	])
 ], [
 	AC_MSG_NOTICE([openssl support not requested])
 ])
-- 
2.41.0

