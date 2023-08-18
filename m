Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8B7808CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359318AbjHRJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359408AbjHRJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:39:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C89812B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:39:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72796D75;
        Fri, 18 Aug 2023 02:40:01 -0700 (PDT)
Received: from [10.57.4.78] (unknown [10.57.4.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE9633F762;
        Fri, 18 Aug 2023 02:39:19 -0700 (PDT)
Message-ID: <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
Date:   Fri, 18 Aug 2023 10:39:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Steve Clevenger <scclevenger@os.amperecomputing.com>
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230818082112.554638-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Steve

Steve,

Are you able to test this with CATU ?


On 18/08/2023 09:21, Anshuman Khandual wrote:
> Currently TMC-ETR automatically selects the buffer mode from all available
> methods in the following sequentially fallback manner - also in that order.
> 
> 1. FLAT mode with or without IOMMU
> 2. TMC-ETR-SG (scatter gather) mode when available
> 3. CATU mode when available
> 
> But this order might not be ideal for all situations. For example if there
> is a CATU connected to ETR, it may be better to use TMC-ETR scatter gather
> method, rather than CATU. But hard coding such order changes will prevent
> us from testing or using a particular mode. This change provides following
> new sysfs tunables for the user to control TMC-ETR buffer mode explicitly,
> if required. This adds following new sysfs files for buffer mode selection
> purpose explicitly in the user space.
> 
> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
> 
> $ cat buf_modes_available
> auto flat tmc-sg catu	------------------> Supported TMC-ETR buffer modes
> 
> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode request
> 
> But explicit user request has to be within supported ETR buffer modes only.
> These sysfs interface files are exclussive to ETR, and hence these are not
> available for other TMC devices such as ETB or ETF etc.
> 
> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help fallback to the
> existing default behaviour, when user provided preferred buffer mode fails.
> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred modes.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.5-rc6
> 
> Changes in V2:
> 
> - Renamed sysfs file etr_buf_modes_available as buf_modes_available
> - Renamed sysfs file buf_mode_current as buf_mode_preferred
> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
> - Moved ETR sysfs details into coresight-tmc-etr.c
> - Dropped etr_can_use_flat_mode() check while offering ETR_MODE_FLAT in sysfs
> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside coresight-tmc-etr.c
> - Updated month in Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
> 
>   .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>   .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 111 ++++++++++++++++--
>   drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>   4 files changed, 131 insertions(+), 14 deletions(-)


Looks good to me.

Suzuki


