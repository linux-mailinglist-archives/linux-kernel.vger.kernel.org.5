Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA53759146
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGSJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGSJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:12:02 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90EC134;
        Wed, 19 Jul 2023 02:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWq5U6SUNseB9qNdQuhchzK4FeAOvQRFB2dxRCKtfwP03Hvt/AKSPc2I4AmHnn2tWYvPIPRjXKeNXVQRJHPxHSFGRsxqFG9LfLsjxFMmedS2NQo1cg0Ejr0vX5YpUaTbkSQ3Wqgp+tZ1LEOHlk3IPODTxmd/CfMEzHnl7fewiK/om4u5PDNt3Dz3/lJE92u7AMffNHU8MF/yPf+VNKrXNHsFfiIehHw1tBMzYpMGz/KEGsMcrmCn/FvvPjg2o9PjkmQnvMU0i+HdNvuBURp5UP+qtedViJjLzKKmTAuEhMpgBLoytC5Dh1qAtjeOknVRRwth+XRkWGNj/JczWOhBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upq9e6LnT2UkBzxdxuFqmG+sqEE89va8W3pKrEWQF8U=;
 b=WnvxUKxSs3CneAM4+n0I6fo67f3mpTcKVpsJ15c8luMe6EGMYQn2vjdGuqnwzfeVewDT9nJu2bBX8Ka2mPVjVxq8ur9kBZgvGFzbjutj2eMOD/lDZcQKg9Dxxck5oSH0s9nscJ0yxNt2pS4RJSWgw/UXPjhzYLpwjJ0xldDfgh+zBXi7XpRrYYYDqoDuZWZFeg9M57PL5y6mEnh7Zx4R0/l991UoIOM8rxu8Hu/qjkXtTftnXhvT52BKJ090j0VP/JQigTQ7FXTf4DKsmzvhhQvgTe8jAC/z8NuenTuetDsIevzPK9Vneu1W0i9OAFLQ6fNsu18voh2bR3S5chjgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upq9e6LnT2UkBzxdxuFqmG+sqEE89va8W3pKrEWQF8U=;
 b=SsdlIG2R0QfW+x2DGns+MCx1Fnv0GAAWf2pTvLxP3k2J0QCs/YjFfBKWJpUCGZq+v5LLNv4SdEH2N9McSQ0K8Ox3T7DOHcv0kBz9Q2SA+d/myAM1+EvzROSDLRlZQCuBZH9vIwY3Atn73NLM6XwFG73Ucce+uwg7OKReKBOvr4s=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OSZPR01MB8234.jpnprd01.prod.outlook.com (2603:1096:604:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 09:11:55 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558%7]) with mapi id 15.20.6588.034; Wed, 19 Jul 2023
 09:11:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH] mfd: rz-mtu3: link time dependencies
