Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2876FF4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHDLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHDLOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:14:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA87AE69;
        Fri,  4 Aug 2023 04:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGbeMFhjX1WNF4XPjqkCxQuieOv97SqPX/SDUn9ZArVwW/+MdJY0o51DQmnO/jLH6UYxib+PZX2Va4vWg051f8R+f1pVmxRI7HCrMrxRbpDLNPdswHAvRGR+sozPFmkyk8h3LAfv+H74ZrJgBHd2poidZJ5ntGSZHhOrC0y93HTBrxwwIXjgFZbR3qGiE6x7ZF4E2OOUCJ8OO6v8f7kIFTnrOr9QsBIl8+f2g330y/2+1i4vFh1qfwcxO8VEHWG+61Yk0ZP5xuqQayQ/ZOl4+ww+aSkydecW9CnoSMRs9qDSKChQmGYtHx1vlmn4BYqUCFWnxzdLyAbHXfpDWVR0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jua2KVCnWp+yRIYvJe0Wrr31FT8Ljf12uiAR9De33q8=;
 b=VpfdmK7BZkMN2WZ6fRO8mY4I4sqmmhLyb0/BUp+DnDoikx260jrSkvTNIEIEr8M3WF6LX1lyuYBFSdCaOd+8uj3WGol4OKFNGXJOtwdHOfjKsIjeebx3TkzPPgx4kOgBK0jA1Jt2npN+2aTcjDS3kxmk7MpCw3XSE0WDBKkxpgddDPOyaTSeq2XlVIZ660ajdpSb3yRVZhSr8Eaey48ET1OFKAmElLOENemBbzuXPbKwQ7ArK5NWjbqnfJt+GCfmYFoVxoEwxjw34F57aPsvDuf46D439k8tzJVQsMtqHKusDov4NlM6YQgzfN+X6MV4RqbUOlM0ui1XuwMt+r7J1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jua2KVCnWp+yRIYvJe0Wrr31FT8Ljf12uiAR9De33q8=;
 b=fZhZJOnsczHeFeLiEZUb1g33l+Kl6e7JgA2EEAe3TSVrqEmxzoqbS9120uTKgRvGsWqAHV4IY+JSUPm44UKoaq8ytaMXCWrvZjwrHFHQ4QlIr1S/9URwevrRLnOdFFceFDEVENcD8ka7RhzKlfSuospasqnL2kDR9hokspX5TLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9357.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 11:14:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 11:14:35 +0000
Date:   Fri, 4 Aug 2023 14:14:31 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Victor Nogueira <victor@mojatatu.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v3 net-next 09/10] selftests/tc-testing: test that taprio
 can only be attached as root
Message-ID: <20230804111431.cjtj3kbcwhk5wcaf@skbuf>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-10-vladimir.oltean@nxp.com>
 <918bf9fc-1c8f-a006-560e-b437581c6ec2@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918bf9fc-1c8f-a006-560e-b437581c6ec2@mojatatu.com>
