Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5D7584F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGRSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGRSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:39:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85807F0;
        Tue, 18 Jul 2023 11:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqIAPVKeYi5GxV2mXnSgjb+PJXkM2rv/udngFZrbAtpH7u4CjVQfhM7AxY4JGB7l/8b+guLqdwR1fkWWp366uBTdTZNPkHxQK771DcHTnKmpFs6WitKddt5isEoxZPR0ao/75Z1eMd5kSqf+D/GJzbIlOR/0njxuYDCCKEuSzYoGUTSwAwGcMBajdU7L2iVg7kvATGKrZOf6UyNVm90D5xQD4xDf+faKef16fpRtcD8J1oGIdSAGmqDGh34RKiR1zN9n7nVt94UPxF0nNLv7M4DKAV6Wd8jFkVfuULdCGZ0B0JlOd3pPKi9CQMgScZFIAeZtz3FhmojHR+1JAcyTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzefbtvy0LhkfXGRlPDni9NptfeEhW+8vUs7K29QMIg=;
 b=kKEyk6GQLBv23OSp7Z/n52JeBdyfJDj3/iblCLTmOV2f6e1gqAlvC3/ZHSFXqYFicuCousA+36gMYDKh84Q/vKavF58GMYiydQTNxc1x4HHTrcO3O57Xb1+kWm2ywlSyMT6nvDRavnU/tuuUV3nKVDne1xbN/TAYaP8wDKGsGCbDArDgNmvwtf64lhC4fBGF1Y2R9i4SIc3XAXCHicdCW4S57O0GzATcm9A9mI8MMTNpqxm8rGrMPKZ8T0ANgI92mC1iGirsb+ukMXatGCUtuo0119Mg2IR51YWAzPQyWM/acv7Ljaeh7LN4/QJ/puiSwi0260LXau4SLdwutgtiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzefbtvy0LhkfXGRlPDni9NptfeEhW+8vUs7K29QMIg=;
 b=JSR5rC0jpAXXm4FxMduCU/fuBUjm//n6t5KejF0Om7EUrFhnZNTKwVtiyaPcP3fDpASVzsT76XEYN1WpoU9H+CGVRSb70BbLX+weoPvkd9yUyjMxiCPp+pcmpSQpDGS6s1XB86lSHL5xm7zr7OKO6XpbTqxmMQqKRrVBg2gv8JKgtAazdBI851uKyBSTFWTTyzI0BwBWG0CqGycYYKLZ2j2fMpgDYRSZ4HelLm4NmIIiAACGArsqlmy+8FeQPsqAxE30+zIhkwF812tBfXsdkHmyzOq9HmHGh/rAPMuj+tXhQCoNAeywW1ytc+D0NHUGYA2cuqYC7KRq8UhszrZY2A==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 18:39:40 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 18:39:40 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v5] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Topic: [PATCH v5] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Index: AQHZs3hprkZxTAvJN0GfKU73innAc6+/4ZKAgAAEgoCAAAENwA==
Date:   Tue, 18 Jul 2023 18:39:40 +0000
Message-ID: <CH2PR12MB38953B86B91D7529CF6DBEF5D738A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230710214910.31892-1-asmaa@nvidia.com>
 <CAMRc=MeQBSJ8Y92VfOfiaDjDyW44RunYt-D1aFraNaR_dTRVOQ@mail.gmail.com>
 <CAHp75VcKH4ZJ7HjjY6q_Woi2wAwnhiqyyPySOpK9Amt_SHB8ow@mail.gmail.com>
