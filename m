Return-Path: <linux-kernel+bounces-50174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050E847551
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961A7B20B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1413E228;
	Fri,  2 Feb 2024 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PMxOMIGk"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB51487C1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892498; cv=none; b=GmsdI/dZ77GFQFibhn6YBGKLSrb1vsY1hnaSky7JORxaTX7BrMnth0A6EO5g/jPOAaJVQsd8qM6dS/e05BRj1EFvXu5Nz40qNEF1yPiQZvzJEv68FX4tfkxcbvOgwa3LQfby0eVTIzIlchzCCaVGoBu3tVgnVpLVxcP3lTYSoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892498; c=relaxed/simple;
	bh=coHSk/yvtjbeST5xOzwNiQYIV1rwnNm9/PU4uK3+dNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzl63OcyJXPDF/kzu4KmZPhf06RamdvULy0AmFcn6ORFN7lfjWDG4NS3wR3uPlA6m7cOi9v0hagMMGil+wZ0BbXs51GA51hK+eWKBdiCsraciCUyo70RuLrrA5dSIGO6xygnW1vVKI9vXSJi6jIEPfhPsEWPXeiPvXQFbEFCocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMxOMIGk; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46d0b74a93dso91158137.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706892496; x=1707497296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqIRLfLzGkEvSBmQJbYiIflgqcbJlUJTWpbIXyETi90=;
        b=PMxOMIGkGEEFYGHdi692Ha0jD3ls7idKX6wmWj8zirGIpSHMZzH7r6MpmuEdiAt7U2
         yF/aPNRwpzGnNnrln08pPaE6mlFTu4TcBLRDhxwSZTjBsQBaq9FIWa7ouff/7l3EKE6E
         R4RmeisGuorCaElBVWvp0BAuzBO2fUoAtgedJKABNX1ORbvZoHa5z/CuWLpnut8/3k3d
         YqiZFPNROKdp6K8b+xqsYGCWPif1uprY12N/UXKxzkhK8VanxAfDZsNgktIEgZxp0mBe
         FmtcDJYTQgesQIdIlYptftnwO5JgXb4/9o6YZggGBXSwNtSOyJ3bfWExNj6nZaqexE4S
         FE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706892496; x=1707497296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqIRLfLzGkEvSBmQJbYiIflgqcbJlUJTWpbIXyETi90=;
        b=cHoncr+DYgxpTbuN1qfijPeKvnnkNojBJHNhSg6vi4RagWC9XCpCGM4VvTZM4PEBuU
         4rDVP4SWvf35XbdDSuXhXuJNf/CEpzAQEFjAMSriydowJawVGCcq3ULkKwN7aAvMEEe8
         Qu0cwW3c4/4ZKDb886AsPfX4HzJDGO+GfN2/4G0DB2qwgAamwUGnupKV0W6mBlcHgAj0
         NVaa8d6uKh9cb3aKZ93iL6KiULzt/nLPkoKbK3+75xM18pjs5vIlrtuypCuoI1rSa11R
         tPEeQfvTjLunbKPIxVYMSF46hC8FVVo6cx6ezwYuxnOFM8DX/GaRYJjRtzbVfwNc/aNp
         7x0w==
X-Gm-Message-State: AOJu0YyXRAlj1Vq+K75g7H2iEXKjZbBZVe7iQGYik52DlqQs8lgrVMPk
	Tpx6Ft8+irsivJrKkiOlqwBJ2v95BJux2JI3TZgtRS1UKpqHwlSK8TQIKcHfAA3Pod0eyFiJlJ6
	gcDNuR/lo0LD2S6ik21m8trTrt89HPYEoWpYu
X-Google-Smtp-Source: AGHT+IEZoUGUPJ/ZrY4qFsoWM/im/x6E8Fhz5YU/9ZvJHc7GpUSZj7wV/izdUeR2yLyxtY782yr1npSu7JhRosrHU+A=
X-Received: by 2002:a05:6102:2338:b0:46c:c290:e617 with SMTP id
 b24-20020a056102233800b0046cc290e617mr5469877vsa.23.1706892495482; Fri, 02
 Feb 2024 08:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com> <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
