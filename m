Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0E757A85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjGRLff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGRLfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:35:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF4C1701;
        Tue, 18 Jul 2023 04:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6lOQQrRA44pZQiPveIzn4Bk/lrBf0bAQh4K0bgpeLOuIE2QBAEk401ttl1KlAMjl9Y0y/DvfknOijB4o4UHRvzEJo+IKtCKdauBKs8Rh9BtehJuDaxRxhc6iNdKMvLgafrwZ86sdxzHpUmkeyaaI6jjzbb/S/ez+TmVpsn3QSVqo0Vrp6q+aWkQcRRanm8wIdH841FnQ52jp28jBnpPJW83mcyrABBfbttCgSq+aJrqlw3IPbg+3Pg7F+NzcJS+sW+2IDZ9awmcFBnejkxEGu6pOnzB4EYhHhJiTfuRmhVNRr7bJ3DV0QKAIlgukHyyiW2H251uWhtAEgLwih0qkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZj+BXgmYNlZF4ZbBWGo+T7f9H042O2iHsu3Oh7WLbs=;
 b=ePoKElqe4HLmGFzbeyfn4gQv79hDq+55AxjMKrHHDz2hRukNYFbaP6ej+0COaSZpXJ70sO7B+w0AumOBMJ+Bygpuran4pqt0Rm92+CicGzLqSGJr08KgDIbjeyR6hCrX3o6LriPkll5FcukV3enW6JTg4vtwHNPqCjD5ZYIbiWsuFCIlnPRYeQ9MB2Qzo0yUG/c7i411dIyxKSMShzUxgI0rjc2btWcy1wENGeaDoYtaDRM7kFMhYWpUabPaiKm9L7gQYkgHCSZPR15qBUNXy4yr1iKZ9C6qlyNlnTT8rTflI26OgS0mFqN5DHTSf9Zuj3uWM3+39tDlUWgGW12u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZj+BXgmYNlZF4ZbBWGo+T7f9H042O2iHsu3Oh7WLbs=;
 b=MPOhEaMsS+N8cKzf7OvSCv/HUNRG2vhNETWu277fQgYXvPj+PvnFWeQ4Tw5If19wjo8Aa7+S/hGRQ0Wfu8o5hknTV3qHviXAf3SdgSgstk95+Z5ee0YEUxL+RPHZmErq6SI99p/1+3WCF0Vm+EOVY5pmecNrukqLgSYD+MbnNqo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB12019.jpnprd01.prod.outlook.com (2603:1096:400:40c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 11:35:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 11:35:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Randy Dunlap <rd.dunlab@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Index: AQHZuTz3JvYeSdheY0298OUyurLS6a+/OhiAgAAo2wA=
Date:   Tue, 18 Jul 2023 11:35:24 +0000
Message-ID: <OS0PR01MB592230D50CA5014C9ED503D58638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB12019:EE_
x-ms-office365-filtering-correlation-id: 229f2864-baa7-4ea7-2677-08db878313ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1y/xzyel9oQ1Xlxx4IzfeuB5xATZqZmAGnoV8ILzPQddbVoL66jjuY5GwFSo0raHL8q8Q788bQHTRVNgdZCnqy51mxdbWZMLg7NJRAJ2FxxCVgGyW4Ws+u8yGsuQjU4VwpIhW9+X8PtQV/wqiDmVEaEA1R/CN3bx1Xs79lxX6jQRTdMqTLaITNduownYM0qsVmTjGw75ELADKdiq2rmUy+K18xyKivGZjais1GIWiHPESRDdUFfZG2be64feX4aHipL5ubO7y37R8nAd6sTsKh9bbWDCXEs4qRfCMxAMqRX9L4eGwAuY0elEthy0TZWPAAiViDcofanSkdSzgCKK8f7/CrGSjxHdYsHuc4FA9zDR9bC16sQKYD5sWPmOoJwUbHQGWgnODQiZ3P1z1WKPHPUF/yXk9XQwg83VO9zac8PIQJA90YdRvUCdfJu24ffw9aOV9IXWLXYyuDYOEiia3/IktPurI6ORzrTOQ9fr6u2wjFmRiAmDf9KVShptwbZpAjLCXmrPUb5g3GfQGwN7D6cEGhi9arXjwQf+tbaUEQ1gl465F69AA7EGu9sV7HU1Z0zPDPloyWkZJ9evW8Rk/7sF8+t/OiRbHrz4wHn292RAKzg0hT22yESVZpXXGmuo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(38070700005)(122000001)(55016003)(9686003)(83380400001)(66574015)(186003)(26005)(107886003)(53546011)(6506007)(52536014)(86362001)(5660300002)(33656002)(8936002)(8676002)(478600001)(54906003)(110136005)(71200400001)(7696005)(41300700001)(316002)(66476007)(4326008)(64756008)(66446008)(66556008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmRzNXBIYW5SRkxJa3ZSMmZOQ1JrZElXczV5cGJBbFR3TTNQNTkzWjFweU55?=
 =?utf-8?B?Q0JUSVJQQmxFVWpHcklyV0tKZUtpbWJEcGoyZHJQcVI1cHU1R3lSSjZlRm5N?=
 =?utf-8?B?ZWkyZkxWbTdsSHdTam1hVkJUVnNPR09SVGlTRHB5a2E4RU5Wc3Y2ckNJMUEr?=
 =?utf-8?B?V2RiYmNjSXYzYmZqMTRObHlBd1FkbmVROUNnMTdTalYrWFJjZlp5a2xiQzBZ?=
 =?utf-8?B?Vk1PUVBLOUlPS2ptSHRHM3E2akkySTVXdE9QeklDTkxFYU54cFZHTTR4ZHk5?=
 =?utf-8?B?Smp3RnlkWndCSTNHRnZHYTJLOVl5ZmxFSkFvb3dJQ1ovZExkdklSZ1kwOUhV?=
 =?utf-8?B?ajk4SFFZa2xqODdQR2xLV0Y4NmhqcEVBVWpQOVdmZVFnUTVvMlNMcnZZSVlR?=
 =?utf-8?B?VUVCNVB1UDlJTXhSTmNja1pRZjNJb2pvZTJhY0FrdmQ5RjhEbXFGUllCZE5C?=
 =?utf-8?B?bXRIZXRpZnJySFNBWDFkMFBnN2VKZHNUd28xbUFnZU16RmoxTkFYRU16MzNs?=
 =?utf-8?B?ajRpMkJCTzJaYjhMWWVYdWdEa2ZVYXVaR3gyZG9MNHFBK1NldGtiRHFweXY3?=
 =?utf-8?B?ZXlSbG9pbzdoMjJPUG1UMUcwczVEdUgrS0lJNXFwbU1mQmJjc0lCTHlDR3RJ?=
 =?utf-8?B?YzhwQmVzRU13YzMwK01EV1Y1dTFPaStWYXhaaGhIaXpib3BSako2d2tRRUhh?=
 =?utf-8?B?aTFXQjFBWTF6VnZkaFZoYkZlVTQzUXpkZFh2S2wzUWtlSUxSN1BOc3VwcDl4?=
 =?utf-8?B?ZDgwS09uVEFtbDF3blcxZnpvZEpyL3AwamhvaVY0anppRVd2TmpDTk00d20w?=
 =?utf-8?B?dHU1NUk4V01lYUlROFBSTDZOYy96VGdRa2dZRmIzemFEcHcvWnBVRUFkZEFv?=
 =?utf-8?B?R0VQc2xzTHJEeUluYWsvSW9NSDU1cDhqZHF3OXA5TXF3MDM4S3ZnckhTblVj?=
 =?utf-8?B?MS9JU3VBTWwyc2FuM1dwNEpJOWVPZHIrQlJDR3VZNFNhNDVjd01kV0ZZeUd2?=
 =?utf-8?B?dXVFMElPNVZIbTBNK2dVc25kMkd6cW95bWt5THI0UTBJRjhCaGIwaTdWVG1u?=
 =?utf-8?B?UXdrK0ZydU1lZFFqd0dURWdhN0dNa2ovWldkSjNVRHVrVVlZS2MzbFVGQzVl?=
 =?utf-8?B?eFpYRFRLUU14T1pLdTBRUXNWcjNNTmVHOUk5OEt5K2VnSTZOSnRwbEk3M3Iz?=
 =?utf-8?B?SDF3UTlzMzgwcC9tWEVCSml5Um4xWmZCRlUyVCs2T00yMTBMRFpBN1dIbjY0?=
 =?utf-8?B?U0UrRjZUd0k3Mi9uYXFyaTE1UHhmTEZ6Z095UmRCcjFJelJ1a1VLekZPOW1h?=
 =?utf-8?B?cE5uV1Z5aE1xYUZ3R01Ma2p0UHdaaDJWdWxNVTRhMDRYR2FPL1VEM3ZyamZM?=
 =?utf-8?B?VWtVdzNYMEF1dU1Tam95eURtTHhwVjlBekpsWXE2cm5IWm0yd2hFaXdJS0d5?=
 =?utf-8?B?ZlhZK3VKdzJzY05iUGRtZnNJVTY0OU1GZUliUnpmNEVLNUEvL0VqZkp1cHJL?=
 =?utf-8?B?S2pjSnNFdFdTdGFOVENiNVFIc0ZxbFlNUkJJVjVBOEgrZHI1RjVwTUxCRVRz?=
 =?utf-8?B?c0UwOWVvT2FLKzRVVzVGaXJyVjluVkNpMGovZWhjcUZuMkJ0RUdHNlhkRU4z?=
 =?utf-8?B?akVVQmFFa21ERUFHUnZOZUw2ZHdNYXdCRFQ2YmJNTHE3UDFzRldTMHk5TWNh?=
 =?utf-8?B?VkV3UktMVzJ2VU5DZE9PUEFVeTRjV25hQUlqOU5DMjFZeDRJZUZZSWlIU1ZZ?=
 =?utf-8?B?NmowMmZOc0VjcUpITU10djhsTE1XZFQyYkVobEpxS3JzK0JmRjZmb2FEMm5C?=
 =?utf-8?B?djdLbG5FSk83MUdDamtLUGhqd1BDSmFSMVRMZnNWMzE2U3hJdzAwV3c1UklY?=
 =?utf-8?B?UzRwYjhoZ2N4T2VoQlR4R3NTeDlOeitPUS9kN2lSYTEyeVloYi9JaG1ZN2tX?=
 =?utf-8?B?RmpUQUJMRjErTkc5VXZKaFdva0ZTYm9TQ3VWVElxZmoydVJhMWw1bmFmcDJX?=
 =?utf-8?B?NVVXNUdvRGQ2N2xwR3VxbkhoanJRMytWVUl3QVY5dTF5WUZUUStzQnV5Qit2?=
 =?utf-8?B?TmxsMHVBN0JQU3doZll4UXFuaVdTRkdQSzdnVk9RdzFBQ2ZHMzMxOVIyand4?=
 =?utf-8?B?Tlh1RTFrZU5LMFIzY2lsZHFpTkVHeG85VUZrRXNzRlBJZE90eDZvK2dZWXUv?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229f2864-baa7-4ea7-2677-08db878313ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 11:35:24.2975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKREcvdCbCLoKRlwqjEAD711nwZJ6UvLjlivsGTYnUauhN47SJ5W93uYKxfshTpLpRUm4s+qDCQHvsG6TAiA3/o2bBzRjgmg0Q6SxP7qnnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE4LCAyMDIzIDEwOjAwIEFNDQo+
IFRvOiBSYW5keSBEdW5sYXAgPHJkLmR1bmxhYkBnbWFpbC5jb20+DQo+IENjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBUaGllcnJ5DQo+
IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPjsNCj4gTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gcHdtOiBmaSBwd20tcnotbXR1My5jIGJ1aWxkIGVycm9ycw0KPiANCj4g
SGVsbG8sDQo+IA0KPiBPbiBNb24sIEp1bCAxNywgMjAyMyBhdCAxMDo1OTowMlBNIC0wNzAwLCBS
YW5keSBEdW5sYXAgd3JvdGU6DQo+ID4gRnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJh
ZGVhZC5vcmc+DQo+ID4NCj4gPiBXaGVuIChNRkQpIFJaX01UVTM9bSBhbmQgUFdNX1JaX01UVTM9
eSwgdGhlcmUgYXJlIG51bWVyb3VzIGJ1aWxkIGVycm9yczoNCj4gPg0KPiA+IGxkOiB2bWxpbnV4
Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9jb25maWcnOg0KPiA+IGRyaXZlcnMvcHdtL3B3
bS1yei1tdHUzLmM6Mzc0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGByel9tdHUzX2Rpc2FibGUn
DQo+ID4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6Mzc3OiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvDQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gbGQ6IHZtbGludXgubzogaW4g
ZnVuY3Rpb24gYHJ6X210dTNfcHdtX3dyaXRlX3Rncl9yZWdpc3RlcnMnOg0KPiA+IGRyaXZlcnMv
cHdtL3B3bS1yei1tdHUzLmM6MTEwOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUz
XzE2Yml0X2NoX3dyaXRlJw0KPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUz
X3B3bV9jb25maWcnOg0KPiA+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MzgyOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gbGQ6IHZtbGlu
dXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX3dyaXRlX3Rncl9yZWdpc3RlcnMnOg0KPiA+
IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MTEwOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+
IGByel9tdHUzXzE2Yml0X2NoX3dyaXRlJw0KPiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1
My5jOjExMTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M18xNmJpdF9jaF93cml0
ZScNCj4gPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fY29uZmlnJzoN
Cj4gPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjM5NzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgcnpfbXR1M19lbmFibGUnDQo+ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210
dTNfcHdtX2Rpc2FibGUnOg0KPiA+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjU5OiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gbGQ6IGRy
aXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjY0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGBy
el9tdHUzX2Rpc2FibGUnDQo+ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNf
cHdtX2VuYWJsZSc6DQo+ID4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyMzA6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF93cml0ZScNCj4gPiBsZDogZHJpdmVy
cy9wd20vcHdtLXJ6LW10dTMuYzoyMzQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210
dTNfOGJpdF9jaF93cml0ZScNCj4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyMzg6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfZW5hYmxlJw0KPiA+IGxkOiB2bWxp
bnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9pc19jaF9lbmFibGVkJzoNCj4gPiBkcml2
ZXJzL3B3bS9wd20tcnotbXR1My5jOjE1NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpf
bXR1M19pc19lbmFibGVkJw0KPiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjE2Mjog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3JlYWQnDQo+ID4gbGQ6
IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX3JlYWRfdGdyX3JlZ2lzdGVycyc6
DQo+ID4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMDI6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfcmVhZCcNCj4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6
LW10dTMuYzoxMDI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hf
cmVhZCcNCj4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMDM6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfcmVhZCcNCj4gPiBsZDogdm1saW51eC5v
OiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fZ2V0X3N0YXRlJzoNCj4gPiBkcml2ZXJzL3B3bS9w
d20tcnotbXR1My5jOjI5NjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0
X2NoX3JlYWQnDQo+ID4NCj4gPiBNb2RpZnkgdGhlIGRlcGVuZGVuY2llcyBvZiBQV01fUlpfTVRV
MyBzbyB0aGF0IENPTVBJTEVfVEVTVCBpcyBzdGlsbA0KPiA+IGFsbG93ZWQgYnV0IFBXTV9SWl9N
VFUzIGRlcGVuZHMgb24gUlpfTVRVMyBpZiBpdCBpcyBiZWluZyBidWlsdCBidXQNCj4gPiBhbHNv
IGFsbG93IHRoZSBsYXR0ZXIgbm90IHRvIGJlIGJ1aWx0Lg0KPiA+DQo+ID4gRml4ZXM6IDI1NGQz
YTcyNzQyMSAoInB3bTogQWRkIFJlbmVzYXMgUlovRzJMIE1UVTNhIFBXTSBkcml2ZXIiKQ0KPiA+
IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+
IENjOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gQ2M6IFV3ZSBL
bGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+ID4gQ2M6IFRo
aWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+DQo+ID4gQ2M6IGxpbnV4LXB3
bUB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IFdoaWxlIHRlc3RpbmcgaGVyZSBJIGhpdCBhbm90aGVy
ICh1bnJlbGF0ZWQpIHByb2JsZW06DQo+IA0KPiBkcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5j
dHJsLXJ6ZzJsLmM6IEluIGZ1bmN0aW9uIOKAmHJ6ZzJsX2dwaW9fZnJlZeKAmToNCj4gZHJpdmVy
cy9waW5jdHJsL3JlbmVzYXMvcGluY3RybC1yemcybC5jOjkxNzozNzogZXJyb3I6IOKAmHN0cnVj
dCBncGlvX2NoaXDigJkNCj4gaGFzIG5vIG1lbWJlciBuYW1lZCDigJhpcnHigJkNCj4gICA5MTcg
fCAgICAgICAgIHZpcnEgPSBpcnFfZmluZF9tYXBwaW5nKGNoaXAtPmlycS5kb21haW4sIG9mZnNl
dCk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCj4g
DQo+IERpZCBzb21lb25lIGFkZHJlc3MgdGhhdCBvbmUgYWxyZWFkeT8gSSBndWVzcyBQSU5DVFJM
X1JaRzJMIHNob3VsZCBzZWxlY3QNCj4gR1BJT0xJQl9JUlFDSElQLiBBbHNvIFJaX01UVTMgc2hv
dWxkIHNlbGVjdCBNRkRfQ09SRSBhcyBJIGhpdDoNCj4gDQo+IAlhYXJjaDY0LWxpbnV4LWdudS1s
ZDogcnotbXR1My5jOigudGV4dCsweDU0NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UNCj4gdG8gYG1m
ZF9yZW1vdmVfZGV2aWNlcycNCg0KDQpPSywgd2lsbCBhZGQgInNlbGVjdCBNRkRfQ09SRSIgYXMg
cG9pbnRlZCBvdXQuDQoNCj4gDQo+IENvbW1pdCA2NTRjMjkzZTE2ODdiMzE4MTlmOWJmMWFjNzFi
NWE4NWE4MDUzMjEwIGFkZGVkIFJaX01UVTMgYXMgYm9vbCwgYW5kDQo+IGl0J3Mgc3RpbGwgYm9v
bCBpbiAyNTRkM2E3Mjc0Mi4gSSB0aGluayB0aGUgcHJvYmxlbSBzdGFydGVkIG9ubHkgd2l0aA0K
PiBiOGIyOGI3MThkZGQgKCJtZmQ6IEFkZCBtb2R1bGUgYnVpbGQgc3VwcG9ydCBmb3IgUlovRzJM
IE1UVTNhIikuDQo+IA0KPiBUaGUgcGF0Y2ggbG9va3MgZmluZSwgYnV0IHRoZSBjb21taXQgbG9n
IG5lZWRzIHNvbWUgYWRhcHRpb24uDQo+IA0KPiBUaGUgZm9sbG93aW5nIHBhdGNoIHdvdWxkIGZp
eCB0aGUgYnVpbGQgZmFpbHVyZSwgdG9vOg0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbWZkL3J6LW10dTMuaCBiL2luY2x1ZGUvbGludXgvbWZkL3J6LW10dTMuaA0KPiBpbmRleCBj
NTE3M2JjMDYyNzAuLjRmMTVjMGRlYWQ2MCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9t
ZmQvcnotbXR1My5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbWZkL3J6LW10dTMuaA0KPiBAQCAt
MTUxLDcgKzE1MSw3IEBAIHN0cnVjdCByel9tdHUzIHsNCj4gIAl2b2lkICpwcml2X2RhdGE7DQo+
ICB9Ow0KPiANCj4gLSNpZiBJU19FTkFCTEVEKENPTkZJR19SWl9NVFUzKQ0KPiArI2lmIElTX1JF
QUNIQUJMRShDT05GSUdfUlpfTVRVMykNCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCByel9tdHUzX3Jl
cXVlc3RfY2hhbm5lbChzdHJ1Y3QgcnpfbXR1M19jaGFubmVsICpjaCkgIHsNCj4gIAltdXRleF9s
b2NrKCZjaC0+bG9jayk7DQo+IA0KPiANCj4gbWF5YmUgZG9pbmcgdGhhdCBhZGRpdGlvbmFsbHkg
aXMgYSBnb29kIGlkZWE/IChXZWxsLCBub3QgZW50aXJlbHkgc3VyZSBhcw0KPiB0aGUgYWJvdmUg
c2V0dGluZyB0aGVuIHdvdWxkIHJlc3VsdCBpbiBhIG5vbi1mdW5jdGlvbmluZyBQV00gZHJpdmVy
Lg0KPiBNYXliZSB0aGF0J3Mgd29yc2UgdGhhbiBhIGJ1aWxkIGZhaWx1cmU/KQ0KDQpJdCBtYWtl
cyBzZW5zZSB0byB1c2UgSVNfUkVBQ0hBQkxFIG92ZXIgSVNfRU5BQkxFRCBpbiB0aGlzIGNvbnRl
eHQuDQoNCg0KQWxzbyB3aGF0IGlzIHlvdXIgcHJlZmVyZW5jZSBmb3IgdGhlIEtDb25maWcgc29s
dXRpb24/DQoNCisgICAgICAgZGVwZW5kcyBvbiBSWl9NVFUzIHx8IChDT01QSUxFX1RFU1QgJiYg
UlpfTVRVMykNCg0KT3INCg0KKwlkZXBlbmRzIG9uIENPTVBJTEVfVEVTVA0KKwlkZXBlbmRzIG9u
IFJaX01UVTMgfHwgUlpfTVRVMz1uDQoNCg0KQ2hlZXJzLA0KQmlqdQ0K
