Return-Path: <linux-kernel+bounces-153777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E88AD2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC07C284204
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3117153BD0;
	Mon, 22 Apr 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVIUgDmM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2D152197;
	Mon, 22 Apr 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805216; cv=none; b=lx7CYKzgSmOXwGK8tOAUxSI8vzQ8TBem4+53+zNGFGCoCJGoonhXSCkkBsS8GysGkk/j34kdoojgdAlpkP5ZtocVNwK65FHPkAJlRCj9ApKkW89ICLHv/750uOwNHwz5Ivbqts+G5lV7yHMGBV7AGdUXfYP5F6tBf9k4h2d8ORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805216; c=relaxed/simple;
	bh=xAOKVOl8L9bgXPssCvU9ysQILCCCOchkHGoJuRkb7/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRPyZ/4xPWV70iEGOSjdlsEjWlu1+FPv9LvjgdOyUppe/3ylNmtt1pDtGCBx89bdzsw8K1qZ2QLOzKuqhcoRlodZ8o+SNdvt3Q7lKw9Z+9IMF1IE4ctsjZOUrPXyVKe3KOxUmkWCzzaIuDqRiRL/GaNeKf8JpwnherocrEwFpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVIUgDmM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713805214; x=1745341214;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xAOKVOl8L9bgXPssCvU9ysQILCCCOchkHGoJuRkb7/k=;
  b=nVIUgDmMWgH/10eZ0/kkZr4/Cxgg0cB+X7YR+R2dWPEl7vnZ92LpXSL1
   +eq+Hg64a7c2w6HLp+/he31PLxkC7SnD7KJ25UDbtLl2TMAQfcBIE/EOW
   5U5NeyZYiZmsKYZZFBiK/zk997ffoRsD52KHsfI5+m1BeXMK9rZe+ns10
   i+YqtDx3REuNZI3soD+n9YGWeD8ZLyQZ+mXVVT9Z9z851qKFcDS1d4e/F
   YSmDwwbKuoIxrb89Iw+eRnn5zQq/KXyIH8JYdVHAiqPtW2BVR+Z/5eCa1
   TFjR7I8t6gh9GRZYaFy0affCZmiGJyrL1soXjhcQBC3PL8YwJVWIZfZuS
   Q==;
X-CSE-ConnectionGUID: ID55QCg5Q2Gsgg/NxT1cng==
X-CSE-MsgGUID: tWFRuV3/TWClPHb2z12Tsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20502405"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20502405"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 10:00:13 -0700
X-CSE-ConnectionGUID: W0R16tSASjShcIHwqgyPlg==
X-CSE-MsgGUID: OW6KzNTESxqrC5nGq+YBPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="23953716"
Received: from ralbanes-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 10:00:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
In-Reply-To: <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1713780345.git.geert+renesas@glider.be>
 <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com>
 <875xw9ttl6.fsf@intel.com>
 <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com>
Date: Mon, 22 Apr 2024 20:00:07 +0300
Message-ID: <87wmops57s.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Mon, Apr 22, 2024, at 15:28, Jani Nikula wrote:
>> On Mon, 22 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>> On Mon, Apr 22, 2024, at 13:50, Jani Nikula wrote:
>>>
>>>> I still disagree with this, because fundamentally the source symbol
>>>> really should not have to care about the dependencies of the target
>>>> symbol.
>>>
>>> Sorry you missed the IRC discussion on #armlinux, we should have
>>> included you as well since you applied the original patch.
>>>
>>> I think the reason for this revert is a bit more nuanced than
>>> just the usability problem. Sorry if I'm dragging this out too
>>> much, but I want to be sure that two points come across:
>>>
>>> 1. There is a semantic problem that is mostly subjective, but
>>>    with the naming as "helper", I generally expect it as a hidden
>>>    symbol that gets selected by its users, while calling same module
>>>    "feature" would be something that is user-enabled and that
>>>    other modules depend on. Both ways are commonly used in the
>>>    kernel and are not mistakes on their own.
>>
>> Fair enough. I believe for (optional) "feature" the common pattern would
>> then be depends on FEATURE || FEATURE=n.
>>
>>> 2. Using "select" on user visible symbols that have dependencies
>>>    is a common source for bugs, and this is is a problem in
>>>    drivers/gpu/drm more than elsewhere in the kernel, as these
>>>    drivers traditionally select entire subsystems or drivers
>>>    (I2C, VIRTIO, INPUT, ACPI_WMI, BACKLIGHT_CLASS_DEVICE,
>>>    POWER_SUPPLY, SND_PCM, INTERCONNECT, ...). This regularly
>>>    leads to circular dependencies and we should fix all of them.
>>
>> What annoys me is that the fixes tend to fall in two categories:
>>
>> - Play catch with selecting the dependencies of the selected
>>   symbols. "depends on" handles this recursively, while select does
>>   not.
>
> I'm not sure where this misunderstanding comes from, as you
> seem to be repeating the same incorrect assumption about
> how select works that Maxime wrote in his changelog. To clarify,
> this works exactly as one would expect:
>
> config HELPER_A
>        tristate
>
> config HELPER_B
>        tristate
>        select HELPER_A
>
> config DRIVER
>        tristate "Turn on the driver and the helpers it uses"
>        select HELPER_B # this recursively selects HELPER_A
>
> Whereas this one is broken:
>
> config FEATURE_A
>        tristate "user visible if I2C is enabled"
>        depends on I2C
>
> config HELPER_B
>        tristate # hidden
>        select FEATURE_A
>
> config DRIVER
>        tristate "This driver is broken if I2C is disabled"
>        select HELPER_B

