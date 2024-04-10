Return-Path: <linux-kernel+bounces-138843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE389FB13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D5B1C22482
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2016DEBE;
	Wed, 10 Apr 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QrriqILR"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDF16C877
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761650; cv=none; b=UMLraJ6svv0/fEFqL3N9jDTPeNfAvpiUfcng0/LV16tTtoKFw1g4CzitKF935p/dzv8tzyUSxSUjkcQ+IWJLM+DepnClIA7SBI3ugE4F9QjeWtEUt57zUDop0krjk76iNFhI6vxdFcKnbfyS2AVx/nAn37T2FQIIIDDpHh+kOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761650; c=relaxed/simple;
	bh=efOz0mghq+OtWB/ztjhh0s2fK209rUGcnyU0KFtsXHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwTTV6VUE1pov7G1XzfEFyAy80NHCDhaH2tStpMNg+X3IN6cDuxcLzWgPHg4gXL+v08ApGIisSuuvICiGx2LslZa/1LgtN8xRSCPZxRI+eSkqB2XjmPnzDZ6uUMFbFizO6FvOsxhe6f3DG0Z3I/3LBVeQ1IKGZV/JwHj0Zy8jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrriqILR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6164d7a02d2so74263607b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712761647; x=1713366447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLKjsUom385xmd5NMGWlteZq1y2bkkhohjUJrbv4Shg=;
        b=QrriqILRv/t/1NBZKMrb/NwbcjhQZNw48jSp62Xm6ufvKsbVgD0rEkC3Nfsgld4a7m
         j9G3M4LKvkAygoMZSH7T+E8m5LFM9CftY1N/eYnj7ud/MG1xrIx6dqZCoD186Uj1iSbs
         4lC+H2eZyjgh0PVv5Og7U0iiCfNAInB2JAC6+33ONAG+gVJ8sK+Sek9O643jmQlfgudE
         rbbKQw8jZ1LaFHFKB2GRvlQamrOKzfiT12b8TqLOQb1QzLohvdA/7QUW5vQH3Kpius2n
         ScU2PceLVuvDT/GD/jUh9AQqNUH25M8h7pq8ODws5y8vrPmjPpVE1grdnBMy6il702ah
         QrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761647; x=1713366447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLKjsUom385xmd5NMGWlteZq1y2bkkhohjUJrbv4Shg=;
        b=fhtEPxxkO3kb8L1Yh/5UVEF44OfYejkaRKxgLYssm2K/9DAB4FIgCYwYjRuSRAnmMJ
         a6uH+2xBDbSzYZ/u1Ex9DHL68ILbiNI6R2ymBSflqvFJk0aoFta+3Y0GJh4fZ3xIMazg
         0der2zOBkEn1iNew/IO3jF8B9qfLiUkyAwq1FWuqP4/8ofz3Bee9462cz9oz4t7JBxbD
         KTcV41iKTks2qh/I7Bs7W64PGdJFHNXp5+T1Ho88SkJUknBPY6vp0bbbhxHUVAMZ1eBv
         HAfzZ+7SlzhhnuFoI69QV4te4t8hcjW+MfTPe7TuNGcoCbCC5fhv+LbhBYckcuYfD4eP
         L7sw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ozrd7EGTabb0klowB5dS6wo+CXYm63ZtOtunrwVjk2/uzGpXGGrPRopIEhUxfv92ed9fmnYsyGD6aLS+PPYYgFdq2GjQy/v5iwXp
X-Gm-Message-State: AOJu0Ywtl776/t/ZcbSJO3EZnv5rVn0ctYD9auaLq22PBzvyvqTzMcoP
	xOGTBQ/YG9Z+mC72Am4rNJRjczPmrD8+xfk8dxHn2IQ3JqLBqOrS/6ySbxi7pUbngMPpTo2ivSl
	dZdZjYdrntIR7lpRlsdq5sBK8ZxUz3kld78kF
X-Google-Smtp-Source: AGHT+IF7TCK2LqrJgp8hV7cq9+Ry/b6lOirZ5fldgud6E7mUjNo54gC130kLZJeYihDRzjoyYJ8Lubhyj/db/BZNZCo=
X-Received: by 2002:a05:6902:1b83:b0:dd0:c12:411b with SMTP id
 ei3-20020a0569021b8300b00dd00c12411bmr3692287ybb.8.1712761647378; Wed, 10 Apr
 2024 08:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20211113062222.3743909-1-jay.xu@rock-chips.com>
 <1da5cdf0-ccb8-3740-cf96-794c4d5b2eb4@amd.com> <3175d41a-fc44-4741-91ac-005c8f21abb8@vivo.com>
 <9e6f1f52-db49-43bb-a0c2-b0ad12c28aa1@amd.com> <5c7ac24c-79fa-45fc-a4fd-5b8fc77a741b@vivo.com>
 <CABdmKX1OZ9yT3YQA9e7JzKND9wfiL-hnf87Q6v9pwtnAeLHrdA@mail.gmail.com> <0df41277-ded5-4a42-9df5-864d2b6646f5@amd.com>
