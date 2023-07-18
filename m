Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50B7574A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGRGww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGRGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:52:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72525186;
        Mon, 17 Jul 2023 23:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFPda4nyqpK+B55XgfiyEsi64yZrj8kDY0NnLxQq/ccHNhRYIMvThRfLrqPvg4mTuhV4NU1RSZfyrkjqFONgqypmv4hudllQJ3u+vLgXz243FyV1hZYflGhm5qp+wWtxsxlTSro+0IQzTTdyAturRAd+nUiHxGRUujm61fnJayrNkIdGk5cPmxVcdp9JiB8xYbAEXYDUaB1m7xbRkUk70cJeGOi2BvF3RBZpnu7h28OeQGIv5M5EbvjuFPhXnFB6nBCnt4HN8aRiG5A6SYox+jh8b5aJaWKCbgzUX/Ssq3H9EOyPyRuu4+HFfddm6ji5rpulGwLIDBdJxlaN1cPltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqfq/UZf2JElFzqVDkeYS0zOtz1I1Sq3UAIgxTvjL0c=;
 b=U6INBY5nTwfS9LFATMrBKr6hyaaMt12yFrNsqesJazOZYd64Lo5pRb3lDBij5swYivS2joFsY8MDFEXawOJ9zgCg4F0DisH4qB/3b7+aoCvwu9E82ZtdjIFE/fxF6mGj09EGF8EmeSKTRvL2BZAArlPdx0oLdoQO1qB2CZN4uzC7Bt79ONh+egeI0j+iMvAENAkp5RtrbbVHdbnWWqymVpFPF9WdbhpYx1gTLLndKE6vc0j0akhga/ZDoNLZB7THsJVmTADUQDK5LspoxT/gWSBCXhB66xozgpiuCpmC2hEfQY+Qc14ysEfGtg4gh6vUaf8whJj5vTLhi4vovtlFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqfq/UZf2JElFzqVDkeYS0zOtz1I1Sq3UAIgxTvjL0c=;
 b=tPNLnEW03nggVyA8ApSrVoXnX6rBVG3iuDtM5rzjhxksh5UpyjU9PQrodvikYh6h+vhprYVy2eW+ZtFjMSgeb+TwrhGKuSWTe3k2U74rhHBk85GY9egh4rHQpShjA01Kvy9y4vj7aHIuMwmCHzeRACygCkp3rks7mXKoxWcF1lc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5537.jpnprd01.prod.outlook.com (2603:1096:604:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 06:52:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:52:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: RE: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Index: AQHZuTz3JvYeSdheY0298OUyurLS6a+/EjSAgAAAdkCAAAGDAIAAAEKQ
Date:   Tue, 18 Jul 2023 06:52:45 +0000
Message-ID: <OS0PR01MB5922C71E47AC3EE25C74EEE18638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
 <d31387c2-7411-ae98-93d3-418b9d5b87f6@gmail.com>
 <OS0PR01MB5922C3D065F47297A9620A4A8638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <f0586356-c7f2-c8dd-fbac-ab874dc94f23@gmail.com>
In-Reply-To: <f0586356-c7f2-c8dd-fbac-ab874dc94f23@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5537:EE_
x-ms-office365-filtering-correlation-id: 4741d510-4600-4466-540d-08db875b97a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcBTVgQwkmPoqnZr7XTkBSinzLFpHwFzxQp1c4JwAMiVO3X7jbMXobQvedS2LqmmM1h4izVvJnvboZDOgjP2lWhNo6LtL86B96+JpyXLQoLdJED4YN9oRttRRz21FMwO3HuVZDkaUOGPaUQGX6rhMJNFOHScgM6x/P9EG5WmqxdwVlidGQjKP3h+32nZuGWUi7MTnvSW02G1xe3nOe2LQvsOgDQg3D4Jru7JHBTcF2rPK7u28wLakb2sFRRNnJHHhZVWLxxrpJhFjnToVUsFV4YDpAC3yaAJIP7und9fbV0AFlMtRRvIt+DlQk1n5DZRYZo++rGWAzk2Qlw3yGsklJrR1O3BG3CJogyddtIet66Q9VvK0fw8+HU4bi9E2mbh78G/yWsg5bbW/A2oZiWbxnC4Xkh+iAc0st3/Vhyaeg9q6Kxiy2Lq9fWxnzPyM+n2tfp8VMwDGwqRo584MANbmnZDOIH+6ne39Z8HW6cSyiPQU8614XcGRSrUamBNkt9+hcL0rtvIzTSITZXgvC+KeAXKXbtD42aP1x47jI5KE7Koub+uopye8gb6bmISNLxyrt24dr5gsI8aSWupk+PAyVtInvhv+6f/A5KH1yvgGJCVAcMCtMg0la3NMzqxzlW7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(478600001)(5660300002)(66946007)(66476007)(66446008)(66556008)(64756008)(4326008)(52536014)(316002)(76116006)(8676002)(54906003)(8936002)(55016003)(2906002)(41300700001)(110136005)(71200400001)(6506007)(9686003)(53546011)(7696005)(26005)(38100700002)(33656002)(186003)(83380400001)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmFVM2QzaEExUnJlZUVWQUdrWEplRlYvLzFOSkdNekh1dVhXNVNkMTFpaE03?=
 =?utf-8?B?bUFRVGlNbFJBWjhVZDN1QW1tV0M4T090T1g1ZCtZek9oVlJ1SW5GcjlIbHpu?=
 =?utf-8?B?aFdUNjBWWXd0TFJZYm0zTnNjZ0VTV2lSU0k2V0dnb3JORFhvanU0OVVDRGZy?=
 =?utf-8?B?Z21WNmpmdDQraDVxaEF1djV1RHJEVXNCN01qaFNlOUdjSmdZWGs2SnZTNXNW?=
 =?utf-8?B?bWFhSmJ4OHJZMGcyaVNTVmdEMWdvRG1JdzBqVlR2VjhRekdPUUdTWlhJMGlq?=
 =?utf-8?B?WU9GZ082c0o3TW11cnJlSlVkOWpNNlJ6RzZieUNWbWMwakJwaHEwL2ZOYW04?=
 =?utf-8?B?NDd0Z0Z5WXF5QmhERGFsMHpsQndoR0tXdmxCVnFIbTRncnE2aVV3THZWUXJH?=
 =?utf-8?B?WmpHZC9jaFRZc0pOMk5OSTlBcHZZUmp6dU5obS9vRk0xWGZidzFmMThxV0Jh?=
 =?utf-8?B?UU1ldVBxK0VaUWl0dCtBL21PSXVZdGdvWVpkL2gxQy9uU05VblZxUU1NTGVm?=
 =?utf-8?B?ZlpsUnFRUnREbDlCN1Y3aEdiY3EvSi9iOGphZ1QwV2JpTXpXVEtMbHpTd0VU?=
 =?utf-8?B?ZjdRUTd3RVg2dlNBd3NGbHFDcmRmL0puOTBQdkhBeG5NTGk1Sk9JOVZZbmk5?=
 =?utf-8?B?MmdKUTFRMkJlTWpCMDZBUVZ6NDlvb1REM2hwTjV1emYzWnovSDVYTEw2bGJ5?=
 =?utf-8?B?K2pybG5hbHBYM3A5TlIxRWZYMmZiZmhFOGQ5dFZ3SmUyd3V3b3AxclBZQUZL?=
 =?utf-8?B?N2YxWnVyUE1HQVd3M05qUVhFYnB3YmNRcFN1TjdpT1lSODJuajZyd0xHL0JE?=
 =?utf-8?B?dXlqRkUrbFdSMU0wZGtyMmphM1l1amtESkw1ZmZBMnJLaUJpTVpZNi9icnV2?=
 =?utf-8?B?bS9LNmUybVR6ZUVWVnZlOFhJZHhGR0pVb2UrTVIxdnRWenl1bUIxbXdzbXZw?=
 =?utf-8?B?bG1COXg1MjBGT3lVWTRRL2VIVXRyQ3NOYXRuSm1JWFpRUzc0ckl3Q2djRXhN?=
 =?utf-8?B?ZUpCZG1SajVSSjlPWHk4RFdsYXRsYmFFWjNLVXZCNUJkZVFqK05LWThNb0Er?=
 =?utf-8?B?d0YzcDB0MmkyYkpyYVkxYXU1TE1td0VzMkdiNjFVNG0vK1Nkb2JmUmJKckhl?=
 =?utf-8?B?M0tnSFZiM2cybHhmYnpxNTZBa25QSy9CUGw4ZGRzRXJBWGd3MjRvTm02aWhu?=
 =?utf-8?B?a1B3ZUE3THI3bXZWZUlsaFZPRldEM29xdEZEalk3OEFORGR4UzNaQTZtRTds?=
 =?utf-8?B?MUdVVVB2QTc5aWhJWFVhWXR5Tnh1TlJmYTRybXhwSURBLzJQM3N4UmJxRnBw?=
 =?utf-8?B?UmIxb3FaVHdCeGcybGlKZytWRWJ3MFVmMW50VEQ4d1QxZUJydkdGK3hnWVlZ?=
 =?utf-8?B?ZDFCOTJ2WHp4ZkFDQnNpdG14RzRlRTBiT3ZEcnNPZHZMd3VuZDNxVTYrTlMx?=
 =?utf-8?B?UEJ5eG51eUdDVG51Qk1Rc3A4NzJSU3ZLdWRYWlRpQkNGNjAxWnRKOW5wWUpI?=
 =?utf-8?B?VFhZcFd1NDFkdGxlT0dDZkxCT0lXSCt0U244UXVBUjB0YnBNNXRFc2ZrYlRJ?=
 =?utf-8?B?MVQ3OTJPOVRKK1g0RGNxQWpPT3dDelFOaU9EeHZ6ODRiWk9TOC9zYnhQQVBl?=
 =?utf-8?B?YWZ3dHB5Z0E0OGdSdjJKUllyTEEvcHUrcndIeURXVVp5djFBbXg0VmtoRlZx?=
 =?utf-8?B?a0U2aTdwU043clBZc09rVXltR3F4blNzMFBZU3JKV2NnMDVlTUkzYTd1emxF?=
 =?utf-8?B?WGc4RFNYd003bmt3RkkxcmhyOEZBUHloVHMyUVBLY2xYS1BlRTluWHlPeXZ6?=
 =?utf-8?B?QnVyblNtVUhWUkFjeVZzdUZ0M0lCVEJjMEhqZFBzdGp5SVFycjFhK0NRNDZ1?=
 =?utf-8?B?MlBid1lRd1BsWmx2ZTBaS25KL09wMW52dmlhUnpMc0cyTnhSVlNsR3dVTTJN?=
 =?utf-8?B?QWgyM0w3eW1WZ3l5d2pzVkZvWElTNGlQR2U4ditmLzZFN2c3VVpXaENYZnQ1?=
 =?utf-8?B?aXl2MVlsTUx1WW8rNmFONDR1STFCK3RKbjJmVVVzZXRXKzFuRWxFSlk4b1or?=
 =?utf-8?B?bkdYMCs5YVNGTDJZVHFMdzVlb3dGUlduWTJWRjZnZ1JCZDFUZXdnNXg0WEQy?=
 =?utf-8?Q?djqW9zXLW+gai5qDHfuWwBa2F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4741d510-4600-4466-540d-08db875b97a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 06:52:45.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+VJA/F9N+mo/nFH1lZpROJapg2ZynNsJdeyjHPioZVXfYrfwr0uhcstj8mHNw8AhUHrczIKA9vFIRCxkcAWoustqP2jwcFEZWE5V3LPwng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5537
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHkgRHVubGFwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFJhbmR5IER1bmxhcCA8cmQuZHVubGFiQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVs
eSAxOCwgMjAyMyA3OjQ1IEFNDQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wd21Admdlci5r
ZXJuZWwub3JnDQo+IENjOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlPjsgVGhpZXJyeSBSZWRpbmcNCj4gPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcHdtOiBmaSBwd20tcnotbXR1My5jIGJ1aWxkIGVycm9y
cw0KPiANCj4gT24gNy8xNy8yMyAyMzo0MiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4NCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJk
LmR1bmxhYkBnbWFpbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTgsIDIwMjMgNzoz
OCBBTQ0KPiA+PiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcHdtQHZn
ZXIua2VybmVsLm9yZw0KPiA+PiBDYzogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT47IFRoaWVycnkgUmVkaW5nDQo+ID4+IDx0aGllcnJ5LnJlZGluZ0Bn
bWFpbC5jb20+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIHB3bTogZmkgcHdtLXJ6LW10dTMuYyBidWlsZCBlcnJvcnMNCj4g
Pj4NCj4gPj4gT24gNy8xNy8yMyAyMjo1OSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiA+Pj4gRnJv
bTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+ID4+Pg0KPiA+Pj4NCj4g
Pj4+IEZpeGVzOiAyNTRkM2E3Mjc0MjEgKCJwd206IEFkZCBSZW5lc2FzIFJaL0cyTCBNVFUzYSBQ
V00gZHJpdmVyIikNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPg0KPiA+Pg0KPiA+PiBPb3BzLCBJIHNob3VsZCByZXNlbmQgdGhhdCB3aXRo
IGNvcnJlY3RlZCBlbWFpbCBhZGRyZXNzZXMuIFNvcnJ5Lg0KPiA+DQo+ID4gQWxzbyB0eXBvIGlu
IHBhdGNoIGhlYWRlciAicHdtOiBmaSBwd20tcnotbXR1My5jIGJ1aWxkIGVycm9ycyIgPz8NCj4g
DQo+IFllcywgSSBzYXcgJiBmaXhlZCB0aGF0IG9uZS4NCj4gDQo+ID4gTm90IHN1cmUgZml4ZXMg
dGFnIHNob3VsZCBiZQ0KPiA+IGI4YjI4YjcxOGRkZCAoIm1mZDogQWRkIG1vZHVsZSBidWlsZCBz
dXBwb3J0IGZvciBSWi9HMkwgTVRVM2EiKSBvcg0KPiA+IDI1NGQzYTcyNzQyMSAoInB3bTogQWRk
IFJlbmVzYXMgUlovRzJMIE1UVTNhIFBXTSBkcml2ZXIiKQ0KPiANCj4gSXQncyB0aGUgUFdNIEtj
b25maWcgZW50cnkgdGhhdCBpcyBpbmNvcnJlY3QgQUZBSUNULg0KDQpPSyBnb3QgaXQuDQoNCkNo
ZWVycywNCkJpanUNCg==
