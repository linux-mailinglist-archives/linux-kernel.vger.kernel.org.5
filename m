Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2007D7B108D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjI1CDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjI1CDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:03:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CAC1;
        Wed, 27 Sep 2023 19:03:21 -0700 (PDT)
Received: from kwepemd500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RwxVn50XczNnmP;
        Thu, 28 Sep 2023 09:59:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemd500002.china.huawei.com (7.221.188.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 28 Sep 2023 10:03:19 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Thu, 28 Sep 2023 10:03:19 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     zhenwei pi <pizhenwei@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Halil Pasic <pasic@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>
Subject: RE: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: Re: [PATCH] crypto: virtio-crypto: call finalize with bh
 disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5QAk7LIAAAEdD4AAMnHjIP//vvqAgADI4ID//3VFcA==
Date:   Thu, 28 Sep 2023 02:03:18 +0000
Message-ID: <53d400c057564aa28930bbf3d76ddeff@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
        <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
        <20230926130521-mutt-send-email-mst@kernel.org>
        <9564c220c8344939880bb805c5b3cac9@huawei.com>
        <20230927152531.061600f0.pasic@linux.ibm.com>
 <829bc434-89e6-b17e-b832-d0d83480c80f@bytedance.com>
In-Reply-To: <829bc434-89e6-b17e-b832-d0d83480c80f@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogemhlbndlaSBwaSBbbWFp
bHRvOnBpemhlbndlaUBieXRlZGFuY2UuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDI4LCAyMDIzIDk6MjQgQU0NCj4gVG86IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+OyBHb25nbGVpIChBcmVpKQ0KPiA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+IENjOiBI
YWxpbCBQYXNpYyA8cGFzaWNAbGludXguaWJtLmNvbT47IEhlcmJlcnQgWHUNCj4gPGhlcmJlcnRA
Z29uZG9yLmFwYW5hLm9yZy5hdT47IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IE1hcmMN
Cj4gSGFydG1heWVyIDxtaGFydG1heUBsaW51eC5pYm0uY29tPjsgSmFzb24gV2FuZw0KPiA8amFz
b3dhbmdAcmVkaGF0LmNvbT47IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDb3JuZWxpYSBIdWNrIDxjb2h1
Y2tAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFJlOiBbUEFUQ0hdIGNyeXB0bzogdmlydGlv
LWNyeXB0bzogY2FsbCBmaW5hbGl6ZSB3aXRoIGJoIGRpc2FibGVkDQo+IA0KPiBIaSBNaWNoYWVs
ICYgTGVpLA0KPiANCj4gSSB2b2x1bnRlZXIgdG8gZml4IHRoaXMgYnkgd29ya3F1ZXVlLg0KPiAN
ClRoYW5rcywgcGF0Y2hlcyBhcmUgYWx3YXlzIHdlbGNvbWUuDQoNCj4gSSBhbHNvIG5vdGljZSB0
aGF0IGRldmljZSBkcml2ZXJzIHVzZSB3b3JrcXVldWUgdG8gaGFuZGxlIGNvbmZpZy1jaGFuZ2Vk
IGFnYWluDQo+IGFuZCBhZ2Fpbiwgd2hhdCBhYm91dCByZS1pbXBsZW1lbnQgX192aXJ0aW9fY29u
ZmlnX2NoYW5nZWQoKSBieSBraWNraW5nDQo+IHdvcmtxdWV1ZSBpbnN0ZWFkPw0KPiANClBlcnNv
bmFsbHksIEkgcHJlZmVyIHRvIGltcGxlbWVudCBpdCBpbiB0aGUgZGV2aWNlIGRyaXZlciBjYXNl
IGJ5IGNhc2UuIHNvbWUgZGV2aWNlcyANCndhbnQgdG8gd29yayBpbiB0aGUgdXBwZXIgaGFsZiBv
ZiB0aGUgaW50ZXJydXB0IGNvbnRleHQsIHN1Y2ggYXMgdmlydGlvLW1lbS4NCg0KPiBCeSB0aGUg
d2F5LCBiYWxsb29uIGRpcnZlcnMgdXNlcw0KPiBzcGluX2xvY2tfaXJxc2F2ZS9zcGluX3VubG9j
a19pcnFyZXN0b3JlIGluIGNvbmZpZy1jaGFuZ2VkIGNhbGxiYWNrLCBkbyBpdA0KPiBoYW5kbGUg
Y29ycmVjdGx5Pw0KPiANCkl0J3Mgb2suIFRoZSBjcml0aWNhbCByZXNvdXJjZSBwcm90ZWN0ZWQg
aXMgZ2xvYmFsIHN5c3RlbV9mcmVlemFibGVfd3EuDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo+
IE9uIDkvMjcvMjMgMjE6MjUsIEhhbGlsIFBhc2ljIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjcgU2Vw
IDIwMjMgMDk6MjQ6MDkgKzAwMDANCj4gPiAiR29uZ2xlaSAoQXJlaSkiIDxhcmVpLmdvbmdsZWlA
aHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4+IE9uIGEgcmVsYXRlZCBub3RlLCBjb25maWcg
Y2hhbmdlIGNhbGxiYWNrIGlzIGFsc28gaGFuZGxlZA0KPiA+Pj4gaW5jb3JyZWN0bHkgaW4gdGhp
cyBkcml2ZXIsIGl0IHRha2VzIGEgbXV0ZXggZnJvbSBpbnRlcnJ1cHQgY29udGV4dC4NCj4gPj4N
Cj4gPj4gR29vZCBjYXRjaC4gV2lsbCBmaXggaXQuDQo+ID4NCj4gPiBUaGFua3MgR29uZ2xlaSEg
U29ycnkgSSBmaXJzdCBtaXN1bmRlcnN0b29kIHRoaXMgYXMgYSBwcm9ibGVtIHdpdGhpbg0KPiA+
IHRoZSB2aXJ0aW8tY2N3IGRyaXZlciwgYnV0IGl0IGlzIGFjdHVhbGx5IGFib3V0IHZpcnRpby1j
cnlwdG8uIFRoYW5rcw0KPiA+IGZvciBmaXhpbmcgdGhpcyENCj4gPg0KPiA+IFJlZ2FyZHMsDQo+
ID4gSGFsaWwNCj4gDQo+IC0tDQo+IHpoZW53ZWkgcGkNCg0K
