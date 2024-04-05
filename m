Return-Path: <linux-kernel+bounces-132746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7993589998F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE3283260
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0457160783;
	Fri,  5 Apr 2024 09:34:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF5814658C;
	Fri,  5 Apr 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309685; cv=none; b=H72ZqahUwys601wHEvv9CTea+38LADJvsxwO156iQP605RoK/j1VNc+/QMdbS6BIj3BGI2BFWWO2gSL7rybxUunikmeQF6vExy6TPXFv3f5Fc5U79wVSqeryiVDwooNq1faAgvcPflJhSG1WSPtWYwq+JzYZQ4qbxZvlkTej3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309685; c=relaxed/simple;
	bh=ahzdwbgj+o5cir41CNjL0fFahwMszfTtje3SqQIi+qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCmRoQZBlLcYZtnZGCjm4UOuYgdJEo+k7QkT5sbcJO/8OwR6NitKVKZDqh1Ehv/ByuR42MwqX8zBWhIuxIrLC/k6PkwwfGED0xAtCvkrYDwruAv79igqqSNWfkhAGGFu3gl5Tb2+UJa1mP1lv9HuMDnVnZ4R1xKGhlHSNlylsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75228FEC;
	Fri,  5 Apr 2024 02:35:13 -0700 (PDT)
Received: from [10.57.74.176] (unknown [10.57.74.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B76E33F64C;
	Fri,  5 Apr 2024 02:34:41 -0700 (PDT)
Message-ID: <b7733517-4a7e-4314-9a36-3e3cab0df029@arm.com>
Date: Fri, 5 Apr 2024 10:34:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [STABLE 5.15][PATCH] thermal: devfreq_cooling: Fix perf state
 when calculate dfc res_util
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 ye.zhang@rock-chips.com, d-gole@ti.com, rafael@kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240404101329.1956664-1-lukasz.luba@arm.com>
 <2024040558-defection-shadily-1879@gregkh>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2024040558-defection-shadily-1879@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/5/24 10:33, Greg KH wrote:
> On Thu, Apr 04, 2024 at 11:13:29AM +0100, Lukasz Luba wrote:
>> From: Ye Zhang <ye.zhang@rock-chips.com>
>>
>> The issue occurs when the devfreq cooling device uses the EM power model
>> and the get_real_power() callback is provided by the driver.
>>
>> The EM power table is sorted ascending，can't index the table by cooling
>> device state，so convert cooling state to performance state by
>> dfc->max_state - dfc->capped_state.
>>
>> Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
>> Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
>> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>
>> Hi Greg,
>>
>> I have solved small backporting conflict to that v5.15.
>> The patch is based on tag v5.15.99 and it's for this
>> failing backport:
>> https://lore.kernel.org/stable/2024033050-imitation-unmixed-ef53@gregkh/
> 
> Thanks, next time all that I need is the git id of this in Linus's tree,
> no need to point to a previous FAILED email.

OK, I will remember.

Regards,
Lukasz

