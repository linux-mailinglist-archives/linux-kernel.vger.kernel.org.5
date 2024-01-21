Return-Path: <linux-kernel+bounces-32028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA0835577
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48633B20F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A136AE3;
	Sun, 21 Jan 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqAcFhDE"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890C364D6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705836031; cv=none; b=PYreYoo76fqWjd/9RFfxnx0fvvajSGz2eOYeqZQdiKFcoIGHIEc89hNNwFvU0AUX/U6AiVzi+ygRYEzamUd3xPSTGs4XaArl5U1RMRpNSnvZY/onlKzdJ6STCYVO0wUoPORlll+lmYTJmZ+pr0wNuKoe0wmYoHY5WaLjjJ2SMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705836031; c=relaxed/simple;
	bh=MsejbbmqBqx7eCDxooPep1228YLUuA5VIqvRrgE3xrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8LyEEOKIfW8msQgN40bxHF7YLbuDmiP9nWjwKb/Cf7ZE6cazsrEGwkPN4OAu8e4Owinm+4oNiCAQhVZUoMk0hv2XP1BzIgKeilhQ8IqzZPWYacB0+ZmwVCugMp5vAz+O85pnSHi040nCmt6CUtljT7eqSEjK4Ys0avFggQ6fuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqAcFhDE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so2313355a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 03:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705836027; x=1706440827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9m8SPIHaGEo52lnFVreqQCDGwIx3Neobr40t4uq1CM=;
        b=FqAcFhDE04qL7IxvgP89hRHq3X36uK6KupTkx9yNq01C+JIup9U95RmQR8gdGmSwbe
         e+Bwa1Cz0CjiigprWZnI7LQSJqegvER2TXt1s4En4IBf+omEZ6+SNQaonBKE63iSXiH0
         eQmZlzqUEjmE1YnkosOgnFBtLbyIg1A6kykZLSPCnirQQAPVm03xvT8vrLmhpAnfJgcP
         zehcNhBOw2jgR6ZVT+3A4b58yq7HShKP+q+MMvY1QR0tutbOHbGF1N7gT7Q0/yRvDUAZ
         m8VPEhp+sluCrHSB9lhChEKy5VvljyJ1IWFwaSpG6dxCPd/yxuLQBtdjP+W2DeQli3l4
         qwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705836027; x=1706440827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9m8SPIHaGEo52lnFVreqQCDGwIx3Neobr40t4uq1CM=;
        b=mvNrl5BKN6OuRY5Xo3WLeO4avbgmKhdMhuJW5H1DKSqrOGfKGp2fiPR14QhXq1Eysm
         +F1uZ/FW4xIgsHxwme0besPpqRNwjievyF35w7kbwtL3jBJ65Fz+FL8jIhDV6pXnzh8Y
         0qX+PHLebkpaC2COKKrq2B+nV2jOPDtDwPRUdtXuupfwO3hL0ExebzqWfYdiUYrjGVr3
         yHaRQCVruEwzGFnCMR+hd2MdFQBpTJ+4tV2ZUGyYtChV+KG1G68p0JwaP/AkED6EyFOs
         TG3y2RFNyU4xy1d+tUpoI3MK3WzFfYDGmTug/JAFXjTn1jB1tTfOa9je8JfjvTgX54WO
         b4Mg==
X-Gm-Message-State: AOJu0YxFK4wJt+qBR0tBYfGW7e97Cncpu4kaFaCXIPxdp0A5fVk5PaW8
	xvp/GXuJiryGbksO0Z/MxdeN/5WvHZhWWhBAWCqYcsKlxbaW9O3H5c71pZvGSwJwx1VM/8r4LpL
	ybdlP9qR4VVIDcURVH9wCk3QqaAbJc8NfqJb14Q==
X-Google-Smtp-Source: AGHT+IEjBKv24wNHFLHNJEzyCx8YAMkyNuZ0jO0Q2lDUZ/PAPR8NKuAMZSCk4sid+hCoOO7cmEBAFSgmiGj2nHvnUuM=
X-Received: by 2002:a50:fa88:0:b0:55b:fece:de8e with SMTP id
 w8-20020a50fa88000000b0055bfecede8emr746252edr.13.1705836027398; Sun, 21 Jan
 2024 03:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-5-nunes.erico@gmail.com> <20240121095604.2368-1-hdanton@sina.com>
In-Reply-To: <20240121095604.2368-1-hdanton@sina.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Sun, 21 Jan 2024 19:20:14 +0800
Message-ID: <CAKGbVbtww65w+sr7OiccawRkGt-p3MRWaWNU=nkQTaqdyMxqVA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Hillf Danton <hdanton@sina.com>
Cc: Erico Nunes <nunes.erico@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 5:56=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Wed, 17 Jan 2024 04:12:10 +0100 Erico Nunes <nunes.erico@gmail.com>
> >
> > @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedout=
_job(struct drm_sched_job *job
> >       struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
> >       struct lima_sched_task *task =3D to_lima_task(job);
> >       struct lima_device *ldev =3D pipe->ldev;
> > +     struct lima_ip *ip =3D pipe->processor[0];
> > +
> > +     /*
> > +      * If the GPU managed to complete this jobs fence, the timeout is
> > +      * spurious. Bail out.
> > +      */
> > +     if (dma_fence_is_signaled(task->done_fence)) {
> > +             DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> > +             return DRM_GPU_SCHED_STAT_NOMINAL;
> > +     }
>
> Given 500ms in lima_sched_pipe_init(), no timeout is spurious by define,
> and stop selling bandaid like this because you have options like locating
> the reasons behind timeout.

This chang do look like to aim for 2FPS apps. Maybe 500ms is too short
for week mali4x0 gpus (2FPS apps appear more likely). AMD/NV GPU uses
10s timeout. So increasing the timeout seems to be an equivalent and better
way?

> > +
> > +     /*
> > +      * Lima IRQ handler may take a long time to process an interrupt
> > +      * if there is another IRQ handler hogging the processing.
> > +      * In order to catch such cases and not report spurious Lima job
> > +      * timeouts, synchronize the IRQ handler and re-check the fence
> > +      * status.
> > +      */
> > +     synchronize_irq(ip->irq);
> > +
> > +     if (dma_fence_is_signaled(task->done_fence)) {
> > +             DRM_WARN("%s unexpectedly high interrupt latency\n", lima=
_ip_name(ip));
> > +             return DRM_GPU_SCHED_STAT_NOMINAL;
> > +     }
> >
> >       if (!pipe->error)
> > -             DRM_ERROR("lima job timeout\n");
> > +             DRM_ERROR("%s lima job timeout\n", lima_ip_name(ip));
> >
> >       drm_sched_stop(&pipe->base, &task->base);
> >

