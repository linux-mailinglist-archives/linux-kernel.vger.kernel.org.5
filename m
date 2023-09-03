Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD1790B7B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjICKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 06:45:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5158F120;
        Sun,  3 Sep 2023 03:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8D8ACE09B6;
        Sun,  3 Sep 2023 10:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA10C433C8;
        Sun,  3 Sep 2023 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693737948;
        bh=FtW4elepbA3dl8TVrQJUZMvhrxmha+pYiCSF4zMey1s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EFATlrKLyAsiiuAuOzeNMPH1zcZQvILtwKIJGszRr0hM7i6glk0zBfBRnIKTCLM2n
         /P0XK78fBmvRUdN5A5QorA+8xxjV2TYPwqM6sbiEG4PCfa7IHyaOlQYyipjrO2++TX
         o8efnD+pj/W84tgKcnQ/gkwfrirzSVH/8RGRpG+9Q02H8s6y9BY3zyATWKTv788mpG
         6Eooeo3xQF5MYKFsgl7gYQqOxA68ra+XYJ3Hlhu2lsQDxnxrmhE/8j2xqts+jn0IWp
         jPyfXAsVsXB3SteVmoRKTHgP0nOUPZGf2r41haFmn6zru7DA9Q5aaAzxJ6l7f50ZPe
         JuZrCNDBR+nKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6DB44CE0C90; Sun,  3 Sep 2023 03:45:48 -0700 (PDT)
Date:   Sun, 3 Sep 2023 03:45:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Ziwei Dai <ziwei.dai@unisoc.com>, Hugh Dickins <hughd@google.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <bbbb0bdf-553e-4fde-90d6-446e920b357e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 08:34:44AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > I've just made the transition from 6.4.14 to 6.5.1 and my Haswell-EP X99 machine took way longer to boot (55 seconds instead of 16 seconds). The following trace was seen in dmesg which was also not present on 6.4.14 (and might be the cause for the long boot time); this is on bare metal.
> > 
> > [  +0,000021] CPU: 13 PID: 338 Comm: kworker/13:1 Not tainted 6.5.1-3.1-cachyos-lto #1 c414458bd5e5db6e6f9addca639c3a78811b24e7

This looks like part of the splat was omitted.

