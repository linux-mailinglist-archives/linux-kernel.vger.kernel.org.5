Return-Path: <linux-kernel+bounces-164418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116AF8B7D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB7D1C234CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578C17BB0F;
	Tue, 30 Apr 2024 16:47:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836E12C7FA;
	Tue, 30 Apr 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495635; cv=none; b=BwkBQKt0ScFLb/1rpmaZOB1QN1w79eoZRyxfkUn0ueXnnbo0MtqP1xIfggG72Fav0j4z7SEOhZAlgioZpbesRILnDsvIDZc5W+QGp7rssSbpbhyTR9m5PruHYrQVLjoap8brxEfo1leD2UP1wWoawFQ409V8cbPnqhQJZLUUJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495635; c=relaxed/simple;
	bh=93evZwhOPpMP46YPBM7x7WZ4DoHMEWykJH9vC1Lzlfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sstGUmSZ81/7MPOnyzeGHTGBAefrrD557dRmKTAtq6AeJ6fRZDpGTVh19CWvuuoKVhvR/BV4ereFjUKjd00e5rVn6aUPytdbg5hE9HDtR7aBz9U0x7S9a7C5deHDVnu4TIJunOMPEE7F5W5EQC5sMyt1zjg5FitU9tMeBvzWRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B872F4;
	Tue, 30 Apr 2024 09:47:39 -0700 (PDT)
Received: from [10.57.65.13] (unknown [10.57.65.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4431E3F762;
	Tue, 30 Apr 2024 09:47:12 -0700 (PDT)
Message-ID: <73edaf80-9251-4c3b-8fcc-202dd617335a@arm.com>
Date: Tue, 30 Apr 2024 17:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: core: Move passive polling management to
 the core
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <5790995.DvuYhMxLoT@kreacher> <2949052.e9J7NaK4W3@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2949052.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/24 16:52, Rafael J. Wysocki wrote:
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
> v1 -> v2:
>     * Add a WARN_ON() check for tz->passive < 0.
>     * Do not start passive polling until tz->passive is positive.
> 
> ---
>   drivers/thermal/gov_power_allocator.c |   12 +++++++-----
>   drivers/thermal/gov_step_wise.c       |   10 ----------
>   drivers/thermal/thermal_core.c        |   14 +++++++++++---
>   3 files changed, 18 insertions(+), 18 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

