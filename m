Return-Path: <linux-kernel+bounces-117922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EE88B155
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2AE30469A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215356770;
	Mon, 25 Mar 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JpOxHfFe"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00453387
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398399; cv=none; b=NymSmd1ndTWxW6LNivCSOeZgWXrf6tcPeklXKb6nJZYe8CDrx0x7/t68CI4413NH9keXf4yE7t7LwyVgoHkNuIDgMNmLm2FLJhH2xu6C/dXyzQ7RfRZTQ4/C8HVLH1BaShPzRJ2q+H6S5C9+l11H9QIa95jf4ifXZ5U26QHTFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398399; c=relaxed/simple;
	bh=skUYPMIsAwiP0vB1/M6Ts5CcVZ5JyOu98eWA+okWyzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frd1nyEWOf+sxrOctWWo1PxnzKso5hERYAYCWYr3GUjEtfd+v8OxLMBoVFhMBVQ1ml+RB5PrXDtKLYQ6eAKFK4lVWqJv3RuFvB1nDqVKPRUN9Rm/QJZ0dpgbG37wC6QvNNOKWUV1vD5l+iJmww2Xa9iM+xeC1fGAqVSifc1ObTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JpOxHfFe; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-221816e3ab9so2050062fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711398396; x=1712003196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQgVc5rA568fhlJ0cVI5voz5lHmOfZopdFI9MupJvHk=;
        b=JpOxHfFe50wwXL+FQSqBUJlNIJ8hwwzj1mOui+ge4kd2ntlZgRcuiLu12T3dK53abM
         hvwSV9sIlngM/ukHf0y4o5dNb49y6EzWEAjcgfj81OU5EjKoDqlLv4IUcs6eRWBbz3kJ
         csROJ1D/FH0mKE/lq8iL6dKZk44d9JodKRNko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398396; x=1712003196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQgVc5rA568fhlJ0cVI5voz5lHmOfZopdFI9MupJvHk=;
        b=AH/Rhdbui5G1f1yK9YC5S+lU34ClOEYD2R1xzuGiDFUHmtDMH7zVgm7deHQceqOdp0
         5mQBQYA9p79KGmTofcQJdynSrQmf55PC8YcLWjuzB5VkT7s91G16trN5pXvN7gLgtMI4
         C/DqIp24fagp26/1NVkuyBWmY+/XrZaq2gKUesuUgqS4KOtvDhsJKE22yEB3onBhG29E
         1ZJK7Son3mGuxneRRzROddtVq9DMoXe8HOWymftX+sGxGOc1L3YqkANwfefFXgStXV2B
         vFHNWbf8T+/uvYiG8fe5ab9XmdmNz0E0XwsJPD+l8Luzp9HvbDT13ZtXXdB+JoxXcSvO
         Id2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL1qhZMgihk8Ryhjuq8njsO/aazjXupI4+lfFvOl9Ld4xZBa9+hkKWdETFA6FC1PifFuJ06B0xtIsIrhgP7XXEe1PBJIwp15Ygo6lH
X-Gm-Message-State: AOJu0Yxg/tUzgpCMV1RuKwz7oRTLsEXnw1+cAb35K9QHCEjMESZ62XBy
	e8Dy5c4J+nyQwwgHQXpbWFZUsEloxI9JRlOoQpOj+oyQzqTxaZQ6ZqkPGXvT0A==
X-Google-Smtp-Source: AGHT+IGDLy633FPE8AGgVDT1L28BA0GlpvQ5JB0Sst0Ad42s4bKNBdcs/aHPwJ6kk2CRqJ3AwFCzew==
X-Received: by 2002:a05:6870:1652:b0:22a:4f78:5be6 with SMTP id c18-20020a056870165200b0022a4f785be6mr2334889oae.17.1711398395563;
        Mon, 25 Mar 2024 13:26:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s66-20020a632c45000000b005d6b5934deesm6218001pgs.48.2024.03.25.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:26:35 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:26:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, jvoisin <julien.voisin@dustri.org>
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Message-ID: <202403251324.F8EADD2E@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
 <24vn56fs7oohqgw3rhssiwglmviruqnt44y6oeajzvskostcrr@7jzhmxjbhcha>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24vn56fs7oohqgw3rhssiwglmviruqnt44y6oeajzvskostcrr@7jzhmxjbhcha>

On Mon, Mar 25, 2024 at 03:32:12PM -0400, Kent Overstreet wrote:
> On Mon, Mar 25, 2024 at 10:03:23AM +0100, Vlastimil Babka wrote:
> > On 3/5/24 11:10 AM, Kees Cook wrote:
> > > Hi,
> > > 
> > > Repeating the commit logs for patch 4 here:
> > > 
> > >     Dedicated caches are available For fixed size allocations via
> > >     kmem_cache_alloc(), but for dynamically sized allocations there is only
> > >     the global kmalloc API's set of buckets available. This means it isn't
> > >     possible to separate specific sets of dynamically sized allocations into
> > >     a separate collection of caches.
> > > 
> > >     This leads to a use-after-free exploitation weakness in the Linux
> > >     kernel since many heap memory spraying/grooming attacks depend on using
> > >     userspace-controllable dynamically sized allocations to collide with
> > >     fixed size allocations that end up in same cache.
> > > 
> > >     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> > >     against these kinds of "type confusion" attacks, including for fixed
> > >     same-size heap objects, we can create a complementary deterministic
> > >     defense for dynamically sized allocations.
> > > 
> > >     In order to isolate user-controllable sized allocations from system
> > >     allocations, introduce kmem_buckets_create(), which behaves like
> > >     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> > >     which behaves like kmem_cache_alloc().)
> > > 
> > >     Allows for confining allocations to a dedicated set of sized caches
> > >     (which have the same layout as the kmalloc caches).
> > > 
> > >     This can also be used in the future once codetag allocation annotations
> > >     exist to implement per-caller allocation cache isolation[0] even for
> > >     dynamic allocations.
> > > 
> > >     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]
> > > 
> > > After the implemetation are 2 example patches of how this could be used
> > > for some repeat "offenders" that get used in exploits. There are more to
> > > be isolated beyond just these. Repeating the commit log for patch 8 here:
> > > 
> > >     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
> > >     use-after-free type confusion flaws in the kernel for both read and
> > >     write primitives. Avoid having a user-controlled size cache share the
> > >     global kmalloc allocator by using a separate set of kmalloc buckets.
> > > 
> > >     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
> > >     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
> > >     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
> > >     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
> > >     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
> > >     Link: https://zplin.me/papers/ELOISE.pdf [6]
> > 
> > Hi Kees,
> > 
> > after reading [1] I think the points should be addressed, mainly about the
> > feasibility of converting users manually. On a related technical note I
> > worry what will become of /proc/slabinfo when we convert non-trivial amounts
> > of users.
> 
> There shouldn't be any need to convert users to this interface - just
> leverage the alloc_hooks() macro.

I expect to do both -- using the alloc_hooks() macro to do
per-call-site-allocation caches will certainly have a non-trivial amount
of memory usage overhead, and not all systems will want it. We can have
a boot param to choose between per-site and normal, though normal can
include a handful of these manually identified places.

-- 
Kees Cook

