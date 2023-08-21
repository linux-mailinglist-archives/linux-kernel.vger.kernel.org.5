Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949478330C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHUUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHUUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:11:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6737611C;
        Mon, 21 Aug 2023 13:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frpxx/6693w8sIFDDNagF7igud/ecSO73t3gtQQzc/nvMvcS2aVIpra8V2eWx3kjRLvlx2oIqZcqliz+kfxvzsVoPiY7eRcf/BQ7cHwg+l6GVQu4kwpLDIXv2CJAFUriRqeYIPh5BVbA7gOR+9wmwgN/p+J1RHZRahAdVPBZkeNsFOwRLX0eknHaPB44TzlhYvfQY0zqlrRHrLfQ0ddgO0WYEGToWLsGuxK0TJmPzXKNryp6qrWCT8Ua2915Y6K/8UN+sEAglArN7vfASed/G+0wI4b54UqZS8dSxiRamNrWS9U0+0bCL4oFWvKhijVZWmgv1D1yqOJoK5a+WNQgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTigH1Rz7Fg9fpXCT8Kq1uo19CO+JSX4xrtdbD1+rbY=;
 b=M7X6LYlebvJGf6k9JzAu/Q4a/esc4FLFR21dRDZCKE9lP2KcaBGqD7aP+Y21aymgJ1gWLx/o9piUsTr+9iFwjI/HCI3cz/z4E5JjkqYvWxdnvzyw0A3dDNuP368dLdZ+yd9NWaBRSUKxN8cZaa+uCqN2zQ0d2rJ0xujPCLDZE7P/eOQmi7wsZHAwVqyG3a6EoK/MaRu9WN9zQ/g4gcY2riwMi4KgRHr9ZBZIPGPdRQm7ujPo14dLd27NVV7n+kiAzb3xEj9/b+TBEOSJYstfhJw3mfattENujV3pZPrs7f+g4TDwF/FnHf4sAppwJDV+u9ywA5MUN9LoxYdIJWVmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTigH1Rz7Fg9fpXCT8Kq1uo19CO+JSX4xrtdbD1+rbY=;
 b=W0sh7LTwqgxLfKeb2Ff69cotHZ6mnNhgSizwFIrS/M0MZs7T9QKuljn8319cHkg0wDXXGWfFSM4O9S3Mv1hIH0Zrfrt5SmNuFLfRBmxmqwb28D8XwQiAJOPyn+3wr+pLxMBo31JaqbfyGvB91kDWVommR9RYZPSHgT9zYfg3fwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:11:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:11:51 +0000
Date:   Mon, 21 Aug 2023 23:11:46 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH net-next 8/8] dt-bindings: net: fsl,backplane-anlt:
 new binding document
Message-ID: <20230821201146.hudnk5v2zugz726p@skbuf>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-9-vladimir.oltean@nxp.com>
 <20230821195840.GA2181626-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821195840.GA2181626-robh@kernel.org>
