Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F97F6C94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjKXHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:10:19 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F7D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:25 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d7f3fc69f4so877494a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809824; x=1701414624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O91wfSpN9ObCdaEwiURAAaoPifbKQnuX2UDqzMk/9EE=;
        b=AYsLJoeKp/VeCaPKIAsqEeGRNi1EXuiCRdE4pVMDxJ6B/TXmQou42eJ+FTRMhNpdnd
         sFuKbaeEReP4bKRRo6CyvkVoKprhlpDx2zx70YKSZLMqK/pM8YdLoYy7vVPx55si3cwd
         +BHk+GRqfjWiA/CiWu5xVNTwzv4UofcWvYHv4DLGksU9dgA8m6ZA86W3C2kBPstgYvGq
         C3HDN5hJhfWEydJcE+A4lEzpyxI8bEjX2zZFta1QC9sLiRa+tfnCdcUmlV9gkqgAPn4V
         36L5/VNZt4XjaErD9yP/duGhGFEOksXfIfMZHsHB0ZL+/5LP0yX+iUAuDGXBm8KY1qrI
         9eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809824; x=1701414624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O91wfSpN9ObCdaEwiURAAaoPifbKQnuX2UDqzMk/9EE=;
        b=UTMOyL/uHt28i+Ie07qBV8QHSksYJa3/nl2clyLMk5J+503sgT/krGjn0i7kmNLPzT
         rIO8/0kQGvw8sfcFXDemzzkYAvi3QmECqdTx5UuSt2M+duek27TxuoZg1c1QTiQrJ+sO
         0AscC+LZeYt1cwojVk7TblFQhaYxhWAcVnkog3K+dppT2Rssc67bIMH6hre8Yu8edg07
         NIn7+D6gWRmVBtEicCPCTvGGU6hmFzyjYNr7BKVD2x6XCVU3ptHYbzAy5IOkP9Ze+DYH
         kA2Kks76RSjgyQR/uH8pT+8hZfT1Q3bjgvdhHc6VZLxQdVXU6g7MEE3DRbOiT5lU+IOz
         iO0g==
X-Gm-Message-State: AOJu0Yz51AnRGI+npCrVr+TPF+/DHGOfFbooW/aGj9jnfg14VCpquPUC
        BETy9VCL9bRBj6E+QvDiNe2rhw==
X-Google-Smtp-Source: AGHT+IHoAk7libxxmoEnwyG+ICVQkzzI6uc6joEaMVEQl0m28dbDgLSf9VQd9ACWrQm5vBhlWCIngw==
X-Received: by 2002:a05:6830:603:b0:6d7:f66d:b0ae with SMTP id w3-20020a056830060300b006d7f66db0aemr1910766oti.5.1700809824530;
        Thu, 23 Nov 2023 23:10:24 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:24 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 0/5] RISC-V SBI debug console extension support
Date:   Fri, 24 Nov 2023 12:39:00 +0530
Message-Id: <20231124070905.1043092-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
functions sbi_console_putchar() and sbi_console_getchar().
(Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)

This series adds support for SBI debug console (DBCN) extension in
Linux RISC-V.

To try these patches with KVM RISC-V, use KVMTOOL from the
riscv_zbx_zicntr_smstateen_condops_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_sbi_dbcn_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Rebased on Linux-6.7-rc2
 - Addressed Drew's comments in PATCH2
 - Improved sbi_debug_console_write/read() to directly take virtual
   address of data so that virtual address to physical address
   conversion can be shared between tty/serial/earlycon-riscv-sbi.c
   and tty/hvc/hvc_riscv_sbi.c
 - Addressed Samuel's comments in PATCH3 and PATCH4

Changes since v3:
 - Rebased on Linux-6.7-rc1
 - Dropped PATCH1 to PATCH5 of v3 series since these were merged through
   KVM RISC-V tree for Linux-6.7
 - Used proper error code in PATCH1
 - Added new PATCH2 which add common SBI debug console helper functions
 - Updated PATCH3 and PATCH4 to use SBI debug console helper functions

Changes since v2:
 - Rebased on Linux-6.6-rc5
 - Handled page-crossing in PATCH7 of v2 series
 - Addressed Drew's comment in PATCH3 of v2 series
 - Added new PATCH5 to make get-reg-list test aware of SBI DBCN extension

Changes since v1:
 - Remove use of #ifdef from PATCH4 and PATCH5 of the v1 series
 - Improved commit description of PATCH3 in v1 series
 - Introduced new PATCH3 in this series to allow some SBI extensions
   (such as SBI DBCN) do to disabled by default so that older KVM user space
   work fine and newer KVM user space have to explicitly opt-in for emulating
   SBI DBCN.
 - Introduced new PATCH5 in this series which adds inline version of
   sbi_console_getchar() and sbi_console_putchar() for the case where
   CONFIG_RISCV_SBI_V01 is disabled.

Anup Patel (4):
  RISC-V: Add stubs for sbi_console_putchar/getchar()
  RISC-V: Add SBI debug console helper routines
  tty/serial: Add RISC-V SBI debug console based earlycon
  RISC-V: Enable SBI based earlycon support

Atish Patra (1):
  tty: Add SBI debug console support to HVC SBI driver

 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/include/asm/sbi.h            | 10 ++++
 arch/riscv/kernel/sbi.c                 | 66 +++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig                 |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c         | 37 +++++++++++---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++--
 7 files changed, 133 insertions(+), 12 deletions(-)

-- 
2.34.1

