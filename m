Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D67B7E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbjJDLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjJDLpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:45:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545B90;
        Wed,  4 Oct 2023 04:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cprQ7iUrXq2KsY0JJ+hp1JyWtw5/PZVWms0M50nw7cyk/MDpBA7HKXDGWRlwZiLtKGd4Xk56MM85in/Ca9ZUQfAwWzmqYzyLZob3lSux0TFDTAG7O+jVL1OuyWgW+tNm7eE1Z3titEc4ItdVyPrLKjV5wsusvmGnS4rN1Xqs5tXZIGrQ+6PHRBdiKOJCAENI60xn78/qT89A4bEnzyArbkYswk5a9YcsetNV7VJe0YpJmVB4Z+PA833BFp2w11KBMiK7JVUKhdQHGiy+k0UODWKZrU+hQ1elB7lI6EaJbrVWSzKpGLzzMjWDR8uHbvUu50uNUh6q5ANe45YgJifRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkOvxqElz8k15AB7F9OqubUOc5ZHZMu4JPxbrflZUP4=;
 b=KBg55P67RzBBeNdbrKfrCqvdg8qkVL34yst7YxLp1BJytmFEhpZjTPdqdu+i+FMFSQtC1Jn2wS6DDNqTHzRvLB2XDudiFVoR5hh4DGmNZjjJwSBsL83Lq1WvHcrphrDfkHcfPEkngK6GO6kLOEcDuj0UDwjSx3+kXdrqt6endzGYmwkpBof/7FT2muFA9K9Kooplutz/oT1So9phldZbRFQRM+XNoTyyCGd+xIAwcswQIo8xcj3sLQjb4sYTGJ+JNJ0RJOtmpzmhE+hZnjTH3j4BKehxjIyNIAneLO1uxmcPYKjzJWx4R05c5sXHUxVkAPyKEkljmRI0NKZpv/cD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkOvxqElz8k15AB7F9OqubUOc5ZHZMu4JPxbrflZUP4=;
 b=YW81Rp4O/Wsd4hJZWw79JHarND6mmquEzFI8dXlQlkFzocOn7brhArpdv1MS2x/2onzMDt1Gy9rro+XAx6wFrKFPRsFi2mGKmAUsrkOiwOUnwiyXwWtGucWMWKuwyzLWN1zxBKgJDb/SMHbjUAgohIbLZYjWE1XtSK094oAHx4k=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 11:45:25 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::7331:e05b:6311:5620]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::7331:e05b:6311:5620%6]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 11:45:25 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy binding
Thread-Topic: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy binding
Thread-Index: AQHZ8qEa5JeYHGbt0EyV+BYDViGoorA2vp2AgAC7O0A=
Date:   Wed, 4 Oct 2023 11:45:24 +0000
Message-ID: <MN2PR12MB433326B66D9037CD0462BD2088CBA@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20230929064852.16642-1-piyush.mehta@amd.com>
 <20230929064852.16642-2-piyush.mehta@amd.com>
 <20231002170025.GA1928031-robh@kernel.org>
