Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3175376BA01
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjHAQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHAQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:53:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A12114;
        Tue,  1 Aug 2023 09:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ/DEVNraQyf+RLWomRh2UFAssdI+2B8g5euZzAwVE/4NyA0LmDohEQdni1kvCn1PUQotFJzhXFKeTc5pZEW3n+3c+9J8cEDLJ2G+nyc/A6jgUlzPn+T87JpVuHGwy2s9tYCoaGvk3aJBkNVrWZhs7PzWhmSSmjP84ZX7Uwk7xlYA2XKihif4dbUWhgz2ouG9Z9lufrgAQK6Mukz+0pZ5gATKTA6qvVLNcSXaCpecVIxd0ROUqFOgF+pUNqfvGrZf3Hx4lWIp9FIXBhXCojBRc2G0Tz0b1+lYr7oMV00ZFF7ieIMIN5oyUL3/S0I7oaiGpZjQzcx6nrZHYVRPUD50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKQUs0KNzJVUD2HOAXcz/OwWukfqP5igzI7Fqy9VsF8=;
 b=Wy1OFjWv2zzlcyDsNCH2Uho66QQLcpsfUIxZrPRXhFr6yBMZkGnzdo+CPlcbyKGXulQrtf5phU4FZ0OwDVNtiz6Vzw591mI2dtjq4ixu5lXF1MChcRtq1EdJiLS3vQ6VVetdVw17jvwkpskk/BI2r9kTpa1gye1xsQxEt5C58ZPFIS5lsfvGjliP/KhV14cxHhjjrrptv0I0bG6zxOTF16/9n1FBjGjmeHQNmAXLm8gf6BqilcIJmWKvOgIhlProbvl8fAbR6ymrgDvxeE1ZA6GG8ChM5owIoS9tNKkKKXd14cSnyg2DVDEQkBTVHHZ9RURAsFRwc9/5o5n0Y6ouzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKQUs0KNzJVUD2HOAXcz/OwWukfqP5igzI7Fqy9VsF8=;
 b=Dt5ItyPK6qLg3u72OrwR0/cIogRcylYAtalyGYMBprZKREWKI08Tm5Rdh8HHaVmGN6J8TjLBkvYBx/0IqDmqs98MXj+MSQqnUWEezeUFkVzGAmJq97TClJK58DF0QgpqAinUBKYg/kJtyeJPeVf+T9MFW/+C5ZQo89V4PNVF2HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 16:53:51 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::ceae:2c83:659e:a891]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::ceae:2c83:659e:a891%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 16:53:51 +0000
Date:   Tue, 1 Aug 2023 19:53:44 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Pedro Tammela <pctammela@mojatatu.com>
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
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v2 net-next 9/9] selftests/tc-testing: verify that a
 qdisc can be grafted onto a taprio class
Message-ID: <20230801165344.3rtleamaqxr2g27k@skbuf>
References: <20230613215440.2465708-1-vladimir.oltean@nxp.com>
 <20230613215440.2465708-10-vladimir.oltean@nxp.com>
 <02c5d2f3-225f-fd56-6540-00a80326d07f@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c5d2f3-225f-fd56-6540-00a80326d07f@mojatatu.com>
