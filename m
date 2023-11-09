Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B897E6B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjKINSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:18:49 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD02D78;
        Thu,  9 Nov 2023 05:18:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7pyjL1ecBAXcH8WnaocEcthhqUFAZGYyOfkPt3aTV4ygBGa1sDe9Pb9jgwDG98bXkwm6WsUY0gQ4i6TAY8N0TzOJm4VxwPulR3rcNbIfzlYCZghZCN9Jyebk70WuJH9Zta7UFaliGx/Kuvq3Y7PWXbPiPB0ZyWPXKr4PLP2ND6mdp3YYzwbltnsA3Z6//dU+4Z/8ie6bBVuYclK1rwEkVSbpCg69LMfhKnAJIsK3AFQPhgcRUGTTJAxbyYKFftu6eHWyLiTzhCdRomWkHXdwfjoh+hjcU7l7JgA0BZ82h8bDkRWzD+BJ8k/kp77SAORLEBNkGjybK+8enqFfSmU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N1iieZrCf1uuk0U98315wv82fYWx/WYzNxSZPWPEac=;
 b=E8YvICym1L53jZIF+P5fxFS1NafPo4yOVOv3n/lgxn4lV0BZe3GvS99zEnrPgtJqu0Y7QmdX4K5KNjN8+eXMMsP090ooL9jQ7XtbG2DbGNSMty3GX5WdysFNBxNiQiwlf054b+Tk/IN3JhjOpCbjpKi2B3XHYm2FEQacfR8zhNYZNHBw2Qfg0djdrDK6dn5/jp/Si15ZC2KuHeUp7rjb41V9A3gqcRNJ0Tbkfz13gjAWZbXHyIwJxcdJsweVvg0oGs2SDpjnHs9vHwJ6skJ2T6JaJjkZ/oh08O2aoHrPYX1rrAWctmhDGecJexCNfwB2wuMR8sTZxno8mKzLXuqqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3N1iieZrCf1uuk0U98315wv82fYWx/WYzNxSZPWPEac=;
 b=iotu1cwfFvVOIk6VW3prdZ1ZMajv5qQQje2AjCiqdhTP179/miKR7Kppt+jH0vb7vC6ZSXAdlLK4iyfhzAqk2J9daF4H5JiJ2QgB4GtijA1T2XDYnT5zFtyURvaJFx5OVsFiIK512Vlb25Itg8KVoOd8Wmo5yPSPSsIFPEnkpKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 13:18:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Thu, 9 Nov 2023
 13:18:44 +0000
Date:   Thu, 9 Nov 2023 15:18:40 +0200
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
Subject: Re: [PATCH v2 net 7/7] net/sched: taprio: enable cycle time
 adjustment for current entry
