Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC927AEADF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjIZK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjIZK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:56:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23C8495;
        Tue, 26 Sep 2023 03:56:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AD1E1FB;
        Tue, 26 Sep 2023 03:57:22 -0700 (PDT)
Received: from [10.57.95.200] (unknown [10.57.95.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54FD33F6C4;
        Tue, 26 Sep 2023 03:56:42 -0700 (PDT)
Message-ID: <71403f39-5894-154d-022a-f42fb344e488@arm.com>
Date:   Tue, 26 Sep 2023 11:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf cs-etm: Fix missing decoder for per-process trace
Content-Language: en-US
To:     Besar Wicaksono <bwicaksono@nvidia.com>, mike.leach@linaro.org,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        rwiley@nvidia.com, ywan@nvidia.com
References: <20230919224553.1658-1-bwicaksono@nvidia.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230919224553.1658-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/09/2023 23:45, Besar Wicaksono wrote:
> The decoder creation for raw trace uses metadata from the first CPU.
> On per-process/per-thread traces, the first CPU is CPU0. If CPU0 trace
> is not enabled, its metadata will be marked unused and the decoder is
> not created. Perf report dump skips the decoding part because the
> decoder is missing.
> 

Hi Besar,

It's not just per-process trace, the bug is also in per-cpu mode but it
means that the metadata from CPU 0 is used for every decoder which is
wrong. Although your change also fixes this issue.

> To fix this, use metadata of the CPU associated with sample object.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  tools/perf/util/cs-etm.c | 130 +++++++++++++++++++++++----------------
>  1 file changed, 77 insertions(+), 53 deletions(-)
> 

[...]

> +	if (!formatted) {
> +		/*
> +		 * There is only one decoder when unformatted. Use metadata of
> +		 * sample AUX cpu.
> +		 */
> +		t_param = t_params;
> +		metadata = get_cpu_data(etm, sample_cpu);
> +		if (!metadata) {
> +			pr_err("CS_ETM: invalid sample CPU: %d\n", sample_cpu);
>  			return -EINVAL;
>  		}

Apart from Mike's comments, this looks ok. Thanks for fixing this it has
been on our list for a while.

One issue with calling get_cpu_data() with the sample CPU ID is that it
won't work with old files that don't have the CPU sample flag set. Mike
added the sample flag fairly recently, and I don't think that was a
breaking change for old files at that time. It should be easy to avoid
that by still returning the metadata from CPU 0 when CPU = -1 (Which
isn't correct but is 99% likely to work).

I checked the Coresight tests and they're all passing, at least on a
system without ETE. If you could make sure they're all passing for you
as well that would be great:

  sudo ./perf test coresight

I think they currently only work from an in source build, if you get
stuck there.

Thanks
James

