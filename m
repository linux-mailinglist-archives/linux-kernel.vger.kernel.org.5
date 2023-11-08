Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5717E60FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjKHXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKHXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:20:47 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7B25B1;
        Wed,  8 Nov 2023 15:20:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UClVIJCVbNQzXG6OQu/v79/yR1nNkYl7IjgN6by9Hme3woCgJAWbedlME5LcgWZGgkMPLWEoKu5mFw97KJ9ddybaSrTY7lWFnG9jdjiQZk/yxUdVneiLWCVk00u+1oR5ImhoaOSjk49aljobS4qWCWvrJIwEamTtcMWUVRDK5tUa9Y5RsKubvGQPzVycnDOA7kNp3B7jlz7YrZmn4m8xpt+UBSo/I7V9/uD6BW+XQbfDu9JutL+gCSCKmxy/vC+yd+5Jqd7x9hpbz0icbd6hcnnYh4UpPMLE/Q5Sba9+wTuKb/DXOcpb9M0S2iufcmN6u4QQb5t218Qsrs2qGN/cPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gGPIKdtySrBVfbdTqrjrlifqoueMwgIoPYF298G7cE=;
 b=ZU+/ef3d1yXiXoLnXDLfijoR8VUt3zro039hezRcDlCQLn20NdEcG5K6Lpa91I2JGwcjrrvJ8XFW+STr3XIrchD6dF/8uuuuP27uOt7hFBN72risgsRdUN4yS50IYhyX4+1yMkSXwrCfyfUeiR87kVAxi4jbAea2ZZCMThwgKwdyaTGhgsgTfUIbeCP6nMWpCPwhwS4tYTND8V9p4TVYq0nX8T4e21fB8pPFyY2WWE2h7i2jCBcgTV8lwxjI9ZNjhg+Ug2xlmqCQdDVduI2fuDjVY4APwZJvp2Av+McOelGvq5nYH3UeRaUBFsiyeyZMtvkOrIWrHVhLJNQHXfvANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gGPIKdtySrBVfbdTqrjrlifqoueMwgIoPYF298G7cE=;
 b=I9mcNZRaB6dLpJC3evt5WFuU+OgABmy7JxFz8lhdiP34dJMAuMb76GZ9LrIseaIFZK9klSH4XHEeGHT5zuPkt3F041Hd2+tW3NZeaAp+qIrVM3rdBr9ALgw3KjJg57Kc/2fyhZt3O4y3zg2Myj3b+L1phZVM74UQf254xN0zx6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6961.eurprd04.prod.outlook.com (2603:10a6:208:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Wed, 8 Nov
 2023 23:20:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Wed, 8 Nov 2023
 23:20:42 +0000
Date:   Thu, 9 Nov 2023 01:20:38 +0200
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
Subject: Re: [PATCH v2 net 2/7] net/sched: taprio: fix cycle time adjustment
 for next entry
Message-ID: <20231108232038.dhk64dtsxrw2p6h7@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: AM0PR02CA0208.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4f746d-6931-443f-bbab-08dbe0b153c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Canm2Hj4IgeYItGdLpz3eMIM1FyrjV9BRze0Wn3C5zshCrd+LCaBRgFwUplM+zpeOxPzM6gOLmqaXA9pR317NGA50aWXlrYFRT6R6B619hMaZLtKHJ5LPJ/Yr0wwI0QXGz/D+KAVSnN7ffXYhkKoiBqPpIgyh5IJKbMkBc36HrrrvP1R7J+mfcoba8lxwW7irSIoIbgVZ2oymf8BNNoTS469BT+yl22kedKE4InKfPU8MdhLdBv6UUI2tCaLg+gP57xO8r6cf8FrKEjgrTIKgh0q1oMD9rUWPUBL4I8e5Mgd94x0FXlF5pFIVZ81M1Fm8S8k1dNLKv4DinyANdkTQuXKTBPBnmSzdEIAUzoDrIBkAKk5KD/6ENkzQ5d1ayK8un1zBYSPyqpdIgT/V63eF+RPoBt2vUY/lp1u7OjTy7ypaeE1B6DadhdfYbn2r/0osQyUGI8ZKac3DqpQYO3XedVWRzOVW5giUjssCEi2vw2BO7BC6IGG/XAlEz0LpWFiGq3q/uRbj4oManZT0XzeeRBKdxLAT3nqLiCu24HGSvomkpggOB2/NIJmqHjGbTUc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(6506007)(9686003)(478600001)(6486002)(6666004)(38100700002)(86362001)(5660300002)(7416002)(33716001)(44832011)(66476007)(66556008)(66946007)(41300700001)(83380400001)(30864003)(2906002)(26005)(1076003)(316002)(4326008)(54906003)(6916009)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMN7AlSj36pHqGrt1tB/NEv6JaXfrFceNVQjZMRmGjvHkHVH34o7Y2JXuz86?=
 =?us-ascii?Q?YF7JXc54BOAsIL7nZMhRNi/frouevPU/c9gFdCPsXgN5uvHWO08No8plpCux?=
 =?us-ascii?Q?9W6NNcJvjxiHywPEylc0i50cs3Z/OCTztD8X1TsxMYPBynnjIbMd+IPrd62o?=
 =?us-ascii?Q?/cXh0NgMjAjumpIZ1CsjWbXgwB5LNL9qMgn9wD3f5i97daIPaecG/Uy6l9qm?=
 =?us-ascii?Q?z4KpZ3rYcNmcUR84h2GYW312GJCSsDODm+AgipxN1/esyfmBx3YyFetQST04?=
 =?us-ascii?Q?FI/W6huUPi83X/pSnV2hBqOPi+BouuVmvJIVdXELd9IvwP66alV1wdx668/a?=
 =?us-ascii?Q?YClRtO7Y+p2nA0dQnIoTIAD3DavjJN3gDO+mfNNTXKCoh2RRa6tDJ8qIUO32?=
 =?us-ascii?Q?P9r1IXbwRzZXS3Dg5b1R3S0fpElyuIPMpC18R0hgJhvyVGXstRkwbstOMjcy?=
 =?us-ascii?Q?FVu8Xr3KxPzZGae+KM9NaZCawk2kmWwa2PDHfidcRWfNAjoAVwhIprHRitjJ?=
 =?us-ascii?Q?20Fz79ADBqBXv4+UEJ0G81g+CChu3xa2o8D4MPUS/q6Yjq7/YsKrz1WQiNtm?=
 =?us-ascii?Q?b0Xu1LywsQFguDFPdcnO3R4Dl+3OfjCy29kBhv5Su88Zxdx1t8DmUqlNg5YI?=
 =?us-ascii?Q?YZq9pvVuBzomCsS6sKKAIAQKiBbM4+U+L29LLeiTXmwgL3/UvjxwM4d9Q9oS?=
 =?us-ascii?Q?lx8EHQ9nXmBnWYUlqTwhwUMzQJLxn/cYqg6ce29BViu5R7869O2HtLWyKdx4?=
 =?us-ascii?Q?uf+v781keF8PpwghLRUesUYVJyx0EaD14mTGbuhC5qEhCxYfXZ1CSiYmGEJF?=
 =?us-ascii?Q?nqWYhE5VuoaYLuY7cHlvhHfGmbh92GWcQhINYjUhyXGyWroqOPGEM40XBEqg?=
 =?us-ascii?Q?ErywxSzh1NWdBKPt4ThWSZhLOjvQ0A2dALwYZy2mgBZArAIar8IKTFjd387J?=
 =?us-ascii?Q?Fi0HBzCOQXpRk/66ifYmiu3QezzYRhOmTcsGh9T/3dyUGqMtb74ok9VACDSv?=
 =?us-ascii?Q?Iv5M2cm4RNsmjKit4QUsFzFXCwPNF7j8Ki9UpmYi1NDUw5eak0Kt16XRU6KK?=
 =?us-ascii?Q?NPRpQBePui6ve1+uO+Hiih6z1i4TCMW5NXmioPoB3Sgsrwfk03KVKC8NjdRl?=
 =?us-ascii?Q?mBOazkz/0sJsehsMPlnUWebzMJDVxv8mX4MtTe5G/5rJhjouN/0DC8t41xNF?=
 =?us-ascii?Q?pO7LgCVqU8BddgQbFpLnxpUS7fmCB5ip457QtbopxjzkGrpxzk7EekcjHtR6?=
 =?us-ascii?Q?Ysvz/IVgTiQ11cDqGmTApHnICS+FjoC9I8lSc91XGiq6SucK9KOn5yJ8xOC+?=
 =?us-ascii?Q?17nBckB8e/xR3FyItL1Z+iL7ZjgO+rbjmVmurbqLVf7Pmlx/LdhAAkW5+N5r?=
 =?us-ascii?Q?8R3rczsXIg1cC2S7gM+Nx0oYn9PMfsoQHYlIATsYVlDHoQFqfNbiFrDlsq0/?=
 =?us-ascii?Q?yEc6cJ8il7mYPqoB5V7vuH4Qx3mXw7Fa6K57fSW5Rq16db3aepmWa0DE5qYJ?=
 =?us-ascii?Q?H311r71MctNn26pjwz4weXqDA9c8i0UFc78Yar+F7FkkSrwyi5oEVdzXY3Hd?=
 =?us-ascii?Q?6VB9AFhB5a+eKe60wLo5AJuQ1q99aciXn6WPxSUDIYdRAeTqueruHeuSW8kC?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4f746d-6931-443f-bbab-08dbe0b153c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 23:20:42.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSVqWZgEc4SsoObL33Swr6I+YpWGAqTDXFHr2TJaHGrfbXQY93oPajsrE0tfei4unz6AFwaTJ0p/oUq2JBgXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:18AM -0500, Faizal Rahim wrote:
> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension:
> "the Cycle Time Extension variable allows this extension of the last old
> cycle to be done in a defined way. If the last complete old cycle would
> normally end less than OperCycleTimeExtension nanoseconds before the new
> base time, then the last complete cycle before AdminBaseTime is reached
> is extended so that it ends at AdminBaseTime."

So far, so good.

> The current taprio implementation does not extend the last old cycle in
> the defined manner specified in the Qbv Spec. This is part of the fix
> covered in this patch.

In the discussion on v1, I said that prior to commit a1e6ad30fa19
("net/sched: taprio: calculate guard band against actual TC gate close
time"), the last entry's next->close_time actually used to include the
oper schedule's correction, but it no longer does. This points to a
regression, and not to something that was never there. Am I wrong?

> Here are the changes made:
> 
> 1. A new API, get_cycle_time_correction(), has been added to return the

I would call an "API" an interface between two distinct software layers,
based on an agreed-upon contract. Not a function in sch_taprio.c which
is called by another function in sch_taprio.c.

> correction value. If it returns a non-initialize value, it indicates
> changes required for the next entry schedule, and upon the completion
> of the next entry's duration, entries will be loaded from the new admin
> schedule.

This paragraph doesn't really help. It gets the reader lost in
irrelevant details which are actually not that hard to deduce from the
code with some good naming. Actually I find it poor naming to say
"non-initialize value" when what you mean is "!= INIT_CYCLE_TIME_CORRECTION".
I think I would name this a "specific" or "valid" cycle correction, when
it takes a value different from CYCLE_TIME_CORRECTION_UNSPEC.

> 
> 2. Store correction values in cycle_time_correction:
> a) Positive correction value/extension
> We calculate the correction between the last operational cycle and the
> new admin base time. Note that for positive correction to take place,
> the next entry should be the last entry from oper and the new admin base
> time falls within the next cycle time of old oper.
> 
> b) Negative correction value
> The new admin base time starts earlier than the next entry's end time.
> 
> c) Zero correction value
> The new admin base time aligns exactly with the old cycle.
> 
> 3. When cycle_time_correction is set to a non-initialized value, it is
> used to:
> a) Indicate that cycle correction is active to trigger adjustments in
> affected fields like interval and cycle_time. A new API,
> cycle_corr_active(), has been created to help with this purpose.

