Return-Path: <linux-kernel+bounces-105336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23687DC65
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD761F21351
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8FCA78;
	Sun, 17 Mar 2024 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7tPvb2V"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF379E5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710655920; cv=none; b=hpjtL1gDd12bCgCE1/P6EgIj9BChboC+khRxWvs4ThZGHghEgrHeqF8oAje3SfFbP2gT/Daws5SpsQ5ue3rPahtojeMAJ7Qezlsx2MhkJG0BZYqgGk6rpyX+Z9l+kNXdPXQtApZyFfci1SN15d6UW+1ZrT+PS9h9AMno5BQxH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710655920; c=relaxed/simple;
	bh=30JULQR39HU+nq0AOxul9JdGEQl1Q8EmdL8KrvOOBdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7gZyniXLWxU+BOW9q2KXUcwMbekL5MEYJ+poUn4ENh9bk1IMg4OvKuop95S35WknbduHqtnmnso1cfCnp/e8btYtmRMvv5pMU79mfAa0XJyd7ALFuWKXYdhadWLcaQtqVcf7gS0Tj8f4kL2vLWdcoOtkLQHzpT1OGusWDhGIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7tPvb2V; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7de17974a6fso1276536241.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710655917; x=1711260717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaXRziAAjTeilxT57/ezUTVz0HxnKuoeL6SxjwNi6/A=;
        b=j7tPvb2VZFnz7DDTj8FZZEte/J0/gZQtN4I6Jrd0Bmhn6ZZcpgq24b3zVbgG8q/IbY
         GEY4MUEEJoeGiBaEtXvJChL07vJhiHCRGrrEca/ezljEnHI/CxbdSop6DeilJTZnmg1P
         ygypPISnfxaLnHKDt6+5StfsPE34P7QXIZ6aI2tRAOy7pkKur5SriG4NRYCjWdqSm5HG
         tD9rR9+JmQboSjGShz1jCLhfC7YNGqCUpvR5VzLlfCIWJaM2bS/cmrsOQV8vDj2h0kOD
         NuDP6v5BzUQRwrlYpHXDjmev8aYueenHjbsVPRo8OdRTm1Tgqnb7QlZJGNICK7FqucTJ
         0Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710655917; x=1711260717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaXRziAAjTeilxT57/ezUTVz0HxnKuoeL6SxjwNi6/A=;
        b=hLN4uGKgYMhXB4p1rKcLwqgDmJuAwNrrJbAo03WsPYTBDTmMG7u5ptFcGmaH/hA8Tx
         zkAuF5bE9qgdkfhk3ticv5IFz1CqFNsbbWNqsqpFUxEEZHdt8de1b396C74xyzUod/u0
         pzH5f9yPvtiCJbC6GmEgr8wogipssp+qXmqt1n0LPXOKQIUpU2aePeK9Kz3xAuvChR0B
         Dk2UzOPtkAhFWQXHY4kh6cqsk3wsMPFw6To0ZONQzfmE7MzDB0nfupzu/603fbp1OIOa
         jgahF7Tg4LAiHUWFeLghHjpYPpu1hT/Nj2dL2f9/7F4JEH5J3ov+Qq8yN9K4f06cYAz8
         FsZA==
X-Forwarded-Encrypted: i=1; AJvYcCX8hvIMvsK2T7Gf6fwSTfPSUjw2u3MLJZhSyVMvFjVBsfIRNjhj5JjRrZJTbLAsaBj8I62kFSotX7rJDB1CFUvx0DSyY4W0B6G4OLm3
X-Gm-Message-State: AOJu0Yz0RoPZs7n/23AVpk4YbK5MIJvZpL+4t1QVz1GfdGLQ6jOYF38e
	JKrBv6r35jHpRXZNWO2HI7qmTl3uT5DfITi+PwX6lw32o5MCKHlggML1CdROlUn9KyXL8dXKHUl
	rxO2rri7QbtcxMf3bWmeAo9zd5ck=
X-Google-Smtp-Source: AGHT+IEylcYSoIR/ruNDqXb8pnruvgXX/ghkBZ9HJd5X81bodgdIw4FDw1hl6Q54oeNcdoEBcKnX92q8dpg3lUIst04=
X-Received: by 2002:a67:ea4a:0:b0:473:efc:eeae with SMTP id
 r10-20020a67ea4a000000b004730efceeaemr7578507vso.2.1710655917329; Sat, 16 Mar
 2024 23:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
 <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
 <4fea8887-b3a1-4b32-8484-c3eeb74cf2e0@arm.com>
