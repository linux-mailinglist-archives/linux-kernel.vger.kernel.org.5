Return-Path: <linux-kernel+bounces-142629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7B8A2E07
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD78283E01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D975676A;
	Fri, 12 Apr 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIVLGs8H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB356457
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924117; cv=none; b=Qm+K83cQZ7og8TTycDTmTKtQYrGD5MUD3LtZ0772WZBclfoOOcL8whFGH9X0NZkAuNmuRVNcewcKhT9Up9dLyMUWhzzOwMu//yLek7G2SmQR5YfyN8o1/weTy+kA7bZZJbCcn+Si9FkebrrebJCzGIlMkFsGo8AIMcz+BXJPkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924117; c=relaxed/simple;
	bh=jMgsflWuaYWNYa9dlh0cqvvdrhZy9tcBnp+Jx8l3B5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwvQLZn1ktkWDSFC9ylDa3CtdaG9BA6UXzeejzbQwEVN7HtI9s/9HpApuXuVtZNXgr/Psg4RiqGNr2AdDLhjmf1/hC1A9ljlnd/0eE1n6ez5+QrGe4Hk6H/FiesA00EUz3Vh1ad3mbs8fSPWdGZdfZbZEyFJuXGjstzNSg3raSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIVLGs8H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712924113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kbg/AnMCE3YNGZKUUT6bVQZJO+XQvmdhDaWbX3/3Wzc=;
	b=WIVLGs8Hw0HDya4Ua+1GWTJbf6IxEG45+jDaf+PAg5SppvjYTPp2N8UxyQbqhPRpofcICr
	F64/NIZ2Q8TmKBYUO0+abw6+mHxu85BPN9ZqLabXGRe6cGI0/hqcKbkDf72+qT+2qXiYz6
	iM5XQJgxCxLZZ4vLxJmTY2GRLCvkm5I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-K5zCabm_NN-nn0fVnt07oA-1; Fri, 12 Apr 2024 08:15:12 -0400
X-MC-Unique: K5zCabm_NN-nn0fVnt07oA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343f1064acaso439036f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712924111; x=1713528911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbg/AnMCE3YNGZKUUT6bVQZJO+XQvmdhDaWbX3/3Wzc=;
        b=wTXuQNZdErd12eyLtx25VhCUNk6moVOBG6TNYIq+8vQiLNsYesK33/N0SzkbNZxZ9f
         2jxn2ZW1aexr3ovqq9SPwdpQY+LTU79v+RQac2lY+7ThxFmr2R79ynbuKkQMZl5VO3Ea
         X7uwemLtbpyjgpNOXUxt/2mvgG2kxtH895pJZbYCPUWfbxJZYW4VBtyMUY3dJ+oPfU93
         205qVGrWO+GCUm3AvSE5qMOfhuOPZNkPAgUCtzK6hAyTf5LT600rJKjDHK7b5m4F3vBf
         Yj1uJJlgdORULveCBu06nWIhe79pw1Uwmt5Nn9PAegMPTyhEn2Az5Q6aRZDlY1cFdqn0
         lCZw==
X-Forwarded-Encrypted: i=1; AJvYcCVIqI+neU0Iu/brXjkOn+n8b4EpARh8wrz5yWkWUlHPGk+hJjsrn+obDzrA2+B2RycRsjPeaZOmfAUtJeGlCCA1th/FggTBtGmaDu+l
X-Gm-Message-State: AOJu0YzDVPBR6Cf9UqSFzIhRAs4ShyF8b2lZcnOTsrZBrvLjDPDgQFiu
	JDYH5dtjWcM6RQ22NhVrBEx8wPW4FqsbZwdtG4YAvShN5EJvzVDJ2qDcnnS45t6Dbxh6hkhtrcd
	f+QpX+d5K5B4i/A36NF1/HBH0IEM0OaM2egh9mt37kiDrjC6ajYN9WCiS+l5r8vaivSdwpO3w+G
	ye8pfEKkT/W3EfEN0E0/lSh6dFvLvdjyw8HFu8
X-Received: by 2002:adf:f984:0:b0:343:90be:f8b5 with SMTP id f4-20020adff984000000b0034390bef8b5mr1811577wrr.36.1712924111095;
        Fri, 12 Apr 2024 05:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0f/Lal1JjP9dKNlIEcj9MMuXsHp5r8ZbKIS/SX6F6aPygKHGgkqTo1ZIYnBysCL3cQkaQ5/QML9YKp4gg4WQ=
X-Received: by 2002:adf:f984:0:b0:343:90be:f8b5 with SMTP id
 f4-20020adff984000000b0034390bef8b5mr1811562wrr.36.1712924110759; Fri, 12 Apr
 2024 05:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133407.3364cda3@canb.auug.org.au> <20240412133516.0286f480@canb.auug.org.au>
In-Reply-To: <20240412133516.0286f480@canb.auug.org.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 14:14:59 +0200
Message-ID: <CABgObfb0Sm8z8u2269+oiR57fxAgh74JURDRrEebhFAaPNKqGA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kvm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:35=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
> On Fri, 12 Apr 2024 13:34:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the kvm tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > kernel/events/uprobes.c: In function '__replace_page':
> > kernel/events/uprobes.c:160:35: error: storage size of 'range' isn't kn=
own
> >   160 |         struct mmu_notifier_range range;
> >       |                                   ^~~~~
> > kernel/events/uprobes.c:162:9: error: implicit declaration of function =
'mmu_notifier_range_init' [-Werror=3Dimplicit-function-declaration]
> >   162 |         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm=
, addr,
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~
> > kernel/events/uprobes.c:162:41: error: 'MMU_NOTIFY_CLEAR' undeclared (f=
irst use in this function)
> >   162 |         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm=
, addr,
> >       |                                         ^~~~~~~~~~~~~~~~
> > kernel/events/uprobes.c:162:41: note: each undeclared identifier is rep=
orted only once for each function it appears in
> > kernel/events/uprobes.c:175:9: error: implicit declaration of function =
'mmu_notifier_invalidate_range_start' [-Werror=3Dimplicit-function-declarat=
ion]
> >   175 |         mmu_notifier_invalidate_range_start(&range);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > kernel/events/uprobes.c:208:9: error: implicit declaration of function =
'mmu_notifier_invalidate_range_end' [-Werror=3Dimplicit-function-declaratio=
n]
> >   208 |         mmu_notifier_invalidate_range_end(&range);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > kernel/events/uprobes.c:160:35: warning: unused variable 'range' [-Wunu=
sed-variable]
> >   160 |         struct mmu_notifier_range range;
> >       |                                   ^~~~~
> > cc1: some warnings being treated as errors
> >
> > Caused by commit
> >
> >   b06d4c260e93 ("mm: replace set_pte_at_notify() with just set_pte_at()=
")
> >
> > I have applied the following patial revert for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 12 Apr 2024 13:27:20 +1000
> Subject: [PATCH] fix up for "mm: replace set_pte_at_notify() with just
>  set_pte_at()"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  kernel/events/uprobes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index f4523b95c945..1215bc299390 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -18,6 +18,7 @@
>  #include <linux/sched/coredump.h>
>  #include <linux/export.h>
>  #include <linux/rmap.h>                /* anon_vma_prepare */
> +#include <linux/mmu_notifier.h>
>  #include <linux/swap.h>                /* folio_free_swap */
>  #include <linux/ptrace.h>      /* user_enable_single_step */
>  #include <linux/kdebug.h>      /* notifier mechanism */
> --
> 2.43.0

Fixed, thanks and sorry for messing up.

Paolo


