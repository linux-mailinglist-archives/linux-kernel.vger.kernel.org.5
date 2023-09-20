Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4E7A74E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjITHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjITHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:53:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E097
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2crZD6Q6PRKjM6cT7nwhYHSQWeZoWrFSvTDaoWgMSEAeWvNeitUQeGDrwsU8gA53Kl+S8WqQeAjul0op3j278I0HjpCGJIe4XezOkJ061WW7gMPnV8+Ck/BBm/AVWYkY6W55DpoNr7KyGFyaWxSdZa54+X0aM7thhShWsbKbZOS6bdhk3I/rie++ShBsW6f8+wUXXwXybFiP+myT6zQC7Aqqgm6o8BE9++eUEZdpaf36DVhYOfJ5st2Z+ZNa5QuLf18rcc9u3uJUhFky3Wd+MM46UCyuRTNquVZMT3KDzrCskUu4ByucYLn6G7wiW/E3SSusH9OLJxG7cR9vSjXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIZJt7YRu4ktYJwARBxgBEIDM0SbsBS3HWZ4jCtrqYc=;
 b=HD52hsAWpKMHCHsiYTRHTqZeeDQ7sXmo2/PqzJlNSI9hl5xtsx7CQ47/PvlibYXRLC8ncsju+ILjqPIbd99V9ICBc6bfBrrqo5BweT7w+pDLdhMH4IdY/tENhyMCfSo7miUZLiRdkX/VZK79SvBoICh9qS0kFLQvNhTKDxhr/QH12PcViupm/by+UfWN2qP2q0gBM++K0c0DWlEaqE///hniCAwLTz22FNag6Hi/XsFPLeUTlPl5+9NcOw747z/QletSo762D0uJVUp3KbesEN3XDgi4rG5S6gF3uuUhTBxgtzngur0sAKxj70QUUO7gCP5eeXirQWKzK4q6xjwu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIZJt7YRu4ktYJwARBxgBEIDM0SbsBS3HWZ4jCtrqYc=;
 b=ThRhpR7eQLub8NdeOdgkGkYuIl9hatJx8RwzNL4PkTrKn91ClIYpQKtPfwx5pIug+eVjr9eAUI3LwxIJL8I5/0ZvR2sm1jnopVk+wVfHT9xV8tmyhGm4cY7D3yDPTauZbuSSlYBM3wkixbNXlTqAy/l1yLxJ8RKMPJ1ZcC7fzl0=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 07:53:31 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:53:31 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        Parav Pandit <parav@nvidia.com>,
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
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiFHuAgAEk1ACAAI2IgP//hVyKgACKb4D//3wYAIAABOgvgACGl4A=
Date:   Wed, 20 Sep 2023 07:53:31 +0000
Message-ID: <BL1PR12MB5849B98B7D8498F02598691AE7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
 <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
