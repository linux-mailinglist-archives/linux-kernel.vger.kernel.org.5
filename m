Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE990782881
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHUMEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjHUMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67384BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED51C632F6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2983AC433C9;
        Mon, 21 Aug 2023 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692619486;
        bh=ku0b1PSf0bDhMBqqwhIxMLwB0rhuhLByM8FxU1qMgxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xq2ZYtAPJaUbsccqXtaw0kX6XBsUs/5/JqQXOCC+cbMqLwqqJt8XR9Vce1Q0vdQYb
         d43l2Kqfrbw6RKb8munNFk1MwcNsqnQLtA62bQU/ksPRjHaO960AwU3Te+NUNzBpgt
         FmIdi9UPuEGeABlJ+DBZPJtijf0SKvt6NtPyJpznpGEPziryc7WP/jZPUvXrM8iqhT
         qEqf0ixw7wUMuzbUhf+XxWaSsqKMnxVoyg5h71T7p9Gt9jXTBeCIae29DWKgvLP/o3
         rve7RTzOlzrc3eHA/+6Oxm27Zv1y6YYTfI0itz+ttO1h9t/3DIT40WXy7zr495UH2T
         qxvn9W2earLNw==
Date:   Mon, 21 Aug 2023 13:04:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     jonathan.cameron@huawei.com, mark.rutland@arm.com,
        chenhao418@huawei.com, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        huangguangbin2@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [PATCH drivers/perf: hisi: 2/2] drivers/perf: hisi: fix set
 wrong filter mode for running events issue
Message-ID: <20230821120440.GB19617@willie-the-truck>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
 <20230816094619.3563784-3-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816094619.3563784-3-shaojijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Guangbin Huang and Shaokun Zhang]

On Wed, Aug 16, 2023 at 05:46:19PM +0800, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> hns3_pmu_select_filter_mode() includes a series of mode judgments such
> as global mode ,function mode, function-queue mode, port mode, port-tc
> mode.
> 
> For a special scenario, command use parameter "bdf=0x3700,config=0x3,
> queue=0x0", it is expected to enter function-queue mode, but event of
> config 0x3 doesn't support func-queue mode, then it enter port-tc mode.
> it's not up to expectations.
> 
> It shouldn't enter any modes but return -ENOENT.
> 
> So, add judgement of bdf parameter to fix it.
> 
> Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/perf/hisilicon/hns3_pmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
> index 6a4d04cbae91..7f38a9e489d4 100644
> --- a/drivers/perf/hisilicon/hns3_pmu.c
> +++ b/drivers/perf/hisilicon/hns3_pmu.c
> @@ -1000,12 +1000,13 @@ static bool
>  hns3_pmu_is_enabled_port_tc_mode(struct perf_event *event,
>  				 struct hns3_pmu_event_attr *pmu_event)
>  {
> +	u16 bdf = hns3_pmu_get_bdf(event);
>  	u8 tc_id = hns3_pmu_get_tc(event);
>  
>  	if (!(pmu_event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT_TC))
>  		return false;
>  
> -	return tc_id != HNS3_PMU_FILTER_ALL_TC;
> +	return (tc_id != HNS3_PMU_FILTER_ALL_TC) && (!bdf);
>  }

Sorry, but I'm struggling to see how this correlates with your example
in the commit message, which implies that it's the config of 0x3 causing
the problem rather than the bdf.

Please can you explain the problem in more detail?

Thanks,

Will
