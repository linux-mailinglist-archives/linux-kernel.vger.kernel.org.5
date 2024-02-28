Return-Path: <linux-kernel+bounces-85160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D5386B148
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DB41F22955
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50E1534EF;
	Wed, 28 Feb 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="W03j8xKz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8693148FFC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129287; cv=none; b=czQOENVuYTHePoISAWJ0YZoRjbPtwLuzOxR/J/LkrQjcY2TJ29jym1z2nSq2gcn91cHYTXGAV/sT4Py0dEUCg7kYIk+Dq+AkdFeuWEzeIuYDjh6OkneCdiBRyLiHwzdbziwCDaTQlpeU3XI1eHxS2q5bJEUWOoyu/GDZm7usD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129287; c=relaxed/simple;
	bh=9Asdirxrf2esJ/71XcckrPTw4c/+aKLVRuVEr9VgptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB9vhHRQfrTdWKYaDpXngAIqEQQPPsGeZvzktW4CcStQ3/zQsAFqaTCMXj54vtWPyKIkp0ArpNEHdFVqmV6BrEguNkoNCp47FnD2a0qq19xNgbyhyU3uYSPMD7Jt6tgK+zyufsk2Ln1Y0gByNdfLwSq1bsLqIWm75IsdP7Z1Wp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=W03j8xKz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412ae6392f0so871625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1709129283; x=1709734083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUVmrcuA39MF251x7X5ARx9WwO4dFVP4l9HT7NkEaNk=;
        b=W03j8xKzDM4mgxwrj4bbrgTYLkCjRJIdT+A1FfDhWCryBqODQbs1FmOH+4JVtrX3CH
         d3cXuQmZPwtDnBkDQWgGe7s7mUQKkyuUCBgfA7OP3KK/vh5fAU2rHeg9obNlcJScwqwm
         hR1NYZFSsvqv7ZozcDNNONEx1xEIWgHRqDTcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709129283; x=1709734083;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUVmrcuA39MF251x7X5ARx9WwO4dFVP4l9HT7NkEaNk=;
        b=H8yo+Yo3OKzhFvJbJFTWI88XvUEzRZ8zbJyc++BhQZI2JKFdSKw3LS6atDH8Firi5h
         kWq+0ksk0dm4h9GxZ6eg8mvDm/QKpcC7SD6fnFHHIPTF6XKbMSp8YyMhamex3+2YQV5G
         p7EZ03qFzBTiiiRteUH16oHBNf28rUKy9c8SgDRLnTaTBrS1qU5XylJFRHB2pXPgeZPi
         w3ifTtZ7Y0mS+e8rOcIXTP5wb/sv1dzZIQzMn2t8AlDWotCC0cnSOfVSdvZubYviwi/u
         sZ/J+6dcfM1lGuxJPBQhsD8wQjT8h/KCzSAAMJsW2gx9t5NVDtWeS06IP8RDh1jX+Qji
         gTmg==
X-Gm-Message-State: AOJu0Yzt7pIU2kgR0IOeEjsdwNlHmqm93onWo70AuMskBMVTNM/qa9hs
	HgHDi24pBXqLSavHEd6CrUO63tlokiY7/lBLrYEn3wzxDH6zJaqLOugejPqXTwkGLKgYQERYZyU
	w
X-Google-Smtp-Source: AGHT+IHVgTT7SAUERgY/qC6JGjy8snO0RQGURwM7F9fgYkHp0K/shY8oyt9T3BuYcky5YRC1fQBimA==
X-Received: by 2002:a05:600c:1c05:b0:412:a1c1:2d9f with SMTP id j5-20020a05600c1c0500b00412a1c12d9fmr7270386wms.1.1709129283066;
        Wed, 28 Feb 2024 06:08:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id jn5-20020a05600c6b0500b0041228b2e179sm2180822wmb.39.2024.02.28.06.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:08:02 -0800 (PST)
Date: Wed, 28 Feb 2024 15:08:00 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 0/2] drm: Check polling initialized before
Message-ID: <Zd8-QBqRIfzH1jCI@phenom.ffwll.local>
Mail-Followup-To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
References: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
 <ZcI9Mw-MclTtkbwe@phenom.ffwll.local>
 <20240220060217.GA14395@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220060217.GA14395@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Feb 19, 2024 at 10:02:17PM -0800, Shradha Gupta wrote:
> Gentle reminder to consume this patchset.

Apologies, I've assumed you have commit rights or know someone, but seems
like no one from microsoft can push to drm-misc :-/

Applied to drm-misc-next now, thanks for your patches!
-Sima

> 
> On Tue, Feb 06, 2024 at 03:07:47PM +0100, Daniel Vetter wrote:
> > On Thu, Feb 01, 2024 at 10:42:56PM -0800, Shradha Gupta wrote:
> > > This patchset consists of sanity checks before enabling/disabling
> > > output polling to make sure we do not call polling enable and disable
> > > functions when polling for the device is not initialized or is now
> > > uninitialized(by drm_kms_helper_poll_fini() function)
> > > 
> > > The first patch consists of these checks in
> > > drm_kms_helper_poll_disable() and drm_kms_helper_poll_enable() calls.
> > > It further flags a warning if a caller violates this. It also adds
> > > these checks in drm_mode_config_helper_resume() and
> > > drm_mode_config_helper_suspend() calls to avoid this warning.
> > > 
> > > The second patch adds a similar missing check in
> > > drm_helper_probe_single_connector_modes() function that is exposed by
> > > the new warning introduced in the first patch.
> > > 
> > > Shradha Gupta (2):
> > >   drm: Check output polling initialized before disabling
> > >   drm: Check polling initialized before enabling in
> > >     drm_helper_probe_single_connector_modes
> > 
> > On the series:
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > > 
> > >  drivers/gpu/drm/drm_modeset_helper.c | 19 ++++++++++++++++---
> > >  drivers/gpu/drm/drm_probe_helper.c   | 21 +++++++++++++++++----
> > >  2 files changed, 33 insertions(+), 7 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

