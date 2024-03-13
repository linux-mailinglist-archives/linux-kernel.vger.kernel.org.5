Return-Path: <linux-kernel+bounces-102644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DA87B53E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7711F2219C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5B5D72B;
	Wed, 13 Mar 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBHzTzuW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E21A38DB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372988; cv=none; b=dHtHfemE7iAWGNb0x8UnkzqhwZxalypga7rD3aqfSOrmkmn1lpTHtnoAv57paVEKUlGyp2LcxbHKYUQDZL2FgEFQ+mhjnBNKckJxW6ekv4o+33bow67TDYaeHL9F4V3+OHvUTMPmuJszNpdBNI4rBIVJE0Hg9iQe6KL70YPZ8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372988; c=relaxed/simple;
	bh=PCCrxOojTZiAdc3yUXFJX/6veg80HcX3d/J+ubH1I5Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qok1KcCYjrHsVAeVAxK9xCo9phgOrbmSjYFROIIotFueKOYruzyMJ+Z5gsQUuPIcEgpZzALGkDnlheXXf5PkB6hS7i7EYUkJb23ugA+PF4vIviCu6mbJETcgC8Bn/tyjZ28bxen0dFU++d/4ffjm9AwcqbrUHy+H0a1Y/7SYKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBHzTzuW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd80777328so28205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710372986; x=1710977786; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNLPEmLrYuypFvKNLV3xlGFW7PDRRyL15rDjWgaPTcE=;
        b=UBHzTzuWxTFDpVRgYOWFSLKiO6obYTJscdatQYkX6+x1frBP6CGy6H+nhbJnJYDUAM
         AN8BZHnaA1fuCsY56FGm5uGgvky1xl0u/CMnaGPTGRGC7nFgrtAG+7MDj3JIc/6DJOBz
         zeA6HKMRkhroKuaSu0Cou07bNpXzjaq7JXgCKekwrFaClL/y7elUOzJfhj1CgAZSl3ZP
         uQBNayoxBSwzwPLRRq5bz/qDNni5Kc8cIrN7IVrI0lYPeJrjhnKSgdG6zHkDiESyGRM4
         SAKjUBN9T9y7qmm6PbpXTPDhRWDXaK96XAvIHRl1XCZORNOPRC5CYRTBVgoxoBRx7aK8
         djBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710372986; x=1710977786;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNLPEmLrYuypFvKNLV3xlGFW7PDRRyL15rDjWgaPTcE=;
        b=e97S0yx2WE7vnnjwzpkRZ32aT8cO/UBpAvwgR5WdND5RZ/4P9FK9hxuxm03a2hz0fL
         akqnEXrY3JD3jUC6h8K9Y57kdouEvyZ8U8S3R9RZd7SScfTLQz3fZpMaZGQBNczPH5Ow
         EvkBI3PV2iI9ZGwdo1fjhJssp4pEuC2W8HRqCFilqhJbhobpG79yvo/pZ4OD7dVnk5Jm
         T1zmN4GqFRhp3EiJVEg2l6atCBkJnjocfXgZUTd44SaVY3dFhmxgEUCjK7I+mz3Kirv8
         uCPNRU7soWmBlZbG6Mj6YIbhYuWmo5HniBNc8SNavmYvp3j4WjY1GxXwFn46/MAvDn13
         oD5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3hgPYZswzOJylxiEd+CKNWg1+L9Fr75pQ9NU5WqEXB0ty5vaGSpLeZyJKhk9/tImF5KIj2ZCBSYGDJevY2e9o72q1x3PtkB/82z5V
X-Gm-Message-State: AOJu0YyDbiA4WjB3TuBT8Iu+7vSSZSrpIZPEKb/8BPXpcO/YEZethFU8
	6FJjxOyVenOLkbCnRsAfUIKSIWKmxzMvWkbrQZNibUk9FwhEHnR1LriGgCnvrg==
X-Google-Smtp-Source: AGHT+IF4ncAr/HVAOrE2PwcPciJR2TDuPrmAv+pFnf3AH4u0lFGpQjBCOJAI6kMhdna0sfrbzoFhNg==
X-Received: by 2002:a17:902:c083:b0:1dd:a473:750e with SMTP id j3-20020a170902c08300b001dda473750emr76126pld.27.1710372985928;
        Wed, 13 Mar 2024 16:36:25 -0700 (PDT)