X-ClientProxiedBy: PA7P264CA0085.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::11) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|VE1PR04MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: a098c188-531d-4555-3546-08db92afe079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJ8aY9/gqbK7OkyxsIQlNWsuQL/DWIeIGEv+vTaJPg48ZpXdj0nOCxSEhlB6C13sXAMLqXDlMfAQS7ZxeFDc1N6pG4e1qjjNdK6GvgHQi0BFjSoDrh398/qcFKQoScZ4HykO7xlc51+hMLJSXWbyV82MXJ6nQVqOnh1N45vkePOUSnLbSAvyFTLf6QqirKvEMKjcMKy9OcqSBZmhwhiSWNNrKa3uOAkNsBqRq0aonqdE1BkCpBbxckPm+sYr5iagU70ZEJUQVTefEc/ZbBNiFmgNuoQXrUHrci6PCPamNzMnNSDOlQW6yUvz5HCdqOiSAnLMZgZ7Bq0YWlFgyqe8mdLExxMH/sD+5yq9cVLGFuf2GgQo0dWciQ5EVeVyiGF175W3Mh3QHI/chQwpl6/5ExtRoEalQk164xg+M2YjNNT/uJFhV8ypGQpldc19GlgeOUtpoL49kqzErTddjkBCQSqAs2Qg8s+eOShOeHrsORgX31KggV4GVjD8Z7SrIHd1fF3dddwUKqggNyGOgqZMJiTT7oOgXwb39RkCgfPekxLzOWtqGYBOw3IIgZvP4Zsx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(8676002)(33716001)(8936002)(38100700002)(86362001)(26005)(41300700001)(15650500001)(4744005)(2906002)(83380400001)(6506007)(1076003)(44832011)(186003)(5660300002)(7416002)(6916009)(4326008)(66476007)(66556008)(66946007)(6512007)(9686003)(54906003)(6666004)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpIp6aoGO1L1E8gom1KFshFTBzYvxqqp8cK8hzkVNfLHte2GG2Ugpe8IfG/9?=
 =?us-ascii?Q?IrTdaRwPoqqOj4Aj2XoDdBEZ2TgyfcydosAig3jIWL4uh0VeAJtnl3iBY1lC?=
 =?us-ascii?Q?GTc+Sh5zjYSwsuTVpV3zktRjZqANsyPRot+Qe9KWvIxJYW0gZMTVJ7C/8XtL?=
 =?us-ascii?Q?3DsDjERqRebOVveMVl9YvMt6k1SFAlf9ljjlC1rQ6DK4bKToq0tHMypIJ/l4?=
 =?us-ascii?Q?YUhb6nJ+h2GUOkpcNJJnG0XBjvvCvEmuomD3qDd2kL4txdhSnPDWONRk1W47?=
 =?us-ascii?Q?r+q+9B5w4V35ue+bWIodbsxQQ6vXe1XQifh4k0dRoWfCG8hCADBdWg3CNWzO?=
 =?us-ascii?Q?rSqG4WYkhCTIGXDCm2S5Mrm53tyrDt+BbAodugb/PnWwIfx+OKQjxSABkqFd?=
 =?us-ascii?Q?E2lRIXbzX8Vkgq1EZJN8X3ICHsAL0nEYwiiYVYM6PspxY01Thy5XZzDEQXHI?=
 =?us-ascii?Q?72nyT386aqQzWvGYxKwymhqhO2P5dUtYohwd3Qog7SityZc3/BnortrPI7uI?=
 =?us-ascii?Q?0e4LpWEJPiA2XooZi/Ld1IoRWBIpiAFkEjAWshfKgPBU5NLGaM2OTKTnDIc1?=
 =?us-ascii?Q?CAYhCUl4G6AL89w+jlIxK5ixzTNK9CirRpWM0dXuJMEzouKJ8jGTUe3DpWzj?=
 =?us-ascii?Q?O8PFsFXmcMvY4728mpt054/S9eRbUkVN95ivLOvYJc26yJ7jfJV1Rrux0sA/?=
 =?us-ascii?Q?ST86ckBXuzIz2f4N2CGmsVhFGuhHydPWBp+kHrGyjI1N0Jm21FCp1+FI+kys?=
 =?us-ascii?Q?G58LbyfH1cOeao88rcDNN2ON0EC+QeXQXdGbt/71FSQAiHolw9ySkCu/yMmX?=
 =?us-ascii?Q?KUR1YNJNEuRQdIuQyILx3591FWYZ1eBTgtzTzN0DDuWhhWh64paLjtpzb2qF?=
 =?us-ascii?Q?ocbooVzBlfNqPCqd5bWL/u7vi+h9a4mHQ0Q2dnRR0asEMiPvWXlZbWlSxoeX?=
 =?us-ascii?Q?0d9druW7IR0R75q9nUl3adJoebl1GVSC3DsB6ctWlXDH3Zvj4hG81/CWJdNg?=
 =?us-ascii?Q?AgKq9SX+6AbKusEEzhuBIy6xPE/h0OG5J3/KeLSQMTLvjKgFNH2xZqmkxYGC?=
 =?us-ascii?Q?+3v9JoMHgnEDYTz11n0ys7zCSl/eCyOZ2QJCfM9SW3Jq9KDXvth6Zu1tb33V?=
 =?us-ascii?Q?mKEA9a49d+OBo9YCHX/tXKxOBfXqQ4woo94sgGSIPcx0E4ID188iA8el19VT?=
 =?us-ascii?Q?dbCLv5K+SZhQekes4H9T0K5BhhAaq/xBRxLW/IBimGY9LGPm5XNz1YfAGLfY?=
 =?us-ascii?Q?YmlgmniiArnNwI8wIDVlwXGcdwMgKz8zpDmQqpgLW1H8uZr2g31/nsd87uLf?=
 =?us-ascii?Q?twJQxhcJY8AmG9g4yuPB7V8BuAWNqdUNtcafGx2qI3u6OkL60LvwtlaO1feR?=
 =?us-ascii?Q?r3vyqZljdnVIlqbXV7MhSYvNMzkilvyJhbmeJ+A3H3fOb0IvGaGzs5uQ0PBX?=
 =?us-ascii?Q?3j7DVQpoB+7UIRPkAGzeMjtlAUi9vAFaDugGgdHUeZRDDwRCSpX6t+50Y47O?=
 =?us-ascii?Q?9XJVaebKzHaQfy5TKa+m6vT9N34GqekS6zyIJYGYoGx7HxiW//p5W15sZKL0?=
 =?us-ascii?Q?gveccAssSaDnFkgJjsa5QnY0s1pMUkhg25B/YqJfXkTgMZsqfAgaT1s61khs?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a098c188-531d-4555-3546-08db92afe079
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 16:53:51.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOSLV3IWPCQxeGczcZCSpL+7t6q83XCRPRLChzaQnuKbpaTZ3bSOdgtmmgcVT9ssNFzjeGIKAnIpd9FTdovObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:45:42PM -0300, Pedro Tammela wrote:
> > +        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 8002: parent 8001:8 cbs idleslope 20000 sendslope -980000 hicredit 30 locredit -1470",
> > +        "expExitCode": "0",
> > +        "verifyCmd": "$TC -d qdisc show dev $ETH",
> > +        "matchPattern": "qdisc cbs 8002: parent 8001:8 hicredit 30 locredit -1470 sendslope -980000 idleslope 20000 offload 0",
> 
> Seems like this test is missing the 'refcnt 2' in the match pattern

Makes sense. This is consistent with the idea of my patch set, which is
that in offloaded taprio mode, each child Qdisc has a refcount elevated
by the fact that it's attached to a netdev TX queue (hence the 2 here).
I had copied this expected output from the "Graft cbs as child of software
taprio" test a7bf (not sure why I didn't catch the failure), but there,
the expected refcount of child Qdiscs is 1 (and thus, not shown).
