Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113A7E1BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjKFIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKFIPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:15:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D531E0;
        Mon,  6 Nov 2023 00:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699258512; x=1730794512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E3dGt3syy+RNIpyA6u+LOY9IzyGcOXqbCVp7hmWtJ3g=;
  b=krwOteO5M0tnbv4/Y1TbCH7WwPulJCJWkxhNZ0t6b7thWenKWOtsqNPN
   cHQgh6dC/URbve6knu7/3HCWw4zHRxXCpFfwFxUlWYFTO3xHLDPv/AT2k
   xvcpm0L/46+wXdC16WFJrwc1pEHKLJ8ekSKwyPKCwco8RiFtuD1fRJX6h
   VNExqW5hrvxoT0HnqDPT9gDyRpHc+b2msB69BV+F0PC44vWpjYiK9Xk7q
   v3Zuff+OPCHDiIAsE/Wic8g2H+ALMa6t9G/aMqI+shMcLL4i0tk6jGud8
   XVZQJVzA155NQteO3N9p5XAk2k92H7y7AwiimbCpfjDvQxWg4SJSs9gdw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="455712154"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="455712154"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="3374994"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:15:09 -0800
Message-ID: <c1aedc2e-e51b-4b17-a05e-cd347f56d83b@intel.com>
Date:   Mon, 6 Nov 2023 10:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Simplify object code reading test
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>
References: <20231103195541.67788-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231103195541.67788-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 21:55, Namhyung Kim wrote:
> It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
> open.  But other arch on a VM can fail with the hardware event and need
> to fallback to the software event in the same way.
> 
> So let's get rid of the cpuid check and use generic fallback mechanism
> using an array of event candidates.  Now event in the odd index excludes
> the kernel so use that for the return value.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

