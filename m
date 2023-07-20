Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D675B399
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGTPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjGTPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097F193;
        Thu, 20 Jul 2023 08:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DC661B4D;
        Thu, 20 Jul 2023 15:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184C3C433D9;
        Thu, 20 Jul 2023 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689868529;
        bh=ZMg9hZkMlQ+mN5Thys3B/BSypxgLGiRrFv0lCdgtRag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U8MPFO0Yji8RyVvrAtgWq+rgT01yfrI2x87wqEEFhYs6ZyUDYJ46KTgLTgYazS47V
         IyQygNQN0IA3HFIDJSXbOmRRJeWIRSKC+zEnL4EtT/MYYScucg0iNvlaRQKODC6dlf
         HbgESByEuyol5QbPv2Qed5dlWGGMk0Vk4KHi7zXWMEPrstflwRtfbd0z4JzACz1W71
         Ez1E9cIxzdfgYh9zgm58khyu73CK0E4eMt4IZKilQIEERVTRkmeetz7XeWXH4tKlmH
         ZxiUXG5NWNbU7g63e5/TpVjN5kkDcra0aLGEYC+Ox+wVx2SOKY5Kk4Q68t2XLu96SW
         3xN6bJKscPSRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A888FCE025D; Thu, 20 Jul 2023 08:55:28 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:55:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2023071940-suspect-ominous-4a6a@gregkh>
 <20230720132714.GA3726096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720132714.GA3726096@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
> On Wed, Jul 19, 2023 at 05:06:39PM +0200, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 6.4.4 kernel.
> > 
> > All users of the 6.4 kernel series must upgrade.
> > 
> > The updated 6.4.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> I have been consistently hitting the following splat with rcutorture's TREE03
> test on 6.4.4. This happened with 6.4.4-rc3 as well.
> 
> Happens at:
> 		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
> 
> So likely RCU boosting is failing:
> 
> The full TREE03 splat:
> [   54.243588] ------------[ cut here ]------------
> [   54.244547] rcu-torture: rcu_torture_boost started
> [   54.247643] WARNING: CPU: 12 PID: 166 at kernel/rcu/rcutorture.c:2227 rcu_torture_stats_print+0x5b2/0x620
> [   54.273082] Modules linked in:
> [   54.278336] CPU: 12 PID: 166 Comm: rcu_torture_sta Not tainted 6.4.4-g62813c2d2a36 #1
> [   54.288540] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
> [   54.307525] Code: 00 00 48 8b 05 3f 6c 46 02 e9 4a fe ff ff 0f 0b e9 02 fd ff ff 0f 0b e9 09 fd ff ff 0f 0b e9 10 fd ff ff 0f 0b e9 17 fd ff ff <0f> 0b e9 1e fd ff ff 0f 0b e9 21 fd ff ff e8 0b 54 ff ff 84 c0 0f
> [   54.331276] RSP: 0000:ffff9fef805efe08 EFLAGS: 00010202
> [   54.338374] RAX: 0000000000000000 RBX: ffff9fef805efe88 RCX: 00000000ffffdfff
> [   54.347738] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> [   54.358923] RBP: ffff9fef805efe30 R08: 00000000ffffdfff R09: 00000000ffffdfff
> [   54.368209] R10: ffffffff94e59280 R11: ffffffff94e59280 R12: 0000000000000001
> [   54.377367] R13: 0000000000000000 R14: 00000000000002fc R15: ffffffff93514000
> [   54.386739] FS:  0000000000000000(0000) GS:ffff9c901f500000(0000) knlGS:0000000000000000
> [   54.397130] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.404585] CR2: 0000000000000000 CR3: 000000000308e000 CR4: 00000000000006e0
> [   54.413884] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   54.423118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   54.432192] Call Trace:
> [   54.435634]  <TASK>
> [   54.438512]  ? rcu_torture_stats_print+0x5b2/0x620
> [   54.444904]  ? __warn+0x7c/0x130
> [   54.449221]  ? rcu_torture_stats_print+0x5b2/0x620
> [   54.455737]  ? report_bug+0x171/0x1a0
> [   54.460935]  ? handle_bug+0x3c/0x70
> [   54.465874]  ? exc_invalid_op+0x17/0x70
> [   54.471336]  ? asm_exc_invalid_op+0x1a/0x20
> [   54.477092]  ? __pfx_rcu_torture_stats+0x10/0x10
> [   54.483472]  ? rcu_torture_stats_print+0x5b2/0x620
> [   54.490029]  ? rcu_torture_stats_print+0x28a/0x620
> [   54.496565]  ? finish_task_switch.isra.0+0x7e/0x240
> [   54.503261]  rcu_torture_stats+0x25/0x70
> [   54.508686]  kthread+0xe3/0x110
> [   54.513141]  ? __pfx_kthread+0x10/0x10
> [   54.518330]  ret_from_fork+0x2c/0x50
> [   54.523356]  </TASK>
> [   54.526500] ---[ end trace 0000000000000000 ]---

