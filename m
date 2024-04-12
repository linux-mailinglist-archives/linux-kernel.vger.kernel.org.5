Return-Path: <linux-kernel+bounces-141779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE88A235E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFB1C21933
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67141524C;
	Fri, 12 Apr 2024 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNSCn3q5"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155D28E7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886514; cv=none; b=utL7sCeRYAox/9HzgoXQzaFbANpddByAkqvlmbzd//oOfs0/veonEOs0pEypO2hm3h0cVy8Y3RYAKCouVAINmwBsMAFXVcrfWIJ8QGlsjfgeoUo3+4P6xr2aOpg7WmcfcilZIpxYVLG3aZLxMwWdiLpnjsQC7WorURH9rRX4RzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886514; c=relaxed/simple;
	bh=U6B6yXIYDDNx7uPX0FR0AL5WZT1BKa/SKkjYgShpBeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXg7avRXhM/PJN0K65nurZS06aAPW+KQF2b0vgSpuHQZcjd0r9spj88FqYJ5pLByg1o6NjIHMqmXNnjrDIvfTJTIJNzdaiZj91hj8PWui25+1gtK7//quycLpYUfkdZ+Uj6HFawaBTAuja74JjdHIP28x1dWb7rzleNjgC6L5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNSCn3q5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so324371a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712886511; x=1713491311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGCc2xE7kNa3p/vj3nCRy1hQloRnEiDZ2zpk6AwtsY4=;
        b=WNSCn3q55hclQF2ti75zotTgDs7DYzuhNzvdrhTfRPkqv4iHi21Jm7TaqrYKdj+ehW
         ia3/ezUBBlA50CHP23rzXqKAPUB8FbcWd/CNe+El3X14fhf5rAeUA1Zc7xixAc9S4dj4
         F/XUC4P78/6BQWut7/49J6+mTYgh3uTl2ROqVzZprrOBemqLQMIcBn4K/bm+62Vm++Dv
         b1XUjdYbphbE5ucT5YXeDE89EcEhj7K9gPFQ1/Ai///hruxeTV2vm33/VZ51sbPt+Bin
         0rcMJ47nsBaPvzNdoXaNn5VF6DMaQCvDD+q4B5DdoSTzhnBPwUI550zCWTWn5A/m6YQS
         akIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886511; x=1713491311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGCc2xE7kNa3p/vj3nCRy1hQloRnEiDZ2zpk6AwtsY4=;
        b=BHn2MY/SlDPLBdSwmkJ74tATVPhw+s4uRefJvpfu7FWJcSAXlY4DOHrFiC0zM4UP5Q
         M/8JOXM7wtI7czXsytsh1OxcW7VjOGtOZTnUHAluBXv5wYDa6weeXIocn5Bycok/uqVF
         DmVpMXBKOADmOXQc3lCOqXcGniwdHhPeAz254XGtMRSe2mcOYh1OuesoNj6M6UXrrvsf
         G++8uoplcDRLP2hv8gfcJMMXCXTyGnf0KiVFGNe2Rf79b+oS9nQ0AUMhHN7955o1TkCR
         /NeMOr7ueYaE/s5rU3OwWFjZ7JNiPIc4awANPjR0NnwbxbiKb6ihI4lSCBb+WEOhPaa1
         1lyA==
X-Forwarded-Encrypted: i=1; AJvYcCUMhbMCeqjQZhoTUU9neHUBvCUIZ6N0leUbe1p2TYho9zHy8FCzr4o36z4WWMbPedvzRdJbr7E7hJUiDpyEhMqLReC2fLJYyQ7rjVFs
X-Gm-Message-State: AOJu0YwGzCf2oiJs4yzr9NNG2Wh95DfgMU+GO7Q8nRpspV9VSUowChrz
	g6SCZjfMIOPuJfgmpV4YZn9GL1DWrvauwA9QcN9KPgFLL20TS1p8eKrXvPoL3h4lAilSrVhYjDZ
	iBMKUAGWjxJIuSJO+YxTsHxI7OfA=
