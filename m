Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AED80E728
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjLLJQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjLLJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:16:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E5DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:17:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A3C433C7;
        Tue, 12 Dec 2023 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702372620;
        bh=pAJ3nx5Llui3FrgGOwWJ1sBjH+cYEeTGCkjb+A7qsBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb1exX7maotv6ujLhPqoFP1C0nl8/QWredniP2WIk+8s+CxcMA48E3PBP9bLi/ObO
         dcMLa0zNrvd4z43yk7j0X8mXbOu0Ep9isOGqzT0r1RwWWbpKX4koNmB/irb0QXhX5H
         bisSdNZqbFqCtIblE+UuqPoSbQW+Rx/Dwr7wNtlE/5LBQbz/sFd17fFgrH0vl2DH7T
         ggm+VZ7Mb5w2k88xAhIVbGpY96hLfkjbbjuRGVRtYTewGx3IlzTQVn06u08R/vxD6p
         pzQkjY0nKIiLdxawLJLu9cUsGKFE9IgwEj8SJLGFb9AeWTpg8JosVm2Vh0wenu0LhZ
         Bwppx6/sfawrw==
Date:   Tue, 12 Dec 2023 09:16:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ilkka@os.amperecomputing.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: Fail DTC counter allocation correctly
Message-ID: <20231212091654.GA28174@willie-the-truck>
References: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:27:28PM +0000, Robin Murphy wrote:
> Calling arm_cmn_event_clear() before all DTC indices are allocated is
> wrong, and can lead to arm_cmn_event_add() erroneously clearing live
> counters from full DTCs where allocation fails. Since the DTC counters
> are only updated by arm_cmn_init_counter() after all DTC and DTM
> allocations succeed, nothing actually needs cleaning up in this case
> anyway, and it should just return directly as it did before.
> 
> Fixes: 7633ec2c262f ("perf/arm-cmn: Rework DTC counters (again)")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 86d970e74129..c584165b13ba 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1816,7 +1816,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>  			idx = 0;
>  			while (cmn->dtc[j].counters[idx])
>  				if (++idx == CMN_DT_NUM_COUNTERS)
> -					goto free_dtms;
> +					return -ENOSPC;
>  		}
>  		hw->dtc_idx[j] = idx;
>  	}
> -- 
> 2.39.2.101.g768bb238c484.dirty

Acked-by: Will Deacon <will@kernel.org>

Catalin -- please can you take this one as a fix?

Cheers,

Will
