Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0A7A73F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjITHYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjITHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:24:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36382C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6gMUcZzvP/qQA0FWBakLB0ZouTa0xbn4PMFSUl6uYR0YXwsZecGoGZfekdKnTEzZRB06gi3TTJKre7VbAX7xS3/lhhDOJr2NS2V5TKlqdcahzc0qI2Bgs79z6AneqlatlnDVXe0K3fjEuNIbOlIBMnq/S7urFwVxzjb8prqutfjzJKut7Wn7NQo9WCspd3omJd8UuW00T2iM6fKZ7VcZ8CHf0aFMLq6b89aKqdk3KvOngW+yDeYAec0mfdzoHzgkvjbQ3VUwMg6Df+glE7yBHEBpbCvljQ8YlIK0s48KguGdsJimCo11TtVL8SgSDTHRLkXLon08bbz6L/YVB8Piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLWQMpNO+MJCSll4ve+JLs6hyOCAlW6nHf6xc6UNP4Y=;
 b=akYIYenPZb+DLCNf5DvfykkcdiwoA/etZu1HWt0EBRhsvTEVHZ+F8HFoDkjwNwTC17maPkMcfWmGYkIeui0g7MwQHeox8PmM4lH+geE+99626xLAveeMmenEslgKE265VTsCHJUDOlpL5t0CmAxc5ld6EsoGy9uaHrFge//dnL+D5gxyhLzlSsftBEAw3aFRNkdPlXO6Z56YhLFngB+HGF2vcPYbKQlErmb3ZxR/21Mek+c82D7aMFKww/dInOEjngcgESh3+K5byYXQzmV10xrb5WuEIV6GbVEgWuj6qs6/4p0JPvwuYDfRpeSxQwqnF1fxs3lYpESACBvNPFT5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLWQMpNO+MJCSll4ve+JLs6hyOCAlW6nHf6xc6UNP4Y=;
 b=XVU10/qeUNBSJzI68z8oF4HbyrbDNVx8ODg2RE6lzNNNuAxxM9OoQIQM1kJX3AzLByXLrcz3+zdjyNZB5s7eRmcuRGkkGMhfWk4juzTgDXpVzaXuR79Dz1cSd3MJPJsdqAkblrlcxkVgxyIXz+QtL1rwnxbUVpnK68uJSv2jXhE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 07:24:11 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:24:11 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        Parav Pandit <parav@nvidia.com>,
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
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiFHuAgAEk1ACAAI2IgP//hVyKgACKb4A=
Date:   Wed, 20 Sep 2023 07:24:11 +0000
Message-ID: <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
In-Reply-To: <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BL0PR12MB4964:EE_
x-ms-office365-filtering-correlation-id: 58146377-01f3-4963-43be-08dbb9aa9631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7lfWSTZfIKSgAOlTDdOwA3aAZFrQjzNUptnwMuj2HoZrOqpdhT/La5EY0qZCvbBTj34gJptgVIoKxNu/EO0g7vhpQQ5RcedG2q3TCSMMaUDeaMqE5LlQwC0K80+e2ZJU90hT3xOYEjJE0p77K2AxOjteDqSmGmh/9C1VsZXJmiVuXseHJ8GOej4EZY0Pu0mLp0aPZnUotBnGW7xFgCHcyY3juT81zMsPxsGxed/VoJi3mX2WeuwTtVMpDZbBKzrTu+cALocXqOnGS0hwxLbrObAhtJIEiHbxA4BG4bjEpeL0mHcsVuzpWXyj/ubE8iO3ugEtqPjCvPQthnyk9+bvf4XbtMBWmzxbvkWqA69kVL6DrC+Fnxa26qog74/OyrUuroH4oyl6x4MzUath4tGfDe7okNeR9+ql8PJQSQPrrqgeqmydWSa8b5Z11ybnj2nUNT/bFuhR1iiWJpIuKUn2lHsK8zPBCwJjXX8Xjne+EOW13YkrjYskRUol5hGI6tAPwZQdHvS0XpGQbaCI6/O1tY1Nob2kCEdSFINaKXpeRqK5otDAEH6tYbHSt/GTIxX2m/L/Hz9UYdCaP8DRfS8bMqkp0Kkpt/vzh/S6sE/Pn8mK9aD+Kw+NYCygn9beTWf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(1800799009)(186009)(451199024)(9686003)(478600001)(7696005)(6506007)(53546011)(8936002)(8676002)(52536014)(83380400001)(66946007)(64756008)(76116006)(54906003)(66446008)(66556008)(66476007)(71200400001)(316002)(110136005)(5660300002)(55016003)(33656002)(38100700002)(38070700005)(4326008)(26005)(2906002)(7416002)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEQyRDhJK202T2xPUEo2NWlrOWR5ZDZTblZ0cGxlMHBMYjg4MVB2WG56d0tT?=
 =?utf-8?B?d2x6ZW9qYTcxeVFwV25zd2k3VERhZXpDeFFnSTZIV3BGQUNjR2ZCSUJENHFF?=
 =?utf-8?B?L3pGZjZvZE45MWlvaVM3WDdwUFFCcjdya09iYmk3TDZlSFkwTi9temFsa01s?=
 =?utf-8?B?azdoUm1FQURFaU9hdUYxM1RranN4NlgxVVZ4NU01dzZPMUJzTEZZWkEwUWRC?=
 =?utf-8?B?NmpDOE9CdDMwRFFwMmtXL1d1RHd1U0ROUzhvOE1zb1VBSE5ZUWpnVFdWZWhN?=
 =?utf-8?B?czducnptOW00Z1lLVnZvdnFCeitEMlJDVHhZMVkzL2FiYjJhSUE4NjZnMENE?=
 =?utf-8?B?TGM2eTcwcFczbWNPNVY3RW9tMjFYaWtTSGZmaEtEQVQwWE1YVlBSZy80MnNw?=
 =?utf-8?B?bmUzaWF2ZjJ3M2pPU1BLNTE3Q0lEcEN3QlBqdXRhTkw3WXFSWEkzRWxJbGor?=
 =?utf-8?B?WFhsNUdveHJLbjRabVIvNGMxN0NOZUZkVlE0NnlpR1NoSFk4cVlzYnFrSnZT?=
 =?utf-8?B?THMyY1h6KzI1MmhMU1RmcC9iYzBJcFRaS1paYjZRZDNUT3gzZW9QZXhpMEg2?=
 =?utf-8?B?U1ZXc2xPQ1pQdzBJVE9NemRvS29PdlUvN252SVh3U29wNGJ0WHlhV2dYL0pi?=
 =?utf-8?B?RVM0ekpzZWNNa3VIUXdNSFRMUXMrenlhNyt5NE1XMFJ5MUJRNXNqdDNLZlNz?=
 =?utf-8?B?azVKRGxvSDhZTE5WdThzVEduT3plRWJUQTk5RkdLNSt2Wm5CN2hpQ09vVEFx?=
 =?utf-8?B?NWFLUlF3dU9RMzk4QmdtUUE4OWhHeThhYjVLT29wVW50dUFyRGZweXFMTzRz?=
 =?utf-8?B?WjRxQk1NQklIM3BSZDc3WVNId09KaDAzUnlaNDUrWDNEbXE5VGxScmRjRjZB?=
 =?utf-8?B?cDdPT0lqMEoxcG9WYlNVeVFHdkRhZFBwK0dNQS9ZaWw4amVSV255YzZqVHBS?=
 =?utf-8?B?czIxSVNSV2g0NERIdFg3Vlk5QVA4OTU2c0FkRDZWQXd4K0RTT3JTa1hQbTBr?=
 =?utf-8?B?YTVab3UyQ2pKSmFod1Z4N0pDMUdGbCt2TFlQa2k1R0RwZU5ZTWVITHBIVGZW?=
 =?utf-8?B?aGlHVlZVcnlVZVI2WGpsaDBoNndNN1g4SW5hVGNIdHVpNWltMW16cko2UGVw?=
 =?utf-8?B?RW1qNlU3czNHY3ZoSjYxeXk2YlN6S0o4V2JrN1BmMkpneEJvam9uZ1R1QlFu?=
 =?utf-8?B?WWFaUzhLZmtSVDVkUlR0czYvR0lrQmpOSXRXc25aejBobDNubFhIbG1CQ0hQ?=
 =?utf-8?B?WVhua1FIOExDZWh4UnNpMFNiQTMyUkp2aEErVzdadWR3NStXNk1LTTJxYzM3?=
 =?utf-8?B?TDRZeDNyUWFPd0ljeDJDNWJuU2EvQllpOXVEUStNZU5YZVRKL2VhTVA4U2tQ?=
 =?utf-8?B?VmkrZmgvdmMydm4rY3lMYzZtTUZKelE2STBjVlJwKzlpUStXTVpNZ3ZReE8z?=
 =?utf-8?B?S3Y5ZG9vb3JYNFQ1OTBQd0VWVi9UU1RmNlhHcWtUMUZsdmxVdG1QSHdRQXpT?=
 =?utf-8?B?UDNjby8xMEJCMlR5akova3Fmc0d1SXhQNnhFMnNuVS93U1U1dGVYcjYxWSty?=
 =?utf-8?B?dDNsT0JnNWtmamJwclRTV0U4c0NNbkd5Y0d3Z1NIZnpVeUoyRkZhV0lVdnpn?=
 =?utf-8?B?NFFaY3RIQmxCQWZHajNsbG5DZHVJSlc4VzFvYTcxOC9zaTU2aXZrQVlqY0FJ?=
 =?utf-8?B?RDJtc1gwUzk3Q1lRTG10UkdrQkFBRlZHeCtiMmNyMElQanhlU2ZYQ3NoOUZ6?=
 =?utf-8?B?ZWhDMHhpNDVwVWw3RXJBVDcyMVVQZnBBQ0tkOGtvV01iRXJEU3JVTU8wbzdU?=
 =?utf-8?B?RXhHU1VFWjA3VnZBcnA0ejBYeVFYczc1d01pazV5ckw3K1BEQ3EveTQ5Ti9y?=
 =?utf-8?B?NFhDeTVKamd3WHZhZUVsc3puM3piVTRkOWdkYUpvVGNjbWg2N21ndnhMdUYw?=
 =?utf-8?B?M3c2TklBL1AvQnpTMVR3dDRiUHIwNThvQkNldzRITWxQWmwydmZnRDVIM0NY?=
 =?utf-8?B?cTlxTFVJTUFjd0k5ZnlUL29ndDZvOHE4NThVbjlLZm13eVI2bW9KbWZJbml6?=
 =?utf-8?B?RnZpcHBNa2lZNWVKWW9VN3RET2k5aEIxYzBDVUlWeVRZSlowSG53M0U4U25T?=
 =?utf-8?Q?Fa/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F827510A5A7F4345B0AE861296F326DE@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58146377-01f3-4963-43be-08dbb9aa9631
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:24:11.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QJTcqFQRBTdmEflKbhC8u2JnCiesP23gvxOaFzon8gY9psq3ZjxnP4G+Nhkpw4Xe46FhGHaiBO88sh8dDhJyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGluZ3NoYW4sDQpJdCBzZWVtcyB5b3UgcmVwbHkgdG8gdGhlIHdyb25nIGVtYWlsIHRocmVh
ZC4gVGhleSBhcmUgbm90IHJlbGF0ZWQgdG8gbXkgcGF0Y2guDQoNCk9uIDIwMjMvOS8yMCAxNTow
NiwgWmh1LCBMaW5nc2hhbiB3cm90ZToNCj4gDQo+IA0KPiBPbiA5LzIwLzIwMjMgMjo1OCBQTSwg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5A
YW1kLmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAxMjowMyBQ
TQ0KPj4+IElmIGRyaXZlciB3cml0ZSAwIHRvIHJlc2V0IGRldmljZSwgY2FuIHRoZSBTVVNQRU5E
IGJpdCBiZSBjbGVhcmVkPw0KPj4gSXQgbXVzdCBhcyByZXNldCBvcGVyYXRpb24sIHJlc2V0cyBl
dmVyeXRoaW5nIGVsc2UgYW5kIHNvIHRoZSBzdXNwZW5kIHRvby4NCj4+DQo+Pj4gKHBjaV9wbV9y
ZXN1bWUtPnZpcnRpb19wY2lfcmVzdG9yZS0+dmlydGlvX2RldmljZV9yZXN0b3JlLQ0KPj4+PiB2
aXJ0aW9fcmVzZXRfZGV2aWNlKQ0KPj4+IElmIFNVU1BFTkQgaXMgY2xlYXJlZCwgdGhlbiBkdXJp
bmcgdGhlIHJlc2V0IHByb2Nlc3MgaW4gUWVtdSwgSSBjYW4ndCBqdWRnZSBpZg0KPj4+IHRoZSBy
ZXNldCByZXF1ZXN0IGlzIGZyb20gZ3Vlc3QgcmVzdG9yZSBwcm9jZXNzIG9yIG5vdCwgYW5kIHRo
ZW4gSSBjYW4ndCBjaGFuZ2UNCj4+PiB0aGUgcmVzZXQgYmVoYXZpb3IuDQo+PiBSZXNldCBzaG91
bGQgbm90IGJlIGluZmx1ZW5jZWQgYnkgc3VzcGVuZC4NCj4+IFN1c3BlbmQgc2hvdWxkIGRvIHRo
ZSB3b3JrIG9mIHN1c3BlbmQgYW5kIHJlc2V0IHRvIGRvIHRoZSByZXNldC4NCj4+DQo+PiBUaGUg
cHJvYmxlbSB0byBvdmVyY29tZSBpbiBbMV0gaXMsIHJlc3VtZSBvcGVyYXRpb24gbmVlZHMgdG8g
YmUgc3luY2hyb25vdXMgYXMgaXQgaW52b2x2ZXMgbGFyZ2UgcGFydCBvZiBjb250ZXh0IHRvIHJl
c3VtZSBiYWNrLCBhbmQgaGVuY2UganVzdCBhc3luY2hyb25vdXNseSBzZXR0aW5nIERSSVZFUl9P
SyBpcyBub3QgZW5vdWdoLg0KPj4gVGhlIHN3IG11c3QgdmVyaWZ5IGJhY2sgdGhhdCBkZXZpY2Ug
aGFzIHJlc3VtZWQgdGhlIG9wZXJhdGlvbiBhbmQgcmVhZHkgdG8gYW5zd2VyIHJlcXVlc3RzLg0K
PiB0aGlzIGlzIG5vdCBsaXZlIG1pZ3JhdGlvbiwgYWxsIGRldmljZSBzdGF0dXMgYW5kIG90aGVy
IGluZm9ybWF0aW9uIHN0aWxsIHN0YXkgaW4gdGhlIGRldmljZSwgbm8gbmVlZCB0byAicmVzdW1l
IiBjb250ZXh0LCBqdXN0IHJlc3VtZSBydW5uaW5nLg0KPiANCj4gTGlrZSByZXN1bWUgZnJvbSBh
IGZhaWxlZCBMTS4NCj4+DQo+PiBUaGlzIGlzIHNsaWdodGx5IGRpZmZlcmVudCBmbG93IHRoYW4g
c2V0dGluZyB0aGUgRFJJVkVSX09LIGZvciB0aGUgZmlyc3QgdGltZSBkZXZpY2UgaW5pdGlhbGl6
YXRpb24gc2VxdWVuY2UgYXMgaXQgZG9lcyBub3QgaW52b2x2ZSBsYXJnZSByZXN0b3JhdGlvbi4N
Cj4+DQo+PiBTbywgdG8gbWVyZ2UgdHdvIGlkZWFzLCBpbnN0ZWFkIG9mIGRvaW5nIERSSVZFUl9P
SyB0byByZXN1bWUsIHRoZSBkcml2ZXIgc2hvdWxkIGNsZWFyIHRoZSBTVVNQRU5EIGJpdCBhbmQg
dmVyaWZ5IHRoYXQgaXQgaXMgb3V0IG9mIFNVU1BFTkQuDQo+Pg0KPj4gQmVjYXVzZSBkcml2ZXIg
aXMgc3RpbGwgaW4gX09LXyBkcml2aW5nIHRoZSBkZXZpY2UgZmxpcHBpbmcgdGhlIFNVU1BFTkQg
Yml0Lg0KPiBQbGVhc2UgcmVhZCB0aGUgc3BlYywgaXQgc2F5czoNCj4gVGhlIGRyaXZlciBNVVNU
IE5PVCBjbGVhciBhIGRldmljZSBzdGF0dXMgYml0DQo+IA0KPiANCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpKaXFpYW4gQ2hlbi4NCg==
