Return-Path: <linux-kernel+bounces-25415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CA182CFF5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32291F21D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37681C10;
	Sun, 14 Jan 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDnN7VuE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743381860
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705219622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0s0Hjd145psVg+vyp1j2biOKXfWkJ5AMOPdt7wW0Ns=;
	b=EDnN7VuElOXFSXJDXOemZPs7rMZxKFD+rM1iXA/fysWSkxVTGuNfEnMPyKKTRdc9YC4Gb0
	vVpsg+/m7lGLRAGUvcdVpGrPxivQN3TypjK31um+u5zyZ9GuNPE16T4wGh04XKgI7cDQnC
	D8cEyEl57DpoRiYcG30lFaqs5aeElGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-HUToJckrPciSCawYaglI-A-1; Sun, 14 Jan 2024 03:06:57 -0500
X-MC-Unique: HUToJckrPciSCawYaglI-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D9385A588;
	Sun, 14 Jan 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCC3E2166B31;
	Sun, 14 Jan 2024 08:06:53 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: masahiroy@kernel.org
Cc: dcavalca@meta.com,
	jtornosm@redhat.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	stable@vger.kernel.org
Subject: [PATCH V5 1/2] rpm-pkg: simplify installkernel %post
Date: Sun, 14 Jan 2024 09:06:44 +0100
Message-ID: <20240114080644.5086-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNAR_wgQBs-q9NH1icb_FPBoVMNEhQpvV8qzH2dFsrDS0pQ@mail.gmail.com>
References: <CAK7LNAR_wgQBs-q9NH1icb_FPBoVMNEhQpvV8qzH2dFsrDS0pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The new installkernel application that is now included in systemd-udev
package allows installation although destination files are already present
in the boot directory of the kernel package, but is failing with the
implemented workaround for the old installkernel application from grubby
package.

For the new installkernel application, as Davide says:
<<The %post currently does a shuffling dance before calling installkernel.
This isn't actually necessary afaict, and the current implementation
ends up triggering downstream issues such as
https://github.com/systemd/systemd/issues/29568
This commit simplifies the logic to remove the shuffling. For reference,
the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
section to create initramfs and grub hooks").>>

But we need to keep the old behavior as well, because the old installkernel
application from grubby package, does not allow this simplification and
we need to be backward compatible to avoid issues with the different
packages.

Mimic Fedora shipping process and store vmlinuz, config amd System.map
in the module directory instead of the boot directory. In this way, we will
avoid the commented problem for all the cases, because the new destination
files are not going to exist in the boot directory of the kernel package.

Replace installkernel tool with kernel-install tool, because the latter is
more complete.

Besides, after installkernel tool execution, check to complete if suitable
(same release and build) vmlinuz, System.map and config files are present
in /boot directory, and if necessary, copy manually for install operation
or remmove manually for remove operation.

Tested with Fedora 38, Fedora 39, RHEL 9, Oracle Linux 9.3,
openSUSE Tumbleweed and openMandrive ROME, using dnf/zypper and rpm tools.

cc: stable@vger.kernel.org
Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Complete to be backward compatible with the previous installkernel
application.
V2 -> V3:
- Follow the suggestions from Masahiro Yamada and change the installation
destination to avoid problems instead of checking the package.
V3 -> V4:
- Make the patch applicable to linux-kbuild/for-next (ia64 support was
already removed).
V4 -> V5:
- Complete for other Linux distributions.

 scripts/package/kernel.spec | 39 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 89298983a169..74542af8cbfe 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -55,12 +55,12 @@ patch -p1 < %{SOURCE2}
 %{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
 
 %install
-mkdir -p %{buildroot}/boot
-cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
+mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
+cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEASE}/vmlinuz
 %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
-cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
-cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
+cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
+cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
 ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
@@ -70,19 +70,35 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 rm -rf %{buildroot}
 
 %post
-if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
-cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
-cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
-/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+if [ -x /usr/bin/kernel-install ]; then
+/usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
 fi
+if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{KERNELRELEASE} | grep -q " #%{release} "; then
+release_match=0
+else
+release_match=1
+fi
+for file in vmlinuz System.map config; do
+if [ ! -e /boot/${file}-%{KERNELRELEASE} ] || [ ${release_match} != 0 ]; then
+cp -v /lib/modules/%{KERNELRELEASE}/${file} /boot/${file}-%{KERNELRELEASE}
+fi
+done
 
 %preun
 if [ -x /sbin/new-kernel-pkg ]; then
 new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
 elif [ -x /usr/bin/kernel-install ]; then
-kernel-install remove %{KERNELRELEASE}
+/usr/bin/kernel-install remove %{KERNELRELEASE}
+if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{KERNELRELEASE} | grep -q " #%{release} "; then
+release_match=0
+else
+release_match=1
+fi
+for file in vmlinuz System.map config; do
+if [ -e /boot/${file}-%{KERNELRELEASE} ] && [ ${release_match} == 0 ]; then
+rm -v /boot/${file}-%{KERNELRELEASE}
+fi
+done
 fi
 
 %postun
@@ -94,7 +110,6 @@ fi
 %defattr (-, root, root)
 /lib/modules/%{KERNELRELEASE}
 %exclude /lib/modules/%{KERNELRELEASE}/build
-/boot/*
 
 %files headers
 %defattr (-, root, root)
-- 
2.43.0


