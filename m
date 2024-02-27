Return-Path: <linux-kernel+bounces-82897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88768868B79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6EE1F2672E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A71332AA;
	Tue, 27 Feb 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsr1QdkS"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73F1332A9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024477; cv=none; b=cIXkE/C1PH2K4c3eeXvIlpaa4lDkywAlLgIuNh82av+d7W30h/o9BE2+hP0N+C2IDIgcRGOvkHvlI3g88y3vVRrG13/s7jfxMZbd9/wSpUVAviyC+da8TCiaIwdPAoazSPRu48HwwbDnLy7rNxT0i0qvk78+n99mIeRBQI75WB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024477; c=relaxed/simple;
	bh=BQjU8Pt6AaoHasAlwE5cWUZpRzUwNx6uJ/z8Y4KYoMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkSATGw0ehr+ysXbvRUti/oVY5k+wVJu7xdk09PJNs3Fx15ZAF6KbNOb36vpyTD35ln/5e+0VguYUR734jPxbKUjX9s0t0JDZIz1ZObsh1fjXfsuUS43vXt3ckuwzqJPEF9c09tES/cGizNB05UYVS5l38gTbVlAox7X8s1pcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsr1QdkS; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4cea831ed57so558866e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709024474; x=1709629274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARRv7DKczsRBULZCd7d/KnPVVsV6nxwE5Rkg1kQ1jGo=;
        b=Bsr1QdkSiw9VmO1x+shtepQbgUzaoUMlzOa2Vu1euS/KAv7KFc44sD1HyQ4MkdwdUI
         07EUO1IhxmkAmSP2UC+uy4gJcQxDSyMgthefKIZ110bA+XKWbmKRDj8wTYBfs8XGKXbT
         LQzNGIPFJ8aKrOL6MqEDbmxhJHjiqGBgiOWpmCnKfXzJQs9PSkQGCnK6ZyI7aEEGsshL
         G76hDfMtjqaNGeGy1iMEl2dRIZzR3CGBqJYflqDNI6EcN0OWVKbJ6PfSBqqILf/0bG9v
         eNISJXDSN2yLHYXwYyK1w48prN82Sfj7Ipl1hoIuIyJ9YVawfgNdaomnyXwwT06LajRw
         0jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024474; x=1709629274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARRv7DKczsRBULZCd7d/KnPVVsV6nxwE5Rkg1kQ1jGo=;
        b=Ub22oSpYsSmSZMOvz/5r8kRYFWVzVqnwkg9m9kTzgda9nil9/ivmeGkMfH+2/aSRAk
         T229LP0hhhBh9SLQtTAfL/sjzMElZBySSFLgPqL4kj71XqRbMdV0JFnSVMNnutNeeby3
         +AxYIgHjlYDc3wrVNjqiJ1cWwiKF0nfJ0DxxBWtsvfLtpIDqVq2n5I3gg33RSvSYrEux
         2t+TOEtxdgSlxQdu/JmhwY9c+78kuaCCUR/t0gATXUgdmd970taBUCncllkBSxRPpx3U
         SAeBaAO4fD/cDdjAz5HsV/QTjFDs4LD6cMiiNo2l5OvLbyMk4Eedns/QzokeV2Sf1Mo+
         V7jg==
X-Forwarded-Encrypted: i=1; AJvYcCXvNptsQmqykAG777MTx9mOMO46Jqh32AO47AeduAbxwcLKkSxH9HVVN7H7pPuCZf+++KQPHAL7L0E1SYoHeOFUeEhHhNLQSUN0K4Qn
X-Gm-Message-State: AOJu0YzDSmUufMO/jFZof9U0TEXe2h/2gxxkjGOGlN07xF3J25ZfbH9k
	K2ZDZYxP6NmesSNYmuR1tLjItc7aLN9Z+tCLyruYNfVo9SR6o7A1pcg7+ppjOzF3b3eq93GI8/n
	LcmdkW1GxOLUoLtgsBNYfK7JxBPc=
