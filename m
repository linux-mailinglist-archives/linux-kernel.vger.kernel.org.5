Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC43757FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjGROrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjGROrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:47:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F2170B;
        Tue, 18 Jul 2023 07:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCYVC9Vjsp96o5qeOWWgAvtQzNYxN7hPr+JAiCZUUO5pz6yk8cKZBOcTYWRH5/E/6MQlh+IOYkYIA/XXawmhdDYlkINJ5859maZYCuoB9/CWKFb/AD+vXY1WSF1TQpvbeP7dCy8B8rZu9qSRIPIywDY/5NXidPwdOi4UknnWdQlcIjcgQaX4i9/DcWnLpoEl1hb/1ectZAzXfJtJqVcL7LRSLHlUl6509tRSyiqrPLAljsOiOSP+Z46CEqFHTjdImyARwpCUc1qvFPDAnHG/K2VIfT06EVAlOwpGdPD+S7APi2woagObiB1mluvOCZ7qwU6XjPuVYkuEmFeOQ2P79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngYAdg6zBGCXo4U2Rqo2qqWePueOPmOkq/tLTVD8iJI=;
 b=YSpEwImbnEeX+50YEaqPfq4NXIe5+iQ6JJebQ/JftiA3hlK2AlP6kfpq3+44DxDpVkxrCi1CS2ANQQcWtW0eaFXvkVWmmVHAEvPnqWUJZwut77WBM4lA6VADb2hyHyDy4cGG06Ha3KpQsUg/fRJeX9p6zSf9fhmNED3z83wFdLg6pzbgD+/5lFtyEIfj30Qrhx0x8ifNvk3PSZRpxcBISr/xc892lXSda+icdKNeve5SpLVdbfJwnrLqBSsWJefCJy9swL3CJOh/0JxCei27G/sxVsFIaIqgaegp7IAR7xqc+9hjCpLEE/S9zf4fvOoqaOERqlI4uz8joCZ3X8dmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngYAdg6zBGCXo4U2Rqo2qqWePueOPmOkq/tLTVD8iJI=;
 b=OrQhzEagMaECQJl/pzW+CFcMulbXDu+SKEHiN5xClTFDPnPrYNjro3c321NSNxwCi+LcwZhmIwpe+MeV2pw0e3DT+ZsQge6XFX0FwTC4XeesLR75YMe8ZFZThT19kjRcggOe++tYLkfOpjhyFtHu8dFyLYCw9GCPn0sPrUdkIgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:46:57 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:46:56 +0000
Date:   Tue, 18 Jul 2023 17:46:52 +0300
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
Subject: Re: [PATCH v8 net-next 12/12] net: remove phy_has_hwtstamp() ->
 phy_mii_ioctl() decision from converted drivers
