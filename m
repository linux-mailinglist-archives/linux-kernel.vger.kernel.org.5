Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86CC786FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjHXNHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjHXNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:07:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA9CEE;
        Thu, 24 Aug 2023 06:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cigaZY9H6tZxRBhdnNruovlS1zaEGTWLRCJWrBn7P49KC514FBMnr2OSXaQUGOmGeNkvZYoTBRWv5C3AtlRSHnWZyhtQig+kNicCAzjHORahOaoM1inTVZlEafXZ868ub22g2zajZZPYEV1vkfknzDLfG1wWyCQ/vPTLdJUNEMjx6Kv4PmiMEIcQ/nnIRwqvzYEVmEx+d2YgX84LnSQ2tZ+LpUIlAgr0WJmW+I2+o7ISkI37r8R9KxB/TZLtQlLj7qgTKkkiCPbU6AXYpqPojTQ5884/UNsUYbp6DlLOhffn+TZUD7fl0khs6snsxK2TwCa+eeG6x/XuGn7QwDp3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYNoINVpE6KNcv50ps5D2LlvQuy2b+KPn4vBqujWlj4=;
 b=ORyXkI1UAltBmpkQkh73N4xheViKh8SFz+mLiQIwoRps3uLS2y/DTwUt5l7Q5r/fPai67eCZa51nwB/xn7sNnuVpig/OOduxnRTfxM6+dMkShwAY6hrJDPmxpQXQRbJ5cXgXvBDVVURyhFs4mxyygLGj9ntqRf08Q+nE6adTWhjT2naRws9osEfjVX92TxmNA+ZEymDp7WEP+pWmgTpw9xsE/2MgBTrShZGytt49gXw6Sd7zss2Tbh3Oa/Wo9wyXgP1OJlfXL/L+FbGRmaeOv1bd38nzXwKSmPaLrdWHmR6djEUaH4RFQoDx0CCisMO/6KgtknwQpe0CPDc/1uYhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYNoINVpE6KNcv50ps5D2LlvQuy2b+KPn4vBqujWlj4=;
 b=J+m5TucFb8htiXjtb5rRGjJYhC8K1+EpQTmENAFP63sql6hG7UhemiaK8bXsoBEmyR3fG+5Q/+iMBYpGANfmANZf/U2BaRUF5J3sMczvyk60MipsjyKyG7HigI0Px+6yksedvi7BGQe+c9pQdGCGKgIC2kwfq7wl2ty5b4nmcBRJY29ga3BmVpx/EZJFySJrixNGiu6labeNaN/h9lWsxC9BnT7lEC39oeXFt6zETnBTOVGqwgErqHU7iNFCa/GoYW3+CmUQClCSdt1RoLUz1uffa7cpG0O+XmNdizMyK/7rIKgXmJndm5L//WXWUnkg9P04J6VhRMHAkDSA8YcctQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:07:23 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:07:22 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the pinctrl tree
