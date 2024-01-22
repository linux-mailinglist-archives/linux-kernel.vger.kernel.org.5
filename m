Return-Path: <linux-kernel+bounces-33978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137CE83713D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE15290E42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F44CB25;
	Mon, 22 Jan 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="As7hIR4G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEE4C62E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947787; cv=none; b=ZjUiye3/tpMQd3y41iXgLai7ejIH/sU3gBZHfT/6CRWZPibvDj6HyjePKCtQ+ObBGGcEN8gMmonlpZnOQ0Ty6JpVn8cOCCBpuHWZTnchaQgS9ourlCvQiyCBZqpzUf/fETzCAQ/Cf8g6ckqE7JgOHSg0x6IOZsEAcjyZ6kKEFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947787; c=relaxed/simple;
	bh=MEW5d+779EpaSh3J+cQL13xl8RKqWQdYIyKAMo1f1B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRjrb+duxAQEjiSaD8p5ZXtwSPDBDtde6vIENW7DgCudZKdG+Ga7l4vJX3FkagBKUc+k8KhE1AUwzDgScVJ8mXgEkzB6R2FeQD9u2tY+5cSj4zS250Da0/BYx/ONq+k8O4tkbm6vYVNidAd9tyQdzCaY+xcfX4weQMp2/yLGRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=As7hIR4G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705947785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+h+8Ws5ampbuVbsEr/yuuau7lwHpAgGkopNi0+tbUU=;
	b=As7hIR4GQFN7cHX8yyg+ql/zTc1r9ic10uUGGYCPYzlfsXEHWHclW6Ujza6Oi/HhUl8LIa
	EXW6bQq2j2kn9PGOA22l9B2o6/2fYebL7lJNCBpArw+li2BHD2hbKIsq60HMqQlSeQ96mm
	/l7iqgVrt90rOPv/TRDKWA342bO4SyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-76xy8_G0PYmiHLAn6641xg-1; Mon, 22 Jan 2024 13:23:01 -0500
X-MC-Unique: 76xy8_G0PYmiHLAn6641xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768E885A588;
	Mon, 22 Jan 2024 18:23:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.175])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCEED1C060AF;
	Mon, 22 Jan 2024 18:22:57 +0000 (UTC)
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
Subject: [PATCH] rpm-pkg: simplify installkernel %post
Date: Mon, 22 Jan 2024 19:22:53 +0100
Message-ID: <20240122182253.17973-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
References: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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

Besides, after installkernel tool execution, check to complete if the
correct package files vmlinuz, System.map and config files are present
in /boot directory, and if necessary, copy manually for install operation.
In this way, take into account if  files were not previously copied from
/usr/lib/kernel/install.d/* scripts and if the suitable files for the
requested package are present (it could be others if the rpm files were
replace with a new pacakge with the same release and a different build).

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
V5 -> V6
- Simplify and do more compatible checks when copied files wants to be
  replaced.
- Remove %preun because it will be better done with another patch.
- Add indentation and quotation

 scripts/package/kernel.spec | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 89298983a169..0bff257ec3d4 100644
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
@@ -70,31 +70,31 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 rm -rf %{buildroot}
 
 %post
-if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
-cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
-cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
-/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+if [ -x /usr/bin/kernel-install ]; then
+	/usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
 fi
+for file in vmlinuz System.map config; do
+	if [ ! -e "/boot/${file}-%{KERNELRELEASE}" ] || ! cmp --silent "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"; then
+		cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"
+	fi
+done
 
 %preun
 if [ -x /sbin/new-kernel-pkg ]; then
-new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
+	new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
 elif [ -x /usr/bin/kernel-install ]; then
-kernel-install remove %{KERNELRELEASE}
+	/usr/bin/kernel-install remove %{KERNELRELEASE}
 fi
 
 %postun
 if [ -x /sbin/update-bootloader ]; then
-/sbin/update-bootloader --remove %{KERNELRELEASE}
+	/sbin/update-bootloader --remove %{KERNELRELEASE}
 fi
 
 %files
 %defattr (-, root, root)
 /lib/modules/%{KERNELRELEASE}
 %exclude /lib/modules/%{KERNELRELEASE}/build
-/boot/*
 
 %files headers
 %defattr (-, root, root)
-- 
2.43.0


