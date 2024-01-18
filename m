Return-Path: <linux-kernel+bounces-30394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF5831E23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B1E288C89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA52C6BE;
	Thu, 18 Jan 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7aVVcZA"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38D25742
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597642; cv=none; b=NxLdrFIrdqf7pLxbw7nfEnHxtewCTK5Xho3o9n1sWwyYBeqG8EtTeAuYjmh4UP2mrUPyLcRlkHUhRD5W7RwzG2fUZEzlmdo+pdIESYVlMntOxrqNf0a7lmsodT7dcdhv5LNCaU526FjPD7wdP5LhgrWPRXMyvwHBRyRNJ/qBzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597642; c=relaxed/simple;
	bh=HlYwd4ZgoThSOWDK/BI/ByWriREGCZu6HCgLz+Vx7lU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=RsEfrhlHVZBnP4e27F74tYtlhhXLfh2JyomeSggXKi7dNwzWt4vOXUa3HP+OqQ6tFXCX+NkVuD8OzJPmDTuJ6Gs5t6/a4Jw5zpc0Nxn5WeHV2JZbuw5/rmRn8H7H9IKO4KasrNl68cfZfmp6hZazI1N6D+S5nuwxfZ3aC55aGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7aVVcZA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26fa294e56so1307142266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705597639; x=1706202439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HlYwd4ZgoThSOWDK/BI/ByWriREGCZu6HCgLz+Vx7lU=;
        b=k7aVVcZAG91ZgvgGHqLQQus/CNIUKv7CBvOaehJ259V1nsQ1NsDBWRAMgXD8FUePSu
         Ze2xRB6mKfmC2fagT5JZ1BkuKsdgJO/00DEQlpQQp9Swe/d+ATmDeXVqXANRoaWHhV3I
         ByzP+wsrK1G6T17xEWKnvkL54F2JUI0jSOitM0m3kybWLu5Z+MJsJcFn/E9jYz5lEjzd
         zoZ0aHRLlSJN+ALep+hZhW0k1MhrDedlq6a96SFxg3W59Fz1PYXGmRCz8P1rqrIUue/a
         ABdvX8hx9AwIz1MsBcaUFAbJzJU6IHnWBnP/hKHqVyVGL99qLSMJ9fg5xenqIgrLOKyi
         PtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597639; x=1706202439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlYwd4ZgoThSOWDK/BI/ByWriREGCZu6HCgLz+Vx7lU=;
        b=C2rbr6uPt7E3rIX7vNzKr9EZDtB+ENcJHeCUBYgvnWFuyDIjFoXa6PXdC/qaYeDqOh
         pGSwsAZ+JK3eFp5+xGONH/rCI55JDj9RRfc7Bqcwg8cbCg1OufLHcPiyMmFFYZMNZ9h0
         Mmylr0cjBrjIpnguGqBta/hI5QvDe709Nj28gbo7lVYU/Tkmo7mK8RJaxpv1/70ia7Ru
         SjIbcezWC57WnlHeDCKinTMTD5oS/T8WZQdL3kYjSD/8LGKvSHZO9uLZh4CjkK3PJoOw
         X9rjvkxGaCsL+ZWHLzg7bQSHWKy7VfsEhJd3lL5xsDICn+mGoHhvgPPFcY2YucZL76Y1
         lGTQ==
X-Gm-Message-State: AOJu0YyC8mrNOX+V05WV3O+6ZylasxY1PFyBGsfgIvW72L5WLoZV0N48
	VjtlGNuEu3E64tth/Z8PKSUmIHZkPgEU78DaiaXhCiaAjU/rXRzjhl6GZ1m1SceU+B48qWcmydP
	3pT2L337+l+8/fHVesPpyYZEHQc+UtTenaKBc
X-Google-Smtp-Source: AGHT+IH8tvSJMBVtMjgt9oPnZXK6j/SOiKaEy5MCl32mJd7TLLo+oh5V3GfqfLmK0RNVJ0qI/u/fj1frwUcpuq7wqzA=
X-Received: by 2002:a17:906:eb4a:b0:a29:8155:b813 with SMTP id
 mc10-20020a170906eb4a00b00a298155b813mr781055ejb.85.1705597639224; Thu, 18
 Jan 2024 09:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com> <20240118161601.GJ939255@cmpxchg.org>
In-Reply-To: <20240118161601.GJ939255@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 09:06:43 -0800
Message-ID: <CAJD7tkb+NCocjpjvM08Nv2fPMDqm4t-YH05TJckz8m1AYFNWUg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > On a different note, I wonder if it would help to perform synchronous
> > > reclaim here instead. With our current design, the zswap store failure
> > > (due to global limit hit) would leave the incoming page going to swap
> > > instead, creating an LRU inversion. Not sure if that's ideal.
> >
> > The global shrink path keeps reclaiming until zswap can accept again
> > (by default, that means reclaiming 10% of the total limit). I think
> > this is too expensive to be done synchronously.
>
> That thresholding code is a bit weird right now.
>
> It wakes the shrinker and rejects at the same time. We're guaranteed
> to see rejections, even if the shrinker has no trouble flushing some
> entries a split second later.
>
> It would make more sense to wake the shrinker at e.g. 95% full and
> have it run until 90%.
>
> But with that in place we also *should* do synchronous reclaim once we
> hit 100%. Just enough to make room for the store. This is important to
> catch the case where reclaim rate exceeds swapout rate. Rejecting and
> going to swap means the reclaimer will be throttled down to IO rate
> anyway, and the app latency isn't any worse. But this way we keep the
> pipeline alive, and keep swapping out the oldest zswap entries,
> instead of rejecting and swapping what would be the hottest ones.

I fully agree with the thresholding code being weird, and with waking
up the shrinker before the pool is full. What I don't understand is
how we can do synchronous reclaim when we hit 100% and still respect
the acceptance threshold :/

Are you proposing we change the semantics of the acceptance threshold
to begin with?

