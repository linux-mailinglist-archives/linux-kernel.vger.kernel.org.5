Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FAC75F806
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGXNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGXNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:16:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E62DD;
        Mon, 24 Jul 2023 06:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+FAV8oPTkI6iDk0bpzXDpVUhRCMj0UUvttlWLdoO+Ty+FlJn4E1KlS0grarcdCovGDT6GQLd+zlzmS5BkXNCvwzwxWk0bBetPxuVkAdqzG+Vk34NjseZ4S6hrIsITnLoTEF5T6532Ozn1rSBx935Y81jcL91Vb1ASwstrauhFAv8sekKkkbjndX6rYXY08fsszINv54KwGVzny98pK/dKHGSzmANPiFGwXPeyfo7d4JRsfbOPh7gmRptwZrtfwut7moPIaAvp05Fz34lVHQQZU1el6zRZ/p7PVpupM8GVlGpL89wO49QpvdAGkP4XGsYZkEcLvB7VkQ3KWn72keng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo2vWYHBEeA0YwfRecSAYyMET2uOxleQamR37vvXyz8=;
 b=GfYtdVl4qgmVpMpQnSbBx4kMmtM9F6Sm4wjrOiy3FI1Uc3P2I1kJ+v3hbFRBBCkZj+TMWNCWR9nP7Dch5nvt+tFMHjQITTB0ssKdpaNJGf9LQM+hVCzJ/QzM9BdeZs6K391xuF8j1nuj0nxnMMVUx+QF+znYCMQxGoua+O0Q26olUkUG+7BUx34f3AO5YeqjMPTfbPQz+dcEAmeJaUrW4e58NuYdAahx9hOYVve94ZTZZLPpwh9teTypm7d7grWlBZ9Zg3iyqa9ykgl73EEyGQLraEN28GJtPetw3Oigbsv86+hmBBsHrF8xeCW+qyar8ddazfjRWK/O/tgR9oyjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo2vWYHBEeA0YwfRecSAYyMET2uOxleQamR37vvXyz8=;
 b=F2KPcypY/NEu+zBTcYTa1ULsHKzCTHiBO8ZXGLhm27PrZvp87AVv/zhvvIrbib37oReSUFASb2p+YhbtlIW8OEZLXO/KxIwyHQdZOHm+70YCPIAUlywdOHFPkR1pN6KAcZGJwm5x5jOuwDjtbpzodzwQCuJoymA32Ayg3SOg9Fw=
