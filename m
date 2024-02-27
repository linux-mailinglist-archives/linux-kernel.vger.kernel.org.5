Return-Path: <linux-kernel+bounces-82794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 462708689C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB84A1F24003
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0D54BD4;
	Tue, 27 Feb 2024 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T34E6l53"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3954773
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018521; cv=none; b=i++zdWCLjAnTRmjUJMwx6/tTOgSqnqqleGiBEuRE2AupAWGCl9jYcH6c7JU6hmJbtbmzHbGcujiKaKJXTmiu6764W4sxXT+ZVhHLYZPvcrWnMsDZfs+nIZuZGtkOnVZswJgAeVhou6cLGwIL1b3OVXis1FzKg0itFBUdmiP9d4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018521; c=relaxed/simple;
	bh=e1H8mt0Gzj93IXnLyehY6/Cc5QY9MW3tV55keO0JG8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeDTuhQj+Ez9ccwdAuRgQKt5wHMSMAyIKMyDK3DDv4ElAAKnTViRKrM+afWFQ9t7MaLetTs9DYo4hm3mCuZVssVcEdcOLKwQ1mmZD29AeNYNsZ951allasK54yvYh7xdUqnms2tUsEm12472D3/8ckHkRoUH4kkBS4pHChopNqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T34E6l53; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4caabc3f941so1964023e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709018519; x=1709623319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEUnAGmSQMSq0UVn7yWFVkUhbK0HgR42Qs6BR08T3ek=;
        b=T34E6l53g1Pnv12MMMxYgjnugP1Mor9Q8q5j0X/zqpP3BxFRsOzMwc5We2+2ynRvqb
         Uo3Hoq3enlbrMMlehmrcTE3Eu8U6rFuKuV4NPxwxqW9kazheJKKGE9LRgjDnyUh3wwTf
         Dn3ICRndaexgRUzHLScR7NnxYcyyFvSaeKK4bLgSxERyXzXcbL08CvrJDFxYaBjeYs8L
         7kZh3nBBEDbkR6e6OTm6TpopwT0H2V6fvUsjZ5sEGTKc0EKNEobE6VhLpScbGy+PJCQJ
         PjwgHqCk6SqF0k5x3jSViunj06CHfbkaFapY+1mDfdnhiWRKMxjwnQyh+80wWItG3KGY
         jipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018519; x=1709623319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEUnAGmSQMSq0UVn7yWFVkUhbK0HgR42Qs6BR08T3ek=;
        b=oB1woiqG36cfNei/Ob7bVZwOu5wKaTZvhOdQAcXuWKuJTRwmgEe3jt52KxojMrUiFW
         J9bSymCH7dwKMdEKOf8HGgmy/gWp9A7wNvKFsG8zpCMQh8+xOcaDBTBXzLPMHjQj556F
         qRgOtGRP6V29IFqz/1pf/z8ZkMcoPPweysHddSrB5hJJvntw3mAvMQ8kfNm9SKf7XYUn
         NjxXI2/rZQ2yGtlOE0G3IeybcM2y7FF99/S0LSvp5lY2zr1ixQpb2EU4P0lFB0EexXaI
         fBkXYXswn18F7Vax20jcoU/oNR8JOKTAA2s2c3gew5e+AZGFKNCDHhqcFczd69FvhQEz
         UfrA==
X-Forwarded-Encrypted: i=1; AJvYcCUiOUAxC1no8Zw6khpO7yDqu6x/coZl7PBvVehvWRLL48xxrNaSkcZGnw5lrh/6Q+/pQ6S21knzIGxCneod2oDLimekcGQHh01eKlv0
X-Gm-Message-State: AOJu0YyRbZMe0s44PTr39fQOssLRhf3/KF9Uvgf0qfyK6d3xVdPtIssG
	xGehs3dZ7KKDSXT9Y5MceHb7aPPEWtwtVmMZhC7Ce0My6QC5z0n7RpLdlK4HQJL3/cxeiOYkCfo
	AvMdDYHMhPqHE6GT+B87XaRoyGCw=
