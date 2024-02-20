Return-Path: <linux-kernel+bounces-72373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EA85B291
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B827E283C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926057334;
	Tue, 20 Feb 2024 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MmrXIEPJ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506A57313
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408944; cv=none; b=PjO4xtIflh4Dv7Y9Kx3l5X0LMNh6SbUqi1c0T3+rUXcskSBo+M5EOjRGoRwI3OobHydq6GYJueksY0JbDeHt8nDMvbLFjDaeZXePq1dSZnrE8lP/yuM36g6AhAjewFljSMv0s/jMJJ65BBwJZLOZGhrK3uzDlFxHxdxr3C3pjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408944; c=relaxed/simple;
	bh=vcvq7PT1f+G9hnxlGtZGdJDEEI6wLIW/0UQlfeHxnPI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdGpqD+zT9No/7v+8AMqxLf7biMCAvAcDOinrmALp+lbZh4QieSKLKScErAqFOHPlim8wk78p/ogsH2rlP9qqRqDheRwCTg6D6Wu9FbmcB2JeMkaXWcX9YGKkJJ0EKXKvluEuY7Q8mGdX9iBclYeXVQ4/KL90su/v0fN7jaru50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MmrXIEPJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 3A9A220B2000; Mon, 19 Feb 2024 22:02:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A9A220B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708408937;
	bh=PPoSUXeB6zRIX7Zi7HPGjneiE6SaP9iHR6fDjGL5kCU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=MmrXIEPJ0Z5ihryAmXvf/QmfzvFLW/Mz8jB7Nff7oretJPnlYvhsHarBC03s23Fzh
	 bZpv+QZix/4bH9jOUPtDrCDzrFIt6+vA/rugZav9Glmfb/FruTlRv74ThUvVkx6Huw
	 B/hENEWQauktVL/zPy734bIKKI/cuV2cAy+dFKmk=
Date: Mon, 19 Feb 2024 22:02:17 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 0/2] drm: Check polling initialized before
Message-ID: <20240220060217.GA14395@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
 <ZcI9Mw-MclTtkbwe@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcI9Mw-MclTtkbwe@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

Gentle reminder to consume this patchset.

On Tue, Feb 06, 2024 at 03:07:47PM +0100, Daniel Vetter wrote:
> On Thu, Feb 01, 2024 at 10:42:56PM -0800, Shradha Gupta wrote:
> > This patchset consists of sanity checks before enabling/disabling
> > output polling to make sure we do not call polling enable and disable
> > functions when polling for the device is not initialized or is now
> > uninitialized(by drm_kms_helper_poll_fini() function)
> > 
> > The first patch consists of these checks in
> > drm_kms_helper_poll_disable() and drm_kms_helper_poll_enable() calls.
> > It further flags a warning if a caller violates this. It also adds
> > these checks in drm_mode_config_helper_resume() and
> > drm_mode_config_helper_suspend() calls to avoid this warning.
> > 
> > The second patch adds a similar missing check in
> > drm_helper_probe_single_connector_modes() function that is exposed by
> > the new warning introduced in the first patch.
> > 
> > Shradha Gupta (2):
> >   drm: Check output polling initialized before disabling
> >   drm: Check polling initialized before enabling in
> >     drm_helper_probe_single_connector_modes
> 
> On the series:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> > 
> >  drivers/gpu/drm/drm_modeset_helper.c | 19 ++++++++++++++++---
> >  drivers/gpu/drm/drm_probe_helper.c   | 21 +++++++++++++++++----
> >  2 files changed, 33 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

