Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581D57B4FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjJBKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:09:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11593B0;
        Mon,  2 Oct 2023 03:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpSDNMFwP2xJN5TCVvM/vqCeUn7mSoCyf5/MZGz59eF5nnyoJxt2jKUu3eTzhsWKrFSgJfavRbWI3pn5BZ0vzgiPU5pYbMoQKTmBT/h7CaNsNVKXNLbC6oXXq/gWRUHp/3sxOiEqMVMqkGIaaaIkN8hva6vqPaFBPw9rh6YmqfJVhfh33u2hGEoRFtrgKIB3sSWaSpqtPhujwkJsO1Gj7QCO4lAB3iTiDqVkR6DBiYz6AXrzE2f8PDkK3i9WTqIWFk5hxsyNg6T+l5Mzxkph6fC5zUFnH3WemyDQwgUiElz8J0isldCxvBTSAE9Asj0cW+VXqap/SVZ8ErTIjDasaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+XK65wn8Ct1iugIrxOEP2P7FvjWb6GFCjLLVDFvjLo=;
 b=XA0oMZ33fD2LxpyfWN5HL5dvKntBaASg08L80lPYfMSabffWQYaBPj90ys+YTHv/XDdV3ZpoCRhqlbkZSgfxqVC7j6fmE8jNkgT1iVZIa4Ns6h0gVRN99bkCJJS6Vf7/L8NVM7jtX0IDfuMsmPrg6Csz12X/YhXev1WZMvniBHxX7zN5EJTX2THu86UQd1I2F5zMAoy/VUxluu+jzGELBRcdPqG40TgOuzH0tmtV0BD0iPkjw8lQS8IPrOOEcGMlQpTPxzSUu15Vc3ZPzA7TzSVP/a4obCZh3dgwoYaf6xPrFRYEafDHd9JURievQEj7yvsfNqCuF2/HkngHivwomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+XK65wn8Ct1iugIrxOEP2P7FvjWb6GFCjLLVDFvjLo=;
 b=OV0P1ln4p5+bUqazwky5+pGBAJ8dZvuX9/NPyei54CwUZa+olBCjSB0obq8c7UrewzBLqxGNCvd0pwlKAcRO5eeBOSQNCpKys5+aRmTV2O/jIK+shyFaHs8JTur3lmLZfWZud95D2YZ8EphqgzXhnxNrIu7WOKO6xCP8tnJnTQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 10:09:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 10:09:42 +0000
Date:   Mon, 2 Oct 2023 13:09:37 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 04/15] phy: allow querying the address of
 protocol converters through phy_get_status()
Message-ID: <20231002100937.7t2skx2kzscid574@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-5-vladimir.oltean@nxp.com>
 <ZRb5+h4TnGRKl3/6@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRb5+h4TnGRKl3/6@matsya>
