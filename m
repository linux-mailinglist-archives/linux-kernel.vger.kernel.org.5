Return-Path: <linux-kernel+bounces-81049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F34866F77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25DB288164
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923554F9C;
	Mon, 26 Feb 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr9Tm/Za"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6054F8C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939598; cv=none; b=Grqx0Ywt0D8/akKjw3rxgpV3FQGBCMQxvLBRtj5vS7eaJzhkk45EXjifNO5ywGwCuwsIWTkN0Ye/Sqi2273Kr8922mKNVV2EnAOazEleaKfiLmShLpq8oaA5mULebG9uBzEgKOp/4bjThAOpKPr6yjB7sRgZmUlI9OTwiezS6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939598; c=relaxed/simple;
	bh=9deL/d/BcOgJ90IBVOvhsZVsKJ8Cuz+9AZRxFu2eesM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jffTDaCC9B44EadAuY1SBlo4QVjBDPFE87yGTuJgHCo2LADkwsCJ/qBwWRzJrLgAljfDS7dfgndA07svqYn+1gD0lF+uzJWFb3s0uXXiw+kNqdTII1ItnPSGCajDDexePDpKyzFoXSfH0y/P34wqY6lByiuFfLcYCZTW3gDCKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dr9Tm/Za; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so877489241.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708939595; x=1709544395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9deL/d/BcOgJ90IBVOvhsZVsKJ8Cuz+9AZRxFu2eesM=;
        b=Dr9Tm/ZatKZhrXF9KI8MCnZw7ZhFyK0ELsljHMsMzle3S2NJuT8QQkUsgLoby6CLSI
         4ehZktOHqg4bfJUqiucIMaRpZI41RCI4MbWji2w2k4ciK6Z7GLYvh1alj9a15fxB9/Y1
         5lXdwn+JQJhH8UEV8ZzXrfP5tf7G72AlqVLzM16fv0wrQT9Pli2K/AtW4fyqo9ghmN2k
         G9RoYFkNOG73TTyY9QdLkeZyZFYFOqKpg9LwJS5C+1TbjqwVF0uBRDaLHhQipKYuDlX+
         OS1LAEDxKO3IDiOe1dXavOwXIC2rRoC4FY4mWznMJ/1YMi4kOeUjVWgBM7QRWR3AZrHr
         oGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939595; x=1709544395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9deL/d/BcOgJ90IBVOvhsZVsKJ8Cuz+9AZRxFu2eesM=;
        b=oh7SI1cWmsnXOslrjoDdxCuoQkAajjaSgffcRk8Prx7AJC19IPPa34jfpFkMgCkwOV
         hNzmew+/bcG/iucg7hw8ZyZFehHyECPBKyzjQ/4gaoEBN/5/G80s7HGW7JKPxYGlmpaW
         /tCKmHEXHj6+gxZfk1VZlXslzde2mm/4knaegBeSVd/kOga8N6vdtJuPoverCC+WTJNa
         FCXp77RFFlkhLVr3PGcVE8zEz4dHYDIY8KOHql64G8vqi+VGeETOSiZ/C9sTquN5V34p
         eXsH4Qjj/HJfo/DOkxDO5ed4LKjg+5eTshCEK6aNRyGDlXblsrRBgK1QcqMGqXcBkAnX
         xCOw==
X-Forwarded-Encrypted: i=1; AJvYcCXWueFEvhTEhwavq7CLZ+pt7hNifLQj1Z5QT20eZGEto1aUL5oDe37JdDm1bBdwV1lWjupKmbwYTInEZ5gaeWX4I7KM0jAKHGrJpaMY
X-Gm-Message-State: AOJu0Yym7FfLKJkmKLfIZFYpBQpALacP4YhtavUCTst03AwR6z0gD/UE
	01wAXuF8BW/DH1w3NtFO4xM15Xl5H+7DGFY1ehe1QW4d9TI22Q/nhEPv35crkl06DJhtfsp3Rwd
	oL8NvNuRXt1CGadBL+/niUElJms5M3muc6YSdRAgU8czzoM2oI5yg
