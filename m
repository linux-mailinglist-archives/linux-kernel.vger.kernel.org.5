Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28722793477
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjIFErQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbjIFErP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:47:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD11CE6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 21:47:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c336f5b1ffso22707815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693975631; x=1694580431; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkNf5DdEUVVxDR8Go3EaSMZ4c9q9d7OU7fzHFUYTbIk=;
        b=MgVfVuDBg2qUnS6BzSgRn+245X0W7jqc4gFqKBvdn7KhM0dslcZzz0QiJKmsE6ykH1
         W5xIUTc8np06OgfuPS+5k0zK57cD34tJueP/rE9y9jIN2E9RtuQ8nFBmiBQuaa+JoR3r
         x79tVJTHDbYXGiKsECuARL9iWw8tmAiS3UZXj51o5duC2QtlONbNErUXJjyBTHNc2Hls
         DDXzDbFlITsJ5sfcDrXNPfKgmc41GE1kvEmmmX1LnWD2LEG20tRLx/q5ddryzUgb0qBw
         6GSqOcVBWZT/fUgtSpJeJHhpPaaOkXgNXmivh6oaz1hU32NtiqKK3a+Atbt/3Q53hBaZ
         9dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693975631; x=1694580431;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkNf5DdEUVVxDR8Go3EaSMZ4c9q9d7OU7fzHFUYTbIk=;
        b=OT0T/yjmF8qCcZMJTgAY6DL7uJDYhKvUWbPiCOuaM8LjYguVoU31qddibtFM8Ibx+o
         49WT8beUx2LoKu1tr1UPns+yoWYYUWK1bYQYQyA9v11TP+9jLf6XErvE/+jmnbRFz0l9
         4dTVuYwlnL+CappS6AO/4KCOdfhPXl9GzLWv4LKBHCwJt+N7/bqWRkraFxOk+j6Dg4fG
         lXCZGv28R3jnBrulyrJdjygMKtds0fVsgd4gTB+DLFBzhMtU04x06FYrWoWDMqcCHVvP
         W7wAUbLz8F84qfskSpYP3QeFK2VO3rRTBlxwqs2ajDcjz6V7vJ6/ybJP+ZY9lRFYevdO
         DAlA==
X-Gm-Message-State: AOJu0Yz87MNsE1TvWIDYs8MgeFJBOzm1kIY35D1J1PM5CxTHI4drVP+R
        +/luIFinOy+MKLlWJnGlvZq8zw==
X-Google-Smtp-Source: AGHT+IHhZFPSvGInMuLV9uwyB9cb85sco3sDZCIbQ1PubHTivGtMzOq6C5Q3wrQz1LDEvAi+2/NQBA==
X-Received: by 2002:a17:902:ced0:b0:1bf:423:957b with SMTP id d16-20020a170902ced000b001bf0423957bmr18742552plg.26.1693975631109;
        Tue, 05 Sep 2023 21:47:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001bc56c1a384sm10087313plt.277.2023.09.05.21.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 21:47:10 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/5] riscv: Add fine-tuned checksum functions
Date:   Tue, 05 Sep 2023 21:46:49 -0700
Message-Id: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkE+GQC/23NQQ6CMBCF4auQWVvTDqDVlfcwxEAZ7cTQkhYbl
 XB3K3Hp8n/JfDNDpMAU4VjMEChxZO9y4KYAY1t3I8F9bkCJpdSyEn6ceOA3XYwlc4+PQfSdqmr
 UujWoIN+Nga78XM1zk9tynHx4rS+S+q4/DXd/tKSEFIdyX0vVZRbbU+DkIzuzNX6AZlmWD72WV
 8q1AAAA
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
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
 arch/riscv/include/asm/checksum.h     | 194 ++++++++++++++++++++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 333 ++++++++++++++++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 +++++++++++++++++++++++++++++++++
 6 files changed, 892 insertions(+)
---
base-commit: 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

