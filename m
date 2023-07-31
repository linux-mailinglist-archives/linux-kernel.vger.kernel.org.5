Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E257691B6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGaJaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGaJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:30:08 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69722F3;
        Mon, 31 Jul 2023 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690795807; x=1722331807;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=NZSgeWBXm7h0TMLHqnPzDrWmPRnxzfTKWAVi+7xSnFM=;
  b=SKd+404+g3nV5oX24H+zuR3hJ8RqJ6yzYJmfY+5yoFcNgnUzkB/5tWkF
   70ybUnxvv1OYwZXxYn4psFOBIldgXf8Uu/emLjtfZjh6fAvIMU3ACCFua
   nLwahL+lqRmPzTLU1gnM70SwzsJdyxaGSUR1AQChLM1oHJOl36vUddUMu
   x8wIjzZ42qDq4fKEBQlUmgwdbLAvlGRPRQLGvKtcebh9spBVmBgFrcigz
   QqkdlNrZD81U4InF8XAs+OHRFdaMRTanG0+9U9m6IBLB84x+8uB9PFopQ
   Q11f046WYHZfQcbOhi1fhD5EgBviuyn3Uh7ehSek4x4t6W+ybi1GmiK3F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348569310"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348569310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="902056846"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="902056846"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:30:04 -0700
Message-ID: <d0b53f6d-f721-9dca-b48c-774f964631a0@intel.com>
Date:   Mon, 31 Jul 2023 12:30:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH 2/3] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230731091857.10681-1-adrian.hunter@intel.com>
 <20230731091857.10681-2-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230731091857.10681-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/23 12:18, Adrian Hunter wrote:
> From: Arnaldo Carvalho de Melo <acme@kernel.org>

Or should that and below be acme@redhat.com

> 
> As thread__find_symbol_fb() will end up calling thread__find_map() and
> it in turn will call these on uninitialized memory:
> 
>         maps__zput(al->maps);
>         map__zput(al->map);
>         thread__zput(al->thread);
> 
> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  tools/perf/util/dlfilter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 46f74b2344db..798a53d7e6c9 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
>  	if (!thread)
>  		return -1;
>  
> +	addr_location__init(&al);
>  	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
>  
>  	al_to_d_al(&al, &d_al);

