Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF7D77FA59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352842AbjHQPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352897AbjHQPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:08:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31DF3A9F;
        Thu, 17 Aug 2023 08:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIwlU97tPsgvSrUfii5mLcbmoOACYx8qb5paorEq4gl2cvB9DBY9OeDCXSCTmX+lk9SAyFWJVq0/3FSDAG7qGwlCCxf+s7McS/Zg24Ft8Isp+OCBM65ke5h0IZa5Hb9iDa4OGO08ArFDndJLTp28mfApFZ59v5Oj0G2/nvxqE4sVcTxcuUxUGnPqJYHhr0ahYBux41/yeRslthnRrKi2n0BUKk+4JO/T07Ab9YO+OvM4OzxMv13m/h05l6+U4YN8ZUu3q3o9SPXVKZ4ESwHvn6i3VMRG1qGmn9lwQMvyvKTpJYormqdnEB1FHmTgpb8pyb+j/Kvmu5eR5ilbO8qKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BClb288ILHxERKSS7vASuDST/LbD4MHF6c4Nj7XwzGg=;
 b=GFSvTTC4gpnMENxie64Ssomo9LX1QdNrdwvP8sGLDRyZDfpSmD/fh6nTauJy1yN6Jz0E8MNcKAlxaH+E1gCk6Sm4gmp+EaHlFx143VTD+GjTwcWZHTT4vpCGeu069ZEk5w5SL9fxZeuzacEja1MWYh1iRmcEKNz95RETIP9OdD6n0X0xFsS315Imo3fLx48mq2aoiyAZUJJwL09UcnMocB+QLWu86A6YhSgL++NoO6EIV1WRM7dUHZttiVKPuO5c4pvO7PmkbEzvJOryHQEldjscuK8Dqr/j6O8AG2v5xvVqtfYhX5/6pnCL4jkdNZA5BMmUbIBYDUcv34Pu0CGK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BClb288ILHxERKSS7vASuDST/LbD4MHF6c4Nj7XwzGg=;
 b=QfHrS04oyqDa1Rp8eKDUllSIml6ned2vAQbXLttauMS1yQ49D6y1kBVe/0NRudBf1bDcLx9Jga7cMMRrmLG32uIXfOk8zfc/xQsQk03RAS/X0wRG2jVkVfZyRgsUGpRQRvf22FsLhkkRdSLVh34Yi/oxXKvrKDVPCnVyoXEkFESbp6elHFDGoTH1P7xHjA0MzOCF+5CRYaLie3gkl9VX3XBch1R0annSGStka3OheaXn0Gh0mYuKnXDdQtIJgLKxHgDHC8Ec0Le4qflFBHTWYf6H/Ku9Ny/mc7FaY5ftYmoVTKRWCxMOI0F1ySy16iOfeeWY5VbMf8Ch52Fjbghmvg==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:07:54 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 15:07:53 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Topic: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Index: AQHZ0Fiforf54onJHkGX7vWgR5BAI6/tEceAgAACvyCAARKIAIAAcQcg
Date:   Thu, 17 Aug 2023 15:07:53 +0000
Message-ID: <CH2PR12MB38950929588D6AF386C4C22FD71AA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230816154442.8417-1-asmaa@nvidia.com>
 <20230816154442.8417-3-asmaa@nvidia.com>
 <CAHp75Vdp9TYTod6UBLxG_YrT_vD4azfyrM9dTrau8CPJuH_vrQ@mail.gmail.com>
 <CH2PR12MB38953114436B7B0768A1C321D715A@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VcEe-2+=2qXCFHp+cxN=nWcsc=oCVYUeinM_cMsPES+mQ@mail.gmail.com>
