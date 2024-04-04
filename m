Return-Path: <linux-kernel+bounces-132185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FA89910F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616D01F24EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914C13C3F1;
	Thu,  4 Apr 2024 22:13:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873082D90;
	Thu,  4 Apr 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268788; cv=none; b=KZfOojUAINESTf3XDQsvSlmKwIHcgygRNK7lkS4Rq7OirbZvuSUaEayYaMm5FPHT16c0nbDdZVHtI0kgwvMgoj3Fbmax+My6+sanSYjIKGgztpqVu5mPb9vP2d7tqmC+oGcc67+gwpDHm0TmZPfUYC138rWBz1eVBI5Dhg8/S9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268788; c=relaxed/simple;
	bh=nH2p+7zXAeIipU/pA+wrG340BFQBleZqxM1Zv86nB30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NviaMuyiwGENf8DLHd/gd67E/wuzk+7L4vFlZElPpUfr+6iEhL7DHH6j+3it+KouC9vBXoD1kdC+6ejqyLKYuxBT1zzxuh6nzwQTE4NQsbeY+QtfNcoC8OIAuGNDToC6d7yvLIGmGuajtfD+aJ2Gagtugvi7Qbyh4D8NjhFxE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0345DFEC;
	Thu,  4 Apr 2024 15:13:36 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3043F64C;
	Thu,  4 Apr 2024 15:13:04 -0700 (PDT)
Message-ID: <5f3a7cb9-d2a0-4713-be3a-2187a40ec82d@arm.com>
Date: Thu, 4 Apr 2024 23:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: core: Make struct thermal_zone_device
 definition internal
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <13485814.uLZWGnKmhe@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <13485814.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/24 19:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the definitions of struct thermal_trip_desc and struct
> thermal_zone_device to an internal header file in the thermal core,
> as they don't need to be accessible to any code other than the thermal
> core and so they don't need to be present in a global header.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Minor changelog update
> 
> v1 -> v2: No changes
> 
> ---
>   drivers/thermal/thermal_core.h  |   85 +++++++++++++++++++++++++++++++++++++++
>   drivers/thermal/thermal_trace.h |    2
>   include/linux/thermal.h         |   87 ----------------------------------------
>   3 files changed, 89 insertions(+), 85 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

