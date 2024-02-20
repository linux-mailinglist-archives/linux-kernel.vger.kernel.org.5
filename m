Return-Path: <linux-kernel+bounces-72600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60385B5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336D0B214B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09045D743;
	Tue, 20 Feb 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHH24exD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166F5D75D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419015; cv=none; b=iLlN6sxfE+g0OJFhkcs47gk5RDMknt6d7K3a6uSOSbcYd8T3FysSDbqfspjH4De9HCKEcAB0pBoJ+AlMFBz2W5VCp9x/3dZ7LLl/XjPZAVqOF+zbg75IKQOXVHaZtguepBJs8+KLLD9UVHieuytsZsu4yX7vFFgNFXFuga46xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419015; c=relaxed/simple;
	bh=8wTnZeiZa5BwRGEKVPQRxlrFT+qy83N5pV5Kf9bmFtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tW4MRBD1ATUkgVKqsPjeW80WHSRH7Com44CyD3h9AwzpafGFzY89ygiUfUR+cxN9klaOgfoUD245mP7V5ZQv4llmdyz/X3fKufL5jR/k6Wq7Kh7ch80E6awXE/Sb7EKgI5spovvd8JfnG8BN2y/14vOLIyrIWDkF2iJoa26Q0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHH24exD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso6705110e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419011; x=1709023811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t15t0QA8PUUprA9RZMeoEMSHHE4KRxpyRH362kM2s2k=;
        b=KHH24exDGScJw4t0k9Dx/YF8PAOXfF1GSwVh/JqzJie5ZLS5bHHeIBvVyYCRl50FR7
         265CQEu8+01TeUR59pHDzkYP3C+R//g0xTUEFZWEgWQ20uzvpPB5h+4+JuRyNZI2tYBc
         Z0aHfGYjWK6BvCVtbO+5cQFAKjifAKtKa5MUSc2JRD2AoBzWMS+nI3+s0xMzfcdCtBnd
         GIO+PAhsk8/9wqDTycgCw1G6ElOVkkbVqDEPfDe11anV89I+VYuhXySZT/WgqhryjsYh
         0WUznxZqYfKb4Bwkp3fY74H9MvbqfqNKg5hsdCf5FE0UYo9LbiZ2RwicoUrzxPIONqfP
         rLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419011; x=1709023811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t15t0QA8PUUprA9RZMeoEMSHHE4KRxpyRH362kM2s2k=;
        b=kXv/WrvFQBAn0zqJ9RzSfjYfsFk2Il3C6DEAGm3mf/F34lR0vjEpXEcqYxpdr9k1ee
         3XW3RdQBTFPFvQfT1Udahc1wyieXx2hZm9DKo/LQao5L6Bg7UvOSqdVLkdQp+MI150Nx
         5L4keM+8XxMuTvGQzy3njLrDiHhsBbfo0nJG6Y84bPx0Fo21aoXqK0JpOUewO48rz2HJ
         qONBRuZP/mJ1+R9xkHf+k1UCV5JHKmjvUct9RQnTwVQ0suJ9obbffB9nhwO3Dw91PBda
         7fk9qGXPTxC40IOtUVUS7m/EYjH6FDn39MvrL91PXQhhDBXggtEQEss7ZZOjIFCee0t1
         GUEg==
X-Forwarded-Encrypted: i=1; AJvYcCVivMx2olgbMPwkF/zyVp5bssTU6csUnjEPM5Men1JwCXMwl5QhG3hyRDHF0lKXbdOyEjhVh7eXfpPlohYqeMWl8DjRdsx1cHey8g+7
X-Gm-Message-State: AOJu0Yy16xEAY/wc4hyOIhzEuefMqlEjfNwa/NIFNYHOKvx1TkfHBvei
	R0gqaFfm1pZwVM0VRgB4/umAXfYVH2WIe5wRfQoajlS/hBDpzlJrUtTyk2c+EV8rmviiFJyYb+T
	HFzJUAN9cL8SKAufPnd/h+VdGRw==
X-Google-Smtp-Source: AGHT+IGSrY3qaVh89MY2zmF9/3vB9Lqtwk0TAXP32s03QoePEzUbbI6OHGKgOJkgEt4RI1ZdDfVfxT7iFF2pb/OSiL0=
X-Received: by 2002:ac2:4a81:0:b0:512:bead:d1a0 with SMTP id
 l1-20020ac24a81000000b00512beadd1a0mr759189lfp.14.1708419011168; Tue, 20 Feb
 2024 00:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <20240219031911.10372-3-fangzheng.zhang@unisoc.com> <ZdLX51r1mOEZKUje@casper.infradead.org>
 <CA+kNDJ+C2b520afauSWbfNK=S1XiNHR_zF32_K-3Rf7R6m3n5Q@mail.gmail.com> <4591b2b3-398f-402e-b21d-55b244f05a2e@suse.cz>