In-Reply-To: <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MW4PR12MB6802:EE_
x-ms-office365-filtering-correlation-id: b1426128-3b5e-4768-2322-08dbb9aeaedc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cs6rmKgPuT+F4F7h0QtOeJvyHMTRyAHGuRd0sBZhK/WtyHvZRCYWEkTN1ot8At6VbPSBcZE2aEnPIhVAB9nn8F18YmoID/YvkfjxCq8K8Bmnn1G9QXN0zuDLk0s/hUqcMwAEB8gFwxtF8Og255rbfDZCUB3yMBjrPp3ODatLpw6PWTybC8dK/XzeUYd7jTVzRy4enFVAKbFF4G0fP1H1sYD/tSBIAjE5NHSEyCuQIGAr+n+D/uggIu2R8xIaQhRfk7X8VkhGG8M/g4DBNMywQ6sNA84EQvy45wrClgU/HvF+zN+ntmW3Ql4yrKdz/gcQSs/jiKp2E0dv4Awta9oZn8eeNe4xE7+aQ07y+Dcj2XyE69MckaAouw7JXXl2LOV/d6ugBFq4/AsQhrGRxWZyIl0zUBYmSEKsyeIUtVs8/1M2Q8HxQ5GGQImSEEd0wSjcnAJjvSqx8NT1uEc2jx1MWLIwTdEFb7X731AdIK1uIP4X06A9jCRAMW1UO3zVoaQfyZNYiaPf3JfhITIcQg+rzUe4aZgy5PxTayblBMVXgV4uJ2rUT5PC8IRNkoA9rd4qjek07B3/aI1EfL2p5NkH6NiIvKLb0YoMHla4yfg/3hygXTirETuqnqqhFE4ga2Jo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(55016003)(5660300002)(41300700001)(26005)(7416002)(2906002)(122000001)(33656002)(38100700002)(38070700005)(4326008)(8936002)(52536014)(8676002)(83380400001)(7696005)(6506007)(9686003)(478600001)(53546011)(110136005)(316002)(54906003)(66946007)(76116006)(64756008)(66556008)(66446008)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2k1Q3N6YnY4Tk1QY0tsaFJsTm5tWkNlVnRuVmpHeTBLQU1aaUk1cTY5SDVL?=
 =?utf-8?B?RTFZdEdNZmdZYjFpRkJhemRIVDBMQkV2bFlRS1haOEtobEo4MlpyU2hvTlpU?=
 =?utf-8?B?NjlQMGpKaXpvcURBWDZ6Q0N3cE1VRjRrUW52Q2xLb0ZvVXRYeDczcnlzVTBm?=
 =?utf-8?B?aHZlWmxQdGtEdElFbjZVU0NXYVg0UjBlRHI2c0dlcmlmNFVzVVcyNkcvcll5?=
 =?utf-8?B?YzhGTzR2ZXljWllKZ1h0bTJ0bzZSWHpRNzZBWWFqVWZUOHRxYWVFcVZDRG5C?=
 =?utf-8?B?bk0xc0FONWthT2FHRDladExIV3JZaXoxdXVkMDRwM2I0Ylh4SHlBUnBFVEty?=
 =?utf-8?B?aW9OQ1RGMnZHdjQ3d0FVakJTZzQwdkU3L1Z0N3piSm5WVEc1b28ybFVzbFJr?=
 =?utf-8?B?b2FhUWNJZkROcE9HbGFxN3N5RjJqY3IzS1NFcVduR1VsNzJOSDR5azQwUlhx?=
 =?utf-8?B?ZGZKZmczZzJub3BRTVljb3dwSUNjdG91Rjd5dTB2N0NHd21ZVE5DSWpoWlhG?=
 =?utf-8?B?UlhQbjluMkVlcWZzMFpJa3ZWUXJScXhnRTg1UW44ZVpFU3BmQUdFbkQ2ZTlM?=
 =?utf-8?B?SUpOcElxMXhEcytRT2dUcHgzYmRiejZpM2tPK1Q0dG5WVzJnT21xTjhUNzMv?=
 =?utf-8?B?UCtYU2JPZllGKzdpcnkvR3gwWlNMYVN1VXlLVGZtSnJ4TmlZSHppVG1vNnZ5?=
 =?utf-8?B?aStnbXZRSThiOWdnWlRlK3FRdHBna2QrZjUzb2dpVm02czBVR2FxOTkzMzh2?=
 =?utf-8?B?WmtTZ0tkOFRWUUJlc2FsaER4cUJBZDBCR1pVSDRMRExmZ2lnZVFwNGxDcFpQ?=
 =?utf-8?B?OFJRemZMODAvRlZZQTJ4aFhBNGx2OEVMQzJxb05SczV4QkJTcG9ZQ2JKMVB1?=
 =?utf-8?B?L0xPcFA0Nkd5c3lmaW1zSjNrTW9yL0hhSkhiVUlrZDZTYkp3VVVyT29oNlFC?=
 =?utf-8?B?YWFOTllCY0VYcS9reW1zQkZ3ZWVtZ2RPSzhjaXhVK2RzOE1xdlhCQzc3dlJT?=
 =?utf-8?B?TU1VY0x6QW54bFZENmIxdzkydjNpM0MyZ3E3c1Nkb283VW9PZkNlQ2tsWHJT?=
 =?utf-8?B?SlREVGhVeDJVeDU2QzdnRFJxakM0TmZCWlRHSy9FMy9ST2FiK1hTRmYrVzV3?=
 =?utf-8?B?di9LRURHMzUydGdnSnpiajNrQzF3MkNZMUViK0RyNHVyaTNLMFRlbVZDQ0oz?=
 =?utf-8?B?WW5XU3FmdzkvOWpyN09iRFM0QkJlMzRvLzArT0U4NG5PVS9MdTZ1SHpxL3VP?=
 =?utf-8?B?QmJQZmtFY2czSWdOMlp5QzM1cGwrN3pDRzFoR1BmU3lLRTN3bWxmRG4zbzNU?=
 =?utf-8?B?UG11bzM2NGtxanNFNXozeFVyVFZCTUdraWIwVGtHK29IY0lvcE92ZHVlNWsr?=
 =?utf-8?B?dEFMNGJkak5UNEFwSUhkY2xXNFAwOVd5aTl5RENPQXRablFhaTB4YW5Gc3d4?=
 =?utf-8?B?bnNlQkRDeGdsbUQ5Ly82OVJVMjNlR2J4RzJkTnNEdXVlTXpmWEV1UnVPbEsx?=
 =?utf-8?B?eTBRNkw2cnUrclg1K1ZSRk1yTHNTZTdtdDFoWDArTHhhYmhscXBDcDdrQmp3?=
 =?utf-8?B?SWN1Ylp3anBUeWNJblFXMGhKbGNSRVMyVGVHTW83SGt6bXpoM2o0ZXZra3Zr?=
 =?utf-8?B?Z2QzVjZoTXMyRmZnRXZzbm1UcjR3VW95MEoxVlkwUHdIRGNBTUJxV1ZlTkMr?=
 =?utf-8?B?N0Y3NnYwa094YUkvSkJZd2xSZlRBTjNSNEdZb0plNlpJRlJaL08zM0lZL3ZJ?=
 =?utf-8?B?RDd3Wi9CYkxUakhjRGVOaEVwUEt3cjdxNCtBNHhLb0RlTWRaa2RGUHh0Q1FB?=
 =?utf-8?B?ZzM0V0piaHlFUFlZaXN5dG1BVFhWWlNQRVR3QmY3RWp6cUFtM0VIVFVRbDlG?=
 =?utf-8?B?d3h0cVVVM29RdTlmVGEyQzN4NEhtRUQyU2ExT01rUG12R20zcFZZL1Jzbndu?=
 =?utf-8?B?eDBHZTAyN2Jqc1hUbE1maER6WUdQSzExOHowSXJCTndNeDlQK1dvMGZBQ2RE?=
 =?utf-8?B?WTBwZ1ZDc2hGYm43djdUbU85UlFlY0tVallwTjUzVEl4Y0NIWlFTRkhFV0lC?=
 =?utf-8?B?NnhDU2VsT1QvVUhvK21QcGlhSCtoVWJmcDRjYUtZUHNQbnNqS1JnL0FoamtQ?=
 =?utf-8?Q?bz4Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4198393AEC57314D8C895F11185D8B3F@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1426128-3b5e-4768-2322-08dbb9aeaedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:53:31.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WISfRby61lHKHvN6fyxxBFrOH9Rh/VgURRMSCsXvLxQ8d+TV4KfIZaABJPNjiFalI0vF/ktYJbhVMAvvy65vCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGluZ3NoYW4sDQpQbGVhc2UgcmVwbHkgdG8geW91ciBvd24gZW1haWwgdGhyZWFkLCBiZWxv
