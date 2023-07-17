Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF653756187
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjGQL0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGQLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:25:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D7E5A;
        Mon, 17 Jul 2023 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n02c6CNfLHYw8dVai09Odi1jMQ/GjTsgL+Eh+rH4el8CYP0WMYi29yb3lZXNc7dwOJgOVqlpVKAX5yeEX1cYKJ6N/X+agNvld7AFiJhld7AHBjBIvJcFFzFhXrtH1ZTvXL/4ANO7w+jl2PEiZCxRW1s8B63mRKTVHMTWaNFXqETeiZKE0LHGF5IV1Nm/mC/KsZ56htyC4DqiEIY7uErumEXbHofLaGELxWM9pcwBHCmCbsAD8nEG3/UeWtmByjQazcMHzZ4mF6y5pZeX3gVxk6aL8DokWu01xcFqZU+pWzGA0rjiAdX2CcPTU5MaxNHvFZMsYVDPBzEXw19ZdgRpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEFh8rCo8j/g0eA/IELmHsXKAw+w2FHmTSflRN24JDs=;
 b=J9aVPwvwn9rjYraLmmjL+X+ecK5BeJQndwNW+5vA98AFR2bSCXczfXqZyy7HY29Fdoj9+q7ScxZh1pT8dEzuov3LaANcPuN1mcUrRmoqhFgJoUr9N/xSACtepl5JjgNKi4FUEt9ADLixcQhBeibKZYnLf9PgMosWRLMQyDcIPuwnumq9ymOSdFOMVLxf6VGIYYpvy/6HbcXHRb47jaAj+37IBBHo8JHysFnWB6NFanStKB/WVPjih/D1bU+ZkC8KMVuehqOxsbffaEkTFnkWxiK0j92UrlGUnwonxVCbtg59PbBaV5R4XrREmPFsFPalt2n61trznn9vuTE8bzhpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEFh8rCo8j/g0eA/IELmHsXKAw+w2FHmTSflRN24JDs=;
 b=j8Mp4yHMKkbQyxiIYdueLXdD1U6ZVfDwgAFf/BXCCUuF6uQtxQc1D2/zhJf9tLQIpW6xaL4GA3Vs0o6S/N9mG1E+RriaLPj05mzmqJUWQWT+vDCmUM2awriia/5H051MK02HrBBH5HawwJ+bzkQAT2x0Dd8ZRap7piYG5F7UUas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Mon, 17 Jul
 2023 11:25:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 11:25:39 +0000
