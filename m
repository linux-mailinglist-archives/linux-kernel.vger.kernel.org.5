Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E944800B6E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378932AbjLANHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378927AbjLANHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:07:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1410D0;
        Fri,  1 Dec 2023 05:07:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLfgnceAAUfQ+j/77/2BP/PkA2XZtY1VE5eRv+WgdcGYstOywK4WAQSx3xlZA2xe2954Uommwgt79oa/17FKFbZsOzRFHj8sVBSVgfTP+eN9NZvfXw63LVRDNPLTngE/gy8ljqXpalsOsOZO/T/juFryiy3T0Yvg4q2UPWkvTP5Uk+xbnofyN3j+dykoCLG7JrB2mdfhuvbtdHp60M4joNbYAXn/LCO19JfvEWP6p1/6sXaZNKki9eqGmbbdVgen1guMRYwwxDbaL55OgU8fXClIJHSqujMpA4/UE1D7KZDZrHwr1Zmia0z39bdRS/oYyr4FgVTUunfW57NQMrtaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuZplxttR0QSwdP57RamGYFk9+1LkWZFeCCHlUUx8OM=;
 b=Oid0qqE7Zyk7IqR9AJhMpTlgbPvNBvY9LaICqEvOfizW646RIrOUCrpSiXifsjlR5IkBe9kz5/QDp7mRsT+Uvz5czCAnOnOl/UvuDWb0tl9a2Pn65qjlKUFuUrVMKIgacyFU2nxMfgi40MzVxCDALX5xdQ9cBXhuSQhiaM42O7iznwGV+lz+4dqoBbcr3OKC+eSqDVqCiSEUtyUh6d4Q8Zwz3lPx0IreBxLnl9bJC7wVXuyErkyOrE30BNV8+aNsSzm95jbzZbCtXhimt62ZMtJn4fmXtQPZg2ZX+pauUXC5OKdEeUyA1dEzM7O8e1AWOdOUQtCqNbOqUmKD0fRDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuZplxttR0QSwdP57RamGYFk9+1LkWZFeCCHlUUx8OM=;
 b=BhlScL+L19P+Er10yvuoqFcpacsv+M/aBDsmN2yztgEEl+/RzMZKp1kInqcKAmlDszftThMLRkIl9Yua3W7A/e/OLiMOip0UsA2gl0ZZV1qpYuINOR6kxw3qKY+Kf64rkfPuCoGk5C5Sbx91XMSdvgM+RIDWhpCeM2V5RNHU/kg=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:07:41 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::6f1a:10d7:a72e:4e1c]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::6f1a:10d7:a72e:4e1c%7]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 13:07:41 +0000
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
Thread-Index: AQHZ8qEa5JeYHGbt0EyV+BYDViGoorA2vp2AgAC7O0CAXU0AsA==
Date:   Fri, 1 Dec 2023 13:07:41 +0000
Message-ID: <MN2PR12MB433371247554DD8EB8ECD6498881A@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20230929064852.16642-1-piyush.mehta@amd.com>
 <20230929064852.16642-2-piyush.mehta@amd.com>
 <20231002170025.GA1928031-robh@kernel.org>
 <MN2PR12MB433326B66D9037CD0462BD2088CBA@MN2PR12MB4333.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB433326B66D9037CD0462BD2088CBA@MN2PR12MB4333.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|DS0PR12MB7727:EE_
