Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECC79AE80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjIKUrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbjIKT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:56:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9D41A7;
        Mon, 11 Sep 2023 12:56:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 693161F88C;
        Mon, 11 Sep 2023 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694462199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/nZkdclC8N0AmmXEFCRJO8MtC0Z8ZAPugiL8rL00Ks=;
        b=mvHWRKfFiFdjA+RAqKXUbxbczOMFEUGNmKIv4pgCPbjU+NQjcayZrqHnwQ24ez9LMAkZ5n
        60VC/RsscTdhpHKoAJIEiGU0Yij2Slr0UbNidGNubILeJYqrxhEczPdptLSPVgDmOgczZ2
        FrOHhRFt2ooaYPq/ydzs0UGcEY4Iij0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694462199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/nZkdclC8N0AmmXEFCRJO8MtC0Z8ZAPugiL8rL00Ks=;
        b=jlb2xG4flSJUd9PhiC8ngVWDKpjClKpX+MUcZZ+sInXANl2y52lciL898ZK0jKOBXOcSNw
        GdL0P8f7cirE6NDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 0F1872C143;
        Mon, 11 Sep 2023 19:56:39 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: rpm-pkg: Fix build with non-default MODLIB
Date:   Mon, 11 Sep 2023 21:56:18 +0200
Message-ID: <20230911195621.15198-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAK7LNAT6mQ0EpwmKUCBhv9Acaf_qyGq4hu=XvSWRuZ-pNAFWVw@mail.gmail.com>
References: <CAK7LNAT6mQ0EpwmKUCBhv9Acaf_qyGq4hu=XvSWRuZ-pNAFWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 scripts/package/kernel.spec | 14 +++++++-------
 scripts/package/mkspec      |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index ac3f2ee6d7a0..1a727f636f67 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,8 +67,8 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
 cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
-ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
-ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
+ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/build
+ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/source
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
 %endif
@@ -99,9 +99,9 @@ fi
 
 %files
 %defattr (-, root, root)
-/lib/modules/%{KERNELRELEASE}
-%exclude /lib/modules/%{KERNELRELEASE}/build
-%exclude /lib/modules/%{KERNELRELEASE}/source
+%{MODLIB}
+%exclude %{MODLIB}/build
+%exclude %{MODLIB}/source
 /boot/*
 
 %files headers
@@ -112,6 +112,6 @@ fi
 %files devel
 %defattr (-, root, root)
 /usr/src/kernels/%{KERNELRELEASE}
-/lib/modules/%{KERNELRELEASE}/build
-/lib/modules/%{KERNELRELEASE}/source
+%{MODLIB}/build
+%{MODLIB}/source
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
2.41.0

