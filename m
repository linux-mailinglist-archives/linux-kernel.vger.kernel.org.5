Return-Path: <linux-kernel+bounces-27603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27D82F2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA61C237CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A871CF9C;
	Tue, 16 Jan 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeIC3MBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D51CF83;
	Tue, 16 Jan 2024 16:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7D1C433F1;
	Tue, 16 Jan 2024 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705424360;
	bh=RV6RHxZ8pi7Vlm2CfQaWVbRHsR98YGEaSTvb/bPpLA8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SeIC3MBdlWckJdKsiVjPDC2t7XY0nXII0yImtIvMrDbQvf0HcjcJli2i/b0i9Fql+
	 6tVXwArZQYUuRk5yUPg3Noq3Td2NeMldaMvj04YTSzZbptRjDqR34gBd3jNooVQ0Mo
	 2c4gh8TCW7/Emss7q1O9PTAEoWxXJaSKI8vg+Z7VpXYoHRw8NC7hUw4JeLExeNI7Y+
	 Hnxqd1/YBaw5I8G/9ve/+vxVa1/VAye9N0BpDZ3loe3WLIrf7kzYpD1uOmjGkHP5cG
	 ve+IOWTGel/85ZO+pIBcsQGyEe1fyozlidSsxJFUxiP/6ld3KUH1OSmjq/H2xGhHA0
	 Kcj+PNSaH8J8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9DEA5CE04A3; Tue, 16 Jan 2024 08:59:17 -0800 (PST)
Date: Tue, 16 Jan 2024 08:59:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, quic_neeraju@quicinc.com,
	joel@joelfernandes.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix WARN_ON_ONCE() in the
 rcu_nocb_bypass_lock()
Message-ID: <7167b868-4160-47f0-8dd6-68c2af71e591@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240110081128.18683-1-qiang.zhang1211@gmail.com>
 <ZaFkKPDTpCTXdyvT@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFkKPDTpCTXdyvT@lothringen>

On Fri, Jan 12, 2024 at 05:09:12PM +0100, Frederic Weisbecker wrote:
> On Wed, Jan 10, 2024 at 04:11:28PM +0800, Zqiang wrote:
> > For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
> > CONFIG_RCU_LAZY=y, here are the following scenarios that will trigger
> > WARN_ON_ONCE() in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended().
> > 
> >         CPU2                                               CPU11
> > kthread                                                   
> > rcu_nocb_cb_kthread                                       ksys_write
> > rcu_do_batch                                              vfs_write
> > rcu_torture_timer_cb                                      proc_sys_write
> > __kmem_cache_free                                         proc_sys_call_handler
> > kmemleak_free                                             drop_caches_sysctl_handler
> > delete_object_full                                        drop_slab
> > __delete_object                                           shrink_slab
> > put_object                                                lazy_rcu_shrink_scan
> > call_rcu                                                  rcu_nocb_flush_bypass
> > __call_rcu_commn                                            rcu_nocb_bypass_lock
> >                                                             raw_spin_trylock(&rdp->nocb_bypass_lock) fail
> >                                                             atomic_inc(&rdp->nocb_lock_contended);
> > rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
> >  WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
> >                             |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|
> > 
> > This commit therefore use the rcu_nocb_try_flush_bypass() instead of
> > rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan(), if the nocb_bypass
> > queue is being flushed, the rcu_nocb_try_flush_bypass will return directly.
> > 
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Queued with Joel's and Frederic's Reviewed-by, thank you all!

							Thanx, Paul