Thread-Topic: linux-next: Fixes tag needs some work in the pinctrl tree
Thread-Index: AQHZ1hIvdUCPBbe+lE+Y1Kt0RGC8U6/5a6tA
Date:   Thu, 24 Aug 2023 13:07:22 +0000
Message-ID: <CH2PR12MB389538DBE55D39F252CF2AF6D71DA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230824083550.49539f4b@canb.auug.org.au>
In-Reply-To: <20230824083550.49539f4b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB9256:EE_
x-ms-office365-filtering-correlation-id: 7d42fff2-3d24-41c2-e7ab-08dba4a30e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMCv5WKvH4tjMEDVfGcKkgvZQVz3WIPk6svGw/zoF5eODzzE8bNugy2g8YNoHXVHCbfvfLkW/NXH7w9qM3oCHdrlVLKurY8y50QEsmluwO7vOkfnQWuNqxIJ/n81cGm8ZI565RzSyi4dHXvksSQLv1dMHI2DTqKR4Engyvl/YF4+iQET7tIryzs+/z3I5ueU9NtlodJKsw+UrsHn9MArPR3lrD2GLB4T05YpmTHWQWYV5xIHTLl3N+GXOdi1cfZvM7FRRXDwKl77ERoGVWSA0hCZGxGSxs6cY1Djyh4uBwl7ijPM07PIDaz1eaxBmbu/jUn8MROVjRWhWanTG58eLFrusX1oS0rV9x0PbXdVHltYe3YmFoE9sjRsDvVPDKED5eyKqk4nkECeAtzZycI4DoBBVtJCCThi1U1aOgjhAkbD88ihJu4sIQC1S6MVeiuP2n32fgHFzVQjzu3ufrjQ5nAPmB755ysmOXMcKPOtj6peyCAXjJjnW55DI12I4EyVmOZWmQ+pQZpQL4I1EYozoN5xPG/gT0qTfJiNQLy1G+n8t6IlXS3rYqJFeEimD1F0fEU16PSbkkeZmK3x/pft8tvABn0yj/AiwjEVImThUdrWFG2BH1OLat0dIv7yTIO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(54906003)(66446008)(64756008)(66476007)(66946007)(66556008)(76116006)(316002)(122000001)(478600001)(110136005)(55016003)(26005)(38100700002)(38070700005)(71200400001)(41300700001)(86362001)(2906002)(6506007)(9686003)(7696005)(8676002)(8936002)(4326008)(52536014)(5660300002)(33656002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vuAgLFkVEzAX5YP/UkGF2jD6DaqD4u5gaPA7Vo1Lhtdh2l4NJyx22ixto8Y+?=
 =?us-ascii?Q?BQq+kkTfRLfeP1B3D5GMo/agopDvr+Jl1zBLnmOCxl9es3DACHlLhOKmMv/R?=
 =?us-ascii?Q?MecUAxcLSoKutR4l1GzbMdPqsxN2q+go9tqso06KiHuUEG89247cO/T5A9/x?=
 =?us-ascii?Q?IDA5aA/e8AFOOoZjWdb5SWuVmM/y7jmEOsntfqhtiyvEUHblhif3oiEBclVo?=
 =?us-ascii?Q?jg2layX/mre0qDiYEmbd8LyfRgNHlCDzOpWBkI4W1Ea0+5azam5jV+aZrkqS?=
 =?us-ascii?Q?OzN/YcKrSu9WzMEUUMiIww84BQZILweqPrnBIctelJSA2kx6WFX7ak3hs6vO?=
 =?us-ascii?Q?Wc1AzvnfdtQtcsS9rFcdZ4qhMuH6QmOuo0QCxyFbPhNHFv7jXXw7LQ7LVfQl?=
 =?us-ascii?Q?d4KrMZEvGtKvxcNICXeO3RaBjjs+q8uvkCVRBIh+Ykrg+hz7dA55IwuphTXt?=
 =?us-ascii?Q?Hv4pMJ0UxgwZeFSaDgCrCAwqPBkOR54u6KxqGAbl/WjzQ8tyIbsmwsYnWuKX?=
 =?us-ascii?Q?szkroDb3JGI8QX6lzc45tU5dsYwIOEc9V0+x0Na1dckhc/Y2VZPjePr2h2LP?=
 =?us-ascii?Q?+17xae/XR//hVLKRNxDTw/hfRSg7SLWMLTvLgH1KGsrpYdMif9AzVK0qrBFA?=
 =?us-ascii?Q?xxM6l3iq2AkB/86qyehdKgepT+cSJGbIMxkMZJoAm3Po4aAfwfBKBV2d1FsT?=
 =?us-ascii?Q?eqEoaOMqIrxpO1fQUY8Q04qjq7daMRcgmc9v7rWfxLByPJfnUiEnsFPFt/rK?=
 =?us-ascii?Q?BRLEyyyspVYkxEer1AHHTj3Sq5qIEOIloDX58uT3j/KVyrtZ74ORC3nEU74T?=
 =?us-ascii?Q?RnO79fqoZj9mfGP5osNNeL0Tid+9pOLTMfixzof2m+is03kwapEhgIXxSrw9?=
 =?us-ascii?Q?S22a9pxxXYW0jltkWLq0GTuTMeYlgMbZ8iXnYeBIxALGr4g/7EiOLTsummO/?=
 =?us-ascii?Q?V5stdWNMpV+ypc9J3qWMUmQMLAvZa3ahscm2vI9Pd0916v+I+akrXgyR/UQU?=
 =?us-ascii?Q?CVIqtVFjTBa8lhieQ1eEVgsrC/bocsBk7WWp8KJxn967ogcvqYfapde6LmLB?=
 =?us-ascii?Q?/gej2GrN8MP1Fc56XFyj80JFrwKlTASkGsZpiFWrWiOaKcItZQT3zgy7G3cd?=
 =?us-ascii?Q?vauYmTx7SOr9itY0iE3InBjuezzJleUmSpq/6u8NvgjXrMNC4Qux8jNwW+Fo?=
 =?us-ascii?Q?nruB87xIzXJLs75IcMp43Z+beuCj0bachRas9rGzJ1oRSuM5JZR7TTysCWzI?=
 =?us-ascii?Q?b23vB8Hkn4fYUSYNN6RTqv1w79yCG2N0a8OJDQfw8xIspe3bQnEVKFtctBv6?=
 =?us-ascii?Q?+NRD/AcuqIhxA3iAes02IcICaZxjYdzzQTDXo4XY0kW0ynRUsCuS2RpqEEN+?=
 =?us-ascii?Q?3Jo9UkfoUEhwoz1c91fgDfchoWGs5cVHeVSTl+8fcbjvPlfgdUTyyeJPgi03?=
 =?us-ascii?Q?RGfOetXcIMoZaw0qNc9XFOI69UXRgxvCdHfZq4ZtG/tgXxzo8tZInuaz7Smz?=
 =?us-ascii?Q?x86wdhl3uKw3T/YAVLxLxMsisvGStUcjP06xNsEn/NE0A3muxBj9fZalYEfl?=
 =?us-ascii?Q?CjknTJ9h1IWcE/LgKwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d42fff2-3d24-41c2-e7ab-08dba4a30e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 13:07:22.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ay6ZunCNZPUBZ+hIlkc6AgTMhi6eYno2BO+kQYZUMlK859SLTcH53+5U6ngHAwV8rlMnyqjqYQmWldQC2nYylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!

> Hi all,
>=20
> In commit
>=20
>   28042b2a1ec3 ("pinctrl: mlxbf3: Remove gpio_disable_free()")
>=20
> Fixes tag
>=20
>   Fixes: d11f932808d ("pinctrl: mlxbf3: Add pinctrl driver support")
>=20
> has these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
>=20
> --
> Cheers,
> Stephen Rothwell