Again, it's exaggerated to call this an "API".
Although, what you can do is provide a kerneldoc-style comment above the
functions which you wish to describe, and remove this explanation from
the commit message.

> 
> b) Transition to the new admin schedule at the beginning of
> advance_sched(). A new API, should_change_sched(), has been introduced
> for this purpose.

This should have been done since patch 1, not here.

> 4. Remove the previous definition of should_change_scheds() API. A new
> should_change_sched() API has been introduced, but it serves a
> completely different purpose than the one that was removed.

So don't name it the same!

> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 105 +++++++++++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 35 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index dee103647823..ed32654b46f5 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -259,6 +259,14 @@ static int duration_to_length(struct taprio_sched *q, u64 duration)
>  	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
>  }
>  
> +static bool cycle_corr_active(s64 cycle_time_correction)
> +{
> +	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
> +		return false;
> +	else
> +		return true;
> +}
> +

Could look like this:

static bool cycle_corr_active(struct sched_gate_list *oper)
{
	return oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION;
}

>  /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between the
>   * q->max_sdu[] requested by the user and the max_sdu dynamically determined by
>   * the maximum open gate durations at the given link speed.
> @@ -888,38 +896,59 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
>  	return false;
>  }
>  
> -static bool should_change_schedules(const struct sched_gate_list *admin,
> -				    const struct sched_gate_list *oper,
> -				    ktime_t end_time)
> +static bool should_change_sched(struct sched_gate_list *oper)
>  {
> -	ktime_t next_base_time, extension_time;
> +	bool change_to_admin_sched = false;
>  
> -	if (!admin)
> -		return false;
> +	if (oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
> +		/* The recent entry ran is the last one from oper */
> +		change_to_admin_sched = true;
> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;

Don't make a function called should_change_sched() stateful. Don't make
this function reset the value of oper->cycle_time_correction, since that
practically equates with actually starting the schedule change.

The oper->cycle_time_correction assignment actually belongs to
switch_schedules(), in my opinion.

And if you make should_change_sched() stateless, then surprise-surprise,
it will contain the exact same logic, and return the exact same thing,
as cycle_corr_active(). I think that naming this single function
sched_change_pending() and providing a kerneldoc comment as to why it is
implemented the way it is should be sufficient.

> +	}
>  
> -	next_base_time = sched_base_time(admin);
> +	return change_to_admin_sched;
> +}
>  
> -	/* This is the simple case, the end_time would fall after
> -	 * the next schedule base_time.
> -	 */
> -	if (ktime_compare(next_base_time, end_time) <= 0)
> +static bool should_extend_cycle(const struct sched_gate_list *oper,
> +				ktime_t new_base_time,
> +				ktime_t entry_end_time,
> +				const struct sched_entry *entry)
> +{
> +	ktime_t next_cycle_end_time = ktime_add_ns(oper->cycle_end_time,
> +						   oper->cycle_time);
> +	bool extension_supported = oper->cycle_time_extension > 0 ? true : false;

"? true : false" is redundant. Just "extension_supported = oper->cycle_time_extension > 0"
is enough.

> +	s64 extension_limit = oper->cycle_time_extension;
> +
> +	if (extension_supported &&
> +	    list_is_last(&entry->list, &oper->entries) &&
> +	    ktime_before(new_base_time, next_cycle_end_time) &&
> +	    ktime_sub(new_base_time, entry_end_time) < extension_limit)
>  		return true;
> +	else
> +		return false;

Style nitpick:

	return extension_supported &&
	       list_is_last(&entry->list, &oper->entries) &&
	       ktime_before(new_base_time, next_cycle_end_time) &&
	       ktime_sub(new_base_time, entry_end_time) < extension_limit;

> +}
>  
> -	/* This is the cycle_time_extension case, if the end_time
> -	 * plus the amount that can be extended would fall after the
> -	 * next schedule base_time, we can extend the current schedule
> -	 * for that amount.
> -	 */
> -	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
> +static s64 get_cycle_time_correction(const struct sched_gate_list *oper,
> +				     ktime_t new_base_time,
> +				     ktime_t entry_end_time,
> +				     const struct sched_entry *entry)
> +{
> +	s64 correction = INIT_CYCLE_TIME_CORRECTION;
>  
> -	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
> -	 * how precisely the extension should be made. So after
> -	 * conformance testing, this logic may change.
> -	 */
> -	if (ktime_compare(next_base_time, extension_time) <= 0)
> -		return true;
> +	if (!entry || !oper)
> +		return correction;

This function is called as follows:

	oper->cycle_time_correction = get_cycle_time_correction(oper, ...);

So, "oper" cannot be NULL if we dereference "oper" in the left hand side
of the assignment and expect the kernel not to crash, no?

"entry" - assigned from the "next" variable in advance_sched() - should
not be NULL either, from the way in which it is assigned.

>  
> -	return false;
> +	if (ktime_compare(new_base_time, entry_end_time) <= 0) {
> +		/* negative or zero correction */

At least for me, it would be helpful if you could transplant the
explanation from the commit message ("The new admin base time starts
earlier than the next entry's end time") into an expanded comment here.
I am easily confused about the "ktime_compare(a, b) <= 0" construction.

> +		correction = ktime_sub(new_base_time, entry_end_time);
> +	} else if (ktime_after(new_base_time, entry_end_time) &&
> +		   should_extend_cycle(oper, new_base_time,
> +				       entry_end_time, entry)) {
> +		/* positive correction */

Same here - move the explanation from the commit message to the comment,
please.

> +		correction = ktime_sub(new_base_time, entry_end_time);
> +	}
> +
> +	return correction;
>  }
>  
>  static enum hrtimer_restart advance_sched(struct hrtimer *timer)
> @@ -942,10 +971,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	admin = rcu_dereference_protected(q->admin_sched,
>  					  lockdep_is_held(&q->current_entry_lock));
>  
> -	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
> -		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
> +	if (!oper || should_change_sched(oper))
>  		switch_schedules(q, &admin, &oper);
> -	}
>  
>  	/* This can happen in two cases: 1. this is the very first run
>  	 * of this function (i.e. we weren't running any schedule
> @@ -972,6 +999,22 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	end_time = ktime_add_ns(entry->end_time, next->interval);
>  	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
>  
> +	if (admin) {
> +		ktime_t new_base_time = sched_base_time(admin);
> +
> +		oper->cycle_time_correction =
> +			get_cycle_time_correction(oper, new_base_time,
> +						  end_time, next);
> +
> +		if (cycle_corr_active(oper->cycle_time_correction)) {
> +			/* The next entry is the last entry we will run from
> +			 * oper, subsequent ones will take from the new admin
> +			 */
> +			oper->cycle_end_time = new_base_time;
> +			end_time = new_base_time;
> +		}
> +	}
> +
>  	for (tc = 0; tc < num_tc; tc++) {
>  		if (next->gate_duration[tc] == oper->cycle_time)
>  			next->gate_close_time[tc] = KTIME_MAX;
> @@ -980,14 +1023,6 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  								 next->gate_duration[tc]);
>  	}
>  
> -	if (should_change_schedules(admin, oper, end_time)) {
> -		/* Set things so the next time this runs, the new
> -		 * schedule runs.
> -		 */
> -		end_time = sched_base_time(admin);
> -		oper->cycle_time_correction = 0;
> -	}
> -
>  	next->end_time = end_time;
>  	taprio_set_budgets(q, oper, next);
>  
> -- 
> 2.25.1
>
