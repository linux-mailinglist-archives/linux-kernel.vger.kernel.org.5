Return-Path: <linux-kernel+bounces-145920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0EC8A5CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4933A284F31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482E157491;
	Mon, 15 Apr 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxHdFkcQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26715746D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215791; cv=none; b=p8R61TAM6ML5D8bsiZa0bs8rTK1bRElfmJZ3Qx/PwltZ+AFwNNpbdzkVdBkjRk8cfM3YF9yFCxckwWZ/PfbxrY7YnTqiRoFPKXMCbX4NdezQ7oWYXIFMlWNiaKYHUEpr7xuMZp8bRMy3W6qiTCew4lEC0FoLL3knM1KX1qkbaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215791; c=relaxed/simple;
	bh=/gBO3bQqorcLrlItRxZaPGQ7ONvyrajD2NgIHaH5MR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAd9thEh9yd3vaQfpJoFwE7eHsGXoIaW391w24VVsDP3hD77YAewL5plUszCZR6B7JFJ18ghfMJ7RfN0RXgTL9IafNgFve1l8s2G5o17npbKtumHXrcZHllQpkAlAjU1Dmtyav1wnyENB8Cj88dzanMKZcfpP0YEqNYbwjbUjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxHdFkcQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3806411e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215788; x=1713820588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gBO3bQqorcLrlItRxZaPGQ7ONvyrajD2NgIHaH5MR8=;
        b=CxHdFkcQN3vUtfPzn6fJ752rWjZZYkNcegt1MndkW5AwfcsZWa9CTp1RoYPwP9xX3i
         9KOdXVkfkSZedkS4tVRC0Qbt6I0T38HV2ionpgoDnMRh5CN1ifTmxZlUHOUoX4s47KD8
         iu4Og0DhYejTUX0l7ENV1MHQWFQ/f+8c3FwNEKmeOp+as2LBvnClGO/GtTFNmaiue7xg
         iqc6Ix/v3f+IYH+Us+1fewcjQmSBWbbrxDtX/40V4pA9fP8I77IRkJ9Unr0PUw68VpMT
         q9wjNjm7SZPxXhupOJj8ALfpUu52pNKCGdcgUjiBWsvMVrfb3pAKfPRKiyk0L+FCZWZH
         7Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215788; x=1713820588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gBO3bQqorcLrlItRxZaPGQ7ONvyrajD2NgIHaH5MR8=;
        b=TlgCSm9aNtl6CpAIcPn+0Ip02CKhKLy6enLxZRFxfYaLJyI96RXb5u+hb68yFhO/Eg
         I6MG5D5zY5SGHeX6dcBN+E8fvkCgxuBdYw7s9YUAgBCmUG42MVR7IAxoOdzEoIW5mVR9
         noS1jjThxI/TQ3VIHVmWZgxABNLXPJeG7nVj/lEeSRBko4Gk6MmaA4k0xAmjG9mLE59I
         GoW0gscI2t/WDmfT1DMfQetT8JKZvP6YsykGfoAt3G1vb/k57aSWXiwp2sHO2Fo7RZ+h
         zKWXhMTPST/tDq2UiqgDszIbjUcyqFjQkuMqO4R+bihK/DOjLzPhvlM7ayXK72y60suR
         q2EA==
X-Forwarded-Encrypted: i=1; AJvYcCV5UX0OjH1pZw5+DzQ1h3uFf0vux7px47mcT0N5Wnp7Asq7horKkq5cJNbTY1Z5fFvDazVy1X5ZxBea+s29QUiXStybB9V5EAWZZT+U
X-Gm-Message-State: AOJu0YwyXHdOcIQKx3EbotN60siqIOhVNCt8P+bo87PdJtVvR7gi3XXZ
	+sHBQzEihy3AOOh0xC+S1XWllHuiA7E71vmttz/FIHckz8BlXYHtuZsUBuI20sbFP15knCK/BlI
	mLA/uArfgue1oxcSpDnPYKOQpS9U=
