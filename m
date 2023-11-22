Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245A7F48C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjKVOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjKVOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:20:07 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F6D59;
        Wed, 22 Nov 2023 06:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9DvrydSUhOphKj+Q8Ed275jCqP8WNA6r7sMtLGDb0FejyLf4lcFq78M263wbvJoZ4nX78XhEEeH0Jcm+feypMTBUuX6o53dqirhR1sZdWK8I6FTN9XD+D0aBEpkc5SuhHZnW6rWrYlzHDyuEYjFYJbigm8FZTa3jycVACgjLNpQHBV2Dd8Lprir0lwr/oEXo7C7+8X3C+rgDMU6FMIKPIOnSgC1jrL9S+VsPyitKywKufWG4A++duTgwhb8WDRF3iAGHz8oLXVBI6s+JQgzLZpVsiETMmSysJAw5ywgFmRBJRPyV21J0bguP5QeQ7b7HrVAGRCAeDGvnXDyDjkRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik45CBBHo0WvXAk/+9NMsZcrPQkrfTPEAunpSlZksnw=;
 b=WNo4PCM79cLBuQghKTCRuUZMs2u3aoEr0YuBI4bTiY34tJQ53H7BXpnafYku4Of00Gf3ORrFYHykYhLbTxvb21FzBIWWDoOOsE9e0hKUpGRWJZakuqm9e6BbemRdMVCKowfRDJ6BaVbysZUE9PrLFatlnjhI7m39DE5tujFEgj6eUoM16tpY6uEgtu+4BkmzsU/YAjrXjzK/n3kfB9opCHD9J2jiXt+eju+NEK/o4j8J3ytPEDG55mxwiVjLEagRx0WaenQwQbzl4TOPDEFPtGXFyrmsafIgmEf95i2N57mI4xrzAq0vsnDx5I2U5UZK2tkX1OaMON2c6dPn5vy19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik45CBBHo0WvXAk/+9NMsZcrPQkrfTPEAunpSlZksnw=;
 b=NYjQsM/0GHdgJp+j59FUx4tTLIif63JgsCSGGyX8GAHFUY1p+Zyta+0X0E1ZBjPWv/bvwmGYgkkx7ybV32w8O8oKF+lqGHyCjwT1GDstDpx2A6HcTcyPetfljmI6TlfW1zhUNh/LrtW5F4DaWZIviekZ2EKrCm8h5VMlZY8MSEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 14:20:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 14:20:00 +0000
Date:   Wed, 22 Nov 2023 16:19:55 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231122141955.vx6gb4a47jr3bhal@skbuf>
References: <20231120093723.4d88fb2a@kernel.org>
 <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
 <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122140850.li2mvf6tpo3f2fhh@skbuf>
