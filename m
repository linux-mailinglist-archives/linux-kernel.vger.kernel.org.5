Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88317781A16
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjHSOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjHSOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:30:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A691B338;
        Sat, 19 Aug 2023 07:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agvWq/IEcTDJJfensoCkPFSVgr6vbxpCFkD+wvbwvGcWvxbE7FZ4PEtQYw2+L0U9UAZOxNWtWjzqKKvUPPCogIVmm8+L9elO+RxkKlwWmK73jOR1/SXEKeq9N46jP3smXbt6dBJ57B5snZM3X+g/R6HSdnvuBMWHYXujaMY0k6XsT74adAw+jehaXYBPS1ootCY0OG0o9SF5I/L0xItCAZpHH4lSrVwGpOcW7j1Eu40XKlj9EcDIF0FopqAekKY35My2gbYivZ40KR33K/Qhn+sCmfj++f335lch49hCQieLWPXnffGovHBhSWo9jo7SGQ65WgEgTH5dPZJ4d52dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwRsGC0pkh7ZNo5dj32ltMyxAlOZspa65WWYe5x3StM=;
 b=JeLldyk5aBZbKY+wkZNeYt5l3OAXAgHnYNhUCrI/u1Q4civ+mAkl0B3O1MNUqJBn5t6uiaRV5nRqADfq/58FWRpfMlAmX4r+QY6oQiuTTkC6tieDdyTqPBQA3ALXUXKojslyn63xPYdmBJqGG1RJ8hbIqcyYcnCQgfcZ/UnGgnl9oJM1oacTNBCHHV3NlOORt5D6HCPR7/gUE9Mi3leBOYxpjZfhX9tr4kp7k2PkomrR7Sfzuod0nqmZjSB4/ymbCVBkZeC4tTTI1WcosF6KYJiRl78o7KPi2IzqKUkofb/q9iZLd0TqZBaM4itHmfBHsdxVCNCH+MZbPN2ba4RQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwRsGC0pkh7ZNo5dj32ltMyxAlOZspa65WWYe5x3StM=;
 b=iGoakm2OQJXcdxrH98ih3esm5MRguIVz0ugowtpsQotCEBvI0BIw95fjyKXkwYOyXLEJTy8kseoN8F5/yFJiw7eu9CV98Z6i7f70NWVAJEY9u0elzM+8u8VkoRF6uNWfO6qB3XZeGD8lvyvdPgzbCkK5VRX8I+Wnd3l/bBTn0jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Sat, 19 Aug
 2023 14:30:20 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 14:30:19 +0000
Date:   Sat, 19 Aug 2023 17:30:15 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, shaozhengchao@huawei.com,
        syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/1] net/sched: fix a qdisc modification with
 ambigous command request
