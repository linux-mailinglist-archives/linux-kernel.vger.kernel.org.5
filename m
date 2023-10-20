Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7890F7D1426
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377908AbjJTQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjJTQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:36:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B167D7F;
        Fri, 20 Oct 2023 09:36:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F1A4143D;
        Fri, 20 Oct 2023 09:37:22 -0700 (PDT)
Received: from [10.57.82.142] (unknown [10.57.82.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F473F5A1;
        Fri, 20 Oct 2023 09:36:40 -0700 (PDT)
Message-ID: <ecd3e95c-bfea-4f0e-94c8-28f056b6206a@arm.com>
Date:   Fri, 20 Oct 2023 17:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <13365827.uLZWGnKmhe@kreacher> <3768557.kQq0lBPeGt@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3768557.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 18:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the power allocator thermal governor to use trip pointers instead
> of trip indices everywhere except for the power_allocator_throttle()
> second argument that will be changed subsequently along with the
> definition of the .throttle() governor callback.
> 
> The general functionality is not expected to be changed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_power_allocator.c |  123 +++++++++++++---------------------
>   1 file changed, 49 insertions(+), 74 deletions(-)
> 

[snip]

> @@ -636,7 +619,6 @@ static int power_allocator_bind(struct t
>   {
>   	int ret;
>   	struct power_allocator_params *params;
> -	struct thermal_trip trip;
>   
>   	ret = check_power_actors(tz);
>   	if (ret)
> @@ -662,12 +644,13 @@ static int power_allocator_bind(struct t
>   	get_governor_trips(tz, params);
>   
>   	if (tz->num_trips > 0) {
> -		ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
> -					      &trip);
> -		if (!ret)
> +		const struct thermal_trip *trip;
> +
> +		trip = params->trip_max_desired_temperature;
> +		if (trip)
>   			estimate_pid_constants(tz, tz->tzp->sustainable_power,
>   					       params->trip_switch_on,
> -					       trip.temperature);
> +					       trip->temperature);
>   	}

The code check for the populated pointer (by earlier new
get_governor_trips(tz, params)) :

if (params->trip_max_desired_temperature) {
	int temp = params->trip_max_desired_temperature->temperature;

	estimate_pid_constants(...)
}

looks better (what you have figured out already).

Other than that the patch LGTM:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

I have also tested this is a few ways and it still works as expected:
1. Power allocation in different conditions
2. Trip points properly recognized with this nice get_governor_trips(),
   here is the test output, with many tricky trip point setups:

use case A:
5 trip points:
- 2 passive for 50, 60 degC
- 1 active 70degC
- 2 passive 70, 85 degC
- 1 critical 120 degC

expected IPA trip points: 50, 85 deg => 35 degC IPA operating range

[   24.578806] Power allocator: IPA: trip->temperature=50000
[   24.578824] Power allocator: IPA: passive trip->temperature=50000
[   24.578838] Power allocator: IPA: fist passive trip->temperature=50000
[   24.578851] Power allocator: IPA: trip->temperature=60000
[   24.578863] Power allocator: IPA: passive trip->temperature=60000
[   24.578875] Power allocator: IPA: trip->temperature=70000
[   24.578888] Power allocator: IPA: active trip->temperature=70000
[   24.578900] Power allocator: IPA: trip->temperature=120000
[   24.578912] Power allocator: IPA: trip->temperature=70000
[   24.578925] Power allocator: IPA: passive trip->temperature=70000
[   24.578937] Power allocator: IPA: trip->temperature=85000
[   24.578950] Power allocator: IPA: passive trip->temperature=85000
[   24.578964] Power allocator: IPA: trip_switch_on->temperature=50000 
control_temp=85000
[   24.578978] Power allocator: IPA: temperature_threshold=35000

-------------------------------------------------------------
use case B:
5 trip points:
- 2 active for 50, 60 degC
- 1 active 70degC
- 2 passive 70, 85 degC
- 1 critical 120 degC

expected IPA trip points: 70, 85 deg => 15 degC IPA operating range

[   27.402474] Power allocator: IPA: trip->temperature=50000
[   27.402492] Power allocator: IPA: active trip->temperature=50000
[   27.402505] Power allocator: IPA: trip->temperature=60000
[   27.402518] Power allocator: IPA: active trip->temperature=60000
[   27.402531] Power allocator: IPA: trip->temperature=70000
[   27.402544] Power allocator: IPA: active trip->temperature=70000
[   27.402557] Power allocator: IPA: trip->temperature=120000
[   27.402570] Power allocator: IPA: trip->temperature=70000
[   27.402582] Power allocator: IPA: passive trip->temperature=70000
[   27.402596] Power allocator: IPA: fist passive trip->temperature=70000
[   27.402608] Power allocator: IPA: trip->temperature=85000
[   27.402622] Power allocator: IPA: passive trip->temperature=85000
[   27.402635] Power allocator: IPA: trip_switch_on->temperature=70000 
control_temp=85000
[   27.402649] Power allocator: IPA: temperature_threshold=15000

--------------------------------------------------------
use case C:
6 trip points:
- 2 active for 50, 60 degC
- 1 active 70degC
- 3 passive 70, 85, 90 degC
- 1 critical 120 degC

expected IPA trip points: 50, 85 deg => 20 degC IPA operating range

[   36.998907] Power allocator: IPA: trip->temperature=50000
[   36.998921] Power allocator: IPA: active trip->temperature=50000
[   36.998935] Power allocator: IPA: trip->temperature=60000
[   36.998948] Power allocator: IPA: active trip->temperature=60000
[   36.998960] Power allocator: IPA: trip->temperature=70000
[   36.998973] Power allocator: IPA: active trip->temperature=70000
[   36.998985] Power allocator: IPA: trip->temperature=120000
[   36.998999] Power allocator: IPA: trip->temperature=70000
[   36.999011] Power allocator: IPA: passive trip->temperature=70000
[   36.999024] Power allocator: IPA: fist passive trip->temperature=70000
[   36.999037] Power allocator: IPA: trip->temperature=85000
[   36.999049] Power allocator: IPA: passive trip->temperature=85000
[   36.999062] Power allocator: IPA: trip->temperature=90000
[   36.999074] Power allocator: IPA: passive trip->temperature=90000
[   36.999087] Power allocator: IPA: trip_switch_on->temperature=70000 
control_temp=90000
[   36.999101] Power allocator: IPA: temperature_threshold=20000

