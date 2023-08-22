Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5978409B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjHVMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjHVMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:20:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202AD199
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:20:16 -0700 (PDT)
Message-ID: <20230822121936.476984181@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692706807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WSBQF9IDXNIpTGtsDW7Yi6vz1fTlHKZ9EhLlwxPSgdA=;
        b=m1BmRyxEi/FdlmbPGN8DJ3+qY+Ts6weOSmmlQssn4zSZdnOjSgDavzaTJCrjPOjA/3z9ej
        clRjMdUYeiWdesyV2OmOxo0JC+igFw76fk4Y+azc9hg5SxHducoWdb7qTjupw1IHTuD42g
        UEW+YsX0OUfQiKLQ5elxLn13NTBK9dXxL/WkkVy9c0bn00MCezorRRt4uIksBIj25Mux3H
        xizkCpySf2W+QJ7zEwd2DCD+4tQcJjVADzz4ixe2g9QTaMtlc3sgKv4/uCpxA/OeZF0hNs
        31Y54NMqk1/aU9p/k/JfxZUPq+B+z91p00iajXeTaXt87QX3EvNdGcICFoQoMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692706807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WSBQF9IDXNIpTGtsDW7Yi6vz1fTlHKZ9EhLlwxPSgdA=;
        b=2BeZIqruZfeGJzCv7UKVjWcn+SdOAPWNb/8vtIQqRhCNYnRCF7ETvWqHAf0PT7LvTdBp29
        8wH5no0BufHL4pCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Subject: [patch 0/2] x86/microcode: Make 32-bit early loading robust and
 correct
Date:   Tue, 22 Aug 2023 14:20:07 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the microcode loader I stumbled over the 32bit early
loading mechanism which runs before paging enable in physical address mode.

Aside of being a source of code horror and debug trouble, it also turned
out that this is fundamentally broken vs. stackprotector and tracing:

 1) When stackprotector is enabled then the microcode loader code has the
    stackprotector mechanics enabled. The read from the per CPU variable
    __stack_chk_guard is always accessing the virtual address either
    directly on UP or via FS on SMP. In physical address mode this results
    in an access to memory above 3GB. So this works by chance as the
    hardware returns the same value when there is no RAM at this physical
    address. When there is RAM populated above 3G then the read is by
    chance the same as nothing changes that memory during the very early
    boot stage. That's not necessarily true during runtime CPU hotplug.

 2) When function tracing is enabled, then the relevant microcode loader
    functions and the functions invoked from there will call into the
    tracing code and evaluate global and per CPU variables in physical
    address mode. What could potentially go wrong?

While it would be possible to mark all the involved functions to be non
instrumentable and excluded from stack protector, the obvious question
arose why this is necessary at all.

The changelog of the commit which introduced this is completely useless to
answer this question and the cover letter consists mostly of handwaving
word salad without technical content:

  "The problem in current microcode loading method is that we load a
   microcode way, way too late; ideally we should load it before turning
   paging on.  This may only be practical on 32 bits since we can't get to
   64-bit mode without paging on, but we should still do it as early as at
   all possible."

So after asking around, it turned out that this was implemented to handle
the erratum of early ATOM CPUs which affects PSE.

So I sat down and did a proper technical analysis of that erratum and the
resulting requirements. It turns out that the early loading before paging
is enabled is just a pointless exercise due to lack of a thorough analysis.

More details about the reasons why this is a pointless exercise can be
found in patch 1/2.

Patch 2/2 is not microcode related, but the fallout of the analysis. It's
the only other C-function invoked on 32-bit before paging is enabled and it
is obviously affected by the stack protector issue as well and on top lacks
the removal of tracing.

The series applies on top of

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode

Thanks,

	tglx
---
 Makefile                 |    1 
 cpu/microcode/amd.c      |   31 ++-----------
 cpu/microcode/core.c     |   40 +++--------------
 cpu/microcode/intel.c    |  108 +++++------------------------------------------
 cpu/microcode/internal.h |    2 
 head32.c                 |    6 ++
 head_32.S                |   10 ----
 smpboot.c                |   12 +----
 8 files changed, 38 insertions(+), 172 deletions(-)

