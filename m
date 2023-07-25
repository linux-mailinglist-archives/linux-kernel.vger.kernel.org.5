Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D0C761A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjGYNvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGYNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:51:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2102.outbound.protection.outlook.com [40.107.113.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8851BFE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ/TQ6M+H9lymkrpLPm9oN0VXHfZ8Yte/qgpAVlCnJ8h634NR1khVzS5kJIlkZ1XxUfxms2xdSOwSAlKlFr0lBsGE9cj+XI7HzHolQOfQwIIrwFe5K6SqqBQ+3uKyqg2NVG3T10cCigbuUro2t3diomxJBggssMw8cAeUYfeXCstGnRx1JOm088M9J/wJPJYzjHxK7iMUZVBMlJBgF2MzBenNah2WU4SjgiAIkhzx2Q5MmJ4DHwpM1ZD0oDsGmwBfJ3nBoJM/5qNkiq7pkBaS0MhN3rqAmx0ffD6U0Q9RedRS5edDURCro8u61DH3yecfdWkMwNsR4GEe+bZWN+EDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNuXxacr7e8GqnhOuQVyhVaPJM3LjbdZ08u+q14S7R0=;
 b=Hccx0KrXrHwx+uNBXJbVuYvyyOCXhHx4R1dWP6Bsp2Vjzjw++ZCxKgZbUSlsQ04yCCrmzczaubssJurFJMhUlL7k8BUMwvZrdPN/4YEpcp0BtojLOX0i9COICQofykMu+zytC+0YHaYXPTWrrHZz0tJrMFaG3JQRaKuxLRR4pGQ8ZfranfzHlFxiA4AAz96Jkqo6c9QxFg9grz20tPiQG2TF3SnXnuN4Fb9CfbX3GBLtgRtnhXhC5lJVPvzo7+x8rNdsBVep7YeqWdn+MSdNYgjnYcifguTPFc7PYxfyYLYLDZOIhJyDSEIzqg8CFZsyzkQeC8XIsvpxYP+Tc905GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNuXxacr7e8GqnhOuQVyhVaPJM3LjbdZ08u+q14S7R0=;
 b=OVu6m9LfMrdPdXtm26IiT8E9Ne3O4uWTzaUzpEzfyyRsW5VusHJzTQIK4mVAkMp+A+Ye2aT4giiRW8npt75noRKG841YCMCILyBTK61Ul1qnb2MTxhzJTTx/cysQwIv6Bsyz5Dt0z0G11CEbEwOhuVj+nftObtHxkmT54NjVb74=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10221.jpnprd01.prod.outlook.com (2603:1096:400:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:51:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:51:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
Thread-Topic: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
Thread-Index: AQHZvt8morzZIT9HiUiELKP14S0wHa/Kf5Dw
Date:   Tue, 25 Jul 2023 13:51:38 +0000
Message-ID: <OS0PR01MB59220756AD4F8184ACF34B238603A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <202307251752.vLfmmhYm-lkp@intel.com>
In-Reply-To: <202307251752.vLfmmhYm-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10221:EE_
x-ms-office365-filtering-correlation-id: b0f0e66e-3a57-45e0-179f-08db8d1644c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bT/K67/9NlFEp66IdVrLMaDI5lJ7hX4l5Yjk+9ZKNinIz1spRWi+HTvPBArJONEs2Un+oWYeADLVaRn/3Iz4wfrFr9+D4Hc3skt/QcFqdlgj2pvAbtSWRa7kciJcZg1p5AOB/GTSVIr/dQBYnJHBwwqJVkEAhoUU2158KrnMqJZcvNJ0oyERkZjrDCsuwNOlRNtJOj1OvyjqNFjiMAkZBBhwpVQQwpjxkDXRiQ7RWswnqRVC1vaMFvrwt6J52VcGVW+Ymah0iIL13qAxaYPNxWwKFbvZXtS3B4IgI+3WEilJJpOhk+Jbu2/jrnRs4gVQnmWRxMFapIpdY4mvchuub4kAE48Hta+YjUYcUktLvsWYui/2WHt1Ia2XCYYdHbNl2VG5KOwPrs8krrsvVfmPvYMPURJPA4mziqSP51jcVdsB+FLFDqBisDOJR34wNk/hkQuanCh4kHQmohHTc1JvGfKMkciq8Zml6Le7qMBExQKa+qh/Xf5ORo1ATZY7JyfcHpRi2Ct1A/ZtWUuiL5MAS3dDvSyHRqFpCg/5eAoNm5p+x3rrKsS+O6+ed7zqzhanhZqFP5ar/qWTXxIgAgd96QR4aVjbMFu+hRZICo1u2ugqDZDtWkfrJNPDXXBV0cKz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(55016003)(26005)(186003)(71200400001)(53546011)(6506007)(64756008)(66476007)(83380400001)(6916009)(66556008)(316002)(76116006)(66446008)(66946007)(4326008)(5660300002)(52536014)(41300700001)(8676002)(8936002)(7696005)(966005)(9686003)(45080400002)(2906002)(478600001)(54906003)(38100700002)(122000001)(33656002)(86362001)(38070700005)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HNclWui5vDT8uUQ4kr02JvrDkH65f2d/3JUl5NBEpTN3ydHpfCWcc4tDdV?=
 =?iso-8859-1?Q?2zDserAoYSnoIZklv84FOEAUDe87pbe15RFhj+jc2Mgf6Nkxstwrf52MdN?=
 =?iso-8859-1?Q?fdlMDjaFhjFlsNV1/dCncgtnGIi45gHp8ZnzU3CmKetEpt7xyOxqvYUxiw?=
 =?iso-8859-1?Q?RMd4L2KVWElCPkUJTIULyVPG7IO4DbOebiVc6RcX6kP3aRy+LwzpPCFU8Q?=
 =?iso-8859-1?Q?mtFYCayZtdiqrg3hGifql61F72t5X/ztOBVCrFKqPWEP7O/ka9aF4pBz+v?=
 =?iso-8859-1?Q?iJilIIU1o2fiDCW5v4rumkmouv/TWQWNzHC+1dYGdkxOFnWDRbaJ3QpIa6?=
 =?iso-8859-1?Q?pBpScSy1wEngMrcxjQBgTQkZtJF4DZYcTfhFnL9giwL+3uWAEYEp02qfGE?=
 =?iso-8859-1?Q?bQN00vZ2J9k+b3yciysxPIqwITS9rlQR6bIJcBzGD2IBoEN9Sllc2bCV2W?=
 =?iso-8859-1?Q?mpHW7ovmmweHaX9GbJzBsDXjY8Ud4dCY3LYs3suJVEfLo2DOA5VNnw2JPm?=
 =?iso-8859-1?Q?5CmGgSEaH+mXwBz2KKhu015Yt9JMomSy4QgU1oJFuWFCBsZ8Fua20gKnSt?=
 =?iso-8859-1?Q?9I3i3iNn0RjHz3KgM/I/sNKHck98LKZk0lvlAKgUQnFzItGb4RlryIqCtz?=
 =?iso-8859-1?Q?Q0t9MgHLi6exMi6PB1Pj87eKHO8VMIl/SalPvaU1k39RlSGI5cSfbqByLP?=
 =?iso-8859-1?Q?SxihUZf3NZ/XGde2VGt+y1+oq+cFEK5frzMWagx6YEP8XTfYffpvt6Ah+S?=
 =?iso-8859-1?Q?VMAskNWhUFfCJCXsGvYD+F5665YEa0nVurXLoORK7qQLHi0JWDBp4bPsDI?=
 =?iso-8859-1?Q?fvbPrN0LgpZ4Tp25j8WDewX7eJ5r8Vs4U2T6nGVCJBZ8AAIM8HqTRBYZfs?=
 =?iso-8859-1?Q?phmQo9JBsWpigJHpUVmPlcM7+LcNDEOkU0f4+X1K9rBmvBoUGa62JxMr6M?=
 =?iso-8859-1?Q?mGw7R2XCQtU4KtgkrHTJWB60oToFYjc3IRvYrIPWTkziSVod9zE/ivky0m?=
 =?iso-8859-1?Q?zWClDgct3iZy3vGBrVzyhi0U50QZ+GQoSQOdQVLTsoHSfIxKGX+wBX1Ogx?=
 =?iso-8859-1?Q?dLXunu5+BQ9RoLCLA2e/D4/y5f/qSbMF1czrL0jBm7zqqp3S9a7/ROxkag?=
 =?iso-8859-1?Q?bCtlweqpg9EpSJiOa7D5u7EghVJTvdnRu7Q1rUNyhCqCZH//QiWgOGL1oD?=
 =?iso-8859-1?Q?ItbyHHchGAO/oWZeVvL2rRmZcwzZs2dTIuhJxC1AXJ+W4ttArEO+Jyk4Oj?=
 =?iso-8859-1?Q?pEJeZeozKgzYVpvUBzwIiOQKO4Bim3JDzSeVVE499YFXj4oCnWVWpsMv7r?=
 =?iso-8859-1?Q?iBbyK/0VK8wgFxBdnAf3QJ9UTjfUkg1RR29NuuFwP6s0FQ/5KfZvU4l7oI?=
 =?iso-8859-1?Q?2xrX8WC8S3+I0zK2XIT6UYOJAf7Y9GULwYS2FVkrf38ZTwcqBPO2TsaD6E?=
 =?iso-8859-1?Q?J/PZZkBql1q7ZUUXBx54xWyPeqopcOdVevQ16ykVAg2HoPt7RGKoN08Ocn?=
 =?iso-8859-1?Q?TdB6Mz08DUDcSoSfqT5/0vu9OoW+XZtSU/bRZBgMzUI0V03rI/EFDWfwK0?=
 =?iso-8859-1?Q?rSX1zmpsKyzvFFM8J8CKIt8crZHVkG7lWUVc5ei+dfMuMV66WzW080J1nu?=
 =?iso-8859-1?Q?bJWArJ0PUpWPxifmN2dgfJJ1Vpt8Onf36a?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f0e66e-3a57-45e0-179f-08db8d1644c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 13:51:38.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EF40QWi9uzPwT0X52cubY3AB31iEzpMaTxvO8zPnc5okgu2IlfIsJ3NX1lJWpkO2e4TYh0RRnjAW01QLuIHeQ3ZRBxGkxVdOB4MNywMlKBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10221
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel test robot,

I have fixed the original issue by adding dependency to COMMON_CLK.

But I hit below error which related to m68k compiler/arch specific.
Can you please fix this issue?

/home/user/0day/gcc-12.3.0-nolibc/m68k-linux/bin/m68k-linux-ld: section .ro=
data VMA [00002000,009a758f] overlaps section .text VMA [00000400,012a08ff]
make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
make[2]: Target '__default' not remade because of errors.
make[1]: *** [/builds/0/rzg2l-linux/Makefile:1250: vmlinux] Error 2
make[1]: Target '__all' not remade because of errors.
make[1]: Leaving directory '/builds/0/rzg2l-linux/build_dir'
make: *** [Makefile:226: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Note:
You can reproduce this issue by

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6210babb0741..eeecf249f372 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -506,6 +506,7 @@ config PWM_ROCKCHIP
 config PWM_RZ_MTU3
        tristate "Renesas RZ/G2L MTU3a PWM Timer support"
        depends on RZ_MTU3 || COMPILE_TEST
+       depends on COMMON_CLK
        depends on HAS_IOMEM
        help
          This driver exposes the MTU3a PWM Timer controller found in Renes=
as
--

Cheers,
Biju

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Tuesday, July 25, 2023 11:02 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Thierry
> Reding <thierry.reding@gmail.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>
> Subject: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
>
> tree:
> https://git.ke/
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=
=3D
> 05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Cddafcfaf3d0740bb720d08db8cf6482
> 0%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638258761619965319%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DidIXqpIejeDQMi9x3H7uoGxBlGPkBj6OONAc=
%
> 2FUX%2Bq00%3D&reserved=3D0 master
> head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
> commit: 254d3a727421ccc935f085eaa9bae51cb6c9df25 pwm: Add Renesas RZ/G2L
> MTU3a PWM driver
> date:   5 weeks ago
> config: m68k-randconfig-r035-20230725
> (https://downl/
> oad.01.org%2F0day-ci%2Farchive%2F20230725%2F202307251752.vLfmmhYm-
> lkp%40intel.com%2Fconfig&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C=
d
> dafcfaf3d0740bb720d08db8cf64820%7C53d82571da1947e49cb4625a166a4a2a%7C0%7
> C0%7C638258761619965319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DZVZQjR=
a
> BlITtV7ooqne%2FbgVayvBT9Z2kpNW%2F%2FOGmOig%3D&reserved=3D0)
> compiler: m68k-linux-gcc (GCC) 12.3.0
> reproduce:
> (https://downl/
> oad.01.org%2F0day-ci%2Farchive%2F20230725%2F202307251752.vLfmmhYm-
> lkp%40intel.com%2Freproduce&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com=
%
> 7Cddafcfaf3d0740bb720d08db8cf64820%7C53d82571da1947e49cb4625a166a4a2a%7C
> 0%7C0%7C638258761619965319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DZHl=
9
> ZDmwIItVHzIfQQ9IqncDcsvrRhgbk2dAJrcrWyg%3D&reserved=3D0)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore/
> | .kernel.org%2Foe-kbuild-all%2F202307251752.vLfmmhYm-lkp%40intel.com%2F
> | &data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Cddafcfaf3d0740bb720d08=
d
> | b8cf64820%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638258761619965
> | 319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> | I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DpnWkQUcmvfm4pgg5KskiRm=
p
> | YzCe13tuQ4GMw7GBsRHc%3D&reserved=3D0
>
> All errors (new ones prefixed by >>):
>
>    m68k-linux-ld: section .rodata VMA [00002000,009a764f] overlaps
> section .text VMA [00000400,012a124f]
>    m68k-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function
> `rz_mtu3_pwm_pm_disable':
> >> pwm-rz-mtu3.c:(.text+0x114): undefined reference to
> `clk_rate_exclusive_put'
>    m68k-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function
> `rz_mtu3_pwm_probe':
> >> pwm-rz-mtu3.c:(.text+0x32c): undefined reference to
> `clk_rate_exclusive_get'
> >> m68k-linux-ld: pwm-rz-mtu3.c:(.text+0x380): undefined reference to
> `clk_rate_exclusive_put'
>    m68k-linux-ld: pwm-rz-mtu3.c:(.text+0x400): undefined reference to
> `clk_rate_exclusive_put'
>
> --
> 0-DAY CI Kernel Test Service
> https://github/
> .com%2Fintel%2Flkp-
> tests%2Fwiki&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Cddafcfaf3d07=
4
> 0bb720d08db8cf64820%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6382587
> 61619965319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DA2zogmxOdQAYSC1ogk=
2
> IneNrLIdpV2xsmI14gNmbG7Y%3D&reserved=3D0
