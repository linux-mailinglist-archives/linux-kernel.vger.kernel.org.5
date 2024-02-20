Return-Path: <linux-kernel+bounces-73547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4AB85C3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D01C22074
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025212E1D8;
	Tue, 20 Feb 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBQ2caJo"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F487602B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455108; cv=none; b=k0f+0voaaUsCUaWZe24p3BhKrKx8/xK+JwKIbX5KRXD+85GV82NPvqa4Bo9FHieOTgJfZh3EohMfsgbTAYpcRbgk/dE9S4pjE7YPWuTuxA1MoWEZFNzb31oMzdY2CO1NlGqzr9q+eUe6Qvq2lt218D2hvTQESHyWTaJ2vzhAJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455108; c=relaxed/simple;
	bh=B/Y907SBVrsllYy6qByqNQHwt7IG5OvmGpDMhx82aEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT6i9Xk7y8McpHn9YVfyIooI7LBZ/fELwHWdD5Dxn4W7OjjiY9UMBHJPuxtuUdzEpRYn2Y0WlH3GmxsuA7DTwQMgt9hytzSc8ksQXhucZyQNTmLIjp5S1Odzo1shuH28brqKDyIerkxRerl/ghf4aFmAN+RrHXiI/aFCSU1e7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBQ2caJo; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47063d4b17cso1028571137.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708455106; x=1709059906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Y907SBVrsllYy6qByqNQHwt7IG5OvmGpDMhx82aEA=;
        b=kBQ2caJoz/ymTu4hy4NudQGQhwOO2iEJD4Dm0eTF4QTw38NBBxcqqUR0hWriq9inPi
         E40vS0yViJwyeIl+nDi2bL1EdMukUNkDqnmsOe8GiBR8YX6gKdIygeZuTmumM571mEdv
         BKssl7Uq/efLhTfLRjfdZK5vr8eMbqFHGJ1w/r7Tu7GbHxCEPaI25IhGLGuiXuxZKPJ5
         UwNlV5zI0IeQsifreISbR76Xm2fa1Bwqwq/9WZS5NvTKOF8UOJEuyqVdkbmYawqtOKKb
         tE8xy7UlfRShFyc/zzZubu+IJrUUZFQkepsE/sZCsMppsdW33JUfBZaopdPULM4Fk45H
         f7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455106; x=1709059906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/Y907SBVrsllYy6qByqNQHwt7IG5OvmGpDMhx82aEA=;
        b=DrmuPoh5AEwSrgVSpLTkYEEHQIgXv51x48xD9P3Id5cplLQqRALpjiKu1WN/4hltWD
         Tw6IR+MsMd0sNp9lDYOz9ViRBnzsqeVzRod+6C99CwUpZ0wcWJa5MtBOk6IC71V8gOea
         NmZft2pvWJkrxQGAr08sR6j+UgovpyMwIjLVmIk+zpnT9ryWvR3NzmcdPIbOJyjLU0wu
         NsvLPb9P+6BU+Xvo00UwLG7tkiF1dhLOH/Pi0vEZwgIkngmRo+b0WhhEw16lj5+XbCvQ
         gyJgoy0f6FhCPZszAB+CKfZPjHQFYsbD/Gb++uKFH7/XRt/fGZqQDmtYJkIAbCbfTL+U
         tHBw==
X-Forwarded-Encrypted: i=1; AJvYcCXn4h1BKxoBrW31rjzRS1jVLwdlKher1C6p/yM6aREiPfrrQPIBibH8zqoQXnTjzSTxXqqO3lH+XdjNuXxFSXgqc/ipZoZCKwwr0KvV
X-Gm-Message-State: AOJu0Yxyf032s7WsQhNQKgnOvw3mtzLOsXjQ7LRbNjFvEhHlBn4/bgBV
	LwFoka4wnnlsw5ZH2HKbaNHn0MeWwm7KCgV38OgGu+0ODmNwlKQm9ifp7ZZuX7xYUFUOd/oNlbq
	KaM7KnJjh2M5uKS7rfsAWFfQG7Fpjr6BPIV61
X-Google-Smtp-Source: AGHT+IFHzuL7PAZHpU0n+2ypxN9ERpiX5mLfFdtADHU+PKGjyMPtDiVJEcCfRQjX0yyY7/Q65ionVkALzA1P/jMzi1Q=
X-Received: by 2002:a05:6102:1608:b0:470:5718:23a7 with SMTP id
 cu8-20020a056102160800b00470571823a7mr5778068vsb.7.1708455105738; Tue, 20 Feb
 2024 10:51:45 -0800 (PST)
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
 <20240220093011.bf84486d704c3814079c2aa0@linux-foundation.org> <96c51d35-15ce-42d0-b81b-7e76044e1f2b@suse.cz>
In-Reply-To: <96c51d35-15ce-42d0-b81b-7e76044e1f2b@suse.cz>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Feb 2024 19:51:07 +0100
Message-ID: <CANpmjNMObiX5X721DERccn16aMW+WMPz+wvLKv=UdaQi3XOMwA@mail.gmail.com>
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

On Tue, 20 Feb 2024 at 19:16, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/20/24 18:30, Andrew Morton wrote:
> > On Tue, 20 Feb 2024 10:37:03 +0500 Mikhail Gavrilov <mikhail.v.gavrilov=
@gmail.com> wrote:
> >
> >> On Tue, Feb 20, 2024 at 4:50=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >> > >
> >> > > I'm all confused.
> >> > >
> >> > > 4434a56ec209 ("stackdepot: make fast paths lock-less again") was
> >> > > mainlined for v6.8-rc3.
> >> >
> >> > Uh sorry, I just trusted the info that it's not merged and didn't ve=
rify
> >> > it myself. Yeah, I can see it is there.
> >> >
> >>
> >> Wait, I am talk about these two patches which is not merged yet:
> >> [PATCH v2 1/2] stackdepot: use variable size records for non-evictable=
 entries
> >> [PATCH v2 2/2] kasan: revert eviction of stack traces in generic mode
> >> https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.c=
om/
> >
> > A can move those into the 6.8-rc hotfixes queue, and it appears a
> > cc:stable will not be required.
> >
> > However I'm not seeing anything in the changelogs to indicate that
> > we're fixing a dramatic performance regression, nor why that
> > regressions is occurring.

It's primarily fixing a regression of memory usage overhead for
stackdepot users in general. Performance is mostly fixed, but patch
2/2 ("kasan: revert eviction of stack traces in generic mode") also
helps with KASAN performance because entries that were being
repeatedly evicted-then-reallocated are just allocated once and with
increasing system uptime the slow path will be taken much less.

> We also seem have an unhappy bot with the 2/2 patch :/ although it's not =
yet
> clear if it's a genuine issue.
>
> https://lore.kernel.org/all/202402201506.b7e4b9b6-oliver.sang@intel.com/

While it would be nice if 6.8 would not regress over 6.7 (performance
is mostly fixed, memory usage is not), waiting for confirmation what
the rcutorture issue from the bot is about might be good.

Mikhail: since you are testing mainline, in about 4 weeks the fixes
should then reach 6.9-rc in the next merge window. Until then, if it's
not too difficult for you, you can apply those 2 patches in your own
tree.

Thanks,
-- Marco

