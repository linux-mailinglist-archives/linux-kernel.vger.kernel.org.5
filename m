Return-Path: <linux-kernel+bounces-60343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82185036D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB72816BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD693611F;
	Sat, 10 Feb 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiBbS/fU"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E436113
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551585; cv=none; b=OMb4DAo9n6VPd5MIWSaVMlq4uUFR23b2Q9XFKqdmaZaG8keeFZC9gDea/eebPVrZoDrIyJ9HPXPGGZqy+gldOacoAwOlJ56xAvekOpnVhxUf1xkuaJhpWxMzJi/qLuf/OxxtdiCLjZl+NVmplVGfRhzlvnjHxALcDeOaxcxgzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551585; c=relaxed/simple;
	bh=nkyC8tK1dMd2dmSg/0e0LiBXB/pFACbP8NHTKyQBFww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmPVnvLPNMSjlBSrptrllY/6GWGZ1o7rlZtU5oS7gGXGoW0qZHivsLvp2MaZ4t4pohPQcOGEuUamwZzTBvRC0kAUNQblDkLdqnIYTDUCqkOW1ZzfZUnlNeYFNSprt3wqB0xxqHxOBpvp6WeKaXOJ50PqEI56WliM5TEkbl0k7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MiBbS/fU; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-46d331e3fd2so979220137.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707551583; x=1708156383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oh7b21hgViH6ruD4OjEdfH5S4LaVkUGIxCxXRvf2xsc=;
        b=MiBbS/fU6+i38KTIU18eYGarG8sasDEsALDMQ8AS1On4XJZGpvkK1yzMbdpySo0Ffm
         Qrxq7co/9WARQ+9slk86fVIsvAdvNoDOHf9zJr7XccxNzdp4xhHAY8a9bABhKndXBBrs
         SDIzRaoZadcqDb6x64qIWH9ckR7jzq2ZZ+pC1HuXEkeZ6/vDSEQXXuGtRA1QvyBOiWv4
         ip+QnLvVzDYH5CXW8YpLTYJA7l4kFR4/SdTCMnpwrDdwvCTr29AygFEVUoDkB8M/K9Zl
         Hmwge0GeyN92sEydaqmIBmgfNDGGAZJiM6Cd8k0EqgYsJKMS+8sD9a2TNrobMCG2XILs
         bTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551583; x=1708156383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh7b21hgViH6ruD4OjEdfH5S4LaVkUGIxCxXRvf2xsc=;
        b=Fc6b23sbMmzWPv2a7IkX3W/QzK/e7pOIYKnG/GX1vHur3YawH+qjRgcnqcU15JLvfo
         3pxuTg2Et5yzxqvtvFJSR/CJdN0wHQM3hqi/BbQwAkXigyi8qE2l0I82QHtHkUvoZEs4
         Q4UcIykTA417izFxLJa4+fXn6ITc+MGyzhfh2MUkRXvmghzoQQDTv9AhC49HbgvFFOTy
         CShwtF7noqgpEomyhY/D7XVJoDnUyW8z4n6K2opAwa1/qd4H4FYxolOtbZmL9gvcAGEy
         bcdte93L0JctE7j+qCu5znLYWQ9uFj0DXTxWg1lZN8vaVr/CxQ7kd+1eVRdhJnE1Gj4t
         IUyw==
X-Gm-Message-State: AOJu0YyRnbKwQqigbZYCi42h9mjtXrQcjTP28VRcypJQt867oA9u0iPD
	YTr8xXlCK71iUJvbrOOQQfJw57hnKCN9QxJRQWMa8kh+MZ3LSALo+BD3YDYz5pT3sUndGTwXHNM
	o6rTrEub7OvT8AIMYfHDntE2JV4GOjinDsaD0
X-Google-Smtp-Source: AGHT+IEy5rUmGLmkkY3OAPFo9Hk+pfbInuFkdngpUfw0cdyQRm4JJclp/RrYVG0JQ72JVRTrm/4TEUFpxSUyyzFVwAU=
X-Received: by 2002:a05:6102:548c:b0:46d:2f69:c772 with SMTP id
 bk12-20020a056102548c00b0046d2f69c772mr1600399vsb.11.1707551583163; Fri, 09
 Feb 2024 23:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-4-osalvador@suse.de>
 <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
 <ZcaesCP4mY-94ciJ@localhost.localdomain> <ZcaxxQE1PkepEWwf@localhost.localdomain>
In-Reply-To: <ZcaxxQE1PkepEWwf@localhost.localdomain>
From: Marco Elver <elver@google.com>
Date: Sat, 10 Feb 2024 08:52:25 +0100
Message-ID: <CANpmjNOpfdgMT1jNPJev_e6tecZjGn4n8Sk6aoaLVDsqfJgmKg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 00:13, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Fri, Feb 09, 2024 at 10:52:48PM +0100, Oscar Salvador wrote:
> > Thinking about it some more, I think I made a mistake:
> >
> > I am walking all buckets, and within those buckets there are not only
> > page_owner stack_records, which means that I could return a stack_record
> > from e.g: KASAN (which I think can evict stack_records) and then
> > everything goes off the rails.
> > Which means I cannot walk the buckets like that.
> >
> > Actually, I think that having something like the following
> >
> >  struct list_stack_records {
> >       struct stack_record *stack;
> >       struct list_stack_records *next;
> >  }
>
> Or, I could use the extra_bits field from handle_parts to flag that
> when a depot_stack_handle_t is used by page_owner.
>
> Then __stack_depot_get_next_stack_record() would check whether
> a stack_record->handle.extra_bits has the page_owner bit, and only
> return those stacks that have such bit.
> This would solve the problem of returning a potentially evictable stack
> , only by returning page_owner's stack_records, and I would not have
> to maintain my own list.
>
> I yet have to see how that would look like, but sounds promising.
> Do you think that is feasible Marco?

The extra bits are used by KMSAN, and might conflict if enabled at the
same time. I think the safest option is to keep your own list. I think
that will also be more performant if there are other stackdepot users
because you do not have to traverse any of the other entries.

