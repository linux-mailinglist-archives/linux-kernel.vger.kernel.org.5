Return-Path: <linux-kernel+bounces-124085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B9891200
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F27B23479
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E42C3984A;
	Fri, 29 Mar 2024 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DXQHNkM9"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129538F87
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682946; cv=none; b=kUf6LqaFLX6v2/KcSDtD8sbaUN8l/DA/Y+X0ODV68uvwWFT20gTPGonnnmepCwsdFptsUbopgdD7E5LDZfqNaDE2p0uFDMPysWPBPsige9meOIp2QXz+aHx3JohGLYlU/E7E97nQcC2LL9ZquWcJa3nhqBa/irCt0lWBHb1hmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682946; c=relaxed/simple;
	bh=zxKmzxnSx9PjVgeDbZCPKKdWSiAMc87p77knFPKdQWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vp2KO88mEYpeh95+JfvDxLYtgp77y7fce2tquoaNwVIh+QrFzk0UgFVL8pPa3KLKtubjCmtj/ocGVStpXR1Wx2H0cf398yqCeEd/1ahkDVE8WMXZFvrYnjSL5ltmGE0G6l+rGqnJvru/Pky2Ufhih36qFdNn5lq7Urcs4Y3H3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DXQHNkM9; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36867dfe940so5477405ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711682944; x=1712287744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4UbQsk5JfCEGbuiJGPYChkxKlb06kKR5FuZVR4mueQ=;
        b=DXQHNkM9AUszNS/1MVcK8YGOP3Zhw73zLOzXEUeo7VACaMxrGFpzC/lJ48sd3omrz1
         8VtuPn6orqM1fYmFav0pk1ElipPcSOVUZYMCggIcGg1U2IcrStt3HR7J/F67qOMN5u8i
         t4jrvFOIPOHp0ruEahD5sALok3NtXxvu1A17w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682944; x=1712287744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4UbQsk5JfCEGbuiJGPYChkxKlb06kKR5FuZVR4mueQ=;
        b=NvJ/WU5EeAoB4dXQbPFFic0rDkZxyexXFQ1WFWIPfHyQJF8yGAied3uI7fIinEp01y
         QWt+rslGsIORXvAvQlp6mgWSDoQlS1kLS/92Lzuhd2DfU2yqrKnWq0IVMn/D3fClKp+s
         ZKqa49wxsJxeG3X4/D8NQ/DfPXPoWY2dzRsniUCfExsKeojzRENof88RoVKX7yK+5HAZ
         sBVybGimE/yWlYj82zuGB3rYI7GRPgv0cSMq8ACJJAXjYiSnDdjvgzoWekJO4n1Z1KjX
         NpiKCxI28stSrEyV8it/V59DJxvqjvSOkhowW7jLh8bvXJs+eDbjd0QCx1hqNjhsHjEJ
         WyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Cvla9MICcL3dkxFSmNCuTqukudHK7HV79ocIr25EjGi6QvAuUNfEUuad+Zj1p3Vg2RAvKUO2fJroO8fyNblBkegVCYdXEQRhXunc
X-Gm-Message-State: AOJu0Yy/uEifPyuuxnuT5/RTo3fcPn15UdN3HER68nxyKKrLMv73Qa/d
	xW0PAUUANeeLv0misb3ztz+kNK0LyTAwKF6kh7j9wX+t+m6FrkuKYmAix66TZHKYqud2M0Ylp/4
	=
X-Google-Smtp-Source: AGHT+IGqWxBBoE3CxFg/cl5Fd1n0LDcdDA7ZaQ+Cun7xZlmWrNgimznfOIOY+KlqexqgjDjjC38tDg==
X-Received: by 2002:a92:ca4e:0:b0:366:ab6f:f6a with SMTP id q14-20020a92ca4e000000b00366ab6f0f6amr1050509ilo.24.1711682944447;
        Thu, 28 Mar 2024 20:29:04 -0700 (PDT)
Received: from chromium.org ([75.104.105.200])
        by smtp.gmail.com with ESMTPSA id l7-20020a056e021aa700b003685b574968sm815717ilv.51.2024.03.28.20.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:29:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH v12 0/2] arm64: Add a build target for Flat Image Tree
Date: Fri, 29 Mar 2024 16:28:34 +1300
Message-Id: <20240329032836.141899-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flat Image Tree (FIT) is a widely used file format for packaging a
kernel and associated devicetree files[1]. It is not specific to any
one bootloader, as it is supported by U-Boot, coreboot, Linuxboot,
Tianocore and Barebox.

This series adds support for building a FIT as part of the kernel
build. This makes it easy to try out the kernel - just load the FIT
onto your tftp server and it will run automatically on any supported
arm64 board.

The script is written in Python, since it is easy to build a FIT using
the Python libfdt bindings. For now, no attempt is made to compress
files in parallel, so building the 900-odd files takes a while, about
6 seconds with my testing.

The series also includes a minor clean-up patch.

[1] https://github.com/open-source-firmware/flat-image-tree

Changes in v12:
- Avoid showing FIT message if V=0

Changes in v11:
- Use dtbslist file in image.fit rule
- Update cmd_fit rule as per Masahiro
- Don't mention ignoring files without a .dtb prefix
- Use argparse fromfile_prefix_chars feature
- Add a -v option and use it for output (with make V=1)
- rename srcdir to dtbs
- Use -o for the output file instead of -f

Changes in v10:
- Make use of dtbs-list file
- Mention dtbs-list and FIT_COMPRESSION
- Update copyright year
- Update cover letter to take account of an applied patch

Changes in v9:
- Move the compression control into Makefile.lib

Changes in v8:
- Drop compatible string in FDT node
- Correct sorting of MAINTAINERS to before ARM64 PORT
- Turn compress part of the make_fit.py comment in to a sentence
- Add two blank lines before parse_args() and setup_fit()
- Use 'image.fit: dtbs' instead of BUILD_DTBS var
- Use '$(<D)/dts' instead of '$(dir $<)dts'
- Add 'mkimage' details Documentation/process/changes.rst
- Allow changing the compression used
- Tweak cover letter since there is only one clean-up patch

Changes in v7:
- Drop the kbuild tag
- Add Image as a dependency of image.fit
- Drop kbuild tag
- Add dependency on dtbs
- Drop unnecessary path separator for dtbs
- Rebase to -next

Changes in v6:
- Drop the unwanted .gz suffix

Changes in v5:
- Drop patch previously applied
- Correct compression rule which was broken in v4

Changes in v4:
- Use single quotes for UIMAGE_NAME

Changes in v3:
- Drop temporary file image.itk
- Drop patch 'Use double quotes for image name'
- Drop double quotes in use of UIMAGE_NAME
- Drop unnecessary CONFIG_EFI_ZBOOT condition for help
- Avoid hard-coding "arm64" for the DT architecture

Changes in v2:
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint too-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

Simon Glass (2):
  arm64: Add BOOT_TARGETS variable
  arm64: boot: Support Flat Image Tree

 Documentation/process/changes.rst |   9 +
 MAINTAINERS                       |   7 +
 arch/arm64/Makefile               |  11 +-
 arch/arm64/boot/.gitignore        |   1 +
 arch/arm64/boot/Makefile          |   6 +-
 scripts/Makefile.lib              |  16 ++
 scripts/make_fit.py               | 290 ++++++++++++++++++++++++++++++
 7 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.34.1


