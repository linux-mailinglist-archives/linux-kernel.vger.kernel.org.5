Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7D78FE4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbjIANay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjIANax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:30:53 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED17CDD;
        Fri,  1 Sep 2023 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693575047;
        bh=pkbbGagA3i0Bnj+ku0lHfhSJzOGz2/XYlf1w4l2JIXg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C+m22130Lvzn8GrGf2sOmSHmowFiKfvj2xHtVhvj+F360XM5OiSSWolq8QmacTOmb
         px8FcNRPIgEhiJpBA5iCTdIIiZ6Q7CqA6A4/JoCo812tJTE2f6QSzpsp2qtMiYgHF8
         govH2PsztIGIcVW6WGrHb1N0HVleMndq+lH7X/NQArDU/VTmRCEmgL0mvmokLZOKmu
         AkTbEJqqiCJi5t7Uvh89OUZnpKqffcm7NbzG4ozxSnPlPDFpeLfo2QlOkkumpRjHRw
         TDufzeNKLVk1EuByVhgok6eLUitHOqj+iQftaw6Vm1NwnBtffHvP5+8TqWDe+R5yY2
         1L7zjkYl+mwRA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rcf6v1FR8z1Ml2;
        Fri,  1 Sep 2023 09:30:47 -0400 (EDT)
Message-ID: <d05deed9-637f-697c-5c2f-d6fede4c956d@efficios.com>
Date:   Fri, 1 Sep 2023 09:31:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] srcu: The value may overflow
Content-Language: en-US
To:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
References: <20230901095341.55857-1-arefev@swemel.ru>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230901095341.55857-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 05:53, Denis Arefev wrote:
> The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> is subject to overflow due to a failure to cast operands to a larger
> data type before performing arithmetic
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>   kernel/rcu/srcutree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..e14b74fb1ba0 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>   				snp->grplo = cpu;
>   			snp->grphi = cpu;
>   		}
> -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);

What possible values of cpus supported by the Linux kernel and grplo can 
cause this to overflow on 64-bit architectures ? I suspect the maximum 
result of this subtraction is defined by the RCU_FANOUT or other srcu 
level-spread values assigned by rcu_init_levelspread(), which can indeed 
cause the signed 32-bit integer literal ("1") to overflow when shifted 
by any value greater than 31. This analysis should be added to the 
commit message so the impact of the issue can be understood.

I also notice this in the same file:

srcu_schedule_cbs_snp():

         for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
                 if (!(mask & (1 << (cpu - snp->grplo))))
                         continue;

Which should be fixed at the same time.

Thanks,

Mathieu

>   	}
>   	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
>   	return true;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

