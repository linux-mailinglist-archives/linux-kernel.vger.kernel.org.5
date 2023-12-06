Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F88078DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442818AbjLFTsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379438AbjLFTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:47:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720FD3;
        Wed,  6 Dec 2023 11:48:05 -0800 (PST)
Received: from kitsune.suse.cz (unknown [10.100.12.127])
        by smtp-out2.suse.de (Postfix) with ESMTP id D907D1FD38;
        Wed,  6 Dec 2023 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701892083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRWb+HJrZK0+DeQKF7G3lI1mi1x+bXsZpMkFr/DHwLo=;
        b=x6K1kx8CbsvgZuyz896cRajvdVXvkWeCINL7yDq/BxZUEe98u1JRDk1xb8PPi6uOWycEoL
        90KJAuAYJ/uiPOnRnGZMeya5oQgwkMcu9HXgVUBAcwNyYHfIKnCbBUYryjaDUWAmyYknf6
        kY5O9TBp88gAI+G4w++EdT8StxRCvp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701892083;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRWb+HJrZK0+DeQKF7G3lI1mi1x+bXsZpMkFr/DHwLo=;
        b=j+qDcBrV+ldOxKEIHrJohbeQHnGbUd0pXC1tKDZbmZYlmV2mQ9AHlrgMHFNSeMJojaUMfE
        CkypdC6TgBInaVCg==
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
Subject: [PATCH v6 2/2] kbuild: rpm-pkg: Fix build with non-default MODLIB
Date:   Wed,  6 Dec 2023 20:47:52 +0100
Message-ID: <baa3224bece94220dfe7173432143a91f7612c09.1701892062.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.40
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [3.40 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         R_MISSING_CHARSET(2.50)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_RATELIMIT(0.00)[to_ip_from(RLbjsaozyn1c4dqqoh4tzemsye)];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[13];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[suse.de,suse.com,gmail.com,inai.de,kernel.org,google.com,fjasle.eu,vger.kernel.org];
         BAYES_HAM(-3.00)[100.00%];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default MODLIB value is composed of three variables

MODLIB = $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)

However, the kernel.spec hadcodes the default value of
$(KERNEL_MODULE_DIRECTORY), and changed value is not reflected when
building the package.

Pass KERNEL_MODULE_DIRECTORY to kernel.spec to fix this problem.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
Build on top of the previous patch adding KERNEL_MODULE_DIRECTORY
---
 scripts/package/kernel.spec | 8 ++++----
 scripts/package/mkspec      | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..12996ed365f8 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
 cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
-ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
+ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}/build
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
 %endif
@@ -98,8 +98,8 @@ fi
 
 %files
 %defattr (-, root, root)
-/lib/modules/%{KERNELRELEASE}
-%exclude /lib/modules/%{KERNELRELEASE}/build
+%{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}
+%exclude %{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}/build
 /boot/*
 
 %files headers
@@ -110,5 +110,5 @@ fi
 %files devel
 %defattr (-, root, root)
 /usr/src/kernels/%{KERNELRELEASE}
-/lib/modules/%{KERNELRELEASE}/build
+%{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}/build
 %endif
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index ce201bfa8377..e952fa4f2937 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -24,6 +24,7 @@ fi
 cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
+%define KERNEL_MODULE_DIRECTORY ${KERNEL_MODULE_DIRECTORY}
 %define pkg_release $("${srctree}/init/build-version")
 EOF
 
-- 
2.42.0

