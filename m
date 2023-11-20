Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC07F12AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjKTMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjKTMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:06:12 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC701A7;
        Mon, 20 Nov 2023 04:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt2nXTiLFyXIDV4DUk80JrN/6pNXoHfS6UgtZXcWGlywA7SVU/lafO9eP71XMB/zHbChEKsS0q1d23RhPP11JSgFVdxqG5DMgys02i7m5GRbYjGhGMvyoo8KQuZIhHn8V4WS+78unc/Exu+rF3VvwMKJCotrWBkRPa5g45UKHteGi4RD8Dj/Lfb0P+8gH+teYww0vRzmehmhrgDrYnodQ462B10aCW1MIErBBSQE90dwt9NqyeIFOyK7UQsFHueBMQ11gDAril8BMHejpspg4CAzKh1hiAVyf+vsr89UCCNDWX2c9/CW2mFjT6OGOYViQplSGSefxxX0kadfsctVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDQle/PzHCaZ5EZ3wdcZOKFKkM6smXkz9B5bQpmLh/g=;
 b=SKpoC9pyFLZpUrSUVbRCqEeIkRXIjV8bEqaOeApT0cq3PECU28bpCGvDy3gnKc+imNqb48Une+wpvLfmp1sW4TtoazNrB+6Iiri/UGXyr31YXF0OsVqBlZwc0HRiDtrkkqpH8aEvShrjt194QVwXw7IDr+aM/i/w3lNWa0/Fo2rWPEF3Ql+/oeU0V2dvM36GhfsjCQSk5F/McqzJwpAIMzrhyeG3f4CbjpCJCbwhyniiY/lHZATqeapK9F9YavBlT6kwidl+B2roIADvMlXpBU+jWadEshMa1PB6aFCg+wdUSxV3obXYzNDxJ44a6iBkLv+SGmLoY3WEIsH5ji72hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDQle/PzHCaZ5EZ3wdcZOKFKkM6smXkz9B5bQpmLh/g=;
 b=nxBLRFE77mYlSUweZwRNnvh2OkmnC8t5RAKtJbuTfw7ZL7dVd5trAWWeNvdMVXFaQzyoozd9A2igIutpji4v86RO8I0GbyAZDKHpHDcHdlv7weT0xr27QrYsUtLMgfouBz7Pgz5UUw3axM/BiPyXK9N2F2wunKHZcWr9ylGjjGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:06:06 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 12:06:06 +0000
