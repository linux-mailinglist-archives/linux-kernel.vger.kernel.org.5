Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87FB812E33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443910AbjLNLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443857AbjLNLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:09:55 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B778E;
        Thu, 14 Dec 2023 03:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtCZNFNvEJGfhUJSGOpC1dX5wwE9Dy+o+sbuMUP7j7TjWE1MYr2OEF6YjeGXLjpB6y6sdb25tMwD0KCWXSi3OXYn9BxMwKN4jQfVfnyNjaBZ3B9MjnvFSao7BNpI0Au48FwyjZ9LPnjOQda2TpWOCBSz3Rdnz3puq/4HQeQZxhzONf1OPF15aMZK4//5nJdjBaqi/0+kM3AYQR5rCisZZ9/1N6rFLakqeRVgyFxXT/48KR8g7VeHF+E83n+FJ1tQ9gDkbXdXcj5TKcu2H1QH/tNija1EJtxhH/1ZW5n85oP7JQU6HH4i1Z6KFVPuGh0HQ76ixsT1SjdqHat2NG6YyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJga9KhNjsQARGXZbdBR/76t74JghYWH0yV6fbTznnY=;
 b=D8/kUD4z41v0DIPc6zWMgjrY8+io4uWXF5rcCSS1sxt/e54lm27y6a+UOiC1gDJLv+fVE/meMhN7HplY5bJiZkO/717U3Hdg1gfxf1Uee+P+omClWrkrkA84dyg3Fcq6BDh15RpTm64klEuSTwO775U2R6r2MmUZPyF+Br1D4n6RZq9yrXFrV39QhyKW7Mt9G9w0SquRqv5Kh9WSQYlbgbM1yHi3pan+jbgYJKg00lzmhOrWQTIWU+OJ23qk/4ZCfAMhJUbL/qBczXO3ueqAZ+4JbAAZAIBqIkKO5B9j7O4Urv8qY5QAZeL/LZTGB1MRYAXxdOvv3VEFH93XK8+2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJga9KhNjsQARGXZbdBR/76t74JghYWH0yV6fbTznnY=;
 b=PtvzaarZNDO5b97zZN+ir7jpGf/919hYcX6auwo5q2BUj9WrENxlQjgkLMey658Fsz6yBjyodiyJeeD3DwtQMTpVcaCvuGYOpoFX+OMHR9RBao5S5Fn/Ip5J7DxKiQ0ipnGnrTQ+PLqnh3EStDwFW9PMa8sNeWqBbujetz3fMGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PR3PR04MB7273.eurprd04.prod.outlook.com (2603:10a6:102:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 11:09:58 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:09:58 +0000
Date:   Thu, 14 Dec 2023 13:09:54 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 06/11] net: ethernet: ti: am65-cpsw: Move
 code to avoid forward declaration
