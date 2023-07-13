Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979AE752D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGMWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGMWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:34:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9C2701;
        Thu, 13 Jul 2023 15:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASPcYiNrhkiZOe/d4ldCQJcXAmcO+NSoCrzpcD/eM/+fZni32dI1ggbz+Oj1+V2juZ6qn3VWgcz8tP4mWFP7YihG36+oT6qCT6ZekkfxDJ6a399PTNZmKVpQMXvsHM/l4AlUPWJHuKVs3Ro28bIpHYlkGiZ6EmmccW6UHy/h96Suz2n79uunPpIHXGZyXT5LqWFlFP0P1SBEba7hFfgGhQkjZrRtqkXJXj3GHlI5263PR5Mdc2a121ncBUUbOYPmbLKXBHEEeiWbA5D0yuTMl+iV8gC5/V2ANmHGIKIhJm4z9OIjYsumFuWfHx3TqafK7p5yI/4jsKxfs+lU0lH0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8cvsblMANTWYnatLPEjhM5ojSSBYHzHAKXtbBC330o=;
 b=nEohajy3HClqvXQJ8k55zffEE1OZDJTagcOm5PLGVXsc+VgR02I4mbPQMHrw9+wYR7FNk8nDgYRARQOjPSHppzm1bDv1ixDUfzWfI+el7WbFwx4kCYk37K2KyT2RZOKH7tdpzcsYO3iMLsuP2mI3LrWgQGqSVUz/zugkr+Vn3MbPSv151I09pGCK+8tSbQ3Oji6q/aLdAwEOrnrlOpkPPlUL2iDYD4nuEmU3/tbTof5LQxtcAOkB1mPmLQOQTny8rsgo7hu5pcktrvQ95eJAQ7zStl76QpjSjW0eO/wgTwaPT40MgLThAKFG/e0dp4gtlwa3W+ixAPEwf3WBTVMYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8cvsblMANTWYnatLPEjhM5ojSSBYHzHAKXtbBC330o=;
 b=PgOrBVBLKCLU/Us0AnmEc7HmTYksmq3wgbCO8pkK3zxdB3tIt1TTko+1v2kavi0zeGFNbungyp/r8G9ONxwECsWPazuwmK12l9MvKGQ63yG4LG09D1D8j54QJAVLDw4YMfsaCfRdqORfmMxS8mgwuAafSC0W4ETLYnpSurcCZDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB9809.eurprd04.prod.outlook.com (2603:10a6:800:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 22:33:58 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:33:58 +0000
Date:   Fri, 14 Jul 2023 01:33:53 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <20230713223353.wfo4xarh4jpfynjp@skbuf>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <f4193401-8f61-8f8d-a85c-e513e64e90fa@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4193401-8f61-8f8d-a85c-e513e64e90fa@intel.com>
X-ClientProxiedBy: VI1P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbdad48-1977-444a-39fd-08db83f13f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7kyNBd5PtRmeQbED4s05OWY0SYxaaPJ9IiXCwbGxzRk/C3LE+zHdgsDxcMrbvqsuKHORNDoNOIg59q0H6uAnBE2Zdftx7tUeIyf9qnyI2hfpPvrpkN/jyTji+dDhZIXb/Ph+rTSrum7NQUKszECcaQnh/BcGne0YLSYHuZmcBEOdJa/9+CIBgkfpPfb48RtErGfpTnnAB1TMMY7NppX4jvLdGcUPXvEpXU3lZkmMJCd3uVhqspZsRJ0C1k97lD6aYZwgcwY1F3KKNd/5+6w6xKWtkbtGD5wMQeoc1yJHapMqkVE2HC0qqy6fu6qJvpt9joD4mSNkgHKjNJMrsxoY/nAFw9XzKaORxZ5OlzSLqlwZeo18NcqI/H4yfJOGz2+ZTAqK3budX7LYuw7Pf+ZFWVAhl/XH5K0Q8rzv5m9Cx9PwLyhLSAeJPbhjxM9t63Y64hKJhsbiW2U8nR1ZzfyhyQVzyr8KyR8i9MVPVE4rh/ZJVnWufnYaKWXy6y7XKi01ws3R6XEN4tR9n6fn2tXG0nQrZxW7bdcbYa0MMgGfth7CR6gigtIADMd4ErkQOG2u4OGZ5U22hspu0dIuLHbMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(38100700002)(86362001)(33716001)(478600001)(6666004)(54906003)(8676002)(6512007)(6486002)(966005)(44832011)(5660300002)(7416002)(316002)(66946007)(2906002)(66476007)(66556008)(6916009)(41300700001)(4326008)(8936002)(53546011)(6506007)(1076003)(9686003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/heFTdXZqhGYw6++d5ZmOyKK/51kIxoRJPAUNyLFLFzubz8elEf+EA1oZS?=
 =?iso-8859-1?Q?Rc2Qkyo5uImVHG/+P6kylnTqRg7QkYZpJlexm/JXupk8vwk/b9JtfauHb9?=
 =?iso-8859-1?Q?DAcjyiskwqV6cy/HNyNpDJx9WOCUysRcTECSt1MwWA0ur8nMDW1dwfe6w6?=
 =?iso-8859-1?Q?Rk+2SCnseWQNLS1kkwbmFj2UZgjmKYsrtdFHOi/SJx07vUK54tclvanOHU?=
 =?iso-8859-1?Q?wjabugCWIbPJjGsqtQP9AqWfj8IjCotAFC9sH9gjjCKjwooSBsKenCWkb4?=
 =?iso-8859-1?Q?NwNRfYgqcXFMd172bXvlHR/+I/yDqlyW0jWyPbbS1RZ1pLUUQUwisAPRY6?=
 =?iso-8859-1?Q?3/QVWrYv6vvB4SHkB00doxO0+onPsoq8DDiOcrcQMqn03KRryMZ2st+my6?=
 =?iso-8859-1?Q?O5+qxg6moCX9zk78z2vTfWSeC2Ki+InjOjIiH2luXg2YNhYq01gRRs4Hvm?=
 =?iso-8859-1?Q?inT0nHspsra7hiDN+qLDrkfYMJoB+FKqSVwHxGYAqFxS9SyByy0xhwZA3Y?=
 =?iso-8859-1?Q?k80Qz83ahvPAYOhrRrrHqIulJb76I7LJ6tBnfHYLE21tG/TbxH3xXqoCLo?=
 =?iso-8859-1?Q?NVXXSS2iBV+K5jlKKX15ebWijiPwxL9A9CgwRcqTo9yVgtL2SlDIDOWzQc?=
 =?iso-8859-1?Q?iNFL/LIShjCElNrwhtp7arlB/4xHvc92MWaWmdMB07LpuFTCS/FTiqyvod?=
 =?iso-8859-1?Q?TpmFkKmhEp1T1R5fFC7QB0FkRjbdvLhfDlbaO+L8fwTF7sGScjXaFnmdFZ?=
 =?iso-8859-1?Q?NoYqlOxZz97gclNzi/kC+KFnx3JujR/fcYsiAVISo4BuOVJg1qQRpt5O1Y?=
 =?iso-8859-1?Q?lymK0m43PJto7EPuDUtvYEAS270K+0ZZg4XHlt0Ibpx/5wUIfnJ1vVUlqA?=
 =?iso-8859-1?Q?iJjoyZrUM6+DVR1CkZM+XS0yEPURWjymjySHn5xr5fUNzryH8rXIAkZ7dc?=
 =?iso-8859-1?Q?DtTBrHyF1NEkqrEuzCIiKBAIadYw0GmJEr5nGS25StrynAE9SJl3ymMyrr?=
 =?iso-8859-1?Q?Uq4WsurXkyP4BX4Jsq2LwztK8xqZFdXiwOH3scS+kBcI9m+KF1FTiysxCY?=
 =?iso-8859-1?Q?JmY9RTH9WmpESPW7cb47+2vuMnZ55AYBdOt2H1rzdCrnCq7+aBpqTk8eB0?=
 =?iso-8859-1?Q?LMs9A4Jgx/GcJug/EO/LYcgGEhVDWsE1R4mY+Dapy3vo0UhSRWs+6FIazs?=
 =?iso-8859-1?Q?RaidFaI37b2nbHy4j3Lgrz11p9HV0jiuOBHgo0sGPbB42Jk9l/YmiU6bd/?=
 =?iso-8859-1?Q?Plqobxo6DLNNevSoQqWe8Fi7QYkdKNJMModU+qk4f0pgG5E6PRdAdC234X?=
 =?iso-8859-1?Q?NlSvMJQYclLZxsDbRLpBE176jcg4Uz5TnwIQNRINIfpzN5Kxfq2jE7B4qp?=
 =?iso-8859-1?Q?es2xSyzJj2SH+wTjR9njdGpc1L/+NeJ0SQR5YOS5eW44WWz/vAZqqUdVD6?=
 =?iso-8859-1?Q?yO1WFZu1JQZ1UAgxJaoK4ZVjszwvpt1jkUi/fHYOyTi+x37UVz9TuYSU6M?=
 =?iso-8859-1?Q?1bU/gM2PR3eb04ylfeeE6QXd64oShZv8zcFQ0SsOK98xganLI1le33fG0m?=
 =?iso-8859-1?Q?RGbPByFndlfJjC/4QOsXowz6Okl1lqq8k2LMwPSCcG3EU6iefO0O0Oe1cY?=
 =?iso-8859-1?Q?WnmXiyn+IjQuZeSuz5bhuNDJiqsT+KaLX78/Thr46nOFlaeopTYJsQhA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbdad48-1977-444a-39fd-08db83f13f79
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:33:58.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiW79/mFHSUWjggQqXm47IzxZLep4/nSjscRuBeUuXocTyytbyoBN0s3wAJIY3JY2eC1vaVAMikRIpBiMPx6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9809
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:50:39PM -0700, Jacob Keller wrote:
> On 7/13/2023 5:18 AM, Vladimir Oltean wrote:
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
> > 
> > I hope that the concerns expressed in the comments of previous series
> > were addressed, and that Köry Maincent's series:
> > https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@bootlin.com/
> > can make progress in parallel with the conversion of the rest of drivers.
> > 
> 
> This series looks good to me, nice cleanup and reducing some boiler
> plate code is excellent.
> 
> I'd like to convert the Intel drivers too, but I am not sure when I can
> commit to doing that as I have a lot on my plate presently.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the review. The conversion of Intel drivers is in the Github
link I had posted.