In-Reply-To: <CAHp75VcKH4ZJ7HjjY6q_Woi2wAwnhiqyyPySOpK9Amt_SHB8ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|MN2PR12MB4566:EE_
x-ms-office365-filtering-correlation-id: 737680ad-661f-4961-549b-08db87be5898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ruukzZXCP8ysIAJ0Or4+0e7BoIZWV1msCcI14jlxSn3BHU3DQzK5vlFIZbze6drORqozeby58HoJ3lnLFl1XbhoiUBu7zeFfrEa2uWjiH/geXR4HIwj+sa4OzThW/zafkW7I0vZFVYPgDarnKDGqQ53x/DUh+8QA2tRLslTcuSVP/jey73cZECoUdzmgzAVcXwrsooydbaXAPCYkEKVIbdKquFphBcWqo9PfWl3eiu1fjbba+n2sx+KGan+qXQEmbnwfHKc0FiBBh4MLhj2FrB5Uix1iTL8Dw2YsTZ/WafJeUm18adJ3Utf7tIZY0Pr8N29juOB8oEM6PuSxHhk4PN0chtCHHdrzH94+LywurGjSVSNNzYjsuucV7EbxPTV0KLRyM6584D2w9g5u9iN+vSTgPA+XBOGw+bWAGJGHD5th2WCBe0R0DSCtBS6aoTStHajoGJO+eDZSPgMnqXI+McV8VFCbgfjNaHMlcFreYQtqR2jWjEdvgrGauQBUMrvQ1x9ro91rW8jucR5k0pV726kv67rFQXeeKij6/03o56k/dBRmZAOwy+pYiEa1SLP1TVZietsPtGq8gxs4xqx6bHqfrhDJbzIMTH/is5k8EAisk4zDWtFWmVZcVvnWYgLR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(33656002)(107886003)(71200400001)(6506007)(38100700002)(186003)(26005)(55016003)(110136005)(478600001)(38070700005)(558084003)(54906003)(66476007)(8676002)(41300700001)(7696005)(66446008)(2906002)(8936002)(66556008)(66946007)(52536014)(316002)(4326008)(5660300002)(9686003)(64756008)(86362001)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0hJci9hNGF6SWx5QS8yZ2RUNFd5QkFiWGFvNjM1RWJ2WXVLSlh1ZDc0OHov?=
 =?utf-8?B?aXc1RkUzeXFjVHE3RzIwSS9rVmsvd2JOd1Y0ZDYzd25JbHp2ZnVEbEFGMmg4?=
 =?utf-8?B?WUJBUW4vZTVoRFZ3dUNKanhkUFhIRG4yd053aHM5VkZmbUc3dnh0ZDhtSTk0?=
 =?utf-8?B?dWw3OW9BTmxxUENlTGdVMnFIR2h0Q09jN1NEQStmbVJMM3FsQU9wVm44MXJh?=
 =?utf-8?B?UXV5N0ozekVtbnV0OGxlUFFmS2JYTnpPbFNHSVBDalVaZS9xSmNrMWZqVlBF?=
 =?utf-8?B?dWtnUmo0T29ieEdBVmIrVWtEVDFRSENWbGk4MFZtM0QzM052bDFFUG16YzEx?=
 =?utf-8?B?NjEvUjh3amFUcnJHcFpZa1NkcXFBdWxiZFcvUjJDK3BSTkVJSkhjbklBS1l4?=
 =?utf-8?B?NU9uM1BxNm5qV0crOHNrcDNFN2haNDF1UThVYjliWXBpdFFVbXR2V3JEcjEy?=
 =?utf-8?B?SlFhMWZoVm1mNU1wbVozaGoySDN0dGRHYmpJNzczcWs1WUQvQnVVZjRwRWI0?=
 =?utf-8?B?Z2tYSzhacEVxdVFUMythSzFuZ2VIbGNya0pFUCt1TW9PYjNvRzFEYjJFaitj?=
 =?utf-8?B?UlozbmJEaFUxUVlsQ1djblQrR0RqTDVNTG1QeUhuNmNaamNnUFFLR0d0T2Iw?=
 =?utf-8?B?czNFM1E1R3dqV0kvby9XUUZsVHUvRkJncDRLMjQ3Rk5EU2FNNFVnY0E2ZkJP?=
 =?utf-8?B?d2lLcGdUS2FidzREQUthQ3pzaWJJL0ttVWw3MHN3ZTdEZFZrRTV0cFQ5TmFC?=
 =?utf-8?B?Uzd0RG1waGlJWDVRUzZhLzhhUEl1MHZqYXpXR3VUUVNadXdQRDZKOFVjVWhW?=
 =?utf-8?B?THNxUFZvM2ZNVUZhTmNiMlNYSEtvZGJURzdvc1RUREdmamVzU3gzVFAvVG1S?=
 =?utf-8?B?QUdJRmVrTHR2NTNNVHdOMFNWZG5pRFlDeHdwWWNqbC9yclZmSkh3RmdEV3Bv?=
 =?utf-8?B?UjJSalBVSG1KblFJemZudG1BRFc1RGFORVEvVTZjRXcrTjQ3L3QrbEl0aWph?=
 =?utf-8?B?OGRXamlkcTBpUmt3bXBOT2ZNdEJNbitnMUVGZU1NSXpOdFZPZHQxcnJwZ2lC?=
 =?utf-8?B?Zyt2UGZxRkpBN21UVEk3Tm9RTEFKeGNnUkFNdGthem83RjZCTkdCQ2gzeHho?=
 =?utf-8?B?Qk1qbTQxNk1GMHJqY20ySm1BUjlXQUJsT2VvbktTUUlQTGRZZjJaWU9GdkIr?=
 =?utf-8?B?bDVKL1FIQzc2VDVteXVPY0xERE1qUmtLVVZrWTMzQTFXM0xNOTNCYmhNbTZn?=
 =?utf-8?B?K25nckFESXluRksya3I3MXlHK3RtL0o0N3VHbmFGWHdlalAxYllkR1ZqTnlp?=
 =?utf-8?B?NlhlN0p1SzQxRFhHdzlQQWh5R2NMM2tYeXhBalI4Z0xjbWVURTVndHNUN1hF?=
 =?utf-8?B?dlU5MnJLMnRyYkV0azRzRE5lOUJmRy9UY2xwUERRdi9OQnBoaXJ1NlNqMnpz?=
 =?utf-8?B?ZHM1K1dzMUNqcVVXZFZxd09zUGdiUE8zdXE3UEJENWtnZGkyVGZlcTdXUlVr?=
 =?utf-8?B?YTlNYld6S3BzUmlnRUR3Z0NveW5PRXkvTXZzbzFlYWRKN1RmejNTK1hwU1RZ?=
 =?utf-8?B?UDZGSloyd1VGK1QxVkxEU2lCVS9hWWZiZEE0RkRDRWQvWE5kL29LbUNjYW9Y?=
 =?utf-8?B?NnFhaW5QWHROODlsY092ZU1MdjZoWG1xNFN5d3JmemhHS2hZMzNocnl3U3c2?=
 =?utf-8?B?TnlRdUtLYVlhSHhBMm1kZXpJaENMWmZBSUVLSVlIV2wzUEEvOFluLzQ4bjZ6?=
 =?utf-8?B?L0tFdGx1SE1xK1k2SHJQNEcwRGJNYUNlUmdiMXI2VkMyblFoVnJZMkpDUUFp?=
 =?utf-8?B?MzBEdTlneUtLMEI3cU9RM29DTWdXQitUYXJTQ3RsaCsxSzYzUzFWd0sweE1M?=
 =?utf-8?B?eWI3QnUyOFd6MjBtWmp6cWxHT2VaTG9RSXRUdTdlTXhQOENHL0pGSktPT3hV?=
 =?utf-8?B?YWF0dkVsZG9tK2d4MjhDY1pGQVkxN1ZJSlhjVFVocVdoVXg1UzhZbVJWakl6?=
 =?utf-8?B?Y3dXR2JPTWFMTVFMNjU3S3pwbnZRRytxMTd0R3JpVWkyajQyK1FXMWhlR25k?=
 =?utf-8?B?SU56YmtuazFZQ0pUeEIrYU8yVm1vdHc3TnJaTzhXWG4yM0JtQVRFalNUOWRS?=
 =?utf-8?Q?5jIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737680ad-661f-4961-549b-08db87be5898
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 18:39:40.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os6rSu/Z8ZxuqfchV9JP/tBG+aRd9LkljNSmmWO6uf3WvW2cvE5fCU7O4AnNIC4qkTJeACfeo6rVlSiXhgNDWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiBBcHBsaWVkLCB0aGFua3MhDQo+IA0KPiBUaGlzIGhhcyBhIGJ1Zy4NCj4gDQpNeSBh
cG9sb2dpZXMgZm9yIHRoaXMgaW5jb252ZW5pZW5jZS4gVGhpcyBpcyBub3QgdGhlIHJpZ2h0IHBh
dGNoIHRvIGJlIGFwcGxpZWQuIEl0IHdhcyByZWplY3RlZCBieSBBbmR5LiBJIGp1c3QgZm9yd2Fy
ZGVkIHRvIHlvdSB0aGUgcGF0Y2ggdG8gYXBwbHkuDQpJdHMgb25seSBvbmUgcGF0Y2ggYW4gZGlz
IG5hbWVkOg0KIFtQQVRDSCB2MiAxLzFdIGdwaW86IG1taW86IGhhbmRsZSAibmdwaW9zIiBwcm9w
ZXJseSBpbiBiZ3Bpb19pbml0KCkNCg==