X-ClientProxiedBy: AM9P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::33) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 008e5905-e3dc-4513-6f63-08dbeb661c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcqLlS3eMxFIeJxJpJsMXRJ1PGtn0tDBlUAhjKcz2veVxfptQfQzVj4VMpmK1bxkpz7WjIWdk0Z/iwbT3EQZwfUuKmT+6337+onPUqTmtIbQ42RAjQqS9/dNt4fuSiHF1bxKJXh2/WJiqyb8Vkf/siw+D5uz2woPEE52DiItAtJqwvjrsd6UKAy2F+1ASrPLikd6m0sb4IRMwInchpRq+9bRHt+Wq+J0IYjvkO8JlnJ38UaDV0LDCgcrQ5Z3B6fgPtn9YXv6PBUGf5HE/qo4beyub9JeizWBsFoDLtbDwxZlg7h35iX9MkNvHok6vxtKRFEv+RbEI15X2saPsKe9RSlrQu4g35lkHkeZbL39z5Q/NLvDIxm/BFHRP29peHYK27I5z3R0bZOC9szver6WjzCog8Zf6wQcIKTmvdm/jAs9KVOicwmaf/afoNiKROcvXDEVBHiKzYvD8Q3GVdiYy6YUOqOhjs+mtoqGLtgi3pk8umOx6cCgr/Lq9pT1a04iv0X++ANghwj0EBXxRucLbbVeQrf5D7DRKFsX76elk5qe3KM447o6Add0vNzO0XSH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(478600001)(26005)(6512007)(9686003)(6506007)(33716001)(6666004)(316002)(66556008)(66476007)(54906003)(66946007)(6916009)(1076003)(38100700002)(8936002)(8676002)(4326008)(2906002)(5660300002)(7416002)(4744005)(41300700001)(86362001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8UrAe0maRwumCphx2MijaFhWOBogc7fPw/j/72JwGA9ToLE2cKEwELqmjsz?=
 =?us-ascii?Q?MuaygJMRzg2HqkYAbTP22/QfAY1KQK6EFIorsgH5Pv5NNFctohz4ZKNzpDy3?=
 =?us-ascii?Q?PHHbnjXkBMqTXC11KSY1D2Isw48fdJ/OQdV252GBps9M+siaKlF3Zze/9+XH?=
 =?us-ascii?Q?8/T0B/6noIjSm/EhjdqZ49LThogFltxsbHoCR+BS1EFUh9iBLW7ox6LlK8Gf?=
 =?us-ascii?Q?Kr6z0luVAKQoVL5gJZmd1HgbRFURh8rbzvtwDGkrHk0jiIOkei3x1XPA/UTh?=
 =?us-ascii?Q?HkHNWttzMgrsIY/Lxy3Cbt6+ZNMYFs+a7gu5PvbNnUrEw7c6znmTFmX+npQI?=
 =?us-ascii?Q?VhQL4w5Rqh++tB2U7GY7U33EcYtGa9ULG5vigBIZYLLrVDPbRpfdNu1qYr4C?=
 =?us-ascii?Q?theRrF1buncb08b6rp+0j5EVzZ33yUh5D48VOtvlkDECXXyjzErEEuEHksZE?=
 =?us-ascii?Q?iz+ZGp/krBEaJZG6eeHs8mcFfqFmaPQx+Sw1HONmkD6cwzoe4vfDN0p4uCSh?=
 =?us-ascii?Q?Sp6P1V1eI1833GgcqUvMelq6f9mPwdfDOsNaIHngIlELkp7ebX9Q5rul5W/k?=
 =?us-ascii?Q?MZZgAoAbsOcfyRsIy5EUSHy6DwOLTMUBbw39R87AjzNLM1492GQl4Ao6IRPw?=
 =?us-ascii?Q?eOIe+WPoEjTr/TqIsIoLhBQ+PdZpFGnld3PHXwQpQyRzprh6DveVoe0PBKku?=
 =?us-ascii?Q?u8Lex/sRmPYreF06lhPd89qj2s2jq+n/xb54GqxhVBN/Bv0ARueKJl87tAbO?=
 =?us-ascii?Q?zpPvzbFxVcdjf9uz0KqvgixqSlHygS4yMyf+Qhr2jRyh4t79y9zWm05b71NY?=
 =?us-ascii?Q?xl5NEQoIdHO5ImV//8IgOZ3bbEql4TG+X14jhyY2K5+2heu/QOOF/x2bZ4h5?=
 =?us-ascii?Q?0Lskartpgnbw4mIRyiErJtdKYw3s+ysH4bwy7AsafZ0LV2DLFaj1N7rC8cFl?=
 =?us-ascii?Q?rKYBgSgejwrgugOWP5M5bncFx1kXWDEMEW58Muwi2jKNr/Sj6vQjReIzdkO/?=
 =?us-ascii?Q?8vgXAOL8RUMgZAHFKrEoiFinqogHxYA/VqZ9KqKkFlmRY1TcHyfd2DvD/RXh?=
 =?us-ascii?Q?lzk0+UrEuU2QqpinDArmnBADPZ574bpqW0c3YGK1Zjle3N2DvNluOongpW98?=
 =?us-ascii?Q?FlfiuZYzLyQZhtNWh+w8ZcdmuYe6NrnUZQBnvs0HVN24o3RFxrHqCm7H6oRO?=
 =?us-ascii?Q?Ext7z2i+qeh2E+xvflftXmZDGV95xVpYLb92kgfsjPZnkwkZVB18fBVBt5TB?=
 =?us-ascii?Q?QPHiL02NCuxrHH30fiwltRR+uJ9U74iu2lAwVkPANKxl7B+smtZYwUDq5aZq?=
 =?us-ascii?Q?uiQlYJGXSUjXSsrgnfNsxo1gymEFdIPd89v0aAX4bW8iGOznMKU20QAX89hv?=
 =?us-ascii?Q?sAPGDiGZjDRoqRxVjN3hp0CckiR2zbPbJYIehqhk9BSO2IfQVvkeZalGrLUM?=
 =?us-ascii?Q?QhHDVqJx0FTPbKwpqBw2/CVz2lcUxl4k+D9nVGwLo1ix1VonDqLZ+JCuewLi?=
 =?us-ascii?Q?LptY8XWh8/xFmESnabeDYpYGA9LGnavO4wrU6DDs1pdpNoBAzU5JiFJlJzbc?=
 =?us-ascii?Q?1bcUlEx2Wm8SMMHDl+kqqSYBW+7OrqMr3ObqwHQiQvkEaDx//HgeQxMX4EkQ?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008e5905-e3dc-4513-6f63-08dbeb661c99
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 14:20:00.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UC3L/3ERzRLCyTWvbBVlQFgRhh9lu6qGEEXLzd2aZ2T+XwXNAktD5AbP+Ska90LXCT+5r3Szje1bXkJ3BdkbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:08:50PM +0200, Vladimir Oltean wrote:
> The concept of an "active phc_index" would not explicitly exist in the
> UAPI. Thus I'm not sure what's with this TSINFO_SET being floated around.
> The only thing would exist is a configurable rx_filter and tx_type per
> hwtstamp provider (aka "{phc_index, qualifier}"). User space will have
> to learn to select the hwtstamp provider it wants to configure through
> netlink, and use for its class of traffic.

One clarification: the extended timestamping filters are PER NETDEV
(in addition to being per one of the hwtstamp providers listed for that
netdev). This was understated from the fact that the netlink interface
itself targets a netdev, but I didn't say it explicitly.
