Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0575328D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjGNHGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGNHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:06:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4F61727;
        Fri, 14 Jul 2023 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689318401; x=1720854401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BaEo9Tux8uqrNwgTh1LcHPbDEKHZM4gN91FR5Y91izM=;
  b=cMFakY9dbSPVfl9hq9dyZrQiKhidFHSfVxCXNrtf23GUV6DuF8uqq8uD
   0WPlRQfFcg68Sx+JFMjaMo62xDDyGSgTvFwcyCHUt/zi5KNcoQX0KAYnp
   uWPyvJJDLAVwt/ytyhLOFxcr/vF25t0gWuFvnczUlsT9u5BnoJ1jsQq5g
   tPz43nml47Aiii6P/DowTNyaBF1rTNsUQ0hv7adGYCjoUbzhC1ezVzXkv
   pyYQKe75yy+192+pp1GB5cc2ThOvgBi/Ds/pKFVX1wGODSc4YywLA+l5C
   CK3pYQIyiWdX03bQtj0MJ9g4uMXfqVUD+MMwvTDybHQDEPYBVHHaIdrev
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="350280434"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="350280434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 00:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968898780"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="968898780"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 00:06:35 -0700
Message-ID: <b1127b63-6c6a-e42e-ce6c-cf4f24bbc5a1@intel.com>
Date:   Fri, 14 Jul 2023 10:06:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] perf: add new option '--workload-attr' to set workload
 sched_policy/priority/mask
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713085831.395112-1-changbin.du@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230713085831.395112-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/23 11:58, Changbin Du wrote:
> To get consistent benchmarking results, sometimes we need to set the
> sched_policy/priority/mask of the workload to reduce system noise.
> 
> For example, CPU binding is required on big.little system.
> 
>   $ perf stat -r 10 -- taskset -c 0 ls
> 
> Nevertheless, the 'taskset' is also counted here.
> 
> To get away of the middleman, this adds a new option '--workload-attr' to
> do the same jobs for stat and record commands.
> 
>   $ sudo perf stat --workload-attr fifo,40,0x1 -- ls
> 
> Above will make 'ls' run on CPU #0 with fifo scheduler and realtime
> priority is 40.

Aren't there ways to set up a process then start perf using -p <pid>
then let the process continue.

