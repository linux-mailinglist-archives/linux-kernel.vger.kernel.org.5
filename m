Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E397FDE39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjK2RWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjK2RWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:22:42 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD9910A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:22:48 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35ca48d48d6so2979545ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701278568; x=1701883368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmMU4E/b+uSxcWr7/YV1tz9g4DZ7LEAYA6oOOjTn5rY=;
        b=OSOyCY5PTnD9nka1J7K7FbnbTgHQNbJPJRVEJygwmvVTLR11rIB9FVTzQUc7ein4MP
         /RMZkKMn6A4l4Bbu6FLAuIABOZdFJvq5FnhqreqWQOR4CdUPdTS4D8moX5OUmE10dbig
         GqBtzMCvvXOnvzq/oKrNUkanKYcqNMTZyu0iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278568; x=1701883368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmMU4E/b+uSxcWr7/YV1tz9g4DZ7LEAYA6oOOjTn5rY=;
        b=veaaeIE4myU7zuXN+uZLFKThfqRxA9czvseV8aT0ggZ1zTYd6133YFL0KIyrVf49MQ
         PFHSGgP9Zv/uea1r+5s57T5aKySof50MWedFv9UBJFkh6Nyc19mdTuL8Eo6cfKQP91ZC
         dECOoLX+L5K6K4VaDeB0ZPxCAsIwJqjvz9Kh+62TAX/NfUxYSdCFStUlLUEFzKm3arXh
         V74atTJ1MVYdVK/Vx5zaGNW1dDSCIRBQ8zq9zSn2+ZqM+/HUOYSaVNaBbl9FSYL332BL
         seEQ1vQmAmdO5kQe9aYH5Cdt8+HvE+vEw/BHszdTT/KZOorncVMe5IKZ2twDsDMVs9rr
         UxMA==
X-Gm-Message-State: AOJu0Yy3x9f3X+yk9ZCgPlc+qHQLO31DfY5ah+yGhNcf6MEHA4kcUXK2
        P1X3XvOPNYFj6v5Byv1ZAj8k8g==
X-Google-Smtp-Source: AGHT+IGBxziXrcPo8J6ti14stg5UnqZ33EBytnwprKYBbSzdEFUFDixLcVYV2vqJhDc547Ifaf7fVQ==
X-Received: by 2002:a05:6e02:1c88:b0:35c:c82c:c79c with SMTP id w8-20020a056e021c8800b0035cc82cc79cmr9781849ill.7.1701278567855;
        Wed, 29 Nov 2023 09:22:47 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:f4fd:5056:45a8:b749])
        by smtp.gmail.com with ESMTPSA id di5-20020a056e021f8500b0035d2fc4ce47sm471212ilb.9.2023.11.29.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:22:47 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH v7 0/2] arm64: Add a build target for Flat Image Tree
Date:   Wed, 29 Nov 2023 10:21:51 -0700
Message-ID: <20231129172200.430674-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The series also includes a few minor clean-up patches.

[1] https://github.com/open-source-firmware/flat-image-tree

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

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |  13 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  13 ++
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 326 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.43.0.rc2.451.g8631bc7472-goog

