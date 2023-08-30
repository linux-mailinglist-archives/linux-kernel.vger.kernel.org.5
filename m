Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3778D324
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjH3GGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjH3GGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:06:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98ADCE0;
        Tue, 29 Aug 2023 23:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSAscC2h/vJ/MHaDbkRxovPqYqulIsLq89jaFecE7697yHOEqAkW7gXzj28Hv3qJjodo9eAYcTiZyw51TzAB2+93EXFhmt/RUjQjNBOFZohSEUZvAo4kP8yf02Sa/t7yBkgudEBdwDwKpW1/KdGOUCluy6Byrt8cqNa1PHNjpbEaOjFlH+X8Qs+6oSS9Mox4Jz557YRKrF99MJBOeRCleozHiMPgdx2VtpPVyPW2oYzopvrF4hiYvk2aL7u+D62OxkRc4VchDWfTYoD2afC82NH+wCMss0ZTk8Cy0MfxPc2XIiPamf8pTZHX4zOqu9Sn3vDIKrHrs0yRGT2IoCVrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jdRkH40Wmi0x56X5Kx0Z/BhOpNUpHW0v+C8m3lZaNw=;
 b=fIsa1jGsSVBACuhPOhqy8tT2H1gzRH+nO/G1x5/KXuwiHzTwJBnb/GWMZpKeSqwl0cONuNz47CfYHLhj44KFT/C5UvmDDqM42xmzIXLsqDUC768ipFDjSxHrBsfs/03aUvSUVED6j7ybxIoDoNK+IWCCBQdkX7WHAgBVjVzr6uDPeKAE6y1GSrVP7eCscNdnAzkZ1BpAlpw62DXDDpvTavrXtYAXoGfjgKGiBKOcjuci+zI0gqr1p5w2YXlQqyIde4zZz4cuobKuU16Hqt6m+V630EnVhjXXvUwET03481vA8EVN6fCczCz81JZA+sLByMvR0R5AqjvXEex+2hlBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jdRkH40Wmi0x56X5Kx0Z/BhOpNUpHW0v+C8m3lZaNw=;
 b=lDHP+ziQBE9pjOlW+CStByOnA2azC787zxDX8DiwoJ/ekYanAPnyyDb9c4foPGWUxyUkV6Onga3iQW0VNE4ojbC8bZznKnOhqxznPltiYXlKPhEpwAsXTtvScyMVP8v8bYAiQ2s3pj/Xtlz9rolqnI2uvVnp3ixUoK5Hc85QcC0=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 06:06:19 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::3a16:8b71:150d:5e82]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::3a16:8b71:150d:5e82%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 06:06:18 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "appana.durga.rao@xilinx.com" <appana.durga.rao@xilinx.com>,
        "naga.sureshkumar.relli@xilinx.com" 
        <naga.sureshkumar.relli@xilinx.com>
Subject: RE: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Thread-Topic: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Thread-Index: AQHZ2cBiFgY83WJUzUyA4MeJwK/v66//2S+AgAKA3EA=
Date:   Wed, 30 Aug 2023 06:06:18 +0000
Message-ID: <PH8PR12MB6675C31C6D1DCD3281FE8A10E1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
 <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
 <20230828154309.GA604444-robh@kernel.org>
