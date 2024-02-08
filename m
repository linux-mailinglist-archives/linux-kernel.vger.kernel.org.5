Return-Path: <linux-kernel+bounces-58067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F184E0CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33CF2826A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA548762C0;
	Thu,  8 Feb 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MP3uOHKf"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525B6EB4B;
	Thu,  8 Feb 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395921; cv=none; b=OAvLcAVJbz/2XS4vjtEkGug2YANv/D4fzrlJbDUGGUIXjRw9rBM17o965pNpUmRCwFcPlmT+PvcDqkksIDtz+SXzi1OJwmiZu58vTZQG/zE1DVI44LxuropdaNEolvAfFSyJoIl/U/WJGY5DLYR1QkoyL/6FkkUoM7RFEYlpuag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395921; c=relaxed/simple;
	bh=v6ar3XL4NmldOxqy4tm/6Yg673Ym1vs13mSEDPytD2Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSbu483/+5U61Foq+2Hznj3gGqQaU5BdiqLo1+rFaEULARByakSXBarr47FDcEbdwy9oU1eWXQkxvEx54FDJMArVlB4enL9paVcDwnCYBz1oP10JCr0CKn9mKFAwwwUm3zgsWJXEFiL1M9s9nx/lJxY8WePS2fBaBFUnaXTR/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=MP3uOHKf; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1707395919; x=1738931919;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=XpaOl328Z0sK2jVAZ5hfANv8ZvM8k9ggJCj6QG2taxk=;
  b=MP3uOHKfPOwlCftpmBijdPejoXr0QS0VOehEbfzK884JVMThBPCR7cfH
   2U4AbmLJz+ToGAqeRHadOUChb9wKMUrIx0IA4MlT0Ik2u7mC6aDdsHph9
   THw4FHwPJq7QW63U5wtdMSFDj3wCQEmVPre0YIRRF2T40huCqEF2vvCa1
   s=;
X-IronPort-AV: E=Sophos;i="6.05,253,1701129600"; 
   d="scan'208";a="64637088"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:38:36 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.44.209:48592]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.4.133:2525] with esmtp (Farcaster)
 id 8f6b3cd2-68f2-4838-a80e-f09091bf4d06; Thu, 8 Feb 2024 12:38:35 +0000 (UTC)
X-Farcaster-Flow-ID: 8f6b3cd2-68f2-4838-a80e-f09091bf4d06
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 12:38:32 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 12:38:32 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 8 Feb 2024 12:38:31 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 67924956; Thu,  8 Feb 2024 12:38:31 +0000 (UTC)
Date: Thu, 8 Feb 2024 12:38:31 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: Julien Grall <jgrall@amazon.com>, <stable@vger.kernel.org>, "Andrew
 Panyakin" <apanyaki@amazon.com>, Juergen Gross <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Rahul Singh <rahul.singh@arm.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>, Jeremy Fitzhardinge
	<jeremy.fitzhardinge@citrix.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/events: close evtchn after mapping cleanup
Message-ID: <ZcTLR9uUyfy9cNUk@amazon.de>
References: <20240124163130.31324-1-mheyne@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124163130.31324-1-mheyne@amazon.de>

On Wed, Jan 24, 2024 at 04:31:28PM +0000, Maximilian Heyne wrote:
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
> Cc: stable@vger.kernel.org
> Co-debugged-by: Andrew Panyakin <apanyaki@amazon.com>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Friendly ping. Did anyone find time to look at this?



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




