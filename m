Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10AC7E4008
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjKGN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjKGN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:26:33 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7D8F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:26:30 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-359398abeb5so21488135ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699363590; x=1699968390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/mFjd0wgmEwKVxmYgWqnXsXQMR8jMmnZxMCOKykInw=;
        b=QxzwgS9jfl6qIrlOtdRLXW2dUQ3azVnHzTIYvtV4TVlJdJh4tWQYgyKpBTsP8/746A
         dmwk0PIn6wEu8iSHGSQQUB/lgLGay/BonAObLO3CPQ8jrwgY1OQYcaluqKyIYAaJOAd0
         mH2TNXAxJ0kif2QG5s0vNGVgkStSo58t8Y2ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363590; x=1699968390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/mFjd0wgmEwKVxmYgWqnXsXQMR8jMmnZxMCOKykInw=;
        b=d7TeVdut3Pm2PXN4iTg3ogD158W2PY9IRcpCWPGMcZt01QUPW3B/AcSOKfS4g1QiLM
         aQXnh3O4hIcBHWneOygLE8wzfn3OpStF8OK0ps2IIJ6SqSeLeOkdK0woJUKpUwh/KOyf
         8A240CwbEKvgnYCeNjkmGDP+XSzrkE7Xec1/GyqK0+6lhvgKH9DuPghm7Znt1zUbaiFr
         +KYqi2cj+IFH8pKQLc4B1dxzmTjsf2nLfu1k4mayylEHe01/e0xNDXMhkAKmJ9eL6ME3
         yltkiyH9niPOXnV6yxMsVMM+5sYsleGPC6VlwI62bKGTgoT19Q5U+olnIRsiHVjVaBTo
         glAA==
X-Gm-Message-State: AOJu0YyC5TmJI2ZQAE6ZYp5GVpYDEVB2vrcCcwvTW1ceIzRKNZh1mUpO
        4w/FDrnDnN42GNUBHFl6twZ/1Q==
X-Google-Smtp-Source: AGHT+IEvK+ABpnW0xq6JBR04UWQ96UFjO7HkpTm4Tgs7DAO9KabFFzP3Z7DWsLQSuhCHCZEWm4Mydw==
X-Received: by 2002:a92:c56c:0:b0:359:b467:e29e with SMTP id b12-20020a92c56c000000b00359b467e29emr3139219ilj.30.1699363590166;
        Tue, 07 Nov 2023 05:26:30 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id db8-20020a056e023d0800b003596056a051sm3141589ilb.71.2023.11.07.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:26:29 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] arm64: Add a build target for Flat Image Tree
Date:   Tue,  7 Nov 2023 06:25:52 -0700
Message-ID: <20231107132619.34062-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
  kbuild: arm64: Add BOOT_TARGETS variable
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  16 ++
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.869.gea05f2083d-goog

