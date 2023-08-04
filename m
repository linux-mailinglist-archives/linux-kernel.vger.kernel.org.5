Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1E770250
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjHDNwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHDNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:51:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3A4EED;
        Fri,  4 Aug 2023 06:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsRSFDD/P+pHAHxkqj5GaVVbqAM6u477uTQsqkdnzRBsk5WsCR6adPu9v10kH5QXY9ue23dIzhy5nRfcxy4f+NvmdeJ+NArjdfd58K6BYUIBjO5S7E/HTy8U9aflyIISuVLPiZ28mF3UphcXI1xWNSF/K2RuwwqGc/OH846S0kURghBzmXImPLRcmGoRETXoUHB2j8W7m8p2rsk/NgPCzb9xg52T7PglIPV1+2w8uweFR771NkAWfijEdrOwjfc6kbwH8o4L4W6iozAMx4gex21XzE84cMI2wVJzIkLhJFW8kgSughcBbX1J6VrafaB1UmCdN5Itj9fRGZATPCY8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25FXIWZr7HFO/KtGICcieze5mrHkV/URIhUjR+awnh4=;
 b=FDKsrLCysCmxuOwlkhOvBM1tKMRyHk6ucqccgam0cZgIJC4nFhiNbLqD+2nMaeSFi9dPGoKC5W0nK0OehR5ghnBsdb3y7iBd1l99bHbLzWQsgGsGbs4TLY2beX/e8eNG+H3/KAIgHJ9J4lf9bpR87vNy9uKT2hymxuTtOF3imk6vrczmXV1XwSWToclweYNbkNelBfKtzEAGpnF99gk0mSeNx/hIF5c/l+GBJ8p8viZzMRynq/D4pLiAbgL/Mi5sCU/1x2F5tpASkUuco8GsZCnrXmA/JuacYNANk6jEr2rZc52oDGk9gfIYMLO3c5aidx9+MVV0jNxsJSnbXdat9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25FXIWZr7HFO/KtGICcieze5mrHkV/URIhUjR+awnh4=;
 b=FpfDSOlmq9Gq/IdT3cgYO/sSEh8wQMea+0tHDnZZqTbaxJvYNf7Zy/B2fkkRq5MLYzOsDisGg8sqYP9Wo2sK9/XX8vv1O3a2TtnaucE6AjrlxEp6p4NWVwUHmM8/2m0cFwjJOmNl5X1KcxACU4pniXMrw29+CKTIwdKTCQwLK2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 13:51:08 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 13:51:07 +0000
Date:   Fri, 4 Aug 2023 16:51:02 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH v9 net-next 12/12] net: remove phy_has_hwtstamp() ->
 phy_mii_ioctl() decision from converted drivers
