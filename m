Return-Path: <linux-kernel+bounces-168101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0988BB3AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409191C2371D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65AB15535A;
	Fri,  3 May 2024 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YfjVDCz1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F712EBF1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763203; cv=none; b=TOnQ0kGjIpESAhMQeW5fLiBb/6AsetcdGBQIlGsTUc8kTxeiR8YEyWckDEEwG6Hhx1T7IK/qTXGbYd7vDW5zVwWt+9xEW6JOh8yAajiFatqzCkZhXN2AdqJp2P/i2IthOqf6bgqL+vsg2C+PzoxwwGyciHnvFHoN3o9dL4EOzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763203; c=relaxed/simple;
	bh=CIUsfCKkMvt/yVjK1M5lGf65YvwWmEZYtpiH5e8fOME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MePuDxPC4qoaRSH3zZoQRwKRIa0eFkZCvLFihGwJ5HFLVeauip7C9uVbtRbTv5G3YUG1u7n9rh7Xycql0mKUh0cYC2eueWh9sNGbpJeJVn/nUMw3Pd8iz3cuB/tsrELnNXq+0LaHKtaPz3+frYENvWSYjlwrQpTkeeGhNgOXxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YfjVDCz1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso52718b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714763200; x=1715368000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZsz55fiqZR4w4NlbwWoRsw4O+mWS9LyOjfLrSZHpu4=;
        b=YfjVDCz1e/jI7ZuLW4t/tgvnQ/1T78jGN/gZKWw8MG/jcKwGYiyUGCEesuxmE1sVQj
         aTOdz0P+NcJ/WyjCVSgjB5VW4JrD1WmhuhUSK2w6GZ25weQJVyA/YGRgZmciHOTsSFtd
         OcV9XhZYbQO6Vgwia6iktEaz9gRL1bSPUKPy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763200; x=1715368000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZsz55fiqZR4w4NlbwWoRsw4O+mWS9LyOjfLrSZHpu4=;
        b=jDH/CbYbJxmL+ncLcL9eU2VgqMH2F+pARX7sH7qtbpzj7DJra6Ky1uv4RzHm/K/YcZ
         PsIR/DTCgIgobm9jSeI+EBNUdnAl6f1vvl5xLo424ZqlrdPQANJXnUY5fu5TMZHWeejr
         zODzPfCFBDxIlnQ6sulLl+CGagq3Lh3ivd12jP/yqXlQaoaWQ8UW5wZagQFlmZfvW2oc
         byVVx8UmIl1tcFFo/X0so5LGTUdFX8wZSQUyZwg6yUFvX/LcsgJMF+pdG5CVyUTazY8i
         axHJNyYfJ2loqJWEnF0nY67ac1V72ZM0pIWFVYhhbAwp0TUl4Chexn/xHL5HQDrk/YC3
         JDQg==
X-Forwarded-Encrypted: i=1; AJvYcCW4r9J/7HKL2VlWYZtKToltJN74NKhLlXCmse6/RMldPS1QRQkyCv/BgNsbTdDkGMV4y0o6FcTwyyKBFQrGq7wouRmOQbm8pueskI/R
X-Gm-Message-State: AOJu0Yw4VcO5il1nPv+TLp4BG9Xch+Ll7NEb0c7z54c2CetzPvlml1Z6
	EW+FMz0kucvduqy8RbhiUwuB03ptS3k5m3PJk9LdNn1A/1rZURLZ8FS0sXj38g==
X-Google-Smtp-Source: AGHT+IGwximmF86WltIWrIY4dQJlppuh9AHcCW6xvgeEfudlw5lj3W4bueIitHYmaG0IiKCkZhyeOA==
X-Received: by 2002:a05:6a00:3d04:b0:6f3:ee60:54c3 with SMTP id lo4-20020a056a003d0400b006f3ee6054c3mr3422347pfb.19.1714763200238;
        Fri, 03 May 2024 12:06:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw33-20020a056a0092a100b006f3eec7be3bsm3423206pfb.32.2024.05.03.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:06:39 -0700 (PDT)
