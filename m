Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47C880F27B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjLLQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjLLQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:29:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84024EA;
        Tue, 12 Dec 2023 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702398597; x=1733934597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1KPdh+IHvxj61yHY90L5mpUKcg5ebFH71mmxLtM871E=;
  b=ifybhCwYVdLDuvOn7VAspe8BDO/p87H+8nFgZPi0Z/pPqZ+kqj/XKjHz
   XzrfNJxJsdu1BeQyt99gS+eZI5kdUIgx2bk8GFsWyoquA7LtWl6xEte7f
   32wXmA83EkZJfubhA29zrRCvJKXexoje8GwrFPi6mQcSddRraMd7lpi7j
   E6NdCdFv97lTgMOVREu9R0MEHzOPjzpeAecrXqfHCRoVCbc0U4CHyT6f6
   fdyl7yHo1yXLFYV+U7cS3z0qkmr1nk2M/kT9eADWypWT7gkeBchae+SVF
   gaaj7p3gMXRgNL3DtJ3DZP18oJ04XQbuFGIKyWyk+vYrShB5ZKgrkiD2Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8195796"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="8195796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 08:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="777155040"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="777155040"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.253])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 08:29:52 -0800
Message-ID: <6b6a238d-4b1c-452f-8061-6840d44120bc@intel.com>
Date:   Tue, 12 Dec 2023 18:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] perf intel-pt: replace strlcpy() with
 strscpy()
Content-Language: en-US
To:     yang.guang5@zte.com.cn
Cc:     jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn,
        cgel.zte@gmail.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        liam.howlett@oracle.com, ojeda@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
References: <202312121122562881958@zte.com.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202312121122562881958@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 05:22, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated.
> No return values were used, so direct replacement is safe.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> index b450178e3420..5b14c6701ecb 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -507,7 +507,7 @@ int intel_pt__strerror(int code, char *buf, size_t buflen)
>  {
>  	if (code < 1 || code >= INTEL_PT_ERR_MAX)
>  		code = INTEL_PT_ERR_UNK;
> -	strlcpy(buf, intel_pt_err_msgs[code], buflen);
> +	strscpy(buf, intel_pt_err_msgs[code], buflen);
>  	return 0;
>  }
> 

perf doesn't have strscpy():

util/intel-pt-decoder/intel-pt-decoder.c: In function ‘intel_pt__strerror’:
util/intel-pt-decoder/intel-pt-decoder.c:510:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  510 |         strscpy(buf, intel_pt_err_msgs[code], buflen);
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors

