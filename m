Return-Path: <linux-kernel+bounces-30706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15C83235C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E0285EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48B139D;
	Fri, 19 Jan 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldr6hg1A"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAF15A4;
	Fri, 19 Jan 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631848; cv=none; b=XWw6feMSjnuTDfRSTn5BeiKNcRgoq/rJm+9wEXatTLy8BKjYpuGtmRTxQ5+iuMILwBlo4wJUDpWDl7TE0THbebVusxPelgtsoT7xDTOXiVYAfVANq8GCvvJDHHAe80wDwAWAO5lKsG0Z7KLevKIIofc7t6+baaYR7kL68239vus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631848; c=relaxed/simple;
	bh=aICAH4hRXeLeMw1z8zxzaW7lbyGRMfDIu0CC/thDglg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIwq24TAh003AT4OM72uwxdtdDEmd7A/HlGnQegpdhiPFV1lTvD3xXSE2EuryBnokhhfZGCIQ84pekT5PvPkuFu8Ri4jc9rigT5/CKFQ7tvT371mqqZ1QBBFofqsTWm/1b5WBvfx4OgvJNnI+Uh2+toMwZuczllBCGhX5g+8OvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldr6hg1A; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ebca94cf74so3178837b3.0;
        Thu, 18 Jan 2024 18:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705631846; x=1706236646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aICAH4hRXeLeMw1z8zxzaW7lbyGRMfDIu0CC/thDglg=;
        b=ldr6hg1A/8WMSsCLdyU6MRQGsRsvrpVwAmeGGnle2Rcr8wJpoemKiNDuoSrXM4vRfP
         zYZ025iYb9VCmXMzTxlszWdZfWwzz/WC+OoT/AoVkJTN1sk8v33DJa0IhVLVgX7tbAIA
         aJGg8ohJWycWsj+k+InHaX4Z0D1+M6Bdm/dppyQAcD3Ib5HRg71w+gSAvVDVtIS+iEQw
         BTgQ+bsYqGbbUgUgm9VLElnexUZZIaY1X5BhVdriBYjvXEpxuflnPjl+BVVhGwM2Vd7Q
         sfX9yK0Nvlmrwc+STUzlqPeotInONJRHVvqo8xz+M4rbdXO+YiYYQxU9+xHM8PxVNOaO
         92WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705631846; x=1706236646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aICAH4hRXeLeMw1z8zxzaW7lbyGRMfDIu0CC/thDglg=;
        b=Aq9PE/00bQ9L017q0kj7vRYuODMEvP5qmtyx9cv70d3aczPGKjTDkBssTVNLirE1DV
         i0iegl7L1AVsgLdkAmGTdsIAdzwqbJdXUIqjUkVuWk5l6wEmCVkubVP2EUHac0kTEgzg
         lDMuUVXwJZjr4eJQvCUIt1rK1YVfXiFsv/RW9Q9riy+3lNSOeNOBkHXmkwynBbKjkL0q
         s58icv8U+LyKaPNrsaFHefR2/V+miWXSJZ2g83//L6d58wRwW1spXJYpTMU8+TGHrcBj
         f3As1LXDrLx+JBPbA9Pf5TWEKyLPM2kCJ0tA5flPflExHjzIelCkiDK1lzKr1SVHUcA/
         NHMw==
X-Gm-Message-State: AOJu0YwdWri43d5k115aayrm/C1240VUJX0ZJWRBAXlpyy7AYvsH3IrA
	oWaCdn+JXM9dpXYuE+GPYmhl2X2MndIYp3D+GNmpRy57J7FDzW8dZSFCGgONpPC+QWiEoHTYW87
	nDsBKosf/hoqjuMlS41uJCRumkeo=
X-Google-Smtp-Source: AGHT+IFh9LHQHtffb4CbOihY48EMjl6zFT/VeDNE2gD3ybmauOUjWzJrCzUrHXjoEE8tIzwDekj0YCoL7L2xxgPhr8g=
X-Received: by 2002:a5b:c07:0:b0:dc2:371d:53b with SMTP id f7-20020a5b0c07000000b00dc2371d053bmr1488950ybq.9.1705631845763;
 Thu, 18 Jan 2024 18:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <Zakq-54DFdPu0c2U@tiehlicka> <CAAa6QmTN2B-JAO=38A09hMtUp=srLiUfs=sDbck7Chkr=W-dCw@mail.gmail.com>
 <CAHbLzkphG+kmLvYQFB6WZuuGadPsRvsH4Os9CwnxvizKAfwuvQ@mail.gmail.com>
In-Reply-To: <CAHbLzkphG+kmLvYQFB6WZuuGadPsRvsH4Os9CwnxvizKAfwuvQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 19 Jan 2024 10:37:14 +0800
Message-ID: <CAK1f24kQTUQsNf05cxJ_HsaLg9rTBWh8K64PCVbeudW8G7pStg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Yang Shi <shy828301@gmail.com>
Cc: "Zach O'Keefe" <zokeefe@google.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Yang,

Thanks for taking the time to review!

On Fri, Jan 19, 2024 at 3:00=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Thu, Jan 18, 2024 at 6:59=E2=80=AFAM Zach O'Keefe <zokeefe@google.com>=
 wrote:
