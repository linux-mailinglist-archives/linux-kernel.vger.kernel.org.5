Return-Path: <linux-kernel+bounces-166383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44918B99E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6542F1F2450E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A469944;
	Thu,  2 May 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fKx7hk+U"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8264CFC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648588; cv=none; b=dngQmLG9zDWgFyjAiBjblfxpJXxGptKCaoYn2llKe4393/hpDNhS1JFuES9JXE1BbPwsCFoci/xVcbkkC1MLmkxpCItt753rRMkWvNrXWmb+9N5ixSHDVNaOpFN/H0iS21PZ6uHyCricSX2hgG0ek7Xl+3Xph2oAsuzfLNzHcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648588; c=relaxed/simple;
	bh=7s1M5OYDc+LWVWpSbYQemQMh9geLdoxMPq2vKB3i6UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNT7v+tAFj4OEmTl/vBQHHyVX7E1n5g19zq4yeh0mW4lui/eu6vVGMdshYSO1a+iEjqQ27U6hOqBKwrNV3N6e9VpyN7kolU1XA/KWEQfsW2c2Ey1GwgH/91kwxUbSIz5mCchrN4/SZUYFKEWVfyan2btb44H/h1/xkjMFTVPL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fKx7hk+U; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C5833FE62
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714648582;
	bh=MK9pS8zh0OAd8/YKYBCNbvjlHmkQLgxQ6JtcNKhjMOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=fKx7hk+UP9wGhEJgc+atiCRs7VgqD6FAHc/fv84q906/2uvB4SbdXpSK+RzgTvT51
	 ewdZg5HwPENzu9rAxG3cvC+20HJ/zr6KreI64U62lPHKzA+JSB3DQPlACbQerVe39n
	 uu8in9WvBW2gvTcaayYcyPnCoR2COMVYoWCLxhIIp9OaMoQk+0rDHhPTLp32rVgVTQ
	 wocEYaKZXa2VnDzg+tNJekvnJezWcjMqYJB9AKB488Ffqz9SRv6HPZdncLIkDSuUA6
	 Fo9tPNd3y7bB17M4j0HKqNMyrxredb5d6L9nmGFGKafsyZRv2ZF+h+kmQ0fLj0a5B2
	 FH5wZN5fktWTg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a592c35ac06so180905966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 04:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648577; x=1715253377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK9pS8zh0OAd8/YKYBCNbvjlHmkQLgxQ6JtcNKhjMOU=;
        b=KyW28zlPe9x0aQNX/VtxRKZ0vNVnFjbZ6JnSFLqDqz7iFQno89LQWYVY1h1Ln0SROH
         Q65givqbSEYyp7euSditKFHRIvxEra6PuRoxUS3bOmyL+lcCerLfiij2uHa/sMe5dwiw
         opey1Ol6a+nQmccIF4Voej8sV2+gz73tz9atAfq3SRJ+6Zb03WntZ9BaucH7PYGFbELQ
         oLl4lwEH+5OoiWT4M9hQnoiL2NGktNVoVfN1/61tyd3LOZlG9RobBjJ6do22ilmwQuD0
         M8piXPPpEDz6bXueBU8E4WOd4m8ciawwy9PgdDN8m7iHe2MGqiYK7hlxUcTyCHtBdQxN
         +ABg==
X-Forwarded-Encrypted: i=1; AJvYcCWiipVDof0W01bALntyt1toSV6KAj8rWtrB4MMgBWo7r59A6jVnC+YffwaiXwL5/w9+CB2o4ZRgd7frT3h9xpkDs1LfL45bodIdKmmE
X-Gm-Message-State: AOJu0YyRg0FGlDrav94sEBFhYrP68PBTB/Kytjg90SjAA9yghDv14HxK
	1jjS+KD00eg/yt1X3wa4lnNaSw4i3At+PZaAh4Tq5yAZ42mfbvIVJoh1QZDxPtO1iPLhGysRNbT
	MuWLcrxSt4rzHXhFK48q0mF7877ilq+jRnb89JRfVdIjK3NVvZrCp9rpCdoyUCcmM24k0MuQ0mm
	wbI0rwDYnd+w==
X-Received: by 2002:a17:906:248b:b0:a58:eb0d:f2a6 with SMTP id e11-20020a170906248b00b00a58eb0df2a6mr1882989ejb.31.1714648576859;
        Thu, 02 May 2024 04:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7LnYqMf09AgSTE93ChylTc81npf1nJHpjVmGmIFbInD5oUeTRsn+ecAVqhExu0Tv8wF6tLQ==
