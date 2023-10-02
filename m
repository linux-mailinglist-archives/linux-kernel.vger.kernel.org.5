Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8086F7B52D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjJBMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjJBMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:20:09 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C381A6;
        Mon,  2 Oct 2023 05:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZ5WKLGWSRBXS81TfAUVuXl/zFabk5FkamKkWLoJu39HyImNTEvvxu/ELLEkFfFqd4fRvYj/RMXMnh1WWMb7jYTAHnAAn9amX3gq/6e+UqeNXNV2VQIkTCSVq/1cgnNW49uq6cnKhgkfzyXj0wy3iXQNTkBLq/8x5L8gVyOsZPXlWSVSMFifFUoPu3t4sQ24P5ULPK9dV38waruIJlPx3jaOa1YbHAU0EUldIC0uzD1Jl6S9bPKIb5jgRtSx/0XTpDYU+VZvknUjlM4hlmn1nQatGyIrDIXuGNYM6b+sFvWD3erz61hcVEnxwOlE35B2MMhIU+aim3DxWGzSVgElkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm/E32g4VeGrCiJUg+ljpLYx/zJ8JRqy+HCXMQvavMM=;
 b=KAOqDSDVQTz0J6oK5wWM3fB12P2wkiGgoWbfs6PX83JnGKUxgsgPfT5OgRMt1FKq1PDV6bOc/Awo/2q+q0MxmUxRTI2tEW/sBSvOM41FW5NGGF8AI/2Zb8B2PQCS1mUCle1dixHC3ZXo0w+rHM8ZNzK5fbnKEqlR/CxPJ2YyXyPBpfs07NkrknUk9UCdDtE/ua+M5SXw23qKe8UKXzsKbOxvm/2nhUjvdKH20spu8HhpjFIy9Q72g1Tk5wot3ScT0njSEruOWPseLifK5Pekn9RHGmv88z2t1VTYFLzzU233YGLZLwTkAnmkf5E16JxqRCQicE64kOzqCwQmdzvcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm/E32g4VeGrCiJUg+ljpLYx/zJ8JRqy+HCXMQvavMM=;
 b=k1+8gbVELyed1CCyO4LMQilbc2DAKEO64ZsfaJDuMA2pdJ3pm42M2WCF3sus2derGWr9Dl/MmL+wrUyPTDszOqeqMxD/d0bGZ/Dkfdx0O0TLXMlH26v2S0mbP8tGE+5b0OM1BAqlb6IJnty6LIf9kwvPpkv2vYxG6fv5wy9zdw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB7101.eurprd04.prod.outlook.com (2603:10a6:800:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 12:20:02 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 12:20:02 +0000
Date:   Mon, 2 Oct 2023 15:19:58 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 13/15] dt-bindings: lynx-pcs: add
 properties for backplane mode
Message-ID: <20231002121958.xybzovgjzldfiae2@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-14-vladimir.oltean@nxp.com>
 <c31577ee-9d81-212b-42a6-e72a648f9276@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31577ee-9d81-212b-42a6-e72a648f9276@linaro.org>
