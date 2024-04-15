Return-Path: <linux-kernel+bounces-145763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4048A5A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6D31F226D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC1155A57;
	Mon, 15 Apr 2024 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PnR6gDv1"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED3155A37
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208707; cv=none; b=d+f7He0O8JN4KWXht/5sgCs6urAOKKpposjfBJIyRY7zN2w/TY65yzaA7KiGpcUEstU19HUW6/i8wjohKKbk5vMmU8oK3XF0b/15HHkSut0LOfj9eDnRa2C81e9hm+ds7o0vgfrAb041i30lJqW5xJcz5ukNZh3DJ9oGwi5X2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208707; c=relaxed/simple;
	bh=ALuNIUZS6wYf2/keSwqWw7ntqvL6NRxjJfhg0zFl8vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI5wgeeurkqpaYDtVqNbbpPE9171iZu0LA+yhPJfgLg2ylI87wiBbT/tNn2MFK4kIUuke8IvXfB/X2lFdkrntzqjh0V/FswRF0nbxxm8GCE9Ralv3SGmggskkPqf2eWr5XLiQXAlpRWqt40cyJm3FZl9v1VFliOa0XKkG37h0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnR6gDv1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso2868613a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713208704; x=1713813504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuNIUZS6wYf2/keSwqWw7ntqvL6NRxjJfhg0zFl8vo=;
        b=PnR6gDv1LKhAqa4e3Jvuu6AhIMEnGsxr0TmjdFoNuDGjni1Uik/fqVzVvl3f2GudAr
         x0QTp7ammGVWubpHRY4DlJE6hZu3u44X6ZHi77fxlGtf3BqMaUKXuJ5c04enOHm2Jgtp
         sXsS62iIe9RbvyhIxCOAW4iLRnHU4c5jLiaYRvdHhMWoGAn6ffUcSZrowzFU3F3Ssn++
         brStGJgQU/fr2+uCAz1Lx3BDLuMnTp9dEDfM1UctbBR5zqQ4XyDQauoKcVuxX02fmOPN
         /6Fbc+f++h5bVDeaMlu1x+KToaj9jF++MWK/z2oseeadY/LyHjQXjm3OVleOeMqJybKs
         /EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713208704; x=1713813504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALuNIUZS6wYf2/keSwqWw7ntqvL6NRxjJfhg0zFl8vo=;
        b=TbhBMMlOi5ct0D8Po8WH2/tFDcldpy+ZWGj7AfQ+Tfc7vhxxoAUuclcZIyoTfKaQdn
         0py27DMwmwRyRZhpYONRnFpNSMqexK7PkEESBS4d7m/XVvs8Cs3k/gJAXQji7x6o9zfX
         ULOnMB9yyYpwUyq9upzXxGmJ4uK8uHYYVp0dU7Fhj0uZbcfTqaCljnPT1z2VQ3+7S40T
         mQfX7LQVWwPAiv0U1EU3/q16ZaN8GGeM+0gWJP3cKo9akH9giZ8KPBycY//RYH7W1dzF
         ccl4DhW0UtE40axP7j0Z3iEwj8izAqe0i9bgmZfF8lvt03+/FTwg8wck4MU758kbNI2e
         2oKg==
X-Forwarded-Encrypted: i=1; AJvYcCVHgnExuO2LGSYpB8AWgLjXpqc1O5vs4+0DO/KO/bRWbS3SGdSbvOHKF7OdZnM1BVJEKPPwlKQCBojElDnpxk9iqFMYs54CkHnHZkEh
X-Gm-Message-State: AOJu0YzJSxqNbmHlSksa0vZCL4Nl34iGM4gwmkBfOFgb/CQ2fQ+te43i
	XEeCkt4TSB0JYVpKP6v5XltM+jK9oZkuQTwlQU7s5O/GJFdADXdzG97xi7V4gA9YKsoen2LCy2P
	gBuIFFeDYB5x3fi9Oz9iy7NoiexUkqBd2Uq8J
X-Google-Smtp-Source: AGHT+IHKCkhaUIaCBrVZaX7MLiHQwQXRoDVNNDzRPPY70dSBbHyXa1c9PIqBRcGGWLmm0Lk046xfsLONk3Ydo7CxG2M=
X-Received: by 2002:a17:906:68e:b0:a52:66f3:a9ee with SMTP id
 u14-20020a170906068e00b00a5266f3a9eemr2471348ejb.41.1713208703571; Mon, 15
 Apr 2024 12:18:23 -0700 (PDT)
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
 <f18ecb84-31a5-4767-a8df-0c0b8be82d81@redhat.com> <CAJD7tkYMM9oDQYsWPcQNctRRH52+oM-3cUhxV+_7Qg1NNZx4cg@mail.gmail.com>
 <d4b5033a-34fd-44ed-ab57-ea2b4ed01468@redhat.com> <CAJD7tkacCA5JQpis=Y6zGVx+uMnwCBk3jUDA8Nch2qXnR1qrgw@mail.gmail.com>
 <11e9143f-67c6-4d7a-827b-dd04043b6fa4@redhat.com>
