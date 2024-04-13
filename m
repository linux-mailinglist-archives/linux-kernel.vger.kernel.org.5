Return-Path: <linux-kernel+bounces-143486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B18A3A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590FB1C21816
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E96AA1;
	Sat, 13 Apr 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9kDvazX"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2484C65
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970379; cv=none; b=TjBPAHcBosSzFWInLTN5d2rW6LX4tvk1Zn34yTm7EBNGm7HyzHaYIGCYHCBg1w0L8RWxjoGMbJB1n0zAOYw9ytriIl6H4IOd1GIqL7PEKpZILUYfBDCTqS/pdMtFqwIk/kTOYAEePE3BVd9BlZ1LWgzW/76rd+lGdvYGd2vENOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970379; c=relaxed/simple;
	bh=MHmucI/H5NxibwlUQ0js8/JOPLCBsTS2p7VG0CvPNNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4hWFbdbLqgP9qogw8Mca3IcW0wyAXwe3zjkLB8LOnCQA0+C0+Hn3evC/V0fgdGlwpr0pzvqJcaOTeFj2HcET4oiULoMdaEDIxU/yTeX13m2m/WzpTr/xcW/1wUwFovd+IQ/hh5ERqcrTlFSzTv5fK9RKvCyTXvYYRa0eyNslIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9kDvazX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so1810721e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712970376; x=1713575176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHmucI/H5NxibwlUQ0js8/JOPLCBsTS2p7VG0CvPNNo=;
        b=m9kDvazXq5P6Z2jCFUucDb31pK8mSAtfCN4bGMt28LuW4H9B9idjxoe97NybOkEkiC
         F1FdhncIf3UN8mmWichl7VqWx/tf3b1ySZ6Y7SBY+MZCtzGZOkH+t6pJjjOWCCLdYgs1
         xD7ucjGSRde9Cr/IKLxeeYXk8k7/q/Wh2ML70+UY6Ae7h9f/ADlv8GetuDH8g05tuQN5
         qhQpEpilbnHCaNWiiKajcd3P0YSJQYQrop74svBt2ucUnTpQelms91jeZrGOKuDfBM1h
         L/uLmqMVgKt9e9gU58c4LnNL7DPbeI9eJ+ThfeLvImN2tA+MlfjoTLg2YVAJVp/p1Zhi
         rtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712970376; x=1713575176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHmucI/H5NxibwlUQ0js8/JOPLCBsTS2p7VG0CvPNNo=;
        b=vtdsEvozdpncwOuMw7ddRUCE/65GzEbhw4s2Ysb8m8Ob6iUpLtAmsQ28d7lnSONAeq
         I1ljXDxqFxmgNBUUocXhoMBXOCserClhe1Sk69yWbO8YJ5JLXabNJUBNHUwDYS8Tmzrw
         rdm7XzZ4ta37taDbbpxxcA5ZMDfODZa26rQaX4MdS/UUPtDmGqN7JoL4p3E2YbO4BSyK
         mzNXhbrPBVrrJkhfPZ5zvJ44uKilAx8EdSxUvivI9WhuGsoliu0FHn4xyDoanYRQL8nj
         zeYeCjR5Kb81G8V3blW28713Sb+cmpftYO6MMTz3+DpDqxBNMEuo7Ga+a+tGQW0rdWt8
         GTGw==
X-Forwarded-Encrypted: i=1; AJvYcCUk8QxaFeSZAPvRMyux5AUVRHi3IMNlxJwpzuMF3yVSuV8nXd1E/1FPippiOqNR2zpuWAezqi9raYoWEuGHaHMq7JTCobepfs8HCvr/
X-Gm-Message-State: AOJu0YyedpmGzOZ4KFFcR0K9u8dWfmZi9JuqtjBJai/T738gJhEdcKKc
	h/4DAh1HweSsI/abtLmXfmlX/NxLyzmm7ZeZQe8bi/gKuYOkp44xMxv/0E31Y7tw8+vyjvFjXYX
	bEcoK0VtL4pu20XcSt/jnNjyzVVdAHC3eQYlXvHxwpad1b8nU3FcYeP8=
