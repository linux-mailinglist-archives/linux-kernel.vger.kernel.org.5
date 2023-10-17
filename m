Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA67CC550
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjJQN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjJQN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:57:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE97711D;
        Tue, 17 Oct 2023 06:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OobZ8H1StkLi+F9c53s/1F2jW8Q5Fku6lnsLX+MG5xoTYysM8IcFrdGWcheBuCih/Ix7i4ytl/rHXy3+2KXnQPUDuSsov5Os/doptVwkvbammfc+MOlyBDtNf3T3RYwCXUYc0IuOsylWRZTqhyC/Dq2//+zG+c1dcfedQxubYMnMrgVsE2dvhSnLmSilBV0M0gYKYQOwjkyKzTuh5wkneOoUltvYim2FusVPdgyKILTomlodPCQxZQMIlm84PewX3QTM2PDjfE+/rIClENwXmljPZac7GKmgg/moKk4YQNMPL0v5pm8MHQ0X6r9qT9GqCC7WPyg4Dg3nmysF+Sqqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEYPqAIgozko+LnqkXzlt1sYhN9jH6JlVVlbWYTFlro=;
 b=SOfoeaRBv2ufhwr/TWtOlBc0qfo1WGLq2g6C+tFeFVX6sluuvEdLeB9TbcRndYwx0QWCTN++B+4HjeBe41xkqprMD66erX/8f3ytmRg2+BFLCsmyLTx/DKr6uDpTG8f4x2tpU7biot7EZ2WDTHjV0fZFiDzMHdFc+zMVh0yGNYzcOPojO04z8Uu/f7KMFx1WTKQUCb4HBAbOuqbdLRtWtcSkTd5aRQl9nBFLuQdU6koGdqSQFhWBK99kJwBcxzs8V0XTumOR7L3m4HJhSpxoHftf6e7lzM8WGZQE9zQwF1aGOGo6roARkK1NcG5jc4xJFewufl50r6g/ScO+ifEl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEYPqAIgozko+LnqkXzlt1sYhN9jH6JlVVlbWYTFlro=;
 b=ciyMRVc/kPPM3rYigA4Qd2qk2nDRmcsIPU4xdq5nTd/zLkNM3r5BS73a5radcC9HyelFWqE5Aqa0ciQxSsip1PWApUbIG5nbkyPufWyeaTiZBFlQDdnO2ODPcGrADH92OUR6pA0PlbRE+pQDBn+mDBlvoMtZPzg/+fVJ8W2Ov4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 13:57:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:57:28 +0000
Date:   Tue, 17 Oct 2023 16:57:24 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio-mux: fix C45 access returning -EIO after
 API change
Message-ID: <20231017135724.pl5neb2ubjdopf6l@skbuf>
References: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
 <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
