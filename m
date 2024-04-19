Return-Path: <linux-kernel+bounces-151782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDA8AB3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6443B1C21B35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01698137758;
	Fri, 19 Apr 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HQt67EbJ"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E4628F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545670; cv=none; b=oZNTISq4dza++ATl3ln56TPYNum2z0ArssUGeL0Ls0o7GJkXsH6Dpzv4cV1EaEOqFCDK1Lffp4MkGF87+5dEq1pZydCkiCiHtRTzql3wPzXy1ex+sXf1NejrAu664MUUpVw2TDbVzMGVk6siDtf05XNF1mxPdJeGVrVIsLNUin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545670; c=relaxed/simple;
	bh=cs19R5imxIssTUZwvDAlU65GuO6RH+OUen1wZDTPe04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJLxLr6k2BAte3YVoglY8EEaD5zcSlBYrNAdchI4A0Cj6owlk4QS3jQ1UoEplk8KwbWd8fgFrxIxVe52RgZr4y7O4LNBkqn2kkjsm+7WYtsR9iejb+VRjYZJIltmTx0Qu7nfEAwfjDqbSpxCe3b3wAHlBzbVgJzxMgquNPghK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQt67EbJ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de45f3f092bso2776693276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713545667; x=1714150467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBpoOyRi1gACy8UrMdPa5IxAxynbsn8XkxmG646b1Bc=;
        b=HQt67EbJpJ0KDwbNxpmqP5kfTTr3BfHBLipGDnvhvQi62bh4iz1tqCdE5SsAgIBcR6
         zf2SYs5262G6VvXj4q2NUUhjvIFfAjV/uKd1wFL1vVzfNb/WnyqS/eDlYFCDO7UQWLK7
         yXNKfWalqH09p0vWavwdBaBXdviX9nRvG0cQDKz7u0vjTveERQUPtfy6PmaM53uYNR5P
         qevW9SVZU6iCGgNlOjMV+Avj59hHyEp/FLUT4AckctUcUrfh8MERaZP3zxymuptSCBUZ
         ELHAt3vsoB6Sflk/F2Ddx2LLOL7xl9C5N/2S6d6ffZZfPk5vlMIHMATtfa4lO938OUfy
         kp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545667; x=1714150467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBpoOyRi1gACy8UrMdPa5IxAxynbsn8XkxmG646b1Bc=;
        b=lAwqkl2XTyZYdaVlSIGpV0tJRQ+DvmXDz27LjYXeryrS9kvZU5o/TjXR0WJ18CkI0O
         N4YINWm6cUCKnF3YMaq5Dn6ao0O8RxwEvBnIvkurlUnUc9W66xqri/ocWqVjx3BNwxNQ
         iN1ow+gJ8N3RIrVXwlnH40aD6Yn7lEj7xmfxbfC1pAQB1RpyZ8Z3LLi54bfvSmcobX10
         RElaZSjmo3XSCaRNLkAGfgYZo9D5jWpByMerNO+hGEvbhC1rQYRo5M3JiyOi1XK1Lcrr
         UVGqJUa1Yml3VcLbGjYjtARzYn2IDR7o9utEkoLvLdtSxgpw2YkYBjjAfEzadwUl5Gmm
         GIPA==
X-Forwarded-Encrypted: i=1; AJvYcCXr5oHKpwxzLP81/3Fa7XWNXMwy/5ZaY73JVBNiUGzGUjYY+QFfuUOgpEuGBx4lVIVQ01EovDuCRYSIhSRHK063+VX0Ye6GB/oZ15CH
X-Gm-Message-State: AOJu0YwIBOpY1MNlw2tr4P6r6sKNfh0en7Z9/wn2PnqWILNIC0wsYIjj
	H9bfyUXQQeGIGlNU/QnxhfurnrMiwGMMahYR0YY4Yf86Dm7wQ80Gya4qQ0f+fsX3RrTlQbwky/t
	vkXibjUJUtmfqz+5zyDHjUJhrdH8Z10Q5JW2/
