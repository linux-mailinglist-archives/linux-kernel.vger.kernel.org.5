Return-Path: <linux-kernel+bounces-39215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000983CCDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E021C23DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DD136673;
	Thu, 25 Jan 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KuHYFhrT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9018135A5E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212310; cv=none; b=flLygI1Y49YXu8XC/uWlGy2AnQGMOtfAmMXH1AFNQxyg8cW2IpEGzqEaDlcxtyl7aghyCCuoLbhQ7QjK+JA/JchwOrT/GWyVKXpYh00hC5WWSR7OliUMHRWl08GPhEj3O9oZ2Jz7WX+IUrkMPtjvipP6uTS6Bt78NXZNjjdIC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212310; c=relaxed/simple;
	bh=pbKdTDXTH8qIfvsvKPqheQLoN3wH8pNE8FMLGEpj3M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxMWZ8WkPbmtN+4H1wnyHEA+zWpbbZe3ZA57mR+ZZ8mlCnDWMpa7XnRyX0ZOvyt+hFjLBFEitSMIO6UxdjLYTPai7Wc+yd9UmXz3FTFaTlywinKgXXk2N5u0qEA6qaSbxeynTNfMEoqzmO6p4aFv8K4zRaNx0oQy2u1i0lJ0JiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KuHYFhrT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so52404455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706212307; x=1706817107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tE7eACK6kxfwaRTLe0GNK8zp8igHDm0V06Q+Q7zAa1w=;
        b=KuHYFhrTWERrIXNdyA5IG+jD25H57JCShkcNa1Smz7gMYyvEkZULiIrJQW3rzCJY8B
         7UG/oXBWK4MHdF+kpqW0TAogCfs08I/rYtpAzGU43Fon8WzadVGJ+i5uUqwgPtisO3h5
         tABhaGN9fAWeWeE4juuJk54t0NMRyrjs9jX9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212307; x=1706817107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE7eACK6kxfwaRTLe0GNK8zp8igHDm0V06Q+Q7zAa1w=;
        b=tpySIUrWtGZsWGuHrRp29ZExkMKKVBlB3ZFkENq55oIeGF7rSikgK6lkFbqwld2QGB
         71/3ji8ljtYotAl3FCxmnclsazrfLfPyvbgK/F7PrDy9aFD9L7FjGezLATKgj/aLj2X1
         Ijte9rDOJjZ9Yo2XHbiRxVpw9+YY5jJjKugaSKvbQmagiLkhOOkj7gWQuxjztOrXB5Ly
         1D7Y245+bssJQJRjf9p5nAypgmlwEH5056EcA7CdNPRAv/wzBsqxxHcukoecjabYFPeT
         f0ujg7HZlk8IYiPLkZIKE9ykxwyzlExJK7hcnk6y/8BnY2RHS9k+8PbxZRDNjel37nrz
         R0zA==
X-Gm-Message-State: AOJu0YwxMCiNaTyfWi/2nvHVmuvRA1xqacCGXhxfwhJK2BmSZmVV024O
	D5XBWdJOgMRZz/UPPnyyJ0m7YdVzhydcaqmTxitPneNv+EVbLskNOxsq9DAqtQG3ShHpN8Blniy
	YLvzU4g==
X-Google-Smtp-Source: AGHT+IFkH+XwKTQLnwBvwi8uVXymVg2JUL27UDepzOX/pEOgcGWiQjmyH0pP2fc1e5T1TzPT/3KhVQ==
X-Received: by 2002:a05:600c:4e93:b0:40e:b106:3ca5 with SMTP id f19-20020a05600c4e9300b0040eb1063ca5mr152735wmq.98.1706212306717;
        Thu, 25 Jan 2024 11:51:46 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm2918368edu.83.2024.01.25.11.51.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 11:51:46 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso8360327a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:51:45 -0800 (PST)
X-Received: by 2002:aa7:d3c5:0:b0:55a:4959:a2e4 with SMTP id
 o5-20020aa7d3c5000000b0055a4959a2e4mr81533edr.52.1706212305649; Thu, 25 Jan
 2024 11:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
In-Reply-To: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jan 2024 11:51:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
Message-ID: <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing tasklet_struct
To: Mikulas Patocka <mpatocka@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, Mike Snitzer <msnitzer@redhat.com>, 
	Ignat Korchagin <ignat@cloudflare.com>, Damien Le Moal <damien.lemoal@wdc.com>, 
	Bob Liu <bob.liu@oracle.com>, Hou Tao <houtao1@huawei.com>, 
	Nathan Huckleberry <nhuck@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 10:30, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> There's a problem with the tasklet API - there is no reliable way how to
> free a structure that contains tasklet_struct. The problem is that the
> function tasklet_action_common calls task_unlock(t) after it called the
> callback. If the callback does something that frees tasklet_struct,
> task_unlock(t) would write into free memory.

Ugh.

I see what you're doing, but I have to say, I dislike this patch
immensely. It feels like a serious misdesign that is then papered over
with a hack.

I'd much rather see us trying to move away from tasklets entirely in
cases like this. Just say "you cannot do that".

In fact, of the two cases that want this new functionality, at least
dm-verity already makes tasklets a conditional feature that isn't even
enabled by default, and that was only introduced in the last couple of
years.

So I think dm-verity would be better off just removing tasklet use,
and we should check whether there are better models for handling the
latency issue.

The dm-crypt.c case looks different, but similar. I'm not sure why it
doesn't just use the workqueue for the "in interrupt" case. Like
dm-verity, it already does have a workqueue option, and it's a
setup-time option to say "don't use the workqueue for reads / writes".
But it feels like the code should just say "tough luck, in interrupt
context we *will* use workqueues".

So honestly, both of the cases you bring up seem to be just BUGGY. The
fix is not to extend tasklets to a new thing, the fix is to say "those
two uses of tasklets were broken, and should go away".

End result: I would suggest:

 - just get rid of the actively buggy use of tasklets. It's not
necessary in either case.

 - look at introducing a "low-latency atomic workqueue" that looks
*exactly* like a regular workqueue, but has the rule that it's per-cpu
and functions on it cannot sleep

because I think one common issue with workqueues - which are better
designed than tasklets - is that scheduling latency.

I think if we introduced a workqueue that worked more like a tasklet -
in that it's run in softirq context - but doesn't have the interface
mistakes of tasklets, a number of existing workqueue users might
decide that that is exactly what they want.

So we could have a per-cpu 'atomic_wq' that things can be scheduled
on, and that runs from softirqs just like tasklets, and shares the
workqueue queueing infrastructure but doesn't use the workqueue
threads.

Yes, the traditional use of workqueues is to be able to sleep and do
things in process context, so that sounds a bit odd, but let's face
it, we

 (a) already have multiple classes of workqueues

 (b) avoiding deep - and possibly recursive - stack depths is another
reason people use workqueues

 (c) avoiding interrupt context is a real concern, even if you don't
want to sleep

and I really *really* would like to get rid of tasklets entirely.

They started as this very specific hardcoded softirq thing used by
some drivers, and then the notion was generalized.

And I think it was generalized badly, as shown by this example.

I have added Tejun to the cc, so that he can throw his hands up in
horror and say "Linus, you're crazy, your drug-fueled idea would be
horrid because of Xyz".

But *maybe* Tejun has been taking the same drugs I have, and goes
"yeah, that would fit well".

Tejun? Please tell me I'm not on some bad crack..

               Linus

