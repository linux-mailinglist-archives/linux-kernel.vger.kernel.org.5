Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847567CC570
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjJQOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344019AbjJQOBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:01:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D8F7;
        Tue, 17 Oct 2023 07:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlYet1dymDnUPGYeM5eVHY9HJGo8qFm7duPQOj8TgSsk0zFghwSerBeQsTw5+pynJt930VJrs2OTn+QkG6dgtbP86i2JHh8cwbXk1eXbALr/LH9DKBd3zqySlRfyqZWwaTrEZSUXbKwkW9pASHse+IsFa0w5ZqTN98VQZbcpyKGOccAdbo/JbDO8EDyU3L50nEc1tnhLLUCodb0+RufMK0KQvMqZNbK4iyp85MSPLx8MEInfO6Xfp7IhTyEPc/+omcP5WVNNOHwfB7gMzdMVg1sjwpVJsKI5ASpt2uRtxXsVmjAhIMbCJwC6qluYv8LMY35GyhwSKvjCMggGKvJ81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gy/xj/DsCqd744C+d0UGWv8g7M6rxWC+yjiRak4iLU=;
 b=Yu8q/3eFORVejGZlaLNj/45vDARehGxOcB2bKtuISyxby3RHv1QQtroAXNdTGqrOvdYBbcpgnSOuV7O6KEH2ETV0VyVgWTQzOqufSpjfnVVooDTQHKXHDMvc7E/twpWZ71yEIegYeuO/ksuwhZ8g1+FselE21TlWO+0lUA0BrqeM+p5E52A/ZhuI3ijCs/TX7oM5lnj2W42XEkj4qdmO8tKbOrEQlYsY3J7N5gyV2Jrdqe1fzVP/D3776KCNBjvQjArQKvGUJwTvI6OpKcspxeBD0/MD0p31gqdGvRLg1MQ6aFr0eAlpc5uTQkAbq1tIHjMvyKEObuvu7bvui3U9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gy/xj/DsCqd744C+d0UGWv8g7M6rxWC+yjiRak4iLU=;
 b=LARKGFN5YBscxo+i/F7An0Ray54kJZPF96B8fPqnwMPZpKMsuuvPlFIlqUE4SIxO5YyrSrJunb2WpmvuO/SJBh1HLgX7NuVVL7sd3ALtl86IHIwPJcXnJJ1PtvCVse0Q4Q/PmYTtjXgyl2d0SpdqMjg8aEvLq44YhfcwSeZQo/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:01:37 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:01:37 +0000
Date:   Tue, 17 Oct 2023 17:01:34 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio-mux: fix C45 access returning -EIO after
 API change
Message-ID: <20231017140134.ce3cjv3bhbq3k4m6@skbuf>
References: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
 <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
 <4ccd7dc9-b611-48aa-865f-68d3a1327ce8@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ccd7dc9-b611-48aa-865f-68d3a1327ce8@lunn.ch>