Message-ID: <20231214110954.mn5kx4wrvciuk2hi@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-7-rogerq@kernel.org>
 <20231213110721.69154-7-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-7-rogerq@kernel.org>
 <20231213110721.69154-7-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PR3PR04MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 7985950f-0cd8-4ffb-8547-08dbfc95355d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX2JACx50CydfLiqeVWhuVQ5AMuFvBJk5Lsj1uqCbfeVUbEhSXWQOeM8fRNsetIQB4Ipat3F6Os2HoYr2OqR3x9vFe04bzT/M9TTYdPD+J5+502BdpCB+kdKbZaFg+HKdbij+5o9OZACYrRv/AoV8pThWl42wHK17b+D0fzJHdaNAktB6ARdhsNQtStMTIoAIjNajWYbyg3so29Ao+1brf1rw1H7ab3ASmFRwTrroeblu7dDW92a8ddQ8djle7L0uQA7kaQLuoeTh0J/3OhpI28xgFYwgm2nTcl0odbqlWOyZ9WIh9Uex0KPLghl0qrq+ueogMmynyYYSdjUZR++HYHnGYpId5sWwJdo+/SQHBFsXYSwA+Hbr1oCPKvXkdgdS2U7K3celIO1CRpmkqvDdC+LeIB1tErqtlfa2wbS5MA3s0QqtT1/w94XEQ3RC5yEJSvOszg6RMlH/h9JubEw4UPglHrd62QE83ulnhIPzRSUzXJRCZrVl6zBvv0wvrOyMgiZn2yQKN0NbkE71bJo+N7l1tmxlSWqb8kq8/VKvCVTDoilVQXuTxBDfJlbkmGy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66476007)(66946007)(66556008)(38100700002)(86362001)(26005)(6512007)(1076003)(9686003)(6506007)(2906002)(4744005)(7416002)(6486002)(6916009)(316002)(478600001)(6666004)(33716001)(41300700001)(4326008)(8936002)(5660300002)(44832011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfRoiW8Hft+HQi6thEDTYyJBW0YInGrZHO/T+UCSJJJDMKtK9nQfiuMvEfGQ?=
 =?us-ascii?Q?Cf3w6sqicDDx1XvlfFO7d0MYi17f9Jee9mHZ0wZn0NQLZ6WbosmSem5JGliR?=
 =?us-ascii?Q?Tw0hsAIUsGLigiRlC9r44BSkF1l+pf4yfmK7x/yssYjXcRJAv5x08AhwCeJb?=
 =?us-ascii?Q?G03r3vd0Xm37ikVF2mWCG9S5lNBpin9ZaFSS+JXgqUOilZaWUn+3ALFz3DuT?=
 =?us-ascii?Q?4YV5K2hpYpJQLuWuXaFrxwdlFWzfsMU/jiTFJwEDfYVcS5HjZh1D6ukQvbCI?=
 =?us-ascii?Q?etPibDG6PhRURohIp8SyPl8WEIHFpEHdWMFQVRJVCo29E04lSTPPre8vLW5k?=
 =?us-ascii?Q?+eGrsKs43NA383PuAXgWfkIUvr6DweeLxNic5WDfXbIeaPSMZafYTyr9gzrA?=
 =?us-ascii?Q?ltTSBMYGC/ULdN2Knmt+JM03Qbx3rmU0rGCnENcR47F+E6wwF/guRt02O9L6?=
 =?us-ascii?Q?ygx8y6zre8JdIFlJMVm5CxKagZfu6oqVjejfQKkgdjkE0aC0AAKy7usBx2U0?=
 =?us-ascii?Q?/HewzgdkuP8so7ggqd0sI0NOeY54zZHUKYDTuzRd1m+ZdyvofAjENMhN5WlI?=
 =?us-ascii?Q?h1N0IEN7czvjYT+ksx2L+NYuTHc0vDDJpwws+6ObrkOCo9SoCencoqU5PNIU?=
 =?us-ascii?Q?C77JF4plHqUcONAZ2gNj7exXYwktj7QjVILxtuaQHc63cY8e3doGC2eD4FQu?=
 =?us-ascii?Q?MIlrg4lR8CQOri1yjQeP68GNa8GN04BICIHAr3MqwG400XrOjVz8wiFQdVqZ?=
 =?us-ascii?Q?Esv7HstQwtw0KmywQyB+XaMkg9Lef5jM2vc8y7E76wkxL7MvhWMFhDJZnWfY?=
 =?us-ascii?Q?IxwI9NrmgxR5W5ZctEiq9yOVhlhkIIpcsm9uRjGoV22NPbuFa0qo7LjMNpVD?=
 =?us-ascii?Q?5L42Xs0WdqSrahxeoqh53g9tDVQ88fi/DhA1NR75Bvu971W7FQnOm0EgiXtP?=
 =?us-ascii?Q?8cZ+miPscvYW00fgv9yhgVrdbQ/ejX5LhGJ5wP1Vx9FO52It+g5peFEWCfAC?=
 =?us-ascii?Q?4A9lh0H2cRn6zwWcoUtEq8eJGnMX+eddHCXGIqhA/DBA4bgl+/lN4D50yAdM?=
 =?us-ascii?Q?T7/3bYWvLOhtCUpM+JZ3K1LoksnckhbZWJtPbev6rv+fQakcAj/xZ7cxI33s?=
 =?us-ascii?Q?1fbz11VQBh2YWoJZ3KkEjVGsMlMJEOksIjKzrzX5fJgl8IRZyVRE9QmnZCSN?=
 =?us-ascii?Q?YnkRc/4VB+jz+8LcGGJzDQcDqKx5eZ0DI1rKKQ/SVIP699rlr6yM7PeVmvVO?=
 =?us-ascii?Q?FHxuScOLaxOJrmgK9UKDD2oo0ZXd+S/R8olOGu816K3Pmy9VD2Ptt3EC6RV+?=
 =?us-ascii?Q?uH+q6kGpRnsRIX+cagkZY12wbGOmeFDPyHoJ2GPGBMMsT05mFPkpJqeil3gP?=
 =?us-ascii?Q?ikezXRu7Qzuoo52G6Xv1t2j5MQ3j1E20sa60egLcqO7t+R9Er51SCra5uABG?=
 =?us-ascii?Q?sTocpHEKsFPn/mN6c/jnu392QfwUAdFtzpNlxQXcS4Joo/ivtxLi3URyRSRz?=
 =?us-ascii?Q?8JBC3Gogu9jTf9qaWeD7qvtioDrwV5Lkp+g4LoTz0J6WOsc5kw40qjftEHzJ?=
 =?us-ascii?Q?8hDIoqobFKEOGLAxombBINalAsxdLqc9NsuMuATSURc1qigh/+Y5mfUdiv8Q?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7985950f-0cd8-4ffb-8547-08dbfc95355d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:09:58.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJpNAgVmAs1cEbw5eDzA/UEc06ONOG8a1ti5H2DTlfuSNgztNJK+Dmn17Jz/h8VAl2hsVZxqYFHuhVzL8H7wqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:16PM +0200, Roger Quadros wrote:
> Move this code to the end to avoid forward declaration.
> No functional change.

It's no longer all being moved to the end - see qox_tx_rate_calc().

> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