In-Reply-To: <20231002170025.GA1928031-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|DM4PR12MB6541:EE_
x-ms-office365-filtering-correlation-id: 5146e539-88f9-42f2-959f-08dbc4cf65e6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XsJYELunSdZ1vFvg1fqxYd/aYM1E0kRDO/gNmHvJU/HBd6CQr3BwS4fnUkCC8y+YVRxOvwvxYVQNer53OAsMjPfm3fN3wXH3U1KHUT2GLeeNkWaF9BdCzLQBrKrjRpwTNqfeo5gislOhUmhdZW/iIzJjUXdgmLLKH0+cblgm0KFIbOaWiJ6BcdQn20s3bVpBlreJy90YRTaYkde30Lrvar/WYluk1YtQ0U20HgVDYgSv+Y+IjyxPUHK2IpT+qwMVk2QOFyoZ13XF2LrCmtvqXlne/9wWSGovT13DxH+7gtPw3RVz2e0qcrxclfzQuzY94edY+s2ld/1RG23wkXDjLRHXiuaqYpP2Jq8XF6x8lxL7TXi/T2cfWG/iAcqt0xsjimVDEzoHBO7wnl04+DSK2preqWum2yIi0kaq2P9jn68XtDCyvGIn5sfZ4SMYL8ccQHIocEZvFeg5Ggv/Ge/ijN8txmTpdJngWRps69CSjiIQr/+Ho16ejBwJw9ngkTTL+y2PUQA/IzZKsbYGVaEXbx5VXqwbSOc4DOeHO8vwqcJ7Bp80CEs9hd02AYwVmvnjCqGUDk2dR+Tu4DCX90MWrDN+saEnHiMQseGMV1b6fH2+vxJau4lLdkXqOA1rXoNdgtcf7qOV65JLm7bvODQNCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(52536014)(5660300002)(9686003)(53546011)(33656002)(71200400001)(38100700002)(38070700005)(7696005)(6506007)(86362001)(2906002)(7416002)(55016003)(966005)(478600001)(122000001)(26005)(8676002)(4326008)(316002)(6916009)(66946007)(76116006)(54906003)(8936002)(64756008)(83380400001)(66446008)(66476007)(66556008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ANJ4SNDlFZmSlgt6JRIwi+EO87dSwUdoPCZzPPXKyMndSt8NxDat3AGbJI8?=
 =?us-ascii?Q?8wYoHFxKV1xxufYwinfD9wdgz1mi76BywKzoujZ5twYpBuwqceXdOB1aPl/A?=
 =?us-ascii?Q?HgRytQvkRBrdgPz+rOVH3GITv0rsbl1tD1R7/xYw1P4N3ElPsGrJmbIF6Qvx?=
 =?us-ascii?Q?xrUo1JAzr4tEGOzyIPf6uCHmHL2TpKri8MI52KVGNmt8VptcOIIUBwHMx3Pb?=
 =?us-ascii?Q?BSLnnSPF0Hu05v21DHfjzf+iRSIOcJb1ALujo8meaaQvWOJhIYDlnClCkfGb?=
 =?us-ascii?Q?8mrwFehd7DoXkwYpbflbRo9XL+K0Lzkjx2JoL1gmiKpicdUOalXLDpv2w1KF?=
 =?us-ascii?Q?h0Mdgibxb9+LnXwca9KF6F/CRcjaE6P1gA60Q/29nb0X15Vaynww/fDSzpc5?=
 =?us-ascii?Q?cNaAgcU/a5n5IVUwwsOSp5XdXNoVw5f3JBy+SI5RdCb40akHTnhNW1kNo6ZT?=
 =?us-ascii?Q?GAvjp5SQ+4xF+Oe2/VF24AXevyfQdNsNcCs62Z7N8LoQ3SrjU6kmyEw5c61Y?=
 =?us-ascii?Q?LpPi52exdhcmNB9+PTrJnP0caT0CszpPaSPlhVFRNB1Qytj8gzofbbla3j4H?=
 =?us-ascii?Q?5HVTzEB7mnDab6YeVvzYC9dW8c7AQp1+K48plDh15JUqGCIs4gqF5wZHSbXT?=
 =?us-ascii?Q?jD88kk3259j3iihBoJyAmktoQK8N4VOD6nd7Cs/6SfrzUQMOGN/3tl02nOG/?=
 =?us-ascii?Q?phEgB4YPmJemoBvaCuuq+aRZpsVsYplCPzsNaQFdASNkpqrcWwvYU1wPxyc9?=
 =?us-ascii?Q?9nd+YWAHWbPCoskSN9NnOw5Q1OpDdu/8ezmhB8hvjD7SUtMIWZaDzJxWPc71?=
 =?us-ascii?Q?oKgQzCoExLAm9dTl1IX49G4O5xeWiOHImK5FocQbufoKJGBBr9qdrAx3QBuG?=
 =?us-ascii?Q?uRiJKAPTen/Rq98QpzWZsvKzdSgwjfoqBmgHll16v7vSTsFxsZXCbYhE5Z7f?=
 =?us-ascii?Q?jARCMHAiPy8lOjaVJUufN6s5Y/ISiQPafuKu4hFyTCVQXrhvpFVvpT0acSaE?=
 =?us-ascii?Q?6fqVh0dz9aog/J8rICJ3fwiM4x3zJcdW+kGlCyaxqqGxtwXYakBgap+3wMYa?=
 =?us-ascii?Q?lRDAIggeplPPSJpwfMevkAXRbPN8GVSnjmGsIqbDDveUNJYJci8RBMW1KrUR?=
 =?us-ascii?Q?44u2MlJlUI2jK1Ykgx2SZppP9whz4lyiuf8D3+rzBB8B/KtC8Zqai6fbbWJA?=
 =?us-ascii?Q?SuVkljOAFl5uc76ucuhzwghzROnusImVM38uUjMB6XmUKULF4NEiyOXUQjXr?=
 =?us-ascii?Q?+uLQ09snFe+GM21n8mbF4F7cIBBmLs87yum+8PYsq5qtOYQo6H58bun7YE53?=
 =?us-ascii?Q?ipKHmdrCv/iubL1N7pKq1TPkd3a3GblOf3soljqCH1sGbv5H2qz2kkhnGuXX?=
 =?us-ascii?Q?+yJrYXuWsdb341g2HapK7KrVuFLtUCdP8zRWgDp+s5RhgmHOVxae8c1XeJf8?=
 =?us-ascii?Q?+89EYhhTCHGQIG/IgaM8rWYkbjlNf4RVikFWxv4f0F+hdF/PUVkPd4Qhe1Zr?=
 =?us-ascii?Q?4AKYDMATsHnSkjiVkwU7TN3ZD+5suCqrEg5ilAmXlihsUVMz0wiJWnTAKzOI?=
 =?us-ascii?Q?Ub4nAGaeZABprHuiei0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5146e539-88f9-42f2-959f-08dbc4cf65e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 11:45:24.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/U8/Q9H6qxNRa1tkmG16HzBfhMC9zpC5AzU52m6UennfECiTjnmpbEYK5esAP+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, October 2, 2023 10:30 PM
> To: Mehta, Piyush <piyush.mehta@amd.com>
> Cc: gregkh@linuxfoundation.org; Simek, Michal <michal.simek@amd.com>;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> peter.chen@kernel.org; linus.walleij@linaro.org; paul@crapouillou.net;
> arnd@arndb.de; linux-usb@vger.kernel.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy bind=
ing
>=20
> On Fri, Sep 29, 2023 at 12:18:50PM +0530, Piyush Mehta wrote:
> > Create an ulpi-phy binding to read and write PHY registers with
> > explicit control of the address and data using the usb.VIEWPORT registe=
r.
> >
> > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > ---
> > This binding patch was created to support generic platforms. This
> > binding will be modified in accordance with patch [3/3] procedures.
> > One of the approch may be Create a zynq phy platform driver in
> > "driver/usb/phy" with driver source "phy-ulpi-zynq-usb.c" and then the
> > binding will be particular to the Xilinx/AMD zynq platform.
> >
> > This binding was built with the Zynq hardware design example in
> > consideration of as a generic platform. The viewport provide access
> > the Chipidea controller to interface with the ULPI PHY.
> > ---
> >  .../devicetree/bindings/usb/ulpi-phy.yaml     | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > new file mode 100644
> > index 000000000000..490b2f610129
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/ulpi-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ULPI PHY- Generic platform
> > +
> > +maintainers:
> > +  - Piyush Mehta <piyush.mehta@amd.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ulpi-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#phy-cells':
> > +    const: 0
> > +
> > +  external-drv-vbus:
> > +    description:
> > +      If present, configure ulpi-phy external supply to drive 5V on VB=
us.
> > +    type: boolean
> > +
> > +  view-port:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Address to read and write PHY registers with explicit control of
> > +      the address and data using the usb.VIEWPORT register.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - view-port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy0@e0002000 {
> > +        compatible =3D "ulpi-phy";
> > +        #phy-cells =3D <0x00>;
> > +        reg =3D <0xe0002000 0x1000>;
> > +        view-port =3D <0x170>;
>=20
> I don't understand. Do you have an MMIO address and the VIEWPORT address
> to the PHY? You need both?

Yes, we need both.=20

The ULPI Link wrapper passes-through packet data and interprets Rx commands=
 as well as send Tx
commands and provide viewport services to the software. The ULPI link wrapp=
er interfaces between
the port controller (a bus similar to UTMI+ that connects to the rest of th=
e controller and its registers)
and the ULPI interface.

Name XUSBPS_ULPIVIEW_OFFSET
Address 0x00000170

Description ULPI Viewport

The register provides indirect access to the ULPI PHY register set. Althoug=
h the core performs access
to the ULPI PHY register set, there may be extraordinary circumstances wher=
e software may need direct
access.

ULPI PHY Viewport
The ULPI viewport provides a mechanism for software to read and write PHY r=
egisters with explicit
control of the address and data using the usb.VIEWPORT register. An interru=
pt is generated when a
transaction is complete, including when the requested read data is availabl=
e.

>=20
> There's already a defined binding for ULPI bus:
>=20
> Documentation/devicetree/bindings/usb/ulpi.txt
>=20
> Why can't you use/expand that?
>=20
> Rob

We need your input to determine the best approach . We did preliminary rese=
arch and discovered few possibilities:

USB Node {
	.............
	ULPI PHY Node {  // child node
		.................
		compatible =3D "ulpi-phy-";
		#phy-cells =3D <0x00>;
		..............	=09
	};
};

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/phy/qcom%2Cusb-hs-phy.yaml#L100
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/usb/ci-hdrc-usb2.yaml#L338
https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/ci_hdrc_=
msm.c#L245
https://github.com/torvalds/linux/blob/master/drivers/phy/qualcomm/phy-qcom=
-usb-hs.c#L85
[This implementation is based on ulpi driver: https://github.com/torvalds/l=
inux/blob/master/drivers/phy/qualcomm/phy-qcom-usb-hs.c#L287C1-L287C19]=20

OR

https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/ci_hdrc_=
imx.c#L81
https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/ci_hdrc_=
imx.c#L176
https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/usbmisc_=
imx.c#L234
https://github.com/torvalds/linux/blob/master/drivers/usb/phy/phy-mxs-usb.c=
#L191
[This implementation is based on platform driver: https://github.com/torval=
ds/linux/blob/master/drivers/usb/phy/phy-mxs-usb.c#L848]

Note:
Above examples are to show the interface between the Chipidea Controller an=
d PHY.

Are these possibilities aligning with your inputs?

Regards,
Piyush Mehta
