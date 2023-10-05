Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B57BA52D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbjJEQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbjJEQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:20 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75139199;
        Thu,  5 Oct 2023 02:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crtdKQbdGHE90CJMVczYAOXGLNFrQYLScCtayQj5Grzfd1O0odsvKxA/OnbTWyQ8d17wIyfo6rg5QHttI36gYYODfjswa2qkHtlkyI7JyjLvltVNJ27+LKI5xA/KjWvojw7661h0YWzLjHyEm63+B7KJaM+8bETQHt8LSPNSZ3GwBbB6LdWZxGveqH8VbAKK+tbmv4HNzZ3hxpTCJKOg5M0ZXJxe2jlecGK7AXCO9QoEV00r90J5ShmACUWa99gHTkUD0dBBEa5F1pXIg0N1OcQjqaWT5jAJIYXLgTk/zIzUU9vYTDQtmKkDz7assNLvhqr3n3qXmTrbw20rrXPAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNgPhoMWbao0T2n8TbW+P72iU63JXQ1U4WnWaG3PLDk=;
 b=CFUoj3/+LPwiA+pkuqAOS8f9iULilUNsQrebSYyISXkNPpiIQtGF1wlvof8MPmZBDTOQL+/wSewW4nh80QXJFxjblV/f+zNDQpO4RSoKj1NdZJJgERMD7LNNHcg7C6KSJeOSWWC+awA5No/WIhol+Rq1kJA9zxW8m+ODKjLz43wUmE4OSQTMTwJP0Ej/oO/MExka9ZoPfhehkUpTo0aH/bFdsjkP7X2leZgWhUb31UHAnhGph3AO4ps/sejfpNjiz3ZUJLHDn5Z5X6UcGg/gZJwKGzkSqZLXnr4EUfXNCWHx9AGe21B/ghiKUzKJIoFbbgvI6MQ63RwW1Kkx3/R9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNgPhoMWbao0T2n8TbW+P72iU63JXQ1U4WnWaG3PLDk=;
 b=Rj7c0j+WOW2hVotZVoGwnZ90dtQ21RAhMRH3c80rAORtM0oAv20tF63c8JyCATCjtMvKgHPzsSmj4MU06WgRmM5BY2+XHhMpFAC5xY18CAcd/z0I29sgOn4jhS+R7kJvrIzbLkb/QkV0pyTarTK3lCOrksUjU5H8DFqt/r79lKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 5 Oct
 2023 09:29:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 09:29:46 +0000
