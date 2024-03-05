Return-Path: <linux-kernel+bounces-91930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32588718B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D22282098
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AAF50275;
	Tue,  5 Mar 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aNP1A3FW"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FB1EF1A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628893; cv=none; b=DJ2y8z3EEp0iCTsoBUNB24Sa/Zyuu/yepUEGqdT13URCcRfqLHwHOS+gnMtU96OBTb4d8cWUzux157kRlVVSuwImhvWO9GJSCZf7UNbAqbxQXJVYU2dvrcEC/+NG0Xns46L6tTrSJzhsxVQold7BibtaNXYS6mh30JIwVLHxfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628893; c=relaxed/simple;
	bh=TfPNhi8JIlq07hDXIhok2HpcXOQrS9RuGHlCMUlj+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCQrrM4bDzEQ7ToOnyRRCofRxDct2HNeSI1mdQJ2yglNQvqcNNA9W6uHKvpzL8HEqQK932zXH7azQibOT3M4n7Lmw3HSaZxeBHb9GUFoSCVGrbi47Ahg+4hwh68GE/j2x5hOV3qnOMaSRgMfgYF+BI1YZR4duWki5lWQKHNtTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=aNP1A3FW; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d358acc8cbso6722291fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1709628886; x=1710233686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQrdFGTzl2dweCQUPSW0EBKwoDyzx87CMamEL7rty8Y=;
        b=aNP1A3FW3EDGN7hGGEZnhowxbLgbTHRg3nc4lVeauQw1k7bYs/1KFA1+JEow9WcXNi
         Xv1Lj1nodFIWelw16YIbI+QOtMF/J9x00swrkAmz5h71JSpkHEOSBdluI2tsstTcNQkf
         KupwGsbxmNv+vQ/r7yL7scAfaB1OXeuQVWe3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628886; x=1710233686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQrdFGTzl2dweCQUPSW0EBKwoDyzx87CMamEL7rty8Y=;
        b=Oe/1at9NbS1N3qJXMQNstQz++mCPuHFUcO63o1ZbyFuXk645JW0yPEB1ci+pEG/pYu
         3wHe2mfh76bGpLn837Aia8GaVKa+kEJ/hQSgsqPhoOz8A3e/NMkpIZxfnXD6cyNrheaQ
         3UbNHAzH1bUSfAESdXvH11CBynaG7BUbsHlJspFMZvgXr+F9HSv65Q/prbQtz0GecFbj
         i1vobVb1wZlmh9rIh+BdyodqO6Fg8RTmZsJGOJDvOeUg11NaWSzAexFe2x+moWTxQ99z
         3up9eSBZfVxG8jNvDZW0cp3L61gCjVx5C4vun2YZON67NEE5pSwQH5st5nd5a6wgt/my
         v03A==
X-Forwarded-Encrypted: i=1; AJvYcCU4qkmw8hG1gMEgCEOyUBiQk8CWm3BYQHGpj5sJhKRWiS6VwvtwPgp3XTtiDLGE5M9XU6txT6+J49AVCqz5wcxk3xKYfqWVh8fTgSag
X-Gm-Message-State: AOJu0Yzy+1Mewrsh03O9EKbHlh7hacNmXdauRHUmVOfrA2z6dW1fMp5d
	YUzAlDsSUdrRUxIvxGgKstB7JXxmfekdBtPfl4mcZTiswjH40T9jnwq0mSs9N18=
X-Google-Smtp-Source: AGHT+IEZqk8YK77lULQVqIQ+W2hrIEcGi2vrmttCn5YhREmOC9fxZ2GD5irofP1qhPxrTdqpuIJiNQ==
X-Received: by 2002:a2e:9bd8:0:b0:2d3:ed14:7e13 with SMTP id w24-20020a2e9bd8000000b002d3ed147e13mr1085825ljj.2.1709628886248;
        Tue, 05 Mar 2024 00:54:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v29-20020a50a45d000000b005649f17558bsm5832879edb.42.2024.03.05.00.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:54:45 -0800 (PST)
Date: Tue, 5 Mar 2024 09:54:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Tvrtko Ursulin
Message-ID: <Zebd08SA4ZQ6hIzg@phenom.ffwll.local>
Mail-Followup-To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Wed, Feb 28, 2024 at 02:22:40PM +0000, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> I will lose access to my @.*intel.com e-mail addresses soon so let me
> adjust the maintainers entry and update the mailmap too.
> 
> While at it consolidate a few other of my old emails to point to the
> main one.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

Directly applied to drm-fixes as requested on irc.
-Sima

> ---
>  .mailmap    | 5 +++++
>  MAINTAINERS | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index b99a238ee3bd..d67e351bce8e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -608,6 +608,11 @@ TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
>  TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
>  Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
>  Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@intel.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@linux.intel.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@sophos.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@onelan.co.uk>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko@ursulin.net>
>  Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
>  Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
>  Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19f6f8014f94..b940bfe2a692 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10734,7 +10734,7 @@ INTEL DRM I915 DRIVER (Meteor Lake, DG2 and older excluding Poulsbo, Moorestown
>  M:	Jani Nikula <jani.nikula@linux.intel.com>
>  M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>  M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> -M:	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> +M:	Tvrtko Ursulin <tursulin@ursulin.net>
>  L:	intel-gfx@lists.freedesktop.org
>  S:	Supported
>  W:	https://drm.pages.freedesktop.org/intel-docs/
> -- 
> 2.40.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

