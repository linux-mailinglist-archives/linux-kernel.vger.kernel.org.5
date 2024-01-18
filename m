Return-Path: <linux-kernel+bounces-29628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB88310F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B53F28247E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809832907;
	Thu, 18 Jan 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZChZyTO"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6C2573
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541809; cv=none; b=Tm42SFN6nl97TVt7CpCIasMGz462XOe5kJ9CNq/SQuciFpx0yIJ4YtTV9+6Cfc0VgZze9MxQDxO4g+pefILcznJhYdKbBq8P1CW7RyKm3dDS4ZDmnm6a/GRLBRnUJ6Wm2Z4Omww06+yzTGzERiP58LZ8K2HEq8x8H/8pzcVyF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541809; c=relaxed/simple;
	bh=fCjJTQ0T8ZghaSVeIk3V2+3NUH/0zGOOdoK+C9NKiXQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=LT7MtBqEw5XeJ9bDFcicu7jVUpmsShbN/dBztIrvla3ym9u0UPvrTyJ2PjzBC1KoNJ8tXSxxms3sI9D6qOzTtJHfB8H+N/8b8UA/Bmp2iqbGQQqsusdBOuTy4hUG4rTUa0ReLRU2q0RCLB7b/pcOMaWJGcm/OYZ5R/UXgr1GSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZChZyTO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55969c01168so445073a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705541806; x=1706146606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z9m6hPmqmYL+JFz3wIA/pboCcBVyWFCc3DeuY26Ipc=;
        b=QZChZyTOsyvPu3KjcSLG3xFZqzNlPspAFw7GR7slZ3MNks0QblSeGMrOsOFplkMd5K
         TlosFMVKtaoWum7sURenPpkcacjH7oceXvpramX/24N/Fxy9xNYQ7cNfYxRrbdQLiWEL
         mzXmWidHWW53NY3BMk6b+XIvv2MGUsdt5VrDBD1SPSpcB67jM69EY3ccYNUJmiB/ODQ1
         n0Y0EM6Iz3BcjEwg3fmPWPCzQpTcDKfNxloaWbG7q1qHwpbfgcFxn/jrSyf2m5uzRlKA
         LVlNq5RjCCAW+6XuOcd9Q/ScmU9b9E8YS70nvfthyqZWLtvzgrZFpHOA3rlayhrF208F
         4j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705541806; x=1706146606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z9m6hPmqmYL+JFz3wIA/pboCcBVyWFCc3DeuY26Ipc=;
        b=LLc0bz18pKB9i/OBlJmEg6vvApx0WaolxFsznAMwK/JtU7ppbF5/8bnXQVOlwcm5+U
         NlHTEs/CZwve5q3XW1vSiVg8J8kRSKG0yb4i+Z7bB8CZrJeQuoBVrJrTSI9Y4a1CdvCh
         +FLy+6CWRjUnJlkA7UEgyeKbbV4i12MDguKF3tQHF7Xoq/pZX34VP3jx2oe4tuCFUmBL
         iNe2CEAVfsL+KEA44eWvYwv0X9eFT69s5C7cKiqCouXYjPCSTvG2GwIT1E8tw4mC3Nem
         jyqYdAcodF5+6RQmKyMpSW6EFvpag/dHFkfnoxhpm4Wrhf+ll9YghLKnrb9WCTk/mz++
         XWcQ==
X-Gm-Message-State: AOJu0Yz2BfvU2y8c7jvb/OB5FrpBVDTI6ClQ4H7wwC8y/9Q7mLbe07GK
	YnC5VF313IyPDArpPH9VFZD2KpnQM7ZglOFLo5kr0dYOOt3TBj6eghVCACPVqnLKgDSdgCuNpDw
	lkFzCykytmhi+ETLg62V9F4YdcME=
X-Google-Smtp-Source: AGHT+IHgWZI8AyD36IA/j+qIgY8kij60I7dsU7WVURaWdH6KDArdEvwF/vu64DZAMjqwazkjqO/cRYqasTD2XUY1eJc=
X-Received: by 2002:aa7:c305:0:b0:557:c568:1d03 with SMTP id
 l5-20020aa7c305000000b00557c5681d03mr186663edq.1.1705541806339; Wed, 17 Jan
 2024 17:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-2-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-2-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 18 Jan 2024 09:36:34 +0800
Message-ID: <CAKGbVbsydzXyKuhN8VyW9zYwuOMWzvz192WKKReHVX1XCnuXGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/lima: fix devfreq refcount imbalance for job timeouts
To: Erico Nunes <nunes.erico@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So this is caused by same job trigger both done and timeout handling?
I think a better way to solve this is to make sure only one handler
(done or timeout) process the job instead of just making lima_pm_idle()
unique.

Regards,
Qiang

On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> In case a task manages to complete but it took just long enough to also
> trigger the timeout handler, the current code results in a refcount
> imbalance on lima_pm_idle.
>
> While this can be a rare occurrence, when it happens it may fill user
> logs with stack traces such as:
>
> [10136.669170] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/lima/lima_devfre=
q.c:205 lima_devfreq_record_idle+0xa0/0xb0
> ...
> [10136.669459] pc : lima_devfreq_record_idle+0xa0/0xb0
> ...
> [10136.669628] Call trace:
> [10136.669634]  lima_devfreq_record_idle+0xa0/0xb0
> [10136.669646]  lima_sched_pipe_task_done+0x5c/0xb0
> [10136.669656]  lima_gp_irq_handler+0xa8/0x120
> [10136.669666]  __handle_irq_event_percpu+0x48/0x160
> [10136.669679]  handle_irq_event+0x4c/0xc0
>
> The imbalance happens because lima_sched_pipe_task_done() already calls
> lima_pm_idle for this case if there was no error.
> Check the error flag in the timeout handler to ensure we can never run
> into this case.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index c3bf8cda8498..66317296d831 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -427,7 +427,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_jo=
b(struct drm_sched_job *job
>         pipe->current_vm =3D NULL;
>         pipe->current_task =3D NULL;
>
> -       lima_pm_idle(ldev);
> +       if (pipe->error)
> +               lima_pm_idle(ldev);
>
>         drm_sched_resubmit_jobs(&pipe->base);
>         drm_sched_start(&pipe->base, true);
> --
> 2.43.0
>