X-Google-Smtp-Source: AGHT+IHUnRw4mFGKo0EZ/hFZK/eG3IFnyKzaqS0jzj1uJLOk9IiRiRv/WsrXIPvhAqjXo29J5z4X1jK9bDP4OCfWkSk=
X-Received: by 2002:a1f:cc84:0:b0:4b6:d63c:ca8f with SMTP id
 c126-20020a1fcc84000000b004b6d63cca8fmr2397957vkg.16.1708939595308; Mon, 26
 Feb 2024 01:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
 <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
 <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
 <CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com>
 <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
 <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
 <CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
 <91c50335-e7b6-4ae1-9dad-a0c990b52021@suse.cz> <20240219152836.11d36709c594e66fe3037f2d@linux-foundation.org>
 <7e31accb-db01-486f-afb8-18a3f5402d00@suse.cz> <CABXGCsOHswLa5rd_Q7kHDHESb=BtqB+F=LV7Wvv+qoRxrqCboA@mail.gmail.com>
 <20240220093011.bf84486d704c3814079c2aa0@linux-foundation.org>
 <96c51d35-15ce-42d0-b81b-7e76044e1f2b@suse.cz> <CANpmjNMObiX5X721DERccn16aMW+WMPz+wvLKv=UdaQi3XOMwA@mail.gmail.com>
In-Reply-To: <CANpmjNMObiX5X721DERccn16aMW+WMPz+wvLKv=UdaQi3XOMwA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 26 Feb 2024 10:25:56 +0100
Message-ID: <CANpmjNPP=c4ZfJmWFexR=03Lk4gGMr7yPW=j81WAnM_vCSCwCQ@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, 
	dvyukov@google.com, eugenis@google.com, Oscar Salvador <osalvador@suse.de>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 19:51, Marco Elver <elver@google.com> wrote:
>
> On Tue, 20 Feb 2024 at 19:16, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 2/20/24 18:30, Andrew Morton wrote:
> > > On Tue, 20 Feb 2024 10:37:03 +0500 Mikhail Gavrilov <mikhail.v.gavril=
ov@gmail.com> wrote:
> > >
> > >> On Tue, Feb 20, 2024 at 4:50=E2=80=AFAM Vlastimil Babka <vbabka@suse=
cz> wrote:
> > >> > >
> > >> > > I'm all confused.
> > >> > >
> > >> > > 4434a56ec209 ("stackdepot: make fast paths lock-less again") was
> > >> > > mainlined for v6.8-rc3.
> > >> >
> > >> > Uh sorry, I just trusted the info that it's not merged and didn't =
verify
> > >> > it myself. Yeah, I can see it is there.
> > >> >
> > >>
> > >> Wait, I am talk about these two patches which is not merged yet:
> > >> [PATCH v2 1/2] stackdepot: use variable size records for non-evictab=
le entries
> > >> [PATCH v2 2/2] kasan: revert eviction of stack traces in generic mod=
e
> > >> https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google=
com/
> > >
> > > A can move those into the 6.8-rc hotfixes queue, and it appears a
> > > cc:stable will not be required.
> > >
> > > However I'm not seeing anything in the changelogs to indicate that
> > > we're fixing a dramatic performance regression, nor why that
> > > regressions is occurring.
>
> It's primarily fixing a regression of memory usage overhead for
> stackdepot users in general. Performance is mostly fixed, but patch
> 2/2 ("kasan: revert eviction of stack traces in generic mode") also
> helps with KASAN performance because entries that were being
> repeatedly evicted-then-reallocated are just allocated once and with
> increasing system uptime the slow path will be taken much less.
>
> > We also seem have an unhappy bot with the 2/2 patch :/ although it's no=
t yet
> > clear if it's a genuine issue.
> >
> > https://lore.kernel.org/all/202402201506.b7e4b9b6-oliver.sang@intel.com=
/

This was confirmed to be a non-bug by RCU devs.

> While it would be nice if 6.8 would not regress over 6.7 (performance
> is mostly fixed, memory usage is not), waiting for confirmation what
> the rcutorture issue from the bot is about might be good.
>
> Mikhail: since you are testing mainline, in about 4 weeks the fixes
> should then reach 6.9-rc in the next merge window. Until then, if it's
> not too difficult for you, you can apply those 2 patches in your own
> tree.

There are more issues that are fixed by "[PATCH v2 1/2] stackdepot:
use variable size records for non-evictable entries". See
https://lore.kernel.org/all/ZdxYXQdZDuuhcqiv@elver.google.com/

This will eventually reach stable, but it might be good to reconsider
mainlining it earlier.

Thanks,
-- Marco

