Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6839811ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442035AbjLMT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:26:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644B9C;
        Wed, 13 Dec 2023 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702495606; x=1734031606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+LZTfv2T9voStSpL88ZlvYWw4h0ys5iznUuZFHt1Ioo=;
  b=kBHD0CVZzo5Xzjj8b10PXLiAqnjr/TRv0W6N5sjHcNNEfFZxrrY9+BFy
   nLoreI6zxIpJyfAelBvO3kirq2rSOCROeIRa2YS72zutURbUClw1qRzHQ
   1elc+qionYEEPCT2NTd/VrPW2LGaIeuL61AaWJCyxsF//K623O/TuFp5R
   9yG9Gcajvjvqt6IzZlY1cVOt6hOX+91qLERzzfRbhZ2Ty0nJLjSGpiDbC
   /tzeIA++zwcs9ru1QO/pE88ENxCbZsmTb/BNb/r0acEyyEPqv8Lw2sLZH
   5soEKKGBZiF5C2bES9TQEMDOK0WU890PoxOa9p7i4L4KK9HKTFxPUedaW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392191201"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="392191201"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:26:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021231609"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1021231609"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.13])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:26:43 -0800
Message-ID: <f50149fb-967c-4987-8d08-d6bb2a69bcf3@intel.com>
Date:   Wed, 13 Dec 2023 21:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf header: Set proper symbol name for vdso when
 build-id event found
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231201111506.37155-1-likexu@tencent.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231201111506.37155-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 13:15, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> If using perf-record to sample a cpu-cycles:P event on a hypervisor process
> when '--kcore' is not enabled, user may find some surprise in perf-report:
> 
> # perf report -i perf.data -v:
> # Overhead Command   Shared Object            	Symbol
>     99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0xffffffffa10d1e30 B [k] 0x0000000000034ed0
> 
> build id event received for vmlinux: d12116149f511f7dbd0b21c45d38d3d2ec09b87f [20]
> build id event received for kvm-intel.ko: a8fc0213abbafd97b10ce58ce84bec8519f9abce [20]
> build id event received for [vdso]: 4d56e381df8d2c051f6bc1ef69c0118c59d5c49f [20]
> 
> # perf report:
> # Overhead  Command  Shared Object     Symbol
> # ........  .......  ................  .......................................
> #
>     99.71%  vcpu0    [kvm_intel]       [k] 0x0000000000034ed0
>      0.10%  vcpu0    [kernel.vmlinux]  [k] __lock_acquire.isra.29
> 
> Users may be curious as to how 0x34ed0 was generated and wondered if this
> RIP came from the guest application but perf-script-D does not point to any
> samples of this address.
> 
> Based on perf/tool implementation, this is actually an offset pointing to
> the vdso object (in this case it is the assembly __vmx_vcpu_run defined
> in arch/x86/kvm/vmx/vmenter.S). The pattern is not reproduced on perf-tool
> of some distributions, and git-bisect quickly identified the possible root
> cause, which leds to this straightforward fix and after this change:
> 
> # perf report -i perf.data -v:
> # Overhead Command   Shared Object            	Symbol
>     99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0x34ed0            B [k] __vmx_vcpu_run
> 
> # perf report:
> # Overhead  Command  Shared Object     Symbol
> # ........  .......  ................  .......................................
> #
>     99.71%  vcpu0    [kvm_intel]       [k] __vmx_vcpu_run
> 
> The fix also gets commit 1deec1bd96cc ("perf header: Set proper module name
> when build-id event found") lit again.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Fixes: b2fe96a350de ("perf tools: Fix module symbol processing")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/perf/util/header.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e86b9439ffee..a33d589511ff 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2305,8 +2305,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  
>  			if (!kmod_path__parse_name(&m, filename) && m.kmod)
>  				dso__set_module_info(dso, &m, machine);
> -
> -			dso->kernel = dso_space;
> +			else
> +				dso->kernel = dso_space;

This is undoing some of b2fe96a350de ("perf tools: Fix module
symbol processing") without explanation.

Symbols in the .noinstr.text section don't seem to be
being resolved, so that could be the issue.  perf synthesizes
an MMAP record from /proc/modules, which works for .text
but perhaps not for .noinstr.text

>  			free(m.name);
>  		}
>  

