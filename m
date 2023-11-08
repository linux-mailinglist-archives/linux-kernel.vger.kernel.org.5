Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5B7E606B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjKHW2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHW2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:28:08 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712AA1FE4;
        Wed,  8 Nov 2023 14:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyAayGUnTYWAud8Azr43AtB6zIOYg0FkRkzoc4g8Nfo9NvDn6zK6kfya9M19Irfvfypjoq4OX8Rh5LcT15oMgPLg7NDyT/fYUCfduNkjfQktcnYKEMmoUHYp2b8X2vwCnM8h3tnxPx2ZQSnSnZ+SktQwU8+YNvuaf6UZe6frjAJS9sAKQa6NJ1UspET+GubqAa5c+Nd8QD9MjG/Uuuyw7bqMCIaBbmIg1MgOFg4azY3HxxhF5lMmu17emqn9nb0/XzWN/xSIDbg9Q+c4LgkK2M+HTqKQMkzljYwuTkJGxZbV+UbIJudadxGiFdiZwtkFfAKRDRY4KUocYguEpbtl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lptyTAQ+RkNIpf+mYcT8luJKrkVN8NW6PEnchlVmVM=;
 b=TgZLkJqrFsdQVsV/fIoTbeZwb6TTVRzrrm5QbbnWXbFMqcX6GIzlN75soNcS0MTtPjbiANquREZX+aCUQ7JPecO35QIivKgB9AfMB8ghfLnJq7SVKSzt6f6FwJ2wiILru7FW1wqN1aqVgauURUVbFV9RNa/bge8aQ7ypv+39pXrKRuatUsKYvykh/D4cE7NO5dyczX+cBst/+ZijqqajCxixwcfCrXkeKNLptMr0Twl0d87pdS6n7IdX85Qq3nzaYBIlG8OO38cBttBEDBr5j48hd/3jg4a2lmtGb5AvAEHF46qt6q099HWjMq9pt0BHbPedLjATWbSa5Lghgk++WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lptyTAQ+RkNIpf+mYcT8luJKrkVN8NW6PEnchlVmVM=;
 b=c4qRYGYkSQ69wgO8m8i/bsrQ7YJ8SlG7jt1viKYv+U39h+97tW7ZP2+XXMMGUgh6prFs24WnkNAWXfh3E5l3mVwtw0RxIjvft7uljpmoxPVc4TCZflNUKJfiRzzwothx/jsmFZ6rbthFt4XgGjUrALa/eIQkPwX6rgFA0s+GlME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Wed, 8 Nov
 2023 22:28:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Wed, 8 Nov 2023
 22:28:00 +0000
Date:   Thu, 9 Nov 2023 00:27:56 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/7] net/sched: taprio: fix too early schedules
 switching
