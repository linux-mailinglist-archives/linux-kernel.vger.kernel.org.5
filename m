Return-Path: <linux-kernel+bounces-87211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9286D124
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ADA283FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E7757EE;
	Thu, 29 Feb 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwMcL2mJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEC70AF4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229140; cv=none; b=SUGZeBwFbH4H4XGrqjzQ0jcKOfR/TZi7aK4nwFlIKYO+z57wFQ9Hj4uRi5nEF4SGlcL6SNiCRrn8yn4/JZEl3w60f5GMoT5k0YU2X/uPFdMfL19R9caBsqw8FQNLt35kq9RRoWfTz5ZWH9d2dT+rbAMEbjFHVO2iA9yqEoLy4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229140; c=relaxed/simple;
	bh=PXUEP1C71co4eWA+/1jmwXfKYcFuP3HFaOJuu0HG8fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSfPL1IZKwgP7VNCXTdD8AtjSwR+p3bZlkXt4ITziZW0/xr2NlG1313do7UWhmZTzQAV+Uo2jhT8QrAgDIg03CuUGpumY9fB6kUeKn20q0++3PJgXO+F8e753q4tgTE4hsLfX60YsCjd43W2WSqeZeXgYQ12g4ZvaabYSsh5TXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwMcL2mJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709229137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm+DA3s213+nIlC3/1Pqt2BegQwfSDXngZs51zMT49Y=;
	b=SwMcL2mJK9xaesmicHWFvirMMBwcKAUIpwzlMkmzwaMaSRTOC90L0RqnUoZKHemhe64vnv
	p3ElpJ6Q9mQwu1EHTix4V0mOMaoPr4R0PTKRzcCbbcwWP2TPghjMh3ap5mMQ8753+jXXi9
	UYW14xoWVUEHs+XZExz++npWM75lq4k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-a5bB9H7gMAeO3qBDfy5JCQ-1; Thu, 29 Feb 2024 12:52:15 -0500
X-MC-Unique: a5bB9H7gMAeO3qBDfy5JCQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412a64bf17eso7188535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229134; x=1709833934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm+DA3s213+nIlC3/1Pqt2BegQwfSDXngZs51zMT49Y=;
        b=WZllIB07mXxu8D1LJjVDryyvQBixUf1XZrDC5uvNIXIkQ5mBEFLyx7XQmmqKW0Uwpl
         yD6f7/9z969y6k01eBHnOi53pp3I/1OW587yBcxCUUz5+oHOsAUjBkjRerwHs1yUuZfd
         hWmsFF417MEXKA9CXMTeG9fTAqRn5zpekP7j6wAj8yVBUpG9xJw7lhLEapYsFh3lqn+0
         EycVimbwyg1oFXAowvu8Jg04uCL0toc5mWMZA17C6k13k6fiePurf4HNpPGS4BE4TTdN
         JlmMCshmUlxi9puURZWC67vDTahGx0l83Gw280i5MNLliTtqYGmDFHYxqHQAgTK6OMc+
         eHGw==
X-Forwarded-Encrypted: i=1; AJvYcCVOsoeDdBNbZ9WSSc741LicQ6GDyEOU+lEnNEW7SI3ZJhpKzbPiZ/IdvV0X9r4H/Symn8qiOikIfB8r1F/lgylB6Sx3MgjOvRNCvdQN
X-Gm-Message-State: AOJu0YxaQNPQFuoA/Vjn4fLHXYH8MwSCw13gF9GYs9/KswAITtSJomRg
	vHa7B4+JBgczxvvFdfH1BQEeH4RfK1IUK6K5XOVaQE4Zkm3uOl8S2/8IrehyuTPa3uDAGetzodS
	cV9Ck4voqM2f7YCnYGMBZzCNenWyDmkucS2Wj6MKYEGSRJzeIytkLL840vltrLQ==
X-Received: by 2002:a05:600c:8518:b0:412:af48:9d9e with SMTP id gw24-20020a05600c851800b00412af489d9emr2266661wmb.20.1709229134053;
        Thu, 29 Feb 2024 09:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2SwLF5eJE0m6m+v9VypbvNmkAsfLUQ1tB/JSeTZDmR75YYBw7SUYGhSzX37cfN2+Y/sn01A==
X-Received: by 2002:a05:600c:8518:b0:412:af48:9d9e with SMTP id gw24-20020a05600c851800b00412af489d9emr2266647wmb.20.1709229133682;
        Thu, 29 Feb 2024 09:52:13 -0800 (PST)
Received: from toolbox ([2001:9e8:8984:bd00:2340:7b35:5e60:4abd])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c488500b004127de1ba84sm2694455wmp.0.2024.02.29.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:52:12 -0800 (PST)
Date: Thu, 29 Feb 2024 18:52:11 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add YUV formats to VKMS
Message-ID: <20240229175211.GA166694@toolbox>
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
 <20240115150600.GC160656@toolbox>
 <9e6ed0e5-c9aa-4fb9-a6d8-4c3b1d658ef2@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6ed0e5-c9aa-4fb9-a6d8-4c3b1d658ef2@riseup.net>

