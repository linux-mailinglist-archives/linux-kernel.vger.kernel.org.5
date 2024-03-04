Return-Path: <linux-kernel+bounces-91248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7FA870BB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5791F22B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1FDDBB;
	Mon,  4 Mar 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbgofL12"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB679DD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584995; cv=none; b=FS9Z+ik+SL22I2d1Ss2aG2rUfBq4CfVutDoaPVZo8ZPnUQshzIT+ESMqeWva2JLp4tQNVcEnv8EPDtqUXmU+jENBIybnebhpKUrsL97P2Y3SiVafsHKpRZ6iAiJVVZW/PG8xmMXqT16GoyHEZmaNErchYOVUfGTD5n/tPM2zo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584995; c=relaxed/simple;
	bh=Z1LgDgX5Y416n1LzNajXIdabLE3wCI+9ZIIldaxVr/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QylzX/FaJJ4GREdqRNGmVGaOuB/fsjv9eeeVaqbbXingUmSdkyv6ANkM+eDoPsmFabZPVGTEldAZAiSZmrJh4fNtHpMV7oc+HKwuTCJ5lVSEu5FmeMMnftQscC659tKUNLm6Q8u72b29nVuNEb0pKskJ2X89v/5H9S8dnP8qJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbgofL12; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7db44846716so440636241.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584992; x=1710189792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1LgDgX5Y416n1LzNajXIdabLE3wCI+9ZIIldaxVr/8=;
        b=kbgofL12/CiN0mVvpihYCzsQLN+6EwGpfEYQ7IOVzHTUPhG2v8wtyC/tKyWztVgE0Z
         w/k0jelPYhA0PWcw9Y+B6OD7hX+yq8oG0TZ3kfcMKIGmewH8YaR+wee+BYCTa5UI/ByK
         82drQDAKQ0nFihQJHAqVa9c2Jx+R61uCCO/Pi/upmnmDjFccvCcXN0+EZaufnReNALf2
         UN3XSANmcxG7x38tiLc90w9MpuTW6Ud1gq0fFLPhe6/7dHIxQm0+uzLNWUn6xlWfNjjV
         7qnCcpQ/u8L56T51DEbUww9XWHyicv+eaqyJqWG+bk/zAHgY3xDqWmomsX9GU/it0DR7
         uOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584992; x=1710189792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1LgDgX5Y416n1LzNajXIdabLE3wCI+9ZIIldaxVr/8=;
        b=WeavD6wABk2/c+6K7xTdSArxGLQsBHnf4dI6MZLT7bO8XFGwHAsZRYXQKMOd8VDRVq
         xIZ27KDm5EmCLomt+VnAWEyRdP5QwNgqIltyM2QaCqkU8d/3arZQWLQEejTCQvKBlTrt
         onO3ZsZzxjR2ybFIuOqNAb/eq9n63jWYrEtF5q9KODE/TMCwp3VE+yNJ42wXO669xXbJ
         liYuDG/+K99OOqTguLSod7Re3WtgH1qecmZW33oENqe3huDY9wEWtc/j08zWSt29FDKn
         DVAp6Xq7iexbeCeXPdqx+KokJajhUsqNXa8C9vy26cVdwN9GkhEU/YyOudefXEQ2z8W4
         /S0w==
X-Forwarded-Encrypted: i=1; AJvYcCVeKyAAYbN5Ok0RLGqFJKqmdy6Ycsofv7IrgaK9myPYK52p+6Oop6ECJ5ze7qX3d2bhO4v1NUAsvujW83KIpF4YgBDkX/Ld3qnQDWGY
X-Gm-Message-State: AOJu0YxVHWxZzzPSB4JxY41JY9WLwOL+m1IcbFkx7HYad+SNWZQSb/d5
	esLXE3TZGckrHUlNcEf8ORizOOtkhcPol3cSM5gncpfAt0aXEhsDWAFja7DpwVeHcl3WP0F8iix
	BEBTYEAdz3Ls4YUZoP1BGRF0odaQ=
X-Google-Smtp-Source: AGHT+IHlRZXM1Ngzq33fC2WvirQblSfXQwjIju8YdhpzzX/4QbzTtngdSvFNfFqaF1b6QaUO70Q/NTL7KkYIqGC6Fu8=
X-Received: by 2002:a05:6102:18c3:b0:470:6fe6:5a08 with SMTP id
 jj3-20020a05610218c300b004706fe65a08mr7087738vsb.34.1709584992126; Mon, 04
 Mar 2024 12:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> <10f9542e-f3d8-42b0-9de4-9867cab997b9@arm.com>
 <17b4527c-3782-4eab-8b33-e0c6ff57139f@redhat.com>
