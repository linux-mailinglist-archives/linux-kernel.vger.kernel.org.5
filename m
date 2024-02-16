Return-Path: <linux-kernel+bounces-68997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B4858323
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E44C2852C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD0130AF6;
	Fri, 16 Feb 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MbHfdr4v"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADD5465D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102641; cv=none; b=BA8jAuyytYWhLunoQUKk9ktt8Mcd0SWiG+Tl0QCUa1la5TUvyNkFRl44cwJIR3/rYSw23HwZ/qCubD5bexFFSwTBn+yTpl265TQC9nEl6wlPBkCKrnEV5CcuBJpwwuOaxZqWMEWlx12XcFnukIGI3Ds9sHjE6fg73pFx51JwV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102641; c=relaxed/simple;
	bh=3DZuNTpPAV7ON2bNBWe9a6b0uHPgEZJRF58/k9z+cxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKx8hjmuYLvjIIlc533A75ErL1A3O4QVM5HrCaB/KHvWZkQ5vLZdwexHGiDZlu/GQ+mwlo8AFXxLi6twesQHUb+RSWX+FZTSCQM99Q2HynwyDNCUVvmraY2/JfzZ7m2Tp2Xif16PYWWz23/woG6wmgTdTNIxOk+AW0DGUUqiLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=MbHfdr4v; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bc21303a35so770162b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1708102639; x=1708707439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a54mBlPJQ0nr4LxEOnQe6E9J05YCJwMg6dbDW6Ogvwk=;
        b=MbHfdr4vgQepVwmwGbfeCOOejVDfuL16CtfpBS75V2FNL9K5AfW60bjf9xyN8e0mgf
         c4dHehM+ZTpbC2Xt3NApctFRXrNDvxmOtBtVC086ZMccpVB7bXId+jCgkdm8lfhKrxsA
         WU0cKMm+D5NPJwigePTRT6YM1/H73P2HzUohY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102639; x=1708707439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a54mBlPJQ0nr4LxEOnQe6E9J05YCJwMg6dbDW6Ogvwk=;
        b=CfHE6OCGtXLghQs9Dql4uX18lImWUjpkTdSpsGb88pHnlS+c9vmzAMHBU5MydDIQsb
         sDwqeW1dWp7RQH/ObNnCo5/ngVKk7Tpnl3GoXct8mIkt3KmWB3507LyJHTe4usqdjQSH
         F4qztDiJer2PW2EZcebYyn3Y2f7PYT3mVNkeGR578ZMQXdnA4pJFf06p5bK/N9a2EWf0
         VGnsmrBktzddy0YNXrSk57c2o9jTIGZF/SUiHDy4VJb2olXs7E4toqSl6QbEYJoEplK6
         y2JxyEh3TZ8GXbkkvSdWqd2l57Hm3/GJFxo4lLQ/Nqt025Vp6OK7PyllD7mr6jsdB3nH
         Cm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT4xplah1Xs6iV4lFdw/mY5Qwq9Rqd9uhgLC2oAXe8KqYFvorF2DTPA/SXx6DB3KgHCB2g310lhmLtqTxgEXzvrdpdrI2ux2rW70f1
X-Gm-Message-State: AOJu0YxmXKw1pBf9KGH9NO4pXl7N9wLKUUUOD9YyPW+LyK/JkRelna8o
	X07Kyn1XvMet39lx54lL1QGEAjxFTLBZUXJl9chKy/LQ+LflcJ5cyMe5aDUXQWOU6r+4ausXsZl
	c6S59iDSCagDw+26ZqR73gXtUxGXAFsGakuA9jQ==
X-Google-Smtp-Source: AGHT+IFZi9RDzwhwyq7Vgbb6tf8+xOs817Ulf+ClWV8voToU7JWM1HF+f6JVnrAvqqhyZKtEyjz2rl5PGCwyv6GOjVw=
X-Received: by 2002:a05:6870:b528:b0:21e:3794:9e24 with SMTP id
 v40-20020a056870b52800b0021e37949e24mr5556668oap.3.1708102639106; Fri, 16 Feb
 2024 08:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214121435.3813983-1-adrian.larumbe@collabora.com> <ba987da3-b4aa-410c-95ae-434e94793d85@arm.com>
In-Reply-To: <ba987da3-b4aa-410c-95ae-434e94793d85@arm.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 16 Feb 2024 17:57:07 +0100
Message-ID: <CAKMK7uH=QKSyMgsOYCHMwE7iv6jQZRwUMcKq=HiXsBXBCv5BCQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Always record job cycle and timestamp information
To: Steven Price <steven.price@arm.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, 
	Lionel Landwerlin <lionel.g.landwerlin@linux.intel.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 01:52:05PM +0000, Steven Price wrote:
> Hi Adri=C3=A1n,
>
> On 14/02/2024 12:14, Adri=C3=A1n Larumbe wrote:
> > A driver user expressed interest in being able to access engine usage s=
tats
> > through fdinfo when debugfs is not built into their kernel. In the curr=
ent
> > implementation, this wasn't possible, because it was assumed even for
> > inflight jobs enabling the cycle counter and timestamp registers would
> > incur in additional power consumption, so both were kept disabled until
> > toggled through debugfs.
> >
> > A second read of the TRM made me think otherwise, but this is something
> > that would be best clarified by someone from ARM's side.
>
> I'm afraid I can't give a definitive answer. This will probably vary
> depending on implementation. The command register enables/disables
> "propagation" of the cycle/timestamp values. This propagation will cost
> some power (gates are getting toggled) but whether that power is
> completely in the noise of the GPU as a whole I can't say.
>
> The out-of-tree kbase driver only enables the counters for jobs
> explicitly marked (BASE_JD_REQ_PERMON) or due to an explicit connection
> from a profiler.
>
> I'd be happier moving the debugfs file to sysfs rather than assuming
> that the power consumption is small enough for all platforms.
>
> Ideally we'd have some sort of kernel interface for a profiler to inform
> the kernel what it is interested in, but I can't immediately see how to
> make that useful across different drivers. kbase's profiling support is
> great with our profiling tools, but there's a very strong connection
> between the two.

Yeah I'm not sure whether a magic (worse probably per-driver massively
different) file in sysfs is needed to enable gpu perf monitoring stats in
fdinfo.

I get that we do have a bit a gap because the linux perf pmu stuff is
global, and you want per-process, and there's kinda no per-process support
for perf stats for devices. But that's probably the direction we want to
go, not so much fdinfo. At least for hardware performance counters and
things like that.

Iirc the i915 pmu support had some integration for per-process support,
you might want to chat with Tvrtko for kernel side and Lionel for more
userspace side. At least if I'm not making a complete mess and my memory
is vaguely related to reality. Adding them both.

Cheers, Sima


>
> Steve
>
> > Adri=C3=A1n Larumbe (1):
> >   drm/panfrost: Always record job cycle and timestamp information
> >
> >  drivers/gpu/drm/panfrost/Makefile           |  2 --
> >  drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ------------------
> >  drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 ------------
> >  drivers/gpu/drm/panfrost/panfrost_device.h  |  1 -
> >  drivers/gpu/drm/panfrost/panfrost_drv.c     |  5 -----
> >  drivers/gpu/drm/panfrost/panfrost_job.c     | 24 ++++++++-------------
> >  drivers/gpu/drm/panfrost/panfrost_job.h     |  1 -
> >  7 files changed, 9 insertions(+), 59 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
> >  delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
> >
> >
> > base-commit: 6b1f93ea345947c94bf3a7a6e668a2acfd310918
>

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

