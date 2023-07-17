Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED57566AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGQOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGQOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:41:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45084E4C;
        Mon, 17 Jul 2023 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689604895; x=1721140895;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3d/dMArMMvLara8UGSDubQb+jDPmJOD4PUCUjs5TeR0=;
  b=jeWrHzODizyKKao8MYhCXgdheJmW4TTX31BXXPRKB2bEPJtE6yFq7V6g
   9bm1DFfO2/FlYED1HzO9LzQ07XTFCryX8qofq7B9srF4OvxZuBodOAks1
   vYWjrCwSgY4H0f4RHEGoycpmxOrPHHtnpD0nWpE+2kDbNR59FimkpefIA
   VWJ3s3y46NJo2H97jpnfEzvr4zXTQ4qoLWvP3Fyco/ifPBlj7RB8Fpo5C
   Ytfd0woDpYAhTSdHnWxqpxZG3Quik4ycDN7x2i1sUKc88u/EeJxHhD3qC
   gmR1qh+S4iOpcTjXR8FfOX3zubQmfIJf142DMZ7Komb5eWu1+bQaKv8ym
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345537783"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345537783"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1053924534"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053924534"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.8])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:41:29 -0700
Message-ID: <5797e5a7-a85f-4f7c-1649-88f8f9ff7a6b@intel.com>
Date:   Mon, 17 Jul 2023 17:41:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/7] perf evlist: Skip dummy event sample_type check
 for evlist_config
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-6-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230715032915.97146-6-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/23 06:29, Yang Jihong wrote:
> The dummp event does not contain sampls data. Therefore, sample_type does
> not need to be checked.
> 
> Currently, the sample id format of the actual sampling event may be changed
> after the dummy event is added.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/record.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 9eb5c6a08999..0240be3b340f 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -128,6 +128,13 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>  		evlist__for_each_entry(evlist, evsel) {
>  			if (evsel->core.attr.sample_type == first->core.attr.sample_type)
>  				continue;
> +
> +			/*
> +			 * Skip the sample_type check for the dummy event
> +			 * because it does not have any samples anyway.
> +			 */
> +			if (evsel__is_dummy_event(evsel))
> +				continue;

Sideband event records have "ID samples" so the sample type still matters.


>  			use_sample_identifier = perf_can_sample_identifier();
>  			break;
>  		}

