Return-Path: <linux-kernel+bounces-20941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1728287A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2357E1F22B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354739FC8;
	Tue,  9 Jan 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="URkF1jPc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4F39AF9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28cfca3c45so76158866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704808943; x=1705413743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV9bGbQzcy98B1lun6Bie281dTIH2X4e1zAwg2HwrZA=;
        b=URkF1jPc5H0qfL3z3eUELqXrEk8pt2xAPxSdrK2vkSjraYmJqBZn16UWlR3BMm6h6V
         7zBiaY4Bm7XKzU/QDW77DKMyp+rYM7L2QHUred8Fyzy6ZCMytuefMh1IhSmMV63xShqg
         JPJnzatqBloCwn9Sq5kZDHMPofF1kciXXgRJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808943; x=1705413743;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wV9bGbQzcy98B1lun6Bie281dTIH2X4e1zAwg2HwrZA=;
        b=vHxdVhmPj4Gfn6JhzHq1CyDovmIA8bWt4vdyegePzI1yrckoGG0DFLPpQVKr6anEnP
         yQ7FzWCuJeL5PKBbVFuS+JSMEAuo4eOzTtMdGs5HXPpcvVoGELieuin8dVvo7r41Ri+2
         OivVwEWHvtNOSto4bRWo7xPThylu9yush4isC23DBb2Q5h2zEZSmLKpPnd5Gw2h68UTP
         EYmvxRA9b4ALhCPpscGbC0xArK3l5Ey/BmdTgTzBbIGC3CCuE2Jlw8fC0xjzk9u1Pkut
         0CPmzuVuD+pjiTktmOVa2pch9qP7h6xgyY7T56kWBHDugnbKsldjdrxSmUltk42xv4QT
         6aDg==
X-Gm-Message-State: AOJu0YzMLLTKQKOajtUEMKGty3FiR8OtGZ3wsnPCiU4Pp5d1k72+jF07
	BGZJmhvCn4ixhLbJaEltatiQmxMPk/9uiw==
X-Google-Smtp-Source: AGHT+IGzXl9ZxQrKbZGeSLespIdBAH1IWl7cNLDW+XFoZzBONVJMhiWSJzoO9BZ/dAH+4MQcN+J7Bw==
X-Received: by 2002:a17:907:a0cf:b0:a28:34e5:b86e with SMTP id hw15-20020a170907a0cf00b00a2834e5b86emr5118851ejc.2.1704808943441;
        Tue, 09 Jan 2024 06:02:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m14-20020a170906580e00b00a28aa4871c7sm1059533ejq.205.2024.01.09.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:02:23 -0800 (PST)
Date: Tue, 9 Jan 2024 15:02:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Erico Nunes <nunes.erico@gmail.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/imagination: Defer probe if requested firmware is
 not available
Message-ID: <ZZ1R7WopPeaW3y44@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Erico Nunes <nunes.erico@gmail.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
References: <20240109120604.603700-1-javierm@redhat.com>
 <ZZ1IellMvvyFlQaF@phenom.ffwll.local>
 <8734v6r51h.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734v6r51h.fsf@minerva.mail-host-address-is-not-set>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 02:48:42PM +0100, Javier Martinez Canillas wrote:
> Daniel Vetter <daniel@ffwll.ch> writes:
> 
> Hello Sima,
> 
> Thanks for your feedback.
> 
> > On Tue, Jan 09, 2024 at 01:05:59PM +0100, Javier Martinez Canillas wrote:
> >> The device is initialized in the driver's probe callback and as part of
> >> that initialization, the required firmware is loaded. But this fails if
> >> the driver is built-in and the firmware isn't present in the initramfs:
> >> 
> >> $ dmesg | grep powervr
> >> [    2.969757] powervr fd00000.gpu: Direct firmware load for powervr/rogue_33.15.11.3_v1.fw failed with error -2
> >> [    2.979727] powervr fd00000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-2)
> >> [    2.989885] powervr: probe of fd00000.gpu failed with error -2
> >> 
> >> $ ls -lh /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
> >> -rw-r--r-- 1 root root 51K Dec 12 19:00 /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
> >> 
> >> To prevent the probe to fail for this case, let's defer the probe if the
> >> firmware isn't available. That way, the driver core can retry it and get
> >> the probe to eventually succeed once the root filesystem has been mounted.
> >> 
> >> If the firmware is also not present in the root filesystem, then the probe
> >> will never succeed and the reason listed in the debugfs devices_deferred:
> >> 
> >> $ cat /sys/kernel/debug/devices_deferred
> >> fd00000.gpu     powervr: failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-517)
> >> 
> >> Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
> >> Suggested-by: Maxime Ripard <mripard@kernel.org>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >
> > Uh that doesn't work.
> >
> > Probe is for "I'm missing a struct device" and _only_ that. You can't
> > assume that probe deferral will defer enough until the initrd shows up.
> >
> 
> Fair.
> 
> > You need to fix this by fixing the initrd to include the required
> > firmwares. This is what MODULE_FIRMWARE is for, and if your initrd fails
> > to observe that it's just broken.
> >
> 
> Tha's already the case, when is built as a module the initrd (dracut in
> this particular case) does figure out that the firmware needs to be added
> but that doesn't work when the DRM driver is built-in. Because dracut is
> not able to figure out and doesn't even have a powervr.ko info to look at
> whatever is set by the MODULE_FIRMWARE macro.

