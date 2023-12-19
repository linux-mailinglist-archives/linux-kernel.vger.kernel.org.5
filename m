Return-Path: <linux-kernel+bounces-5525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA53B818BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6929B286EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A31CF9C;
	Tue, 19 Dec 2023 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD7jof4r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FC1D133
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703001435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bA0rWbgQnctRs+jPodqQaIsJ8wyX5O5TT/EwQR+FiA=;
	b=SD7jof4r5VsQaTffABS8C42RulA07FyhYePFsRjyCf7H/iRMQzBt0oczd3B8YYWLkNDV3T
	do7ThBOjHek0kRVaxRjKKhpdn2WIvR+aGp55yvqX72glLD6Wu7nKgPiGSGoyo/J0KBKc7U
	Mn9WU6CqdInxlz3MI2EywZV8H03BQ5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-WLlpUzjFNi-2Mn7jzOTcKA-1; Tue, 19 Dec 2023 10:57:12 -0500
X-MC-Unique: WLlpUzjFNi-2Mn7jzOTcKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA6338A67E0;
	Tue, 19 Dec 2023 15:57:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FD66C1596E;
	Tue, 19 Dec 2023 15:57:08 +0000 (UTC)
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
Subject: [PATCH v3] rpm-pkg: simplify installkernel %post
Date: Tue, 19 Dec 2023 16:56:59 +0100
Message-ID: <20231219155659.1591792-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
References: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

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
more complete. Suitable manual actions are added as a default if tool is not
present (unusual).

Special installation case for discontinued architecture ia64 has been
removed.

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

 scripts/package/kernel.spec | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..17e7196c9be1 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -55,18 +55,12 @@ patch -p1 < %{SOURCE2}
 %{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
 
 %install
-mkdir -p %{buildroot}/boot
-%ifarch ia64
-mkdir -p %{buildroot}/boot/efi
-cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-%{KERNELRELEASE}
-ln -s efi/vmlinuz-%{KERNELRELEASE} %{buildroot}/boot/
-%else
-cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
-%endif
+mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
+cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEASE}/vmlinuz
 %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
-cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
-cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
+cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
+cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}
 ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
@@ -76,12 +70,12 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 rm -rf %{buildroot}
 
 %post
-if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
-cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
-cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
-/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+if [ -x /usr/bin/kernel-install ]; then
+kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
+else
+cp /lib/modules/%{KERNELRELEASE}/vmlinuz /boot/vmlinuz-%{KERNELRELEASE}
+cp /lib/modules/%{KERNELRELEASE}/System.map /boot/System.map-%{KERNELRELEASE}
+cp /lib/modules/%{KERNELRELEASE}/config /boot/config-%{KERNELRELEASE}
 fi
 
 %preun
@@ -100,7 +94,6 @@ fi
 %defattr (-, root, root)
 /lib/modules/%{KERNELRELEASE}
 %exclude /lib/modules/%{KERNELRELEASE}/build
-/boot/*
 
 %files headers
 %defattr (-, root, root)
-- 
2.43.0


