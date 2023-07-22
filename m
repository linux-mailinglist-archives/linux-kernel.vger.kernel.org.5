Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB03875D9D1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGVEuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGVEtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4844A1;
        Fri, 21 Jul 2023 21:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7636C60A6C;
        Sat, 22 Jul 2023 04:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD068C433C8;
        Sat, 22 Jul 2023 04:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001316;
        bh=NT0kaGdVcDkf3Tf23ZkMpp/DO44gWUS13edWnkYlR2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+aSlyjToYXtheC2p6VwUCmfU15sN1l1GZRkWsTxpen+OqEQfr/vJ8wD8w84MDDjr
         N7K6JmHwy/4knNRVNErib5uqLZ28LlY1E4kCADbP545H0QWuytd1BTM/IaSsDNTyDj
         U7euh/YeVV2FfiZxaRekHKIzR+nTDkOf62+l5thgJPxMNOpB/sO+Ts3J4Q4b3kD00m
         wvpg0d+Y9UFaIugbIMUW6cbGFaseR0Mlhq9A8DOqBdpgxL5s8DkrEnFboeFUfz09DD
         KPkGObUcrUPA4/HW9eMSmnbuQk4wKOvorJ6+Ior+j+k0Ke3daopuSlFXMraXd0g/vG
         lAjI02GAsW+hA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 15/19] kbuild: rpm-pkg: split out the body of spec file
Date:   Sat, 22 Jul 2023 13:48:02 +0900
Message-Id: <20230722044806.3867434-15-masahiroy@kernel.org>
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

Most of the lines in the spec file are independent of any build
condition.

