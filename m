Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784AC77C4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjHOAs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjHOAsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6341710
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E28EF63956
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118E1C433C8;
        Tue, 15 Aug 2023 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060498;
        bh=bQjACPQgTLx/TQKmDG+Aq74AFzkxKsmGok6rVreNj/I=;
        h=From:To:Cc:Subject:Date:From;
        b=n4Fd5ZJ5LrtOvD2vfdvlewuTdwRxuB1BA9+hmJNqLwVUKgQvTpbeNslWmvobh4iZn
         lbHlT6hfw7xBFww7o0SmLnhc5h2h0Xx+NWh97acnk0PYvNoJ1TyDTMNPZ/2hCRqiXp
         pnBPx0me2gmq9RPOoWKUrYPS4UaIiB8ExBXYws8LhZUbdujt6dvcLt604W5GXokoDY
         Lhosa55SqfHhN2Ghnzw8jCskGagTaSlz7IKvOF0nnpZG8bFYZix6IcNJwp4KXawNrY
         3DitgqZFM9c2mlyFe9pmEoCTyyN9ihFtU1bTDIVISOEmDAG2Y5RivvFjKZgyFI8Tyu
         bOK8tdiM5Kxgw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 00/20] ARC updates
Date:   Mon, 14 Aug 2023 17:47:53 -0700
Message-Id: <20230815004813.555115-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a pile of miscll improvements/updates sitting in one of my local trees.
Given the recent warning fix, we coudl also push them out.
@Alexey, @Shahab: care to give these a spin on hsdk (and test ARC700 build/boot on nSIM if possible).

Thx,
-Vineet

Vineet Gupta (20):
  ARC: uaccess: remove arc specific out-of-line handles for -Os
  ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
  ARC: uaccess: elide unaliged handling if hardware supports
  ARCv2: memset: don't prefetch for len == 0 which happens a alot
  ARC: boot log: eliminate struct cpuinfo_arc #1: mm
  ARC: boot log: eliminate struct cpuinfo_arc #2: cache
  ARC: boot log: eliminate struct cpuinfo_arc #3: don't export
  ARC: boot log: eliminate struct cpuinfo_arc #4: boot log per ISA
  ARC: entry: use gp to cache task pointer (vs. r25)
  ARC: kernel stack: INIT_THREAD need not setup @init_stack in @ksp
  ARC: __switch_to: asm with dwarf ops (vs. inline asm)
  ARC: __switch_to: move ksp to thread_info from thread_struct
  ARC: entry: rework (non-functional)
  ARC: entry: ARcompact EV_ProtV to use r10 directly
  ARC: entry: EV_MachineCheck dont re-read ECR
  ARC: entry: Add more common chores to EXCEPTION_PROLOGUE
  ARC: entry: replace 8 byte OR with 4 byte BSET
  ARC: entry: replace 8 byte ADD.ne with 4 byte ADD2.ne
  ARCv2: entry: rearrange pt_regs slightly
  ARC: pt_regs: create seperate type for ecr

 arch/arc/Kconfig                     |   8 +-
 arch/arc/Makefile                    |   6 +-
 arch/arc/include/asm/arcregs.h       |  99 ++---
 arch/arc/include/asm/current.h       |   2 +-
 arch/arc/include/asm/dwarf.h         |  32 +-
 arch/arc/include/asm/entry-arcv2.h   |  66 ++--
 arch/arc/include/asm/entry-compact.h |  50 ++-
 arch/arc/include/asm/entry.h         | 107 ++---
 arch/arc/include/asm/processor.h     |   7 +-
 arch/arc/include/asm/ptrace.h        |  62 ++-
 arch/arc/include/asm/setup.h         |   6 +-
 arch/arc/include/asm/thread_info.h   |  10 +-
 arch/arc/include/asm/uaccess.h       |  21 +-
 arch/arc/kernel/Makefile             |   9 +-
 arch/arc/kernel/asm-offsets.c        |  14 +-
 arch/arc/kernel/ctx_sw.c             | 112 ------
 arch/arc/kernel/ctx_sw_asm.S         |  76 ++--
 arch/arc/kernel/entry-arcv2.S        |  15 -
 arch/arc/kernel/entry-compact.S      |  16 +-
 arch/arc/kernel/entry.S              |  70 ++--
 arch/arc/kernel/kgdb.c               |   2 +-
 arch/arc/kernel/mcip.c               |   2 -
 arch/arc/kernel/process.c            |  17 +-
 arch/arc/kernel/ptrace.c             |   8 +-
 arch/arc/kernel/setup.c              | 561 ++++++++++++---------------
 arch/arc/kernel/traps.c              |   4 +-
 arch/arc/kernel/troubleshoot.c       |  13 +-
 arch/arc/lib/memset-archs.S          |   3 +-
 arch/arc/mm/cache.c                  | 171 +++-----
 arch/arc/mm/extable.c                |  11 -
 arch/arc/mm/fault.c                  |   6 +-
 arch/arc/mm/tlb.c                    |  94 ++---
 32 files changed, 667 insertions(+), 1013 deletions(-)
 delete mode 100644 arch/arc/kernel/ctx_sw.c

-- 
2.34.1

