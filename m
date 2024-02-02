Return-Path: <linux-kernel+bounces-50611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7396847B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA931F2A9AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD6839EB;
	Fri,  2 Feb 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T8ebzg23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C887CF3F;
	Fri,  2 Feb 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909747; cv=none; b=tZMrht+blEH6tDPl48pbBDZeYMU0wd6E1WNaOUUkv5DZlRXTKb+P8thpdpj503r3aaZUxrVFCy/aMEPEOrPDKsPydwwr8H7FerNn202joGPCihx0akWUVTGD5B3s2T52SJgqwqxdxNWEGBwneAUtwu9eM16XOL5JNpqC7EkkhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909747; c=relaxed/simple;
	bh=bygkwq3H5uz4EcL8134faBvbhDYNHUEoqi1fXOwtcSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOCXT7yXfrNfmgYQyIa3tVyusBNnB1Iay0FtuE/vRStN+2FGammwPq46AGXhoEnVQqJOSzvVXpJAb+D0xSLW/XIC/KoA04O4GOaddZq/0sJGKjZfg+bX+cKU0h0Ng8EEFJnO19TC14w+WRBHD88o8u4LiZCT30t3DchR8FgXPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T8ebzg23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F2DC433F1;
	Fri,  2 Feb 2024 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706909746;
	bh=bygkwq3H5uz4EcL8134faBvbhDYNHUEoqi1fXOwtcSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8ebzg239yZx11OVUqtKc43pZ50yggUfrA7hQoCBpoKaij0XzbsBZfy/xUVmLLg6S
	 rW8cxQi03ZsoESqt4C0DOodXMIuDNnslKzlp5y2Uq1Nuy1e1lnXCRRQ82tio8JJY+b
	 dAAojUn2Pm9HAlrlBWpWxh5Ydd8GCGz52szdWMw8=
Date: Fri, 2 Feb 2024 13:35:45 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, bvanassche@acm.org,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, hongyu.jin@unisoc.com, stable@vger.kernel.org
Subject: Re: [PATCH V3] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <2024020233-wildland-blouse-2f2e@gregkh>
References: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>
 <Zb1IxNd54z2Ib1N3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb1IxNd54z2Ib1N3@google.com>

On Fri, Feb 02, 2024 at 07:55:48PM +0000, Carlos Llamas wrote:
> On Fri, Feb 02, 2024 at 04:14:36PM +0800, Zhiguo Niu wrote:
> > There is a deadlock scenario between lockdep and rcu when
> > rcu nocb feature is enabled, just as following call stack:
> > 
> >      rcuop/x
> > -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> > -002|__raw_spin_lock_irqsave(inline)
> > -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> > -003|wake_nocb_gp_defer(inline)
> > -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> > -004|__call_rcu_common(inline)
> > -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> > -005|call_rcu_zapped(inline)
> > -005|free_zapped_rcu(ch = ?)// hold graph lock
> > -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> > -007|nocb_cb_wait(inline)
> > -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> > -008|kthread(_create = 0xFFFFFF80803122C0)
> > -009|ret_from_fork(asm)
> > 
> >      rcuop/y
> > -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> > -001|queued_spin_lock()
> > -001|lockdep_lock()
> > -001|graph_lock() // try to hold graph lock
> > -002|lookup_chain_cache_add()
> > -002|validate_chain()
> > -003|lock_acquire
> > -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> > -005|lock_timer_base(inline)
> > -006|mod_timer(inline)
> > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> > -007|__call_rcu_common(inline)
> > -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> > -008|call_rcu_hurry(inline)
> > -008|rcu_sync_call(inline)
> > -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> > -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> > -010|nocb_cb_wait(inline)
> > -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> > -011|kthread(_create = 0xFFFFFF8080363740)
> > -012|ret_from_fork(asm)
> > 
> > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> > This patch release the graph lock before lockdep call_rcu.
> > 
> > Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> > Cc: <stable@vger.kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> > changes of v3: correct code comments and add Cc tag.
> > changes of v2: update patch according to Boqun's suggestions.
> > ---
> 
> It seems v3 should have collected the review tags from Boqun and Waiman.
> Also, I'm actually Cc'ing stable here. I hope that is enough.
> FWIW, this looks fine to me.
> 
> Reviewed-by: Carlos Llamas <cmllamas@google.com>


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

