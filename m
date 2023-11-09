Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1447E69F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjKILzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjKILzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:55:37 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A0211D;
        Thu,  9 Nov 2023 03:55:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7L8TqdfmIRSxO1kxmfZhsICDFZzTmq86PeWO4zJUwhd103CiRY2WcGwvUj1KJaJYoilqQoRyLxR1yWsAnzF3Qk40A5n42NdUbwpbHiOokLpc4nIdMmk0BM81tPEAgPr7F0Dv3VDcEisga9NakvRHqUa81Rb3mhhSnz2diseVrr9fuddNuXyFpXD+MDsTkiGA5WnHhrlKxw0cZwXWqRIY8gXlfocK0lCg7ifwLOxa8zjK/gvsBSatBavLmrKj9p6cmvIKaqueT/oZM4Xani+exN1JMSh/alN33khcQ56TQo50e/yzevEG2BB2A4nfLjIJ/hNCk45vmtbvcl2BZv4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3PejJiA6Hfqz2RumLaK5822FeON1+IkANvSsDLFcLg=;
 b=nqgh6Uafyeu81IjNaFvWEB80CDqZJafHS2v5OA6dh6kqUQK6PzSs6A+SmUYLJCaYIZV7pkfEEyRgGpfxjsw34ySZt1AIh9oY4OLZIkyHARDcrJD0fD7K74g+GOJpXETODSqHTjjZFBJOm6TBc5zay+Gx3w0Ka2SBCpn4pvf1daoC/zvkQPWVN3z5qLsPt5i8axbIlihQSwKoUouioU0sNca9uU1bxcBk66XVXr6iDF/54l6+iIi14vYd+q8/BtaNJIU9fSTkM+WAdwV7bpzzmiWPrMI2IRFTS+B0RnwAUOdi2Hi2uvO1LjgjS+wwKouRtpnNsRDK4vYweivKymyC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3PejJiA6Hfqz2RumLaK5822FeON1+IkANvSsDLFcLg=;
 b=W0RDP5e4e98ZXpfkKyvQoTy1LFVm+lL5d/Lv6rbZ79CTlg7wgv0I0N93Rb7JZeQ6a3UbrQi3DQwbcsTorJzybV7X3skhS8zzZ6ASBXfUBqznXgcn4t0S/kVQGJmaMYhSettOyWbI888SrF/JnW/Yn4jpH8nzv2Zwj6wFwyO43l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 11:55:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Thu, 9 Nov 2023
 11:55:30 +0000
Date:   Thu, 9 Nov 2023 13:55:27 +0200
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
Subject: Re: [PATCH v2 net 6/7] net/sched: taprio: fix q->current_entry is
 NULL before its expiry
