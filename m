Return-Path: <linux-kernel+bounces-27641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A543E82F38C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1895C1F24665
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9141CD0B;
	Tue, 16 Jan 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/JUfKl5"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E121CABC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427869; cv=none; b=c5nnGzv5Go34jV3hu5nPcCUjPqN0SOUX56HhVnOKnfSnpEamF+MHJlB23WG+/8RpMlCoJWWA9AB5RuiDfz5umgc5Apt155A55UkEU1qnKzuNzrkJt1N2mTzhvhCxZ055ozycn+qRovDYZZiteAoN+VemEy7XC+GHT20kWXoL4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427869; c=relaxed/simple;
	bh=yUAHuj8vVj8IUFVbFycTjbLEQJVq0uuFYF6xO/bIKQk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hSGCHr6weU0XMrJH8esCE2czmCNijSqEZa2fjTxQDseBTskWlgqpyOTMOxRTbih4RhXU3QIbYRsZkI3sucKgYysgXh8wTe86tJ+cv6+recfyThe5Bwxxsdo0c/6qGC8tZAOE4lEmKp1lCD0CU99pmDeRuZ/8NyOnf+bXrkKczaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/JUfKl5; arc=none smtp.client-ip=209.85.128.174
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff45dc44d1so14167487b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705427867; x=1706032667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z9i/7IxW+vD8oAmdqNGi8gKSOYfLZrN80TxMX3ACrg=;
        b=f/JUfKl5Q1BxzhHkzXbL3WJzt9ong+kA44jQ8KmrFUrYr9Q64j5GLTjn0Kss9yGljz
         S6ygarJQQ/1DfIrA69jhT2ULQXWni2pp/dOEZO0dPx6o5O9Jrmwt8ZqZmzEeE5Rdhavp
         bwv7uPUALw+56Tid6hsMYGrewmR1pPsdQ2V08qaG33QdA2vNaySAa/it374iIwuFZoPe
         YV5dq3qZXE0rIoUsA1A4tJnGlRguql+StFakIrTfLDExs/d7CvxoCMpzdHXyQXGrG78Y
         v0Fnl93zQ5Bbqs+Lkqpdtro1eSVsM/TqCtd2z9squzkYG/W/GedcsvhiaCOC8NlkvTcT
         W+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427867; x=1706032667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z9i/7IxW+vD8oAmdqNGi8gKSOYfLZrN80TxMX3ACrg=;
        b=C38dJUmZdxI9DITfReEMFhU49XidtwGC5XnnHq9r5krynjjpyNHUHUOLFoCVVm7R0y
         THkNh5mPr/uy5iiE2VMpo2+H1ZBSDW0uVfC0P3i8m93CuP288cf3AEnuMoYILjlliZPZ
         yb+ehywULRGe9g+QAUOcHLPLgbgCdjUEfsZd7sO+sTNvVoZnCrpCs97uiCrztZ7g+n03
         u+kCpnMpccfsPWakHB4DSHY8SzKWIoLaYW/bnJfniLBgu9PIj91d2J6RWYCyEfq+pT8L
         q9PiCWpZPrCEdyAN6opi5+No5llzavT9+8sXkbVQAU0Ix9/G/1HYqvWAUhGChf+mcQ/R
         uO/Q==
X-Gm-Message-State: AOJu0YxEawWNZeA7xFCvuBI7gZKuKotjCV8gzFIl3PjA24QcixY4os+u
	t0Y/LQh0zdyozl0hZHsWsJ7l5dcn+hwg9Rf7tp/brdgWE08E
X-Google-Smtp-Source: AGHT+IFyVFz3b29oTWOr9F5UxV+4etmI5OtR+C0TA+Mosl5koGhrgqlF3uiF6vK/YTAobFtxglozaPMX3P532Tcex2E=
X-Received: by 2002:a81:ad5b:0:b0:5ff:6117:3df9 with SMTP id
 l27-20020a81ad5b000000b005ff61173df9mr263299ywk.71.1705427866742; Tue, 16 Jan
 2024 09:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com> <1bc8a5df-b413-4869-8931-98f5b9e82fe5@suse.cz>
 <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz>
In-Reply-To: <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jan 2024 09:57:31 -0800
Message-ID: <CAJuCfpGTVEy=ZURbL3c7k+CduDR8wSfqsujN+OecPwuns7LiGQ@mail.gmail.com>
Subject: Re: [RFC 0/3] reading proc/pid/maps under RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, dchinner@redhat.com, casey@schaufler-ca.com, 
	ben.wolsieffer@hefring.com, paulmck@kernel.org, david@redhat.com, 
	avagin@google.com, usama.anjum@collabora.com, peterx@redhat.com, 
	hughd@google.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	Liam.Howlett@oracle.com, yuzhao@google.com, axelrasmussen@google.com, 
	lstoakes@gmail.com, talumbau@google.com, willy@infradead.org, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:46=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/16/24 15:42, Vlastimil Babka wrote:
