Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2C7F488A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbjKVOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343844AbjKVOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:09:02 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E49101;
        Wed, 22 Nov 2023 06:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGDKOOjFMI7+YS8/5UUcfBkKnFh+KYzxvInZ6BtQSzMkUOXYdVZ4R9I5nFPDcDanZa419ZyHexOEhYoDSqSroVJO+ji3gsUzUXaWF3T9rUlrcV89Q0dabSGDtG+Vh0O2J69HVDvVP9BYM1uwOmTmIGyxyEuTStbsQTMdInTLkwXiTFcxe11RNZSkvQfWMCZceMIvIWu2nn7Qop4l7Cw5dbOOotdqwfUXXC2H8HjBiEagdLc1jg9ws1jkxSC168pOaDvsBG4Qy7htc4swOj1ON2rblASEtkOrjAEsLg9NDbrnsqJOIHIpLJfLfSndCIl4WeTIaEURcPDGqQ23uc+B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2t4St3XM9zQS0nrtlT+4PQolMsCsG7LSxflQXBINxI=;
 b=cwWyYutlacPSkORxzBTJWIj0fJpl6cdZDppZmpXKg9V45WW8I3k/O2JFYW0xIZDM0a8m2+WWgyT74WD2/3Vae7t3NuGxs42dgmfRV4RiuNhOFJOTMw+KOagkDqJwIIHgl9wdoAALUgPiJCH0CvapE6BDM3S+HdwNZ/17czIgCoe/JBF+Qc9o59CWuZvNGwZTnXtNVMYUlkEZ8qqMSVAOyywb/sl3X/RwFI5OiVAbGZK9HU8NO5TX0DEokZcJS73skQNEvt22kjMAYew+UpJgRJy0HEidotrOCCLJQtNoiXxKswMtwnuubPsnAUUGnxY2EQnqfZr7UEbfzbfuKVl7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2t4St3XM9zQS0nrtlT+4PQolMsCsG7LSxflQXBINxI=;
 b=dd9NmWSSPOMThrMdo/ViyMvfbHqSMUVBKm8rS1lfnmWL/cheuMb//6V8sNXHaxehAhBXuWWeooOji8xkN/ABDsA0pfs0+JLew0cRfWl8doqS7K2+iHKmmwbKBLo4DvwUgCK25KYsv0CmKA54v7I9FPCuHiazj6J529jYmdYzab4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6849.eurprd04.prod.outlook.com (2603:10a6:208:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 14:08:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 14:08:54 +0000
