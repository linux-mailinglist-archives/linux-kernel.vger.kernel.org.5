Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392C3756197
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGQL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGQL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:29:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84B10CF;
        Mon, 17 Jul 2023 04:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHixzWjuvVTyCS1Vr/vAdnxg/0qOXukbR0e617kChUzuFcHc5efbQBjVOSza3vyBQn7x9wvwRI9ZsPAINl0KpVuYQd4lXFBcN6ke1e57EA+77hs4Z0BDbWAl713eQZjT+wMKlzvCqqZcnZrQl0raHTiYjJhW2uxnT6TUSJjaUH839eAv/k6haMpkdFTNRvW2Ll8GFy1rSs7BvggJbj8QRxsm7lZQVeQC0MDbpd6Gz1nu2IILs7WVF/FhCC+Xn5vef4SnVK9x3X4VoIQHoSBF0ZXKyeowsZEB7EuwdpwJH6qmfYWT59BK09+lyxxWGPb/eDLCu5+kuF/XtMnf/oILqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9V743ZO6U8LY0u5I43oLOfZ8oeUivAcSWYWn8G8y38=;
 b=H29hZk+6QwIqpfHfcRf1bBL0CFL/ObqdiCKW1bGj2FFeOhBN9ed6jUP8ZKTa7pZJT8nOl7kjeYVaY1DPhPQzcqrloFAB/ay7q+ZLpMS3j1RVjASOsb8/IlQlOTlPEUik3H5lNSXpCFqaiBgh64T99u0OCgBWZTFJtiBdE9P541N0fdEwtf9VsBredPTILnaCKpJDNCyiN+6qDqL+GG3gNgAgF3QNAx6924F1I7O6sFjrbNvgL3TZXIQoFLsucQ5faSjElK4GarN1SMJjv7i02m3cCS5vCLMvdBTeyI/9fMaim22xxP4iKEIwAapo9TVglLj6LfV0gNihNGg1XTp7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9V743ZO6U8LY0u5I43oLOfZ8oeUivAcSWYWn8G8y38=;
 b=KlECTSJP3cVPJ7PzbKdufmI/tH+5c2rZsn5Y3dPdrpGd7pnRUrFqssEyr56YsgdeH6hqweMVCw3kytKMEuqV/rxL4Env697ZTPpCA1OY/6FuDIPQrdcrnULtDBpUfgw7734X47AtTo7uInUqzIbFWF+TyQDQxWpbgsOXh10p6F4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 11:29:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 11:29:39 +0000
Date:   Mon, 17 Jul 2023 14:29:34 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
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
Message-ID: <20230717112934.bz2wv5jmcmizm2yq@skbuf>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <20230714080059.vig72wh34d7x5t7n@soft-dev3-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080059.vig72wh34d7x5t7n@soft-dev3-1>
X-ClientProxiedBy: VI1PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:803:50::29) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f8b209-1e17-453a-371f-08db86b91b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAu7ZMuHz0kIaKmsjN9LkYMNYYcJLnAnHdkKhoaHnBxPhkJIhb4nMP1g2ZfhDasdxy+S1Xm5C50PA1U1RzrMaw8hsh7tAvfsfwaMzztp4CjfMIpFbrFOoqAKLfEHSLzYDvEaTseLxU1Aa5sTQBU/nMZQ5HutjM4O+8ufnEiEbfFVbuc4p3OWJ6mgBtUJuk/rFotQ5bz/xhcsp91mnlHE0JCH2IfNkdGt/nYv8U6y5Smh8zZY4CUATi+Gcy3ff09a1WcHsREUH3H35ezpi6U5YkIqIiDnSLaEBLHPqtKZuTigEf5t0K2SjFl0MDw96YRTs93D1fEzDxkJX7EKm7Unjxg/kFJs0WFN9JbgwMrjlAOQv1Y6HNeVzluPZC59DD0bJLaBEZGqWe1S9j29hSUdzOFcNgsJN4FdjjprfQNlzecU8am7XJk3/oL0bKmwE6hHqswGAFR39sDazYjx9wE0nSWy+og12mc2RNLq2Wkwb5vhfaMlNO0aDs7uAcbAWNK6yll2h03KI1ZCZjPxqKF8WOauiq6IezWfWgV5ZJADUBKhOegyRTessTb3uo82hvWXmaFAqvmNJx81dzbr9jmC6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(966005)(6512007)(9686003)(6506007)(1076003)(26005)(54906003)(66946007)(38100700002)(66476007)(66556008)(7416002)(5660300002)(44832011)(2906002)(316002)(33716001)(6916009)(41300700001)(8676002)(8936002)(4326008)(86362001)(6486002)(6666004)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Q888LMwyXPrKHB3baRdsMwQ1g2ULXc1D4u7LRvIl8shkwbd8oxzSMP5qV2z?=
 =?us-ascii?Q?oTqk8h81VTZaW3bOCCJn0de2KZDmMX+vKLMMDIRWG7Ev5C4LRIyCCyotzQGq?=
 =?us-ascii?Q?HbxQ6Y3eizk0IX2U/gpQ+FYPZsSqmlOZMzHqRVRDxDhxYvYTP9Z5Jo4HZCyk?=
 =?us-ascii?Q?S1dAguhqP9+P2GXmY91YD7GkT9hn1vDHY+IPl2M1t0GJLd0Igzh+87h0D1nq?=
 =?us-ascii?Q?Qdll+BO965/H9POJa0RmuaOm2EEW6whVhlJLl6GEKAkFPoS+5lhP6TWwm7ig?=
 =?us-ascii?Q?V1tCccLA8uEiZJ6U6SGEurcfqhjIcggVv55yUnhCEQe2mCDAIs8a7z5KOcWu?=
 =?us-ascii?Q?uEo602p1N9dOcoiejgkczoG4gJlhUpkUiSYuoggujIJZe/kTokhQJjkmsa0i?=
 =?us-ascii?Q?k8y9bopkF0pc0wawvHAxPb60exK3h/jWfAuvW5PiWKN2UM05/dJNvnpmToOU?=
 =?us-ascii?Q?tB8ysS9Z3Wa/4prTv119em3FUbHxPveCbOYrDFKZkW9UX6TIVN4xfan29iVq?=
 =?us-ascii?Q?WdKviJmdjAfeU2RI8tQZWIx3pA7NXov08aNTXy02zyxYwGISqnQ2r+dny8MJ?=
 =?us-ascii?Q?3e3stiwz6aXD0hB+rY33oY8o2TND3zdSddWcrNIAae07N1aapVCg+wbaPYox?=
 =?us-ascii?Q?W2t3/EH4ErZz1zbJLpKZgscfqzwQGEIf3oeDjrFPxXu1+CKw5jw/zKTYwVPV?=
 =?us-ascii?Q?Fw/6GQGxwWA/TIeMntSbwnsLWPkp2FpEWg0cF7XDpDcAA9P/ON5AyAOgI4be?=
 =?us-ascii?Q?nz3Oy35HZ7uIAIJzB3fr7IYwkkFT6lbyZtcE6eTEY/Q0QislCvfs4Jgj7XGb?=
 =?us-ascii?Q?uLnUTz6B6ziMqmXe8BLT8eSUaEfTyQwKn65XJp6SKM1xwaVAWJb5dyWxsmLW?=
 =?us-ascii?Q?zOkFwmtYJ4nk5g1V//W3wtNs9KoxoDdwSRB4biicxxNOV+Njs/2BgOJzNgK/?=
 =?us-ascii?Q?D+eBeriwkpk8QmWMzD2pl6cu1rj+XQCKglt6AKE6vqvNNpQgBpTWzWzNDAjn?=
 =?us-ascii?Q?FHEqDFcV36qc7uCOKDcNTDUo5twp+DFTIqN9FPcjUrtoBUCONB3jIoivcUNV?=
 =?us-ascii?Q?cwkf4jkDc+bGd4e46cr2NQDiFIygjExsTPXPkY3QbicZkMsuG0ksk/qHtMl9?=
 =?us-ascii?Q?jF2DDiXMdZ/n6iDrPqK0r7qRq7c9FMhquSlXRO9EmNAgVBzXqpeScOB3rzUs?=
 =?us-ascii?Q?G4c62wgQru2fNjihbq+eYAChedgX0+C3YrI8yym54FA87f/QNHbd8Fcu7KQ/?=
 =?us-ascii?Q?e50fOmFQChxpQG11rMDg30/4MWycQ0/BzTePSBMQP5d4c7mL1oFh9T5vyRGq?=
 =?us-ascii?Q?JB4Qe79kGmJCG7FC3rVA3npBwXVIx6rIId4djfQIQuZTp0l+c+f1rUhkTMvl?=
 =?us-ascii?Q?EOjArVqfRz1RIrNSBDtEdq73YxFRyVj2Qu7QRdi0Uu6o7uHV82L4EeJzdakY?=
 =?us-ascii?Q?0fVmWwTNGqyrbZskh8WCBS4cnCmsx1j7NRY1mMDmlt2Z0c5Ej5IVQOcjcv52?=
 =?us-ascii?Q?HLYlVKE2Qrjh+qLlT17NdoXNqYsb8R8LuaYeSc02iRO7pLyGh2GvqLVfLT4h?=
 =?us-ascii?Q?OQmtUAPm9mKy3+VyrRMyowSc8hJmO8wjvVRAY6suRe/qSKXNiq2SVG6OrCni?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f8b209-1e17-453a-371f-08db86b91b89
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:29:39.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f17PgNVe9AM7qLCPNZs7ab/LeN701qkCtZGxv3i/xySPvxGvZNcjSdCIBQlJZn0BhsIrjopsqdqrlcT+hZ3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:00:59AM +0200, Horatiu Vultur wrote:
> The 07/13/2023 15:18, Vladimir Oltean wrote:
> 
> Hi Vladimir,
> 
> > 
> > Based on previous RFCs from Maxim Georgiev:
> > https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
> > 
> > this series attempts to introduce new API for the hardware timestamping
> > control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
> > 
> > I don't have any board with phylib hardware timestamping, so I would
> > appreciate testing (especially on lan966x, the most intricate
> > conversion). I was, however, able to test netdev level timestamping,
> > because I also have some more unsubmitted conversions in progress:
> > 
> > https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7
> 
> I have tested this patch series on lan966x. In both cases, when there is
> a PHY that supports HW timestamping and when the isn't a PHY that
> supports HW timestamping. In both cases it behaves as expected. Thanks!
> Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Thanks for testing! I'll apply this tag to patches:

net: add NDOs for configuring hardware timestamping
net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers
