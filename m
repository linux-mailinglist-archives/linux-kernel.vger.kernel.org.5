Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E37A73D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjITHR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjITHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:17:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6589BD7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCn2kDFMhNSCzJ8nd8oAVKiZiBd0NBID1aVtUowqpjhbgNNlO+d/DbkNYwXl4G3J0sOR4cFwzkxE8tpxQWVZ6aFlMb9yHC4J1eEggJ+iGS8BICm9O/cKVAISx98FfFl3/0RP2wltz55UFRAASsoi6NOB7rIvzluNiA+OkTuEeRK/cLpMFRIzuEB9cU8lz19MNcBPdGBbqew1CwqchxWIajosRjmlSRQ7gCxGvJTsF9MyF/s04j4FpdhDp691iACv4KGEgcwtnNCZP20/5xCg13xj6hc5kj/BwsvDJmVXu9Nkb+oHOlSMY/hCQagsLUokcv2gDi264cX1pOaPpRuF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbD4G+bmu/9ys7tf5KFdvbXfewTDoOiB/uiPZCHsEWw=;
 b=G+IB3Y8z/AjxYIJMryW2hEZpYfoROKi5XqwOosx+rEWylhpwLXUFVnU57O4TqMOK3QpoeM/Pf3d52DIiSJpLb6e/CTmaYqCAOXGThhVSKgHz7bKEa/4Jsub3H7HT7tHVkpBMY1/fZ8STa2HJeHYSCSeTAyuWx2GCY1lQt2zMyAxUufyTwEzeea3ttaPMDrfZDpKORnibzKzATQPRvdVQvhH89GPHlTm4iilqYRP6p9AbXmzdPa0TLTOtVkxI7FcVN9Cm5B3WKsv/3hSaEw9KeiBgofpnUnB0DWfAGM5/pw8PSDhP5meHD9W3rjrFsd5mz7TTfr8H/By+zqXZmCSmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbD4G+bmu/9ys7tf5KFdvbXfewTDoOiB/uiPZCHsEWw=;
 b=HGP5gqPVAln26JhyYwXD2/hXnjllH2SM761b8lVHXI/jAPTuPH4BhOdFxo8EXC58+i0d98LNm5snMKgYKkx4qmgAxXxxsU4k6Av+GZrG8aFBtfuKxczUjYqJl4zt9emfhajf6Z092sI8e8zpMcb2QWXixn/qNM1Nv1Whl7PWRxQ=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 07:17:11 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:17:11 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
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
        Parav Pandit <parav@nvidia.com>,
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
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiFHuAgAEk1ACAAI2IgP//gx8AgACHcIA=
Date:   Wed, 20 Sep 2023 07:17:10 +0000
Message-ID: <BL1PR12MB584905241D62294075BC701BE7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <badb53e0-513c-f88c-67b9-ecd59d1cf051@intel.com>
In-Reply-To: <badb53e0-513c-f88c-67b9-ecd59d1cf051@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6792.025)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BY5PR12MB4082:EE_
x-ms-office365-filtering-correlation-id: be15b0c8-ec9d-4c68-9c9c-08dbb9a99b52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMvslNwROa/9tNGWl+jUzrUaL0IcnNR5vsSNc3kGwSX60NO4q92dtR7kyf+CVusjhh9C5P6zgvagK55k7BzaqO8+B2QWnOpnggs7EYLsQcYVgMtEbK+Yj5puVhROJmmV4v3C2yeDif18o9uWWE1IWyB51TkNWuOQx5pqJfpSzAXp5O925sWfAbURzJrnSYw8pX4QLJ2sPczAS2Mb8QGsIOf0kKaeBziNO/le0+rDwPyhV42/o93K450nxRoD21ru0djHb49ahQB2cYM4mfyWQ1D44nZ/I0iMmizGLHSAxbw/XgBQDPauuIGopOkQl0ijwMzJMiU50u55PoWqmJn/VHoMPE7Tze6EMoUKHutXEWmTvn4JwY1Qsx/5J5ek5gpO/PCzvw6rwRm9T50Q/uSQlXKlpx53VFweiXgsjdkhO16AH8tDMbHj4eRdf6XHMNVhUEltH1rHNZemCH9877AR8r1jgJ/IULy72dcN+r7jSb7N4HYy0aHZ0ulQhJb3MrQmFjuSC9OfyKZq/ky/fDfCG24fqef3tNx0ouwNWW6+43MfMm6cw/KuqMkJxUZVcFEtE1mTvg9KxiPfaMlNFVs3ILkdmY+BJ5jxTXN3hHb45+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(186009)(1800799009)(451199024)(9686003)(66899024)(55016003)(26005)(66556008)(66476007)(76116006)(66946007)(110136005)(41300700001)(54906003)(64756008)(316002)(122000001)(66446008)(38070700005)(38100700002)(478600001)(966005)(6506007)(7696005)(53546011)(71200400001)(83380400001)(52536014)(5660300002)(33656002)(7416002)(2906002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1pvREdyRGE0YXpZVlN2MmdpaWZhNWhUcTQ1c1dWUGZ2OTFDUythNWtoY1hU?=
 =?utf-8?B?cjZRZlUraVFuZFJDSUZNM2RVdW8wbWFZOGRGQmdpWTlmekdaeEY0UWhTb05Z?=
 =?utf-8?B?Q0JOV3NSN3lXZDFjWjBGZTZuMjZDRFFyZFlnK0FacFEyWFp1cFRteXRZUWh4?=
 =?utf-8?B?U0hlYTJBQVhYRzZFYnRWeGY5MkdEWFpab01HZTF3TkZsKy8yeStJblJtRHdr?=
 =?utf-8?B?UmtDaHFFSUVPS2RTVGFXYVNGZFRQdEZKRXgwazNJY1B4ZU5YSC9zMENXTnZt?=
 =?utf-8?B?ZDNWdElpVVBBZ1JvWE41UGovOHZ3dEgwUGRNc2s5SHcxYXFyT3o3b3Q0TmUx?=
 =?utf-8?B?OEdwenV1S05XZkpFa05GcU5NRldNUmhDSnBhcnFCd25ZWlhoT3pkM3FnU0Fl?=
 =?utf-8?B?SDZXelp3NmM3eVVORVVGTVlXRWdPZGxPeDNmWTVndnlwek5qQkZ3ZHVOM3R2?=
 =?utf-8?B?RWtKS0hKaHNtYXN1QnNHSEhseU1vQmxySmpUUExxVEx6ZzBVYmlIZFdpdUhk?=
 =?utf-8?B?alpVb051VzRRdjBNVG5LL3gyL05qRk1yVk5FNHB3ZHJTYktPOVVEM2tMUzNX?=
 =?utf-8?B?cWlXMFcwWUJIamdUVDE1Y1JIa05YVkFRNnMzQVI0Z1FsL1BjKytvaEkxZ0Y1?=
 =?utf-8?B?K1hCRUVKZUNtVHEvYzJseXRuTlZacEFxUkYraG9tRkNrc0pJRUJZRy9nK0NL?=
 =?utf-8?B?R2IzVWZmdTBmM3B4SUFVZFY5OXFtdFVjR1laUVp5R0RZbXFyWGVRenZFRjlG?=
 =?utf-8?B?ZUZzS1VpWTFka1BoMFRjellGMlQzcnBCb3hyYmUrMjhaL3lWZWtnWDVZNWlP?=
 =?utf-8?B?Qk5MMVduU0ZZeDV2QW5ucUI4REI5YjVwUGdDZGNGa1g3ZHBSUVg1OUFMK3Nx?=
 =?utf-8?B?TFdKWUpOVUJUM1ovb0tHRTdTcTBZYU83MWpUdEtZU1luMXFrRnk4SFc4U2lx?=
 =?utf-8?B?RlBxUDRBWXpWVTc0ejNmM0RjTjN6SDhwRVNqMnZZaEM3SlFMOEc5ZzJ3WmtL?=
 =?utf-8?B?WXZxc250ZkZhUkF1ZGh1UnZCeWw0R0VUOUN6OHR6VWFUUVo0WkxBRWlRdnpM?=
 =?utf-8?B?Z0ZJYzlWSWZPdW05WG11ZGw2MzZ4SGtZa3hiWDZGb0VBbXQ5TmdnalAwRDAy?=
 =?utf-8?B?VCtCekR5NkE2bE4zaXFmOFVqWVV2MDlyWXczNS9BWjVGNWoyalFPb09EOGRr?=
 =?utf-8?B?T28xZVVvVnZ4Y3FlRkpvR3pEOVZUOEJQeWZnMHRxeEk2VXB0OWJkZmVUbXNU?=
 =?utf-8?B?QW1zM25iQ1ZFWGVXeDR2dkw5TkZNc0ZKVzlJYjdhVUJiSTQvaUhZaEN5N0Vp?=
 =?utf-8?B?NnM0MmlwVW5oQ1Q1bldUZUlrUjVuVWtkVklNUm9FTFV4ektVN0t3VEdtaWV4?=
 =?utf-8?B?RWpyOFV3dytaY0NlZlRxRmZOcllLVGlpTUxmV2tHREpHVUwvdC9ZcGtJcHdV?=
 =?utf-8?B?MTdLSnYzWGhObTl2NzhJQlovWFNFV2NocmRRY0FqUU8xSk1TMjZqbXhoaVRz?=
 =?utf-8?B?UldhOXF2WEFQbmFGam1TM2NZOUZXUlVzbW9rK29vS0RtSEdVMm15ZU04U3ZN?=
 =?utf-8?B?cFpTVDRmZkNrUjBKS2M4U2k2amtlUVpvdllDTDlaWmNoK3J4Zmwxem4xTUVC?=
 =?utf-8?B?ZjM5dDRRdkM5eU9peXdXRUdoU25UejVJWWE3S2JHK1owZXBWOVhmVWhBTkJj?=
 =?utf-8?B?VmJ5Z2lOdXZNaEtSY1lBQVpMVTYxUXNhencvcU83RDNVQVhzUnIvRHBFYnlt?=
 =?utf-8?B?djdEcnM0TmlrWmRtNkRxNlZ4WmkzWSs5czJmU1BJRkI1SndRUlRycEg5b3Y5?=
 =?utf-8?B?dFQ5dXdrc1BneHNZOWRwVlhqbzBmUHBueHMrV0dYOHBNamR4bTJtQm8xelps?=
 =?utf-8?B?T2NsblJXQzJhZUl5YUZaVUNKRGpHSERFanVISnFDMGV5YUhSSjYydkgzNkhv?=
 =?utf-8?B?QTJEVnFiL3pFU2RZZ0kyOTlnZlBic0VLdko2cFZmMC9pdjRDMlROdTVUYlA4?=
 =?utf-8?B?L2RBVFJVakRTNEZTRFVQV0pFdms2RnVybmxhRkphVWk1R2YxbjVtYm1qQmVj?=
 =?utf-8?B?VG5jbkNIMElYK21JVk02T0pnOEt3Q1VDenhWOVJoN2x3ZmY1aW5JczNEbSto?=
 =?utf-8?Q?72Mg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0679A72BA0576F40A2F3997C07521E83@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be15b0c8-ec9d-4c68-9c9c-08dbb9a99b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:17:10.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGsRHITirJSHvrReaHFDC/u1lI8NVSPkvKorDeh42fXvlqk52U/vPtNPOBX75Lv6n0/bC1XLYH/CfQmxGAgXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGluZ3NoYW4sDQoNCk9uIDIwMjMvOS8yMCAxNDo1OCwgWmh1LCBMaW5nc2hhbiB3cm90ZToN
Cj4gDQo+IA0KPiBPbiA5LzIwLzIwMjMgMjozMyBQTSwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4g
SGkgTGluZ3NoYW4sDQo+Pg0KPj4gT24gMjAyMy85LzIwIDEzOjU5LCBaaHUsIExpbmdzaGFuIHdy
b3RlOg0KPj4+DQo+Pj4gT24gOS8xOS8yMDIzIDg6MzEgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToNCj4+Pj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMDc6NDI6NDJQTSArMDgwMCwgSmlx
aWFuIENoZW4gd3JvdGU6DQo+Pj4+PiBXaGVuIGd1ZXN0IHZtIGRvZXMgUzMsIFFlbXUgd2lsbCBy
ZXNldCBhbmQgY2xlYXIgc29tZSB0aGluZ3Mgb2YgdmlydGlvDQo+Pj4+PiBkZXZpY2VzLCBidXQg
Z3Vlc3QgY2FuJ3QgYXdhcmUgdGhhdCwgc28gdGhhdCBtYXkgY2F1c2Ugc29tZSBwcm9ibGVtcy4N
Cj4+Pj4+IEZvciBleGNhbXBsZSwgUWVtdSBjYWxscyB2aXJ0aW9fcmVzZXQtPnZpcnRpb19ncHVf
Z2xfcmVzZXQgd2hlbiBndWVzdA0KPj4+Pj4gcmVzdW1lLCB0aGF0IGZ1bmN0aW9uIHdpbGwgZGVz
dHJveSByZW5kZXIgcmVzb3VyY2VzIG9mIHZpcnRpby1ncHUuIEFzDQo+Pj4+PiBhIHJlc3VsdCwg
YWZ0ZXIgZ3Vlc3QgcmVzdW1lLCB0aGUgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5kIHdlIG9u
bHkNCj4+Pj4+IHNhdyBhIGJsYWNrIHNjcmVlbi4gRHVlIHRvIGd1ZXN0IGNhbid0IHJlLWNyZWF0
ZSBhbGwgdGhlIHJlc291cmNlcywgc28NCj4+Pj4+IHdlIG5lZWQgdG8gbGV0IFFlbXUgbm90IHRv
IGRlc3Ryb3kgdGhlbSB3aGVuIFMzLg0KPj4+Pj4NCj4+Pj4+IEZvciBhYm92ZSBwdXJwb3NlLCB3
ZSBuZWVkIGEgbWVjaGFuaXNtIHRoYXQgYWxsb3dzIGd1ZXN0cyBhbmQgUUVNVSB0bw0KPj4+Pj4g
bmVnb3RpYXRlIHRoZWlyIHJlc2V0IGJlaGF2aW9yLiBTbyB0aGlzIHBhdGNoIGFkZCBhIG5ldyBw
YXJhbWV0ZXINCj4+Pj4+IG5hbWVkIGZyZWV6ZV9tb2RlIHRvIHN0cnVjdCB2aXJ0aW9fcGNpX2Nv
bW1vbl9jZmcuIEFuZCB3aGVuIGd1ZXN0DQo+Pj4+PiBzdXNwZW5kcywgaXQgY2FuIHdyaXRlIGZy
ZWV6ZV9tb2RlIHRvIGJlIEZSRUVaRV9TMywgYW5kIHRoZW4gdmlydGlvDQo+Pj4+PiBkZXZpY2Vz
IGNhbiBjaGFuZ2UgdGhlaXIgcmVzZXQgYmVoYXZpb3Igb24gUWVtdSBzaWRlIGFjY29yZGluZyB0
bw0KPj4+Pj4gZnJlZXplX21vZGUuIFdoYXQncyBtb3JlLCBmcmVlemVfbW9kZSBjYW4gYmUgdXNl
ZCBmb3IgYWxsIHZpcnRpbw0KPj4+Pj4gZGV2aWNlcyB0byBhZmZlY3QgdGhlIGJlaGF2aW9yIG9m
IFFlbXUsIG5vdCBqdXN0IHZpcnRpbyBncHUgZGV2aWNlLg0KPj4+IEhpIEppcWlhbiwNCj4+Pg0K
Pj4+IEhhdmUgeW91IHNlZW4gdGhpcyBzZXJpZXM6IFtQQVRDSCAwLzVdIHZpcnRpbzogaW50cm9k
dWNlIFNVU1BFTkQgYml0IGFuZCB2cSBzdGF0ZQ0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8zZjRjYmY4NC0wMTBjLWNmZmEtMGI3MC0zM2M0NDliNTU2MWJAaW50ZWwuY29tL1QvDQo+
Pj4NCj4+PiBXZSBpbnRyb2R1Y2VkIGEgYml0IGluIHRoZSBkZXZpY2Ugc3RhdHVzIFNVU1BFTkQs
IHdoZW4gVklSVElPX0ZfU1VTUEVORCBpcw0KPj4+IG5lZ290aWF0ZWQsIHRoZSBkcml2ZXIgY2Fu
IHNldCBTVVNQRU5EIGluIHRoZSBkZXZpY2Ugc3RhdHVzIHRvIHN1c3BlbmQgdGhlDQo+Pj4gZGV2
aWNlLg0KPj4+DQo+Pj4gV2hlbiBTVVNQRU5ELCB0aGUgZGV2aWNlIHNob3VsZCBwYXVzZSBpdHMg
b3BlcmF0aW9ucyBhbmQgcHJlc2VydmUgaXRzIGNvbmZpZ3VyYXRpb25zDQo+Pj4gaW4gaXRzIGNv
bmZpZ3VyYXRpb24gc3BhY2UuDQo+Pj4NCj4+PiBUaGUgZHJpdmVyIHJlLXdyaXRlIERSSVZFUl9P
SyB0byBjbGVhciBTVVNQRU5ELCBzbyB0aGUgZGV2aWNlIHJlc3VtZXMgcnVubmluZy4NCj4+Pg0K
Pj4+IFRoaXMgaXMgb3JpZ2luYWxseSB0byBzZXJ2ZSBsaXZlIG1pZ3JhdGlvbiwgYnV0IEkgdGhp
bmsgaXQgY2FuIGFsc28gbWVldCB5b3VyIG5lZWRzLg0KPj4gSSBub3RpY2VkIHlvdXIgc2VyaWVz
LCBidXQgSSBhbSBub3Qgc3VyZSB0aGV5IGFyZSBhbHNvIG1lZXQgbXkgbmVlZHMuDQo+PiBJZiBk
cml2ZXIgd3JpdGUgMCB0byByZXNldCBkZXZpY2UsIGNhbiB0aGUgU1VTUEVORCBiaXQgYmUgY2xl
YXJlZD8gKHBjaV9wbV9yZXN1bWUtPnZpcnRpb19wY2lfcmVzdG9yZS0+dmlydGlvX2RldmljZV9y
ZXN0b3JlLT52aXJ0aW9fcmVzZXRfZGV2aWNlKQ0KPiBpZiB0aGUgZHJpdmVyIHdyaXRlcyAwLCBp
dCByZXNldHMgYWxsIHZpcnRpbyBmdW5jdGlvbmFsaXRpZXMuIFNvIFNVU1BFTkQgaXMgY2xlYXJl
ZC4NClRoZW4geW91ciBwYXRjaGVzIGFyZSBub3QgbWVldCBteSBuZWVkcy4gSW4gbXkgc2NlbmUs
IGl0IG5lZWRzIHRvIGtlZXAgdGhlIFNVU1BFTkQgYml0IHV0aWwgdGhlIHJlc3VtZSBwcm9jZXNz
IGlzIGNvbXBsZXRlLg0KQmVjYXVzZSBpbiBteSB2aXJ0aW8tZ3B1IHNjZW5lLCB3aGVuIGd1ZXN0
IHJlc3VtZSwgaXQgY2FsbCB2aXJ0aW9fcmVzZXRfZGV2aWNlIHRvIGNsZWFyIGFsbCBkZXZpY2Ug
c3RhdHVzIGJpdHMsIGFuZCB0aGVuIHJlc2V0IHZpcnRpby1ncHUgaW4gUWVtdSwgYW5kIHRoZW4g
ZGVzdHJveSByZW5kZXIgcmVzb3VyY2VzLCBJIGRvbid0IHdhbnQgdGhlIHJlc291cmNlcyBhcmUg
ZGVzdHJveWVkIGR1cmluZyB0aGUgcmVzdW1lIHByb2Nlc3MuIFNvLCBJIGFkZCBmcmVlemVfbW9k
ZSB0byB0ZWxsIFFlbXUgdGhhdCBndWVzdCBpcyBkb2luZyBTMyBhbmQgcmVzb3VyY2VzIG5lZWQg
dG8gYmUga2VwdC4NCg0KPiBkZXZpY2UgcmVzZXQgY2FuIGFsc28gYmUgdXNlZCB0byByZWNvdmVy
IHRoZSBkZXZpY2UgZnJvbSBmYXRhbCBlcnJvcnMsIHNvIGl0IHNob3VsZCByZXNldCBldmVyeXRo
aW5nIGluIHZpcnRpby4NCj4+IElmIFNVU1BFTkQgaXMgY2xlYXJlZCwgdGhlbiBkdXJpbmcgdGhl
IHJlc2V0IHByb2Nlc3MgaW4gUWVtdSwgSSBjYW4ndCBqdWRnZSBpZiB0aGUgcmVzZXQgcmVxdWVz
dCBpcyBmcm9tIGd1ZXN0IHJlc3RvcmUgcHJvY2VzcyBvciBub3QsIGFuZCB0aGVuIEkgY2FuJ3Qg
Y2hhbmdlIHRoZSByZXNldCBiZWhhdmlvci4NCj4gSSB0aGluayB3aGVuIGVudGVyIFMzLCB0aGUg
aHlwZXJ2aXNvci9kcml2ZXIgc2hvdWxkIHNldCBTVVNQRU5EIHRvIHRoZSBkZXZpY2UuIEFuZCB3
aGVuIHJlc3VtZSBmcm9tIFMzLCB0aGUgaHlwZXJ2aXNvci9kcml2ZXIgc2hvdWxkDQo+IHJlLXdy
aXRlIERSSVZFUl9PSyB0byBjbGVhciBTVVNQRU5ELCB0aGVuIHRoZSBkZXZpY2UgcmVzdW1lIHJ1
bm5pbmcuDQo+PiBDYW4geW91IHNlbmQgbWUgeW91ciBwYXRjaCBsaW5rIG9uIGtlcm5lbCBhbmQg
cWVtdSBzaWRlPyBJIHdpbGwgdGFrZSBhIGRlZXAgbG9vay4NCj4gVGhlcmUgYXJlIG5vIHBhdGNo
ZXMgZm9yIHFlbXUva2VybmVsIHlldCwgc3BlYyBmaXJzdC4NCj4+DQo+Pj4gVGhhbmtzLA0KPj4+
IFpodSBMaW5nc2hhbg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5D
aGVuQGFtZC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IMKgwqAgdHJhbnNwb3J0LXBjaS50ZXggfCA3
ICsrKysrKysNCj4+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4+
Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS90cmFuc3BvcnQtcGNpLnRleCBiL3RyYW5zcG9ydC1wY2ku
dGV4DQo+Pj4+PiBpbmRleCBhNWM2NzE5Li4yNTQzNTM2IDEwMDY0NA0KPj4+Pj4gLS0tIGEvdHJh
bnNwb3J0LXBjaS50ZXgNCj4+Pj4+ICsrKyBiL3RyYW5zcG9ydC1wY2kudGV4DQo+Pj4+PiBAQCAt
MzE5LDYgKzMxOSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVj
dHVyZSBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBsZTY0IHF1ZXVlX2Rlc2M7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIHJlYWQtd3JpdGUgKi8NCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlNjQgcXVldWVf
ZHJpdmVyO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHJlYWQtd3JpdGUgKi8NCj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlNjQgcXVldWVfZGV2aWNlO8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIHJlYWQtd3JpdGUgKi8NCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBsZTE2IGZy
ZWV6ZV9tb2RlO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcmVhZC13cml0ZSAqLw0K
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGUxNiBxdWV1ZV9ub3RpZl9jb25maWdfZGF0YTvC
oMKgIC8qIHJlYWQtb25seSBmb3IgZHJpdmVyICovDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBsZTE2IHF1ZXVlX3Jlc2V0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcmVhZC13
cml0ZSAqLw0KPj4+Pj4NCj4+Pj4gd2UgY2FuJ3QgYWRkIGZpZWxkcyBpbiB0aGUgbWlkZGxlIG9m
IHRoZSBzdHJ1Y3R1cmUgbGlrZSB0aGlzIC0NCj4+Pj4gb2Zmc2V0IG9mIHF1ZXVlX25vdGlmX2Nv
bmZpZ19kYXRhIGFuZCBxdWV1ZV9yZXNldCBjaGFuZ2VzLg0KPj4+Pg0KPj4+PiDCoMKgDQo+Pj4+
PiBAQCAtMzkzLDYgKzM5NCwxMiBAQCBcc3Vic3Vic2VjdGlvbntDb21tb24gY29uZmlndXJhdGlv
biBzdHJ1Y3R1cmUgbGF5b3V0fVxsYWJlbHtzZWM6VmlydGlvIFRyYW5zcG9ydA0KPj4+Pj4gwqDC
oCBcaXRlbVtcZmllbGR7cXVldWVfZGV2aWNlfV0NCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFRoZSBkcml2ZXIgd3JpdGVzIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIERldmljZSBBcmVhIGhl
cmUuwqAgU2VlIHNlY3Rpb24gXHJlZntzZWM6QmFzaWMgRmFjaWxpdGllcyBvZiBhIFZpcnRpbyBE
ZXZpY2UgLyBWaXJ0cXVldWVzfS4NCj4+Pj4+IMKgwqAgK1xpdGVtW1xmaWVsZHtmcmVlemVfbW9k
ZX1dDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgVGhlIGRyaXZlciB3cml0ZXMgdGhpcyB0byBzZXQg
dGhlIGZyZWV6ZSBtb2RlIG9mIHZpcnRpbyBwY2kuDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgVklS
VElPX1BDSV9GUkVFWkVfTU9ERV9VTkZSRUVaRSAtIHZpcnRpby1wY2kgaXMgcnVubmluZzsNCj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBWSVJUSU9fUENJX0ZSRUVaRV9NT0RFX0ZSRUVaRV9TMyAtIGd1
ZXN0IHZtIGlzIGRvaW5nIFMzLCBhbmQgdmlydGlvLXBjaSBlbnRlcnMgUzMgc3VzcGVuc2lvbjsN
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBPdGhlciB2YWx1ZXMgYXJlIHJlc2VydmVkIGZvciBmdXR1
cmUgdXNlLCBsaWtlIFM0LCBldGMuDQo+Pj4+PiArDQo+Pj4+IHdlIG5lZWQgdG8gc3BlY2lmeSB0
aGVzZSB2YWx1ZXMgdGhlbi4NCj4+Pj4NCj4+Pj4gd2UgYWxzbyBuZWVkDQo+Pj4+IC0gZmVhdHVy
ZSBiaXQgdG8gZGV0ZWN0IHN1cHBvcnQgZm9yIFMzDQo+Pj4+IC0gY29uZm9ybWFuY2Ugc3RhdGVt
ZW50cyBkb2N1bWVudGluZyBiZWhhdmlvdXMgdW5kZXIgUzMNCj4+Pj4NCj4+Pj4NCj4+Pj4+IMKg
wqAgXGl0ZW1bXGZpZWxke3F1ZXVlX25vdGlmX2NvbmZpZ19kYXRhfV0NCj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFRoaXMgZmllbGQgZXhpc3RzIG9ubHkgaWYgVklSVElPX0ZfTk9USUZfQ09O
RklHX0RBVEEgaGFzIGJlZW4gbmVnb3RpYXRlZC4NCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFRoZSBkcml2ZXIgd2lsbCB1c2UgdGhpcyB2YWx1ZSB3aGVuIGRyaXZlciBzZW5kcyBhdmFpbGFi
bGUgYnVmZmVyDQo+Pj4+PiAtLcKgDQo+Pj4+PiAyLjM0LjENCj4+Pj4gVGhpcyBwdWJsaWNseSBh
cmNoaXZlZCBsaXN0IG9mZmVycyBhIG1lYW5zIHRvIHByb3ZpZGUgaW5wdXQgdG8gdGhlDQo+Pj4+
IE9BU0lTIFZpcnR1YWwgSS9PIERldmljZSAoVklSVElPKSBUQy4NCj4+Pj4NCj4+Pj4gSW4gb3Jk
ZXIgdG8gdmVyaWZ5IHVzZXIgY29uc2VudCB0byB0aGUgRmVlZGJhY2sgTGljZW5zZSB0ZXJtcyBh
bmQNCj4+Pj4gdG8gbWluaW1pemUgc3BhbSBpbiB0aGUgbGlzdCBhcmNoaXZlLCBzdWJzY3JpcHRp
b24gaXMgcmVxdWlyZWQNCj4+Pj4gYmVmb3JlIHBvc3RpbmcuDQo+Pj4+DQo+Pj4+IFN1YnNjcmli
ZTogdmlydGlvLWNvbW1lbnQtc3Vic2NyaWJlQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+Pj4+IFVu
c3Vic2NyaWJlOiB2aXJ0aW8tY29tbWVudC11bnN1YnNjcmliZUBsaXN0cy5vYXNpcy1vcGVuLm9y
Zw0KPj4+PiBMaXN0IGhlbHA6IHZpcnRpby1jb21tZW50LWhlbHBAbGlzdHMub2FzaXMtb3Blbi5v
cmcNCj4+Pj4gTGlzdCBhcmNoaXZlOiBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hp
dmVzL3ZpcnRpby1jb21tZW50Lw0KPj4+PiBGZWVkYmFjayBMaWNlbnNlOiBodHRwczovL3d3dy5v
YXNpcy1vcGVuLm9yZy93aG8vaXByL2ZlZWRiYWNrX2xpY2Vuc2UucGRmDQo+Pj4+IExpc3QgR3Vp
ZGVsaW5lczogaHR0cHM6Ly93d3cub2FzaXMtb3Blbi5vcmcvcG9saWNpZXMtZ3VpZGVsaW5lcy9t
YWlsaW5nLWxpc3RzDQo+Pj4+IENvbW1pdHRlZTogaHR0cHM6Ly93d3cub2FzaXMtb3Blbi5vcmcv
Y29tbWl0dGVlcy92aXJ0aW8vDQo+Pj4+IEpvaW4gT0FTSVM6IGh0dHBzOi8vd3d3Lm9hc2lzLW9w
ZW4ub3JnL2pvaW4vDQo+Pj4+DQo+Pj4NCj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiBUbyB1bnN1YnNj
cmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJlQGxpc3RzLm9hc2lzLW9wZW4ub3Jn
DQo+Pj4gRm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRldi1oZWxwQGxp
c3RzLm9hc2lzLW9wZW4ub3JnDQo+Pj4NCj4gDQo+IA0KPiBUaGlzIHB1YmxpY2x5IGFyY2hpdmVk
IGxpc3Qgb2ZmZXJzIGEgbWVhbnMgdG8gcHJvdmlkZSBpbnB1dCB0byB0aGUNCj4gT0FTSVMgVmly
dHVhbCBJL08gRGV2aWNlIChWSVJUSU8pIFRDLg0KPiANCj4gSW4gb3JkZXIgdG8gdmVyaWZ5IHVz
ZXIgY29uc2VudCB0byB0aGUgRmVlZGJhY2sgTGljZW5zZSB0ZXJtcyBhbmQNCj4gdG8gbWluaW1p
emUgc3BhbSBpbiB0aGUgbGlzdCBhcmNoaXZlLCBzdWJzY3JpcHRpb24gaXMgcmVxdWlyZWQNCj4g
YmVmb3JlIHBvc3RpbmcuDQo+IA0KPiBTdWJzY3JpYmU6IHZpcnRpby1jb21tZW50LXN1YnNjcmli
ZUBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiBVbnN1YnNjcmliZTogdmlydGlvLWNvbW1lbnQtdW5z
dWJzY3JpYmVAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gTGlzdCBoZWxwOiB2aXJ0aW8tY29tbWVu
dC1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+IExpc3QgYXJjaGl2ZTogaHR0cHM6Ly9saXN0
cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8NCj4gRmVlZGJhY2sgTGlj
ZW5zZTogaHR0cHM6Ly93d3cub2FzaXMtb3Blbi5vcmcvd2hvL2lwci9mZWVkYmFja19saWNlbnNl
LnBkZg0KPiBMaXN0IEd1aWRlbGluZXM6IGh0dHBzOi8vd3d3Lm9hc2lzLW9wZW4ub3JnL3BvbGlj
aWVzLWd1aWRlbGluZXMvbWFpbGluZy1saXN0cw0KPiBDb21taXR0ZWU6IGh0dHBzOi8vd3d3Lm9h
c2lzLW9wZW4ub3JnL2NvbW1pdHRlZXMvdmlydGlvLw0KPiBKb2luIE9BU0lTOiBodHRwczovL3d3
dy5vYXNpcy1vcGVuLm9yZy9qb2luLw0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4g
Q2hlbi4NCg==