X-Google-Smtp-Source: AGHT+IEkT0SlHP+XvdDvomqIEYCJ0NkqUuIeE4LOBoI0dZ2bGFUm17BCitiNyd+8IXaiol4X/fjni5n49yo6n4y0Ubs=
X-Received: by 2002:a50:a411:0:b0:56f:e75b:83aa with SMTP id
 u17-20020a50a411000000b0056fe75b83aamr918869edb.6.1712886511248; Thu, 11 Apr
 2024 18:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408042437.10951-1-ioworker0@gmail.com> <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com> <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
 <3cda8e87-7095-4aad-beb1-6a420912df34@arm.com> <CAK1f24k6mhQZwws7fjvL0ynme4FtjqBM3T6ZYuFPytH0fG=v6w@mail.gmail.com>
 <8d674b15-ef74-4d96-bc27-8794f744517c@arm.com>
In-Reply-To: <8d674b15-ef74-4d96-bc27-8794f744517c@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 12 Apr 2024 09:48:19 +0800
Message-ID: <CAK1f24=iMEcD43AVv7Xbhviv_K=3CBAidTwT3bOTRMW8yhKt4w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:39=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 11/04/2024 15:07, Lance Yang wrote:
> > On Thu, Apr 11, 2024 at 9:48=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> [...]
> >>
> >>>>> +
> >>>>> +             if (!folio_trylock(folio))
> >>>>> +                     continue;
> >>>>
> >>>> This is still wrong. This should all be protected by the "if
> >>>> (folio_test_swapcache(folio) || folio_test_dirty(folio))" as it was =
previously
> >>>> so that you only call folio_trylock() if that condition is true. You=
 are
> >>>> unconditionally locking here, then unlocking, then relocking below i=
f the
> >>>> condition is met. Just put everything inside the condition and lock =
once.
> >>>
> >>> I'm not sure if it's safe to call folio_mapcount() without holding th=
e
> >>> folio lock.
> >>>
> >>> As mentioned earlier by David in the v2[1]
> >>>> What could work for large folios is making sure that #ptes that map =
the
> >>>> folio here correspond to the folio_mapcount(). And folio_mapcount()
> >>>> should be called under folio lock, to avoid racing with swapout/migr=
ation.
> >>>
> >>> [1] https://lore.kernel.org/all/5cc05529-eb80-410e-bc26-233b0ba0b21f@=
redhat.com/
> >>
> >> But I'm not suggesting that you should call folio_mapcount() without t=
he lock.
> >> I'm proposing this:
> >>
> >>                 if (folio_test_swapcache(folio) || folio_test_dirty(fo=
lio)) {
> >>                         if (!folio_trylock(folio))
> >>                                 continue;
> >>                         /*
> >> -                        * If folio is shared with others, we mustn't =
clear
> >> -                        * the folio's dirty flag.
> >> +                        * If we have a large folio at this point, we =
know it is
> >> +                        * fully mapped so if its mapcount is the same=
 as its
> >> +                        * number of pages, it must be exclusive.
> >>                          */
> >> -                       if (folio_mapcount(folio) !=3D 1) {
> >> +                       if (folio_mapcount(folio) !=3D folio_nr_pages(=
folio)) {
> >>                                 folio_unlock(folio);
> >>                                 continue;
> >>                         }
> >
> > IIUC, if the folio is clean and not in the swapcache, we still need to
> > compare the number of batched PTEs against folio_mapcount().
>
> Why? That's not how the old code worked. In fact the comment says that th=
e
> reason for the exclusive check is to avoid marking a dirty *folio* as cle=
an if
> shared; that would be bad because we could throw away data that others re=
lied
> upon. It's perfectly safe to clear the dirty flag from the *pte* even if =
it is
> shared; the ptes are private to the process so that won't affect sharers.
>
> You should just follow the pattern already estabilished by the original c=
ode.
> The only difference is that because the folio is now (potentially) large,=
 you
> have to change the way to detect exclusivity.

Thanks a lot for your patience and help!

My bad for the oversight and mistake :(
I'll take another look at the original code and make adjustments following =
the
established pattern.

Thanks,
Lance

>
> >
> > Thanks,
> > Lance
> >
> >>
> >> What am I missing?
> >>
>

