Return-Path: <linux-kernel+bounces-50150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278C8474F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC97D29188A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3F1474BD;
	Fri,  2 Feb 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/+VXkQL"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B07148FF7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891719; cv=none; b=Sx5urjzBfqwb2EP/9LDtlpO+piGCD8vNLoHaIQAWRB6wYusPPD1GiABraYpfCiyoHmSUnE8XeXMRTwJlybj3NdbT5oJ9bdlSNtzwT0qOokXMO21BxM0pbol8ocvafHtPMXBgx/QQ7y2LmEnopHQ4vOoNRkmMzy0m3Q7Ez1sTijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891719; c=relaxed/simple;
	bh=kwpElfF3ofIfsAZmHuoQRAHBjk2EW3k5g726E+VJsDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIc/jGcGpIV94lgtI7eIXf9DnRjhUIEm9SM8IPZrrf92dx/IyS6nazjkIKEDsbUzZD2J9veknA+j6DbeuS0KevPCnsgrubscdc1gxh/vqXY7Eah6qDPHIsOSZUeh3B26JdoOg8L/0SVKcTOkM8DOUFBZUzinf99eE7ntXWLPyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/+VXkQL; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59584f41f1eso683572eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706891716; x=1707496516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1b7WFP4fLnEs1xL56WMoxp/TFOgr4QRcoCxeMPjVlo=;
        b=K/+VXkQLr8mNda3V4NtFBmXRbs5nH83HRO9Nz5Iv2Sej5I4n9wae0bYbALcDd55xgH
         JN3WTDa2lMeMld+ip2UAawVQobEy2aGpcrOV0yUrgn7ni86X1sgjNqHnex5DwBsndxr5
         v6gJ8es23/fB8rdWhIc3GuaCwYZARs3jsupMttDecsXJUxcx6TqxwD/GYe+9uvA1/gVG
         Dx30BhJwhjkT/zANW/j4vfBip4R9qbsTHcp3NoBWG9FcNPw4CSEci0p3FA9cvjMs2vtK
         erlxsebM46gd/K9LLNwfu0YKn9fICTV1U0vj5t7aRN2/wz5BnldvDW1R8DOsKKnlOOik
         kHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891716; x=1707496516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1b7WFP4fLnEs1xL56WMoxp/TFOgr4QRcoCxeMPjVlo=;
        b=PSw49RW92y1BriEbhsyWHHksQBIoakQiVoAC9csC0/Z7JBLvf75UsVxav/GoJatFAC
         Gd4UL3Yjq1DsNkRP/OqRNuBjTCif7kT/d9zCVi5nHwhBATA7QXkWKrVpqSu2R9ceWjri
         K3y7iBHwzQAvcvs7Zi/0ZWPc3pBvXcUvSPAfuJ34TI/w/SIbHjlV173WFaGxsMWYiQte
         zD6Ehx6FZDqLmA6wGlPmlwcD7hTZ199lNjOAdNvRaD/Jz2/Ahwc0elx8MHU/QM4a2pMW
         +QmvBnioW9yWLBtbzU5kRAdq8qvBTcvxuoD/zGNrIFFccmwCSU/PswHe2p1d6VTa+epR
         X7ag==
X-Forwarded-Encrypted: i=0; AJvYcCUGDTEBm4yhOzFtnk1UNxSEjYXz2kD1hPCNbRxkc4ry+glZ9LRc1UOM1tUjV1opynsh9fpovOS1sonYKdSmQwpPs1OD8gnv0y4Lwoqw
X-Gm-Message-State: AOJu0YygqZG5/7Ca9lRXDG1KNYjSrKmyOGFpxsST1/uMxzNZxuUawIPj
	XbjGH5cHsD5ZAfSapoZXNc9Tl84KgFNI4E2v7Hx2StTikUged1TtmDD0g208gw2AKkqtztoMQTi
	BBHHmdpXNiTfgospr1K1Bv7wgSps=
X-Google-Smtp-Source: AGHT+IErnTQmqrpMqoIYTqabnL481xBFUNOvS9QOYdaktWUqC2PEVKx1ai1Cf+/xhKYohW6eUcfmFUF8BtDo2ZNL9hg=
X-Received: by 2002:a05:6820:2224:b0:59a:127c:bdfe with SMTP id
 cj36-20020a056820222400b0059a127cbdfemr7159032oob.1.1706891716497; Fri, 02
 Feb 2024 08:35:16 -0800 (PST)
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
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com> <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
In-Reply-To: <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 2 Feb 2024 21:35:05 +0500
Message-ID: <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:00=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> > Maybe we can try something else?
>
> That's strange - the patches at [1] definitely revert the change you
> bisected to. It's possible there is some other strange side-effect. (I
> assume that you are still running all this with a KASAN kernel.)

Yes. build .config not changed between kernel builds.