Message-ID: <20231109115527.loaz76xp5wxwbqav@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6b00d3-0e04-456f-875f-08dbe11ac5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNx+tEo97mIrgZVi7gspRB12o/JondaGJuMvRyZDPdNBPzIFjC0iw5HKoqKr48A57cKqhdgjpuGn9CfjqITspq9+hQldTlaYlkzR5UyhNrTiJ9aremvVohNCdGC0T5X5O9iXL3jFtNj8i2+BsF6KRiJjdwEiRFUtfFHaz6fyeqVBjCAm55UILos14wQnY92F435RvcesiBHkduiApY/ANEwM3ANv5XKFmYIBZMgDCDxiYMWwPb+cS/r2/vFjfUhbUsSpn+ruGimhkwAVy9OOYnZ3Guke5AdRfJuYUQ6ckjulA+pRJxl83TBkQ6PDaERfhKudAdcEt0im11LtquEN1uNptJb9o0jQhVgTRs9NYBpoD+oEtdyn8B6B34v5/X8SUiWaxzUyBlvs1HWntfQR10RAsggHdJRyH7/Z6W4RKCKoUpVrxJ4g3hg2WB2C5a5IZMm+N3sY8GL4M1YATzzfRn/sj5b93ED8Kf5Cr0aSgYb3F4Ntsm38chEQ4Z75KTFTEdITVnJF02YDQBSiy1lUSedGJ6DDfU7NsIKpJxQVtBF3qcTg1xCMfy71eTP1m9OD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6666004)(6486002)(478600001)(86362001)(38100700002)(83380400001)(6512007)(9686003)(41300700001)(66946007)(66556008)(26005)(6506007)(1076003)(5660300002)(2906002)(7416002)(54906003)(44832011)(66476007)(6916009)(4326008)(8676002)(316002)(8936002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/Y68TN6ITXxIALdvry8fj/CPrdI5ITrCMmK5t08w8Oqs56xeRz1lYgpGg86?=
 =?us-ascii?Q?MdG8SOJ9Ae/P9X7muQS8+qjAq/s0vHHuPl/Tuh8dYEBJ6cZmaF0kH761Oxh6?=
 =?us-ascii?Q?VIv1jE3IVjKL6tGFtHX4B3NDmxshmbkqjkNAEGshbuQ6x9Ue5oGn99WCUN+m?=
 =?us-ascii?Q?QK7SDDe3rwdE9Arm2A8q8VbO9EtCFRqg+I+SEAIfGSYGWG2QRjtl0XEwFWdG?=
 =?us-ascii?Q?62trMFMskopghWsjAz3FVfoNCQgNjl1wWVs8TKRJ+UELCXgoBUHD49jdX9Ni?=
 =?us-ascii?Q?dGCcQf1YEHSBKIr9oVSkitWg3jF0TlsF+5CxD8xL6M5DL0Dc42BteTzavS5F?=
 =?us-ascii?Q?1JhKMKOByjt5VjPMrW0Im8ZSioQQ3i8K1oMfmr6H8cDX+6IrgBOPG//9jUtW?=
 =?us-ascii?Q?5Lxl6FZM2J46ZZpHDE7xPr+KMzPiLD8963Mgj271jLn1qw3jaXHFUt7C9BS0?=
 =?us-ascii?Q?Z9ehIvmbvgP2j/iTU9QvjUxuhWAqMd+G8ZOnsnKMLo0Gs6N+izDQRkIxBJEK?=
 =?us-ascii?Q?EbLX0jawciAjwm0D9J5eHU+W33bX/Gfv73ghUeSWgUGA6T7j0F5gFyRkqu3b?=
 =?us-ascii?Q?1FkzcdWPMPO3XpUu3jbDZKCI2N7cfWBlKCOTf5HAbhMcru1FyBOPUOlsZYQf?=
 =?us-ascii?Q?zT9Ysa1oLmo5FCyaTuW1IsIW/JUA+GGbT7AZe7SJSPT0mwVnJe1jZhZm4Lj/?=
 =?us-ascii?Q?OsSquojyF2B++iaj7+C+xWwLi+jtiqLKBeIvZmI7oei6twEFhVL4o1FaT25Y?=
 =?us-ascii?Q?XYr52Iet0Ag89QH2tcHmk84Np0qv9hLiYHd10ituE/AklsdeFiypYrvvlNIT?=
 =?us-ascii?Q?l3M9Gww5xINZBAhDsDgCwbpMKVuKEBwZRlEDjKNdOFqNO3+1/Bc4riZBx4ZY?=
 =?us-ascii?Q?rKbUKFfn3kYzqEFBW817n6ocjUI6wsqidxh1vtEhu9QAKDyoRmwxqAdzogJD?=
 =?us-ascii?Q?eQkZah78f466aGVBTexJ/ERL3SuAvj4fp82EEAp1F4ZYJS+It1E2roTpczXU?=
 =?us-ascii?Q?+JK66g/OZsVPxNjB/034xT3MpPkU+Q9ziqeqrCwWV1BqfxK5fTuuP1QUlICN?=
 =?us-ascii?Q?sr0I9Wkc/zwmX2sfYsxpIFkN8plHG+syFUs1WXyogsDTZAaRnohP9cjEFej5?=
 =?us-ascii?Q?tQlAfXXQ6eok9aR4Q5jDFqLySaBGDhTMtzfKMCdr+NLA1QAWUUc8u6SKAug4?=
 =?us-ascii?Q?s69vMytRZV4qWhbUcryKri8/lkhAfliGEdWGYEfE3M7sgtBkAaKzJYTNi2Jw?=
 =?us-ascii?Q?2y6XJR9zEixhdPR/60wOnZINGklyuPdpVnAiPNafzCyNC3/rWm3J9e7wJOqc?=
 =?us-ascii?Q?LqflBKjgZfYKPMbbN6GcxFhUINav9+zJamHvBFZJx4tlmgEkJSlMZcolfFbX?=
 =?us-ascii?Q?MD6NQxQLPo+ZKmysHRDk6FnkcjEPSafWTNEAgOC2Zjzyt0PXJNAn7K2jAcRY?=
 =?us-ascii?Q?84eCPGtV57vn+0552ZLgo+tkp8LKJq2CeZHZU7E8sJFIk2JlEH3XgkMWyLdl?=
 =?us-ascii?Q?yYFA+gWdfbJMZ6ybwqBUkKtYGxKC0MMejskEP2IP/Sp/E8w0WxQeSJQUr2Qd?=
 =?us-ascii?Q?QWynF3iNgWvlPMaHfL3xq168AIEtz7UZ2VWDmMP6R5Gs8A3OUMnpQ+5RJWrj?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6b00d3-0e04-456f-875f-08dbe11ac5c7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:55:30.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbO7Z3xHh+B8H5iRqkfJeCks/kM5DRdiES2/LZCzx4TIp3Pt3Qh/tAF/xMYTcSvtTmpvpnq6e2YC5UB/wYwoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:22AM -0500, Faizal Rahim wrote:
> Fix the issue of prematurely setting q->current_entry to NULL in the
> setup_first_end_time() function when a new admin schedule arrives
> while the oper schedule is still running but hasn't transitioned yet.
> This premature setting causes problems because any reference to
> q->current_entry, such as in taprio_dequeue(), will result in NULL
> during this period, which is incorrect. q->current_entry should remain
> valid until the currently running entry expires.
> 
> To address this issue, only set q->current_entry to NULL when there is
> no oper schedule currently running.
> 
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

The "Fixes" tag represents the commit where the code started becoming a
problem, not when the code that you're changing was first introduced.

I find it hard to believe that the problem was in commit 5a781ccbd19e
("tc: Add support for configuring the taprio scheduler"), because we
didn't support admin -> oper dynamic schedules back then.

> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 01b114edec30..c60e9e7ac193 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1375,7 +1375,8 @@ static void setup_first_end_time(struct taprio_sched *q,
>  			first->gate_close_time[tc] = ktime_add_ns(base, first->gate_duration[tc]);
>  	}
>  
> -	rcu_assign_pointer(q->current_entry, NULL);
> +	if (!hrtimer_active(&q->advance_timer))
> +		rcu_assign_pointer(q->current_entry, NULL);
>  }
>  
>  static void taprio_start_sched(struct Qdisc *sch,
> -- 
> 2.25.1
>
