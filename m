Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333AF7F4D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbjKVQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbjKVQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:55:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E239197;
        Wed, 22 Nov 2023 08:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCjKgZc7l7ROGmaDYkLoEh6IxvZlOdnrhua476vWM2JKRLxqxwerSQSXNn9XzyXWlKpsOfKoHK3CCimvzZOcZOKOIlafe3gkEjk8br0Pb+ea7rpkHrysJlIrTbAJXDERGbwdLDVJoZRcrqJ2zHDaSfuGDAd4eoQtgSrW48aEWPyLqjDqLToGrdrHYC6k63OuvWIj7xkNMZGAR4lKSuoRWFTDuMlyz+rqg+SlZ4yQFpC0sjVdb6PtA6oUackPZKGTqxktHgpzhIRuaPBYlqnO30BGPoRYOjSTRmKMOBYjLrbnpONz2lOrUGUAKQOAPd+0gmsvW1jGfUMu00e965njJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC6/CCI19y3mej7aCljpwZtqahgDY7XfvYwJKEZSQ6E=;
 b=iQujh0BJb7YSsMz5n1m2dFQWMn+yndNjVW5/WdFpAvwxdUxxGPCLyzu84vhRZxhLflnXxv7pIvg+tXCzX0kZsPmTiLMxmjypGkW/qKdKZ6OC1NtpZs6M4Sz1HPaq61o7XuzETCbGdl46QOfXB+CurrmpQKvv1Ukb1AqMT7CCfrKjxDeXWIZ7tOmrBDkzlm0ndCWFb+Yxc26+6iO2gecAjLOOO27b4oFPUEK2noIrR0Sj2sXkchEF1jvUBwzrWPcqFy5tBfedytcpNiQhViLFTwPw1NETAgrBPtNsd02z3cdGHKlR1rdd5yvNqN362Jwrk3MCYxK6hq16stgiCf0HWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC6/CCI19y3mej7aCljpwZtqahgDY7XfvYwJKEZSQ6E=;
 b=Y93y0woHp/80uAmmcvvRlNmVjbengLd5rrtKPDBBu7kHUhajzXISTrc5sa4cUZOBzf5fsP+ETaPze885LahQqcVLFEgF3saAAiEYIzkF1QHYDxrbTjw01S45h88DfRmdy1TC0D/lK4B+zH3KwtMiQkHUti83DshH+k+xpEMgrzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 16:55:22 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 16:55:22 +0000
Date:   Wed, 22 Nov 2023 18:55:17 +0200
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
Message-ID: <20231122165517.5cqqfor3zjqgyoow@skbuf>
References: <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
 <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122085000.79f2d14c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122085000.79f2d14c@kernel.org>