dyBhcmUgbm90IHJlbGF0ZWQgdG8gbXkgcGF0Y2hlcy4gVGhhbmtzIGEgbG90Lg0KDQpPbiAyMDIz
LzkvMjAgMTU6NDcsIFpodSwgTGluZ3NoYW4gd3JvdGU6DQo+IA0KPiANCj4gT24gOS8yMC8yMDIz
IDM6MzUgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIw
LCAyMDIzIDE6MDAgUE0NCj4+Pg0KPj4+IE9uIDkvMjAvMjAyMyAzOjI0IFBNLCBDaGVuLCBKaXFp
YW4gd3JvdGU6DQo+Pj4+IEhpIExpbmdzaGFuLA0KPj4+PiBJdCBzZWVtcyB5b3UgcmVwbHkgdG8g
dGhlIHdyb25nIGVtYWlsIHRocmVhZC4gVGhleSBhcmUgbm90IHJlbGF0ZWQgdG8gbXkNCj4+PiBw
YXRjaC4NCj4+PiBUaGVzZSByZXBseSB0byBQYXJ2YSdzIGNvbW1lbnRzLg0KPj4+IEBQYXJ2YSwg
aWYgeW91IHdhbnQgdG8gZGlzY3VzcyBtb3JlIGFib3V0IGxpdmUgbWlncmF0aW9uLCBwbGVhc2Ug
cmVwbHkgaW4gbXkNCj4+PiB0aHJlYWQsIGxldHMgZG9uJ3QgZmxvb2QgaGVyZS4NCj4+IFlvdSBt
YWRlIHRoZSBwb2ludCB0aGF0ICJ0aGlzIGlzIG5vdCBsaXZlIG1pZ3JhdGlvbiIuDQo+PiBJIGFt
IG5vdCBkaXNjdXNzaW5nIGxpdmUgbWlncmF0aW9uIGluIHRoaXMgdGhyZWFkLg0KPj4NCj4+IEkg
cmVwbGllZCBmb3IgdGhlIHBvaW50IHRoYXQgZGV2aWNlIHJlc3RvcmF0aW9uIGZyb20gc3VzcGVu
ZCBmb3IgcGh5c2ljYWwgYW5kIGh5cGV2aXNvciBiYXNlZCBkZXZpY2UgaXMgbm90IGEgNDBuc2Vj
IHdvcnRoIG9mIHdvcmsgdG8gcmVzdG9yZSBieSBqdXN0IGRvaW5nIGEgcmVnaXN0ZXIgd3JpdGUu
DQo+PiBUaGlzIGlzIG5vdCBsaXZlIG9yIGRldmljZSBtaWdyYXRpb24uIFRoaXMgaXMgcmVzdG9y
aW5nIHRoZSBkZXZpY2UgY29udGV4dCBpbml0aWF0ZWQgYnkgdGhlIGRyaXZlciBvd25pbmcgdGhl
IGRldmljZS4NCj4gcmVzdG9yZSB0aGUgZGV2aWNlIGNvbnRleHQgc2hvdWxkIGJlIGRvbmUgYnkg
dGhlIGh5cGVydmlzb3IgYmVmb3JlIHNldHRpbmcgRFJJVkVSX09LIGFuZCB3YWtpbmcgdXAgdGhl
IGd1ZXN0LCBub3QgYSBjb25jZXJuIGhlcmUsIG91dCBvZiBzcGVjDQo+IA0KDQotLSANCkJlc3Qg
cmVnYXJkcywNCkppcWlhbiBDaGVuLg0K
