Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEE80C6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjLKKkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjLKKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:40:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68829D0;
        Mon, 11 Dec 2023 02:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702291233; x=1733827233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vyMlyPXqIZPj+eVxK9tCvSg1sTCHGTpqVhNwzAXe5W0=;
  b=hDJDrPU/+mwALc1t2ldK8WuQgB2ofylTFh/WsJ5djZbnJmtOQ642v5nu
   +5M98Kw2znrjVQ0SiJflHGoPY+74x2y6Oo7GTTiWDQO74oXAtSltw63Ov
   QcInb67I1ARqTdHCr1XVu19sUCDwa6LgjKWqA8hS+JL+bZRtZuqXffcsa
   JTxD2Z0FPknud0B6HAvurq9n/xw7MV+G5w4/Y3oTEsstzzotlDs5g862p
   2VSZM+H7u0Z3btCHm33Uzsl8l8/UoRBTOhIH4xbdlawxkFR8MOWOoQ0lF
   v1jpQA4lWU9d/y2wHZihNUTT5mZ74W8YEAsFzUp0E3+lKVtVdOyybiPHw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374133041"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="374133041"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="21033126"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:40:20 -0800
Message-ID: <9e1a5dda-3da8-480b-a804-bc27070fb14d@intel.com>
Date:   Mon, 11 Dec 2023 12:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/uncore: fix a potential double-free in
 uncore_type_init
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205032709.9525-1-dinghao.liu@zju.edu.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231205032709.9525-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 05:27, Dinghao Liu wrote:
> When kzalloc for pmus[i].boxes fails, we should clean up pmus
> to prevent memleak. However, when kzalloc for attr_group fails,
> pmus has been assigned to type->pmus, and freeing will be done
> later on by the callers. The chain is: uncore_type_init ->
> uncore_types_init -> uncore_pci_init -> uncore_types_exit ->
> uncore_type_exit. Therefore, freeing pmus in uncore_type_init
> may cause a double-free. Fix this by setting type->pmus to
> NULL after kfree.
> 
> Fixes: 629eb703d3e4 ("perf/x86/intel/uncore: Fix memory leaks on allocation failures")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  arch/x86/events/intel/uncore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 01023aa5125b..d80445a24011 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1041,6 +1041,7 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>  	for (i = 0; i < type->num_boxes; i++)
>  		kfree(pmus[i].boxes);
>  	kfree(pmus);
> +	type->pmus = NULL;
>  
>  	return -ENOMEM;
>  }

