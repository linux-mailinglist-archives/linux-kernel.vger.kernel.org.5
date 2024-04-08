Return-Path: <linux-kernel+bounces-134992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A489B9B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF82F1C220A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775042C68C;
	Mon,  8 Apr 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okhxeRvR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C025632
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563670; cv=none; b=oz4T5fejDCuhOC5iPbx/lNT6S+KjDDzwT3UoW9Kwx2TL+NgGUS6iOgqgez4L21H2Vj+DEBOkzrvvzMgHxjhrbdsr1Gh2tuYlUTHF1wPAlWS3DLNCswTM8TX2wxBgkiwTFiSecaERQG2y6MzgRhOBj5YhdYj8F038ybNMPDaxOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563670; c=relaxed/simple;
	bh=QQ1VVyZkH5gHgTmHMa8SsQ2lj/VU/Uyu1HFqExvwiZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRyx1WB0o+ZBgmx80TzerhJ/si3q4iT0X9lSwrr8KLeagwKJ9yuG5rMNVPZXOi4jMYGRp0T0Wofcb6t2ymI+LKfMwXRN41wBi+I/Zcej/zgx/gH9U5n4GkPvo7yQ2irJHhwMc0TiXis7fRmnZEcL7FGy2deBbovOhj7oWvqitDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okhxeRvR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51d7213a42so60273866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712563667; x=1713168467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ1VVyZkH5gHgTmHMa8SsQ2lj/VU/Uyu1HFqExvwiZc=;
        b=okhxeRvRlYDCicPQjkKHZ2fwDizsdOnzFRZ5IbtJqWVFm2LK0QDwTstLwYZDq9wRr7
         F6MB6a71It8qbSzsvA62YzZdTefpDsafu+8TiFvMr8mhmUfDfaTkRDPQU8+NJYigPpgA
         eSLEqmkhM9F+cXbrGyKx2Pdy2LocbvTMh4GguyGN6MZu9vCkWKg2PzFtkg758zdeFlrB
         uEf2RnZtZxoKyFn1zIxzMHDOlqbGgJDxZzXj0gM3DhsOdRWLBKM/PCm5WyeElFMg5101
         YDkOgvhTiJMUF2UnHc3mGcSIJDYn+OZm/aFtnsq0vj4gO+zIJcu61JZTLN96cdPGq7Bj
         8d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563667; x=1713168467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ1VVyZkH5gHgTmHMa8SsQ2lj/VU/Uyu1HFqExvwiZc=;
        b=Fozf90X0ojGUVZfACIPAWLyGstfAPWRbQTdmhB4U8iO6IO7CNBsvBjvZzNLuK6YnpV
         +ZAdrUGnA89BAwoWQ9lijzXYzLTsuGgxoUMoWSbs6R+5lBwZM2D0/7l/kK0EaHGx4IBs
         xrZgnk+udmuXAipxaeF6l7OWgiXYn0rkGnfI9LCdVLcQOCHZHP2p2VclRD9rPpE30Mlh
         8tthC1YjO20ofrfzjHPE50pWbCVGNszx5eH1Iyxpelu3r5e2O/V89ZCTgnuVjE1Z1SNJ
         O10P3/II28GMWKMD0bKe8z3hf+43Suogq7dFjxqHvLrXyLhj2Z6nGqBL9rieI+AgaNui
         QtAw==
X-Forwarded-Encrypted: i=1; AJvYcCWRs0sIHfLxElqtP6mBXXzXRobkB+OZkAEygtiaC8ixsWvlv2kGX3OMT0dnDuyMgth7YiYKHR13a3F01vnR5Cd/cYKHC3dZVEXA1AhU
X-Gm-Message-State: AOJu0YzasDwvTalIGpA2R4/XXNiLSa8g/gbmv1kqq+9Uuo+Cj59zljU8
	9nizhgDQ7xLe3RbbOPXu0jsfhkcvC1/4O0OoVDsDuMhUKvbPujLqDS2WdNNzQ7Jxv7pgp9UfEZS
	SozymSWbr7af0fESByHFhHCkVoyQ3ZAkTTdlQfrEtk2YJQsr9L+/biHw=
X-Google-Smtp-Source: AGHT+IHxAsaJ19Ba0Hc05w6Db+kU++86Unb8MGNdlBJwCj3eDLRx5iB9LhpXvl2TFAB0lxwYPWwA8pS5v4PmXD32zLU=
X-Received: by 2002:a17:907:7ea4:b0:a4e:5676:417d with SMTP id
 qb36-20020a1709077ea400b00a4e5676417dmr8477188ejc.58.1712563666917; Mon, 08
 Apr 2024 01:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com> <20240405152619.GA866431@cmpxchg.org>
 <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com> <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com>
In-Reply-To: <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 8 Apr 2024 01:07:08 -0700
Message-ID: <CAJD7tkaa3P7dQys+LhuDe8kqWsUqf7PDB8Q+07+wnQ513-6NLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> >> Note that totalram_pages can also change during memory onlining and
> >> offlining. For that you need a memory notifier that also calls that
> >> refresh function. It's simple enough, though, check out the code
> >> around register_memory_notifier() in drivers/xen/balloon.c.
> >
> > Good point, I completely missed this. It seems like totalram_pages can
> > actually change from contexts other than memory hotplug as well,
> > specifically through adjust_managed_page_count(), and mostly through
> > ballooning drivers. Do we trigger the notifiers in this case? I can't
> > find such logic.
>
> Things like virtio-balloon never online/offline memory and would never
> call it.

I see calls to adjust_managed_page_count() from
drivers/virtio/virtio_balloon.c, but I don't understand enough to know
what they are doing.

>
> Things like virtio-mem sometimes will online/offline memory and would
> sometimes call it (but not always). Things like the Hyper-V balloon and
> XEN balloon never offline memory, and would only call it when onlining
> memory.

Thanks for the details.

>
> >
> > It seems like in this case the actual amount of memory does not
> > change, but the drivers take it away from the system. It makes some
> > sense to me that the zswap limits do not change in this case,
> > especially that userspace just sets those limits as a percentage of
> > total memory. I wouldn't expect userspace to take ballooning into
> > account here.
> >
>
> For virtio-mem, it does change ("actual amount of memory"). For
> virtio-balloon, it's tricky. When using virtio-balloon for VM resizing,
> it would similarly change. When using it for pure memory overcommit, it
> depends on whatever the policy in the hypervisor is ... might be that
> under memory pressure that memory is simply given back to the VM.

That's good to know, it seems like we need to take these into account,
and not just because the users may happen to change zswap limits while
they are onlining/offlining memory.

>
> > However, it would be a behavioral change from today where we always
> > rely on totalram_pages(). Also, if userspace happens to change the
> > limit when a driver is holding a big chunk of memory away from
> > totalram_pages, then the limit would be constantly underestimated.
> >
> > I do not have enough familiarity with memory ballooning to know for
> > sure if this is okay. How much memory can memory ballooning add/remove
> > from totalram_pages(), and is it usually transient or does it stick
> > around for a while?
> >
> > Also CCing David here.
>
> It can be a lot. Especially with the Hyper-V balloon (but also on
> environments where other forms of memory hotunplug are not supported),
> memory ballooning can be used to unplug memory. So that memory can be
> gone for good and it can end up being quite a lot of memory.
>
> The clean thing to do would be to have a way for other subsystems to get
> notified on any totalram_pages() changes, so they can adjust accordingly.

Yeah I agree. I imagined that register_memory_notifier() would be the
way to do that. Apparently it is only effective for memory hotplug.
From your description, it sounds like the ballooning drivers may have
a very similar effect to memory hotplug, but I don't see
memory_notify() being called in these paths.

Do we need a separate notifier chain for totalram_pages() updates?