In-Reply-To: <4591b2b3-398f-402e-b21d-55b244f05a2e@suse.cz>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Tue, 20 Feb 2024 16:49:59 +0800
Message-ID: <CA+kNDJLCEdeQsaaLggxbUzF4mAqk_ZLKe=o3cnRkZO8_EKhoSQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] Documentation: filesystems: introduce
 proc/slabinfo to users
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Fangzheng Zhang <fangzheng.zhang@unisoc.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tkjos@google.com, 
	Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 4:09=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/19/24 07:23, zhang fangzheng wrote:
> > On Mon, Feb 19, 2024 at 12:24=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> >>
> >> On Mon, Feb 19, 2024 at 11:19:11AM +0800, Fangzheng Zhang wrote:
> >> > +Note, <slabreclaim> comes from the collected results in the file
> >> > +/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /proc/s=
labinfo
> >> > +as deprecated and recommend the use of either sysfs directly or
> >> > +use of the "slabinfo" tool that we have been providing in linux/too=
ls/mm.
> >>
> >> Wait, so you're going to all of the trouble of changing the format of
> >> slabinfo (with the associated costs of updating every tool that curren=
tly
> >> parses it), only to recommend that we stop using it and start using
> >> tools/mm/slabinfo instead?
> >>
>
> Hi,
>
> > The initial purpose was to obtain the type of each slab through
> > a simple command 'cat proc/slabinfo'. So here, my intention is not to
> > update all slabinfo-related tools for the time being, but to modify
> > the version number of proc/slabinfo and further display the results
> > of using the command.
>
> I'm not sure you understand the concern. There are existing consumers of
> /proc/slabinfo, that might become broken by patch 1/2. We don't even know
> them all, they might not be all opensource etc. So we can't even make sur=
e
> all of them are updated. What can happen after patch 1/2:
> - they keep working and ignore the new column (good)
> - they include a version check and notice a new unsupported version and
> refuse to work
> - confused by the new column they start throwing error, or report wrong
> stats (that's worse)
>
I generally understand your concerns about modifying patch 1/2.

But judging from my modifications, this worry does not seem to be valid.
Because the =E2=80=9C/proc/slabinfo=E2=80=9D is not used in related slabinf=
o debugging tools
(such as tools/mm/slabinfo), but "/sys/kernel/slab/<slab_name>/" (in
Documentation/mm/slub.rst) or "/ sys/kernel/debug/slab" (in
tools/mm/slabinfo.c).

Furthermore, the current modification only involves optimizing the output
of proc/slabinfo, and does not modify the  struct slabinfo or struct kmem_c=
ache.
So there is no need to adapt other modifications.

> >> How about we simply do nothing?
>
> Agreed wrt modifying /proc/slabinfo
>
> > The note here means what changes will occur after
> > we modify the version number of proc/slabinfo to 2.2.
> > As for the replacement of tools/mm/slabinfo (that inspired
> > by Christoph=E2=80=99s suggestions), it will be implemented in the next=
 version
> > or even the later version.
>
> So what is your motivation for all this in the first place? You have some
> monitoring tool that relies on /proc/slabinfo and want to distinguish
> reclaimable caches? So you can change it to parse the /sys directories. I=
s
> it more work? Yes, but you only have to do that once per boot, because
> unlike the object/memory stats in /proc/slabinfo, the reclaimable flag wi=
ll
> not change for a cache.
>
The situation as you mentioned is very suitable for my current needs.
My original intention is just to get an intuitive slab screen through a
simple =E2=80=98cat proc/slabinfo=E2=80=99 command. As for the description =
"<slabreclaim>
comes from the collected results in the file
/sys/kernel/slab/$cache/reclaim_account"
may not be appropriate. Here I want to express that the column <slabreclaim=
> has
the same effect as traversing "/sys/kernel/slab/$ cache/reclaim_account".

> Would tools/mm/slabinfo almost work for you, but you're missing something=
?
> Then send patches for that in the first place. Changing /proc/slabinfo (a=
nd
> breaking other consumers) for a quick and easy fix with a different solut=
ion
> planned for the future is simply not feasible.
>
Using the slabinfo tool to parse /sys/kernel/slab/$cache/reclaim_account
is what I think about optimizing future tools during the discussion.
It will not affect the current patch 1/2, and patch 2/2 is mainly to
supplement the output examples of proc/slabinfo.

If the community is willing to accept it, I will only modify
patch 1/2 to implement it.

Thanks very much!

> HTH,
> Vlastimil
>
> > Thanks!
>

