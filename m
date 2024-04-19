Return-Path: <linux-kernel+bounces-151195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E108AAAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1A71F22C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68F71745;
	Fri, 19 Apr 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FLQ8+lk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9343AA1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516953; cv=none; b=nF/AK67PNxpj51nz2loulAxlsUe/bjprAMonYFSNmiTJEReHDd+ldQVh9/EjatY1PpKmDPJ0NZcVY1AzqtgELsraoyJCQ+2wPpW1B7fO+sDhkb7ctNXlJMhEBZMYfvRfpVjSejoRymp2BzKhK5G639OKAXTf039lcigKvrdQIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516953; c=relaxed/simple;
	bh=o/S9eg21xMbHDMdlY6+uPWEoHgmg1lCUOWMayHX3g4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq1yUbtgiHJDzB9Zm9Z6FaDU3o94zWeKiHvcVrvKhoM8/omO7mTBR/DMz9eCadq0XIm5gJyjwvWurulF9weq/kv8NlRH2GiGt5UAJrlaWMiuL/aDsXK08YVpAsdx8gzrfLfSGqYZK2E6KdfQnklD4W899C6Ql88lmeMvIwvirLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=FLQ8+lk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A996C2BD10;
	Fri, 19 Apr 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FLQ8+lk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713516948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E5KzsI1r985YbuWl9u53Q0Y08ML3MWhBVBwKzEgP884=;
	b=FLQ8+lk2CyNtCqkfxzqO0MlHs9VO/H9k6VbdjGcBtDyvPIXLHKJpbpQdABsVbiH4ohrxAG
	kPV3/ljiaWF8eUgMjcSRwkvNh+QjUI/NbnkOmvgla1Y8NwECBsi7bB7vfhpzV9+0HFJHEt
	7qxiUXyYbi/VxZVfaBnNRNOpJJbWiJA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9162869 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 08:55:46 +0000 (UTC)
Date: Fri, 19 Apr 2024 10:55:44 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Guoyong Wang <guoyong.wang@mediatek.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running
 in an atomic contex
Message-ID: <ZiIxkN3uMvHhujW2@zx2c4.com>
References: <20240417120217.3814215-2-Jason@zx2c4.com>
 <20240419084112.4089-1-guoyong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240419084112.4089-1-guoyong.wang@mediatek.com>

On Fri, Apr 19, 2024 at 04:41:12PM +0800, Guoyong Wang wrote:
> On Wed, 17 Apr 2024 14:01:11 +0200, Jason A. Donenfeld wrote:
> > The entropy accounting changes a static key when the RNG has
> > initialized, since it only ever initializes once. Static key changes,
> > however, cannot be made from atomic context, so depending on where the
> > last creditable entropy comes from, the static key change might need to
> > be deferred to a worker.
> > 
> > Previously the code used the execute_in_process_context() helper
> > function, which accounts for whether or not the caller is
> > in_interrupt(). However, that doesn't account for the case where the
> > caller is actually in process context but is holding a spinlock.
> > 
> > This turned out to be the case with input_handle_event() in
> > drivers/input/input.c contributing entropy:
> > 
> >   [<ffffffd613025ba0>] die+0xa8/0x2fc
> >   [<ffffffd613027428>] bug_handler+0x44/0xec
> >   [<ffffffd613016964>] brk_handler+0x90/0x144
> >   [<ffffffd613041e58>] do_debug_exception+0xa0/0x148
> >   [<ffffffd61400c208>] el1_dbg+0x60/0x7c
> >   [<ffffffd61400c000>] el1h_64_sync_handler+0x38/0x90
> >   [<ffffffd613011294>] el1h_64_sync+0x64/0x6c
> >   [<ffffffd613102d88>] __might_resched+0x1fc/0x2e8
> >   [<ffffffd613102b54>] __might_sleep+0x44/0x7c
> >   [<ffffffd6130b6eac>] cpus_read_lock+0x1c/0xec
> >   [<ffffffd6132c2820>] static_key_enable+0x14/0x38
> >   [<ffffffd61400ac08>] crng_set_ready+0x14/0x28
> >   [<ffffffd6130df4dc>] execute_in_process_context+0xb8/0xf8
> >   [<ffffffd61400ab30>] _credit_init_bits+0x118/0x1dc
> >   [<ffffffd6138580c8>] add_timer_randomness+0x264/0x270
> >   [<ffffffd613857e54>] add_input_randomness+0x38/0x48
> >   [<ffffffd613a80f94>] input_handle_event+0x2b8/0x490
> >   [<ffffffd613a81310>] input_event+0x6c/0x98
> > 
> > According to Guoyong, it's not really possible to refactor the various
> > drivers to never hold a spinlock there. And in_atomic() isn't reliable.
> > 
> > So, rather than trying to be too fancy, just punt the change in the
> > static key to a workqueue always. There's basically no drawback of doing
> > this, as the code already needed to account for the static key not
> > changing immediately, and given that it's just an optimization, there's
> > not exactly a hurry to change the static key right away, so deferal is
> > fine.
> > 
> > Reported-by: Guoyong Wang <guoyong.wang@mediatek.com>
> > Cc: stable@vger.kernel.org
> > Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Guoyong- can you test this and tell me whether it fixes the problem you
> > were seeing? If so, I'll try to get this sent up for 6.9. -Jason
> > 
> >  drivers/char/random.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 456be28ba67c..2597cb43f438 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -702,7 +702,7 @@ static void extract_entropy(void *buf, size_t len)
> >  
> >  static void __cold _credit_init_bits(size_t bits)
> >  {
> > -       static struct execute_work set_ready;
> > +       static DECLARE_WORK(set_ready, crng_set_ready);
> >         unsigned int new, orig, add;
> >         unsigned long flags;
> >  
> > @@ -718,8 +718,8 @@ static void __cold _credit_init_bits(size_t bits)
> >  
> >         if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
> >                 crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
> > -               if (static_key_initialized)
> > -                       execute_in_process_context(crng_set_ready, &set_ready);
> > +               if (static_key_initialized && system_unbound_wq)
> > +                       queue_work(system_unbound_wq, &set_ready);
> >                 atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
> >                 wake_up_interruptible(&crng_init_wait);
> >                 kill_fasync(&fasync, SIGIO, POLL_IN);
> > @@ -890,8 +890,8 @@ void __init random_init(void)
> >  
> >         /*
> >          * If we were initialized by the cpu or bootloader before jump labels
> > -        * are initialized, then we should enable the static branch here, where
> > -        * it's guaranteed that jump labels have been initialized.
> > +        * or workqueues are initialized, then we should enable the static
> > +        * branch here, where it's guaranteed that these have been initialized.
> >          */
> >         if (!static_branch_likely(&crng_is_ready) && crng_init >= CRNG_READY)
> >                 crng_set_ready(NULL);
> > -- 
> > 2.44.0
> 
> Hi Jason,
> 
> Thanks for your feedback. We concur with the proposed change and have verified that it works well 
> in our tests. Next, I will provide a patch v2 for the changes discussed.

No need. This is already upstream and has your Reported-by. It'll get
backported to stable too.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e871abcda3b67d0820b4182ebe93435624e9c6a4

