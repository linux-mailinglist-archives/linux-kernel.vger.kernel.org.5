Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2A7915A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbjIDKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIDKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:23:04 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B3BD;
        Mon,  4 Sep 2023 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693822980;
        bh=pF47CKJ+Ktbx1cL6qvroO27lm9NOMfXb4lsDb/Pbtj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JnvPqdRMKlUNHvJ6yknzoBBDuy9pekNJkDDnUeFpiPuCHhuFFAxz7hwePLY95NCHg
         Sf4GyO4FbUkTcLedFZs52gKAhRiJX7LobQqnt7nkEC2LDxauvuBO/wFbDumDa4yX/I
         Pevli+2m79V7hdnaVBx3cgVU5rPyPT1NkswX1LWXilBKF9YEf6NvAkdtkfbnLIHrfj
         grVF5uPMBk0TGwVaROZy00msW0PREF3V+Ggxhpa2M2ivRc3NZVhONPR31lT8OPo+pu
         LJMO9fidbbKhLsb8hMJoxLg2FmNdz+MB5uHUudZ1ayYppi78Gv6StCQ6Dq0AuDt1qH
         E0wSaTqleWtkg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RfPpr0y1Rz1N2X;
        Mon,  4 Sep 2023 06:23:00 -0400 (EDT)
Message-ID: <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
Date:   Mon, 4 Sep 2023 06:24:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] The value may overflow
Content-Language: en-US
To:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
References: <20230904094251.64022-1-arefev@swemel.ru>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230904094251.64022-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 05:42, Denis Arefev wrote:
> The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> is subject to overflow due to a failure to cast operands to a larger
> data type before performing arithmetic

The patch title should identify more precisely its context, e.g.:

"srcu: Fix srcu_struct node grpmask overflow on 64-bit systems"

Also, as I stated in my reply to the previous version, the patch commit
message should describe the impact of the bug it fixes.

Thanks,

Mathieu


> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
> v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   kernel/rcu/srcutree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..6c18e6005ae1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>   				snp->grplo = cpu;
>   			snp->grphi = cpu;
>   		}
> -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
>   	}
>   	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
>   	return true;
> @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>   	int cpu;
>   
>   	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> -		if (!(mask & (1 << (cpu - snp->grplo))))
> +		if (!(mask & (1UL << (cpu - snp->grplo))))
>   			continue;
>   		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>   	}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

