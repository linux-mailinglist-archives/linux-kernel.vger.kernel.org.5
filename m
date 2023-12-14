Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A56812BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjLNJ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjLNJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:29:26 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599FB7;
        Thu, 14 Dec 2023 01:29:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCwSGGlqmYlDtOxPaPx4rU8qdzMQZX7seIcAUca5CNTEIvrf76bAiMIh13WbbLujLmPdPixF20akDuQf7vuTIi20TnF2lt/31KFpQq957Er91qsPBDhtNV7jK0LG9F6vVxq2loksRN8jG+pk8SjedlrU7BItbpCN0YaaugnW1ueuUPgF9CTJtiDR6mIjw60gp7NOPbLuWzsAaaNT97zHsyTD9A+Ch2TOmW0Mi1vO8IlBnt+1kwg/By65xMLJGu8Ck5yuBWoYaftAg+GDipgVAp7w/G/Xn+eXKzqvWbUB4sbwmWOVvq2emkK8UmoLZqFNxAEh2LuBz9tVhBlfGxIUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3C9NM7j9NrLEN1Iz31KfrlYOa/iyN8z0lEJ+6QjxnA=;
 b=Dz83DP+Eo0U0HAfrJbWQMeUmh2+zN+BmTLr8RYzxxJBnzLLdEtWh13Q7dz6liC7hPmxJVTfW9cQQWHMYcDL1aogJdttxtOBX/vdyVMchfA7TnMvsF6rztBbP2dKAPmFvS55uBmtFtTZRi3IgtQkkrfIaXu1oFO6CyRA7F1p+R6i0SNcBDsfXj38nN4QsdnpZj4/NDNabUFIaHmwH3YH5SSuhD7koNR7eEx0KU3eYlG0zNb6jwPOf4HOJxQbpYxNICZkMxhbwfqR/npMZhIyKO7bgXep9bfLZNfesiMSGnBMzXTezKEbRNx9ADrQ4Km8+xhwrIoEvRQmG5lpAj/vXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3C9NM7j9NrLEN1Iz31KfrlYOa/iyN8z0lEJ+6QjxnA=;
 b=mOSj2KQ1fPiSxbXQR/0DPF9tr2oVhy0XOugoj1cCO7p9Vdb44jvE+T1lsL5BnEWx5FWbhp9xfad4Fp63bh75FLJDLCKihmByjBpQsKzWi5dmd7XkD3SvkPRrKjE1RGIU7tIsBcx+CtUZgO4rxSLfz+D5BJ7oqNK830dB1rIr4kE=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB12070.jpnprd01.prod.outlook.com
 (2603:1096:400:3db::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Thu, 14 Dec
 2023 09:29:29 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7113.008; Thu, 14 Dec 2023
 09:29:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "benjamin.berg@intel.com" <benjamin.berg@intel.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "miriam.rachel.korenblit@intel.com" 
        <miriam.rachel.korenblit@intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Topic: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Index: Adot078PtDDEl6shQJysZ7bF7F4DCQAm7U9A
Date:   Thu, 14 Dec 2023 09:29:28 +0000
Message-ID: <TYCPR01MB11269A0200358724E126E7ECD868CA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <TYCPR01MB11269DD29E89EF09A4B053C1C868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11269DD29E89EF09A4B053C1C868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB12070:EE_
x-ms-office365-filtering-correlation-id: ec66281d-df7c-435e-419b-08dbfc872bd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HLxJRA/2sxFVEIMYSgmwH+P4lgLYtxjgWztIP/2oOtsXanD+7586iZt2z6napKvnjK5BH3M8fyfPsn/R+V+vsoQGNBnJUx9K2syozjGJHSMvthG6mwSl1yAXVUUbrQok/KzKhvrAnH8ho0jHiOX4RBO3aJOYxGgx3scTdV0B8au8ln1qofkLAnLOhjdi9RTcWtN1NFajcOqEccUqJLXQEOxS/6H3Vs+J1KtQCSJ+wj5Hks02cVZMi1bJNOWY+ALP8r8AA5hIrOr+qmomrd2px0gCiDlAxaBtygyQOtovlm//U/4FHC6doz82a7P5tuDM77hH9pnSPbaLLc6szQ1GzL22Pxnx3cX/QgS8X8x8jfr+SLGo4wlip/fCOa0S8BvtGnWhYXuJfH3lndicacvPGFleUjOqRky+z1RX+2SpLev/HsZb32lBa2Yfe8v7dYSeaT2sQSgI56YjiN6I4Bo2AXIpsy8yyylZhCNnA2ivbjD8NQex1yejW7M2RL+XUaRot+SgMqRNUc10gJSsVF0imDcyfNrmXMt1I8RsYvEcBHdBeKC9ioZFs64D/3670WKWAy0VIH1QK6rEcCD5NEfAIIzjOYFvyOyunPnnn2Abwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(7416002)(4744005)(122000001)(41300700001)(7696005)(38100700002)(6506007)(38070700009)(53546011)(71200400001)(86362001)(110136005)(9686003)(55016003)(66946007)(66556008)(316002)(66446008)(76116006)(54906003)(64756008)(66476007)(33656002)(966005)(478600001)(5660300002)(83380400001)(52536014)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wLNkY6mMfAtKvVu16kvWFE8sud06iaspFVPaLxCpe9cO4buc8p10mJAbabHj?=
 =?us-ascii?Q?VCiWGiuLdWNApbQ1K9eft0i9WW11N0mVtbsnoxBXarKrGZvysUDkjg+cIxrR?=
 =?us-ascii?Q?65p069acqmYU1oVgShOPWoAabF7nFQl+cstRAa8lsmHA4SkSrpJfRmjw8hW1?=
 =?us-ascii?Q?sHne2edxXb3yQr66rWTHd/TQ6DSKJNEHYuVpSSdwUgF2FwPDeCWkDcwHbvWP?=
 =?us-ascii?Q?yZW5JEy2AkSMyrYn5rhbkJ2TFcERWvlbX7UM18muM1efKomNSiSkEdxFlmZV?=
 =?us-ascii?Q?OOTG95k0nZ5HaonRRe9Mftea3EeSKykdfc9k72pToFWiMIzp00Ff5cENHj2W?=
 =?us-ascii?Q?7QfhS7jMIIGx6yCSgL1mBJmMHV7tva+M1zE2W73H6fREh9BJrDUc/XfTwtpC?=
 =?us-ascii?Q?xQrKRssMPUKnCCIQoVnSKP7VT1MCATN6NoADMKe55Ebo8bx8GngpHNt3QYo3?=
 =?us-ascii?Q?7ZHnLMQuOU1U+5AGkHKfY/7zWC1TptQtEAPK7XeFgNKjZg7Y0jNXNK1zAAu5?=
 =?us-ascii?Q?zHyQNikoKVx45Y3NeFKQARSbh868ZF0uP5aRjPv+4GyG5bTLC4l2RARc3gMc?=
 =?us-ascii?Q?KDi4WqHSrSBECavkziksfR78+m21hggj9AaORVX8aiKJMVjSws2xQnVcVqVa?=
 =?us-ascii?Q?wzeMUwnJfZCliul3ziLGQzBtRLbJ2HXJTiNDuCt0vYg6Q3vprGihIxRbfES2?=
 =?us-ascii?Q?h4UJbGueVQKNB0e3yheriGTjaK4r3Uhn3Gzg4euRYGTRc2I5zI6ELAqHnQj0?=
 =?us-ascii?Q?VpNf27CIvmbYeF+7HJcToGqr3khvR1s/C3DV8TNNKT17nHEMmINkOVW2H2nP?=
 =?us-ascii?Q?8hd5nvJZnrKUaUsaTE51m80f9m0h2of2qe7k6sl9R2ZZh5oyuu3Kca6gnPAt?=
 =?us-ascii?Q?uh6W0NbW/FQlA0vaKxvlnfmrU6z9kLHfTZ8L4+e2GjKQhb/botZqiR5DS64z?=
 =?us-ascii?Q?GO8QVXimx2hCJMm9IHfSVFV0/LORdMKc4SSjq4xwxQsPfNaLcVnC2Ickhni1?=
 =?us-ascii?Q?EPVoXJwzh0yOa0ZFmFwM2z76i0ea1p/7NeXWMWB4q3TbdqY2nQJG5GgZ5pG7?=
 =?us-ascii?Q?yC96veum1pqTVm4DolU6oz4Bp9WRh7Bixsu6ixQzGZ24SukqVAsOFtUssmZT?=
 =?us-ascii?Q?bci/8qDpPthjvZozUQJ9iaNY+FmNSJQkRBy+gsftWBMTczgWUGk7TdEbKFtR?=
 =?us-ascii?Q?WZndSE69iUH/stTStkys2C8nXiHeVfwa0QQK4iOmVv7AUca0mBChZrycRDPN?=
 =?us-ascii?Q?DebpnHowfsWE8zBJvAWSwZkMrUCpjU3Q0Ud8YhF9AhWDFtApvs9WqIR5sVwL?=
 =?us-ascii?Q?jwMHAeQ2+IudkFxG3IkFWL7BLXY1P5a3MlrC/HLVAqycuI9D7cOqbpgYqjOQ?=
 =?us-ascii?Q?QXR4ZAVE9VseNsAeMJLKKy2j165OGul72y5pSVb10nH7sdeHHxEXPwVvbcUW?=
 =?us-ascii?Q?MI9UPx+j1zZwf2mmJJZpYaZr7B2z2suu30VfY9oHj70989f/8Fvab59u5/a2?=
 =?us-ascii?Q?oFsKnFjbB3UzcGU438JUaUHjGpKCg951SlofdRhIjl45tnc9H+aNzHMV5sJG?=
 =?us-ascii?Q?JCuaupdxzyT9rGIRf1Xqzjw0K+5gi05Xu7uedoYbgITRFUBbef2JZHe6Fe++?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec66281d-df7c-435e-419b-08dbfc872bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 09:29:28.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBPeP9J/lPoT3X9Z+LkYJ0oziD9IATyDX0HLrI5WFAUuPdYuXgLdjj8PgEmKMPA4SgEqTvcrsvgWaAV7l7vC4PExIvV/4DgucQJ4s/YnM80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> -----Original Message-----
> From: Biju Das
> Sent: Wednesday, December 13, 2023 3:00 PM
> Subject: Re: next: arm64: gcc-8-defconfig - failed - net/wireless/shipped=
-
> certs.c:92:1: error: expected '}' before numeric constant
>=20
> Hi All,
>=20
> I am also seeing similar issue[1] with below tool chain[2] on linux-next.
>=20
> [1]
> gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu
>=20
> Looks like latest code in net/wireless is not buildable with older
> toolchain.
>=20
> Can we revert the change to unblock build failure on next?
>=20
>=20
[1]
https://lore.kernel.org/all/CA+G9fYv9j08=3D+-CpJdtAV1z9-8KYbYcH8YOvWjbz4TgP=
7pB2TA@mail.gmail.com/


FYI, This issue is seen on today next as well,=20
the generated code[2] is missing a comma leading to
Build failure. Is it a requirement to use latest toolchain for linux-next?


[2]
0x45, 0x4e, 0xc3
/* Seth Forshee's regdb certificate */
0x30, 0x82, 0x02, 0xa4, 0x30, 0x82, 0x01, 0x8c,

Cheers,
Biju
