Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7D79E41C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjIMJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbjIMJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:48:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A700199D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:48:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694598521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQEwfUkV8H19i9zBZle+8XE3Io4n8Wakgi4pw+rr94s=;
        b=cfMaOQ6rQZAD2Zc4V2zUNZHFXIgLD5qG6gKy+n0PsD+3BnxmYeRsFnxmEDQZ2o8IHYqcVm
        IBNtCxYoabCJIRLKUlucfIz8LPDjJRs8JZMFTTEiCzezDppDQxEgPEZ4LqGGL+sbuag9S3
        VeGNkRyGBZzyteKxlR2xBpcSbsn4m1VYOD5EvrUG9H02HxIvLTu2U6b3uvymslwONJbhRn
        IdRJSniOC1if1uR/4tf25DrP36U5xIrNusDQnqs+rprUaa8gfu8jupmjC9mLLdgMm9jGN6
        cSAGO+fPdGIad0ykCLnXPEdYtdPJbu1AZNaoq1bQ/vzej2sQw7XedNMD1/U6hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694598521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQEwfUkV8H19i9zBZle+8XE3Io4n8Wakgi4pw+rr94s=;
        b=8uagnMXnIBVrl6gPJF8zV32bJI6rtXhJcw2+1XovNqnxhAxxbK4SkN6o8GHntBn8Bn0ExM
        iaAESFgbAl7PikCA==
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: obsolete usage of GFP_ATOMIC at
 building node tree
In-Reply-To: <20230604070255.172700-1-o-takashi@sakamocchi.jp>
References: <20230604070255.172700-1-o-takashi@sakamocchi.jp>
Date:   Wed, 13 Sep 2023 11:54:39 +0206
Message-ID: <87jzsuv1xk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-04, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
> The flag of GFP_ATOMIC is given to the call of kmalloc when building node
> tree, but the call is not atomic context. The call of
> fw_core_handle_bus_reset() and fw_core_remove_card() builds the tree,
> while they are done in specific workqueue or pci remove callback.

The comment is incorrect about not being in atomic
context. fw_core_handle_bus_reset() calls build_tree() with the
card->lock spinlock held. With 6.6-rc1 I see:

[   12.555784] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[   12.555808] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 70, name: kworker/1:2
[   12.555814] preempt_count: 1, expected: 0
[   12.555820] INFO: lockdep is turned off.
[   12.555824] irq event stamp: 208
[   12.555828] hardirqs last  enabled at (207): [<c00000000111e414>] ._raw_spin_unlock_irq+0x44/0x80
[   12.555850] hardirqs last disabled at (208): [<c00000000110ff94>] .__schedule+0x854/0xfe0
[   12.555859] softirqs last  enabled at (188): [<c000000000f73504>] .addrconf_verify_rtnl+0x2c4/0xb70
[   12.555872] softirqs last disabled at (182): [<c000000000f732b0>] .addrconf_verify_rtnl+0x70/0xb70
[   12.555884] CPU: 1 PID: 70 Comm: kworker/1:2 Tainted: G S                 6.6.0-rc1 #1
[   12.555893] Hardware name: PowerMac7,2 PPC970 0x390202 PowerMac
[   12.555898] Workqueue: firewire_ohci .bus_reset_work [firewire_ohci]
[   12.555939] Call Trace:
[   12.555944] [c000000009677830] [c0000000010d83c0] .dump_stack_lvl+0x8c/0xd0 (unreliable)
[   12.555963] [c0000000096778b0] [c000000000140270] .__might_resched+0x320/0x340
[   12.555978] [c000000009677940] [c000000000497600] .__kmem_cache_alloc_node+0x390/0x460
[   12.555993] [c000000009677a10] [c0000000003fe620] .__kmalloc+0x70/0x310
[   12.556007] [c000000009677ac0] [c0003d00004e2268] .fw_core_handle_bus_reset+0x2c8/0xba0 [firewire_core]
[   12.556060] [c000000009677c20] [c0003d0000491190] .bus_reset_work+0x330/0x9b0 [firewire_ohci]
[   12.556079] [c000000009677d10] [c00000000011d0d0] .process_one_work+0x280/0x6f0
[   12.556094] [c000000009677e10] [c00000000011d8a0] .worker_thread+0x360/0x500
[   12.556107] [c000000009677ef0] [c00000000012e3b4] .kthread+0x154/0x160
[   12.556120] [c000000009677f90] [c00000000000bfa8] .start_kernel_thread+0x10/0x14

John Ogness