In-Reply-To: <CAHp75VcEe-2+=2qXCFHp+cxN=nWcsc=oCVYUeinM_cMsPES+mQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|MW4PR12MB6999:EE_
x-ms-office365-filtering-correlation-id: 4050810b-fee3-4d57-8c7b-08db9f33bb3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sITAemQuyAcDYG9sThZfeakdqo0tghlebStoZ7/ehvdVxG9D2gvP8xSc4wGK+XLub3XYUhRbziw1ukqtzCmdHkMXIuepAirakt2hLlqVOxpPeuPukz3EILc26hXyie0FxOOKEB2gJudjlX/ZobeWD8qlZR7czTznxHtiNIBRo5GsosFGW2ouvlhghfTy4igwpvZteGg5IMrT7R49ROsQNVQhiR2deN2PrBVQF8cZHZWKT4twH09NqSVePFaixzLJMpFWTvJCRUAD6e9lt7VUI5BiMNp77oHnsl2fuz1ACPDDdqi+eQh0CK1nMaQSLxXeCyi/aTVQT28Yy610SOCnyrN61/XeOjazHEcRdvELyE5Yw8U0lJN+6BRbbQwneA9VlgSXbcwXcycbSgAZen8VUQDSx8GFCNkj+CpzI1tRBXABOgwOYfXb2MTcEC8vTS6SWisIVOn4n+Rm6kkhqCnDCab4R7kC4G8Nl3Gd2nadBO0yy8j/68KG4T5NPh5rBXYosj1IM+Nf9hRF9IAJpYf5+gUjMSorQ2EJjAFaT8LIG8PfKbm+daEd1nvgdELtSnMMj4uQxu30ZZYNKypO8lEETtUwmWQVnZMCvJTJz2YL6xSfUZ+OnZvoq3pFqhDS2KE1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(33656002)(86362001)(83380400001)(55016003)(8936002)(5660300002)(8676002)(4326008)(4744005)(2906002)(52536014)(41300700001)(26005)(7696005)(6506007)(71200400001)(9686003)(76116006)(122000001)(478600001)(54906003)(316002)(6916009)(64756008)(66476007)(38100700002)(38070700005)(66556008)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmplSTZsbGJkejgvS2FIejdrcTRxS3BnUWREeElFS0haVU5HcTRWbWVtbGVV?=
 =?utf-8?B?U3JQZ1ZVRmdMWkRpVjA5VWhkVWlRaFVaSUJ2L2ZudXdCSy9yUHd0ZmVjYnFv?=
 =?utf-8?B?KzBTMm40WnNCVW92elZiOGtjVHdZY0Ivc2lENUJSZWRrSW9uVkxXZlVnWUhD?=
 =?utf-8?B?aDlQMnNSSnhtYU5PN01HVTY4bnI0OGlyY1hVdDJhMmR1UGxzY0ZHSTBOSTJw?=
 =?utf-8?B?c1ZlZkxKUmx2UGlSOGp5T0dsUEhhaVdWcHFOdXorR3lXdUVOd0VGMDl5MU8w?=
 =?utf-8?B?a2JwWHVaazcrUkJROWFQTWtDMHZzV25HK3hYVnVHK0ExM3FicFljNGtkb3Ur?=
 =?utf-8?B?b2JYNGRkZDUvdy9HQWd6Z1JvdnhVaFc1YWVXWjhIcWhGbXJ2eGw2bWR3RlRZ?=
 =?utf-8?B?QVl3dmQ5bU9iamJqZTBEeEU5aUZsdkYxTDFzN1RCclZUSXJyc0tzMkxEWDV1?=
 =?utf-8?B?czRrdW4xeGxpOWRGcGxkUmkrNXJBMUtuazlqSW05OERQeGxZTFBCSElia1FI?=
 =?utf-8?B?ekI3RC9pS1JtYzlpYzR1cHlwSFRqcDN6L1NZTitndWcwWHRyOURJS2pMNUpS?=
 =?utf-8?B?MFBoaStTTVlJdGZOdTZwMTB0dFFDYVIwTWxKek00K1VvTzZkb0VSZzhWdUkz?=
 =?utf-8?B?dTJHOG51NCtGRTJFRmZ0MVF1UGZOL0lEQnRKU0FTd3pSczhMZTAwV0hlZm04?=
 =?utf-8?B?b25DV3VOM2Irb3RxeVJPWmhDTkxMSUxJRWdtaGZUUllBUHRBelpDd044Mldz?=
 =?utf-8?B?cW40SkxKOWxlR3E1aHk0MUVxdkdwZVBvZVpaNDF2TXRtY2tUbjQ4bGJBMzZI?=
 =?utf-8?B?elQ3YXovWHZXSVhJU2ttNWNtaHlhUVhEaDRaeVIxT1JlTzlqNTVwZjRFTEpt?=
 =?utf-8?B?ZDBzdWpjVEljOE9LUzlCT0VYdUpLVVlweGR2Rm53bTdZWnlzN0hVV082cjBC?=
 =?utf-8?B?RXNsbUhFVWFDZlpMWExCYnRWUzZ0M0tHVVJ2QmlGN1FBaXNmVnFnWWpMVXpN?=
 =?utf-8?B?eXZFeUlFQlM5NzIyMkswNm5TaW1HSm1tek96eCtBV1FCbEJYVm0yaUkzelVn?=
 =?utf-8?B?blhkTUhkVm01K1N1QWprY2lEK2MrNVc1dVRpL2xvaG8xeklPTkhSS2gxRDdE?=
 =?utf-8?B?aEhvYmVVWExzSlhwcGxZRWQ1bHpyOS9TQ3REV0ZJSlJaSTVYTHVkR0J2Rm5u?=
 =?utf-8?B?cythZ2xrWXNkeHd2YUpNK0xOQnpVeTIxMUhuK3lielI2TFNQZUJJVEpOVFht?=
 =?utf-8?B?UUJJY0ZBTVRzQ0VSVzJOTFZIV0RneC9FSGd6cGJDOXFLZWF3UnFFb0p1VStp?=
 =?utf-8?B?ZEpaL0xrdVp1RXRaNytuTldKK0RPU2FHOEJXa20wMWdiZ0UzUWtyZEFTcVlz?=
 =?utf-8?B?VW9SZVZkZU51YU93TERDNDBTWUFPdEpqb1d5Z09qdHQ4d0lXTkRwRVJiSnZN?=
 =?utf-8?B?RWFsWlgvTC9CM2MxVFdoTG92NTdOc1EzRWU2WS9yTDQ5UG80U0hKbWhqWllW?=
 =?utf-8?B?Unp0TlV0QWlIN2ErYU1MTk5JWERmL2gzS0JJcDRBMkxNTysrT2p6NGswdHZp?=
 =?utf-8?B?VXpzQ0xZT1B3R1JMdWxOc1YwMjJqRUxWSE1Kc1FUSHY3elB0S0pRTFJrNkFP?=
 =?utf-8?B?MzNGRDFTMTRzbFpGWDlxaHZsekxqZ1I3QzhhTTBNT2U2RjEvRHZ5NXhwYkVW?=
 =?utf-8?B?dGdQU0NTWkdON3pldDEvZFdTZ3RSQUd6eis4WEhKV2R0TjBEYlJqTGtoK3dB?=
 =?utf-8?B?TGxXaE5FZlNpVjlCcXd5RGF2RklDUHNEVE5JTjNIT3N3MHVsMEFkY0J3YTNQ?=
 =?utf-8?B?WmZvUTkyeGlDZ1VtaXozRWRXakMwYkI4QklVV1l5MlJvbnd6ZU1vT2RsenZ6?=
 =?utf-8?B?blcydXZZZTdSRWhFdm5pQ1RQREg5L0VXZEI4b1ZSTWxvKzNjS2l0YzJ3M2VZ?=
 =?utf-8?B?UklWdUdSUXlwbTFmOG9zR3hHVlYyeHh0UjV1dmV0ODJGbXVSL3A3dVhidkF4?=
 =?utf-8?B?b2pBdTBTK3V3VUNyNjBySlRUa1JDUUdRczFJdjg4d0lnVHVuckplYnJFNmxm?=
 =?utf-8?B?SitMUTE5TDFZc2lCMDFkaEp6VjFNOGhjUkxCbzBBandaZFU2OFV6R3lWdDVT?=
 =?utf-8?Q?BAYY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4050810b-fee3-4d57-8c7b-08db9f33bb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 15:07:53.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FmRjvFxAW0kzS0shyGY8KR7I+3ddxD18Gk0wzk97pmIcqsnN+fZKnAiH6MA9n4qMr+AfDQ2ZrcvryRfozyvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gSSB3b3VsZCBsaWtlIHRvIGdldCB0aGUgZ3BpbyBibG9jayBpZCB3aGljaCBjYW4gb25s
