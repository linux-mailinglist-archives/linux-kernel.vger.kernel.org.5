Return-Path: <linux-kernel+bounces-65177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A058548F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F42282B74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64F31B964;
	Wed, 14 Feb 2024 12:12:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE118E1A;
	Wed, 14 Feb 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912722; cv=none; b=UlZ1fyDxJdpsWqwHmYcOVucbMOmrYiZX4QcEjFbkP8CJXyq1VSRQcbBweuSFcxEPdbfjG7+k7ktGNKnAE50OlqyLtUziccc7yvwewGqgXV8dC0canYsFlKK5UZh9mkY7DnP0xZiymlsXTup+WuxwqreftUlOPvGKP0PImAzhg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912722; c=relaxed/simple;
	bh=j+XSQDp5gAB2zYgP/6g0xpngtgILZ2D4XzQghGi3R4Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS+Ccvv2Ed2YeEIO+ybd45yxtSKIsEpEP9ECdk+lGE+wiGMobvjmPy/Fl0QfcF5ulOGaNDOjhhWugnq179T4Ws5fsjywEEZruE42Zp5GiyNZAwQCrgln9P/Au1+7yIG36X4zvLEmEGVgeB8cxp/WHujVSTvBqnJT3fikKS6BV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZcR16JDXz6899G;
	Wed, 14 Feb 2024 20:08:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C93E9140D1D;
	Wed, 14 Feb 2024 20:11:54 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:11:54 +0000
Date: Wed, 14 Feb 2024 12:11:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <20240214121153.00005c97@huawei.com>
In-Reply-To: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 06 Feb 2024 14:15:32 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Smatch caught that cxl_cper_post_event() is called with a spinlock held
> or preemption disabled.[1]  The callback takes the device lock to
> perform address translation and therefore might sleep.  The record data
> is released back to BIOS in ghes_clear_estatus() which requires it to be
> copied for use in the workqueue.
> 
> Copy the record to a lockless list and schedule a work item to process
> the record outside of atomic context.
> 
> [1] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

+CC tracing folk for the splat below (the second one as first one is fixed!)

