Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A07D14A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjJTROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377855AbjJTROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:14:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F14F4D6D;
        Fri, 20 Oct 2023 10:14:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCEF143D;
        Fri, 20 Oct 2023 10:14:55 -0700 (PDT)
Received: from [10.57.82.142] (unknown [10.57.82.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A27C3F5A1;
        Fri, 20 Oct 2023 10:14:13 -0700 (PDT)
Message-ID: <63b7f4da-8ddb-443c-8074-66b7b0c6cd84@arm.com>
Date:   Fri, 20 Oct 2023 18:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] thermal: trip: Define for_each_trip() macro
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <13365827.uLZWGnKmhe@kreacher> <8282829.T7Z3S40VBb@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <8282829.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 18:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Define a new macro for_each_trip() to be used by the thermal core code
> and thermal governors for walking trips in a given thermal zone.
> 
> Modify for_each_thermal_trip() to use this macro instead of an open-
> coded loop over trips.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.h |    3 +++
>   drivers/thermal/thermal_trip.c |    7 ++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -116,6 +116,9 @@ void __thermal_zone_device_update(struct
>   				  enum thermal_notify_event event);
>   
>   /* Helpers */
> +#define for_each_trip(__tz, __trip)	\
> +	for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
> +
>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			    struct thermal_trip *trip);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -13,12 +13,13 @@ int for_each_thermal_trip(struct thermal
>   			  int (*cb)(struct thermal_trip *, void *),
>   			  void *data)
>   {
> -	int i, ret;
> +	struct thermal_trip *trip;
> +	int ret;
>   
>   	lockdep_assert_held(&tz->lock);
>   
> -	for (i = 0; i < tz->num_trips; i++) {
> -		ret = cb(&tz->trips[i], data);
> +	for_each_trip(tz, trip) {
> +		ret = cb(trip, data);
>   		if (ret)
>   			return ret;
>   	}
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
