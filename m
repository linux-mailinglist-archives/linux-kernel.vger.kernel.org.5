Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0867A1B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjIOJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjIOJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53D363588
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:53:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07BC51FB;
        Fri, 15 Sep 2023 02:54:03 -0700 (PDT)
Received: from [10.163.62.147] (unknown [10.163.62.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDB5B3F67D;
        Fri, 15 Sep 2023 02:53:22 -0700 (PDT)
Message-ID: <56db2f8b-23c6-a664-7c8b-4c000449abe1@arm.com>
Date:   Fri, 15 Sep 2023 15:23:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230818082112.554638-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 13:51, Anshuman Khandual wrote:
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

Hi Suzuki,

This patch still applies cleanly on current coresight/for-next/queue.
But in case, this needs any changes, please do let me know. Thanks !

- Anshuman