In-Reply-To: <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 17:47:38 +0100
Message-ID: <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 at 17:35, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Fri, Feb 2, 2024 at 2:00=E2=80=AFPM Marco Elver <elver@google.com> wro=
te:
> >
> > > Maybe we can try something else?
> >
> > That's strange - the patches at [1] definitely revert the change you
> > bisected to. It's possible there is some other strange side-effect. (I
> > assume that you are still running all this with a KASAN kernel.)
>
> Yes. build .config not changed between kernel builds.
>
> > Just so I understand it right:
> > You say before commit cc478e0b6bdffd20561e1a07941a65f6c8962cab the
> > game's FPS were good. But that is strange, because at that point we're
> > already doing stackdepot refcounting, i.e. after commit
> > 773688a6cb24b0b3c2ba40354d883348a2befa38 which you reported as the
> > initial performance regression. The patches at [2] fixed that problem.
> >
> > So now it's unclear to me how the simple change in
> > cc478e0b6bdffd20561e1a07941a65f6c8962cab causes the performance
> > problem, when in fact this is already with KASAN stackdepot
> > refcounting enabled but without the performance fixes from [1] and
> > [2].
> >
> > [2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.c=
om/
> >
> > My questions now would be:
> > - What was the game's FPS in the last stable kernel (v6.7)?
>
> [6.7] - 83 FPS - 13060 frames during benchmark.
>
> > - Can you collect another set of performance profiles between good and
> > bad? Maybe it would show where the time in the kernel is spent.
>
> Yes,
> please look at [aaa2c9a97c22 perf] and [cc478e0b6bdf perf]
>
> > perf diff perf-git-aaa2c9a97c22af5bf011f6dd8e0538219b45af88.data perf-g=
it-cc478e0b6bdffd20561e1a07941a65f6c8962cab.data
> No kallsyms or vmlinux with build-id
> de2a040f828394c5ce34802389239c2a0668fcc7 was found
> No kallsyms or vmlinux with build-id
> 33ab1cd545f96f5ffc2a402a4c4cfa647fd727a0 was found
> # Event 'cycles:P'
> #
> # Baseline  Delta Abs  Shared Object
> Symbol
> # ........  .........  ..............................................
> .........................................................................=
..........................................................................=
................................
> #
>     48.48%    +21.75%  [kernel.kallsyms]
> [k] 0xffffffff860065c0
>     36.13%    -16.49%  ShadowOfTheTombRaider
> [.] 0x00000000001d7f5e
>      4.43%     -2.10%  libvulkan_radeon.so
> [.] 0x000000000006b870
>      3.28%     -0.63%  libcef.so
> [.] 0x00000000021720e0
>      1.11%     -0.53%  libc.so.6
> [.] syscall
>      0.65%     -0.24%  libc.so.6
> [.] __memmove_avx512_unaligned_erms
>      0.31%     -0.14%  libc.so.6
> [.] __memset_avx512_unaligned_erms
>      0.26%     -0.13%  libm.so.6
> [.] __powf_fma
>      0.20%     -0.10%  [amdgpu]
> [k] amdgpu_bo_placement_from_domain
>      0.22%     -0.09%  [amdgpu]
> [k] amdgpu_vram_mgr_compatible
>      0.67%     -0.09%  armada-drm_dri.so
> [.] 0x00000000000192b4
>      0.15%     -0.08%  libc.so.6
> [.] sem_post@GLIBC_2.2.5
>      0.16%     -0.07%  [amdgpu]
> [k] amdgpu_vm_bo_update
>      0.14%     -0.07%  [amdgpu]
> [k] amdgpu_bo_list_entry_cmp
>      0.13%     -0.06%  libm.so.6
> [.] powf@GLIBC_2.2.5
>      0.14%     -0.06%  libMangoHud.so
> [.] 0x000000000001c4c0
>      0.10%     -0.06%  libc.so.6
> [.] __futex_abstimed_wait_common
>      0.19%     -0.05%  libGLESv2.so
> [.] 0x0000000000160a11
>      0.07%     -0.04%  libc.so.6
> [.] __new_sem_wait_slow64.constprop.0
>      0.10%     -0.04%  radeonsi_dri.so
> [.] 0x0000000000019454
>      0.05%     -0.03%  [amdgpu]
> [k] optc1_get_position
>      0.05%     -0.03%  libc.so.6
> [.] sem_wait@@GLIBC_2.34
>      0.22%     -0.02%  [vdso]
> [.] 0x00000000000005a0
>      0.10%     -0.02%  libc.so.6
> [.] __memcmp_evex_movbe
>                +0.02%  [JIT] tid 8383
> [.] 0x00007f2de0052823
>
>
> > - Could it be an inconclusive bisection?
>
> I checked twice:
> [6.7] - 83 FPS
> [aaa2c9a97c22] - 111 FPS
> [cc478e0b6bdf] - 64 FPS
> [6.8-rc2 with patches] - 82 FPS
>
>
> [6.7] https://i.postimg.cc/15yyzZBr/v6-7.png
> [6.7 perf] https://mega.nz/file/QwJ3hbob#RslLFVYgz1SWMcPR3eF9uEpFuqxdgkwX=
SatWts-1wVA
>
> [aaa2c9a97c22] https://i.postimg.cc/Sxv4VYhg/git-aaa2c9a97c22af5bf011f6dd=
8e0538219b45af88.png
> [aaa2c9a97c22 perf]
> https://mega.nz/file/dwQxha4J#2_nBF6uNzY11VX-T-Lr_-60WIMrbl1YEvPgY4CuXqEc
>
> [cc478e0b6bdf] https://i.postimg.cc/W3cQfMfw/git-cc478e0b6bdffd20561e1a07=
941a65f6c8962cab.png
> [cc478e0b6bdf perf]
> https://mega.nz/file/hl5kwLTC#_4Fg1KBXCnQ-8OElY7EYmPOoDG6ZeZYnKFjamWpklWw
>
> [6.8-rc2 with patches] https://i.postimg.cc/26dPpVsR/v6-8-rc2-with-patche=
s.png
> [6.8-rc2 with patches perf]
> https://mega.nz/file/NxgTAb4L#0KO_WU-svpDw60Y3148RZhELPcUtFg3_VCDzJqSyz34

Thanks a lot for these results. There's definitely something strange
going - I'll try to have a detailed look some time next week.

In the meantime, this is clear: there does not seem to be a regression
between 6.7 and 6.8-rc with the patches, which is what I was
expecting. The fact that aaa2c9a97c22 is so much better could indicate
that until cc478e0b6bdf there was either a bug which turned something
into a no-op - or, the memsets() were acting as some kind of
prefetching hint to the CPU, which in turn caused a significant
reduction in cache misses. I think at this point we're not trying to
fix a regression, because we're on par with 6.7, but trying to make
sense of this information to optimize the code properly without luck
(but not sure if feasible). Hrm....