Agreed, this indicates that RCU priority boosting isn't getting its
job done.  Does this consistently fail about a minute into the run,
or is it less deterministic than that?

> Also other issues in 6.4.4, I am seeing RCU failures with TREE07 about 40
> minutes into the test. This warning indicates that an rcu_torture object from
> the rcu_torture pool is still allocated which is an indiciation that RCU is
> not working.
> 
> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> 
> However, if we are to believe the '9', it appears the object did made it
> quite some till the end of the pipe array but not until the free pool.

This is from this if/for statement, correct?

		stutter_waited = stutter_wait("rcu_torture_writer");
		if (stutter_waited &&
		    !atomic_read(&rcu_fwd_cb_nodelay) &&
		    !cur_ops->slow_gps &&
		    !torture_must_stop() &&
		    boot_ended)
			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
				if (list_empty(&rcu_tortures[i].rtort_free) &&
				    rcu_access_pointer(rcu_torture_current) !=
				    &rcu_tortures[i]) {
					tracing_off();
					show_rcu_gp_kthreads();
					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
					rcu_ftrace_dump(DUMP_ALL);
				}

If so, this happens when there was a stutter wait, but RCU grace
periods failed to clear out the backlog during the several seconds that
rcutorture was forced idle.  This might be related to the RCU priority
boosting failure, in which a preempted reader persisted across the
stutter interval.

> The full TREE07 splat:
> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> [ 2169.489413] WARNING: CPU: 4 PID: 130 at kernel/rcu/rcutorture.c:1584 rcu_torture_writer+0x7f2/0xd80
> [ 2169.504064] Modules linked in:
> [ 2169.508957] CPU: 4 PID: 130 Comm: rcu_torture_wri Not tainted 6.4.4-g62813c2d2a36 #2
> [ 2169.521735] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 2169.540908] RIP: 0010:rcu_torture_writer+0x7f2/0xd80
> [ 2169.548542] Code: 15 8b 62 45 02 49 8d 45 e8 48 39 c2 74 bf e8 85 03 08 00 41 8b 55 f8 48 c7 c6 d0 f7 e0 9d 48 c7 c7 d7 7b 28 9e e8 ce 29 f7 ff <0f> 0b 8b 05 9a 48 45 02 85 c0 75 97 89 d8 87 05 8e 48 45 02 85 c0
> [ 2169.578445] RSP: 0000:ffffa645804cfe20 EFLAGS: 00010282
> [ 2169.586793] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000ffffdfff
> [ 2169.598069] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000009ffb
> [ 2169.609359] RBP: ffffa645804cff10 R08: 00000000ffffdfff R09: 00000000ffffdfff
> [ 2169.620717] R10: ffffffff9e659220 R11: ffffffff9e659220 R12: 0000000000000017
> [ 2169.631918] R13: ffffffff9f166b60 R14: 0000000000000000 R15: 0000000000000001
> [ 2169.643365] FS:  0000000000000000(0000) GS:ffff8b3a5f300000(0000) knlGS:0000000000000000
> [ 2169.655249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2169.663207] CR2: 0000000000000000 CR3: 000000001562e000 CR4: 00000000000006e0
> [ 2169.672806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2169.682194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2169.693530] Call Trace:
> [ 2169.698054]  <TASK>
> [ 2169.701786]  ? rcu_torture_writer+0x7f2/0xd80
> [ 2169.708853]  ? __warn+0x7c/0x120
> [ 2169.714088]  ? rcu_torture_writer+0x7f2/0xd80
> [ 2169.721066]  ? report_bug+0x15d/0x180
> [ 2169.726125]  ? handle_bug+0x3c/0x70
> [ 2169.730948]  ? exc_invalid_op+0x17/0x70
> [ 2169.736238]  ? asm_exc_invalid_op+0x1a/0x20
> [ 2169.742047]  ? rcu_torture_writer+0x7f2/0xd80
> [ 2169.747907]  ? __pfx_rcu_torture_writer+0x10/0x10
> [ 2169.754175]  kthread+0xcb/0xf0
> [ 2169.758407]  ? __pfx_kthread+0x10/0x10
> [ 2169.763501]  ret_from_fork+0x2c/0x50
> [ 2169.768420]  </TASK>
> [ 2169.771445] ---[ end trace 0000000000000000 ]---
> [ 2169.777698] Dumping ftrace buffer:
> [ 2169.782470]    (ftrace buffer empty)
> [ 2169.787241] ------------[ cut here ]------------
> 
> 
> I will continue to monitor and debug these but since I recently re-started
> testing stable (my infra was down for a long time), I don't have any
> reference for when these started happening.

I haven't been seeing this in v6.4, though there is always the possibility
that your hardware setup has timing differences from mine, so maybe my
testing simply isn't seeing this.

And thank you very much for testing this!!!

							Thanx, Paul
