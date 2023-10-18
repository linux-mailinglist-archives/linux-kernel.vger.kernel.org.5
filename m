Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C057CE2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjJRQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJRQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:25:06 -0400
X-Greylist: delayed 69 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 09:25:02 PDT
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4AB8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1697646300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn6bP0y+TEnTpEbIH74pLwx5syCgFSPqKw4e/aWzrG8=;
        b=Q/SrF7pg6bKsDXnQH/4xXm4vjHGO44NWa1CXIswPB1F+T5pWmf3WiDdJEIVAiBQZgECPlK
        +RNS9Hzm86dKGyfkVzXpFnVR84AgM7wwZ2xl6umAeNjlKBG6IxHYimUVDFKM8LSnF30yZz
        edMuEtx0EH0Yij3QOMmXiBE/hnWTaB4=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-53-Sw0GyZSoO_m_QITxfEIa1w-1; Wed, 18 Oct 2023 18:23:47 +0200
X-MC-Unique: Sw0GyZSoO_m_QITxfEIa1w-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0760.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23; Wed, 18 Oct 2023 16:23:45 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 16:23:45 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "neeraj.sanjaykale@nxp.com" <neeraj.sanjaykale@nxp.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "sherry.sun@nxp.com" <sherry.sun@nxp.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "amitkumar.karwar@nxp.com" <amitkumar.karwar@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Thread-Topic: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Thread-Index: AQHaAdM10VjLQGV+KUS/mQuRf8z4TrBPrjUAgAANEIA=
Date:   Wed, 18 Oct 2023 16:23:44 +0000
Message-ID: <872a2317c504c011c5022b21e35d3d490639525b.camel@toradex.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
         <20231018145540.34014-2-marcel@ziswiler.com>
         <AM9PR04MB8603471C0C4BF61CC3AA3BF5E7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8603471C0C4BF61CC3AA3BF5E7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0760:EE_
x-ms-office365-filtering-correlation-id: 328916ab-a150-4792-02a4-08dbcff699a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: LvXXe3wBblzBuAFsgy0juc3B59h8O9DhQQ/yxw8sH65vv4WQfMeZRki3yNR85KoEeNpdRQsf1d7tRAlWg21VEd9awJFFUXZ8ld+wnvwmqcj+R0iKgxPYUDw3eTO9mLavAjEWSnePLbe+mpHMwQnx8zk3zozzs7fh7GTD0r0mL+atnPyeO87lYEKz3d2kPj3lK+g+wPJa7MCcY8WmTV1SocgAI51e/lTQYqd/1YXJO+QNV+kmx6wbesheDe1pRHHHrIFp+Q4qsTVsmS6nhuv18OOBegQPR0/aT8XBYZyKjr3lPXmbNxwSCJ+ZkJltrXlixxoyiaV5j6frPAoY7BxQDSB06PVKKZUR33vtZFtvHd/huK2Ub0YhJmIU1IVgi0N1nO9QR3s8Cs6n2RbCgVjMz26VTECJOLfF8cLTvsFPLMcn8OJW8n8zA1Q7yVRctBqYDpupbSSRDV0z79+M6c+5T7FPGe/P+xhwZPZ+ShtUTUijaT9LZSr+SH8nW3SAZ/ZW6wqjXhsTbWxnxWa7sqybSZ6Ej9jv/A0xVZAPL0F4CnnjhlOnC7jGKTtGl8Fkn1dDdrpGvUZOmvKrYBYMlwArX5wvzHzGPmTi1sGGr5ZxlWwYSxmCgQiIWHRPX45TBfJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(66574015)(26005)(38100700002)(83380400001)(44832011)(5660300002)(76116006)(8936002)(8676002)(4326008)(2906002)(54906003)(64756008)(41300700001)(66446008)(66946007)(66556008)(66476007)(316002)(86362001)(4001150100001)(6486002)(110136005)(53546011)(478600001)(71200400001)(6506007)(91956017)(2616005)(38070700005)(6512007)(36756003)(122000001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXd0NWJoMjJDVkRxRWhtRkN3a1B1RDhmVHdwS3NJVzdhWFlIVVkvUUVoemlH?=
 =?utf-8?B?anc0ZGIyY1hMZERPUmhCaEZ3czl3RU5CZEtSVFB6em5DbTBDajdCRVcvMGFQ?=
 =?utf-8?B?N0ZRWTl2akl1Y0tTRGhvVzhlSFE1SHkyVlVicFRwMSt4QmlIb3JaK2VFMFBX?=
 =?utf-8?B?Q3c0TUk2MHJ5UE9SVkdVVVVraW1YWTdNbFBYZE9LMlA5Y3FoakdMTUtrTzBX?=
 =?utf-8?B?VWZuYkIzcU5kejVtL0xjdWIzRHYrV2xLTk1jejZjWmc3UTQwem0zZVkxcFFB?=
 =?utf-8?B?TlpTT1liSGJsR3RpbFVhYXlMV280cVFrUEgyeURCUHZYQ2p4WDdPMFR2cGhn?=
 =?utf-8?B?T0dkL1FnWU5sSkMrT3oyejVSclc1S0JtQXU5aWNSK1ErcllWWGVNRnViQ01t?=
 =?utf-8?B?Q25aVjljTklyOXRpc0dDekUrUTdGL01yOTJ5ZFRqM0N5SWxrTUgwaFpET0Fs?=
 =?utf-8?B?TFErVnpTdGNUa0xXRmtBQ2NxNXBsUHFKYTREU0F6bGZXaHBnWkIxcDBoK3Bp?=
 =?utf-8?B?T0V0c3ZoS0ZFZlRaS0c3cXg4K0RCcWFMVlZ3M0hISTl1aGVtbUFXQncvTW04?=
 =?utf-8?B?WlJ5YTN0dHRsUW9wcHNUVVdJY0lnaEp6NVVMdVJqb3RFeDUwNmZTTytLaVNl?=
 =?utf-8?B?ZjNEcHFrVUF6akFjTVMwUXJMRzYrVHRhQjBPUk12UTIxeEpkODdGTFlGRm8v?=
 =?utf-8?B?bjkxVW94aVRBdExweEp3Rk52ZkR6WDYraDBiZVNGOUFRSGt1ckNkRU03MUtI?=
 =?utf-8?B?R1p3MzBMNnl5Ulg2TFVmYzMxSDdpb05IaFNLaVhSRUlWb0JRNEkzZGh2OVlS?=
 =?utf-8?B?RlhqQ05PUUhBd1I2dlcyaXdYLzZIYkFZazV0ek9uYTlvVVVOTEVOaHI0ekl5?=
 =?utf-8?B?Tlh5bEM4dmJocHROYkpsRENNS1NENWZYdVlZU1I0YkMrRjNRRWlwNVc0ZjBF?=
 =?utf-8?B?NVprNUZlMThqOUo3bXFtdmt6QkoyYk1IQ0JWNVVXZTYvaFhsSENDclQyWVNk?=
 =?utf-8?B?aWw1bGVreEwvUlNRbVZLNnRpL1RReGExejYrVFlBZXBDbUN3T3dxQkZvL2wr?=
 =?utf-8?B?a1J6cE1vbHhFUzdUdzV4OXJSSEVqT0YyTUM0VVVUWmFLVVFtMWZXVGlMR1BR?=
 =?utf-8?B?Z3AwbkhhQUdoVUNYN0pmTHV6bElrQTlaNlF1V01sTVRCZC84eW9SWnZtTEVP?=
 =?utf-8?B?YlpFZWVtKzdad2M4dVcvR1k4TmxJM3RiNEJSeWYwR0NodXliZHJUU2gvWlJt?=
 =?utf-8?B?czBkR0ZkK0ZBcE1kcWdIRnBlYlFORUlkdmpkMk82YUUrY2hoaHpkSnRQTjNS?=
 =?utf-8?B?WHRjOE5SMzcyU2VzZnVvWGp1dkx2dExkUGprUVVDTkQvTi9WbkVWREhGbVhj?=
 =?utf-8?B?VkxqdC8vRS9aRm5leTN5ZFlDVGdpV3I3anZ3OFVGMnVmcHBmWHFVVFZEN2R3?=
 =?utf-8?B?aWc1T0diOTl2K2FicytmRUE3SCt1OWVjVHVJZWt1amsxQm9HRWJET1UwSUIw?=
 =?utf-8?B?RiswNXVkRkg1Mk1RZkZWbE1Ydk5mLzg1SDRQRlYzak04MlNSVHAweFpzVHpL?=
 =?utf-8?B?a2ZHQjRlQXNLL3Z4T1FuaWJQUFNrbnVlSDJYdkZDcXZnRkNhRjBGNC9JbkMz?=
 =?utf-8?B?aTFPd3ZpM3NabG1Jc051VWFHeGlVTXE2K2xBOXRtMmlTdUJnOU9rWS9kdmJS?=
 =?utf-8?B?bE9pa2oyZU00OWxlY3pIVHk4TlhVZS9yZDRENVhNRHRjcDM0cGVpelNwMmx3?=
 =?utf-8?B?U1ZKbVdvaEtoRjNkRUpyK2xnNVh2MnNSRnNscGZ2QUdIMHlHOEdMT3J5QldM?=
 =?utf-8?B?ZlQ0Y290cW5CRGlkTWFrQ3FQU3NxaEd1Sy9jOWM5Tm9Cc0dBYUtZak9Yb3g5?=
 =?utf-8?B?V2xOVWVhc0p0M3BidTk5aGxHcFBsSEI1RzNwOFRBMjA5WE9yQ2tESEE5eVJk?=
 =?utf-8?B?Nm0rOGFEK0d3YTZacTFGbTRBKzFmY1EzbkhPN212YzE1TnJhL0NJbi9uVkFU?=
 =?utf-8?B?SndQVzhENXE2eFBsdUNFM3ZDZE9uNDNXclZVM3hYTzByZHYzdFkzQ1RCOGNS?=
 =?utf-8?B?dCtPWGJqY004S0lnSFRNWktmeEFlN2RRTzVkdXBNS3l4b0FhRlhZekt6U05p?=
 =?utf-8?B?QnJVTDRkT0xyOUtsVHQzajlveGVuaWUwWGFuZWtaUDhxSmt2ODFVbFNId2dx?=
 =?utf-8?B?TUE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 328916ab-a150-4792-02a4-08dbcff699a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 16:23:44.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLXOFa0/U8prMYX9n+jw4FvzWP1KC6GZudAR5IvCSbQGZNwUC3ZNboRBq0eGK3b7vLkp55spyQNlCRqCgH4goJYzgI7g9DDyf3UuircLbvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0760
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <C2413A2A98C57341AB451920D2121BA3@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmVlcmFqDQoNCk9uIFdlZCwgMjAyMy0xMC0xOCBhdCAxNTozNiArMDAwMCwgTmVlcmFqIHNh
bmpheSBrYWxlIHdyb3RlOg0KPiBIaSBNYXJjZWwsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIg
cGF0Y2guDQo+IA0KPiA+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsQHppc3dpbGVyLmNv
bT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTgsIDIwMjMgODoyNiBQTQ0KPiA+IFRv
OiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IFNoZXJyeSBTdW4gPHNo
ZXJyeS5zdW5AbnhwLmNvbT47IEpvaGFuIEhlZGJlcmcNCj4gPiA8am9oYW4uaGVkYmVyZ0BnbWFp
bC5jb20+OyBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo+ID4gPGx1aXouZGVudHpAZ21haWwuY29t
PjsgTmVlcmFqIHNhbmpheSBrYWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPjsNCj4gPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0
bWFubi5vcmc+Ow0KPiA+IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXgu
Y29tPjsgQW1pdGt1bWFyIEthcndhcg0KPiA+IDxhbWl0a3VtYXIua2Fyd2FyQG54cC5jb20+OyBJ
bHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gU3ViamVj
dDogW1BBVENIIHYxIDEvMl0gQmx1ZXRvb3RoOiBidG54cHVhcnQ6IEZpeCBidG54cHVhcnRfY2xv
c2UNCj4gPiANCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3Jh
ZGV4LmNvbT4NCj4gPiANCj4gPiBVbmZvcnR1bmF0ZWx5LCBidG54cHVhcnRfY2xvc2UoKSBtYXkg
dHJpZ2dlciBhIEJVRzogc2NoZWR1bGluZyB3aGlsZSBhdG9taWMuDQo+ID4gRml4IHRoaXMgYnkg
cHJvcGVybHkgcHVyZ2luZyB0aGUgdHJhbnNtaXQgcXVldWUgYW5kIGZyZWVpbmcgdGhlIHJlY2Vp
dmUgc2tiLg0KPiA+IA0KPiA+IEZpeGVzOiA2ODljYTE2ZTUyMzIgKCJCbHVldG9vdGg6IE5YUDog
QWRkIHByb3RvY29sIHN1cHBvcnQgZm9yIE5YUA0KPiA+IEJsdWV0b290aCBjaGlwc2V0cyIpDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJA
dG9yYWRleC5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gwqBkcml2ZXJzL2JsdWV0b290aC9idG54
cHVhcnQuYyB8IDMgKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jIGIvZHJp
dmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiBpbmRleCBiN2U2NmI3YWM1NzAuLjljYjc1
MjllZWYwOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+ID4gQEAgLTEyMzQsNiAr
MTIzNCw5IEBAIHN0YXRpYyBpbnQgYnRueHB1YXJ0X2Nsb3NlKHN0cnVjdCBoY2lfZGV2ICpoZGV2
KQ0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIHBzX3dha2V1cChueHBkZXYpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgIHNlcmRldl9kZXZpY2VfY2xvc2UobnhwZGV2LT5zZXJkZXYpOw0KPiA+ICvCoMKg
wqDCoMKgwqAgc2tiX3F1ZXVlX3B1cmdlKCZueHBkZXYtPnR4cSk7DQo+ID4gK8KgwqDCoMKgwqDC
oCBrZnJlZV9za2IobnhwZGV2LT5yeF9za2IpOw0KPiA+ICvCoMKgwqDCoMKgwqAgbnhwZGV2LT5y
eF9za2IgPSBOVUxMOw0KPiA+IMKgwqDCoMKgwqDCoMKgIGNsZWFyX2JpdChCVE5YUFVBUlRfU0VS
REVWX09QRU4sICZueHBkZXYtPnR4X3N0YXRlKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
MDsNCj4gPiDCoH0NCj4gVGhpcyBpcyBhbHJlYWR5IGRvbmUgaW4gYnRueHB1YXJ0X2ZsdXNoKCks
IHdoaWNoIGlzIGNhbGxlZCBieSBoY2lfZGV2X2Nsb3NlX3N5bmMoKSwgYmVmb3JlIGl0IGNhbGxz
DQo+IGJ0bnhwdWFydF9jbG9zZSgpLg0KDQpZZXMsIEkgd2FzIGFsc28gd29uZGVyaW5nIGFib3V0
IHRoYXQuDQoNCj4gSXMgYnRueHB1YXJ0X2ZsdXNoKCkgbm90IGNhbGxlZCBkdXJpbmcgeW91ciB0
ZXN0aW5nPw0KDQpZZXMsIEkgZXZlbiBhZGRlZCBzb21lIG1vcmUgdHJhY2luZyB0byBjb25maXJt
IHRoaXMuIEhvd2V2ZXIsIHdpdGhvdXQgbXkgZml4ICh3aGljaCBCVFcgd2FzIGluc3BpcmVkIGJ5
IGxvb2tpbmcNCmF0IHRoZSBmb3JtZXIgaGNpX21ydmwuYyBkcml2ZXIpIHRoaXMgYnVnIGlzIHJl
YWxseSBvY2N1cmluZy4gSnVzdCBrZWVwIGxvYWRpbmcvdW4tbG9hZGluZyB0aGUga2VybmVsIG1v
ZHVsZSBhDQpmZXcgdGltZXMgYW55IHlvdSBtYXkgaGl0IGl0Lg0KDQo+IFRoYW5rcywNCj4gTmVl
cmFqDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

