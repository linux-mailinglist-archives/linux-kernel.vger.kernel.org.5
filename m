Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC57F7807
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjKXPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345916AbjKXPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:43:46 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869151BD9;
        Fri, 24 Nov 2023 07:43:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfvnZxnR4bV7U5WwFdg+ymCIpojuNiSc0jFqr0MqBaQvY3OzKj4yhmhZNjuK6Xm3TjVQ2P4W8DbiIP99DRMQMT6PldmiKRgR25+NYBOymT2qMRRtfyn/VNUYJIrzz7rKUDAjPCcUFlbgip/P4UXvSphYe4gN3ZZ9eF0wg8bxxCjQI/CZ4Ok/KZKZLPjuZAupreh7tQbIHH7QDPnBuED80X6FVoC6fejsB5QU2nV3XhK2ilX255+gsP2nyHDtNf/olBzi0G0JlpAujbXKOum0C4+KM9UU6lpa1Z307mBQGeFIfnQDUGCSbbvD+bt7FKSoB+iZrNgvDeP03rf+GFI4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeiRHHOiRlK7tVW0hP0iV4iv4hsQAbvq2O0CB/Ds0rk=;
 b=eWbohEFe9sKhH9b3FEHjIVy4FVXD59jVMFalD6bNbgMIn/+8ihtY1Gn9jw2ZrnvF+86AnOwMpsiDrJSfKhw+AcCS5ze6vq1EhrmxJw/17jbl5W4yQNy5JVCwJ6Tk73kUIGwNxU/0Pg/uRhhEV/eTOZFqctnZ7oGhHfnaqG2sKMLMiDo/wo25gFJBajLuv4Ibacym2LqXtjVZqIYDwBeg0T3w2PNr3pjwr2j8MEXtHSkEKwGtZ4tpekzquI4fATvC9VIWGciP7fZZyxzOy0sa6iJS2i1Q9cirEzEav/lcFhHzFBhLXELGf2UiuHhgdRQ8rqQdoMf5CJ8yLz/g3O4NMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeiRHHOiRlK7tVW0hP0iV4iv4hsQAbvq2O0CB/Ds0rk=;
 b=qZdc2khBaKBcvQjrtC4mNK7RqxRG4OJrQU7U51zZ1c2NDxID5Yvk5YyN2mxCQb8+Upnr7Q4fHVRyjcF59UKUJRRNr6o6xzLNXOfw+s7CaBd2DJRuvxJ5YyruYf9PsZJ42pIKdMhtDD70NFQ6LFEo99A9xhv1X4IKyYtvpd+lHWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 15:43:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 15:43:47 +0000
Date:   Fri, 24 Nov 2023 17:43:43 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
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
Message-ID: <20231124154343.sr3ajyueoshke6tn@skbuf>
References: <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122085000.79f2d14c@kernel.org>
 <20231122165517.5cqqfor3zjqgyoow@skbuf>
 <20231122100142.338a2092@kernel.org>
 <20231123160056.070f3311@kmaincent-XPS-13-7390>
 <20231123093205.484356fc@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123093205.484356fc@kernel.org>