X-ClientProxiedBy: AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::30) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bf8233-de5c-45cb-d80d-08dba282db1e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9t6+yE3TCIBvcrKFCRbbKWiFExXtVQ44VBGhT9q4KR1VZMUSd4h5cU9KZz3QElnV3V4CNyVr/yJavlXu+u2By9vMAQq7JpnjVx/imo2PVZa9PjK/CrkR8WTkkMggIemHg3KjaA9DD6xnGmPkWGW9TJpBuIWgm5DRQnjatvsIGmwwn6HpFXmN21iqa3V/p4+tuKNTwEhK53G7Fd9CadAOgCNbKqeznwjHcRs4JYD3smqrMR8z1LjdtCFkng+VVpwIWKVl8JmXS7TFER0RvOsEcMZRRP2NbyxiNyfODKZmt2+4dMNAzj+o3dmE7H7zBV3yJ6VeRgXUUCQ/3j303JwbiH4fuxuYYe2SOnwcso0OKW+qslnqsIGuskYGCjTQPfhb6L7aIvQGDq1A0qE1nbviYpKPSnl5XcEaF6M2K6eJvUzLC2kTheNM1MSiWQ5WSC9hEj1SeBC088j438hLuvn3el+mCmENZJZWB6xWI9oZYdG8yPv13fkexoq8Y5QUxGbJv4jd7udeMYp/uA8kejaz1UDtt3jo3iJxTTWfxTH4yOjt4G5pllYD0y16V4QMsfJn+uKZAsmEaIGP+HibLNRxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(8676002)(8936002)(4326008)(1076003)(33716001)(41300700001)(966005)(478600001)(6666004)(38100700002)(6506007)(6486002)(83380400001)(30864003)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55Uh9qZPbE74bZR24by7HSpcmW2ajf1hOI2RX0T0/tq3VPBEHODYLX+bfbxL?=
 =?us-ascii?Q?+vLOgOxObFfrWxLqTR9ZnrBcIgLjnqzPKebg0MP/LeqXnhCwnCGDPBS1Vu5+?=
 =?us-ascii?Q?2NhPYTjyASd61SW+LZBPnht//ovvI8icF0T8s2GDrFXC2YgWglbaUeR8DbIl?=
 =?us-ascii?Q?QpoU1coa7MDZMbLCeCggloybv4qA7tX+R9wTw1M7imEku/QPYwGFAABDi64b?=
 =?us-ascii?Q?LwOjYWiDEsANzCQVnPgN8h4HOol86utIE5dQGlnuoDSpuykWVPBzLFGkoeK0?=
 =?us-ascii?Q?vPHnk1vnjXmNoO1que87T10TONDizEaMxXdxG8rXYjLGKJEVxGYSbEuyv8oD?=
 =?us-ascii?Q?NbhtwZfb82Alp1TZnMVqx9kxDMt/GkY0sVt+J3WfCXVrYYioSH3NS6kg+WR1?=
 =?us-ascii?Q?nMDgAw36vmHFqeetGiEhF+ad6lkgA7ErnV6b3bv+Gmy2j+VV2XKv3sPmwFeH?=
 =?us-ascii?Q?YLelP1nsX5SE9jobeGBE8axCw4OCF2uoK0jX6iXe8ipCNizxmnutVkc7Az/g?=
 =?us-ascii?Q?xgX/tHrLEXjCFHkjQ33GQdlEFSxYyzndxNgJgQb4YSbHhZFMP6+Z4MylT7QB?=
 =?us-ascii?Q?IAby7vRFDLcZBblrkIw7rw6LLNXb7F7fRz3r1+BWnlhK8eGEMbU45Scbg7zX?=
 =?us-ascii?Q?tedtOgSTXCPzU6t8OHbgoMdLv2jlC28iQ6pxJpNBw3IeDYnkE6+C197BTbGb?=
 =?us-ascii?Q?P+Xt8GOs4yi1C/sz2K45D7Q7Hqjvx6jRwItx4NQByNc3oILGytfthAvTH3GM?=
 =?us-ascii?Q?v/oHJ4P4LkvId7VQFvpJwyDQbfU7MSkUM6IBe4txbWwcD0MQTY367CrX5iBS?=
 =?us-ascii?Q?dQ1fmB80OAv7koBoonweKXm0qK0/LowrW0EX9gb4vwdIWw/rrCO0xJ9wCxjU?=
 =?us-ascii?Q?eBrlYawdbNayAFHvGU+am0EMgj6mzcaTpAlA02RRvT4TTLctKirI/l3iwIEt?=
 =?us-ascii?Q?2dSPr+RiYxHF4P7hb0bol9ZaomnbjBRLzaOJig9yFO63tnWPw56GuLuglnhg?=
 =?us-ascii?Q?+ilrvakj4yzLzQKcZNvbip/PDF4xstm/nFZygL/AtgbxrSo3bHhuPPqj8n2n?=
 =?us-ascii?Q?6Q02r2Mu1HTDwwDmZghrSBYpzuUIs7U6qOkkg/y0NUzaDiBdJ+OfQXzrGUsE?=
 =?us-ascii?Q?TAjxNUEMm+VrMDdvsPxrS7g9lyb4q3A6eMOTTBzdItf+xZs6jdYZToyDfRTP?=
 =?us-ascii?Q?jlqjDeN0k3dgvhLQfGi2vnZL9u0TOmevFQLhKdlviki4lpBn8nVtzZweUlb0?=
 =?us-ascii?Q?wHGPQsqN1OJWJMZMC5/nwZ6cWGcyTD/1dBXTx3rLSxfq+U0PlfA9QILVMARn?=
 =?us-ascii?Q?bJ6mGW6ECj/3iJ4lBIPl+ZT/hz9i3HNzVJu4eCUvNP5oUn7qMbYxC/c71SFx?=
 =?us-ascii?Q?ZuQwg7m5VTvLzQCYP6yGINNwAcRAbAtTeWg03B6oDDo7teAHWqVN11gzIfzF?=
 =?us-ascii?Q?6uzha7ERv9tZ9hr/9FB11fCAnLXLHAxPimWQH+c/o25efxRglriABOO2WATo?=
 =?us-ascii?Q?aROogmP4wVwXiwPaAyCpqiockLjt2krpbx9YYAC8NzIkgAKGFqHldY/vyh8Q?=
 =?us-ascii?Q?q/h12eBO5Gf/YwZA6nt/PgH35rZVXCHh4F5vY1lHT4zLSmQEF32U1mJJa+DP?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bf8233-de5c-45cb-d80d-08dba282db1e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:11:50.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0jrba2ewEBlauf2oTMkrxQA88bYAhVA4yNTJyipBeL53GPhPgfwbwvbZTN5JgH3JjY3JF/HuzOwNFssc7QUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Aug 21, 2023 at 02:58:40PM -0500, Rob Herring wrote:
