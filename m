Return-Path: <linux-kernel+bounces-56181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC784C713
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BFC1F240AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533D20DC1;
	Wed,  7 Feb 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IB5uZepd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F371D554
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297414; cv=none; b=RXZTjWq+c9UseAnM94zcd3Fp6x4Tm32e3MttupPBQ3AMMwPRDugML+qiFzwKudWNUli+zLADoX3INIQnhzDXl+AEXOFtGWUr4ASXI3usqDafm08M8jRib2xOcG+BkRJgs7Ib5ijODup2wwNEjz999LaKf6YpONrOrvxUWw3EHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297414; c=relaxed/simple;
	bh=zQQCNmahUwZK3qO6Zo+aBo/S2P1qs/t9sW1T2X5nctU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EW6uwbImaURbD9QUvLOC09xKj2jNWvC8KD82P0vAkt1faP9vOIwOuBjaPO6PJ9NTke6bOBmimekc+MC2OnQv1zVAuV0H9QWIBoBEHgCFunI7sEgkoMzXVfHkruaFjZ3OHVHjp+qXwk0Kb9TX8odDuGY1TjwI7cU6KD096ULWCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IB5uZepd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707297413; x=1738833413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQQCNmahUwZK3qO6Zo+aBo/S2P1qs/t9sW1T2X5nctU=;
  b=IB5uZepdBizq31JwXc2j7AmolCQShmrTm9aGBdd3llPLEbsmq9u5JYFb
   u0GXsdWtjH+ez/exPFS1B8HDxlHWSI4Lhnp0VvWxAEr4Jr9PHdpyR3JJY
   0aldbwh3ZZxzYnE0HHuv+9l7BAVmRJQppHDFhEHAZc3hJZnXWd3CGmOCo
   2jhNDEOOtFz7KgJyVqHXLxA5SO2TCcGGM0U8EDOUiY4fcmrmtZ5Ljk7qG
   WJkWyR2N7v27ka80DTYhCn5nDE18uJx37I6jVIrL/9P11YtFvBp9b1qGh
   1i7NPx2jPMB1cxI7XyVP9NB7AlCSsFGFAmHo+y9xUfq5k5Dp9ES9/jaZd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11683702"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="11683702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1559644"
Received: from ahamill-mobl2.ger.corp.intel.com (HELO [10.213.228.167]) ([10.213.228.167])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:16:32 -0800
Message-ID: <3c63aea1-1a04-45eb-9af1-02f52d4132e4@linux.intel.com>
Date: Wed, 7 Feb 2024 09:16:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Prevent possible NULL dereference in
 __caps_show()
Content-Language: en-US
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240206164543.46834-1-n.zhandarovich@fintech.ru>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20240206164543.46834-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 06/02/2024 16:45, Nikita Zhandarovich wrote:
> After falling through the switch statement to default case 'repr' is
> initialized with NULL, which will lead to incorrect dereference of
> '!repr[n]' in the following loop.
> 
> Fix it with the help of an additional check for NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 4ec76dbeb62b ("drm/i915/gt: Expose engine properties via sysfs")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> P.S. The NULL-deref problem might be dealt with this way but I am
> not certain that the rest of the __caps_show() behaviour remains
> correct if we end up in default case. For instance, as far as I
> can tell, buf might turn out to be w/o '\0'. I could use some
> direction if this has to be addressed as well.
> 
>   drivers/gpu/drm/i915/gt/sysfs_engines.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/sysfs_engines.c b/drivers/gpu/drm/i915/gt/sysfs_engines.c
> index 021f51d9b456..6b130b732867 100644
> --- a/drivers/gpu/drm/i915/gt/sysfs_engines.c
> +++ b/drivers/gpu/drm/i915/gt/sysfs_engines.c
> @@ -105,7 +105,7 @@ __caps_show(struct intel_engine_cs *engine,
>   
>   	len = 0;
>   	for_each_set_bit(n, &caps, show_unknown ? BITS_PER_LONG : count) {
> -		if (n >= count || !repr[n]) {
> +		if (n >= count || !repr || !repr[n]) {

There are two input combinations to this function when repr is NULL.

First is show_unknown=true and caps=0, which means the for_each_set_bit 
will not execute its body. (No bits set.)

Second is show_unknown=false and caps=~0, which means count is zero so 
for_each_set_bit will again not run. (Bitfield size input param is zero.)

So unless I am missing something I do not see the null pointer dereference.

What could theoretically happen is that a third input combination 
appears, where caps is not zero in the show_unknown=true case, either 
via a fully un-handled engine->class (switch), or a new capability bit 
not added to the static array a bit above.

That would assert during driver development here:

			if (GEM_WARN_ON(show_unknown))

Granted that could be after the dereference in "if (n >= count || 
!repr[n])", but would be caught in debug builds (CI) and therefore not 
be able to "ship" (get merge to the repo).

Your second question is about empty buffer returned i.e. len=0 at the 
end of the function? (Which is when the buffer will not be null 
terminated - or you see another option?)

That I think is safe too since it just results in a zero length read in 
sysfs.

Regards,

Tvrtko

>   			if (GEM_WARN_ON(show_unknown))
>   				len += sysfs_emit_at(buf, len, "[%x] ", n);
>   		} else {

