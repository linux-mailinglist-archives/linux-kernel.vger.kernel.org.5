Return-Path: <linux-kernel+bounces-32285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3883596F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6426B1C2130F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12E15AF;
	Mon, 22 Jan 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eua6183v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC07EBF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705891302; cv=none; b=ZYEy7CUaM9vSW4PT8305UguCD2b+v5yNJRV8lZuX6H/1XwPlM99Os8NE0BgEaAGixXb4TnL81hD2mL4ZR4+3/Lnz+MvYov/QNUh0imKx86Zbm1fZNcWa50eqXyrFJcuMeKnVnAmMwEPO60a8xKmmIKv69+R/njGXHfZ6IDokmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705891302; c=relaxed/simple;
	bh=Wx4G5f14fWCH1LlNGXNwyXAQeQoYLXwSq2j/Mf3l25A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1qCCOvMspzHIn+nsA+1fmHefcDqHM2B6mDy1mhUcHsdYcqMeDCK6ps2TW+/ezdIqagEeI7vdSeufGUjff2P1KREhRBHlmtCuewDBKgTp6jLBfKi0AZcF17A5r9mOHyFVbl7SjJ21WV1ujAjG0XvPGFWWYZMlMb6gJSqF7Da19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eua6183v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705891299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYLMsusBHJOF/wunon7MNJiQYUv5pT0V6GEmOyxtuq8=;
	b=Eua6183v9MzXFQFsxNI4Hj+Als5baMNeO64G0goXgm2zF1N49lot4k5IKWadQqKbzFoXZz
	ZLyOaEm2JOSl89H8sGeJnSksiund/8oDLS3ehEfOBLcHXYLwutl8eJVw27qmhD3xyiTV1L
	sBVeUJ0kMCB6kZadCDxBRYhsDZyi6Ks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-3qP6E781NCCqnnomP8AZHg-1; Sun,
 21 Jan 2024 21:41:35 -0500
X-MC-Unique: 3qP6E781NCCqnnomP8AZHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D84F1C05AA6;
	Mon, 22 Jan 2024 02:41:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BA153C2E;
	Mon, 22 Jan 2024 02:41:30 +0000 (UTC)
Date: Mon, 22 Jan 2024 10:41:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>, ming.lei@redhat.com
Subject: Re: [PATCH 1/9] cpumask: introduce for_each_cpu_and_from()
Message-ID: <Za3V1pFXM+4UnoIM@fedora>
References: <20240120025053.684838-1-yury.norov@gmail.com>
 <20240120025053.684838-2-yury.norov@gmail.com>
 <Zas4CeVG6mlfiUM9@fedora>
 <Za11asdkTrKzrL8e@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za11asdkTrKzrL8e@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sun, Jan 21, 2024 at 11:50:02AM -0800, Yury Norov wrote:
> On Sat, Jan 20, 2024 at 11:03:37AM +0800, Ming Lei wrote:
> > On Fri, Jan 19, 2024 at 06:50:45PM -0800, Yury Norov wrote:
> > > Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
> > > which is handy when it's needed to traverse 2 cpumasks or bitmaps,
> > > starting from a given position.
> > 
> > The new helper is useless, see
> > 
> > https://lore.kernel.org/lkml/ZZNgDb6bzOscrNmk@fedora/
> 
> Let's consider the following configuration.
> Step-by-step:

..

> 
> #	loop	cpu	match	siblmsk	nmsk	irqmsk
>  0	outer	0	yes 		1110	0001
>  1	inner	1	yes 	0011	1100	0011
>  2	inner	2	no 	0011	1100	0011
>  3	inner	3	no 	0011	1100	0011
>  4	outer	2	yes	 	1000	0111
>  5	inner	3	yes	1100	0000	1111
> 
> Your code works worse because it's a Schlemiel the Painter's algorithm.
> I mentioned it twice in the commit messages and at least 3 times in
> replies to your comments.

Does it really matter here in reality? Which kind of user visible improvements
can be observed?

I have mentioned several times, for control/management code path, we care
more on maintainability, correctness instead of efficiency.

You are _wasting_ resources in wrong place, if you are really interested in
optimization, please do in fast code path, such as, related and not not limited,
irq handling, io handling, memory allocation, ....

Unfortunately, your V5 still have obvious bug, and as you mentioned,
the patchset title is wrong too.

> 
> Here I'll stop and will not reply to your emails, including the rest of
> that Friday's night mailbombing, unless you at least admit you're wrong
> in this case and for_each_cpu_and_from() is useful here. 

It is easy to get same result without adding for_each_cpu_and_from(), see the
patch I sent:

https://lore.kernel.org/lkml/20240120065543.739203-1-ming.lei@redhat.com/

in which we needn't to update iterator variable inside loop, and fix
the bug in your patch 4 of v5, and it is still O(N). Meantime it is
simpler and easier to get proved.

Here your use of for_each_cpu_and_from() is tricky too, cause the
loop condition variable(part of iterator variable) of cpu mask is being updated
inside the loop. And we can get same result by cpumask_next_and()
without playing the trick.

> 
> I'd also recommend you to learn more about atomic operations basics and
> revoke your NAK from the patch #3.

If you think my comment on the NAK is wrong, please reply on the comment
directly.

> 
> Thanks,
> 	Yury
> 
> PS: There's a typo in the series name, I meant that the series makes the
> function O(N) of course. But even that is overly optimistic. It's O(N*S),
> where S is the number of sibling groups. A couple more patches needed to
> make it a true O(N). Still, much better.

Either O(1) or O(N) isn't one big deal here, cause it is oneshot
slow code path, and nr_cpu_ids is not big enough in reality.

Even you can't make real O(N) because your patch 4 has logic
mistake, see my comment:

https://lore.kernel.org/lkml/ZatlggW%2F8SH6od9O@fedora/



Thanks,
Ming


