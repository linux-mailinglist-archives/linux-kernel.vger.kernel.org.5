Return-Path: <linux-kernel+bounces-107727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F108800CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74701C214F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF998120F;
	Tue, 19 Mar 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HSlj6oIm"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A51657BA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862573; cv=none; b=p/aRmCWjHl4pdMjtbx6EN7VprKYZ5BJR5dDdDm0jWH0AsNM/niMuYnKuBh7G6fekQP0lK3OJsWPWqGmXJAeD5PpK0XzidwVi3Zj3EY4BTEKZ8SM7ksEgyfW6Koyx7lIaEtUnvRP1wrHdX71Hq8CiUhqv8PwoIGPe6SB+9W60zio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862573; c=relaxed/simple;
	bh=evXLw/ER1O/WAyPO8SELAcnS1lMZtXHdsbrDNdBK37o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/tzqgMozNXlxXc3jFMtLYVvRSPe1XPBvU4zUC7Vn5ZyZlJ3BhEVZYgdrHzCMceJuJKzwfayEKu8ashCgFjDq8/UQpG2bFz7KSjCUg7tx+hng5pvNiZnM9kKKDCFK1xZuHNrxgosvlgBuxmqqZDNt717+o9jL+MXiQKHrNOgT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HSlj6oIm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568c6e65d09so319314a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1710862570; x=1711467370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMRrzjOPzthVrfn6KYAeeCpTeFZ11+LfDjNaDwcFwcY=;
        b=HSlj6oImhLeo1ZDYD3cWCqweHgBg3RcWVApqKG5REuwU5pUfUkcnzUgnj/uQ/cUcHQ
         S7Ols5Gxz1mPpsOCZh89CwNHyyiQHf/QjQqdSoDJaeVae/YMDW/DR2XR6NR1lGKCpuYZ
         se6LinJxWEvFgHvEDIMgWcKroPa3ZtFZEfSOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862570; x=1711467370;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMRrzjOPzthVrfn6KYAeeCpTeFZ11+LfDjNaDwcFwcY=;
        b=JXXHmDnIO0vWZzoZFLeFUSIQj1Nu56rWt5M1Tw/UjCUe5jtTzL6IMGjrmZ87euAQfI
         NUmTrjz3AEhlAxcbU+25kD0an8ZZ7roWcJzhq+d9ZfLCG0Y2XZYnPJU5ATTWdKMp7Dkc
         rkm+fSDdsfTminTy/khPB8Pu6VeWwAp00k12GG9fZ3Eo5+cjpMbAGdvL79u335AxSwCB
         NtxE8y9aeKEZCeUXnunKcfFXB57yb44NFbpQPBbx+WxDHPU6EF0MAxoS/xMm74Vq3sQQ
         Dy4e5achXz8X7ykmjaggoEwcDCeBQz7ubyuZD4pjFruqPfb6IHIDmOWVzDiilqy6bYyz
         1Rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWDlCybPT5lT1Q2/j5csYNDJFqF3QHMm0xLLE+Of+m/yadtGbhTrrV4Wox3tSGyoaVcdyLPQrGCZhrIIyg9gSbRo6HwoR22urrdsMvX
X-Gm-Message-State: AOJu0YykinYCkWBfDNqvOZcT+9KMwG6s6579Qdsh4aCYWNgAX/NwsU/o
	Oh6bYYIi+GhIMv9Fe+YUhL5e+Mi/WF4xAZNyqUydwuASnS68QZSegj9VqLVAWag=
X-Google-Smtp-Source: AGHT+IGqka02G9xZBUIJYUnMVsGDttJH1Lg5gp0y4iikQkmbEHNnKV4dqr/YUk062oXDQf+NP19rXg==
X-Received: by 2002:a05:6402:388b:b0:568:a65c:7aff with SMTP id fd11-20020a056402388b00b00568a65c7affmr1747003edb.4.1710862569608;
        Tue, 19 Mar 2024 08:36:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906049700b00a3efa4e033asm6220139eja.151.2024.03.19.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:36:08 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:36:06 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Document requirements for driver-specific KMS
 props in new drivers
Message-ID: <Zfmw5qjlQmiWRDIV@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240311155904.323488-1-sebastian.wick@redhat.com>
 <20240314-portable-pragmatic-weasel-7dd91e@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-portable-pragmatic-weasel-7dd91e@houat>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Mar 14, 2024 at 11:20:09AM +0100, Maxime Ripard wrote:
> On Mon, Mar 11, 2024 at 04:58:58PM +0100, Sebastian Wick wrote:
> > When extending support for a driver-specific KMS property to additional
> > drivers, we should apply all the requirements for new properties and
> > make sure the semantics are the same and documented.
> > 
> > v2: devs of the driver which introduced property shall help and ack
> > 
> > Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> We probably want to have Dave or Sima ack on that one too

Yeah that's a good idea and defacto how we handled this - additional users
of anything (whether library or uapi or whatever) get to clean up an
existing mess if it's too bad. But for uapi it's good to be really
explicit and document that.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

