Return-Path: <linux-kernel+bounces-102769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD987B71A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D504C284BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49F8F58;
	Thu, 14 Mar 2024 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGn8WO7P"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC438BE5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390457; cv=none; b=Kv1caF6zMKqGShz0Q/HYcSkN4N8NMVB3A72RngodZu4B0jPlMebXNYOG/apCaK221YZzMLh01nnfMtXWRmYUMyYx2DFBUjyTE4gg43+abGaBsozeTp4RvH2lnd3Q6z9hkgw10/GAd1V+buxl4neuc/hfa1eJ6ULIvty3yZxs2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390457; c=relaxed/simple;
	bh=JKNjXwrEAhTcPx0IcTiV0urqEE4apMQabqJ3HGrQyjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUNC2bSZIIy0gJzFUnzDCx3qMy5+s2dVlXEbzd6YI1uMj9yG/0t7GMaZH45MSX8+UA1oEu0ABkcoKVEIl0e5baCEejAwh39rMX1ZIpR1Ufdn2u3Zr+InRKuAd6DHzNzo6lCavPSYYnYt6PRq53l3b6+Niczry/b043lDh9qiejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IGn8WO7P; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso440321a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710390455; x=1710995255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cTJjdrBktqdx3YztHJVlXtN8MmvjL+jR5a4blf9J9E=;
        b=IGn8WO7PAJQCBmbvp4ZHz5ZIcXTGrFH3Fs8Iej3Kc9WsigNQmCL5uxPq8AOgtAeEDD
         O2MuKnxnVJ/+r147mLyL0jlWCr8wcoFRbnbrvC6K2kAZ+R1MsJ8+mrxoyPoQ3tbvbwfu
         /hE52UP7shXH4B0aER5RxnCjMg3YGabGDc0FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710390455; x=1710995255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cTJjdrBktqdx3YztHJVlXtN8MmvjL+jR5a4blf9J9E=;
        b=YqChy7z1ZmMXMiakS6Xjz+KYqHwfWwa8ThFyyfC4Vq3eQ+B1N7WMNzEDmeWH17kmPe
         KDMyzPProKAFFZuLzeO0SNo0c8jgC2uDOAHJlm41zt7qsjsl3TGxnGyC8pEKTxrE7N0j
         fj9NH16IMIH/O4FlsUnDCkBFCdfdFjPiicNwfcqNEkkJRIMPzzw/ow5YU47cEVbuuLQW
         n5DWM8FbNweMK8ricZ5MgedvytHHJm+jkmHVf8gpz//WvEJatQLk8/SbqASyuFMZh5Ag
         Va7j3bUbrHwPAXhN+Gj/avwXAdXwf02VSmfY9GMG+aOR3KaDqiFZLjduYRNmNSrVT+ia
         308A==
X-Forwarded-Encrypted: i=1; AJvYcCUKQuJ53kDOBSu1x560AMV8sFeShUJq2I6X/18Ij1rd/Ipd/uPYAaTtInwfe8NJPIHxRWpS+YVoZymywnJn+VfBm4kOFMEUgfkjMtDN
X-Gm-Message-State: AOJu0YwQprsRdbHDMVt+sXoTv9p5kFgmNGnIqcZ1n4FDrdIRPS9KUPYJ
	UIsYR3Utv989FvUhMXCtTKnVEyf/DBrM3vESG8H6moZRIyb5GOitzYu7zBpUZA==
X-Google-Smtp-Source: AGHT+IE2GvvqiEZuSI45BF1+iK8kMRqs1IBhTbrrI1bwGMdn+msU9RP/ADvzi87321MQZrj02GGl6A==
X-Received: by 2002:a05:6a21:3990:b0:1a1:49e9:805f with SMTP id ad16-20020a056a21399000b001a149e9805fmr1085141pzc.35.1710390455654;
        Wed, 13 Mar 2024 21:27:35 -0700 (PDT)
Received: from chromium.org ([118.149.78.37])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001dd98195371sm479200plh.181.2024.03.13.21.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:27:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: [PATCH v11 0/2] arm64: Add a build target for Flat Image Tree
Date: Thu, 14 Mar 2024 17:26:57 +1300
Message-Id: <20240314042659.232142-1-sjg@chromium.org>
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
 scripts/Makefile.lib              |  15 ++
 scripts/make_fit.py               | 290 ++++++++++++++++++++++++++++++
 7 files changed, 336 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.34.1


