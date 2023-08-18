Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE67813B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379795AbjHRTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379986AbjHRTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:42:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4204C37
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:42:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbff6b2679so10015465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692387709; x=1692992509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rO/GUjqy2MCWkNcI9MNL4IXjkgGHQcESzZrRDHtdeBw=;
        b=HUOkjNnS0G3UQF0NDHPyYjqP02QdPU9zoAWS4AH5JJoGjL0DKKk3iAViyAZfC5ZCJ6
         SxBo984z15jkyaC+/oo7e38wht/CkFKF32cNAg/ktTK/OHghzqeZ2a3holHzb+UefpqC
         hRwhMs+sRjX004iMu/N9E3kvfDhErk0C9UH6hec9/ivN13LhQyZOxCZ2hPeSrMwVQ93D
         1vYgSld99LAY3VoEWPms7Xkww94o3MyydYPNKGGGWMQqbKLUqrYNmDASAriNZC27VEit
         MUUYU5p7YVRm74h+Y9jiLR/azSBHXs7+m8GomS8KHfSgE2dtbUzgyAEK98dBZooBIDbs
         azSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692387709; x=1692992509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO/GUjqy2MCWkNcI9MNL4IXjkgGHQcESzZrRDHtdeBw=;
        b=BUg++vG86rD9kHqjSbotdllXymN5m2FF42Ht1A2XsqgGjuTAvNfCl0mvY+/6JdUQ4T
         OawcaZzq+N243ggxWqPEbvLtbzv6LB/pmYQHcRqc2kHB0BlBiEmRxCL5UDZudqrudG8j
         09Fz1ng8xxZjoBZVbCDpflal2+zPTd/5OCItJOLEjttPGku1f/lnXWxNd2H5miGcESwv
         o7GhRO0y/uWlr2vUfTpHFNKuhl1LmGpe4ekr3bJ+w+fPcjnt40alrJNoQXYz1VF8pQuM
         d4KNb0i9wOCmg9vg7PQRH9srfs9wmTDHc3gkuabVW0lq5izFwqn31j2nYdWJNdNVI5eY
         pCRQ==
X-Gm-Message-State: AOJu0YxSiPJf7ypmWdE6p6Xpq6W+ph9UfWD7q1YlIG6mifrxGzBW3e6y
        aP4ip22yC+CV1tVSyf6JqOjrzQ==
X-Google-Smtp-Source: AGHT+IHAbzVBKSdZm7wTqR2x1vEdbjkUfcwg1DIi0NWKJ5cIeVFirBgIn1Yq/YXj66ZWyVJtECsk7w==
X-Received: by 2002:a17:903:2445:b0:1bc:6861:d746 with SMTP id l5-20020a170903244500b001bc6861d746mr185975pls.58.1692387709302;
        Fri, 18 Aug 2023 12:41:49 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b001a5fccab02dsm2126614plx.177.2023.08.18.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:41:48 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/2] RISC-V: Probe for misaligned access speed
Date:   Fri, 18 Aug 2023 12:41:34 -0700
Message-Id: <20230818194136.4084400-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The current setting for the hwprobe bit indicating misaligned access
speed is controlled by a vendor-specific feature probe function. This is
essentially a per-SoC table we have to maintain on behalf of each vendor
going forward. Let's convert that instead to something we detect at
runtime.

We have two assembly routines at the heart of our probe: one that
does a bunch of word-sized accesses (without aligning its input buffer),
and the other that does byte accesses. If we can move a larger number of
bytes using misaligned word accesses than we can with the same amount of
time doing byte accesses, then we can declare misaligned accesses as
"fast".

The tradeoff of reducing this maintenance burden is boot time. We spend
4-6 jiffies per core doing this measurement (0-2 on jiffie edge
alignment, and 4 on measurement). The timing loop was based on
raid6_choose_gen(), which uses (16+1)*N jiffies (where N is the number
of algorithms). By taking only the fastest iteration out of all
attempts for use in the comparison, variance between runs is very low.
On my THead C906, it looks like this:

[    0.047563] cpu0: Ratio of byte access time to unaligned word access is 4.34, unaligned accesses are fast

Several others have chimed in with results on slow machines with the
older algorithm, which took all runs into account, including noise like
interrupts. Even with this variation, results indicate that in all cases
(fast, slow, and emulated) the measured numbers are nowhere near each
other (always multiple factors away).


Changes in v4:
 - Avoid the bare 64-bit divide which fails to link on 32-bit systems,
   use div_u64() (Palmer, buildrobot)

Changes in v3:
 - Fix documentation indentation (Conor)
 - Rename __copy_..._unaligned() to __riscv_copy_..._unaligned() (Conor)
 - Renamed c0,c1 to start_cycles, end_cycles (Conor)
 - Renamed j0,j1 to start_jiffies, now
 - Renamed check_unaligned_access0() to
   check_unaligned_access_boot_cpu() (Conor)

Changes in v2:
 - Explain more in the commit message (Conor)
 - Use a new algorithm that looks for the fastest run (David)
 - Clarify documentatin further (David and Conor)
 - Unify around a single word, "unaligned" (Conor)
 - Align asm operands, and other misc whitespace changes (Conor)

Evan Green (2):
  RISC-V: Probe for unaligned access speed
  RISC-V: alternative: Remove feature_probe_func

 Documentation/riscv/hwprobe.rst      |  11 ++-
 arch/riscv/errata/thead/errata.c     |   8 ---
 arch/riscv/include/asm/alternative.h |   5 --
 arch/riscv/include/asm/cpufeature.h  |   2 +
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/alternative.c      |  19 -----
 arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++
 arch/riscv/kernel/copy-unaligned.h   |  13 ++++
 arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c          |   3 +-
 10 files changed, 198 insertions(+), 39 deletions(-)
 create mode 100644 arch/riscv/kernel/copy-unaligned.S
 create mode 100644 arch/riscv/kernel/copy-unaligned.h

-- 
2.34.1