Message-ID: <20231108222756.l3u6h6gllxnbypyn@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GVXPR04MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd71735-447e-4465-5bd8-08dbe0a9f726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5t9+tbqZI3pRELvgcMdNtRMrKqtPXDDFjkCPeZFl4Ji3FPeu2nI9fbccE27Znsx1gRPnUML1qnR5OLeBvf9XnHiQBx71FVjv3WNVckbYr1zLq8++/zOK1G81uCkmH1jO8Fv28LiX3HCsiNnH6pdAawaVl0fhXEm66iJvg2vWJTnO5xTC+jWSoDJ/RV5s9APP0qsr76f+ezW75zvH5Vk5noReovEZP5IKAexc43uxTCUwlwjDCuLoMkiNlElFSPjJR7eBYi6VP8v/plHkakQfT3kSnmkTqSq0ZXlao7Z4dsWD3d7pnhYiqm8F8rhO91OHw9hfDdRp4RJx8TuhwGE2KqaUjgkR8uLmH7S4nkSdaCFzEqOk35VIJIa9JC17w3sdOzbz3GkF51MLw5U8YYyAvDupzxaSWDgNW2PSLlWhjLJdw76T6O18/O5C0hwIS2unisNzveNEXn2//ioNYppZ1p+OuKOpnlU1n43c/CJd6jmnp90K9SaDr8JLoQxube1hZB1bGUYdXWjQtgbnNn3a+mW1Wvu5qMXPzWY8LaOUVhf9inG3DZcYcYLZdKSavDG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(6506007)(9686003)(478600001)(6486002)(6666004)(83380400001)(26005)(1076003)(2906002)(44832011)(7416002)(5660300002)(33716001)(41300700001)(66946007)(66556008)(66476007)(316002)(6916009)(54906003)(4326008)(8676002)(8936002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWp6a0hYcU5BVlgzMldVYis3ZE5pVm1zbkFyc1llM2RLR0FWRnh4MFZVdnNQ?=
 =?utf-8?B?WXVLdUF3d2R2dzZyR25UOUJxV2hydFpXSFBnbjNRU085MHZYa1pnM3ZHN0hJ?=
 =?utf-8?B?dGl6d1ZZQ2NCK2k1c3NRMmIzK3dBSVZyd21MdHRoVkNwM1NMbDJKWnQ5ajVp?=
 =?utf-8?B?b1pka3JLbkVVb2ZJVWVWMzNCSmc5MTJFVm1MQ2t6dXRhbkNDMW1YeVdNeVdh?=
 =?utf-8?B?NS9nNkd3OXpRMUd2cmN4cmVpNDg0c1R4eThEK2I0dU1LQUR4amE0WVMwZzFV?=
 =?utf-8?B?YlhKUnRKanJMNk80UUlFSzFwWE5PYzJYUUpoTkE3YTUyaFg5S0lGQThaTWlr?=
 =?utf-8?B?cjVKc2lvTEhRTmpjbC9WL28vR1plaGNWZDlqWlZGTjFSdS9KN29iNXNRSkVl?=
 =?utf-8?B?UnlOZVVYR0dVV2VqNlcrenkwZEZqRVViZ2YxVUZDbnJsNVhmd3VRdFgwRjFz?=
 =?utf-8?B?ZURKL3FzazgzNjBJZzZib013bHRiSWxQN3piOXNyak0yb3pCbW1HQ2JRYlVZ?=
 =?utf-8?B?WUFsb1g4Y0tvdG9MemUwS3d0d2FLUjdQcGw5VGM2Z0FvKzlqeDY3U2I0aUhD?=
 =?utf-8?B?dU85MEI0cHNwOU10VmszU2F6c1Q4M3ArcnZvWjhiak1ZNVJrNUZ5ZlpKYUZ1?=
 =?utf-8?B?eEtyTVArbFl3KzZxVUR3TVRWTHF3QjhKS29NVTJydjZjVWpmaUp4OFJRTDcz?=
 =?utf-8?B?WXRCcFFJbG9NUXlsM1psbUFUSFJYR0VidFFnSmV3SndhR0FwZndSQ0ZVTDRM?=
 =?utf-8?B?SWJnUWZJNXZabjhNS3JjelF2Vk9nanVNWTNkdjBTb2xqRVlOZVJVL21weity?=
 =?utf-8?B?emVyUFA3c2x1RSswOC9Iem8vVy9pMHJnQkhxUFljVlBZcVJ3OFBDSUUvdHVB?=
 =?utf-8?B?SC9uaFVjdlllYW53bnJXamlrM0dNMGcybjdQYXZjdVdwdUlEUDE4S1RYTjFt?=
 =?utf-8?B?Z1JzZDFKSU1pbW5JRnFXZTBzWEl2NzhyWmN3UXFwK214K216OEw4YkZDN3RY?=
 =?utf-8?B?YmYvSFpvWmVYS0JqSEhydDhML3RNaEczNUR0RDJaaUNyOTZhNmlKWDVwazFk?=
 =?utf-8?B?aEx3bzRSNFJvUFovOElqMmFJOTd3bWJZdVdUMmV4cVB3djNpSzFxU1JFSVBv?=
 =?utf-8?B?eG1nSnVGbUphMk43NW1rd2owcmtnbytobmNGVWloYzdoWUVRNmlFcjVhczRU?=
 =?utf-8?B?ZDNYQk8vdVo0THdOdFdQbDkyMzZ6MUFUa05IaE40MWlZaGkrbTBSRW5iOERN?=
 =?utf-8?B?czNHcmthREp3NXZuQm5pTFF4Rm9VQy8xa0V0aU1xZ3JuTGkxS3o1cis5clFQ?=
 =?utf-8?B?c0RrRHNJQWgxWEtBZDdsYURsMUtnUUc4ZDNDM21EK1JnRmtzR0xNZzExelJI?=
 =?utf-8?B?ek1yUm9iam0yVVIrbnY3YVhiRGtTbUZ5dHlwZGhpZGd2WWpxa1hQMWZsVUJU?=
 =?utf-8?B?MXR5NkNZT1ovTldwTWY0cW9la3NQOHFRSmVGdVVxenlwdWU0cEg4OWNkLzBu?=
 =?utf-8?B?TTZwQm9JQWR0Y3QrQ1RBcVlIL1RWdWprU0Q1TEJ3Zjc3S3dlTlRWRk9BUGk1?=
 =?utf-8?B?cmhrZWIyVFdnRzlRU3pNbStSOUpPSkdIeGdtOTdEdlFGSHlTZDEzRXh6aXQx?=
 =?utf-8?B?a2lrT3NkTmZEU04vbytBNnRnaHZJVTJuK0ZaOGMwMDFOdVBOZTh4ek9KUVdk?=
 =?utf-8?B?QjkxRUUyMkRyN2N5MTlmdEZrM2p4c29mTm1PYVliQlE0YlRCS0lHWHI3di9N?=
 =?utf-8?B?L1drcXp0c2tuN2pucmxNazhrZWN3bnp1YkE2OEpDemlUTmp2Q3dadWpxZjQz?=
 =?utf-8?B?Z0tTNk45Y2hnT3YvZVdseC9iOTlqTHZxMDFFamt5bUJhQ1RpU1RoQWlmOG84?=
 =?utf-8?B?YitvRmxXMy9wdmQ4MlZDZGJhbmI0THFsL1cralFLK3Rid0ExZXNZNmRzTjdn?=
 =?utf-8?B?YlB4OWdkcjU0eTlDWjgzaDE4cGVBN2tDY0xWd2dzZkpRUXRQb0xCb3NJMkZr?=
 =?utf-8?B?ODBjQkI1N3c2SVRna0cwbW11dll6ejJTUzhYYk5yUXJhVE01cDZkZEtQZmha?=
 =?utf-8?B?TWpRaFVxQ3FxZ0YzdC9ITDdrQmk1UnowNk1vRC9scGt1SzdzYXBBNHpINGZE?=
 =?utf-8?B?SWJhcTlCa3pjdUZZZW1saUlDR2lWUHhWSEtPb29iN1RFNFdhMkxRUEl1ZGFJ?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd71735-447e-4465-5bd8-08dbe0a9f726
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 22:28:00.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGHVceKPgoQdvTqcVMAEg+qSL7ew2MUKCVRO0Xsg7fo7M0EbjiVhvhvDFF4ZU1Ciksgz6jdoIzMKr2EnWNxrnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:17AM -0500, Faizal Rahim wrote:
> In the current taprio code for dynamic schedule change,
> admin/oper schedule switching happens immediately when
> should_change_schedules() is true. Then the last entry of
> the old admin schedule stops being valid anymore from
> taprio_dequeue_from_txq’s perspective.

