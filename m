Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E2782618
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjHUJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHUJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:14:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16FABA;
        Mon, 21 Aug 2023 02:14:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37L9DcS5033097;
        Mon, 21 Aug 2023 04:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692609218;
        bh=SnCsL4h5uCaxDzBAtrbLL9f+OdeHH2vaZmmRPxVlWuA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=T4Ycjre+5utlMGC5gX+NPibTYFadn2mw+kp8V6ZwAylz4u7xQY1dm2nmwkVCAjFhs
         GF5WeQdRn5+4LmQDNSBXc6+X8TZggkgHrR74/PeLkGgLqEyani3RimBDTFn3KT6RTJ
         LVQcugLnomffBFQ25iHOL+4Cped6g2B57uv2zWy8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37L9Dc7G037411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Aug 2023 04:13:38 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Aug 2023 04:13:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Aug 2023 04:13:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37L9DbbU000737;
        Mon, 21 Aug 2023 04:13:37 -0500
Date:   Mon, 21 Aug 2023 14:43:36 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Liao Chang <liaochang1@huawei.com>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: stats: Improve the performance of
 cpufreq_stats_create_table()
Message-ID: <20230821091336.w4wcbvuarzxrvlkk@dhruva>
References: <20230818095000.937633-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230818095000.937633-1-liaochang1@huawei.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2023 at 09:50:00 +0000, Liao Chang wrote:
> In the worst case, the freq_table of policy data is not sorted and
> contains duplicate frequencies, this means that it needs to iterate
> through the entire freq_table of policy to ensure each frequency is
> unique in the freq_table of stats data, this has a time complexity of
> O(N^2), where N is the number of frequencies in the freq_table of
> policy.
> 
> However, if the policy.freq_table is already sorted and contains no
> duplicate frequencices, it can reduce the time complexity of creating

s/frequencices/frequencies?

> stats.freq_table to O(N), the 'freq_table_sorted' field of policy data
> can be used to indicate whether the policy.freq_table is sorted.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 55c7ffd37d1c..fcb74050711a 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -243,7 +243,8 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  
>  	/* Find valid-unique entries */
>  	cpufreq_for_each_valid_entry(pos, policy->freq_table)
> -		if (freq_table_get_index(stats, pos->frequency) == -1)
> +		if ((policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) ||

[...]

Otherwise looks okay to me,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
