Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E07F8A03
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjKYKik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjKYKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:31:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6E10E4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:31:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4015CC433C8;
        Sat, 25 Nov 2023 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700908292;
        bh=1NjYyVMTbEYrYJbWYo16fYRJ4go93r4tTFjTVNLyfms=;
        h=From:To:Cc:Subject:Date:From;
        b=MVlOFapVpx90KH1wMWShYB/xzzNDh16Atogs82J3zghXoqUFi+xcapJ6fODrvVGTj
         f8PKozrX4yioUdDuibC4/52x5/HDy9jh35vyHoK+iBupoTA71fJr+6k4z6645jg/H3
         1DeDWjz3kfsDpEBTUtmK/rSdVRrAMSH8fE0niSrFj27KTeohvchgKXObM8Yv+iBfH0
         zwpEh9eRbOZOChuT7cADbeikGoVOADxGNRSWqov7vBf+f+53FjfsWulDh6Q92P88FW
         ydTuV0NieSNCF0TTpjTj4wRpSEmRMBggu7emM7j7pbGQcOdiGN2CUYYWPjgOS4m9qy
         FTIcDOzAUT3fw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] modpost: move __attribute__((format(printf, 2, 3))) to modpost.h
Date:   Sat, 25 Nov 2023 19:31:14 +0900
Message-Id: <20231125103116.797608-1-masahiroy@kernel.org>
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

This attribute must be added to the function declaration in a header
for comprehensive checking of all the callsites.

Fixes: 6d9a89ea4b06 ("kbuild: declare the modpost error functions as printf like")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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

