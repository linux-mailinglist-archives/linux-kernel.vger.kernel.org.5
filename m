Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287E75D9BC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGVEsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVEsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D043583;
        Fri, 21 Jul 2023 21:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECDE960A57;
        Sat, 22 Jul 2023 04:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBB4C433CA;
        Sat, 22 Jul 2023 04:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001300;
        bh=8bWzrXDFr490RC9P5zcq6jqr8is5wzIWgnKM5w+Z3y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6UumIi0rFoYZ6kXBy48R132DOo8EDMKwo0NcId/amxMXv9Oj32Ht82zOeNtZdiro
         chnCcXClRykreyPTAifA8hUYZXdJhv6sO8Z6xv7A7Aezx7qT2lT6uNiUf3a7zK69YH
         oWZTlseQqt3l1EQBreIAEM31VZVmqKHSlOWaMvD1Iy5GdpBuAsO+NPLtQljIs8XfvN
         /+C7Xyxcrqdp+LQ7XZkJ4VTaNQh1sOJGWWAPL4mQ/b1cx+bAheb5MsvwzxbQmyucpr
         28wMASJNIfKL4soQC/o9dSZHfaRUM5OCPCQ//QGreDUiGD2GaUQrNykQGjn/MJBq7T
         ghXhvJFHFw92w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 04/19] kbuild: rpm-pkg: use %{makeflags} to pass common Make options
Date:   Sat, 22 Jul 2023 13:47:51 +0900
Message-Id: <20230722044806.3867434-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful to pass more common Make options.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 9b2b4386019d..a1ce6677880a 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -39,6 +39,7 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 #  $M: this line is enabled only when CONFIG_MODULES is enabled
 sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 %{!?make: %define make make}
+%define makeflags %{?_smp_mflags}
 
 	Name: kernel
 	Summary: The Linux Kernel
@@ -91,19 +92,19 @@ $S	cp %{SOURCE1} .config
 $S	patch -p1 < %{SOURCE2}
 $S
 $S	%build
-$S	%{make} %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
+$S	%{make} %{makeflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
 $S
 	%install
 	mkdir -p %{buildroot}/boot
 	%ifarch ia64
 	mkdir -p %{buildroot}/boot/efi
-	cp \$(%{make} -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
+	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
 	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
 	%else
-	cp \$(%{make} -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
+	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
 	%endif
-$M	%{make} %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
-	%{make} %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
+$M	%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
+	%{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
-- 
2.39.2

