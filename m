Return-Path: <linux-kernel+bounces-155295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FDD8AE860
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A70B23084
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A7136655;
	Tue, 23 Apr 2024 13:38:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FC13664A;
	Tue, 23 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879527; cv=none; b=RJhiGHClFKeLC6YtAZMK64LfHAHroIhan136mJ5omeS7mm1f0+iPW5cv2Z3ZOdLYhWA0Un5QwdAGk8WCeu3hX1+vG3VlP4e/z5E/G8ol9ikTTJVo8eWgRj0ZUC2UGIRabJ/INuLO1iiFGK2mf9uVzskz94/RQhyZ/2srFcj4thI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879527; c=relaxed/simple;
	bh=PfhZ9BWya075TMeIKQE4oWCcQuH0pMJSpG0ApxJMxuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PENRTkNMvshJ6518DG22qCSvuBx8Y92xGsBxbV34utusqV2m+jFym68Feakwufw2M/unI9K+LoNlaWDXrtOAXx5g9pDn6Qsj6bJry9CGclcaReYGmgjb1ZAMZ/ags6sl8QrQPaKZEtfXN6Zx5s5d6PmLJc6TPFsOZtUf6M4zzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 369F8339;
	Tue, 23 Apr 2024 06:39:10 -0700 (PDT)
Received: from [10.57.76.137] (unknown [10.57.76.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F1193F64C;
	Tue, 23 Apr 2024 06:38:41 -0700 (PDT)
Message-ID: <95c30582-4fba-4e2d-8cc1-776b3e5507b7@arm.com>
Date: Tue, 23 Apr 2024 14:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <4918025.31r3eYUQgx@kreacher>
 <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
 <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org>
 <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
 <2acea3c3-5c8f-4f3c-a275-743c3fbfd2e6@linaro.org>
 <CAJZ5v0j5Ja9-vuC9ve9Li=UxATcBtTmdMdhMS1g993XBe1DVqw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0j5Ja9-vuC9ve9Li=UxATcBtTmdMdhMS1g993XBe1DVqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/23/24 13:26, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 6:12 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/04/2024 17:48, Rafael J. Wysocki wrote:
>>> On Mon, Apr 22, 2024 at 5:34 PM Daniel Lezcano
>>
>> [ ... ]
>>
>>>> or we should expect at least the residency to be showed even if the
>>>> mitigation state is not closed ?
>>>
>>> Well, in fact the device has already been in that state for some time
>>> and the mitigation can continue for a while.
>>
>> Yes, but when to update the residency time ?
>>
>> When we cross a trip point point ?
>>
>> or
>>
>> When we read the information ?
>>
>> The former is what we are currently doing AFAIR
> 
> Not really.
> 
> Records are added by thermal_debug_cdev_state_update() which only runs
> when __thermal_cdev_update() is called, ie. from governors.
> 
> Moreover, it assumes the initial state to be 0 and checks if the new
> state is equal to the current one before doing anything else, so it
> will not make a record for the 0 state until the first transition.

Correct, AFAIKS.

> 
>> and the latter must add the delta between the last update and the current time for the current
>> state, right ?
> 
> Yes, and it is doing this already AFAICS.
> 
> The problem is that it only creates a record for the old state, so if
> the new one is seen for the first time, there will be no record for it
> until it changes to some other state.

Exactly, it's not totally wrong what we have now, just some missing part
that needs to be added in the code, while we are counting/updating
these stats.

> 
> The appended patch (modulo GMail-induced white space breakage) should
> help with this, but the initial state handling needs to be addressed
> separately.
> 
> ---
>   drivers/thermal/thermal_debugfs.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -433,6 +433,14 @@ void thermal_debug_cdev_state_update(con
>       }
> 
>       cdev_dbg->current_state = new_state;
> +
> +    /*
> +     * Create a record for the new state if it is not there, so its
> +     * duration will be printed by cdev_dt_seq_show() as expected if it
> +     * runs before the next state transition.
> +     */
> +    thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations,
> new_state);
> +
>       transition = (old_state << 16) | new_state;
> 
>       /*

Yes, something like this should do the trick. We will get the record
entry in the list, so we at least enter the list loop in the
cdev_dt_seq_show().