Message-ID: <20231109131840.wgfrzuk5kz4wtd2h@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR0102CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::44) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b9a77e-c099-413b-6af4-08dbe12665d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toAHq5ujRfS7EeS7y3HjRfX5dh3e/gnHE+CHTNB+S4zfvQWx2u4+hXtlDpw99KdwCG63cWX5ncCfxPhhtUQdgpAm8yRPKFAtlRPjjJWfThBwlwgdpxDlpDZSTP+YxVq+UxWurulOlUg7zESGKa8zRES6MB9R1LvD7rQrFUqqlWX1IXO0HCx5ObiAQ2lUiEsJ6NZJN4mqEqZG+HpxA0SluOVsKb6FhjlCBSqDIl7EAGt39iNHqOnWRnOMdggg+k1mCKzylfZ9YZul1Cz1dOSz2vOjy64e8DFl2QPF4NAzLDlB1PL7dnQTGaeDqitd7YcOpRGQyDyakBJaWumpbKyw8SXK2BGOqVPomDQq4lQR5aqCqcrW4Hk6yiPXpaskgtR8mpDLYPzbMq1mauaHqY5+D9YLYY+qRKmIGdRw5mlxqVWRDDbIOYt+Uakly9/RYV5dqrBsZmU8XqCncVOvziNEqiY5A4Y7ERsaourKVkzHzzMT8c3fc+GVi9HtM898TnQamwy+UT8PkFKKpf3ge1sNL9Xq46G81hg4B5DzGIyKx2hLZOo1n8qwU/3iOha0iCM4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(7416002)(8676002)(8936002)(5660300002)(44832011)(316002)(6916009)(54906003)(66476007)(66946007)(66556008)(4326008)(6486002)(2906002)(478600001)(6666004)(6512007)(9686003)(83380400001)(33716001)(6506007)(41300700001)(26005)(1076003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRl7D9ZqVpNkKWOV9jIqoVS/dD2nyGWHJcKWM5TvThND3X1bWionAv/XGfML?=
 =?us-ascii?Q?CfH75a1ZIbV49P3vSMZDPNRd8QWpNznq3TQgdOMDkHrigGlZheEAusMYzrZ5?=
 =?us-ascii?Q?Qb1sleRl+mhLxOzRaFNwCE2H6Mm1qkNN/AONWJyUkG6qe4WGALW1fp9BEflT?=
 =?us-ascii?Q?7ftL+23SYm9Yz+UxPjIr1O0WAPwm8/noByMWIw1tS4Ci92gunbv4RXX3Q0QG?=
 =?us-ascii?Q?KjysAuDSZiDNehN2HOuzVpb1ZyRHTOJENbmJa0jg5DYI/tAkmJ4UNUYdxD3J?=
 =?us-ascii?Q?DhMkweqVoyIGwtQEAA1a6hJidX+pK29yhKIiPqDso+n7TAfFQmer7flGLE4l?=
 =?us-ascii?Q?G1MqHjhTGEfz+BrVt1DgLUSrPRn6nxhIb+e1dK6vY2oe/SYoVcE3qxlgM6Yw?=
 =?us-ascii?Q?iVurqVS0N1+F9e/Z9QjTiDEQwki9LgNVL/tlE7G9TPXTvVlFszuL/eN1SAEU?=
 =?us-ascii?Q?/uTleDR5LybWv3EEbQweDfG/F/TUAE5ky/by4rl40WyvPIZORqr+05AWfD8J?=
 =?us-ascii?Q?ryuNbpQEuOyPVc8V8xYjF5SHKLE7lURNNoK30OnQ0zGzn0KRxxws7QZFPAdl?=
 =?us-ascii?Q?aR2HdD2Nzt7/FKQNd07UBuNjdDdjak+hlp7ZFfv8LHJUURJXf4L7Mt3C4aBC?=
 =?us-ascii?Q?FIDwfA6XbP0ypk2OOW+c6j+WOsOhMlRG+rx/eHYUM99TJUe26+5D74emFePU?=
 =?us-ascii?Q?gaunjMCPykmejzBqJjo625REqwbWmH4fibUC68GxUFhMkZcxcC6e3cs3YDLY?=
 =?us-ascii?Q?gdNf0dAcIMmJQ5QLW6H+sG4xQ+rf/GEXabNW8pXQ7+FpXltEZyR/BDvxM0gE?=
 =?us-ascii?Q?moA0jQtWcoSfuWSCKpXfm7xqhoK9i0FDQp79W0WicthkQg57ScyS1waXWxJI?=
 =?us-ascii?Q?HEwONRXvAEV4JXvPC+o6hibQdG51we9F0bHyd7kqGgtIhxQb744Tvpc7RW1b?=
 =?us-ascii?Q?fbChq4znvS6g+VZtml6IbL1vi1YvpyExAofl9RM/X7bFSGpDm0d00bY2jKbs?=
 =?us-ascii?Q?4401+SGJ5lagSM5hdcja9YQUKJzsaKtJ8yoeZgqZOsLRwFhwLkytb17Cojy1?=
 =?us-ascii?Q?yG4KyncHYsC4Ko7PMDE+d7JIE19Sn1BMTrsqQTFLIh4e1BycI7Cd6uz17JlO?=
 =?us-ascii?Q?npoLSbwiI04njTk4yp0mEFqUoFrfEbYUT4OP46IoOEcgpm4imlFSlNe4deJw?=
 =?us-ascii?Q?8erxdnpXgXoTrgLcHkHFSBugcc58yO5tXwMv1SulkeXqmvHQO9dQxpQDtj6g?=
 =?us-ascii?Q?LHcWOYLMj32Zlvt3j1o39Od+h/YHLXyKvzCac+Dxw62ABWGABrddhsRgtyH8?=
 =?us-ascii?Q?tCNxcgL27KxLcLykf/xTVKBqMjOaIQYJnKqcVoHR0HmfEA2K9BB4AsYsMcfr?=
 =?us-ascii?Q?/0JFcxQAwOG9uHUw/EUf5NYzF8jdZ7BA7tqdhHeKu4a4WE+S5MtCU1ftGDxt?=
 =?us-ascii?Q?HG+sfG4c4+X0o0b6ui6iM7dc68ta55SaBlHCLCAFUdv6yTlU5qO2pFyY0NAK?=
 =?us-ascii?Q?3j0Wiidp/G+3yR5QBelZgbVyWVK1EZjIGijosY6lDVNUz/SXk19L5U8AsWoY?=
 =?us-ascii?Q?KyWLcj0GbRTbQRvlx+2iFN4+My+pMn5RbZd3mDcoVBupOlJgyQAIqbu2pP9p?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b9a77e-c099-413b-6af4-08dbe12665d4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:18:43.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVDjeijvp8OG4c4JLTdiuUNObDtJK1kfgmRtdhsbtAW3EQfu7zOZYIaPdtswHDAbrJWBCjvArMq/zxD8XIM9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:23AM -0500, Faizal Rahim wrote:
> Handles cycle time adjustments for the current active entry

Use the imperative mood for commit messages, i.e. "handle".

> when new admin base time occurs quickly, either within the
> current entry or the next one.
> 
> Changes covers:
> 1. Negative cycle correction or truncation
> Occurs when the new admin base time falls before the expiry of the
> current running entry.
> 
> 2. Positive cycle correction or extension
> Occurs when the new admin base time falls within the next entry,
> and the current entry is the cycle's last entry. In this case, the
> changes in taprio_start_sched() extends the schedule, preventing
> old oper schedule from resuming and getting truncated in the next
> advance_sched() call.
> 
> 3. A new API, update_gate_close_time(), has been created to update
> the gate_close_time of the current entry in the event of cycle
> correction.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 72 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index c60e9e7ac193..56743754d42e 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1379,41 +1379,75 @@ static void setup_first_end_time(struct taprio_sched *q,
>  		rcu_assign_pointer(q->current_entry, NULL);
>  }
>  
> +static void update_gate_close_time(struct sched_entry *current_entry,
> +				   ktime_t new_end_time,
> +				   int num_tc)
> +{
> +	int tc;
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		if (current_entry->gate_mask & BIT(tc))
> +			current_entry->gate_close_time[tc] = new_end_time;
> +	}
> +}
> +
>  static void taprio_start_sched(struct Qdisc *sch,
>  			       ktime_t new_base_time,
> -			       struct sched_gate_list *new)
> +			       struct sched_gate_list *admin)
>  {
>  	struct taprio_sched *q = qdisc_priv(sch);
> +	ktime_t expires = hrtimer_get_expires(&q->advance_timer);
> +	struct net_device *dev = qdisc_dev(q->root);
> +	struct sched_entry *curr_entry = NULL;
>  	struct sched_gate_list *oper = NULL;
> -	ktime_t expires, start;
>  
>  	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
>  		return;
>  
>  	oper = rcu_dereference_protected(q->oper_sched,
>  					 lockdep_is_held(&q->current_entry_lock));
> +	curr_entry = rcu_dereference_protected(q->current_entry,
> +					       lockdep_is_held(&q->current_entry_lock));
>  
> -	expires = hrtimer_get_expires(&q->advance_timer);
> -	if (expires == 0)
> -		expires = KTIME_MAX;
> +	if (hrtimer_active(&q->advance_timer)) {
> +		oper->cycle_time_correction =
> +			get_cycle_time_correction(oper, new_base_time,
> +						  curr_entry->end_time,
> +						  curr_entry);
>  
> -	/* If the new schedule starts before the next expiration, we
> -	 * reprogram it to the earliest one, so we change the admin
> -	 * schedule to the operational one at the right time.
> -	 */
> -	start = min_t(ktime_t, new_base_time, expires);
> -
> -	if (expires != KTIME_MAX &&
> -	    ktime_compare(start, new_base_time) == 0) {
> -		/* Since timer was changed to align to the new admin schedule,
> -		 * setting the variable below to a non-initialized value will
> -		 * indicate to advance_sched() to call switch_schedules() after
> -		 * this timer expires.

I would appreciate not changing things that you've established in
earlier changes. Try to keep stuff introduced earlier in a form that is
as close as possible to the final form.

> +		if (cycle_corr_active(oper->cycle_time_correction)) {
> +			/* This is the last entry we are running from oper,
> +			 * subsequent entry will take from the new admin.
> +			 */
> +			ktime_t	now = taprio_get_time(q);
> +			u64 gate_duration_left = ktime_sub(new_base_time, now);

What is special about "now" as a moment in time? Gate durations are
calculated relative to the moment when the sched_entry begins.

> +			struct qdisc_size_table *stab =
> +				rtnl_dereference(q->root->stab);

"q->root" is "sch".

> +			int num_tc = netdev_get_num_tc(dev);

It would be nice if you could pay some attention to the preferred
variable declaration style, i.e. longer lines come first. If you cannot
easily respect that, you could split the variable declarations from
their initialization.

> +
> +			oper->cycle_end_time = new_base_time;
> +			curr_entry->end_time = new_base_time;
> +			curr_entry->correction_active = true;
> +
> +			update_open_gate_duration(curr_entry, oper, num_tc,
> +						  gate_duration_left);

Recalculating open gate durations with a cycle time correction seems
very complicated, at least from this code path. What depends on this?
The data path only looks at the gate_close_time. Can we get away with
updating only the gate_close_time?

> +			update_gate_close_time(curr_entry, new_base_time, num_tc);
> +			taprio_update_queue_max_sdu(q, oper, stab);
> +			taprio_set_budgets(q, oper, curr_entry);

There's a lot of duplication between the correction management from
advance_sched() and the one from taprio_start_sched(). I wonder if some
of it can go into a common function.

> +		}
> +	}
> +
> +	if (!hrtimer_active(&q->advance_timer) ||
> +	    cycle_corr_active(oper->cycle_time_correction)) {
> +		/* Use new admin base time if :
> +		 * 1. there's no active oper
> +		 * 2. there's active oper and we will change to the new admin
> +		 * schedule after the current entry from oper ends
>  		 */
> -		oper->cycle_time_correction = 0;
> +		expires = new_base_time;
>  	}
>  
> -	hrtimer_start(&q->advance_timer, start, HRTIMER_MODE_ABS);
> +	hrtimer_start(&q->advance_timer, expires, HRTIMER_MODE_ABS);
>  }
>  
>  static void taprio_set_picos_per_byte(struct net_device *dev,
> -- 
> 2.25.1
>
