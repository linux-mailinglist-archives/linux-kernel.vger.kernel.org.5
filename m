Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BC7A743B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjITHfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjITHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:35:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15BCE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVdN/AvdBtC3C2bnDnXqfzgnZKaDKhc9BZi5GA+wvFcqUbxq97abi1kh3VtxdJjT0C9mkWOAJQTimXhzmF2d5QRS1Qur4eLuf6aaqgK/kYgmJzldBViEAsiLDBGbN+B9CG80m8HBRGF1pQhJ/rEV+9Zx827cl6QFe+2OpQ1sw04WcCNeKte2X+pnyyAr4xu69wj8WKy9hUeAKCI9UiRvohlZDX0xfQnQQLYMtP4qyQX0yXiiBPANngtuAZ9uQZr++1oCGSvbATG6srjFRx04XCWJX4UmF+RhMGa+HfuIxBwrWEmUpjLpMytO6Z1sQHqrXsG7ygeOwUyVWzE5dl1gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YECQx/UWESkEpmJ2r90CTg6JgqARvf1tSbyYy6VeXTs=;
 b=Z/fozslOa2E9rUI4qQnVe1eOSFtifVnfJbU1Oh6llUsQnioGan+HNSM8I8vQugtGOYkLOfDtN8+JwYZgEiHqGRNtfe4WDqff6dpxkFFfEQ20b6FsqxH3vtvV2/qsoDteHOnkdyCMCWLvyrWcbn+iYSwRvNLPW0EzAL59IO1Ky+moXXLhM7oYyTE+r5YJEggEs8mYgEpBGid9nwdxo2vwaAHsdoyf+ABJOQWyLU1VpOXMH8ptBItqq/OwswE1s1pRKEPhlaVWW3G9Dc+hYRhbfwyYDRbE6nxqVjcOT7E4Wt5OHlPvVD9nQX2mukMo8MpPXajLEJizPynRbTY1E7NooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YECQx/UWESkEpmJ2r90CTg6JgqARvf1tSbyYy6VeXTs=;
 b=VZLAMUEczP/21VONsSqByQvT+tf6iiTvjRKdeItjrF16FX7ciLBulA49+f8gCqPve75KRllzmB+QfTX3fOFKxoHsTpYZs2ynki2O+u+pFaKynE8DoVzBkvTri7sX+EZr99kYVNqpJ6+3kn5YshT2UhNcUNDFXIEKHMKFHCvJ0adgMFF0/5S9HYNpE/eKHJ16nYrV8CG+wJ7qU95M5P8tNa7hwkcOoRkYQhvYDseqc3yK3PJraqh/pmJldB1kzcXDoqmRGe5/tcD/BF3fZOYgXlzp1vf5YNFyWOqLj7DHvtJpHtDpMYPvxELGRodBsbOgO9kKm7i1rLq5MGiZDUfiWQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:35:34 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:35:34 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAATtgIAAAbEAgAAAlkA=
Date:   Wed, 20 Sep 2023 07:35:33 +0000
Message-ID: <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
In-Reply-To: <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: a260b1c4-ad6b-4e45-c2f9-08dbb9ac2cd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQ3SGoSP0sdwQixG2c84fWrbug62AVetictZYDDmbYX+fbWaP06obGzYY4EuIUl/AUtJpV0T7rR4Um1Bm1IUKRxjJ0svVrByTBXCsn0Hd/X/dRZ64WMPN43eo8e+ZkLna5ne1QH6YBc4PToHCTS3pgecfAw+16MvktwysX89q7yUvPCtuwYxWrTmjBuXvk1LQzfVJcpoz2cc5jWSVwTKIjCQ6UpaysFOkEx2PckbSgcF/fowG50CaI00SMlmvNyvqx8Z76FOu5BXdauyDeTa8VCVma3nG7zZM07Veg3FiYgXSN3/PZZFLk2giktmL0WvOZmT/F6SZUinG/cStrgzf0zwR3Xjd2G1v1J4LJXmJZswP2cdwkafFAWPVYPMF2pp3X7kPRq6OR74AletTKjVa1ZwVe7KYoBRxDYWCob+93rvgbKKGqi3yL1AyDsEJWYQL2ugnW4tR+jdEjgYedu2gQ4KUVuxkWNONeP1m59QKiG8ZG2Cv+RxBoQ+2yYukkammmUh2ri5LylpETDcD/sB5JP1/TzBNa0DdUE3ifqk1mK53TMOiCnJ7mcGOu2TfCbEOYEwsFRobszagkISIj1GwQAZ3RERwl4KJMmUbR0ALWklH3aAJsggTOrusfi/1fYD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(38100700002)(55016003)(38070700005)(6506007)(7696005)(53546011)(71200400001)(478600001)(33656002)(86362001)(122000001)(2906002)(26005)(4744005)(9686003)(83380400001)(64756008)(5660300002)(41300700001)(52536014)(4326008)(8676002)(110136005)(7416002)(66556008)(8936002)(66946007)(316002)(54906003)(66446008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q29mRElpbXBqMmtxdDVGS09BWldPNHNQVDJRMkJRc1JaUzQ1dUN0b2o5SC9l?=
 =?utf-8?B?cUZxdnBhRlM4aHlLUnV2bTFwMEJFVDVJcE15dTIvWDIyd2Y3ZVZMeURIcWlV?=
 =?utf-8?B?ME1wQW9jQUtCTGNSMUdIaXAyOXBmaFNQMmp6bTJBcnl3Z2hXOXZOUU00S01N?=
 =?utf-8?B?RkMweWlzT1p6L3oxY2h6bEVpZ1k4amFnZmNSemRZK3ZIcXhKdE44d0RpSU54?=
 =?utf-8?B?TVdqcnVFSHBqVlduVk1oVlFmUE9Yb0E2c21sUGF2Y3ZGZFhMQmZ6NU96TE5I?=
 =?utf-8?B?TEpRdGE5WWJCbW1CSHA3N2l1a2UzbjFwNWRTZHhQeVdZeXpTMEZneW1kbGlw?=
 =?utf-8?B?YUl2QlM1Q0RSem9HbC9Kd2F0bUF5dzh1bUNPOTV3UExuRFZqS25tT2pOcFBM?=
 =?utf-8?B?bHJZT0FQaThEOTdQNWNteSt3SVNDUDhtRldOS3U1Nkx0TlZLckIwKzRmUzFa?=
 =?utf-8?B?Y25iYTJsd2hLa1M3aUlrd2lkN0RaSDZTOHpaUWlRR004cWN6SG1vS3ArYmpN?=
 =?utf-8?B?VmM5alZZOEVNSVY5UmxEU1dYbEM2MzBDNDYxVlY0Y1NaeDBYYzJZUlFUMmNY?=
 =?utf-8?B?YWVUSUdDTkErbm1NVVlyYTlkcWFReWZjcTBEdGlyQ091Uk9idm5LZkMzNzNL?=
 =?utf-8?B?cHI1NExDQ05ZYVk3a3Z3YXJaN2o4bUF6WVpXVkl4QkM2VzJaZ0FicS9FSVZt?=
 =?utf-8?B?VS9GZmZMU1hkRE9IR1Z6d3FxbDV0Z0gzYnpGR0FneWR0RzdLUDRTSWJWZEVG?=
 =?utf-8?B?WHhRaGkrZzJvRjVhcWZucDl6TUd3YWZydk10V3p1TnlCeGlBc0U4NkppUnhZ?=
 =?utf-8?B?aHorNFJmNzRpT29zL1k4ekhOWHQ1cDYyVjZ0S1ZUVlZMZ2cwcUNpUnRHRkdU?=
 =?utf-8?B?cVVBOXZvRHhVYlFNZVZYdzVnMjFaTkgvRStxRDF6YTk4Qmw2b1kzbC9WU1Yw?=
 =?utf-8?B?aEN6cjE5dW5FUDdLY0pETU9nL0RHc2hrcWxNMmt4L1VvVHl6WncrN05lQWZs?=
 =?utf-8?B?dkpjRXBONWY5eUJoUjRJN2w3dVRtbmlEOUxKSEsrMG5GRFBpdUJLdXZJVE5z?=
 =?utf-8?B?TWhzVzAyTjNTbnlERWg3cy8rcXduK04yMWRJY3RnZ0NMendMWGNqRmhQbGQx?=
 =?utf-8?B?SFRZN0RZVkN2M050QU1pTUNJZ0VjQWtkY0Zhd3JSeHdFZDQzTkNhZ0FabWFt?=
 =?utf-8?B?cWxmMEJ1cW1wTDg5cnVqdFJsb3NGaDQ3UjhOU3laa2JWc0ZMbUxCU3poWVZp?=
 =?utf-8?B?S1NYcURTenZIM3VZNlJXNEw5QnozZDFxemMyOGJRNXMrMURhY0o3NVAvdmNU?=
 =?utf-8?B?MHVuWTRNV1FUVUFBWGs4MkhhVHE2N05TS0hPcThjeFV4Q0RHRVN2aExxZnBH?=
 =?utf-8?B?bWdSSE9iVEEyc0pYcG9NVFRlRXZ5R1FRK05JWFlHRHVoR2hLTlRaSEwrMmJI?=
 =?utf-8?B?SHBvNDh6LzJvc0ppVGhPZnR5OTN6cnhJc01OdzYvRnVMQlBwY0hWMzZ2YURv?=
 =?utf-8?B?Y3d5R1lsOUZ5bHNpOFpNWFk5TllRVEVuWkdFckxxUnBCdWxndDFUUks1TmtH?=
 =?utf-8?B?VTlFSDhITk9CRkpoT1FQcng2a3d0RFZEQ1ppNm0wb2JFbjdKQ25HVXA3aGwv?=
 =?utf-8?B?ejdaTWRZMkdJZHBaMWE2ak9aOVc1VmcrQ0Y0c0ZOM2p5RndoT0xFVXVXQ2RN?=
 =?utf-8?B?MWsycW14cGJUWk1WUU1qWXhtVXJrejM5TG1nWGdvODhYUS9pVmtNbUVLZnlY?=
 =?utf-8?B?bUd5MGgvZFlNbGZoRFJydG0zMUlsODNIL0RuZUVzNzF6NjVNZ2U5ZkJGc3du?=
 =?utf-8?B?eS9qRFdUTXFRQTZqaTFZV0pzS3MrUlI5YTFVM3ErM2FyM21KcEluTE5hKzB2?=
 =?utf-8?B?K0NseXdEdXJKZ2ZZVVJYd0h1bDhrS1FSdy8rRUEzeStYM050ci80ZElPZ2pj?=
 =?utf-8?B?VDdzd1hLdHdQRnQ2OVlBWmpsQzJTSFppbEswYUJQV3M2MkFQM2h3d1FqU1pu?=
 =?utf-8?B?VHIyZGtRZUZUbHhpMXhNa1FIUGhrSnFteGliQjk0QUx0ZTc5NExQeHJMdVpS?=
 =?utf-8?B?RUhPaEF2MEhUTzRSVTRjREwvUFF4cGF3S1phOVN3QWlibUw0amZpajVMVDNh?=
 =?utf-8?Q?oh+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a260b1c4-ad6b-4e45-c2f9-08dbb9ac2cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:35:34.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynxYcseOYBn9ciE4+LcUeDAB3oWSSsauBSgbkQ+wVtYtk1KubpHTSCAgUCC2yd7vjIlDuOA0cMQ10V5nnQvZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6MDAgUE0NCj4gDQo+IE9uIDkvMjAvMjAy
MyAzOjI0IFBNLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+ID4gSGkgTGluZ3NoYW4sDQo+ID4gSXQg
c2VlbXMgeW91IHJlcGx5IHRvIHRoZSB3cm9uZyBlbWFpbCB0aHJlYWQuIFRoZXkgYXJlIG5vdCBy
ZWxhdGVkIHRvIG15DQo+IHBhdGNoLg0KPiBUaGVzZSByZXBseSB0byBQYXJ2YSdzIGNvbW1lbnRz
Lg0KPiBAUGFydmEsIGlmIHlvdSB3YW50IHRvIGRpc2N1c3MgbW9yZSBhYm91dCBsaXZlIG1pZ3Jh
dGlvbiwgcGxlYXNlIHJlcGx5IGluIG15DQo+IHRocmVhZCwgbGV0cyBkb24ndCBmbG9vZCBoZXJl
Lg0KWW91IG1hZGUgdGhlIHBvaW50IHRoYXQgInRoaXMgaXMgbm90IGxpdmUgbWlncmF0aW9uIi4N
CkkgYW0gbm90IGRpc2N1c3NpbmcgbGl2ZSBtaWdyYXRpb24gaW4gdGhpcyB0aHJlYWQuDQoNCkkg
cmVwbGllZCBmb3IgdGhlIHBvaW50IHRoYXQgZGV2aWNlIHJlc3RvcmF0aW9uIGZyb20gc3VzcGVu
ZCBmb3IgcGh5c2ljYWwgYW5kIGh5cGV2aXNvciBiYXNlZCBkZXZpY2UgaXMgbm90IGEgNDBuc2Vj
IHdvcnRoIG9mIHdvcmsgdG8gcmVzdG9yZSBieSBqdXN0IGRvaW5nIGEgcmVnaXN0ZXIgd3JpdGUu
DQpUaGlzIGlzIG5vdCBsaXZlIG9yIGRldmljZSBtaWdyYXRpb24uIFRoaXMgaXMgcmVzdG9yaW5n
IHRoZSBkZXZpY2UgY29udGV4dCBpbml0aWF0ZWQgYnkgdGhlIGRyaXZlciBvd25pbmcgdGhlIGRl
dmljZS4NCg==