> > On 1/15/24 19:38, Suren Baghdasaryan wrote:
> >
> > Hi,
> >
> >> The issue this patchset is trying to address is mmap_lock contention w=
hen
> >> a low priority task (monitoring, data collecting, etc.) blocks a highe=
r
> >> priority task from making updated to the address space. The contention=
 is
> >> due to the mmap_lock being held for read when reading proc/pid/maps.
> >> With maple_tree introduction, VMA tree traversals are RCU-safe and per=
-vma
> >> locks make VMA access RCU-safe. this provides an opportunity for lock-=
less
> >> reading of proc/pid/maps. We still need to overcome a couple obstacles=
:
> >> 1. Make all VMA pointer fields used for proc/pid/maps content generati=
on
> >> RCU-safe;
> >> 2. Ensure that proc/pid/maps data tearing, which is currently possible=
 at
> >> page boundaries only, does not get worse.
> >
> > Hm I thought we were to only choose this more complicated in case addit=
ional
> > tearing becomes a problem, and at first assume that if software can dea=
l
> > with page boundary tearing, it can deal with sub-page tearing too?

Hi Vlastimil,
Thanks for the feedback!
Yes, originally I thought we wouldn't be able to avoid additional
tearing without a big change but then realized it's not that hard, so
I tried to keep the change in behavior transparent to the userspace.

> >
> >> The patchset deals with these issues but there is a downside which I w=
ould
> >> like to get input on:
> >> This change introduces unfairness towards the reader of proc/pid/maps,
> >> which can be blocked by an overly active/malicious address space modif=
yer.
> >
> > So this is a consequence of the validate() operation, right? We could a=
void
> > this if we allowed sub-page tearing.

Yes, if we don't care about sub-page tearing then we could get rid of
validate step and this issue with updaters blocking the reader would
go away. If we choose that direction there will be one more issue to
fix, namely the maple_tree temporary inconsistent state when a VMA is
replaced with another one and we might observe NULL there. We might be
able to use Matthew's rwsem_wait() to deal with that issue.

> >
> >> A couple of ways I though we can address this issue are:
> >> 1. After several lock-less retries (or some time limit) to fall back t=
o
> >> taking mmap_lock.
> >> 2. Employ lock-less reading only if the reader has low priority,
> >> indicating that blocking it is not critical.
> >> 3. Introducing a separate procfs file which publishes the same data in
> >> lock-less manner.
>
> Oh and if this option 3 becomes necessary, then such new file shouldn't
> validate() either, and whoever wants to avoid the reader contention and
> converts their monitoring to the new file will have to account for this
> possible extra tearing from the start. So I would suggest trying to chang=
e
> the existing file with no validate() first, and if existing userspace get=
s
> broken, employ option 3. This would mean no validate() in either case?

Yes but I was trying to avoid introducing additional file which
publishes the same content in a slightly different way. We will have
to explain when userspace should use one vs the other and that would
require going into low level implementation details, I think. Don't
know if that's acceptable/preferable.
Thanks,
Suren.

>
> >> I imagine a combination of these approaches can also be employed.
> >> I would like to get feedback on this from the Linux community.
> >>
> >> Note: mmap_read_lock/mmap_read_unlock sequence inside validate_map()
> >> can be replaced with more efficiend rwsem_wait() proposed by Matthew
> >> in [1].
> >>
> >> [1] https://lore.kernel.org/all/ZZ1+ZicgN8dZ3zj3@casper.infradead.org/
> >>
> >> Suren Baghdasaryan (3):
> >>   mm: make vm_area_struct anon_name field RCU-safe
> >>   seq_file: add validate() operation to seq_operations
> >>   mm/maps: read proc/pid/maps under RCU
> >>
> >>  fs/proc/internal.h        |   3 +
> >>  fs/proc/task_mmu.c        | 130 ++++++++++++++++++++++++++++++++++---=
-
> >>  fs/seq_file.c             |  24 ++++++-
> >>  include/linux/mm_inline.h |  10 ++-
> >>  include/linux/mm_types.h  |   3 +-
> >>  include/linux/seq_file.h  |   1 +
> >>  mm/madvise.c              |  30 +++++++--
> >>  7 files changed, 181 insertions(+), 20 deletions(-)
> >>
> >
>

