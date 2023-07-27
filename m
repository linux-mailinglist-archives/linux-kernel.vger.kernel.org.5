Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97368764976
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjG0Hzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjG0Hz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:55:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F05FCB;
        Thu, 27 Jul 2023 00:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQl0lOwQ6963kVk3mER2gf4ejDEE515HtGS1/0Ki5aYrg/H7mOduIfFSVN1AMi0KIEA70BUFU5V3BUFfdF3XO6LqM6/UTclJ3nQrpTjmJhbB058/oeeQyG+OemO5UDxFuvKlRe4lPFx/5Kbl4vjUAFLpNTOBMptXDg0Ex+i3GfT/lWRL26wUiTJnZt4KQLLwIZwIRzKXZp3IjkMyaMNGQKthaSdieuYoDHZlS9nOyysQBEdXbC1nLrs2ZRbzlkGne7l05+YcidP4L/u2kU6VYXLWc10QWryzRgs8NTtaXH3gAnVHkPayypwZtXO3KRLZvrDv4ppGXBGY5VMjypGsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anocTTaWc3N8vP7CPPkes2npWiFkcPgsQSr8jHWCaKQ=;
 b=EXdq477gInQ4bxj2K4bR0O0lSnjrWEi8MIhZzU26rR8cScpZKcXxgQYahLAu3Et7TudhCCxVHIbXxXcK8QP43IHKNd9pRqaXBi69Wub7Zo1HrQIcpBiVrnZDTjpcG/tDWsa8v3D+RtX5lZIgJ+32hMg4uuMnFjZQ/wY/CgGDI6sI7WAKN/El83vBPEtkhFzFd6gKre2E1rRo9H4AFSG9/mBCDQV5ovHtPK68PLw6kaVMbORY74TTKnvrXk3R4d+Xd7BL4/r8foXJWnU10JqBCk0o5yYC8I3WJKHkWoen9FniuCrrvzIeGADJh+xtZlYjR46khHQ64XGtbvTPj4IU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anocTTaWc3N8vP7CPPkes2npWiFkcPgsQSr8jHWCaKQ=;
 b=NukWZoGlfOP8IEY/xkhJQ3A7zuHeon3S2/YpMxQWfGWshSQcxnI5hkbennahiJrZUXPl6r0cjQoVquS9+AKqx0xYgndkH1xQtGglbleWKwY6muRj16zOnVyo2RfpdDR2SIDu8jh+p2lIXhWz6bBo46Oo9KYUJYfyjDuzkiqskiQ=
