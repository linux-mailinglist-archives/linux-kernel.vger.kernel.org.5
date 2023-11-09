Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056007E69ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKILvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjKILvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:51:00 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415619E;
        Thu,  9 Nov 2023 03:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehl3ms3JgWE1Q6a8RIHzQTtQGwCHmoFnrLHvQQo4qlG4yF249fR5okvS6eMv9mCBWr4YqROtFZfGwgJoMuma9raFaIQMWPyQC2cmLACboA/S6jdRu7cQOOnZaBR3IMsOoA7ziitT64ykVYZpI9OgB3PwqWn+ezmfWHFANdGahxnl2cxNGJvlkzF5+Aw4VcSDMYPe2CWmZ97A8pLCA4M1ecOaxjPkWl/vLPSKkc3rD2W4+ZelUFnAdmckLvL4wnmRuOG2sI/jWVdhGsg+Chno83zP2b6RmdK4/IqNVKCihNxaPImShh+v5shifgX7A/ajhxocjLRqWQiXMjPbepTAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBh9QvkhAm/bhRyPxBExc/o94SRksH9s79ZLrmDjTWs=;
 b=iaK2I5cABBWI70TAQehLeVsJkE6T+FaWnXAhXJplmmsM9sJ6d7+AeoXuBpM1lkDqImN75GgapZRiZNeFcckHwXlh859ZvokTlt2J2w6dP1wxB+qAGR4eDQjOG8CGnkLPwpZVulVuKnMymB3DRfA7Vh4IjnWZMjvnGQ1BeS2akUtXThk8GtupUN/24Li29YJaGR+eaiIgxWSeu3HT1h/qx20wb9p9Y+HIdb5BS1aD1gfYNhqBm9qhJgKGdvxKtEDhjk6eJtnbqEPc4lETiZ5az3mOfSk2+bEnTb6H0Aqom1KojtKuI7k7I1WmZrGJwyFICcKCcmuXqQ4pkZV/1R/KEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBh9QvkhAm/bhRyPxBExc/o94SRksH9s79ZLrmDjTWs=;
 b=Noo+A1QjpqGW8zzu3D7nfcIFw9NCt0ufv3bGF2SlPLawZ/cX0GTbD+MZb+VPhEj+S3pGGUTQyHt6MZLAAe1EhjibNx7B/2TeNAq5J9HHg7taLpj8SqmdmfLliCyNQjXYwCL2218cL28kvAqksYz0LYqjCoQ5sxuMmWYaNeLhfvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9556.eurprd04.prod.outlook.com (2603:10a6:10:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.13; Thu, 9 Nov
 2023 11:50:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Thu, 9 Nov 2023
 11:50:55 +0000
Date:   Thu, 9 Nov 2023 13:50:52 +0200
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
Subject: Re: [PATCH v2 net 5/7] net/sched: taprio: fix delayed switching to
 new schedule after timer expiry
Message-ID: <20231109115052.xz2vhaknno6nycbo@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-6-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-6-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 0297e40e-eb26-4b50-9df4-08dbe11a2189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCqr0czUL6b4eJeVsNjjxgx6bM6NW767FxApIxT7K46i3SALjkga/CAW/WrwghEfx+bmtYSxujUhXBPZSYQkLeV6o+EHvusFjN5UpdZ2etK2Cm914abZkqQN8JUKQ+6OcHuY5e94B96dVuvKjMLUn3oGIlnRsvt7UPM4sqPPGCSa7dAwcrtPWm1J2nQtA2RR+PVSuMxLRCdD63W3Id4MaKXwGzzpNM3v7YSmpTsp38Joh7AV4Mu+1K7WqKjLesTXecc4TtO2B5bh5S26XKt+msLtkzxM3zfg9IH2uGvUdqF00SgdOwJz7U/5zeVNZAO9zcjTY8/EhSNjLcs409nr3KfJOAY/GNm5rYK2sIiRcspxqGCQfm0N66V80fVuS878hrD46QMsCAEzGJksdUgLw4xUFLJk6gBOwI0Rg4UEYttBMJg+SDEEQXqXoKK2D5Mc/qzxQx3yxU8LZQbZEBXsl7f3PjbulauidmF4vYgZKpqYYDzbFsrorKvV6Sq/Hp+32lH0pBNPIOs5ndb/GkD+KWHLNRAA/TbYgwJMcabVxYt+3mkOcWb/Df8PtseZIpoV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(8676002)(8936002)(66899024)(41300700001)(2906002)(5660300002)(7416002)(44832011)(316002)(83380400001)(4326008)(33716001)(86362001)(6916009)(66476007)(66946007)(54906003)(38100700002)(66556008)(26005)(6506007)(6666004)(6486002)(6512007)(478600001)(9686003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0x6d7kDL5qAbVxFF4eqnp64iCWlGdBSdfYGAmcrULCdiIVNdRob6GZyll+Kg?=
 =?us-ascii?Q?lljrdqXGiYSYogqPt3DwhU6Un3ohn8aY1INoOKJfdQWmeHTWa73t1KKfCPN8?=
 =?us-ascii?Q?c54maZIlvdLwST+Xa8fSmyyMvPA84EyiJtH7kqT7bRJ6RklcpngvRavggHfp?=
 =?us-ascii?Q?GXDzhoWsRwrMKfJh18ashko+qotuW7YtLzJNubFJQ7rfv9JtxZI4tvNh5Kcm?=
 =?us-ascii?Q?hehmVep2O50insW0CIJ/A00z05ubsWDQwbSyaEwKJeUwvGq1JGn7R3cYpSSP?=
 =?us-ascii?Q?1HLDziKgs2GQZhtGzt6cXH5srnh63R6Yhkm7zL9VgkrOvuVqHFtu7Iv8ji8T?=
 =?us-ascii?Q?Wlc90ESGzGgMHCwFKiT95XXe+nKctsXyjtyTAt8f41VuysRRG0HjYk0SBlMA?=
 =?us-ascii?Q?zeWtPjvQ3X2x5COxC2+TInfdtSdqCalVtX3FrsfJ0YxZPA32gtTA1mo5hJlM?=
 =?us-ascii?Q?XLt8ikJUNZ6a0ooDN7BRtF3N8c5Bl8je9tNm8icnbu66tH/t/CfkTbyBbjv1?=
 =?us-ascii?Q?kpw8IAvFV1IH78NUlP6vJ91HOKNwqt2QywUFx5yjFVHxS6ZnQlsXYQ2zxe9E?=
 =?us-ascii?Q?sxhL0rW1hg9hRIdEMTQMxj4LVHHmAO18pXkzZ4dXZDAqtdbCtUZjtXEm7NNY?=
 =?us-ascii?Q?USlNBwslyyvRwUccDvRZ7WHMcjOeEbhGYruJsp4DXU8ojl8Bnh2A+mJ+g2wc?=
 =?us-ascii?Q?XAC//9RZzG3455/j0ZButj2dOx++1lUobPzb+3HtN4m17f1lhn+XSaf3XH4R?=
 =?us-ascii?Q?O2gq1zYgxJevfdFmXQl3qg5t8NOqYH3pPwH/fNJ9qZJ77ddP7eFqjn0Kn0wD?=
 =?us-ascii?Q?pJi1q/S3DMApFf/6FEEr35Q7HQfaMhSkHNrcar+8sRhY6107niKdTV8uSZru?=
 =?us-ascii?Q?Dz2BfRcMypdRQAfiIknlIfcYv+iDqGgTVWFLyEDCgPVdDlOgCItUjv62Wbqx?=
 =?us-ascii?Q?6rSvt4a0Rpuc1fg/0WWkoqQTOOCkXIKPopgwE/Jg5Nz77bnudcNbV64RKHy/?=
 =?us-ascii?Q?4/OB9tz2TKF21JvpxdDikG3gFNJq+SPMO0lhpziGDJs6yCICOFrMoXsCZ4Mp?=
 =?us-ascii?Q?TCsbHfca+N9LcZTh2iOWO3d1BakBbaouUdNq7JvDXty2xDuq24QAPnqppysx?=
 =?us-ascii?Q?0mXk6qrFQp6MLuUEYVtMyJctJ17T6tE8X/VP8VITvm7zRZOUUQbxUZs2Hqk0?=
 =?us-ascii?Q?ck13/Hz9J2FGgO5i4pta1VXIznRjx7YqMmNm7HN9zLLPhhgFXlFLSpjOaFB3?=
 =?us-ascii?Q?mQiKyf56JfjY1fz3b9KQDmUKLyFFNQgiLSvq/5/EqQCylsDcshFHl+peJZSB?=
 =?us-ascii?Q?7/xvMHHr/pTbFZUI6XayWlCnTqiXr4twkiEQbcabi3AT553CHVx7r5uktd8s?=
 =?us-ascii?Q?GOuxfJekCq4nURkOCD1BRTnEqaOvcY1J/iWDqt3tRTKGIDybQqgbGOSn+uCa?=
 =?us-ascii?Q?umK0rXr4BBI59xvpnOSclBKsPu9v4mg+AWp24p6cJ4RCFwu3hjY2uhVOEbwK?=
 =?us-ascii?Q?hT16vjhEDQVYZ9ixnO4lGXXTEoCALrQrMqAb6GdbB+8PGhdBujuuvxGQZ+Zr?=
 =?us-ascii?Q?WzhKOlP2+lHt78ndlMPzEldipskCvELyF9wlpqQT6APvBzgWE0jV97wLdAK5?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0297e40e-eb26-4b50-9df4-08dbe11a2189
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:50:55.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzJtKzwwoR/Z/GuYHG6p6yZpMiEtxtkB10OMlnuTQ5u0JECMCpTPlFxgXxnwTdK0OdJK0kSYbt+mhzq5aZ0aXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:21AM -0500, Faizal Rahim wrote:
> If a new GCL is triggered and the new admin base time falls before the
> expiry of advance_timer (current running entry from oper),
> taprio_start_sched() resets the current advance_timer expiry to the
> new admin base time. However, upon expiry, advance_sched() doesn't
> immediately switch to the admin schedule. It continues running entries
> from the old oper schedule, and only switches to the new admin schedule
> much later. Ideally, if the advance_timer is shorten to align with the
> new admin base time, when the timer expires, advance_sched() should
> trigger switch_schedules() at the beginning.
> 
> To resolve this issue, set the cycle_time_correction to a non-initialized
> value in taprio_start_sched(). advance_sched() will use it to initiate
> switch_schedules() at the beginning.
> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")

Did the commit you blame really introduce this issue, or was it your
rework to trigger switch_schedules() based on the correction?

> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f18a5fe12f0c..01b114edec30 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1379,14 +1379,19 @@ static void setup_first_end_time(struct taprio_sched *q,
>  }
>  
>  static void taprio_start_sched(struct Qdisc *sch,
> -			       ktime_t start, struct sched_gate_list *new)
> +			       ktime_t new_base_time,
> +			       struct sched_gate_list *new)
>  {
>  	struct taprio_sched *q = qdisc_priv(sch);
> -	ktime_t expires;
> +	struct sched_gate_list *oper = NULL;
> +	ktime_t expires, start;
>  
>  	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
>  		return;
>  
> +	oper = rcu_dereference_protected(q->oper_sched,
> +					 lockdep_is_held(&q->current_entry_lock));
> +
>  	expires = hrtimer_get_expires(&q->advance_timer);
>  	if (expires == 0)
>  		expires = KTIME_MAX;
> @@ -1395,7 +1400,17 @@ static void taprio_start_sched(struct Qdisc *sch,
>  	 * reprogram it to the earliest one, so we change the admin
>  	 * schedule to the operational one at the right time.
>  	 */
> -	start = min_t(ktime_t, start, expires);
> +	start = min_t(ktime_t, new_base_time, expires);
> +
> +	if (expires != KTIME_MAX &&
> +	    ktime_compare(start, new_base_time) == 0) {
> +		/* Since timer was changed to align to the new admin schedule,
> +		 * setting the variable below to a non-initialized value will

I find the wording "setting the variable below to a non-initialized value"
confusing. 0 is non-initialized? You're talking about a value different
than INIT_CYCLE_TIME_CORRECTION. What about "setting a specific cycle
correction will indicate ..."?

> +		 * indicate to advance_sched() to call switch_schedules() after
> +		 * this timer expires.
> +		 */
> +		oper->cycle_time_correction = 0;

Why 0 and not ktime_sub(new_base_time, oper->cycle_end_time)? Doesn't
the precise correction value make a difference?

> +	}
>  
>  	hrtimer_start(&q->advance_timer, start, HRTIMER_MODE_ABS);
>  }
> -- 
> 2.25.1
>