X-Google-Smtp-Source: AGHT+IFpxB1heOrrx/VKM6QexHAFmFQpjYHMRq+COSAp1rnrwuNIOToge4I6KnTSQ3CbY3cdCojL2edeLrHQ+egw2yQ=
X-Received: by 2002:ac2:430d:0:b0:513:5951:61a4 with SMTP id
 l13-20020ac2430d000000b00513595161a4mr2495959lfh.6.1712970375757; Fri, 12 Apr
 2024 18:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com> <20240405152619.GA866431@cmpxchg.org>
 <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
 <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com> <CAJD7tkaa3P7dQys+LhuDe8kqWsUqf7PDB8Q+07+wnQ513-6NLg@mail.gmail.com>
 <69dcd33b-e8de-4927-93dd-d4ea22834a18@redhat.com> <CAJD7tkb5D6Y5OMTzpHefYgSXbw7GdPtfjSp2=nBGjJFk99GP_A@mail.gmail.com>
 <f18ecb84-31a5-4767-a8df-0c0b8be82d81@redhat.com>
In-Reply-To: <f18ecb84-31a5-4767-a8df-0c0b8be82d81@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 12 Apr 2024 18:05:39 -0700
Message-ID: <CAJD7tkYMM9oDQYsWPcQNctRRH52+oM-3cUhxV+_7Qg1NNZx4cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:48=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 10.04.24 02:52, Yosry Ahmed wrote:
> > [..]
> >>> Do we need a separate notifier chain for totalram_pages() updates?
> >>
> >> Good question. I actually might have the requirement to notify some ar=
ch
> >> code (s390x) from virtio-mem when fake adding/removing memory, and
> >> already wondered how to best wire that up.
> >>
> >> Maybe we can squeeze that into the existing notifier chain, but needs =
a
> >> bit of thought.
> >
>
> Sorry for the late reply, I had to think about this a bit.
>
> > Do you mean by adding new actions (e.g. MEM_FAKE_ONLINE,
> > MEM_FAKE_OFFLINE), or by reusing the existing actions (MEM_ONLINE,
> > MEM_OFFLINE, etc).
>
> At least for virtio-mem, I think we could have a MEM_ONLINE/MEM_OFFLINE
> that prepare the whole range belonging to the Linux memory block
> (/sys/devices/system/memory/memory...) to go online, and then have
> something like MEM_SOFT_ONLINE/MEM_SOFT_OFFLINE or
> ENABLE_PAGES/DISABLE_PAGES ... notifications when parts become usable
> (!PageOffline, handed to the buddy) or unusable (PageOffline, removed
> from the buddy).
>
> There are some details to be figured out, but it could work.
>
> And as virtio-mem currently operates in pageblock granularity (e.g., 2
> MiB), but frequently handles multiple contiguous pageblocks within a
> Linux memory block, it's not that bad.
>
>
> But the issue I see with ballooning is that we operate here often on
> page granularity. While we could optimize some cases, we might get quite
> some overhead from all the notifications. Alternatively, we could send a
> list of pages, but it won't win a beauty contest.
>
> I think the main issue is that, for my purpose (virtio-mem on s390x), I
> need to notify about the exact memory ranges (so I can reinitialize
> stuff in s390x code when memory gets effectively re-enabled). For other
> cases (total pages changing), we don't need the memory ranges, but only
> the "summary" -- or a notification afterwards that the total pages were
> just changed quite a bit.


Thanks for shedding some light on this. Although I am not familiar
with ballooning, sending notifications on page granularity updates
sounds terrible. It seems like this is not as straightforward as I had
anticipated.

I was going to take a stab at this, but given that the motivation is a
minor optimization on the zswap side, I will probably just give up :)

For now, I will drop this optimization from the series for now, and I
can revisit it if/when notifications for totalram_pages() are
implemented at some point. Please CC me if you do so for the s390x use
case :)

>
>
> >
> > New actions mean minimal impact to existing notifiers, but it may make
> > more sense to reuse MEM_ONLINE and MEM_OFFLINE to have generic actions
> > that mean "memory increased" and "memory decreased".
>
> Likely, we should keep their semantics unchanged. Things like KASAN want
> to allocate metadata memory for the whole range, not on some smallish
> pieces. It really means "This Linux memory block goes online/offline,
> please prepare for that.". And again, memory ballooning with small pages
> is a bit problematic.
>
> >
> > I suppose we can add new actions and then separately (and probably
> > incrementally) audit existing notifiers to check if they want to
> > handle the new actions as well.
> >
> > Another consideration is that apparently some ballooning drivers also
> > register notifiers, so we need to make sure there is no possibility of
> > deadlock/recursion.
>
> Right.
>
> --
> Cheers,
>
> David / dhildenb
>

