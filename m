Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208676B596
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjHANNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjHANNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:13:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587FE9;
        Tue,  1 Aug 2023 06:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM0KeCQdExmn9OBRSvOZ3AYQSNacYUFUFoJXQdYWMTCckn3SE8YHaA3Iwd0fAOrFN5dOTZwLR4zKn33Jky4OkF1rk1nVaulZRxFRK5TqbsFruLGybSk2zNuuMh9hPyEV27E0hmqsjsdumadPAO1obdH0HU/sHzFpIX+geXjLAgKNlO/C+6Ut8i99JlCPvxI96cd/jumRhh8umLjEOaziz61sYr0fWYL/lg4McMrEdtAqZ01PnLKqcRHtzAxPp5TSIHJ5XZQtDbIkRShQi7qPS/pndPy1kAoVY1PPrhjI/ZaSqT2NILpG6N7yPbtiwqIb/mpWhue5E0AhW3LSPacnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRUnGRFpZ+EjtZcziCt0bVrZHpMxAj7Zl3/1p6WoH64=;
 b=m/x17bQ49Cue1jUpjhX9QnnuE7aGgV2pua2nHyWN7JHryqFQxFfClvFXl7bg++rDbH55T8tJHYPpb8JGArfyG0rQJ6QnfrQBzX5oAedHaHbFOVrHwo2deLG/PXp26kSRY7nnElbJwSRRb05f7iOYQs76GaOL99rjMtN3fNqDXzzEzS1hufGesxy2SV4MrpM7ZSzi/XLa2mPvXRqUXtzyNLGXS9T76ddd1UuI0LrLjuVj74QDFoIsT3FdtfZtd3+0yWZrHzgnVRbNisjMVX2Bjt7lg7XyhS5uz8bnNhZRRQMWFKXcRqjutAfd9NXgATpMJU0BadIMhWnYw8/gCnVAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRUnGRFpZ+EjtZcziCt0bVrZHpMxAj7Zl3/1p6WoH64=;
 b=QrlfgdcAwh+zIp1RVj+Ps4ZbJ3sWuo/UQHQA6+aYGEDJkG3FoL0c14cezR0jXGUCCz9w/losWXlvk4O3F4Nm7gdhZP3ojD6lQ9M2/6SVnWD4YFsWgmLqiBpIZ9Bs2QKSRY6q+7UEnA7jbTdXB8ZjJr0PbZtWj/eGTIA6+Tk82x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 13:12:59 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:12:59 +0000
Date:   Tue, 1 Aug 2023 16:12:54 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
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
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 06/12] net: fec: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Message-ID: <20230801131254.xzc3xppbwftdj6it@skbuf>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
 <20230717152709.574773-7-vladimir.oltean@nxp.com>
 <ZLafnWuAlytSN7B+@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLafnWuAlytSN7B+@shell.armlinux.org.uk>
