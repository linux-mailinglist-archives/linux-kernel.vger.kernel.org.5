Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB14E79BAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjIKXS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350767AbjIKXMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 19:12:39 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47436E8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 16:00:08 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-564af0ac494so3558852a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694473064; x=1695077864; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFHImHKcNiQeeK+5BliTUXW2QVp3vXADiZhQpYrJUp8=;
        b=yM3vsk7dnr85Gk4iS/4AmRtIRbWNWONpAG//SACFZ4dwKlMpZxQ1KhUjHcOtHlaQ4W
         JPpv/T2X+n8fJRQ2Gif9ZC5CIVr591pw+pjoOD8sL63K8i4rTB052KnJp8cOuGFBa0KW
         7cZF4F42B10vd9au8wMspM1HOY4f+By9zJnx+SiuKxJBpxvUo4G7wKZCqupTEJEFJ30E
         Mdi7HKWreFsNLV4ZLu68V3LVF7XhzETVaW5RajpRTTkoD9ICA9TPHRm3pRjxQJbcDb6u
         agq2kf5RdI2xzIZuvbjHAyGsHHla3dZ3OPRLyTTTbWI/Akn+H+6eDpJFibtheUAq8ytJ
         XCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473064; x=1695077864;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFHImHKcNiQeeK+5BliTUXW2QVp3vXADiZhQpYrJUp8=;
        b=sqdnqo+Li5h08ILaGvFfgt5z5ySy8hXB2RgGkm/hjZ5nzua36UsgD7bwoBqkLNDJPR
         txoPvJ1C8jBI1jFEtnAsEYS5k0xiymldZxwmZqxBBkyD8N299MFJhNm/dbexXXesRv4R
         EQqyaEmxOoifH5rAx0k7fiAFcrYuwm3NkysPKcmt0zxzYhkjDJX0SLwrSMM8HFCHmSsS
         jvVMkcxTL+/1VqjEHcLoeWeGjSaCWmn59HqgB0igufAMen81gm8HqbbkJSCWv6E7yR1u
         1VYGdR5WLA7nVvaBKiz4JvkKtH6gycZEg2AfEkRmByRgvt892vZOMSNRnxV2jb87TsFC
         nJEQ==
X-Gm-Message-State: AOJu0YxF0Sk1DsHo+ywj98cLKblj70Hcz6gQdeRRnv86T68rk7/AhbDC
        u3EugPai7DG0OZz23Rs758mCNKECOlku62pt/8E=
X-Google-Smtp-Source: AGHT+IHA1R0qiVnW7n9r+m0MpAsKnCumiTMnjCic5EWNH4bsKLOSQXuZbxIlhVKjEjmIJ/bIc33XPw==
X-Received: by 2002:a05:6a20:1593:b0:13f:b028:789c with SMTP id h19-20020a056a20159300b0013fb028789cmr10806478pzj.5.1694473063940;
        Mon, 11 Sep 2023 15:57:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b0066a2e8431a0sm6021038pfm.183.2023.09.11.15.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:57:43 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/5] riscv: Add fine-tuned checksum functions
Date:   Mon, 11 Sep 2023 15:57:10 -0700
Message-Id: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEab/2QC/23N3wrCIBTH8VcJrzP0qPvTVe8REZtaO8Tm0CXV2
 LvnRlDELr8/OJ8zkmA92kD2m5F4GzGg61LI7YbopuqulqJJTYCBYAWT1PUDtviyZ91YfQv3lpq
 aSwVFUWngJN313l7wsZjHU+oGw+D8c3kR+bx+NMhWtMgpo6XIFeN1YqE6eIwuYKd32rVkBiN8k
 ZKpNQQSorXJVGHqXIp6BRG/SL6GiBlRDIyQpjS5+EOmaXoDxv4t7D8BAAA=
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each architecture generally implements fine-tuned checksum functions to
leverage the instruction set. This patch adds the main checksum
functions that are used in networking.

Vector support is included in this patch to start a discussion on that,
it can probably be optimized more. The vector patches still need some
work as they rely on GCC vector intrinsics types which cannot work in
the kernel since it requires C vector support rather than just assembler
support. I have tested the vector patches as standalone algorithms in QEMU.

This patch takes heavy use of the Zbb extension using alternatives
patching.

To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
and RISCV_CHECKSUM_KUNIT.

I have attempted to make these functions as optimal as possible, but I
have not ran anything on actual riscv hardware. My performance testing
has been limited to inspecting the assembly, running the algorithms on
x86 hardware, and running in QEMU.

ip_fast_csum is a relatively small function so even though it is
possible to read 64 bits at a time on compatible hardware, the
bottleneck becomes the clean up and setup code so loading 32 bits at a
time is actually faster.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v4:
- Suggestion by David Laight to use an improved checksum used in
  arch/arc.
- Eliminates zero-extension on rv32, but not on rv64.
- Reduces data dependency which should improve execution speed on
  rv32 and rv64
- Still passes CHECKSUM_KUNIT and RISCV_CHECKSUM_KUNIT on rv32 and
  rv64 with and without zbb.
- Link to v3: https://lore.kernel.org/r/20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com

Changes in v3:
- Use riscv_has_extension_likely and has_vector where possible (Conor)
- Reduce ifdefs by using IS_ENABLED where possible (Conor)
- Use kernel_vector_begin in the vector code (Samuel)
- Link to v2: https://lore.kernel.org/r/20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com

Changes in v2:
- After more benchmarking, rework functions to improve performance.
- Remove tests that overlapped with the already existing checksum
  tests and make tests more extensive.
- Use alternatives to activate code with Zbb and vector extensions
- Link to v1: https://lore.kernel.org/r/20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com

---
Charlie Jenkins (5):
      riscv: Checksum header
      riscv: Add checksum library
      riscv: Vector checksum header
      riscv: Vector checksum library
      riscv: Test checksum functions

 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/include/asm/checksum.h     | 181 +++++++++++++++++++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 302 +++++++++++++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
 6 files changed, 848 insertions(+)
---
base-commit: af3c30d33476bc2694b0d699173544b07f7ae7de
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