On Wed, Feb 28, 2024 at 08:42:41PM -0300, Arthur Grillo wrote:
> 
> 
> On 15/01/24 12:06, Sebastian Wick wrote:
> > On Wed, Jan 10, 2024 at 02:44:00PM -0300, Arthur Grillo wrote:
> >> This patchset aims to add support for additional buffer YUV formats.
> >> More specifically, it adds support to:
> >>
> >> Semi-planar formats:
> >>
> >> - NV12
> >> - NV16
> >> - NV24
> >> - NV21
> >> - NV61
> >> - NV42
> >>
> >> Planar formats:
> >>
> >> - YUV440
> >> - YUV422
> >> - YUV444
> >> - YVU440
> >> - YVU422
> >> - YVU444
> >>
> >> These formats have more than one plane, and most have chroma
> >> subsampling. These properties don't have support on VKMS, so I had to
> >> work on this before.
> >>
> >> To ensure that the conversions from YUV to RGB are working, I wrote a
> >> KUnit test. As the work from Harry on creating KUnit tests on VKMS[1] is
> >> not yet merged, I took the setup part (Kconfig entry and .kunitfile)
> >> from it.
> >>
> >> Furthermore, I couldn't find any sources with the conversion matrices,
> >> so I had to work out the values myself based on the ITU papers[2][3][4].
> >> So, I'm not 100% sure if the values are accurate. I'd appreciate some
> >> input if anyone has more knowledge in this area.
> > 
> > H.273 CICP [1] has concise descriptions of the required values for most
> > widely used formats and the colour python framework [2] also can be used
> > to quickly get to the desired information most of the time.
> > 
> > [1]: https://www.itu.int/rec/T-REC-H.273
> > [2]: https://www.colour-science.org/
> 
> I want to thank you for suggesting the python framework, it helped
> immensely now that I'm changing the precision from 8-bit to 32-bit[1].
> 
> If I'd known about this framework while developing this patch, I
> would've saved myself a few weeks of pain and suffering recreating a
> part of this library XD.

I'm glad this is useful for you! We also used it for our color-and-hdr
project https://gitlab.freedesktop.org/pq/color-and-hdr/.

> [1]: https://lore.kernel.org/all/b23da076-0bfb-48b2-9386-383a6dec1868@riseup.net/
> 
> Best Regards,
> ~Arthur Grillo
> 
> > 
> >> Also, I used two IGT tests to check if the formats were having a correct
> >> conversion (all with the --extended flag):
> >>
> >> - kms_plane@pixel_format
> >> - kms_plane@pixel_format_source_clamping.
> >>
> >> The nonsubsampled formats don't have support on IGT, so I sent a patch
> >> fixing this[5].
> >>
> >> Currently, this patchset does not add those formats to the writeback, as
> >> it would require a rewrite of how the conversions are done (similar to
> >> what was done on a previous patch[6]). So, I would like to review this
> >> patchset before I start the work on this other part.
> >>
> >> [1]: https://lore.kernel.org/all/20231108163647.106853-5-harry.wentland@amd.com/
> >> [2]: https://www.itu.int/rec/R-REC-BT.601-7-201103-I/en
> >> [3]: https://www.itu.int/rec/R-REC-BT.709-6-201506-I/en
> >> [4]: https://www.itu.int/rec/R-REC-BT.2020-2-201510-I/en
> >> [5]: https://lists.freedesktop.org/archives/igt-dev/2024-January/066937.html
> >> [6]: https://lore.kernel.org/dri-devel/20230414135151.75975-2-mcanal@igalia.com/
> >>
> >> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> >> ---
> >> Changes in v2:
> >> - Use EXPORT_SYMBOL_IF_KUNIT instead of including the .c test
> >>   file (Maxime)
> >> - Link to v1: https://lore.kernel.org/r/20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net
> >>
> >> ---
> >> Arthur Grillo (7):
> >>       drm/vkms: Use drm_frame directly
> >>       drm/vkms: Add support for multy-planar framebuffers
> >>       drm/vkms: Add range and encoding properties to pixel_read function
> >>       drm/vkms: Add chroma subsampling
> >>       drm/vkms: Add YUV support
> >>       drm/vkms: Drop YUV formats TODO
> >>       drm/vkms: Create KUnit tests for YUV conversions
> >>
> >>  Documentation/gpu/vkms.rst                    |   3 +-
> >>  drivers/gpu/drm/vkms/Kconfig                  |  15 ++
> >>  drivers/gpu/drm/vkms/Makefile                 |   1 +
> >>  drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
> >>  drivers/gpu/drm/vkms/tests/Makefile           |   3 +
> >>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 156 ++++++++++++++++
> >>  drivers/gpu/drm/vkms/vkms_drv.h               |   6 +-
> >>  drivers/gpu/drm/vkms/vkms_formats.c           | 247 ++++++++++++++++++++++----
> >>  drivers/gpu/drm/vkms/vkms_formats.h           |   9 +
> >>  drivers/gpu/drm/vkms/vkms_plane.c             |  26 ++-
> >>  drivers/gpu/drm/vkms/vkms_writeback.c         |   5 -
> >>  11 files changed, 426 insertions(+), 49 deletions(-)
> >> ---
> >> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
> >> change-id: 20231226-vkms-yuv-6f7859f32df8
> >>
> >> Best regards,
> >> -- 
> >> Arthur Grillo <arthurgrillo@riseup.net>
> >>
> > 
> 


