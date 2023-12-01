Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D56800D83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379190AbjLAOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379192AbjLAOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:41:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C07129;
        Fri,  1 Dec 2023 06:41:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17761007;
        Fri,  1 Dec 2023 06:42:24 -0800 (PST)
Received: from bogus (unknown [10.57.42.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314D43F73F;
        Fri,  1 Dec 2023 06:41:36 -0800 (PST)
Date:   Fri, 1 Dec 2023 14:39:35 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_mdtipton@quicinc.com, quic_asartor@quicinc.com,
        quic_lingutla@quicinc.com, Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix frequency truncation by
 promoting multiplier to u64
Message-ID: <20231201143935.be6wzjzxmyl5vpz6@bogus>
References: <20231130204343.503076-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130204343.503076-1-sudeep.holla@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:43:42PM +0000, Sudeep Holla wrote:
> Fix the frequency truncation for all values equal to or greater 4GHz by
> updating the multiplier 'mult_factor' to u64 type. It is also possible
> that the multiplier itself can be greater than or equal to 2^32. So we need
> to also fix the equation computing the value of the multiplier.
> 
> Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
> Reported-by: Sibi Sankar <quic_sibis@quicinc.com>
> Closes: https://lore.kernel.org/all/20231129065748.19871-3-quic_sibis@quicinc.com/
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 81dd5c5e5533..8ce449922e55 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -152,7 +152,7 @@ struct perf_dom_info {
>  	u32 opp_count;
>  	u32 sustained_freq_khz;
>  	u32 sustained_perf_level;
> -	u32 mult_factor;
> +	u64 mult_factor;

I have now changed this to unsigned long instead of u64 to fix the 32-bit
build failure[1].

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20231201085914.4ad45eb2@canb.auug.org.au
