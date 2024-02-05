Return-Path: <linux-kernel+bounces-53831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F109384A70E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CC428A94B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FCA60BA4;
	Mon,  5 Feb 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk3IsXrS"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659960B82
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162078; cv=none; b=T+Vd8P5AUFIeDfK4r/xGU5B6ydiHyhTC5Xa/WxXsifvEaydzbYaZJax0U0q4PeKJWS7kP4J5fke2cJZxBeuXcWuYLqCnciCl7/ch523tt/Ai///mqxbdrynFbw5/FhxSvUr4KzPCUdb0G/Fx4O3k/P6EYPOiIf3J9WH7p6uwYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162078; c=relaxed/simple;
	bh=3b6oeS+sd5xoZNeIJEQUdkAN1RG5u3Jd70MTpYqp6SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG5zbWkPyv3uZlyx6+2CF79ToGYIWzkZd0ZqpdwU0ojVPOjzVISLTjG4uQoW7St8ftSEg4WBkQS5q5vjHfsmG6lfrp4XaPEAfbSqPlvjqt2oUxgozTC6FMaw/6c8iyE4LEmEnT9YDwU9wpy/Z4sxPcqClBVqY5sg9KcETH8V43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk3IsXrS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so3531538a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707162076; x=1707766876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b6oeS+sd5xoZNeIJEQUdkAN1RG5u3Jd70MTpYqp6SQ=;
        b=Lk3IsXrSX4wqxMlMk7cri4M6IUXcDa2FnzoZ/TKm30119aM0SuBdhFGEvRboC94oK5
         kzLhb9t1fAmTyXZY6/yQDXwbkKQkWOkdDka7jMz2D2LQ3Ze6+w1L6GTOXfQgcMxrPyoC
         04uc2A1UcalW87jBF3R+bq3nkrX3DQz/aw4NgMq8kv70u6hCW1zpPA33VfsYDDpHyiyr
         zuyk+llMkzLH6qHj7YpJoS4xSEsLfB4M313GJjs51sl7B7khLDE//kRtOQcnCS7W7cfi
         pjUL9oM+juG+A5yfL7wePr6WrpD+RdT3ics95PNj1zIt4XY7BRVI/LU1898pmHWyLs8q
         a+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162076; x=1707766876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b6oeS+sd5xoZNeIJEQUdkAN1RG5u3Jd70MTpYqp6SQ=;
        b=k3EjvpEcUyynmPagrhezzdRTK/HawhTfx7jx+5LHnENhzWTA8qhdW1fcEQjmdHGL7m
         rIckz08RhoQQYLjFEkDOo7ufbW++A5O8XFSF0Xg81Ffs+nRSt3So5oGVcYJ0rbZyR7R2
         gIiF001ZqwKiKSAqLeuaItYmFfeyxmLZSGNWKi3jlReOfgv/HscPalvU4kA/mUbpc/Dt
         O0tYLVglpM8ZXo0sNneVvco/ORH6pdBQhB/Ana/V5Gd1efBEK0M2HMr0Fbp2p22JWlxM
         BNeSAt25f9SCL1YzvH/fJUgsOnLvYUUdHI2piWONXwkTZfJYqWEIrMhM7aPfVoe9dPmI
         tkfg==
X-Gm-Message-State: AOJu0YxSUJvOAaiysvdDb2x/u4iSCE69ydkbb97H9wQ+9NAEZ3zvmiiE
	HWD1OSQloGUhzaPsOxi5TFWOtAMKus4weyUERBVmMzDDd0nGnJRmD1RSNqYNYCmBwGrMkcePfFj
	GPImdNaVrbEXL6tEa71rTd9u/K7g=
X-Google-Smtp-Source: AGHT+IGZcG8Y0PjKAioDsv7aAA6ZG2FjD0D14DE2NUFI5ykKeMGcmCUrJ2PIWDJdVOpxzinNN2Cjm/ZRFPVZGoOahrc=
X-Received: by 2002:a17:90b:4b41:b0:296:1979:cc61 with SMTP id
 mi1-20020a17090b4b4100b002961979cc61mr492646pjb.0.1707162075750; Mon, 05 Feb
 2024 11:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka> <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka> <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
 <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com> <CAK1f24n_ahUoWvw1zJN3P9W-4cxuQVL=1cOZKNjiBhp-ortc5g@mail.gmail.com>
In-Reply-To: <CAK1f24n_ahUoWvw1zJN3P9W-4cxuQVL=1cOZKNjiBhp-ortc5g@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 5 Feb 2024 11:41:02 -0800
Message-ID: <CAHbLzkqMTpja+RuePjy4Oz=0Eq2j7LP8hwApGZWu9v6MkKs+Ag@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Lance Yang <ioworker0@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	zokeefe@google.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:17=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> Hey Michal, David, Yang,
>
> I sincerely appreciate your time!
>
> I still have two questions that are perplexing me.
>
> First question:
> Given that khugepaged doesn't treat MADV_FREE
> pages as pte_none, why skip the 2M block when all
> the pages within the range are old and unreferenced,
> but won't skip if the partial range is MADV_FREE,
> even if it's not redirtied? Why make this distinction?
> Would it not be more straightforward to maintain
> if either all were skipped or not?