X-ClientProxiedBy: VI1P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd1c36e-81dd-415b-11d8-08dbc341e750
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp/eCWED2lva4GhMfHH9RkoO2ckKRu5YY7CApPO3x2qBlbvn2Ad2RXjH+0UlwYmbRrIa9PdPaj0W3e9TRn087fpW8CRekApC9XuYI61xHfsxKpivVpwAkGXQxdQUjgdADs/6okX0n9cXaDQoeUbZlPH36mGqZQMfdaXq6aKUPQmmrd7A6/c/Pt7DDT9yDIsU3ArNwPVfTXIH0yY7yBaZuxAFeVwuAPcRjW7BgN/bqHXUp4vfai2Qtr+pzbKOu3gaxVMqLMZQwZuU2jnONbaWdwZWOmlCsabVCmcBS3UGnrMTnHC1QCuLTQ6NBNi3eJHHSEHkp2PC8MM5GN/Uyff3uQ2RdlZJXsT4FZJCAJ8eOb4XAFruVOfcKdjyNpmrUFrCiEYryPwFymGtLM4nKUsI7s5IOfs27rPQpahl4CxlXFajrm88TfLUzjQESvEsfmshkr3Xs0Nv4EcacwKN7LFj0I1UJPx/TLi/RwyC/ZwqIS68DQn/D6P2gC7iENlafEHLZ0HjtBkgyEJN7Zh2iHnE34tdmd0PE3ttZ06PPBYF7j70qpwEYkCAqfCaPn+rndTF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66476007)(66556008)(6916009)(54906003)(316002)(66946007)(2906002)(478600001)(5660300002)(6486002)(6506007)(6512007)(44832011)(4326008)(26005)(1076003)(53546011)(6666004)(8676002)(8936002)(7416002)(83380400001)(9686003)(41300700001)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMOmhOswINyfEkemyJIlM3Vu8e5/8vwDHbB1bQt5v919fHGJE+01krCG6XCw?=
 =?us-ascii?Q?L95aNmaq8ivYO1Rs59S94/abVcoYuI2444AHvpxBk014+zCOsydBpw1bT0tz?=
 =?us-ascii?Q?7gw5bBIL7alu3ktgNaTlITPXbCLRgO17C3crjqJPAIufJzIu2Bp/GczkE94C?=
 =?us-ascii?Q?2Oot7X8GLTnhedwSKWRKY/11wzRXBfLpMgnMQntplThjP1wf3PzlxUOkPRJH?=
 =?us-ascii?Q?ykxrvclyaPBz3FHH/OZqwAvWmpp3LWo/nJi7T++HDveZusV5qq4Pg8/AKCmp?=
 =?us-ascii?Q?cY1YCR6p1IvdZIc/o5dFkCRX2iPauYGa9Ngs4ffdKht1LmdweAxt70vILfKs?=
 =?us-ascii?Q?U7psew9Z0eOVu16b1VhUbq2ZFhanfgUVAHrQIez8RvDXGPNx3Zdm9ajGLevo?=
 =?us-ascii?Q?iWjcNbMoNCMxRckI9JhNu1JDT/lCqn4LG4fJzUMtdRcYu7WvfB2EWiCgrd0k?=
 =?us-ascii?Q?y6Oi3b8z9ioXNX+RKuHHopmYW3VE04wcwdtiKRaeM6TrHnivtbUuByb4mxtT?=
 =?us-ascii?Q?HZ54uaQiy63eZmg8R0JBquLSbpZgbsdmruDdw0e3NuxA7rdAK0INomImVBfJ?=
 =?us-ascii?Q?XkbJtjLbqngBg95A8a+7szWhhytRQpB4s5+CtrTagUx1015hTvhyzzHMRCSg?=
 =?us-ascii?Q?pQVmAPDn/iw9emuHfCUMNcp0AcZgBLEIObfCg3SDZZYPerlWGrBmlw17vTA+?=
 =?us-ascii?Q?oGQjXiSH2qE6mnadFt0FmZ2sWDvhPSo3VxfRnLquEVJ/fWWmNrITH03wkIfi?=
 =?us-ascii?Q?hb/4eX3eGS4uSd1Ay+5jRCin7QvZQgUjULhBGhIYeaU82zx7loxd+V0sEORl?=
 =?us-ascii?Q?YcUwUmVG4tmxUB9vAo4F7pBpA0hbPmoaHBT5aUx5QobQGUNmMIRabet6hWM5?=
 =?us-ascii?Q?G6tUAj4VMaesrFRluWrZ2sy28R+G19ErQKVgow6bOx+2bTY/pB47dWxNQGWi?=
 =?us-ascii?Q?Si7X7ScIXm4sdCPT0u+GlOfXYwmwPzWcGCtIwKYVzeU9KUxFwfrADejaYSTy?=
 =?us-ascii?Q?xlIhh9BeE2GwUZ/GTaQ9n97N8D5RhyTRa+ixENLph1psiSP6F4cN8Pcy6hfp?=
 =?us-ascii?Q?MkcubsBr8NxWAsxbZqjutXKY9xQLt40t1CHfuixSsmkTzJGwmaTUJkpNjOs+?=
 =?us-ascii?Q?y/vmbsR0kanIVvsQxdIjWg9Ed3d+pzrtfnf8wGqqDpYwfkSNbrQpi6Gw+nZH?=
 =?us-ascii?Q?hZ5BL2z0cyck21lVlSmDYv8UMEI1VYB9kj2mfyXKmHyJC3bm7ysJvvhwr/YY?=
 =?us-ascii?Q?ps4TfBp1G3uDVni8+Uo9Q/tXTnAkUNRlZX+YDZ46PXBU18K7Kh+l4PVOygt4?=
 =?us-ascii?Q?2IYLa8XGxBllD1YICSPfytjiUbaTzMNjWDvIk9LupjlnnsD4lhucl/P39KOc?=
 =?us-ascii?Q?8nyGC1QEWLtR5QglASrJoWXFwONKRNMeWg+Z1cInqT5EJJAvBk9SarBYFqyH?=
 =?us-ascii?Q?5EyTb+NvjRKX0v60/uvK9DNKEnsCNT82Ow3vpfhigpMgpcBaT3CKAbqUY6Z8?=
 =?us-ascii?Q?VGn4ucL61mzH0KBEE3ZlmQjbwqWNIMyEerS9oCSo+dI3uWVMeBba8LhQt3gT?=
 =?us-ascii?Q?Ux+VRIheeEj+a+z+rElIxya1TGqXv32xig8GLpO6prb5mb7CLbWGolb/QKt9?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd1c36e-81dd-415b-11d8-08dbc341e750
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 12:20:02.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsMwtm+fyOwgxFxVT7rxnt3MiP1Q8bTEYVYZn1ItLFO6E45xH6LMaFV/ejl9R0dBIglniwIFdEsgwx1NapI+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7101
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Sep 24, 2023 at 01:49:24PM +0200, Krzysztof Kozlowski wrote:
> On 23/09/2023 15:49, Vladimir Oltean wrote:
> > When the Lynx PCS is deployed on a copper backplane link, it must be
> > prepared to handle clause 73 autoneg and clause 72 link training, which
> > it can do using a dedicated AN/LT block. The latter doesn't need to be
> > described in the device tree, because it is discoverable from the SerDes
> > lanes.
> > 
> > The media type that is deployed on the link is not discoverable though,
> > so the introduction of a fsl,backplane-mode boolean property appears
> > necessary to determine whether the AN/LT block should be employed, or
> > left bypassed.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > v1->v2: patch is new
> > 
> >  .../devicetree/bindings/net/pcs/fsl,lynx-pcs.yaml | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/pcs/fsl,lynx-pcs.yaml b/Documentation/devicetree/bindings/net/pcs/fsl,lynx-pcs.yaml
> > index fbedf696c555..40fbcd80ee2a 100644
> > --- a/Documentation/devicetree/bindings/net/pcs/fsl,lynx-pcs.yaml
> > +++ b/Documentation/devicetree/bindings/net/pcs/fsl,lynx-pcs.yaml
> > @@ -16,11 +16,24 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    const: fsl,lynx-pcs
> > +    enum:
> > +      - fsl,lx2160a-lynx-pcs
> > +      - fsl,lynx-pcs
> >  
> >    reg:
> >      maxItems: 1
> >  
> > +  phys:
> > +    maxItems: 4
> > +    description:
> > +      phandle for the SerDes lanes that act as PMA/PMD layer when the PCS is
> > +      part of a copper backplane PHY.
> > +
> > +  fsl,backplane-mode:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that the PCS is deployed over a copper backplane link.
> > +
> 
> Please extend also existing example.