In-Reply-To: <20230828154309.GA604444-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|IA1PR12MB6116:EE_
x-ms-office365-filtering-correlation-id: 8171a4af-35ef-4728-e026-08dba91f39c8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nktevzhfNn042/vzbMGmF93RTXA+gunlsTTHtMUD/IyVuIeyv2C4Lxny0hgljEz3EVvuWGF8MHEyWZR5/3cEM44txwjiPPu4EjK8a15aI9suP5ZK63kyVuuQonx94+fwCDIq2hlJT9NntwqNPRUBABXQZe4HTesbiuLyHK7008iqmYZ77QW6L7tl9W9aeSKr7HTpHaO10NhDZNWA2TOdnn+MWFhkqj0EJ4l0HnAI+jY4k/9AH8ajaDWbv3g3NpuGWsr0HU43FfG2aI5arjXjUE1JYi71mjE0aNOBW4po0w82BIrNE7OsgSlIJMd6+InRJQK6CPdr1p72Wa9zLgOpebifE9I2TCW1g3FOCZ0NHwXAcqCdWgPhFSLkgGjHFWytrDfRE0ndXisr9iyVSSxl2CTICwvMlpc2FQm6/HiUYDLBkHes9kjntPT3KmRp1PTq6EitkeujsqT6fO8JqB8PoSB8IY7Zm7E6f4ANXTd/IaFB1HryZUPG+NFfgTM/0gzr3uilZ7N6KlzRiJQaeH6GleqJZmU7a+dMRtdKHFsyEkGuPglwYrBiwFNv6ucL5T3yAJKpNWPcr06JRYzTbSDf55G6qpzSVSeW6msA7xseBCo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199024)(1800799009)(186009)(9686003)(26005)(316002)(38100700002)(6916009)(38070700005)(41300700001)(4326008)(33656002)(7416002)(55016003)(2906002)(52536014)(86362001)(5660300002)(8676002)(83380400001)(8936002)(71200400001)(66446008)(7696005)(966005)(6506007)(64756008)(66476007)(54906003)(66556008)(76116006)(66946007)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1M0Ie0xntR7NpchwXJa+iXPOrWjo24LNZB5aUsZZ69485yZzZkpzClh5Enlu?=
 =?us-ascii?Q?kKVfrBi3JqYQqGZKmv5wNemZjmIFillpRCDE49CwfCxHHtDJfri8lLlvTGIR?=
 =?us-ascii?Q?gDsQnMKGClC/+E+0xUm85bHyneO6CeatC+zoCWxPI2k+ZUPVAoRtld4EKRRV?=
 =?us-ascii?Q?0m9YV5UBvQtm9R+kHkLeovClnv+fD0peQa7rOh7+ChrJVoh05e5salT5p++V?=
 =?us-ascii?Q?tDcIti/hlIgKA8LToYL7md4qt2te3q8UoRX7hjYaFP7xaWGfqQODinYoxsm4?=
 =?us-ascii?Q?tGkJBxif4zc+4dqEEge6diwuiH0HrfSaJEvGscdPc/t2qQwpyioQgZMm1aoL?=
 =?us-ascii?Q?114NcDfr+2rSYkctmgjlCw2zCbN6mynDBlVleq6eATG9KaL4TVR/+5ece0Ii?=
 =?us-ascii?Q?l1z8P1vtZ5q+fmzlppcr3gVH0Sb9Y75O6398zMaHc8riw2DnuN9OXFUWGQx/?=
 =?us-ascii?Q?uvaTqw15m68J34PcaSZCcyqLDhkJWEEUAkWmfAfkXTRzPS4o41in6crdbZJa?=
 =?us-ascii?Q?8raObcJSHzzvBgu9HmeLmqbUKOKObRUPkivM9lIg91yB8mpol1diTgRMFRtQ?=
 =?us-ascii?Q?Ik7nE9h16g3L+jrmUW+3GMgTrtOHj1qTNPUyi4J7nSA1GyET+KGBLzGGNVVe?=
 =?us-ascii?Q?NXfgogm6Kwe4BIk+Wf9+5JZ3ff288ivRI3dm3vs0rr2ZaYriA824GLlK5KE3?=
 =?us-ascii?Q?3w1fSXdV71c8VlTNgPsVrXvqRTiZNReNCtjElBGDNLrXf9pYdSxqo+CQFBHp?=
 =?us-ascii?Q?S4p4/jqjAxZXpakheMYOnBay4N5l+QqAJbJPHxqKioLi8B3i2QoEKZOzIJ9N?=
 =?us-ascii?Q?8TxSRb0GQ22lmS1X4g6QXFsgUFv7N3x54ZDRJm3uAhyq6NDojMAwA4Nutnbl?=
 =?us-ascii?Q?1mYD6ltTtkhU8Iz3+ApaT41TFtNiMwXx0owKFNmgSumc9pF6sXaUGV/hHSAf?=
 =?us-ascii?Q?SpzygmKYpmS1YRpRDLx3G6FNDiCtzsEayj1Z1XYOKRXXKMSzLDgN5a2VTHEv?=
 =?us-ascii?Q?2ALuWTn2v46tEx5dol+nuoLR4b0XPUDErrLaxRYgdzJ+y24/dGS+u5+M17Jg?=
 =?us-ascii?Q?tjIHzlEFLnnWfpwG6FjbqVgrTDNlkpRImNqJHrgST7iVNrZDdE4tKwhXb5bf?=
 =?us-ascii?Q?aNOcUd3iQvHTlc6YLNuUwaCnseYuDpLCUG4owuA1suyzcYlUP87KXTo/BM8H?=
 =?us-ascii?Q?4ciaCXk8VAoyKpaj6z26qT3WosHiy0HCGm/egZ3d4UNyDCkx/PggC91V4jib?=
 =?us-ascii?Q?cWbWDHvE64wJB6AWCMMR5DbDJJ0gEDkqPBdaD7opXhFqYZXn4gYB96kPmB4K?=
 =?us-ascii?Q?ZpmqwIip5wwzGPVA52BXl6kV2CV+0430BtLzskHDaL7xHAglcQ/7IVYPYVj9?=
 =?us-ascii?Q?AQiLvbVMpuMTHwG0y/HNePtIt5cQk4+nmhz8jR43hsvfoJeVv7IkUaUGlnV6?=
 =?us-ascii?Q?b+9E7KnsI2smxCCppD5HlEjzBuoZSg1uwfIyoE7/aNjuc9HdDmpnM7qcXTZS?=
 =?us-ascii?Q?2womVlid7WsGcNZFU3Z+eJjTioASuP158YYLcPjh8gYsvP86Ay+8jCpTt1tJ?=
 =?us-ascii?Q?r/tezVd6VGReBtKSatk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8171a4af-35ef-4728-e026-08dba91f39c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 06:06:18.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3P0CaKSEBO222bH1cctvlUWevWvS7/aYJfVVWgKm80yYJo21mk4AbEHFhEAQsFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>-----Original Message-----
