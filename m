Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5117A008A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjINJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjINJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:43:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916730F4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qttlgn1i7uup5MXVKkFT5cfmqjWEuEZvMZiUzDoo5LOKSX1w7zxdNsu82kXmr7JyBhMaDthdJRKAe8kBvcN/dfAV81YgcYYkU2yfq9h1IWD0YkctxmiiJh/G0Tn9P8jvZxdIKsBSi/oKShq4DmnzthIwzD7vY+QmMMqqD8sJfiNtxcgxZcj+nHQGkrJOKnfuypIEWBp64GtcwG0ze7lzkbfe0GKUNDhUOqin2daBdKE+UZt9zBe/qACAhxgcsWJNP4v4iHabh85vPJK3FuPXaAoXYl6NIxMp1genMFkPSo3VpcSj4TxeyBP/scZ729IOmg7Tw0X/oEki4jClloskEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egyfOqMQqUYpFJ6TcU2lTfd7t+DlcCvIF0tYBMArd4E=;
 b=nUDwLELDpgHfqZhJl4UHko6AHoqJaRjqwBjRu6JtUmgrCXkxjqB99c8hTGdQfNXxRdCviw+pxX5mN8vb98C9CXlJCgbaU2zCqKjoLnNdvbzvi2VLbOU+jOZkMgSwpgiJah29Qqfq2ASYj/T3s80O81HpnFENBiLUu82Q6j4WlmoKQuZB4Fg+uH95l583nJcdWf/ECR+AHEmT27rg08xVnV+z79sggyvKnqNPStua9i+d7RwC6rQ/LBuGbxQrpzxFnTvSzBKV1srChxK1VPsGPMau/qz9tj0bKBWjWfLOtp6wEgFpf2VuC/1ddL1r413Wb76rEJ6e3zElJUNzUh600A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egyfOqMQqUYpFJ6TcU2lTfd7t+DlcCvIF0tYBMArd4E=;
 b=GWN0hZAa9C16/slAs0BgRXY6Jy23fb8qrBz/hjEjmDXvaPlfxtyTuykNiaGDYKwY92nrMW3VVmCPAikyeSJ+xr6kCBbONNAaAieRzt4UHyA4FjdosACqd3m3pjGheAoiGh9+qTSpFuEdh6h9qwEZKvbLcU+Af9GcvsOL4eDsbIWq9HMj9hIwWDIb4Xs15vAwN6Wyyv5ltTn+efCSosmO2n5tJ7tXG9Tr/c+h2nGylKjV8IpZ2IZUUb28V21FbJn0fOwJnrFa1WtMzsoJr/MTJ1hA5/e1/zEP2o1uWmir7hLCauMlcIai2UV1phy5K4bOXxsjQBCzHoWcw0N7OJI3oQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 09:40:20 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 09:40:20 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Fix double release of debugfs entry
Thread-Topic: [PATCH] vdpa/mlx5: Fix double release of debugfs entry
Thread-Index: AQHZ2p/zbYv0LgZ3c0m1iaCv6OXnnbAaKbKA
Date:   Thu, 14 Sep 2023 09:40:20 +0000
Message-ID: <6046d673ad79d14584b141ef1f1f4cbd397d7124.camel@nvidia.com>
References: <20230829174014.928189-2-dtatulea@nvidia.com>
In-Reply-To: <20230829174014.928189-2-dtatulea@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB7307:EE_
x-ms-office365-filtering-correlation-id: 4c058bf1-3103-40d6-b6cc-08dbb5069c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNtGpLlS5LLv0/SfjNni/rVbiI1GQFD3GcKQNRAOIhGGhqYPLzYFVj4++Ac/rf48WWNLXaj1vtqtxOQjYvuQhm25/HOf/f22pol9/i/JKiGN7X2RAZWjNXhqwTM7qlznbTX2mWTxQ6l4PtuCuwkGR3zn3RckslaiTR7PfgBHVNSc7ZlPAXSh66Dy1+6i8dzm7n9LCLlKWCuE7GJ6OSYjLlmY5EqV+mutvZ3ZfNrM7G/iAb6WwxKoS5kjV3IQh1Rkwbx3HPLdGd7HYefSSOwLo90dsSr9xi5jraB8D4FST6+AAZEmzCpa96gVmPewg7oXaN3RJ0BdncosjpgbY8IBshUg84S2EnTInnYRT8VD8/WHKzP59bJhZmW89D7MxoV9SupicoKiYoqtjDspOPOqXVK3wjU81Tp7AQm5tV5WB2BlZwSdA/+00s1BUrL4mQ7WgwEWY65Y/VSWACllZ+pmyC7bRw40neAupfoO7YribGjP3IPRLsnndXIM2CDwKm3gKd9h0WiY58eCiAUuirZfhMROyc6oQKUO3OBmLYmByrYCqXlj41zaikw9+OVJyva0RDzPlTQl8xXK2E/uowsTU1Dux2zIjkNuhz5Zhx3tcxQ8u78zw1AHKj41o/IzVRKG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(186009)(451199024)(1800799009)(36756003)(38100700002)(38070700005)(86362001)(478600001)(5660300002)(6486002)(6506007)(76116006)(91956017)(110136005)(54906003)(64756008)(66446008)(66556008)(66476007)(66946007)(316002)(6512007)(41300700001)(8936002)(2616005)(4326008)(8676002)(71200400001)(2906002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDVLYkJVNWRMY2gvWXg1Um55eWJYenFYMHh5VWlTZS9Xd2hBL3BEYzEvaytZ?=
 =?utf-8?B?VzVTcUVoWGdYSnBzdWh3Q2dwNmwzcDVLVUoyWFFiNFBXVThPemtrNEZSL2Iy?=
 =?utf-8?B?U0I1L2R6SDhOOTM4RThSUjRqelNQc2ZBcVRhbU9pcEpKczcweWVZdGEvRmtq?=
 =?utf-8?B?bXNTNk56TUJvMm1RZ21PaEJsN2czUEs5OGt5cndBUjZYRG0wV0tFdi9Gcmlj?=
 =?utf-8?B?d1FhODhXb001bkV1VUxtUVRUYm45dU5qdDVoTkYxaGhleXV2RHZ0c0pUc0FJ?=
 =?utf-8?B?OGduVFhNcWJMNmNyM21lZi8yRmpNZHN2aWI4Z09wdVEzNmdUcGtrMHRKUzJV?=
 =?utf-8?B?RDNVYXY1aGtIVnhqSlBrem1EZDM5NU81d2F2RjNqU2N5dXh2bERVRkVDVWJK?=
 =?utf-8?B?MzE5Uks2dWVsTytwWlRPTHVsQnQ2d3pMbUlSaTRLbXYrSUk4S1ZDalNHV1JQ?=
 =?utf-8?B?MDBsbmN6dTZudkxxaldmT3hRYUF1eU5Ua2hrUUNwNUp4RysyN3dhZ0ZPOU1w?=
 =?utf-8?B?Q1djTDZjZmZBR0ZSVjU2bDBkbFJJcEg3Wlg3dzZYeHd1b1FiZ2d5VkVxdmx6?=
 =?utf-8?B?Ky82VUFmWjdMdU5VVzdmeDZ1ZkFPbEZIRDVPNGFEd1duVWZBTVkvSDhEWVd4?=
 =?utf-8?B?VmYzNlNkTHh6SVdLSFlheTUrdDJJc25xUjFXekp3UVRsd0NVWUdpY3QzQ3VT?=
 =?utf-8?B?SG9EVWxSb09lU0ZmSW8rZkpWY0dEelVRWHMyM1Mzc3QvSHlWQTYycVF0ZTds?=
 =?utf-8?B?ZGpReS8xeTJFTTd4WjRrT3U2WTBGN0RSdDdjMzRwQTV3UE1YTzNQem1DNEMy?=
 =?utf-8?B?KzVGeEtMZ2xmNnhONnA3YS9mTmsvMUpMdzJ1OStvN21HOU9FdlppZFlxZ3ZK?=
 =?utf-8?B?SlhLUGdZdXhHY0ZYeWdleTBoSjZHcldnSW9iN295ejAvNHFlbHRjTUhnU09i?=
 =?utf-8?B?aDFlK25PMU5ybmJzdElhaVYvbmNYQkJsRzlMZldNWEdLT2ErRnZQWjZPT3Fp?=
 =?utf-8?B?TnRYMEt6ck9Wb1hrNkxuR1YvL3JNc2RIMC80bHJ3MjFvNDdMeENyQ2svdkxC?=
 =?utf-8?B?NytEQkpudXJEeG5jN1ZETzhESHpac1ViYkZDWlpTZUZUSGREdW5XWjJLQnBI?=
 =?utf-8?B?b0hTVHJwdlJaSWRkVGc4c21qRFFHUjZTRmNreWVyS1pzQzJ3NFc5TThydkV3?=
 =?utf-8?B?dExEYUFmOUZpMTBxQXhBRkVKNDVXSEJJSUxyUnVNclBlMEFyL1pDT3J5cUF6?=
 =?utf-8?B?RjFWTEc2bFB0Vk1ZcmxBTVdCTUExS0RiS05hWkc1VnBVdzI3eTJMRmRHMDZu?=
 =?utf-8?B?b3Z4T3FPeUUydUlLeStEeG5RcWMyUnhadnBJdVFpUHZ0VzZjRmxlYXUvWlF6?=
 =?utf-8?B?d2llNVJtVGhJemtWUkxoZXFOUGludCtkYnV5QVpHRUhPMVhCQWpIZWx5K3FB?=
 =?utf-8?B?eFNnekV4djVWYkFRNjRncG1nRVlaQ3ZYbDVrdFBsTy8vaUpYVEswT3ZwNGFn?=
 =?utf-8?B?R2NGMFRIR2FVRitRdVpLTkhSZUNISCsvZEtGQjlxdERSWTVDQW9hYzhDVE1T?=
 =?utf-8?B?OGJDWjc5R1BUeTVncjg2clpYRjdEYUZQZTVTeUpaalAwblhzVFJ6OHk5aUg1?=
 =?utf-8?B?SlBWME5hT1NpR3RZOEVMUTdKWmwwNERFWVR0UzN0S1NMcVRLMHl5WmZFU1Zs?=
 =?utf-8?B?NUFra2VEMHp4NUdmdHgya0dlVWRIL0luZVlrTmdGL1BRV2tRMWk5cFVSK2Vk?=
 =?utf-8?B?TWtsMFc3K3N2TnhuTWNyaS9WQkJDcFF0R0NReGFvajhmdmY3N0pydGxxMHZU?=
 =?utf-8?B?dnRwYUNjZ0dGT1RYcHluVHFMQVRDbHlXZllPZFQyTmtJeFNvWDg1VzBXaVZQ?=
 =?utf-8?B?dEV6NDV4V1ZFY1locitUU1drTU9xdnB4cDd4SEVVS0tZQXFRNVFmcDNoVHpu?=
 =?utf-8?B?cEszM0NIc2pOTzlFMjFnUmJEWFBTSWdVWDFvK2gvaWdra0ZRRndjeG9wWlh2?=
 =?utf-8?B?bFp4UjlVMWxoWU1Mbjk5QUJ5citBWFR4bUo1UGpmb0VQcWozWXZmZTNPbDhq?=
 =?utf-8?B?QTQ2VG9LRDRyQjV6eG5SZkh3S0Jrb2tKeVNKUWNQYW9vanVPSU5VaXB3Z1Ax?=
 =?utf-8?B?RlcvbTRHVjhiTlcwdDFlOEQwNkFWVFgyS1BxZUQ4dUg2bE9VdkptZHhsQzZS?=
 =?utf-8?B?ckZqREJnTXVpdjVCbTFNQUJQZHh3R0JxWGNralF0L2N3NEtmR3ZNYjQ2ZVB3?=
 =?utf-8?B?ajN1akJRUXgyVWtMbnZYVVMvdHhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B5D8315C0957B4BB8C2BB4D09FD4F3A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c058bf1-3103-40d6-b6cc-08dbb5069c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:40:20.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BULNlkUavgIIWqbo7wPKODDivhp1E1C5wpFF7esGAYx3KxdABrsQoohCc6uy4uvCs7F7+qjxBKqQujH8unbzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDIwOjQwICswMzAwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToN
Cj4gVGhlIGVycm9yIHBhdGggaW4gc2V0dXBfZHJpdmVyIGRlbGV0ZXMgdGhlIGRlYnVnZnMgZW50
cnkgYnV0IGRvZXNuJ3QNCj4gY2xlYXIgdGhlIHBvaW50ZXIuIER1cmluZyAuZGV2X2RlbCB0aGUg
aW52YWxpZCBwb2ludGVyIHdpbGwgYmUgcmVsZWFzZWQNCj4gYWdhaW4gY2F1c2luZyBhIGNyYXNo
Lg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgYWx3YXlzIGNsZWFyaW5nIHRo
ZSBkZWJ1Z2ZzIGVudHJ5IGluDQo+IG1seDVfdmRwYV9yZW1vdmVfZGVidWdmcy4gQWxzbywgc3Rv
cCByZW1vdmluZyB0aGUgZGVidWdmcyBlbnRyeSBpbg0KPiAuZGV2X2RlbCBvcDogdGhlIGRlYnVn
ZnMgZW50cnkgaXMgYWxyZWFkeSBoYW5kbGVkIHdpdGhpbiB0aGUNCj4gc2V0dXBfZHJpdmVyL3Rl
YXJkb3duX2RyaXZlciBzY29wZS4NCj4gDQo+IEZpeGVzOiBmMDQxN2U3MmFkZDUgKCJ2ZHBhL21s
eDU6IEFkZCBhbmQgcmVtb3ZlIGRlYnVnZnMgaW4gc2V0dXAvdGVhcmRvd24NCj4gZHJpdmVyIikN
Cj4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+DQo+
IFJldmlld2VkLWJ5OiBHYWwgUHJlc3NtYW4gPGdhbEBudmlkaWEuY29tPg0KDQpHZW50bGUgcGlu
Zy4gQXJlIHRoZXJlIGFueSBjb21tZW50cyBvbiB0aGlzIHBhdGNoPw0KDQpUaGFua3MsDQpEcmFn
b3MNCj4gLS0tDQo+IMKgZHJpdmVycy92ZHBhL21seDUvbmV0L2RlYnVnLmPCoMKgwqDCoCB8IDUg
KysrLS0NCj4gwqBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA3ICsrLS0tLS0N
Cj4gwqBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmggfCAyICstDQo+IMKgMyBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L2RlYnVnLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvZGVidWcuYw0KPiBpbmRleCA2MGQ2YWM2OGNkYzQuLjljODUxNjJjMTlmYyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L2RlYnVnLmMNCj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L2RlYnVnLmMNCj4gQEAgLTE0Niw3ICsxNDYsOCBAQCB2b2lkIG1seDVfdmRwYV9h
ZGRfZGVidWdmcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBuZGV2LT5yeF9kZW50ID0gZGVidWdmc19jcmVhdGVfZGlyKCJyeCIs
IG5kZXYtPmRlYnVnZnMpOw0KPiDCoH0NCj4gwqANCj4gLXZvaWQgbWx4NV92ZHBhX3JlbW92ZV9k
ZWJ1Z2ZzKHN0cnVjdCBkZW50cnkgKmRiZykNCj4gK3ZvaWQgbWx4NV92ZHBhX3JlbW92ZV9kZWJ1
Z2ZzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQ0KPiDCoHsNCj4gLcKgwqDCoMKgwqDCoMKg
ZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKGRiZyk7DQo+ICvCoMKgwqDCoMKgwqDCoGRlYnVnZnNf
cmVtb3ZlX3JlY3Vyc2l2ZShuZGV2LT5kZWJ1Z2ZzKTsNCj4gK8KgwqDCoMKgwqDCoMKgbmRldi0+
ZGVidWdmcyA9IE5VTEw7DQo+IMKgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jDQo+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+
IGluZGV4IDM3YmU5NDVhMDIzMC4uZjkxYzkzOGI0YmUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jDQo+IEBAIC0yNzEzLDcgKzI3MTMsNyBAQCBzdGF0aWMgaW50IHNldHVwX2Ry
aXZlcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpDQo+IMKgZXJyX3JxdDoNCj4gwqDCoMKg
wqDCoMKgwqDCoHRlYXJkb3duX3ZpcnRxdWV1ZXMobmRldik7DQo+IMKgZXJyX3NldHVwOg0KPiAt
wqDCoMKgwqDCoMKgwqBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMobmRldi0+ZGVidWdmcyk7DQo+
ICvCoMKgwqDCoMKgwqDCoG1seDVfdmRwYV9yZW1vdmVfZGVidWdmcyhuZGV2KTsNCj4gwqBvdXQ6
DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOw0KPiDCoH0NCj4gQEAgLTI3MjcsOCArMjcy
Nyw3IEBAIHN0YXRpYyB2b2lkIHRlYXJkb3duX2RyaXZlcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldikNCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghbmRldi0+c2V0dXApDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBtbHg1
X3ZkcGFfcmVtb3ZlX2RlYnVnZnMobmRldi0+ZGVidWdmcyk7DQo+IC3CoMKgwqDCoMKgwqDCoG5k
ZXYtPmRlYnVnZnMgPSBOVUxMOw0KPiArwqDCoMKgwqDCoMKgwqBtbHg1X3ZkcGFfcmVtb3ZlX2Rl
YnVnZnMobmRldik7DQo+IMKgwqDCoMKgwqDCoMKgwqB0ZWFyZG93bl9zdGVlcmluZyhuZGV2KTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoGRlc3Ryb3lfdGlyKG5kZXYpOw0KPiDCoMKgwqDCoMKgwqDCoMKg
ZGVzdHJveV9ycXQobmRldik7DQo+IEBAIC0zNDg5LDggKzM0ODgsNiBAQCBzdGF0aWMgdm9pZCBt
bHg1X3ZkcGFfZGV2X2RlbChzdHJ1Y3QgdmRwYV9tZ210X2Rldg0KPiAqdl9tZGV2LCBzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKg0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
d29ya3F1ZXVlX3N0cnVjdCAqd3E7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoG1seDVfdmRwYV9y
ZW1vdmVfZGVidWdmcyhuZGV2LT5kZWJ1Z2ZzKTsNCj4gLcKgwqDCoMKgwqDCoMKgbmRldi0+ZGVi
dWdmcyA9IE5VTEw7DQo+IMKgwqDCoMKgwqDCoMKgwqB1bnJlZ2lzdGVyX2xpbmtfbm90aWZpZXIo
bmRldik7DQo+IMKgwqDCoMKgwqDCoMKgwqBfdmRwYV91bnJlZ2lzdGVyX2RldmljZShkZXYpOw0K
PiDCoMKgwqDCoMKgwqDCoMKgd3EgPSBtdmRldi0+d3E7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmgNCj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmgNCj4gaW5kZXggMzZjNDRkOWZkZDE2Li42MGNkYmM5MDMwMzcgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuaA0KPiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmgNCj4gQEAgLTg4LDcgKzg4LDcgQEAgc3RydWN0IG1hY3Zs
YW5fbm9kZSB7DQo+IMKgfTsNCj4gwqANCj4gwqB2b2lkIG1seDVfdmRwYV9hZGRfZGVidWdmcyhz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldik7DQo+IC12b2lkIG1seDVfdmRwYV9yZW1vdmVfZGVi
dWdmcyhzdHJ1Y3QgZGVudHJ5ICpkYmcpOw0KPiArdm9pZCBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVn
ZnMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpOw0KPiDCoHZvaWQgbWx4NV92ZHBhX2FkZF9y
eF9mbG93X3RhYmxlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KTsNCj4gwqB2b2lkIG1seDVf
dmRwYV9yZW1vdmVfcnhfZmxvd190YWJsZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldik7DQo+
IMKgdm9pZCBtbHg1X3ZkcGFfYWRkX3Rpcm4oc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpOw0K
DQo=
