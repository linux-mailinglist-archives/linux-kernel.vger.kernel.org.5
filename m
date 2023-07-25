Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5027623AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGYUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGYUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:41:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF7E47;
        Tue, 25 Jul 2023 13:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSAkJeMLVn1qbS3BzkUupMnoMPCU36xMg3FgCckMgmE34pH/uHqQ91+lSrDDbWW2F1VnMwEo1YO+STpTtUDYlrH47+0HiMTG2KDLusK4oX10KSPkxNqHApR5ItlssOhgwvqxnRhFSL1FyNujfcNR6E7mW25f4IFKrdHUTVsowHncytdmbOCzSe223hVt8SlL/OOph9LhpcFU8vrkz0KASKGGXjmyz/RMQqOM5LaYkJOYqu9tkkVjn6A6FpJ5/DFjmvoS/5N3OVTQ2zYEOJuILQbO6e7Ts5vmFJy8DXTA/zH97eC8HhIAdF5NARbr0Ynuj3boX2A5O+N64vedKorphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apvFxtoO/tk765HvcwYfAB6Rg23L41Uwl15m6SnpfLo=;
 b=J6jSyDnG3pnMhcn78z+E5O8tFDzj/sXrnJ/zNpW+Fn+hA+R32Ei+XSYeHF/up/L+KtM9lbHJhRhgdn6CppoeqwVBcVZveIKGN5cECKUmY8mtmPbduVehd4eMc/WVlixyppCEAy2EGdtkb5+xXV/mWiPfOEDhz5pEZi9YZ72H7z8ShBohxOnXWZ2PnrrQA8dNjhQ8R8AK8lBJpy50bGIA0OQCqIPOPzz0rL9yyJ4CF/qfADA/44ISjLQN5x4ETKLVYxXildDcv7kflERqW/ehcVSfb8mB7cdfm1sALugEUa9HmTmavLZV3d7RriwEl3h3Z14mcevkN7O1pnDYYDDc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apvFxtoO/tk765HvcwYfAB6Rg23L41Uwl15m6SnpfLo=;
 b=W78MIQ+DmZtQ0Xez7YgzG/DmE/+eJA4RCy+ahWeh4WkZ/2bWU7ywWqG++Z/ZpUO0vSkkx1u6rrmCngrz9fTiPIwd5ftkEf6E/Sbck7ll5TZUFDmRtu7F6eMmNvnWsFHDeFSzPNmwfvfrpQNe0/cLxj/1q4KV3+j62/N3p95txt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7430.eurprd04.prod.outlook.com (2603:10a6:10:1aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 20:40:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:40:46 +0000
Date:   Tue, 25 Jul 2023 23:40:42 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Josua Mayer <josua@solid-run.com>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa: avoid linking objects into multiple modules
Message-ID: <20230725204042.opemku5oerpkpsqi@skbuf>
References: <20230725064403.581634-1-arnd@kernel.org>
 <ZMAqPdO2XcIXOCFs@corigine.com>
 <990b6871-169b-4d03-b202-f19294730f8c@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990b6871-169b-4d03-b202-f19294730f8c@app.fastmail.com>
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 20321a81-6030-4ae9-3157-08db8d4f6c69
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FE/uZYdCfpbF4uKEaIywhpI1chfDEkWbsH+o+NRdN9MBMD82dM1Ye/Vo6pH15q+/CIJ9a8BnNnZZwyGrhAveqxzKkrW3FFgEuN8JQKN3pMOFtJYulwOG7d5/16p2vwOP1eambTGYZItCJdQ81UbMT425MIrNbqoLD/h6byp/DXONCqnO3jGH299X2iJlrKrAk9McMfbpiykCER+K8q8mL+7AdC6+PacH297QTrANk3PAuJx4ca47oLP/eUqBoZOeAxerLKb2u+IQKnvFBb695TaAJk793oPhsoqtWogpQo6WLQNcsy1XY1/7ytDxbw2glro99Vyg6xBYyBzoIRaEPWKv3RIqcSmEvWbyxohpA6nQ0h3YQ0HaqQMu0etClVnjExdUFXx5rTKyGneP4DFH0chthk9UKCHilsXgoq9cpiO7MgcEkieTLxHPgAVe0vYEfxSLehiUtLhREB1hAVKalQ4gkSb17a6gWk/IeGzE84bXuBb04pKeaLJ59Bwx0qjqcx3fe0xP8zWSih3DY6Xz4Y5E9yvKRy6s9te8wC1sB/tnlF/UVtdYjhcJbiFM/IPa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(33716001)(6486002)(54906003)(66476007)(66556008)(66946007)(83380400001)(86362001)(38100700002)(478600001)(6512007)(9686003)(26005)(186003)(1076003)(6506007)(6666004)(41300700001)(5660300002)(316002)(2906002)(6916009)(4326008)(7416002)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lEHQuEG2iGHnnXtiNAoHsgsAtOdXoHdnkt4yhylOGVchvEdWX5y48L03c3pW?=
 =?us-ascii?Q?VFUjuyllCBGlVKva+bjD4/Cb/A3dk0df2DPJGI3Fu6MZRoBubm+Flj8pGJxe?=
 =?us-ascii?Q?neZKYyaas4Nwr5JFudqw8Tglpo01JZUQUBwdZ3ByPSKmgZ/B5Q9qXTk8rk/9?=
 =?us-ascii?Q?XRFl31WOQBycmvuKPr4vp1mbD8L36t+VL3JL9/6IO1jKUgc+lc2e0hRXAXCJ?=
 =?us-ascii?Q?jzoSUPPudNajz/EGvwdnNEri9eEVGCIhzibgRd6plDfLtI7HfbMR02F8e2PG?=
 =?us-ascii?Q?rEZxWuFHyPoMG/e4BOI80us/hk3tA0v5XE+VvTrHNeakAK7dKDh585QkIdaO?=
 =?us-ascii?Q?9SLbjmQlm0MxaDozj3DWTEStHHbhFQiaXmPDOJk4Wt1pdY077JNJYTicIqu8?=
 =?us-ascii?Q?ABQnJiWtAA40CgnfHzAVoSndq//a1W42swv85W7o/fz5vhJ2c6stM6tD0STU?=
 =?us-ascii?Q?UtRFljALdmFWYccC6/fn57ZKKUgDCXDk3gih28B42nYwj5LsLkKP0IOM0sss?=
 =?us-ascii?Q?iQESclRqfsuXV96ntEyl3CcsqDCGmAt50GHOs0/VVa/fO+qxRjw1FV7Xdn6b?=
 =?us-ascii?Q?sy4B8g98/MvXNmgxWMvemaHx2RHhZA69GDdFvJCp7BLpP/sl98l6B8PAv043?=
 =?us-ascii?Q?GESMJ+1qRTYvbuhG5LuhFln2dI4SzygLaGYKc+lAZeiHWP8G0fPD7lrn4bP6?=
 =?us-ascii?Q?SowiyYrLoVzBwLl5LvSChiLwETF0zpyes6fiPjWX9wzD0hzIBLFmx/Zee78h?=
 =?us-ascii?Q?hAmV6U0hMf+KHSHOoS+zvhznG78Q/Khc2VSQoelWfABx32z/TjvPS6v+ET9J?=
 =?us-ascii?Q?Hoax42g4gctBsu6peZM9EzacTCnTf7l1OyGehfgNWmWAe7EowGAIIn/Kby44?=
 =?us-ascii?Q?1jthNDnQLDGqOnvX3/I3hyZD/5/VoWxuS8L4U1tCR5WBqYrP/2kBnlrxqYCE?=
 =?us-ascii?Q?t57wXedRW7FZeGD1AyUfExmD5uEepJL1H2eUGkPKEY4x1yWaWTt8iflqjbjV?=
 =?us-ascii?Q?cqImhlV4oYAyaOw8CIn0Jdj2E64m2JfFcZosiiniUFaWxZV0tM75VYkbUjqH?=
 =?us-ascii?Q?OZ3FENN40E/i/xcDm4IGalo/CgzYsRE7iORVWLRVgMOqrFIXjJiZEj8rJD+g?=
 =?us-ascii?Q?gaA9lwGRGnxTxZ7axm2yqSupTAY2jRNavzj1jep7UtV1oguT4KfXz2Rl43hh?=
 =?us-ascii?Q?anRxInCsQ3d+/pNDSi1UdDG+t7q7cgFibBAigpPxOAbHKz6/cOTAeBUTcGfM?=
 =?us-ascii?Q?t5c9pEIXHmS73sgpUCF/t7ozKXTp+BSphrnVLh5g1L+m+czZCV+zsCMmYJ9n?=
 =?us-ascii?Q?MQOhwKOSWT6fqtqndA/3VkszgUg1wDzA5r990VpMFsKoSJ5QoxFrc/6m3cRc?=
 =?us-ascii?Q?+3Jqqa4ISPyoq9Pz17uV4DzsU0QevhATEfunKsf7YEJbIdC1dnoWwV+4GJNR?=
 =?us-ascii?Q?vYRYAQO2ibwno18G9QlorwjLfmMxQAyxWQPhpFoYSGp57SReQ55mSofw0VfZ?=
 =?us-ascii?Q?EUmJD5ef7HVZCN8yJfgAP8CpRpKcP2i/sUAvIEi8c0/GxltSGavMIqwF7DMf?=
 =?us-ascii?Q?C+rYiFGjgSO7b0MN+ID/fIy9XhsaK2CHcyUIIRlSmtQri084NpNHXoulP/P3?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20321a81-6030-4ae9-3157-08db8d4f6c69
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:40:46.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shd2aAjwXH2OUPU4rFCq0tfuCSuTLa3bzPD5KeQxXo1JnDH7VXKfuvRTliGI4238vo4HYuZp0pJt4Kht8kuf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:37:07PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 25, 2023, at 22:02, Simon Horman wrote:
> > On Tue, Jul 25, 2023 at 08:43:40AM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Each object file contains information about which module it gets linked
> >> into, so linking the same file into multiple modules now causes a warning:
> >> 
> >> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> >> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> >> 
> >> Chang the way that dpaa2 is built by moving the two common files into a
> >> separate module with exported symbols instead.
> >> 
> >> To avoid a link failure when the switch driver is built-in, but the dpio driver
> >> is a loadable module, add the same dependency in there that exists for
> >> the ethernet driver.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Hi Arnd,
> >
> > overall this looks good to me.
> > One thing that I noticed, and I'm not sure if we care,
> > is that an x86_64 allmodconfig now reports:
> >
> > WARNING: modpost: missing MODULE_DESCRIPTION() in 
> > drivers/net/ethernet/freescale/dpaa2/fsl-dpaa2-common.o
> 
> My mistake, I had disabled the warning in modpost.c as it was
> generating too much output while I tried to address some
> other warnings, so I missed the regression I introduced.
> 
> I'll send a v2, adding
> 
> MODULE_DESCRIPTION("DPAA2 Ethernet core library");
> 
>       Arnd

Hi Arnd,

Don't send a v2 yet, I'm writing a more detailed response.
