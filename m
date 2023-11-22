Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4317F4915
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjKVOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:36:31 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5C195;
        Wed, 22 Nov 2023 06:36:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So8MlTBTG6E5nsy83l6+pTw1jOLpRCprvJlzCkHv1ALxipUcJ+RdfbLFfIoznKT0biQuuTzRdBzXhrJ1vOzvBBLehgYi49dxGCEKkfWAVlsDB/c0L+dugVU0YhB44mtwGtG0XKo/cnvJlp28C80OBuAmeXsyxZKW5TjFySUj7uPkLV7glHcCbaD5JTDWFVfqJ1OV/EOdwi/s2s3n0IerH4aliOzN3xlKJ9l3TeQwKJQ2+TwNLcFZTaOOE3hIyfISGl4vxzq/UwVLgbYISepgdCQFRqOO46H+ueOWvSLaFRdWq7liXI/v7yj1ocCy76w33jkuU05hzZkXQtow+SuXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8VF5+MnoOSLiu7kBZlwEDsN476yIgyikWe3UFelqvA=;
 b=d38jia9rQiuf2dkrvc4qnHZlqb6R8AfVHZOIqetzhDNHSicPHJ9cXF4LYkvqLNDq8VM42Vbb1edaD71fE/CZTta37/BS37VK7l6Qb00HST+3Ah4QlbGFyqTjlvv7II86e4h8AVn66kYR10DaOGLNEeXYe42h94A1c89EsoQ6NLZqKPG5r5hQhZ50mtBrsk7NaKlNEsi0plxTJoExy0Tk112W2D3DB6VHtzgk55aAua73qaX0BUJTUbhRjHZXx8zJdRuxq1oJNADWYId7Ufn3o02m2rH5w7P7VZs5/icGw+jl4vO6hKU8fjsCoVXhOVW8BdCDoMJRXjwoNtxqRib8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8VF5+MnoOSLiu7kBZlwEDsN476yIgyikWe3UFelqvA=;
 b=SnKXvaAgTNYwussBTrJcDY5ZJHUMlJmUW4ZCm/BhO8LeaRmT2EaU29MkvFPGt6JLgE/DlKPQDhWjgt/q81CUQKzmbY9tMEqvFtQ3mW990vSt5Ay73UDpfwDPzBRHzJoeq3pr33ai0aKErJTUr9OtLmKkZP1kTesAJcnYUkRnsM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 14:36:23 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 14:36:23 +0000
