Return-Path: <linux-kernel+bounces-74124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB885D039
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210021F25C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486C39FEF;
	Wed, 21 Feb 2024 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KROK9+QF"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711339FC3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495542; cv=none; b=Budpcb0CwCKrkTWqeGufW3rF9/+NT5TJxvAZ3WpOmOFs4hDnB1XJscKgl+1zBg8H1SWDuUbsZuK4kNCHeTVZsn8pXzrsyUA7dxuazM5b0D5ymvbGFlbm2o1EHfKgfrY2j3y2M7rjKQODPOI4KUoXSpHqUBUJRqBtrpU1h2y3a+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495542; c=relaxed/simple;
	bh=qxqD9OboNB5MJTngrlpVRY1GfPED4n6/ANjl2SqXUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofSa3XF8MOvDfEFw0TdozNN8Up/KR4uj2VbgxcRJo6zZRSyZe33zWIYET8LhHoLxoa3PHnXw3nH8wYVosoR4M5F1ch8Nb1Hm4z46F/ccW16ZDHmIstHDNMf+o6zi0VyZ55cJccY+KfnfEvJP9uftwDA8GOr0HHcDYCpBCJZP4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KROK9+QF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d228a132acso53621571fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708495539; x=1709100339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2Z3YPpifLO+v9LYFEzmiWXk2FbpYOnhII5xRfQ0SCw=;
        b=KROK9+QFr4w5Io8O+CQpjEiciECzpxBRVhsy9F9kyMzZunp/2NghN8c0MlQZR99kwM
         1iJDrwz3BbrklF26mY+1pGE5a74q2A4tlpaYp6EUieF67ztzcPWsIZ0H5AWhv+Eij3h3
         uHrAmkZaweklwySkRyEm/lgkQKHYXkChSVWAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708495539; x=1709100339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2Z3YPpifLO+v9LYFEzmiWXk2FbpYOnhII5xRfQ0SCw=;
        b=CYFMyL0bDkoujFU6annp98zsAonCM/KuUFLndI90P/nakSYRY/bZbBRoW0/XC5lxGh
         EfJNlV61u6sTaEIiT18bboJLUItN3q9XZ59ms3d7GNw/6u0WNvslS8r0J7+BaE+vc8Fe
         yN1qzDO50yf7cGzSNDTsmQmPk2dpAe1NJxFRXLCtYWJYv0phBAcXr8LCYMd8FdHOkXNa
         z6WViFbfGZ1GOtyiKJB8ckT9SYwX3+m5mU5T9KizES9uYfW1myR5thXXHvqp2xeQeQpB
         CzbL9n02nKR5HjjaMuJS//wOVZlEhYBdu5pWcxv5ZoY+eUAYMxIEsqUqdCUhJj7Sevr3
         JXYg==
X-Forwarded-Encrypted: i=1; AJvYcCXVV9Etfvayi0Zj3PQ03z0wbTCpk5Gg5k6KRroq7wLvUjT6p9ZzMN+VEa/EVdE1ncP9dSacMJ6zWNprQnxudh2KTX6gcZMn9QPi/7Sq
X-Gm-Message-State: AOJu0Yz1q+KbgCDx8pnMgIKDLdJszL/XmQi/TvHRxGx4AHuyL3Fa8/pW
	GV7TwXoTOayAUCpPvb0ibbanvifrDAx7YoFm/HNV07h1uBszKr9nBvDGwGMTA5qwz2doeDfAoHU
	K+0yojxiBC5lg1DiQk/CPvnFwkCelL7Rx9hwQ
X-Google-Smtp-Source: AGHT+IHpzKQIyntrxNuQosyoWuA3YfqQc5Z/nsxyG5p3QePuUaVL24CuxlJrIlatb6/JHiziUwnqV6yOeBe5ljVDn0o=
X-Received: by 2002:a2e:9bd0:0:b0:2d2:3c9b:ab70 with SMTP id
 w16-20020a2e9bd0000000b002d23c9bab70mr4256464ljj.21.1708495539115; Tue, 20
 Feb 2024 22:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <CAD=HUj5733eL9momi=V53njm85BQv_QkVrX92xReiq0_9JhqxQ@mail.gmail.com>
 <ZUEPn_nIoE-gLspp@google.com> <CAD=HUj5g9BoziHT5SbbZ1oFKv75UuXoo32x8DC3TYgLGZ6G_Bw@mail.gmail.com>
 <ZYJFPoFYkp4xajRO@google.com> <ZcGn0t3l8OCL5mv6@google.com> <ZcrkhTn1Da5-vND2@google.com>
