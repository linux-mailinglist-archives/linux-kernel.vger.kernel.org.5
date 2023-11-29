Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8B7FE133
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjK2UhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjK2UhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:37:02 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656FF10C8;
        Wed, 29 Nov 2023 12:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwGmvMvp9wlS8iAtj2bTjNiSdAfwgr1L6v3T6wktiT4PmVFLY2wwNDPNYbyLAtucl1/nbRb26FpIT4DZI/N6nVZys+Qxi86rNrGHRP3rhSnXMrg7beHN134O0bim1Ikt60AmpGIm5O/teYSiXpcWTcfxGtcX48V3fah4OVWYOAO+Gi4FI8ZfPeWsaAO5BtOuoyEVlkpubGm8qxeuWv+JnXlGzlY/xfeBQQSl09HWlkd5wt1kQZkVK0OD6J2fcBLH5Bfgmw+qrbp7RWjOOGE5rUXL+vzte5UxzPW+OmqYDrAvGnVuU2aj4VSVPfOIpW+yrOptK9EzHYSyI58CwhlBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGPB7Z65IO6D3Y9PuIs4UaGq2tlyoJ5MgzXImn8Cl9g=;
 b=RDmrNxQKN/Y0FAWWoCwLX/tLTiAKcW1HqVbSM5KvTqhkxWAl8O7sG4WcPGazG/Rg0R14U5MBuGS5HN0kmjRbsaoVLLPkeab/9fPisMPbnM+3wpfH+NxauNzPnJT2BH7BrNm9GURSswnieTQbDTvcqOkbWxM4ums/1sss1yLiFhhJO5bZOHX5dWvYfccBxQBEXzWip47aqSOjNKSY4aGVjmVqLGs9igPuKyNa/EpCCI91JwUWTV0KUqVO75mnXfinxQazqd+6tCniHSK2sIczfQ64v76uiocTnXVVbYjTSS1/p7PP5103baUBbsfXKKn3NTqZPNl9Nev3AMiv20GIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGPB7Z65IO6D3Y9PuIs4UaGq2tlyoJ5MgzXImn8Cl9g=;
 b=O3dCgVEuqb7lQsDFqnfXHUPYy2/aBpN5PKRo7fD5zzBj4Qyv8JkWA50fZqd7XlSNKa1wTxL7iFVW2SuBRqCfjIl/C4ucZUhZpaI+ilez4DTiqbkrnTUKhZMQphnI/8A6U+GkELFioYatV9avouyJNv8Q8WeP6TUzn/RxHM8xiys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB9115.eurprd04.prod.outlook.com (2603:10a6:10:2f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 20:37:05 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 20:37:04 +0000
Date:   Wed, 29 Nov 2023 22:37:00 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
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
Message-ID: <20231129203700.ckpkc4r5bwwudwpf@skbuf>
References: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
 <20231120105148.064dc4bd@kernel.org>
 <20231120195858.wpaymolv6ws4hntp@skbuf>
 <20231120134551.30d0306c@kernel.org>
 <20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
X-ClientProxiedBy: BE1P281CA0485.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: c050df55-db65-4886-4491-08dbf11af2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODg4/cIOBDfNRghuN6jkDU/tyO6g2AJ6UfXoSlavkswPkTtF32F4MFvCT0JQ0zsF4bFbRJz68B6KKTwjsXAQXe0YM0h6QtlUq+8wz99fK7aZbBZcPinn62Ck55FgkOihv/X4ZrV3euNB9i9q6c247nVsvXSANuTDgnyZsfUtOztiHypAHaXzL1m99P22lPGFScrk+ILaXRlAHUyGFiQwYyPbVZcYKjTK+zRNsf1n0sTe1IBZ8HkA8X+lig8cgozJrEav6rm59Pspj12B59Oo65EYZ3Sir7m5O/oygXSL26T3DKmIjYNcCbc7+iz+pvhIUBuIz/izgqbD4zbuPkuDWh56xnLjfpuNi6cA/XgrZBRwcH6Ma4b1O4NqnqjZfQoNrWJlpK5SKIR88Gcb6KRsP8EGB+TnTleTqvsHbWy4WVXKP4VpRCw7JHOZ+/l/noaGbuAofl526u/E04TXVcXjbuX6+6X9N2HVJxWqCM+Mf9KBRvF7QQ8Y7InHsXSB6BXRYrNpeKGo1kl4/rJquPInWPkcI383hoS5zIWmt6U91yQkUf4bHrfLUpsWOtga9RgWoMSRN/TKkXCSkYK/Vx2Wc4IUnecREoFAeRYc+QQOaX77FydWvzsbZdl742Ovc002
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(66899024)(202311291699003)(26005)(1076003)(86362001)(66574015)(2906002)(33716001)(7416002)(44832011)(5660300002)(6506007)(9686003)(83380400001)(6666004)(478600001)(6512007)(6916009)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(54906003)(316002)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CY7pcAONsOFQTAV8vASKhR5CJzHK7+kS6Dfghii483Asz7yCp7PhqI5o/V?=
 =?iso-8859-1?Q?5EwMSrZv3N9Hq1dqnR6rSXrrIW6Vh1HV/b9RkP4kVb4i6bjp/b/gDDyYFi?=
 =?iso-8859-1?Q?woOZlEvF9YYot6Xx2x3Jiickn81cqnaZZz8DlDScXg+BuaeDtKFQoIbA+C?=
 =?iso-8859-1?Q?zLMpBEouFRG52a/zFmoe807PrmpUlv+q/lcqTfNirxtnmt4jzZkmDd7CLE?=
 =?iso-8859-1?Q?HDlC//5PtpYUWqtOhjAt9ks/uCJAsGPYSXCRKRHTQF7ITlBgpcxV1XtIlt?=
 =?iso-8859-1?Q?MtfCCeY5i1Wd3LfTPm8q5IUDh+d7BpuKkheXFHj5B8y2M6D13QSYyPdnKs?=
 =?iso-8859-1?Q?abaBdy5a++hQ6J0uWOr/f/zShQmurrXjbFN7non9JU9HFF8nC0YFAMX4ZZ?=
 =?iso-8859-1?Q?70jO70QsaG8+MXmKBJLTRO9NmXg5HiwB2ZDiHSM7iiwaXN2/Cl14HeQVpt?=
 =?iso-8859-1?Q?KipYkcm48mclk4aeAC0rWjl7zwfJjS+RbowIHx3ReDN6XWWtzbB1VV7Y6D?=
 =?iso-8859-1?Q?uS7pM7YGnKMZeDg2CShTxr8u0m0SSZtl87LcMMVRC0/ulFoht2kaGxiTzf?=
 =?iso-8859-1?Q?Zdr5GecLP5wEU4KkHgFVI1DUo8QPVLyS38Yq+Q1T4N9+6tQyq4khqLoQBG?=
 =?iso-8859-1?Q?4lLs5eeTy4as3hvtRBvxDECVu6Iyg6fbH+ZkJDvWA/NoCh8XMiL7oxWzLO?=
 =?iso-8859-1?Q?K6jZHIutObtGEKiH0/wbNBNuqzfIC/5d7dk7C6PTKqJSFL29H/SJgcLTJB?=
 =?iso-8859-1?Q?esDLtvMvw39PtQmyXtb+SoOyK9KaWF4pR6IRW0QH4EBrIeO8Vrejs7cbIl?=
 =?iso-8859-1?Q?/zchFsQE3vByqj79z+exWbDlbp+1RsDWN75ZoBkGYEH25W7slEZzRY7mJC?=
 =?iso-8859-1?Q?+vnHNPgW4lmkxbnM7fF2GOGMtVb1h2Yy8O8/BsCph7DW3vyMFmCJZiPDCl?=
 =?iso-8859-1?Q?fXiBtwiyMsi+AOfTHO1tb+vtvwu5i/pREFW7+mUKqbB6SNxQpRQHMHZY39?=
 =?iso-8859-1?Q?ou1m5F6DUf5VsKn03TrxDJCWAf7KDYFHxJmQgUaB84GuyC90Jpx0Vs0YRv?=
 =?iso-8859-1?Q?XW5Zft7f68xl4ZQHCiN4GogHkKqj1FJVMb58uoOOItgOfAoQLfdEF95plV?=
 =?iso-8859-1?Q?17yb2GSv4R+DeQhqhUteAtqSKRkUX/KM6AQMZAQXeaaC0nKzQOHnfbR7oj?=
 =?iso-8859-1?Q?fIoQ863C9V3DAsTCtEr6wvUv5mbx6lw5VlaILpsR/HtBbzrHIZpu7oAerO?=
 =?iso-8859-1?Q?1GMDbWSNrjpXXpFBG+7aMeHs0TaUNLzg6PYwO3fkqdP0UqHuPRUxLBJyWb?=
 =?iso-8859-1?Q?1hBqt6in5B7gIrihdphGN97cWkT6PEB8tPCRZ5vSQBnjNrtpqAk0YuEHMp?=
 =?iso-8859-1?Q?aFE41ItQ7znz+g41ga8MJCNRz77aywTBovcG92eLo4XRoUCdHhJkVT6GTh?=
 =?iso-8859-1?Q?gT2gg8LtwxLYmsN3MuvR6x9Q+KeLZh2KDlLC6EQw1RTNAK+1vS+WKahG8W?=
 =?iso-8859-1?Q?Y/+LGhYHSwO0NLHwy+Q9OM1yzWRGQDkezFcHtor2Q+xsYMoBx5wA2J8sOK?=
 =?iso-8859-1?Q?psv2in81HfH5OHnZJ46dYsoYvql4BAcg8KOUV+wLQqUb1wyDTSRidmoKJf?=
 =?iso-8859-1?Q?PvIzh/bcXeFwUhoLe7bs/ktG2xPmskM+Fv2+cGeUVEUxCqU6glTizPtQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c050df55-db65-4886-4491-08dbf11af2af
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:37:04.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIJmARU/r6U/UnLy8RaAR/ys1GwqL+A+siml5VKtZ19PgzrT9v1FWgphNmB88v0Pp/vk3rnOD315G1cTKOEX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9115
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:09:59PM +0100, Köry Maincent wrote:
> On Mon, 20 Nov 2023 13:45:51 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Mon, 20 Nov 2023 21:58:58 +0200 Vladimir Oltean wrote:
> > > I'm still waiting for you to fully clarify the "per socket vs global"
> > > aspect, but independently of that, at least I understand why this is a
> > > counter-argument to my proposal. I need to tune it a bit (ASSUMING that
> > > we want DMA timestamps to "look like" hwtimestamps, and not like their
> > > own thing, to user space), because the PHC index would no longer fully
> > > identify a hwtstamp provider, so we need something more.
> > > 
> > > I imagine both ETHTOOL_MSG_TSINFO_GET and ETHTOOL_MSG_TSINFO_SET to
> > > support a new (nest) nlattr called ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER.
> > > 
> > > This would contain (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_PHC_INDEX
> > > and (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER. It could be
> > > extensible in the future, but this is the baseline and forms the key.
> > > 
> > > The latter takes values from an:
> > > 
> > > enum ethtool_hwstamp_provider_qualifier {
> > > 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_MAC,
> > > 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PHY,
> > > 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_DMA,
> > > };  
> > 
> > Sounds reasonable. Having more attributes than just PHC index works.
> > Given the lack of distinction between MAC and PHY for integrated NICs
> > I'd lean towards ditching the "layers" completely and exposing 
> > an "approximate" vs "precise" boolean. Approximate being the DMA point
> > for NICs, but more generically a point that is separated from the wire
> > by buffering or other variable length delay. Precise == IEEE 1588
> > quality.
> 
> Hello Jakub, just wondering.
> I can add this hwtstamp provider qualifier in the next series version but it
> won't be used as it is set and used at the driver level and no driver is using
> it for now. It would not be accepted if I use something that is not used, right?
> Do you still think I should add this in v8?

Not sure why you say "not used", though. Are you not planning to expose
the qualifier as an attribute to the listing of hwtstamp providers
offered to user space by ETHTOOL_MSG_TSINFO_GET?

Personally, I worry that if the qualifier gets added later (not now) to
the UAPI, we will end up having user space software (written now) that
iterates through the provider listing thinking that there may only ever
be one provider offered by one PHC, and will stop at the first such
provider found, whichever that may be.

With the added qualifier, there's a higher chance that user space
searches will be for a {phc, qualifier} pair (even if there will only be
1 possible qualifier type), and the future addition of a new hwtstamp
provider will keep existing software working in the same way as before,
i.e. user space won't select the DMA provider by mistake, by ignoring
the qualifier attribute altogether.

Generally I'm against adding things upfront that can only be in a certain
way, but in this case I believe that it is necessary in order for the
future extensions that were discussed to be possible. The qualifier is
part of the user space search key and thus pretty important.

My 2 cents, Jakub can absolutely disagree.
