Return-Path: <linux-kernel+bounces-164409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627A8B7D56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9A01F22F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C271791EB;
	Tue, 30 Apr 2024 16:44:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A56D12C7FA;
	Tue, 30 Apr 2024 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495443; cv=none; b=akTsRgtKfxlgWlAiLYlwJoxbJ0kjkn96W5hOMdVgcTj2Ah9WO/XqqoQVrvAohkoOGaqQDidHW20kPnELbjGiHd0/CvpRNZTeAtG3lUol+3KaIblHk+b6bY0lXAawM4PDipsloMFO8pQl3NllXnwZghnK6Msvfs8hZLq2YXKFIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495443; c=relaxed/simple;
	bh=v8K8vEmJ0RqXAC0tJopsQxCRVo5OmqZhLNA/uVb5msA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpPAC8u2iWdrF5oSu28nRoiq/EYsDn7d/BMwTJsTBu5bY1wUmh/5arCM8yeuVWjiv7va9iBElGM8ctpI0akixS1NuQt1HLJZNajFOMFsaEEBITAClau6f5cnqgVojaUVAluexPjU8FO8OKB4hSm7inlEnE27WJgurm64V6vROVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4989D2F4;
	Tue, 30 Apr 2024 09:44:27 -0700 (PDT)
Received: from [10.57.65.13] (unknown [10.57.65.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F022C3F762;
	Tue, 30 Apr 2024 09:43:59 -0700 (PDT)
Message-ID: <4f5efb62-b490-4295-bce6-58f63d1287a1@arm.com>
Date: Tue, 30 Apr 2024 17:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: core: Do not call handle_thermal_trip()
 if zone temperature is invalid
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <5790995.DvuYhMxLoT@kreacher> <4902888.GXAFRqVoOG@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4902888.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/24 16:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make __thermal_zone_device_update() bail out if update_temperature()
> fails to update the zone temperature because __thermal_zone_get_temp()
> has returned an error and the current zone temperature is
> THERMAL_TEMP_INVALID (user space receiving netlink thermal messages,
> thermal debug code and thermal governors may get confused otherwise).
> 
> Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing notifications at init time if needed")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch in v2.
> 
> ---
>   drivers/thermal/thermal_core.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -487,6 +487,9 @@ void __thermal_zone_device_update(struct
>   
>   	update_temperature(tz);
>   
> +	if (tz->temperature == THERMAL_TEMP_INVALID)
> +		return;
> +
>   	__thermal_zone_set_trips(tz);
>   
>   	tz->notify_event = event;
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