Split the body of the spec file into scripts/package/kernel.spec.
scripts/package/mkspec will prepend some env-dependent variables.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/kernel.spec | 117 ++++++++++++++++++++++++++++++++++
 scripts/package/mkspec      | 123 +-----------------------------------
 2 files changed, 120 insertions(+), 120 deletions(-)
 create mode 100644 scripts/package/kernel.spec

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
new file mode 100644
index 000000000000..ac3f2ee6d7a0
--- /dev/null
+++ b/scripts/package/kernel.spec
@@ -0,0 +1,117 @@
+# _arch is undefined if /usr/lib/rpm/platform/*/macros was not included.
+%{!?_arch: %define _arch dummy}
+%{!?make: %define make make}
+%define makeflags %{?_smp_mflags} ARCH=%{ARCH}
+%define __spec_install_post /usr/lib/rpm/brp-compress || :
+%define debug_package %{nil}
+
+Name: kernel
+Summary: The Linux Kernel
+Version: %(echo %{KERNELRELEASE} | sed -e 's/-/_/g')
+Release: %{pkg_release}
+License: GPL
+Group: System Environment/Kernel
+Vendor: The Linux Community
+URL: https://www.kernel.org
+Source0: linux.tar.gz
+Source1: config
+Source2: diff.patch
+Provides: kernel-%{KERNELRELEASE}
+BuildRequires: bc binutils bison dwarves
+BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
+BuildRequires: gcc make openssl openssl-devel perl python3 rsync
+
+%description
+The Linux Kernel, the operating system core itself
+
+%package headers
+Summary: Header files for the Linux kernel for use by glibc
+Group: Development/System
+Obsoletes: kernel-headers
+Provides: kernel-headers = %{version}
+%description headers
+Kernel-headers includes the C header files that specify the interface
+between the Linux kernel and userspace libraries and programs.  The
+header files define structures and constants that are needed for
+building most standard programs and are also needed for rebuilding the
+glibc package.
+
+%if %{with_devel}
+%package devel
+Summary: Development package for building kernel modules to match the %{version} kernel
+Group: System Environment/Kernel
+AutoReqProv: no
+%description -n kernel-devel
+This package provides kernel headers and makefiles sufficient to build modules
+against the %{version} kernel package.
+%endif
+
+%prep
+%setup -q -n linux
+cp %{SOURCE1} .config
+patch -p1 < %{SOURCE2}
+
+%build
+%{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
+
+%install
+mkdir -p %{buildroot}/boot
+%ifarch ia64
+mkdir -p %{buildroot}/boot/efi
+cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-%{KERNELRELEASE}
+ln -s efi/vmlinuz-%{KERNELRELEASE} %{buildroot}/boot/
+%else
+cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
+%endif
+%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
+%{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
+cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
+cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
+ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
+ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
+%if %{with_devel}
+%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
+%endif
+
+%clean
+rm -rf %{buildroot}
+
+%post
+if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
+cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
+cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
+rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
+/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+fi
+
+%preun
+if [ -x /sbin/new-kernel-pkg ]; then
+new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
+elif [ -x /usr/bin/kernel-install ]; then
+kernel-install remove %{KERNELRELEASE}
+fi
+
+%postun
+if [ -x /sbin/update-bootloader ]; then
+/sbin/update-bootloader --remove %{KERNELRELEASE}
+fi
+
+%files
+%defattr (-, root, root)
+/lib/modules/%{KERNELRELEASE}
+%exclude /lib/modules/%{KERNELRELEASE}/build
+%exclude /lib/modules/%{KERNELRELEASE}/source
+/boot/*
+
+%files headers
+%defattr (-, root, root)
+/usr/include
+
+%if %{with_devel}
+%files devel
+%defattr (-, root, root)
+/usr/src/kernels/%{KERNELRELEASE}
+/lib/modules/%{KERNELRELEASE}/build
+/lib/modules/%{KERNELRELEASE}/source
+%endif
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 511cae46a90d..c08567ae7fb1 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -23,127 +23,10 @@ else
 echo '%define with_devel 0'
 fi
 
-cat<<-EOF
+cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
 %define pkg_release $("${srctree}/init/build-version")
-
-# _arch is undefined if /usr/lib/rpm/platform/*/macros was not included.
-%{!?_arch: %define _arch dummy}
-%{!?make: %define make make}
-%define makeflags %{?_smp_mflags} ARCH=%{ARCH}
-
-	Name: kernel
-	Summary: The Linux Kernel
-	Version: %(echo %{KERNELRELEASE} | sed -e 's/-/_/g')
-	Release: %{pkg_release}
-	License: GPL
-	Group: System Environment/Kernel
-	Vendor: The Linux Community
-	URL: https://www.kernel.org
-	Source0: linux.tar.gz
-	Source1: config
-	Source2: diff.patch
-	Provides: kernel-%{KERNELRELEASE}
-	BuildRequires: bc binutils bison dwarves
-	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
-	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
-
-	%define __spec_install_post /usr/lib/rpm/brp-compress || :
-	%define debug_package %{nil}
-
-	%description
-	The Linux Kernel, the operating system core itself
-
-	%package headers
-	Summary: Header files for the Linux kernel for use by glibc
-	Group: Development/System
-	Obsoletes: kernel-headers
-	Provides: kernel-headers = %{version}
-	%description headers
-	Kernel-headers includes the C header files that specify the interface
-	between the Linux kernel and userspace libraries and programs.  The
-	header files define structures and constants that are needed for
-	building most standard programs and are also needed for rebuilding the
-	glibc package.
-
-	%if %{with_devel}
-	%package devel
-	Summary: Development package for building kernel modules to match the %{version} kernel
-	Group: System Environment/Kernel
-	AutoReqProv: no
-	%description -n kernel-devel
-	This package provides kernel headers and makefiles sufficient to build modules
-	against the %{version} kernel package.
-	%endif
-
-	%prep
-	%setup -q -n linux
-	cp %{SOURCE1} .config
-	patch -p1 < %{SOURCE2}
-
-	%build
-	%{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
-
-	%install
-	mkdir -p %{buildroot}/boot
-	%ifarch ia64
-	mkdir -p %{buildroot}/boot/efi
-	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-%{KERNELRELEASE}
-	ln -s efi/vmlinuz-%{KERNELRELEASE} %{buildroot}/boot/
-	%else
-	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
-	%endif
-	%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
-	%{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
-	cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
-	cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
-	ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
-	ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
-	%if %{with_devel}
-	%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='\${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
-	%endif
-
-	%clean
-	rm -rf %{buildroot}
-
-	%post
-	if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
-	cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
-	cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
-	rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
-	/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-	rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-	fi
-
-	%preun
-	if [ -x /sbin/new-kernel-pkg ]; then
-	new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
-	elif [ -x /usr/bin/kernel-install ]; then
-	kernel-install remove %{KERNELRELEASE}
-	fi
-
-	%postun
-	if [ -x /sbin/update-bootloader ]; then
-	/sbin/update-bootloader --remove %{KERNELRELEASE}
-	fi
-
-	%files
-	%defattr (-, root, root)
-	/lib/modules/%{KERNELRELEASE}
-	%exclude /lib/modules/%{KERNELRELEASE}/build
-	%exclude /lib/modules/%{KERNELRELEASE}/source
-	/boot/*
-
-	%files headers
-	%defattr (-, root, root)
-	/usr/include
-
-	%if %{with_devel}
-	%files devel
-	%defattr (-, root, root)
-	/usr/src/kernels/%{KERNELRELEASE}
-	/lib/modules/%{KERNELRELEASE}/build
-	/lib/modules/%{KERNELRELEASE}/source
-	%endif
 EOF
+
+cat "${srctree}/scripts/package/kernel.spec"
-- 
2.39.2

