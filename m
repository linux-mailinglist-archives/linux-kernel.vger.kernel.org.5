Return-Path: <linux-kernel+bounces-36182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07568839D23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2631F2BEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAF53E2F;
	Tue, 23 Jan 2024 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prc0UqJX"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4B53E17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051972; cv=none; b=fMAgs3PAGT8o0uobjVo9baAUQLDZQ7IaaMKxLlZ4tzpk6h3+BNZ8ZxwcYkt/7knCNIA/X+sJf5Tcl59XGzXOHi89mfdWyEO4bY4N+I4KXAdvbgUG4dgzBriPhqSmjWAO3Fjr+msl1eQyVLd4v20FTp5S7A06IG7dNZdPLMiZlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051972; c=relaxed/simple;
	bh=M5lsjQAMvmARbfng+ZC+oAy6Jm5m8MdlGzyMgcVRFUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thHDqZerFfQFEpWIJxBPEuO/W19bT8U0KIjfgF50oyzV0cCC903JIjrhrrG4Til/fuwZ+yFxZOJ5wsjyAnWgPgH+eOZgwdQpNr40lLWd3gN9aqnG/RSoIOi5W8o2cPxzD11qcVd8DlUaYDF1JX0fU++l1fWAbCAXv3E4UmR1lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prc0UqJX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so6206768e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706051969; x=1706656769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5lsjQAMvmARbfng+ZC+oAy6Jm5m8MdlGzyMgcVRFUw=;
        b=Prc0UqJXFQW1h159+kBcEQAajHjsNj+attn2p4THHUUEg/w46FimwBsoAmdXltnsyu
         IE5ILrl4xIHJO0STpkcUqGqxtlI8P/hL+4CJ79oLrNY6wti6w3dHjPE849EsDLuV2ZPs
         exf/wDl01OtdaD/A/yBBuxNiB6b0ZEvwJ+zLOu8cvCfuGf+ZiUY4HZvYrYGDaDemCY00
         3DDAlxs2wGtLjmwWgKj1T0EyZm8XrRSrw4fNl/vjOi0SRVohwIDMb7ZBE9GKQDlQLMqY
         EFTIKmd56pewOUrP/PuZ2dviBClLbixb5o4KW25zukshNdnQjtjNwypxezyaPpYP/6e7
         n0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051969; x=1706656769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5lsjQAMvmARbfng+ZC+oAy6Jm5m8MdlGzyMgcVRFUw=;
        b=YUcR2wZX8dNuz+L6+nNg+Oz1IS9jko4UWAz8abLE8CdHgerBk9qVKfL27PD8RGcFtA
         SqxVckFn7f8iZ6ugDk0pTA1L1PDk5PVH1X4chn9IWUzVxJ6bh0dxT3cy4Xg2PdBx2d0m
         sX4ZswVigOEGCKtUz9ghuIHTnIeiteidMzrhkZO2BdY6UrgYfp8hlJ1WmRnYLxzuog4R
         MtNTiYj3noEV4/S+ZlpkORBiSMv3OZ3jflUrzBTydxAmMqBnLAMLj3I5Io6WCiDaiJKA
         YmgIMlZFS1keFIo49ny6YjP1p2wthnOXYp8D/miWHHrgohx6Sjl/0CrQyvs8IFEUoTIC
         Nmig==
X-Gm-Message-State: AOJu0YwtbyN6OKkLC/EatJa1KSVqiX+oRgcTAH/Ov56OeLKCaYmckyW6
	u4MFfkYiW78GWNsrOZ+4a6TeazmJShzAQ2o+ytqS2ZJw0xSWcTICLbkgxkTV4oOrUrPgde1NLtx
	jpLtqs0+ayUa5E/L7VOKGGMwkE3k=
X-Google-Smtp-Source: AGHT+IGmy9LMF8+huaUJrVNG3UM69DsTbGNL9dgDDYl1j0VON7S/Thj0pZyWpIbibwenLY1MV4W5JsIVYCYyGY4la/g=
X-Received: by 2002:a05:6512:114c:b0:50e:d71a:ebd0 with SMTP id
 m12-20020a056512114c00b0050ed71aebd0mr3518760lfg.40.1706051968883; Tue, 23
 Jan 2024 15:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-2-nunes.erico@gmail.com> <CAKGbVbsydzXyKuhN8VyW9zYwuOMWzvz192WKKReHVX1XCnuXGQ@mail.gmail.com>
 <CAK4VdL2PnWTZ+M2eQqF22+VuF-YGKb_WjG=168BcuBDqD8+9kA@mail.gmail.com> <CAKGbVbvWAM64T+a6_VRL99araN_2dubu4vO=mqzCoC1p2m_X-g@mail.gmail.com>
In-Reply-To: <CAKGbVbvWAM64T+a6_VRL99araN_2dubu4vO=mqzCoC1p2m_X-g@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Wed, 24 Jan 2024 00:19:16 +0100
Message-ID: <CAK4VdL3Tp33Wi5fmsh92XFWP8GE3TZMa473a=FeZajgnHn2mbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/lima: fix devfreq refcount imbalance for job timeouts
To: Qiang Yu <yuq825@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:50=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Thu, Jan 18, 2024 at 7:14=E2=80=AFPM Erico Nunes <nunes.erico@gmail.co=
m> wrote:
> >
> > On Thu, Jan 18, 2024 at 2:36=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wro=
te:
> > >
> > > So this is caused by same job trigger both done and timeout handling?
> > > I think a better way to solve this is to make sure only one handler
> > > (done or timeout) process the job instead of just making lima_pm_idle=
()
> > > unique.
> >
> > It's not very clear to me how to best ensure that, with the drm_sched
> > software timeout and the irq happening potentially at the same time.
> This could be done by stopping scheduler run more job and disable
> GP/PP interrupt. Then after sync irq, there should be no more new
> irq gets in when we handling timeout.
>
> > I think patch 4 in this series describes and covers the most common
> > case that this would be hit. So maybe now this patch could be dropped
> > in favour of just that one.
> Yes.

After dropping the patch while testing to send v2, I managed to
reproduce this issue again.
Looking at a trace it seems that this actually happened with the test workl=
oad:
lima_sched_timedout_job -> (fence by is not signaled and new fence
check is passed) -> irq happens preempting lima_sched_timedout_job,
fence is signaled and lima_pm_idle called once at
lima_sched_pipe_task_done -> lima_sched_timedout_job continues and
calls lima_pm_idle again

So I think we still need this patch to at least prevent the bug with
the current software timeout. If we move to the hardware watchdog
timeout later we might be able to remove it anyway, but that will
still require separate work and testing.

Erico

