Return-Path: <linux-kernel+bounces-161894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA48B52D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427F5B20C96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA9171B6;
	Mon, 29 Apr 2024 08:09:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9592D14A8D;
	Mon, 29 Apr 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378147; cv=none; b=Cen/30DofotBA9b+9B9NSaoE141UTZ+IvuPrYpWBbG4yFq3ft2bEyEaWhTn72W+tz6H7YHlK9BAAj943wGiPQsWRsjKLXmoTQkUzfzrOuXw4LPx9ixb/eKNaW0f+iOKjOoIHjOsxaXogVUqjG+gsC5Jx/lCZt//FvDLh9z8JzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378147; c=relaxed/simple;
	bh=Xw1L+ZSzWxvqVKxIaQDKHeBhzPaUvwzATtm/SMBVKS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rt1fbv/94GB2+CJF/Uqgw6X+tgvxSHk37NZcF5+paXBEAadpVKWzlo9M/ncifyLRS5iESrER/yQ/4xAG3xD0eurewaJhHyy7DzewXrwNcLAK8yjyluTFus4fyr5dfnKZVsB4taLMUqLJsqqsnoDIRZf/EBe9fBgbUDKqYk2qA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E542F4;
	Mon, 29 Apr 2024 01:09:31 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6FE3F73F;
	Mon, 29 Apr 2024 01:09:03 -0700 (PDT)
Message-ID: <5cf7d491-b0c1-4ffe-b66c-8c97331b7b76@arm.com>
Date: Mon, 29 Apr 2024 09:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Move passive polling management to the
 core
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <5938055.MhkbZ0Pkbq@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5938055.MhkbZ0Pkbq@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 15:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Passive polling is enabled by setting the 'passive' field in
> struct thermal_zone_device to a positive value so long as the
> 'passive_delay_jiffies' field is greater than zero.  It causes
> the thermal core to actively check the thermal zone temperature
> periodically which in theory should be done after crossing a
> passive trip point on the way up in order to allow governors to
> react more rapidly to temperature changes and adjust mitigation
> more precisely.
> 
> However, the 'passive' field in struct thermal_zone_device is currently
> managed by governors which is quite problematic.  First of all, only
> two governors, Step-Wise and Power Allocator, update that field at
> all, so the other governors do not benefit from passive polling,
> although in principle they should.  Moreover, if the zone governor is
> changed from, say, Step-Wise to Fair-Share after 'passive' has been
> incremented by the former, it is not going to be reset back to zero by
> the latter even if the zone temperature falls down below all passive
> trip points.
> 
> For this reason, make handle_thermal_trip() increment 'passive'
> to enable passive polling for the given thermal zone whenever a
> passive trip point is crossed on the way up and decrement it
> whenever a passive trip point is crossed on the way down.  Also
> remove the 'passive' field updates from governors and additionally
> clear it in thermal_zone_device_init() to prevent passive polling
> from being enabled after a system resume just beacuse it was enabled
> before suspending the system.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This has been mentioned here:
> 
> https://lore.kernel.org/linux-pm/61560bc6-d453-4b0c-a4ea-b375d547b143@linaro.org/
> 
> and I need someone to double check if the Power Allocator governor does not
> need to be adjusted more for this change.

I'll do this today (and the rest of the patch as well).