X-Google-Smtp-Source: AGHT+IFwXnNTIk3orhZfP4qxn3dYyruHvbP6SterPuZJvbV1zio+Eacm/yiWDPX1DUiBi39Sa5QfMAvx65iGxDukW2E=
X-Received: by 2002:a1f:dfc4:0:b0:4c8:a2c6:c2be with SMTP id
 w187-20020a1fdfc4000000b004c8a2c6c2bemr6562061vkg.8.1709018518951; Mon, 26
 Feb 2024 23:21:58 -0800 (PST)
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
In-Reply-To: <CAGsJ_4x6Otb9LUvnxAaPLnQ2MPPng0xpG-vJmFL7pNm10FDhZA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 20:21:47 +1300
Message-ID: <CAGsJ_4xndYM8=7v+EV_aWX+_qgA1UPmm38n+ujbQXJLzCPKfog@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Feb 27, 2024 at 8:02=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.co=
m> wrote:
> >
> >
> >
> > On 2/27/24 14:40, Barry Song wrote:
> > > On Tue, Feb 27, 2024 at 7:14=E2=80=AFPM Yin Fengwei <fengwei.yin@inte=
l.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2/27/24 10:17, Barry Song wrote:
> > >>>> Like if we hit folio which is partially mapped to the range, don't=
 split it but
> > >>>> just unmap the mapping part from the range. Let page reclaim decid=
e whether
> > >>>> split the large folio or not (If it's not mapped to any other rang=
e,it will be
> > >>>> freed as whole large folio. If part of it still mapped to other ra=
nge,page reclaim
> > >>>> can decide whether to split it or ignore it for current reclaim cy=
cle).
> > >>> Yes, we can. but we still have to play the ptes check game to avoid=
 adding
> > >>> folios multiple times to reclaim the list.
> > >>>
> > >>> I don't see too much difference between splitting in madvise and sp=
litting
> > >>> in vmscan.  as our real purpose is avoiding splitting entirely mapp=
ed
> > >>> large folios. for partial mapped large folios, if we split in madvi=
se, then
> > >>> we don't need to play the game of skipping folios while iterating P=
TEs.
> > >>> if we don't split in madvise, we have to make sure the large folio =
is only
> > >>> added in reclaimed list one time by checking if PTEs belong to the
> > >>> previous added folio.
> > >>
> > >> If the partial mapped large folio is unmapped from the range, the re=
lated PTE
> > >> become none. How could the folio be added to reclaimed list multiple=
 times?
> > >
> > > in case we have 16 PTEs in a large folio.
> > > PTE0 present
> > > PTE1 present
> > > PTE2 present
> > > PTE3  none
> > > PTE4 present
> > > PTE5 none
> > > PTE6 present
> > > ....
> > > the current code is scanning PTE one by one.
> > > while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, =
PTE6...
> > No. Before detect the folio is fully mapped to the range, we can't add =
folio
> > to reclaim list because the partial mapped folio shouldn't be added. We=
 can
> > only scan PTE15 and know it's fully mapped.
>
> you never know PTE15 is the last one mapping to the large folio, PTE15 ca=
n
> be mapping to a completely different folio with PTE0.
>
> >
> > So, when scanning PTE0, we will not add folio. Then when hit PTE3, we k=
now
> > this is a partial mapped large folio. We will unmap it. Then all 16 PTE=
s
> > become none.
>
> I don't understand why all 16PTEs become none as we set PTEs to none.
> we set PTEs to swap entries till try_to_unmap_one called by vmscan.
>
> >
> > If the large folio is fully mapped, the folio will be added to reclaim =
list
> > after scan PTE15 and know it's fully mapped.
>
> our approach is calling pte_batch_pte while meeting the first pte, if
> pte_batch_pte =3D 16,
> then we add this folio to reclaim_list and skip the left 15 PTEs.

Let's compare two different implementation, for partial mapped large folio
with 8 PTEs as below,

PTE0 present for large folio1
PTE1 present for large folio1
PTE2 present for another folio2
PTE3 present for another folio3
PTE4 present for large folio1
PTE5 present for large folio1
PTE6 present for another folio4
PTE7 present for another folio5

If we don't split in madvise(depend on vmscan to split after adding
folio1), we will have
to make sure folio1, folio2, folio3, folio4, folio5 are added to
reclaim_list by doing a complex
game while scanning these 8 PTEs.

if we split in madvise, they become:

PTE0 present for large folioA  - splitted from folio 1
PTE1 present for large folioB - splitted from folio 1
PTE2 present for another folio2
PTE3 present for another folio3
PTE4 present for large folioC - splitted from folio 1
PTE5 present for large folioD - splitted from folio 1
PTE6 present for another folio4
PTE7 present for another folio5

we simply add the above 8 folios into reclaim_list one by one.

I would vote for splitting for partial mapped large folio in madvise.

Thanks
Barry

