Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221627E86EF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbjKKA3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjKKA3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:29:35 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1FD3C3D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:32 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0760cd20so22174506d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699662571; x=1700267371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3FqWqpMvGy3I/j1a0yonrCNkExrkTlpaTzYW4XHQH8=;
        b=OEnFCqQtFB3BCqODtORgmALObNeX7giHiGaPJsJQWEitGCFTtvOYGAvH9vuUqz6I54
         Vxjh+eC4JmYwVVQoUw+sPrXMXwLXTgaCnFrMDQG98G2c3lX9MwQ50i/xeepmNbq5zr8M
         X2SRq6T9mJ5dcoBR4REuXWoePmYQeQKIWA558=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662571; x=1700267371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3FqWqpMvGy3I/j1a0yonrCNkExrkTlpaTzYW4XHQH8=;
        b=RHS77CelkypM6ysbK0Ho5YaSWOBNa7l7BPTu6m9SA3oBIWHw0tAqzEzJ4VApIn4XLt
         C2MsBUqh4oGRTJSh3OaNQGVo+9LAq74nLe40hb3yaE6CyiWMhu4BDi7ZK9mBNmb5iLRk
         y/SvnWcG/o2rdtaZkoGY5cxdy7zftSofiAZw3xmvlaG5Cmr3Tr1rLhImXI/Lm0sIajNd
         GV2Pe3/46FIWGdJMnz8z/bjk5zXqQ+lCY5bqeSzHo7t1GpL9cG37j0FFA1ObV33cEXJw
         iyOtq9WeqFCTbhWkoDGB/bOaENiT0a/gwZX5psNwfUNr92i6UtAeCD+6cDrhb2i7mVM+
         Jf0Q==
X-Gm-Message-State: AOJu0Ywr0OWoPHOjJ8vAJ8MsrL0/I1pzweh/i9GC6l1l7wbbQhcCthHQ
        wz/y9HeHzr0AI4hDcDvvtBqWSQ==
X-Google-Smtp-Source: AGHT+IFKxCzqkIhj/4+puQidciJwVE6cx36K5j318gXTxCtNqzPsItFD1CVurLoJ+T7KVdksSn3fvA==
X-Received: by 2002:a05:6214:125:b0:66c:fa89:a894 with SMTP id w5-20020a056214012500b0066cfa89a894mr5337035qvs.10.1699662571162;
        Fri, 10 Nov 2023 16:29:31 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5104:5a27:f95d:21d1])
        by smtp.gmail.com with ESMTPSA id l16-20020a056214029000b00677adcfd261sm55898qvv.89.2023.11.10.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:29:30 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     lkml <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 0/3] arm64: Add a build target for Flat Image Tree
Date:   Fri, 10 Nov 2023 17:27:59 -0700
Message-ID: <20231111002851.1293891-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes in v5:
- Correct compression rule which was broken in v4

Changes in v4:
- Add a patch to move the single quotes for image name
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

Simon Glass (3):
  kbuild: arm64: Add BOOT_TARGETS variable
  arm: boot: Move the single quotes for image name
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  17 ++-
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 323 insertions(+), 4 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.869.gea05f2083d-goog

