Return-Path: <linux-kernel+bounces-76441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7510885F769
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317342851DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C04596E;
	Thu, 22 Feb 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/jKcYuy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10C208A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602427; cv=none; b=uomB76EO8u2FzKkE5jwDXV0VE0UY9xGjpTIiQ8FuvXm7KgdKarhSr7mnGYpxgpOmuk24b71hBCpmYtGtDzMpVqWK5MTrw5e/JI+oEXaZJVpYJtoLo1mOvEkNkkRrR46V7Fy5I6scyYykMZ/FgTK7hs/hFlSZ2JLrB+U7Z+i1kXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602427; c=relaxed/simple;
	bh=ttzzkLU0tkloAcPUyFKKE9pN4F+8RiVVYIalZ+A/NYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilwtgwIRZKqbf/YlYgF4gf/0fu+Vg5b3XDW51hO+xILk77vKAjli9mnwgBDY9xYPfqYsIGlobbB1HO97YT16ZlKT3xWyXQyU+tA+xLqMSt+Lra/bVxMtV506sSEHXRGaOPJq9Xbrol3u1A40BwLJt4IwU6oLNEvoU+pdOO1JWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/jKcYuy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708602425; x=1740138425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ttzzkLU0tkloAcPUyFKKE9pN4F+8RiVVYIalZ+A/NYk=;
  b=R/jKcYuy51O82z2PTogm7rRHmpqK+Q3kq/UXyhZCe0hZSfq0qVlWZvs+
   PpquIpLnxidKu1nJLLURQ1IKd/PWLTuBjK5lr/9qpDZPx6ic9uTRxwEDh
   OrqCDv1uYtsPrXobN+VrEoF4ydr6fNgvZes7up2ctDjHbtxhMR9AK0C8K
   28OxHWucHoPQG74y/0Jqt8goxpgq1N6qLNAVvg29DrQxovkEOo+1sKekS
   WI8G7bzeT7UgyazCKqRICAJHTuWWBGiz1YZX92/MrWdbjv1Coixu9Z8BE
   BkJLQr9L8ewuFf7Lycaasl1J8a0KaHhx36rqAgXKrAvXBdyrtH0CirxLg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13522214"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13522214"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10160890"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:47:03 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B1E8411F81D;
	Thu, 22 Feb 2024 13:46:59 +0200 (EET)
Date: Thu, 22 Feb 2024 11:46:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mei: vsc: Call wake_up() in the threaded IRQ
 handler
Message-ID: <Zdc0M9Uf2zn63P0e@kekkonen.localdomain>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-2-sakari.ailus@linux.intel.com>
 <MW5PR11MB5787130A75404600F47A7D9C8D562@MW5PR11MB5787.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5787130A75404600F47A7D9C8D562@MW5PR11MB5787.namprd11.prod.outlook.com>

Hi Wentong,

On Thu, Feb 22, 2024 at 03:26:18AM +0000, Wu, Wentong wrote:
> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
> > wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT.
> 
> Does this mean we can't use wake_up() in isr? 

Good question. A lot of callers currently do.

In this case, handle_edge_irq() takes the raw spinlock and acquiring the
wake queue spinlock in wake_up() leads to sleeping IRQs disabled (see
below).

I don't think there's any harm in moving the wake_up() to the threaded
handler.