> On Thu, Aug 17, 2023 at 06:06:44PM +0300, Vladimir Oltean wrote:
> > Illustrate how the backplane AN/LT blocks can be instantiated on the
> > LX2160A SoC with SerDes protocol 19.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  .../devicetree/bindings/net/ethernet-phy.yaml |   8 +
> >  .../bindings/net/fsl,backplane-anlt.yaml      | 238 ++++++++++++++++++
> >  2 files changed, 246 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index c1241c8a3b77..96fa672e4786 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -49,6 +49,14 @@ properties:
> >        - items:
> >            - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
> >            - const: ethernet-phy-ieee802.3-c45
> > +      - items:
> > +          - const: fsl,lx2160a-backplane-anlt
> > +          - const: ethernet-phy-ieee802.3-c45
> 
> What's the benefit of having ethernet-phy-ieee802.3-c45? Will it work if 
> the OS only understands that and not fsl,lx2160a-backplane-anlt?

No. The "is_c45" bool won't get set correctly in fwnode_mdiobus_register_phy().

	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");

With that bool set incorrectly, the MDIO protocol cannot access the device's
registers.

> > +        description:
> > +          Some C45 PHYs have no PHY ID in the standard location, and there is
> > +          also no PHY ID allocated for them to fake. They are identified by the
> > +          primary compatible string, plus the secondary one to distinguish them
> > +          from a raw MDIO device.
> >  
> >    reg:
> >      minimum: 0
> > diff --git a/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml b/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
> > new file mode 100644
> > index 000000000000..7282e93b1dd4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
> > @@ -0,0 +1,238 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> 
> Not the right license.

What's wrong with it?

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,backplane-anlt.yaml
> > +$schema: http://devicetree.org/meta-schemas/core.yaml
> > +
> > +title: Freescale Backplane Ethernet PHY
> > +
> > +maintainers:
> > +  - Vladimir Oltean <vladimir.oltean@nxp.com>
> > +
> > +description: |
> > +  Some QorIQ and Layerscape SoCs have an additional block on each SerDes
> > +  networking lane, based on an IP core from MoreThanIP, which performs IEEE
> > +  802.3 clause 73 base page exchanges (for auto-negotiation) and clause 72
> > +  training frame exchanges (for link training).
> > +
> > +  By default, this AN/LT block comes up with auto-negotiation disabled, and
> > +  in that case it allows itself to be quickly bypassed from the data path and
> > +  for the PCS link to come up without its involvement.
> > +
> > +  Software can optionally make use of it, to turn the PCS, AN/LT block and lane
> > +  (PMA/PMD) into a full copper backplane internal PHY.
> > +
> > +  As a warning, the binding for the multi-lane link modes (40GBase-KR4) is not
> > +  currently backed up by a driver implementation.
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          - items:
> > +              - const: fsl,lx2160a-backplane-anlt
> > +              - const: ethernet-phy-ieee802.3-c45
> 
> Use "contains" and drop ethernet-phy-ieee802.3-c45.

