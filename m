Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C1D759071
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGSIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGSIj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:39:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2056136;
        Wed, 19 Jul 2023 01:39:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CFC2F4;
        Wed, 19 Jul 2023 01:40:09 -0700 (PDT)
Received: from [10.57.31.26] (unknown [10.57.31.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5F93F6C4;
        Wed, 19 Jul 2023 01:39:24 -0700 (PDT)
Message-ID: <47ded4da-5c39-9132-7978-d0f8c8ee0318@arm.com>
Date:   Wed, 19 Jul 2023 09:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "thermal: power allocator: change the 'k_*' always
 in estimate_pid_constants()"
Content-Language: en-US
To:     Di Shen <di.shen@unisoc.com>
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, orsonzhai@gmail.com,
        zhanglyra@gmail.com, amitk@kernel.org
References: <20230712084840.3594-1-di.shen@unisoc.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230712084840.3594-1-di.shen@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Di,

On 7/12/23 09:48, Di Shen wrote:
> This reverts commit 90a996544946d1d4834ec2ec8add586edd905779.
> 
> The commit ensures that the pid constants are updated when
> sustainable_power changes, but it makes it impossible for
> the driver to set the pid constants when the sustainable_power
> is not changed.
> 
> When the driver tries to register a thermal zone device by
> thermal_zone_device_register_with_trips(const char *type,
> 	struct thermal_trip *trips, int num_trips, int mask,
> 	void *devdata, struct thermal_zone_device_ops *ops,
> 	struct thermal_zone_params *tzp, int passive_delay,
> 	int polling_delay)
> and passes the private thermal_zone_params structure data,
> 
> thermal_zone_devcice_register_with_trips
> 	|
> thermal_set_governor
> 	|
> bind_to_tz
> 	|
> power_allocator_bind
> 	|
> estimate_pid_constants
> 
> the tzp->k_* will not be the data that driver have given,
> but the data estimated by sustainable_power.
> 
> To make it possible for driver to add its own pid constants,

That was dropped, the drivers shouldn't configure 'k_*' IPA
parameters. There was also an ask to add those parameter
values to the DT for setup - also not allowed.

> the 'force' flag is needed to indicate whether the tzp->k_*
> should be estimated by sustainable_power or not.

We don't want to maintain many different ways of configurations,
which can cause bugs in not tested corner cases.

Please use the user-space to change those 'k_*' parameters.
There are this dedicated and safe sysfs interfaces for each
thermal zone.

The phones that I have on my desk do the update of 'k_*' parameters via
sysfs. They do this in different scenarios. You can try to derive
best 'k_*' values for your workload scenarios and than save
them in the config file. You can update in runtime from user-space
when you switch to your scenario (e.g. camera, game, video call).

Regards,
Lukasz
