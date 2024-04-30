Return-Path: <linux-kernel+bounces-163546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A88B6CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BDD1F23D96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C341272D6;
	Tue, 30 Apr 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YqU7MWks"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B991272C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466183; cv=none; b=iHpBpxXuKk8Nun9x/bo8EQEJRp+YHw50UJdWr5yudY2RQq+t1/mUEd8Y9mxb741bv+ztKwOZEqT6KvZZsC+2LPFbiSfjZNIt+O3XxI36TBjbH53frPN5FSwrIoFsk87FfIyZjmAquDYNWr63py/OG4G2ROA4A4Ryf4VBatPgF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466183; c=relaxed/simple;
	bh=PKJi23ZEdp7YSR9RP6FGfNy1KIVhPpmIoZUapBG4h5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTSxJThS/teq/wCrOHuBuRsX+OSqtqvvIkuKgOWRP3qxFb3yR/P11o6hv4arUy3K5JOkmV+05T3jGUIgiULow/+g7nQ9Er8ECU2LnQEY7FuzcTXkvni0H9Gv1Fi252xOCZwu80LYlVHVTg+WPj4B9eF74ccs2qNGjiscPmEdEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=YqU7MWks; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db239711ebso13156971fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714466180; x=1715070980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGVB/W5mrOB3l6iBdxjqJlIucqWuwhmZ4dypg7eBhxs=;
        b=YqU7MWksncHXC0tX3fNsSQaLaT5WAvmVIzit9W4+01+9qGPSIXf2hpe5Tu2cAehpEL
         n2vidwII33xKgMqhxxT2XuU7TCv1XJxfyT/0whnqOGxVy/meFvPukX3QuSggj49OLt3/
         IIvcJjpY4pYaZczCvDhn7xCGfmLiaalQ1PoYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466180; x=1715070980;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGVB/W5mrOB3l6iBdxjqJlIucqWuwhmZ4dypg7eBhxs=;
        b=pB0zQ3nNPd4lmPhUL3ETBk53yswSeqvfz7BAHjXVB7o8XPCCEPg1PYbJBMCb6lEseg
         jSczPpuNmcBNqtwtFsCcT3uPZ3UbDS8cnBKWGSInGr6X/pgoIB4XBo970v0FcyoMDUyf
         xJL9bclSE+g5LXud3s5Vqkwe2OZ9RKz7A+hroqCe0saPvFm3Ii19/iP6fc/eo1IepQ5b
         SEuUZH6dVFkjX7gbZkB6m6PgVui1NIlmZx6jpUVYY4+XUiybSYZxE/HgAZO8G0ZB5sKt
         i6n8Z/j78cIpvOjLih6g8ZlClK1uumBgpyojnQi2gYbno/q5Tl8NEEa0W9I9Loa2enJa
         bB5A==
X-Forwarded-Encrypted: i=1; AJvYcCUO0GpkpgnTd0sbpkcZeIaLCHxcEjnR0w0c+wWhwTR5fUbeLz+HdrklgCBPy3MMUlrganjJ7upmsgJ6AnX4VPLXWjx+myWUTGOlWVFB
X-Gm-Message-State: AOJu0YwV7FtuXOj6AjYqnkDIdx2SOJMfdNwHl81bgORt4U/RtJoyOPyx
	1AQVlVAfvPKeJZDeZRBgmTcjgAiuDb2gvOQRchwwOzNF1qFI1mbXm6aEaHw6QPk=
X-Google-Smtp-Source: AGHT+IEYFTGK3s8lpOgKS5ZwMqfeIgo5p84oT5kN52Xbo3XKHDHug3/cbMfIkcCiFuK9z1+GK7/Cnw==
X-Received: by 2002:a19:381a:0:b0:513:9d6b:6d6d with SMTP id f26-20020a19381a000000b005139d6b6d6dmr7386406lfa.5.1714466179684;
        Tue, 30 Apr 2024 01:36:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0041be78ae1f0sm11303980wmq.2.2024.04.30.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:36:19 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:36:17 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Brandon Pollack <brpol@chromium.org>
Cc: marius.vlad@collabora.com, mairacanal@riseup.net, jshargo@chromium.org,
	hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
	linux-doc@vger.kernel.org, hirono@chromium.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	melissa.srw@gmail.com, mduggan@chromium.org, mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH v6 0/7] Adds support for ConfigFS to VKMS!