Date:   Mon, 17 Jul 2023 14:25:34 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Max Georgiev <glipus@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20230717112534.nhy7ldeer42r4rz3@skbuf>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <CAP5jrPFbt7vc77wVi5buYM88gDQ-OCHzm3Hg=EzRxJiha7Ur5A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP5jrPFbt7vc77wVi5buYM88gDQ-OCHzm3Hg=EzRxJiha7Ur5A@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0103.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::32) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 5410b131-2dc2-43b5-9c9e-08db86b88c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40HEx0nTTqwP+0sBRMDOIplA/Mte7F/l2DHEIF4mUNRyJqB/5IfimpctFhOX+SeKdYgyL6nLepp7LoczM+bKKTbPLS+chhBZY+IxXkWu8yBFPY7txjc8VnQF1KUD7S9to7cVXhwOErmh3Z2+KHK4z9HYCRmXgfQgrA6haOPk3KzRbSp6qgEQOlfgAGV0Eh2PFeNk5MNi8P2XUnaiZhw6GxM7Fh2X6wBXDO+HFTxIm+64kWrxU2ioCvjYvBt9YsYmkcasBdrap+CmDizlC6crBhpGVxJ6qFYPNb1UWSJpAXY8lCfppjXBVJiAg9rrRgibJjtwwEzKqC+lY3SMEKd0TtI/lVJS6YHM7iUkGQeLzqktFPSlOlN7DHakypIIpY8D2DiYezigSQ58AXoEtrSGQ5jnAKKtE0JokCsuGrKFnmXk+HR62urjmtLmaj+bW0sbGInj6Afd1nS4Th9Ni3JICEQVnbLnEKHOj6I7TU65P/d6rebF6zGkOXq5RfDl3Mbqfm5/JCSgUHmC5r5cn7VOt7Q5TqNWA+6ObjmLwlxBUCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199021)(33716001)(2906002)(66556008)(478600001)(54906003)(8936002)(4744005)(41300700001)(7416002)(6486002)(44832011)(66946007)(4326008)(66476007)(6916009)(8676002)(316002)(6512007)(966005)(38100700002)(5660300002)(6666004)(86362001)(9686003)(6506007)(26005)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLdpY8MMUgHedugnqBR5yqyJYdRYETTsU2KcjBR9Nn9QEYBaR9G4Ai3GINM9?=
 =?us-ascii?Q?WA3kBIdf8zHGTonNANEJcNy/EVfEAtcMYzO/EfmXVpUIE7dVBZ1Cdu+naLM9?=
 =?us-ascii?Q?rR7L6BYfh+RhJbq7Wm/IO0X7u6Lur0TYSH9WDkfMyTrZnwGcB6zvLP1Yk1YT?=
 =?us-ascii?Q?IgJTZoJ2WroRMoyaD4fGtBdCXyCiNSbIFNYvAL9mja88IIb5Lr1gSmEOZZ5W?=
 =?us-ascii?Q?stMmSFCu7ib37xkcgLIsdxmKeXphPnDGq8Yv8a0Y43CagPdaofVlQjsKfjoM?=
 =?us-ascii?Q?A9ovSFTI95kz9lZHN/nLIjdKi0uerYY8kySV9Xlz+8tKwQHllLYv2KA+xFI7?=
 =?us-ascii?Q?dCoJrHyFNxPO8D95CvtsSvty8RQXY3x8fJI0QMY0IBQ8G9EkBY4wxhoPE2HE?=
 =?us-ascii?Q?K4DFh8jr3qU8g1jIQwSHnLsfsHsGWsVT1ccu3ETl9z4Id9trDosdzD6bNkTc?=
 =?us-ascii?Q?lUf2JS6qsphcvxIQc0ofRtnul0KfOpQDx6a8tab2Bzz83/5pXfjpFua8RsOR?=
 =?us-ascii?Q?qX6b7bhqYI1/lRWerq/9yPKRo7VJcF8fokyWQJ9Z891tJq5kZTH8PX98TvXm?=
 =?us-ascii?Q?W7Gl/yQD5tN2YKYLsOj90MT4yf74nFMhvkxlyFC7CqyHSLrZDRIQhYfMd56w?=
 =?us-ascii?Q?bOBrl8QFH+VMgbTNyIXHn6LeZGg2AE76sTnBSHNt4I84r+xN+lQQnAlQ7D/r?=
 =?us-ascii?Q?1QPa3d4rjWK/kD+8778qUjaX/tVGEfAd0eAhj69s7JdLYN6H2Zh4lo6wEvxX?=
 =?us-ascii?Q?jY+SJNKI5oPB01gvVnp6ltI3o9JeTuImh6caM9fU3vzcLKb66YJrv2JMhvuN?=
 =?us-ascii?Q?8N8fxUiP5RPrnpeaYEaClsLf3x/p+kKAz31rcEhRTtFbZpOxBFQ1x7YQw1gL?=
 =?us-ascii?Q?tySkAj4dRW/Smctzi4xk56qcstR9mbGF4e3BOaCDLMuc4u1KPR/Dtc1UnZgP?=
 =?us-ascii?Q?oEYNsbXPw/ljnPqsNEeykjyqwTGUnODkqPaTEtiiKp1MKIQq9V+TMNEicW70?=
 =?us-ascii?Q?GxXJAk0pkqKJeG4NXh2FLDJ5FSPGB30HZzxS9gMmotOe8gaTk7RU9BdbMcRy?=
 =?us-ascii?Q?L/8Xb2Lqwge1834XbYpsZw7BxkZLiCCq+HvqJoNEFVSjePPwFJyCpm4rsyL6?=
 =?us-ascii?Q?mOVx1N61D6Tux5e8IMpNHHxFnUFaWZUnKzudmP43tBBpUJ34VN3iBHJiUyKx?=
 =?us-ascii?Q?+PJmIUWet9mcomEK3TLU+vr3CvHu2s6IU7iQixxkTS4OHF+4MII7YJpRUXiM?=
 =?us-ascii?Q?5hKemZDjQaJcmuE1W3hseftDhVVjsc1P6pcv7bncoPypa7rCNBozj+KOnYIU?=
 =?us-ascii?Q?TqwxvvgTjn1CgIMMUXZeTV6TPj3hTNubvL4HDZLQiQUD1snf2+46ND9gsrEV?=
 =?us-ascii?Q?ftZISEHDPpXFwsclBUnIt8rU3lNDuhdxTvZh/nf8CzBsztEbl1gSroJm/h0v?=
 =?us-ascii?Q?VJwBwxft2npTi76MEPzSsiy2vpvMEefLXYXoabUz5OdT11yC5LbJ7zK6r6MK?=
 =?us-ascii?Q?ZEQsVu5GJ2+b0BOY9WCCcGVv/RSLbJR4s0B0kVvVkZ1EgUqJ+o6HBx64RMef?=
 =?us-ascii?Q?r6hKeCQV1OqUTHWTmkgFMaBnCcoXp64AqtM33kA7/aF+cLKdA6VR9TxTcmmp?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5410b131-2dc2-43b5-9c9e-08db86b88c97
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:25:39.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKqHIqECTYDIpjaiDGR4AZVwHTHt+55m5WX4abbkLOfkZ+p0oQ9IDmqBcI66UFmN4BjKBYIzKxSPaO+pckRVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim,

On Sun, Jul 16, 2023 at 07:22:23PM -0600, Max Georgiev wrote:
> Vladimir, thank you for taking over and improving this patch stack!
> 
> I see you dropped the netdevsim patch:
> https://www.spinics.net/lists/netdev/msg901378.html
> Do you believe it's not useful any more since the rest of the
> patches in the stack were tested through other means?

I just didn't consider that adding mock hardware timestamping support to
netdevsim was necessary or useful, considering the number of other driver
conversions that will have to be submitted. Just an extra, avoidable effort
for me.
