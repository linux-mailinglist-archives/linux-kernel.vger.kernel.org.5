Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40DA789ACD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjH0B1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjH0B0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:26:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAEC1B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdbf10333bso17246905ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693099606; x=1693704406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNSCCQJ2PHIrpnuCYjkfmwAL1UlsOXF5w17YaiUOSMs=;
        b=CgS+ELHYl68sNVrtSNvW+no+75+iNX5v8szBnRR5GsefmWuQMd+wl+Is32E5MtWRPd
         4mOAlMT0Pt2bc6beSZcQGlNQ059Pk6xy2nfKkLpKNdlMh3RclwViHo33EZtCrbvEWp8Z
         qhieYrdu/ZkisUY8fnkwfZU9A/JIUoyr654ieaLuJ6hVwIPqVAdBB6HMqhX6Nw5iJzOB
         9ImbtOxHaC58nmFogp28Z7KS5uhB9DdPSeHFAIp0wQkf6hiGenV3Huc+apT1SK+iZaC6
         nJ0+PCHAoCfpwpX/6AR/zJwZgxUSrvICwnNWqyHXFhVQlvq9Zf0yOEDfhHP/hJahultn
         WrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099606; x=1693704406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNSCCQJ2PHIrpnuCYjkfmwAL1UlsOXF5w17YaiUOSMs=;
        b=kF5Ui/md7yAK2t2PvnF7VItoI+uCL3kDRlRJo1bNPALoBoV8uH5iForXacEPkjMWhE
         G9ROR8Vf+6FazsRI+vUz77r547FUGrH8KdsDzwCrqSsxQIigrj6s2hqLHlNxJ5/bQdZO
         BjshnbC4lD+zaoSf6mcR736SeOby7eYd/OwlIYegcJvnXPngjgxvxNF0GWEzfD0kk2ID
         HKvJB0TlioE42jSco9KELJjtxJHwFIydGp+tCIB8q0yjtMOHHFyPuhiq86yyO4FLL4UP
         XckCMCFB8RMiFsCTBGlSMUZAVX9tmczB5mBdOXEOLLkpbBok26rRRbtnAu+BdkbLjxNJ
         1rsg==
X-Gm-Message-State: AOJu0YyF8fPgV2yiiDO6XzCxolFHlNNSeOd515nXCwNb/7wmXTX0H6l8
        fkUTeAb+eFbAhcnJZrIMUnq8cA==
X-Google-Smtp-Source: AGHT+IH8uJ+mK8/jT0ou9nq6/xNAJEE4H8D7+FwR4quNsvGNSpXeGhllAqEyEP6g1xYfWsCvIsJbdg==
X-Received: by 2002:a17:903:24f:b0:1b8:4e00:96b with SMTP id j15-20020a170903024f00b001b84e00096bmr26818362plh.9.1693099606315;
        Sat, 26 Aug 2023 18:26:46 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b869410ed2sm4357404plb.72.2023.08.26.18.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:26:45 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/5] riscv: Add fine-tuned checksum functions
Date:   Sat, 26 Aug 2023 18:26:05 -0700
Message-Id: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC2m6mQC/x3MQQqAIBBA0avErBPUDKSrRITZVENooRWRdPek5
 Vv8nyBiIIzQFAkCXhRp8xmiLMAuxs/IaMwGyWXFNVds2w9y9GBvF7RrPB0bB6FqqbWxUkDu9oA
 T3f+z7d73Axxw9zpjAAAA
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each architecture generally implements fine-tuned checksum functions to
leverage the instruction set. This patch adds the main checksum
functions that are used in networking.

Vector support is included in this patch to start a discussion on those
since I am not super familiar with the vector instructions. I wasn't
able to get the vector patches to compile in the kernel, but as vector
support matures I will be able to go back and fix them up. I have tested
the vector patches as standalone algorithms in QEMU.

These functions work best with the Zba and Zbb extensions, so support
for those instructions were added to the kernel.

To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
and RISCV_CHECKSUM_KUNIT.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (5):
      riscv: Checksum header
      riscv: Add checksum library
      riscv: Vector checksum header
      riscv: Vector checksum library
      riscv: Test checksum functions

 arch/riscv/Kconfig                    |  23 +++
 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/Makefile                   |   2 +
 arch/riscv/include/asm/checksum.h     | 165 ++++++++++++++++++++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 283 ++++++++++++++++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 111 +++++++++++++
 8 files changed, 619 insertions(+)
---
base-commit: 7bafbd4027ae86572f308c4ddf93120c90126332
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

