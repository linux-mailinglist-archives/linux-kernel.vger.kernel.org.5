Return-Path: <linux-kernel+bounces-166382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D288B99E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A76284537
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949B65194;
	Thu,  2 May 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XBPQRvcj"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968A64CE1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648587; cv=none; b=Ge9UCPUETQredf5M0TUocn8DSMEbAT2QOdTeCALJVmRESWPBJ50pR7qdmxgg0XifB+geQbcZw6CDzHkRV0/tKK8lWpM3oezo0garRTK+2LAF+4g1qMenPr+nmygB4wUeQbcdaDXSB6SpMNUlR4OpemQ1ohhANV1Ow631jorVia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648587; c=relaxed/simple;
	bh=jAfPxDaZQf+Z3EoMBa2T7YQWg15qnOSgj0+XC4k/BRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e88ayRY37bElMAQpF918kr3fbmJNoA7Cs+VeGm2F6JuvzqXgLxkFCVRSp+vz3xP5lvFxJSPw9k8MTQOe23uHTt5v6Iq3l/NZtMI+Iackrad0yevCfEkz7QEouBzy2ybzTT4htd1QhBXEjq51T20V0CfyZdXMUlxsp9U49DasVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XBPQRvcj; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BAD223FE64
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714648582;
	bh=9viCGe21wce589SPhaLpq63lHm2lNcUSGMl+Cs89goo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=XBPQRvcjxx+qiYmBQ0T4dv8RbPvuHEe3jYPS5UXX9VLELwIHEbzpt6n+TVjYVvYz2
	 owovTOpuv8Fp3V0WZeY8gyuHgGh+s6mFwMOVVDkPCeCvYqA41XagmpRksS/yQTdc6c
	 0zYhlDX3fZFw7cCYImGYZnkWl+ZoFSJ5Kp4JSGNrtd+Ki1YuVnDngB9dTq+MNoNnB4
	 xHzAu1pZ3FysTrvQkkmsCNT6Em8D6shv3EFMWPnoOCvQKhWGCynSqpAINRa5O965Ij
	 Bq9bX7/LpUnO9p4V+31Fzw8CEShG0juj8P9h+2V8fb29BT3baDc2nEGaiJyJidZZvS
	 h9NOPNd69qJDw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4455ae71fcso420270466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 04:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648577; x=1715253377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9viCGe21wce589SPhaLpq63lHm2lNcUSGMl+Cs89goo=;
        b=uMgPWNQBHnEGJyyj7eWrux4RIiueoJ84fIWH+rfUgEwGSWH8T8ch3RcPtwynAUoegz
         tK3Jnnikqx22J9Ig3M5UPlp5Wkl8TFB4RlLH4QA1ezzqj42NIazYC3lKT6cAIrW+2+B4
         yysHvp/hirJfA1Br/UHLs/d+Ze/8LF7eqj8cJdjwWY4/aj3cwqKzXFc6lX7oHf7TFvUF
         QE8uECJkyni9w7ND8AkIYd63Uxuy4nm/6AG16Rf7z3O+romI9sv9EVjs8hwVLwJEn1BA
         nsA4cBoOtGdWtbaXs3r5MXdGtc9TAhxQLGj/4zk1AkG9G2LFkEy0dGrKT0QRN4v5uXsi
         5IjA==
X-Forwarded-Encrypted: i=1; AJvYcCXOCGHShCPjSQGJImjF3QdH0DTG8bro3PR10PGnpdkZpohebqfT4shtSl1ejIa9hBJJ05v5wxlDpy+/0UdBh3b2eN0u2yw6ohPUtpSg
X-Gm-Message-State: AOJu0YzmlMjxZOjSf2G8RK1ABifNxhAM2Pt+CPsIIA7Ij+tTSWm1ILQq
	x8RonGZkW6iX8+Kjj+ZN5t/zCrfqqAB0EKja2R4hI/pEgyzP8wexgVbDL/KLSvjrn9gE9dHDAey
	TZxP26H6zKVnOh4p54U2bkI6Hxm6YOeAQQbF/1lUjvnHIuYQJFYvZO8OqoDwqVK3Imr2yKcV1ot
	tPHg==
X-Received: by 2002:a17:906:2555:b0:a52:19ea:8df0 with SMTP id j21-20020a170906255500b00a5219ea8df0mr1225322ejb.66.1714648577763;
        Thu, 02 May 2024 04:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Myo75XOgrFJPJUQRXhMKXEEwYehp1jVRMzzcbJCBYoh68rOqDmHMkFSk+66SPyDzmCEKDA==
X-Received: by 2002:a17:906:2555:b0:a52:19ea:8df0 with SMTP id j21-20020a170906255500b00a5219ea8df0mr1225308ejb.66.1714648577553;
        Thu, 02 May 2024 04:16:17 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b00a4739efd7cesm437278ejb.60.2024.05.02.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:16:17 -0700 (PDT)
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
Subject: [PATCH v1 2/3] riscv: show help string for riscv-specific targets
Date: Thu,  2 May 2024 13:16:07 +0200
Message-ID: <20240502111613.1380453-3-emil.renner.berthing@canonical.com>
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

Define the archhelp variable so that 'make ACRH=riscv help' will show
the targets specific to building a RISC-V kernel like other
architectures.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 29be676415d6..024482c68835 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -202,3 +202,20 @@ rv32_defconfig:
 PHONY += rv32_nommu_virt_defconfig
 rv32_nommu_virt_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
+
+define archhelp
+  echo  '  Image		- Uncompressed kernel image (arch/riscv/boot/Image)'
+  echo  '  Image.gz	- Compressed kernel image (arch/riscv/boot/Image.gz)'
+  echo  '  Image.bz2	- Compressed kernel image (arch/riscv/boot/Image.bz2)'
+  echo  '  Image.lz4	- Compressed kernel image (arch/riscv/boot/Image.lz4)'
+  echo  '  Image.lzma	- Compressed kernel image (arch/riscv/boot/Image.lzma)'
+  echo  '  Image.lzo	- Compressed kernel image (arch/riscv/boot/Image.lzo)'
+  echo  '  Image.zst	- Compressed kernel image (arch/riscv/boot/Image.zst)'
+  echo  '  vmlinuz.efi	- Compressed EFI kernel image (arch/riscv/boot/vmlinuz.efi)'
+  echo  '		  Default when CONFIG_EFI_ZBOOT=y'
+  echo  '  xipImage	- Execute-in-place kernel image (arch/riscv/boot/xipImage)'
+  echo  '		  Default when CONFIG_XIP_KERNEL=y'
+  echo  '  install	- Install kernel using (your) ~/bin/$(INSTALLKERNEL) or'
+  echo  '		  (distribution) /sbin/$(INSTALLKERNEL) or install to '
+  echo  '		  $$(INSTALL_PATH)'
+endef
-- 
2.43.0


