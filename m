Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680987E80F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjKJSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345059AbjKJSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33373304B;
        Fri, 10 Nov 2023 04:14:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 060FC219C4;
        Fri, 10 Nov 2023 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699618454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dq19wJSmTOrZRzEGt4AZFA5wmg4WvLvB9MbM94XFO7k=;
        b=cYTmn7Cu5Hwf6dEwJm2Dfuphy49HT1ncwzz63aOGu9p+CD8c2blI9bAm9+DM8sSHqLuv3c
        E8eSAFeVkQ0xT/E/X8bVsEGbLGYY6n+oFUTn4Yz/sWxyMB2W9ecJ7mvbmgIqdUnftk07zW
        6cqDA+0jSFKR6T9iL8HBAJzGZwHvJK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699618454;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dq19wJSmTOrZRzEGt4AZFA5wmg4WvLvB9MbM94XFO7k=;
        b=ArSIIaCcyPZ/qGHDyDqGuJmiIQaBWEq0JmsIWnWTnc+p9QQn2hoMnCmarEV2Wor6UZFv6Z
        PosazrD2S6yHsTDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id A17E72C162;
        Fri, 10 Nov 2023 12:14:13 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] configure: Check that provided paths are absolute
Date:   Fri, 10 Nov 2023 13:13:55 +0100
Message-ID: <8aff0c9c491d8afeec7f6b2cd96cbd0439e26fbb.1699618135.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699618135.git.msuchanek@suse.de>
References: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf> <cover.1699618135.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

configure checks that its built-in directory options get an absolute
path. Copy the check for custom options.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v6: new patch
---
 configure.ac | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configure.ac b/configure.ac
index d6da5ee9ae9a..de01e08cf2e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -97,6 +97,23 @@ AC_ARG_WITH([module_directory],
         [], [with_module_directory=/lib/modules])
 AC_SUBST([module_directory], [$with_module_directory])
 
+# Check all directory arguments for consistency.
+for ac_var in	distconfdir rootlibdir module_directory
+do
+  eval ac_val=\$$ac_var
+  # Remove trailing slashes.
+  case $ac_val in
+    */ )
+      ac_val=`expr "X$ac_val" : 'X\(.*@<:@^/@:>@\)' \| "X$ac_val" : 'X\(.*\)'`
+      eval $ac_var=\$ac_val;;
+  esac
+  # Be sure to have absolute directory names.
+  case $ac_val in
+    @<:@\\/$@:>@* | ?:@<:@\\/@:>@* )  continue;;
+  esac
+  as_fn_error $? "expected an absolute directory name for --$ac_var: $ac_val"
+done
+
 AC_ARG_WITH([zstd],
 	AS_HELP_STRING([--with-zstd], [handle Zstandard-compressed modules @<:@default=disabled@:>@]),
 	[], [with_zstd=no])
-- 
2.42.0