eSBiZSAwIG9yIDEgb24gQmx1ZUZpZWxkLTMNCj4gKG9ubHkgMiBncGlvIGJsb2Nrcywgb25lIHdp
dGggMzIgZ3BpbyBwaW5zIGFuZCBvbmUgd2l0aCAyNCBncGlvIHBpbnMpLg0KPiA+IFRoZSBhYm92
ZSBsb2dpYyB3YXMgYW4gImVhc3kiIHdheSBmb3IgbWUgdG8gZ2V0IHRoZSBncGlvIGJsb2NrIGlk
LiBUaGVuIHRoZQ0KPiBwaW5fYmFzZSBmb3IgZWFjaCBncGlvIGJsb2NrIGlzOg0KPiA+IHBpbl9i
YXNlID0gaWQgKiBNTFhCRjNfR1BJT19NQVhfUElOU19QRVJfQkxPQ0sNCj4gDQo+IEl0J3MgZnJh
Z2lsZS4gVXNlIGEgZGlyZWN0IGNhc2Ugc3dpdGNoIGZvciB0aGF0LCB3aGljaCB3aWxsIGJlIG1v
cmUgZXhwbGljaXQgYW5kDQo+IHJvYnVzdCAoaG93ZXZlciBzdGlsbCBjYW4gZmFpbCBmb3IgYW55
IG5ldyBjaGlwIHJldmlzaW9uL3ZlcnNpb24gd2hlcmUgaXQgbWlnaHQNCj4gYmUgYSBkaWZmZXJl
bnQgR1BJTyBsYXlvdXQpLg0KPiANClRoYW5rcyBBbmR5ISBXaWxsIGRvLiBIb3BlZnVsbHkgaXQg
aXMgdG9vIGxhdGUgdG8gY2hhbmdlIHRoZSBCRjMgaGFyZHdhcmUgYXQgdGhpcyBwb2ludCBzbyB3
ZSBzaG91bGQgYmUgZ29vZCA7ICkgLg0K