> >
> > On Thu, Jan 18, 2024 at 5:43=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > Dang, forgot to cc linux-api...
> > >
> > > On Thu 18-01-24 14:40:19, Michal Hocko wrote:
> > > > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > > > [...]
> > > >
> > > > before we discuss the semantic, let's focus on the usecase.
> > > >
> > > > > Use Cases
> > > > >
> > > > > An immediate user of this new functionality is the Go runtime hea=
p allocator
> > > > > that manages memory in hugepage-sized chunks. In the past, whethe=
r it was a
> > > > > newly allocated chunk through mmap() or a reused chunk released b=
y
> > > > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back m=
emory with
> > > > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLA=
PSE)[3]
> > > > > respectively. However, both approaches resulted in performance is=
sues; for
> > > > > both scenarios, there could be entries into direct reclaim and/or=
 compaction,
> > > > > leading to unpredictable stalls[4]. Now, the allocator can confid=
ently use
> > > > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation =
of huge pages.
> >
> > Aside: The thought was a MADV_F_COLLAPSE_LIGHT _flag_; so it'd be
> > process_madvise(..., MADV_COLLAPSE, MADV_F_COLLAPSE_LIGHT)
> >
> > > > IIUC the primary reason is the cost of the huge page allocation whi=
ch
> > > > can be really high if the memory is heavily fragmented and it is ca=
lled
> > > > synchronously from the process directly, correct? Can that be worke=
d
> > > > around by process_madvise and performing the operation from a diffe=
rent
> > > > context? Are there any other reasons to have a different mode?
> > > >
> > > > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE =
-
> > > > e.g. non blocking one to make sure that the caller doesn't really b=
lock
> > > > on resource contention (be it locks or memory availability) because=
 that
> > > > matches our non-blocking interface in other areas but having a LIGH=
T
> > > > operation sounds really vague and the exact semantic would be
> > > > implementation specific and might change over time. Non-blocking ha=
s a
> > > > clear semantic but it is not really clear whether that is what you
> > > > really need/want.
> >
> > IIUC, usecase from Go is unbounded latency due to sync compaction in a
> > context where the latency is unacceptable. Working w/ them to
> > understand how things can be improved -- it's possible the changes can
> > occur entirely on their side, w/o any additional kernel support.
> >
> > The non-blocking case awkwardly sits between MADV_COLLAPSE today, and
> > khugepaged; esp when common case is that the allocation can probably
> > be satisfied in fast path.
> >
> > The suggestion for something like "LIGHT" was intentionally vague
> > because it could allow for other optimizations / changes down the
> > line, as you point out. I think that might be a win, vs tying to a
> > specific optimization (e.g. like a MADV_F_COLLAPSE_NODEFRAG). But I
> > could be alone on that front, given the design of
> > /sys/kernel/mm/transparent_hugepage.
>
> Per the description Go marks the address spaces with MADV_HUGEPAGE. It
> means the application really wants to have huge page back the address
> space so kernel will try as hard as possible to get huge page. This is
> the default behavior of MADV_HUGEPAGE. If they don't want to enter
> direct reclaim, they can configure the defrag mode to "defer", which
> means no direct reclaim and wakeup kswapd and kcompactd, and rely on
> khugepaged to install huge page later on. But this mode is not
> supported by khugepaged defrag, so MADV_COLLAPSE may not support it
> (IIRC MADV_COLLAPSE uses khugepaged defrag mode). Or they can just not
> call MADV_HUGEPAGE and leave the decision to the users, IIRC Java does
> so (specifying a flag to indicate use huge page or not by the users).

Thank you for providing insights into the Go use cases with MADV_HUGEPAGE
and the configuration options for defrag mode.

Considering the limitations with the "defer" mode, it becomes apparent
that there
is a gap in addressing scenarios where an application desires a lighter-wei=
ght
alternative to MADV_HUGEPAGE.

MADV_F_COLLAPSE_LIGHT aims to fill this gap by providing a more flexible an=
d
opportunistic approach, catering to applications in latency-sensitive
environments
that seek performance improvements with huge pages but prefer to avoid dire=
ct
reclaim and compaction. This option can serve as a valuable addition for us=
ers
who want more control over the behavior without the constraints of existing
configurations.

In the era of cloud-native computing, it's challenging for users to be
aware of the
THP configurations on all nodes in a cluster, let alone have
fine-grained control
over them. Simply disabling the use of huge pages due to concerns
about potential
direct reclamation and compaction may be regrettable, as users are deprived=
 of
the opportunity to experiment with large page allocations. However,
relying solely on
MADV_HUGEPAGE introduces the risk of unpredictable stalls, making it a trad=
e-off
that users must carefully consider.

By introducing MADV_F_COLLAPSE_LIGHT, we offer users a more flexible and
controllable solution in cloud-native environments, allowing them to
better balance
performance requirements and resource management. This selectively lightwei=
ght
alternative is designed to provide users with more choices to better
meet the diverse
needs of different scenarios.

Thanks again for your review and your suggestion!
Lance

>
> >
> > But circling back, I agree w/ you that the first order of business is t=
o
> > iron out a real usecase. As of right now, it's not clear something
> > like this is required or helpful.
> >
> > Thanks,
> > Zach
> >
> >
> >
> >
> > > > > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec=
56404faca29a82689c77
> > > > > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740=
996181268b60a3a
> > > > > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9e=
ca3be4b3a9bd2af
> > > > > [4] https://github.com/golang/go/issues/63334
> > > > >
> > > > > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker=
0@gmail.com/
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs

