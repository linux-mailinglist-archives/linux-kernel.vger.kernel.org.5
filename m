Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8B757A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGRL0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGRL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:26:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BAD8;
        Tue, 18 Jul 2023 04:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPbmBlEck9uqF4IoDrwHyrKd7xjXwx/YhKS7Y6UYtB+wcQG3GHthqm+KBuNBeZLUwcYRjr0GpWWANOdxklxuUfNhV1RHWB5K1jXtGO7zqSIvV6UNk75awV0D628Jvi6QsxbVZ/+xDQdm6M0MarWEtKqT7Zi/vLT9dtdTUn95C84uD20O7Rkd1qtxkhIKLWXz8iKWzUdD6C1AWeomaKD9JdNZ8rxVIWQBS+484w9rqxqwVc7q667eDjqJYXcVhV28iYOjfSjQewso4z6JZ1zwB9Uky0MKDUIxy+Kqt7vVgxeeJH3cB/cTy0jDDZB8kzXufl1kdpCjMmxnaGcxtrtGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c8AEu4V2C71dnhusXWys2CJF3pdSaQXpRh97Rm8kDE=;
 b=bz+ijoRwV5M0fH/AKo3xKmtjHsxi16JF0DQYqeJSzTVjXEb95v489SBUPacFlquD/ZXb6013FtlDNzJ0iIX+Dpz7BDre1KUBGr5mJBQKecxXS4AMSCYhvdutZiDbYULLwGZUvhwm5G/bvASlMPWzQlqsCCUjvc2/7URfhPz79v0t4c6rY5lGWJIQ0dsBOOuVZxB7QhCKBHGHQVp4f+U8x+agZ01CXec56/6vX25tza1DFE1qNBHFIWG08eowwlj4MiWRVHQHcToyfO+o86xMo7WzWL7J4KYzGzaKeiPoSr4Q7nuKK/j1ybSVtV1RozEodVIBya2KGGzO65cocUlN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c8AEu4V2C71dnhusXWys2CJF3pdSaQXpRh97Rm8kDE=;
 b=aAaYZBB5boOa3wDqH8mv62cAtdv1HjG2+xqSHseNJPLVoheMba1nnd7l4tjEGIqyARx5xD4cvAVb/H82rxe97kPdc91ol67UEh+xzsZYCG732c4fn/d8UJea+vW5Q5EQliD47W3YfkFlY3w4m+dqA2LtQHjFuWZhNjUZyNmmzgE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB10719.jpnprd01.prod.outlook.com (2603:1096:400:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 11:26:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 11:26:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Index: AQHZuULWGO/C9BN6KUGGSx2mRQXL7a+/Ym5g
Date:   Tue, 18 Jul 2023 11:26:28 +0000
Message-ID: <OS0PR01MB5922D3163524299B94166B178638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
In-Reply-To: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB10719:EE_
x-ms-office365-filtering-correlation-id: ef1393df-3f4b-4bc3-8e3c-08db8781d42a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xzWOXfFP7KlYccuxg/3rMqaI3OlL92hHpr7wdrtpg4fLoZ1qAjcYZqlcGQXH6x4v3DFP+RsjGs9+wuR8fQZO8CnMpkr+4oovP/HCRf/POI6dGocog5Qx+8tT1VDzKGLMKLL0yKUue+w3N+N0gGeNNJ5F/ZJAnPFFKTDDJseg0JQYX4c7eNnGgTUe6MKuLaFjXLLd/IxQbjTYKWEw0Z6FcpQ2OLdX0Yu9YdAUst4M0h/IG7DPi/jhbfDncQer34e/Q1N/EkIJ2U/7RHA1ZN7YC1CRpagyYgY4JQTLVCUZjeb4V85BApPLFiIL7Kt9jdcZt+pXOqBk7xss70Ni/+fzCI+8lv5U4IQjh6Co7isTUaNqx/UG62QMZk1o6grx/6zB/53S4ca3MYLkqTpEctnoNI2EamD7jln3ym7xLKMKS+FGMkzbYC3mCnl7mAl0biNEW8WCggdVMTmwhym31kL1yWTmiqTeVCw1mSeVMnWw0JFgL0QqDRgP2jsAQ4wqxfimCjnLv6kudaPGR4u+0bW59u8EZhOqBK3ZNbYuWmf9DWjgGSESxwdnK3kZ8DSH+TzkVP0d0uJxP3ZFHOCwlLOGuH6kIcj29iETwScKH3EUeGnfwl1ioNR4DGVJWb+krn4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(66476007)(66446008)(66556008)(54906003)(110136005)(86362001)(186003)(64756008)(66946007)(76116006)(4326008)(478600001)(41300700001)(9686003)(316002)(7696005)(71200400001)(38100700002)(8676002)(8936002)(38070700005)(5660300002)(52536014)(6506007)(26005)(55016003)(2906002)(66574015)(83380400001)(122000001)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3ppR1pFVDhMU3c2YjVCTmNwajJ1c1hmeVVTNlUzM2hTVTVNS1Ara2tyMGFT?=
 =?utf-8?B?WDJmSXZHc0R6bGYydDhSMTdnT2JmVjVGbk5SenFuRWo1MXluWWdhRDNQTlJU?=
 =?utf-8?B?K3M0SWl6eTRteGJ6MWdpMjcrTDY4cmlzVzJaTTNOZm5pOVhGT2FSV29JazBL?=
 =?utf-8?B?eGhNZDhLSndJa1ZYdUhWZXlEWFk2R0FVS05GblJ6SUkrNEpWNCtZYnNlRG9G?=
 =?utf-8?B?U0JZQ0pYK0VIczVrRThyazFoNlNOZHorUmtOdUZGdkxlQzcvam1rWk96cXZZ?=
 =?utf-8?B?SVFFZktGY1RxVzRCMm14bEZTem8xTXA4R2NLZkd2ZXEwdGlJZUlqRXpxLzcy?=
 =?utf-8?B?TkFEYkg5YVpKWU9RTTVqYk1MS2ZWZktiOGpzNnVKckFDMUYzbU92dzZ6eWtK?=
 =?utf-8?B?Nk9uQkRNaFdpOUpzeTYzN3hVZlVxemExc2FrMkxaYTduVmY1d1pnUVdHMm1k?=
 =?utf-8?B?aDdOa0hqQTFVcGVsd3RNOWtoTEFSandFbGxpNlBsRCttWWV6NUlGL3ZTc1Nl?=
 =?utf-8?B?VFEwdFhJeGlwRVcrNTk1NEhXdTFtYzQ0bGVnNnFoQVlmZVBIMEUrTFNwa3lh?=
 =?utf-8?B?eUpucWhzd0kvanErdXpHc3c2MVdkWmdoOUZTekpQVzV3d2kwbjV5TXFUenlU?=
 =?utf-8?B?cVRydGtETTVhZlFsdFkrZGZjOHE4TVZvWk5qb2FVdFBqYUtUc1dob2YwZzhD?=
 =?utf-8?B?elZ1SDFhcjB4U2dwRXYyL293bWZDSnMwUXRDNE5Cakgvc0dBTTlFTWZ0aG9t?=
 =?utf-8?B?ZDUvbHluRTEzSnhKeXY1cmljVVM5Z1FTZTlHTmlBQkdySk5kdEZ6Y1p3bDFL?=
 =?utf-8?B?bTJRL0tIZTlxOVZNVGFSa3BRb05haDM2ZGhpSkpqS0FEN0ZqVEpvcFo5WVh4?=
 =?utf-8?B?dGdtZ3M4ZThPSDh0Yzg0cFYvWHoxdVhmQURZblpjMTd2bVRIUVlmclQ4ckRF?=
 =?utf-8?B?Si9uQk14WG11bi9YdWVuUnNMQ1FCT2JtZXlpZDlzdlJxb2hGdG81WXpPU24r?=
 =?utf-8?B?eSt5UVlNSGlNYUJXY1NDU1dEeS9yajRFMjd5SWxabXd5RGJFUjhsMG5GZk5p?=
 =?utf-8?B?OExCNlNuTGp4aW9ma1loVVJnK0E2c1BiYk5RSmNPM25RUHk2elpvUXovaWQv?=
 =?utf-8?B?Uks3dVlORTN2V21BYkFxL1E0OW51NjNmQ3dkU2dhVUNPbzUzQnorTk8yTWIz?=
 =?utf-8?B?QXdueG1lVTVGa0gzdVA1Z2hQdTU2bFgxR1NvUkpKUHhBbVF5SkVYcXhmVnM2?=
 =?utf-8?B?Q24vU0pYY2ttZWNJQTNaVldDSzlzMWFJR2szZFl2U2N4UkgzaUNxNGtyOU9p?=
 =?utf-8?B?cEZoLzgzRWVJUDN2RUhxeEt5TXZXTEkwd3ZCZEE1cWxwYmNSQUprVFhodWQr?=
 =?utf-8?B?dngzWGtvQmsxSHJKWEZTOFRyekZwZW5KUVVsK3hDby9Ea0ozWEU0WXZNZExm?=
 =?utf-8?B?NmZKNVE4R3NOc1RNQnIvb1NQNW1MQ2FTbmJLZ2R6VTJVczg4RUtyZlNwTHlG?=
 =?utf-8?B?a2tHWlR4TG82N2MxUEdIdFZVczB0bTBjOG9Hcm9LS2YrcW9MaWlBWVpvb3VX?=
 =?utf-8?B?TFhZa1o3T1lEeHR0bTB5L3V4VWhPRytUSDd5djhVNWp0OUc5bkd6c1pYTTVF?=
 =?utf-8?B?WHBCdmo5NW5CbDNxeUJMbmc0ZkJDdksxVEpPQjZlZ29mMWdWUmp4ZUxlSXM1?=
 =?utf-8?B?eW9iaU9vdm4rdnZEekZQWUp4MlB5U2p4NEpIQzFjTENxUVROZ0NBWkhJY3d4?=
 =?utf-8?B?dUxLQXAreHVvQ1dScldMaEtLVVlDRlpNdzhKSTJUSW9sVkpJd3VldWZoVTlH?=
 =?utf-8?B?R3A2M2VxSzdiQUhZUndWVjBxTzlBSG4xcUo1MWNacFRVMThzSnd3MTdqNDRo?=
 =?utf-8?B?UjkxbzIvYjRMUkFwN1RBY2EvQ2l3RldTZDlRaTYyb0xUZnl5S2E2SGVkVmlr?=
 =?utf-8?B?MGhQYUY3TlRMak1NdzJMbktEY0N4Rmc4L29LSWpXS1g3VGlGbUVIbXhTNlU0?=
 =?utf-8?B?Qmo2WVNtcjFQblVLTDVQcW0xM0RoMmpzSmdZdzlIYy9DTEJveUJRSEhNS2Zw?=
 =?utf-8?B?RGdFSXRVMmtjWGZRSDZMVlNRMHEyR3ByWGFOZnRWMFZ1SFl2OHJOeWlFWXdH?=
 =?utf-8?B?UUxaQ2MvUmlBcFdYRG43alI4cXhnalVCeG9TdCszazBQR1VLb1VwakpIWUVB?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1393df-3f4b-4bc3-8e3c-08db8781d42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 11:26:28.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FV+Je5FUznvHXVlIbRfSMx0HJ4UGRqit6ExFopMQl3YBA76N6j/Yc0g44/IoGKp/qlRVWNVbZKPL0+OUlJnkuJ0Y6guAb3dlIWQjP4A4jSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10719
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkg
RHVubGFwIDxyZC5kdW5sYWJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE4LCAy
MDIzIDc6NDEgQU0NCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXB3
bUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT47IFRoaWVycnkgUmVkaW5nDQo+IDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+OyBVd2Ug
S2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUtDQo+IGtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU3Vi
amVjdDogW1BBVENIIHYyXSBwd206IGZpeCBwd20tcnotbXR1My5jIGJ1aWxkIGVycm9ycw0KPiAN
Cj4gRnJvbTogUmFuZHkgRHVubGFwIDxyZC5kdW5sYWJAZ21haWwuY29tPg0KPiANCj4gV2hlbiAo
TUZEKSBSWl9NVFUzPW0gYW5kIFBXTV9SWl9NVFUzPXksIHRoZXJlIGFyZSBudW1lcm91cyBidWls
ZCBlcnJvcnM6DQo+IA0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21f
Y29uZmlnJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzozNzQ6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8gYHJ6X210dTNfZGlzYWJsZScNCj4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUz
LmM6Mzc3OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUn
DQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV93cml0ZV90Z3JfcmVn
aXN0ZXJzJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMTA6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfd3JpdGUnDQo+IGxkOiB2bWxpbnV4Lm86IGlu
IGZ1bmN0aW9uIGByel9tdHUzX3B3bV9jb25maWcnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1
My5jOjM4MjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3dyaXRl
Jw0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fd3JpdGVfdGdyX3Jl
Z2lzdGVycyc6DQo+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MTEwOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvDQo+IGByel9tdHUzXzE2Yml0X2NoX3dyaXRlJw0KPiBsZDogZHJpdmVycy9wd20v
cHdtLXJ6LW10dTMuYzoxMTE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZi
aXRfY2hfd3JpdGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9j
b25maWcnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjM5NzogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgcnpfbXR1M19lbmFibGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGBy
el9tdHUzX3B3bV9kaXNhYmxlJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyNTk6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF93cml0ZScNCj4gbGQ6IGRy
aXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjY0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGBy
el9tdHUzX2Rpc2FibGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3
bV9lbmFibGUnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjIzMDogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3dyaXRlJw0KPiBsZDogZHJpdmVycy9wd20v
cHdtLXJ6LW10dTMuYzoyMzQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJp
dF9jaF93cml0ZScNCj4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjM4OiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGByel9tdHUzX2VuYWJsZScNCj4gbGQ6IHZtbGludXgubzogaW4gZnVu
Y3Rpb24gYHJ6X210dTNfcHdtX2lzX2NoX2VuYWJsZWQnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnot
bXR1My5jOjE1NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcnpfbXR1M19pc19lbmFibGVkJw0K
PiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxNjI6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8NCj4gYHJ6X210dTNfOGJpdF9jaF9yZWFkJw0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlv
biBgcnpfbXR1M19wd21fcmVhZF90Z3JfcmVnaXN0ZXJzJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6
LW10dTMuYzoxMDI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hf
cmVhZCcNCj4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MTAyOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvDQo+IGByel9tdHUzXzE2Yml0X2NoX3JlYWQnDQo+IGxkOiBkcml2ZXJzL3B3bS9w
d20tcnotbXR1My5jOjEwMzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M18xNmJp
dF9jaF9yZWFkJw0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fZ2V0
X3N0YXRlJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyOTY6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF9yZWFkJw0KPiANCj4gTW9kaWZ5IHRoZSBkZXBl
bmRlbmNpZXMgb2YgUFdNX1JaX01UVTMgc28gdGhhdCBDT01QSUxFX1RFU1QgaXMgc3RpbGwNCj4g
YWxsb3dlZCBidXQgUFdNX1JaX01UVTMgZGVwZW5kcyBvbiBSWl9NVFUzIGlmIGl0IGlzIGJlaW5n
IGJ1aWx0IGJ1dCBhbHNvDQo+IGFsbG93IHRoZSBsYXR0ZXIgbm90IHRvIGJlIGJ1aWx0Lg0KPiAN
Cj4gRml4ZXM6IDI1NGQzYTcyNzQyMSAoInB3bTogQWRkIFJlbmVzYXMgUlovRzJMIE1UVTNhIFBX
TSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkLmR1bmxhYkBnbWFp
bC5jb20NCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6
IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IENj
OiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiBDYzogbGludXgt
cHdtQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gdjI6IGZpeCB0eXBvIGluIFN1YmplY3Q7DQo+
ICAgICBjb3JyZWN0IG15IGVtYWlsIGFkZHJlc3Mgd2hpbGUgaW5mcmFkZWFkLm9yZyBpcyBkb3du
Ow0KPiANCj4gIGRyaXZlcnMvcHdtL0tjb25maWcgfCAgICAzICsrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLSBhL2RyaXZl
cnMvcHdtL0tjb25maWcgYi9kcml2ZXJzL3B3bS9LY29uZmlnDQo+IC0tLSBhL2RyaXZlcnMvcHdt
L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9wd20vS2NvbmZpZw0KPiBAQCAtNTA1LDcgKzUwNSw4
IEBAIGNvbmZpZyBQV01fUk9DS0NISVANCj4gDQo+ICBjb25maWcgUFdNX1JaX01UVTMNCj4gIAl0
cmlzdGF0ZSAiUmVuZXNhcyBSWi9HMkwgTVRVM2EgUFdNIFRpbWVyIHN1cHBvcnQiDQo+IC0JZGVw
ZW5kcyBvbiBSWl9NVFUzIHx8IENPTVBJTEVfVEVTVA0KPiArCWRlcGVuZHMgb24gQ09NUElMRV9U
RVNUDQo+ICsJZGVwZW5kcyBvbiBSWl9NVFUzIHx8IFJaX01UVTM9bg0KPiAgCWRlcGVuZHMgb24g
SEFTX0lPTUVNDQo+ICAJaGVscA0KPiAgCSAgVGhpcyBkcml2ZXIgZXhwb3NlcyB0aGUgTVRVM2Eg
UFdNIFRpbWVyIGNvbnRyb2xsZXIgZm91bmQgaW4NCg0KDQpUaGUgYmVsb3cgcGF0Y2ggYWxzbyB3
b3JrcyBmaW5lLA0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vS2NvbmZpZyBiL2RyaXZlcnMv
cHdtL0tjb25maWcNCmluZGV4IDFjOGRiYjA2NGVlNS4uNTZhYjJmNGI5MWZlIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9wd20vS2NvbmZpZw0KKysrIGIvZHJpdmVycy9wd20vS2NvbmZpZw0KQEAgLTUw
NSw3ICs1MDUsNyBAQCBjb25maWcgUFdNX1JPQ0tDSElQDQogDQogY29uZmlnIFBXTV9SWl9NVFUz
DQogICAgICAgIHRyaXN0YXRlICJSZW5lc2FzIFJaL0cyTCBNVFUzYSBQV00gVGltZXIgc3VwcG9y
dCINCi0gICAgICAgZGVwZW5kcyBvbiBSWl9NVFUzIHx8IENPTVBJTEVfVEVTVA0KKyAgICAgICBk
ZXBlbmRzIG9uIFJaX01UVTMgfHwgKENPTVBJTEVfVEVTVCAmJiBSWl9NVFUzKQ0KICAgICAgICBk
ZXBlbmRzIG9uIEhBU19JT01FTQ0KICAgICAgICBoZWxwDQogICAgICAgICAgVGhpcyBkcml2ZXIg
ZXhwb3NlcyB0aGUgTVRVM2EgUFdNIFRpbWVyIGNvbnRyb2xsZXIgZm91bmQgaW4gUmVuZXNhcw0K
DQoNClNvIHNoYWxsIEkgc2VuZCB0aGlzIGZpeCBpbnN0ZWFkLg0KDQpDaGVlcnMsDQpCaWp1DQo=
