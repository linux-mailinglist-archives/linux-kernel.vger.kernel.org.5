Return-Path: <linux-kernel+bounces-34580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4CC8381B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34A71F2332D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322C51C21;
	Tue, 23 Jan 2024 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz/i3Y7f"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066924A1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972697; cv=none; b=QYSqIt2vCncVZH6Bb0796ZlD9RV0uR+6DouTHXf9pjRhkn19Gj9kOUi/NOs2P0XVwpgR9HcWzCxl+mTgCYPfvjYlrnfDxbWkj8lTBJRlL48tBf6I8TiIWwsXcfg23f8157GzZl9MqfMS0zdU48oJthwdzNHThLAW+dbGfY8jciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972697; c=relaxed/simple;
	bh=7OGpeO8bcvoJGD6aSk6hwBQ0SR8wEJaEQk7HVbaXwYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJPEdmOLRmIwa9wlPD8R0NBJ+VkN8yApGdU80K5E9wfIFEUitb7B2VbBs27lOWoO4ONLWsboZUKLFipbStYP/8gYqGwIe+4wtYtX5+5WK52zEnG+tE2I7JdmQCrta2r6yPVVaYWDPhZYOJc6gYk19RJbejHFO/PHAMWEuJNq5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz/i3Y7f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso5156344a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705972694; x=1706577494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6lo1t0xIINgMF9rkW3F98A1LhixJMkR04sT2kjXH0U=;
        b=iz/i3Y7fFWM8IGsXaHfsB57b2Lga959AA/BKrxr+rwRK7isv0WL/CEG4Ru596+XPHV
         nvoxj8tfoMiJcEcRJXASi/kWeCV5nH7uysOisvt3g4lJz+0I9THTlY3/N8KvRmSAuKys
         U3FDbO33r8klBQqFViipr/TKz2AjP+fZKbZWXeOoxz/oBpM2Jj7khA18y27oCjhzHLJ0
         P/DPpsIaKtwATy4uXchbJ45ll2md7CHoqaiQKfw+5QcRE6NbQ+4wNnEZmx/wHFSer0iC
         kQX7heE3R3IoZFPdILuhcOg+KUcAKEo5X4/6vF4ztVa/j8YsBltcxGpENcXfhXF3ABUF
         Song==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972694; x=1706577494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6lo1t0xIINgMF9rkW3F98A1LhixJMkR04sT2kjXH0U=;
        b=k0icTBOq6iDe+ArpfEbLQzZY/Cp/66H9qTTcGz1+gAor1f2K2crpNs14iCiX8h10ZN
         4pLVr7EPtSiCbgsUq37zw+xuvjHTOe+/v+Y5a+STmI8HFoIhHTUDkzZGikEzvMKBzM1L
         Yxb4OqfCk0sJmhtef2hgd9bMj36Zd2mfF8AHSPiOmPgP1H0Ht5Z5g3JtfhAqzikpk9dS
         VIaOBJPuYZCTNXrVPzuolWqMw5KFh/Klj1CKxA1HMlfZxO+qdq9vk2iuicFHPHeXjBtq
         Vx4fo2u0oaquz7gx82gBBTFEtA+xw69Nbu+D6gbTSXfWPv/1IXmMJnjjNcnjqmy1lvlg
         v77A==
X-Gm-Message-State: AOJu0YzLWqTOxxp3aPv8SkiINWqGVlfbQPhWBXcZw/62FIxGENXsHcCj
	q+9ZoBz1csHyvk4bxpH2xCtJp6SKUoou1h4dRWsvS3nKTBcKhOqlBNvMA6v7fesAmfjmwgLx2CE
	YUgx/bkP55843md76HKBzoNcyik4=
X-Google-Smtp-Source: AGHT+IEZviig2ABwI+Udm06OKNNEtIsVzvahiXfDsMin+LKRvil70+W7da5h9vtTL+44GHv7o1I4liutXvYTauIlvGw=
X-Received: by 2002:a05:6402:3552:b0:556:cda3:469c with SMTP id
 f18-20020a056402355200b00556cda3469cmr258947edd.153.1705972693986; Mon, 22
 Jan 2024 17:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-5-nunes.erico@gmail.com> <20240121095604.2368-1-hdanton@sina.com>
 <CAKGbVbtww65w+sr7OiccawRkGt-p3MRWaWNU=nkQTaqdyMxqVA@mail.gmail.com> <CAK4VdL2oRsvCMAWsMyvT+MpPz5e=7=mVtMWAbJKopLEOM0_A+w@mail.gmail.com>
In-Reply-To: <CAK4VdL2oRsvCMAWsMyvT+MpPz5e=7=mVtMWAbJKopLEOM0_A+w@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 23 Jan 2024 09:18:02 +0800
Message-ID: <CAKGbVbu18v_f4N0nGQAKmTZa5Dijy7u1GMqOrggthrXCsYzyRg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 11:11=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> On Sun, Jan 21, 2024 at 12:20=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrot=
e:
> >
> > On Sun, Jan 21, 2024 at 5:56=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > >
> > > On Wed, 17 Jan 2024 04:12:10 +0100 Erico Nunes <nunes.erico@gmail.com=
>
> > > >
> > > > @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_time=
dout_job(struct drm_sched_job *job
> > > >       struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
> > > >       struct lima_sched_task *task =3D to_lima_task(job);
> > > >       struct lima_device *ldev =3D pipe->ldev;
> > > > +     struct lima_ip *ip =3D pipe->processor[0];
> > > > +
> > > > +     /*
> > > > +      * If the GPU managed to complete this jobs fence, the timeou=
t is
> > > > +      * spurious. Bail out.
> > > > +      */
> > > > +     if (dma_fence_is_signaled(task->done_fence)) {
> > > > +             DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> > > > +             return DRM_GPU_SCHED_STAT_NOMINAL;
> > > > +     }
> > >
> > > Given 500ms in lima_sched_pipe_init(), no timeout is spurious by defi=
ne,
> > > and stop selling bandaid like this because you have options like loca=
ting
> > > the reasons behind timeout.
> >
> > This chang do look like to aim for 2FPS apps. Maybe 500ms is too short
> > for week mali4x0 gpus (2FPS apps appear more likely). AMD/NV GPU uses
> > 10s timeout. So increasing the timeout seems to be an equivalent and be=
tter
> > way?
>
> Indeed 500ms might be too optimistic for the sort of applications that
> users expect to run on this hardware currently. For a more similar
> reference though, other embedded drivers like v3d and panfrost do
> still set it to 500ms. Note that this patch is just exactly the same
> as exists in Panfrost today and was already discussed with some common
> arguments in the patches of this series:
> https://patchwork.freedesktop.org/series/120820/
>
> But I would agree to bump the timeout to a higher value for lima. Some
> distributions are already doing this with module parameters anyway to
> even be able to run some more demanding application stacks on a Mali
> 400.
>
> Another thing we might consider (probably in a followup patchset to
> not delay these fixes forever for the people hitting this issue) is to
> configure the Mali hardware watchdog to the value that we would like
> as a timeout. That way we would get timeout jobs going through the
> same error irq path as other hardware error jobs and might be able to
> delete(?)/simplify this software timeout code.
>
This way should be much simpler and stable.

> In the meantime for v2 of this series I'll make the change to account
> for the multiple pp irqs. So do you agree it is ok to leave
> drm_sched_stop() as it is at least for this series?
>
I'm OK with this.

> Thanks all for the reviews
>
> Erico