x-ms-office365-filtering-correlation-id: 651dab69-426d-47e4-679f-08dbf26e8075
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtoMGvlMw3/1I3FjZ4N52jq9eL5j2TfPMAnefrQs1H7dk3xV7SidYMI5rjS5DWkI75FRa8AqB1iic7Ez5xGk7Gs8/H3qz30SgzeciXonT1lKGwQmRU6HXvrK0z1IiB53FZ/rGMfr0JKc4VFYOAsMNkMLPCt67EhccEICDGal6eHqMoIo+K7rSIwVkapNrJwF/dioOkENnrmGUP5HTypdYnYXWGInQcRvJL8GInpQ2U7imtiKxOdv200h8jKA4l3QGXq/k51pBLBe8khwwFikfInSJHtO8ofcveCaTnYh5L4R1RqinOUF8fB0VSECQa7M6WLjnQkJqz+vL74T5IbHpqN9igMl5dhk6IX2pUQy60pKM/Uud2WWfGVPATmVMaIgjqwo59hLnROw/fjUSp49ro3N/fbOMcbqmPzDBMBGJi+Zjc8uwbpKHJY1jsNeVyB+jA8zA/osekLwQt50osMckxyIILpkNQUwR+iICzn+X6HnR6He1G99gWniF2XCKPi2wX4RYXqy7fE63GvHKeO+5o0JbjAil5KytUNy7RNt6IRCfWh3PBU17/SZW6aiPVQktRrGE/+ucvXz8VqlsW0ez53lpYPLHtUg/vuIWYYov4LGIgUqCNA8McOfrDUomvdr43FEpDaLQAB9jxQeuE+rlkRxx/9nFcMfvqq/9+NNzpIqhkxP4p8q8HvZDaXOQZE/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(2906002)(4326008)(52536014)(8676002)(8936002)(55016003)(26005)(316002)(41300700001)(54906003)(76116006)(66476007)(64756008)(66556008)(66446008)(6916009)(66946007)(5660300002)(7416002)(9686003)(53546011)(6506007)(7696005)(83380400001)(38100700002)(122000001)(86362001)(33656002)(966005)(71200400001)(478600001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bMVxo1GF3hetaLdQWQpNHm5ElD4CJKZU0WUjzgAayvIX1KQXx+ZEqaROinxV?=
 =?us-ascii?Q?DOd+rs5EoFEYY03GsRfg01GNL3PNO4JQ3mMZkZU1y+qmVXgCvhn/UtZ6b4jF?=
 =?us-ascii?Q?aJeXQU4O1owLC37gpp0ZHYYIKDE/QuCch+S7fpmprlvzLDCv4MySsrl8A/0+?=
 =?us-ascii?Q?udDsDPJQl3hyswetOR11usSWb8V9VdMunNO4BuotXO3dL/E1Z3/vycGdDpUg?=
 =?us-ascii?Q?wwpTiLH9ngKae2bMrUyY4WXdI2CzmQvRUyhTuWKiTLGBfUYtr83PcQy0/YH1?=
 =?us-ascii?Q?V0yUn4qT8sAccM3hW5XjRfpSLgdw5yYnVLOnEJnKPTC/4la09cP/uH1B/jXb?=
 =?us-ascii?Q?CdXasb5nySW/pSeB/TYUcE5UpzxjARZ9QVn17b6b3k5nq/7SaVoIMAydMpdz?=
 =?us-ascii?Q?qei4cZSEc8ruWvBgk5hb9f3BafUxIfkFWSDYUEhRV3rijGG5YHivWZhGuq4l?=
 =?us-ascii?Q?DLdzD/LMjdKMIUJCoKz8cHJ/kdeP+M1hOuA4p9rcKXywSDBEW+1XPsSxzFb5?=
 =?us-ascii?Q?/oWI/DoCMDG+APe/EJJK0XO3derqUVW3ka05otchmJL/1pRyQEeXB+TeseY4?=
 =?us-ascii?Q?HoVQxasXGYzv+F8A71AmazolgR3+LDhAO8/TXTA41gtgampx34gHw/eJgQSm?=
 =?us-ascii?Q?+Lxi+gyNgtbIVFWlhNm/DWhtLIy8tTlMIbhaMsb5OxeGnu9sY/qPUtRYFyq/?=
 =?us-ascii?Q?KkEp6fbEqF8CEszmhmzXLBONqISC3E5MTH9ppycLCAQEL8dbBGD5i5rkrWvR?=
 =?us-ascii?Q?Ce4XwB6mfmMme9OUQvcE51eGd3RQB8jVCOqArlpxsJ+3GEpCPaWZ7JIEp9fd?=
 =?us-ascii?Q?QyWbsMN/G4q4z2A9pKpTUSkJQm1v7L21+k+1DUUGVTUj7P6O+POK83Ym+gmd?=
 =?us-ascii?Q?0/CdQ1UiBnZF02HrK42CF7Zdo1ddtnHHnLHNmPWHt4SefiTJObYyHd0y3Q4b?=
 =?us-ascii?Q?NzykNxAr4v65tp5O1ZjxSwLcxK5i3XtkvswmRrU6spjXzvw5kCO2eHM4ObKl?=
 =?us-ascii?Q?dq/1A2Q3WPznkDwzBNtKl4qaI2DKkADecbK9ANg/YXhLD5eyXaCSpnrWIUtu?=
 =?us-ascii?Q?oaULpUrLg2uxTae/Nu7KsNi0+O6aqmiAXrtG8UY10OAuef2PQZzsbafCfVWn?=
 =?us-ascii?Q?uXGmO38DkxefB6LY3yLaHB2CVWKfRNtBgcNh+t91f2UNyAYnB2LMeZKfqH98?=
 =?us-ascii?Q?zBLTGl920vlRzgEC8tJZXd137hxqQjEohiOHDkgAtgagS4h0ZgkOaga5/q7V?=
 =?us-ascii?Q?+9wbfXlJ+YBo9kNqbDuYsU6C7Cm8hl+8xbepPlQLeSwmaMOaNgqovOhcFnIP?=
 =?us-ascii?Q?Vyub7c+uWVUarZzyCrM/x9P5QFb2uBFefjM08XhuZwJJeCdSMpVSNi0qpkly?=
 =?us-ascii?Q?uI353PJJyif9yF5+MLScof3szzMis8czakumI1UUvJPz2xFqw9YMkf5haBhj?=
 =?us-ascii?Q?bBwSdqJ0dHfRSU3XxJNJBEvPiUy/WWnfGAPhKfsRveAe3Mm+QK99SHVCwlfF?=
 =?us-ascii?Q?SNxGvxLwePl7Xinu3v6YHmbcf15LpFieQWsAegkPoHu+9tSo2GD88I42ICaJ?=
 =?us-ascii?Q?RTzA0rMF0Sf3fo2g8kw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651dab69-426d-47e4-679f-08dbf26e8075
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 13:07:41.8272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzoEiWx9fnpFS4K3Iu4Fu0SArB659O2Hsy0zhXDbH3njjpsIDH/1njzPpgRuWHeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Mehta, Piyush
> Sent: Wednesday, October 4, 2023 5:15 PM
> To: Rob Herring <robh@kernel.org>
> Cc: gregkh@linuxfoundation.org; Simek, Michal <michal.simek@amd.com>;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> peter.chen@kernel.org; linus.walleij@linaro.org; paul@crapouillou.net;
> arnd@arndb.de; linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: RE: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy bind=
ing
>=20
> Hi All,
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, October 2, 2023 10:30 PM
> > To: Mehta, Piyush <piyush.mehta@amd.com>
> > Cc: gregkh@linuxfoundation.org; Simek, Michal <michal.simek@amd.com>;
> > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> > peter.chen@kernel.org; linus.walleij@linaro.org; paul@crapouillou.net;
> > arnd@arndb.de; linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > linux- kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy
> > binding
> >
> > On Fri, Sep 29, 2023 at 12:18:50PM +0530, Piyush Mehta wrote:
> > > Create an ulpi-phy binding to read and write PHY registers with
> > > explicit control of the address and data using the usb.VIEWPORT regis=
ter.
> > >
> > > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > > ---
> > > This binding patch was created to support generic platforms. This
> > > binding will be modified in accordance with patch [3/3] procedures.
> > > One of the approch may be Create a zynq phy platform driver in
> > > "driver/usb/phy" with driver source "phy-ulpi-zynq-usb.c" and then
> > > the binding will be particular to the Xilinx/AMD zynq platform.
> > >
> > > This binding was built with the Zynq hardware design example in
> > > consideration of as a generic platform. The viewport provide access
> > > the Chipidea controller to interface with the ULPI PHY.
> > > ---
> > >  .../devicetree/bindings/usb/ulpi-phy.yaml     | 48 +++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > > b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > > new file mode 100644
> > > index 000000000000..490b2f610129
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/ulpi-phy.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ULPI PHY- Generic platform
> > > +
> > > +maintainers:
> > > +  - Piyush Mehta <piyush.mehta@amd.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ulpi-phy
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#phy-cells':
> > > +    const: 0
> > > +
> > > +  external-drv-vbus:
> > > +    description:
> > > +      If present, configure ulpi-phy external supply to drive 5V on =
VBus.
> > > +    type: boolean
> > > +
> > > +  view-port:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      Address to read and write PHY registers with explicit control =
of
> > > +      the address and data using the usb.VIEWPORT register.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - view-port
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    phy0@e0002000 {
> > > +        compatible =3D "ulpi-phy";
> > > +        #phy-cells =3D <0x00>;
> > > +        reg =3D <0xe0002000 0x1000>;
> > > +        view-port =3D <0x170>;
> >
> > I don't understand. Do you have an MMIO address and the VIEWPORT
> > address to the PHY? You need both?
>=20
> Yes, we need both.
>=20
> The ULPI Link wrapper passes-through packet data and interprets Rx
> commands as well as send Tx commands and provide viewport services to the
> software. The ULPI link wrapper interfaces between the port controller (a=
 bus
> similar to UTMI+ that connects to the rest of the controller and its regi=
sters)
> and the ULPI interface.
>=20
> Name XUSBPS_ULPIVIEW_OFFSET
> Address 0x00000170
>=20
> Description ULPI Viewport
>=20
> The register provides indirect access to the ULPI PHY register set. Altho=
ugh the
> core performs access to the ULPI PHY register set, there may be extraordi=
nary
> circumstances where software may need direct access.
>=20
> ULPI PHY Viewport
> The ULPI viewport provides a mechanism for software to read and write PHY
> registers with explicit control of the address and data using the usb.VIE=
WPORT
> register. An interrupt is generated when a transaction is complete, inclu=
ding
> when the requested read data is available.
>=20
> >
> > There's already a defined binding for ULPI bus:
> >
> > Documentation/devicetree/bindings/usb/ulpi.txt
> >
> > Why can't you use/expand that?
> >
> > Rob
>=20
> We need your input to determine the best approach . We did preliminary
> research and discovered few possibilities:
>=20
> USB Node {
> 	.............
> 	ULPI PHY Node {  // child node
> 		.................
> 		compatible =3D "ulpi-phy-";
> 		#phy-cells =3D <0x00>;
> 		..............
> 	};
> };
>=20
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/b
> indings/phy/qcom%2Cusb-hs-phy.yaml#L100
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/b
> indings/usb/ci-hdrc-usb2.yaml#L338
> https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/ci_hdr=
c
> _msm.c#L245
> https://github.com/torvalds/linux/blob/master/drivers/phy/qualcomm/phy-
> qcom-usb-hs.c#L85
> [This implementation is based on ulpi driver:
> https://github.com/torvalds/linux/blob/master/drivers/phy/qualcomm/phy-
> qcom-usb-hs.c#L287C1-L287C19]
>=20
> OR
>=20
> https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/ci_hdr=
c
> _imx.c#L81
> https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/ci_hdr=
c
> _imx.c#L176
> https://github.com/torvalds/linux/blob/master/drivers/usb/chipidea/usbmis
> c_imx.c#L234
> https://github.com/torvalds/linux/blob/master/drivers/usb/phy/phy-mxs-
> usb.c#L191
> [This implementation is based on platform driver:
> https://github.com/torvalds/linux/blob/master/drivers/usb/phy/phy-mxs-
> usb.c#L848]
>=20
> Note:
> Above examples are to show the interface between the Chipidea Controller
> and PHY.
>=20
> Are these possibilities aligning with your inputs?
>=20
Please share your inputs on the above alternate design approaches.

> Regards,
> Piyush Mehta

BR,
PM