Received: from BN8PR12MB2852.namprd12.prod.outlook.com (2603:10b6:408:9a::14)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 13:16:30 +0000
Received: from BN8PR12MB2852.namprd12.prod.outlook.com
 ([fe80::c371:256e:45d1:a680]) by BN8PR12MB2852.namprd12.prod.outlook.com
 ([fe80::c371:256e:45d1:a680%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:16:30 +0000
From:   "Somisetty, Pranavi" <pranavi.somisetty@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Thread-Topic: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Thread-Index: AQHZugjScH8iKU5N9kWTSvwBM7ERX6/BZ8YAgAd/OlA=
Date:   Mon, 24 Jul 2023 13:16:30 +0000
Message-ID: <BN8PR12MB2852E09191C6AB6DBF7EF33AF702A@BN8PR12MB2852.namprd12.prod.outlook.com>
References: <20230719061808.30967-1-pranavi.somisetty@amd.com>
 <20230719182206.GA537052-robh@kernel.org>
In-Reply-To: <20230719182206.GA537052-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB2852:EE_|SN7PR12MB6690:EE_
x-ms-office365-filtering-correlation-id: aa2d1881-49b7-47d6-0487-08db8c4831ff
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xd/nBSrQFnXfsSw0M40iwrPHm7KTCYKIIJ/HoDH9ZojCvZsTEpNU4B/ceTRcXQWnvL1Vb/EkGyFAH5alf8b24/Wob8ZpnRax5PL/58ATyg1biOYG386Y6ppisPjzuWjLiWpBZATsqfVfHitmAWq09jrWMndG8wKpH/Fg1dN07ISgVAz59U88ObXwUwEbOdaFTb8nBliRZp6UrrOG7jJbqXExomsZlS2bk2ejGCyasnaceU4vXcLwGBEPKfWrhia/9DmwtLcXm6YGk0N6sfoH0ri675ChmOLZtUGh2ULbu4we8D/kiC7joEN1tYBdHzqMXhEl8AAXd5ZFnyAFoZPzg7UgZ6NcuW0Jc6eP7L4dBc9i/1woNwxk0kbghZa+BxCh1Pnhlzrn9qwEZIj/5+u/glaD975k985d8YVMuaMKC8mz4tEEN6SoNPysAuFrHs82LKtBx6541AbHiF5DKjZ9lldBSAyVrDnB6Arc/S0V2inoJc2C8Ajp/PpDjHWfwX1YVr+t1l+u8BLLWKB6VhOIs8++IJH5X8ibZXoSy44o9RHJsuaxFopl89XVsknjAXI9LPFMvYYRHjOJiSU6wavsfNupc9bcwy11FMByEWSj9zhMOAeMwXoi4ndcSSPMwr5xNEgoqjbJ80IafPfeH7z5jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2852.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(2906002)(55016003)(478600001)(38100700002)(8676002)(83380400001)(966005)(122000001)(9686003)(186003)(6506007)(53546011)(86362001)(52536014)(8936002)(5660300002)(33656002)(7416002)(71200400001)(7696005)(6916009)(76116006)(38070700005)(66556008)(64756008)(66946007)(66476007)(66446008)(316002)(54906003)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i6Tr2RRoJqH9DxIRwSMhqttjcS86OhkzC3Z5o0mBmYfhriki39s13Zh3ec2l?=
 =?us-ascii?Q?A20O3Efx3bsd2kP27YxcL9Ki/QkLCuao3fIGVTLk9oFzgoSfohTdglG2FEzi?=
 =?us-ascii?Q?7HwJsHyXRaG+kSwtgPkX7fMBsljlqBo8Vxt3iHlWcqX8OiYBQ+AyAIPdLHT0?=
 =?us-ascii?Q?vlO6xI2pzwZEnyUTcyv7AVqBRT85pjsRL6duP/A2z5NkAL7eaJImc0Qp1GoQ?=
 =?us-ascii?Q?S6lDJrGdYzds0OYpdUyYsa8oIyikfsMMv9kBHtfRLcth5GErW26/2C0NzvM5?=
 =?us-ascii?Q?p21XvpfOw1PBZusMQMX+HvGfkrEcs8EiQNcejyetJxX5ggrcQ1kIMprYQzeN?=
 =?us-ascii?Q?LyMFst+CEWdhwAxr4sJQZI1xAiRytiCC8j+wDhgS1vsS6nZDUsoN0Hll7ViE?=
 =?us-ascii?Q?qG+AozL60rabKnvT/oUM70w1S+2GHwboDxNxx9cap4ZPy67i1iqxTYgntGUt?=
 =?us-ascii?Q?P1hs9x0PDX2TGaZvOvEzDzIaOJPxambEBfD5cmBYOxvb2DIoBfgCaHE1igyn?=
 =?us-ascii?Q?91pGeXZMWNOsoRAT5HBahQmhUM3UiolXo0ooz4oE5UJQTMnJQz7LKSru0GrJ?=
 =?us-ascii?Q?/pULWPs4+n7W/ukXTnmE/yMweiuoz57Z5kncXGSLHo1pNF70abgEYZyqbXY4?=
 =?us-ascii?Q?D6rqPeI85rLmyz/9c2vgv9P5As7mictIyEBoa9oOeIf8sWzRTy6ipQA5CBz3?=
 =?us-ascii?Q?M1ax/OlhU3SJbAiPrRMLQY8BkfzaS5tqqbkMyC8mhJ4qQb0yX7BIWxrCQAv3?=
 =?us-ascii?Q?+Y1CrLmEygmOY+Ljc0cj3Xa5FU5gr/5HyqRFYK/7IeMzE4C8bocCXiRTD/rd?=
 =?us-ascii?Q?gTtD+y0ionvoDx78d29d7Q8axTYMKzsEvZ4C3alGrtdGC7TzJ/1XynSDYGS1?=
 =?us-ascii?Q?iQO2v2Ow7GwBloip1SRCajmsBH7GxrnkCzeD4fc6M8A+ADi+fiQPP3xzf+NP?=
 =?us-ascii?Q?N4dG99f+knvgAKpFNXOb/0RjvtgWYsOSk+42otuzP01lY8Q0SxzQOuzuGCoP?=
 =?us-ascii?Q?JkoNG4z+BLQW3c1jcCxkn5kxwFMmOcFYMYdSWWzelA2jbIX9bCcw6J3dLHvA?=
 =?us-ascii?Q?cRimzi6G+9jQjl8sR36kSXrZoaKAW+pmcNKpD/yboYBu56HmVkWWOxEXhqj4?=
 =?us-ascii?Q?+xSR6bUMR+EGyD0kLMOfUuXVdFe9x6jz9G2x2TtyMCAELXkgeNyLJZ0FC83P?=
 =?us-ascii?Q?6Uv6N2OSuNEM3k4zSkQCmOhuRl/pEKGJB3ZulFC0d+a97q9j0THLWt1UPB5z?=
 =?us-ascii?Q?akSCde+Ck8e3Dyh7WQYIyPsE9sPgLk6s2YCdyJxY/q9nXkESEJ62uILwPigY?=
 =?us-ascii?Q?OnzpkDXXcPcw2d3syRExOvD3UDM+qXUt0S59wijR0iMLBPD/G3L1pqQv/H48?=
 =?us-ascii?Q?kowWtYSCRo/bHQgeVIrnyDEW16OO04vuF9y1uNWT8kpiL5ClFfcOiyy/Qi6t?=
 =?us-ascii?Q?NG/d+q+m6GcNBmKkTrrPNAAgF38OVafbcM7DMdKajkP22zC/rYGj9Vnt/pCe?=
 =?us-ascii?Q?J7FSSPy5pfuB0R4vamWrtZkRLBqcSaHju9zbxqSHILTW0XwAhkcGHdQrnw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2852.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2d1881-49b7-47d6-0487-08db8c4831ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 13:16:30.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWVSZChvaQb+rqVmg42mihVji/hJz7ADTTU1F9jbDFhv8odpK9M3MzFBtDL05++uz/i1hQO6SXRZ/teXcX5g9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, July 19, 2023 11:52 PM
> To: Somisetty, Pranavi <pranavi.somisetty@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Katakam, Harini <harini.katakam@amd.com>;
> git (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to j=
son
> schema
>=20
> On Wed, Jul 19, 2023 at 12:18:08AM -0600, Pranavi Somisetty wrote:
> > Convert the Xilinx GMII to RGMII Converter device tree binding
> > documentation to json schema.
> > This converter is usually used as gem <---> gmii2rgmii <---> external
> > phy and, it's phy-handle should point to the phandle of the external ph=
y.
> >
> > Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> > ---
> > Changes v2:
> > 1. Changed description for the property "reg".
> > 2. Added a reference to the description of "phy-handle" property.
> > ---
> >  .../bindings/net/xilinx_gmii2rgmii.txt        | 35 ------------
> >  .../bindings/net/xlnx,gmii-to-rgmii.yaml      | 54 +++++++++++++++++++
> >  2 files changed, 54 insertions(+), 35 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> > b/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> > deleted file mode 100644
> > index 038dda48b8e6..000000000000
> > --- a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -XILINX GMIITORGMII Converter Driver Device Tree Bindings
> > ---------------------------------------------------------
> > -
> > -The Gigabit Media Independent Interface (GMII) to Reduced Gigabit
> > Media -Independent Interface (RGMII) core provides the RGMII between
> > RGMII-compliant -Ethernet physical media devices (PHY) and the Gigabit
> Ethernet controller.
> > -This core can be used in all three modes of operation(10/100/1000 Mb/s=
).
> > -The Management Data Input/Output (MDIO) interface is used to
> > configure the -Speed of operation. This core can switch dynamically
> > between the three -Different speed modes by configuring the conveter
> register through mdio write.
> > -
> > -This converter sits between the ethernet MAC and the external phy.
> > -MAC <=3D=3D> GMII2RGMII <=3D=3D> RGMII_PHY
> > -
> > -For more details about mdio please refer phy.txt file in the same dire=
ctory.
> > -
> > -Required properties:
> > -- compatible	: Should be "xlnx,gmii-to-rgmii-1.0"
> > -- reg		: The ID number for the phy, usually a small integer
> > -- phy-handle	: Should point to the external phy device.
> > -		  See ethernet.txt file in the same directory.
> > -
> > -Example:
> > -	mdio {
> > -		#address-cells =3D <1>;
> > -		#size-cells =3D <0>;
> > -		phy: ethernet-phy@0 {
> > -			......
> > -		};
> > -		gmiitorgmii: gmiitorgmii@8 {
> > -			compatible =3D "xlnx,gmii-to-rgmii-1.0";
> > -			reg =3D <8>;
> > -			phy-handle =3D <&phy>;
> > -		};
> > -	};
> > diff --git
> > a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> > b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> > new file mode 100644
> > index 000000000000..9d22382a64ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/xlnx,gmii-to-rgmii.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx GMII to RGMII Converter
> > +
> > +maintainers:
> > +  - Harini Katakam <harini.katakam@amd.com>
> > +
> > +description:
> > +  The Gigabit Media Independent Interface (GMII) to Reduced Gigabit
> > +Media
> > +  Independent Interface (RGMII) core provides the RGMII between
> > +RGMII-compliant
> > +  ethernet physical media devices (PHY) and the Gigabit Ethernet
> controller.
> > +  This core can be used in all three modes of operation(10/100/1000
> Mb/s).
> > +  The Management Data Input/Output (MDIO) interface is used to
> > +configure the
> > +  speed of operation. This core can switch dynamically between the
> > +three
> > +  different speed modes by configuring the converter register through
> mdio write.
> > +  The core cannot function without an external phy connected to it.
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,gmii-to-rgmii-1.0
> > +
> > +  reg:
> > +    minimum: 0
> > +    maximum: 31
> > +    description: The ID number for the phy.
> > +
> > +  phy-handle:
> > +    $ref: ethernet-controller.yaml#/properties/phy-handle
>=20
> Don't reference individual properties like this. Instead add a $ref at th=
e top
> level to just "ethernet-controller.yaml#". Since this is the only propert=
y you
> want from there, put a 'phy-handle: true' here and use additionalProperti=
es
> instead of unevaluatedProperties below.
>

Adding a top level $ref to ethernet-controller, implies, DT for gmii2rgmii,=
 follows the schema in ethernet-controller.yaml. This is incorrect since gm=
ii2rgmii IP isn't an ethernet controller.
I'm not sure how to reference ethernet-controller.yaml from this schema. Wo=
uld it be okay to add a description to the phy-handle property instead of r=
eferencing the description in ethernet-controller.yaml?

Regards
Pranavi
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - phy-handle
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    mdio {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        phy: ethernet-phy@0 {
> > +            reg =3D <0>;
> > +        };
> > +        gmiitorgmii@8 {
> > +            compatible =3D "xlnx,gmii-to-rgmii-1.0";
> > +            reg =3D <8>;
> > +            phy-handle =3D <&phy>;
> > +        };
> > +    };
> > --
> > 2.36.1
> >

