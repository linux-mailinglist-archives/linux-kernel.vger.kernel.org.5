Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A5F79C950
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjILIIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjILIIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:08:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E52310D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:08:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C625C15;
        Tue, 12 Sep 2023 01:08:45 -0700 (PDT)
Received: from [10.57.31.51] (unknown [10.57.31.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD663F738;
        Tue, 12 Sep 2023 01:08:07 -0700 (PDT)
Message-ID: <d7c4f92f-a68c-26cf-896b-122158097622@arm.com>
Date:   Tue, 12 Sep 2023 09:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] perf/arm-cmn: Fix CMN_DTM_UNIT_INFO offset in CMN700
Content-Language: en-GB
To:     "guojinhui.liam" <guojinhui.liam@bytedance.com>, will@kernel.org,
        mark.rutland@arm.com
Cc:     lizefan.x@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230912040309.1789-1-guojinhui.liam@bytedance.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230912040309.1789-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 05:03, guojinhui.liam wrote:
> The por_dtm_unit_info's offest is 0x0960 in CMN700 according to
> the CMN700 spec.
> 
> CMN700 spec link:
> https://developer.arm.com/documentation/102308/0302/?lang=en
> por_dtm_unit_info can be found in section [4.3.13.10 por_dtm_unit_info].
> 
> Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>
> ---
>   drivers/perf/arm-cmn.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 913dc04b3a40..6f3fafee0ac9 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -113,6 +113,7 @@
>   #define CMN_DTM_PMEVCNTSR		0x240
>   
>   #define CMN_DTM_UNIT_INFO		0x0910
> +#define CMN700_DTM_UNIT_INFO		0x0960
>   
>   #define CMN_DTM_NUM_COUNTERS		4
>   /* Want more local counters? Why not replicate the whole DTM! Ugh... */
> @@ -2247,6 +2248,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   
>   		if (cmn->part == PART_CMN600)
>   			xp->dtc = 0xf;
> +		else if (cmn->part == PART_CMN700)
> +			xp->dtc = 1 << readl_relaxed(xp_region + CMN700_DTM_UNIT_INFO);

I'd prefer to fix this more thoroughly, since there are still potential 
issues with this code as-is. I already have that patch written[1], 
however it ended up spawning a couple more patches to revisit actually 
making meaningful use of the DTC domain information[2], which I've still 
been debugging, but I hope to post the whole series soon.

Thanks,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/e4216d99eed2cd951fc515f06ccf31672fb3f58d
[2] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commits/cmn-dev?ref_type=heads

>   		else
>   			xp->dtc = 1 << readl_relaxed(xp_region + CMN_DTM_UNIT_INFO);
>   