Message-ID: <20230718144652.ihhimqn3bw3t3xhi@skbuf>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
 <20230717152709.574773-13-vladimir.oltean@nxp.com>
 <ZLaj40L3s+FssNHq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLaj40L3s+FssNHq@shell.armlinux.org.uk>
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3173af73-fb42-4f03-ba63-08db879dd578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMq2ACeaT9/hW9MMUBfTLTFkVO4L6MpPEeO7q7k0RC6UvuEHAuu+fWYLYEORQAWu9QdYVVD091x4zmmZboql7w0MAgs8p//w3ck1MImt6PR73ySg6PPzJ2u5bZGyV6uPoPL+a58Um5lx727Z4Ywkc6lZs8H6APLy39QOYHCDcyE6KtYo0aQ1E1lPXAqHg2ebuFVwM3qsUT6uGN9JnDZ1qgTFEB5tty/nqJnbIA5PzG6AHBixwsJ7x1ZP+ZLznb6MGVaqRnv4DUkIY+ANJIx8J69RhstvJ6GYLgDzG5wz8Nj0p9cnngTBRDV79NdYSybEzOkFRkWIxPPoPUuX2dZ8qs2nPsgeGSdF8LQAe9LxQUaxKFk6jCVoaTzsUqhxMs75v4PYB9yVa0J+Gbp3DprZ0mHdkb8S4API35zxw1YxYxMCQJKW2NduzUsr72JKiT0pzOfTM8IwI/Ai6V5Ne7R6siGqJJkADWixqEbNqqKeMRU9DFGjAZPJUhX1VJTselYX3Q/r28jrzgoNQolTzucdzpLYBJdYeQlDbZJEMQF+8XfB6qcdCxMGj4o8PIBZp/Lu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(33716001)(478600001)(86362001)(38100700002)(6512007)(9686003)(83380400001)(26005)(186003)(1076003)(6506007)(5660300002)(8676002)(8936002)(44832011)(7406005)(66556008)(7416002)(6486002)(54906003)(6666004)(66476007)(316002)(41300700001)(4326008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JF7llVj1EbWHxkfF0z04ZPWC+37woB+qDB4TuxJpd0sE05yOPcxTKyjhqE?=
 =?iso-8859-1?Q?2rl1zkD/9fUd6hlPKkwLnaE4VakzE2NnMgxe7NFspr59GNEzx14oY0QAhz?=
 =?iso-8859-1?Q?oYMWfadJs5Xkcrc7UkfHzs2SwGpC3NLc11cWd/dHrZa+OIiL/bOwkiCC65?=
 =?iso-8859-1?Q?NIPtprDaGXkx6QS+8SER79Dl0Dqe56oUXAqnxeStw2fHBYl8s+OIpB3E2+?=
 =?iso-8859-1?Q?DLhtIk1S6RBW586Ow1NybfhPIG/g+qol/ExFWuUZcRzRD0dZ6Z0jm2YxiB?=
 =?iso-8859-1?Q?bv1RWvn9UHGPCo1uzECtvfQ09Cp5VxmkKlC8VTWGHMUHPYoD8e8xripqMF?=
 =?iso-8859-1?Q?uKAaq9ERrRndB1u4SLQSos34xeS0P2yWzpsLKmP7EjrAq97r2G2/ktHJEM?=
 =?iso-8859-1?Q?CwH7s9HRrvMz0chevM3iRS6gRuhweEWGAUns/SJ4xKve1efhUubUeAXrLs?=
 =?iso-8859-1?Q?Um1n4UI0MNwU/2eOp5prGVM2fb6cyA+oT5ZEmM15cc8OF7y5kCLpd+t80H?=
 =?iso-8859-1?Q?79ZnGjzKXR57r/LfzPoFoPn0GWwUCgMB7CexPMWcMbnsvT1qQCiyusXMRU?=
 =?iso-8859-1?Q?mnCKY8EE9RdtJK3LKwRVUbE/2arwLiNRFXVB6ILXDvB6VM85qEQZmwklIa?=
 =?iso-8859-1?Q?zmm2ercm6cGPKCoEUkFWB+Y9axYVM+EJlWirGBUPhajvLAmVAqdY7RcNN0?=
 =?iso-8859-1?Q?Mqx/ZDb8kMW38eOyQVRpI1CnQYgi9OI0P9myUGTq99lFkn+MsZfTq8TDa6?=
 =?iso-8859-1?Q?3/DQxb+xFwymR+dLbqVZytwFGSnyMnEpCjPKMEACKDoQpBZeXeFKrtoZe8?=
 =?iso-8859-1?Q?q6ZkLBNlhNehL+CSG96oRKUwQlfZHFVh8cqBv/ndw+FF/s1kml9OgmL/2H?=
 =?iso-8859-1?Q?do7II2u8OJelaC5PYPOI7mQiBq13oZD6lZqiNhThVRBadyaERyNt3Pgbhi?=
 =?iso-8859-1?Q?+Lob004tjXmoMeIiL3Vp7SAdZVy4tTMcCcKgViFJRHk4t+Sw0UGaZWRlPu?=
 =?iso-8859-1?Q?jMiZVRCeyce4eBE26E3A2/2o6RNUSUKWrupFKELCG+bafFIo4rtMvQoDPi?=
 =?iso-8859-1?Q?yTifFE2VrpFsSjCSnzcjADpXMPmuBg3BwI53QESLWuq3GTebPQY/d2n2bF?=
 =?iso-8859-1?Q?V1GiDfTKMG0Cmm+rNv+01xTrzZwgLopwBDinVwxrF+u8e3TZQQs9Nq56ln?=
 =?iso-8859-1?Q?+CyhNxPhUotjPvyculT7e4dteJOcgnmoC4Erjv2mDdLdzPYjcc3YT+moQj?=
 =?iso-8859-1?Q?fQlM+ZPrPxbLQynItA6lzFqLRy7HRblpg9GwZvfz2YBz/hq+9YdEndBUat?=
 =?iso-8859-1?Q?/yxK7Jwugy2BMTYqwYp3OcGyy2oljYF+/f4Ju4WEPdQnoW7GBWRNkKBz+B?=
 =?iso-8859-1?Q?0qFVCmBWOmumkRiJ4A9WWwcRSFPA3TczWfIgcHGi7TKNBQubt9na0HVNbH?=
 =?iso-8859-1?Q?UMgCNVQa5Zd7EmhBuui3xiQclwl9T1j/pOr4vtIP1IEaG3oY0mtrZt5CJl?=
 =?iso-8859-1?Q?q5fbnCtRVwxErau12AHkYunA87doLMIo4Cb0gfozW6qCwN2Vykv6UXfouw?=
 =?iso-8859-1?Q?LuqDGht7E2bLzmQWd8T+wbCFd89H9P3E9dAFXDRRGS777HY0R+6UKGYo5D?=
 =?iso-8859-1?Q?+pCCr3WD8bfycvBQHxB5sNOe89/slF7doYIyr5rMj4JimYW3TAl/hQJg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3173af73-fb42-4f03-ba63-08db879dd578
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:46:56.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed0KXqdu/ZsLU/r9zbm2MS5DTP3GJYnnCnABVYZAMRKMPWiLLCkMWBA1M3FJ8JR/fQS+RFIXVPHNtI6kUsnH7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:38:27PM +0100, Russell King (Oracle) wrote:
> On Mon, Jul 17, 2023 at 06:27:09PM +0300, Vladimir Oltean wrote:
> > +static int dev_set_hwtstamp_phylib(struct net_device *dev,
> > +				   struct kernel_hwtstamp_config *cfg,
> > +				   struct netlink_ext_ack *extack)
> > +{
> > +	const struct net_device_ops *ops = dev->netdev_ops;
> > +	bool phy_ts = phy_has_hwtstamp(dev->phydev);
> > +	struct kernel_hwtstamp_config old_cfg = {};
> > +	bool changed = false;
> > +	int err;
> > +
> > +	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
> > +
> > +	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
> 
> I suppose the idea here is that for something like mvpp2, which when we
> have PTP support for Marvell PHYs in general will want to prefer to use
> the MAC-based PTP rather than PHY-based, that driver needs to set
> IFF_SEE_ALL_HWTSTAMP_REQUESTS so that the ndo timestamp ops always get
> called? I didn't see this discussed in the commit message for this
> patch.

No; the plan for mvpp2-like situations is for Köry to:

- add UAPI to allow specifying the timestamping source (based on PHC ID,
  aka /dev/ptpN, probably)

- change the core policy (effectively this function) to prefer:
  - netdev-based timestamping by default (this reverses the current policy,
    to prevent future regressions when more phylib drivers gain
    timestamping support)
  - phylib-based timestamping for a selection of whitelisted phylib PHYs
    (this avoids regressions with existing phylib-based systems)
  - the user choice

The only thing that IFF_SEE_ALL_HWTSTAMP_REQUESTS does is to give the
netdev a hook for phylib timestamping operations, for completely
unrelated purposes (switch ports that become PTP-aware must stop
flooding PTP packets).
