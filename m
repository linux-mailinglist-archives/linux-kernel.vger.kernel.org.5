Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3037BA2F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjJEPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjJEPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:49:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E078C37;
        Thu,  5 Oct 2023 08:07:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D89EF1F38D;
        Thu,  5 Oct 2023 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696518467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yZlU7QN0oRlDYYCQ2eW8q/GdWjqvw1DcFTvoKMkfVz8=;
        b=ov2VnqDIVSqkpksz2LmAeiGObLWtzfZogfmYV5AAr9s9quUiBPRZJ71FwxA7JmI/K/kjDU
        6SC1JbcUjWGz5lhROAqphQuenK7OdwFHGKbZgSZ5Rvh3zB7CTnaJGtf9nlaamenUZWbF0H
        qWL9j/y9ZM00hKDMDocR3eQYp9hyGfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696518467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yZlU7QN0oRlDYYCQ2eW8q/GdWjqvw1DcFTvoKMkfVz8=;
        b=ZhTwBZlLV3Jc4irtOEOMLaKr2L3qMg95Ll4Tmq+LMYA9lxj9Myk5tq4YKSYhsTc6vkOe8O
        AEqAHUMSIL58k7DQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 63D052C143;
        Thu,  5 Oct 2023 15:07:47 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-modules@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default MODLIB
Date:   Thu,  5 Oct 2023 17:07:28 +0200
Message-ID: <20231005150728.3429-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default MODLIB value is composed of two variables and the hardcoded
string '/lib/modules/'.

MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)

Defining this middle part as a variable was rejected on the basis that
users can pass the whole MODLIB to make, such as

make 'MODLIB=$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'

However, this middle part of MODLIB is independently hardcoded by
rpm-pkg, and when the user alters MODLIB this is not reflected when
building the package.

Given that $(INSTALL_MOD_PATH) is overridden during the rpm package build
it is likely going to be empty. Then MODLIB can be passed to the rpm
package, and used in place of the whole
/usr/lib/modules/$(KERNELRELEASE) part.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 scripts/package/kernel.spec | 8 ++++----
 scripts/package/mkspec      | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..15f49c5077db 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
 cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
-ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
+ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/build
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
 %endif
@@ -98,8 +98,8 @@ fi
 
 %files
 %defattr (-, root, root)
-/lib/modules/%{KERNELRELEASE}
-%exclude /lib/modules/%{KERNELRELEASE}/build
+%{MODLIB}
+%exclude %{MODLIB}/build
 /boot/*
 
 %files headers
@@ -110,5 +110,5 @@ fi
 %files devel
 %defattr (-, root, root)
 /usr/src/kernels/%{KERNELRELEASE}
-/lib/modules/%{KERNELRELEASE}/build
+%{MODLIB}/build
 %endif
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index d41608efb747..d41b2e5304ac 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -18,6 +18,7 @@ fi
 cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
+%define MODLIB ${MODLIB}
 %define pkg_release $("${srctree}/init/build-version")
 EOF
 
-- 
2.42.0