This case is really what I was referring to, although I was sloppy with
words there. I understand that select does work recursively for selects.

>>   There is no end to this, it just goes on and on, as the
>>   dependencies of the selected symbols change over time. Often the
>>   selects require unintuitive if patterns that are about the
>>   implementation details of the symbol being selected.
>
> Agreed, that is the problem I frequently face with drivers/gpu/drm,
> and most of the time it can only be solved by rewriting the whole
> system to not select user-visible symbol at all.
>
> Using 'depends on' by itself is unfortunately not enough to
> avoid /all/ the problems. See e.g. today's failure
>
> config DRM_DISPLAY_HELPER
>        tristate "DRM Display Helpers"
>        default y
>
> config DRM_DISPLAY_DP_HELPER
>        bool "DRM DisplayPort Helpers"
>        depends on DRM_DISPLAY_HELPER
>
> config DRM_PANEL_LG_SW43408
>        tristate "LG SW43408 panel"
>        depends on DRM_DISPLAY_DP_HELPER
>
> This version is still broken for DRM_DISPLAY_HELPER=m,
> DRM_DISPLAY_DP_HELPER=m, DRM_PANEL_LG_SW43408=y because
> the dependency on the bool symbol is not enough to
> ensure that DRM_DISPLAY_HELPER is also built-in, so you
> still need explicit dependencies on both
> DRM_DISPLAY_HELPER and DRM_DISPLAY_DP_HELPER in the users.
>
> This can be solved by making DRM_DISPLAY_DP_HELPER a
> tristate symbol and adjusting the #ifdef checks and
> Makefile logic accordingly, which is exactly what you'd
> need to do to make it work with 'select' as well.

So bool is kind of problematic for depends on and select even when it's
not really used for describing builtin vs. no, but rather yes vs. no?

>> - Brush the invalid configs under the rug by using IS_REACHABLE(),
>>   switching from a loud link time failure to a silent runtime
>>   failure. (I regularly reject patches adding IS_REACHABLE() to i915,
>>   because from my pov e.g. i915=y backlight=m is an invalid
>>   configuration that the user shouldn't have to debug at runtime. But I
>>   can't express that in kconfig while everyone selects backlight.)
>
> Thanks a lot for rejecting the IS_REACHABLE() patches, it is
> indeed the worst way to handle those (I know, as I introduced
> IS_REACHABLE() only to replace open-coded versions of the same,
> not to have it as a feature or to use it in new code).
>
>> If you have other ideas how these should be fixed, I'm all ears.
>>
>>>    The display helpers however don't have this problem because
>>>    they do not have any dependencies outside of drivers/gpu/
>>
>> Fair enough, though I think they still suffer from some of them having
>> dependencies. (Wasn't this how the original patches and the debate all
>> got started?)
>
> I believe that Maxime said on IRC that he only did the patches
> originally because he expected problems with them based on his
> understanding on how Kconfig works. I'm not aware of any
> particular problem here.
>
> Let me know if you see a problem with any of the symbols that
> Geert has proposed for reverting, and I'll try to find a solution.

I think there will still be some things that select and some other
things that depends on DRM_DISPLAY_HELPER, for example. Usually that's a
recipe for kconfig failures down the line. (Is it ever a good idea?)

For example, after this series, we'll (again) have:

config DRM_DISPLAY_DP_AUX_CEC
	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
	depends on DRM && DRM_DISPLAY_HELPER
	select DRM_DISPLAY_DP_HELPER
	select CEC_CORE

Should we now also drop the help from DRM_DISPLAY_HELPER, and select it
everywhere, including here, and in DRM_DISPLAY_HDCP_HELPER and
DRM_DISPLAY_HDMI_HELPER?

> In my randconfig test environment, I have several patches that
> I sent in the past to clean up the ACPI_VIDEO, I2C, BACKLIGHT and
> LED dependencies to stop using 'select' as I could not otherwise
> get nouveau, i915 and xe to build reliably, but that means I
> may be missing some of the other problems.

Yeah, these seem to be the really problematic ones. I admit I may have
been misguided in insisting the same approach to the helpers that should
be used here; at least the helpers should be easier to fix without
selecting the target symbol dependencies in the source symbols.

BR,
Jani.


-- 
Jani Nikula, Intel

