Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD82B7F1E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjKTVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKTVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:18:11 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C0C4;
        Mon, 20 Nov 2023 13:18:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXcTvB3rBq0l9d9HY2ISpvO9iG+ExcBEGWzpVCxbX8UxnW2L0wrmL/ssNMfYwwB6B2eS6Pd/m4FnKxSZkfMXMg6NXgQTiQQUgtXV/xiohsHjCpKO2YZcgBBACp62e7DeqTRjswfnNubtEUaoKp7vfpNzCn3UIMsO/rNNb4zNHgYUImx4pkeCkvsNUbW9ei+0ZIznMv+X7fcmARKMLZh+qWLHLRB0F7UwE2iR9dNemYqepqUr0xqkgFQRp/ZbhdYQyOyfYR9wvPhkztVd+aMoboDE85UeI4YuKhmibnk2KqVbVuDe4+B44oqO63j98pvA8oC48BPycYWrtvk3CJ/gmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGC4930dmDbEpYKwO4PMeIK3SPLXqyTV1lV5kB7MLYE=;
 b=kcsDtMSbvtOtROEx1ju58f0oHAoAdaYSQVuNYAx2O94nBDHt8/Sp3SJwJtBHKgnU2nBAVWPt9oBIuH/z9TSVn7PEBX/TjmgEjsHebTbbuJAgw7Dpo+6WFEJbHf3tmW9XF/Y9n+/SiM7uJy/iz2fvA1cjdC4wYcZTDuVGglhTPgSqRYZ39vrbGYZStSoTdgRI9IK2BOT1zdOdztPHveFMyvSaCbudgbdfPbdtjcZJYjjn0aOSmc14F5PTn0Tc4qtvDbYjFtLvcUvG0VFUbAiuIR6m3OsDoYvYuCgbK0fRl8ajW7hS5g8avhfxqbvLRkWNa/fGMJJMlKvIy/NSTrPiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGC4930dmDbEpYKwO4PMeIK3SPLXqyTV1lV5kB7MLYE=;
 b=tAOeopr6iXpPESMaykIwha29JRZlYuFJJBqAS6Q84IAEb93SSY30Eu8V+qqFUr4yP+786ZJbheN3ujM84GO64EPYgKaBmC008dJUVy0x/EIR+SnVvE2JpGbNFmSzK1AC4FB2P5oQ3DoVlbG+ua80NQsec1Fal5jvQPf8qxvIIWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 21:18:03 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 21:18:03 +0000
