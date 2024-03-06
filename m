Return-Path: <linux-kernel+bounces-94127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57485873A50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA7F1F297A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5F13790C;
	Wed,  6 Mar 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le/G77he"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED11350D8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737620; cv=none; b=dSXb4nfQa/q6KCJ5FFzS6C0jjqTRoZHhlW7EPVTKgoJJh+ssaDADYaWRksHRSgfxHUZmDc0dVZ1IdiUnGX+mVkqO5vUabr6UjFHYrWx5KT7N/ryDYfYesjQ02ZZ45M0S7Cn8ch+mFnbh2K/Ou185sEN0YMyakmqJMg7AzIFYT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737620; c=relaxed/simple;
	bh=NkW0kjqnGBo5wFggNC6XMC1hc0EuI58azaDi+ScyGKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOQchqCsfVMJDRWRGcOWjVhHMvfjW3t4VXnGWwBhOkG5miork0fWLPs7BulybhnZmnvaWRQLh+aIYr7Pl9zNLxQY8fiNA8M+PCE5Ar040t8qPcovXXkmXVy90U4z4dKSdkFsRfIaeWr2P4YT5oTAY0IA7EcKzse90cE+ugb/tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le/G77he; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709737618; x=1741273618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NkW0kjqnGBo5wFggNC6XMC1hc0EuI58azaDi+ScyGKk=;
  b=le/G77heZ2Z+nHB46j4uQozOhKAorE/GbZq8ORyb11rUGIGFmeJfyqXk
   UqKk2EhjKZSRegqIDR9PbooQJXCS0xmCKH2qKqncX4KpvbxaAAXcKp6Y+
   4xmtGRYrp/yLRHmlh6o3SWhws3nkRSXXAu2G2O+1V/u3oIe5uiW089N6h
   ubHEJ0v5oxckU8ua1mDQ2FXgRGzQMMKFhfbzCKcJ+1KHP6+cPGoCq/0vp
   JijR+R7IlBtQOitwlpyn4l4k82zyhQkNayosJHLYQGmUWRECKWk+bbdt6
   IoviZqnlG8n1i2qYdtQPM75N5MRuzotgPEOv/Zt9ehjd/xnWEBC6hc59K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15008372"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15008372"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="827774338"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="827774338"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 06 Mar 2024 07:06:52 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 06 Mar 2024 17:06:51 +0200
Date: Wed, 6 Mar 2024 17:06:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rob Clark <robdclark@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
Message-ID: <ZeiGi4l1lL_fYJ69@intel.com>
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
 <CAF6AEGs2zCP1SWPzxz4v2CU--yyEsN0+PS3dKM1nOuGyVkCpLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGs2zCP1SWPzxz4v2CU--yyEsN0+PS3dKM1nOuGyVkCpLg@mail.gmail.com>
X-Patchwork-Hint: comment

On Wed, Mar 06, 2024 at 06:49:15AM -0800, Rob Clark wrote:
> On Wed, Mar 6, 2024 at 4:18 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi,
> >
> > sorry that I did not see the patch before.
> >
> > Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> > > Even though the UDL driver converts to RGB565 internally (see
> > > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> > > compatibility. Let's add ARGB8888 to that list.
> >
> > We had a heated discussion about the emulation of color formats. It was
> > decided that XRGB8888 is the only format to support; and that's only
> > because legacy userspace sometimes expects it. Adding other formats to
> > the list should not be done easily.
> 
> OTOH it is fixing a kernel change that broke userspace
> 
> > >
> > > This makes UDL devices work on ChromeOS again after commit
> > > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> > > commit things were "working" because we'd silently treat the ARGB8888
> > > that ChromeOS wanted as XRGB8888.
> >
> > This problem has been caused by userspace. Why can it not be fixed there?
> >
> > And udl is just one driver. Any other driver without ARGB8888, such as
> > simpledrm or ofdrm, would be affected. Do these work?
> 
> Probably any driver where ARGB8888 is equivalent to XRGB8888 (ie.
> single primary plane, etc) should advertise both.

To me that seemes likely to trick userspace developers into
assuming that ARGB is always available, and then when they
finally try on hardware that doesn't have ARGB it'll just
fail miserably.

-- 
Ville Syrjälä
Intel

