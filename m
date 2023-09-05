Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85877929C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352686AbjIEQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354800AbjIEO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:29:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDC1189;
        Tue,  5 Sep 2023 07:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DF066CE1184;
        Tue,  5 Sep 2023 14:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36825C433C8;
        Tue,  5 Sep 2023 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693924140;
        bh=rDW5JlXBxHtrWOrH5tZpYrnS/cxmCu/YT/sp/xdH1Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9sEyHAJhyg6tOG1+T4cgTMhD5cid3YRK5LSLhEKIcuLC0I7+VH1txfIhfQ8fDqGj
         D8cPY7hl+xXImhhRickzn6+ukDtTvLaFJMgkwrDMRJwTcpz88Mg87u/Diu/Wufce2h
         jTDyxvTGDz1Uq67D9quCJKv7SMNX2JaLJTfCOgz7fSbDxxmjlsq0ASgLe3nz8qJfUm
         7JGauM4xaNCJT8DoNrWGnaXu80+/OkP6InMsDfrDt/IcmDv8nCTGYxYfTee6OUvlR4
         x1ygzXzaCY4ZbNQ+hFa1PLGuutgW1wB2R2Yx2ggjq6utdxysoVm4ZoepADpJzjdD3+
         ZdStrl7MqChCg==
Date:   Tue, 5 Sep 2023 15:28:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Jeongtae Park <jtp.park@samsung.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>
Subject: Re: [PATCH] perf: CXL: fix mismatched number of counters mask
Message-ID: <20230905142854.GA3322@willie-the-truck>
References: <CGME20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1@epcas2p2.samsung.com>
 <20230905123309.775854-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905123309.775854-1-jtp.park@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:33:09PM +0900, Jeongtae Park wrote:
> The number of Count Units field is described as 6 bits long
> in the CXL 3.0 specification. However, its mask value was
> only declared as 5 bits long.
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> ---
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 0a8f597e695b..365d964b0f6a 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -25,7 +25,7 @@
>  #include "../cxl/pmu.h"
>  
>  #define CXL_PMU_CAP_REG			0x0
> -#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(4, 0)
> +#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(5, 0)
>  #define   CXL_PMU_CAP_COUNTER_WIDTH_MSK			GENMASK_ULL(15, 8)
>  #define   CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK		GENMASK_ULL(24, 20)
>  #define   CXL_PMU_CAP_FILTERS_SUP_MSK			GENMASK_ULL(39, 32)

I don't have access to the CXL spec, but widening this mask looks like
it puts us out-of-whack with CXL_PMU_MAX_COUNTERS.

Did v3.0 of the spec bump the number of counters? If so, can you please
check that this is a backwards-compatible change?

Will