X-Google-Smtp-Source: AGHT+IFiczogLx2L9hqVWzCOLaqmtJ2nvkSY6KB3rPJEr4+ctRthL+H5XO/Tn3v44rl5XwnJhzxaNoOnz4zyb9P+9UA=
X-Received: by 2002:a1f:e704:0:b0:4d1:34a1:c887 with SMTP id
 e4-20020a1fe704000000b004d134a1c887mr6707680vkh.9.1709024472515; Tue, 27 Feb
 2024 01:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com> <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com> <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com> <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com> <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
 <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com> <CAGsJ_4x6Otb9LUvnxAaPLnQ2MPPng0xpG-vJmFL7pNm10FDhZA@mail.gmail.com>
 <CAGsJ_4xndYM8=7v+EV_aWX+_qgA1UPmm38n+ujbQXJLzCPKfog@mail.gmail.com>
 <009e5633-decb-4c21-b5fc-58984fbade96@intel.com> <CAGsJ_4yftgfD7MsNd5iej8_wTrYeTsAFfW7xmqrj-Q_w8-oqMg@mail.gmail.com>
 <05f2d04c-333d-4298-8c7a-d5adeac5df82@intel.com>
In-Reply-To: <05f2d04c-333d-4298-8c7a-d5adeac5df82@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 22:01:00 +1300
Message-ID: <CAGsJ_4yqk6eU+rpym61TnSN_5c5=K+u1FPa5JP92WKxzfrkkcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:33=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 2/27/24 15:54, Barry Song wrote:
> > On Tue, Feb 27, 2024 at 8:42=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >>
> >>
> >> On 2/27/24 15:21, Barry Song wrote:
> >>> On Tue, Feb 27, 2024 at 8:11=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> >>>>
> >>>> On Tue, Feb 27, 2024 at 8:02=E2=80=AFPM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2/27/24 14:40, Barry Song wrote:
> >>>>>> On Tue, Feb 27, 2024 at 7:14=E2=80=AFPM Yin Fengwei <fengwei.yin@i=
ntel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2/27/24 10:17, Barry Song wrote:
> >>>>>>>>> Like if we hit folio which is partially mapped to the range, do=
n't split it but
> >>>>>>>>> just unmap the mapping part from the range. Let page reclaim de=
cide whether
> >>>>>>>>> split the large folio or not (If it's not mapped to any other r=
ange,it will be
> >>>>>>>>> freed as whole large folio. If part of it still mapped to other=
 range,page reclaim
> >>>>>>>>> can decide whether to split it or ignore it for current reclaim=
 cycle).
> >>>>>>>> Yes, we can. but we still have to play the ptes check game to av=
oid adding
> >>>>>>>> folios multiple times to reclaim the list.
> >>>>>>>>
> >>>>>>>> I don't see too much difference between splitting in madvise and=
 splitting
> >>>>>>>> in vmscan.  as our real purpose is avoiding splitting entirely m=
apped
> >>>>>>>> large folios. for partial mapped large folios, if we split in ma=
dvise, then
> >>>>>>>> we don't need to play the game of skipping folios while iteratin=
g PTEs.
> >>>>>>>> if we don't split in madvise, we have to make sure the large fol=
io is only
> >>>>>>>> added in reclaimed list one time by checking if PTEs belong to t=
he
> >>>>>>>> previous added folio.
> >>>>>>>
> >>>>>>> If the partial mapped large folio is unmapped from the range, the=
 related PTE
> >>>>>>> become none. How could the folio be added to reclaimed list multi=
ple times?
> >>>>>>
> >>>>>> in case we have 16 PTEs in a large folio.
> >>>>>> PTE0 present
> >>>>>> PTE1 present
> >>>>>> PTE2 present
> >>>>>> PTE3  none
> >>>>>> PTE4 present
> >>>>>> PTE5 none
> >>>>>> PTE6 present
> >>>>>> ....
> >>>>>> the current code is scanning PTE one by one.
> >>>>>> while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE=
4, PTE6...
> >>>>> No. Before detect the folio is fully mapped to the range, we can't =
add folio
> >>>>> to reclaim list because the partial mapped folio shouldn't be added=
 We can
> >>>>> only scan PTE15 and know it's fully mapped.
> >>>>
> >>>> you never know PTE15 is the last one mapping to the large folio, PTE=
15 can
> >>>> be mapping to a completely different folio with PTE0.
> >>>>
> >>>>>
> >>>>> So, when scanning PTE0, we will not add folio. Then when hit PTE3, =
we know
> >>>>> this is a partial mapped large folio. We will unmap it. Then all 16=
 PTEs
