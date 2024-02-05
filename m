Return-Path: <linux-kernel+bounces-53830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBE84A70D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3951F2A3F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990360863;
	Mon,  5 Feb 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO6gwLqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF23605BB;
	Mon,  5 Feb 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162073; cv=none; b=NPJg1GoHHMzsZfCUfLdQySeDqzAWW/i5kzmGygKb2WZvIfxjs/P5o9EQI2Ry64mxJpOkG1pn09kyyF57TgrwI0YDyvgma0p4PJZD/LOfXP+mEGfzlXONHqHG62P3x1t6kTlWz7Ht4353a2nQVqqosWMM0wGk5syh9VQclnM4K8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162073; c=relaxed/simple;
	bh=Tf5sWpsOVkaiiHhZyJvaTkhmhB8pV5gkbffdgP5l+YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp6UYbZS9p+20G9LhcDEh3B2EgbFF0IcZBhqXcANtBsKoLiwqlV/Hx/EGwe+EmQsGxL7/viCXl4XT6BrHbjOB6Ge2VpEfw4ATx1HgYDkQeQNPNG2j4xCQIxBhOK5pEJW7+PtogZ20gb8N+uGWNAXcj2UPD6V8L2C+7X/AGD1vAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO6gwLqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0028AC433F1;
	Mon,  5 Feb 2024 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707162073;
	bh=Tf5sWpsOVkaiiHhZyJvaTkhmhB8pV5gkbffdgP5l+YQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TO6gwLqc8U5N2Ivy6mGSl7A3/NxKlGglLF83+CwVMBzkPNGdlGIgtO7XoxICgMxnb
	 o7BBGkwXPw60E6Dw1vI5O1u3GaK2HyQ2ziL2aArU+rTClRJTPEkPP92KYbUdSiTl4I
	 3THaI47XGTboNOlVEcxz531MqcYWik4T3hFw9rBYdLpNOtgyIQ00JlhT0SS2hJTSuj
	 MM/L+aKNDrLDyOlNKtqgQFyrVZouCvXB4H5J5Glb0ZEkq7eGDTVqvNfpuvUlgNxI3H
	 GRLluizGBtCB4N19ZgS0NcoB7b+CJDK9cMI3hwfFmYZYIJO6tONX3yvNZHNiTQr0AV
	 45I4Kfy7UeKvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9D83CCE1C10; Mon,  5 Feb 2024 11:41:10 -0800 (PST)
Date: Mon, 5 Feb 2024 11:41:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <a8386e9d-39f6-4bd5-8329-30550fb2745a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
 <ZcDdlRzpofn2cAuO@alley>
 <20240205132515.GF69174@google.com>
 <a6762ad5-62f2-41d4-bba7-c2d9dcb12498@paulmck-laptop>
 <ZcEfCM160K5cnzHx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcEfCM160K5cnzHx@slm.duckdns.org>

On Mon, Feb 05, 2024 at 07:46:48AM -1000, Tejun Heo wrote:
> On Mon, Feb 05, 2024 at 09:45:53AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 05, 2024 at 10:25:15PM +0900, Sergey Senozhatsky wrote:
> > > On (24/02/05 14:07), Petr Mladek wrote:
> > > > > Good point, if it does recur, I could try it on bare metal.
> > > > 
> > > > Please, me, John, and Sergey know if anyone see this again. I do not
> > > > feel comfortable when there is problem which might make consoles calm.
> > > 
> > > Agreed.
> > > 
> > > > Bisection identified this commit:
> > > > 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> > > 
> > > That commit triggered early boot use-after-free (per kasan) on
> > > my system, which probably could derail some things.
> > 
> > And enabling KASAN on next-20240130 got me that same KASAN report and
> > also suppressed the misbehavior, which is not surprising given that
> > KASAN quarantines free memory for some time.  Plus enabling KASAN
> > on recent -next does not trigger that KASAN report.
> > 
> > So my guess is that we can attribute my oddball test failures to
> > that use after free.  But I will of course continue testing.
> 
> Can someone paste the KASAN report?

Here you go!

							Thanx, Paul

------------------------------------------------------------------------

[    0.316453] ==================================================================
[    0.317646] BUG: KASAN: use-after-free in wq_update_node_max_active+0x123/0x810
[    0.318851] Read of size 8 at addr ffff88802109d788 by task swapper/0/0
[    0.319937] 
[    0.320195] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240130 #7935
[    0.321453] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.323299] Call Trace:
[    0.323700]  <TASK>
[    0.324043]  dump_stack_lvl+0x37/0x50
[    0.324653]  print_report+0xcb/0x620
[    0.325249]  ? wq_update_node_max_active+0x123/0x810
[    0.326066]  kasan_report+0xaf/0xe0
[    0.326639]  ? wq_update_node_max_active+0x123/0x810
[    0.327455]  kasan_check_range+0x39/0x1c0
[    0.328119]  wq_update_node_max_active+0x123/0x810
[    0.328903]  ? __pfx_mutex_lock+0x10/0x10
[    0.329567]  apply_wqattrs_commit+0x4e4/0xb80
[    0.330289]  ? __pfx_mutex_lock+0x10/0x10
[    0.330946]  apply_workqueue_attrs_locked+0x9e/0x110
[    0.331764]  alloc_workqueue+0xf76/0x18d0
[    0.332432]  ? __pfx_alloc_workqueue+0x10/0x10
[    0.333189]  ? kasan_unpoison+0x27/0x60
[    0.333818]  ? kasan_unpoison+0x27/0x60
[    0.334455]  ? __kasan_slab_alloc+0x30/0x70
[    0.335147]  ? __pfx_mutex_unlock+0x10/0x10
[    0.335831]  ? idr_alloc_u32+0x291/0x2c0
[    0.336479]  ? mutex_unlock+0x7e/0xd0
[    0.337085]  workqueue_init_early+0x69a/0xe70
[    0.337800]  ? __pfx_workqueue_init_early+0x10/0x10
[    0.338605]  ? kmem_cache_create_usercopy+0xcc/0x230
[    0.339421]  start_kernel+0x141/0x380
[    0.340023]  x86_64_start_reservations+0x18/0x30
[    0.340788]  x86_64_start_kernel+0xcf/0xe0
[    0.341465]  secondary_startup_64_no_verify+0x16d/0x17b
[    0.342334]  </TASK>
[    0.342703] 
[    0.342954] The buggy address belongs to the physical page:
[    0.343899] page:00000000a19a7ad3 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2109d
[    0.345471] flags: 0x100000000000000(node=0|zone=1)
[    0.346297] page_type: 0xffffffff()
[    0.346882] raw: 0100000000000000 ffffea0000842748 ffffea0000842748 0000000000000000
[    0.348184] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[    0.349518] page dumped because: kasan: bad access detected
[    0.350457] 
[    0.350706] Memory state around the buggy address:
[    0.351532]  ffff88802109d680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    0.352748]  ffff88802109d700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    0.353968] >ffff88802109d780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    0.355221]                       ^
[    0.355808]  ffff88802109d800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    0.357161]  ffff88802109d880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    0.358439] ==================================================================

