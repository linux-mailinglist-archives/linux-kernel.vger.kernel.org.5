Return-Path: <linux-kernel+bounces-24845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAC882C356
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72BD286AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B757316E;
	Fri, 12 Jan 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDtS86E1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999164CFF;
	Fri, 12 Jan 2024 16:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21C5C433F1;
	Fri, 12 Jan 2024 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705075755;
	bh=QvCLpQbO3roibGZLdHcYBlC9RXMzUp5wDxNcFNfizvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDtS86E1CjYvRCeba2u5/ZyxllA/WItnguD+vilx6MIYPR5Z4qFDUCwYUut7yS6Im
	 4r2Du/TY+ckF62JVP5AJoRXM1cPPGBhjsxSijhymKZDopm6+vdCj7oRcCcuuJVqhoa
	 a5bAfRcnwu2aWMPNgqXY0Ri8UcnGBZPS79wH8FWiaknwY/wQ3njNE2Lpu43iiAc/Kb
	 6aWT5Ef//takFx/Wx9cLUtTMsxHGXzTyv1d3QKZQvlvtrew8EW4vBU+SUU8SqaRf5V
	 KAShT5OTKg4mbfxTl1i2SU4hRivO1z2pyarZs9dQmmU4RCcxD52JbYptqj3k0L9ngC
	 GF1fg6sgKt5/w==
Date: Fri, 12 Jan 2024 17:09:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, quic_neeraju@quicinc.com, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix WARN_ON_ONCE() in the
 rcu_nocb_bypass_lock()
Message-ID: <ZaFkKPDTpCTXdyvT@lothringen>
References: <20240110081128.18683-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110081128.18683-1-qiang.zhang1211@gmail.com>

On Wed, Jan 10, 2024 at 04:11:28PM +0800, Zqiang wrote:
> For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
> CONFIG_RCU_LAZY=y, here are the following scenarios that will trigger
> WARN_ON_ONCE() in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended().
> 
>         CPU2                                               CPU11
> kthread                                                   
> rcu_nocb_cb_kthread                                       ksys_write
> rcu_do_batch                                              vfs_write
> rcu_torture_timer_cb                                      proc_sys_write
> __kmem_cache_free                                         proc_sys_call_handler
> kmemleak_free                                             drop_caches_sysctl_handler
> delete_object_full                                        drop_slab
> __delete_object                                           shrink_slab
> put_object                                                lazy_rcu_shrink_scan
> call_rcu                                                  rcu_nocb_flush_bypass
> __call_rcu_commn                                            rcu_nocb_bypass_lock
>                                                             raw_spin_trylock(&rdp->nocb_bypass_lock) fail
>                                                             atomic_inc(&rdp->nocb_lock_contended);
> rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
>  WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
>                             |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|
> 
> This commit therefore use the rcu_nocb_try_flush_bypass() instead of
> rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan(), if the nocb_bypass
> queue is being flushed, the rcu_nocb_try_flush_bypass will return directly.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

