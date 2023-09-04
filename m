Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201E67911BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjIDHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIDHDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:03:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C141B11A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neN2Poidnw5jShxOksOo3Xnosf699qkgBO5ZjV9Fs/2EHXtTkMCNm06JDjTOhhd/7UobZHDAOSntjRXfaf2tn8J9YI8D0Yf2n8BkRx9KuFJnx54SGk7gRXzdDFadYg9IfeOPPDrbSf/htcf+LHZU1CgyndxtB/FPwwwmqoywwrjGegk8CpOgCPuFb5VBFjQfKwAUanpAa06k19Lv04nKlstR83mLRgF80ocXRKvtqim32qhUHbiGZ4iT6yVMJsokOKxWmRJaoh9ryq4nBB0wqkR1q/94A6DRiQlRzAGL3yV5PYVbE7FYUhlaGC90uMOkOCIGhPfmF0Dad832MKxS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rwPsy75n5K87DuR0PKkQ+DqqNXF6F37Bewh+AxqAZY=;
 b=X/u6sBGggbIkVsVUbTIasu2BL8USbHBL7BMC9doIxXmY6oZ7rW58KKNTHhzUlvGiu3xWdN+MpPHnE/34HIPmHeM47KT0wTVE6dBrtQSVsU+PzTtboJibrzhwEH5RdBy4xYbVcXXgxd45lcmvi0qmExMKQkqz/BZKFQDfNzqxMdJZrkes0laoHqwdJw/I8egK/E72akKsUCxE4jBAvbgKSTvoIb4wQlTogdWz+MjfVv2chlmsnEYLALg8/xe/mW6W2EYpNEd2QZSz0td6XrqVhi+5nzbH4MedwdE7ws9aByxFXFeL0FWKJX+LxJxxRAHdw+RY3TjAXCivMRR1gh1asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rwPsy75n5K87DuR0PKkQ+DqqNXF6F37Bewh+AxqAZY=;
 b=scnNYYpgyZqty47VDJGsRUFMjq5QsN2nAJ3hQlo2Kf4fR2+uZZcdvbPgNOQDb4OUZWp+QTQ/fR6yU+85DcoEDqmKmuyW/934YHZWwniJlk/T6iuthLR6AeReYXYOoDS6D+Vq66y7xg8si5ZLlcGLelq6Gj9RfIeWR8TTzIjiudw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6195.jpnprd01.prod.outlook.com (2603:1096:604:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 07:03:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:03:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2] regulator: max20086: Make similar OF and ID table
Thread-Topic: [PATCH v2] regulator: max20086: Make similar OF and ID table
Thread-Index: AQHZ3n1UL1GqcXV3sESD7f3Yj4yTyrAJj+OAgACtJIA=
Date:   Mon, 4 Sep 2023 07:03:32 +0000
Message-ID: <OS0PR01MB59222C22997B3391673A69BA86E9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230903154257.70800-1-biju.das.jz@bp.renesas.com>
 <20230903203719.GC13794@pendragon.ideasonboard.com>
In-Reply-To: <20230903203719.GC13794@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6195:EE_
x-ms-office365-filtering-correlation-id: ccafa73b-a3f7-4b44-ebad-08dbad150cc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXPMUwzrTzZqlC2VNeoat6LuJbkjRJ4kvbS2YeuPudoDN6wGfDTRAVVuuGo0WUZNlRa9iBx89GANz2aKl+hfMFcbAYdyp3opdCKu8bEVCWpdj4UJ4zUfvVsWu6isoYOqumUzEK9EJUqAyk3/HukMgEhN40QavZftMnMj1UvXYsA+khuZ3aNyvShNvQXAUfx2+f6/u5Mx766NlPbpqPzymCybYIZzb//6F/5FIXUyyGh3GBABYb4OwGLp07gvObHnC7HnyYqax3ro5QazUJhSV5WjjXTankGcNZvUpL764Sus+NLeFRc6Gk+Y7J2AoikHy5Q5jqpvpRvWElxmBZH17q9fRiMNQaGZVc3BULprtxWYsb3/LQK6RgA+smBzxu0GsasHsbKy4DXrr/SJxi9RAim6GWmadJx9vK6N6KrVaRhVB8mTWO8+4XO4NJFfg40sfBh6Kn72ffiEhXL//N/ySe+xEsUxxL8ilLBHB5jR7hTCkSy6dj1o3ARruKRDciwo/SDWU6GWSWNkJEX8gLj8CkVDJIO6KFNzyXyUA/M/HtYDLUwBCawOaUidmIRkFrwAbl7V3HE7b0cvtiRaxCxoWdlSSJbH/spKnBpFihAuYLNaPBxitkM9BeWutSa0oWVl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6506007)(7696005)(26005)(9686003)(122000001)(38070700005)(38100700002)(33656002)(86362001)(83380400001)(55016003)(8936002)(41300700001)(6916009)(316002)(54906003)(66556008)(66476007)(66446008)(64756008)(52536014)(5660300002)(76116006)(66946007)(8676002)(4326008)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDFyd01vUVBpK3gvZENyVFEyTER2d0k5a2FFdmd5QUlCVWxpOXFLUUkwd1RE?=
 =?utf-8?B?ZUdNQVdnRUFiTWJ4enhHOEVUMUhqWEdERU5iR0pNZHBFSUh6SGFZa1cyMUNC?=
 =?utf-8?B?TFR3T0x0anJJTEJVZEc4Tkl0ZmZ2c3l3RnNVR3k5bjc0Wm1tak5EaU9kS2Vh?=
 =?utf-8?B?NnBGTW9RdW44WERMZm5KN0RjVVk4VjNhUWdYRkNpYXppaStiZXc2Mk5GbzFx?=
 =?utf-8?B?S3RxdlJWcjZPSEJoOWEyZ1BZNXo2OVVERVJNQjRaYkIwUjY3MVV2ZHBLVlpV?=
 =?utf-8?B?YXFlRDIvaEpGaHE2aUNheDdYSDkyUldRRytlb2tyUmxYV29JTUJsWHBkL2w5?=
 =?utf-8?B?U0w1ODduNHBSVmM5OHd1ckRiV3l6c0U2c0RDYnJkSWsxNmRzSG9BS0ZkZWpv?=
 =?utf-8?B?amdXRDdxUmY1RklsVFNYV3FzVDV3RE00ZFBHT3ppbnBWQzFrUjdzNGUvT1cx?=
 =?utf-8?B?Z05vV3pFQnRMdENnMTFReXpBZ0taeHhaTGRHaURHZ1RzdmdRbkljTGgzNlpO?=
 =?utf-8?B?Q0NjQkI3VE9WeU95MDFqVVhWMlIrREFtb1h3TURKNU00b3k1TjF0emo4bEVs?=
 =?utf-8?B?WVZUNHJuZ1Y4UFg3d3NqMmpQL1E0M0w4WlY3VmJjMk10cEV3TGxtUGxxb2M0?=
 =?utf-8?B?aXcyY2Q2SkYxT0IwSUxXMjUyUVFER1gybnBhbWZJSmx6MS9VWUtid3ZIRTdR?=
 =?utf-8?B?d0R2NVh0cU5KdDRTMkd2dWYrdStBNm5qRllESUhTSE5NN09IY1lBSmNtUUNi?=
 =?utf-8?B?ZFZjQkJCT2FYM0tIUllpcDJHRWJMSnE5V3p1RTFWb2xWOTlBaVlXK1dhZ0Rh?=
 =?utf-8?B?WFFDYnJuT2p0dW41ZkJ5SEJaMmpuWUJ4WkhQbUhuMnRHeFJ0WkRuczVSZ01F?=
 =?utf-8?B?N3ZudFRtL2U2dzc4Q2dRa3g0RUZTUytWdUFmTlNuVGM1R0tsTGI5TUsxNFdO?=
 =?utf-8?B?VDZLZWYrKzNpTjdQN2xtMG9EQ3ltUFltcXJGdHdTbVIxUzNuNFRVZ1pjVjBU?=
 =?utf-8?B?aUV6ejdQS3pkWm0vZHQ1YktWUitocTJVMlFsQzA3YTB3TCt5MHNkbHo5cVUw?=
 =?utf-8?B?aHFZNnQ0YU1NSkZtTFBZUW5HK2FjUHg4Um4yZzRTNHJQQVByK0FLUkpEMitP?=
 =?utf-8?B?Sm9sQjY0WHh5Y2RxSGJyQ01RZFEvSFoxM3E5WUFTY2NlU1ZTeDJRazFjc0hk?=
 =?utf-8?B?Zk9wVTM4OXpwUllvUzNsaUp3RzFOQ2kwaitvMFRUT1dhVnl4cG9JZDZGYnh4?=
 =?utf-8?B?TGhiNG9JRHlkelpXWUJQZTY0WElrZk9QVHE0ZmVGU2J4cFFzQ1ArQTMwVksw?=
 =?utf-8?B?blBpSnU2aThFbEQzOVZKNExORDdNZis0eE83QnpFTGlXRHdxTCszRkMvcmZI?=
 =?utf-8?B?S0FSZkFkaitmZVpkSVdYL3FGdzZlTGFGdzVkWVVqMzJxcnd2VGdWeFdwaEI5?=
 =?utf-8?B?TnRabkQwN0VvdDlQc2RGaXNZeGl4bGw5R3dYajJSOHV2MVMyWjVoeE10R0hp?=
 =?utf-8?B?TWU5d1pMbkNpcmc3UFhPWDlYR1NkTG1TNkxBU01XSTMvS2tubUhyTnpUZW5h?=
 =?utf-8?B?Ui83NE0zOTR4UHdveExvRnNMR1pWRGExaHZjTW83NE83TVlHckFEVGxkM0JG?=
 =?utf-8?B?Z1JuQmpYT3V3REtaeHBDbGQxbkFkdncvbmJOdEx0T0xCWGdDQ3dxOHdjYWQ4?=
 =?utf-8?B?VW9RQlVBbDhYa21CeXErZnhwM1krdUU4WWw1Sy9TUzQ4M0c2bWpESy9sRVRt?=
 =?utf-8?B?b1cyVUFIVmtXMDBBWVdiLzlYdjQrT21zbmFKTDM0M21WeGFwR0hldzBZakhN?=
 =?utf-8?B?YUZFNG12QWp4V25yNDhjS2ppbDRzZlBMVlNQSWEyUmZWK0lUN1U5WFBpR2JO?=
 =?utf-8?B?Mm9IejIwRlE4RFB6bEx0bWlPaWtlQndKUS9FYVdKZGhBQm5XNmg3TjRaY3RQ?=
 =?utf-8?B?VDFudDU4S3BzMmFRdWpNaUcxSlFWWnZYZDNWSm96M3lIRlRkNWtNRmc3b2Zk?=
 =?utf-8?B?WHFjb0dzNHBKNDk1RS96TWlSQ2UwYmJ1REY0SHYvNjlzblN5L1doMExHbDRN?=
 =?utf-8?B?dzVSVUQxQjVVVHE4NS9CWUdjV3llUWVRRlZxUE4rM2kwNjhNUEt6QmN6dksr?=
 =?utf-8?B?cUlFSXRwZ3RxMTQ0WXQ1MGVBZVJhZUVlNU8wV0h2UTVucjFNZmFhOEtmWkVR?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccafa73b-a3f7-4b44-ebad-08dbad150cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 07:03:32.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmFDVDz+mg9uVGm/LmrpnHRy8WdqiIPQTqVibNqLCHmTwkokyPfAX/gHJlgyIsXiq9EG3EsVT2J6kUg2MwN2U03+E5F+lYqI+PWtYE64vic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCBQaW5jaGFydCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIA0KDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHJlZ3VsYXRvcjogbWF4MjAwODY6IE1ha2Ugc2ltaWxhciBP
RiBhbmQgSUQgdGFibGUNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBw
YXRjaC4NCj4gDQo+IE9uIFN1biwgU2VwIDAzLCAyMDIzIGF0IDA0OjQyOjU3UE0gKzAxMDAsIEJp
anUgRGFzIHdyb3RlOg0KPiA+IE1ha2Ugc2ltaWxhciBPRiBhbmQgSUQgdGFibGUgdG8gZXh0ZW5k
IHN1cHBvcnQgZm9yIElEIG1hdGNoIHVzaW5nDQo+ID4gaTJjX21hdGNoX2RhdGEoKS4gQ3VycmVu
dGx5IGl0IHdvcmtzIG9ubHkgZm9yIE9GIG1hdGNoIHRhYmxlcyBhcyB0aGUNCj4gPiBkcml2ZXJf
ZGF0YSBpcyB3cm9uZyBmb3IgSUQgbWF0Y2guDQo+IA0KPiBJZiBpdCdzIGN1cnJlbnRseSBicm9r
ZW4gZm9yIHRoZSBJMkMgSUQgdGFibGUsIGxldCdzIGRyb3AgaXQgaW5zdGVhZCBvZg0KPiBmaXhp
bmcgaXQuIFdlIGNhbiBhbHdheXMgYWRkIGl0IGJhY2sgd2hlbiB0aGlzIGRldmljZSB3aWxsIGFw
cGVhciBvbiBub24tT0YNCj4gc3lzdGVtcywgaWYgaXQgZXZlciBkb2VzLiBUaGUgbWF4MjAwODZf
ZHRfaWRzIHRhYmxlIHdvdWxkIHRoZW4gbm90IG5lZWQgdG8NCj4gYmUgbW9kaWZpZWQgdG8gZXh0
cmFjdCB0aGUgbWF4MjAwODZfY2hpcF9pbmZvIGluc3RhbmNlcy4NCg0KSSBhbSBsZWF2aW5nIHRo
aXMgdG8gcmVzcGVjdGl2ZSBtYWludGFpbmVyIHRvIHRha2UgYSBkZWNpc2lvbiwgd2hldGhlciB0
byBlbmhhbmNlIHRoZSBkcml2ZXIgb3IgZHJvcCBicm9rZW4gc3VwcG9ydCBsaWtlIERSTSBicmlk
Z2UgZHJpdmVyIChhbmFsb2dpeC1hbng3OHh4Pw0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KPiANCj4g
PiBXaGlsZSBhdCBpdCwgZHJvcCBibGFuayBsaW5lcyBiZWZvcmUgTU9EVUxFX0RFVklDRV9UQUJM
RSogYW5kIHJlbW92ZQ0KPiA+IHRyYWlsaW5nIGNvbW1hIGluIHRoZSB0ZXJtaW5hdG9yIGVudHJ5
IGZvciBPRi9JRCB0YWJsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiBOb3RlOg0KPiA+ICBUaGlzIHBh
dGNoIGlzIG9ubHkgY29tcGlsZSB0ZXN0ZWQuDQo+ID4NCj4gPiB2MS0+djI6DQo+ID4gICogUmVt
b3ZlZCB0cmFpbGluZyBjb21tYSBpbiB0aGUgdGVybWluYXRvciBlbnRyeSBmb3IgT0YvSUQgdGFi
bGUuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcmVndWxhdG9yL21heDIwMDg2LXJlZ3VsYXRvci5j
IHwgNjUNCj4gPiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMzEgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9yZWd1bGF0b3IvbWF4MjAwODYtcmVndWxhdG9yLmMNCj4gPiBiL2RyaXZlcnMv
cmVndWxhdG9yL21heDIwMDg2LXJlZ3VsYXRvci5jDQo+ID4gaW5kZXggMzJmNDdiODk2ZmQxLi41
OWViMjNkNDY3ZWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvbWF4MjAwODYt
cmVndWxhdG9yLmMNCj4gPiArKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9tYXgyMDA4Ni1yZWd1bGF0
b3IuYw0KPiA+IEBAIC0yMjMsNyArMjIzLDcgQEAgc3RhdGljIGludCBtYXgyMDA4Nl9pMmNfcHJv
YmUoc3RydWN0IGkyY19jbGllbnQgKmkyYykNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0K
PiA+ICAJY2hpcC0+ZGV2ID0gJmkyYy0+ZGV2Ow0KPiA+IC0JY2hpcC0+aW5mbyA9IGRldmljZV9n
ZXRfbWF0Y2hfZGF0YShjaGlwLT5kZXYpOw0KPiA+ICsJY2hpcC0+aW5mbyA9IGkyY19nZXRfbWF0
Y2hfZGF0YShpMmMpOw0KPiA+DQo+ID4gIAlpMmNfc2V0X2NsaWVudGRhdGEoaTJjLCBjaGlwKTsN
Cj4gPg0KPiA+IEBAIC0yNzUsNDUgKzI3NSw0MiBAQCBzdGF0aWMgaW50IG1heDIwMDg2X2kyY19w
cm9iZShzdHJ1Y3QgaTJjX2NsaWVudA0KPiAqaTJjKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPg0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgbWF4MjAwODZfaTJj
X2lkW10gPSB7DQo+ID4gLQl7ICJtYXgyMDA4NiIgfSwNCj4gPiAtCXsgIm1heDIwMDg3IiB9LA0K
PiA+IC0JeyAibWF4MjAwODgiIH0sDQo+ID4gLQl7ICJtYXgyMDA4OSIgfSwNCj4gPiAtCXsgLyog
U2VudGluZWwgKi8gfSwNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtYXgyMDA4Nl9jaGlwX2lu
Zm8gbWF4MjAwODZfY2hpcF9pbmZvID0gew0KPiA+ICsJLmlkID0gTUFYMjAwODZfREVWSUNFX0lE
X01BWDIwMDg2LA0KPiA+ICsJLm51bV9vdXRwdXRzID0gNCwNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbWF4MjAwODZfY2hpcF9pbmZvIG1heDIwMDg3X2NoaXBfaW5m
byA9IHsNCj4gPiArCS5pZCA9IE1BWDIwMDg2X0RFVklDRV9JRF9NQVgyMDA4NywNCj4gPiArCS5u
dW1fb3V0cHV0cyA9IDQsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IG1heDIwMDg2X2NoaXBfaW5mbyBtYXgyMDA4OF9jaGlwX2luZm8gPSB7DQo+ID4gKwkuaWQgPSBN
QVgyMDA4Nl9ERVZJQ0VfSURfTUFYMjAwODgsDQo+ID4gKwkubnVtX291dHB1dHMgPSAyLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtYXgyMDA4Nl9jaGlwX2luZm8g
bWF4MjAwODlfY2hpcF9pbmZvID0gew0KPiA+ICsJLmlkID0gTUFYMjAwODZfREVWSUNFX0lEX01B
WDIwMDg5LA0KPiA+ICsJLm51bV9vdXRwdXRzID0gMiwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgbWF4MjAwODZfaTJjX2lkW10gPSB7DQo+ID4g
Kwl7ICJtYXgyMDA4NiIsIChrZXJuZWxfdWxvbmdfdCkmbWF4MjAwODZfY2hpcF9pbmZvIH0sDQo+
ID4gKwl7ICJtYXgyMDA4NyIsIChrZXJuZWxfdWxvbmdfdCkmbWF4MjAwODdfY2hpcF9pbmZvIH0s
DQo+ID4gKwl7ICJtYXgyMDA4OCIsIChrZXJuZWxfdWxvbmdfdCkmbWF4MjAwODhfY2hpcF9pbmZv
IH0sDQo+ID4gKwl7ICJtYXgyMDA4OSIsIChrZXJuZWxfdWxvbmdfdCkmbWF4MjAwODlfY2hpcF9p
bmZvIH0sDQo+ID4gKwl7IC8qIFNlbnRpbmVsICovIH0NCj4gPiArfTsNCj4gPiAgTU9EVUxFX0RF
VklDRV9UQUJMRShpMmMsIG1heDIwMDg2X2kyY19pZCk7DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgbWF4MjAwODZfZHRfaWRzW10gX19tYXliZV91bnVzZWQgPSB7
DQo+ID4gLQl7DQo+ID4gLQkJLmNvbXBhdGlibGUgPSAibWF4aW0sbWF4MjAwODYiLA0KPiA+IC0J
CS5kYXRhID0gJihjb25zdCBzdHJ1Y3QgbWF4MjAwODZfY2hpcF9pbmZvKSB7DQo+ID4gLQkJCS5p
ZCA9IE1BWDIwMDg2X0RFVklDRV9JRF9NQVgyMDA4NiwNCj4gPiAtCQkJLm51bV9vdXRwdXRzID0g
NCwNCj4gPiAtCQl9DQo+ID4gLQl9LCB7DQo+ID4gLQkJLmNvbXBhdGlibGUgPSAibWF4aW0sbWF4
MjAwODciLA0KPiA+IC0JCS5kYXRhID0gJihjb25zdCBzdHJ1Y3QgbWF4MjAwODZfY2hpcF9pbmZv
KSB7DQo+ID4gLQkJCS5pZCA9IE1BWDIwMDg2X0RFVklDRV9JRF9NQVgyMDA4NywNCj4gPiAtCQkJ
Lm51bV9vdXRwdXRzID0gNCwNCj4gPiAtCQl9DQo+ID4gLQl9LCB7DQo+ID4gLQkJLmNvbXBhdGli
bGUgPSAibWF4aW0sbWF4MjAwODgiLA0KPiA+IC0JCS5kYXRhID0gJihjb25zdCBzdHJ1Y3QgbWF4
MjAwODZfY2hpcF9pbmZvKSB7DQo+ID4gLQkJCS5pZCA9IE1BWDIwMDg2X0RFVklDRV9JRF9NQVgy
MDA4OCwNCj4gPiAtCQkJLm51bV9vdXRwdXRzID0gMiwNCj4gPiAtCQl9DQo+ID4gLQl9LCB7DQo+
ID4gLQkJLmNvbXBhdGlibGUgPSAibWF4aW0sbWF4MjAwODkiLA0KPiA+IC0JCS5kYXRhID0gJihj
b25zdCBzdHJ1Y3QgbWF4MjAwODZfY2hpcF9pbmZvKSB7DQo+ID4gLQkJCS5pZCA9IE1BWDIwMDg2
X0RFVklDRV9JRF9NQVgyMDA4OSwNCj4gPiAtCQkJLm51bV9vdXRwdXRzID0gMiwNCj4gPiAtCQl9
DQo+ID4gLQl9LA0KPiA+IC0JeyAvKiBTZW50aW5lbCAqLyB9LA0KPiA+ICsJeyAuY29tcGF0aWJs
ZSA9ICJtYXhpbSxtYXgyMDA4NiIsIC5kYXRhID0gJm1heDIwMDg2X2NoaXBfaW5mbyB9LA0KPiA+
ICsJeyAuY29tcGF0aWJsZSA9ICJtYXhpbSxtYXgyMDA4NyIsIC5kYXRhID0gJm1heDIwMDg3X2No
aXBfaW5mbyB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJtYXhpbSxtYXgyMDA4OCIsIC5kYXRh
ID0gJm1heDIwMDg4X2NoaXBfaW5mbyB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJtYXhpbSxt
YXgyMDA4OSIsIC5kYXRhID0gJm1heDIwMDg5X2NoaXBfaW5mbyB9LA0KPiA+ICsJeyAvKiBTZW50
aW5lbCAqLyB9DQo+ID4gIH07DQo+ID4gLQ0KPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBt
YXgyMDA4Nl9kdF9pZHMpOw0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBtYXgy
MDA4Nl9yZWd1bGF0b3JfZHJpdmVyID0gew0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExh
dXJlbnQgUGluY2hhcnQNCg==
