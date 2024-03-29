Return-Path: <linux-kernel+bounces-124380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B579E89169B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D084B21EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699D535AE;
	Fri, 29 Mar 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z8R+Vk9A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8A524DE;
	Fri, 29 Mar 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707563; cv=none; b=anC7bDZEAyOTRsEqWtY3AKYuHgjK6mK3wC64t8jeCLWMJOxR2ACSgACr1eloQIAki/8DqfjMftiuwRKLHkZbzin/EvMXys/j8EkmzgjqVxXQgZFPnb+cy2z68ndCXbPhvsGQCXgIh12EHknn4Bgrpa6qZRldGm/9kJdbYjzTeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707563; c=relaxed/simple;
	bh=YKi4gOrn9DGeJgVs3gZWjPTkOjRhWQkQ0AhfqNFExlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHleFajYUVRZhDhLtbxF6Y50WhOKm+0SEfbDEhJ65IplIWssjwZHEHhARajAR/BBJ8/reY+RQvmYict+v5yAwqmm9rkfrpjT4rQxiLrOH+A+t06v04L8DaTQJOolM6/xN0/m5kWtuB+KH/cBUcqRomvVjXQy6wvY93tSJwAj9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z8R+Vk9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8B3C433C7;
	Fri, 29 Mar 2024 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711707563;
	bh=YKi4gOrn9DGeJgVs3gZWjPTkOjRhWQkQ0AhfqNFExlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8R+Vk9AaVETwWhRaEMlScRY8lYNj5Vjj5HXh5+UfgzyDFzsNyncqajG1/O+QJ4+q
	 UiqGM7PveSSoOuk4zROteC9zZMoQ49sxqIGCp9U1CD7P/eNV24eFABJm2R3108fX0r
	 rkdpJuStXtuOyvOmJ0FwjFlEDS3fwfgoq6hRGTmE=
Date: Fri, 29 Mar 2024 11:19:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Paniakin <apanyaki@amazon.com>
Cc: stable@vger.kernel.org, Benjamin Herrenschmidt <benh@amazon.com>,
	Maximilian Heyne <mheyne@amazon.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Julien Grall <jgrall@amazon.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4] xen/events: close evtchn after mapping cleanup
Message-ID: <2024032905-divisibly-unarmored-f080@gregkh>
References: <20240303044539.2673085-1-apanyaki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303044539.2673085-1-apanyaki@amazon.com>