X-Received: by 2002:a17:906:248b:b0:a58:eb0d:f2a6 with SMTP id e11-20020a170906248b00b00a58eb0df2a6mr1882976ejb.31.1714648576542;
        Thu, 02 May 2024 04:16:16 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b00a4739efd7cesm437278ejb.60.2024.05.02.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:16:15 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCH v1 1/3] riscv: make image compression configurable
Date: Thu,  2 May 2024 13:16:06 +0200
Message-ID: <20240502111613.1380453-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
References: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously the build process would always set KBUILD_IMAGE to the
uncompressed Image file (unless XIP_KERNEL or EFI_ZBOOT was enabled) and
unconditionally compress it into Image.gz. However there are already
build targets for Image.bz2, Image.lz4, Image.lzma, Image.lzo and
Image.zstd, so let's make use of those, make the compression method
configurable and set KBUILD_IMAGE accordingly so that targets like
'make install' and 'make bindeb-pkg' will use the chosen image.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/Kconfig         |  7 +++++++
 arch/riscv/Makefile        | 43 ++++++++++++++++++++------------------
 arch/riscv/boot/install.sh |  9 +++++---
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..6c092d1ea7db 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -138,6 +138,13 @@ config RISCV
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_LZ4 if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_LZMA if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_LZO if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 5b3115a19852..29be676415d6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -129,11 +129,27 @@ endif
 CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
 
 # Default target when executing plain make
-boot		:= arch/riscv/boot
+boot := arch/riscv/boot
 ifeq ($(CONFIG_XIP_KERNEL),y)
 KBUILD_IMAGE := $(boot)/xipImage
+else ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
+KBUILD_IMAGE := $(boot)/loader.bin
+else ifeq ($(CONFIG_EFI_ZBOOT),y)
+KBUILD_IMAGE := $(boot)/vmlinuz.efi
+else ifeq ($(CONFIG_KERNEL_GZIP),y)
+KBUILD_IMAGE := $(boot)/Image.gz
+else ifeq ($(CONFIG_KERNEL_BZIP2),y)
+KBUILD_IMAGE := $(boot)/Image.bz2
+else ifeq ($(CONFIG_KERNEL_LZ4),y)
+KBUILD_IMAGE := $(boot)/Image.lz4
+else ifeq ($(CONFIG_KERNEL_LZMA),y)
+KBUILD_IMAGE := $(boot)/Image.lzma
+else ifeq ($(CONFIG_KERNEL_LZO),y)
+KBUILD_IMAGE := $(boot)/Image.lzo
+else ifeq ($(CONFIG_KERNEL_ZSTD),y)
+KBUILD_IMAGE := $(boot)/Image.zst
 else
-KBUILD_IMAGE	:= $(boot)/Image.gz
+KBUILD_IMAGE := $(boot)/Image
 endif
 
 libs-y += arch/riscv/lib/
@@ -153,32 +169,19 @@ endif
 vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
 
-ifneq ($(CONFIG_XIP_KERNEL),y)
-ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
-KBUILD_IMAGE := $(boot)/loader.bin
-else
-ifeq ($(CONFIG_EFI_ZBOOT),)
-KBUILD_IMAGE := $(boot)/Image.gz
-else
-KBUILD_IMAGE := $(boot)/vmlinuz.efi
-endif
-endif
-endif
-BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
+BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
 
 loader.bin: loader
-Image.gz loader vmlinuz.efi: Image
+Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader xipImage vmlinuz.efi: Image
+
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
-Image.%: Image
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-
-install: KBUILD_IMAGE := $(boot)/Image
-zinstall: KBUILD_IMAGE := $(boot)/Image.gz
+# the install target always installs KBUILD_IMAGE (which may be compressed)
+# but keep the zinstall target for compatibility with older releases
 install zinstall:
 	$(call cmd,install)
 
diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
index 4c63f3f0643d..a8df7591513a 100755
--- a/arch/riscv/boot/install.sh
+++ b/arch/riscv/boot/install.sh
@@ -17,15 +17,18 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
-if [ "$(basename $2)" = "Image.gz" ]; then
+case "${2##*/}" in
 # Compressed install
+Image.*|vmlinuz.efi)
   echo "Installing compressed kernel"
   base=vmlinuz
-else
+  ;;
 # Normal install
+*)
   echo "Installing normal kernel"
   base=vmlinux
-fi
+  ;;
+esac
 
 if [ -f $4/$base-$1 ]; then
   mv $4/$base-$1 $4/$base-$1.old
-- 
2.43.0