Date:   Mon, 20 Nov 2023 23:17:59 +0200
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
Message-ID: <20231120211759.j5uvijsrgt2jqtwx@skbuf>
References: <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120115839.74ee5492@kernel.org>
X-ClientProxiedBy: AM0PR03CA0087.eurprd03.prod.outlook.com
 (2603:10a6:208:69::28) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7c62cf-112c-4c44-079e-08dbea0e2e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSJoNaRey6oi58q39fqQd1CNkvT1VTnGaBliRvhIYAPM4ooehz2IhrnC660uocLcjCgnJPBp4N7EpteiKaYdK5APoO+k30QWbd5gjgRE4y1YkAqBgTkzDabCwS5I/2uZYhOtlScv4afChcspZk4huHXT00kF+nPuM4EEboy74ypyS4hN7ItVO8MJ/SAX1+pdZIEorCLhgua1IThEdbkTEan0H4bS6dNqHr+uO8BH7XrHjhSUy13oPZ0AH97wFud8gSnO3rMI96iadry6NuI55S6ad4rB6Ij9io6T+mzFFwhpKCq7bYZbUkjc9/I14dAeso2NMir1dVvoWrmg3PXGES0Cr+v1DiEL6dEs+JCtr79+jPS85JZeZmpdYHhRNuuMT3yM5G1y38uEMEo1Ov7izQPg2gLftw6q26E0FAQ563a0Ueoys/GbaEgrKxI9xr5Y8FD5TNb/kLuIOK7mCtwvTUEMwXLB3Ey2nHo24wYAsD3gVyiDBDTFQPeQFGqfiNeGXbYgUCx/K4ezCF0BPbaGe1zhJlxfryKdnq6NX4M5bNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(83380400001)(6512007)(9686003)(478600001)(6506007)(33716001)(66574015)(66946007)(6916009)(54906003)(66476007)(66556008)(316002)(38100700002)(8936002)(4326008)(8676002)(966005)(6486002)(26005)(44832011)(86362001)(7416002)(5660300002)(41300700001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2ryLX5PIgKnJ5m7C+d+xq4iCHSTl5r8HyXH534cfb4hSyBaZfYXHdxzQUj?=
 =?iso-8859-1?Q?aqoi4LvT970B78E09inEH2rv3THlAGA00Q15h2yjGVw2BkgI4JaYKPIUtt?=
 =?iso-8859-1?Q?Ugzj9zBiJTaYCtalOp/ETVrNW29gDQFZFsRh4bsNyHE+R3MiZiYAOWcTmh?=
 =?iso-8859-1?Q?lgVdPCxtPr9eV5cT27t4pz7uZhNPRei5yATN07kNIKizUclCH9njnT4iUw?=
 =?iso-8859-1?Q?nL07gAsTFJxkvyXAaq9fchW5f2Wum3ncuyPBBZ/l6onJZ1YEi28aKYuope?=
 =?iso-8859-1?Q?R5vDd3I7ebkNRg+dzi/YXh8bZM0voGudeNTat+Q+tHBgCx1nR8j1AMwPts?=
 =?iso-8859-1?Q?lZ9YWgLioyVFTme7W09OKF9RUWzDwK7TaNsn63IqN3MRjv5Qoa/NFEmHIr?=
 =?iso-8859-1?Q?1fnS7OTemfK8LVG7ZykYhhLy2czkJv1IFHcwxoYxN3ryaIflRbk9SSrHyt?=
 =?iso-8859-1?Q?qI8+aEVdncOCgRbI7KT99HkB9NLQfH/R+3BbC9Fr3Yb0SK3wJvde2HHbsZ?=
 =?iso-8859-1?Q?qDUg6zm0GEZf7JyfRG+YJ10BqbYZ1AmYs7zUp5yUzIG0hexnIc+LkeHFiN?=
 =?iso-8859-1?Q?gXSU45bQz1yQMhN18jsclNOWFpkSfCxXiQx383v+CTDHjf8wkjpgdIWamR?=
 =?iso-8859-1?Q?qCXQEJfSmxjrw3drr9KG9K1M9G5PfOLOdKR7+RKtIh6s4GQg8JgP9f2h7Q?=
 =?iso-8859-1?Q?ubN62ScdiCOLxNdYIKtFt/ZcBQnlzkBG2y8Yy4HYkt1UxnGsEnemH8A4YN?=
 =?iso-8859-1?Q?Rimu6ZIEMhuNI8xBZKr13d0pDT6tzmqv///6q0b9e3DzE+h9VY6AgAKT2A?=
 =?iso-8859-1?Q?8m43pO4QcUrKDgypITfBpQrSrO26M5QabNfFWNqX35MhQrRol7kKPKX7sF?=
 =?iso-8859-1?Q?bk2PREBD3O4UL03wa9xMtngw+oJE4IuCs6E+iuqyhQ1nz/zKi2Fgu9EQor?=
 =?iso-8859-1?Q?j1/ZyTJQGHBGoruuvf8rEMpeUzFlmWUrsSlt4iM0MJnoumrV9/bSWxPvkp?=
 =?iso-8859-1?Q?HFgf/463Kk2na0IBdWtQMHvzYu03dS13TaY4QVe7Tyep+hxI9cS9qz8iQe?=
 =?iso-8859-1?Q?YV2jhc1xDgXW7Ac/Qwt8FGlP9QfXT7nZ6868xBBQgYnYfP65V2ckDcZRoo?=
 =?iso-8859-1?Q?tCPL6i3twS6J/bWEQDtX/phBufw6uKsfJWtIzn5TfCU3H5ibtHuW+/n/RW?=
 =?iso-8859-1?Q?FMEIKS+J0SZNHSXV3At/Q6HZpYW9qNuLaB3NF4IktMEHHEPnjx+atTHwol?=
 =?iso-8859-1?Q?sxXvrFUAq7txdzfOZE+82W0CaexKXGmpmSa1jfeKVRNk8xuBAUTbLH6N9Q?=
 =?iso-8859-1?Q?AI+3WZw61eGjflWvbNkfCiS6fxvYlM18vZMVL6kPn/96Lymp6DNBFzoYAV?=
 =?iso-8859-1?Q?GJk+Pe3/Y5UJg01oTf6rrcuaPt5M9JK9+EfYg02tDDEn1LCWUVVZgcMREi?=
 =?iso-8859-1?Q?gnQfHUtYpuHcUsAP+ocWVcy8BYHgsqA0UOTQapa8R+IrH2joCiuhUl1M78?=
 =?iso-8859-1?Q?esK5WI9VetP6o6tYOnq+9BQ/+8yLWX99wBWrWaaMs+HcnckWFyUh/FSl++?=
 =?iso-8859-1?Q?qNdlgriNpBgjdiN7yu1llHap47NKKKiWGSMQd/aWbKu4GZwMrmnotAJRXY?=
 =?iso-8859-1?Q?dQfymYCFwHMSRmtYr2MGRgXxegSSPD3zm4SubgQqSYzqxoRaJynEHUlA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7c62cf-112c-4c44-079e-08dbea0e2e91
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 21:18:03.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDq3TacEj8U9AziIZlB9yZPC67w9wBzOYnFxV6MoIhpG1i7ikFnX9YZ7wCKEXzJX+Fj8nExSvOb9nqdvLE968g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:58:39AM -0800, Jakub Kicinski wrote:
> Rx time stamping is configured by filters. Is there a problem with user
> specifying that they want "true" timestamps for PTP/NTP packets, and
> "dma" timestamps for all the rest?

There is, because enum hwtstamp_rx_filters is NIC-wide, and there is
only one of those - corresponding to the single hwtstamp (ts[2]) provider.
There were never talks in this patch set, AFAIR, about multiple hwtstamp
providers active simultaneously (for different traffic streams) and
configuring them independently, with separate RX filters.

> Maybe we can extend struct scm_timestamping to carry an indication
> which stamp ended up in ts[2] but that's less important to me than
> the ability to configure the thing. Right now, as I said, mlx5 uses
> an ethtool priv flag :(

No, you misunderstood me. I didn't suggest (at least not here) to add an
indication to struct scm_timestamping of "what's the source of ts[2]
(the hwtstamp)".

I was just _asking_ (collecting data) whether it's ultimately desirable
for DMA timestamps to be visible in ts[2] (indistinguishable from a
better hwtstamp, as they currently are, I guess) rather than their
own thing. Like for example, in a congestion control algorithm, where
does TCP really get them from.

If they'd rather be their own thing in a fully developed API, then the
whole discussion is rather off-topic to Köry, because here, we're
beating the dead horse of "where does ts[2] come from" - _still_ a
single source, just selectable, that is.

> > But maybe I'm wrong and there are NICs which can do that filtering.
> > If such NIC exists, then I guess a SOF_TIMESTAMPING_RX_DMA flag should
> > be added to the socket layer, and the NIC driver provides timestamps
> > according to the skb->sk->sk_tsflags, and that problem is completely out
> > of scope for Köry's patch set - and implicitly compatible with it, since
> > as you say, the device-wide timestamping layer - PHC index - does not
> > really change.
> 
> IDK. Maybe the sniffles I picked up at LPC are clouding my judgment
> but to me this patch set is shaped too much by current implementation
> and not enough by what it's modeling. It basically exposes to user
> space the "mux" for choosing NETDEV vs PHYLIB.

The last sentence I agree with.

> There are multiple time stamping points as the packet moves thru 
> the pipeline. Expose them so that SIOC[GS]HWTSTAMP can target each
> on individually.

Ok, that is rather vague and complex.

You will forever have to contend with the fact that struct scm_timestamping
can contain a single hwtstamp per packet: ts[2]. So you need complex
control path logic to ensure that the sum of RX filters for all
timestamping points in the packet data path doesn't actually request
more than one ts[2] for any skb.

I understand how that could scrath your itch, but here, it sounds
off-topic?

This is actually starting to get close, in a way, to my feedback to
Richard to allow multiple hwtstamp sources for an skb, and to just give
an indication in the cmsg of what's their source, leaving user space to
figure out the rest.
https://lore.kernel.org/netdev/20220120164832.xdebp5vykib6h6dp@skbuf/

But his response was "There was a fair amount of discussion, and it
seemed to me that everyone wanted a pony."
https://lore.kernel.org/netdev/Y%2F0Idkhy27TObawi@hoboy.vegasvil.org/

I mean, IDK, maybe it's not off-topic, but it's a round-about way of
achieving what they think they can achieve in a more straightforward way.

Rephrased in my own words, you're saying:

Forget the concept of an active hwtstamp provider, just open up the
knobs of _all_ possible hwtstamp providers for a NIC. Simultaneously!
To make one active and all the others inactive, just use
HWTSTAMP_FILTER_NONE/HWTSTAMP_TX_OFF for all except one, and the desired
enum hwtstamp_rx_filters / enum hwtstamp_tx_types for the active one.
Live with this expanded configuration model for a while, just restricted
for a single active timestamping layer, and then, once user space is
ready for an enhanced struct scm_timestamping which supports potentially
multiple cmsgs with distinct hwtstamps, remove the restriction and let
it all rip! Everybody gets their pony!

Additionally, SIOCSHWTSTAMP is kinda rusty, has a fixed binary format,
and is not extensible to target a specific hwtstamp provider. So a
netlink conversion of that, as a first step, would of course be great.

Is it an accurate summary?

If it is, I'll let Köry comment on the feasibility :)

> > If I'm not wrong and the MAC-or-DMA timestamp selection is NIC-wide
> > (which diverges from your problem description),
> 
> Nope.
> 
> > then neither Köry's work
> > nor my "everything is a phc_index" proposal will bring your use case to
> > fruition without further work. Here I would avoid speculating, because a
> > lot will depend upon the details which you haven't really given.
> 
> What are the details you'd like? PTP gets stamped at the PHY/MAC, 
> the rest gets stamped at DMA. mlx5 achieves this by splitting the
> PTP traffic to a separate queue pair, and configuring that qp to
> capture PHY/MAC stamps, AFAIU.

That's enough, thanks.

> > One question will be whether, in the case of "NIC-wide DMA timestamps",
> > DMA timestamps should be presented as hardware timestamps - struct
> > scm_timestamping[2] from CMSG_DATA() - or as their own thing, that user
> > space needs explicit support for - by parsing a new cmsg level/type.
> > If DMA timestamps won't look to user space like hardware timestamps,
> > then the use case is again out of scope for Köry's work, as far as I see
> > it.
> > 
> > Another simple question is - if NICs do this today - probably by giving
> > the "unrepresentable mix" to user space in an implicit, hardcoded and
> > very fine tuned way such that nobody bats an eye - then what is there
> > more to support? Are you looking at extra UAPI as a way to legitimize
> > hacks, or do you feel there is extra control that applications can gain?
> 
> I don't understand what you're asking me.

You've partially answered above. The mix of timestamps coming from the
PHY/MAC and those coming from the DMA is unrepresentable in today's
UAPI, and is just fine-tuned to work for the existing use case of "PTP
gets PHY/MAC, everything else gets DMA".

Still not 100% clear what would the proper UAPI (separate user-controllable
RX filters for PHY, MAC and DMA) gain, in addition to what exists in mlx5.

> DMA timestamping is becoming increasingly important. Ready any
> congestion control paper from the last 5 years and chances are
> it will be using delay as a signal. If we're extending uAPI
> for Hw stamping we should make sure to cater to CC use cases.

I'll stop commenting here for a while and go read some of those papers and
RFCs, in the hope that I find some info about the way in which TCP expects
hwtstamps from a NIC. It's quite evident to me that I don't have enough
information to help this discussion reach a conclusion.