Thanks, I'll try it.

> > +    then:
> > +      $ref: ethernet-phy.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: fsl,lx2160a-backplane-anlt
> > +          - const: ethernet-phy-ieee802.3-c45
> > +      - const: fsl,lx2160a-secondary-anlt
> > +
> > +  reg:
> > +    minimum: 0
> > +    maximum: 31
> > +    description: |
> > +      The address of the AN/LT block within the internal MDIO bus of the MAC it
> > +      is attached to.
> > +
> > +      In the 1000Base-KX and 10GBase-KR link modes, the AN/LT block responds at
> > +      the same MDIO address as the PCS (determined by the SGMIInCR1[MDEV_PORT]
> > +      or SXGMIInCR1[MDEV_PORT] registers of the SerDes block, by default 0).
> > +      The PCS and AN/LT block respond to different MMDs, though.
> > +
> > +      In the 25GBase-KR and higher link modes, the AN/LT block responds at a
> > +      different MDIO address than the PCS, determined by the
> > +      ANLTnCR1[MDEV_PORT] register of the SerDes block. By default this is 4
> > +      for lanes A and E, 5 for lanes B and F, 6 for lanes C and G, 7 for lanes
> > +      D and H.
> > +
> > +      The PCS responds in all cases at the address determined by the MDEV_PORT
> > +      field of the SGMIInCR1, SXGMIIaCR1, E25GaCR1, E40GaCR1, E50GaCR1 or
> > +      E100GaCR1 registers of the SerDes block.
> > +
> > +  phys:
> > +    maxItems: 1
> > +    description:
> > +      phandle for the generic PHY (SerDes lane) that acts as PMA/PMD layer
> > +
> > +  pcs-handle:
> > +    maxItems: 1
> > +    description:
> > +      phandle for the technology-dependent PCS block corresponding to the
> > +      initial (RCW-based) configuration of the port. Must be omitted for the
> > +      link modes where the PCS and AN/LT block respond at the same MDIO
> > +      address. Must be specified otherwise.
> > +
> > +  secondary-anlt-handle:
> 
> Needs a vendor prefix and type.

