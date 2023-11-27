Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F77F98EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjK0Fup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Fum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:50:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9538F0;
        Sun, 26 Nov 2023 21:50:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EECA2F4;
        Sun, 26 Nov 2023 21:51:35 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180743F6C4;
        Sun, 26 Nov 2023 21:50:43 -0800 (PST)
Message-ID: <6bb84dec-42de-431a-b2e2-ebb532e0375e@arm.com>
Date:   Mon, 27 Nov 2023 11:20:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] Documentation: arm64: Document the PMU event
 counting threshold feature
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com, namhyung@gmail.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231124102857.1106453-1-james.clark@arm.com>
 <20231124102857.1106453-4-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231124102857.1106453-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 15:58, James Clark wrote:
> Add documentation for the new Perf event open parameters and
> the threshold_max capability file.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  Documentation/arch/arm64/perf.rst | 72 +++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
> index 1f87b57c2332..41eee68951ff 100644
> --- a/Documentation/arch/arm64/perf.rst
> +++ b/Documentation/arch/arm64/perf.rst
> @@ -164,3 +164,75 @@ and should be used to mask the upper bits as needed.
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
>  .. _tools/lib/perf/tests/test-evsel.c:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
> +
> +Event Counting Threshold
> +==========================================
> +
> +Overview
> +--------
> +
> +FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
> +events whose count meets a specified threshold condition. For example if
> +threshold_compare is set to 2 ('Greater than or equal'), and the
> +threshold is set to 2, then the PMU counter will now only increment by
> +when an event would have previously incremented the PMU counter by 2 or
> +more on a single processor cycle.
> +
> +To increment by 1 after passing the threshold condition instead of the
> +number of events on that cycle, add the 'threshold_count' option to the
> +commandline.
> +
> +How-to
> +------
> +
> +These are the parameters for controlling the feature:
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Parameter
> +     - Description
> +   * - threshold
> +     - Value to threshold the event by. A value of 0 means that
> +       thresholding is disabled and the other parameters have no effect.
> +   * - threshold_compare
> +     - | Comparison function to use, with the following values supported:
> +       |
> +       | 0: Not-equal
> +       | 1: Equals
> +       | 2: Greater-than-or-equal
> +       | 3: Less-than
> +   * - threshold_count
> +     - If this is set, count by 1 after passing the threshold condition
> +       instead of the value of the event on this cycle.
> +
> +The threshold, threshold_compare and threshold_count values can be
> +provided per event, for example:
> +
> +.. code-block:: sh
> +
> +  perf stat -e stall_slot/threshold=2,threshold_compare=2/ \
> +            -e dtlb_walk/threshold=10,threshold_compare=3,threshold_count/
> +
> +In this example the stall_slot event will count by 2 or more on every
> +cycle where 2 or more stalls happen. And dtlb_walk will count by 1 on
> +every cycle where the number of dtlb walks were less than 10.
> +
> +The maximum supported threshold value can be read from the caps of each
> +PMU, for example:
> +
> +.. code-block:: sh
> +
> +  cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max
> +
> +  0x000000ff
> +
> +If a value higher than this is given, then it will be silently clamped
> +to the maximum. The highest possible maximum is 4095, as the config
> +field for threshold is limited to 12 bits, and the Perf tool will refuse
> +to parse higher values.
> +
> +If the PMU doesn't support FEAT_PMUv3_TH, then threshold_max will read
> +0, and both threshold and threshold_compare will be silently ignored.
> +threshold_max will also read as 0 on aarch32 guests, even if the host
> +is running on hardware with the feature.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
