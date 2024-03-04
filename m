Return-Path: <linux-kernel+bounces-91169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE5870A94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B928265F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5557995B;
	Mon,  4 Mar 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NPDwU+G/"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA07992E;
	Mon,  4 Mar 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580019; cv=none; b=S7WS5NdEueZRvGjcAEaEi+mo/rC1+UVDXezswK3uMSGUgBukgvKZxQcFiURQq2pW46ckq4lLBhCcw6xuX9/Vy8pEVeWwgOtVw8KpdSMDD4I2lMVHdPThMJD6PvlDnJdAJvdh8wMU2J2nQ10hrLE/2lnOKilgQpyhFmJwLqCS7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580019; c=relaxed/simple;
	bh=KMZ17CS97Wx1dyNNC561RxoogvvvOrIxCQIZ7jfuiLA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=crp6gKQyXYKIIBDMouv9ZI7kLp1gYTSFasFYT0EOiMDB9CCnlNsSsjq2X9VXPtkwg0yHyOnvO5WPW0/ZfOdVtctlmaRQ+68Bk1bCx7Hrs+YfG9ZDf3seh9HT2Adc9mzd+c0NSMzvdJ+GkfA7m6K7q0nUHZREMgUSN5OxVHYMdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NPDwU+G/; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709580018; x=1741116018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hp/Pxo/mK3yvk0cAXe1HmgajLOcF/spYOUraUsiYG28=;
  b=NPDwU+G/kaGboT5VNUgH/3ALJNxcGJejqjEY9QjHgikIM0PanjsaRp0L
   FZ6GXpcW+hPGKu5HK5GoCrBsp9HuT6z6nfd0ChrHWAI3Pq+PIS9Nc6Pvs
   o01Q+a1a+w4v32Eap53qRd6fJSiKiAS9++76txdKbJIUnK9UqR1bTi8pA
   w=;
X-IronPort-AV: E=Sophos;i="6.06,204,1705363200"; 
   d="scan'208";a="278517762"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 19:20:13 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:13445]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.111:2525] with esmtp (Farcaster)
 id b368db1f-8b69-4baf-b72b-e07fa55b7192; Mon, 4 Mar 2024 19:20:12 +0000 (UTC)
X-Farcaster-Flow-ID: b368db1f-8b69-4baf-b72b-e07fa55b7192
Received: from EX19D026EUB004.ant.amazon.com (10.252.61.64) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 19:20:12 +0000
Received: from uc3ecf78c6baf56.ant.amazon.com (10.187.170.53) by
 EX19D026EUB004.ant.amazon.com (10.252.61.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 19:20:09 +0000
Date: Mon, 4 Mar 2024 11:20:06 -0800
From: Andrew Panyakin <apanyaki@amazon.com>
To: <stable@vger.kernel.org>
CC: Andrew Panyakin <apanyaki@amazon.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Julien Grall
	<jgrall@amazon.com>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Maximilian Heyne <mheyne@amazon.de>, Benjamin Herrenschmidt
	<benh@amazon.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1] xen/events: close evtchn after mapping cleanup
Message-ID: <20240304192006.GA3517973@uc3ecf78c6baf56.ant.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D026EUB004.ant.amazon.com (10.252.61.64)

From: Maximilian Heyne <mheyne@amazon.de>

Commit fa765c4b4aed2d64266b694520ecb025c862c5a9 upstream

shutdown_pirq and startup_pirq are not taking the
irq_mapping_update_lock because they can't due to lock inversion. Both
are called with the irq_desc->lock being taking. The lock order,
however, is first irq_mapping_update_lock and then irq_desc->lock.

This opens multiple races:
- shutdown_pirq can be interrupted by a function that allocates an event
  channel:

  CPU0                        CPU1
  shutdown_pirq {
    xen_evtchn_close(e)
                              __startup_pirq {
                                EVTCHNOP_bind_pirq
                                  -> returns just freed evtchn e
                                set_evtchn_to_irq(e, irq)
                              }
    xen_irq_info_cleanup() {
      set_evtchn_to_irq(e, -1)
    }
  }

  Assume here event channel e refers here to the same event channel
  number.
  After this race the evtchn_to_irq mapping for e is invalid (-1).

- __startup_pirq races with __unbind_from_irq in a similar way. Because
  __startup_pirq doesn't take irq_mapping_update_lock it can grab the
  evtchn that __unbind_from_irq is currently freeing and cleaning up. In
  this case even though the event channel is allocated, its mapping can
  be unset in evtchn_to_irq.

The fix is to first cleanup the mappings and then close the event
channel. In this way, when an event channel gets allocated it's
potential previous evtchn_to_irq mappings are guaranteed to be unset already.
This is also the reverse order of the allocation where first the event
channel is allocated and then the mappings are setup.