Received: from BN8PR12MB2852.namprd12.prod.outlook.com (2603:10b6:408:9a::14)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:51:10 +0000
Received: from BN8PR12MB2852.namprd12.prod.outlook.com
 ([fe80::c371:256e:45d1:a680]) by BN8PR12MB2852.namprd12.prod.outlook.com
 ([fe80::c371:256e:45d1:a680%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:51:09 +0000
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
Thread-Index: AQHZugjScH8iKU5N9kWTSvwBM7ERX6/BZ8YAgAd/OlCABGBVUA==
Date:   Thu, 27 Jul 2023 07:51:09 +0000
Message-ID: <BN8PR12MB285265974F825587DFAD1748F701A@BN8PR12MB2852.namprd12.prod.outlook.com>
References: <20230719061808.30967-1-pranavi.somisetty@amd.com>
 <20230719182206.GA537052-robh@kernel.org>
 <BN8PR12MB2852E09191C6AB6DBF7EF33AF702A@BN8PR12MB2852.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB2852E09191C6AB6DBF7EF33AF702A@BN8PR12MB2852.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB2852:EE_|LV8PR12MB9232:EE_
x-ms-office365-filtering-correlation-id: b85615cd-ba07-4528-be0d-08db8e763de4
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSo1iAEjA7YmKPLiC12+6nA/QHSJXpJISo1/o/1M+QMZ9txtTcFmQOAnLweWqHNIYg6B4MTgxSmIdMhYlo83KqgMsdx7vNT9Ikz/L8XJPVPhyNVJ+l4vG2jkgfDJSN2OrtVLh18IO/Bp8Q84kLxGGpz3Gnz2YeDsSQ6JJ6ybZecmtpdL2b9Ol1DLrhONvs/Ci1Dh943q336moVxRN7CMh81Av+kncXz8Ehx6y1D8E6+xsTNmarYJ78rQZDTlxcsn71Bk8vbWr9fGeOdk5TNQZ4up9bAVW5BETZxLUtCe3yuWfSHga8v6rQiNw2FUdu6V1xcC0onr2FJl4UFiTpZn0f3T1HLwFZVjj0wkrleqMWpywHxWCsXnDcufJqFA0oAxl+hf3lHuSu3xFN2VRAoJ2sACkSs4O5MQ8CARVLqYZu4n5UbshAz6RRtqcnFKfrm7KhMg7lVbCn6HjqK29EzUYIAx5s1qDBTaPZxWPnHyLWxeKQM6B71T74pBrUD7RKSTFL/FXUNMrxCfdAY4f98TJ1jwUQiOzYoCTn1a9NbJfI49JkBu9LUMytp6tSWtF0CkTJBKVUERQ1BanBnmbBpTUFjF12MATcQcRKrzIY5dyakEp5g4NO9jT33kybYoaxj/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2852.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(8676002)(7416002)(8936002)(52536014)(5660300002)(41300700001)(316002)(6916009)(4326008)(2906002)(54906003)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(71200400001)(7696005)(53546011)(9686003)(186003)(478600001)(6506007)(86362001)(55016003)(38070700005)(83380400001)(38100700002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bXfliAjmzDwYMNLAP1k+9LDp5Ac3xYiFYUloYE/WiXTlET0Zb30U/m5IAAht?=
 =?us-ascii?Q?I/6uYcWyUzadSQwfjEOtu0nMu8P5IAxXLH+9YzbpNYB4KMiFedkI8F5hvPUC?=
 =?us-ascii?Q?QH7gXnC3jbU5gYGnW2cZc3Pq0YBDfcbf2YLOWvx6y93Sg7ojBHoX/g9a/FBE?=
 =?us-ascii?Q?zFVLuI5WlXpb8Gp0LVCX2fJI2xF7FzU3bj8ROvcCycjglN+1aAvKE7kSIa3I?=
 =?us-ascii?Q?A6d6sSqnsZFolO3aEARdD2XSH4FjLiijehSs/L0R6fdGZB+/IXzW/Pu1bk+I?=
 =?us-ascii?Q?X7a4An02JAaURCULeE2aA/9vIMNNdrh5B8T31x61mQefA6fUHlzNeG0vDOI3?=
 =?us-ascii?Q?0U4edbHe6UyhTi9MzMQlLWch4KnKp9AA0EvN563qk915Mp6yMks7qbbSvwjk?=
 =?us-ascii?Q?25aF5e8iOS0PDpF3NoXM9PeJOnzxMG9jSLzPTXTdl6LbN7Ap9AcA9Aw5cm4f?=
 =?us-ascii?Q?sXnCotQ79+/oMG8w98f9pGt9eM7sfU7s/8hEnZ4vZC2b8be0SeelI7B9AiuG?=
 =?us-ascii?Q?VFddqavUPaIWvw/0eCtlbMoP4uuwiai0wy7SiXKvHw5c6NXzdYzdOJKuMogx?=
 =?us-ascii?Q?8J3MqnEDGXslj4xJdyP6T6Y2gmuLT4JjSylboKRyT4r90txWBinT/tULVhi/?=
 =?us-ascii?Q?gbydmu3qBkmSXf3Oqr+vM4xFaDLGcBRLUat/9sE9EG8ZKVrXlJ0CrRAtO1b3?=
 =?us-ascii?Q?z/aAiRv+M9L0tZpkh5JoTJFr4Eyd1gsR0qjlmQ/FRI0KIvM/3f9Hv14BeIio?=
 =?us-ascii?Q?h8o9RlmWUvBzHCFy6Siq51tQRrZn9Aiv9HgEndwC0X2bWk7pqUEZM5VCsaI2?=
 =?us-ascii?Q?xbrgBTN5VQlwj+j3Y3iebRP+HUsQXj/S4BYO2gJB/553oteaZtLCQhtkUqYl?=
 =?us-ascii?Q?QNy0pfmGQW5MGbc1gn3WAW3vhtF1btfDWhbOAZI3U2X+91wPMEHJPfxgeEDJ?=
 =?us-ascii?Q?axfvJ8G4d0BIjzlnzCf3eo+ShD+8WM8Ckicc9hUmq0iwVYTZetLPe9MPIo0W?=
 =?us-ascii?Q?ReSl8FNBkWNFvfONlM153wY1IApVPU66E1G6CovLNClyAp/oSwMRhsXbZKjH?=
 =?us-ascii?Q?NfpJBKPFw7Wh7xCgZv8C1cw5XLwSY9hXrVfP35mONh4qNN/1sO1oUPrFwrvv?=
 =?us-ascii?Q?vLWXJtyww+CRo6feuhOfzx5sFhfC3SmSnpUPx2bcYe3cZAUyMtOgK/WW7G4F?=
 =?us-ascii?Q?FwcTuIpkbgBysdFJYt1xqoOtVs/VKBFBdG2QcdhJjOzh/BWVQP2Z3ZPLRSu9?=
 =?us-ascii?Q?d5xJqlnVvFGgsjJtZMkVg9GHJ4gxKwFUzIWNY62KzXwNR32waF90pXdMq6Fh?=
 =?us-ascii?Q?6CGtCXXBSoSfGeksY4ahkYsykq/3QCtGtOFFcXCZK0y8KPiqncpMuJXaoz3Z?=
 =?us-ascii?Q?/d6eB1Pucuo7LzfJpCFYHvxf2uLPadLQGPnUmPVg7LU9LxbPxNgxgRH/lfqe?=
 =?us-ascii?Q?R3xNSeTK0CTatP8rKTPLb6+mlQVxDbez81Bxk2h2CUGRi6J/u+dxwMPz0zwm?=
 =?us-ascii?Q?KCk74KEqvCzgWHAfoDG4e2EXaUuL3bE4itWUGsHsANuxzK0ib8nRAqCP5ac0?=
 =?us-ascii?Q?L8fUTTX4+s7DkKOOZ4I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2852.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85615cd-ba07-4528-be0d-08db8e763de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 07:51:09.8376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGI2KnQxkEodLXT3OL6S1D4j1qAYK03B+gUWFi7WWLLKxBwzAGlzsHbKLXDDHdz1/3WG3xjqWaT8yLGyWXY9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Somisetty, Pranavi <pranavi.somisetty@amd.com>
> Sent: Monday, July 24, 2023 6:47 PM
> To: Rob Herring <robh@kernel.org>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Katakam, Harini <harini.katakam@amd.com>;
> git (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to j=
son
> schema
>=20
>=20
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, July 19, 2023 11:52 PM
> > To: Somisetty, Pranavi <pranavi.somisetty@amd.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Katakam, Harini <harini.katakam@amd.com>;
> git
> > (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert
> > to json schema
> >
<snip>

> > > +
> > > +  phy-handle:
> > > +    $ref: ethernet-controller.yaml#/properties/phy-handle
> >
> > Don't reference individual properties like this. Instead add a $ref at
> > the top level to just "ethernet-controller.yaml#". Since this is the
> > only property you want from there, put a 'phy-handle: true' here and
> > use additionalProperties instead of unevaluatedProperties below.
> >
>=20
> Adding a top level $ref to ethernet-controller, implies, DT for gmii2rgmi=
i,
> follows the schema in ethernet-controller.yaml. This is incorrect since
> gmii2rgmii IP isn't an ethernet controller.
> I'm not sure how to reference ethernet-controller.yaml from this schema.
> Would it be okay to add a description to the phy-handle property instead =
of
> referencing the description in ethernet-controller.yaml?
>=20
> Regards
> Pranavi

Just FYI, when I add a $ref pointing to ethernet-controller.yaml, this is t=
he error I'm seeing: Documentation/devicetree/bindings/net/xlnx,gmii-to-rgm=
ii.example.dtb: gmiitorgmii@8: $nodename:0: 'gmiitorgmii@8' does not match =
'^ethernet(@.*)?$'

Regards,
Pranavi
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - phy-handle
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    mdio {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +        phy: ethernet-phy@0 {
> > > +            reg =3D <0>;
> > > +        };
> > > +        gmiitorgmii@8 {
> > > +            compatible =3D "xlnx,gmii-to-rgmii-1.0";
> > > +            reg =3D <8>;
> > > +            phy-handle =3D <&phy>;
> > > +        };
> > > +    };
> > > --
> > > 2.36.1
> > >