>From: Rob Herring <robh@kernel.org>
>Sent: Monday, August 28, 2023 9:13 PM
>To: Goud, Srinivas <srinivas.goud@amd.com>
>Cc: wg@grandegger.com; mkl@pengutronix.de; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>p.zabel@pengutronix.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
><michal.simek@amd.com>; linux-can@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>netdev@vger.kernel.org; devicetree@vger.kernel.org;
>appana.durga.rao@xilinx.com; naga.sureshkumar.relli@xilinx.com
>Subject: Re: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
>'xlnx,has-ecc'
>
>On Mon, Aug 28, 2023 at 08:28:43PM +0530, Srinivas Goud wrote:
>> ECC feature added to Tx and Rx FIFOs for Xilinx AXI CAN Controller.
>> Part of this feature configuration and counter registers added in IP
>> for 1bit/2bit ECC errors.
>>
>> xlnx,has-ecc is optional property and added to Xilinx AXI CAN
>> Controller node if ECC block enabled in the HW
>>
>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>> ---
>> Changes in v3:
>> Update commit description
>>
>> Changes in v2:
>> None
>
>Doesn't apply, dependency?
This patch is created on top of below commit and this is part of the=20
linux-can-next/master and Linux torvalds GIT
https://lore.kernel.org/all/bfaed896cc51af02fe5f290675313ab4dcab0d33.168916=
4442.git.michal.simek@amd.com/

>
>>
>>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>> b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>> index 64d57c3..c842610 100644
>> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>> @@ -49,6 +49,10 @@ properties:
>>    resets:
>>      maxItems: 1
>>
>> +  xlnx,has-ecc:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: CAN Tx and Rx fifo ECC enable flag (AXI CAN)
>
>has ECC or enable ECC?
Will update description with "has ECC"

>
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -137,6 +141,7 @@ examples:
>>          interrupts =3D <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>>          tx-fifo-depth =3D <0x40>;
>>          rx-fifo-depth =3D <0x40>;
>> +        xlnx,has-ecc
>
>Obviously not tested.
Will fix it.

Thanks,
Srinivas
