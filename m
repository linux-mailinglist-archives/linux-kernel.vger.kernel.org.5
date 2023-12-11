Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51CF80C4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjLKJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjLKJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:44:25 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ACBE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:44:28 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so53822071fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702287866; x=1702892666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkVX/kO8wR8tFky0mjPSXH+PwnVI8mpjAOkFM1M+MLk=;
        b=kV4gTIcEl1J3LFI+Xst4+SECU6vohdQ32uj3LG2Km485KNGX0EAjEmLfI9NUe6EhSw
         /9uVPzZLGs5PAdF3TMizL2sFp0wMKMbcwxTrvr/Q6OcNUlcChZhJrQ+orAvmZ3IL9lgZ
         QFyQTzScYpWvGUYV45qc7DyTc63ooCT0Lg5bdKbot1xjVQE9l0oujGcZlsAKNkD3ThpV
         hLLvBN2/l9ovPxl938SfSof+y/os1dw1nBo0iPMZeQGjdpeKwi8Qo0R75PrevsNHxhy0
         rHmChucbPJ3RWVFYhyPzn5c2OgVS9TNNqDXzLcF2Rx4FzIWTuBQ7p/seGUllHlUCF8nQ
         pxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287866; x=1702892666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkVX/kO8wR8tFky0mjPSXH+PwnVI8mpjAOkFM1M+MLk=;
        b=AfJaPzvpIpY1jIlCl01Y0TZMVT83tojjGShQFJJ98Xw3mifYkj5BP/cZEEHdwlQcO5
         ECPiP818Si6Ii0iwtZsPnOXAc72Q2udqM/qghfEZtWVmQU2B7FrULXmQOs7pO8rbCc+T
         5T+IJ9wKAHkLKMWXlBJo0/Chpv8AMIKkTq+DAW4pUSPzgv9zVRXBY7isSJml7/E8Qk7Z
         eEQILrENAxizHcoOzSZuI6BMc8uWt9tfg2K9eRZBKYCQxiuue010OcaQq/UQ6tr/gj8q
         RPlUzBrzzs57v+qJw9cjOmjCYpr1GzMC5Q4t1uOOW7pdxmm57rRdczIOvQ+YjScoMDLt
         y4AQ==
X-Gm-Message-State: AOJu0YwUgl5s/l4z8HYUlkbqa23lXqxQmMJmIsgbY21T4AHccqPJNH48
        HyAKAaOYeXPWnAZOi/JmaNI=
X-Google-Smtp-Source: AGHT+IGkmBPY0oFteEOVZTgnLWZi6LGWx8KFEsiUe0UcFe5nXf/4TL7OaXO96YMN4A8p2N2hd46r7g==
X-Received: by 2002:a05:651c:b09:b0:2ca:68:acf6 with SMTP id b9-20020a05651c0b0900b002ca0068acf6mr1588150ljr.88.1702287865734;
        Mon, 11 Dec 2023 01:44:25 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.124.152])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm3463505edb.59.2023.12.11.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:44:25 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2 0/4] membarrier: riscv: Core serializing command
Date:   Mon, 11 Dec 2023 10:44:10 +0100
Message-Id: <20231211094414.8078-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 ([1]):

Add patch 1/4 to resolve the "sync core" scenario reported by Mathieu
in [1] and meet the requirement of the membarrier "private expedited"
command.

Miscellaneous improvements/additions to documentation and MAINTAINERS
files.  Follow up on Mathieu's suggestion in [1] to introduce a Kconfig
/feature for the latter command (patch 4/4).

N.B.  Patch 4/4 is in RFC-mode, the plan being to submit this patch to
the various archs/doc lists (more likely, as a stand-alone patch) once
I've got some ack/positive feedback from the MEMBARRIER maintainers.

  Andrea

[1] https://lore.kernel.org/all/20231127103235.28442-1-parri.andrea@gmail.com/

Andrea Parri (4):
  membarrier: riscv: Add full memory barrier in switch_mm()
  locking: Introduce prepare_sync_core_cmd()
  membarrier: riscv: Provide core serializing command
  membarrier: Introduce Kconfig ARCH_HAS_MEMBARRIER

 .../membarrier-sync-core/arch-support.txt     | 18 ++++++-
 .../sched/membarrier/arch-support.txt         | 50 +++++++++++++++++++
 MAINTAINERS                                   |  4 +-
 arch/alpha/Kconfig                            |  1 +
 arch/arc/Kconfig                              |  1 +
 arch/arm/Kconfig                              |  1 +
 arch/arm64/Kconfig                            |  1 +
 arch/hexagon/Kconfig                          |  1 +
 arch/mips/Kconfig                             |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/riscv/Kconfig                            |  5 ++
 arch/riscv/include/asm/membarrier.h           | 48 ++++++++++++++++++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++
 arch/riscv/mm/context.c                       |  2 +
 arch/s390/Kconfig                             |  1 +
 arch/sparc/Kconfig                            |  1 +
 arch/x86/Kconfig                              |  1 +
 include/linux/sync_core.h                     | 16 +++++-
 init/Kconfig                                  |  6 +++
 kernel/sched/core.c                           |  9 ++--
 kernel/sched/membarrier.c                     | 16 +++++-
 21 files changed, 204 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/features/sched/membarrier/arch-support.txt
 create mode 100644 arch/riscv/include/asm/membarrier.h
 create mode 100644 arch/riscv/include/asm/sync_core.h

-- 
2.34.1