X-ClientProxiedBy: AM4PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:205:1::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e2634a-bbda-463f-3743-08db92910716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2GPKgRwts7cP0s1q7La14sC6ImY7ZrBplRh7JGMAWByWnEOKEx6eUsXtpNj/w7QbVGGr5xpVE0Emxf+vB/Tke8hRqua20S3r3HZLG8uj0P/gwBdptI5aX6Vqq1qsewU6Q7XmvoFmZA5WOVqurwUWKOqEfRUKdYmBmIEVCeao6lEVoxaioMbWYpZot18Q4KpGvePqImxi1hCqEnk19ULQ1gH0wVfK5v6Y7SF6Sv/O3TkDa5HssNhnQAYccPgP0X4KhrDWP363uvRNIDgDuOL7uA6UmAkWeVtpOc7ol4oGqXdLlNTmsYfWd0pZhWk/vuYgOZpDx+Eawp5+LgVdndA9KwVHJTfMpGSKWWUOzlU6vpcOd1QJbdCJjs10Nv4uDXQxX+Tu9SOyBEcU3ZI28kjYGaQAZFVMeBOPaXL2XdRk2s4322M7aztUdFZwrkjMw16IvWud2/C7rlQX//8vsHLrVjGmsUZjaNsrFRmtN8sdvQvWhUa9kFPA5d5ZaztiTmE0oyiFZMuqDhL+bTsx9v5btVnZlMkC9nwRWdL2NdN4Mxw0yhrzP4sN2Pp9dcYqEmt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(26005)(86362001)(8936002)(41300700001)(8676002)(2906002)(186003)(1076003)(6506007)(7416002)(7406005)(44832011)(5660300002)(33716001)(6486002)(478600001)(66476007)(66946007)(66556008)(4326008)(6916009)(6666004)(54906003)(38100700002)(316002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2v7THu4Z7DmjW6jTZtjQamj+gdeGdF3fVWmTGRhRlXosNDiXw5vcI844P4Y?=
 =?us-ascii?Q?ML02uOwquAd0ArBX94VP28f3ZH3fhLt4WKC9ev7pUjiCbnWe/8Q9fiHXoN4Z?=
 =?us-ascii?Q?3WJz06e+xrmi0DnJKUwr5Zveg6IYyFyb/c9ZLfut+FRhQLtCbASUWjuKiXiX?=
 =?us-ascii?Q?RdByHHe1D5NJjMwsg4oaYAyBpC1oST25wIxAEChx4ooodXWpMiCJp3pBVE9R?=
 =?us-ascii?Q?XfABBwFVK7hs4pqYQqBqCvCadlnxbzeThtAiKsovcgm/hRzTONU+s+HRQoD1?=
 =?us-ascii?Q?1Cjn+BvjjG+R9c/apjWZbq10/ujKTKsui1At3Q+wBXTm9R3aDNNFfFwIcRJ2?=
 =?us-ascii?Q?6rHZMYS08fmKAUwrWpeTXdvyIQjpZoIEkt4z6TYqhkaZ2u4JkvcPBHidtZ9f?=
 =?us-ascii?Q?w9RhfYw5MyoT/ZLWJHBGc+DcGBD0+Vbyp+IiiydVg4OzY6HlOtEa4jofnlEv?=
 =?us-ascii?Q?UJ2UD081Nm8GNJEHJXG4bCysGBTi63+iRDAZzRYi6MqjpzlYgZo7yZNRPEWh?=
 =?us-ascii?Q?8CYbUFUuSftbYCEBll/DC5YUXWbLzuO4wJ7MAkU8x7TTb4DyPvvC2iTdd82o?=
 =?us-ascii?Q?+4/o6li99L++cyfoZWI+Y7h5kJZirQrNndC6GININai7iVCQ7vswZeb3RBxR?=
 =?us-ascii?Q?IjYMbkzZ8ZyiCzApCuSg+vNZ2uEcs8v4hZQzIEVDo1mYxQPWqTDNgPB9D85n?=
 =?us-ascii?Q?eqr+mb0hbNlEAJ4y69VLlzgTVIBSYd7en1ftmSAI1YaghJofPIU4dp9DAwSR?=
 =?us-ascii?Q?yMkKawUUsolnB1juwRxIBh9JvP/Lk/QN32KSpEGK0vs9ZoL263m/d6cGt3JE?=
 =?us-ascii?Q?Ze5pJfDteF+oiLiLdVgFWoptUtLWExjdHPodOmQ8tnQVVsow/EO6A9GxwS9U?=
 =?us-ascii?Q?L1w1S+xxI1XMTM+TngxVjKs+S9NlCoF1oVj7Ta3O6KnHYNsbJH/1McoaBBaF?=
 =?us-ascii?Q?b0VkSNwjd6QVr4dVErOB9yRMjVdb+EQhNUIOAAEcG/y1CjCryj6E636VC1FB?=
 =?us-ascii?Q?6apiXeeOpLlIlsN1PTGDB5nlBO9GKUgl+0n770wdJ8M3lsvMHG/bR69mBjxi?=
 =?us-ascii?Q?kO0CqgBUIsp9Ad7nKb1dlhGgZvlyyOTlbtZ38a3BT8Ec7wLQsz4Cf5s8EU5K?=
 =?us-ascii?Q?I8FbF+ct3Ab8UAy/Lfq7blu7yy8A4A73lkQWulvZ8QJpsA4WU3fmkPDLO/j9?=
 =?us-ascii?Q?3fW+ichgSzopxNt4IGXZVFlR9jqpE/vIYh+8UqQlMJECNOSTDlCgBX2Z44rh?=
 =?us-ascii?Q?Rvd8BQnYX1t5YNznPF+TNpChm2XDkgbhoMuDhIt5YA9bJfIHi8CTDDhBMzt+?=
 =?us-ascii?Q?jYnGvkmIkINZ+J4fjlzPiHrXxZhqJnFSwDdylvuh/dfQoLHZp38ImRpacwoj?=
 =?us-ascii?Q?E9sB5ZdL5E/xf0qUAQ3m/Dk2ER0IuteUgNpPWq3YjAXQCcWfhkuscbDMkOh8?=
 =?us-ascii?Q?t2GgJrIDiz7mGi5WzufgTrRW2L0hfxWfTYpYDrXfwZNqB46Le/wofJWcTuIH?=
 =?us-ascii?Q?G7zUFzcLxdH1XY3xrVaj4JfYUF7GvS6fvwyq7NKugsQli/OvLVNZuP9txEV0?=
 =?us-ascii?Q?OzCOCTdjjR5JGKrJF5i6MaHeHE8BMOFq5KYzyD0V6kHBEoJj6yxc9yBXa+SV?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e2634a-bbda-463f-3743-08db92910716
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:12:59.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fylb0fhrQnyBZvyILhLQYw5Xcn9I7USFDDZPQ34+KQq0oh4Bw+9oV9vVJ83G+Y2YOIDJiYsLW+Qx/Pb1XCEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:20:13PM +0100, Russell King (Oracle) wrote:
> > +static int fec_hwtstamp_get(struct net_device *ndev,
> > +			    struct kernel_hwtstamp_config *config)
> > +{
> > +	struct fec_enet_private *fep = netdev_priv(ndev);
> > +	struct phy_device *phydev = ndev->phydev;
> > +
> > +	if (phy_has_hwtstamp(phydev))
> > +		return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
> > +
> > +	if (!fep->bufdesc_ex)
> > +		return -EOPNOTSUPP;
> 
> If the interface hasn't been brought up at least once, then phydev
> here will be NULL, and we'll drop through to this test. If the FEC
> doesn't support extended buffer descriptors, userspace will see
> -EOPNOTSUPP rather than -EINVAL. This could be misleading to userspace.
> 
> Does this need something like:
> 
> 	if (!netif_running(ndev))
> 		return -EINVAL;
> 
> before, or maybe just after phy_has_hwtstamp() to give equivalent
> behaviour?
> 
> > +static int fec_hwtstamp_set(struct net_device *ndev,
> > +			    struct kernel_hwtstamp_config *config,
> > +			    struct netlink_ext_ack *extack)
> > +{
> > +	struct fec_enet_private *fep = netdev_priv(ndev);
> > +	struct phy_device *phydev = ndev->phydev;
> > +
> > +	if (phy_has_hwtstamp(phydev)) {
> > +		fec_ptp_disable_hwts(ndev);
> > +
> > +		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
> > +	}
> > +
> > +	if (!fep->bufdesc_ex)
> > +		return -EOPNOTSUPP;
> 
> Same comment here.

I will add back the netif_running() check to continue to not permit the
operation to go through, as before.