Lock debugging is slow (on an emulated machine) :(
Testing with my gitlab.com/jic23/qemu cxl-2024-02-05-draft branch
which is only one I've put out with the FW first injection patches so far

For reference without this patch I got a nice spat identifying the original bug.
So far so good.

With this patch (and tp_printk in command line and trace points enabled)
[  193.048229] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  193.049636] {1}[Hardware Error]: event severity: recoverable
[  193.050472] {1}[Hardware Error]:  Error 0, type: recoverable
[  193.051337] {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
[  193.052270] {1}[Hardware Error]:   section length: 0x90
[  193.053402] {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
[  193.055036] {1}[Hardware Error]:   00000010: 000e0000 00000000 00000005 00000000  ................
[  193.058592] {1}[Hardware Error]:   00000020: 00000180 00000000 1626fa24 17b3b158  ........$.&.X...
[  193.062289] {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
[  193.065959] {1}[Hardware Error]:   00000040: 000007d0 00000000 0fc00307 05210300  ..............!.
[  193.069782] {1}[Hardware Error]:   00000050: 72690000 6d207361 00326d65 00000000  ..iras mem2.....
[  193.072760] {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
[  193.074062] {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
[  193.075346] {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................

I rebased after this so now we get the smaller print - but that's not really relevant here.

[  193.086589] cxl_general_media: memdev=mem1 host=0000:0e:00.0 serial=5 log=Warning : time=1707903675590441508 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=128 flags='0x1' handle=0 related_handle=0 maint_op_class=0 : dpa=7c0 dpa_flags='0x10' descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT|POISON_LIST_OVERFLOW' type='0x3' transaction_type='0xc0' channel=3 rank=33 device=5 comp_id=69 72 61 73 20 6d 65 6d 32 00 00 00 00 00 00 00 validity_flags='CHANNEL|RANK|DEVICE|COMPONENT'
[  193.087181]                                                                                                                                                                                                                                                      
[  193.087361] =============================
[  193.087399] [ BUG: Invalid wait context ]
[  193.087504] 6.8.0-rc3 #1200 Not tainted
[  193.087660] -----------------------------
[  193.087858] kworker/3:0/31 is trying to lock:
[  193.087966] ffff0000c0ce1898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x148/0x1c8
[  193.089754] other info that might help us debug this:
[  193.089820] context-{5:5}[  193.089900] 8 locks held by kworker/3:0/31:
[  193.089990]  #0: ffff0000c0018738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x154/0x500
[  193.090439]  #1: ffff800083793de0 (cxl_cper_work){+.+.}-{0:0}, at: process_one_work+0x154/0x500
[  193.090718]  #2: ffff800082883310 (cxl_cper_rw_sem){++++}-{4:4}, at: cxl_cper_work_fn+0x2c/0xb0
[  193.091019]  #3: ffff0000c0a7b1a8 (&dev->mutex){....}-{4:4}, at: pci_dev_lock+0x28/0x48
[  193.091431]  #4: ffff800082738f18 (tracepoint_iter_lock){....}-{2:2}, at: trace_event_buffer_commit+0xd8/0x2c8
[  193.091772]  #5: ffff8000826b3ce8 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x124/0x398
[  193.092031]  #6: ffff8000826b3d40 (console_srcu){....}-{0:0}, at: console_flush_all+0x88/0x4b0
[  193.092363]  #7: ffff8000826b3ef8 (console_owner){....}-{0:0}, at: console_flush_all+0x1bc/0x4b0
[  193.092799] stack backtrace:
[  193.092973] CPU: 3 PID: 31 Comm: kworker/3:0 Not tainted 6.8.0-rc3 #1200
[  193.093118] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown unknown
[  193.093468] Workqueue: events cxl_cper_work_fn
[  193.093782] Call trace:
[  193.094004]  dump_backtrace+0xa4/0x130
[  193.094145]  show_stack+0x20/0x38
[  193.094231]  dump_stack_lvl+0x60/0xb0
[  193.094315]  dump_stack+0x18/0x28
[  193.094395]  __lock_acquire+0x9e8/0x1ee8
[  193.094477]  lock_acquire+0x118/0x2e8
[  193.094557]  _raw_spin_lock+0x50/0x70
[  193.094820]  pl011_console_write+0x148/0x1c8
[  193.094904]  console_flush_all+0x218/0x4b0
[  193.094985]  console_unlock+0x74/0x140
[  193.095066]  vprintk_emit+0x230/0x398
[  193.095146]  vprintk_default+0x40/0x58
[  193.095226]  vprintk+0x98/0xb0
[  193.095306]  _printk+0x64/0x98
[  193.095385]  trace_event_buffer_commit+0x138/0x2c8
[  193.095467]  trace_event_raw_event_cxl_general_media+0x1a8/0x280 [cxl_core]
[  193.096191]  __traceiter_cxl_general_media+0x50/0x78 [cxl_core]
[  193.096359]  cxl_event_trace_record+0x204/0x2d0 [cxl_core]
[  193.096520]  cxl_cper_event_call+0xb0/0xe0 [cxl_pci]

The rw_sem is held to protect the callback pointer.

[  193.096713]  cxl_cper_work_fn+0x7c/0xb0
[  193.096808]  process_one_work+0x1f4/0x500
[  193.096891]  worker_thread+0x1f0/0x3f0
[  193.096971]  kthread+0x110/0x120
[  193.097052]  ret_from_fork+0x10/0x20

So I'm not sure how to fix this or if we even want to.

We could try and release locks before calling the tracepoint but that looks
very fiddly and would require ghes.c to be able to see more of the
CXL tracepoint infrastructure which isn't great.

Just because I was feeling cheeky I did a quick test with following.
I have a sneaky suspicion this won't got down well even though it 'fixes'
our issue...  My google fu / lore search terms are failing to find
much previous discussion of this.

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9ff8a439d674..7ee45f22f56f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2957,7 +2957,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
        iter->ent = fbuffer->entry;
        event_call->event.funcs->trace(iter, 0, event);
        trace_seq_putc(&iter->seq, 0);
-       printk("%s", iter->seq.buffer);
+       printk_deferred("%s", iter->seq.buffer);

        raw_spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
 }

My assumption is similar views will apply here to Peter Zijlstra's comment on
not using printk_deferred.

https://lore.kernel.org/all/20231010141244.GM377@noisy.programming.kicks-ass.net/

Note I also tried the hacks Peter links to from there. They trip issues in the initial
CPER print - so I assume not appropriate here.

So I'm thinking this is a won't fix - wait for the printk rework to land and
assume this will be resolved as well?

Jonathan

> ---
> Changes in v2:
> - djbw: device_lock() sleeps so we need to call the callback in process context
> - iweiny: create work queue to handle processing the callback
> - Link to v1: https://lore.kernel.org/r/20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com
> ---
>  drivers/acpi/apei/ghes.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 7b7c605166e0..aa41e9128118 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -679,6 +679,12 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>   */
>  static DECLARE_RWSEM(cxl_cper_rw_sem);
>  static cxl_cper_callback cper_callback;
> +static LLIST_HEAD(cxl_cper_rec_list);
> +struct cxl_cper_work_item {
> +	struct llist_node node;
> +	enum cxl_event_type event_type;
> +	struct cxl_cper_event_rec rec;
> +};
>  
>  /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
>  
> @@ -706,9 +712,34 @@ static cxl_cper_callback cper_callback;
>  	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
>  		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
>  
> +static void cxl_cper_work_fn(struct work_struct *work)
> +{
> +	struct llist_node *entries, *cur, *n;
> +	struct cxl_cper_work_item *wi;
> +
> +	guard(rwsem_read)(&cxl_cper_rw_sem);
> +
> +	entries = llist_del_all(&cxl_cper_rec_list);
> +	if (!entries)
> +		return;

Unfortunately the rw_sem is protecting the cper_callback itself
so I'm not sure how to do this.

Maybe a dance where cper_callback creates the record but returns
the data to here so that we can release the lock and issue
the tracepoint?

> +	/* Process oldest to newest */
> +	entries = llist_reverse_order(entries);
> +	llist_for_each_safe(cur, n, entries) {
> +		wi = llist_entry(cur, struct cxl_cper_work_item, node);
> +
> +		if (cper_callback)
> +			cper_callback(wi->event_type, &wi->rec);
> +		kfree(wi);
> +	}
> +}
> +static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
> +
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>  				struct cxl_cper_event_rec *rec)
>  {
> +	struct cxl_cper_work_item *wi;
> +
>  	if (rec->hdr.length <= sizeof(rec->hdr) ||
>  	    rec->hdr.length > sizeof(*rec)) {
>  		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> @@ -721,9 +752,16 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  		return;
>  	}
>  
> -	guard(rwsem_read)(&cxl_cper_rw_sem);
> -	if (cper_callback)
> -		cper_callback(event_type, rec);
> +	wi = kmalloc(sizeof(*wi), GFP_ATOMIC);
> +	if (!wi) {
> +		pr_err(FW_WARN "CXL CPER failed to allocate work item\n");
> +		return;
> +	}
> +
> +	wi->event_type = event_type;
> +	memcpy(&wi->rec, rec, sizeof(wi->rec));
> +	llist_add(&wi->node, &cxl_cper_rec_list);
> +	schedule_work(&cxl_cper_work);
>  }
>  
>  int cxl_cper_register_callback(cxl_cper_callback callback)
> 
> ---
> base-commit: 99bd3cb0d12e85d5114425353552121ec8f93adc
> change-id: 20240201-cxl-cper-smatch-82b129498498
> 
> Best regards,


