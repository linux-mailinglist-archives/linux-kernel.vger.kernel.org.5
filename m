Return-Path: <linux-kernel+bounces-49935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C434A8471C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E36628EFEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068214198A;
	Fri,  2 Feb 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFqci3Tl"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF41185A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883657; cv=none; b=OaTxpf8/Y6+tA+JiaHUXhT6f3Agrg+Freq6o4SeJaJ/51yqBY2U/oh8kFQ9UyYgL3iKI8mDlQnMmXuWmJ5jOYKqOdiusxG4JbFzuAG9hBUvQN6Ktk3DEdTMMkqTFf7Mrvik+bxGgwO9wP/UT+mqpdQk/vJwvB1NDsv8Zfw9j3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883657; c=relaxed/simple;
	bh=G2uxDw3rJ90QUP0VxxcGcpNUOmy7xFkn/uZBFq7Dat0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUd7BV+SzRicRxqo1GmJLOZbafE4J1jz4F0noxgQpgfAJhnNEiVGcfSgRahsW+uQdPSmM+LmdcMlbywTaPNW686ynShhE380KNG0pZoEnKbdTIkhb0FmeKljful7bRhOtMeIx3IaN58SJro7cq539q0EXXEDYJKL6YJrbjQjydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFqci3Tl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60410da20a2so21436507b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706883655; x=1707488455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2uxDw3rJ90QUP0VxxcGcpNUOmy7xFkn/uZBFq7Dat0=;
        b=fFqci3TlcxVdIhoOvZM+cSFg6Uo1jCdy5yadnXq20KxT98ibf1ncUXxLDFhmmZN2PT
         T3+GIDy0HjiHkBtJKuP6PmZAyvaZIwESgtqDfgC395Z15inifznfzJn5p0ECx6GTxGmA
         aTasrtuuN/fXk/W/6pP4gAUxIzOnVqaWnM7UM4sFBx9x/ABnhD3UMAn4FSfQm91eDOWT
         aFytj6TyFe1/KmbmMlVrC9NJ45955RZtrGWgWd/ZFt+tX7JwrybL5B6dl76mVeemlqpH
         p3MsZId8MQG/6Hqk2tR344zluXhPJmDN/M2mv/ptvgAIrIQVkfgm6WNt1m6/lTPjaLmM
         YUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706883655; x=1707488455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2uxDw3rJ90QUP0VxxcGcpNUOmy7xFkn/uZBFq7Dat0=;
        b=Pz5Pzbf4ZYMOhZGHvt4S/t3nXAqV2jefLXgNUR00tH+fGKhfLSJM6Duhk/WettUolh
         4VYhMCmIRKWdxTk4C5VIh2Q8cL/afvc/GOLREf2wFLQxo6XV9fo+1QhdZn9/C0k77dMZ
         A5zNHGYuDseBe+Y+ZpkgMvTTfggxDkpFf8Od9+ED2o1h7wJiM7xDU3Tk8LQMxaA22uzO
         FhE1f1XAjkzaFD5mFzCHDB3Ux+H+um87edgsmkGqAsXO0id9AAKd7HwvyaT5QQDx18yO
         y+FrfbBp4CkDPIBdSdugXsaUcHXUJqJO6QUYX21xm1xv8A0yS/w6x4iMAgewteX+j7Nb
         M62Q==
X-Gm-Message-State: AOJu0YyX0MAyfzbGv6gNL99zfaKEnsQsu1bKJRQVaDEFc0J/lrx1TYEt
	srhqncYIW3N+sN8oH4xYE0fS3W765BKwR2TPUNgJTU0T2v23SPTKGAuQw5Zn1/NTHLuGrwKxjmH
	ygTXSTHrOIM9W3gYI5dzZIDmPHhk=
X-Google-Smtp-Source: AGHT+IEqf50LUjBPwdqZ6TbQazL+K8tUNpZi9E1X57Kcl7GuX7fVtf0lcgQoMT07e0dTsdejuuiLqXiT8bdHYXwZ2mQ=
X-Received: by 2002:a25:ce43:0:b0:dc2:3c31:8f85 with SMTP id
 x64-20020a25ce43000000b00dc23c318f85mr8010365ybe.47.1706883655275; Fri, 02
 Feb 2024 06:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka> <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
In-Reply-To: <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Feb 2024 22:20:40 +0800
Message-ID: <CAK1f24kak95cmYvhr=OeEPr2w2EzrM_xVW09BTguUfNnAe8LSg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'd like to add one more point.

Users mark pages as lazyfree with MADV_FREE,
expecting these pages to be reclaimed until memory
pressure occurs. Currently, khugepaged treats lazyfree
pages the same as pte_none, which seems reasonable.
IMO, avoiding the copying of these pages to the new huge
page during khugepaged collapse can better keep the
semantics of MADV_FREE. It appears that lazyfree
pages are reclaimed before khugepaged collapses them.

Thanks,
Lance

On Fri, Feb 2, 2024 at 9:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> Here is a part from the man page explaining
> the MADV_FREE semantics:
>
> The kernel can thus free thesepages, but the
> freeing could be delayed until memory pressure
> occurs. For each of the pages that has been
> marked to be freed but has not yet been freed,
> the free operation will be canceled if the caller
> writes into the page. If there is no subsequent
> write, the kernel can free the pages at any time.
>
> IIUC, if there is no subsequent write, lazyfree
> pages will eventually be reclaimed. khugepaged
> treats lazyfree pages the same as pte_none,
> avoiding copying them to the new huge page
> during collapse. It seems that lazyfree pages
> are reclaimed before khugepaged collapses them.
> This aligns with user expectations.
>
> However, IMO, if the content of MADV_FREE pages
> remains valid during collapse, then khugepaged
> treating lazyfree pages the same as pte_none
> might not be suitable.
>
> Thanks,
> Lance
>
> On Fri, Feb 2, 2024 at 8:57=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
> >
> > On Fri 02-02-24 20:52:48, Lance Yang wrote:
> > > On Fri, Feb 2, 2024 at 8:27=E2=80=AFPM Michal Hocko <mhocko@suse.com>=
 wrote:
> > > >
> > > > On Fri 02-02-24 19:18:31, Lance Yang wrote:
> > > > > IMO, since it's treated the same as pte_none,
> > > > > perhaps lazyfree pages shouldn't be copied to
> > > > > the new huge page.
> > > >
> > > > Why? The content of MADV_FREE page is valid until it is reclaimed.
> > >
> > > IMO, if MADV_FREE pages are considered valid until
> > > reclaimed, treating them the same as pte_none might
> > > pose a conflict.
> >
> > What kind of conflict?
> > --
> > Michal Hocko
> > SUSE Labs

