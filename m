Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFC7560B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGQKkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGQKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:40:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF32C0;
        Mon, 17 Jul 2023 03:40:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8819221958;
        Mon, 17 Jul 2023 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689590404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVsH0ru6iCq/4+npZ6IZoOzlEjBX5Fl88+GmHlp+UOY=;
        b=GvuChp5d5XY58JX7F9pYSRZqnwHghZNqZaQ1ZAeF8tGVxQwvwOHOu8xM1OMWDUpTlpbpCG
        c/O1nagNibhnQqO33IgbX/iiIScNqAj6e2nAe0gCQ+P7GkFGUeURBcLciLNZEXjH+ObQKs
        C7A7Om3VwtQvDbfQ2akmZAVxSuWHFiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689590404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVsH0ru6iCq/4+npZ6IZoOzlEjBX5Fl88+GmHlp+UOY=;
        b=YBjEXmPxNuZj/Nk5drOQURoKWwf6It1X81oQzXQJISZVIBYFe8T+0GZyoY0tlseEa9GTqx
        Y/RiKiPPPpRS5BCw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 2545B2C146;
        Mon, 17 Jul 2023 10:40:04 +0000 (UTC)
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
Subject: [PATCH kmod v4 3/4] kmod: Add config command to show compile time configuration as JSON
Date:   Mon, 17 Jul 2023 12:39:52 +0200
Message-ID: <eacb691cec6266a22387f6445507de122f5c7afb.1689589902.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689589902.git.msuchanek@suse.de>
References: <20230711153126.28876-1-msuchanek@suse.de> <cover.1689589902.git.msuchanek@suse.de>
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

Show prefix (where system configuration files are searched/to be
installed), sysconfdir (where user configuration files are searched),
module compressions, and module signatures supported.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: mention module signature in commit message
v3: add sysconfdir
---
 man/kmod.xml |  6 ++++++
 tools/kmod.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/man/kmod.xml b/man/kmod.xml
index 0706ad58c2cc..f992a500f836 100644
--- a/man/kmod.xml
+++ b/man/kmod.xml
@@ -71,6 +71,12 @@
           <para>Show the help message.</para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term><command>config</command></term>
+        <listitem>
+          <para>Show compile time options in JSON.</para>
+        </listitem>
+      </varlistentry>
       <varlistentry>
         <term><command>list</command></term>
         <listitem>
diff --git a/tools/kmod.c b/tools/kmod.c
index 55689c075ab1..a684c1d24284 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -37,9 +37,11 @@ static const struct option options[] = {
 };
 
 static const struct kmod_cmd kmod_cmd_help;
+static const struct kmod_cmd kmod_cmd_config;
 
 static const struct kmod_cmd *kmod_cmds[] = {
 	&kmod_cmd_help,
+	&kmod_cmd_config,
 	&kmod_cmd_list,
 	&kmod_cmd_static_nodes,
 
@@ -95,6 +97,44 @@ static const struct kmod_cmd kmod_cmd_help = {
 	.help = "Show help message",
 };
 
+static const char *compressions[] = {
+#ifdef ENABLE_ZSTD
+			"zstd",
+#endif
+#ifdef ENABLE_XZ
+			"xz",
+#endif
+#ifdef ENABLE_ZLIB
+			"gz",
+#endif
+			NULL
+};
+
+static int kmod_config(int argc, char *argv[])
+{
+	unsigned i;
+	printf("{\"prefix\":\"" PREFIX "\""
+			",\"sysconfdir\":\"" SYSCONFDIR "\""
+			",\"module_signature\":["
+#ifdef ENABLE_OPENSSL
+			"\"PKCS#7\","
+#endif
+			"\"legacy\"]"
+			",\"module_compression\":[");
+	for(i = 0; compressions[i]; i++) {
+		printf("%s\"%s\"", i ? "," : "", compressions[i]);
+	}
+	printf("]}\n");
+
+	return EXIT_SUCCESS;
+}
+
+static const struct kmod_cmd kmod_cmd_config = {
+	.name = "config",
+	.cmd = kmod_config,
+	.help = "Show compile time options in JSON",
+};
+
 static int handle_kmod_commands(int argc, char *argv[])
 {
 	const char *cmd;
-- 
2.41.0

