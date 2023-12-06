Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F780792E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442890AbjLFULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442880AbjLFUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:10:57 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3C9A;
        Wed,  6 Dec 2023 12:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL4O0TJYvnvn6EYKTAOi9tn/OVrYPwn7C67IY0Fc7NdEJheGXrvPArgf+HOJt/o7lS8laEZUcjdctKusajUTeWJACc/sftJihiztYs3ALabclqDxx2SAZ76qpNZU8LAQd1I3M4EnykF14btrZyEfM88gm3Rm1F+YoYymn8JjuDviSV0FHW9qahqB8QdiMRsQrzluCmhOh0jxMCLEseGRz8fLsmyZ1CntXcVVNt6p3W6cl0IxAY8M5cg0V3sQtYaoE/kZ5zNXmaHmGiWebK/SckaeSI/WdeiNkjAZE+jz8pFnMbp1uA2Y0ZK6oyF8n4jpAnjrFSIZGbp/q+7nH5cMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1V4RTfdgjV+ssR5nf0tCLQ2p6+O1A2m5UmQQ+jFq9w=;
 b=MY4hT4OnSp3DWq7lI6s3k4q3nonXZjOMsAyDNEc5kmNS2S9sFNwn80fBuU/x0GYt8KX3/MsQ96re37GidJVGjBp4SyQzH/ucxXKx4kj63Z+dr1aIRbCanC6HVIMkpbolq4DaxGVqTFrOxVMy6QTld0q9xW8+bs82UV/zO1eo0yQL0XK6ltUOHsMbzgMgZC45epVbKbt99ONTztpo+kEmoL0vL8i112Zzkr1WcgASVkxcR3FsWJP1rzVwQA0X6fQPu1mr6Z5ZThvL2tfOVvdG09HFzvHxqrjyoy4bvRMYrvxlx661VrsIoDNEDiKKEtO9B8uka4OfIS25FF9kEnMPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1V4RTfdgjV+ssR5nf0tCLQ2p6+O1A2m5UmQQ+jFq9w=;
 b=PEjnTMjZgSJMdmcR8TY153TQzGfEEeatf5BeTCqPiin/3zsKLB6MTgiuIKMC4UXLZbty0r1mW32nCBeQ4uI7ovgoO64o8UobqM7p986tQ9FFaS9f4SyGXu4sf6nt1nly/HL18IrTh7KyMjxtG2bKItLMJkPbUqDs1w02udlnO1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 20:10:58 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Wed, 6 Dec 2023
 20:10:58 +0000
Date:   Wed, 6 Dec 2023 22:10:54 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Christian Eggers <ceggers@arri.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Message-ID: <20231206201054.7ketpxxox5y2wnby@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206071655.1626479-1-sean@geanix.com>
 <20231206071655.1626479-1-sean@geanix.com>
