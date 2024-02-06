Return-Path: <linux-kernel+bounces-55379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14384BBE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE89B1C22DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57433D517;
	Tue,  6 Feb 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKCcp7q4"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A6BA50
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240678; cv=none; b=sfHNWFqTrXV+zs4pXjg6tLd3f1vE7L21ml/TiBPSpHtjLlGxyAq19a9HX/E6UIdGeJztOjRJH/iwjGRdrz1lQb8XNzUqE/GK69K4cPe92wEQ6ltERsV8t7qOOtlAYM+Xu0dnMS5Y2fMNjdxYX1QY2AqhHE2DmvtIU+REjnXyyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240678; c=relaxed/simple;
	bh=tr6m+R2THwf3zvHVbBb44TsmN3M31ERvqZA3x4Ing70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icv2F7H9MqC3nl/9x2BDwKyLbucGXURDh9dxOzfG3TIu9KyzUWBwSI90UZLSi2//RkVTe0wVbFG3EFC4HM6JiELdJ7BCIeeMXxATYoe0QzOUbRFHTwrIDEOd8rtluWx5GB/ACrsKc7IgeWHXpYRp8okmFgo+Q6Vrj7VTGxbMOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKCcp7q4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c00cfd7156so238704639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240676; x=1707845476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPcqdTOG7hsb6OetsSk6gwLuDAB08ptM/Ebrl9LX+uc=;
        b=UKCcp7q4/8YDZM2OrSGBRdmzum3D7HLixr9FaphZklaA+pV9PipaLpGTRY0ZaAbuHA
         Dca3InrmGLW3A72ma/A9HaP6StRX2NQ0J7hV18KqMpAg/57/cKwszgl4FqJXu+3790op
         lsuZPIkUafGnQUOBvEc3ksPBtI7kqYoo7V2WV9auEd+mOwsTnSP/jK4xHPZ0XKTAAc9u
         Dsn/6oeuDekffjlJL084Lfuyx9Z5Ed0XHPeL1Pc0pkEcHGE+uf9R9a0zMx15rOb5//Vr
         1E5TD/lzF+BP2SbaQaFX8tgLdWlY+fki2fn2fbuD00QCpigOrcNlp4qWdczeIRIhw/SL
         28qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240676; x=1707845476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPcqdTOG7hsb6OetsSk6gwLuDAB08ptM/Ebrl9LX+uc=;
        b=gIrhSVTaDe0Sg4uMxK/Xz1KCTqHz9VKauitwzQAUo1+HK5zSrnB1BAqsnyfmNDQx+N
         uSrFlSuGQ8JeA1HvlVblXKXP+FfmDNAMgUpLO/oZrvv2o6dKj9oRksEclzhpEF4Vw+7O
         TzP/FamYoSwl2skGOJMBV2qQbfFE2fRGTQHEJhL3XyyMLiabDb1yneIdbNwec9xsKiXW
         A0V9UZ++z7zLCVR6VW8AgISAXW4a/+3aGWTeGBTrWRJkd3gOGv6E6hEpPKnlUJ4F8cQy
         95LwiiXKN7j31xrCb6UTmNnrV3bJ8E4nMTbKg6eChOq5ElIWX9uvlLuN+eaZ3mQpz/y/
         EIrA==
X-Gm-Message-State: AOJu0Yzm+KEfKwQIpp6W1Dd+Wk3+WzCZ1nsC4Ho1ptfwzNjndwtxhGtS
	D1ouI7z8D4UKK+wrAzisAmK3zGkwNXVf0lo/xmUulSzMxwi2wj1GTJ1yDwBs1QmrIIXe15mdw5t
	E4l6YnPtFbAbBMTLsC2NTgXDdJT4=
X-Google-Smtp-Source: AGHT+IHwZvUC74P4q/l1EaSnsg7ta7gOlVu/FmAfqhuEXq0gxrEH6mxcei45FQXey0KBh+cOaM345ptlFi+YwfS3W3Q=
X-Received: by 2002:a05:6602:17c6:b0:7c3:f303:e274 with SMTP id
 z6-20020a05660217c600b007c3f303e274mr2201238iox.8.1707240676003; Tue, 06 Feb
 2024 09:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205232442.3240571-1-nphamcs@gmail.com> <20240206151523.GB54958@cmpxchg.org>
In-Reply-To: <20240206151523.GB54958@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 6 Feb 2024 09:31:04 -0800
Message-ID: <CAKEwX=NxY+MsTO9vxrpSPHu-i4fJ+m=9=_U5beo5XLAtbADivw@mail.gmail.com>
Subject: Re: [PATCH] mm/swap_state: update zswap LRU's protection range with
 the folio locked
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, yosryahmed@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 7:15=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Feb 05, 2024 at 03:24:42PM -0800, Nhat Pham wrote:
> > Move the zswap LRU protection range update above the swap_read_folio()
> > call, and only when a new page is allocated. This is the case where
> > (z)swapin could happen, which is a signal that the zswap shrinker shoul=
d
> > be more conservative with its reclaiming action.
> >
> > It also prevents a race, in which folio migration can clear the
> > memcg_data of the now unlocked folio, resulting in a warning in the
> > inlined folio_lruvec() call.
>
> The warning is the most probable outcome, and it will cause the update
> to go against the root cgroup which is safe at least.
>
> But AFAICS there is no ordering guarantee to rule out a UAF if the
> lookup succeeds but the memcg and lruvec get freed before the update.

Ah nice. I didn't consider that. IIUC, having the folio locked should
prevent this too. Based on the documentation:

 * For a non-kmem folio any of the following ensures folio and memcg bindin=
g
 * stability:
 *
 * - the folio lock

I'll rework the commit log to include this, and make this more prominent :)

>
> I think that part should be more prominent in the changelog. It's more
> important than the first paragraph. Consider somebody scrolling
> through the git log and trying to decide whether to backport or not;
> it's helpful to describe the bug and its impact first thing, then put
> the explanation of the fix after.
>
> > Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google=
com/
> > Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure=
")
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Would it make sense to add
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> to zswap_folio_swapin() as well?

