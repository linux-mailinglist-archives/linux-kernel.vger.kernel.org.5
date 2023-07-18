Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D257577C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGRJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGRJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:22:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050FE0;
        Tue, 18 Jul 2023 02:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuQxySCUiLMP5RYu5U773O7UpRrm9ZQlkUSeJmIQ7b3jin7+xUiIQi6rsXzVd3dbA5nZlATSh6/Ol5VLLg9R2uFwBqP4RqIeIaJsQtzeIVEnPKZZU08oB72z/fY2/by04KQ3tSIe9RjANI5XpQW13hdlUlHqUF8bniv50ssVJYTzNtZrm+vQ2gK5lChtE2skcH3H4GbNHmRFdnbQXhwT3KtsnxwkczYo9b/ElQO4DNxddWfSoC+nOCPE4egZeOV+kl/5g2cbQXK/T+HJAB4lcF6wkmi7Cj8vpXgVKMDEmu6dcK8qV6CuRPnnTvD1weOEktDra9o9MIJxSJvGMODkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv6Szlg73K+U6+oPwk20aSc0kvPFXk7TX1a4otgpLDE=;
 b=RxS1a0GwMT/lybBfMZOu1G3+OaWKwneMlWwFHv+EhbzOVjIPKibnpqCdata6K03hWuelnVfKkJOZaYc3Nhu0kBmiAtEOOlGO3JOzh0ErDUvBSTLenHOeafdLiN/mvJXV8mTeh22z7WW6cIw4osSGIB6B7d9CkK58EiqHKrOsXpo7AVWWuckt759diRoF6Rdg8yUcRxU2TJUZg7mWOBlqpmZNXacZ9UeGC3fhKc0dRcCAF1iKF0BLdq5L5J88dmR1kcHrpEmf7O0Sl1BTEV7aAVmZJCIvq4LXSmgFEXjbzAMRzdzQ63RwJ23MyWQvBI9JmAy6ojD5vSCbjhOja8Iipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv6Szlg73K+U6+oPwk20aSc0kvPFXk7TX1a4otgpLDE=;
 b=SYrJcc3XAfISZUTB3uRsz7J3VYJ5leuXfj+GPNPecARWxDRMUf1VxPCmDQON0+Nq61/agSitfe0hDisHus80bcHSv0ed7JvQ/3CQAWusuFU8xUXKyFKYkq15uHc3dRZt+ZUP63/OumNNpuWlACzyjofqx58eZZHvNd04NBKV4bM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6029.jpnprd01.prod.outlook.com (2603:1096:400:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:22:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:22:46 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Randy Dunlap <rd.dunlab@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>
Subject: RE: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Index: AQHZuTz3JvYeSdheY0298OUyurLS6a+/OhiAgAAEgIA=
Date:   Tue, 18 Jul 2023 09:22:46 +0000
Message-ID: <OS0PR01MB59226EBBB8D65ACFE23E12D08638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
 <20230718090023.wo6m6ffzaifgctkj@pengutronix.de>
In-Reply-To: <20230718090023.wo6m6ffzaifgctkj@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6029:EE_
x-ms-office365-filtering-correlation-id: 88392ac9-e010-4af5-42b3-08db87708c51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQvMfAceFBrev8V++pltRbTWrx+UhmAgfGRq5EoDNytolzPyHUYgF0ttDyi08cntAeeCkZbpjWMRb3JSg+FYrlB3CkxWqe0Bzaatj/mikl6gYJ1acPex8U5gqTMI7vJwC5mTvDNJYuIAdcwtYU/gJsc6az7UWW5rLwTf5AMPf41Ts1FGyyzdZerlV8/VQEkWlvEF8Jthj+/F3t4cYLyZHEjE3IlhhOBTiO334dut6WuOi6FikZkU/fCBKV72DHK1du6O92quCIeui2VXASj1b8J6sgV51MKAi9mOasofXNZrxbSkyaIhRF53fFjyuxY+/I0zheFu0+ee0wKbd2U2f6CiWQXEUgGx5yWJrNOe5bV/3q+RR3o8pcr7IFV5iZmLRaeDWUS9+BXRQe9wGWAD70fghLhsotBsLWgP5OUmkJWbd+OmT/NV1e9cUjoFjc2jaFD0EpEFfMxkwYjI9w0SO/Hc7JoqYiyhwaJsjQzcvLRexrN5PleAn/Hx/3NYQvqgLFdbvSTciGWTtH2PrcEyqF+AwRAe34mDZE1lwFOXXSwtPUS/XD0gqwyM5y6864B9nXYpy2APVHgqHPuAO+lDliyCtla/xWOdAQ/ZGaqv17w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(71200400001)(7696005)(110136005)(54906003)(478600001)(66574015)(83380400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(6506007)(26005)(186003)(53546011)(966005)(9686003)(38100700002)(66476007)(122000001)(76116006)(66946007)(64756008)(66556008)(4326008)(66446008)(316002)(41300700001)(8676002)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFhrSlBnUFB5azRDaG12SzA0RzAxdWRSUGRaVkNpT1M1VzFzV1cyWUdCQk00?=
 =?utf-8?B?a3dMNzZ3TFQ0ekw4ZkI2bm5JUjVqdlMvc3JpcmJTVzdiNTVxZWQ1QVh2cUg4?=
 =?utf-8?B?YWk3Q3J3d1RuUXovZU83aGgxUGtBdmxsTVpRdnZmaEhwRnFWajk2a2VvL1dB?=
 =?utf-8?B?c3RmbmVTd09DWi9lMmdIWGFDQVNnQmQ0ZUJKNFB2T2JTZ0loZmVvSUoxZXd6?=
 =?utf-8?B?SjVkOFZnZ1JPb2dmY293OExIZDFMbHRFVVIxWXM4cEg1RjRZWitMYmtLQklC?=
 =?utf-8?B?VitqVG5hZE94VGZ6SGlNZXQ4SW43MEN1WEdzV3djQ2g1MmIxU1hRMjVra0E5?=
 =?utf-8?B?T2RKR0dTaU1qUm0rWkV2S01FT2lrQmcyOHZ1WFdteFlrSks2MDVDRyt3UFdH?=
 =?utf-8?B?b3Nid0lJNktCQlpwWk5XTDBlZGZPbVlDOFhra3hOd1hTNERQdURwMmlEOUd6?=
 =?utf-8?B?SWd1b3VhWjNsWWliSEd3T3RoSmlvQ0xVWVU4cUFVQmh4VzBLeHV6aHlRVDIv?=
 =?utf-8?B?Uy9XeG15TCtWdEEwQjh2OEIvczNOK0JFRzRqMEVIREJ0cU5UdFczNTJDSHpI?=
 =?utf-8?B?TEpseUY5TWhXK1JaN0lFQlRvS3FFVGhIVWRvTjRzbThhQlYzcFRiVTZUWTA5?=
 =?utf-8?B?ZkdRbE9TYUVKNXFNYTd6QTJZd0txMTEzR3NhZTI4alVpd2d4UjZncTRnYyts?=
 =?utf-8?B?eFJHM1YxcXUyTXJXZno5a2xWditydVU4ZXFDUDZzanNVN1ZhRnpEclJDN2NT?=
 =?utf-8?B?UkxHdjhac09DUklLam5DV1p1LzlQYjJpTU41cTUreU0xM1lRVGo1ajZYL1p2?=
 =?utf-8?B?WnhRMnFVak4vaUdzaWh3MVMxamxGc3QxajdRNHNycTUxb0ZUSi9IVlczWTZJ?=
 =?utf-8?B?cC8wd2doRnZjWXBqZzVqY1RaTG1FQW1ncC9ncGJFV0QwVXdGeng2MloxRmFC?=
 =?utf-8?B?QTlVckU5ZC9wZFh3YnlabkFEUlQ4VHVoeUY5TnpXaDJURFIzZE5mQmdESStR?=
 =?utf-8?B?QVg3MFltY0NFYzcwSmltY2ZOSm9pMGsyNlByRGNtR3hnTUlIQTVBRWZHbCto?=
 =?utf-8?B?NlZPek1lMFN5T0RzN2M1bjB4L1ZsZlpuOC85Y3ZycThNcS9KR25hdHZXeWk5?=
 =?utf-8?B?blZubEsvU2hXbFFKNk81Z0lTa2oxSXNiYXZ6QlpJQkdsTFRYekpDSGY3TXB0?=
 =?utf-8?B?bVMvS01hRUlVS2pYK2M0MzJnZW5aRUdWQ291VDRqUTNBTFpnZmp6QmhqcVNB?=
 =?utf-8?B?UVA1K1ZRekxuNTMwUnNmYlhwa3BIZWJvTVZXeEF1VXNnYXRzRXlWM0poR1R4?=
 =?utf-8?B?YTJrWXJBUjFsdFd4RG54RHRvWW5zMWJyOXdnaVQvK1V4UWc0Z2dZd3VGMWlU?=
 =?utf-8?B?TG44SGJsRlBDNEhNaFdYSEpnRXg2Ujcvc0s1SG54MEE1eUkyQWd6SElZS3Fx?=
 =?utf-8?B?NUg5YUprOVBhd0FhM1hybGM4V2hiQzRkR0RKNnFTNGljcVVHYlluQVNNZklL?=
 =?utf-8?B?SzRUWkhPUkgwYi9JeDNhbm1TK2s0MHRycWllS2JTT2psS0MxMjM2bkpLTFFJ?=
 =?utf-8?B?MXZPdE50M3VuNEptYlRVbnJpeGxVT21jQTY2MEMxaktXTmtLZ2g0aW91d0ZJ?=
 =?utf-8?B?NGNDRFQrVEQxeURWeWx0cEwzeVBkSHR2b1NzSmlCc1k5bWJZTHF5SzZTclNz?=
 =?utf-8?B?NUVTanJDUEV1UXlBYTdGNVNHaGo3U29kbmtsMTJVNjFIb2ZZWGpCcjdWWGhS?=
 =?utf-8?B?amNIRHRCRzFQQjZzcDkxa1J6N05mdEJrLzdyVk1ndVV1ZmhhbElmSHloN2FU?=
 =?utf-8?B?MTdXaGxvdDBLTHVFTCtHTEpKWGVZOEdNWUg5dmFRSWhFZVY1K3lvUmtxQ2VM?=
 =?utf-8?B?L3phTnFEMmFCeFFmWTdCTDBSSnA2RUlkcy9DTlJnTUx5ZUgzV2lmY0Uydmsw?=
 =?utf-8?B?Sk9lRGdxaUcwSE5yK0hQQTJiL080N0NhR1ZVK21Ba0hTVGpINkYrN0lLendR?=
 =?utf-8?B?RTFwbFRlWm1oekVxSUdaZGZxYno4alNkc0x1Q3Fuc1JLN3FKdHc3dEtXMm50?=
 =?utf-8?B?L3ZPTDMyYmZRQWVqZXdHa09jOFFyd1p2bFdGUWNUeUI5eExuOVdJaGMvMGhQ?=
 =?utf-8?B?QWwvNW1Vd0hOODFHVTdrWWZVbTVlbkh1Q0QrSXFESXA3Q1FhMkJhT3MvRzE5?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88392ac9-e010-4af5-42b3-08db87708c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 09:22:46.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5R3W1WuJJBU+tzKsmiz7htaI4w0Beef757tidqZ0c5J18zIwkoIwUuW/SdhkUDOQQmaWkOUG0OG4mjn7n0Z8bUNKGBy/xS6CBOD5HOtEitw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgVXdlIGFuZCBSYW5keSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBT
ZW50OiBUdWVzZGF5LCBKdWx5IDE4LCAyMDIzIDEwOjAwIEFNDQo+IFRvOiBSYW5keSBEdW5sYXAg
PHJkLmR1bmxhYkBnbWFpbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBUaGllcnJ5DQo+IFJlZGluZyA8dGhpZXJyeS5y
ZWRpbmdAZ21haWwuY29tPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsN
Cj4gTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcHdt
OiBmaSBwd20tcnotbXR1My5jIGJ1aWxkIGVycm9ycw0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiBN
b24sIEp1bCAxNywgMjAyMyBhdCAxMDo1OTowMlBNIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6
DQo+ID4gRnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+ID4NCj4g
PiBXaGVuIChNRkQpIFJaX01UVTM9bSBhbmQgUFdNX1JaX01UVTM9eSwgdGhlcmUgYXJlIG51bWVy
b3VzIGJ1aWxkIGVycm9yczoNCj4gPg0KPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGBy
el9tdHUzX3B3bV9jb25maWcnOg0KPiA+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6Mzc0OiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGByel9tdHUzX2Rpc2FibGUnDQo+ID4gbGQ6IGRyaXZlcnMv
cHdtL3B3bS1yei1tdHUzLmM6Mzc3OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUz
XzhiaXRfY2hfd3JpdGUnDQo+ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNf
cHdtX3dyaXRlX3Rncl9yZWdpc3RlcnMnOg0KPiA+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6
MTEwOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzE2Yml0X2NoX3dyaXRlJw0K
PiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9jb25maWcnOg0KPiA+
IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MzgyOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+
IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24g
YHJ6X210dTNfcHdtX3dyaXRlX3Rncl9yZWdpc3RlcnMnOg0KPiA+IGRyaXZlcnMvcHdtL3B3bS1y
ei1tdHUzLmM6MTEwOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzE2Yml0X2No
X3dyaXRlJw0KPiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjExMTogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M18xNmJpdF9jaF93cml0ZScNCj4gPiBsZDogdm1saW51
eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fY29uZmlnJzoNCj4gPiBkcml2ZXJzL3B3bS9w
d20tcnotbXR1My5jOjM5NzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcnpfbXR1M19lbmFibGUn
DQo+ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX2Rpc2FibGUnOg0K
PiA+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjU5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
DQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1t
dHUzLmM6MjY0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzX2Rpc2FibGUnDQo+
ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX2VuYWJsZSc6DQo+ID4g
ZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyMzA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4g
YHJ6X210dTNfOGJpdF9jaF93cml0ZScNCj4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMu
YzoyMzQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF93cml0ZScN
Cj4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyMzg6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8NCj4gYHJ6X210dTNfZW5hYmxlJw0KPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9u
IGByel9tdHUzX3B3bV9pc19jaF9lbmFibGVkJzoNCj4gPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1
My5jOjE1NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M19pc19lbmFibGVkJw0K
PiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjE2MjogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3JlYWQnDQo+ID4gbGQ6IHZtbGludXgubzogaW4gZnVu
Y3Rpb24gYHJ6X210dTNfcHdtX3JlYWRfdGdyX3JlZ2lzdGVycyc6DQo+ID4gZHJpdmVycy9wd20v
cHdtLXJ6LW10dTMuYzoxMDI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZi
aXRfY2hfcmVhZCcNCj4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMDI6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfcmVhZCcNCj4gPiBsZDogZHJp
dmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMDM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6
X210dTNfMTZiaXRfY2hfcmVhZCcNCj4gPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpf
bXR1M19wd21fZ2V0X3N0YXRlJzoNCj4gPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjI5Njog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3JlYWQnDQo+ID4NCj4g
PiBNb2RpZnkgdGhlIGRlcGVuZGVuY2llcyBvZiBQV01fUlpfTVRVMyBzbyB0aGF0IENPTVBJTEVf
VEVTVCBpcyBzdGlsbA0KPiA+IGFsbG93ZWQgYnV0IFBXTV9SWl9NVFUzIGRlcGVuZHMgb24gUlpf
TVRVMyBpZiBpdCBpcyBiZWluZyBidWlsdCBidXQNCj4gPiBhbHNvIGFsbG93IHRoZSBsYXR0ZXIg
bm90IHRvIGJlIGJ1aWx0Lg0KPiA+DQo+ID4gRml4ZXM6IDI1NGQzYTcyNzQyMSAoInB3bTogQWRk
IFJlbmVzYXMgUlovRzJMIE1UVTNhIFBXTSBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJh
bmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+IENjOiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gQ2M6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+ID4gQ2M6IFRoaWVycnkgUmVkaW5nIDx0aGll
cnJ5LnJlZGluZ0BnbWFpbC5jb20+DQo+ID4gQ2M6IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gDQo+IFdoaWxlIHRlc3RpbmcgaGVyZSBJIGhpdCBhbm90aGVyICh1bnJlbGF0ZWQpIHByb2Js
ZW06DQo+IA0KPiBkcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6ZzJsLmM6IEluIGZ1
bmN0aW9uIOKAmHJ6ZzJsX2dwaW9fZnJlZeKAmToNCj4gZHJpdmVycy9waW5jdHJsL3JlbmVzYXMv
cGluY3RybC1yemcybC5jOjkxNzozNzogZXJyb3I6IOKAmHN0cnVjdCBncGlvX2NoaXDigJkNCj4g
aGFzIG5vIG1lbWJlciBuYW1lZCDigJhpcnHigJkNCj4gICA5MTcgfCAgICAgICAgIHZpcnEgPSBp
cnFfZmluZF9tYXBwaW5nKGNoaXAtPmlycS5kb21haW4sIG9mZnNldCk7DQo+ICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCj4gDQo+IERpZCBzb21lb25lIGFk
ZHJlc3MgdGhhdCBvbmUgYWxyZWFkeT8gSSBndWVzcyBQSU5DVFJMX1JaRzJMIHNob3VsZCBzZWxl
Y3QNCj4gR1BJT0xJQl9JUlFDSElQLiBBbHNvIFJaX01UVTMgc2hvdWxkIHNlbGVjdCBNRkRfQ09S
RSBhcyBJIGhpdDoNCj4gDQo+IAlhYXJjaDY0LWxpbnV4LWdudS1sZDogcnotbXR1My5jOigudGV4
dCsweDU0NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UNCj4gdG8gYG1mZF9yZW1vdmVfZGV2aWNlcycN
Cj4gDQo+IENvbW1pdCA2NTRjMjkzZTE2ODdiMzE4MTlmOWJmMWFjNzFiNWE4NWE4MDUzMjEwIGFk
ZGVkIFJaX01UVTMgYXMgYm9vbCwgYW5kDQo+IGl0J3Mgc3RpbGwgYm9vbCBpbiAyNTRkM2E3Mjc0
Mi4gSSB0aGluayB0aGUgcHJvYmxlbSBzdGFydGVkIG9ubHkgd2l0aA0KPiBiOGIyOGI3MThkZGQg
KCJtZmQ6IEFkZCBtb2R1bGUgYnVpbGQgc3VwcG9ydCBmb3IgUlovRzJMIE1UVTNhIikuDQoNClNv
IGZhciBQV00gaXMgYnVpbGQgdGVzdGVkIHdpdGggDQoNClJaX01UVTM9eSAsICBQV01fUlpfTVRV
Mz15IGFuZCBtLCBSWl9NVFUzX0NOVCA9IHksIG0NCg0KUlpfTVRVMz1tICwgIFBXTV9SWl9NVFUz
PW0sIFJaX01UVTNfQ05UID0geQ0KDQpCdXQgSSBoYXZlIG4ndCBidWlsZCB0ZXN0ZWQgdGhpcyBj
b25maWd1cmF0aW9uDQpSWl9NVFUzPW0gLCAgUFdNX1JaX01UVTM9eSwgUlpfTVRVM19DTlQgPXkg
DQoNClRoaXMgaXMgaW52YWxpZCBjb25maWd1cmF0aW9uLCBhcyBNVFUgaXMgY29yZSBkcml2ZXIg
YW5kIFBXTS9Db3VudGVyIGRyaXZlcnMgZGVwZW5kIHVwb24gdGhhdA0KDQpNYXliZSBhbnkgb25l
IG9mIFBXTV9SWl9NVFUzIG9yIFJaX01UVTNfQ05UID15LCBSWl9NVFUzIHNob3VsZCBiZSBzZWxl
Y3RlZCBhcyB5Lg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IFRoZSBwYXRjaCBsb29rcyBmaW5l
LCBidXQgdGhlIGNvbW1pdCBsb2cgbmVlZHMgc29tZSBhZGFwdGlvbi4NCj4gDQo+IFRoZSBmb2xs
b3dpbmcgcGF0Y2ggd291bGQgZml4IHRoZSBidWlsZCBmYWlsdXJlLCB0b286DQo+IA0KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZmQvcnotbXR1My5oIGIvaW5jbHVkZS9saW51eC9tZmQv
cnotbXR1My5oDQo+IGluZGV4IGM1MTczYmMwNjI3MC4uNGYxNWMwZGVhZDYwIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L21mZC9yei1tdHUzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9t
ZmQvcnotbXR1My5oDQo+IEBAIC0xNTEsNyArMTUxLDcgQEAgc3RydWN0IHJ6X210dTMgew0KPiAg
CXZvaWQgKnByaXZfZGF0YTsNCj4gIH07DQo+IA0KPiAtI2lmIElTX0VOQUJMRUQoQ09ORklHX1Ja
X01UVTMpDQo+ICsjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19SWl9NVFUzKQ0KPiAgc3RhdGljIGlu
bGluZSBib29sIHJ6X210dTNfcmVxdWVzdF9jaGFubmVsKHN0cnVjdCByel9tdHUzX2NoYW5uZWwg
KmNoKSAgew0KPiAgCW11dGV4X2xvY2soJmNoLT5sb2NrKTsNCj4gDQo+IA0KPiBtYXliZSBkb2lu
ZyB0aGF0IGFkZGl0aW9uYWxseSBpcyBhIGdvb2QgaWRlYT8gKFdlbGwsIG5vdCBlbnRpcmVseSBz
dXJlIGFzDQo+IHRoZSBhYm92ZSBzZXR0aW5nIHRoZW4gd291bGQgcmVzdWx0IGluIGEgbm9uLWZ1
bmN0aW9uaW5nIFBXTSBkcml2ZXIuDQo+IE1heWJlIHRoYXQncyB3b3JzZSB0aGFuIGEgYnVpbGQg
ZmFpbHVyZT8pDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0KPiAtLQ0KPiBQZW5ndXRy
b25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAg
ICAgICAgICAgIHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAg
IHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUvIHwNCg==