X-ClientProxiedBy: AM0PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::26) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 0733f7fc-c15e-44cb-fcd6-08dbf69775b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJhyAvl3Inv+hz05h1Duk6pM9iUVSnIRs0m2KuDiPRUtwJ8amdm6BtbB2O9dfF8YczN54hAdikrQRlYCs1XXbjs4+DL9dJIIV/g2hroS9m/eM7GFYj44njIR/Kmgn349iUjavUcj15pNJodeMipjcC1vz2U5NDKc3brCKygc6EhL3VbGAToiGY9xaTjDNwT/HIhIW6mUy1VqmZQN7/D3UnB5wUGl8zYSxhtwUD6iGYqlmV4R+cUrtfzKeNLBf434xOUGhC4UjrioyFhiIYxPwqibI76K7ugNjFcRhMXX+wFCyJ6wCMJY/cgyyXPXT3NWUC8nnrgNVfTVvBdu1T95sn15Qx3MK6uDaGIS6IpKkIacBowvdfKmoLQsqsNBM8HAbXIqAkUdweMNZv9d6XiIVD0Xvhs3xDaqOM0096A1mVWlu548ZdIEdUVltgfvYBslR1ysorz0lQt34+oJQVeSmLAnGf7mqO32omDmn8M1+amN2gUpaos5W7bHMGu+DqubMB9RJWxK7TDOrauA1O+k/9leheQUItMr1gBegu8J3dgUAZmt1lmbrpWUZWN8mEAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(1076003)(26005)(6666004)(6512007)(33716001)(8936002)(83380400001)(9686003)(5660300002)(7416002)(66946007)(4744005)(41300700001)(2906002)(478600001)(6916009)(66476007)(6486002)(66556008)(8676002)(54906003)(4326008)(316002)(44832011)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyBG1/mR07cj/+34XC7adqq/aLt6T/UM7zBojcdG7s8HBOyji8fjB6iKyzKT?=
 =?us-ascii?Q?o8xctXGOgqG6LIr1pPFEO+m28u+2XtKGpdGc0mNo+qNuAzrG0FozbDTPHTm2?=
 =?us-ascii?Q?c54WLUpr5v2iR8nsMHfcTMgyK/h9+Nfkx17MJkaibKe6GWB3zaIYWv1Ka3yd?=
 =?us-ascii?Q?C4Et1k9BowjbJXPNFth1xsMj+OPgub9xUXbV3z2HwoU1RddsSISayoJ5kmle?=
 =?us-ascii?Q?QStMnU+Pca2AZskajvc83/ONLgI2Iwi/fn+YcXJNG3x1jbF8Ylx3p+nBJQy1?=
 =?us-ascii?Q?W9OwwOs5BJZDZ/fedhOYEnsKWfOERKzalR6vDmKMZfDrJK08DrFxVYvHYnOz?=
 =?us-ascii?Q?knHzCZd4hQ4Rylwih9SGF9g/y2CwGSKe6s2fUh/OIo4KDbDSlaP9VGRaD2F5?=
 =?us-ascii?Q?PAqtPnOQgNAHBh5me1F2MzT2HqOdHbWrofr2V61nNXaG3fdU/MQYRF65kkCD?=
 =?us-ascii?Q?0DObbTPMZpyGzNULwQJvhOS63cd0IM3MN3E0VOOiHCVgmOiF0xF/4ZflJP69?=
 =?us-ascii?Q?zd7J+8fbbqPIS/pGaUWgfT5/DBZGdU665WXst6pxTJjH66LmzEUf7KQf4ApA?=
 =?us-ascii?Q?4j8B/unswOlFXPftaMI/L8hF6Aaq8zlDCRyGUQBhCeAOnlnVi4WT6Zmcedqv?=
 =?us-ascii?Q?vL1Q9ab2KizQNPnYprbXbwhjyCBxNsVRW3t8dPEh8oAa8WMJis8O+RWGV+Hs?=
 =?us-ascii?Q?uEFOYuqL3D8jVnG3b0IgLfNf1Axvrt52n4D3hR5EVyOYwKE7XNnWZgiCcHxr?=
 =?us-ascii?Q?SWy0Y9WM8Sp6aoWuv5d7uXZn4hiS+1OqdmQByuUI5uwkrQGzu28ZZTwARPGa?=
 =?us-ascii?Q?fAsMaoUK+8F4liBDxQUp9FZsytXsc1x7JTJusPDo5uw2RNPJbZghwCdQT/La?=
 =?us-ascii?Q?aFLiK/VK35gRY1I+IlZBdfBFLIF5HkIEm5zd0GSQDGwKcLOflc4E6/oIllgA?=
 =?us-ascii?Q?M1898TKuazDlK0hghhKrszU8TK3KAoUKvSKH1lns4XGeKwGVr/IsA6ZKBV7L?=
 =?us-ascii?Q?1PnvEZxzoW4yIiFp8zc8QGm7e+DHWSeAjmaV5j4neWyHv3fUuCqfL6vTIT5e?=
 =?us-ascii?Q?4w/bPAEEZJj1AoREXkVcWrJKIrr5SWD60MMndsuQ8AQZtFVeqUBbMRAFK+MH?=
 =?us-ascii?Q?A28xSOsi3kV7wp8MIDZ+7HgeVg8t2Wgwln1yRkR+1fgGKqCBzS5071lGkFx3?=
 =?us-ascii?Q?XFsDF6AF5UotGHwK0yHooGzeORLNdBdLf3DNmoinhHhgXepaR1+ZEWZsA16y?=
 =?us-ascii?Q?GQFaTPjSOgx4iA7MCJfHds+KFUr76pNc1kOBXsrYONRk+M4qujTlTjxqo17L?=
 =?us-ascii?Q?pVr9dvxhDiDr/L85hxNYKDGESiZ0dAMA0RNhaQ9CpzTnlVuBscAjrzWQZUay?=
 =?us-ascii?Q?67zNrhjoBDfVEnAklrPR6MzxRJy+3vS3tSeFyWoGzGZtXhuizYRlCUw0Ty2S?=
 =?us-ascii?Q?Xd6sYFuQbIezvbxGZ4pZN55O+E8Wm0mil4nYr53htPU/q0skKdfYj306OOQ+?=
 =?us-ascii?Q?SgoEfathAEqORwPEhxaWpBgC8hnvN9r2CDb5vOf1qLzCM2S0oDNgXNS7gFS5?=
 =?us-ascii?Q?JWVa/xoi1nKQD3Mvh5UNUx0ih9bMoIdFFolDja5XPpdwfthkuIGEK5dQimyT?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0733f7fc-c15e-44cb-fcd6-08dbf69775b1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 20:10:58.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wWnUfJms4KiNryx5il0xL3dDv+dBAD8wScWw3Ta3bdSRZ5WApAfXHVwZlApmNIhDvDkuAGyt66W94Fx8EIzXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:16:54AM +0100, Sean Nyekjaer wrote:
> Provide a list of valid protocols for which the driver will provide
> it's deferred xmit handler.
> 
> When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
> "connect" method, therefor ksz_connect() is not allocating ksz_tagger_data.
> 
> This avoids the following null pointer dereference:
>  ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
>  dsa_register_switch from ksz_switch_register+0x65c/0x828
>  ksz_switch_register from ksz_spi_probe+0x11c/0x168
>  ksz_spi_probe from spi_probe+0x84/0xa8
>  spi_probe from really_probe+0xc8/0x2d8
> 
> Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission timestamping")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