X-Google-Smtp-Source: AGHT+IFeGdiIWY6aOqpTE9Q8KjfPAJjPwyLn2RAn+sOxC4h2XiQHg/rVuol4OCtdU/LH0LByBkWiRetj/4daQ0VyqHM=
X-Received: by 2002:a05:6902:218f:b0:dc6:aebb:168e with SMTP id
 dl15-20020a056902218f00b00dc6aebb168emr3117818ybb.26.1713545667251; Fri, 19
 Apr 2024 09:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
 <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
 <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com>
 <CAJuCfpEM0b-_gCbMqcUVvKedqXsSE4di7oqzeQGofVNsHRAqCg@mail.gmail.com> <CABi2SkVk-9gQXtWKWs-1pf=Jnm=hNC04-z7qS95sJeCVrEra1Q@mail.gmail.com>
In-Reply-To: <CABi2SkVk-9gQXtWKWs-1pf=Jnm=hNC04-z7qS95sJeCVrEra1Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Apr 2024 16:54:13 +0000
Message-ID: <CAJuCfpE7_4B2v1Fw+6RHWJwM99+pgOPT80ntRSW-1nSTbDxPyg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:15=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Fri, Apr 19, 2024 at 7:57=E2=80=AFAM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Thu, Apr 18, 2024 at 6:22=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
> > >
> > > On Thu, Apr 18, 2024 at 1:19=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Apr 16, 2024 at 12:40=E2=80=AFPM Jeff Xu <jeffxu@chromium.o=
rg> wrote:
> > > > >
> > > > > On Tue, Apr 16, 2024 at 8:13=E2=80=AFAM Liam R. Howlett <Liam.How=
lett@oracle.com> wrote:
> > > > > >
> > > > > > * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > >
> > > > > > > This is V10 version, it rebases v9 patch to 6.9.rc3.
> > > > > > > We also applied and tested mseal() in chrome and chromebook.
> > > > > > >
> > > > > > > -------------------------------------------------------------=
-----
> > > > > > ...
> > > > > >
> > > > > > > MM perf benchmarks
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > This patch adds a loop in the mprotect/munmap/madvise(DONTNEE=
D) to
> > > > > > > check the VMAs=E2=80=99 sealing flag, so that no partial upda=
te can be made,
> > > > > > > when any segment within the given memory range is sealed.
> > > > > > >
> > > > > > > To measure the performance impact of this loop, two tests are=
 developed.
> > > > > > > [8]
> > > > > > >
> > > > > > > The first is measuring the time taken for a particular system=
 call,
> > > > > > > by using clock_gettime(CLOCK_MONOTONIC). The second is using
> > > > > > > PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests=
 have
> > > > > > > similar results.
> > > > > > >
> > > > > > > The tests have roughly below sequence:
> > > > > > > for (i =3D 0; i < 1000, i++)
> > > > > > >     create 1000 mappings (1 page per VMA)
> > > > > > >     start the sampling
> > > > > > >     for (j =3D 0; j < 1000, j++)
> > > > > > >         mprotect one mapping
> > > > > > >     stop and save the sample
> > > > > > >     delete 1000 mappings
> > > > > > > calculates all samples.
> > > > > >
> > > > > >
> > > > > > Thank you for doing this performance testing.
> > > > > >
> > > > > > >
> > > > > > > Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ =
2.00GHz,
> > > > > > > 4G memory, Chromebook.
> > > > > > >
> > > > > > > Based on the latest upstream code:
> > > > > > > The first test (measuring time)
> > > > > > > syscall__     vmas    t       t_mseal delta_ns        per_vma=
 %
