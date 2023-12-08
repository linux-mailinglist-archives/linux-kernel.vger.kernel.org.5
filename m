Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D180A919
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574206AbjLHQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjLHQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:34:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE4198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C539C433C9;
        Fri,  8 Dec 2023 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053302;
        bh=xQL6pG6caMEyh27UFdkVG4YVqENSinSYSj4xkfqkX3c=;
        h=From:To:Cc:Subject:Date:From;
        b=GDMWy+MeAdezgVTuAgkePTDVNCDmK6Xb8vdKI+aRsMe1aHkIohr2LQhf1GDl1VW3p
         Qquxo3Cj+Gf5cb/QZuFokdhqLBP1FrAJ8Xgxymun8pajiCz2JdgZZgcvyIlNCfokKf
         ZdzdF2+bkZMDW7TxDMJP7oBDr7yXViufFmxlCNNPhkBiSacXp8vNxdVzu0oTokHzAV
         6qPuW2i5fpMmEiIjtxUrcndcOqG8XNhqGbfo4rzj/q/rM6gbc9497pDenwuTZzf+cu
         BATEflAHnCRp+pUO+NvOT4fGDZLRsbteEvmG2mBAHMHsZYrv252nKEnpnFjnwwRvhS
         1x1qOB9aFrx8w==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 0/9] powerpc: ftrace updates
Date:   Fri,  8 Dec 2023 22:00:39 +0530
Message-ID: <cover.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early RFC.

This series attempts to address couple of issues with the existing 
support for ftrace on powerpc, with a view towards improving performance 
when ftrace is not enabled. See patch 6 for more details.

Patches 7 and 8 implement support for ftrace direct calls, through 
adding support for DYNAMIC_FTRACE_WITH_CALL_OPS.

The first 5 patches are minor cleanups and updates, and can go in 
separately.

This series depends on Benjamin Gray's series adding support for 
patch_ulong().

I have lightly tested this patch set and it looks to be working well. As 
described in patch 6, context_switch microbenchmark shows an improvement 
of ~6% with this series with ftrace disabled. Performance when ftrace is
enabled reduces due to how DYNAMIC_FTRACE_WITH_CALL_OPS works, and due 
to support for direct calls. Some of that can hopefully be improved, if 
this approach is otherwise ok.

- Naveen



Naveen N Rao (8):
  powerpc/ftrace: Fix indentation in ftrace.h
  powerpc/ftrace: Unify 32-bit and 64-bit ftrace entry code
  powerpc/ftrace: Remove nops after the call to ftrace_stub
  powerpc/kprobes: Use ftrace to determine if a probe is at function
    entry
  powerpc/ftrace: Update and move function profile instructions
    out-of-line
  powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
  powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS
  samples/ftrace: Add support for ftrace direct samples on powerpc

Sathvika Vasireddy (1):
  powerpc/Kconfig: Select FUNCTION_ALIGNMENT_4B

 arch/powerpc/Kconfig                        |   6 +
 arch/powerpc/Makefile                       |   6 +-
 arch/powerpc/include/asm/code-patching.h    |  15 +-
 arch/powerpc/include/asm/ftrace.h           |  35 ++-
 arch/powerpc/include/asm/linkage.h          |   3 -
 arch/powerpc/kernel/asm-offsets.c           |   7 +
 arch/powerpc/kernel/kprobes.c               |  69 +++++-
 arch/powerpc/kernel/trace/ftrace.c          | 231 ++++++++++++++++----
 arch/powerpc/kernel/trace/ftrace_entry.S    | 182 +++++++++++----
 samples/ftrace/ftrace-direct-modify.c       |  94 +++++++-
 samples/ftrace/ftrace-direct-multi-modify.c | 110 +++++++++-
 samples/ftrace/ftrace-direct-multi.c        |  64 +++++-
 samples/ftrace/ftrace-direct-too.c          |  72 +++++-
 samples/ftrace/ftrace-direct.c              |  61 +++++-
 14 files changed, 845 insertions(+), 110 deletions(-)


base-commit: 9a15ae60f2c9707433b01e55815cd9142be102b2
prerequisite-patch-id: 38d3e705bf2e27cfa5e3ba369a6ded84ba6615c2
prerequisite-patch-id: 609d292e054b2396b603890522a940fa0bdfb6d8
prerequisite-patch-id: 6f7213fb77b1260defbf43be0e47bff9c80054cc
prerequisite-patch-id: f2328625ae2193c3c8e336b154b62030940cece8
-- 
2.43.0