X-ClientProxiedBy: AS4P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: c058229b-1b8a-453c-5636-08dbcf18ffbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOH8Sbi+3yBg3i3cbRaSKmnrdyEmd2hv2yMOHwgzZ8QyVXIQsMpfWmnDLA01eFnN1HtK1CGlHqTKb276og9koDivuxD45P9WafKgD3HjHtRK/u6c+982tS47WnK+ZZ/0HkILC5MRBbHLkgi2/4DpmjKzB1J1tIhWpS+vxxdPHTIendtEihphkK5KNMVpPGZgUFM+Nl7Mt96ikYkfBxvOGt7eAHIs5InIfifsnvTmKFGOCKD/tZ45+E3sSlyPnnGygcYosSD+c+hb9OHxKDFPoj1vWUoZ5JzmG26bi2cBt3h1nqVS88ZHsZEgx82+6/XQbNJCksKD2uXaBCLGtnVXhK5IuSfKeQFmW4XoUKqq7yyrYNmX44n8lWE8UsjYUR9AHqU25xsjuCaYTfaqVSZuGOvP9DDPAAxu9UZPItMOcdP48PQSF2wfUz1b99Vm5k9zjMnDTmxsy6LTUOdRyNmL8DW8bHDcakb8oYuRueUU9DUi6NVGx80tGB/tBmMJQOSkKrp8gYpGvCnlVTDSC2OdTI7/Farau+Vhc0G8SdJ+PJQXB5uUTZOZ9wDDNCe2vLAm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(66476007)(66556008)(316002)(6916009)(54906003)(66946007)(1076003)(26005)(86362001)(38100700002)(6506007)(6666004)(33716001)(9686003)(7416002)(4744005)(6512007)(2906002)(41300700001)(5660300002)(8936002)(8676002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EOpXffOBBM1B641rGUpLHDHao6Ux9N31b+7+38Brs7MG5v+Pxbt9mY96VQfw?=
 =?us-ascii?Q?5g9t3yan7qxumtM1XpqgB56939yjXBrMLtITnj4Ig9WKcaksozVaBYOLD3y4?=
 =?us-ascii?Q?jEBwfJNmw6QguGjdhKYPDwdUXu8+xBxH44bc4RIAKe7PHFvQgZDwZTGaQX7/?=
 =?us-ascii?Q?0DBen8qdUTVc9H3slS1W3y3BQB9fPM2fiy10srz2f+DzDW/uPcYuZZUtcVQK?=
 =?us-ascii?Q?T4Nc//XRv2RZv2P0s8mom2Ffsp0LZDeHCRlnJeFQIH3K4yNTejX5z50PcoPQ?=
 =?us-ascii?Q?GJU/lyV31b67fNwH+aOAGKoQxOciN8E4wCcFu1nqoowA6RsoPQMF8xLcu/7I?=
 =?us-ascii?Q?lhLeMpzjLHgGAGtDrz0xfbK6vHZz4s7ZDNENxhZm+Ju+BslNYHCAL05/P8ww?=
 =?us-ascii?Q?O7RyDQSnVkUCChoG9oF5wGpin7AAItqJKWNEjJTO3Yb2G9b+rvmYKP15EZm8?=
 =?us-ascii?Q?f6sSp5GNhdNCD5dnh4CRFLaepFi1QChekc8GKLyAufxO8xEybm2HcTzwvhYB?=
 =?us-ascii?Q?sgMvFf6YRZmCQZvbI7R91XNR3yisdEUVrc8P1KBjOTePKZyNmddmFik1BUCM?=
 =?us-ascii?Q?FqzfpVJIoJeH5zaq5yAJu0IJlUa/bTp51c1tt0Sxislwp3ud4E6YVD1LKx8m?=
 =?us-ascii?Q?fcFK6VY4uqY5wCmAXJj6kLLXncY4b2KMjgHDbE8IkC3azaVvPU19itcD0Hur?=
 =?us-ascii?Q?7plScpME58fbnX9sGgvBeQHaX9c0/d3KdFP932izEaMKLYDcV+JDdsLUJTdj?=
 =?us-ascii?Q?fQkvcDwq2MnO8UZmethAczNUkQmUt3P/7KrHzHpsydhBh0cuQgIMvca5YoZj?=
 =?us-ascii?Q?t5g4xcHbPkyFoPhzG2sOKBVkYIiFXXwSPiciSS6VwrgwqFOMKDlEUhzm5IR/?=
 =?us-ascii?Q?+zmQG+/PhepcdGYcZs2BnixRNpGo7H3eFvC4766HE5V7FqPNIeup8kB/z0AS?=
 =?us-ascii?Q?30esn26XhJShquoQmSC7JrSzDcQCc6Ppu8k8kNk6ZiJSaQhmBYiJuYU9cu+T?=
 =?us-ascii?Q?67ytInsaACqGLW7ElJb84qqFBXoVTtql4JZ3ofpdHrLd6bu1lvKoZVjbWAQx?=
 =?us-ascii?Q?POSGvI0QlFKRF2ZsBmOdK3/r5DTS8OPh6wcD2tfW568nU8XoHFenvwGJf1ov?=
 =?us-ascii?Q?99bilB6ZjLUS/igZYptoKcUHlGtvO125PU5z5HaewS739d/hRsXZseTIfZT/?=
 =?us-ascii?Q?kkNhqT9gpT9bM4HIuOhA7IRSBdwlRCxr/OsZqTmw62jbWshZ2cjZJxa8YOr7?=
 =?us-ascii?Q?iVo/6AvBJoYNG0owRnGhcCzrHV0qTZITSIbl8caf9OGVNOuoh8TGl16H6oCY?=
 =?us-ascii?Q?ng1Bks3Vd4NPnEZ6SJfgWG4UmsgD2glbKHfX/TDPTzeSw3PckL8vMvES9kq4?=
 =?us-ascii?Q?9cEpa+nPcnashzuw/0vSvlE/5/pg0aMn80cVtieYz9Ti+62TzpFf7OBOsFqI?=
 =?us-ascii?Q?IJ0kA3ANnS1BSPE/ygmTQ9hU/FxBMI/G8sPRCmdJh0UVZRPs1KP2InuA7g1T?=
 =?us-ascii?Q?oz6sS6rIg9Vq+iqUhVUfZCEww/BGc7FFoYFXcUOLMy+6Z6ysZUSSIzqCmhoR?=
 =?us-ascii?Q?QfCV/dMN/z7Rj8/J7RpXa+wdHF8T6VPla1qldyt/VB7SthczigL7Vk2vQ331?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c058229b-1b8a-453c-5636-08dbcf18ffbf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:57:28.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4732p6wJx1qSUrFGiFsiLszbqaNAnkRiG3ZckruHaqIw0uNS9qjPDlSEUvBQ35IY1y22wp/zkZGvsV1r5VKbdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:31:30PM +0100, Russell King (Oracle) wrote:
> What if the parent bus doesn't have read_c45 or write_c45 ?

Good question. Predictably, the kernel crashes.

> Maybe make these conditional on the parent bus implementing the c45
> read/write ops?

I can do that, and send a v2 right away. Thanks for the hint.
