Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DD7EAFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjKNMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjKNMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:13:54 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC713D;
        Tue, 14 Nov 2023 04:13:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czF9yJ0WuDyhzIibMRbZ47YHYBus5y/bO0Amlfe3dpvDi90SihekH2Wrr4bEaKjL7WKI5ffENuh8uknigURV8oXXHN5yuH3Pv9PB9mJi4kDYL6fCvzgODn+kgMhAYUzVt2hDV8b7MT5yV74UIphFztRjvNshv5hg6MQF2zCi3MC16LUzC7gZyXGJzYUwOL5U0Y4yE3dNzgXGHCVkClxEruhx06GTCBZD2zHXH4EJXnt4nI/KVSU0G2Nw99tGeqKt+1WvQXU7+/MDPiIOqG1PJZ2KNCszKjoBnmHwRwDA/MuOv5BLkV51NArvFqnfsmmjOfa9YvF70hJ3ioXCSrL6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xuzQNlvEW2TMEC++uFdRgFdgj4wJu1RLi0sJ52EhEI=;
 b=AwBgDlySk0MlYPUA2ec/TnBhBRYVewjNGhqJVrjnWnv97FdQuZHEWmbZK/IjGZSrfuU42BMd48aekxkleFOOHkm9CI8qGvl5wgaiO0PhBonVsZfxNPtBwnZqdySnj2f9FQD06P8wDmV2tQj0mmJpdIAWnZcZnidWbSXDnCvPme34zRJi9v+yKc8vY9rWRtdLeMZ3FecxzKyU4BWujJ+TQ3cYkID7Kd0Qywn6rnGeNBNSrV8YL1r5zEx4K2dzHolaKwWmd/8cFdfsebR2yLAwWxpSXeSk0FOmn+BZbDgWx1Olv1LWrFen5zf48zQPTJg6kOIWz/PshSK+SkgtVfWDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xuzQNlvEW2TMEC++uFdRgFdgj4wJu1RLi0sJ52EhEI=;
 b=PtzMSSdnLFpVInTBxvNFDrz6Kx3jPmsTL/KTHYuTKNbI236pm6MZgoMU01zKgk4cLQ2Te0882ZqRIb1jAlhbmn0krzLhpxwwW3LYzLl6vMgE6RjnbjDQMhghmes31ZjcBWNSWDe6U6475g8AVwNEFTz6Wn90QClY4WjIZmk2TTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Tue, 14 Nov
 2023 12:13:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 12:13:47 +0000
Date:   Tue, 14 Nov 2023 14:13:43 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: am65-cpsw: Set default TX
 channels to maximum
