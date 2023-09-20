Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA67A715E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjITD63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjITD6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:58:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A0CC1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG9VehOSdxcS9KBUfmsQmjKvqA/oowfaGk3b6tK7CoyzBtvFGcHRp9TNWYF0jaIeDm0plz4a3Cu9fuGyo44dID7/UhUf8AczsQ9fKeuDYI7dqfPyxshNl7uiGEwJI48KyEnYFWScXsR7E3mu4AdRcC+yJk2tiV7KRG5VCKS5DZsggoSuOnsIN/cr1TqFRk2B7/B2SQGpIbn7+2W8gbwKRxQRjIIQJn5TgrZc+48PDbK84l3K/RGYzyeAon1Dtnh1mmhaQdb1m+CxdEO2gwKR8onMYAbIm7qBjH5eRg9zw9MmPOd+zhwU220dbB4HrU2l3DhPzAzZZu3w3qcb72Nu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqEnHUWWTCVjLBpGDilQKxtvQygdSAAggP0uzPtys+o=;
 b=F9Fh5DiYm9WAZSTfOCBsQgZc/mXJ6faJkMwY9YBHM6cbFXvrKv1kEC0PRxtt7Rne88UHF4wod+G4ximvuFDSJQ1VyJKA3qY7yvZtQSanwdw3HmQBl0ho9z1IsEfnzavWzoB6+/u0T8ya2nIGRWOjxql82D39/NclYbJptFLOlMZK8cKctKxfpQrBcz8u0Xlm5CT8rcSomj3gIXhCaF32WD2YVH8Nn2ZNHQgwYdYlXeaPzY8kVwBvu5bLpdQ6JY6MESfoOeZrVWEf2GquWN/kPhhC5inqgmiE5EAZqDi4Uj5Dq+DB0zWv/9ZJ8camd5GUlk4dNVwInQIdwXmrvDwNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqEnHUWWTCVjLBpGDilQKxtvQygdSAAggP0uzPtys+o=;
 b=SCNko1ZsjwKac41LAzTfcFXtJ9ROfkPLFI35+BJqxkt3YejsyhJ0F+P5nJxJckD4MOWpjmFmSofTOjI5qUnmOd9i97V9dvpmSqAiX5yVUcy3VJ0EU33r0KllTJS36Gic8h4Zk9WZO2B7D7Nur1iGn2NzBClaxmJD0wlspPfKdk0=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:57:51 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 03:57:51 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Parav Pandit <parav@nvidia.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
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
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [virtio-dev] RE: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] RE: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiDrKAgAF0SwA=
Date:   Wed, 20 Sep 2023 03:57:51 +0000
Message-ID: <BL1PR12MB5849B6C811E3BA8A8977FE18E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|IA1PR12MB7541:EE_
x-ms-office365-filtering-correlation-id: 0cfc7fbb-d04a-4194-2130-08dbb98dc2e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHeZH4t6mFVLpGo1dNDlTPDhlH1u2frhCfEFZytlKfvfhX0VhclzpEGhfxT83+LVhSoKPL+dgNxV+Z64WJz+4IGMPKT3GypTK87FLpU+ritRkn/7Qssmc10RCR5m3ZfxTK4iUcBHAF9KvjfUoGY8T6uJQxzJ00HOqtCXhn8MpZmjoDHdHC/LDYmjRcGX4HxgFB+bD1XpMVe7QqZvdgfIukz0kzRvmk1bE+aTGOUxboxHnOtQE3dETEmXwcLWhD0w1VXm292dcsDruWaBhYuGxVM+XmnJxY37OKLA2BTfz0y8BnNsWcWp7AVJjjZmHnk2uJFcvORRUOhm/XdpylDWd3V6LkygWHb0fRQKO0ruBP0nQKychF9Brp3OKsvFA2vpzD3t+5ExW0xWeOlj1jj8DqkxzIrjbOGth2l2crE6sJx0+WqBj3bFP+7iBqz0OP/s0FII6JrBfEiDKB6DcX9yrULRoGWxzCjfEekepMX8wipEr/X11G878QCr4FeJpy7truozJMtlbck4H3AYeug44haPn+voWpO+ukLCKipAiJ1zOcNOLwUMgsthWliD0ptCg/OfOwY+2O9jPVdNYUaQ563NSKUrkOoR3D0kdwXZZNY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(38070700005)(71200400001)(6506007)(53546011)(7696005)(966005)(9686003)(478600001)(83380400001)(2906002)(26005)(66556008)(316002)(64756008)(66476007)(76116006)(66446008)(54906003)(66946007)(4326008)(5660300002)(52536014)(8676002)(41300700001)(8936002)(6916009)(7416002)(55016003)(33656002)(122000001)(38100700002)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkUrckpCZU56ZU9KVEpBVUhoMW4zRWNpYmVSbDlHTk5aRlZJRTJBZldlN1lM?=
 =?utf-8?B?TXNMNXVkcWR3MmRxeHE4Y1R0RXh5Y2xVbmU1b081NUM0MjJKT1Y1VnIwaTRC?=
 =?utf-8?B?dGRnM09VVnJBbFRKdUkxUkdpZjFyZHhrK2RtZnhBU2VRdXlQQ2NXRFpuNmFl?=
 =?utf-8?B?bW1DdzdrRVBGaWVDK1kvRXM0T2t6dHIwdjFqUFYxNlBLK0JHOG8rdFNBUGdE?=
 =?utf-8?B?QkcyOWFtN1dBT05CZ20rd2tpa042YlFlZGxyY3ByKzhaWGlINXZoWUVIYzcx?=
 =?utf-8?B?djNlanVDNlhhbFhhaFU1cGUyTUdaRURleU5yOGJjRlV5TUVLaUFMbWdNQUh6?=
 =?utf-8?B?UVFrLzhlREtqRjNiRG0zcVBvZm11M1ZsRFh6TXBLSitYeVltdkZ3NGo2cDJV?=
 =?utf-8?B?SExLOHNzcGFub3dKMFJvWDN1eFZKMXpnUitNQ3lyeFFjZ3dDRGk2UEtSTVVI?=
 =?utf-8?B?SUt3aXY4QXpnM0lMSEtYMjVMcmJ5aEZUVjM5Qnk0ck1kYzRnRWtyQkdmQnBS?=
 =?utf-8?B?TVorMWhXZnQxOXBWYkZpVnhzRFRESlFMdlRtQTRlUmJoanZXenhBSnlWSWJn?=
 =?utf-8?B?bE5xNXJTa1R1ZHZjVnJNSG16aW1FT29WR1VITE10Y0JncEM3VTJvZnNWN0Np?=
 =?utf-8?B?Z0tPR0hqdWxETy8vOFZYN2hwcDFlNTVvTjRLRUYzYWZvMnVabjdDdUhDVWtN?=
 =?utf-8?B?K09CM0QvWlAzVUpVQ29nVXppeHZWTHh2U3hJaGJjc3U0OTYxblYzUW02SjRI?=
 =?utf-8?B?K2crYU1Dd2FyWG1DRTNzOU9Yd3NBWnJLTktXS1Fzd0NjNENRWHAzbnUyNHNk?=
 =?utf-8?B?U2tlWS93Y0hJWk93cWxCL0ZFKzdVZWZEZUx3TUxicys5d0ZvTHBCcTJDUExz?=
 =?utf-8?B?bDdPY3hMODkrZWtQTElScStXS2pxRGEvM000T0czZURrRXltZGFtazRCQ1Bs?=
 =?utf-8?B?cEpET1ZrSnhvRUhUcWduc2pmMEFKRVFiVy9rV0ZDMTdjcTBHOUh2dlpoNE9v?=
 =?utf-8?B?Ymc1amZKNHYvWU5hWHlIOFFPcytuWnpPaDRuSklLRnA3T1ZWUmd4bGNSbjN4?=
 =?utf-8?B?Um9UeldJd0dONG9NdjhhbUVYcFVIRTJUcGxiNGZyS0hOWWlzbmcxQlRFSjNa?=
 =?utf-8?B?SDd0UUlGK1dic2prb0xBcXdyell6V25hRm9jR1ZnVUpYR2pyQ0Vsak51QVpI?=
 =?utf-8?B?eFhuajM3RUIrdjd1MUUwRkZxd2tsUjNEZmZSVm1WT1hDRURVb1l1RnMycU1i?=
 =?utf-8?B?NktYUVorQXBXYzJ4WjdXenpVeDZTeG1CT1hWeXJ0T2FuSENZQVVLaHlOTy9P?=
 =?utf-8?B?UjNFNlB1a2VqZHBjV3h4T0p1QmdSNVEzZjZ1Q3BLSGtQeUpJYXZKUWxya0hs?=
 =?utf-8?B?RDNGMTdUVjVidjlWN0EyNE9sbFJIWGpjOHpDcUxlYUc2dWJLVVh2RDRZdHY2?=
 =?utf-8?B?UGpvU2d6Qm5jUkVFc1cxNlRxd0g1UWlPdm44UlBPdHdhZWZKU29vczFubHdZ?=
 =?utf-8?B?aEJoSGxrRXpDMkowQkR1bkowZkw1bnQ2YkpHVVFpK1RwMmpKdDZOV1RDdUw0?=
 =?utf-8?B?a0VSNnFFdzhiZXdTa0dDT0kzVWJXWmRqbTZiZHptL3huMnFDLy8rRW9RMlI4?=
 =?utf-8?B?OGtNd1lzSWwxTFo2ZmR1dG5zcXJ3TGRsWmJ5ZlA2enllTDJUbXlBYXBQaVVV?=
 =?utf-8?B?VGxDVU5uTW5QN2JIUFhNdER2bjZzeTB6VmVtUFR0b01MeDdpeHdma1ZMNENo?=
 =?utf-8?B?VGxTalB3SFk5OFVmd05rVVZiTkc0NVB3cnJCUVVMYmdyNjYzUksxQ2k5NnU5?=
 =?utf-8?B?cVZFTDB5cHk1RWUrVjBPQjIvTExiN2dtd1kzMU5kL04yUE15MlR6a0RMa0Na?=
 =?utf-8?B?SmhaVFp6Ulg2TzhUT2V6MG5wUlNGU2VWUWE4eVBDUm4wV2tMUXh0cGNnb2Js?=
 =?utf-8?B?Zk5WTTlBMGlScFFqRHJxcHQvcHNzRzRKZmUwTFlmOHR5YlhHcWgwUXZMNkZy?=
 =?utf-8?B?NmRuM1pnSzhMTXJ1K0sycm16MlUyM2M3VXZkYkJsSDZRRlNxeTFHWmVJMnRy?=
 =?utf-8?B?dHRaamNmcFUyaVJaYVdFcVRDRW5PbE52SGo0RkVIRGlRVFNlYXBjKzlBUzBX?=
 =?utf-8?Q?cYM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D4AABD744F32B43BF529D2867C925F9@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfc7fbb-d04a-4194-2130-08dbb98dc2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 03:57:51.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0f2LvciTGrCaTzOEVa6ZQ/4e1eb7qAsy8X+7n2kyjPyvznT0GcIcu1ZrvsYLe9X9JxFHZr+fje4OQPf4cc8Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFyYXYsDQoNCk9uIDIwMjMvOS8xOSAyMDoxMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiBI
aSBKaXFpYW4sDQo+IA0KPj4gRnJvbTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+
DQo+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjMgNToxMyBQTQ0KPj4NCj4+IFdo
ZW4gZ3Vlc3Qgdm0gZG9lcyBTMywgUWVtdSB3aWxsIHJlc2V0IGFuZCBjbGVhciBzb21lIHRoaW5n
cyBvZiB2aXJ0aW8NCj4+IGRldmljZXMsIGJ1dCBndWVzdCBjYW4ndCBhd2FyZSB0aGF0LCBzbyB0
aGF0IG1heSBjYXVzZSBzb21lIHByb2JsZW1zLg0KPiBJdCBpcyBub3QgdHJ1ZSB0aGF0IGd1ZXN0
IFZNIGlzIG5vdCBhd2FyZSBvZiBpdC4NCj4gQXMgeW91IHNob3cgaW4geW91ciBrZXJuZWwgcGF0
Y2gsIGl0IGlzIGZyZWV6ZS91bmZyZWV6ZSBpbiB0aGUgZ3Vlc3QgVk0gUENJIFBNIGRyaXZlciBj
YWxsYmFjay4gU28gcGxlYXNlIHVwZGF0ZSB0aGUgY29tbWl0IGxvZy4NClRoYW5rcywgSSB3aWxs
IHVwZGF0ZSBpdC4NCg0KPiANCj4+IEZvciBleGNhbXBsZSwgUWVtdSBjYWxscyB2aXJ0aW9fcmVz
ZXQtPnZpcnRpb19ncHVfZ2xfcmVzZXQgd2hlbiBndWVzdA0KPiBzL2V4Y2FtcGxlL2V4YW1wbGUN
Cj4gDQo+PiByZXN1bWUsIHRoYXQgZnVuY3Rpb24gd2lsbCBkZXN0cm95IHJlbmRlciByZXNvdXJj
ZXMgb2YgdmlydGlvLWdwdS4gQXMgYSByZXN1bHQsDQo+PiBhZnRlciBndWVzdCByZXN1bWUsIHRo
ZSBkaXNwbGF5IGNhbid0IGNvbWUgYmFjayBhbmQgd2Ugb25seSBzYXcgYSBibGFjaw0KPj4gc2Ny
ZWVuLiBEdWUgdG8gZ3Vlc3QgY2FuJ3QgcmUtY3JlYXRlIGFsbCB0aGUgcmVzb3VyY2VzLCBzbyB3
ZSBuZWVkIHRvIGxldCBRZW11DQo+PiBub3QgdG8gZGVzdHJveSB0aGVtIHdoZW4gUzMuDQo+IEFi
b3ZlIFFFTVUgc3BlY2lmaWMgZGV0YWlscyB0byBnbyBpbiBjb3ZlciBsZXR0ZXIsIGluc3RlYWQg
b2YgY29tbWl0IGxvZywgYnV0IG5vIHN0cm9uZyBvcGluaW9uLg0KPiBFeHBsYWluaW5nIHRoZSB1
c2UgY2FzZSBpcyBnb29kLg0KVGhhbmtzLCBJIHdpbGwgYWxzbyBhZGQgaXQgdG8gY292ZXIgbGV0
dGVyLg0KDQo+IA0KPj4NCj4+IEZvciBhYm92ZSBwdXJwb3NlLCB3ZSBuZWVkIGEgbWVjaGFuaXNt
IHRoYXQgYWxsb3dzIGd1ZXN0cyBhbmQgUUVNVSB0bw0KPj4gbmVnb3RpYXRlIHRoZWlyIHJlc2V0
IGJlaGF2aW9yLiBTbyB0aGlzIHBhdGNoIGFkZCBhIG5ldyBwYXJhbWV0ZXIgbmFtZWQNCj4gRnJl
ZXplICE9IHJlc2V0LiA6KQ0KPiBQbGVhc2UgZml4IGl0IHRvIHNheSBmcmVlemUgb3Igc3VzcGVu
ZC4NCkJ1dCBpbiBteSB2aXJ0aW8tZ3B1IHNjZW5lLCBJIHdhbnQgdG8gcHJldmVudCBRZW11IGRl
c3Ryb3lpbmcgcmVzb3VyY2VzIHdoZW4gR3Vlc3QgZG8gcmVzdW1pbmcocGNpX3BtX3Jlc3VtZS0+
IHZpcnRpb19wY2lfcmVzdG9yZS0+IHZpcnRpb19kZXZpY2VfcmVzdG9yZS0+IHZpcnRpb19yZXNl
dF9kZXZpY2UtPiB2cF9tb2Rlcm5fc2V0X3N0YXR1cy0+UWVtdSB2aXJ0aW9fcGNpX3Jlc2V0LT52
aXJ0aW9fZ3B1X2dsX3Jlc2V0LT4gdmlydGlvX2dwdV9yZXNldCkuIEFuZCBJIGFkZCBjaGVjayBp
biB2aXJ0aW9fZ3B1X2dsX3Jlc2V0IGFuZCB2aXJ0aW9fZ3B1X3Jlc2V0LCBpZiBmcmVlemVfbW9k
ZSB3YXMgc2V0IHRvIEZSRUVaRV9TMyBkdXJpbmcgR3Vlc3Qgc3VzcGVuZGluZywgUWVtdSB3aWxs
IG5vdCBkZXN0cm95IHJlc291cmNlcy4gU28gdGhlIHJlYXNvbiB3aHkgSSBhZGQgdGhpcyBtZWNo
YW5pc20gaXMgdG8gYWZmZWN0IHRoZSByZXNldCBiZWhhdmlvci4gQW5kIEkgdGhpbmsgdGhpcyBh
bHNvIGNhbiBoZWxwIG90aGVyIHZpcnRpbyBkZXZpY2VzIHRvIGFmZmVjdCB0aGVpciBiZWhhdmlv
ciwgbGlrZSB0aGUgaXNzdWUgb2YgdmlydGlvLXZpZGVvIHdoaWNoIE1pa2hhaWwgR29sdWJldi1D
aXVjaGVhIGVuY291bnRlcmVkLg0KDQo+IA0KPj4gZnJlZXplX21vZGUgdG8gc3RydWN0IHZpcnRp
b19wY2lfY29tbW9uX2NmZy4gQW5kIHdoZW4gZ3Vlc3Qgc3VzcGVuZHMsIGl0IGNhbg0KPj4gd3Jp
dGUgZnJlZXplX21vZGUgdG8gYmUgRlJFRVpFX1MzLCBhbmQgdGhlbiB2aXJ0aW8gZGV2aWNlcyBj
YW4gY2hhbmdlIHRoZWlyDQo+PiByZXNldCBiZWhhdmlvciBvbiBRZW11IHNpZGUgYWNjb3JkaW5n
IHRvIGZyZWV6ZV9tb2RlLiBXaGF0J3MgbW9yZSwNCj4gTm90IHJlc2V0LCBidXQgc3VzcGVuZCBi
ZWhhdmlvci4NClRoZSBzYW1lIHJlYXNvbiBhcyBhYm92ZS4NCg0KPiANCj4+IGZyZWV6ZV9tb2Rl
IGNhbiBiZSB1c2VkIGZvciBhbGwgdmlydGlvIGRldmljZXMgdG8gYWZmZWN0IHRoZSBiZWhhdmlv
ciBvZiBRZW11LA0KPj4gbm90IGp1c3QgdmlydGlvIGdwdSBkZXZpY2UuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiAtLS0NCj4+ICB0
cmFuc3BvcnQtcGNpLnRleCB8IDcgKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdHJhbnNwb3J0LXBjaS50ZXggYi90cmFuc3Bv
cnQtcGNpLnRleCBpbmRleCBhNWM2NzE5Li4yNTQzNTM2IDEwMDY0NA0KPj4gLS0tIGEvdHJhbnNw
b3J0LXBjaS50ZXgNCj4+ICsrKyBiL3RyYW5zcG9ydC1wY2kudGV4DQo+PiBAQCAtMzE5LDYgKzMx
OSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZQ0KPj4g
bGF5b3V0fVxsYWJlbHtzZWM6VmlydGlvIFRyYW5zcG9ydA0KPj4gICAgICAgICAgbGU2NCBxdWV1
ZV9kZXNjOyAgICAgICAgICAgICAgICAvKiByZWFkLXdyaXRlICovDQo+PiAgICAgICAgICBsZTY0
IHF1ZXVlX2RyaXZlcjsgICAgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8NCj4+ICAgICAgICAg
IGxlNjQgcXVldWVfZGV2aWNlOyAgICAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4gKyAg
ICAgICAgbGUxNiBmcmVlemVfbW9kZTsgICAgICAgICAgICAgICAvKiByZWFkLXdyaXRlICovDQo+
PiAgICAgICAgICBsZTE2IHF1ZXVlX25vdGlmX2NvbmZpZ19kYXRhOyAgIC8qIHJlYWQtb25seSBm
b3IgZHJpdmVyICovDQo+PiAgICAgICAgICBsZTE2IHF1ZXVlX3Jlc2V0OyAgICAgICAgICAgICAg
IC8qIHJlYWQtd3JpdGUgKi8NCj4+DQo+IFRoZSBuZXcgZmllbGQgY2Fubm90IGJlIGluIHRoZSBt
aWRkbGUgb2YgdGhlIHN0cnVjdHVyZS4NCj4gT3RoZXJ3aXNlLCB0aGUgbG9jYXRpb24gb2YgdGhl
IHF1ZXVlX25vdGlmX2NvbmZpZ19kYXRhIGRlcGVuZHMgb24gY29tcGxldGVseSB1bnJlbGF0ZWQg
ZmVhdHVyZSBiaXQsIGJyZWFraW5nIHRoZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPiBTbyBw
bGVhc2UgbW92ZSBpdCBhdCB0aGUgZW5kLg0KSSBoYXZlIGNvbmZ1c2VkIGFib3V0IHRoaXMuIEkg
Zm91bmQgaW4gbGF0ZXN0IGtlcm5lbCBjb2RlKG1hc3RlciBicmFuY2gpOg0Kc3RydWN0IHZpcnRp
b19wY2lfY29tbW9uX2NmZyB7DQoJLyogQWJvdXQgdGhlIHdob2xlIGRldmljZS4gKi8NCglfX2xl
MzIgZGV2aWNlX2ZlYXR1cmVfc2VsZWN0OwkvKiByZWFkLXdyaXRlICovDQoJX19sZTMyIGRldmlj
ZV9mZWF0dXJlOwkJLyogcmVhZC1vbmx5ICovDQoJX19sZTMyIGd1ZXN0X2ZlYXR1cmVfc2VsZWN0
OwkvKiByZWFkLXdyaXRlICovDQoJX19sZTMyIGd1ZXN0X2ZlYXR1cmU7CQkvKiByZWFkLXdyaXRl
ICovDQoJX19sZTE2IG1zaXhfY29uZmlnOwkJLyogcmVhZC13cml0ZSAqLw0KCV9fbGUxNiBudW1f
cXVldWVzOwkJLyogcmVhZC1vbmx5ICovDQoJX191OCBkZXZpY2Vfc3RhdHVzOwkJLyogcmVhZC13
cml0ZSAqLw0KCV9fdTggY29uZmlnX2dlbmVyYXRpb247CQkvKiByZWFkLW9ubHkgKi8NCg0KCS8q
IEFib3V0IGEgc3BlY2lmaWMgdmlydHF1ZXVlLiAqLw0KCV9fbGUxNiBxdWV1ZV9zZWxlY3Q7CQkv
KiByZWFkLXdyaXRlICovDQoJX19sZTE2IHF1ZXVlX3NpemU7CQkvKiByZWFkLXdyaXRlLCBwb3dl
ciBvZiAyLiAqLw0KCV9fbGUxNiBxdWV1ZV9tc2l4X3ZlY3RvcjsJLyogcmVhZC13cml0ZSAqLw0K
CV9fbGUxNiBxdWV1ZV9lbmFibGU7CQkvKiByZWFkLXdyaXRlICovDQoJX19sZTE2IHF1ZXVlX25v
dGlmeV9vZmY7CS8qIHJlYWQtb25seSAqLw0KCV9fbGUzMiBxdWV1ZV9kZXNjX2xvOwkJLyogcmVh
ZC13cml0ZSAqLw0KCV9fbGUzMiBxdWV1ZV9kZXNjX2hpOwkJLyogcmVhZC13cml0ZSAqLw0KCV9f
bGUzMiBxdWV1ZV9hdmFpbF9sbzsJCS8qIHJlYWQtd3JpdGUgKi8NCglfX2xlMzIgcXVldWVfYXZh
aWxfaGk7CQkvKiByZWFkLXdyaXRlICovDQoJX19sZTMyIHF1ZXVlX3VzZWRfbG87CQkvKiByZWFk
LXdyaXRlICovDQoJX19sZTMyIHF1ZXVlX3VzZWRfaGk7CQkvKiByZWFkLXdyaXRlICovDQoNCglf
X2xlMTYgZnJlZXplX21vZGU7CQkvKiByZWFkLXdyaXRlICovDQp9Ow0KVGhlcmUgaXMgbm8gcXVl
dWVfbm90aWZfY29uZmlnX2RhdGEgb3IgcXVldWVfcmVzZXQsIGFuZCBmcmVlemVfbW9kZSBJIGFk
ZGVkIGlzIGF0IHRoZSBlbmQuIFdoeSBpcyBpdCBkaWZmZXJlbnQgZnJvbSB2aXJ0aW8tc3BlYz8N
Cg0KPiANCj4+IEBAIC0zOTMsNiArMzk0LDEyIEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25m
aWd1cmF0aW9uIHN0cnVjdHVyZQ0KPj4gbGF5b3V0fVxsYWJlbHtzZWM6VmlydGlvIFRyYW5zcG9y
dCAgXGl0ZW1bXGZpZWxke3F1ZXVlX2RldmljZX1dDQo+PiAgICAgICAgICBUaGUgZHJpdmVyIHdy
aXRlcyB0aGUgcGh5c2ljYWwgYWRkcmVzcyBvZiBEZXZpY2UgQXJlYSBoZXJlLiAgU2VlIHNlY3Rp
b24NCj4+IFxyZWZ7c2VjOkJhc2ljIEZhY2lsaXRpZXMgb2YgYSBWaXJ0aW8gRGV2aWNlIC8gVmly
dHF1ZXVlc30uDQo+Pg0KPj4gK1xpdGVtW1xmaWVsZHtmcmVlemVfbW9kZX1dDQo+PiArICAgICAg
ICBUaGUgZHJpdmVyIHdyaXRlcyB0aGlzIHRvIHNldCB0aGUgZnJlZXplIG1vZGUgb2YgdmlydGlv
IHBjaS4NCj4+ICsgICAgICAgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVfVU5GUkVFWkUgLSB2aXJ0
aW8tcGNpIGlzIHJ1bm5pbmc7DQo+PiArICAgICAgICBWSVJUSU9fUENJX0ZSRUVaRV9NT0RFX0ZS
RUVaRV9TMyAtIGd1ZXN0IHZtIGlzIGRvaW5nIFMzLCBhbmQgdmlydGlvLQ0KPiBGb3IgYWJvdmUg
bmFtZXMsIHBsZWFzZSBkZWZpbmUgdGhlIGFjdHVhbCB2YWx1ZXMgaW4gdGhlIHNwZWMuDQpPaywg
SSB3aWxsIGFkZCB0aGVtLg0KDQo+IA0KPj4gcGNpIGVudGVycyBTMyBzdXNwZW5zaW9uOw0KPj4g
KyAgICAgICAgT3RoZXIgdmFsdWVzIGFyZSByZXNlcnZlZCBmb3IgZnV0dXJlIHVzZSwgbGlrZSBT
NCwgZXRjLg0KPj4gKw0KPiBJdCBjYW5ub3QgYmUganVzdCBvbmUgd2F5IGNvbW11bmljYXRpb24g
ZnJvbSBkcml2ZXIgdG8gZGV2aWNlIGFzIGZyZWV6aW5nIHRoZSBkZXZpY2Ugb2YgZmV3IGh1bmRy
ZWQgTUIgdG8gR0Igb2YgZ3B1IG1lbW9yeSBvciBvdGhlciBkZXZpY2UgbWVtb3J5IGNhbiB0YWtl
IHNldmVyYWwgbXNlYy4NCj4gSGVuY2UgZHJpdmVyIG11c3QgcG9sbCB0byBnZXQgdGhlIGFja25v
d2xlZGdlbWVudCBmcm9tIHRoZSBkZXZpY2UgdGhhdCBmcmVlemUgZnVuY3Rpb25hbGl0eSBpcyBj
b21wbGV0ZWQuDQpJIHRoaW5rIHRoZSBmcmVlemUgZnVuY3Rpb25hbGl0eSBpdHNlbGYgaGFzIG5v
dCBtYW55IHByb2JsZW1zLiBNeSBwYXRjaGVzIGp1c3Qgd2FudCB0byB0ZWxsIFFlbXUgdGhhdCB0
aGUgcmVzZXQgcmVxdWVzdCBpcyBmcm9tIHRoZSBwcm9jZXNzIG9mIGd1ZXN0IHJlc3VtaW5nIG5v
dCBvdGhlciBzY2VuZSwgYW5kIHdyaXRlIGEgc3RhdHVzIGludG8gZnJlZXplX21vZGUsIHRoZW4g
d2UgY2FuIGNoYW5nZSB0aGUgcmVzZXQgYmVoYXZpb3IgZHVyaW5nIGd1ZXN0IHJlc3VtaW5nLg0K
DQo+IA0KPiBQbGVhc2UgcmVmZXIgdG8gcXVldWVfcmVzZXQgcmVnaXN0ZXIgZGVmaW5pdGlvbiBm
b3IgYWNoaWV2aW5nIHN1Y2ggc2NoZW1lIGFuZCByZWZyYW1lIHRoZSB3b3JkaW5nIGZvciBpdC4N
Cj4gDQo+IEFsc28ga2luZGx5IGFkZCB0aGUgZGV2aWNlIGFuZCBkcml2ZXIgbm9ybWF0aXZlIG9u
IGhvdy93aGVuIHRoaXMgcmVnaXN0ZXIgaXMgYWNjZXNzZWQuDQpUaGFua3MsIEkgd2lsbCBhZGQg
dGhlbS4NCg0KPiANCj4gQWxzbyBwbGVhc2UgZml4IHRoZSBkZXNjcmlwdGlvbiB0byBub3QgdGFs
ayBhYm91dCBndWVzdCBWTS4gTGFyZ2VseSBpdCBvbmx5IGV4aXN0cyBpbiB0aGVvcnkgb2Ygb3Bl
cmF0aW9uIGV0YyB0ZXh0Lg0KVGhhbmtzLCBJIHdpbGwgY2hhbmdlIGl0Lg0KDQo+IA0KPiBZb3Ug
bmVlZCB0byBkZXNjcmliZSB3aGF0IGV4YWN0bHkgc2hvdWxkIGhhcHBlbiBpbiB0aGUgZGV2aWNl
IHdoZW4gaXRzIGZyZWV6ZS4NCj4gUGxlYXNlIHJlZmVyIHRvIG15IHNlcmllcyB3aGVyZSBpbmZy
YXN0cnVjdHVyZSBpcyBhZGRlZCBmb3IgZGV2aWNlIG1pZ3JhdGlvbiB3aGVyZSB0aGUgRlJFRVpF
IG1vZGUgYmVoYXZpb3IgaXMgZGVmaW5lZC4NCj4gSXQgaXMgc2ltaWxhciB0byB3aGF0IHlvdSBk
ZWZpbmUsIGJ1dCBpdHMgbWFuYWdlbWVudCBwbGFuZSBvcGVyYXRpb24gY29udHJvbGxlZCBvdXRz
aWRlIG9mIHRoZSBndWVzdCBWTS4NCj4gQnV0IGl0IGlzIGdvb2QgZGlyZWN0aW9uIGluIHRlcm1z
IG9mIHdoYXQgdG8gZGVmaW5lIGluIHNwZWMgbGFuZ3VhZ2UuDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3ZpcnRpby1jb21tZW50LzIwMjMwOTA5MTQyOTExLjUyNDQwNy03LXBhcmF2QG52aWRp
YS5jb20vVC8jdQ0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdp
bGwgcmVmZXIgdG8geW91ciBsaW5rIGFuZCB0aGVuIG1vZGlmeSBteSBkZXNjcmlwdGlvbi4NCg0K
PiANCj4geW91IGFyZSBtaXNzaW5nIHRoZSBmZWF0dXJlIGJpdCB0byBpbmRpY2F0ZSB0byB0aGUg
ZHJpdmVyIHRoYXQgZGV2aWNlIHN1cHBvcnRzIHRoaXMgZnVuY3Rpb25hbGl0eS4NCj4gUGxlYXNl
IGFkZCBvbmUuDQpEbyBJIG5lZWQgdG8gYWRkIGZlYXR1cmUgYml0IHRvIERFRklORV9WSVJUSU9f
Q09NTU9OX0ZFQVRVUkVTPyBBbmQgZWFjaCB0aW1lIHdoZW4gSSB3cml0ZSBmcmVlemVfbW9kZSBm
aWxlZCBvbiBrZXJuZWwgZHJpdmVyIHNpZGUsIEkgbmVlZCB0byBjaGVjayB0aGlzIGJpdD8NCg0K
PiANCj4+ICBcaXRlbVtcZmllbGR7cXVldWVfbm90aWZfY29uZmlnX2RhdGF9XQ0KPj4gICAgICAg
ICAgVGhpcyBmaWVsZCBleGlzdHMgb25seSBpZiBWSVJUSU9fRl9OT1RJRl9DT05GSUdfREFUQSBo
YXMgYmVlbg0KPj4gbmVnb3RpYXRlZC4NCj4+ICAgICAgICAgIFRoZSBkcml2ZXIgd2lsbCB1c2Ug
dGhpcyB2YWx1ZSB3aGVuIGRyaXZlciBzZW5kcyBhdmFpbGFibGUgYnVmZmVyDQo+PiAtLQ0KPj4g
Mi4zNC4xDQo+IA0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6
IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gRm9yIGFkZGl0
aW9uYWwgY29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRldi1oZWxwQGxpc3RzLm9hc2lzLW9wZW4u
b3JnDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K