> Just so I understand it right:
> You say before commit cc478e0b6bdffd20561e1a07941a65f6c8962cab the
> game's FPS were good. But that is strange, because at that point we're
> already doing stackdepot refcounting, i.e. after commit
> 773688a6cb24b0b3c2ba40354d883348a2befa38 which you reported as the
> initial performance regression. The patches at [2] fixed that problem.
>
> So now it's unclear to me how the simple change in
> cc478e0b6bdffd20561e1a07941a65f6c8962cab causes the performance
> problem, when in fact this is already with KASAN stackdepot
> refcounting enabled but without the performance fixes from [1] and
> [2].
>
> [2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com=
/
>
> My questions now would be:
> - What was the game's FPS in the last stable kernel (v6.7)?

[6.7] - 83 FPS - 13060 frames during benchmark.

> - Can you collect another set of performance profiles between good and
> bad? Maybe it would show where the time in the kernel is spent.

Yes,
please look at [aaa2c9a97c22 perf] and [cc478e0b6bdf perf]

> perf diff perf-git-aaa2c9a97c22af5bf011f6dd8e0538219b45af88.data perf-git=
-cc478e0b6bdffd20561e1a07941a65f6c8962cab.data
No kallsyms or vmlinux with build-id
de2a040f828394c5ce34802389239c2a0668fcc7 was found
No kallsyms or vmlinux with build-id
33ab1cd545f96f5ffc2a402a4c4cfa647fd727a0 was found
# Event 'cycles:P'
#
# Baseline  Delta Abs  Shared Object
Symbol
# ........  .........  ..............................................
..........................................................................=
..........................................................................=
..............................
#
    48.48%    +21.75%  [kernel.kallsyms]
[k] 0xffffffff860065c0
    36.13%    -16.49%  ShadowOfTheTombRaider
[.] 0x00000000001d7f5e
     4.43%     -2.10%  libvulkan_radeon.so
[.] 0x000000000006b870
     3.28%     -0.63%  libcef.so
[.] 0x00000000021720e0
     1.11%     -0.53%  libc.so.6
[.] syscall
     0.65%     -0.24%  libc.so.6
[.] __memmove_avx512_unaligned_erms
     0.31%     -0.14%  libc.so.6
[.] __memset_avx512_unaligned_erms
     0.26%     -0.13%  libm.so.6
[.] __powf_fma
     0.20%     -0.10%  [amdgpu]
[k] amdgpu_bo_placement_from_domain
     0.22%     -0.09%  [amdgpu]
[k] amdgpu_vram_mgr_compatible
     0.67%     -0.09%  armada-drm_dri.so
[.] 0x00000000000192b4
     0.15%     -0.08%  libc.so.6
[.] sem_post@GLIBC_2.2.5
     0.16%     -0.07%  [amdgpu]
[k] amdgpu_vm_bo_update
     0.14%     -0.07%  [amdgpu]
[k] amdgpu_bo_list_entry_cmp
     0.13%     -0.06%  libm.so.6
[.] powf@GLIBC_2.2.5
     0.14%     -0.06%  libMangoHud.so
[.] 0x000000000001c4c0
     0.10%     -0.06%  libc.so.6
[.] __futex_abstimed_wait_common
     0.19%     -0.05%  libGLESv2.so
[.] 0x0000000000160a11
     0.07%     -0.04%  libc.so.6
[.] __new_sem_wait_slow64.constprop.0
     0.10%     -0.04%  radeonsi_dri.so
[.] 0x0000000000019454
     0.05%     -0.03%  [amdgpu]
[k] optc1_get_position
     0.05%     -0.03%  libc.so.6
[.] sem_wait@@GLIBC_2.34
     0.22%     -0.02%  [vdso]
[.] 0x00000000000005a0
     0.10%     -0.02%  libc.so.6
[.] __memcmp_evex_movbe
               +0.02%  [JIT] tid 8383
[.] 0x00007f2de0052823


> - Could it be an inconclusive bisection?

I checked twice:
[6.7] - 83 FPS
[aaa2c9a97c22] - 111 FPS
[cc478e0b6bdf] - 64 FPS
[6.8-rc2 with patches] - 82 FPS


[6.7] https://i.postimg.cc/15yyzZBr/v6-7.png
[6.7 perf] https://mega.nz/file/QwJ3hbob#RslLFVYgz1SWMcPR3eF9uEpFuqxdgkwXSa=
tWts-1wVA

[aaa2c9a97c22] https://i.postimg.cc/Sxv4VYhg/git-aaa2c9a97c22af5bf011f6dd8e=
0538219b45af88.png
[aaa2c9a97c22 perf]
https://mega.nz/file/dwQxha4J#2_nBF6uNzY11VX-T-Lr_-60WIMrbl1YEvPgY4CuXqEc

[cc478e0b6bdf] https://i.postimg.cc/W3cQfMfw/git-cc478e0b6bdffd20561e1a0794=
1a65f6c8962cab.png
[cc478e0b6bdf perf]
https://mega.nz/file/hl5kwLTC#_4Fg1KBXCnQ-8OElY7EYmPOoDG6ZeZYnKFjamWpklWw

[6.8-rc2 with patches] https://i.postimg.cc/26dPpVsR/v6-8-rc2-with-patches.=
png
[6.8-rc2 with patches perf]
https://mega.nz/file/NxgTAb4L#0KO_WU-svpDw60Y3148RZhELPcUtFg3_VCDzJqSyz34

--=20
Best Regards,
Mike Gavrilov.