On Sat, Mar 02, 2024 at 08:45:39PM -0800, Andrew Paniakin wrote:
> From: Andrew Panyakin <apanyaki@amazon.com>
> 
> From: Maximilian Heyne <mheyne@amazon.de>
> 
> Commit fa765c4b4aed2d64266b694520ecb025c862c5a9 upstream
> 
> shutdown_pirq and startup_pirq are not taking the
> irq_mapping_update_lock because they can't due to lock inversion. Both
> are called with the irq_desc->lock being taking. The lock order,
> however, is first irq_mapping_update_lock and then irq_desc->lock.
> 
> This opens multiple races:
> - shutdown_pirq can be interrupted by a function that allocates an event
>   channel:
> 
>   CPU0                        CPU1
>   shutdown_pirq {
>     xen_evtchn_close(e)
>                               __startup_pirq {
>                                 EVTCHNOP_bind_pirq
>                                   -> returns just freed evtchn e
>                                 set_evtchn_to_irq(e, irq)
>                               }
>     xen_irq_info_cleanup() {
>       set_evtchn_to_irq(e, -1)
>     }
>   }
> 
>   Assume here event channel e refers here to the same event channel
>   number.
>   After this race the evtchn_to_irq mapping for e is invalid (-1).
> 
> - __startup_pirq races with __unbind_from_irq in a similar way. Because
>   __startup_pirq doesn't take irq_mapping_update_lock it can grab the
>   evtchn that __unbind_from_irq is currently freeing and cleaning up. In
>   this case even though the event channel is allocated, its mapping can
>   be unset in evtchn_to_irq.
> 
> The fix is to first cleanup the mappings and then close the event
> channel. In this way, when an event channel gets allocated it's
> potential previous evtchn_to_irq mappings are guaranteed to be unset already.
> This is also the reverse order of the allocation where first the event
> channel is allocated and then the mappings are setup.
> 
> On a 5.10 kernel prior to commit 3fcdaf3d7634 ("xen/events: modify internal
> [un]bind interfaces"), we hit a BUG like the following during probing of NVMe
> devices. The issue is that during nvme_setup_io_queues, pci_free_irq
> is called for every device which results in a call to shutdown_pirq.
> With many nvme devices it's therefore likely to hit this race during
> boot because there will be multiple calls to shutdown_pirq and
> startup_pirq are running potentially in parallel.
> 
>   ------------[ cut here ]------------
>   blkfront: xvda: barrier or flush: disabled; persistent grants: enabled; indirect descriptors: enabled; bounce buffer: enabled
>   kernel BUG at drivers/xen/events/events_base.c:499!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 44 PID: 375 Comm: kworker/u257:23 Not tainted 5.10.201-191.748.amzn2.x86_64 #1
>   Hardware name: Xen HVM domU, BIOS 4.11.amazon 08/24/2006
>   Workqueue: nvme-reset-wq nvme_reset_work
>   RIP: 0010:bind_evtchn_to_cpu+0xdf/0xf0
>   Code: 5d 41 5e c3 cc cc cc cc 44 89 f7 e8 2b 55 ad ff 49 89 c5 48 85 c0 0f 84 64 ff ff ff 4c 8b 68 30 41 83 fe ff 0f 85 60 ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00
>   RSP: 0000:ffffc9000d533b08 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
>   RDX: 0000000000000028 RSI: 00000000ffffffff RDI: 00000000ffffffff
>   RBP: ffff888107419680 R08: 0000000000000000 R09: ffffffff82d72b00
>   R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000001ed
>   R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000002
>   FS:  0000000000000000(0000) GS:ffff88bc8b500000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 0000000002610001 CR4: 00000000001706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    ? show_trace_log_lvl+0x1c1/0x2d9
>    ? show_trace_log_lvl+0x1c1/0x2d9
>    ? set_affinity_irq+0xdc/0x1c0
>    ? __die_body.cold+0x8/0xd
>    ? die+0x2b/0x50
>    ? do_trap+0x90/0x110
>    ? bind_evtchn_to_cpu+0xdf/0xf0
>    ? do_error_trap+0x65/0x80
>    ? bind_evtchn_to_cpu+0xdf/0xf0
>    ? exc_invalid_op+0x4e/0x70
>    ? bind_evtchn_to_cpu+0xdf/0xf0
>    ? asm_exc_invalid_op+0x12/0x20
>    ? bind_evtchn_to_cpu+0xdf/0xf0
>    ? bind_evtchn_to_cpu+0xc5/0xf0
>    set_affinity_irq+0xdc/0x1c0
>    irq_do_set_affinity+0x1d7/0x1f0
>    irq_setup_affinity+0xd6/0x1a0
>    irq_startup+0x8a/0xf0
>    __setup_irq+0x639/0x6d0
>    ? nvme_suspend+0x150/0x150
>    request_threaded_irq+0x10c/0x180
>    ? nvme_suspend+0x150/0x150
>    pci_request_irq+0xa8/0xf0
>    ? __blk_mq_free_request+0x74/0xa0
>    queue_request_irq+0x6f/0x80
>    nvme_create_queue+0x1af/0x200
>    nvme_create_io_queues+0xbd/0xf0
>    nvme_setup_io_queues+0x246/0x320
>    ? nvme_irq_check+0x30/0x30
>    nvme_reset_work+0x1c8/0x400
>    process_one_work+0x1b0/0x350
>    worker_thread+0x49/0x310
>    ? process_one_work+0x350/0x350
>    kthread+0x11b/0x140
>    ? __kthread_bind_mask+0x60/0x60
>    ret_from_fork+0x22/0x30
>   Modules linked in:
>   ---[ end trace a11715de1eee1873 ]---
> 
> Fixes: d46a78b05c0e ("xen: implement pirq type event channels")
> Co-debugged-by: Andrew Panyakin <apanyaki@amazon.com>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> [apanyaki: backport to v5.4-stable]
> Signed-off-by: Andrew Paniakin <apanyaki@amazon.com>
> ---
> Compare to upstream patch this one does not have close_evtchn flag
> because there is no need to handle static event channels.
> This feature was added only in 58f6259b7a08f ("xen/evtchn: Introduce new
> IOCTL to bind static evtchn")

All now qeued up, thanks.

greg k-h