Message-ID: <20230819143015.yjegbsu32ddsp3fb@skbuf>
References: <20230818181432.54283-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818181432.54283-1-jhs@mojatatu.com>
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 411084b8-06e6-4152-4066-08dba0c0d07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwXb+Aa5umGKkmtdI3LkClSq1vIzXYfWUkr1UewMefVrqNfHmux1VJtBcQyAakmWJeu6cNYSezJpxVezANUdhNUEgt3t1JMoQpjNH8Vle+Me3VfaP21Amjx9c9EV4iO3f02RfzP3egO9F74/yx5gJPOmB5CXYRRHP0oAZXp6v3IuETY2ON7f7tf0nwXnz7nU8CsV5yJJjYCp09XBuu22N3j8EeMT4Aj2oTkPzqXE9HIv/RiWuZ6Xlu+vb6yTt+BG2XLMIPV0sgqBt8/j999249OIWtV/k5dAfC2/GY/xlpgl7VxX3pzfsFXSQfSjJpVFFEfxSMttkwqy9McPjucy6JsdL2oY44/Ix1LLcM+UzZi/u6pMr0IcFWFZoPiURgKko75iwscYBphcDiDHnn68z66dDmXYqL82/NS0NM53YrX1KobY9eIjraDFUarEu3wV9UQ/sFE7BHn5nDqzCY75JdA1XMDgwU41wtht6whqW8gmpwfmRoF1J9Kd7QSJMMIzbdLgnG/Uf+3shC8tM6JaNm0C0pi9Ii4WgdJwokgEDto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(7416002)(2906002)(83380400001)(4326008)(6486002)(66556008)(6916009)(66476007)(6666004)(26005)(6506007)(316002)(478600001)(5660300002)(44832011)(41300700001)(8676002)(6512007)(66946007)(9686003)(8936002)(1076003)(86362001)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4v4jRiFLpXfsnKFIDGrd/MuJ0w4zc9oopBTJrAoIFdhUY8myXwRfyNb621m4?=
 =?us-ascii?Q?+xAgBrLDJQ8VDXI+ETV8YQ4FD3FdRV0L1UHg3crxLv3qwqHXDrJxAlzE5wO1?=
 =?us-ascii?Q?mQhmE9LHBhBGcqmxMgr6AWcGtp213Gqzg3zAQ3K4M6jdQqSwA+QXNyGwH8uc?=
 =?us-ascii?Q?cBtcuGbLRzKmUJVk5xktZT1BJFgfroW1L3Qrl0zyXtWPHKoOj7MDzkIRQUgx?=
 =?us-ascii?Q?b7Drtd692NMh6whIRo8U2+MXQB+NpPr2NNwyh9hMIAxUw9swkYEQ8mJ2U7l1?=
 =?us-ascii?Q?qrZENuPnD07/yRccdZHgOjuksNHUSv6GDudvPG/a4r+OLw7pg7SU7UIkhxgr?=
 =?us-ascii?Q?6elJeRlAEhDmwbh26mRpJoHqToGNt6IVEY+16XxtF+eqyvlbMkNtvk0bU3Ji?=
 =?us-ascii?Q?q4e/2zpCiok4EGxueKxWhcHtJrUtiE4HZXpN213kL1UXtw5wfrVOkoPSMFHG?=
 =?us-ascii?Q?bLSIe5aE5c1EJAGWbuDDAfo9a9Ethj2dEgGSqcHYdIQ47iljBit2swOQHcEi?=
 =?us-ascii?Q?pzJ4La/K1XquRXKqigueZ2v5gvPkwAim+s6Zamiwg2uA4mMPjdbgGHmlDaMv?=
 =?us-ascii?Q?hmtQDUuuC+tcPLXUDF8WqKC18SKb/6iR3t48O/+sMkvF/XY3JItCdaXQeRkZ?=
 =?us-ascii?Q?ROaAeIOAPRl+F+XK1AZA6aEoc/O/6JItNSwHpcnchI4351Ol+OmTT31yjzth?=
 =?us-ascii?Q?LFZ8vj/arCok8ihz2q3BDL5OBGHFFI8H0VmQnEPHqOMRWqJcL0eQHDqhkvvm?=
 =?us-ascii?Q?yA2a3W5DKXMubbwC3E+mhq/ZaaDOY0oY6XO/PWvLqAel0qSDdKX/R0Ypuux/?=
 =?us-ascii?Q?WuoJl2ZT1UFushOObYsu+LShRPnr6PgHJeEWvbAtjnNgmm4oJVZP6jk7u+SE?=
 =?us-ascii?Q?PQJZmKLnx/4gceUeOVqaREwKr4CLjYxcXK/B+QdYEcdT10PSDQ2bBcxs1Jav?=
 =?us-ascii?Q?YGLiVI6gyQvED5iukZPNERjjMnaHRFwjeGSR0IhLUm9/i6VfLUYIE8Nvfw02?=
 =?us-ascii?Q?jc2HJLkARP4t8qD9TYx9xxM2TahsSXYX82QS/Hhw4sl+ZNdj0h+7j+U/SMyU?=
 =?us-ascii?Q?9uvRTd9SWlcXdR6DXzXbqpZGB7jP/BDtcZAlVpn2/c4UkVyxSax8kLlV2YHV?=
 =?us-ascii?Q?uYL8uUvnSIF2cIWzETfhsmhXCYEd7Zf/XRKdJyUUGTTaWxnHBb81DEgw/N/5?=
 =?us-ascii?Q?Y+oM9VIR2ldeHfXuQJBL0JMtXPWm8JH7W4ch33osVeBrX8mY0xKyQt29VVvo?=
 =?us-ascii?Q?alMzM7s3Gkza/aQLbfhWECOFpBuhlvSIgWZCSEZDgxyn70nMSzFgX+IjCxoL?=
 =?us-ascii?Q?9lHloQlJ9DSx67MYbGmSfFdzNj7bgcwe/CFWpcb2CLmwFnmLjwcry3TucQ5f?=
 =?us-ascii?Q?1Wwe2KzowPHo6R4qS5xHQ3iMldvDuZX2CK3MpOuhaeU2Y6tXEuLj4wKQOodi?=
 =?us-ascii?Q?jPoQAt9nrF/2WYbeKS4LNISZz5EpjQqN1zqC+x2rwscedpH8OmnZgSm2qtyd?=
 =?us-ascii?Q?XzTJjfCo6T8dQOv/UQL1nd+JF44NFhIKZFe9qqryH3v9YJCg/EZ4TwHfC7Uu?=
 =?us-ascii?Q?jlG1ZfBjYpAoS2fwgx6cCfcQLt2f25omyxcXfaC2fEOAQQWgOxaoRc2ylto9?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411084b8-06e6-4152-4066-08dba0c0d07b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 14:30:19.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NtfuwJ/m6MPhjpgUEKEBCkU8HPLLLrP8894v32yUA4Z8PkDjDWBAcUmMkZm09BQZs3zkarQnyasIVYr4R7hFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamal,