X-ClientProxiedBy: AM8P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6f69e1-828e-4594-cf7b-08dbed0425f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x02+izdP50aUeHGZcyo0+unsFYNaKxsAGj4w4irfIUprv8bAdwisGzMd5PJSqOAUmn8D+Y3rZ+8Q3h6fWbr205SQgEeievREugLlX597Jo7BFOpfOnhQQ38bxnqmM428sWNXfF434e9hQXnf9Qzvk+eXOoQW7FaWMYb+t1OopvIcMr+f3fwYSmPz+90w6PAAx8Ntl7spMA2Eh5R41gIjp3XboNRWIbV46qmQv6EaOzz4COPiCSAfkvtEXng0lMs8WUqEX9tnN0vCJU5srk9aNMGHHTsX6dsH3NllVReyMQsLBEo8NiOSAt6gbU4+Ho5zPff/TRNwg7xLhgZpC9314lo06sc3utauX+9X0fQ/otCwUkl02lDfy00QoCdHUaV/IlwWFMbUW1ZvH1e1MHRrmvi3STtbevTHNTBWt8MjrpUINAFEKsQEtKCihAxuCcSoXZ/ju4drMR8DMbyL7LjyPtzIEtj+amN7yLbK2zXmnVKq2eblZtZ9ZI3Paml6m6xVOCtwrDtMpPHJBVANUXndFQ3DSxHoYFSdSJ7CiM2l7lz6WinwO2pBzu2P5HnKrbTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(478600001)(6486002)(9686003)(6512007)(6666004)(44832011)(6506007)(316002)(66476007)(66946007)(110136005)(54906003)(66556008)(8936002)(4326008)(8676002)(2906002)(33716001)(41300700001)(38100700002)(1076003)(86362001)(7416002)(66574015)(83380400001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?X8vUXq4N5btf1Uf1V6huanGX/0PXAOrbY565g8KcQLo/i9J6vUGGJ3dyXm?=
 =?iso-8859-1?Q?UhKQz5nPTdmq4H7/1LMQRNdSCCI6Eu5jPyZoO2sn1zmKBEVkkQX29J8kC5?=
 =?iso-8859-1?Q?c1z5SMkeHBkoSLJTITYCrgYgq9bnUvW/S5dvQn9m4GDWcpR7AoaAuyRgND?=
 =?iso-8859-1?Q?isyY2JlNjyJg+XEbd+Im0znbrOTkVj9SsCAXseyczncm1bDn6Qkne+ahJL?=
 =?iso-8859-1?Q?NOB6js0JDd5kNwQAxdAN3CdDvkVmBYioUZ9FL0oeV7h9/pmi93Njz2wDqa?=
 =?iso-8859-1?Q?IwoZrYlx1BKCYm+A0/quvWoKOE+2JC6z6zVsfCVqZ/8Nx9oThfDWAZLN72?=
 =?iso-8859-1?Q?iDhaYvqNlkapOk++qNTQQEaGf2Lmz1nF5mH8nyItlou2E3mgW/VmeIy3BR?=
 =?iso-8859-1?Q?rKdAdDSVQmBQbtF9LzodxOU9HukIyeGS1LvSr2ld9jHekY+OqbS9gDeyRX?=
 =?iso-8859-1?Q?6sq0omtLteTUwTSLc/EZgOhI9cXC9u5f5REoYyC2/pqPUG0CQ45qn8lVQn?=
 =?iso-8859-1?Q?XtavSCALHbfZpPZzXYboikmjf8ltAxtVxZSiHwHHvsmoaZUAaOqBf6EE+3?=
 =?iso-8859-1?Q?j6gATHc9xfdj1IzfVHW39T7PisUuNF9a7diaR+v39sToB65XEbmylBc2jW?=
 =?iso-8859-1?Q?CulW8o8BowkADnYTNwwVRPyfHd+7pXsESK91n9yXdL/AdL7BQFrnLWL/Li?=
 =?iso-8859-1?Q?EjTYn7MDT0g+/4XXVgEb55RG0YSyrjpJo3GC7wJekSArRkvMoRtdQ7WJHd?=
 =?iso-8859-1?Q?+t1ikB4fJByP03DZoI+lPyNXLXF87iuBGzLYEciKkpqYR6hiOqiwcckjcM?=
 =?iso-8859-1?Q?S+7mvO1m88472xMjFUrl1q0dcnHM4adGBNqE34QUcfic/wsK3EibRc5Eup?=
 =?iso-8859-1?Q?y89fWjMbN4t735NveTOEWPPAxTTpW5YeqODgi0sunQuLgfZt1dVq6Vj66A?=
 =?iso-8859-1?Q?UAQlddrsO2zXhnJ2ZBnNjI6PT81A3OygRVMKXxvsdVppPc9kVOnhzlbBr+?=
 =?iso-8859-1?Q?cpCY3kKczpE0xexNpKSFEXvuhkmcBpqLG1owFY870Qo9laJgAyqAPTQX8y?=
 =?iso-8859-1?Q?kCWlzt6yA0zh+yK63XaUc+5/z5QJpCaprSKK1UP0zUfugPgCrRMKc0N2gy?=
 =?iso-8859-1?Q?6boyYnnIvRWjzJcHgsRebNvFm39NUj+yiD/CMSioM+zekEg1aIEBz72mvS?=
 =?iso-8859-1?Q?MJFFYGF+nnBRIw4ajzT81b2t/xrIkNRXikRk+JYXEwmsmYgA3XHgDit/Tw?=
 =?iso-8859-1?Q?QjnEaoirQCj3nGs6dm/td03A/IWIx/NkuOPdZioyzR/QLBsZSHj3GQlzxo?=
 =?iso-8859-1?Q?X/lTykZ5hveVrE2VmA7p21rCW0MJ6S2VtKYDV04Bhza1kG87xx7aqshI2S?=
 =?iso-8859-1?Q?/+jorblLwcebfR7CjAlhjqINKF9q5Es1RUvl2L+gqqGiZgPl0BLWxlOU/K?=
 =?iso-8859-1?Q?vtC9BH4dHJuX0qB3jHrKhlvPobZZXrKNQ9h1VwXQD6l2Cx4q5ho3KyJQZy?=
 =?iso-8859-1?Q?v4kUFDSNVz5TLuiN7EJ4QE0uCL2cHnirWHen57NkVqfHIRQKJKEsFXgh+K?=
 =?iso-8859-1?Q?J/c5KbSAdy/mNio0Z1TupdRNHWDiiHWuHaOj9VO9JwkzgS4aRDQBr+Iej0?=
 =?iso-8859-1?Q?Citm+srIQKXmQ6btvNIAmcK23QmCMIwPcInihzYaUqA6gu18PkURipXg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6f69e1-828e-4594-cf7b-08dbed0425f1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 15:43:47.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Reyokufp86UtbRBlhKrPnVsB8HIDR+apsT5k49hSSU7oczkw8Dktqb04v41UJ4vEjaAja1bPY4V/c8dalVeeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 09:32:05AM -0800, Jakub Kicinski wrote:
> On Thu, Nov 23, 2023 at 04:00:56PM +0100, Köry Maincent wrote:
> > So, do we have a consensus? Vlad, do you agree on putting all under ethtool?
> > 
> > ETHTOOL_GET_TS_INFO will be in charge of replacing the SIOCGHWSTAMP
> > implementation. Need to add ETHTOOL_A_TSINFO_PHC_INDEX
> > ETHTOOL_A_TSINFO_QUALIFIER to the request.
> > 
> > ETHTOOL_GET_TS_INFO will list all the hwtstamp provider (aka "{phc_index,
> > qualifier}") through the dumpit callback. I will add a filter to be able to
> > list only the hwtstamp provider of one netdev.
> > 
> > ETHTOOL_SET_TS_INFO will be in charge of replacing the SIOCSHWSTAMP
> > implementation.
> 
> If not we can do a vote/poll? Maybe others don't find the configuration
> of timestamping as confusing as me.

If you mean the ETHTOOL_MSG_TSINFO_GET netlink message (ETHTOOL_GET_TS_INFO
is an ioctl), you're saying that you want to move the entire contents of
SIOCGHWSTAMP there, by making the kernel call ndo_hwtstamp_get() in
addition to the existing __ethtool_get_ts_info()?

Yeah, I don't know, I don't have a real objection, I guess it's fine.

What will be a bit of an "?!" moment for users is when ethtool gains
support for the SIOCGHWSTAMP/SIOCSHWSTAMP netlink replacements, but not
for the original ioctls. So hwstamp_ctl will be able to change timestamping
configuration, but ethtool wouldn't - all on the same system. Unless
ethtool gains an ioctl fallback for a ioctl that was never down its alley.

But by all means, still hold a poll if you want to. I would vote for
ethtool netlink, not because it's great, just because I don't have a
better alternative to propose.
