Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8C7543D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjGNUhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjGNUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:37:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F410EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wrUsX+fGObyqWFLpJoZXsYVL4Y4Pkz1ztByvASSpKFo=; b=DVw+JntWvLjM2IFhSOsUO5+3AA
        5JgQdgrRboH3sfu3M4EAJ34CbQcU5e9D+pSgjqC3u/yRHCsJ184hwlX/jIngm1Lrvs2zVWaR2AOQ5
        zHTMs7aZJRQLATfPqQFSuJXSjh6Ld5K2O1IQJI/MuhAsHkYuulS5eheNEKxDzP5o3GWlb96YJNen1
        rrFw/eV4gW2F53Q4rzy47OyCAstakgOMZTwEdS1QHMgtjck/53+8wX+RQTIYh82HhVl4WqmA0sCVH
        YpklrDcNRVakT26Swff8MZWUG/dWuLhtaGgliluNlD4fF76B8Es8vvjy2apzXtrcoYChOEcHk+M6W
        gAeuu7iQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKPXX-006Mye-1M;
        Fri, 14 Jul 2023 20:37:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67F793001FD;
        Fri, 14 Jul 2023 22:37:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CC4F245CA115; Fri, 14 Jul 2023 22:37:22 +0200 (CEST)
Date:   Fri, 14 Jul 2023 22:37:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] x86/urgent for v6.5-rc2
Message-ID: <20230714203722.GA3273303@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of CFI fixes for 6.5-rc2.

Thanks!

(also yeah, sometimes I can't type -- I only now noticed :/)

---

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_6.5_rc2

for you to fetch changes up to 535d0ae39185a266536a1e97ff9a8956d7fbb9df:

  x86/cfi: Only define poison_cfi() if CONFIG_X86_KERNEL_IBT=y (2023-07-11 10:17:55 +0200)

----------------------------------------------------------------
Fix kCFI/FineIBT weaknesses

The primary bug Alyssa noticed was that with FineIBT enabled function
prologues have a spurious ENDBR instruction:

  __cfi_foo:
	endbr64
	subl	$hash, %r10d
	jz	1f
	ud2
	nop
  1:
  foo:
	endbr64 <--- *sadface*

This means that any indirect call that fails to target the __cfi symbol
and instead targets (the regular old) foo+0, will succeed due to that
second ENDBR.

Fixing this lead to the discovery of a single indirect call that was
still doing this: ret_from_fork(), since that's an assembly stub the
compmiler would not generate the proper kCFI indirect call magic and it
would not get patched.

Brian came up with the most comprehensive fix -- convert the thing to C
with only a very thin asm wrapper. This ensures the kernel thread
boostrap is a proper kCFI call.

While discussing all this, Kees noted that kCFI hashes could/should be
poisoned to seal all functions whose address is never taken, further
limiting the valid kCFI targets -- much like we already do for IBT.

So what was a 'simple' observation and fix cascaded into a bunch of
inter-related CFI infrastructure fixes.

----------------------------------------------------------------
Brian Gerst (2):
      x86/32: Remove schedule_tail_wrapper()
      x86: Rewrite ret_from_fork() in C

Ingo Molnar (1):
      x86/cfi: Only define poison_cfi() if CONFIG_X86_KERNEL_IBT=y

Peter Zijlstra (4):
      x86/cfi: Extend {JMP,CAKK}_NOSPEC comment
      x86/alternative: Rename apply_ibt_endbr()
      x86/cfi: Extend ENDBR sealing to kCFI
      x86/fineibt: Poison ENDBR at +0

 arch/um/kernel/um_arch.c             |  2 +-
 arch/x86/entry/entry_32.S            | 53 +++++++--------------------
 arch/x86/entry/entry_64.S            | 33 ++++-------------
 arch/x86/include/asm/alternative.h   |  2 +-
 arch/x86/include/asm/ibt.h           |  2 +-
 arch/x86/include/asm/nospec-branch.h |  4 ++
 arch/x86/include/asm/switch_to.h     |  4 +-
 arch/x86/kernel/alternative.c        | 71 ++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/module.c             |  2 +-
 arch/x86/kernel/process.c            | 22 ++++++++++-
 10 files changed, 120 insertions(+), 75 deletions(-)