On a 5.10 kernel prior to commit 3fcdaf3d7634 ("xen/events: modify internal
[un]bind interfaces"), we hit a BUG like the following during probing of NVMe
devices. The issue is that during nvme_setup_io_queues, pci_free_irq
is called for every device which results in a call to shutdown_pirq.
With many nvme devices it's therefore likely to hit this race during
boot because there will be multiple calls to shutdown_pirq and
startup_pirq are running potentially in parallel.

  ------------[ cut here ]------------
  blkfront: xvda: barrier or flush: disabled; persistent grants: enabled; indirect descriptors: enabled; bounce buffer: enabled
  kernel BUG at drivers/xen/events/events_base.c:499!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 44 PID: 375 Comm: kworker/u257:23 Not tainted 5.10.201-191.748.amzn2.x86_64 #1
  Hardware name: Xen HVM domU, BIOS 4.11.amazon 08/24/2006
  Workqueue: nvme-reset-wq nvme_reset_work
  RIP: 0010:bind_evtchn_to_cpu+0xdf/0xf0
  Code: 5d 41 5e c3 cc cc cc cc 44 89 f7 e8 2b 55 ad ff 49 89 c5 48 85 c0 0f 84 64 ff ff ff 4c 8b 68 30 41 83 fe ff 0f 85 60 ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00
  RSP: 0000:ffffc9000d533b08 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
  RDX: 0000000000000028 RSI: 00000000ffffffff RDI: 00000000ffffffff
  RBP: ffff888107419680 R08: 0000000000000000 R09: ffffffff82d72b00
  R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000001ed
  R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000002
  FS:  0000000000000000(0000) GS:ffff88bc8b500000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000000002610001 CR4: 00000000001706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   ? show_trace_log_lvl+0x1c1/0x2d9
   ? show_trace_log_lvl+0x1c1/0x2d9
   ? set_affinity_irq+0xdc/0x1c0
   ? __die_body.cold+0x8/0xd
   ? die+0x2b/0x50
   ? do_trap+0x90/0x110
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? do_error_trap+0x65/0x80
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? exc_invalid_op+0x4e/0x70
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? asm_exc_invalid_op+0x12/0x20
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? bind_evtchn_to_cpu+0xc5/0xf0
   set_affinity_irq+0xdc/0x1c0
   irq_do_set_affinity+0x1d7/0x1f0
   irq_setup_affinity+0xd6/0x1a0
   irq_startup+0x8a/0xf0
   __setup_irq+0x639/0x6d0
   ? nvme_suspend+0x150/0x150
   request_threaded_irq+0x10c/0x180
   ? nvme_suspend+0x150/0x150
   pci_request_irq+0xa8/0xf0
   ? __blk_mq_free_request+0x74/0xa0
   queue_request_irq+0x6f/0x80
   nvme_create_queue+0x1af/0x200
   nvme_create_io_queues+0xbd/0xf0
   nvme_setup_io_queues+0x246/0x320
   ? nvme_irq_check+0x30/0x30
   nvme_reset_work+0x1c8/0x400
   process_one_work+0x1b0/0x350
   worker_thread+0x49/0x310
   ? process_one_work+0x350/0x350
   kthread+0x11b/0x140
   ? __kthread_bind_mask+0x60/0x60
   ret_from_fork+0x22/0x30
  Modules linked in:
  ---[ end trace a11715de1eee1873 ]---

Fixes: d46a78b05c0e ("xen: implement pirq type event channels")
Cc: stable@vger.kernel.org
Co-debugged-by: Andrew Panyakin <apanyaki@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
Compare to upstream patch this one does not have close_evtchn flag
because there is no need to handle static event channels.
This feature was added only in 58f6259b7a08f ("xen/evtchn: Introduce new
IOCTL to bind static evtchn")

 drivers/xen/events/events_base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 00f8e349921d..96b96516c980 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -937,8 +937,8 @@ static void shutdown_pirq(struct irq_data *data)
 		return;
 
 	do_mask(info, EVT_MASK_REASON_EXPLICIT);
-	xen_evtchn_close(evtchn);
 	xen_irq_info_cleanup(info);
+	xen_evtchn_close(evtchn);
 }
 
 static void enable_pirq(struct irq_data *data)
@@ -982,8 +982,6 @@ static void __unbind_from_irq(unsigned int irq)
 		unsigned int cpu = cpu_from_irq(irq);
 		struct xenbus_device *dev;
 
-		xen_evtchn_close(evtchn);
-
 		switch (type_from_irq(irq)) {
 		case IRQT_VIRQ:
 			per_cpu(virq_to_irq, cpu)[virq_from_irq(irq)] = -1;
@@ -1001,6 +999,7 @@ static void __unbind_from_irq(unsigned int irq)
 		}
 
 		xen_irq_info_cleanup(info);
+		xen_evtchn_close(evtchn);
 	}
 
 	xen_free_irq(irq);
-- 
2.40.1