In-Reply-To: <0df41277-ded5-4a42-9df5-864d2b6646f5@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Apr 2024 08:07:15 -0700
Message-ID: <CABdmKX03Of7OE_9PfAy5DWcCwwvQvJGXDjzAE8c4WRrz_0Z_eg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: add DMA_BUF_IOCTL_SYNC_PARTIAL support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Rong Qianfeng <11065417@vivo.com>, Rong Qianfeng <rongqianfeng@vivo.com>, 
	Jianqun Xu <jay.xu@rock-chips.com>, sumit.semwal@linaro.org, 
	pekka.paalanen@collabora.com, daniel.vetter@ffwll.ch, jason@jlekstrand.net, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:22=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 09.04.24 um 18:37 schrieb T.J. Mercier:
> > On Tue, Apr 9, 2024 at 12:34=E2=80=AFAM Rong Qianfeng <11065417@vivo.co=
m> wrote:
> >>
> >> =E5=9C=A8 2024/4/8 15:58, Christian K=C3=B6nig =E5=86=99=E9=81=93:
> >>> Am 07.04.24 um 09:50 schrieb Rong Qianfeng:
> >>>> [SNIP]
> >>>>> Am 13.11.21 um 07:22 schrieb Jianqun Xu:
> >>>>>> Add DMA_BUF_IOCTL_SYNC_PARTIAL support for user to sync dma-buf wi=
th
> >>>>>> offset and len.
> >>>>> You have not given an use case for this so it is a bit hard to
> >>>>> review. And from the existing use cases I don't see why this should
> >>>>> be necessary.
> >>>>>
> >>>>> Even worse from the existing backend implementation I don't even se=
e
> >>>>> how drivers should be able to fulfill this semantics.
> >>>>>
> >>>>> Please explain further,
> >>>>> Christian.
> >>>> Here is a practical case:
> >>>> The user space can allocate a large chunk of dma-buf for
> >>>> self-management, used as a shared memory pool.
> >>>> Small dma-buf can be allocated from this shared memory pool and
> >>>> released back to it after use, thus improving the speed of dma-buf
> >>>> allocation and release.
> >>>> Additionally, custom functionalities such as memory statistics and
> >>>> boundary checking can be implemented in the user space.
> >>>> Of course, the above-mentioned functionalities require the
> >>>> implementation of a partial cache sync interface.
> >>> Well that is obvious, but where is the code doing that?
> >>>
> >>> You can't send out code without an actual user of it. That will
> >>> obviously be rejected.
> >>>
> >>> Regards,
> >>> Christian.
> >> In fact, we have already used the user-level dma-buf memory pool in th=
e
> >> camera shooting scenario on the phone.
> >>
> >>   From the test results, The execution time of the photo shooting
> >> algorithm has been reduced from 3.8s to 3s.
> >>
> > For phones, the (out of tree) Android version of the system heap has a
> > page pool connected to a shrinker.
>
> Well, it should be obvious but I'm going to repeat it here: Submitting
> kernel patches for our of tree code is a rather *extreme* no-go.
>
Sorry I think my comment led to some confusion. I wasn't suggesting
you should take the patch; it's clearly incomplete. I was pointing out
another option to Rong. It appears Rong is creating a single oversized
dma-buf, and subdividing it in userspace to avoid multiple allocations
for multiple buffers. That would lead to a need for a partial sync of
the buffer from userspace. Instead of that, using a heap with a page
pool gets you kind of the same thing with a lot less headache in
userspace, and no need for partial sync. So I wanted to share that
option, and that can go in just Android if necessary without this
patch.

> That in kernel code *must* have an in kernel user is a number one rule.
>
> When somebody violates this rule he pretty much disqualifying himself as
> reliable source of patches since maintainers then have to assume that
> this person tries to submit code which doesn't have a justification to
> be upstream.
>
> So while this actually looks useful from the technical side as long as
> nobody does an implementation based on an upstream driver I absolutely
> have to reject it from the organizational side.
>
> Regards,
> Christian.
>
> >   That allows you to skip page
> > allocation without fully pinning the memory like you get when
> > allocating a dma-buf that's way larger than necessary. If it's for a
> > camera maybe you need physically contiguous memory, but it's also
> > possible to set that up.
> >
> > https://android.googlesource.com/kernel/common/+/refs/heads/android14-6=
1/drivers/dma-buf/heaps/system_heap.c#377
> >
> >
> >> To be honest, I didn't understand your concern "...how drivers should =
be
> >> able to fulfill this semantics." Can you please help explain it in mor=
e
> >> detail?
> >>
> >> Thanks,
> >>
> >> Rong Qianfeng.
> >>
> >>>> Thanks
> >>>> Rong Qianfeng.
>

