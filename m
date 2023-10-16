Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4D7CA138
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjJPIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJPIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:05:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D1DDC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:05:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B95CC433C7;
        Mon, 16 Oct 2023 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697443540;
        bh=eTb4IkeeflfPQpfL4Srr/m6zWcbbZMFZEA3IzGQ3xOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMu7HLQ9hayb57a81aWwHj4q2ewTi/nRGjFs7IUkr9ness11wlR0cQMFWSj+yn5aM
         QqdZzNRwD5BZvdC0ldOOaLjFTFGvaZ/hEUW3ATIc4v3mjGikOi75dyzEEx6Vj7MzEq
         h89FcRrL5nhAzGPsDymJ5i606G1QslTbiNYf2Xq0=
Date:   Mon, 16 Oct 2023 10:04:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, anshuman.khandual@arm.com,
        alexandru.elisei@arm.com, sashal@kernel.org, maz@kernel.org,
        james.morse@arm.com, pcc@google.com, scott@os.amperecomputing.com,
        ebiederm@xmission.com, haibinzhang@tencent.com,
        hewenliang4@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v5.15 00/15] arm64: Fix a concurrency issue in
 emulation_proc_handler()
Message-ID: <2023101601-varnish-attendee-fae2@gregkh>
References: <20231011100655.979626-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011100655.979626-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:06:40AM +0000, Jinjie Ruan wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> In linux-6.1, the related code is refactored in commit 124c49b1b5d9
> ("arm64: armv8_deprecated: rework deprected instruction handling") and this
> issue was incidentally fixed. This patch set try to adapt the refactoring
> patches to stable 5.15 to solve the problem of repeated addition of linked
> lists described below.
> 
> How to reproduce:
> CONFIG_ARMV8_DEPRECATED=y, CONFIG_SWP_EMULATION=y, and CONFIG_DEBUG_LIST=y,
> then launch two shell executions:
>        #!/bin/bash
>        while [ 1 ];
>        do
>            echo 1 > /proc/sys/abi/swp
>        done
> 
> or "echo 1 > /proc/sys/abi/swp" and then launch two shell executions:
>        #!/bin/bash
>        while [ 1 ];
>        do
>            echo 0 > /proc/sys/abi/swp
>        done
> 
> In emulation_proc_handler(), read and write operations are performed on
> insn->current_mode. In the concurrency scenario, mutex only protects
> writing insn->current_mode, and not protects the read. Suppose there are
> two concurrent tasks, task1 updates insn->current_mode to INSN_EMULATE
> in the critical section, the prev_mode of task2 is still the old data
> INSN_UNDEF of insn->current_mode. As a result, two tasks call
> update_insn_emulation_mode twice with prev_mode = INSN_UNDEF and
> current_mode = INSN_EMULATE, then call register_emulation_hooks twice,
> resulting in a list_add double problem.
> 
> commit 124c49b1b5d9 ("arm64: armv8_deprecated: rework deprected instruction
> handling") remove the dynamic registration and unregistration so remove the
> register_undef_hook() function, so the below problem was incidentally
> fixed.
> 
> Call trace:
>  __list_add_valid+0xd8/0xe4
>  register_undef_hook+0x94/0x13c
>  update_insn_emulation_mode+0xd0/0x12c
>  emulation_proc_handler+0xd8/0xf4
>  proc_sys_call_handler+0x140/0x250
>  proc_sys_write+0x1c/0x2c
>  new_sync_write+0xec/0x18c
>  vfs_write+0x214/0x2ac
>  ksys_write+0x70/0xfc
>  __arm64_sys_write+0x24/0x30
>  el0_svc_common.constprop.0+0x7c/0x1bc
>  do_el0_svc+0x2c/0x94
>  el0_svc+0x20/0x30
>  el0_sync_handler+0xb0/0xb4
>  el0_sync+0x160/0x180
> 
> Call trace:
>  __list_del_entry_valid+0xac/0x110
>  unregister_undef_hook+0x34/0x80
>  update_insn_emulation_mode+0xf0/0x180
>  emulation_proc_handler+0x8c/0xd8
>  proc_sys_call_handler+0x1d8/0x208
>  proc_sys_write+0x14/0x20
>  new_sync_write+0xf0/0x190
>  vfs_write+0x304/0x388
>  ksys_write+0x6c/0x100
>  __arm64_sys_write+0x1c/0x28
>  el0_svc_common.constprop.4+0x68/0x188
>  do_el0_svc+0x24/0xa0
>  el0_svc+0x14/0x20
>  el0_sync_handler+0x90/0xb8
>  el0_sync+0x160/0x180
> 
> The first 5 patches is a patch set which provides context for subsequent
> refactoring 9 patches, especially commit 0f2cb928a154 ("arm64:
> consistently pass ESR_ELx to die()") which modify do_undefinstr() to add a
> ESR_ELx value arg, and then commit 61d64a376ea8 ("arm64: split EL0/EL1
> UNDEF handlers") splits do_undefinstr() handler into separate
> do_el0_undef() and do_el1_undef() handlers.
> 
> The 9 patches after that is another refactoring patch set, which is in
> preparation for the main rework commit 124c49b1b5d9 ("arm64:
> armv8_deprecated: rework deprected instruction handling"). To remove struct
> undef_hook, commit bff8f413c71f ("arm64: factor out EL1 SSBS emulation
> hook") factor out EL1 SSBS emulation hook, which also avoid call
> call_undef_hook() in do_el1_undef(), commit f5962add74b6 ("arm64: rework
> EL0 MRS emulation") factor out EL0 MRS emulation hook, which also prepare
> for replacing call_undef_hook() in do_el0_undef(). To replace
> call_undef_hook() function, commit 61d64a376ea8 ("arm64: split EL0/EL1
> UNDEF handlers") split the do_undefinstr() into do_el0_undef() and
> do_el1_undef() functions, and commit dbfbd87efa79 ("arm64: factor insn
> read out of call_undef_hook()") factor user_insn_read() from
> call_undef_hook() so the main rework patch can replace the
> call_undef_hook() in do_el0_undef().
> 
> The last patch is a bugfix for the main rework patch.
> 
> I've tested this with userspace programs which use each of the
> deprecated instructions on Raspberry Pi 4B KVM/Qemu, and I've concurrently
> modified the support level for each of the features back-and-forth between
> HW and emulated to check that there are no oops or above repeated addition
> or deletion call trace.
> 
> Fixes: af483947d472 ("arm64: fix oops in concurrently setting insn_emulation sysctls")
> Cc: stable@vger.kernel.org#5.15.x
> Cc: gregkh@linuxfoundation.org
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

All now queued up, thanks.

greg k-h