Ok. Snippet for attention (a dtsi I was working with - applies over fsl-lx2160a-qds.dts):

&dpmac2 {
	phy-connection-type = "internal";
	managed = "in-band-status";
	/delete-property/ phys;
};

&pcs_mdio2 {
	status = "okay";
};

&pcs2 {
	fsl,backplane-mode;
	phys = <&serdes_1 3>, /* lane D */
	       <&serdes_1 2>, /* lane C */
	       <&serdes_1 1>, /* lane B */
	       <&serdes_1 0>; /* lane A */
};

The thing is that the RFC v2 bindings are still very much WIP. For v3,
I will try to remove the "phys" property from the pcs node, and process
the ones from the MAC node (client of PCS).

For example, arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
has "phys" under &dpmac7:

&dpmac7 {
	sfp = <&sfp0>;
	managed = "in-band-status";
	phys = <&serdes_1 3>;
};

but &dpmac7 also has pcs-handle = <&pcs7>; in fsl-lx2160a.dtsi.
Thus, if I'm able to pass the "phys" phandle from &dpmac7 to &pcs7
through code (argument to lynx_pcs_create_fwnode()), then the location
of the "phys" property could be the same regardless of use case
(backplane or not), and the dt-bindings of the lynx pcs would be simpler.

The only dilemma that has stopped me from doing it is that the dpmac node
may have other "phys" in the signal path (for example external redrivers/
retimers). With up to 4 SerDes lanes per MAC and with optional retimer
phys on each lane, it becomes a question of how can we distinguish the
SerDes phys from the other phys (the PCS wants the SerDes PHY)? Would it
be okay to add a phy-names property, and parse it for "serdes-%d" to
indicate a SerDes PHY, and anything else can be named in any other way
("retimer-%d")?

> If these do not apply to lynx-pcs, then they should be disallowed in
> allOf:if:then.

They do: the "fsl,lynx-pcs" compatible string + the bool "fsl,backplane-mode"
is supposed to instantiate a MTIP_MODEL_AUTODETECT backplane AN/LT block
(as opposed to LX2160A where it isn't autodetectable). It's just that I
didn't get to implement support for the other models yet.
