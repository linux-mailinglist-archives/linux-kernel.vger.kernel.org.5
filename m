Return-Path: <linux-kernel+bounces-50255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 477AB847673
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C41C25CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FF314C581;
	Fri,  2 Feb 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaRuyXdF"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F847E5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895762; cv=none; b=k3fHOJtuPwCbkpcrH91MBGsONYuuwvDUvWzegfFCqLIGOz3DR096I/7zNxjTwfrYa1FBCiAx6Ts+jMHo0tj2bJtHQH/u089xmtWMhiwnBA3iX2Wg68m/6ilOcyq/GWG/SRUXr6nrgaLOpSOhczTvp54yxSeE+LyeeVTpCdQKCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895762; c=relaxed/simple;
	bh=YbZrUNv0lorsBlq8MWkZPKDTCLxKxKnhmcAsSst1DGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYPGZNOBMqfNyp73sLcOjO4MllSVz1YC1hdybQDERSWEI57C9ysEEYVWUrrXbt4n9IpUDbmo1p+EX9NQdDHKoLkvDoTGPHl6BC5S74HStqGlQme+el7LdXHB+ACxMLqVNIdaJVmbv9G8UbEc/M7jF7ryJO7G03Wbm5SATvvSrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaRuyXdF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1862080b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895760; x=1707500560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbZrUNv0lorsBlq8MWkZPKDTCLxKxKnhmcAsSst1DGI=;
        b=EaRuyXdFQbZQO9M4X21gv8NO9ws2L/mLUycJPY2BBiii6leSWiWDf28UOyjHFIgxZ2
         bBFlax4jvZd5sycQon1OJu2BdLQIAVvqlFuuheW7A5zScziJVBLSfgCHQvDfSbDhpIi2
         S8mS7DdVB+gM8J7V9pLQh8WbRA7WJKPqCPVrf0O7EocsCmrTVTQ+FfW8Fu5BfMP3HARm
         IQetQtg5TQlJvVGi/tPdfXIkg7PJUgeGai+Rm2ScIcTxcg3VhW/tmeaMY1ToMiff/oo6
         l6NxywjvNpnXY4CzWOD1lQxXu1AiBNOWif0vy3MiSwkuCHwCkzL0lpHzxroLVm0zdvth
         dz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895760; x=1707500560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbZrUNv0lorsBlq8MWkZPKDTCLxKxKnhmcAsSst1DGI=;
        b=YeiEqbA78Z/TgDbNNfVY/qcAL1fI781O2i05CffnszFGFH6agvDFpWcTAggGp61UZb
         VF9FrDZEj0CDmF25tBFQ/LTUw+Mgj+w6f5dRloXuU+Ak6r9Qw8kx6v+YtjSwSvfGT2lM
         5OC7LewA1ZITJ1IXJ2zg7rBL0TDw+u4b9EonzyP3ajZGMmq/TSMLhhFfCskNGj+LX2pb
         F7XE/J6HxNzKOoU4FmZbS6jU8LALcGeRrGopUYCd3fPemHnGOZM19sZhKC1AVdzVqKWJ
         4oQcMor0enV0mqflhnIWqsyxQpL95q4pfkgFgfleIWzlYfj5mybwCANV2EmbXAwkOWx5
         RuPA==
X-Gm-Message-State: AOJu0YxAKG4HvyfIv0kQHYRygiqdUXuQHYDf9d9eXbIvJRuXtAw5DeXN
	vkarFTrXBPtPDcweVQ3Vb0rhjcn9llm08OVLAmRmkHl60FK20vZMMkWyMBMSwjHnMHvNuqcyQbJ
	Jd+N2Q46At0CD8wj7R2gvhfRz4Qk=
X-Google-Smtp-Source: AGHT+IEagYrFGa1mLHqR4YR39HzL8/XAu8T17Suk0bkr6hsml9Fy+Y3fUJy/q1XbAv78Ia5V9IAZUXWTGwhxoTOAoKI=
X-Received: by 2002:a62:f24b:0:b0:6d9:aaef:89a7 with SMTP id
 y11-20020a62f24b000000b006d9aaef89a7mr2981119pfl.10.1706895759977; Fri, 02
 Feb 2024 09:42:39 -0800 (PST)
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
In-Reply-To: <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 2 Feb 2024 09:42:27 -0800
Message-ID: <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Lance Yang <ioworker0@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> How about blocking khugepaged from
> collapsing lazyfree pages? This way,
> is it not better to keep the semantics
> of MADV_FREE?
>
> What do you think?

First of all, khugepaged doesn't treat MADV_FREE pages as pte_none
IIUC. The khugepaged does skip the 2M block if all the pages are old
and unreferenced pages in the range in hpage_collapse_scan_pmd(), then
repeat the check in collapse_huge_page() again.

And MADV_FREE pages are just old and unreferenced. This is actually
what your first test case does. The whole 2M range is MADV_FREE range,
so they are skipped by khugepaged.

But if the partial range is MADV_FREE, khugepaged won't skip them.
This is what your second test case does.

Secondly, I think it depends on the semantics of MADV_FREE,
particularly how to treat the redirtied pages. TBH I'm always confused
by the semantics. For example, the page contained "abcd", then it was
MADV_FREE'ed, then it was written again with "1234" after "abcd". So
the user should expect to see "abcd1234" or "00001234".

I'm supposed it should be "abcd1234" since MADV_FREE pages are still
valid and available, if I'm wrong please feel free to correct me. If
so we should always copy MADV_FREE pages in khugepaged regardless of
whether it is redirtied or not otherwise it may incur data corruption.
If we don't copy, then the follow up redirty after collapse to the
hugepage may return "00001234", right?

The current behavior is copying the page.

>
> Thanks,
> Lance
>
> On Fri, Feb 2, 2024 at 10:42=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Fri 02-02-24 21:46:45, Lance Yang wrote:
> > > Here is a part from the man page explaining
> > > the MADV_FREE semantics:
> > >
> > > The kernel can thus free thesepages, but the
> > > freeing could be delayed until memory pressure
> > > occurs. For each of the pages that has been
> > > marked to be freed but has not yet been freed,
> > > the free operation will be canceled if the caller
> > > writes into the page. If there is no subsequent
> > > write, the kernel can free the pages at any time.
> > >
> > > IIUC, if there is no subsequent write, lazyfree
> > > pages will eventually be reclaimed.
> >
> > If there is no memory pressure then this might not
> > ever happen. User cannot make any assumption about
> > their content once madvise call has been done. The
> > content has to be considered lost. Sure the userspace
> > might have means to tell those pages from zero pages
> > and recheck after the write but that is about it.
> >
> > > khugepaged
> > > treats lazyfree pages the same as pte_none,
> > > avoiding copying them to the new huge page
> > > during collapse. It seems that lazyfree pages
> > > are reclaimed before khugepaged collapses them.
> > > This aligns with user expectations.
> > >
> > > However, IMO, if the content of MADV_FREE pages
> > > remains valid during collapse, then khugepaged
> > > treating lazyfree pages the same as pte_none
> > > might not be suitable.
> >
> > Why?
> >
> > Unless I am missing something (which is possible of
> > course) I do not really see why dropping the content
> > of those pages and replacing them with a THP is any
> > difference from reclaiming those pages and then faulting
> > in a non-THP zero page.
> >
> > Now, if khugepaged reused the original content of MADV_FREE
> > pages that would be a slightly different story. I can
> > see why users would expect zero pages to back madvised
> > area.
> > --
> > Michal Hocko
> > SUSE Labs

