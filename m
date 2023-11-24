Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0D7F84F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjKXT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKXT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:57:12 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4A172A;
        Fri, 24 Nov 2023 11:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqouQIz6WHjvOIFQJ53rulQh9QCqGEBIR0f5VsvPq1HNNBXGW3oNhCORO3PuFKboSRDFRf7bfBHYwpcWzKSROxKlSnuhzIYN+xFaCOwa2D2nL/qIqk4BOyTa66svyuLFgXxGrnLy/si3C0unoJVpGMiCuDhOeHjDJkYNGlO63GFom0DVhO2+/p9waYkdDQAq1MY0jA+CGQFDt1gjW8j+vhjRHnEwsQ7M42CTOlAlN1H3A8C9N+ECz3wXU2PIos70UdYZoNI806u9k8KEXk6Xu948on4n+XD87P+L1iUD9ihbASGgFH5jKsbQD+0sZSCSvL26zvVTuiAWvwGN6zt3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT/9nCUvTCqDxUkJRY0/HG06RPp5bIjOpEjU3OhtAek=;
 b=WuGk7qtVUCSt7gvryRI4waqueVKB39QXk+j8x1R2jSkRK3MVmAKKuHueyn4qLYmHS2kIYJORTrUW97N/6tKOImRl7pW8rkJF+43BHOadx78jxEZ/8+qC4vQ6Wo3UXWxPpIQLZIyH87VNg0mHPj7InVLdrlQGNvGDHyZSMAGcKhBjThkPmFBwMgwP/eJjhLrjC2xBsTbAp4bObJ7Gvnm9ZZeIjk1XBKGYCEvTAXBBnWwtjYno+QRbozOZ+sJan7J6lEKDeqEA/OO6Uw+XrOqIrJbsmWSYu9HjNwVFGQTiDdevtR00WPfvngMcThmxAnfnk5f9rJaU3Bz/hifMabRiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT/9nCUvTCqDxUkJRY0/HG06RPp5bIjOpEjU3OhtAek=;
 b=iuwS64VM7T0GdBg+zHUv+et623pNnT8iR+f6JhksIKaxuX4XUcqQWQp0CP7UN/YX04lAMwXUrx6RZmj4YjCbd5tfd/553Ca2KQy1j077YXe8R9g4GUhEHocKiQFWXZkWITtMBbNV85zlmDiW5xazM5nGjCOCeiwpc7DXojO+Z7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 19:57:14 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Fri, 24 Nov 2023
 19:57:13 +0000