Date: Fri, 3 May 2024 12:06:38 -0700
From: Kees Cook <keescook@chromium.org>
To: jvoisin <julien.voisin@dustri.org>
Cc: Matteo Rizzo <matteorizzo@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
Message-ID: <202405031126.CEAB079A1A@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <d0a65407-d3ae-46d5-800f-415ce7efcf22@dustri.org>
 <202404280921.A7683D511@keescook>
 <28478de8-3028-48f2-b887-56149b6e324a@dustri.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28478de8-3028-48f2-b887-56149b6e324a@dustri.org>

On Fri, May 03, 2024 at 03:39:28PM +0200, jvoisin wrote:
> On 4/28/24 19:02, Kees Cook wrote:
> > On Sun, Apr 28, 2024 at 01:02:36PM +0200, jvoisin wrote:
> >> On 4/24/24 23:40, Kees Cook wrote:
> >>> [...]
> >>>     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> >>>     against these kinds of "type confusion" attacks, including for fixed
> >>>     same-size heap objects, we can create a complementary deterministic
> >>>     defense for dynamically sized allocations that are directly user
> >>>     controlled. Addressing these cases is limited in scope, so isolation these
> >>>     kinds of interfaces will not become an unbounded game of whack-a-mole. For
> >>>     example, pass through memdup_user(), making isolation there very
> >>>     effective.
> >>
> >> What does "Addressing these cases is limited in scope, so isolation
> >> these kinds of interfaces will not become an unbounded game of
> >> whack-a-mole." mean exactly?
> > 
> > The number of cases where there is a user/kernel API for size-controlled
> > allocations is limited. They don't get added very often, and most are
> > (correctly) using kmemdup_user() as the basis of their allocations. This
> > means we have a relatively well defined set of criteria for finding
> > places where this is needed, and most newly added interfaces will use
> > the existing (kmemdup_user()) infrastructure that will already be covered.
> 
> A simple CodeQL query returns 266 of them:
> https://lookerstudio.google.com/reporting/68b02863-4f5c-4d85-b3c1-992af89c855c/page/n92nD?params=%7B%22df3%22:%22include%25EE%2580%25803%25EE%2580%2580T%22%7D

These aren't filtered for being long-lived, nor filtered for
userspace reachability, nor filtered for userspace size and content
controllability. Take for example, cros_ec_get_panicinfo(): the size is
controlled by a device, the allocation doesn't last beyond the function,
and the function itself is part of device probing.

> Is this number realistic and coherent with your results/own analysis?

No, I think it's 1 possibly 2 orders of magnitude too high. Thank you for
the link, though: we can see what the absolute upper bounds is with it,
but that's not an accurate count of cases that would need to explicitly
use this bucket API. But even if it did, 300 instances is still small:
we converted more VLAs than that, more switch statement fallthroughs
than that, and fixed more array bounds cases than that.

