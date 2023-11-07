Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6B7E3A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjKGKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjKGKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:50:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA3B6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:50:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E96C433C8;
        Tue,  7 Nov 2023 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699354222;
        bh=uUU+l1Ykp+7N9EZ7TzTsRCmrJ3WvxT36njqrsgygmPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHulcJ4f7hvWubFbau6K3qPz539/8L77jsiHUM8EhdG07TT7Gu3IZ2jUo082XlzAp
         KOKtA/qOfZX5RLdwGI6AdxffAv6m8bkJ3UUHawZys0QshR9cGsa0AyIjZq0oemDDGE
         NUAOHdUNwjCNVpt8y3aYSleCIeIlK2X5ogDMRS/krI7l3xacZyXALLLJy0MQovDZK2
         9sG3r3c4YzoD+za65zijGPnhB9uDx+NeLk+GlGh48XcAwW/flqgU34jkGeaTtUxvkv
         jaQM8BjX50poKlqNfSQwHQeXH7a0GBclNE6ULoppyRQC1mWG5VPG0beOd9mtsHTIMj
         NKeLwNfFLVevA==
Date:   Tue, 7 Nov 2023 10:50:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        catalin.marinas@arm.com
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Message-ID: <20231107105017.GB19133@willie-the-truck>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Catalin]

On Thu, Nov 02, 2023 at 05:16:54PM -0700, Ilkka Koskinen wrote:
> Coresight PMU driver didn't reject events meant for other PMUs.
> This caused some of the Core PMU events disappearing from
> the output of "perf list". In addition, trying to run e.g.
> 
>      $ perf stat -e r2 sleep 1
> 
> made Coresight PMU driver to handle the event instead of letting
> Core PMU driver to deal with it.
> 
> Cc: stable@vger.kernel.org
> Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 42b72042f6b3..2cc35dded007 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -676,6 +676,9 @@ static int arm_cspmu_event_init(struct perf_event *event)
>  
>  	cspmu = to_arm_cspmu(event->pmu);
>  
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +

Acked-by: Will Deacon <will@kernel.org>

Catalin -- please can you pick this up as a fix in the arm64 tree?

Cheers,

Will