X-ClientProxiedBy: VI1P195CA0056.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::45) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d7d69d-e211-4490-9608-08dbc32fb1b3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCwqaFZpdA0730PvaO6ZdvdkEOHq8HSBHIu4gCircO1du44vQVAaAIWOSyYlhExaDN+0KbJj/PkKr6Jnjq5xEry9+6C8QY5quelGxUc81v2kqWj5+QzW5rGelyvF8Sl9pQ9/yj1c8r0vSrvTFDo1Nu2Zlyy8qDvlzwQXuR5BILCU9oH/KAOb9ZJy8fcVoXLxLOlDQIxnZ4tjVMy8cmoYuShb9cXgKo2OCXSb5jXYS0pJD1KN5NesqaAoelbkhHD7W/if9zZ6G1u2PF41eOY3wnEQdGH4Ws1d3DGMacV3b/SYa475zaEMeQ4KV99fyWQJAH02YrLHa817DWXRkyaWcsYAdgHmhMeVwh5zQ+Xu8e6YqcJd6Gn1gOfvQjO0Mv9Pbp8gifx470pa0fkFNYq+gKvUjLTF84BtJz3H+Hdchlk3X+zoKvBExYtWyIke1hzMN0rhBklZnm0T0mGufx1wN/a9DgS74Tq4yqjNmdiNehaiBuiZmIhWpgaIZWBonS96yeUfjrV5UdLpzZNZaFn4GHQKYCgUBzhMIQNEnTkdHkY0Qxhno/87h7kqQ6IBHPcu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33716001)(86362001)(38100700002)(6486002)(6512007)(6506007)(4326008)(44832011)(7416002)(6666004)(8676002)(8936002)(9686003)(53546011)(83380400001)(1076003)(26005)(2906002)(66946007)(66556008)(66476007)(316002)(54906003)(6916009)(5660300002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNr4Q7fH9D8m2enWWRJAf9b16uLwi2zSZSNllsi6pRQfH6tyksvEdEiCjI9E?=
 =?us-ascii?Q?KEojtg1PME+MpiKi7PexgfHWrVkXPV73/NL8ohOy/Tj21JIGHPtijO/Hx8+B?=
 =?us-ascii?Q?DIO2ennOj1AsbyiEkPLyoSr/4S+Pz+XS3NGV+ov91cZCkrcqz8O2aH8d6hZV?=
 =?us-ascii?Q?L1TdaUr3gYOXUTWgphsZWIjUGjDaZa4KyRl7dmYQEADyzyt8dEGcoGZ54zVv?=
 =?us-ascii?Q?aCpAgfssc7IvPV/jPsG9W2k7Z9jDskMcXlq+SKi70fpmP/80tjYmdgLvhGjp?=
 =?us-ascii?Q?9qRwW8X7+vzLr9Icq6BEwByAlakzbMlHrVZ2CQHS6rt4R8CmXxEoJSNWJg+C?=
 =?us-ascii?Q?+cfnEiKTsmx0pnIlG/Tgmhh3YbpIc+lQEoRdlmId5WrussMIUzwoiemcC34G?=
 =?us-ascii?Q?+zqWeRwv/Ewp0Hz+PGelVcfnwfN9/GzByBHUmywN5NB46H+Dn0VfrSWNkJFt?=
 =?us-ascii?Q?G6Iv3VOL4VMR0zoQ1JUtsfn7sYjaYgEFg0LOWMRmm1j5FqNU7CpQV9t9oHnf?=
 =?us-ascii?Q?dyH59zQhsnZUdxfX4vEAC2lXTRUzlJEN8yjsm25NS/7FTNH2f00XplFRcrs1?=
 =?us-ascii?Q?/dNmNSpP9fB7z72dxStOUARqNfmkfCwJud9xX6DhB956oWCRE6cm9XCIAfEZ?=
 =?us-ascii?Q?+MlEZ/kMsPysld8fuz7i5gcr6ron0RHjx0qt5Fi89RWtLzk3lDVD/eTtKP29?=
 =?us-ascii?Q?ECY+6+xSrckP8fHljzLxM7RvRNkdmkL7ZOrvHSOjuHKcXCPaGhW9IpUMGSzc?=
 =?us-ascii?Q?M18q6AxOhZ+d2tG8S08F1zZVjnpZvrQ+srZ3fn5SbsIUqDSgJUh1Wy7vVT2Q?=
 =?us-ascii?Q?s29NqkPBwZTKnwCCOXxkuLK+5zq8OYmh++zorMOgl+mGWVscDSSowcivFy9k?=
 =?us-ascii?Q?HawOZKaOsZvIgig1zv91+7DkIlQgRnPnV52HrU+GrBW2VMZKihr2hv7yt7Br?=
 =?us-ascii?Q?Mx++/bG+FxGerIIriJTOS+fsUqwhgsaSSUE60bCZHz6dMMlUmzRvAmYyJQnc?=
 =?us-ascii?Q?oHxCs71fsJziQtLSNuYMB7tCSmhv9PKP4OY0zais6o15jrzX6/sNizeKHY7D?=
 =?us-ascii?Q?WkiAaEEkvOrV/di6wZFvc02IfXYlaJy1u0uwnRtQiLIxfPbIBFI+fv+q8fZX?=
 =?us-ascii?Q?qI3dvn7/fUTZEG0bpWlwtg3tPYr4I5GUEkgQPehxBptep44UUd8A4yrYnY1U?=
 =?us-ascii?Q?CuzgxvcUb8xCjBE0sh8OtAO1QQLqqaGo2PCviSoQ1h+vaeJQesVT1+YON5fL?=
 =?us-ascii?Q?joF3WhU9B6eG/0EI1jaXnn2rqyM7H76sEclR0Mg7euezm0sxHcnd5TDhpZXR?=
 =?us-ascii?Q?n6Ro8/dJhunQ1jmNx8B7VAXvA10oQTIcYwGuNoR7Yb9dx0271dQUy8gcmH8U?=
 =?us-ascii?Q?kE6UXf6w3zE15hp2iyOg0+9bSxLz2ItT0cbNuIybl5Whn5HdVkU5Gup7VIME?=
 =?us-ascii?Q?68XkT/p+35tnZuGmCCXvnQNK4CylmqvzivfJ4oEm71SbbyIvZ8dX+Knu7KAx?=
 =?us-ascii?Q?ard9vJqGzXV15Xc/qleOyPdsqTCEnbEFSqsfRYHuJnTcyvSWeMBOipr/V1Dd?=
 =?us-ascii?Q?uc5c4dnYbCP5DeDsXBgARFCCHrPb4mQ1d4/BCiPr4q6Qxyrwc5Opl9Iglopw?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d7d69d-e211-4490-9608-08dbc32fb1b3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:09:41.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFx43psC8fhFCf0Tq3sueMo84GvbeXgTJS8HQCDykWdSV5q42Q+O8shqdyDkYrFs6yLGL1xaeKfvGiZLSo9fGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Fri, Sep 29, 2023 at 09:53:22PM +0530, Vinod Koul wrote:
> On 23-09-23, 16:48, Vladimir Oltean wrote:
> > The bit stream handled by a SerDes lane needs protocol converters to be
> > usable for Ethernet. On Freescale/NXP SoCs, those protocol converters
> > are located on the internal MDIO buses of the Ethernet MACs that need
> > them.
> > 
> > The location on that MDIO bus, on these SoCs, is not fixed, but given by
> > some control registers of the SerDes block itself.
> > 
> > Because no one modifies those addresses from the power-on default, so
> > far we've relied on hardcoding the default values in the device trees,
> > resulting in something like this:
> > 
> > 		pcs_mdio1: mdio@8c07000 {
> > 			compatible = "fsl,fman-memac-mdio";
> > 
> > 			pcs1: ethernet-phy@0 {
> > 				reg = <0>;
> > 			};
> > 		};
> > 
> > where the "reg" of "pcs1" can actually be retrieved from "serdes_1".
> > 
> > That was for the PCS. For AN/LT blocks, that can also be done, but the
> > MAC to PCS to AN/LT block mapping is non-trivial and extremely easy to
> > get wrong, which will confuse and frustrate any device tree writers.
> > 
> > The proposal is to take advantage of the fact that these protocol
> > converters *are* discoverable, and to side-step that entire device tree
> > mapping issue by not putting them in the device tree at all. So, one of
> > the consumers of the SerDes PHY uses the phy_get_status() API to figure
> > out the address on the MDIO bus, it also has a reference to the MDIO bus
> > => it can create the mdio_device in a non OF-based manner.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > v1->v2: patch is new
> > 
> >  include/linux/phy/phy.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index f1f03fa66943..ee721067517b 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -56,6 +56,33 @@ enum phy_media {
> >  enum phy_status_type {
> >  	/* Valid for PHY_MODE_ETHERNET and PHY_MODE_ETHTOOL */
> >  	PHY_STATUS_CDR_LOCK,
> > +	PHY_STATUS_PCVT_ADDR,
> > +};
> > +
> > +/* enum phy_pcvt_type - PHY protocol converter type
> 
> It is not a generic protocol converter but an ethernet phy protocol
> converter, so i guess we should add that here (we are generic phy and
> not ethernet phy here!

Can you please show, using a diff, what modification you would like to see?
In my mind, enum phy_pcvt_type could also contain non-Ethernet protocol
converter types, and so, I didn't want to add "ethernet_" in it.
The "ETHERNET_" prefix will be part of the individual enum values that
are applicable to Ethernet.

> > + *
> > + * @PHY_PCVT_ETHERNET_PCS: Ethernet Physical Coding Sublayer, top-most layer of
> > + *			   an Ethernet PHY. Connects through MII to the MAC,
> > + *			   and handles link status detection and the conversion
> > + *			   of MII signals to link-specific code words (8b/10b,
> > + *			   64b/66b etc).
> > + * @PHY_PCVT_ETHERNET_ANLT: Ethernet Auto-Negotiation and Link Training,
> > + *			    bottom-most layer of an Ethernet PHY, beneath the
> > + *			    PMA and PMD. Its activity is only visible on the
> > + *			    physical medium, and it is responsible for
> > + *			    selecting the most adequate PCS/PMA/PMD set that
> > + *			    can operate on that medium.
> > + */
> > +enum phy_pcvt_type {
> > +	PHY_PCVT_ETHERNET_PCS,
> > +	PHY_PCVT_ETHERNET_ANLT,
> > +};
> > +
> > +struct phy_status_opts_pcvt {
> > +	enum phy_pcvt_type type;
> > +	union {
> > +		unsigned int mdio;
> > +	} addr;
> >  };
> >  
> >  /* If the CDR (Clock and Data Recovery) block is able to lock onto the RX bit
> > @@ -71,9 +98,11 @@ struct phy_status_opts_cdr {
> >   * union phy_status_opts - Opaque generic phy status
> >   *
> >   * @cdr:	Configuration set applicable for PHY_STATUS_CDR_LOCK.
> > + * @pcvt:	Configuration set applicable for PHY_STATUS_PCVT_ADDR.
> >   */
> >  union phy_status_opts {
> >  	struct phy_status_opts_cdr		cdr;
> > +	struct phy_status_opts_pcvt		pcvt;
> >  };
> >  
> >  /**
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod
