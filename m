Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0B813226
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573247AbjLNNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573249AbjLNNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:50:41 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E70111;
        Thu, 14 Dec 2023 05:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzVV9evaF3UukAZ/uj0N04K48UnMRAiHSU3fW9pqkgo9GiSO3SjwxmhHgO0UAKCAmKoQT15AXxelftv53UI+iZWpzLgQBWQ0+W+yZKmI3KLvIZfbUG8oAYk0fyOzFCrQaGhgnqvrgulKGm6HB9I5x8E2yTPBXTgW7uSzhAYbW9EpG0GAqKPwegObpn4JuJbwbpeE0kMO99P+JwOILwQS1+hnLfSIfqpDEiMAdGiUuBdF164VpPLcHzf8bmN3v8EG6tk73cPtxTThd18Nkj1Xbq4Fr9QqYEPqGiYK4+MyIJBcD9ZUi03DzeRKmijEqSuYOFnHkV/SFpiRkDs28cIquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+ruLHmTerFCZmlpr8FvL2HxouY/xwQbgo9JiMiqY1s=;
 b=Iz89K/sL+QPuA8RpcDZHFmtG+WQTWHkwJlFG59zMJHevcOC7zNtzEE4F3p00Cw1Foy87RsEkF1r9UTj2qOFeUvLqR8lh3AZ9Q2RujYb6ZjLIe/uczh8Z+LIA8uJAfvK3QVaty2Dav5jHLeWUPY3gSpj9bcH9XZKUo+/K8nJmgRxv0Ob3VoTmlmoZVzl0vmJceLiINfsO7GCxmzzbNmOOGoIpyRyYBGUfxb9Nqvc8ClK61OtEnkiRbDr47jhRo4uGUAOEIkaqhH8t+emeCXPtQ43rBAHP97xltA5WADIwTI9TnlULyXj02VPwNTa5QjeGD51In6d/iENFsRoGtJM3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ruLHmTerFCZmlpr8FvL2HxouY/xwQbgo9JiMiqY1s=;
 b=hhItrqZsEOYiNWa1EKBCAA06N95Wd2cf43BjyD63arDPfnB8FSdZOoJuGd89bG5R1xhRMrul3ofhlmAxJ0SIf78+iN7K2POGgXfdSzrLaA77HcSi/WtqDdBGfsT8ogtp10ImhT+c90Iv4dR9B7j6WrsNGMLIW71w6ojP6PhaycY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8758.eurprd04.prod.outlook.com (2603:10a6:10:2e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:50:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:50:43 +0000
Date:   Thu, 14 Dec 2023 15:50:39 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 09/11] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231214135039.6lcixyy7z6u56zgv@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-10-rogerq@kernel.org>
 <20231214110448.lycg7yusrusbd7w2@skbuf>
 <c08814cb-86b6-44bb-8682-00a5b6a0c0bc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08814cb-86b6-44bb-8682-00a5b6a0c0bc@kernel.org>
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: fa70c1b9-fde5-464e-cf4f-08dbfcabaa9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbUQcfopSBUm5kjuZhP8vQ1jDAJGIbkmiVkoocXZOE3svWwbmydl7Vvj6t5+BuHLiZtFNDIB7n+PX9PMwiHo5mgAJUhlR19qOzKDWbjLTedLdV6H2+poHySDE4NVbvfrUE9VY2KtU1J4kjyiiXN/G5PzTyJ4Hs8mn7uubbbplKnHiIY3X69Z1eTS0rXRhTdLgu89SEDZ1O0cZyfSqlpCF2YgXdZ3iIYKZxuzuuhxcX01Tnft5f7CSMfHxqJslUJfpA5PW4a2tKcZ2904FESVuBgpsgOczUv0+ITbmJcNu2qI7nYTOAlUpLNMs3azmFhGpt4HBdKzFRoSNSocmyNy3F4B4NCR68030uy/+rXXRG92UiaMw6pkkujgJc6E6Qr1iNOhAqTzJBj3ubIvowtICOr+NhfU/SegFWUu1Juz5A9M3f7bT40Tb/FjcEb2b6YzQ16TzAqV0r6LRhPcjcDzLTB0yhkBBDE7IdlD1GFk6I0tvR/NyhfcFVqXEMNTwrE7DU7Y8GyT/cqfc8LXW5nl3vYyAiuLvbJXyRL3AqKchr8IbknFi1uReTEV3Pxi6j1D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(1076003)(26005)(83380400001)(86362001)(53546011)(6486002)(478600001)(6512007)(6666004)(6506007)(9686003)(66946007)(66556008)(6916009)(316002)(66476007)(8676002)(4326008)(44832011)(8936002)(2906002)(4744005)(7416002)(5660300002)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MiGWjI7xea/K6k111SCLyZ3MNqe1iBTSQN/2/tq8wmG/fPFOCOfuwuv/uBg4?=
 =?us-ascii?Q?IXxOPlUQ1n8jH1A51r4/Rqmel9WuO9ZUTZMpPSmUjX+4mRJGzGKiDnzR2+V8?=
 =?us-ascii?Q?td/6BeifO0ztv9XesuxN01TUNRrI4ySjwK5pOMkSdEmhsJhar6PcGMe1iGfV?=
 =?us-ascii?Q?CptZNJzCsBASgy7qQ1nGrUjPbjvvxxecZscUL7T8emhuf0cShTn9MY9Rf5o+?=
 =?us-ascii?Q?IT3vkFaxSxfbXOSo7Bvm16+/DnKoPGHIM+8EjiFmEQj8txLdcdkVtI+5KPfU?=
 =?us-ascii?Q?GdpdZ1lMCk9Q29e46pSau/JJv26OGD8AZnEzADjsXb5SoxbkaoiGqpx+u3ux?=
 =?us-ascii?Q?CNEfTiSUJ3x5wKeSHQAEo+8JDlwa4xI6174CJ4vGVXz4ThmlBkmCND2H6VSs?=
 =?us-ascii?Q?Fn7Cc47four6AFLvU89NcMegLDrvP00EaeDMaQHzfUp11Leowcv+dpxQlygq?=
 =?us-ascii?Q?izFfoI4QQgrd8uTQvTWDDhQgruD6kzF4gQCX00dIEOfMg7yqAQ9I/k85jciH?=
 =?us-ascii?Q?iNSOrfOIU3gM7JXNVY8KV5+a0ohMgDtOv/0HhSIHK5LjTMvvCI2HvNbM1B44?=
 =?us-ascii?Q?RHXbduncf7yHJFhOUtQ6f2ofK8pZ9/MCmKUpcUW/CPg97jDdSe+l0HBuOVqU?=
 =?us-ascii?Q?Arqrn47Torj1buBMBwis7URYpBnCH4InFXQI05b6BvmX6+mnmDPbL/rCXDzA?=
 =?us-ascii?Q?TGk4UEq1vEK6NZ/+DQSwD8PxSEoZaFkoj82ndMxP+xllAYG6OOzLFoMRKjeT?=
 =?us-ascii?Q?3i2MAlURcBz6ZqjmYCpUCjJ6mn69ilD9QN7Hj2JbIHQ521bACtMxVB215vfr?=
 =?us-ascii?Q?zrjq2BFRm7zfzHluSZqpaL9yQLrgG7NCeMD0tSGQie1pbFS7pcPoeAx7fQwN?=
 =?us-ascii?Q?kLmy5al6rPjZHXSWd7coRXiqW7JkPaJVAntWnAxRPoKk2VvEpz+pTDbJpxuS?=
 =?us-ascii?Q?sxMqNctfQKd57qkI61eliU+61F519crVv7DEfccfeGKd1a9i6I+POS01whcI?=
 =?us-ascii?Q?EOi0POgax915LBEYUuRHw8Rs7P2/V1qTXWWWWRBNw1pQI5MIvPK08h2slwwO?=
 =?us-ascii?Q?v6pcaga2WAWYoY2ZZEQ5/x9iybb6sVAnC3t/3OZtls7j6GDXWQlCkQ8EjWiH?=
 =?us-ascii?Q?QcYK9sT6itQLpVdIaakLLirfoaL227x27AZremWn4Xrciw9praLit3tzA2lQ?=
 =?us-ascii?Q?mSOjUBC5DQ4mKnmYeVXBaSz73ySfNwUz+TocOYrHVk7eZvW7ISk2NPf4cu9m?=
 =?us-ascii?Q?SW2ZpgBZ9TDDn8ZDifsXkPwpBH6Nhfe8VJFZxHEGA9OoNicttiiO63stp4xY?=
 =?us-ascii?Q?FqhtANYjeHJwL3bPlT8/Br4m4i6dz+5nKAGH5oHL8AOOYrxpdIG9DiKviQ2e?=
 =?us-ascii?Q?EnbvCoskUj+KaNy6gZgkZsGfzvwCSGHKHACRW2pY5mLaXELg+7ymQJqfEJW2?=
 =?us-ascii?Q?lqm7VwR78fck/9I1JIJUPrT458uoXEBYTB8LD443F9ZSuElX3eQpCwJWDUn+?=
 =?us-ascii?Q?EnkQWCk4DO6cym9o7Gg3Mexp7KkXO1rpMGO0Tv/fZ3sg0T7akpw/N+OgXOuC?=
 =?us-ascii?Q?U6hcM9i3QmI4tJN8UDXXChTNP57jpmU2tXDVnSkxnKWFSKYadEgARJmqUZKe?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa70c1b9-fde5-464e-cf4f-08dbfcabaa9c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:50:43.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1R7GK/w9OXFADUxvssgEHYN6kMsGb5zuoeVOkVUfnhlMlMbLoNDtOsX2+zA1rqubu+JWzRC0Ypu+2AHYHVOn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:44:03PM +0200, Roger Quadros wrote:
> On 14/12/2023 13:04, Vladimir Oltean wrote:
> >> +	/* verify_timeout_count can only be set at valid link */
> >> +	if (cfg->verify_time > 0)
> >> +		port->qos.iet.verify_time_ms = cfg->verify_time;
> >> +	else
> >> +		port->qos.iet.verify_time_ms = 10;
> > 
> > I don't think I understand what the check is for? The netlink policy for
> > ETHTOOL_A_MM_VERIFY_TIME limits the range between 1 ms and 128 ms.
> > How can it be 0?
> 
> I didn't check ETHTOOL_A_MM_VERIFY_TIME before.

Not even when the exact same policy was rejecting the verify-time set by
LLDP in v6, for being larger than the upper limit of 128 ms? :-/