Date:   Thu, 5 Oct 2023 12:29:43 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 3/4] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231005092943.q7no33k32thyo6y4@skbuf>
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-4-rogerq@kernel.org>
 <20230927072741.21221-4-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927072741.21221-4-rogerq@kernel.org>
 <20230927072741.21221-4-rogerq@kernel.org>
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: cda1fa45-3945-4b8c-71d4-08dbc5859d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWf/xr0I30Y3YptoNQgcxiavpmQ421IJ5+FZoIoP7QRP25femhWiX35L96W/0ccYkiI3VZvzTokqTS7mvSHMwuJ+FAtP5iLzbyIS4uHGfkBtv19G3/Tg+Cf7Zs6CsJsbSxbBzmWfzfXErtZoE8Oawt1UNNLyS37aKf/cPT/oWoZ2kSqvsKsHe/JLDirQ3KqRSALirX5uhmryNfzAJb1BDtqDmTxFPIICrVdTcaw2BX93rXq8oS6xoO5w8rwR0SH2ffN94zx5y0oPEUL98r7mdzAjEb2/T4446GJGkG85PqD/lk3rj5Nz4Ud8JZ7qxeekIvvtMNi6i2KjOgz+bxaf9L9vMb49q3OHObqB2mP84j5+ij0Q1hmhHg0hYlO7C4X0dXF3KMSy9IFhSGlluU4FHTFLH4cMbl3R6d9o/Fa2oXakxZDXQNngqnSD0ljaQqa/oTN6KKmz+ZVXJkDn/aQtWCusvMqxnMN29SOvZorOvMsT4VW+Zii+JiIhYhLmxP9rySDB77o/IwJzcq+xTtsGv2CSAHATPqOjaAgscdZuY9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(1076003)(26005)(9686003)(6512007)(2906002)(33716001)(86362001)(38100700002)(66946007)(66476007)(66556008)(83380400001)(478600001)(5660300002)(44832011)(41300700001)(6916009)(316002)(966005)(6486002)(4326008)(8676002)(8936002)(6506007)(7416002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzMwTm80YkNLSXhRRGRvbk5FYnFQWmhubmEra0k2Vk9FeGtmbHNjWm9jZ1pJ?=
 =?utf-8?B?ZmRySWw0bTIxVmN5MWZWSTc3SVB2R1FLaTE4OVh5ZmlMdjVySVRYQ25zKzRx?=
 =?utf-8?B?THlDcHE5c2o2TThhOEE2NGd0UmRiUVJ4K0o3WjRobThQQmIxS1dqcFVsNDlX?=
 =?utf-8?B?SkFvdHRoMTFRQ2k0K0lodDl0U3FXNWVGLzQ4QmhuOU9MVjZudDNubDV2aGxV?=
 =?utf-8?B?TW1WeDlTd0gxcVNTdXROblBFSVR2M09LRmhicnlRcjFrZ3diWm5JUWs1V3ZT?=
 =?utf-8?B?ZlNHVzRWdXh2cHNQdzBCVC8yNTk4UWFNUUtYeGdqdkpia0pROVV1WkpndE9B?=
 =?utf-8?B?aEJ4N3JwN3kxdVlPdE12b0tWb3QwQWVBWXdZQTdpTkw1b0REUndGR3hhWXBu?=
 =?utf-8?B?RC9ZdlpTOHR1eE5FQXJGMUhUZExqNjJwdkpyM28ya1ZkMWdwT3VobTBSQk04?=
 =?utf-8?B?empySkNNelpiUUxoQzF4TjNDWFVEVE85OCs0ZkgwUjNTdUJlQXFBKzZzL01D?=
 =?utf-8?B?eS9mS21WeU5hd25QTWdjM1ZYUVZabFYzWHhQWm5NMUhrcHdnMjMrY3JXNDF4?=
 =?utf-8?B?R1p1MkNHTTlpa0pUbHNKZ0xsZGxLdkZpZm12dU5tYmpCQnFlTnR6bFJ1bTdv?=
 =?utf-8?B?U0xYSm9CK1RHa0lmQVlMSFRUdjJLb1NYTVBPS2s4a3JXYlpiTEltOEdhdzRX?=
 =?utf-8?B?TWdvcnljWnlNeXh3ZXpzMm1iVjZoQVZPUElaQmJ3OGZSVzZOa0kzUldCYS9x?=
 =?utf-8?B?WnVMWE51TVNKamdoQ2RoM0lnMkFOWkh3Y0FKVjRla0gybVZ0L3pzckU5aytI?=
 =?utf-8?B?WnRTTHROSGttT0tFQ05iNHJKdWVzZ3hVcGdqb2NneGxCQjdQbnVUK09TM3pD?=
 =?utf-8?B?RXVJcmhVLzVWWFNILzF0d2swUnRVWEVzcTA4MnYzTkppOThKSGIvdjY2MDFp?=
 =?utf-8?B?L0tzL09VZ2htdnNmS0tMYkdYWHdZejF4Tm1PQzdqTkxrNG5raGNMK1REbUdt?=
 =?utf-8?B?ZVNaRVRwa25rSm5aTktRN3d4NkM3bEhwTzVoOUtnZmVnZDN2K1g3UmxBQnVW?=
 =?utf-8?B?MkVkWGNTdk9XN2tJbnNTc1dMb1ppUS93cE5PaGNXSStPam9wZnNHNVFvOFV0?=
 =?utf-8?B?aWVBcG5BcXVQUDcrRU5raGtVU1I1bHdIQlBOM0pFS25BaVJXa3VpYzU0WHJ6?=
 =?utf-8?B?dXFLK1RheVlaUVdta0E4b3lGeU5QY3gwWS9tbzF0RitCMmNGQzhDNVo5Wmp1?=
 =?utf-8?B?SVo1SDNNVUxTN1ZnUUg2bDFKSERkbm95Qi81ODVWUmF5bTRSeGtRREV6am40?=
 =?utf-8?B?dkVTNXl2VVVZeTY0S0p6N09JZDZOU2lqUXpkSllSQWxNbFEyYzc4RVRwbFZo?=
 =?utf-8?B?dDFvcjJ3c1pKZE1BZGR3bUZZRE9oRVRoeWFXckFoaTlOMTRuMC9kRVY2R21J?=
 =?utf-8?B?NFJOYUxWUVgxajZseFhFb2xzVXZ3VEJlbmlENEsyUjdETXMyTVVic2FkOFQy?=
 =?utf-8?B?UzZDcVVRSGdwU1phc3Z6QWhOdWExeFlFMGVqY1U5bU12YXZTTFpsZ3pwQVlR?=
 =?utf-8?B?U0QwS3RBdUQ1YlJId0F3UXJPMVV5cGc0Z2FuL2Z3SmFKUmkzUmRsQWc1MGtY?=
 =?utf-8?B?dHlSbXVqa3UycW5MUkRlbzkrNi9Fb1dQU2t6anB6WGJGTisxYStaNkZLRDk5?=
 =?utf-8?B?Y0JHa1hBMXE3WlE2TmZ1U3IyblVvdDdvT3ZuWXRCWVlzTlVETWg5US84bXpl?=
 =?utf-8?B?K0lHSHl2aWU0bldNTEJnRjdZWk9DK2FxaUVSY0NYdlVLajR1dzIyUWRjWUgv?=
 =?utf-8?B?eEZJdVlRVTF2MkN0eVF2Y0Z3Rk0rRFhlMktTNE9pNldvYnZ0VGdsZFIyRVNX?=
 =?utf-8?B?a3N4aDlVZUJYazB2djBXUHZDTEhzYkFvRm5CQ1NhUE1CYStaSFo0UFlBM3FY?=
 =?utf-8?B?MkFzM1ZWdllmYWpFYnNNTk9TZzJXc2ZCSUdtNTQvUk5KeE1STHd1dncrZGZW?=
 =?utf-8?B?ejJrVW4zK3hqalRPdkxCd0NvSFJzWUJ6TW9KMHhXZHljQ1RmMVNsZzAxRi9t?=
 =?utf-8?B?TmJpaUg5ODVzZy9OcmFXN0VpU0I1Z1MxZGRkYXpKRHBmZkYxcXp3YXpqQk9z?=
 =?utf-8?B?L2tBRjJsbzJSZFVUMC9PVjZsMjE2czBBdzkzdHg3bm1JaVVKMmtoMFdFYlRM?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda1fa45-3945-4b8c-71d4-08dbc5859d34
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 09:29:46.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOCEkdeH7CBp0vtRvNy3QTXSQPijWPP1n6fka7GXKLYFX7GQUwNo+dYRZvduLL8lNprdp3WM9QTw/7irsKd37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:27:40AM +0300, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
> 
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
> 
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
> 
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> 
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>  5 files changed, 454 insertions(+), 47 deletions(-)
> 
> Changelog:
> v5:
> - No change
> 
> v4:
> - Rebase and include in the same series as mqprio support.
> 
> v3:
> - Rebase on top of v6.6-rc1 and mqprio support [1]
> - Support ethtool_ops :: get_mm_stats()
> - drop unused variables cmn_ctrl and verify_cnt
> - make am65_cpsw_iet_link_state_update() and
>   am65_cpsw_iet_change_preemptible_tcs() static
> 
> [1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/
> 
> v2:
> - Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
>   and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
> - Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
>   AM65_CPSW_PN_CTL_IET_PORT_EN set.
> - Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>   1G link if link is inactive.
> - resize the RX FIFO based on pmac_enabled, not tx_enabled.
> 
> Test Procedure:
> 
> - 2 EVMs with AM65-CPSW network port connected to each other
> - Run iet-setup-mqprio.sh on both
> 
> #!/bin/sh
> #iet-setup-mqprio.sh
> 
> ifconfig eth0 down
> ifconfig eth1 down
> ethtool -L eth0 tx 4
> ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on verify-time 10 tx-min-frag-size 124
> ifconfig eth0 up
> sleep 10
> 
> tc qdisc add dev eth0 handle 100: root mqprio \
> num_tc 4 \
> map 0 1 2 3 \
> queues 1@0 1@1 1@2 1@3 \
> hw 1 \
> mode dcb \
> fp P P P E
> 
> tc -g class show dev eth0
> tc qdisc add dev eth0 clsact
> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 0xffff action skbedit priority 2
> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 0xffff action skbedit priority 3
> ip addr add 192.168.3.102/24 dev eth0 
> 
> - check that MAC merge verification has succeeded
> 
> ethtool --show-mm eth0
> 
>         MAC Merge layer state for eth0:
>         pMAC enabled: on
>         TX enabled: on
>         TX active: on
>         TX minimum fragment size: 124
>         RX minimum fragment size: 124
>         Verify enabled: on
>         Verify time: 10
>         Max verify time: 134
>         Verification status: SUCCEEDED
> 
> - On receiver EVM run 2 iperf instances
> 
> iperf3 -s -i30 -p5002&
> iperf3 -s -i30 -p5003&
> 
> - On sender EVM run 2 iperf instances
> 
> iperf3 -c 192.168.3.102 -u -b200M -l1472 -u -t5 -i30 -p5002&
> iperf3 -c 192.168.3.102 -u -b50M -l1472 -u -t5 -i30 -p5003&
> 
> - Check IET stats on sender. Look for MACMergeFragCountTx: increments
> 
> ethtool -I --show-mm eth0
> MAC Merge layer state for eth0:
> pMAC enabled: on
> TX enabled: on
> TX active: on
> TX minimum fragment size: 124
> RX minimum fragment size: 124
> Verify enabled: on
> Verify time: 10
> Max verify time: 134
> Verification status: SUCCEEDED
> Statistics:
>   MACMergeFrameAssErrorCount: 0
>   MACMergeFrameSmdErrorCount: 0
>   MACMergeFrameAssOkCount: 0
>   MACMergeFragCountRx: 0
>   MACMergeFragCountTx: 57824
>   MACMergeHoldCount: 0
> 
> - Check IET stats on receiver. Look for MACMergeFragCountRx: and
>   MACMergeFrameAssOkCount:
> 
> ethtool -I --show-mm eth0
> MAC Merge layer state for eth0:
> pMAC enabled: on
> TX enabled: on
> TX active: on
> TX minimum fragment size: 124
> RX minimum fragment size: 124
> Verify enabled: on
> Verify time: 10
> Max verify time: 134
> Verification status: SUCCEEDED
> Statistics:
>   MACMergeFrameAssErrorCount: 0
>   MACMergeFrameSmdErrorCount: 0
>   MACMergeFrameAssOkCount: 57018
>   MACMergeFragCountRx: 57824
>   MACMergeFragCountTx: 0
>   MACMergeHoldCount: 0

Nice of you to post commands, but could you also please clearly state
whether the implementation passes tools/testing/selftests/net/forwarding/ethtool_mm.sh?

> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +	/* verify_timeout_count can only be set at valid link */
> +	port->qos.iet.verify_time_ms = cfg->verify_time;
> +
> +	/* enable/disable pre-emption based on link status */

For the benefit of grep, I would appreciate if it was spelled
"preemption" everywhere.

> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> +
>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>  {
>  	return port->qos.est_oper || port->qos.est_admin;
> @@ -602,6 +743,8 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
>  	if (port->qos.link_speed == SPEED_UNKNOWN)
>  		return -ENOLINK;
>  
> +	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
> +

Hmm, why just look at the preemptible traffic classes and not at
taprio's entire mqprio configuration? This bypasses the mapping between
Linux traffic classes and switch priorities that you've established in
am65_cpsw_setup_mqprio().

With the addition of the "mqprio" structure in tc_taprio_qopt_offload,
my intention was to facilitate calling am65_cpsw_setup_mqprio() from
am65_cpsw_setup_taprio().

>  	return am65_cpsw_set_taprio(ndev, type_data);
>  }