X-ClientProxiedBy: BE1P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e31edb2-cc0d-42e3-2f5e-08db94dbfc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR2k/ybMND6MGITIcCVpR+dd8/PvdX0f0+UlMKky8PmEsjZ5N3P4poiEhpUamO7qb9xClqi3tT39Ej9Xh3IgAl19E6KFFjTe/FuA/kElZnbD5x+63a22CRGy70xn0Nvf8MtyijvPsl5tLEiIJLPv0zcrsZ3W+YL98DaOYs7QWxqcC4/Z0w3/d/4VoanFxOYot+/fPJby50QFbCXVdZNvRn2TGsy2PF7pzpFs6iyCYZup/9sm0lACUP79PN49hp5Zw5/4CmSp0OC3SxYRp4TWwRvtguynC7GAAAPOa7woixyt8Y12zzIImT2hR+EWcIF8dhTgSMtp7ZrdUdEmCZL4SX9PvuPtjg3YHwj8aNa0oX3jont5fqR0v0ZUcOb4iC254f8942Fc36gGrwNTKhbmCpdEahY9ra5ZAtPxIvKb+mS88ccq3obgVcvV7quC8IcjfOUqKKlmyWZ75Um5FbUuGkwjHZnJ8UkzAuMbMT7lkINO8RricPoXsoawiYngeC+1fM+cXTUxvrVfoqxnnwmixDUc1hNQMJyq3zVUXq2/vFvnqhytVPFujQgiyBd/1Kdw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(1800799003)(186006)(53546011)(6506007)(1076003)(38100700002)(26005)(83380400001)(2906002)(5660300002)(8936002)(8676002)(44832011)(7416002)(478600001)(6666004)(86362001)(54906003)(6512007)(9686003)(6486002)(316002)(41300700001)(33716001)(6916009)(4326008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YQnOHAED9Wm1UfeiQtUg1AeE9Lgb9QnSWWe0zBd7U1P2driYqbGqciJ7+SP?=
 =?us-ascii?Q?9QDsHvJ4Pf4bA9JccNYm97n2jq1mf+IDvk9QIgjOj9sXoF7MDqMVaFcxUM7U?=
 =?us-ascii?Q?AP4lJdCoRGA3Ek1TVS9pgJgns5vY8RnXVIp5Zzsb5NJbGdwYvoL8vPeQRC2n?=
 =?us-ascii?Q?YNCXhfKGHJsVio9n5SXjntDU4Aejyn5Sar9f7YsqSQ9hViwIksKFVerwx43b?=
 =?us-ascii?Q?aegwFSNOXhs1ukblWZyrWdM6SrywVMtEC/gbkwdRGKFWMT91W/ei958WuPqw?=
 =?us-ascii?Q?oX8USRPp1qUKX7EP7ceGJhBfEhlYOcGjfsLHx3h2yV9YJcIOVpp8Ikyw38eM?=
 =?us-ascii?Q?eb64t3wdJezipN9vCLkXfcuqQlO5us6COW7FSOxo9HksxqsXco1mt0jeRfzu?=
 =?us-ascii?Q?6wrzbFvBKxDxZonxl47o2D0j/j/198npqsKoA9enrlQpiz1E+R9Hg5ClXEQD?=
 =?us-ascii?Q?UBzRFj9ABqG0XgiC13EiVRGapzGYyNhHzDeoRK2J//qGXxPsNBrPZPeMhzkk?=
 =?us-ascii?Q?fqyCA40nZ3qxwmXNFrYBRiu3SoWz58kt/JzYwa3ALONFD313/QKn/pFJ8qsg?=
 =?us-ascii?Q?boF2uDgQ8sUHhdzBSZh4zl8dzZ3+JmL9Mo3rQX4fb4oOg3UF8uSLYUjyR/pG?=
 =?us-ascii?Q?mQ/eoXSrXARr9KT+VyI1zefwmwIaajNF4IIYu2D8U+oCMEmtvnmEQ+8fVFE0?=
 =?us-ascii?Q?Z/FhA2j6h1BVbrri5thX6gMmPOJ2ii35IaoYtAh4ADun8XJ23lvQWiqGAhwc?=
 =?us-ascii?Q?rjiOkctChg8zKGzLwYLSIijHmkydSHOBNUtPZzR/St2S9zUOntEcmSJocnKt?=
 =?us-ascii?Q?6LD6NljDVC+eAa8a9c2Eg8RExEPn8QaELtgY2pwP849M32XkWnL9GEXMMdXN?=
 =?us-ascii?Q?OH3jQO8MHiNNsJudDpcjI3Y2ZLILIOZExuolc1zOepy2QF+/DD08UsjhLpSZ?=
 =?us-ascii?Q?8S/V+nu4YzXSNj/iTLyglM1F9Hhz8I0/b2D5ISZwa3aZaunCMDSer5+bjN+M?=
 =?us-ascii?Q?tN4Gz+UpaiBVrLOrkUsJ3ZAWny683RG4qCjLAVxEyJJwfKb6LUmIUuPnFt6K?=
 =?us-ascii?Q?UkOeo5mLQLXQV0SF9zm89pLyfEnR/FwD3ZXSU6FMxUIXWg2JaUDt/zXSCYpO?=
 =?us-ascii?Q?q2OZT5rFt0+MZf7Phq7BcpTpNF0ko3tJRK6eYCsE3BZUdpgZSsaFPOWq7hcw?=
 =?us-ascii?Q?eEBD1GyoJv6mZMvEJJcXlPeEfX7KSB+PLtFap0e6OrzmZIZ5KMrCFkhKmdwm?=
 =?us-ascii?Q?p777Y2rJnFCjyHzSjMWqzb54me4XyEazZ4+Ni6mpspZ2zuHTXDiGVwFLUy7M?=
 =?us-ascii?Q?05AuDw8S8dJHMDAoqUQe5TlgZmTPaIp8hMleSwTVwM51ABTJGjtrpyqmAt4f?=
 =?us-ascii?Q?I1JE0F/GBrmec2P+86CAtAonChO8NhCPA4Fmjs8QE6cNIwDJXCtatUfPPUEG?=
 =?us-ascii?Q?hymsQHwVG3R3A6h8m9RyEEpAU8QssXc/TJOBZWRTiNZSu3Nb8cv8pOXfCbsj?=
 =?us-ascii?Q?pA4tzMzoQdlMkgexinQ51xcHMrIScAoxfIr//PcFLd2HWxdpsZXRJXZYmwV8?=
 =?us-ascii?Q?rpk3aYYZClf3GB5V2hbpcuecu9WrgL2i1hFUgzh/pinKWhUqSWIjcvesKChh?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e31edb2-cc0d-42e3-2f5e-08db94dbfc38
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 11:14:35.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgioAPEe6Yws8W73jK98IYnfoqIaDrVQUNzQEIP7OCnoMi0bxQwNOQtBcaB6A5gNd2MLCkYNrSrhIfYD+Vtwlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:21:07PM -0300, Victor Nogueira wrote:
> On 01/08/2023 15:24, Vladimir Oltean wrote:
> > Check that the "Can only be attached as root qdisc" error message from
> > taprio is effective by attempting to attach it to a class of another
> > taprio qdisc. That operation should fail.
> > 
> > In the bug that was squashed by change "net/sched: taprio: try again to
> > report q->qdiscs[] to qdisc_leaf()", grafting a child taprio to a root
> > software taprio would be misinterpreted as a change() to the root
> > taprio. Catch this by looking at whether the base-time of the root
> > taprio has changed to follow the base-time of the child taprio,
> > something which should have absolutely never happened assuming correct
> > semantics.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> If I understood correctly, these tests depend on CONFIG_PTP_1588_CLOCK_MOCK.
> If that is the case, you should add it to the tdc
> config file (tools/testing/selftests/tc-testing/config).

Thanks, will do.