Message-ID: <20231114121343.o3nk3lddzy57mqgw@skbuf>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-3-rogerq@kernel.org>
X-ClientProxiedBy: AM0PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:208:136::31) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dfd005-dd5c-4708-7c87-08dbe50b272f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubEfrLg9uMrpzZY/kQxGacTF5b5e5kZyQi1eGpwgxZnkxDgSgooO+9aFpFDER6XWD26bC9TwDjmEso3rgnrGtynvW2ohwo83U9oAXkN1DiiPu5TMcQqhLCaHNN6m6/DO60TWOfzHT2muKy2v+KWKpt1AAbd4j5YKKH9S8RA9Vk2zcj9MRwOc163iKoTe3qVXv/15K+8ELA335LxSqxtcgRURccm7xhrXsigjXkBTa3zkw3UxotCByXqLjvvDZDXwY65X2f8EW/3DynL5kDpnVrtByElBuYyE0rZ2Lf1KuE/stRu6+p0AhFdaFaxTRLYbtTwdtXODLsbHHwByutF93/uVA0UKK8Y6PaOyztpfpJVbnYZbr7Lm91UgF0Af2rPJjJ4+0E33Ci/UhsnbUyqeT766aPRkFdT6L0i1ad8hrguEc+9pOrQ1kqdzAYeO13SvOrHdQlxJVNfp52GvxTVsVryv0dpzEPsXlrAz1nLs9kfzD63jENAq3sJjhULW3N0hro38hBEre0YC/EbkKF0v0Vn5Tmg8Zp4JmhiEylL/4w69vjV/zNH75sZTSjA2n2PN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6916009)(66476007)(66946007)(66556008)(558084003)(38100700002)(86362001)(9686003)(6512007)(7416002)(1076003)(26005)(6666004)(33716001)(6506007)(41300700001)(6486002)(2906002)(478600001)(316002)(4326008)(44832011)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/H9VwKaBG3XbtIQxweZ59FM1SmclruUkov5DKaUWiH3c5EKi2GbDwXwPmFhD?=
 =?us-ascii?Q?o/TvqfJwCszeX51rrKBUC3KL9XxhyPLhRz1QX2XssftTkX9YozHh6iggyz4A?=
 =?us-ascii?Q?qtQV4vmkf3qtgMzjB+D8VOHm7j/tyAQVb/CszorMTKupNhUneTtkvrJQMX1x?=
 =?us-ascii?Q?fgtj4OmkE/dWyUlpJ05R/bsOQcD8OcxDjJvoHnvGi2g3AY+Rg9XnOmRdrc1M?=
 =?us-ascii?Q?4a85tVqz1QNRhKehGzzOamPsNtdj1+naWlJVskpfVGbQlvizbDTfBKQNmUpB?=
 =?us-ascii?Q?aHVquwGqmh6bnD4pm4ODsukKu7o3hfc6ar/jLgn/14qWrnDOZR5olpI3cRbY?=
 =?us-ascii?Q?2+Jrfrhr/Ud2r9kBURSS12wvenUVAqtJcNWAoyK6SDbTA/0qux/RblY18uVL?=
 =?us-ascii?Q?ceI1BchykrJ5YU4RN4Oe7bqqOKLUtc51rTzyGIltJk/ptgqvlFSfEHwMj8z7?=
 =?us-ascii?Q?YK1bSrDPJlr0kOy/KFXfm4L7iEOYDiXvqzkSNOPTwNj2nRH2xSgre52EGp2Y?=
 =?us-ascii?Q?f+/3R657hcAg2Zm728Yi2EPOhVD4SYgssFXhGwl+yf2YC8o3CloXaR25vD0q?=
 =?us-ascii?Q?F5oJaLWyK2WxBVTsASB0E1IWr7srUtThx4g03VwevCCKCHn4b54eSyK3SoaN?=
 =?us-ascii?Q?tzZnUlKNVXDKbSAQHYkWzM3HhmEqkSKJ8JppBUziRjBe+HBmbqgc11W9HbE9?=
 =?us-ascii?Q?QH4FW0xv6JFW2HWiLU8u27XrYSHmyLepvPbRndjD6qnN5CQqCcHfBpwNFpOl?=
 =?us-ascii?Q?np5U7iOKQQ+Dz2CIPfpx2dHGy2QKScIU6kBO3+BO0SR9n7ctfn9ybdgKhVch?=
 =?us-ascii?Q?QR2Yp7zv74jyzO4/aDnQJI/bl35L2y855cRu+k4NrPonI/cUSltFjmP4SWzH?=
 =?us-ascii?Q?S0CCXMbuhGMfS+uFzx1RhwuKqaMIC82Yx1Yzs6vJc178BkcOmFEHurTxEjqd?=
 =?us-ascii?Q?ZR7l3/wyDkyy2OlzRXG6NC2YIn4aIPdBDf/Qe8Qja5DfY4tCmObIQqf6uZPG?=
 =?us-ascii?Q?DT+wQo8CZWPwf+flKVa4vIy5ej2pkPzrVNSmEsd0PKdxtj94mpXwYQl3gfn5?=
 =?us-ascii?Q?B4IPtQ0bXT8xOscSOIwwk0VS3o9cMiT7SNtcwkvC2CmZROLFcUls8vDoecmV?=
 =?us-ascii?Q?Z4qSrOsplNxtiJwEvMRJc0QavTGkirjR3SHShq2+3UvN43hNVOaWcGhZ8OOg?=
 =?us-ascii?Q?7dd5WbzV3wUM6HqebR1gshD3FxZ5Iaixgfpj6SDNirP22EfD5X3Jfi8Z99nU?=
 =?us-ascii?Q?Y2n2ZN57b6yUPnVbltdOq/EniPXGsK8+7FLLFyEnbQiCO+hBCNFAnF/hWCL7?=
 =?us-ascii?Q?sVgQNHaqh5M7Ygh6dlE6EtcZe/UbOaAE0Z4DhF8o+TFTcYcF5PqOzelDXAYa?=
 =?us-ascii?Q?Fna41BT+nrEMQKT0+nziCGHYWyk+gUWFNGnLtUn5IeX8TOvTUPwDbU+Je/gi?=
 =?us-ascii?Q?hwTutwOZLZ9CZJjJ4VwZHLxpioVCO1G+ZCnlgstKhWkoUmb7l0UJTQraLQpO?=
 =?us-ascii?Q?EpBGb2GnGVFV8wS+a4RsPZhaobKGkUzqK9OcBPKSqZSbZN6x1W2YUro/MyWK?=
 =?us-ascii?Q?+Z6V+G9ukh/8qPBGmBb30aj9NwVxpnC7nLVC1C4I5eoLmrU+zZKRldOktzw1?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dfd005-dd5c-4708-7c87-08dbe50b272f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:13:46.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9ycysS9x3hYdjP645w3RYH+vBGxM/TuTdmTuKTlO5cKgQ/9+fRn/RsPl/Yd4yoWBEDzcf7z/EY4de+FgbYVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:07:07PM +0200, Roger Quadros wrote:
> am65-cpsw supports 8 TX hardware queues. Set this as default.

Motivation? Drawbacks / reasons why this was not done from the beginning?
