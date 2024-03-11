Return-Path: <linux-kernel+bounces-99234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1F878561
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7551C20854
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D052F78;
	Mon, 11 Mar 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGDJp4YW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F857860
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174172; cv=none; b=JpCilcJUt4KCREBWXHu7xjb+JUP4xtjC/9bBt3yjsnwnfT2u2/nGnw0hSG4iTmuVWHt7jOczi5JeEI0w3E9KvRgM1WltRcLfS3p7qc+4AIYip0ugBXiyoYwrPkvppcweba1iZVeFUfyufW2KoEQszY/NVt396Nz0++F8RnT7ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174172; c=relaxed/simple;
	bh=XDSfURSGPZgQfIxvmCYz/Kgu4M5nZACxndhVTEc5lX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDpFDWDGqBaxePHsrsJsYbCf+Ny5R5A5DrKI34rQTWcVSaU6a4BD+f1acLKwvx7JLyl6hNykoR2BxMuXKO3ps0O2qYSIXfWrRyTEF1Quwfg+4XtUREND4GCVL10bcDm28j5eKWAEyJzAggMRHwlEIoShee53m+5BonRdbwXpr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGDJp4YW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710174169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wu/GbQyAsTJ6iD1A5pIHTBnraO749TaX6tIRLxu4AAg=;
	b=MGDJp4YWF7/WtAiMsGiYxoDHiHx53zhvqqBeBjcPjSV+Io5WjL40jwoTV3i+Z25IDkuXvU
	h8oKtVIq9WbXgAnVFg4y9J38RqWOeEg5O25QxeE42tjorkKFTUVUf6TxoXT2Vj2ld948GC
	xYrXY5Ms2ZxsUVgo2ej04GLFeQHNXh8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-FtzkMTugM7yRDbMnUa55uw-1; Mon,
 11 Mar 2024 12:22:46 -0400
X-MC-Unique: FtzkMTugM7yRDbMnUa55uw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E2B71C006AA;
	Mon, 11 Mar 2024 16:22:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C331E492B14;
	Mon, 11 Mar 2024 16:22:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: masahiroy@kernel.org
Cc: jtornosm@redhat.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu
Subject: [PATCH V2] kbuild: rpm-pkg: add dtb files in kernel rpm
Date: Mon, 11 Mar 2024 17:22:38 +0100
Message-ID: <20240311162238.1761147-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNAQ6_kr0Q1RB0dELiGUObFJ4HEEu3XTErGf6FaNntKMnTg@mail.gmail.com>
References: <CAK7LNAQ6_kr0Q1RB0dELiGUObFJ4HEEu3XTErGf6FaNntKMnTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Some architectures, like aarch64 ones, need a dtb file to configure the
hardware. The default dtb file can be preloaded from u-boot, but the final
and/or more complete dtb file needs to be able to be loaded later from
rootfs.

Add the possible dtb files to the kernel rpm and mimic Fedora shipping
process, storing the dtb files in the module directory. These dtb files
will be copied to /boot directory by the install scripts, but add fallback
just in case, checking if the content in /boot directory is correct.

Mark the files installed to /boot as %ghost to make sure they will be
removed when the package is uninstalled.

Tested with Fedora Rawhide (x86_64 and aarch64) with dnf and rpm tools.
In addition, fallback was also tested after modifying the install scripts.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Follow the suggestions from Masahiro Yamada to improve the checks and
avoid the loop to ghost the dtb files in /boot folder.

 scripts/package/kernel.spec | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c256b73cca3e..e095eb1e290e 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -61,6 +61,9 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEAS
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
 cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
+if %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='test -d ${srctree}/arch/${SRCARCH}/boot/dts' 2>/dev/null; then
+	%{make} %{makeflags} INSTALL_DTBS_PATH=%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb dtbs_install
+fi
 ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
@@ -81,6 +84,11 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 		echo "%ghost /boot/${x}-%{KERNELRELEASE}"
 	done
 
+	if [ -d "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" ];then
+		echo "/lib/modules/%{KERNELRELEASE}/dtb"
+		find "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" -printf "%%%ghost /boot/dtb-%{KERNELRELEASE}/%%P\n"
+	fi
+
 	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
 } > %{buildroot}/kernel.list
 
@@ -96,6 +104,11 @@ for file in vmlinuz System.map config; do
 		cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"
 	fi
 done
+if [ -d "/lib/modules/%{KERNELRELEASE}/dtb" ] && \
+   ! diff -rq "/lib/modules/%{KERNELRELEASE}/dtb" "/boot/dtb-%{KERNELRELEASE}" >/dev/null 2>&1; then
+	rm -rf "/boot/dtb-%{KERNELRELEASE}"
+	cp -r "/lib/modules/%{KERNELRELEASE}/dtb" "/boot/dtb-%{KERNELRELEASE}"
+fi
 if [ ! -e "/lib/modules/%{KERNELRELEASE}/modules.dep" ]; then
 	/usr/sbin/depmod %{KERNELRELEASE}
 fi
-- 
2.44.0