Date:   Fri, 24 Nov 2023 21:57:09 +0200
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
Message-ID: <20231124195709.wkhplnhtpxf75a6n@skbuf>
References: <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122085000.79f2d14c@kernel.org>
 <20231122165517.5cqqfor3zjqgyoow@skbuf>
 <20231122100142.338a2092@kernel.org>
 <20231123160056.070f3311@kmaincent-XPS-13-7390>
 <20231123093205.484356fc@kernel.org>
 <20231124154343.sr3ajyueoshke6tn@skbuf>
 <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a694f66-bbcb-411e-4f43-08dbed278d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91dovqOrl2999KXizCSjAtSx7Jpo+aVMwoBzbBUfvH/xYG0n/ubW35oA293sssjV7+i6Tt/8gn/ZauG0mwp2kpSosifNu78xUnqA89J7nRxSv6FdhJrPa06bQSobh1C+JTu9mBS7H4oMj0IFFL8y6MmaFVQyoaD922bW8Re9FtQ4gNrpxi1Fi+0u+impqgeq9xcxsQimSVh+u6lRwEUL02OAArp4WhCtBx5/Egiy+rpWkJ6jGTlUinl55sfkHin8YVjScRVzcZhjArQ0fXWH4aDww3gFXS1ZhpS14RT1y5FGuvDEQ9uTta8tMY4vmsDvk9A0lseyq9GNV/NszNGfMFfyl+JfYBmrwc7I33GYk7Mp/+eyTWCLLFW2l41Oen+2FIjZP8yIPG74jaDPtw5VOOxg9HQZ2gt9ApYnAD635sDLOHrEcYgYUGBIebEU/jjWZDIjUfcb+TrGREjeHo089OXegWbJbDdbsZm+Ei0XchJAgQ+X6LrozGdHgf7KzXHe3k006E4kCOBcji/2ELBXRCoQI2jthYvUDZ/k8bX18BU3c2K5aiIWHDpgsXQHAxhj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(478600001)(1076003)(66574015)(83380400001)(6666004)(6506007)(6512007)(9686003)(6486002)(41300700001)(44832011)(5660300002)(7416002)(2906002)(8936002)(33716001)(8676002)(316002)(4326008)(66556008)(66476007)(6916009)(54906003)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Wkex0m7PZrPvpo9BsQOLIu1skeNmEhc3f4MKsCbWCBYNpTpP57jJXeWaf6?=
 =?iso-8859-1?Q?ZoddXENoFZ48JqrcNXuG1lDai1cgpeE+VoCZ1jF6VhZBBbHngr26bM3fRD?=
 =?iso-8859-1?Q?DLztvjgBD5Vgz+L9yLLo5HeHfL3MH1EYTBKph0tjo+8c5K6rKoKCR7tgaK?=
 =?iso-8859-1?Q?dktwNjX15GL1rlipSxfZyxZiFfT/Pl20hwH1hztJFsVLPdI8nWzX3HqYUN?=
 =?iso-8859-1?Q?NRFoUnRcvDYW4/U/GFaLidJ6RrkmoIqgfa9OphkEIoKsUbJv3MgVSytr6V?=
 =?iso-8859-1?Q?rzJBXW1i4Mkcf4qL9OI8AsQX4W/e8bybVx85U7O/KqyYcQdHguqtwnxsts?=
 =?iso-8859-1?Q?Pgzf44417R5p5R527GGWcndtk1ZfwugTVI0THQ0VhQMTXnKl/y+otWqXSP?=
 =?iso-8859-1?Q?SzwiviYNbJHv4+GqUItJdoj+8lqmmKqOqdSNkCYn3g2sJX6eY0YjeG/RuB?=
 =?iso-8859-1?Q?Ii39cGhGEgJslVVVr2cFIKI4jST1X1Uv+5sawp/TnGvbFoym0y2LYIpMbP?=
 =?iso-8859-1?Q?gYQ92q82P5pqT73VfbT2OzW14aDd3U3itQCQESbyy8nKypbVUD/WZBMaxm?=
 =?iso-8859-1?Q?SP5+EEkEMvW3Xp/a7LAX2p9NOb6wa7QiKG7ePKJ+p7xbr+D1Lyo6fqKxEC?=
 =?iso-8859-1?Q?NIrQ7d20WwsVjATCZRumIownakcD9D92Gt8WdDc6LAzuRZYNk/MMwZoyw0?=
 =?iso-8859-1?Q?biBGSDa9CtdxhVRp4q2tRk70a/D5FaEFuZtgccaI1OVKBk5ck1kV4nNlBV?=
 =?iso-8859-1?Q?cIs/D9MzgT6II6pRswPLPrlM1CLzlr46hyEhPvYfl6pAHgeaJuJpCkNHm3?=
 =?iso-8859-1?Q?5niPVaASOXPeXBPSLJXoNmhIIMDTldmC0D6bKT6w9GJ6K/QkU/zoR79m4l?=
 =?iso-8859-1?Q?cOqTL1Pbu1XuhaSYUcS2jpBJWRbOTpS2x01L0i0Ts63kwczQKwgKs2PxAz?=
 =?iso-8859-1?Q?VaDqQcSIVcBhNDJpzOeXGZYjR5anZq5JsxjlML3i7fQaSlu0Xrr24NQZ7K?=
 =?iso-8859-1?Q?8ZMIR/FVdWPHvtUW0ZLxa2YTaAGIvpq9NYSF40ZCi1HzO6XZ93o2+GCP3P?=
 =?iso-8859-1?Q?o0iKbm6oXxQ2janPrjPjXOb0Y8bTh4iUZDs+oL3rhOADjoV1XVRuX3NRlN?=
 =?iso-8859-1?Q?EYKEu3dE+bSptGQ9y/QfY6yBC7MZv3Y0j1CzqZU0IYIcDlFgSsrFWiQDoB?=
 =?iso-8859-1?Q?nzPTJo5yBld2IpsW6AaRJY0RkV6UnD7nu4oXhEj7l4g7ZE5U/tWTA430wj?=
 =?iso-8859-1?Q?V9Y3VRqyWA5oTtkAzOTyv2MZqhUXyUcvkAGcYJiyDaIL2PiVD0+ZxysdrL?=
 =?iso-8859-1?Q?54wM/lL2VSKFu6B0znny7XP3kMsnB8IZgK+Si8xeLQ6KhhztCmwzVngFHC?=
 =?iso-8859-1?Q?fmJbgAV84XL58TbTP1jJjB+6xw5L2cEsulY43fkzhdm6Dfwyxpy80VvD30?=
 =?iso-8859-1?Q?/f+nyTbG3MG2wXBZe1sETa1bNWhGadkwD+Ggzy0s8Chn7ODOJLC1o8b/mp?=
 =?iso-8859-1?Q?KD7dyb9L4C0LrJ26QwEFaxFSXJrC6S8v+P+4+ZkjvF6nR5Y6GmcJSFizKV?=
 =?iso-8859-1?Q?QiKR2oxNGyMUz4xYhpox52Qad7Od6SMYmdebmQDcH7VXKDiBTXkEmc01y0?=
 =?iso-8859-1?Q?GbUkskPSPy1zSiftkjvBxyEDLAbhOPh4SEtcGxGWgfUgKJ6+OEqyoQ7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a694f66-bbcb-411e-4f43-08dbed278d61
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 19:57:13.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayoa6SdvlfIKCmwLjtsccc4kKyiOb9YIWOMozEfIo8JB1L8n2odpqNwOYvzM1Ewlumfrtp6l52SjZ5a14w9cgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 06:34:31PM +0100, Köry Maincent wrote:
> Would it break things if both ioctls and netlink can get and set the
> hwtstamps configuration?

Uhm, obviously? It would break things if ioctl and netlink were _not_
freely interchangeable, and you couldn't see in a ioctl GET what got set
through a netlink SET.

> It is only configuration. Both happen under rtnl_lock it should be
> alright.

Yeah, but you always need to keep the API interchangeability in mind
during the implementation.

> The question is which hwtstamp provider will the original ioctls be able to
> change? Maybe the default one (MAC with phy whitelist) and only this one.

TL;DR: yeah.

Remember one single rule and go from there: new development should not
change established setups. So SIOCSHWSTAMPs should continue to behave
"as before".

This is also the exact reason why I asked for the phy whitelist. The
introduction of CONFIG_NETWORK_PHY_TIMESTAMPING introduced exactly that:
a breaking change in the mode in which deployed setups operate.

> > But by all means, still hold a poll if you want to. I would vote for
> > ethtool netlink, not because it's great, just because I don't have a
> > better alternative to propose.
> 
> If you agree on that choice, let's go. Jakub and your are the most proactive
> reviewers in this patch series. Willem you are the timestamping maintainer do
> you also agree on this? 
> If anyone have another proposition let them speak now, or forever remain
> silent! ;)

Hmm, proactive means doing stuff in anticipation of being requested to
do it. I'd use the work "active" at most...