Admittedly, I may have become a bit detached from this code base in the
past months, but I don't understand the reasoning here.

Could you please explain what makes the last entry of the old admin
schedule be invalid from taprio_dequeue_from_txq()'s perspective?

What I see is that when should_change_schedules() is true, we change
q->oper_sched and q->admin_sched through the switch_schedules() call,
but we don't change q->current_entry, so I fail to understand the
connection you are implying.

On the other hand (and I see I did mention this in the other thread),
it seems that taprio_skb_exceeds_queue_max_sdu() - called from the
enqueue() path - looks at q->oper_sched, and that's a valid reason why
we'd want to delay the schedule switch until admin's actual base time,
rather than the current oper's cycle_end_time.

But please, let's spare no expense in providing a proper problem
description, justification for the change and Fixes: tag. This is not
optional.

> To solve this, we have to delay the switch_schedules() call via
> the new cycle_time_correction variable. The variable serves 2
> purposes:
> 1. Upon entering advance_sched(), if the value is set to a
> non-initialized value, it indicates that we need to change
> schedule.
> 2. Store the cycle time correction value which will be used for
> negative or positive correction.

It needs to be stated much more clearly that only purpose 1 is relevant
here (I would even go as far as to omit its secondary purpose here).
The only reason we are using the correction variable is because it
happens that we'll need that in later changes.

> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")

I believe that since the only observable problem has to do with
taprio_skb_exceeds_queue_max_sdu(), the Fixes: tag should be the commit
which added that logic. Which is:

Fixes: a878fd46fe43 ("net/sched: keep the max_frm_len information inside struct sched_gate_list")

> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2e1949de4171..dee103647823 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
>  #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
>  #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
>  #define TAPRIO_FLAGS_INVALID U32_MAX
> +#define INIT_CYCLE_TIME_CORRECTION S64_MIN

I would prefer naming it CYCLE_TIME_CORRECTION_INVALID or _UNSPEC.
It is not just used as the "initial" value.

>  
>  struct sched_entry {
>  	/* Durations between this GCL entry and the GCL entry where the
> @@ -75,6 +76,7 @@ struct sched_gate_list {
>  	ktime_t cycle_end_time;
>  	s64 cycle_time;
>  	s64 cycle_time_extension;
> +	s64 cycle_time_correction;
>  	s64 base_time;
>  };
>  
> @@ -940,8 +942,10 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	admin = rcu_dereference_protected(q->admin_sched,
>  					  lockdep_is_held(&q->current_entry_lock));
>  
> -	if (!oper)
> +	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {

You could introduce even as early as this change a "static bool
sched_switch_pending(struct sched_gate_list *oper)" function, which
incorporates the entire body of this "if" expression.

> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>  		switch_schedules(q, &admin, &oper);
> +	}
>  
>  	/* This can happen in two cases: 1. this is the very first run
>  	 * of this function (i.e. we weren't running any schedule
> @@ -981,7 +985,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  		 * schedule runs.
>  		 */
>  		end_time = sched_base_time(admin);
> -		switch_schedules(q, &admin, &oper);
> +		oper->cycle_time_correction = 0;
>  	}
>  
>  	next->end_time = end_time;
> @@ -1174,6 +1178,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
>  	}
>  
>  	taprio_calculate_gate_durations(q, new);
> +	new->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>  
>  	return 0;
>  }
> -- 
> 2.25.1
>
