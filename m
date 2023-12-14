Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC88131DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444249AbjLNNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572940AbjLNNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:41:32 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61208193;
        Thu, 14 Dec 2023 05:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT6DeRpY3VUgwwYXgb+jYgPXohRhH0rS2aVAUVybJPBUSXSqq0eQ+bt0ijVRMKaF1Wz2k53jBxFLK8O0SrlB1+KLCVJbYP8F6XUeTKqiR+Pd206TnNnYoDhwiK3TMj5tT9EZCY/Eba0qQipHc5dZpV86nRW5eW34cOQEljEyw08BvFifdViqOEfSisB9NEDwzdD4RnaOUcJEFUtZXFGIfkJ9rzNGjpZByDmusfzMSMgIPQMPK4c4+MjyLjUxDxLXQfnFuzkUHyaBO36YXgbDQDjBWvlQMLNV4jjMr/LjxH3ICrSuZyQYADBfXRnO4IZfpinsn/X2Nu2JTrTa1X7+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htEMtdBx9EiBkVLrbaOi1yaR593AHXsKEbBQ0hIGmyQ=;
 b=i+2Uqsc6O0CIEtSpZrgqYfrFaIr0KAIDeq1Mp91ZzClbF4Gkgz1l+9WEu1fe7rBxq9S49eJkJYjGtz21uweZ6+aaz/fl8+1U4mnX9aWHID6AUtj6MU2NZr9AHc4pmWuigRYZrGXaHI17BYRatmzFDrX+HhOgg85Sbgl0LMAfo0Z0J6j3K3XOPVw1jpJKwWKaKYUhD8IqPwN0T6tGMI5X2+fXmBrc55Tpn1fuGWWorXKG0P49KYmn5crATpkv1XNGUNyB4Ffw6FF0nbKAe6lugG8+Yrd3JgndunsXY/efyX+3GTyYcHD2NA9nETFRHMJFpFdal1jqfaP9PKRwNOGwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htEMtdBx9EiBkVLrbaOi1yaR593AHXsKEbBQ0hIGmyQ=;
 b=Buv4G6IrBwOpKJXePHqDjQwe4rdfvsxxB/zbr5McfJqDkGDawgbGU12B6ehBIF8t3ucVDwQxnE20N0qTe9+UxQaIEbuL2eIKppWGG5+H2LqqSK1VW7Kloe00FHpiRSmZDm4Wy1pBGOa4+lcM/dgeUqkQ273KkoXS5rzZpoPBTZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Thu, 14 Dec
 2023 13:41:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:41:35 +0000
Date:   Thu, 14 Dec 2023 15:41:31 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 05/11] net: ethernet: am65-cpsw: cleanup
 TAPRIO handling
