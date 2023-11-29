Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A487FE22C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjK2Vm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2VmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:42:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 141598F;
        Wed, 29 Nov 2023 13:42:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9CDFC15;
        Wed, 29 Nov 2023 13:43:18 -0800 (PST)
Received: from [10.57.4.241] (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69E23F5A1;
        Wed, 29 Nov 2023 13:42:30 -0800 (PST)
Message-ID: <7cdce766-7bec-4654-9727-2313b466b14d@arm.com>
Date:   Wed, 29 Nov 2023 21:43:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <12350772.O9o76ZdvQC@kreacher> <4869676.GXAFRqVoOG@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4869676.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 13:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both trip_point_temp_store() and trip_point_hyst_store() use
> thermal_zone_set_trip() to update a given trip point, but none of them
> actually needs to change more than one field in struct thermal_trip
> representing it.  However, each of them effectively calls
> __thermal_zone_get_trip() twice in a row for the same trip index value,
> once directly and once via thermal_zone_set_trip(), which is not
> particularly efficient, and the way in which thermal_zone_set_trip()
> carries out the update is not particularly straightforward.
> 
> Moreover, some checks done by them both need not go under the thermal
> zone lock and code duplication between them can be reduced quite a bit
> by moving the majority of logic into thermal_zone_set_trip().
> 
> Rework all of the above functions to address the above.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Fix missing return statement in thermal_zone_set_trip() (Lukasz).
> 
> v1 -> v2:
>     * Fix 2 typos in the changelog (Lukasz).
>     * Split one change into the [1/2].
> 
> ---
>   drivers/thermal/thermal_core.h  |    9 ++++++
>   drivers/thermal/thermal_sysfs.c |   52 ++++++++--------------------------
>   drivers/thermal/thermal_trip.c  |   60 +++++++++++++++++++++++++++-------------
>   include/linux/thermal.h         |    3 --
>   4 files changed, 62 insertions(+), 62 deletions(-)
> 

That looks OK. I have also checked those places
were we set the callbacks. In mainline we only use
set_trip_temp() callback. I don't know what is
Daniel's idea for the patch, but LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

also tested both patches on two arm32, arm64 boards

Tested-by: Lukasz Luba <lukasz.luba@arm.com>