In-Reply-To: <4fea8887-b3a1-4b32-8484-c3eeb74cf2e0@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 17 Mar 2024 19:11:46 +1300
Message-ID: <CAGsJ_4yiuP7Ew92ptid5Xur9kwpydHXTk6qzPQRdocfk+SW2_w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 1:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 15/03/2024 10:01, Barry Song wrote:
> > On Fri, Mar 15, 2024 at 10:17=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >>> On Fri, Mar 15, 2024 at 9:43=E2=80=AFPM Huang, Ying <ying.huang@intel=
com> wrote:
> >>>>
> >>>> Barry Song <21cnbao@gmail.com> writes:
> >>>>
> >>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>>
> >>>>> On an embedded system like Android, more than half of anon memory i=
s
> >>>>> actually in swap devices such as zRAM. For example, while an app is
> >>>>> switched to background, its most memory might be swapped-out.
> >>>>>
> >>>>> Now we have mTHP features, unfortunately, if we don't support large=
 folios
> >>>>> swap-in, once those large folios are swapped-out, we immediately lo=
se the
> >>>>> performance gain we can get through large folios and hardware optim=
ization
> >>>>> such as CONT-PTE.
> >>>>>
> >>>>> This patch brings up mTHP swap-in support. Right now, we limit mTHP=
 swap-in
> >>>>> to those contiguous swaps which were likely swapped out from mTHP a=
s a
> >>>>> whole.
> >>>>>
> >>>>> Meanwhile, the current implementation only covers the SWAP_SYCHRONO=
US
> >>>>> case. It doesn't support swapin_readahead as large folios yet since=
 this
> >>>>> kind of shared memory is much less than memory mapped by single pro=
cess.
> >>>>
> >>>> In contrast, I still think that it's better to start with normal swa=
p-in
> >>>> path, then expand to SWAP_SYCHRONOUS case.
> >>>
> >>> I'd rather try the reverse direction as non-sync anon memory is only =
around
> >>> 3% in a phone as my observation.
> >>
> >> Phone is not the only platform that Linux is running on.
> >
> > I suppose it's generally true that forked shared anonymous pages only
> > constitute a
> > small portion of all anonymous pages. The majority of anonymous pages a=
re within
> > a single process.
> >
> > I agree phones are not the only platform. But Rome wasn't built in a
> > day. I can only get
> > started on a hardware which I can easily reach and have enough hardware=
/test
> > resources on it. So we may take the first step which can be applied on
> > a real product
> > and improve its performance, and step by step, we broaden it and make i=
t
> > widely useful to various areas  in which I can't reach :-)
> >
> > so probably we can have a sysfs "enable" entry with default "n" or
> > have a maximum
> > swap-in order as Ryan's suggestion [1] at the beginning,
>
> I wasn't neccessarily suggesting that we should hard-code an upper limit.=
 I was
> just pointing out that we likely need some policy somewhere because the r=
ight
> thing very likely depends on the folio size and workload. And there is li=
kely
> similar policy needed for CoW.
>
> We already have per-thp-size directories in sysfs, so there is a natural =
place
> to add new controls as you suggest - that would fit well. Of course if we=
 can
> avoid exposing yet more controls that would be preferable.
>
> >
> > "
> > So in the common case, swap-in will pull in the same size of folio as w=
as
> > swapped-out. Is that definitely the right policy for all folio sizes? C=
ertainly
> > it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm =
not sure
> > it makes sense for 2M THP; As the size increases the chances of actuall=
y needing
> > all of the folio reduces so chances are we are wasting IO. There are si=
milar
> > arguments for CoW, where we currently copy 1 page per fault - it probab=
ly makes
> > sense to copy the whole folio up to a certain size.
> > "

right now we have an "enable" entry in each size, for example:
/sys/kernel/mm/transparent_hugepage/hugepages-64kB/enable

for the phone case, it would be quite simple, just enable 64KiB(or +16KiB) =
and
allow swap-in 64KiB(or +16KiB) folios, so it doesn't need any new controls
since do_swap_page does the same checks as do_anonymous_page()
does. And we actually have deployed 64KiB-only swap-out and swap-in on
millions of real phones.

Considering other users scenarios which might want larger folios such as 2M=
iB
1MiB but only want smaller swap-in folio sizes, I could have a new
swapin control
like,

/sys/kernel/mm/transparent_hugepage/hugepages-64kB/swapin
this can be 1 or 0.

With this, it seems safer for the patchset to land while I don't have
the ability
to extensively test it on Linux servers?

Thanks
Barry

