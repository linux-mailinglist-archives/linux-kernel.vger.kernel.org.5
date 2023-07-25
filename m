Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB445761E60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGYQXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjGYQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:23:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7940810EA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5PD+qz2G9is/qX91K1GUqK8tkhv9J7t4H+P34KVSAmCsqCVmew7TJR/BX3OdY5VfCh7tPRvnQLwTj8q7gL/2LMlh/KuQpqcyLEMIlUeH+t09zpILfUJnZYTAor0CIUqY7/WppkGM1wXJcV0m58pFCamSijvLzY0RppJRcY0zmmpQY5NQwwnlvDCGQnCIdbAv4nbJNZEazKnveWscI5mB13jpk8J8CDvVUNi5XyuUZvVxmzGBSvAuwoProyGl/uUp1Msat5+WvD0jfFxXyFWXr+75QYDCKqF/Z89gy6HO6r8GtFM1JWbI/1jnPslkDJxd7/X+nI9tv3mXytNsi7pAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKvEupayOow/THOcpfMM/LPW5qZEO+Gj/S7fOxpa5Y4=;
 b=VPj2Gcqi2RvTUn/uETvrLahZMwV2F4FV2o3GSafpsye9MvqQ93ji6mn/U6nptGy5AZtYGMQMCGCmolUbsxJp7x9Eai+nidvtztXRpkwC/7HquyvaXFWaGgXJsccw0PsHQM2u4wrBLvmsGuHOr9kGhfFfSgLCJaxtT61DW6l48XXtWyRTQGqcw1zzxmeUbhT0+JAfxP/GrUUB/oq0LavoD0Uuib8tvNCQcN8HlDKfwItUbHmgo9OmtUcBK1E5oNPdpmNgLzSBafVhuq/X2aaejSZZT+uomTULDLeY12BCMz9k9JC6TUgXUzptiRNLAoJkeBvpy5PorXhanK4Hpsi+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKvEupayOow/THOcpfMM/LPW5qZEO+Gj/S7fOxpa5Y4=;
 b=SsRIePHGCc6h3sgeVIUG3Vsvtc0WHraQniW6hB+HZVwD1OnWlqP7zDdxlyyVF7x9MznM5JQWvguEAN/NWvlLOz5R2p7w1dv7zCIa2Ji4bmHULVwcOeqb8sh9YllRPTAba57j2od5GTaDM8VE9rddZzya6Zsn3NsEWHZzws16aHs=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS3PR01MB6136.jpnprd01.prod.outlook.com (2603:1096:604:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 16:23:13 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 16:23:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     kernel test robot <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
Thread-Topic: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
Thread-Index: AQHZvt8morzZIT9HiUiELKP14S0wHa/Kf5DwgAAqx4CAAAAzMA==
Date:   Tue, 25 Jul 2023 16:23:12 +0000
Message-ID: <TYCPR01MB59334CA7AD3C6B346DF41BA68603A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <202307251752.vLfmmhYm-lkp@intel.com>
 <OS0PR01MB59220756AD4F8184ACF34B238603A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZL_bEBGNb73wbpRF@orome>
In-Reply-To: <ZL_bEBGNb73wbpRF@orome>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS3PR01MB6136:EE_
x-ms-office365-filtering-correlation-id: 1626966b-958b-442f-6b39-08db8d2b713f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmgwd4ULLZw78lVrpUtKd3gPJnBQ4WKTn909Ubu9qKEZD9jlhUQhBS9coJhImzfvF8+nEjBsvsQ6eeSvq4ET8FraZXkd7xyxVrrEolLS1PCXfSe41zOl08DDOGvmXLvntzZFZbel+2bMUTEui1KvImRy0+dYuj0rSFmZnxIKlstw9TwmcMXf7DQV1V3VzKFEzWNyqKUyEY2R3hw/AsH74YOAcal1zLc3l2e7h1sf40/kQccygVP0RVB9Kxsoz0ihEINuNOkqoM1dZ6sIdx9PKWG9EM7D+ZUVjLQiqEQVbr1TUhO5GY8P1LogoDVIiwHJa1sA1vtX86BLDdB0UZVD0Ij0f/RFQ4OzRVJEn3d/1LCD5TZVsYT3/B2VLBQB71AokHx9Xl5k99q4c/9cKWC4fgn1i+F0vM5WQAcbLgRuoT21XiHAWtdoPI+nJsne/5qs9c75MDQAHpSOa6S0U8Mvc0KIp0QMyqCFKowdqRzD1D8yjJe0W9X1TKOzrLiXbWqwxQSXslNl1caXVk2+WG6yvOpfKmh3rfpl6uF6NILy3xfH9GIq1r9uBrzIE4sK5Kx/zkuq1GQKZJFnzlumUwmOy91FNY8Stn9Xddkea8eUUFUSfoUQxOXyZ/xc7e/MpzFG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(71200400001)(7696005)(54906003)(478600001)(55016003)(186003)(38100700002)(41300700001)(8676002)(53546011)(76116006)(66446008)(122000001)(64756008)(83380400001)(66476007)(66946007)(66556008)(4326008)(316002)(6916009)(86362001)(33656002)(38070700005)(9686003)(966005)(5660300002)(8936002)(52536014)(6506007)(2906002)(26005)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ixlOkMucHZbC66QpoIdCUHjgvIfCB4pZXOkQsmtGMdQf8TA+Oz53II6fLM?=
 =?iso-8859-1?Q?c9+fiSSgaj8I6Q1HtgPgOBTrr9w+RE7FecrHdcehJtqZvldBZHemEa7DWH?=
 =?iso-8859-1?Q?25baYZq0BFSepuQLrLjxU4vu/pQ6WB8y4zDcu4Ka/r4KsEf0zmOwpp20/V?=
 =?iso-8859-1?Q?qkrH53KcGEbKJwUwW9UHe9KBzGU5TfaNP39z4/MrRLSsnP1t/vY3PfsoOp?=
 =?iso-8859-1?Q?FJc9WrcjYA0ZZjymN6jRTkCN94R4bO1GdnlCnKsg/ZDols8sI8sZcSGfcb?=
 =?iso-8859-1?Q?5Vigon7ireUB7nQkQq4C4xrQe4FVaNhBiJD+DOUPa+onWK+F4NKADwKvyi?=
 =?iso-8859-1?Q?7E9SecyBdlcEJ8YW0fmz3jEAsS/CY+lfIxH6d+dLGTVzDIVXNTT4Pq4PxH?=
 =?iso-8859-1?Q?bmklcp3Ev4fmRLE6DCdPqje+/Wq8k9zCEAOgI3m2Fftt59czk6sHewP8w7?=
 =?iso-8859-1?Q?P1AantyjE0rFJ4jwhIn6jp6C0/je0oT0Or3lACfgPA637Zm7Y7Z2YBbGgU?=
 =?iso-8859-1?Q?nTrEvqZIe98rbmUz2AWM0rcDH9eFv+HeO3l2w53MChVxK2RZ2uKYqtWRf5?=
 =?iso-8859-1?Q?cPhe3htXGqyHvjmFYjDFdFHuGLh0yjhKrLwBX+6Oc7JuaQ/9wNUkEq5HXr?=
 =?iso-8859-1?Q?agfxyl0vnc0td3u5tQHUmkrbAtiLz7dFUPuzwMW89Ygst/hErNDRuB3ty2?=
 =?iso-8859-1?Q?eMNtk3aVt2RCT03jf5910UtH+2T0sVX+rALtTdwvRpaAQh4eojOSvZzIgj?=
 =?iso-8859-1?Q?sAi/9bpZEhWzwKM1DDVFeKPRUaVsSWzhiybM1guPdD/BtluTSH09APjvB2?=
 =?iso-8859-1?Q?Z++WM9ct6IGNzjOdim2UKZW4deUKOw1dblBL8wlZJk7Lo4CC95gbVNeGsM?=
 =?iso-8859-1?Q?SgT0vGVYZNyAxmA7nY6p31OeaVkVNNOEr4AnWXHzy1jf4sk4UIpuTXDQQ9?=
 =?iso-8859-1?Q?AXk0FYCfUgK6Yj90CHJHGlz+DKrqAbagDjVVoKbFAQLAmOGenxvddNzW83?=
 =?iso-8859-1?Q?nBHFCZdoNhPl9KbBvyh4MY52mWhttQOKAveexc3Onod4p8JwUCDR6a9nGj?=
 =?iso-8859-1?Q?hNAVbOlYtcwn6EbwuTIuiher8/UsG5B+mJgZDjho01o1iws2DCOt3gjoZ8?=
 =?iso-8859-1?Q?IZ75PiQWgK4FU+5+bDuSkjkKAy/JAqVHH+ElcOqtIXubqL6yQaY+hlegK1?=
 =?iso-8859-1?Q?46eeYY3XToV3VZI5tyaUjjLCEzWuDEwAso+AisqIFe/tLtYF8NwHl2xh46?=
 =?iso-8859-1?Q?gz3Z4E3AbIOndbEaGoXq/zUuMDMDNwEHrPMRgy619SI8ZavOByJeTC01zp?=
 =?iso-8859-1?Q?sHLrjpPlVly99srrgfY7zjN4ZM7fb5+27qzXQa7ie0GYqfb65kAKTgUYUd?=
 =?iso-8859-1?Q?r2Vl9km1TgLJX2qalv0WwTWFEhd79mfYZ0+Sde9yhIvhJCKASfNw5L0d/8?=
 =?iso-8859-1?Q?tDEv2QgBMPdVVd3vzwEymInWrEYXs845vB3HgIsT/Ta95VTi+oyyB5wikk?=
 =?iso-8859-1?Q?Fr7QiNCrs1OnwdUMrrhhDF5u+sWIw9EMSZZI7Io3AN98orBJkitfpdhWKK?=
 =?iso-8859-1?Q?GcKY6vAC+HA+KSQ0h2vBakFDzcD5xKe+hmEQZQJB+CQKhfIkmIw7TdenTN?=
 =?iso-8859-1?Q?hxI0nVnVcIF/QQOc205LWSYowK9WYmRAtnzxlGvwGYZbLYKSJxqGr17Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1626966b-958b-442f-6b39-08db8d2b713f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 16:23:12.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pmH4iHn0Q88hgnfzbcXeRegCkKdQh/4iFB445X0N7z1ATzBujQKykTEIdD528qfTJ/EzNA+x3+blD9fXdNapM8+GdOWg0Y5TdXxp7UIuaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry Reding,

Thanks for the feedback.

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, July 25, 2023 5:21 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: kernel test robot <lkp@intel.com>; oe-kbuild-all@lists.linux.dev;
> linux-kernel@vger.kernel.org; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>
> Subject: Re: pwm-rz-mtu3.c:undefined reference to
> `clk_rate_exclusive_put'
>=20
> On Tue, Jul 25, 2023 at 01:51:38PM +0000, Biju Das wrote:
> > Hi kernel test robot,
> >
> > I have fixed the original issue by adding dependency to COMMON_CLK.
> >
> > But I hit below error which related to m68k compiler/arch specific.
> > Can you please fix this issue?
> >
> > /home/user/0day/gcc-12.3.0-nolibc/m68k-linux/bin/m68k-linux-ld:
> > section .rodata VMA [00002000,009a758f] overlaps section .text VMA
> > [00000400,012a08ff]
> > make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
> > make[2]: Target '__default' not remade because of errors.
> > make[1]: *** [/builds/0/rzg2l-linux/Makefile:1250: vmlinux] Error 2
> > make[1]: Target '__all' not remade because of errors.
> > make[1]: Leaving directory '/builds/0/rzg2l-linux/build_dir'
> > make: *** [Makefile:226: __sub-make] Error 2
> > make: Target '__all' not remade because of errors.
> >
> > Note:
> > You can reproduce this issue by
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 6210babb0741..eeecf249f372 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -506,6 +506,7 @@ config PWM_ROCKCHIP  config PWM_RZ_MTU3
> >         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> >         depends on RZ_MTU3 || COMPILE_TEST
> > +       depends on COMMON_CLK
>=20
> It probably doesn't change anything about the build issue, but I think a
> slightly more correct dependency would be:
>=20
> 	depends on HAVE_CLK

Nope. I used that one and still got build error. See[2]

[2] https://elixir.bootlin.com/linux/v6.5-rc3/source/drivers/clk/Makefile#L=
4

Cheers,
Biju

>=20
> Thierry