Yeah built-in drivers that require firmware don't really work. I'm not
sure it changed, but a while ago you had to actually include these in the
kernel image itself (initrd was again too late), and that gives you
something you can't even ship because it links blobs with gplv2 kernel.

Maybe that changed and the initramfs is set up early enough now that it's
sufficient to have it there ...

Either way I think this needs module/kernel-image build changes so that
the list of firmware images needed for the kernel itself is dumped
somewhere, so that dracut can consume it and tdrt. My take at least.

> > Yes I know as long as you have enough stuff built as module so that there
> > will be _any_ kind of device probe after the root fs is mounted, this
> > works, because that triggers a re-probe of everything. But that's the most
> > kind of fragile fix there is.
> >
> 
> Is fragile that's true but on the other hand it does solve the issue in
> pratice. The whole device probal mechanism is just a best effort anyways.
> 
> > If you want to change that then I think that needs an official blessing
> > from Greg KH/device core folks.
> >
> 
> I liked this approach due its simplicity but an alternative (and more
> complex) solution could be to delay the firmware request and not do it at
> probe time.
> 
> For example, the following (only barely tested) patch solves the issue for
> me as well but it's a bigger change to this driver and wasn't sure if will
> be acceptable:

I think this is still barking up the wrong tree. I think there's two
proper fixes:

- make the "EPROBE_DEFER delays until rootfs no matter what" official and
  documented policy. That's much better than drivers hand-rolling
  EPROBE_DEFER each in their own driver code.

- fix kernel build and dracut so it can pick up the firmware images the
  kernel itself needs. Because having a driver built-in but it still fails
  to load until the rootfs is there is some very confusing failure mode.
  Due to that failure mode I think this is the right fix, otherwise
  built-in drivers become confusing.

  Alternatively I guess you could disallow drm/img as a built-in driver
  ... And also any other driver that requires fw to function.

I don't think a "mostly works due to undocumented driver-specific hack" is
a good fix, since this is entirely a generic issue.

I think it's different if the fw is only needed for optional features,
e.g. for i915 some of the display firmware is only needed for self refresh
and low power modes. And a runtime_pm_get until the firmware has shown up
to prevent mayhem is imo a clean design for that, since the hardware is
fully working aside from using a bit too much power.

> From c3fb715047a44691412196d8408f2bd495bcd1ed Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javierm@redhat.com>
> Date: Tue, 9 Jan 2024 14:47:05 +0100
> Subject: [RFC PATCH] drm/imagination: Move PowerVR GPU init to the drivers's open
>  callback
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Currently the device is initialized in the driver's probe callback. But as
> part of this initialization, the required firmware is loaded and this will
> fail when the driver is built-in, unless FW is included in the initramfs:
> 
> $ dmesg | grep powervr
> [    2.969757] powervr fd00000.gpu: Direct firmware load for powervr/rogue_33.15.11.3_v1.fw failed with error -2
> [    2.979727] powervr fd00000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-2)
> [    2.989885] powervr: probe of fd00000.gpu failed with error -2
> 
> $ ls -lh /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
> -rw-r--r-- 1 root root 51K Dec 12 19:00 /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
> 
> To prevent this, let's delay the PowerVR GPU-specific initialization until
> the render device is opened by user-space. By then, the root filesystem
> will be mounted already and the driver able to find the required firmware.
> 
> Besides the mentioned problem, it seems more correct to only load firmware
> and request the IRQ if the device is opened rather than do these on probe.
> 
> Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

[snip]

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
> index 5c3b2d58d766..f8fb45136326 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1309,10 +1309,18 @@ pvr_drm_driver_open(struct drm_device *drm_dev, struct drm_file *file)
>  {
>  	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
>  	struct pvr_file *pvr_file;
> +	int err;
> +
> +	/* Perform GPU-specific initialization steps. */
> +	err = pvr_device_gpu_init(pvr_dev);

Ok this is full blas "init hw on first open" drm 1 design. I think what
would be ok somewhat is delaying the drm_dev_register, but this here gives
me nightmares ...

Please no :-)

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