X-ClientProxiedBy: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 655750a6-22e2-4e4a-12be-08dbeb7bd0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnDAdwnE2LhK6++6JLUrMzwkqaOaIarRtMxlKc2opeKCRm3nBWw62UW3azmBmDDgFUtPK4iqCRS27/d4EtIMHkg13b8zjpOAxWF3rhiwZw+Mk5AEbGH/m6etupuYNoepX7kcP+VUmo0+s6VwrGXGnJ538eqtAd6/ekNqo+RmwVFIzFFkWf9kxw/vLpkfbbM5M4XTOgatbWs73bZUdZDQXu3BChbwNXlRzkjqKYL8BqgsG1RlwZGyHkk7JUfMIdRPqUyQxhRMki1PYI/gnAjS5Hb/pD473n6fvgud71iteJzHmtU8ayB9yMOkVNL5sGOQ4cN+ZzbK6in5dZRF80Qu7kwTc4hNyJlTbNrPlAJACpctehbbGD14Bek0gTPwJvZr6QP11pxdxljcUG8kUNeyupkHtN+m7Cx0vdamO+SzhFiOnydhB4nKA0XQp77gX/gxeJn+Mj2xLDwJbSkfP5dp1Ngt7ei5iFPNn9mEqOdPi8MhDPBRiznnokGq3jzGuIWDjT3OFF3oUBtiRyyCN3qpofRGl+QAkbBVhsUz3o+QoIbB5Z6J0cvcuasjjSVGgrVA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66899024)(1076003)(478600001)(6666004)(6486002)(9686003)(6512007)(6506007)(38100700002)(86362001)(5660300002)(2906002)(41300700001)(33716001)(66476007)(7416002)(83380400001)(6916009)(26005)(44832011)(66946007)(8676002)(8936002)(316002)(54906003)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2a9pjJXkd7w0PzD98IUjLNi91LCnddJfo3/oKfF0F4IhCeLgkR+r7zIXoNs?=
 =?us-ascii?Q?gWWe+6/PshIkMptkSebLYB+/uJmAjEo451bECyKpBD+EV210h4L7GawZISoB?=
 =?us-ascii?Q?kIgZoMMUO3ErIdX4gTr4yPaQIY3PQZyMLzwM38Rg8SuVTLH8Z5QoPH/MjgaU?=
 =?us-ascii?Q?Rr1WzFmUmaJNnWrS5gK7LDwOnACZ+w+l62vyrPgFIIARgqXVFmQvkdwbF1+Z?=
 =?us-ascii?Q?doVf7Vb+/pBC7Mp8OE2OEY+Vh2gGTVRXlzYWwT2m3CZU42f/nCKywn1sFinI?=
 =?us-ascii?Q?QZy0u1kZDKEgMLyROjUqL2aVMuMOsmyy4BOyobpc61YYEFWYgH6FsWWorysi?=
 =?us-ascii?Q?rH2VoMR8nR8g2nvqYsPV3his0DgYwloIJYEBnwGYrSa3Z6nMG7IA1bjLZOUO?=
 =?us-ascii?Q?Dm4U0h9aAIIWKOFJm9nxyyfHci74oY2XkNr+5Txl9BvkPncuba6NanoBqnjd?=
 =?us-ascii?Q?tX5fnGYm4FE9/UwSKmypghW7P2WkMz+x1fMnMQX0uVzhT0/v5u3rR3jPZJw1?=
 =?us-ascii?Q?fQ8hgqV3m9lrrpdvD4Q5HUNUpaWLUX3hvHBV/xXUYU3KSdW46dysI272WWyW?=
 =?us-ascii?Q?u80RkuDCG/ngAi1vaZbG4Cs5XYvhT5KPGrJBQd3KpXAAm7EnbDkgJY92u/xW?=
 =?us-ascii?Q?FpSVTc4QfvEW3yu5o3gB5osfjGHNaKnirLDmD3LAXx2MX1iWq88uaggU20eD?=
 =?us-ascii?Q?4j/yLXzJ2oiTEm3GQpp4D8qSVpAPkEnby7dPeqye7q7GLLXWpDgWkf752oH7?=
 =?us-ascii?Q?8Kgk/oJfZMYuM9FYzyVSKL1KKLqWApwLMyZ7MxzXoe+T2e9bZRbNoU1dtWhb?=
 =?us-ascii?Q?Pqz9NqaoCzULwwaVu7gcaqDIck9y9NJVGrk7b70CBnS8krIhaM/NWetcckSI?=
 =?us-ascii?Q?zbvp/cvLfyFhk/NrL7jCnUZ0L2vvEF2rUPA7u1/O/5AqpfS/E4YlMb7QKkiG?=
 =?us-ascii?Q?LrSm715ysZ6EjohKzzkXMt8yWpx1QAaQjh2AHVAqZXNbpZPrJPp00oBuIFcA?=
 =?us-ascii?Q?cpkUtCxTxX65AuOnIDc7dDz421sVQMlaXC06iUwU3JUWtnDZlRrLvze7aFAz?=
 =?us-ascii?Q?+s5ghFDRKAjZ1VHQ0AGZc2GH0tLvihGemEJguaRg8k5dduD7CEWs1JCQ/6bN?=
 =?us-ascii?Q?ZXto90244/fZLtfcLl3AqlF8copysWDruvgDqyrZgpEmpfalmbNoZ6AlH97m?=
 =?us-ascii?Q?nKSTXiYy99BHVXi26Uv2FylVn1YN7cVqQOb0DzSXMxp1DVJYZhWV/lJ+eyRI?=
 =?us-ascii?Q?3u8w+E7DN1Tv+6PjKZSEWm3YYWcW1m3kzAlqq6LByJlWgBYn/GsV48Z3LHuh?=
 =?us-ascii?Q?Py+7kuo3AomiNpsculy3bNqrfpZ6d9MvGUtHkxWll4+knKilZonUtcWxhzUJ?=
 =?us-ascii?Q?47ht2fZ+465SC4Qk+o5xPjX2aywU1FaGNXqNkqiJ0JNgfGykGqGlRf2UjZ2W?=
 =?us-ascii?Q?Yu+kKfed4RNyCfLsmDVmTiNTOdFbvoCdUBqfxW2PlZpYEJ6WtdwMMJ6s1t9V?=
 =?us-ascii?Q?xYIRdcYqiVTOAbOt0OOtzkBST6eCwEjwI8PkD4ZAlFepjSA2kuAHve8kUaUY?=
 =?us-ascii?Q?CoUcfNDmr62X5lH0uQiGSs42eZ44EBfL8/vk5r51c1fzw9vPi6SBZf6ThN6U?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655750a6-22e2-4e4a-12be-08dbeb7bd0de
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 16:55:22.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP1vdJCu7pWdcvSuBO06iqVbMRd5UuE1/W7O/X3H+p2AMqpadhh3QbYp0tDlFldbk5/WCkuViEobpoOrbKsDog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:50:00AM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 16:08:50 +0200 Vladimir Oltean wrote:
> > My understanding of Jakub's email was that he wants to see the functionality
> > offered by SIOCGHWTSTAMP and SIOCSHWTSTAMP converted to netlink. I don't
> > think that ethtool is the correct netlink family for that, given that
> > these aren't ethtool ioctls to begin with. Maybe the new netdev netlink
> > family. The conversion in its basic form would offer exactly the same
> > functionality.
> 
> Well, ethtool has been the catch all for a lot of random things
> for the longest time. The question is whether we want to extend
> ETHTOOL_GET_TS_INFO or add a third API somewhere else. And if we
> do - do we also duplicate the functionality of ETHTOOL_GET_TS_INFO
> (i.e. getting capabilities)?
> 
> My vote is that keeping it in ethtool is less bad than 3rd API.

With SIOCSHWTSTAMP also implemented by CAN (and presumably also by
wireless in the future), I do wonder whether ethtool is the right place
for the netlink conversion.

I wouldn't suggest duplicating ETHTOOL_GET_TS_INFO towards the netdev
netlink family.

> > The concept of an "active phc_index" would not explicitly exist in the
> > UAPI. Thus I'm not sure what's with this TSINFO_SET being floated around.
> > The only thing would exist is a configurable rx_filter and tx_type per
> > hwtstamp provider (aka "{phc_index, qualifier}"). User space will have
> > to learn to select the hwtstamp provider it wants to configure through
> > netlink, and use for its class of traffic.
> 
> "Active provider" is the one that has TX_ON, rx != FILTER_NONE, right?

In the "implicit" definition of an "active hwtstamp provider", yes.