Message-ID: <ZjCtgSaL50YrS-F-@phenom.ffwll.local>
Mail-Followup-To: Brandon Pollack <brpol@chromium.org>,
	marius.vlad@collabora.com, mairacanal@riseup.net,
	jshargo@chromium.org, hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com, linux-doc@vger.kernel.org,
	hirono@chromium.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
	mduggan@chromium.org, mripard@kernel.org, tzimmermann@suse.de
References: <20230829053201.423261-1-brpol@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829053201.423261-1-brpol@chromium.org>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, Aug 29, 2023 at 05:30:52AM +0000, Brandon Pollack wrote:
> Since Jim is busy with other work and I'm working on some things that
> rely on this, I've taken up the task of doing the iterations.  I've
> addressed the comments as best I can (those replies are to each
> individual change) and here is the patch set to go with those.
> 
> I added my own signoff to each commit, but I've left jshargo@ as the
> author of all the commits he wrote.  I'm sure there is still more to
> address and the ICT tests that were writtein parallel to this may also
> need some additions, but I'm hoping we're in a good enough state to get
> this in and iterate from there soon.
> 
> Since V6:
> ========
> rmdirs for documentation examples
> fix crtc mask for writebacks
> 
> Since V5:
> ========
> Fixed some bad merge conflicts and locking behaviours as well as
> clarified some documentation, should be good to go now :)
> 
> Since V4:
> ========
> Fixed up some documentation as suggested by Marius
> Fixed up some bad locking as suggested by Marius
> Small fixes here and there (most have email responses to previous chain
> emails)
> 
> Since V3:
> ========
> I've added hotplug support in the latest patch.  This has been reviewed some
> and the notes from that review are addressed here as well.
> 
> Relevant/Utilizing work:
> =======================
> I've built a while test framework based on this as proof it functions (though
> I'm sure there may be lingering bugs!).  You can check that out on
> crrev.com if you are interested and need to get started yourself (but be
> aware of any licensing that may differ from the kernel itself!  Make
> sure you understand the license:
> 
> https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/LICENSE
> 
> That said, you can see the changes in review on the crrev gerrit:
> 
> https://chromium-review.googlesource.com/c/chromiumos/platform/tast-tests/+/4666669
> 
> Outro:
> =====
> I really appreciate everyone's input and tolerance in getting these
> changes in.  Jim's first patch series was this, and other than some
> small cleanups and documentation, taking over it is also mine.

Sorry for not having looked at this earlier. I think overall it's looking
good, mostly just a bunch of comments on lifetime/locking questions.

I'm also wondering a bit how much we want to go overboard with igt tests,
since the lifetime fun is quite big here. I think at least some basic
tests that trying to do nasty things like unbind the driver in sysfs and
then try to use configfs, or keeping the vkms_device alive with an open fd
and removing the configfs directory would be really good.

One thing that's a bit tricky is that configfs is considered uapi, so must
be stable forever. And I think that's actually the right thing for us,
since we want compositors and other projects to use this for their
testing. So unlike igt tests using special debugfs interfaces, which are
ok to be very tightly coupled to kernel releases

Cheers, Sima
> 
> Thank you everyone :)
> 
> Brandon Pollack (1):
>   drm/vkms Add hotplug support via configfs to VKMS.
> 
> Jim Shargo (6):
>   drm/vkms: Back VKMS with DRM memory management instead of static
>     objects
>   drm/vkms: Support multiple DRM objects (crtcs, etc.) per VKMS device
>   drm/vkms: Provide platform data when creating VKMS devices
>   drm/vkms: Add ConfigFS scaffolding to VKMS
>   drm/vkms: Support enabling ConfigFS devices
>   drm/vkms: Add a module param to enable/disable the default device
> 
>  Documentation/gpu/vkms.rst            |  20 +-
>  drivers/gpu/drm/Kconfig               |   1 +
>  drivers/gpu/drm/vkms/Makefile         |   1 +
>  drivers/gpu/drm/vkms/vkms_composer.c  |  30 +-
>  drivers/gpu/drm/vkms/vkms_configfs.c  | 723 ++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 102 ++--
>  drivers/gpu/drm/vkms/vkms_drv.c       | 206 +++++---
>  drivers/gpu/drm/vkms/vkms_drv.h       | 182 +++++--
>  drivers/gpu/drm/vkms/vkms_output.c    | 404 ++++++++++++--
>  drivers/gpu/drm/vkms/vkms_plane.c     |  44 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c |  42 +-
>  11 files changed, 1514 insertions(+), 241 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
> 
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

