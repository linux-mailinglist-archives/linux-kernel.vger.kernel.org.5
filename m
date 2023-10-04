Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7E7B826C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbjJDOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjJDOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:34:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC9C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:34:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406532c49dcso4962755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696430084; x=1697034884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CM1tzOwYIRfBowwMaDOZ0YTv6DSHjRM1ieV3JngoGb0=;
        b=zEip87a0BH1j92Z/jps+EGC6DV3MxeNx5LtX4FBEpISjNNEYsJg4mbdQGHLOHSdLHy
         xFbG7KASGIupi44Jia+cpHBuRqQsy5dzriC6VLao+g8Lc7CtUIEtnGyTp77u+dzSuozk
         AfMZWpToKPycdJjYhyOwSvf5hNTXtpAMROuH20kp64XvBxRqL74v1Dyn9p7ONQbX1wxg
         b+0COpHsMLnzJ2qWwnfmVWGnZIkRZyKLxzCxjdaF3X0zljQ57WdRkjDdrsDdycU1Pngu
         9GfPuT6IdQ4ZaxUvtdogEsCm3eQPtgmPjSb8JTUhUZbho6HztewR37Ogt/4DXdjIyBlC
         Us/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430084; x=1697034884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM1tzOwYIRfBowwMaDOZ0YTv6DSHjRM1ieV3JngoGb0=;
        b=kmsL9voWoMP6qrIXRGzWvsUNEGbYWb2Qd/vlJR8SGw7gKeEAx4VyKQ2sujfXHBqalQ
         WGoTV8M/SBEPvCd7Byny9TFgziK+uWtsm22+2WZwmW8yCfIAwxzqxLZ6/0efys8gaT1K
         JA+prUxlzAxGo3Cn/K2opG7+1p9doZYaLY2WpZd49a/Dt/oI4GbnHEMS1xwBqRoENifA
         SNJ1l2oR/ZjvlBm2ZIhnDMiKisSTlfLIN16ZvDwWlYVSKmDxvOIiQkShmc3wu7Oqd89F
         hXimkZkj2UGiI1X+BYjWLq3GrPtYynGdot0HZfogFqUNlC5dLJJiNBiRFMloWTno9tlp
         rHcQ==
X-Gm-Message-State: AOJu0YxR1q/ViocVuZh19cmpVrP5SwpyyCzBEXhIyOdqKtQNXXFy8Lgc
        pPk955lcBiFsFJPpFP+uyQ9MTg==
X-Google-Smtp-Source: AGHT+IEcQotQCjgDXMBBO6ccwZ9igg2/BW1u3BEgiE/Ihu0ulcuIV203Up+Cur0jM4vJZJIKO6KgBA==
X-Received: by 2002:a05:600c:5114:b0:405:4127:f471 with SMTP id o20-20020a05600c511400b004054127f471mr2532705wms.1.1696430083756;
        Wed, 04 Oct 2023 07:34:43 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id t20-20020a1c7714000000b00401e32b25adsm1686205wmi.4.2023.10.04.07.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:34:43 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: [PATCH 0/5] riscv: cleanup assembly usage of ENTRY()/END() and use local labels
Date:   Wed,  4 Oct 2023 16:30:49 +0200
Message-ID: <20231004143054.482091-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does a cleanup of all ENTRY()/END() macros that are used in
arch/riscv/ as well as use of local labels. This allows to remove the
use of the now deprecated ENTRY()/END()/WEAK() macros as well as using
the new SYM_*() ones which provide a better understanding of what is
meant to be annotated. Some wrong usage of SYM_FUNC_START() are also
fixed in this series by using the correct annotations. Finally a few
labels that were meant to be local have been renamed to use the .L
suffix and thus not to be emitted as visible symbols.

Note: the patches have been split between arch/riscv/ and
arch/riscv/kvm/ due to having different maintainers.

Clément Léger (5):
  riscv: use ".L" local labels in assembly when applicable
  riscv: Use SYM_*() assembly macros instead of deprecated ones
  riscv: kernel: Use correct SYM_DATA_*() macro for data
  riscv: kvm: Use SYM_*() assembly macros instead of deprecated ones
  riscv: kvm: use ".L" local labels in assembly when applicable

 arch/riscv/kernel/copy-unaligned.S            |  8 +--
 arch/riscv/kernel/entry.S                     | 19 +++----
 arch/riscv/kernel/fpu.S                       |  8 +--
 arch/riscv/kernel/head.S                      | 30 +++++-----
 arch/riscv/kernel/hibernate-asm.S             | 12 ++--
 arch/riscv/kernel/mcount-dyn.S                | 20 +++----
 arch/riscv/kernel/mcount.S                    | 18 +++---
 arch/riscv/kernel/probes/rethook_trampoline.S |  4 +-
 arch/riscv/kernel/suspend_entry.S             |  4 +-
 arch/riscv/kernel/vdso/flush_icache.S         |  4 +-
 arch/riscv/kernel/vdso/getcpu.S               |  4 +-
 arch/riscv/kernel/vdso/rt_sigreturn.S         |  4 +-
 arch/riscv/kernel/vdso/sys_hwprobe.S          |  4 +-
 arch/riscv/kvm/vcpu_switch.S                  | 32 +++++------
 arch/riscv/lib/memcpy.S                       |  6 +-
 arch/riscv/lib/memmove.S                      | 56 +++++++++----------
 arch/riscv/lib/memset.S                       |  6 +-
 arch/riscv/lib/uaccess.S                      | 11 ++--
 arch/riscv/purgatory/entry.S                  | 16 ++----
 19 files changed, 125 insertions(+), 141 deletions(-)

-- 
2.42.0