Message-ID: <20230804135102.u3i6lz2bjhh3p2rn@skbuf>
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
 <20230801142824.1772134-13-vladimir.oltean@nxp.com>
 <CANn89iLOspJsvjPj+y8jikg7erXDomWe8sqHMdfL_2LQSFrPAg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLOspJsvjPj+y8jikg7erXDomWe8sqHMdfL_2LQSFrPAg@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: a26d69cf-bfce-4773-3628-08db94f1da6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpMs2s204hNtGozhd1UnlBuREES/Vk4qqDNsdczVkE4C9fcadZRfr4/fv7qxfolQbfF54v2JDiUzI+2FDVS8KMMUi2YzRUG29qsJtRi8WRbv06rNuNYDdYUHWhwjtTG770fqPedjL1p9/oFMGT25n04fM5V4puSK596jIPBcvcH7kNCLF03IReiWfkXqdwhT4kifym4yceiZatZ0tzI6gehrVGquTt9wlb1IWrHApD58Q70YARI2lSFVvobcwPU/VV8y+QXjHupZ2ZxtW709knDATXaJru8zmekQCG9vof0sHONq30XD9+hxVQk/kqO3KvTDhG9pA97A5IeIxdR+MAgdhERP0C8eRHDfu5QrMz6QJX9V0z6SmPq1bO1Fi1RN534DXtNU4j3gm/sHhIzcZSxFx+oHOQ4ACDx712wtITAbq+6bOhUCiCzvhRdvUlxeTZ/NmSKLPrkufWUlSvMsyUYLmLQ5ts0QbgsdjBjPfS/khuTqhykzp+R6X4PNskQ4mGmJEbVcu89pcED6qsYyL74bApDM+ZVwCnKBM36ryUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(346002)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(44832011)(66476007)(66946007)(66556008)(4326008)(6916009)(2906002)(38100700002)(1076003)(6506007)(7416002)(7406005)(83380400001)(33716001)(54906003)(86362001)(9686003)(6512007)(966005)(26005)(478600001)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwM1Y6QGWawJSVTlzanyBe2SbjwCT850aFIdJL75aARieiFPJ5ELljjhWMmc?=
 =?us-ascii?Q?swawT9Bh5+Brzbme+hVTzYzIxtwF4iaTGRVNYswevC9gS8VGAm54hV1EFndW?=
 =?us-ascii?Q?0G3D74FphhOFywBblqS1CJ8VNtu+Qua+i4ZZZ3u1TplRwAAcNp852NEwI3Io?=
 =?us-ascii?Q?ZwMG0PuhLMJ8shPYt5KXgmWOL/NHd69XWM/HRwdqqsqmcpaFFnscLwlItSK0?=
 =?us-ascii?Q?PVcoucmNr/DqShkDTe9YxtYBA2GM78O2NHJF30xAwh5/VUKXgd9X8SvOAJrX?=
 =?us-ascii?Q?I0ncp0hmioUVlJYhGNAYwbrnyqDiqcGwm99670SIfeSU5sdRWQKjF5/4uPJr?=
 =?us-ascii?Q?4UxvlTK3boMVPC4LFtiY7fJlTLl254B+CAZzzG7AFC84sJJyKq54FMSwJFzo?=
 =?us-ascii?Q?E8h8Kz+cuW48hJsNloLZNjzmYEzbK8lT2o3Iz1CTu40NsirpRWKlAOfmWPa2?=
 =?us-ascii?Q?9ITx04ZrvuTOmwzweEbWa/vwfCi4JHwYBGXjjyCT5+NMONup94Aa+4pFUeFd?=
 =?us-ascii?Q?UNi4/YslK1JPBtO8hIjxy0z7yi6c0NVYC2UX6Fhs1pVunsSsuaqTXMaIeGa+?=
 =?us-ascii?Q?ATKfOumYuRcn25I61siaV8BfBHUrpfOTgnj0KKg1CojhIE75fcWTiPvtQ4zL?=
 =?us-ascii?Q?NVq4VqAKQy7OKwD7tinns1SYGgG4yavHzROCDccIBY8PBJDkjs1L8iCzDhTi?=
 =?us-ascii?Q?Egg4+gRYBz7o/4NYQMRS3+2X8Yatkq0xauh2oOMQs/cZazWZeUo/eEGFQPfk?=
 =?us-ascii?Q?FPQq0YPqrUXoyNM3hdOx33qEui5OQ184ikFJ4lGOyVIMsZOYoMhob4Zs8vwq?=
 =?us-ascii?Q?23Vm8NYVEtfuajasGWCo46rLQx/kTfF3avW3AjyNZMQWDgaSFEf580Sty/eY?=
 =?us-ascii?Q?OhjSZloPWJrW8wfNImyM8vhOFOgt9HQLv8ryX8mhgD3ko+byPHwD/Snpgc94?=
 =?us-ascii?Q?sEm6Rb4QQKOddb9xh6MCyc3MGQQN3phVEGF6ATDfj80AYEWwMW3jxcIyQYa0?=
 =?us-ascii?Q?y4djfLSm6xy3FPl0IM/WjnNIPa3Pjz6l5Gy1IR8ZpByZwXIu6YoghBH1y3/T?=
 =?us-ascii?Q?baJNsY4xps7peO4mlG/mIVCAfHmYHTol6QP4p236/ALYRKHJUC87Po0n3ytJ?=
 =?us-ascii?Q?WyqcVT0T0WkJArPq+rFFmfpkLkLQKvgi7snQM7Tb39WhSx4hTKnj5EFQiCv3?=
 =?us-ascii?Q?hW2tOwSPuY/4z+0+loH2BtZI3dSuip9KS2lKOFwFN9PEa1QypMf/SQwTFCPs?=
 =?us-ascii?Q?1HCFVz5BxV7TgUaXRLcZ+bEqQYgANdOtvW9p1YJUMh0o30Dr8OAd5uUTX1JF?=
 =?us-ascii?Q?0an71jEWxnsVipCvAIGsEqGw1NNZF1Foxvgsl2F0cLdSm3z7q3O+V7o/v0a6?=
 =?us-ascii?Q?u/9WqK/9qtmjGqb1f3H60EaOGgweIFq3NmViji+ykOq1L1KzIjbPuGaR8bw8?=
 =?us-ascii?Q?wXYzyec3Ss+AoKCvAD3i4XNVXmCOGZ3OBefNwFCQW8wD4wGs75gGJtBmT9TX?=
 =?us-ascii?Q?Op6c19ztEg8O6zgJGgdTYsR57g25sB80MnP4cKzXpYLG0uj//B49n34LGKzh?=
 =?us-ascii?Q?TvJ2icEHLYcgDeSW7uf8xLYFdI1iAKMRiGhAzg5j4QobAn9z/y1ogfNKgNf8?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26d69cf-bfce-4773-3628-08db94f1da6d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 13:51:07.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBjyPPy7q0qqUDXw6Lo9F71XxUffj/xuzSY4ZY7QvyImvuBOcuWrEX+8mHWsFO28SUmd+rTvscr1TogUqq7Atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 09:21:28AM +0200, Eric Dumazet wrote:
> > +/**
> > + * dev_set_hwtstamp_phylib() - Change hardware timestamping of NIC
> > + *     or of attached phylib PHY
> > + * @dev: Network device
> > + * @cfg: Timestamping configuration structure
> > + * @extack: Netlink extended ack message structure, for error reporting
> > + *
> > + * Helper for enforcing a common policy that phylib timestamping, if available,
> > + * should take precedence in front of hardware timestamping provided by the
> > + * netdev. If the netdev driver needs to perform specific actions even for PHY
> > + * timestamping to work properly (a switch port must trap the timestamped
> > + * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
> > + * dev->priv_flags.
> > + */
> > +static int dev_set_hwtstamp_phylib(struct net_device *dev,
> > +                                  struct kernel_hwtstamp_config *cfg,
> > +                                  struct netlink_ext_ack *extack)
> > +{
> > +       const struct net_device_ops *ops = dev->netdev_ops;
> > +       bool phy_ts = phy_has_hwtstamp(dev->phydev);
> > +       struct kernel_hwtstamp_config old_cfg = {};
> > +       bool changed = false;
> > +       int err;
> > +
> > +       cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
> > +
> > +       if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
> > +               err = ops->ndo_hwtstamp_get(dev, &old_cfg);
> 
> old_cfg.ifr is NULL at this point.
> 
> This causes a crash later in generic_hwtstamp_ioctl_lower()
> 
>     ifrr.ifr_ifru = kernel_cfg->ifr->ifr_ifru;

Thanks for reporting. My control flow is all wrong, it seems. I've sent
this patch for addressing the breakage:

https://lore.kernel.org/netdev/20230804134939.3109763-1-vladimir.oltean@nxp.com/