Date:   Mon, 20 Nov 2023 14:06:01 +0200
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
Message-ID: <20231120120601.ondrhbkqpnaozl2q@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
 <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
 <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: e40c0d04-1e71-495c-b13d-08dbe9c112db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99bqGn39xs3X0F48Z7ro8ELl/ujSt7NfEs88QjlAvVAd9fwttoUSoIRxAKIJ1+RYb2CIRx3fu9w2UwzpXKQv09q/pMcY1ZIs7fDGtpd2X8QAfMKRDmPngrEwjYe6ailjytaIb93uvJM/2oCehRxMNDWzXEzYbZ6x9HUOgqTXIBIWcDYw33rEy7/+cg/4N0XQ3Y2yzVO2skLf6cEWppMO2oPUiYI9tAAXAq29Qa4Ls7pmXU4l53Sqyus5Q4TatFHcsvDCA59PGJy1G0h0+weOiwTcpQL7XnUerST07OlrHvCEKfcwFpN201skVJDUMIFiSqzjXs0RuIPn6m+5hOfADD99VFSCdKpcLsof4J4StYEQmFewVTLpaQtd5aXyqC4uHfVCFd1HzlZSiYEnJpmFtjvq8tmPjbdVXryfMn150+uyrwT5Xwyl8s7sAH/FtvKgN+dYPSqU/5yqvMnBU9/fF+dGRc6Wo58nk1gHOBhP9KIOlIVjGz4UgvET8MEnajymCovQZGu//sRV0TtbD0F7OybLH0f8wKCdnlWaEkYIlIFzrdHN+AR6/YEX4kctjpOy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(6512007)(9686003)(6486002)(1076003)(6666004)(6506007)(26005)(54906003)(66946007)(66556008)(66476007)(316002)(6916009)(33716001)(86362001)(2906002)(44832011)(41300700001)(5660300002)(7416002)(38100700002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ogfi4AwMtMhLkzM764tRKFJyT1U70sWfLzCJgDhx/jMkDA7hzOR5gGSRiY?=
 =?iso-8859-1?Q?JjBCjuHWdPLvuxPTm9N34xSGuprUkPimV7VZiXYS+0l2kX/poQgUX7yBMw?=
 =?iso-8859-1?Q?WCUTk49UUCsMYBRzLzilg1JS9KChJG9hEgEKlIIqUVZ5jRIIA5GZ/4PX6h?=
 =?iso-8859-1?Q?i6CkIf+Ua5qX2d4LGbR8DjWzQ0bciut8ZAWJao69oylIIfNOqvriiwEOqW?=
 =?iso-8859-1?Q?/sPEq/v1aHJSZCFQTqhLsxi6cv9NGSML22nz2SVh+eP/l75BkE0P413Zln?=
 =?iso-8859-1?Q?/1MEUK5WieDKaArWa75TtKTcF69MoSZP0aZ11HfhChl4WLNA6XPn0C1l5l?=
 =?iso-8859-1?Q?oBPrakbBePv12VJYIZTzwut2947to6b0RTcfLfVLBRmDdKtQg6sYQcnWvc?=
 =?iso-8859-1?Q?y0ocoOwA5GfnroBbhjGwS16KWwJkNGwbUYSBEzgOGQwOXvy8iFacRTpg4E?=
 =?iso-8859-1?Q?b4Z+heSCdUjCRzXmf2ypBXfHO4KjadHo3op0TYDi5xYRE98D9EneWimDd1?=
 =?iso-8859-1?Q?O2L6OsS3+TdjBIgkGcLtYHANcITsgVrOlMeQxUEZYFSt7BQP+Fs35nYS6A?=
 =?iso-8859-1?Q?lumAji9nALFVJauhHniOe7CyJvwj72yQD3mjkvAWqbIUxXdfRSw3lms/Zb?=
 =?iso-8859-1?Q?hkrZN8PGgNeUUIprw4hbUGB3lpJ49XUaaavi1iNB+s8iucHlj9strBi0kJ?=
 =?iso-8859-1?Q?5IU0xKQw5AVmQjz0NHF27BFbD32XJLCsEMGHH1Xv9x7xh9KRJA5mfCRAks?=
 =?iso-8859-1?Q?0U6z8ZkDXxPItxzDjvarwqTr7XpHt8KTTsID2e8UrBX5XY+xogd653TBrD?=
 =?iso-8859-1?Q?Nl/c/xjKgYJF9FvK/aQ1k9G9hGOAkzlhY9WmZSvhpRBbl3DRyrOk20OfQ8?=
 =?iso-8859-1?Q?9x6+L1FW2g98yDVRZPi//SErsdi7efOa2E0k1xfGfS/udxpE46bSV0eBle?=
 =?iso-8859-1?Q?d6VjOHwQ9r3KKi7Ly+A9SNsN4SGtFTma6v11Apjl07jf9RVGhYGNkJ03x9?=
 =?iso-8859-1?Q?vRlNMj6bb4Vnq3tHaGdOo//MSiOx2Z+VrMuONK+22u5BiVWmagmEUOb+KF?=
 =?iso-8859-1?Q?4OFfbHc/zFEpnIz+g4ABEkTtzuKIE5PuTP/sGapqsnZXmdPQsu2+Mwa3ph?=
 =?iso-8859-1?Q?gsFljwOtIYLKPIctwETjzmjeOpX8kokSymGIgqAC+60srCbQLgX6e+bqSk?=
 =?iso-8859-1?Q?JDZFoSGHA5vmIQGO0B2UFL+VflOTaPS1sTFPdgoPX+by22oPCoJVtBMQZT?=
 =?iso-8859-1?Q?iCyeLPlGC1aNvp/WSVX2PIkSQg3Ykzndq0qDjeMM+iySNXU2Q779BxZQd5?=
 =?iso-8859-1?Q?kazT5qgTscqEiqCwTUbD4jTF0vki+O43HD7FMveVXiq4J1m+2BtmiNoj8U?=
 =?iso-8859-1?Q?GwBuaJSfWsbrd9PPWpPiV3YBn8c86aGzkZ0OHln6yO42lAfn4JiDtaT4Ex?=
 =?iso-8859-1?Q?0UixY7+wVbpvvrNrkrccFi/rLxm6TPS6W7FQdcnFk1wDtfojGZ5U6G71KT?=
 =?iso-8859-1?Q?D8+ZIgWottOAeWEX82ZzYyUowjnFHYxoMiH8gBpBYQPopJdn9wlW6vdUIA?=
 =?iso-8859-1?Q?k+BdyV2rZ6oSPO9skfXpqEbRhcaVge+GtzApzlga2+/aPEd1IQXOoeJ/nP?=
 =?iso-8859-1?Q?NW1FjxnxvDMzjQ/Jm8oNb30ZzfRzArWlY4ZjiqDu+anArz+UQ+xt9TyA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40c0d04-1e71-495c-b13d-08dbe9c112db
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:06:05.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjCrl9FYdS77zYGdOkm+E4kh61lYDHQdLLWfucpv5cfdwC8Rj/m+UJcQkFJD/OmZEhDbliJQWgx5I6ic/npwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 12:14:40PM +0100, Köry Maincent wrote:
> > Does your UAPI proposal make it possible in any way to select
> > timestamping in phylib PHY A rather than PHY B? Or do you think it is
> > extensible to support that, somehow?
> 
> It does not support it for now.
> I didn't want to base my work on his series as it could work without it for now
> and I didn't want to wait to have his series accepted. It is more a future
> possible support as I don't have anything to test it and I don't know if such
> hardware exists right now.
> I think it will be extensible to support that, my thinking was to create this
> struct in net_device struct:
> 
> struct {
> 	enum layer;
> 	u32 id;
> } ts;
> 
> With id saving the phy_index of the PHY X used when the layer PHY is selected.
> This id could also be used to store the timestamp point in case of several
> timestamp in a MAC.

Ok, and I suppose the "u32 id" would be numerically the same as the
ETHTOOL_A_HEADER_PHY_INDEX nlattr that Maxime is proposing?

The next question would be: if a driver performs PHY management in
firmware, and does not use phylib, how should user space interact with it?
What timestamping layer and upon what should the ID be chosen?

Finally (and unrelated to the question above), why is SOFTWARE_TIMESTAMPING
even a layer exposed in the UAPI? My understanding of this patch set is
that it is meant to select the source of hardware timestamps that are
given to a socket. What gap in the UAPI does the introduction of a
SOFTWARE_TIMESTAMPING hwtstamping layer cover?
