Return-Path: <linux-kernel+bounces-94711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FD38743DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C771B22221
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69111D545;
	Wed,  6 Mar 2024 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7gafIm2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4001D534
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767460; cv=none; b=FsDDd5Pbfo5HOHzE7Hmt25nknb+vR7R8QXINlbU3FNLIasxeRGSjfQlWqCnk6Z2fMYqKcv66xU7cd3gzbyzsG+lE+Xte4K3ZduPtF4ram+MKz18NiL4Nq61cw1xnKgUjTAQ6tHw01mCvG+Obul5hNnFOwUTXios69oUAlHs2rbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767460; c=relaxed/simple;
	bh=nxTMNVUWXiY8S9V11c5v9di2lz8F1CQuxnAnPyQIic8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGiKenqHNQYGm2sB1xPbhdjRL4UZ6AlrofJPblQs5SnrA21yr2m/7f7Ac0MCfvQpBWDoNs3O5eS/Rj/8D1XVIB1hHS0XvGtsz8eEeksD0qS1uedRq9JLdsYqj+IVOvmT2t7gArOo8ZfrreFWeAkAGSRjs8N07Ork0YH1QzFWAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7gafIm2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709767459; x=1741303459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nxTMNVUWXiY8S9V11c5v9di2lz8F1CQuxnAnPyQIic8=;
  b=V7gafIm2Argm+oC1nWfJpO7XdU0ndEBgSPn5nACj0PcskJRg7ATcIpR+
   gJY4NPvjfr7V909TsCPXk2xWOoge8NLojkHt7GTzg0FVFcs70t4LIGMDO
   bfP/gqHfuLEfWeMjm+XF9lXrvU2EfzsfLKxIZNcMwo1mKZYy5VeScRa7C
   QTaXwtYqNPXimTfvK6ASjXaUYJ5xu4YzFEr68W4wjZWuCTTfCDKzqyTRy
   9tv3VyuhyfjhMQWU8eG343qxb8M1MJ+iL8+nwiL+BuCx/yc0HzT8zQn6P
   Rp7s1WEjIIyg4brn5ru4rBLfjKwd+9cnHrFMsGP5ZXzKpbn/EnmoMTHcY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4558379"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4558379"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 15:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="827774495"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="827774495"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 06 Mar 2024 15:24:13 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 07 Mar 2024 01:24:12 +0200
Date: Thu, 7 Mar 2024 01:24:12 +0200
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
Message-ID: <Zej7HOLVOAMtWvrn@intel.com>
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
 <CAF6AEGs2zCP1SWPzxz4v2CU--yyEsN0+PS3dKM1nOuGyVkCpLg@mail.gmail.com>
 <ZeiGi4l1lL_fYJ69@intel.com>
 <CAF6AEGs1ce2xzuo3xEO+xgj+0iCi59nM8AiTwBfEhwZZ2w6Vww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGs1ce2xzuo3xEO+xgj+0iCi59nM8AiTwBfEhwZZ2w6Vww@mail.gmail.com>
X-Patchwork-Hint: comment

On Wed, Mar 06, 2024 at 07:37:16AM -0800, Rob Clark wrote:
> On Wed, Mar 6, 2024 at 7:06 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Wed, Mar 06, 2024 at 06:49:15AM -0800, Rob Clark wrote:
> > > On Wed, Mar 6, 2024 at 4:18 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > >
> > > > Hi,
> > > >
> > > > sorry that I did not see the patch before.
> > > >
> > > > Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> > > > > Even though the UDL driver converts to RGB565 internally (see
> > > > > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> > > > > compatibility. Let's add ARGB8888 to that list.
> > > >
> > > > We had a heated discussion about the emulation of color formats. It was
> > > > decided that XRGB8888 is the only format to support; and that's only
> > > > because legacy userspace sometimes expects it. Adding other formats to
> > > > the list should not be done easily.
> > >
> > > OTOH it is fixing a kernel change that broke userspace
> > >
> > > > >
> > > > > This makes UDL devices work on ChromeOS again after commit
> > > > > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> > > > > commit things were "working" because we'd silently treat the ARGB8888
> > > > > that ChromeOS wanted as XRGB8888.
> > > >
> > > > This problem has been caused by userspace. Why can it not be fixed there?
> > > >
> > > > And udl is just one driver. Any other driver without ARGB8888, such as
> > > > simpledrm or ofdrm, would be affected. Do these work?
> > >
> > > Probably any driver where ARGB8888 is equivalent to XRGB8888 (ie.
> > > single primary plane, etc) should advertise both.
> >
> > To me that seemes likely to trick userspace developers into
> > assuming that ARGB is always available, and then when they
> > finally try on hardware that doesn't have ARGB it'll just
> > fail miserably.
> 
> I think that ship has sailed already, at least for any drivers that
> previously silently accepted ARGB8888

Perhaps. Although I don't actually understand what kind of weird
userspace people are running if it somehow expects ARGB to be there,
but only for some specific kms drivers. Is said userspace really
somehow checking which kms driver is present and then just ignoring
the pixel format list exposed by the driver? Or is it just some
super hw specific thing where they can just assume a specific kms
driver?

Anyways, adding ARGB to even more drivers seems like a terrible
idea to me.

-- 
Ville Syrjälä
Intel

