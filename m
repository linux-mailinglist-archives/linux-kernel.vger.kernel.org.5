Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B937D1472
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJTQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:58:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A0269E;
        Fri, 20 Oct 2023 09:58:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A76143D;
        Fri, 20 Oct 2023 09:58:44 -0700 (PDT)
Received: from [10.57.82.142] (unknown [10.57.82.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D733F5A1;
        Fri, 20 Oct 2023 09:58:01 -0700 (PDT)
Message-ID: <430d4342-a2fd-431f-b279-92ea90b83778@arm.com>
Date:   Fri, 20 Oct 2023 17:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] thermal: trip: Simplify computing trip indices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <13365827.uLZWGnKmhe@kreacher> <3256881.aeNJFYEL58@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3256881.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 18:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A trip index can be computed right away as a difference between the
> value of a trip pointer pointing to the given trip object and the
> start of the trips[] table in the thermal zone containing the trip, so
> change thermal_zone_trip_id() accordingly.
> 
> No intentional functional impact (except for some speedup).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_trip.c |   13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -175,14 +175,11 @@ int thermal_zone_set_trip(struct thermal
>   int thermal_zone_trip_id(struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip)
>   {
> -	int i;
> -
>   	lockdep_assert_held(&tz->lock);
>   
> -	for (i = 0; i < tz->num_trips; i++) {
> -		if (&tz->trips[i] == trip)
> -			return i;
> -	}
> -
> -	return -ENODATA;
> +	/*
> +	 * Assume the trip to be located within the bounds of the thermal
> +	 * zone's trips[] table.
> +	 */
> +	return trip - tz->trips;
>   }
> 
> 
> 

I agree wit hthe comment, we should be safe here, since we control that
array.

I could be a bit picky about this 'int' return in that function on
64bit kernels, were we have also ptrdiff_t set to long IIRC. But this
particular usage should be handled properly in all our cases, so:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