Thread-Topic: [PATCH] mfd: rz-mtu3: link time dependencies
Thread-Index: AQHZuiAOB9HBxEITsk+Logz94gZKk6/AzQeA
Date:   Wed, 19 Jul 2023 09:11:55 +0000
Message-ID: <TYCPR01MB5933B2E93C552F0C79455FF68639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230719090430.1925182-1-arnd@kernel.org>
In-Reply-To: <20230719090430.1925182-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OSZPR01MB8234:EE_
x-ms-office365-filtering-correlation-id: cdf3f213-5662-4905-03d4-08db883832f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyhDgv30zZ0Bu515U7fkKPIYCymawCiebnvnk8ibri46c3EuYj3M7nL5pM1mOnYFHQ9cNIFFb47NGcllPnX7vZWJQBkHtF+VqfU7m58OTl5SxZEvegWJDdtbsAuJePBgM7XepkKqwKsY+ce5ThLPgvAIKkmBaJCAOgYexNqAxa4Wd7FFQVFXCJZyakBCSgR3ci4uIP3xxOcW6o3Lt0XJyvnJBp/pCzJ4MThzdOcgqaAHOlSx4IpVQo20jXixLHvIZ4q06KKtFtEekhA8+hI88pHBwV2pIdX7HFbuGZTXJo6SRE+avyIPOqr6TU+i5lUIGZI4S8cdaJJYXFfyVKzd2yw47HyeVu+HF3YAbLAVmTgUc8cT4DuCruk5HnkAL/oUMHxDz3u3xZPtW8owPPZT1I73HLgyAhqQ+gbgw3kxJgX/PITbTIAxMPgxegmq3v5sE+efBCfUpMRAKuqBctNQkzRjPnseHw8Q/AbUE/2+Sz8ZirlNqX8Zhk5ev4nsn2KlPecaZYvbAZ204rGAYfn6daSh4IkbioDFRs6w52ja/zKNCtXA6dfCMhSHvc4/5aejiRkLIC8Txkx2Wb3mfFPAfPnJTbSEOFi16DWQWMq235s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(122000001)(83380400001)(38100700002)(38070700005)(86362001)(66556008)(33656002)(41300700001)(7416002)(2906002)(8936002)(5660300002)(4326008)(316002)(8676002)(66476007)(66446008)(66946007)(71200400001)(64756008)(76116006)(478600001)(966005)(7696005)(54906003)(110136005)(55016003)(66574015)(52536014)(9686003)(26005)(6506007)(53546011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aKHoyeBBWIbtPKT/JVxn6Zl9cfUvmdHN5lbikjJ4wSYOTH3Tglxr4Y44Fm?=
 =?iso-8859-1?Q?65whsA6k+ql+us1Xv2zi5NvcuGIM5+5VLJbEfVtcWxtPD9ZgbywgxGf2Qm?=
 =?iso-8859-1?Q?GssmuWRAeVXdA1IxXPDwJIT597sA+GDdePa4tvh8SRr93Q8UOcj1z1ECvo?=
 =?iso-8859-1?Q?0UdPLRwrgnI/lWEU/MT8vlSHnTnZj0dFFBmXgwy5CCh86dWPyJUciNjTtA?=
 =?iso-8859-1?Q?X35BoExx+2LufUR/sCLuLgXZJECzLU4PrJfIVtHrdnz22kwaRflO2ZAl6q?=
 =?iso-8859-1?Q?UoISQzXa8juajtlGZJGQakrYwPB6Ldfp3F+/bmRTUL8y1SU7eu15JnyR9W?=
 =?iso-8859-1?Q?LBdNi3aGLmbprmYRTY22HlpV0/Yj2+MT29KDIrKMI730qhsbYlD77zbgup?=
 =?iso-8859-1?Q?JnV7Kp+Qi/ahLMVXpwxXcf3ymr/Ehl16Su0Z/sVqpTaUEqs0/+Oq7kv+v+?=
 =?iso-8859-1?Q?TPlnn2xbEV0vX5IoiKCoh6FpJpTmCxRWdgu6O0qUfIKaS7TaFqD9pNSYC8?=
 =?iso-8859-1?Q?DLWzgnxwp160yrhszY0xBybZ8qWFJaXNKoKxhEEJA3bwsHgerzXf1hnQQA?=
 =?iso-8859-1?Q?FR5j909FLRCN6fCtPrqO6vW8EZwWPWyqLMHyDRGWsiyXRVYIwtFJQ3mbHQ?=
 =?iso-8859-1?Q?gCD1c0PeoYkSqJBJcLqa9xCV2jKyRlReycaT3IdqWcrWy9nVvhNaVtcSuU?=
 =?iso-8859-1?Q?mnysqe7r5MPBT959CBIn2aWEfL74p041qS35oLkU005QbnGn5fqOLsJvv1?=
 =?iso-8859-1?Q?IyCzKtdyxOP6oeyu2OBs8X3sqk4uqZTIPvgYNeg7p3EeqRYmC236G4G5mO?=
 =?iso-8859-1?Q?3rMTPdAxPO4R92zDhSBhW02//aI95QhPgV17ShSH094I1KxMn3cFX36j5i?=
 =?iso-8859-1?Q?h933PfvG2mL19gZZh6e7Jb3kN+OBH7xXcmCnGeTGKk4OXdZfNDW1MMrbs4?=
 =?iso-8859-1?Q?frwYKGBlS41KABZdh+1wYQyMx3FMo2c8ad8fUiHeOy3DhC9qMdq9B+mCdA?=
 =?iso-8859-1?Q?RhxDfc7hj18qQvDBA386iOc/evOTLxnQg7CPmZsCYz+HSHPhbbA3oqdkrt?=
 =?iso-8859-1?Q?lfdEcFR/fjmnmpjfdCE3H+DI0fI5WAAq8k3LDK1vnkTn8igAUTbAH/pW/I?=
 =?iso-8859-1?Q?40PpCp6rS3KPBInKRX6fT1AOsV4f/AyQzLKx1KFEh6dD5lBIqzlzAqUHFj?=
 =?iso-8859-1?Q?hV1WgJ5MvKJicipkfMsBhag7Mn2J4D+RaE/tWCDm5dpuNvNeGEZJ+IPeEW?=
 =?iso-8859-1?Q?jjQd6nb02Y9pK9hmoRCARvbzDhNpmV1pgXi00z0SmMAt+QlCS7jnhT9HB4?=
 =?iso-8859-1?Q?T4IQ80RbHLqrOmnXUkFBFEw0uPxRXLANKR+qPFPf4gvoeOZrXis8qntt6U?=
 =?iso-8859-1?Q?2omw+Zm3BYzhnOcgWtZywk5Mp6LnpoSWjlrRTVP3oq1DzjtLJoq3zR+v9q?=
 =?iso-8859-1?Q?g0mWpVCTsq7WrJrDU9YI1t3h+pezLuDz8eyL9Am+syEU/bY5zT8WRIIq3b?=
 =?iso-8859-1?Q?dCHlhq2rraruImwvOydR/iygWJ0CbcVmR71PE8rtNuF6oB0yVoSSI6moZS?=
 =?iso-8859-1?Q?zos5yosqtw4fxwGxPiUsMp2ocRO0XZF0yYTi+Hvzt8TKczlnMEc0Q0Hdyx?=
 =?iso-8859-1?Q?saQw+fXJ6x76FUmF7/yn5Rm0wVPdurJ1Da?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3f213-5662-4905-03d4-08db883832f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 09:11:55.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iN0b03NwfxsTEKIdP7yEGQVA4kjrmC0K1Mz7zJAJcSirI/l5odrRST+J6qdFjhg5+jLSWjsm7qJRtzuFwxN3ZtJySWWbMUYzd3VnzlpWPx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8234
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for the patch. It is inline with[1]

[1] https://patchwork.ozlabs.org/project/linux-pwm/patch/ac8d6190-06ae-b538=
-1293-07efedbfe94e@gmail.com/#3150120

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Wednesday, July 19, 2023 10:02 AM
> To: William Breathitt Gray <william.gray@linaro.org>; Thierry Reding
> <thierry.reding@gmail.com>; Lee Jones <lee@kernel.org>; Uwe Kleine-K=F6ni=
g
> <u.kleine-koenig@pengutronix.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Peter Robinson
> <pbrobinson@gmail.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pwm@vger.kernel.org
> Subject: [PATCH] mfd: rz-mtu3: link time dependencies
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The new set of drivers for RZ/G2L MTU3a tries to enable compile-testing
> the individual client drivers even when the MFD portion is disabled but
> gets it wrong, causing a link failure when the core is in a loadable
> module but the other drivers are built-in:
>=20
> x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function
> `rz_mtu3_pwm_apply':
> pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to
> `rz_mtu3_8bit_ch_write'
> x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to
> `rz_mtu3_disable'
>=20
> arm-linux-gnueabi-ld: drivers/counter/rz-mtu3-cnt.o: in function
> `rz_mtu3_cascade_counts_enable_get':
> rz-mtu3-cnt.c:(.text+0xbec): undefined reference to
> `rz_mtu3_shared_reg_read'
>=20
> It seems better not to add the extra complexity here but instead just
> use a normal hard dependency, so remove the #else portion in the header
> along with the "|| COMPILE_TEST". This could also be fixed by having
> slightly more elaborate Kconfig dependencies or using the cursed
> 'IS_REACHABLE()' helper, but in practice it's already possible to
> compile-test all these drivers by enabling the mtd portion.

Typo "mtd"->"mfd"

Otherwise looks good to me.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

>=20
> Fixes: 254d3a727421c ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Fixes: 0be8907359df4 ("counter: Add Renesas RZ/G2L MTU3a counter
> driver")
> Fixes: 654c293e1687b ("mfd: Add Renesas RZ/G2L MTU3a core driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/counter/Kconfig     |  2 +-
>  drivers/pwm/Kconfig         |  2 +-
>  include/linux/mfd/rz-mtu3.h | 66 -------------------------------------
>  3 files changed, 2 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig index
> 62962ae84b77d..497bc05dca4df 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -92,7 +92,7 @@ config MICROCHIP_TCB_CAPTURE
>=20
>  config RZ_MTU3_CNT
>  	tristate "Renesas RZ/G2L MTU3a counter driver"
> -	depends on RZ_MTU3 || COMPILE_TEST
> +	depends on RZ_MTU3
>  	help
>  	  Enable support for MTU3a counter driver found on Renesas RZ/G2L
> alike
>  	  SoCs. This IP supports both 16-bit and 32-bit phase counting
> mode diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 6210babb0741a..8ebcddf91f7b7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -505,7 +505,7 @@ config PWM_ROCKCHIP
>=20
>  config PWM_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> -	depends on RZ_MTU3 || COMPILE_TEST
> +	depends on RZ_MTU3
>  	depends on HAS_IOMEM
>  	help
>  	  This driver exposes the MTU3a PWM Timer controller found in
> Renesas diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-
> mtu3.h index c5173bc062701..8421d49500bf4 100644
> --- a/include/linux/mfd/rz-mtu3.h
> +++ b/include/linux/mfd/rz-mtu3.h
> @@ -151,7 +151,6 @@ struct rz_mtu3 {
>  	void *priv_data;
>  };
>=20
> -#if IS_ENABLED(CONFIG_RZ_MTU3)
>  static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
> {
>  	mutex_lock(&ch->lock);
> @@ -188,70 +187,5 @@ void rz_mtu3_32bit_ch_write(struct rz_mtu3_channel
> *ch, u16 off, u32 val);  void rz_mtu3_shared_reg_write(struct
> rz_mtu3_channel *ch, u16 off, u16 val);  void
> rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel *ch, u16 off,
>  				   u16 pos, u8 val);
> -#else
> -static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
> -{
> -	return false;
> -}
> -
> -static inline void rz_mtu3_release_channel(struct rz_mtu3_channel *ch)
> -{ -}
> -
> -static inline bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch) -{
> -	return false;
> -}
> -
> -static inline void rz_mtu3_disable(struct rz_mtu3_channel *ch) -{ -}
> -
> -static inline int rz_mtu3_enable(struct rz_mtu3_channel *ch) -{
> -	return 0;
> -}
> -
> -static inline u8 rz_mtu3_8bit_ch_read(struct rz_mtu3_channel *ch, u16
> off) -{
> -	return 0;
> -}
> -
> -static inline u16 rz_mtu3_16bit_ch_read(struct rz_mtu3_channel *ch, u16
> off) -{
> -	return 0;
> -}
> -
> -static inline u32 rz_mtu3_32bit_ch_read(struct rz_mtu3_channel *ch, u16
> off) -{
> -	return 0;
> -}
> -
> -static inline u16 rz_mtu3_shared_reg_read(struct rz_mtu3_channel *ch,
> u16 off) -{
> -	return 0;
> -}
> -
> -static inline void rz_mtu3_8bit_ch_write(struct rz_mtu3_channel *ch,
> u16 off, u8 val) -{ -}
> -
> -static inline void rz_mtu3_16bit_ch_write(struct rz_mtu3_channel *ch,
> u16 off, u16 val) -{ -}
> -
> -static inline void rz_mtu3_32bit_ch_write(struct rz_mtu3_channel *ch,
> u16 off, u32 val) -{ -}
> -
> -static inline void rz_mtu3_shared_reg_write(struct rz_mtu3_channel *ch,
> u16 off, u16 val) -{ -}
> -
> -static inline void rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel
> *ch,
> -						 u16 off, u16 pos, u8 val)
> -{
> -}
> -#endif
>=20
>  #endif /* __MFD_RZ_MTU3_H__ */
> --
> 2.39.2