> > [  +0,000003] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> > [  +0,000002] Workqueue: events kfree_rcu_work
> > [  +0,000004] RIP: 0010:kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000004] Code: 80 04 00 00 80 bf 89 04 00 00 00 75 24 85 c0 75 20 31 f6 ba 02 00 00 00 e8 72 50 bd ff 5b 41 5c 41 5e 41 5f 5d e9 05 df ba ff <0f> 0b e9 54 ff ff ff a9 ff ff ff 7f 74 e5 80 bf 88 04 00 00 >
> > [  +0,000002] RSP: 0018:ffff8fe4611cbd90 EFLAGS: 00010206
> > [  +0,000002] RAX: 0000000000000048 RBX: ffff8fe8e04f7000 RCX: fffffffffffffffc
> > [  +0,000002] RDX: 0000000000000000 RSI: ffff8fe8e04f7000 RDI: ffff8fe9df95cac8
> > [  +0,000001] RBP: ffff8fe4611cbe40 R08: 8080808080808080 R09: fefefefefefefeff
> > [  +0,000002] R10: 000073746e657665 R11: 8080000000000000 R12: 0000000000000000
> > [  +0,000001] R13: ffff8fe4611cbde0 R14: ffff8fe9df95cac8 R15: ffff8fe4611cbdd0
> > [  +0,000001] FS:  0000000000000000(0000) GS:ffff8fe9df940000(0000) knlGS:0000000000000000
> > [  +0,000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0,000002] CR2: 00007f8287bff008 CR3: 00000005e8f73001 CR4: 00000000001706e0
> > [  +0,000001] Call Trace:
> > [  +0,000003]  <TASK>
> > [  +0,000001]  ? __warn+0x9e/0x160
> > [  +0,000004]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000004]  ? report_bug+0x112/0x180
> > [  +0,000003]  ? handle_bug+0x3d/0x80
> > [  +0,000003]  ? exc_invalid_op+0x16/0x40
> > [  +0,000003]  ? asm_exc_invalid_op+0x16/0x20
> > [  +0,000005]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000003]  kfree_rcu_work+0xcd/0x200
> > [  +0,000005]  process_one_work+0x21a/0x620
> > [  +0,000004]  ? wake_up_process+0x1d3/0x1720
> > [  +0,000004]  worker_thread+0x12b/0x4c0
> > [  +0,000003]  ? compat_get_bitmap+0xa0/0xa0
> > [  +0,000003]  kthread+0xf1/0x160
> > [  +0,000004]  ? getreg32+0x1e0/0x1e0
> > [  +0,000003]  ret_from_fork+0x30/0x40
> > [  +0,000005]  ? getreg32+0x1e0/0x1e0
> > [  +0,000003]  ret_from_fork_asm+0x11/0x20
> > [  +0,000005]  </TASK>
> > [  +0,000001] ---[ end trace 0000000000000000 ]---
> 
> Later, the reporter came up with another trace:
> 
> > I just saw a patch from Hugh Dickins on the LKML (https://www.spinics.net/lists/kernel/msg4919906.html) and indeed, with my self-compiled 6.5.1 Kernel, the trace is now downgraded to a warning (see below). However, the slow boot still remains and also my games won't load up due to missing a rendering device. But that might be a different issue.
> > 
> > 
> > [  +0,000227] ------------[ cut here ]------------
> > [  +0,000002] WARNING: CPU: 21 PID: 345 at kernel/rcu/tree.c:2952 kvfree_rcu_bulk+0x13b/0x160

In -stable v6.5.1, this line is the following:

	rcu_lock_acquire(&rcu_callback_map);

None of the patches in the github URL listed in the full version of that
bugzilla comment affect this file, but some of them could potentially
produce a slowdown.

Nevertheless adding Uladzislau on CC for his thoughts.

In the meantime, I echo Artem S. Tashkinov's suggestion of bisection.

							Thanx, Paul

> > [  +0,000011] Modules linked in: pkcs8_key_parser crypto_user fuse loop zram bpf_preload ip_tables x_tables ext4 crc32c_generic mbcache crc16 jbd2 usbhid amdgpu mfd_core drm_buddy drm_suballoc_helper crc32c_i>
> > [  +0,000027] CPU: 21 PID: 345 Comm: kworker/21:1 Not tainted 6.5.1-3.1-cachyos-lto #1 de6495663682da00bbe0d80bdc163dd768b25681
> > [  +0,000004] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> > [  +0,000002] Workqueue: events kfree_rcu_work
> > [  +0,000006] RIP: 0010:kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000006] Code: 80 04 00 00 80 bf 89 04 00 00 00 75 24 85 c0 75 20 31 f6 ba 02 00 00 00 e8 52 50 bd ff 5b 41 5c 41 5e 41 5f 5d e9 e5 de ba ff <0f> 0b e9 54 ff ff ff a9 ff ff ff 7f 74 e5 80 bf 88 04 00 00 >
> > [  +0,000003] RSP: 0018:ffff8df57a5ffd90 EFLAGS: 00010206
> > [  +0,000003] RAX: 0000000000000020 RBX: ffff8df44cb40000 RCX: fffffffffffffffc
> > [  +0,000003] RDX: 0000000000000000 RSI: ffff8df44cb40000 RDI: ffff8df91fb5cac8
> > [  +0,000002] RBP: ffff8df57a5ffe40 R08: 8080808080808080 R09: fefefefefefefeff
> > [  +0,000002] R10: 000073746e657665 R11: 8080000000000000 R12: 0000000000000000
> > [  +0,000002] R13: ffff8df57a5ffde0 R14: ffff8df91fb5cac8 R15: ffff8df57a5ffdd0
> > [  +0,000002] FS:  0000000000000000(0000) GS:ffff8df91fb40000(0000) knlGS:0000000000000000
> > [  +0,000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0,000002] CR2: 000055fe51d3f700 CR3: 000000065de7d002 CR4: 00000000001706e0
> > [  +0,000002] Call Trace:
> > [  +0,000003]  <TASK>
> > [  +0,000002]  ? __warn+0x9e/0x160
> > [  +0,000006]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000005]  ? report_bug+0x112/0x180
> > [  +0,000005]  ? handle_bug+0x3d/0x80
> > [  +0,000005]  ? exc_invalid_op+0x16/0x40
> > [  +0,000003]  ? asm_exc_invalid_op+0x16/0x20
> > [  +0,000007]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000006]  kfree_rcu_work+0xcd/0x200
> > [  +0,000006]  process_one_work+0x21a/0x620
> > [  +0,000006]  ? wake_up_process+0x1d3/0x1720
> > [  +0,000005]  worker_thread+0x12b/0x4c0
> > [  +0,000005]  ? compat_get_bitmap+0xa0/0xa0
> > [  +0,000004]  kthread+0xf1/0x160
> > [  +0,000006]  ? getreg32+0x1e0/0x1e0
> > [  +0,000004]  ret_from_fork+0x30/0x40
> > [  +0,000007]  ? getreg32+0x1e0/0x1e0
> > [  +0,000003]  ret_from_fork_asm+0x11/0x20
> > [  +0,000009]  </TASK>
> > [  +0,000001] ---[ end trace 0000000000000000 ]---
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217864
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217864
> 
> -- 
> An old man doll... just what I always wanted! - Clara
