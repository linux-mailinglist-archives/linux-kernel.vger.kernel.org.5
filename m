Return-Path: <linux-kernel+bounces-69100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C8858475
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50D5B26216
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4A1332A8;
	Fri, 16 Feb 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMRttiIk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF3132472
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105442; cv=none; b=T6lMQVgCzgBhtO3kOks3OUmlnUaA+CFe7EwME7H6RKsgHYo2H0p6U293EIsO6p3DjR+3qLeBgg3V2hO/MzUFeEFH7HnZu+XaLr2c4PoS8d5wUwUF0CT/OCPqoNJ0BEniKDBxkr3l+N6C8CVo6dgyQJJRP2mxZ2crSauhJJkPCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105442; c=relaxed/simple;
	bh=Vp2sP+hVGRaYxsIsbYmPQbJHb9mX+CXXwxtXpLpfDOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4K6IQXatZeDdkrv7Meahk51Qn6I76GeEWHw2keKJbDdhGn/M5mizJ+4AexDF3OPST+A70UqFZHFiRZsoyLrHHKQAw4YYBC9oGqUkycEJfyM9upiIruu81osrmePtQifUKwbmiK1IziZHXqxVm+CzofB7vibAw8PxXBvsdJ3S9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMRttiIk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708105441; x=1739641441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vp2sP+hVGRaYxsIsbYmPQbJHb9mX+CXXwxtXpLpfDOI=;
  b=SMRttiIk+3P/Erl9tgM13gL/PMk1RXtp0d8f9hIDFPGjNWdFtz5s6XUT
   dvCWFxjAg5oyn4mEFcKTXoG+BERY8gD5IHP/3TPIn7czBUlOsY9Z4QpXE
   ZriiQKgv6iE73LT8k6lQ6qbUgaIQMqDwl1RBksae8Eo+oUtNJDINfMml9
   uUVkNMvZjjOMDZEpQAhKUp7/k+Rj9HA88GBhdassr8dtkOYFyA9rgzONe
   l3X1z1qv5/f0ZjJJsZKim9hNtff/4JwO7diqKPHfZz9nWu4sgSFkJzGeh
   +0NXQ2XjgSqc5HJf9GymDSVyR7Ig/kU7EyntLT9z2klAQ1xRp0hTDRFRm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6052116"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6052116"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4253874"
Received: from pclear1x-mobl.ger.corp.intel.com (HELO [10.213.230.254]) ([10.213.230.254])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:43:57 -0800
Message-ID: <cfe1870f-16ff-45b4-8966-6bb536d3cae7@linux.intel.com>
Date: Fri, 16 Feb 2024 17:43:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Always record job cycle and timestamp information
Content-Language: en-US
To: Daniel Vetter <daniel@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Lionel Landwerlin <lionel.g.landwerlin@linux.intel.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20240214121435.3813983-1-adrian.larumbe@collabora.com>
 <ba987da3-b4aa-410c-95ae-434e94793d85@arm.com>
 <CAKMK7uH=QKSyMgsOYCHMwE7iv6jQZRwUMcKq=HiXsBXBCv5BCQ@mail.gmail.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAKMK7uH=QKSyMgsOYCHMwE7iv6jQZRwUMcKq=HiXsBXBCv5BCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16/02/2024 16:57, Daniel Vetter wrote:
> On Wed, Feb 14, 2024 at 01:52:05PM +0000, Steven Price wrote:
>> Hi Adrián,
>>
>> On 14/02/2024 12:14, Adrián Larumbe wrote:
>>> A driver user expressed interest in being able to access engine usage stats
>>> through fdinfo when debugfs is not built into their kernel. In the current
>>> implementation, this wasn't possible, because it was assumed even for
>>> inflight jobs enabling the cycle counter and timestamp registers would
>>> incur in additional power consumption, so both were kept disabled until
>>> toggled through debugfs.
>>>
>>> A second read of the TRM made me think otherwise, but this is something
>>> that would be best clarified by someone from ARM's side.
>>
>> I'm afraid I can't give a definitive answer. This will probably vary
>> depending on implementation. The command register enables/disables
>> "propagation" of the cycle/timestamp values. This propagation will cost
>> some power (gates are getting toggled) but whether that power is
>> completely in the noise of the GPU as a whole I can't say.
>>
>> The out-of-tree kbase driver only enables the counters for jobs
>> explicitly marked (BASE_JD_REQ_PERMON) or due to an explicit connection
>> from a profiler.
>>
>> I'd be happier moving the debugfs file to sysfs rather than assuming
>> that the power consumption is small enough for all platforms.
>>
>> Ideally we'd have some sort of kernel interface for a profiler to inform
>> the kernel what it is interested in, but I can't immediately see how to
>> make that useful across different drivers. kbase's profiling support is
>> great with our profiling tools, but there's a very strong connection
>> between the two.
> 
> Yeah I'm not sure whether a magic (worse probably per-driver massively
> different) file in sysfs is needed to enable gpu perf monitoring stats in
> fdinfo.
> 
> I get that we do have a bit a gap because the linux perf pmu stuff is
> global, and you want per-process, and there's kinda no per-process support
> for perf stats for devices. But that's probably the direction we want to
> go, not so much fdinfo. At least for hardware performance counters and
> things like that.
> 
> Iirc the i915 pmu support had some integration for per-process support,
> you might want to chat with Tvrtko for kernel side and Lionel for more
> userspace side. At least if I'm not making a complete mess and my memory
> is vaguely related to reality. Adding them both.

Yeah there are two separate things, i915 PMU and i915 Perf/OA.

If my memory serves me right I indeed did have a per-process support for 
i915 PMU implemented as an RFC (or at least a branch somewhere) some 
years back. IIRC it only exposed the per engine GPU utilisation and did 
not find it very useful versus the complexity. (I think it at least 
required maintaining a map of drm clients per task.)

Our more useful profiling is using a custom Perf/OA interface 
(Observation Architecture) which is possibly similar to kbase mentioned 
above. Why it is a custom interface is explained in a large comment on 
top of i915_perf.c. Not sure if all of them still hold but on the 
overall perf does not sound like the right fit for detailed GPU profiling.

Also PMU drivers are very challenging to get the implementation right, 
since locking model and atomicity requirements are quite demanding.

 From my point of view, at least it is my initial thinking, if custom 
per driver solutions are strongly not desired, it could be interesting 
to look into whether there is enough commonality, in at least concepts, 
to see if a new DRM level common but extensible API would be doable. 
Even then it may be tricky to "extract" enough common code to justify it.

Regards,

Tvrtko

> 
> Cheers, Sima
> 
> 
>>
>> Steve
>>
>>> Adrián Larumbe (1):
>>>    drm/panfrost: Always record job cycle and timestamp information
>>>
>>>   drivers/gpu/drm/panfrost/Makefile           |  2 --
>>>   drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ------------------
>>>   drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 ------------
>>>   drivers/gpu/drm/panfrost/panfrost_device.h  |  1 -
>>>   drivers/gpu/drm/panfrost/panfrost_drv.c     |  5 -----
>>>   drivers/gpu/drm/panfrost/panfrost_job.c     | 24 ++++++++-------------
>>>   drivers/gpu/drm/panfrost/panfrost_job.h     |  1 -
>>>   7 files changed, 9 insertions(+), 59 deletions(-)
>>>   delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
>>>   delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
>>>
>>>
>>> base-commit: 6b1f93ea345947c94bf3a7a6e668a2acfd310918
>>
> 
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

