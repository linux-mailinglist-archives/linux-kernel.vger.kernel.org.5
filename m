Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96066761AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGYOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGYOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:08:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076F102;
        Tue, 25 Jul 2023 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690294115; x=1721830115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9y/LiJLrXSm1fXP3reG+FrB4JdZTCsireB5Ygj7UXtE=;
  b=ak3C7n/YDDwKImoDEit3M56Mp9/0LeVjlcYdeVm8ClcnU2BobEBP4bMZ
   wArXewJP3nkq/qA9TgSDpuuooGNbgFQmigut9U4FB4yCfa0/w6tfwJ1nm
   22RkXAS0fCABWyW9ZA7f7mXAIK3f26CqSlBdNZLnMN0FMOKBy0/R+Q7zO
   7f9PyizlJvvOt4p8KdY07edUuzU8qUTfdFU/EBKdLCfl3RJEsA+U28aEX
   t95BaKj0JAWUqJgzb4WS6zXbs2dJ9DjGTwqbUyownCDI6uEzCbm+Iju+1
   CXLe2t7Rsto7lMCeMHl6BZeRwbveEWZm4RmjeBNFiR71cGhoFLbpT/j3h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431536742"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431536742"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="796156912"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="796156912"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:08:19 -0700
Message-ID: <1bd2e89c-8316-18fe-6584-c517da6585c4@intel.com>
Date:   Tue, 25 Jul 2023 17:08:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] perf machine: Include data symbols in the kernel
 map
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230725001929.368041-1-namhyung@kernel.org>
 <20230725001929.368041-2-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230725001929.368041-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/23 03:19, Namhyung Kim wrote:
> When perf record -d is used, it needs data mmaps to symbolize global data.
> But it missed to collect kernel data maps so it cannot symbolize them.
> Instead of having a separate map, just increase the kernel map size to
> include the data section.
> 
> Probably we can have a separate kernel map for data, but the current
> code assumes a single kernel map.  So it'd require more changes in other
> places and looks error-prone.  I decided not to go that way for now.
> 
> Also it seems the kernel module size already includes the data section.
> 
> For example, my system has the following.
> 
>   $ grep -e _stext -e _etext -e _edata /proc/kallsyms
>   ffffffff99800000 T _stext
>   ffffffff9a601ac8 T _etext
>   ffffffff9b446a00 D _edata
> 
> Size of the text section is (0x9a601ac8 - 0x99800000 = 0xe01ac8) and
> size including data section is (0x9b446a00 - 0x99800000 = 0x1c46a00).
> 
> Before:
>   $ perf record -d true
> 
>   $ perf report -D | grep MMAP | head -1
>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>                                                                ^^^^^^^^
>                                                                  here
> After:
>   $ perf report -D | grep MMAP | head -1
>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>                                                                ^^^^^^^^^
> 
> Instead of just replacing it to _edata, try _edata first and then fall
> back to _etext just in case.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/machine.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 4e62843d51b7..11de3ca8d4fa 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1216,7 +1216,9 @@ static int machine__get_running_kernel_start(struct machine *machine,
>  
>  	*start = addr;
>  
> -	err = kallsyms__get_function_start(filename, "_etext", &addr);
> +	err = kallsyms__get_symbol_start(filename, "_edata", &addr);
> +	if (err)
> +		err = kallsyms__get_function_start(filename, "_etext", &addr);
>  	if (!err)
>  		*end = addr;
>  