Message-ID: <20231214134131.ecww24rt7socuplt@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-6-rogerq@kernel.org>
 <20231214112352.iaomw3apleewkdfz@skbuf>
 <0b437b72-d9ee-478c-a838-ff8c27ec05d5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b437b72-d9ee-478c-a838-ff8c27ec05d5@kernel.org>
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: c712181e-0aa2-4d66-31ff-08dbfcaa63e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2Ft9FCulE+mrjMdjKc81lcFLhGuUgJl37sWgFTJAUFY/ICoSMjYLpYOaZDTo3U0UtG2tldnOrkoCqcGESAaY7E5IZvbgvVQJl5oIMVF2zLru/CqdoCONDlnPKSQUSrUVzGVDhe0rbGSVa+JXfJFnisM16qLIr7jCDkck1y4ZFT08SB5NvJWHtMvupnVeUsp0CLaOu+TrQcUInBmugZmbOf5aPCLj3lHCWnTjpHONg6ocNBisyBwSWrWnhLPvlbRKUgSVbq+gNBjGLRtdEIME3+m+agUQKlj9vvebwdNTafYGtLC4+JqZxS3p7XU1NFyAA2f3vptw+xKk0h7y60g7wM2zN6CD4osd0CreJRi1eYqjY40jg42SUSh+mxmyTQIpc4u00abI6Txj9+sBO2fp13viyHg201IiTcEE7ojGxgEnktCcNeLLW2ox67OyAC3fHv9K2M31RvcFygg+yw9NLKO8aF8IjgPv2A9Sg26hyDEPwwx9d/Qj4iHiu4sE8gPF/LL/GidaNQYZYkjA8SvTEM3c2xdLERuX0KiPXN0AsVga/UfpW56C7ZfUaUSTfzi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(6916009)(316002)(66476007)(66556008)(478600001)(6512007)(6486002)(26005)(9686003)(1076003)(83380400001)(6506007)(6666004)(41300700001)(33716001)(86362001)(66946007)(2906002)(5660300002)(44832011)(7416002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNGc8zzTnxRq5WVpSPNsI6199zPuwPfSzt0F5A1jDgTMRq2sSNYiiWL3oqjm?=
 =?us-ascii?Q?4Dhrj/3Zwmnc819jwNiPuKjRmqEE2JOeYWYuJ4esD2nSd5JWjpcEdpbccM/p?=
 =?us-ascii?Q?6TDDUYOSYePnIeYbBwvBf8KDKxiE+WD/iKZzG26K6fy3sR+NaOJqYpdJFTAj?=
 =?us-ascii?Q?FB92z/T4xo8TN30dHm5sh2nk4tTb/2I5fo/eq4TaAoZDAl49kYAx1EM/HR3B?=
 =?us-ascii?Q?m++0XJqhp3GBnWrdKHRM2g/DGfZdekLDDgyWMP0srZOr8kSWU/XWJfvZkQm4?=
 =?us-ascii?Q?iKfN5ViUiQ3Gn3JQO/CBNTButVZskapeEonDnYLjBIp4GWfURtF37saj5vX5?=
 =?us-ascii?Q?ARZcVj1COVwJKKzc3yokAiyGelLgYwjU1XBRBokpVdywNllufHs9Co1GzqxM?=
 =?us-ascii?Q?45tWlU9xYrG29WyeJpQAu1Rgd5M2zMbsjyrY3d30CpBU3wGpa1XB/8Im69kK?=
 =?us-ascii?Q?Px+CMpPfCdO7IzhhjNEwTdqcdC6o7vqgholFzKjGuhc49BhVOy9VkZ++uW5W?=
 =?us-ascii?Q?4/lOS+azfLLya3X2nkL60F9syRQhL0XB4i0IE0IBXfzXq1Ni1V1beEzL4vLg?=
 =?us-ascii?Q?lmzXNEFsR+sj1e0N6xycDBmkL+OYwBuBI0tNyMO3651NZzMkn2KYw4G35SeE?=
 =?us-ascii?Q?wEPahj+Qmtxqi+kjpohAbJdVBFIY0G1yGenlFenPPshC3OTnkpjjH5jZNFX4?=
 =?us-ascii?Q?JG3ZYV5u7y2dTMv3rJ40ItxfwTDFwMY4dauilG6uvFSvcnitVs7BeZy4RyNj?=
 =?us-ascii?Q?6hml+tFoOXEidIGhKEWY/ngHu7cxvPe0CG1GgPdF5KHQgDtnpvIpm2OZeMGc?=
 =?us-ascii?Q?T8ypulyIQSZfMO4AHPkMdRITpdX+ZY++mBNQ2uA/oPPcW468ZIwS6s7YSP5j?=
 =?us-ascii?Q?KUAVTv+fYDf1Z9SVXXgVIXnBEkjzp0CKy/WUtbZQOGfGIqE5JTyH3+Es92W5?=
 =?us-ascii?Q?MmFbN6MWu4x463XibCkUj2ortfY5tILUroCuSuNuoTzxGj8ez6Hx7WwUalCZ?=
 =?us-ascii?Q?fN50ciohPlxnt8RSFADH7ak+TeWirHAClYFJ4RKOx6SXCS5+8f+3GA1JhAXH?=
 =?us-ascii?Q?CT6uY0929ddKB3A2pNPnVfCfUkGRUkYgPAby08/NZwIwDrg0oL4M4MjaMZLk?=
 =?us-ascii?Q?EE3/kXdDfeQFbgJbvGSl1g3TGs9c9g2akMOLQq/rbVyqtYPjGmTEXfexELQU?=
 =?us-ascii?Q?J61gOmyyjvVf/4hJrDK9W2nMwXyRn7pQcl8jXlJo8uVURQjhCPwk+fVR3ohw?=
 =?us-ascii?Q?EdaW6ZEkR2ipitualKy2y4MFa13VPmdELW4sr58nrlE2r8Up/vXeSqjQKD01?=
 =?us-ascii?Q?pZrSOLf0fL/MmXSZQQdntyAIs4LzcE4tvyJbnDjE49y2Spi7EwXKkTO7wXaF?=
 =?us-ascii?Q?Nqnhz45itQ7OywQAxAIJKXSyxCgp8BjovCcqwf0wfLMEOc+x/59KU+dLdo5N?=
 =?us-ascii?Q?VRoO7sx2xUaYKVOwotQmdQkmB35DjFhPsoK95396nzPWXU4wUPJ+/47uZzJY?=
 =?us-ascii?Q?PiSviJ66kCH8Esyx4KBz8sihcteXpAoVMaC4ZW6jVuV0awMRPd36vzj5owIR?=
 =?us-ascii?Q?aVmGSHixmJqJegEtQ4+G7tOX5wkQeu0M5kcBHDlmqU8i0RrwOM3hTHmXPoyY?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c712181e-0aa2-4d66-31ff-08dbfcaa63e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:41:35.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Mx43msdQ5kvfxXED74wyNWei69VjUHaUtw+Wtqhm0Xn8lSu6GqgBkZUQ51H2eIl8QZcGkaYo7x9psahLUH8TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:36:57PM +0200, Roger Quadros wrote:
> Actually, this code is already present upstream. I'm only moving it around
> in this patch.
> 
> Based on the error message and looking at am65_cpsw_est_check_scheds() and
> am65_cpsw_est_set_sched_list() which is called later in am65_cpsw_taprio_replace(),
> both of which eventually call am65_est_cmd_ns_to_cnt() which expects valid link_speed,
> my understanding is that the author intended to have a valid link_speed before
> proceeding further.
> 
> Although it seems netif_running() check isn't enough to have valid link_speed
> as the link could still be down even if the netif is brought up.
> 
> Another gap is that in am65_cpsw_est_link_up(), if link was down for more than 1 second
> it just abruptly calls am65_cpsw_taprio_destroy().
> 
> So I think we need to do the following to improve taprio support in this driver:
> 1) accept taprio schedule irrespective of netif/link_speed status
> 2) call pm_runtime_get()/put() before any device access regardless of netif/link_speed state
> 3) on link_up when if have valid link_speed and taprio_schedule, apply it.
> 4) on link_down, destroy the taprio schedule form the controller.
> 
> But my concern is, this is a decent amount of work and I don't want to delay this series.
> My original subject of this patch series was mpqrio/frame-preemption/coalescing. ;)
> 
> Can we please defer taprio enhancement to a separate series? Thanks!

Ok, sounds fair to have some further taprio clean-up scheduled for later.
I would also add taprio_offload_get() to the list of improvements that
could be made.