And, again, while this series does close a bunch of methods today,
it's a _prerequisite_ for doing per-call-site allocation isolation,
which obviates the need for doing per-site analysis. (We can and will
still do such analysis, though, since there's a benefit to it for folks
that can't tolerate the expected per-site memory overhead.)

> [...]
> >>>     Memory allocation pinning[2] is still needed to plug the Use-After-Free
> >>>     cross-allocator weakness, but that is an existing and separate issue
> >>>     which is complementary to this improvement. Development continues for
> >>>     that feature via the SLAB_VIRTUAL[3] series (which could also provide
> >>>     guard pages -- another complementary improvement).
> >>>     
> >>>     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> >>>     Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
> >>>     Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
> >>
> >> To be honest, I think this series is close to useless without allocation
> >> pinning. And even with pinning, it's still routinely bypassed in the
> >> KernelCTF
> >> (https://github.com/google/security-research/tree/master/pocs/linux/kernelctf).
> > 
> > Sure, I can understand why you might think that, but I disagree. This
> > adds the building blocks we need for better allocation isolation
> > control, and stops existing (and similar) attacks toda>
> > But yes, given attackers with sufficient control over the entire system,
> > all mitigations get weaker. We can't fall into the trap of "perfect
> > security"; real-world experience shows that incremental improvements
> > like this can strongly impact the difficulty of mounting attacks. Not
> > all flaws are created equal; not everything is exploitable to the same
> > degree.
> 
> It's not about "perfect security", but about wisely spending the
> complexity/review/performance/churn/… budgets in my opinion.

Sure, that's an appropriate analysis to make, and it's one I've done. I
think this series is well within those budgets: it abstracts the "bucket"
system into a distinct object that we've needed to have extracted for
other things, it's a pretty trivial review (since the abstraction makes
the other patches very straight forward), using the new API is a nearly
trivial drop-in replacement, and we immediately closes several glaring
exploit techniques, which has real-world impact. This is, IMO, a total
slam dunk of a series.

> >> Do you have some particular exploits in mind that would be completely
> >> mitigated by your series?
> > 
> > I link to like a dozen in the last two patches. :P
> > 
> > This series immediately closes 3 well used exploit methodologies.
> > Attackers exploiting new flaws that could have used the killed methods
> > must now choose methods that have greater complexity, and this drives
> > them towards cross-allocator attacks. Robust exploits there are more
> > costly to develop as we narrow the scope of methods.
> 
> You linked exploits that were making use of the two structures that you
> isolated; making them use different structures would likely mean a
> couple of hours.

I think you underestimate what it would take to provide such a flexible
replacement. As I noted earlier, the techniques have several requirements:
- reachable from userspace
- long-lived allocation
- userspace controllable size
- userspace controllable contents
I'm not saying there aren't other interfaces that provide this, but it's
not common, and each (like these) will have their own quirks and
limitations. (e.g. the msg_msg exploit can't use the start of the
allocation since the contents aren't controllable, and has a minimum
size for the same reason.)

This series kills the 3 techniques with _2_ changes. 2 of the techniques
depend on the same internal (memdup_user()) that gets protected, which
implies that it will cover other things both now and in the future.

> I was more interested in exploits that are effectively killed; as I'm
> still not convinced that elastic structures are rare, and that manually
> isolating them one by one is attainable/sustainable/…

I don't agree with your rarity analysis, but it doesn't matter, because
we will be taking the next step and providing per-call-site isolation
using this abstraction.

> But if you have some proper analysis in this direction, then yes, I
> completely agrees that isolating all of them is a great idea.

I don't need to perform a complete reachability analysis for all UAPI
because I can point to just memdup_user(): it is the recommended way
to get long-lived data from userspace. It has been and will be used by
interfaces that meet all 4 criteria for the exploit technique.

Converting other APIs to it or using the bucket allocation API can
happen over time as those are identified. This is standard operating
procedure for incremental improvements in Linux.

> > Bad analogy: we're locking the doors of a house. Yes, some windows may
> > still be unlocked, but now they'll need a ladder. And it doesn't make
> > sense to lock the windows if we didn't lock the doors first. This is
> > what I mean by complementary defenses, and comes back to what I mentioned
> > earlier: "perfect security" is a myth, but incremental security works.
> > 
> >> Moreover, I'm not aware of any ongoing development of the SLAB_VIRTUAL
> >> series: the last sign of life on its thread is from 7 months ago.
> > 
> > Yeah, I know, but sometimes other things get in the way. Matteo assures
> > me it's still coming.
> > 
> > Since you're interested in seeing SLAB_VIRTUAL land, please join the
> > development efforts. Reach out to Matteo (you, he, and I all work for
> > the same company) and see where you can assist. Surely this can be
> > something you can contribute to while "on the clock"?
> 
> I left Google a couple of weeks ago unfortunately,

Ah! Bummer; I didn't see that happen. :(

> and I won't touch
> anything with email-based development for less than a Google salary :D

LOL. Yes, I can understand that. :) I do want to say, though, that
objections carry a lot more weight when counter-proposal patches are
provided. "This is the way." :P

-Kees

-- 
Kees Cook

