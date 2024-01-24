Return-Path: <linux-kernel+bounces-36255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2629839DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F7AB2224B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F211866;
	Wed, 24 Jan 2024 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STYybsmB"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02351841
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058256; cv=none; b=hnP6yD4P7NOtrP/F3SMrsV0FfODvr1is+ahB/ydVuEMck1KovDBO6lcLQezUYQR2p4THeBWAOTS54moqFDMLFOIXHvWB1en3UdkkT3TNfK2mK4D+ea0/GD0z+jLimpv22Pwcsv/Vx9O83/kLfznwPxQpzgaQYk3kl8mSO/iqrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058256; c=relaxed/simple;
	bh=Oq5Oc44lN6Y/fdmZbA+lICY4LBnbi9LJB6fS0kTmo50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUUkwZRCANFXh38lh7lGFr4ok3pZpGGyRvqEditPWB+Seff7ReXsAKQyzc8lNqGS4gLUv/pzXnh5D0Tr2B9RUJCQIjEw5kbOEkAZTyHC8wbrWvo6/8YOHYjmKrsR1q8RhA3lwW9/kxlr0c7+Z9DRAkYtplbwPhjDvapJE/RN1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STYybsmB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5802552a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706058253; x=1706663053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oq5Oc44lN6Y/fdmZbA+lICY4LBnbi9LJB6fS0kTmo50=;
        b=STYybsmBSPeTp3nyCuCkKVU6J37H1hHKsZD4aGUOonGDhH6NOfXvmx2zJ/466Nk8UF
         OCXZoUReYYfjsMLpWTE6Xwjfkx9t11omSeJ5YLOGqFC5CyhDlWU5E1f/gAtEe3G+SMiH
         /61Qgm/kxY/Y5l2kPKqDqCGMm9jpwqYH/a5GRQeiDEzWi4YUyrSBHQYrWbcAnEuSwBhu
         riDgFcyq7bjsictAKBDycTDJpKg2MWLOhgJxejZqazvO9RLDluKbbV3rtBtSwEIqEHO6
         wKnng2mG7wWt8KhAXqvV8e5WE0nEk116M+KC10uShioY56D7NW7IOv2qT3JatqHo5825
         3+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706058253; x=1706663053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oq5Oc44lN6Y/fdmZbA+lICY4LBnbi9LJB6fS0kTmo50=;
        b=Kp9tKn9cQ47M/aIsSBgLIgg5VLdfN3Al/PJcCibeQyTjCXik+GE1E944uZITGKn4Ia
         qpydfdDYmhcnsH0BA4ZrTiwgPAi/mzpz5abaznWqMJTiKG0AblZR0IVM2NmekoBCmZX3
         GUgZFz/BhuKrNDf17B3J4arnQ5IOx63aVjXGvE2d8EvxfLque+W8WcjucJb7zffBe712
         DlL9QGIh+7WmoW7uF3OaFK5SHF3Bz/TdSLXFEOX5A6ayYLGpCwoKVYOwp9yKZLTLALnC
         hDMC5nYv5kIcz4MQ+3VHdLF4iB1KbWW6HXfcD+3gyIpVVpQn2bT9Cn6NTKN6imev+KbO
         iyeQ==
X-Gm-Message-State: AOJu0YwBsLzBxo/27kE9DcaJjxxpVNrFrCqWtwZ0hKEVflhBQNdYXMNp
	6BF3N8Snr738rS7B/VblKXKqdpqjoiV0iS9NTr/tHZFSjT8vX2LCFHxuZmS0MjKMUwglHSRtsFA
	hIKl3WvorlT1eEJC95Q1rmRahnbY=
X-Google-Smtp-Source: AGHT+IEInUKF+6tZk6TsgyVVN7h6LAF89fWaSLdEWwIidNLYKA6PQx6rGaHVRXnYyIl2i/OhkyDb7gSTxH/atAAjDI4=
X-Received: by 2002:aa7:db59:0:b0:55a:5608:8bb3 with SMTP id
 n25-20020aa7db59000000b0055a56088bb3mr1352541edt.57.1706058252729; Tue, 23
 Jan 2024 17:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-2-nunes.erico@gmail.com> <CAKGbVbsydzXyKuhN8VyW9zYwuOMWzvz192WKKReHVX1XCnuXGQ@mail.gmail.com>
 <CAK4VdL2PnWTZ+M2eQqF22+VuF-YGKb_WjG=168BcuBDqD8+9kA@mail.gmail.com>
 <CAKGbVbvWAM64T+a6_VRL99araN_2dubu4vO=mqzCoC1p2m_X-g@mail.gmail.com> <CAK4VdL3Tp33Wi5fmsh92XFWP8GE3TZMa473a=FeZajgnHn2mbA@mail.gmail.com>
In-Reply-To: <CAK4VdL3Tp33Wi5fmsh92XFWP8GE3TZMa473a=FeZajgnHn2mbA@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Wed, 24 Jan 2024 09:03:59 +0800
Message-ID: <CAKGbVbsw+19VFJXmeYsk6SPP+uZtwXHrvxuQuebRFnTGdFuBFQ@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 7:19=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> On Fri, Jan 19, 2024 at 2:50=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote=
:
> >
> > On Thu, Jan 18, 2024 at 7:14=E2=80=AFPM Erico Nunes <nunes.erico@gmail.=
com> wrote:
> > >
> > > On Thu, Jan 18, 2024 at 2:36=E2=80=AFAM Qiang Yu <yuq825@gmail.com> w=
rote:
> > > >
> > > > So this is caused by same job trigger both done and timeout handlin=
g?
> > > > I think a better way to solve this is to make sure only one handler
> > > > (done or timeout) process the job instead of just making lima_pm_id=
le()
> > > > unique.
> > >
> > > It's not very clear to me how to best ensure that, with the drm_sched
> > > software timeout and the irq happening potentially at the same time.
> > This could be done by stopping scheduler run more job and disable
> > GP/PP interrupt. Then after sync irq, there should be no more new
> > irq gets in when we handling timeout.
> >
> > > I think patch 4 in this series describes and covers the most common
> > > case that this would be hit. So maybe now this patch could be dropped
> > > in favour of just that one.
> > Yes.
>
> After dropping the patch while testing to send v2, I managed to
> reproduce this issue again.
> Looking at a trace it seems that this actually happened with the test wor=
kload:
> lima_sched_timedout_job -> (fence by is not signaled and new fence
> check is passed) -> irq happens preempting lima_sched_timedout_job,
> fence is signaled and lima_pm_idle called once at
> lima_sched_pipe_task_done -> lima_sched_timedout_job continues and
> calls lima_pm_idle again
>
> So I think we still need this patch to at least prevent the bug with
> the current software timeout. If we move to the hardware watchdog
> timeout later we might be able to remove it anyway, but that will
> still require separate work and testing.
>
Then you do need to solve the IRQ and reset race by disabling GP/PP
IRQ and sync irq after drm_sched_stop(). I mean you may keep the
patch 4 for spurious timeout, and add a new patch for solving the IRQ
and reset race.

Disable pm idle does not solve the race completely, other reset logic
may also conflict if not sequence the IRQ and reset .

