Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B095175D9C1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGVEs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGVEs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E83C0A;
        Fri, 21 Jul 2023 21:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6872460A4C;
        Sat, 22 Jul 2023 04:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF7BC433CC;
        Sat, 22 Jul 2023 04:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001304;
        bh=VV5tg2oV5uhqxjDebBRYN7lAbnxJg/0q4gs6El0Bz/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mG08w/YO2AVy4RvhlsZYRzU8pZ7AOynAFV251+7dUAQpeLDr1wrX6xYt+W3+8fKtR
         wwhZySwk/6Yn49cDO/EzC/F6iKyyHLB8hiu4fUvVsHTUb8hfie25cCiwMl9fyPvgb/
         licrRafLcsQK5IOU5RdwNE7AWRynJZB0bStUf/nfYmC2O/ycmkr+HJi/SwiICuu+jC
         wJC195JJ1ouMd9Qaq/qHAzNrjYKb3a9y1H6/UEKgjLL5x4m03YL4abKtW4NtY3Zsle
         LnV1g/BfowWXyKagezKfu1wsu3mfGmCbAwHUWq5/H/NY3H5yB3qFLUwdB9J99awvOp
         BavFmJ8F7OGkA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 07/19] kbuild: rpm-pkg: replace $KERNELRELEASE in spec file with %{KERNELRELEASE}
Date:   Sat, 22 Jul 2023 13:47:54 +0900
Message-Id: <20230722044806.3867434-7-masahiroy@kernel.org>
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

Avoid hard-coding the value of KERNELRELEASE in the generated spec file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index a6a383aaaea7..34b2489106cf 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -39,6 +39,7 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 #  $M: this line is enabled only when CONFIG_MODULES is enabled
 sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 %define ARCH ${ARCH}
+%define KERNELRELEASE ${KERNELRELEASE}
 
 %{!?make: %define make make}
 %define makeflags %{?_smp_mflags} ARCH=%{ARCH}
@@ -54,7 +55,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 $S	Source0: linux.tar.gz
 $S	Source1: config
 $S	Source2: diff.patch
-	Provides: kernel-$KERNELRELEASE
+	Provides: kernel-%{KERNELRELEASE}
 $S	BuildRequires: bc binutils bison dwarves
 $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
 $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
@@ -94,58 +95,58 @@ $S	cp %{SOURCE1} .config
 $S	patch -p1 < %{SOURCE2}
 $S
 $S	%build
-$S	%{make} %{makeflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
+$S	%{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
 $S
 	%install
 	mkdir -p %{buildroot}/boot
 	%ifarch ia64
 	mkdir -p %{buildroot}/boot/efi
-	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
-	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
+	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-%{KERNELRELEASE}
+	ln -s efi/vmlinuz-%{KERNELRELEASE} %{buildroot}/boot/
 	%else
-	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
+	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
 	%endif
 $M	%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	%{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
-	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
-	cp .config %{buildroot}/boot/config-$KERNELRELEASE
-$S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
-$S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
-$S$M	mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
-$S$M	tar cf - $EXCLUDES . | tar xf - -C %{buildroot}/usr/src/kernels/$KERNELRELEASE
-$S$M	cd %{buildroot}/lib/modules/$KERNELRELEASE
-$S$M	ln -sf /usr/src/kernels/$KERNELRELEASE build
-$S$M	ln -sf /usr/src/kernels/$KERNELRELEASE source
+	cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
+	cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
+$S$M	rm -f %{buildroot}/lib/modules/%{KERNELRELEASE}/build
+$S$M	rm -f %{buildroot}/lib/modules/%{KERNELRELEASE}/source
+$S$M	mkdir -p %{buildroot}/usr/src/kernels/%{KERNELRELEASE}
+$S$M	tar cf - $EXCLUDES . | tar xf - -C %{buildroot}/usr/src/kernels/%{KERNELRELEASE}
+$S$M	cd %{buildroot}/lib/modules/%{KERNELRELEASE}
+$S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} build
+$S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} source
 
 	%clean
 	rm -rf %{buildroot}
 
 	%post
-	if [ -x /sbin/installkernel -a -r /boot/vmlinuz-$KERNELRELEASE -a -r /boot/System.map-$KERNELRELEASE ]; then
-	cp /boot/vmlinuz-$KERNELRELEASE /boot/.vmlinuz-$KERNELRELEASE-rpm
-	cp /boot/System.map-$KERNELRELEASE /boot/.System.map-$KERNELRELEASE-rpm
-	rm -f /boot/vmlinuz-$KERNELRELEASE /boot/System.map-$KERNELRELEASE
-	/sbin/installkernel $KERNELRELEASE /boot/.vmlinuz-$KERNELRELEASE-rpm /boot/.System.map-$KERNELRELEASE-rpm
-	rm -f /boot/.vmlinuz-$KERNELRELEASE-rpm /boot/.System.map-$KERNELRELEASE-rpm
+	if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
+	cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
+	cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
+	rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
+	/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+	rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
 	fi
 
 	%preun
 	if [ -x /sbin/new-kernel-pkg ]; then
-	new-kernel-pkg --remove $KERNELRELEASE --rminitrd --initrdfile=/boot/initramfs-$KERNELRELEASE.img
+	new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
 	elif [ -x /usr/bin/kernel-install ]; then
-	kernel-install remove $KERNELRELEASE
+	kernel-install remove %{KERNELRELEASE}
 	fi
 
 	%postun
 	if [ -x /sbin/update-bootloader ]; then
-	/sbin/update-bootloader --remove $KERNELRELEASE
+	/sbin/update-bootloader --remove %{KERNELRELEASE}
 	fi
 
 	%files
 	%defattr (-, root, root)
-$M	/lib/modules/$KERNELRELEASE
-$M	%exclude /lib/modules/$KERNELRELEASE/build
-$M	%exclude /lib/modules/$KERNELRELEASE/source
+$M	/lib/modules/%{KERNELRELEASE}
+$M	%exclude /lib/modules/%{KERNELRELEASE}/build
+$M	%exclude /lib/modules/%{KERNELRELEASE}/source
 	/boot/*
 
 	%files headers
@@ -154,7 +155,7 @@ $M	%exclude /lib/modules/$KERNELRELEASE/source
 $S$M
 $S$M	%files devel
 $S$M	%defattr (-, root, root)
-$S$M	/usr/src/kernels/$KERNELRELEASE
-$S$M	/lib/modules/$KERNELRELEASE/build
-$S$M	/lib/modules/$KERNELRELEASE/source
+$S$M	/usr/src/kernels/%{KERNELRELEASE}
+$S$M	/lib/modules/%{KERNELRELEASE}/build
+$S$M	/lib/modules/%{KERNELRELEASE}/source
 EOF
-- 
2.39.2