In-Reply-To: <17b4527c-3782-4eab-8b33-e0c6ff57139f@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 09:42:59 +1300
Message-ID: <CAGsJ_4wgMtY2=xRFSx8xAgROR97MevAtCYRUG+Xy+n6FUw9a1w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 3:27=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.03.24 14:03, Ryan Roberts wrote:
> > On 04/03/2024 12:41, David Hildenbrand wrote:
> >> On 04.03.24 13:20, Ryan Roberts wrote:
> >>> Hi Barry,
> >>>
> >>> On 04/03/2024 10:37, Barry Song wrote:
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
> >>>> PTEs modification such as break-before-make, while iterating PTEs
> >>>> of a large folio, it will only begin to acquire PTL after it gets
> >>>> a valid(present) PTE. break-before-make intermediately sets PTEs
> >>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
> >>>> in try_to_unmap_one().
> >>>
> >>> I just want to check my understanding here - I think the problem occu=
rs for
> >>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large f=
olios? Now
> >>> that I've had a look at the code and have a better understanding, I t=
hink that
> >>> must be the case? And therefore this problem exists independently of =
my work to
> >>> support swap-out of mTHP? (From your previous report I was under the =
impression
> >>> that it only affected mTHP).
> >>>
> >>> Its just that the problem is becoming more pronounced because with mT=
HP,
> >>> PTE-mapped large folios are much more common?
> >>
> >> That is my understanding.
> >>
> >>>
> >>>> For example, for an anon folio, after try_to_unmap_one(), we may
> >>>> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
> >>>> So folio will be still mapped, the folio fails to be reclaimed.
> >>>> What=E2=80=99s even more worrying is, its PTEs are no longer in a un=
ified
> >>>> state. This might lead to accident folio_split() afterwards. And
> >>>> since a part of PTEs are now swap entries, accessing them will
> >>>> incur page fault - do_swap_page.
> >>>> It creates both anxiety and more expense. While we can't avoid
> >>>> userspace's unmap to break up unified PTEs such as CONT-PTE for
> >>>> a large folio, we can indeed keep away from kernel's breaking up
> >>>> them due to its code design.
> >>>> This patch is holding PTL from PTE0, thus, the folio will either
> >>>> be entirely reclaimed or entirely kept. On the other hand, this
> >>>> approach doesn't increase PTL contention. Even w/o the patch,
> >>>> page_vma_mapped_walk() will always get PTL after it sometimes
> >>>> skips one or two PTEs because intermediate break-before-makes
> >>>> are short, according to test. Of course, even w/o this patch,
> >>>> the vast majority of try_to_unmap_one still can get PTL from
> >>>> PTE0. This patch makes the number 100%.
> >>>> The other option is that we can give up in try_to_unmap_one
> >>>> once we find PTE0 is not the first entry we get PTL, we call
> >>>> page_vma_mapped_walk_done() to end the iteration at this case.
> >>>> This will keep the unified PTEs while the folio isn't reclaimed.
> >>>> The result is quite similar with small folios with one PTE -
> >>>> either entirely reclaimed or entirely kept.
> >>>> Reclaiming large folios by holding PTL from PTE0 seems a better
> >>>> option comparing to giving up after detecting PTL begins from
> >>>> non-PTE0.
> >>>>
> >>
> >> I'm sure that wall of text can be formatted in a better way :) . Also,=
 I think
> >> we can drop some of the details,
> >>
> >> If you need some inspiration, I can give it a shot.
> >>
> >>>> Cc: Hugh Dickins <hughd@google.com>
> >>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> Do we need a Fixes tag?
> >>>
> >>
> >> What would be the description of the problem we are fixing?
> >>
> >> 1) failing to unmap?
> >>
> >> That can happen with small folios as well IIUC.
> >>
> >> 2) Putting the large folio on the deferred split queue?
> >>
> >> That sounds more reasonable.
> >
> > Isn't the real problem today that we can end up writng a THP to the swa=
p file
> > (so 2M more IO and space used) but we can't remove it from memory, so n=
o actual
> > reclaim happens? Although I guess your (2) is really just another way o=
f saying
> > that.
>
> The same could happen with small folios I believe? We might end up
> running into the
>
> folio_mapped()
>
> after the try_to_unmap().
>
> Note that the actual I/O does not happen during add_to_swap(), but
> during the pageout() call when we find the folio to be dirty.
>
> So there would not actually be more I/O. Only swap space would be
> reserved, that would be used later when not running into the race.

I am not worried about small folios at all as they have only one PTE.
so the PTE is either completely unmapped or completely mapped.

In terms of large folios, it is a different story. for example, a large
folio with 16 PTEs with CONT-PTE, we will have

1. unfolded CONT-PTE, eg. PTE0 present, PTE1-PTE15 swap entries

2. page faults on PTE1-PTE15 after try_to_unmap if we access them.

This is totally useless PF and can be avoided if we can try_to_unmap
properly at the beginning.

3. potential need to split a large folio afterwards. for example, MADV_PAGE=
OUT,
MADV_FREE might split it after finding it is not completely mapped.

For small folios, we don't have any concern on the above issues.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

