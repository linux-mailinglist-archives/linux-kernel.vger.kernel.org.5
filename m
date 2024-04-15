Return-Path: <linux-kernel+bounces-144447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6A8A4685
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE981F21F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF915695;
	Mon, 15 Apr 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W++OBiXf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D811798F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143926; cv=none; b=MJJJxe86Xctf6rwtmPjp28YZNAs7WcAU6Jqt2V8rekvnqJddvHAZCYQ+68PKftMXr925JAGGXBsZjAyWmuxZ7xPpJFd1yvd96+VtsHPqo8OYjVZJNQfboVfWKivV9gS5uFZcPq4qZ/Ijjf97HedYeB5MKu0K5J68l2hk/XvzmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143926; c=relaxed/simple;
	bh=SZEU2AAYiK32tO0ekIS2kaYeVNenr2KRFJCsIWB5H+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjgPEk0RZMEIl1i8sF4CD04Npb9C4ERTiW2W9t0cJEEUDVDKewRU5taWKXmVjEUN8+1G9JqG9J/mKJ3OQl/us9JsGvSgvBiEqxLSuxcg/4P35YSAss7MOxMGZhYSXBWvm+3IRocBW58LULrgfup1FbwMEtdDxoMPYip669fvAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W++OBiXf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a1c8d931so336309066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713143923; x=1713748723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+XqQYX6j74TVTNZkVvf9TiEg5jTs7E3pT/qOHAJIRE=;
        b=W++OBiXfQraaTj9ufjYwg5TFtnfOJdCeLAsjDVT1IRtVfhEZSdrLgeAe+GHODv1oQQ
         0mn6BYThMdEgdFS2HwK8wkfa9vrhyPyEe/6YwZc9/AfYyJP7uBlqgirusIswFTRnU8Lz
         wojVebD6CnrD0rN7b+SF+sNzSop5NbHnoSI8SEucGJd8T0mqBDNh/YAcOiGsnqIrEkLj
         69edwFL5F0aWfW4WaS6TcVcuTTJh9g3aj6VT0rkBibkO1v3LFsK7uGsjwXRr4LClYZi8
         3Kt64YoyasDJ2FxCkrdrcATpyqT0G3hikmorfRz+aemHlq4P0VTjywqw4oxIM+g1QHOC
         CXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713143923; x=1713748723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+XqQYX6j74TVTNZkVvf9TiEg5jTs7E3pT/qOHAJIRE=;
        b=uGRe+VIzuo6znWfsFRX/ojyMGgEWDakqaAZhDY1d5dbkMVXYE8+Ru5NaTQyFWIhl45
         /AHbD9jCSsIKPdZQE1QTWYbGJCQqIkptuUA7o4JznS1mkgdRv+ByjiYlQHXuMkz98JIU
         Eljzfd790XAxTeC+2a7qx/wRs2WbPAnuqZgE5DxVUnYEE99A/2KqJ6odUsK4DAs5e2tX
         ZgEtnF5HvF0fFPlQeI5v2rbPDWGypup1wH2kjyZJntFC4NvDzhLQNVr3XAH6hDyqXbYz
         t7iT4+pofFng5mFG3KkHilB4u2qUMCE9Q4LqtkasIGrc0nOEpf8j/utA0Y89u6muR+eH
         7zZw==
X-Forwarded-Encrypted: i=1; AJvYcCXQDd6bgczqD95hbSVY+kJq+1RsXSHGiN0oVQsNeO+L1MSAu08IzADTzlDOhHk5yOcgaDRpwmFPVl2BeB3oc11NxVT3Sr2z8fB78EWI
X-Gm-Message-State: AOJu0Yy6Se2Bc6cTZ7kgP/MYxd6fSD8bpAQwNjS8AIWI4VmNPUPvNXbg
	dEa+pTgDvgb2wgwN1YH9A1BDirzG/sAHNfn0EtI47IlWtRQnlIECwlSL/Z87G5DdLmHIy/JorrP
	etoEY4D0k9z58Mf9q7NB8LPF/Ctg=
X-Google-Smtp-Source: AGHT+IGnYT7NaV2BdrGRbTU3oSvqLMFMCJ66KWPYOl5ZrgmLYsx69G0pKUpgkJ8G+ZYW51R1IrNjaxVD/ur8UtaMQso=
X-Received: by 2002:a17:906:b2d8:b0:a52:5925:2a31 with SMTP id
 cf24-20020a170906b2d800b00a5259252a31mr513102ejb.29.1713143922536; Sun, 14
 Apr 2024 18:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405152951.1531555-1-nunes.erico@gmail.com> <CAKGbVbszmRpWfaXVjQ83RiFBapjent9UKM=JcGTMVsOk3bqJkQ@mail.gmail.com>
In-Reply-To: <CAKGbVbszmRpWfaXVjQ83RiFBapjent9UKM=JcGTMVsOk3bqJkQ@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 15 Apr 2024 09:18:30 +0800
Message-ID: <CAKGbVbvoBf79NZFHiKJHKvOn5qqKYCy4JTEgSYj1uzJZmKAdAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/lima: fix devfreq refcount imbalance for job timeouts
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	christian.koenig@amd.com, megi@xff.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

applied to drm-misc-next

On Sat, Apr 6, 2024 at 3:32=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> Serial is Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> On Fri, Apr 5, 2024 at 11:31=E2=80=AFPM Erico Nunes <nunes.erico@gmail.co=
m> wrote:
> >
> > v1 reference:
> > https://patchwork.freedesktop.org/series/131902/
> >
> > Changes v1 -> v2:
> > - Split synchronize_irq of pp bcast irq change into (new) patch 2.
> >
> > Erico Nunes (3):
> >   drm/lima: add mask irq callback to gp and pp
> >   drm/lima: include pp bcast irq in timeout handler check
> >   drm/lima: mask irqs in timeout path before hard reset
> >
> >  drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
> >  drivers/gpu/drm/lima/lima_bcast.h |  3 +++
> >  drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
> >  drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
> >  drivers/gpu/drm/lima/lima_sched.c |  9 +++++++++
> >  drivers/gpu/drm/lima/lima_sched.h |  1 +
> >  6 files changed, 51 insertions(+)
> >
> > --
> > 2.44.0
> >

