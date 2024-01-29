Return-Path: <linux-kernel+bounces-43137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686B840C16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B781C214F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4A15698A;
	Mon, 29 Jan 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAWLzYVj"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BFB157038;
	Mon, 29 Jan 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546819; cv=none; b=fVoZ5IysNY0oHdvJ03wt7hsEL61tXRTKpTBmhIu929kyEWRnd0LTn3/G6pMfDm0eUd8yd2aII0oxIUYpDn3rZSXqdJT4bnqUR+3U4kRv+tfcBV47YK2PcRs4qmJr1qOGu4mpWrgH3R8sZ7UbhOBZYz86h1QWfoJjz3lThyw9fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546819; c=relaxed/simple;
	bh=44NsvH+KQdpWMlSBMIAtXvkxIIBjDimdakKzD/tf1eI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3wOuZl3KWh4vmNnXZ9ZmTVD//jF8Ni7w1bcZt3hN7DHbBLbb5aZEX9Ky75T502ApZP1xRVfglMT+iInVh2F2ik2+1GUhmy1DIaFFIFw8IL3xI8xab9A9wdhBMz1bblqGIF9D9jGCjGwaVZYz9toxEzrzgO1yGed+7U3iolIbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAWLzYVj; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706546817; x=1738082817;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=44NsvH+KQdpWMlSBMIAtXvkxIIBjDimdakKzD/tf1eI=;
  b=jAWLzYVjlY12yg+214YAeg3AKA40sLIlgXrP2bOheCzb0a7HDpuXCJ6/
   g5unUVLPeBb1Zjq0XbWuCl/4Uy1KKlqiAa9Dp8GdEElg6fAfKGQIrADhL
   sM2sWBnT35W9hvicmsyOkKZgP1ei614Izzdko1BzUay98o8kmN8b8PQqY
   e58NrYFJeoTysot9tR5Yfpj5iBECf/bs5hFeg2bYL5J3VbJfAoOjZGLx8
   KHX7OaI5jJLqbEZRk5fU/dAv0dzB4Re/y9fB6oXFWQxbmDERgelgUPxa0
   SLl4jNuw9QL31Al0UQWFu18bbBu2bWj5BbQ8TX8YEQDMYm+epQrJLpqSG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467262299"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="467262299"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3423587"
Received: from hbrandbe-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.53])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:46:53 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "open
 list:ACPI" <linux-acpi@vger.kernel.org>, Mark Pearson
 <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH 2/2] drm/amd: Fetch the EDID from _DDC if available for eDP
In-Reply-To: <63c60424-1b2d-4912-81b2-7c7ead4c8289@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240126184639.8187-1-mario.limonciello@amd.com>
 <20240126184639.8187-3-mario.limonciello@amd.com>
 <87le88jx63.fsf@intel.com> <63c60424-1b2d-4912-81b2-7c7ead4c8289@amd.com>
Date: Mon, 29 Jan 2024 18:46:49 +0200
Message-ID: <87cytkjddy.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 29 Jan 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> On 1/29/2024 03:39, Jani Nikula wrote:
>> On Fri, 26 Jan 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
>>> index 9caba10315a8..c7e1563a46d3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
>>> @@ -278,6 +278,11 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
>>>   	struct amdgpu_device *adev = drm_to_adev(dev);
>>>   	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
>>>   
>>> +	if (amdgpu_connector->edid)
>>> +		return;
>>> +
>>> +	/* if the BIOS specifies the EDID via _DDC, prefer this */
>>> +	amdgpu_connector->edid = amdgpu_acpi_edid(adev, connector);
>> 
>> Imagine the EDID returned by acpi_video_get_edid() has edid->extensions
>> bigger than 4. Of course it should not, but you have no guarantees, and
>> it originates outside of the kernel.
>> 
>> The real fix is to have the function return a struct drm_edid which
>> tracks the allocation size separately. Unfortunately, it requires a
>> bunch of changes along the way. We've mostly done it in i915, and I've
>> sent a series to do this in drm/bridge [1].

Looking at it again, perhaps the ACPI code should just return a blob,
and the drm code should have a helper to wrap that around struct
drm_edid, so that the ACPI code does not have to depend on drm. Basic
idea remains.

>> Bottom line, we should stop using struct edid in drivers. They'll all
>> parse the info differently, and from what I've seen, often wrong.
>> 
>> 
>
> Thanks for the feedback.  In that case this specific change should 
> probably rebase on the Melissa's work 
> https://lore.kernel.org/amd-gfx/20240126163429.56714-1-mwen@igalia.com/ 
> after she takes into account the feedback.
>
> Let me ask you this though - do you think that after that's done should 
> we let all drivers get EDID from BIOS as a priority?  Or would you 
> prefer that this is unique to amdgpu?

If the reason for having this is that the panel EDID contains some
garbage, that's certainly not unique to amdgpu... :p

> Something like:
>
> 1) If user specifies on kernel command line and puts an EDID in 
> /lib/firmware use that.
> 2) If BIOS has EDID in _DDC and it's eDP panel, use that.

I think we should also look into this. We currently don't do this, and
it might help with some machines. However, gut feeling says it's
probably better to keep this as a per driver decision instead of trying
to bolt it into drm helpers.

BR,
Jani.


> 3) Get panel EDID.
>

-- 
Jani Nikula, Intel