> >>>>> become none.
> >>>>
> >>>> I don't understand why all 16PTEs become none as we set PTEs to none=
.
> >>>> we set PTEs to swap entries till try_to_unmap_one called by vmscan.
> >>>>
> >>>>>
> >>>>> If the large folio is fully mapped, the folio will be added to recl=
aim list
> >>>>> after scan PTE15 and know it's fully mapped.
> >>>>
> >>>> our approach is calling pte_batch_pte while meeting the first pte, i=
f
> >>>> pte_batch_pte =3D 16,
> >>>> then we add this folio to reclaim_list and skip the left 15 PTEs.
> >>>
> >>> Let's compare two different implementation, for partial mapped large =
folio
> >>> with 8 PTEs as below,
> >>>
> >>> PTE0 present for large folio1
> >>> PTE1 present for large folio1
> >>> PTE2 present for another folio2
> >>> PTE3 present for another folio3
> >>> PTE4 present for large folio1
> >>> PTE5 present for large folio1
> >>> PTE6 present for another folio4
> >>> PTE7 present for another folio5
> >>>
> >>> If we don't split in madvise(depend on vmscan to split after adding
> >>> folio1), we will have
> >> Let me clarify something here:
> >>
> >> I prefer that we don't split large folio here. Instead, we unmap the
> >> large folio from this VMA range (I think you missed the unmap operatio=
n
> >> I mentioned).
> >
> > I don't understand why we unmap as this is a MADV_PAGEOUT not
> > an unmap. unmapping totally changes the semantics. Would you like
> > to show pseudo code?
> Oh. Yes. MADV_PAGEOUT is not suitable.
>
> What about MADV_FREE?

we can't unmap either. as MADV_FREE applies to anon vma.  while a
folio is marked lazyfree, we move anon folio to file LRU. if somebody
writes the folio afterwards, we take the folio back; if nobody writes it
before vmscan gets it in the file LRU, we can reclaim it by setting PTEs
to none. we can't immediately unmap a large folio at the time
MADV_FREE is called.  immediate unmap is the behavior of MADV_DONTNEED
but not MADV_FREE.

>
> >
> > for MADV_PAGEOUT on swap-out, the last step is writing swap entries
> > to replace PTEs which are present. I don't understand how an unmap
> > can be involved in this process.
> >
> >>
> >> The intention is trying best to avoid splitting the large folio. If
> >> the folio is only partially mapped to this VMA range, it's likely it
> >> will be reclaimed as whole large folio. Which brings benefit for lru
> >> and zone lock contention comparing to splitting large folio.
> >
> > which also brings negative side effects such as redundant I/O.
> > For example, if you have only one subpage left in a large folio,
> > pageout will still write nr_pages subpages into swap, then immediately
> > free them in swap.
> >
> >>
> >> The thing I am not sure is unmapping from specific VMA range is not
> >> available and whether it's worthy to add it.
> >
> > I think we might have the possibility to have some complex code to
> > add folio1, folio2, folio3, folio4 and folio5 in the above example into
> > reclaim_list while avoiding splitting folio1. but i really don't unders=
tand
> > how unmap will work.
> >
> >>
> >>> to make sure folio1, folio2, folio3, folio4, folio5 are added to
> >>> reclaim_list by doing a complex
> >>> game while scanning these 8 PTEs.
> >>>
> >>> if we split in madvise, they become:
> >>>
> >>> PTE0 present for large folioA  - splitted from folio 1
> >>> PTE1 present for large folioB - splitted from folio 1
> >>> PTE2 present for another folio2
> >>> PTE3 present for another folio3
> >>> PTE4 present for large folioC - splitted from folio 1
> >>> PTE5 present for large folioD - splitted from folio 1
> >>> PTE6 present for another folio4
> >>> PTE7 present for another folio5
> >>>
> >>> we simply add the above 8 folios into reclaim_list one by one.
> >>>
> >>> I would vote for splitting for partial mapped large folio in madvise.
> >>>
> >

Thanks
Barry