> > > > > > > munmap__      1       909     944     35      35      104%
> > > > > > > munmap__      2       1398    1502    104     52      107%
> > > > > > > munmap__      4       2444    2594    149     37      106%
> > > > > > > munmap__      8       4029    4323    293     37      107%
> > > > > > > munmap__      16      6647    6935    288     18      104%
> > > > > > > munmap__      32      11811   12398   587     18      105%
> > > > > > > mprotect      1       439     465     26      26      106%
> > > > > > > mprotect      2       1659    1745    86      43      105%
> > > > > > > mprotect      4       3747    3889    142     36      104%
> > > > > > > mprotect      8       6755    6969    215     27      103%
> > > > > > > mprotect      16      13748   14144   396     25      103%
> > > > > > > mprotect      32      27827   28969   1142    36      104%
> > > > > > > madvise_      1       240     262     22      22      109%
> > > > > > > madvise_      2       366     442     76      38      121%
> > > > > > > madvise_      4       623     751     128     32      121%
> > > > > > > madvise_      8       1110    1324    215     27      119%
> > > > > > > madvise_      16      2127    2451    324     20      115%
> > > > > > > madvise_      32      4109    4642    534     17      113%
> > > > > > >
> > > > > > > The second test (measuring cpu cycle)
> > > > > > > syscall__     vmas    cpu     cmseal  delta_cpu       per_vma=
 %
> > > > > > > munmap__      1       1790    1890    100     100     106%
> > > > > > > munmap__      2       2819    3033    214     107     108%
> > > > > > > munmap__      4       4959    5271    312     78      106%
> > > > > > > munmap__      8       8262    8745    483     60      106%
> > > > > > > munmap__      16      13099   14116   1017    64      108%
> > > > > > > munmap__      32      23221   24785   1565    49      107%
> > > > > > > mprotect      1       906     967     62      62      107%
> > > > > > > mprotect      2       3019    3203    184     92      106%
> > > > > > > mprotect      4       6149    6569    420     105     107%
> > > > > > > mprotect      8       9978    10524   545     68      105%
> > > > > > > mprotect      16      20448   21427   979     61      105%
> > > > > > > mprotect      32      40972   42935   1963    61      105%
> > > > > > > madvise_      1       434     497     63      63      115%
> > > > > > > madvise_      2       752     899     147     74      120%
> > > > > > > madvise_      4       1313    1513    200     50      115%
> > > > > > > madvise_      8       2271    2627    356     44      116%
> > > > > > > madvise_      16      4312    4883    571     36      113%
> > > > > > > madvise_      32      8376    9319    943     29      111%
> > > > > > >
> > > > > >
> > > > > > If I am reading this right, madvise() is affected more than the=
 other
> > > > > > calls?  Is that expected or do we need to have a closer look?
> > > > > >
> > > > > The madvise() has a bigger percentage (per_vma %), but it also ha=
s a
> > > > > smaller base value (cpu).
> > > >
> > > > Sorry, it's unclear to me what the "vmas" column denotes. Is that h=
ow
> > > > many VMAs were created before timing the syscall? If so, then 32 is
> > > > the max that you show here while you seem to have tested with 1000
> > > > VMAs. What is the overhead with 1000 VMAs?
> > >
> > > The vmas column is the number of VMA used in one call.
> > >
> > > For example: for 32 and mprotect(ptr,size), the memory range used in
> > > mprotect has 32 VMAs.
> >
> > Ok, so the 32 here denotes how many VMAs one mprotect() call spans?
> >
> Yes.
>
> > >
> > > It also matters how many memory ranges are in-use at the time of the
> > > test, This is where 1000 comes in. The test creates 1000 memory
> > > ranges, each memory range has 32 vmas, then calls mprotect on the 100=
0
> > > memory range. (the pseudocode was included in the original email)
> >
> > So, if each range has 32 vmas and you have 1000 ranges then you are
> > creating 32000 vmas? Sorry, your pseudocode does not clarify that. My
> > current understanding is this:
> >
> > for (i =3D 0; i < 1000, i++)
> >     mmap N*1000 areas (N=3D[1-32])
> >     start the sampling
> >     for (j =3D 0; j < 1000, j++)
> >         mprotect N areas with one syscall
> >     stop and save the sample
> >     munmap N*1000 areas
> > calculates all samples.
> >
> > Is that correct?
> >
> Yes, There will be 32000 VMA in the system.
>
> The pseudocode is correct in concept.
> The test implementation is slightly different, it uses mprotect to
> split the memory and make sure the VMAs  doesn't merge. For detail,
> the reference [8]  of the original email link to the test code.

Ok, thanks for clarifications. I don't think the overhead is high
enough to worry about.
Thanks,
Suren.


>
> -Jeff