Date:   Wed, 22 Nov 2023 16:08:50 +0200
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
Message-ID: <20231122140850.li2mvf6tpo3f2fhh@skbuf>
References: <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
 <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: c03204a9-532f-4a83-483f-08dbeb648fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +h0Ihr28AUVhCpyXJS4x02GIBlKniIknzs3SOmpdOX/Ocb5IWHl1HQlh1SMaXCzkdHLZJ6V6od292LaIAb4tBdiB7pj2voPR+YlhHefNzRBkq+nfihPbccCUGClbrsQCB3uI60gue2AIr7Pt+rWtbz6VoHTbKJxcOGm+ZibC8gnjQoqWPC6Cpy4ghV4zyVt2a97fzb3dYO10gqSV4+/UQ3XI/evtROLcGsyW7QyFC0tX99+Zve5za3xDHuV5zcLY4m7sYHdHl1F1NhmSK2u4B8B/J/ekxAmRfdSmmm2T/bB86KtJoMuZmuYt7yMhIbguHZKdYfV6O/1c+AUIR38AgmqA9HL1u/Yscq6Y9U3Z58ZySUW6z0rNyWrj2a69WY12DdLLsUZudanP3A6SgFhaFggl5JA1y4L8b64WRPigGBUaB1MzKVDBo4/W/C00oqIcPnUhixyOvZg3UZxc+x6HWFH8z+9waXrgqdq21kCyvvDf4AcQ0lkEQifEuTK+oBwZilMx19f5j/9Cf9+IQ8Js8x7K+jCqN6NbwVpDCe2xepw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7416002)(41300700001)(8676002)(4326008)(8936002)(44832011)(6506007)(478600001)(6486002)(86362001)(5660300002)(966005)(66556008)(316002)(66476007)(54906003)(2906002)(66946007)(38100700002)(6916009)(66574015)(26005)(83380400001)(33716001)(1076003)(66899024)(6512007)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FzkRcTyAyFTkrUMwcyXoP83X1gvf3nz7v4zhE4ZTXHXIliF4BAYX+Lqr/+?=
 =?iso-8859-1?Q?hdGeaUOOHGFTOk48xaA8iG9GffkrZm/aQIZZHnBRk+8aOp2rUWUMcg0vuf?=
 =?iso-8859-1?Q?JEs+D2wj1Rauq2tHMej5Cn7lMiSxAyaoXDgmOCbuWz1oD74kWhnmeeaD4M?=
 =?iso-8859-1?Q?3FYfzr3qTMp2U6nv7w3KE14aio5tylJ8WwyCGwJlHEIR1sdtpq831+kR9Y?=
 =?iso-8859-1?Q?9zaZvJoXJAZWGk0ZfNjA3gIGXXIaZH2nBga4MPXTeEj9Mu2K7293PROZsO?=
 =?iso-8859-1?Q?8VW7H3bOrP0MMnhQsEhAcl/7KYLfUy600C9PQevIhxiNSsgdPRdJ11BfQn?=
 =?iso-8859-1?Q?//WVCSM5kzn7oFYzgQPIvWXFNX9xCwkbZAgbv5c+tx4wDeCccG2vpT4fTv?=
 =?iso-8859-1?Q?MWGqzmdwPM/tO76TEDTLXKH6/JHUWHEHmcK8snAJvDWOSfdkesKePFh/x5?=
 =?iso-8859-1?Q?S7nssOpLrLDvH2oTgtTRLe19oEujBNRdlVAike7U6Mwrb/mwl0j0xj8k7r?=
 =?iso-8859-1?Q?L8zp7g8xAw5yhMQevcNC9wwQtfZGT3t3caSD8wvcQ4DYLkivS9UV2I9grm?=
 =?iso-8859-1?Q?J5XJgRYvx36Af1BLAesxy+0KB2AuTHG2JMejQJ4mlWH4xJQwS7mz9pGoXB?=
 =?iso-8859-1?Q?YA32SYqAAQOAdn8XLXhb2IFW3P2iZ9TOVm6aK26q/RBnjC2SAlUJ+ivnd/?=
 =?iso-8859-1?Q?CHasSTYFgKauHq35L1a92oFbcWj8ntWxByQyaeuMxYMAwYUPyXZ/BDOHzE?=
 =?iso-8859-1?Q?TPl4IZHWEELyWRhNnU/SrdkfqPo/tjxzQlVEpNVXt7xz1gck4EZTDmtQDP?=
 =?iso-8859-1?Q?keQ52yoD4cVR0HpRULmjFk5L42KTAOqQWB9D5jBAhAFTTH01LHkdCKfhvf?=
 =?iso-8859-1?Q?xF3KZgsIbE0/ORnHuovnxkKGmJ1SGWuxj4xUPoM7LQtHl5PzSZpHM+Qb/b?=
 =?iso-8859-1?Q?VwO5lvLUB2n2d4alspGXAE76zWP1o9lUCxkR3qVmXyxOfvskaRbPGc3gTv?=
 =?iso-8859-1?Q?tfNLJRijF0I9CM2VHubf/Dxc1Mjt+n5E2UFlL3OExdNaIE3y5mNA7LBdQU?=
 =?iso-8859-1?Q?R5LyDdAFLchQwEn5oH6WCEMIDRj0ueGcRNMLrI2+S2DMkD0DA+bjwFMJTB?=
 =?iso-8859-1?Q?lBysO7OoVrYusTsI9nOj8osjHECDPN6U5IxiX5Cbx+1cG+6ibr0W9BEMPK?=
 =?iso-8859-1?Q?Rul4eC+cfX/uNkEe18J/7zUhEBi0hKWx8APC9IQYE6z79LaNvtP5D5DzF6?=
 =?iso-8859-1?Q?5GfdUdVm+vflqxGsZ1wHftcxFxY90VE/spApJcNEAUCq4itc514Y6G2zys?=
 =?iso-8859-1?Q?4OrkOwp5Rykrd54Wzzgm4zRf9PsvLLDc9Wq8qgsq4dmnA4OvVMPebomZ1S?=
 =?iso-8859-1?Q?X1vDiKzJiPRQjrpjM+c2FOFdR5EzArb9XJa6tuXn+8cimYmQCKOyjWFlrH?=
 =?iso-8859-1?Q?glK8DCUBh72+Z/YWswuqBbkbp8Shy83kar3l/mrmhrtWHBmWf1wcso43YH?=
 =?iso-8859-1?Q?oTp0IDy4D8RDqVo1sqmY15DRYoSGpWp9mzoDD1/PpQS3c3qnIUUFs4tALb?=
 =?iso-8859-1?Q?R6587MVtA9Bv1At84GgHzLdZ2sSJNR07w3h/FEKkn3yM7AsvRB2peqcZZY?=
 =?iso-8859-1?Q?N9po+kgTj87nY5d3pIy27JulZJK/c/xLIyXiBclpXCmsbCXplWJo4oUw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03204a9-532f-4a83-483f-08dbeb648fae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 14:08:54.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VN10I0pGK2Tw4+ijryL771zldMHQJQ8O5WwVn32a57gErCFe371pctFslc7ZEdWXdxqtRhCaXKgMcPrmcZoAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6849
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:44:53PM +0100, Köry Maincent wrote:
> On Tue, 21 Nov 2023 09:43:54 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 21 Nov 2023 18:31:14 +0100 Köry Maincent wrote:
> > > - Expand struct hwtstamp_config with a phc_index member for the
> > > SIOCG/SHWTSTAMP commands.
> > >   To keep backward compatibility if phc_index is not set in the
> > > hwtstamp_config data from userspace use the default hwtstamp (the default
> > > being selected as done in my patch series).
> > >   Is this possible, would it breaks things?  
> > 
> > I'd skip this bit, and focus on the ETHTOOL_TSINFO. Keep the ioctl as
> > "legacy" and do all the extensions in ethtool. TSINFO_GET can serve
> > as GET, to avoid adding 3rd command for the same thing. TSINFO_SET
> > would be new (as you indicate below).
> 
> You say this patch series should simply add TSINFO_SET command to set the
> current phc_index?
> 
> It won't solve your requirement of having simultaneous hwtimestamp and
> enabling/disabling them through rx_filter and tx_types.
> You want to do this in another patch series alongside a new SIOCG/SHWTSTAMP_2
> ABI?
> 
> > > - In netlink part, send one netlink tsinfo skb for each phc_index.  
> > 
> > phc_index and netdev combination. A DO command can only generate one
> > answer (or rather, it should generate only one answer, there are few
> > hard rules in netlink). So we need to move that functionality to DUMP.
> > We can filter the DUMP based on user-provided ifindex and/or phc_index.
> 
> Currently, the dumpit function is assigned to ethnl_default_dumpit. Wouldn't
> the behavior change of the dumpit callback break the ABI?
> 
> 
> > > Could be done in a later patch series:
> > > - Expand netlink TSINFO with ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER.
> > >   Describing this struct:
> > > enum ethtool_hwstamp_provider_qualifier {
> > >  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PRECISE,
> > >  	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_APPROX,
> > > }; 
> > > 
> > >   Set the desired qualifier through TSINFO_SET or through SIOCSHWTSTAMP by
> > >   expanding again the struct hwtstamp_config.
> 
> Just wondering to have a insight of future support, in the case of several
> provider qualifier and the SIOCG/SHWTSTAMP_2 layout containing the phc_index.
> Will we be able to talk to the two providers qualifiers simultaneously or is it
> not possible. To know if the SIOCG/SHWTSTAMP_2 layout would contain the
> description of the qualifier provider.
> If I understand well your mail in the thread it will be the case right?
> 
> Regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com/