In-Reply-To: <ZcrkhTn1Da5-vND2@google.com>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 21 Feb 2024 15:05:28 +0900
Message-ID: <CAD=HUj5fO9QCaMJhiJdzQsMPnVSRvM6T9RLYqE03_dEfzeQmtw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
To: Sean Christopherson <seanjc@google.com>
Cc: kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:39=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
> On Mon, Feb 05, 2024, Sean Christopherson wrote:
> > On Tue, Dec 19, 2023, Sean Christopherson wrote:
> > > On Tue, Dec 12, 2023, David Stevens wrote:
> > > > On Tue, Oct 31, 2023 at 11:30=E2=80=AFPM Sean Christopherson <seanj=
c@google.com> wrote:
> > > > >
> > > > > On Tue, Oct 31, 2023, David Stevens wrote:
> > > > > > Sean, have you been waiting for a new patch series with respons=
es to
> > > > > > Maxim's comments? I'm not really familiar with kernel contribut=
ion
> > > > > > etiquette, but I was hoping to get your feedback before spendin=
g the
> > > > > > time to put together another patch series.
> > > > >
> > > > > No, I'm working my way back toward it.  The guest_memfd series to=
ok precedence
> > > > > over everything that I wasn't confident would land in 6.7, i.e. l=
arger series
> > > > > effectively got put on the back burner.  Sorry :-(
> > > >
> > > > Is this series something that may be able to make it into 6.8 or 6.=
9?
> > >
> > > 6.8 isn't realistic.  Between LPC, vacation, and non-upstream stuff, =
I've done
> > > frustratingly little code review since early November.  Sorry :-(
> > >
> > > I haven't paged this series back into memory, so take this with a gra=
in of salt,
> > > but IIRC there was nothing that would block this from landing in 6.9.=
  Timing will
> > > likely be tight though, especially for getting testing on all archite=
ctures.
> >
> > I did a quick-ish pass today.  If you can hold off on v10 until later t=
his week,
> > I'll try to take a more in-depth look by EOD Thursday.
>
> So I took a "deeper" look, but honestly it wasn't really any more in-dept=
h than
> the previous look.  I think I was somewhat surprised at the relatively sm=
all amount
> of churn this ended up requiring.
>
> Anywho, no major complaints.  This might be fodder for 6.9?  Maybe.  It'l=
l be
> tight.  At the very least though, I expect to shove v10 in a branch and s=
tart
> beating on it in anticipation of landing it no later than 6.10.
>
> One question though: what happened to the !FOLL_GET logic in kvm_follow_r=
efcounted_pfn()?
>
> In a previous version, I suggested:
>
>   static kvm_pfn_t kvm_follow_refcounted_pfn(struct kvm_follow_pfn *foll,
>                                              struct page *page)
>   {
>        kvm_pfn_t pfn =3D page_to_pfn(page);
>
>        foll->is_refcounted_page =3D true;
>
>        /*
>         * FIXME: Ideally, KVM wouldn't pass FOLL_GET to gup() when the ca=
ller
>         * doesn't want to grab a reference, but gup() doesn't support get=
ting
>         * just the pfn, i.e. FOLL_GET is effectively mandatory.  If that =
ever
>         * changes, drop this and simply don't pass FOLL_GET to gup().
>         */
>        if (!(foll->flags & FOLL_GET))
>                put_page(page);
>
>        return pfn;
>   }
>
> but in v9 it's simply:
>
>   static kvm_pfn_t kvm_follow_refcounted_pfn(struct kvm_follow_pfn *foll,
>                                              struct page *page)
>   {
>         kvm_pfn_t pfn =3D page_to_pfn(page);
>
>         foll->is_refcounted_page =3D true;
>         return pfn;
>   }
>
> And instead the x86 page fault handlers manually drop the reference.  Why=
 is that?

I don't think FOLL_GET adds much to the API if is_refcounted_page is
present. At least right now, all of the callers need to pay attention
to is_refcounted_page so that they can update the access/dirty flags
properly. If they already have to do that anyway, then it's not any
harder for them to call put_page(). Not taking a reference also adds
one more footgun to the API, since the caller needs to make sure it
only accesses the page under an appropriate lock (v7 of this series
had that bug).

That said, I don't have particularly strong feelings one way or the
other, so I've added it back to v10 of the series.

-David