X-ClientProxiedBy: AM0PR10CA0113.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::30) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b496c93-37a1-4707-3d31-08dbcf19948c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePyZrUN0xgwmxEQf0h3sycd+yMc6GUW7kZj+CBto9oCajHnZY6HW08YAWde96QwaGZ2t/zTJac5rzWN1bVRXo5TU1qTgYQJ1Se9c5LwyV9yw2IhPoGtPTGyB+IspPQ07aVb3l5DnrFNfNvM6SmzIGzP9bcNm3L78atkaJeNn86guDMorHwQf+cAS3fo5uvADGusH2A81f/Dojd/Lh2IEAE5D9L89x0XNb3CxmIDey3Cf+7auMURNImkKY8K8+3ICzkcl4EhFa/p7g3Zm+Pb+2wuH+F7tPX4NcDqWab9Q6hMGBM92zWiBSeRbor+k4eBfx6UgorWvUL33QKGzaurHuF2PZPSjiVnhQobyO/7VKZK2xCzhE5YNW1ajGez1O2ENEyOAUP9uaDUoPNFrEWPDklndKf7JRzK/WYg2hx9oVfrELAXk9JvNiMLS1I3N037+SzLD5WWfdyg5fLbbvAjTbWS9N+GJbcFF0/4GA8p8oJWpm1UC+GZnzkO/ygHt5CqQVpJ+ZSHRb4BAle3aWa6m43xs5+yJWze+eh2W4fQ9f1Sx7kKpIaKnd8W0dASPJmFu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33716001)(83380400001)(8676002)(4326008)(316002)(478600001)(66556008)(66946007)(6506007)(6666004)(6486002)(8936002)(26005)(6916009)(1076003)(54906003)(66476007)(6512007)(9686003)(7416002)(4744005)(2906002)(5660300002)(86362001)(38100700002)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kq+Br5I2x1Ry5u2NNgLLeruRfYwPxmczsWD7Rw3fw5ZWK6gKI86U5IRDEC0k?=
 =?us-ascii?Q?YqwI16XSL9P6zNag984vFsJ1BrPAUuocD9OdGnpWrlQ6QW3Y3abL8BBLmSy7?=
 =?us-ascii?Q?ja6N6rsFygJEcNRmPvQ1Y8k4lLYskzAlofj4IBcNxYIfKgHS5WdPexJ+6GN0?=
 =?us-ascii?Q?H2GwfECsRstB0CVK3apm/pcYwYRdcJ66ua/i2HWGgfXtBAcr0Whx2/k4nUd1?=
 =?us-ascii?Q?Guy6c5/ZoKcc8wh8j4DLwYO7wOKX7COuDNf35b9xKWLTDCf+vAs1HkHRlnd3?=
 =?us-ascii?Q?yuNqtdbSH3HYEiPZxjmSTWcL6OBppOUTxOdCtqxQb/+hZboh53n0A01hRAWN?=
 =?us-ascii?Q?TA/VX6pvM74zcAbA5bKGFT63i9v2cVE/REicaTLqakE/lYK9s9w90NZ23yX/?=
 =?us-ascii?Q?PrNkj/yyIHRyteJQtKWRzqW4ugEJ+OABCTpOADFANBRyVNYY0wWzEiGM+OOF?=
 =?us-ascii?Q?elmHXe2RVL0cDzCFzBQLoEVl/jQslxZuvxh8pVSPSJXlNTMYs1ccrtwb/EKP?=
 =?us-ascii?Q?Ejuk0xK1d/IidUAqXh5Htt4ivj6wKAYV/hOki++RJjg59jalGj2wU5wVAKKH?=
 =?us-ascii?Q?C8acfTBGIUiRKL+HAuY4HC0+BGeUSYm+mzoMccqXaPTmiqCWLpbd/KBD8ts+?=
 =?us-ascii?Q?OCUVGm6uhbbyCaw9AExzn5Z0rGA0+LHSnur9PnlS4Uxggf8IxWYiWMYL7opv?=
 =?us-ascii?Q?661ox966OekwemYcuux9LAfDJbQpyNCURQ+oUhVOpgJlMBiQ6SF96kIOoqIE?=
 =?us-ascii?Q?ZmbCm+KeSSEIEJ5QTjOza60/zzwXynhz0q50RbehmwDbKpY2GJDlG0wpAmPg?=
 =?us-ascii?Q?INkPLR7vDV4+JcaFeUSzeZztW9wbB1fGjB55dUi9wcUcm85euxTfUIl0BsLl?=
 =?us-ascii?Q?MZsuo4elCX8o3RcQxswARlQ05AtZSl9ClewEBFxVgiUs2zLwx4dWNLA9QNab?=
 =?us-ascii?Q?pbNbZzFal2KT8i6CxuyAzdr6Q3xzQhZmWF/ILMUuZQ0E3e7zZ9E//pgx3MoJ?=
 =?us-ascii?Q?CWhPJn8e+l7eJWapPKT5GZgrZowsJ4fqbtV8z/ZxOylG3GlU4ruKq6XGDpZ/?=
 =?us-ascii?Q?R8R3j53P7FHxEYFKx9ZhfnkZ0oU399Nt9aViKDvJSk6+yE557l7+v7fjTU6L?=
 =?us-ascii?Q?nFK1zM8xP2yAXTKH/Bpvf8FFHkUMhDnMRdwSKNuxEm0fUVksvFznv8Wmr+bA?=
 =?us-ascii?Q?np01KwgjxLRqhetkAy4Ui80rI7pNWWsTSjgDv5ZZcfNGQIR2gNRMsLuVpvwA?=
 =?us-ascii?Q?wQgbBZzH7JX4FFXkiz34ziWMVGRASzvCsQnxwA/X4M0BQ56tS3C8IB2TAb5v?=
 =?us-ascii?Q?H11oWWTH4cTKnH31Z6LGcGbnK2aFdixDIsGsW50Zf0UWq2SPO/urbmOzKt4y?=
 =?us-ascii?Q?VfTxxUVa0AXtQmbU7YfC8XU2wb/FQj1m0vhdH1+hWOUczPdIPWqHfKxdIaLC?=
 =?us-ascii?Q?2jEyLxpaJGEisjqpIEzmqJa8y6yXUZPYaVMdPE08IpW0d/v1OS9JO6F+0L82?=
 =?us-ascii?Q?yNCGEEFOeOelQIciaKwwYPAzziNTFtgQT/vg2zQA5APNWRGsThHGAmOD0v6Z?=
 =?us-ascii?Q?n5+t0tT1YP/bPB0yN8DERO88txI4ZOn9gFZgfkc3kWKQibVMWdx+jNptOWpI?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b496c93-37a1-4707-3d31-08dbcf19948c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:01:37.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P57MEwidqyVaco2pUQK36yJxrdqrRbhtSRGye4Le7v+fSww3C2JxGAgCsCLol9QGxIIXluk/Uh+c31fVflXAPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:44:58PM +0200, Andrew Lunn wrote:
> > Maybe make these conditional on the parent bus implementing the c45
> > read/write ops?
> 
> And optionally, for net-next, make the c22 read/write ops conditional
> on the parent bus having C22 as well. Its a bit of a corner case, but
> there are a couple of MDIO bus masters which are C45 only.
> 
> Not having C45 is however very common, so we should make this
> conditional as part of the fix.
> 
>       Andrew

Ok. I don't know if net-next will remain open after this patch gets
accepted and "net" gets merged back into it, so in order to not
completely forget, I'll add a patch with your suggestion to our
Layerscape SDK and that will serve as a reminder for the next
upstreaming session.

In the meantime, for this patch:

pw-bot: cr