Date:   Wed, 22 Nov 2023 16:36:18 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
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
Message-ID: <20231122143618.cqyb45po7bon2xzg@skbuf>
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
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5d6e82-d157-41b4-b00f-08dbeb68663e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5P2UEf3aI9fbQP7Pshjla4valB/CxpBhdGyqd+hHG4/OHxnEG5huXZteyOqcmRfyF8m6ujTcJM8hwp/iTRlLMQ50UVyBBenxdmG9r/jtVJYbrq9W+f/M6gWs4YSmHtuMDwm0ysvGh9aMQW38XOGBJNkw9K4z9y0tjITnL4ni3Ti2Sz76BZwG8gfBvljdqLVTmScpCS5XuZsWb+lYUNkIblfy62HX41hmEZv2hx0InIhByaEbGrLXHMU0aa5P4419j0mAkxbEvQWhWL6gdsf7G86PzLvh72WVeeGkeQi1t+DwSN5x2Scfd9FytKuwRQjzfPI++TvpXxYy9fJWlN74RbXd8DZf/sTl38zljk4kGsy4ScIzEuJF2yN7mKMg3B0tFLATQ6lQRZaZTyVMKHHK90s0uZZ7pl2S7QZsmYSElFhMBYHw9AoTLk1N0461j8WKDzYi5v4fgsaUU6lZJPjbNmZ/CdmePaToubyy/9KA497B7m2zg3CXS+kk3K48rWTCsuc3l9ls0CsJ+4wViL1RGQ6koeLyprz25ztA5WLsDJWvF4r2bhNQc0k+RppXi4m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(9686003)(6512007)(1076003)(86362001)(38100700002)(7416002)(5660300002)(44832011)(2906002)(6666004)(478600001)(6506007)(54906003)(6916009)(8676002)(316002)(66476007)(4326008)(41300700001)(66946007)(33716001)(6486002)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOabux9UycFeWONqiGe4ylLVp44WGFRcGHKaCpJKgdriHL3ph0IWYLwZ5HTg?=
 =?us-ascii?Q?0x7zXyAyyxYC5kEvD0htEuxjfRHXJzHf4OcJxrwtwMWRpwnDSsXX1vPFAba6?=
 =?us-ascii?Q?2XejtRULfdsbBl8/82gwJYjnjRIdCSeilIi+6bpLNRe7rmNVW5+Q7XVQ+QW4?=
 =?us-ascii?Q?BcJyuVm7TCyjAK/Xv6/oqGhhni6bie2y0xE1XnXZMbbp6Rl2gk6euO8qOu9b?=
 =?us-ascii?Q?/pP8cHGH4BjgfE/HydvrXm8YckIo2LIoG5lQrCMOC3IZ35ulZNvKpuvypehn?=
 =?us-ascii?Q?MxyS6lIQpzladffCa9fgHhooUX1KMCMJceuVQeaERd9m1OvUrCDB8QtrtwoW?=
 =?us-ascii?Q?hkwPHWhV98ueOZzvzMMl5dsfI8mZZ6bJsq/IapFIIhFJ8EDw4M00V1lNX5P7?=
 =?us-ascii?Q?D6ghSuUUScZImlCgp/arMNbcFWkIgl+xdg8Ks9QPrw97VsyAM98laJEFUwco?=
 =?us-ascii?Q?DmDzHRsi1y8MOJW/a2VL3dc3hjWLl1akPA55QkMwX7v7/5Dlg/O+riMpK23D?=
 =?us-ascii?Q?/Py3DZPlkQ61HeTZuddqQ4HiQhfl5dorLs3gP2FqiF4xZjBGB/Zb/scCtVML?=
 =?us-ascii?Q?35IR/BugYkHbHjyab62SbRBKjwk6vTc41eLhElY1PCUC8YXCe3tDr6VpdqVq?=
 =?us-ascii?Q?pSHTa0iQNR3M/L7pGdjmOFB4p+BkQIm+s8Ihpc1FKWq1hnToAp1FhZ2WmFVv?=
 =?us-ascii?Q?iNDGx9wIfvPSQWDvvn37kNOxJKGrkkrDg10un6YYwPobj5PbzzBwTwXJWgLT?=
 =?us-ascii?Q?mDmEQOUw9VHJzVsp5eIDG6+hwt8Cmc3vHAa/bgLCzgvdzZguo1ysoRtwXHBB?=
 =?us-ascii?Q?mB7cQd91ZMV3a5PC/4sKwfkgdd4eWW7pAVK9O/Mxd+NwCGSKzl42duuj+myg?=
 =?us-ascii?Q?RGj0EcP87n/xsHu9nNkSwwWe+0np3w0dXCxNR9ASosUcHmHe2g6onwcWjYA6?=
 =?us-ascii?Q?FJ5v2TJWuTTQp4fwgybyCD1d5zD5hJDlwlVU5fLB2IahGlnGQURdMUdScnUp?=
 =?us-ascii?Q?1HfV4jnTB2uex0zJK5p8M8B9i6O7GhGOYC2eBzHTiSzlK6WgZ4unJA2Zd/E+?=
 =?us-ascii?Q?ikVOzMakz7uLvWbAc2+0ZtRpQtSX6/OyrlKofE2dH4sLiF8L8E8CTojM7Wdg?=
 =?us-ascii?Q?w+xJ1tV19xCPeixBa8lzUNqaFwiJr597/DB1/98lWe5iaBghk7lRDCBICbdE?=
 =?us-ascii?Q?sLytabVbt3OXhOQE/tm/iwuhif1s3BiBkamjVq6+qo3pUXYcWSCJhZV0q8gj?=
 =?us-ascii?Q?VRwpSYwQwqLje08sPE5JlDIz2l5z1fNSMST1R0CY8JD+C9OfZQLngVjb6ICp?=
 =?us-ascii?Q?2zVpdm9VKxC40Z4OgWpL1UcjwnMh0jJa644Qh2UjbJS80DdulHG0XGVizW/0?=
 =?us-ascii?Q?JT9nwYFQ5Dp9t5emkRin8lW0CVHQy338JDgIGWab+IeE7u7DvWEPI2aQwQjl?=
 =?us-ascii?Q?ZeH7fokIpegShhtoiH2jk+e6BaJABtamFMbKBmUR3OMeg118e9YAZsp04oaq?=
 =?us-ascii?Q?iXNI8hAKl+j219J7b0l0+PZ2jyDTQFGDf2ihF7ehuykG75gYjlsmfaRxoZwM?=
 =?us-ascii?Q?LoyM4NTr0O2/nU/65IPv57Lu2NE2SQBim3si9JrIy7FTBJV/cQVrXVDPdgur?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5d6e82-d157-41b4-b00f-08dbeb68663e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 14:36:22.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMbuoro59UvgBDqFGmY9CR0zQFyl0nAYJcxGSFLG8isIvNW8h7Y3cb6TesBTaR6nLnfMGRbhZpkDPkG7VPFsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
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

@Jakub, for your long-term "MAC timestamps for PTP, DMA for everything else".
How do you see this? I guess we need some sort of priority function in
the UAPI between hwtstamp providers.

And even with that, I think the enums that we currently have for filters
are not specific enough. The most we could expose is:

                      MAC provider                      DMA provider

hwtstamp_rx_filters   HWTSTAMP_FILTER_PTP_V2_EVENT      HWTSTAMP_FILTER_ALL
tx_type               HWTSTAMP_TX_ON                    HWTSTAMP_TX_ON

but it isn't clear: for PTP, does the DMA provider give you an RX
timestamp too? What about a TX timestamp?