Ok (assuming this will remain in the final solution, after PHY maintainers' review)

> > +    maxItems: 1
> > +    description:
> > +      In case this is the primary (first) lane of a multi-lane link mode, this
> > +      property holds an array of phandles for the other AN/LT blocks, that are
> > +      involved in link training but not in auto-negotiation. These have the
> > +      "fsl,lx2160a-secondary-anlt" compatible string.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - phys
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +
> > +  # LX2160A lanes A, B, C, D with SerDes 1 protocol 19: dpmac2 uses 40GBase-KR4
> > +  - |
> > +    dpmac2 {
> > +        phy-handle = <&mac2_backplane_anlt>;
> > +        phy-connection-type = "internal";
> > +    };
> > +
> > +    pcs_mdio2 {
> 
> mdio {

Hmm, is it bad if I can keep the name? (it's actually important for documentary purposes)
Actually I wanted to put a label like "pcs_mdio2: mdio {", but I couldn't,
and this is what led me to the compromise.

> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        status = "okay";
> 
> Don't need status in examples.

Ok.

> > +
> > +        pcs2: ethernet-phy@0 {
> > +            reg = <0>;
> > +        };
> > +
> > +        mac2_backplane_anlt: ethernet-phy@7 {
> > +            compatible = "fsl,lx2160a-backplane-anlt",
> > +                          "ethernet-phy-ieee802.3-c45";
> > +            reg = <7>; /* according to ANLTDCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 3>; /* lane D */
> > +            max-speed = <40000>;
> > +            pcs-handle = <&pcs2>;
> > +            secondary-anlt-handle = <&mac2_lane2_anlt>, <&mac2_lane3_anlt>,
> > +                                    <&mac2_lane4_anlt>;
> > +        };
> > +
> > +        mac2_lane2_anlt: ethernet-backplane-anlt@6 {
> > +            compatible = "fsl,lx2160a-secondary-anlt";
> > +            reg = <6>; /* according to ANLTCCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 2>; /* lane C */
> > +        };
> > +
> > +        mac2_lane3_anlt: ethernet-backplane-anlt@5 {
> > +            compatible = "fsl,lx2160a-secondary-anlt";
> > +            reg = <5>; /* according to ANLTBCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 1>; /* lane B */
> > +        };
> > +
> > +        mac2_lane4_anlt: ethernet-backplane-anlt@4 {
> > +            compatible = "fsl,lx2160a-secondary-anlt";
> > +            reg = <4>; /* according to ANLTACR1[MDEV_PORT] */
> > +            phys = <&serdes_1 0>; /* lane A */
> > +        };
> > +    };
> > +
> > +  # LX2160A lane E with SerDes 1 protocol 19: dpmac6 uses 25GBase-KR
> > +  - |
> > +    dpmac6 {
> > +        phy-handle = <&mac6_backplane_anlt>;
> > +        phy-connection-type = "internal";
> > +    };
> > +
> > +    pcs_mdio6 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        status = "okay";
> > +
> > +        pcs6: ethernet-phy@0 {
> > +            reg = <0>;
> > +        };
> > +
> > +        mac6_backplane_anlt: ethernet-phy@4 {
> > +            compatible = "fsl,lx2160a-backplane-anlt",
> > +                          "ethernet-phy-ieee802.3-c45";
> > +            reg = <4>; /* according to ANLTFCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 4>; /* lane E */
> > +            max-speed = <25000>;
> > +            pcs-handle = <&pcs6>;
> > +        };
> > +    };
> > +
> > +  # LX2160A lane F with SerDes 1 protocol 19: dpmac5 uses 25GBase-KR
> > +  - |
> > +    dpmac5 {
> > +        phy-handle = <&mac5_backplane_anlt>;
> > +        phy-connection-type = "internal";
> > +    };
> > +
> > +    pcs_mdio5 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        status = "okay";
> > +
> > +        pcs5: ethernet-phy@0 {
> > +            reg = <0>;
> > +        };
> > +
> > +        mac5_backplane_anlt: ethernet-phy@5 {
> > +            compatible = "fsl,lx2160a-backplane-anlt",
> > +                         "ethernet-phy-ieee802.3-c45";
> > +            reg = <5>; /* according to ANLTFCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 5>; /* lane F */
> > +            max-speed = <25000>;
> > +            pcs-handle = <&pcs5>;
> > +        };
> > +    };
> > +
> > +  # LX2160A lane G with SerDes 1 protocol 19: dpmac4 uses 10GBase-KR
> > +  - |
> > +    dpmac4 {
> > +        phy-handle = <&mac4_backplane_anlt>;
> > +        phy-connection-type = "internal";
> > +    };
> > +
> > +    pcs_mdio4 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        status = "okay";
> > +
> > +        mac4_backplane_anlt: ethernet-phy@0 {
> > +            compatible = "fsl,lx2160a-backplane-anlt",
> > +                         "ethernet-phy-ieee802.3-c45";
> > +            reg = <0>; /* merged with PCS SXGMIIGCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 7>; /* lane G */
> > +            max-speed = <10000>;
> > +            /* no pcs-handle to &pcs4 */
> > +        };
> > +    };
> > +
> > +  # LX2160A lane H with SerDes 1 protocol 19: dpmac3 uses 10GBase-KR
> > +  - |
> > +    dpmac3 {
> > +        phy-handle = <&mac3_backplane_anlt>;
> > +        phy-connection-type = "internal";
> > +    };
> > +
> > +    pcs_mdio3 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        status = "okay";
> > +
> > +        mac3_backplane_anlt: ethernet-phy@0 {
> > +            compatible = "fsl,lx2160a-backplane-anlt",
> > +                         "ethernet-phy-ieee802.3-c45";
> > +            reg = <0>; /* merged with PCS SXGMIIHCR1[MDEV_PORT] */
> > +            phys = <&serdes_1 7>; /* lane H */
> > +            max-speed = <10000>;
> > +            /* no pcs-handle to &pcs3 */
> > +        };
> > +    };
> 
> 5 examples yet not one for "fsl,lx2160a-secondary-anlt"

Are you sure? They're in the first one:
"LX2160A lanes A, B, C, D with SerDes 1 protocol 19: dpmac2 uses 40GBase-KR4"
(and still not trimmed from this email)