Received: from [2620:0:1008:15:93dd:65bc:bbd0:d2ac] ([2620:0:1008:15:93dd:65bc:bbd0:d2ac])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001c407fac227sm181933plh.41.2024.03.13.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 16:36:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:36:24 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
cc: Chengming Zhou <chengming.zhou@linux.dev>, 
    "sxwjean@me.com" <sxwjean@me.com>, Christoph Lameter <cl@linux.com>, 
    Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mm/slub: Simplify get_partial_node()
In-Reply-To: <PH0PR11MB51924D5FA695AAEC0E41428EEC2A2@PH0PR11MB5192.namprd11.prod.outlook.com>
Message-ID: <934f65c6-4d97-6c4d-b123-4937ede24a99@google.com>
References: <20240312140532.64124-1-sxwjean@me.com> <38beee7c-aceb-4d59-ac79-e7e412a01588@linux.dev> <PH0PR11MB51924D5FA695AAEC0E41428EEC2A2@PH0PR11MB5192.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2024, Song, Xiongwei wrote:

> > On 2024/3/12 22:05, sxwjean@me.com wrote:
> > > From: Xiongwei Song <xiongwei.song@windriver.com>
> > >
> > > Remove the check of !kmem_cache_has_cpu_partial() because it is always
> > > false, we've known this by calling kmem_cache_debug() before calling
> > > remove_partial(), so we can remove the check.
> > >
> > > Meanwhile, redo filling cpu partial and add comment to improve the
> > > readability.
> > >
> > > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > > ---
> > > Changes in v2:
> > >  - Use "#if IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)" to instead
> > >    "if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))" to fix build error.
> > >    (Thanks Chengming Zhou)
> > >  - Add __maybe_unused for partial_slabs to prevent compiler warning.
> > >
> > > v1:
> > >  https://lore.kernel.org/linux-kernel/20240311132720.37741-1-sxwjean@me.com/T/
> > > ---
> > >  mm/slub.c | 24 +++++++++++++-----------
> > >  1 file changed, 13 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index a3ab096c38c0..ab526960ee5b 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -2588,7 +2588,7 @@ static struct slab *get_partial_node(struct kmem_cache *s,
> > >  {
> > >       struct slab *slab, *slab2, *partial = NULL;
> > >       unsigned long flags;
> > > -     unsigned int partial_slabs = 0;
> > > +     unsigned int __maybe_unused partial_slabs = 0;
> > >
> > >       /*
> > >        * Racy check. If we mistakenly see no partial slabs then we
> > > @@ -2620,19 +2620,21 @@ static struct slab *get_partial_node(struct kmem_cache *s,
> > >               if (!partial) {
> > >                       partial = slab;
> > >                       stat(s, ALLOC_FROM_PARTIAL);
> > > -             } else {
> > > -                     put_cpu_partial(s, slab, 0);
> > > -                     stat(s, CPU_PARTIAL_NODE);
> > > -                     partial_slabs++;
> > > +
> > > +                     /* Fill cpu partial if needed from next iteration, or break */
> > > +                     if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))
> > > +                             continue;
> > > +                     else
> > > +                             break;
> > >               }
> > > -#ifdef CONFIG_SLUB_CPU_PARTIAL
> > > -             if (!kmem_cache_has_cpu_partial(s)
> > > -                     || partial_slabs > s->cpu_partial_slabs / 2)
> > > +
> > > +#if IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)
> > 
> > Hmm, these two CONFIG_SLUB_CPU_PARTIAL look verbose to me :(
> > 
> > How about using just one, maybe like this?
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 2ef88bbf56a3..a018c715b648 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2620,19 +2620,16 @@ static struct slab *get_partial_node(struct kmem_cache *s,
> >                 if (!partial) {
> >                         partial = slab;
> >                         stat(s, ALLOC_FROM_PARTIAL);
> > +#ifdef CONFIG_SLUB_CPU_PARTIAL
> >                 } else {
> 
> I don't like splitting  "if...else..." up with preprocessor directives personally. It's messy for me.
> 

I would agree, but the flow here actually seems like it's easier to follow 
if we are checking for CONFIG_SLUB_CPU_PARTIAL in multiple places :/