In-Reply-To: <11e9143f-67c6-4d7a-827b-dd04043b6fa4@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 15 Apr 2024 12:17:45 -0700
Message-ID: <CAJD7tkZJW38zmrss_vYT=kgAPsgux3i_8zmaZg5QKOtPoruA7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:15=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 15.04.24 20:30, Yosry Ahmed wrote:
> > On Mon, Apr 15, 2024 at 8:10=E2=80=AFAM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 13.04.24 03:05, Yosry Ahmed wrote:
> >>> On Fri, Apr 12, 2024 at 12:48=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>
> >>>> On 10.04.24 02:52, Yosry Ahmed wrote:
> >>>>> [..]
> >>>>>>> Do we need a separate notifier chain for totalram_pages() updates=
?
> >>>>>>
> >>>>>> Good question. I actually might have the requirement to notify som=
e arch
> >>>>>> code (s390x) from virtio-mem when fake adding/removing memory, and
> >>>>>> already wondered how to best wire that up.
> >>>>>>
> >>>>>> Maybe we can squeeze that into the existing notifier chain, but ne=
eds a
> >>>>>> bit of thought.
> >>>>>
> >>>>
> >>>> Sorry for the late reply, I had to think about this a bit.
> >>>>
> >>>>> Do you mean by adding new actions (e.g. MEM_FAKE_ONLINE,
> >>>>> MEM_FAKE_OFFLINE), or by reusing the existing actions (MEM_ONLINE,
> >>>>> MEM_OFFLINE, etc).
> >>>>
> >>>> At least for virtio-mem, I think we could have a MEM_ONLINE/MEM_OFFL=
INE
> >>>> that prepare the whole range belonging to the Linux memory block
> >>>> (/sys/devices/system/memory/memory...) to go online, and then have
> >>>> something like MEM_SOFT_ONLINE/MEM_SOFT_OFFLINE or
> >>>> ENABLE_PAGES/DISABLE_PAGES ... notifications when parts become usabl=
e
> >>>> (!PageOffline, handed to the buddy) or unusable (PageOffline, remove=
d
> >>>> from the buddy).
> >>>>
> >>>> There are some details to be figured out, but it could work.
> >>>>
> >>>> And as virtio-mem currently operates in pageblock granularity (e.g.,=
 2
> >>>> MiB), but frequently handles multiple contiguous pageblocks within a
> >>>> Linux memory block, it's not that bad.
> >>>>
> >>>>
> >>>> But the issue I see with ballooning is that we operate here often on
> >>>> page granularity. While we could optimize some cases, we might get q=
uite
> >>>> some overhead from all the notifications. Alternatively, we could se=
nd a
> >>>> list of pages, but it won't win a beauty contest.
> >>>>
> >>>> I think the main issue is that, for my purpose (virtio-mem on s390x)=
, I
> >>>> need to notify about the exact memory ranges (so I can reinitialize
> >>>> stuff in s390x code when memory gets effectively re-enabled). For ot=
her
> >>>> cases (total pages changing), we don't need the memory ranges, but o=
nly
> >>>> the "summary" -- or a notification afterwards that the total pages w=
ere
> >>>> just changed quite a bit.
> >>>
> >>>
> >>> Thanks for shedding some light on this. Although I am not familiar
> >>> with ballooning, sending notifications on page granularity updates
> >>> sounds terrible. It seems like this is not as straightforward as I ha=
d
> >>> anticipated.
> >>>
> >>> I was going to take a stab at this, but given that the motivation is =
a
> >>> minor optimization on the zswap side, I will probably just give up :)
> >>
> >> Oh no, so I have to do the work! ;)
> >>
> >>>
> >>> For now, I will drop this optimization from the series for now, and I
> >>> can revisit it if/when notifications for totalram_pages() are
> >>> implemented at some point. Please CC me if you do so for the s390x us=
e
> >>> case :)
> >>
> >> I primarily care about virtio-mem resizing VM memory and adjusting
> >> totalram_pages(), memory ballooning for that is rather a hack for that
> >> use case ... so we're in agreement :)
> >>
> >> Likely we'd want two notification mechanisms, but no matter how I look
> >> at it, it's all a bit ugly.
> >
> > I am assuming you mean one with exact memory ranges for your s390x use
> > case, and one high-level mechanism for totalram_pages() updates -- or
> > did I miss the point?
>
> No, that's it.
>
> >
> > I am interested to see how page granularity updates would be handled
> > in this case. Perhaps they are only relevant for the high-level
> > mechanism? In that case, I suppose we can batch updates and notify
> > once when a threshold is crossed or something.
>
> Yes, we'd batch updates.

Thanks for clarifying, looking forward to your changes :)