My understanding of Jakub's email was that he wants to see the functionality
offered by SIOCGHWTSTAMP and SIOCSHWTSTAMP converted to netlink. I don't
think that ethtool is the correct netlink family for that, given that
these aren't ethtool ioctls to begin with. Maybe the new netdev netlink
family. The conversion in its basic form would offer exactly the same
functionality. The extended netlink messages would have extra attributes
to identify the targeted hwtstamp provider. In the lack of those
attributes, the default hwtstamp provider is targeted. The definition of
the default hwtstamp provider should be as per your current patch set
(netdev, with a whitelist for current phylib PHYs).

The _listing_ of hwtstamp providers is what could be done through ethtool
netlink, similar but not identical to the way in which you are proposing
today (you are presenting blanket "layers" which correspond to netdev and
phylib, rather than individual providers).

The concept of an "active phc_index" would not explicitly exist in the
UAPI. Thus I'm not sure what's with this TSINFO_SET being floated around.
The only thing would exist is a configurable rx_filter and tx_type per
hwtstamp provider (aka "{phc_index, qualifier}"). User space will have
to learn to select the hwtstamp provider it wants to configure through
netlink, and use for its class of traffic.

This is why I mentioned by ndo_hwtstamp_set() conversion, because
suddenly it is a prerequisite for any further progress to be done.
You can't convert SIOCSHWTSTAMP to netlink if there are some driver
implementations which still use ndo_eth_ioctl(). They need to be
UAPI-agnostic.

I'm not sure what's with Richard's mention of the "_2" variants of the
ioctls. Probably a low-effort suggestion which was a bit out of context.
His main point, that you cannot extend struct hwtstamp_config as that
has a fixed binary format, is perfectly valid though. This is why
netlink is preferable, because if done correctly (meaning not with
NLA_BINARY attributes), then it is much more extensible because all
attributes are TLVs. Use NLA_BINARY, and you will run into the exact
extensibility issues that the ioctl interface has.
