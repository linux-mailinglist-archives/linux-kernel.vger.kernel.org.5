Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A637A98D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjIURxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjIURxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBD4F931
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3BDppv0C8Lr9UoVX5c5Jya8OSBZixRcdJkxeuVkWS99HzQU2/TcyLjNx+2qJgpmav382CP2U8EfiBqSCPuADU13nE2dn68MT+p2RA2OJ5Md/loFA1ivqOHaUF3x/HCzvwAyMEf3H6kk/L+H+ZMSWexx/VlemyWkgT6ENC/6jL99vXQscoNHbyVEDPjFB2QqrDckWaqz84ly/qHp9GAmTJaIHTwh1GUaQsKcxjeZIrXz4kV6tryVzKYToGiLm8pCtcyfungbf/fUAD/kJh9yPHKzTwAxICGVTWgwjsm5dDMNxgmXoaxfIApKuy9DeSrqA0B0XEraKPuTRVjornur9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmWlaQh2q7dng2K3s7YioDbUh36bTRJ+edb18irpF68=;
 b=hvGN6sgZbLvoZt+yx3jHkFmQjnZR+xHM75T5uNi5Efru/e9a4h388bKROb36okzGOOEbeHJCE0hSVC4K4qYbLBDu6651P96gfX1S4kUla0EWZ4mnc+Y26SZj+v38ebrUfOQwlvrjkMvV5/o6+pxGkxcaVpyQZL7QcFiYZWdoOwAst677Ahe1RTGog88u70oWSeN1RmSSDfasObrFq4wySWmKwubcglWsmazSPQbNOwoHfpK0pfcGoOX2AVM3YMQZPTPDLZK/4D6E+oaIMKqeOlJylymA7vxc/oJPWsMaAmpvkbsSPskX0jmVoj1STmBMbidFgNTQWhxs+Lx3i4Y6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmWlaQh2q7dng2K3s7YioDbUh36bTRJ+edb18irpF68=;
 b=cq71h09zhuDe1Buxrr9Sdy75j+G3AeURZKt0/BoKEF4ip+wH+4rwCeRHLyN1Q42+jnINWxR+29sJypyMKgvzbOBHmtDezRYB2GExExNqD5a1tLsj/DNFXQ8x/9mtXeyPhpPhRjW/AjbsjrUFNSWlYnLtOwB/Bfv1QRTw1dB73Ak=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 06:28:31 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 06:28:31 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
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
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AksLcAgACjFgA=
Date:   Thu, 21 Sep 2023 06:28:30 +0000
Message-ID: <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
In-Reply-To: <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM4PR12MB5721:EE_
x-ms-office365-filtering-correlation-id: 04a57c22-b1a1-497c-17ba-08dbba6bf915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ur29++n6rsFn1GNOHTTFgNrYfMk/7C6eW52Y8z/bvm/W3nI3GJ0aswL2Rg7Q/op2xeySuetEXPTlRPAJOyIGm/haQ2s4dy3Uy4Kn3hkTQ+Rf8Isep0X2Z+xc0N18A+HNlNWuoj7ShZvaY/QvQHet7co3Nz6eWgVyozZcjjbde9RXIkndhKZtJGAbn6iUI4iWtS80ggtsIaftf87bzmiLVbRu7mvCwWOKCcSlWR+2zH3jTVzcE5Jc9jfSVps6VBfmyHquvY/wsdqjbrdgiAg6UYfntihZmn9rHL1BIwMQGlN3lXzr0VNm/R007H82PKZiiYW9vOL2K+SrAQKA6LVX2++Ceoq+RVvXgT51D9Bczxjehr/Ybq6v1CMwHsVTbGy42XjmMNxVtmwDzA9pQz8HbqBkGb1Ro1/gHLx8AujDpGyKVk1R8iaSsyeVrWhY9LK4pJfbiW/DWaxKLjIcegAh7d/nKc0+L2t2qaCpdhYkgru7Vinnq7XlWhLjvvEioMyYrAujae7wEl27oIYXe+kJ+LKPX6KZ0qp/jRYQRj6eUXbvNifEgAj5QZk3jD8kxQ4Oh96+mQQQjQ4Iu5GYmSvpGsZKuxEZru3RcTQQmQA3gZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(71200400001)(38100700002)(478600001)(38070700005)(122000001)(966005)(33656002)(7696005)(6506007)(9686003)(53546011)(83380400001)(26005)(41300700001)(316002)(6916009)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(2906002)(66899024)(8676002)(52536014)(8936002)(55016003)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVZOZ2VUTVNLcXJBZC9qeWpFUXF6cU4yZWZ0RGpHTWVmL2lHbXllWkxuZ1Fv?=
 =?utf-8?B?K1AxcCtndzJIUFlpRDJzbEk4WlJNcktsZlE5cHVWaHc3UjJ6TktkcWpQODZE?=
 =?utf-8?B?Sm5CSWt1NVhhcnlwV2tRcCtKakc1a0VIYmg4QkxVSlRiYS81TkFBeW5FeTFB?=
 =?utf-8?B?d3RmTnFLWWRnRm1kVElSY1NlcUFlMmhRYzdOZElvUWI0TEl1TFIxTDh4MGpu?=
 =?utf-8?B?M3poblhsZTA3eXBPS2FBNmdPYUNqakhPUTRkNDBublluSjNEenpodHVuVWpp?=
 =?utf-8?B?QjJBRGErYUw1dzR4MEZMeUNUc0NMVFdNcGg3MGk0V1NkZUlQV0xXc3NhMno3?=
 =?utf-8?B?c21pSkJIbFp6c3AwMDJOVXdZRkFwSmZGMjBvT09GQi9vUWhuR0phRFh0aTBZ?=
 =?utf-8?B?WmZJZG5ud0VBa2o3MmJYQVdBd0hrK1NIaUR5dmdkMi9XRU9IOG95ZXloNmJJ?=
 =?utf-8?B?MlVBSjZFYTBPRzBmNEMvT2hRdWFJMDQrcW5yYnJaUURaNW9nL3FEK25nTWtX?=
 =?utf-8?B?bzF4MTM3YjlrWE9SNC91OHpMbDdLb0RmajdDNXYya0VqWEFtRVRRNmJQUEo0?=
 =?utf-8?B?ZVEwUEFBSmN6OUJuaWpoVjdZMFVQci9BcUd1aUVHM1MwQjhrc25PaVVBeUxN?=
 =?utf-8?B?bDBhRXZzTnZsdlJFcmp0S3YvQ0lxUXYwbVZiTzB5cXlxK0VHMGJ6M0E4QjBw?=
 =?utf-8?B?ejd3TXowVlFTL05BdnIvenU3eDJ2bUk1UXR4SkwxUENYUk4xQWI0bWl0a0ZF?=
 =?utf-8?B?U3E3RHZBWk0rSG5RaTIxMi9SaGdiWHBNbnVzL2N2bWZ6Um85dmY5YUJUS1Vx?=
 =?utf-8?B?WFE1UXFwV3dFOWRqZVdrQTZ3Vm1CN1ZzVFFMbGliNTlQWksxQ1k1Q1dEaDlI?=
 =?utf-8?B?Njk1Ym0rZW8ycGNsY2c4YTFDUE9tZE50dmNaa21MaUpxTm5nblhaSVIzTS9u?=
 =?utf-8?B?TDIvWGM0elhXUkJjdmRDekttKy9ZdDI4WFhialE0dC9DNEFBZ0p0TUswYkZy?=
 =?utf-8?B?a1dnUGk5emNFNEpuakFBb2p4YUhOSCtBbzlISGIxTi9jZjdhU0JVZUpEOXB3?=
 =?utf-8?B?S1VKVHQ2TC9GOXRwWENPc2ZwbFJFSEp0N2t1YVNUTlJGS3VkZjV0OUl0MTFw?=
 =?utf-8?B?Y1RreDlmZnNMYVlEWUpJdDU0U0czOG4yeUNRemJRWHljMk9OWExwZmlCU0RC?=
 =?utf-8?B?dVFiaHVQZUZHd0dHOXcySWg1dFdiQjNvMEsyZzB6U0p1bXgzWFVCcHRWdE9v?=
 =?utf-8?B?QXdTaFBuTndBY3J2ZW5MRlZmZlZ2eWszTXArQ0FwSHJHYWFpOE9ic3J2cDBZ?=
 =?utf-8?B?MFJ0elNyS1QyVU1seDdCRVhaRm1YZXJiVUs3TGFmTVZ1NkFOWnZqMndBWHVO?=
 =?utf-8?B?c1F4ck9IYVN5ekg2Tlc2MnlzUW1RS3pBbG5UcXlHZmFIT1JaT1V2RnVZTjRY?=
 =?utf-8?B?bnRmSGVpNHlKdDZ6UWdtdGFDamdUWHU4cVBmWm9iemJLc3N2UWdvbVlVdTJU?=
 =?utf-8?B?NGZIMzJKWUtyL1VvdzFubUF5b3hTOCtpVDVDTzVROFE4Q1lzODlhN1JlbU0x?=
 =?utf-8?B?VXBacmtBZmR0M1dOcmJOdjFsRUc3dEJ5TXRNYk9QcFo0UHBIeHZTaGNHc0tZ?=
 =?utf-8?B?V2VNSjhHN3VpbTNsNUNjSjcxZGhoekpkeVp0anllWTFmc05Ocm52WHBGb01F?=
 =?utf-8?B?azk3N29OM2lUaXhhTHA5OTAvK0pMaFh4dHluTVBWb1ZjOGwxTUJiNGkvZUVw?=
 =?utf-8?B?MGh3bHZzL0RCTTU4R284Mkh4aWJBMUJmMGJMd0wycVBkTS85dzd2WmMzT1l1?=
 =?utf-8?B?R3VYR1lyOE1waloxdzFSTG4yRmdzTHhUK3puRmZTTjdBczJWaDQrUWNHOUFi?=
 =?utf-8?B?SHBqNUl1TnV5ZlVvWWRrUGZSTW92VW9XT05VMXZrMjRRRWpLSzh6R3o1TDJC?=
 =?utf-8?B?RVdFaEtkVHZDcGNFSHpKamhBNUZnWGhHbVBKRk1JYmY3aTJMY1Z5TGs3Znph?=
 =?utf-8?B?NGtvcGlsWVN0dTl1cjhUR01odU1DakZiWHE4WE1NT1YvbXhpckNIWEFRQVp2?=
 =?utf-8?B?VWZpV3BQMDFqNTJQM0NiLzR0WVJBd21obU9heUhoSTBhRTdiMEhJSVNpL0N1?=
 =?utf-8?Q?QTOo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C17D5E176A3CD24187E102FA6E08608A@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a57c22-b1a1-497c-17ba-08dbba6bf915
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 06:28:30.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDj3FFDM/8xJ2SAnRW0LSIzKdFt8kIyXLYEzNOsa+M0hsMo+A0sYWcwhDtsoLZAfFcs/Bcs9o7rcwOAACA7q3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24sDQoNCk9uIDIwMjMvOS8yMSAxMjoyMiwgSmFzb24gV2FuZyB3cm90ZToNCj4gT24g
VHVlLCBTZXAgMTksIDIwMjMgYXQgNzo0M+KAr1BNIEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBh
bWQuY29tPiB3cm90ZToNCj4+DQo+PiBXaGVuIGd1ZXN0IHZtIGRvZXMgUzMsIFFlbXUgd2lsbCBy
ZXNldCBhbmQgY2xlYXIgc29tZSB0aGluZ3Mgb2YgdmlydGlvDQo+PiBkZXZpY2VzLCBidXQgZ3Vl
c3QgY2FuJ3QgYXdhcmUgdGhhdCwgc28gdGhhdCBtYXkgY2F1c2Ugc29tZSBwcm9ibGVtcy4NCj4+
IEZvciBleGNhbXBsZSwgUWVtdSBjYWxscyB2aXJ0aW9fcmVzZXQtPnZpcnRpb19ncHVfZ2xfcmVz
ZXQgd2hlbiBndWVzdA0KPj4gcmVzdW1lLCB0aGF0IGZ1bmN0aW9uIHdpbGwgZGVzdHJveSByZW5k
ZXIgcmVzb3VyY2VzIG9mIHZpcnRpby1ncHUuIEFzDQo+PiBhIHJlc3VsdCwgYWZ0ZXIgZ3Vlc3Qg
cmVzdW1lLCB0aGUgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5kIHdlIG9ubHkNCj4+IHNhdyBh
IGJsYWNrIHNjcmVlbi4gRHVlIHRvIGd1ZXN0IGNhbid0IHJlLWNyZWF0ZSBhbGwgdGhlIHJlc291
cmNlcywgc28NCj4+IHdlIG5lZWQgdG8gbGV0IFFlbXUgbm90IHRvIGRlc3Ryb3kgdGhlbSB3aGVu
IFMzLg0KPj4NCj4+IEZvciBhYm92ZSBwdXJwb3NlLCB3ZSBuZWVkIGEgbWVjaGFuaXNtIHRoYXQg
YWxsb3dzIGd1ZXN0cyBhbmQgUUVNVSB0bw0KPj4gbmVnb3RpYXRlIHRoZWlyIHJlc2V0IGJlaGF2
aW9yLiBTbyB0aGlzIHBhdGNoIGFkZCBhIG5ldyBwYXJhbWV0ZXINCj4+IG5hbWVkIGZyZWV6ZV9t
b2RlIHRvIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcuIEFuZCB3aGVuIGd1ZXN0DQo+PiBz
dXNwZW5kcywgaXQgY2FuIHdyaXRlIGZyZWV6ZV9tb2RlIHRvIGJlIEZSRUVaRV9TMywgYW5kIHRo
ZW4gdmlydGlvDQo+PiBkZXZpY2VzIGNhbiBjaGFuZ2UgdGhlaXIgcmVzZXQgYmVoYXZpb3Igb24g
UWVtdSBzaWRlIGFjY29yZGluZyB0bw0KPj4gZnJlZXplX21vZGUuIFdoYXQncyBtb3JlLCBmcmVl
emVfbW9kZSBjYW4gYmUgdXNlZCBmb3IgYWxsIHZpcnRpbw0KPj4gZGV2aWNlcyB0byBhZmZlY3Qg
dGhlIGJlaGF2aW9yIG9mIFFlbXUsIG5vdCBqdXN0IHZpcnRpbyBncHUgZGV2aWNlLg0KPiANCj4g
QSBzaW1wbGUgcXVlc3Rpb24sIHdoeSBpcyB0aGlzIGlzc3VlIHNwZWNpZmljIHRvIHBjaT8NCkkg
dGhvdWdodCB5b3UgcG9zc2libHkgbWlzc2VkIHRoZSBwcmV2aW91cyB2ZXJzaW9uIHBhdGNoZXMu
IEF0IHRoZSBiZWdpbm5pbmcsIEkganVzdCB3YW50ZWQgdG8gYWRkIGEgbmV3IGZlYXR1cmUgZmxh
ZyBWSVJUSU9fR1BVX0ZfRlJFRVpFX1MzIGZvciB2aXJ0aW8tZ3B1IHNpbmNlIEkgZW5jb3VudGVy
ZWQgdmlydGlvLWdwdSBpc3N1ZSBkdXJpbmcgZ3Vlc3QgUzMsIHNvIHRoYXQgdGhlIGd1ZXN0IGFu
ZCBxZW11IGNhbiBuZWdvdGlhdGUgYW5kIGNoYW5nZSB0aGUgcmVzZXQgYmVoYXZpb3IgZHVyaW5n
IFMzLiBCdXQgUGFyYXYgYW5kIE1pa2hhaWwgaG9wZWQgbWUgY2FuIGltcHJvdmUgdGhlIGZlYXR1
cmUgdG8gYSBwY2kgbGV2ZWwsIHRoZW4gb3RoZXIgdmlydGlvIGRldmljZXMgY2FuIGFsc28gYmVu
ZWZpdCBmcm9tIGl0LiBBbHRob3VnaCBJIGFtIG5vdCBzdXJlIGlmIGV4cGFuZGluZyBpdHMgaW5m
bHVlbmNlIGlzIGFwcHJvcHJpYXRlLCBJIGhhdmUgbm90IHJlY2VpdmVkIGFueSBmZWVkYmFjayBm
cm9tIG90aGVycywgc28gSSBjaGFuZ2UgaXQgdG8gdGhlIHBjaSBsZXZlbCBhbmQgbWFkZSB0aGlz
IHZlcnNpb24uDQpJZiB5b3UgYXJlIGludGVyZXN0ZWQsIHBsZWFzZSBzZWUgdGhlIHByZXZpb3Vz
IHZlcnNpb246IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNv
bW1lbnQvMjAyMzA3L21zZzAwMjA5Lmh0bWwsIHRoYW5rIHlvdS4NCg0KPiANCj4gVGhhbmtzDQo+
IA0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1k
LmNvbT4NCj4+IC0tLQ0KPj4gIHRyYW5zcG9ydC1wY2kudGV4IHwgNyArKysrKysrDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90cmFuc3Bv
cnQtcGNpLnRleCBiL3RyYW5zcG9ydC1wY2kudGV4DQo+PiBpbmRleCBhNWM2NzE5Li4yNTQzNTM2
IDEwMDY0NA0KPj4gLS0tIGEvdHJhbnNwb3J0LXBjaS50ZXgNCj4+ICsrKyBiL3RyYW5zcG9ydC1w
Y2kudGV4DQo+PiBAQCAtMzE5LDYgKzMxOSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25m
aWd1cmF0aW9uIHN0cnVjdHVyZSBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+
PiAgICAgICAgICBsZTY0IHF1ZXVlX2Rlc2M7ICAgICAgICAgICAgICAgIC8qIHJlYWQtd3JpdGUg
Ki8NCj4+ICAgICAgICAgIGxlNjQgcXVldWVfZHJpdmVyOyAgICAgICAgICAgICAgLyogcmVhZC13
cml0ZSAqLw0KPj4gICAgICAgICAgbGU2NCBxdWV1ZV9kZXZpY2U7ICAgICAgICAgICAgICAvKiBy
ZWFkLXdyaXRlICovDQo+PiArICAgICAgICBsZTE2IGZyZWV6ZV9tb2RlOyAgICAgICAgICAgICAg
IC8qIHJlYWQtd3JpdGUgKi8NCj4+ICAgICAgICAgIGxlMTYgcXVldWVfbm90aWZfY29uZmlnX2Rh
dGE7ICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4+ICAgICAgICAgIGxlMTYgcXVldWVf
cmVzZXQ7ICAgICAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4NCj4+IEBAIC0zOTMsNiAr
Mzk0LDEyIEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZSBs
YXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+PiAgXGl0ZW1bXGZpZWxke3F1ZXVl
X2RldmljZX1dDQo+PiAgICAgICAgICBUaGUgZHJpdmVyIHdyaXRlcyB0aGUgcGh5c2ljYWwgYWRk
cmVzcyBvZiBEZXZpY2UgQXJlYSBoZXJlLiAgU2VlIHNlY3Rpb24gXHJlZntzZWM6QmFzaWMgRmFj
aWxpdGllcyBvZiBhIFZpcnRpbyBEZXZpY2UgLyBWaXJ0cXVldWVzfS4NCj4+DQo+PiArXGl0ZW1b
XGZpZWxke2ZyZWV6ZV9tb2RlfV0NCj4+ICsgICAgICAgIFRoZSBkcml2ZXIgd3JpdGVzIHRoaXMg
dG8gc2V0IHRoZSBmcmVlemUgbW9kZSBvZiB2aXJ0aW8gcGNpLg0KPj4gKyAgICAgICAgVklSVElP
X1BDSV9GUkVFWkVfTU9ERV9VTkZSRUVaRSAtIHZpcnRpby1wY2kgaXMgcnVubmluZzsNCj4+ICsg
ICAgICAgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVfRlJFRVpFX1MzIC0gZ3Vlc3Qgdm0gaXMgZG9p
bmcgUzMsIGFuZCB2aXJ0aW8tcGNpIGVudGVycyBTMyBzdXNwZW5zaW9uOw0KPj4gKyAgICAgICAg
T3RoZXIgdmFsdWVzIGFyZSByZXNlcnZlZCBmb3IgZnV0dXJlIHVzZSwgbGlrZSBTNCwgZXRjLg0K
Pj4gKw0KPj4gIFxpdGVtW1xmaWVsZHtxdWV1ZV9ub3RpZl9jb25maWdfZGF0YX1dDQo+PiAgICAg
ICAgICBUaGlzIGZpZWxkIGV4aXN0cyBvbmx5IGlmIFZJUlRJT19GX05PVElGX0NPTkZJR19EQVRB
IGhhcyBiZWVuIG5lZ290aWF0ZWQuDQo+PiAgICAgICAgICBUaGUgZHJpdmVyIHdpbGwgdXNlIHRo
aXMgdmFsdWUgd2hlbiBkcml2ZXIgc2VuZHMgYXZhaWxhYmxlIGJ1ZmZlcg0KPj4gLS0NCj4+IDIu
MzQuMQ0KPj4NCj4gDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gVG8gdW5zdWJzY3JpYmUsIGUtbWFp
bDogdmlydGlvLWRldi11bnN1YnNjcmliZUBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiBGb3IgYWRk
aXRpb25hbCBjb21tYW5kcywgZS1tYWlsOiB2aXJ0aW8tZGV2LWhlbHBAbGlzdHMub2FzaXMtb3Bl
bi5vcmcNCj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=