There's a typo in the title: ambigous -> ambiguous

On Fri, Aug 18, 2023 at 02:14:32PM -0400, Jamal Hadi Salim wrote:
> When replacing an existing root qdisc, with one that is of the same kind, the
> request boils down to essentially a paremeterization change  i.e not one that
> requires allocation and grafting of a new qdisc. syzbot was able to create a
> scenario which resulted in a taprio qdisc replacing an existing taprio qdisc
> with a combination of NLM_F_CREATE, NLM_F_REPLACE and NLM_F_EXCL leading to
> create and graft scenario.
> The fix ensures that only when the qdisc kinds are different that we should
> allow a create and graft, otherwise it goes into the "change" codepath.
> 
> While at it, fix the code and comments to improve readability.
> 
> While syzbot was able to create the issue, it did not zone on the root cause.
> Analysis from Vladimir Oltean <vladimir.oltean@nxp.com> helped narrow it down.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
> Closes:https://lore.kernel.org/netdev/20230816225759.g25x76kmgzya2gei@skbuf/T/

Space between Closes: tag and link.

> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> ---
>  net/sched/sch_api.c | 55 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index aa6b1fe65151..dd3db8608275 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1547,10 +1547,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  	return 0;
>  }
>  
> +static inline bool cmd_create_or_replace(struct nlmsghdr *n)

We tend to use "static inline" functions only when defining them in headers.
In C files, we drop "inline" and let the compiler decide whether to inline or not.

> +{
> +	return (n->nlmsg_flags & NLM_F_CREATE &&
> +		n->nlmsg_flags & NLM_F_REPLACE);
> +}
> +
> +static inline bool cmd_create_exclusive(struct nlmsghdr *n)
> +{
> +	return (n->nlmsg_flags & NLM_F_CREATE &&
> +		n->nlmsg_flags & NLM_F_EXCL);
> +}
> +
> +static inline bool cmd_change(struct nlmsghdr *n)
> +{
> +	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
> +		!(n->nlmsg_flags & NLM_F_REPLACE) &&
> +		!(n->nlmsg_flags & NLM_F_EXCL));
> +}
> +
>  /*
>   * Create/change qdisc.
>   */
> -
>  static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  			   struct netlink_ext_ack *extack)
>  {
> @@ -1644,27 +1662,37 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  				 *
>  				 *   We know, that some child q is already
>  				 *   attached to this parent and have choice:
> -				 *   either to change it or to create/graft new one.
> +				 *   1) change it or 2) create/graft new one.
> +				 *   If the requested qdisc kind is different
> +				 *   than the existing one, then we choose graft.
> +				 *   If they are the same then this is "change"
> +				 *   operation - just let it fallthrough..
>  				 *
>  				 *   1. We are allowed to create/graft only
> -				 *   if CREATE and REPLACE flags are set.
> +				 *   if the request is explicitly stating
> +				 *   "please create if it doesn't exist".
>  				 *
> -				 *   2. If EXCL is set, requestor wanted to say,
> -				 *   that qdisc tcm_handle is not expected
> +				 *   2. If the request is to exclusive create
> +				 *   then the qdisc tcm_handle is not expected
>  				 *   to exist, so that we choose create/graft too.
>  				 *
>  				 *   3. The last case is when no flags are set.
> +				 *   This will happen when for example tc
> +				 *   utility issues a "change" command.
>  				 *   Alas, it is sort of hole in API, we
>  				 *   cannot decide what to do unambiguously.
> -				 *   For now we select create/graft, if
> -				 *   user gave KIND, which does not match existing.
> +				 *   For now we select create/graft.
>  				 */
> -				if ((n->nlmsg_flags & NLM_F_CREATE) &&
> -				    (n->nlmsg_flags & NLM_F_REPLACE) &&
> -				    ((n->nlmsg_flags & NLM_F_EXCL) ||
> -				     (tca[TCA_KIND] &&
> -				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
> -					goto create_n_graft;
> +				if (tca[TCA_KIND] &&
> +				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
> +					if (cmd_create_or_replace(n) ||
> +					    cmd_create_exclusive(n)) {
> +						goto create_n_graft;
> +					} else {
> +						if (cmd_change(n))

else if cmd_change()

thus the code block under the qdisc kind comparison can become:

					if (cmd_create_or_replace(n) ||
					    cmd_create_exclusive(n))
						goto create_n_graft;
					else if (cmd_change(n))
						goto create_n_graft2;

(no extra brackets are needed)

> +							goto create_n_graft2;
> +					}
> +				}
>  			}
>  		}
>  	} else {
> @@ -1698,6 +1726,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
>  		return -ENOENT;
>  	}
> +create_n_graft2:
>  	if (clid == TC_H_INGRESS) {
>  		if (dev_ingress_queue(dev)) {
>  			q = qdisc_create(dev, dev_ingress_queue(dev),
> -- 
> 2.34.1
>
