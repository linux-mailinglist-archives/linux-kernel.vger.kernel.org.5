Return-Path: <linux-kernel+bounces-71250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DF85A279
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE85D1F262DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611436AE0;
	Mon, 19 Feb 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTAYxurw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C0364C6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343368; cv=none; b=JlSn632IVhUiceY8VK7prTh6ENkzODcqfbLcmR2EudXVeQsCiSDz/ywpCuomPaLJaBVNUFdvegUqHUFYt/PW2oaWL9wEEZhWIkONTlJDQrk2ynMQw4oE66vEwhPTqR+yJ35iiRTUZGzS+0q2fiXtR6c4bW2VRDfXx6sK+0A7cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343368; c=relaxed/simple;
	bh=42XZ7hX+wU9FWriVYFFf2JlaTu+LTLTxliJ/DxOsXJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Svir4Aedq9NxI7KNPBdvNcDwHuIEnQ98RvYTblXRrpmEc8iOJNsQ/D+6UGBPXgrSeekbmcZWVOArdCCv8EGDhcaTVzcvyIFVCxSosK6iw/au4yeIn+hUAvMVzUqUofjcmXc46AHAd4JWhOPk0H+QKsvi89fji1+/Iza9laYyDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTAYxurw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343367; x=1739879367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=42XZ7hX+wU9FWriVYFFf2JlaTu+LTLTxliJ/DxOsXJg=;
  b=lTAYxurw1DHGf8WCWL4ZxY0/nj8sQjesuuEMengKraNYJpFNuybyzpGL
   +FAmWoPt3Qizk2SaztKl73IoC/X5urISnNPwuj43mcG8kuosOvqQ3CVeO
   iGRvwsGJmp/qCgbZB2M19m3bEgR9/tkxa4snR4yqsVKPFs3KBiAVRtgK6
   +6dU4eHuLzqpE/MgvDP8WyYKBK4He1w4LLUhttFx6HBHbUpzfgxaVYfPn
   iUvA+5ZAOxGNXqIbQiZv7yDAyUfAEHCEd+bolJTVZ/ER8d4KZWiRESAQA
   As60izrah1gXuxsEn1Q02nD2f4rvRRqG2+CJ9jrFSCWPQoKJjaSa0ejdd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2282126"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2282126"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9139099"
Received: from proe-mobl.ger.corp.intel.com (HELO [10.252.22.52]) ([10.252.22.52])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:49:23 -0800
Message-ID: <124a084e-9f8e-4b38-a0e3-9dfac0312e97@intel.com>
Date: Mon, 19 Feb 2024 11:49:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tests/drm_buddy: avoid 64-bit calculation
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 David Gow <davidgow@google.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240216202442.2493031-1-arnd@kernel.org>
 <745e156e-c3ec-427f-98ad-bfc7d3cfd846@infradead.org>
 <4cdc5b58-11c1-490d-8c3b-6352d8f1b8cb@amd.com>
 <fbd0426c-fdd2-4b7f-a13e-072ed5f973de@app.fastmail.com>
 <a293460f-6a40-427f-b5d2-2e701d1af229@amd.com>
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <a293460f-6a40-427f-b5d2-2e701d1af229@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2024 11:41, Christian König wrote:
> Am 19.02.24 um 12:29 schrieb Arnd Bergmann:
>> On Mon, Feb 19, 2024, at 12:22, Christian König wrote:
>>> Am 17.02.24 um 02:31 schrieb Randy Dunlap:
>>>> On 2/16/24 12:24, Arnd Bergmann wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>>
>>>>> The newly added drm_test_buddy_alloc_contiguous() test fails to 
>>>>> link on
>>>>> 32-bit targets because of inadvertent 64-bit calculations:
>>>>>
>>>>> ERROR: modpost: "__aeabi_uldivmod" 
>>>>> [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
>>>>> ERROR: modpost: "__aeabi_ldivmod" 
>>>>> [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
>>>>>
>>>>> >From what I can tell, the numbers cannot possibly overflow a 
>>>>> 32-bit size,
>>>>> so use different types for these.
>>>>>
>>>>> I noticed that the function has another possible flaw in that is mixes
>>>>> what it calls pages with 4KB units. This is a big confusing at best,
>>>>> or possibly broken when built on machines with larger pages.
>>>>>
>>>>> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>> I've just pushed a similar patch Mathew came up a bit earlier to
>>> drm-misc-fixes.
>>>
>>> Sorry for the noise, I have to catch up on picking up patches for
>>> misc-fixes and misc-next.
>> Ok, thanks.
>>
>> Have you looked at how this code works for larger values of PAGE_SIZE?
>> Is there any need to change other things or will this work with the
>> hardcoded 4KB chunks?
> 
> I haven't looked into the details, but I've pointed out before that 
> using PAGE_SIZE in the buddy or its test cases would be incorrect.
> 
> Background is that the buddy allocator is for devices and those work 
> independent of the CPU PAGE_SIZE. So it can be that on a CPU with 64k 
> pages the buddy still needs to work with 4k.
> 
> Could be that this is work, but could as well be that this is completely 
> broken. Arun and Mathew needs to answer this, I haven't tested it nor 
> reviewed the code.

Yeah, we should not be using PAGE_SIZE or PAGE_SHIFT in drm_buddy.[ch] 
and tests/drm_buddy_test.c. The smallest default page size is SZ_4K for 
drm_buddy. A patch to fix that would be very welcome. If no takers I can 
send something.

> 
> Regards,
> Christian.
> 
>>
>>       Arnd
> 