It is just some heuristic in the code and may be some arbitrary
choice. It could controlled in a more fine-grained way if we really
see some workloads get benefit.

>
> Second question:
> Does copying lazyfree pages (not redirtied) to the
> new huge page during khugepaged collapse
> undermine the semantics of MADV_FREE?
> Users mark pages as lazyfree with MADV_FREE,
> expecting these pages to be eventually reclaimed.
> Even without subsequent writes, these pages will
> no longer be reclaimed, even if memory pressure
> occurs.

Yeah, it just means khugepaged wins the race against page reclaim. I'm
supposed the delayed free is one of the design goals of MADV_FREE, and
the risk is the pages may not be freed eventually. If you want
immediate free or more deterministic behavior, you should use
MADV_DONTNEED or munmap IIUC.

>
> BR,
> Lance
>
> On Sat, Feb 3, 2024 at 1:42=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
> >
> > On Fri, Feb 2, 2024 at 6:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com>=
 wrote:
> > >
> > > How about blocking khugepaged from
> > > collapsing lazyfree pages? This way,
> > > is it not better to keep the semantics
> > > of MADV_FREE?
> > >
> > > What do you think?
> >
> > First of all, khugepaged doesn't treat MADV_FREE pages as pte_none
> > IIUC. The khugepaged does skip the 2M block if all the pages are old
> > and unreferenced pages in the range in hpage_collapse_scan_pmd(), then
> > repeat the check in collapse_huge_page() again.
> >
> > And MADV_FREE pages are just old and unreferenced. This is actually
> > what your first test case does. The whole 2M range is MADV_FREE range,
> > so they are skipped by khugepaged.
> >
> > But if the partial range is MADV_FREE, khugepaged won't skip them.
> > This is what your second test case does.
> >
> > Secondly, I think it depends on the semantics of MADV_FREE,
> > particularly how to treat the redirtied pages. TBH I'm always confused
> > by the semantics. For example, the page contained "abcd", then it was
> > MADV_FREE'ed, then it was written again with "1234" after "abcd". So
> > the user should expect to see "abcd1234" or "00001234".
> >
> > I'm supposed it should be "abcd1234" since MADV_FREE pages are still
> > valid and available, if I'm wrong please feel free to correct me. If
> > so we should always copy MADV_FREE pages in khugepaged regardless of
> > whether it is redirtied or not otherwise it may incur data corruption.
> > If we don't copy, then the follow up redirty after collapse to the
> > hugepage may return "00001234", right?
> >
> > The current behavior is copying the page.
> >
> > >
> > > Thanks,
> > > Lance
> > >
> > > On Fri, Feb 2, 2024 at 10:42=E2=80=AFPM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Fri 02-02-24 21:46:45, Lance Yang wrote:
> > > > > Here is a part from the man page explaining
> > > > > the MADV_FREE semantics:
> > > > >
> > > > > The kernel can thus free thesepages, but the
> > > > > freeing could be delayed until memory pressure
> > > > > occurs. For each of the pages that has been
> > > > > marked to be freed but has not yet been freed,
> > > > > the free operation will be canceled if the caller
> > > > > writes into the page. If there is no subsequent
> > > > > write, the kernel can free the pages at any time.
> > > > >
> > > > > IIUC, if there is no subsequent write, lazyfree
> > > > > pages will eventually be reclaimed.
> > > >
> > > > If there is no memory pressure then this might not
> > > > ever happen. User cannot make any assumption about
> > > > their content once madvise call has been done. The
> > > > content has to be considered lost. Sure the userspace
> > > > might have means to tell those pages from zero pages
> > > > and recheck after the write but that is about it.
> > > >
> > > > > khugepaged
> > > > > treats lazyfree pages the same as pte_none,
> > > > > avoiding copying them to the new huge page
> > > > > during collapse. It seems that lazyfree pages
> > > > > are reclaimed before khugepaged collapses them.
> > > > > This aligns with user expectations.
> > > > >
> > > > > However, IMO, if the content of MADV_FREE pages
> > > > > remains valid during collapse, then khugepaged
> > > > > treating lazyfree pages the same as pte_none
> > > > > might not be suitable.
> > > >
> > > > Why?
> > > >
> > > > Unless I am missing something (which is possible of
> > > > course) I do not really see why dropping the content
> > > > of those pages and replacing them with a THP is any
> > > > difference from reclaiming those pages and then faulting
> > > > in a non-THP zero page.
> > > >
> > > > Now, if khugepaged reused the original content of MADV_FREE
> > > > pages that would be a slightly different story. I can
> > > > see why users would expect zero pages to back madvised
> > > > area.
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs

