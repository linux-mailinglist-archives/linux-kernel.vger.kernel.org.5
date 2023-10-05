Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585787B9EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjJEOJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjJEOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9188B2754E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq21pTKoCOKeRo/EXvZUCOhbamHz2ng9DkNBgVRhfUDcDrxt+HStFS6g/RlaeqtpPtaioTa7JqJXX2zpz6Ylt4Ax3E/HIGmY1saW85Ly9NR5aw2NS9FwukGSC0BKxPvmGHGXv8Ocy8L9rj80xm6Of1UkQPp0jkeZPZjvqtU5GBGehMCQgKJWuqpcn2pSUM6POE9Ae0tzLFnZHwdMiDenY6xmG3ghSRPOJBbpBux57cH398Rwz4FfO6Gj0sh3k+vmcARz6nr44e/kz3TpThlXKI4ZrT9gUwkVcgOkmX+DF/zoZPmfhnTQihl535DC40CywSiV6PnXi0Jw7TedQi9JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdlZvrPWC0Wc0eimL4H5LkR+17k9ukaZePHK0sgnKk8=;
 b=lKXA6IWmLuKivWNNqhbVsTKEvpSW9VRYwxIkwMbxIDBC9XG9C4KKvKkgqXuAQgHEXmg21qDz3mlVCzXvkbn0yC/IaAenWONSxFm+9lcMMNINvdwavAd2rYsRPa/VkjxWNybEb4AjdgYBElKeHkZavond0OtIkw6X/6FpaJ5HKv9jUf+gYGKZGRjIOncHJWgDCwQiJWDHoC8edHYSpqGv53kY9YqLAKB0a9kfbqv81A94Ry1V1nnD4cJYP70SZm+0L2ZD0chvdkJhymrVprAuOAai7AJHCTw6kfCjkAdnH8LJmSB8oyjPr+cR2PEWf7wiXo4yHThVdvJ+1p8qqBD8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdlZvrPWC0Wc0eimL4H5LkR+17k9ukaZePHK0sgnKk8=;
 b=Gb77RcqOdGCi/i4ceF+vDxM4utMnT/8iRAYDQYyfH6qbAcz5TfKMjLxxan7WHrUzpZ9mE0asxIyJfI+pgrp8W90AC+0/66unFNkAsN4+v0/E4uAk16tB0J0iB6Y3YwVKyiJ8JKY8ZZmg8DegejLrCTArG35n4naw60ecf2IrxTRU/i/2kS044HzeriKM66zT5TWxQzIM2E794xiLgtrnFV//q+7JuhiDw6nJglGAmrrlIZtbZRCgnNs3BPhOolTXo6XmsYycakommcJNnfdaCRcw0B3HSyc3WLawHUbMxOV+2sm+G0mkVu1K2LWw8C9YEuZqiElzanOmSxbDeExyow==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 13:12:12 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 13:12:11 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "eperezma@redhat.com" <eperezma@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID
 change
Thread-Topic: [PATCH vhost 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID
 change
Thread-Index: AQHZ8ivjXSyhgo8OLUeQVwGXiDv5FbA7DL0AgAAqAwA=
Date:   Thu, 5 Oct 2023 13:12:11 +0000
Message-ID: <b6f90921bc239fc0e1fc04dc62e4376fcd622376.camel@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
         <20230928164550.980832-18-dtatulea@nvidia.com>
         <CAJaqyWe9iYnh_DwZbU4986bSAZ0C1=Y9Th6-vv_ZRTTYwQqhYA@mail.gmail.com>
In-Reply-To: <CAJaqyWe9iYnh_DwZbU4986bSAZ0C1=Y9Th6-vv_ZRTTYwQqhYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|DM4PR12MB6183:EE_
x-ms-office365-filtering-correlation-id: 3d257e4d-4863-48f0-6744-08dbc5a4afda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvSMnmlBG8Z2yEGvZRZbAJW+s/V/C0g1QlKsntDD2X5r8NF+Q8KOCCHsEr2eJS8eOTwMk0Es36I+rLQOLY6Ztv85/BrOtM3XsbvJw5iVUuiWjNl3npWegx8cCMT0GkgcAc4vC8bE11fwuItATTlKc6p1bQZoBy+qZ0uSHHausDBx2yIa1VdI584pzt0K9be7McsOcpuc3DKkdUSauxtclU4vQVhE9zcvO6a6ZxYTlBGxAGZ/pZ7jww0ifrCVordEDh8GsERYRNsLj9WdxE6KD4IomT3J+QFg36ScGKoJv/UBisg+8qOpGwCAiLqknlbSpsL/+ZD9uxvL3F9Iy/Y40mCTi6oBNfxHGM2x+GkfnNDQDQSwao2vPpnWam+E3VtALghSLSzyPgtYrh/su6CwIkf9ALMjGC8gr+k7aPXSkKrxeXYulq40zN/GhWf8UCyyF2gesJkJfOTDvdqxfTofWuVOUBEEQuYOS34xcLjAbSaBlqRBnHzw3pKS++Kt5mCxZ5xq8RoXtokus3+KIWuSRMVosv0SCf04gJnJC6XnBjUxtswhQRUcjycfwBd2W5iVqSQOdmT6b7edUZSz6p1yxZrxUVXQ6a/bQEUnd8cXL+/1FzcT6T5aF1qm2Yu2ajyx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4326008)(6916009)(66556008)(6512007)(66946007)(8676002)(5660300002)(8936002)(54906003)(64756008)(66446008)(316002)(478600001)(66476007)(2906002)(71200400001)(53546011)(76116006)(91956017)(6506007)(6486002)(41300700001)(66574015)(83380400001)(38100700002)(36756003)(2616005)(86362001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWNESi9EZS93bjltaVFmYTA2eDQ3NkNBQ2FldjRCWVh0eExVNW5abll1eGhx?=
 =?utf-8?B?RDAvZnNpUzNhN3VRbHp3Y1ZjNmdqZVNCNDMvam9rckhSM3VzTW5oeHcrL1FL?=
 =?utf-8?B?K2kya3BGY3lLNE1Kano0VTM4bkc5MXJjZnpRdm82R0RESkdGZkUvdDRVeU45?=
 =?utf-8?B?amdRRDBwMi9QdW1zM1pJYUlQd3Q3SW0zTHp1TkRuWmNpS3hHSnFrN2ZCN2Ft?=
 =?utf-8?B?bTJoWllORnh1akRvRHE2UzdsNTF1V3ZzYkNYbjlMeHVuZ0tieXoxNzNpSFF3?=
 =?utf-8?B?TDl0NDl3MFBVNUQrS0dxUThodWI1V3hpclNGK0xvNFpoazNuWEx5NUxpK3lX?=
 =?utf-8?B?ZWdBMEJhMEdZZ3E2Z2FkT0J4MlE2SVcyWURUMFNOajdtb2Foekwra0dVR1hQ?=
 =?utf-8?B?WWNPMFZ3K3NUYXNIWjQwYlFtNDI2ZGlVMGFoSDd5dWpJTi9RT21IZENqYytM?=
 =?utf-8?B?bHFJOWlrR1RYcTNwWkkyWFVQMXRlTkhDTk02VUxaOG95bHhIcFJGMW0xa0wv?=
 =?utf-8?B?aVBFTURIVUh4dnNxZjhCZlVZdTZ1UFpYbVFIcEtFcndVaCt4NVZIdWR0a0ZN?=
 =?utf-8?B?REtDZS9xZDIyaEU3L1VMMmkvUHZVVjQvazNuOFBtMDlEdkZxNWJlWlFybDZQ?=
 =?utf-8?B?b2UzOU1WRlNRWG1iYjlxampSZFRXcWpaSGZvZVI4VU8vTFhhdldmUGpZYW9B?=
 =?utf-8?B?MURkZHZ1cDBGOEVVbS9pelFQWDQzT0Y1Q3VNMDgrRzJnK0Y0SmJEb3puZ1o0?=
 =?utf-8?B?WUxvdmZtN2dERGFaYWMxS014MzFNNURLRDgya250Zit5ZFRpQ2drdGkzZkY5?=
 =?utf-8?B?UzdDekw0Uk93dFV5YTBZcTRoT0hFNHZXMUNEb2tLSG9TR3YzVnloUDU4S2p1?=
 =?utf-8?B?NDZ1bCt6VXVPTFhPOERlMzFpWlNtZEZ3bzFmNGVOUXRESklIdEZwcWZPRUY0?=
 =?utf-8?B?Y2o4dVhmRHZYbkZBb1RVZWJnVWhoQ1pGR0dsOG56VHNzTzViRGs2RW1XVW5o?=
 =?utf-8?B?eU9DSEdweTJLeHdLQ1NJaFN5SytuUWZoS09oV2VDc3RVVlVGcldxTUNTVDBW?=
 =?utf-8?B?aEQveVVrNW9qVmU4cmdwNC8xcXVUQmZCYnZuTjkveEhxY3k1Wkp3MTNMWDJ0?=
 =?utf-8?B?L0hZUHA4VjhJOTBxRHpMdmM1aXFvelFXeURFREpSNEsyOW1TbUROb295Q0sx?=
 =?utf-8?B?WkRjYnRUbGJNbWtYM3d4bThzQnE5cEFtYyt5cXBFMHpNS2N0R2ZaQWl6eE1u?=
 =?utf-8?B?QURNdk1mcFJGQ0ZKc1BITXNzQkw1VXJZOFlmc09mTHROY0RTNldjUDdvMnhI?=
 =?utf-8?B?aiswaVFhQlMzYWE4Y1NuTjdnbVlCUmpseDFCZ1EySGNCazQ4elJUeldFMHZJ?=
 =?utf-8?B?c2FNMHZIVlBTdHJPd1J4Y3JGR0dvMmJURFdOdE4yMkI2Z29WanZmRjUxOGRQ?=
 =?utf-8?B?SHZhZzkzWm9xM3RMdE1JQzB6N3pHWWNVR0tQdGs4VHNQMVQ0NlBHeWlmTTBE?=
 =?utf-8?B?T09kVm1kSnJDV0dMbUczZDVPWllvWlNaSXE4WTdvRkUyM0J0MjVVNEY5bmNO?=
 =?utf-8?B?eW0zbWxKZk1xZ01WcWpYbGFXS1hORjJCUGR5cFUzb3NkUkMzZzZWUEFHWXBL?=
 =?utf-8?B?d3Y1UjdFbFFGWjBNZkh5NWo0ajhJd3FVNXhrSzAzZ2JEVlJsZlcyV0dUeG9p?=
 =?utf-8?B?QThGN1ZUMjkybVJMbktrSmc4ZXh2bW4ycWZlQmNsZ2VadTgvOE9ES1ovV0k1?=
 =?utf-8?B?OW4vUkM1bHErTlZMdkh6RkhjQXRRWit6M2h3OUJmUk13QTJaZnkxQ1EzRGFK?=
 =?utf-8?B?bk1Pcmk0N2JEN0MrUUE4N1R0a0ptRm1ObmNQSTJkdlBWMmNTNUhyRnlmelRH?=
 =?utf-8?B?N2p1WFprd1RXd0dJMCtEU014cHh5MXl1OGNHcjF5VXd6OENiRStMRFFhRWly?=
 =?utf-8?B?ZExySWFzeU02Y2NWNXFmNXhRalkyZWZvS25iUDc0NUgzclFVaXNpdVR1c0Uw?=
 =?utf-8?B?ZklaVjZRM2VabU9XUTVMTi9LTWhtMjJuejkwa1Q3bHY1Zmw3ZDBQS29vNFhV?=
 =?utf-8?B?OFZ3TGRzUVNuTnIwNHFhTUxWSS8wRTRZcUhMTGo4S1RCRFFSYTFZWnBQR2V4?=
 =?utf-8?B?R0o4ajZMQTJiVHFybk82STdSQzNscHR1dmE1SXp3RG04NGkrcTkxajlwWTVa?=
 =?utf-8?Q?6WeWmgIAoO/YADGMjyYfK2ecrBqj+orYAYxp7vD5n4US?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <336667B4DF6ACB43ADB84A2BB61D6E91@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d257e4d-4863-48f0-6744-08dbc5a4afda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 13:12:11.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HV6S9yIHhR0xFCJoAobPQ5M/jTwOac0HzFFAZM1k2QRA62iKTpRXcBNEuOm28iKeDv7I2XUPZ9xr5Hsf2CFGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDEyOjQxICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToKPiBPbiBUaHUsIFNlcCAyOCwgMjAyMyBhdCA2OjUw4oCvUE0gRHJhZ29zIFRhdHVsZWEg
PGR0YXR1bGVhQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gCj4gPiBGb3IgdGhlIGZvbGxvd2luZyBz
ZXF1ZW5jZToKPiA+IC0gY3ZxIGdyb3VwIGlzIGluIEFTSUQgMAo+ID4gLSAuc2V0X21hcCgxLCBj
dnFfaW90bGIpCj4gPiAtIC5zZXRfZ3JvdXBfYXNpZChjdnFfZ3JvdXAsIDEpCj4gPiAKPiA+IC4u
LiB0aGUgY3ZxIG1hcHBpbmcgZnJvbSBBU0lEIDAgd2lsbCBiZSB1c2VkLiBUaGlzIGlzIG5vdCBh
bHdheXMgY29ycmVjdAo+ID4gYmVoYXZpb3VyLgo+ID4gCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3Vw
cG9ydCBmb3IgdGhlIGFib3ZlIG1lbnRpb25lZCBmbG93IGJ5IHNhdmluZyB0aGUgaW90bGIKPiA+
IG9uIGVhY2ggLnNldF9tYXAgYW5kIHVwZGF0aW5nIHRoZSBjdnEgaW90bGIgd2l0aCBpdCBvbiBh
IGN2cSBncm91cCBjaGFuZ2UuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbWx4NV92ZHBhLmggfMKgIDIgKysKPiA+IMKgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
wqDCoMKgwqDCoMKgwqAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqBkcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmPCoCB8wqAgOSArKysrKysrKy0KPiA+IMKgMyBm
aWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gPiBiL2RyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiA+IGluZGV4IGFlMDkyOTZmNDI3MC4uZGI5
ODhjZWQ1YTVkIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaAo+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ID4gQEAg
LTMyLDYgKzMyLDggQEAgc3RydWN0IG1seDVfdmRwYV9tciB7Cj4gPiDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBsb25nIG51bV9kaXJlY3RzOwo+ID4gwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBudW1fa2xtczsKPiA+IAo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlv
dGxiOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqAgYm9vbCB1c2VyX21yOwo+ID4gwqB9Owo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92
ZHBhL21seDUvY29yZS9tci5jCj4gPiBpbmRleCBhNDEzNWMxNmI1YmYuLjQwM2MwODI3MTQ4OSAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ID4gKysrIGIvZHJp
dmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gPiBAQCAtNDk5LDYgKzQ5OSw4IEBAIHN0YXRpYyB2
b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rldgo+ID4gKm12ZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhXwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
c3Ryb3lfdXNlcl9tcihtdmRldiwgbXIpOwo+ID4gwqDCoMKgwqDCoMKgwqAgZWxzZQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc3Ryb3lfZG1hX21yKG12ZGV2LCBtcik7Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgIHZob3N0X2lvdGxiX2ZyZWUobXItPmlvdGxiKTsKPiA+IMKg
fQo+ID4gCj4gPiDCoHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LAo+ID4gQEAgLTU1OCw2ICs1NjAsMzAgQEAgc3RhdGljIGludCBfbWx4NV92ZHBh
X2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rldgo+ID4gKm12ZGV2LAo+ID4gwqDCoMKgwqDC
oMKgwqAgZWxzZQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IGNyZWF0
ZV9kbWFfbXIobXZkZXYsIG1yKTsKPiA+IAo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoZXJyKQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqAgbXItPmlvdGxiID0gdmhvc3RfaW90bGJfYWxsb2MoMCwgMCk7Cj4gPiArwqDCoMKg
wqDCoMKgIGlmICghbXItPmlvdGxiKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlcnIgPSAtRU5PTUVNOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBl
cnJfbXI7Cj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgZXJyID0g
ZHVwX2lvdGxiKG1yLT5pb3RsYiwgaW90bGIpOwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoZXJyKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfaW90bGI7Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gKwo+ID4gK2Vycl9pb3RsYjoKPiA+ICvCoMKg
wqDCoMKgwqAgdmhvc3RfaW90bGJfZnJlZShtci0+aW90bGIpOwo+ID4gKwo+ID4gK2Vycl9tcjoK
PiA+ICvCoMKgwqDCoMKgwqAgaWYgKGlvdGxiKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZGVzdHJveV91c2VyX21yKG12ZGV2LCBtcik7Cj4gPiArwqDCoMKgwqDCoMKgIGVsc2UK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc3Ryb3lfZG1hX21yKG12ZGV2LCBt
cik7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+ID4gwqB9Cj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+IGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiBpbmRleCA0NjQ0MWU0MTg5MmMuLmZj
NWQ2Yjk4OWE1YSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiBAQCAt
MzE1NCwxMiArMzE1NCwxOSBAQCBzdGF0aWMgaW50IG1seDVfc2V0X2dyb3VwX2FzaWQoc3RydWN0
IHZkcGFfZGV2aWNlCj4gPiAqdmRldiwgdTMyIGdyb3VwLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBh
c2lkKQo+ID4gwqB7Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYgPSB0b19tdmRldih2ZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqAgaW50IGVyciA9IDA7Cj4gPiAK
PiA+IMKgwqDCoMKgwqDCoMKgIGlmIChncm91cCA+PSBNTFg1X1ZEUEFfTlVNVlFfR1JPVVBTIHx8
IGFzaWQgPj0gTUxYNV9WRFBBX05VTV9BUykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVJTlZBTDsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgbXZkZXYtPmdyb3Vw
MmFzaWRbZ3JvdXBdID0gYXNpZDsKPiA+IC3CoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJm12ZGV2LT5tcl9tdHgpOwo+ID4gK8KgwqDCoMKg
wqDCoCBpZiAoZ3JvdXAgPT0gTUxYNV9WRFBBX0NWUV9HUk9VUCAmJiBtdmRldi0+bXJbYXNpZF0p
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBtbHg1X3ZkcGFfdXBkYXRl
X2N2cV9pb3RsYihtdmRldiwgbXZkZXYtPm1yW2FzaWRdLQo+ID4gPmlvdGxiLCBhc2lkKTsKPiAK
PiBEbyB3ZSBuZWVkIHRvIHByb3RlY3QgaGVyZSBpbiBjYXNlIHVzZXJzcGFjZSBzZXRzIHRoZSBz
YW1lIEFTSUQgdHdpY2U/Cj4gbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIgc2hvdWxkbid0IGNh
bGwgZHVwX2lvdGxiIHdpdGggdGhlIHNhbWUgc3JjCj4gYW5kIGRzdC4KCldoeSB3b3VsZCBzcmMg
YW5kIGRzdCBiZSBpZGVudGljYWw/IERvZXNuJ3QgZHVwX2lvdGxiIGNyZWF0ZSBhIGNvcHkgb2Yg
c3JjPwoKVGhhdCBiZWluZyBzYWlkLCB0aGVyZSBzaG91bGQgYmUgYSBjaGVjayBpbiBkdXBfaW90
bGIgZm9yIGRzdCA9PSBzcmMuIE5vdCBzdXJlCmlmIHRoaXMgaXMgYW4gZXJyb3Igb3Igc3VjY2Vz
cyB0aG91Z2guLi4KClRoYW5rcywKRHJhZ29zCi0gCj4gQXBhcnQgZnJvbSB0aGF0Ogo+IAo+IEFj
a2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAKPiA+ICvCoMKg
wqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZtdmRldi0+bXJfbXR4KTsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqAgcmV0dXJuIGVycjsKPiA+IMKgfQo+ID4gCj4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
dmRwYV9jb25maWdfb3BzIG1seDVfdmRwYV9vcHMgPSB7Cj4gPiAtLQo+ID4gMi40MS4wCj4gPiAK
PiAKCg==