-------8<---------------------------
[   54.216989] =============================
[   54.218458] [ BUG: Invalid wait context ]
[   54.219913] 6.8.0-rc2+ #1972 Not tainted
[   54.221493] -----------------------------
[   54.223165] swapper/4/0 is trying to lock:
[   54.224756] ffff888112d04688 (&tp->xfer_wait){....}-{3:3}, at: __wake_up_common_lock+0x25/0x60
[   54.226426] other info that might help us debug this:
[   54.228189] context-{2:2}
[   54.229817] no locks held by swapper/4/0.
[   54.231453] stack backtrace:
[   54.233078] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.8.0-rc2+ #1972
[   54.234720] Hardware name: Dell Inc. XPS 9315/0WWXF6, BIOS 1.3.0 08/16/2022
[   54.236361] Call Trace:
[   54.237983]  <IRQ>
[   54.239594]  dump_stack_lvl+0x6a/0x9f
[   54.241147]  __lock_acquire+0x43e/0x11fb
[   54.242704]  ? mark_lock+0x96/0x34d
[   54.244212]  ? check_chain_key+0xe5/0x132
[   54.245759]  ? __wake_up_common_lock+0x25/0x60
[   54.247312]  lock_acquire+0x128/0x27c
[   54.248848]  ? __wake_up_common_lock+0x25/0x60
[   54.250384]  _raw_spin_lock_irqsave+0x3e/0x51
[   54.251922]  ? __wake_up_common_lock+0x25/0x60
[   54.253524]  __wake_up_common_lock+0x25/0x60
[   54.255049]  vsc_tp_isr+0x1e/0x28 [mei_vsc_hw]
[   54.256569]  __handle_irq_event_percpu+0xb4/0x1aa
[   54.258054]  handle_irq_event_percpu+0xf/0x32
[   54.259550]  handle_irq_event+0x34/0x53
[   54.260982]  handle_edge_irq+0xb0/0xcf
[   54.262440]  handle_irq_desc+0x39/0x43
[   54.263898]  intel_gpio_irq+0x105/0x15a
[   54.265348]  __handle_irq_event_percpu+0xb4/0x1aa
[   54.266792]  handle_irq_event_percpu+0xf/0x32
[   54.268244]  handle_irq_event+0x34/0x53
[   54.269634]  handle_fasteoi_irq+0xa5/0x131
[   54.271018]  __common_interrupt+0xdc/0xeb
[   54.272392]  common_interrupt+0x96/0xc1
[   54.273754]  </IRQ>
[   54.275109]  <TASK>
[   54.276391]  asm_common_interrupt+0x22/0x40
[   54.277733] RIP: 0010:cpuidle_enter_state+0x171/0x253
[   54.279071] Code: 8b 73 04 83 cf ff 49 89 c6 e8 62 fe df ff 31 ff e8 65 29 79 ff 45 84 ff 74 07 31 ff e8 0d c3 7f ff e8 fc 91 85 ff fb 45 85 e4 <0f> 88 ba 00 00 00 48 8b 04 24 49 63 cc 48 6b d1 68 49 29 c6 48 89
[   54.280496] RSP: 0018:ffffc900001a7e88 EFLAGS: 00000202
[   54.281935] RAX: 0000000000000004 RBX: ffffe8ffffa310c0 RCX: 000000000000001f
[   54.283382] RDX: 0000000c9f7cf88f RSI: ffffffff82103e63 RDI: ffffffff8209b592
[   54.284828] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000001
[   54.286274] R10: 0000000001151268 R11: 0000000000000020 R12: 0000000000000004
[   54.287699] R13: ffffffff8266fec0 R14: 0000000c9f7cf88f R15: 0000000000000000
[   54.289127]  ? cpuidle_enter_state+0x16d/0x253
[   54.290564]  cpuidle_enter+0x2a/0x38
[   54.291987]  do_idle+0x190/0x204
[   54.293394]  cpu_startup_entry+0x2a/0x2c
[   54.294797]  start_secondary+0x12d/0x12d
[   54.296198]  secondary_startup_64_no_verify+0x15e/0x16b
[   54.297595]  </TASK>
-------8<---------------------------

> 
> BR,
> Wentong
> 
> > This leads to sleeping in atomic context.
> > 
> > Move the wake_up() call to the threaded IRQ handler vsc_tp_thread_isr()
> > where it can be safely called.
> > 
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/misc/mei/vsc-tp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> > 6f4a4be6ccb5..2b69ada9349e 100644
> > --- a/drivers/misc/mei/vsc-tp.c
> > +++ b/drivers/misc/mei/vsc-tp.c
> > @@ -416,8 +416,6 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
> > 
> >  	atomic_inc(&tp->assert_cnt);
> > 
> > -	wake_up(&tp->xfer_wait);
> > -
> >  	return IRQ_WAKE_THREAD;
> >  }
> > 
> > @@ -425,6 +423,8 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void
> > *data)  {
> >  	struct vsc_tp *tp = data;
> > 
> > +	wake_up(&tp->xfer_wait);
> > +
> >  	if (tp->event_notify)
> >  		tp->event_notify(tp->event_notify_context);
> > 

-- 
Regards,

Sakari Ailus