X-Google-Smtp-Source: AGHT+IEDn5kGKqXTNIp9wi5FOGO4o+yR/DHKy6T42if6Z7v7yd8DMUUrry362dBPDSX4Q/0P54AkmG4jasb6JD7/cJA=
X-Received: by 2002:a19:5e02:0:b0:517:8e01:266f with SMTP id
 s2-20020a195e02000000b005178e01266fmr8591806lfb.2.1713215787578; Mon, 15 Apr
 2024 14:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com> <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com> <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
 <60049ec1-df14-4c3f-b3dd-5d771c2ceac4@redhat.com> <CAHbLzkpMjSUpB2gsYH+4kkEtPuyS4bP7ord+nSgR9xcp3fyVFQ@mail.gmail.com>
 <c76c78ab-7146-4963-97aa-980b767e84a5@redhat.com>
In-Reply-To: <c76c78ab-7146-4963-97aa-980b767e84a5@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 15 Apr 2024 14:16:15 -0700
Message-ID: <CAHbLzkrAyt2U4Lr=zqh-G8sgKwJEn7cP3OiRydbhSgnyJEwsTQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:19=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >>
> >> We could have
> >> * THP_DEFERRED_SPLIT_PAGE
> >> * THP_UNDO_DEFERRED_SPLIT_PAGE
> >> * THP_PERFORM_DEFERRED_SPLIT_PAGE
> >>
> >> Maybe that would catch more cases (not sure if all, though). Then, you
> >> could tell how many are still on that list. THP_DEFERRED_SPLIT_PAGE -
> >> THP_UNDO_DEFERRED_SPLIT_PAGE - THP_PERFORM_DEFERRED_SPLIT_PAGE.
> >>
> >> That could give one a clearer picture how deferred split interacts wit=
h
> >> actual splitting (possibly under memory pressure), the whole reason wh=
y
> >> deferred splitting was added after all.
> >
> > I'm not quite sure whether there is a solid usecase or not. If we
> > have, we could consider this. But a simpler counter may be more
> > preferred.
>
> Yes.
>
> >
> >>
> >>> It may be useful. However the counter is typically used to estimate
> >>> how many THP are partially unmapped during a period of time.
> >>
> >> I'd say it's a bit of an abuse of that counter; well, or interpreting
> >> something into the counter that that counter never reliably represente=
d.
> >
> > It was way more reliable than now.
>
> Correct me if I am wrong: now that we only adjust the counter for
> PMD-sized THP, it is as (un)reliable as it always was.

Yes. The problem introduced by mTHP was somehow workaround'ed by that commi=
t.

>
> Or was there another unintended change by some of my cleanups or
> previous patches?

No, at least I didn't see for now.

>
> >
> >>
> >> I can easily write a program that keeps sending your counter to infini=
ty
> >> simply by triggering that behavior in a loop, so it's all a bit shaky.
> >
> > I don't doubt that. But let's get back to reality. The counter used to
> > stay reasonable and reliable with most real life workloads before
> > mTHP. There may be over-counting, for example, when unmapping a
> > PTE-mapped THP which was not on a deferred split queue before. But
> > such a case is not common for real life workloads because the huge PMD
> > has to be split by partial unmap for most cases. And the partial unmap
> > will add the THP to deferred split queue.
> >
> > But now a common workload, for example, just process exit, may
> > probably send the counter to infinity.
>
> Agreed, that's stupid.
>
> >
> >>
> >> Something like Ryans script makes more sense, where you get a clearer
> >> picture of what's mapped where and how. Because that information can b=
e
> >> much more valuable than just knowing if it's mapped fully or partially
> >> (again, relevant for handling with memory waste).
> >
> > Ryan's script is very helpful. But the counter has been existing and
> > used for years, and it is a quick indicator and much easier to monitor
> > in a large-scale fleet.
> >
> > If we think the reliability of the counter is not worth fixing, why
> > don't we just remove it. No counter is better than a broken counter.
>
> Again, is only counting the PMD-sized THPs "fixing" the old use cases?

Yes

> Then it should just stick around. And we can even optimize it for some
> more cases as proposed in this patch. But there is no easy way to "get
> it completely right" I'm afraid.

I don't mean we should revert that "fixing", my point is we should not
rely on it and we should make rmap remove code behave more reliable
regardless of whether we just count PMD-sized THP or not.

>
> --
> Cheers,
>
> David / dhildenb
>

