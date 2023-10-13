Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF97C7FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjJMIMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJMIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:12:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10038B8;
        Fri, 13 Oct 2023 01:12:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423D411FB;
        Fri, 13 Oct 2023 01:12:43 -0700 (PDT)
Received: from [10.57.80.116] (unknown [10.57.80.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF9193F7A6;
        Fri, 13 Oct 2023 01:12:01 -0700 (PDT)
Message-ID: <0f6d3d0a-3685-4a0c-b922-b5aa72f20b19@arm.com>
Date:   Fri, 13 Oct 2023 09:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] thermal: core: Pass trip pointers to governor
 .throttle() callbacks
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <13365827.uLZWGnKmhe@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <13365827.uLZWGnKmhe@kreacher>
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

Hi Rafael,


On 10/6/23 18:38, Rafael J. Wysocki wrote:
> Hi All,
> 
> While working on https://lore.kernel.org/linux-pm/4846448.GXAFRqVoOG@kreacher/
> I started to change thermal governors so as to reduce the usage of trip
> indices in them.  At that time, I was concerned that they could not be
> replaced with trip pointers overall, because they were needed in certain
> situations (tracing, debug messages, userspace governor) and computing them
> whenever they were needed would be extra overhead with relatively weak
> justification.  In the meantime, however, I realized that for a given trip
> pointer, it is actually trivial to compute the corresponding index: it is
> sufficient to subtract the start of the trips[] table in the thermal zone
> containing the trip from that trip pointer for this purpose.  Patch [1/6]
> modifies thermal_zone_trip_id() in accordance with this observation.
> 
> Now that the cost of computing a trip index for a given trip pointer and
> thermal zone is not a concern any more, the governors can be generally
> switched over to using trip pointers for representing trips.  One of the
> things they need to do sometimes, though, is to iterate over trips in a
> given thermal zone (the core needs to do that too, of course) and
> for_each_thermal_trip() is somewhat inconvenient for this purpose, because
> it requires callback functions to be defined and in some cases new data
> types need to be introduced just in order to use it.  For this reason,
> patch [2/6] adds a macro for iterating over trip points in a given thermal
> zone with the help of a trip pointer and changes for_each_thermal_trip() to
> use that macro internally.
> 
> Patches [3-5/6] change individual governors to prepare them for using trip
> pointers everywhere for representing trips, except for the trip argument of
> the .throttle() callback and patch [6/6] finally changes the .throttle()
> callback definition so that it takes a trip pointer as the argument
> representing the trip.
> 
> Please refer to the individual patch changelogs for details.
> 
> Thanks!
> 
> 
> 

I have issues to apply this series, could you tell me the best
base branch from your tree?

I will give it a try on my boards and review.

Thanks,
Lukasz
