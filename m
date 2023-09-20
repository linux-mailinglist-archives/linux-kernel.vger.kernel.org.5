Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673BE7A75A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjITISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjITISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:18:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C61C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drz5+UoUob2t/ztUMNlbTGNzHtPG0u39cBuLBm0knqcGpThnX7RgQEf3+dgucQiuZ5gvE1FbDwq54APdJUGFUNwm8kpewE//CH9+JUUp39lzz5VPNOf4UsctDQTCM7Wh2BCZ405gcDQQwezTNmlVJzpCl5ybB6JXE4ITQjIqdoiIU+iBrASZ60jJWsnUx9kJ2HCk0RzbLXPR3LJyf6NsSVQZq8WfSF6bJxGuPSlR04Q8jg+1VSu2aFGV3rcui4iKWAD13KGsSM2DnfqMdh63qS28HWMAGTxq0xY+u9Ri8M96Fe9iepC9gdbtk/6VHdOd1TfKby2oIcRKMiZqQfW7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvU0j02qK2bhmyBt84SuDrbKFqGcqx4oOBdZepAoyto=;
 b=JqRmeRdFui1RcftExnIZVdNXLMRdSZbJU1YETtHg6u5BB2ir0xpaLdagdjragOHgeLJC5DoKINwBZ/iObUwaRM26h2mH4S2BeY3SJc4GTamzoa+EB+oUIjp101yQDFqcTDm9fp5sWprmhp+TV7ZmDNUfvkPqnYsguVtCJjvDDTpmyPKmq96e3XkGAMetd7U2Hhmw+R9AsZin9IYPDjysBpgx6E5K8WxbQFRh9tZ4dmP5Ido1r/YjbREsKciYUR7JfwVWS8tsjbVHbs4KgihJQIMtmXnG53C+GQ+M7puKoTN0byQlv7/w/ikHAtKlf2jE0W9mE0Z4LkHZlWIcWaRG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvU0j02qK2bhmyBt84SuDrbKFqGcqx4oOBdZepAoyto=;
 b=z5sB4VOisK/mb3UcmgsL5/zzkTRvGbwqqfhbP6qolL2Cfujb+E7eoOI+umIFCGMm4DXJuLchdh0dHov48E17x4zMA4W9jZPM5OI9TBAs0aZH7XzLwKa1XQAq7vXGakoVz2bggnGYa8hgBE/zPanfSWrYPUs/dQ6h5KQ0HnRz2iU=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 08:18:27 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:18:27 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Parav Pandit <parav@nvidia.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>,
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
Subject: Re: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] Re:
 [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Topic: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] Re:
 [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiFHuAgAEk1ACAAI2IgP//hVyKgACKb4D//3wYAIAABOgvgACGl4D//3vJAAARCYGA
Date:   Wed, 20 Sep 2023 08:18:27 +0000
Message-ID: <BL1PR12MB5849B919336F6B6F15098092E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
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
 <BL1PR12MB5849B98B7D8498F02598691AE7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481B25861A98F040705B60ADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B25861A98F040705B60ADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS7PR12MB8081:EE_
x-ms-office365-filtering-correlation-id: 4543bfa8-2cf3-4d89-da03-08dbb9b22a92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYSKezJIHEp3AZMDhnaQZGF1bio01u1CVW/CXiYllAHtXiZ8JOvnrzK53es2JLx21QmE7vmU9C5fqVfET9oXIRJb2eXbh9CG9tudU6QppraeLcrUdsI+WMzXsnQ9KmkH/6+FVW11+hVnXx+cRuVuHpHFmSX0vEIRtM9VwZz6GcYjse5BxDV2VN7f5IQtYmwgISAMCa0wbiYMHJYPQhR8Bu4wgS/iBoCs4uu8oWh3pkU2gMdBH6vw3+4r6BsLy/AW+bA1k6AywF2duh0gXyl/ABMOjhAIr7hWbvHrHn1uRCDOn7ZCmgZdakImyth7i0+AFcanWKWoK56ZUp7tENFJ0+0K73dJWOG0OdV58FgazYE/Bhz8IYlz5rNsK4GFR1TyIfuozHI4cueEBwYqt9OhAHSS16FDREr974+IFj+GGsRafJAXN2CiCRalOSd5FDejX8SbXz+g3h5ljuFa2zctfJsHuoxhuv8d0xXtNV1wvIacmK1nasXiQbDUuNQ3jXPsVnHn61WQGIm3Wz70ycNb2cagIfMDYaNmXkHkPnBnUb/DBR60xMkBsdfcpmVBK/qsFGEmaWokPQe8CGwYjg57wm91YDtevxHnyMQZsjSAPfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(9686003)(53546011)(71200400001)(7696005)(6506007)(122000001)(38100700002)(33656002)(38070700005)(26005)(2906002)(7416002)(966005)(55016003)(478600001)(83380400001)(52536014)(5660300002)(8936002)(8676002)(4326008)(66446008)(64756008)(76116006)(66946007)(66556008)(66476007)(110136005)(316002)(41300700001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ditlUis4MmlrZGQrL3c3czRiN1VXdGdES21vbm1aZWhTdUtPOHpsbkYyNXJq?=
 =?utf-8?B?NzFtK3d6aGZSM0I4em1RUW5aSkNXZFpmaFBOYkdLenJzUS9tWWsydjNIYnJl?=
 =?utf-8?B?MGJHUExoT2Qzb0VrU29nM1VETHVOSGlCNEV6Ull0TVpPN1FmN1I0cEhSZjNT?=
 =?utf-8?B?MnhCbFpuTjRDU2Z5UkNIWHh4cTY1MENOci9GNWFJbFRubCtGemY2cDBqTHgv?=
 =?utf-8?B?aExLMmtLdVpLVXdNWkQzdCtUV3FZUitwTCtVem4rRWk5L3lEQytHKzNwUGFU?=
 =?utf-8?B?cUUvdmtqRzVVWXUzU0lpQ3JPU3dRczVoZURRYVEvT0lZajFIYUdTVFA1cWpI?=
 =?utf-8?B?RkRqNUJPQVhEdVZVZ0RuUUNrZXFTSHI2bFNqZ0FhTk5ZZW1LdldqU3VoMGNR?=
 =?utf-8?B?aFhhUXNkWFl1OFlMYlVyM0VkSm9WWlg4RjlYaXdtUXovcm9UMG5oM0xvN0RZ?=
 =?utf-8?B?Y2NkRmhOMUNBSlJBT0lLTERmQTBMUDYydzlSYjhyQnhZRVcycXdyNGtLb2sv?=
 =?utf-8?B?U1E0anhGcEUzWE5qREhEOHpCSmMrUVBlbnJYNmtXSXJqSTJrR0pJL1Zqb3Bv?=
 =?utf-8?B?Y3pDRXdmK2txTFZDTEgxSU5nNkRtQThWZG9Fa3Mwb0hLT0RTcUxTWFI0eUdJ?=
 =?utf-8?B?aGNkaWNHTi9ISXMvRzJ2cU1ZVVVEOEJocU8vbnNPV1pmQkUwY09EUkQwSUdm?=
 =?utf-8?B?eFVCL3dkMlIrU3pVMWJtTW94T3E3Nk4rR0kreTQvQUxJdHZKT0VySzQyS2VD?=
 =?utf-8?B?WlRHcUlEK0NpNjUwbnUwSFdnaVJYT3ZkR094Zk4vSk51eDZ5OTFBeXhsaUFn?=
 =?utf-8?B?S1VPREZPWnJSTi9VWkoyNklteVUyVkdVT1JUVlRtQ1B5eXFITlZQbTJ5bmZ3?=
 =?utf-8?B?d0NpQXJqZEwwb0VHMUhXdjhObGptUm13LytTSkNlK3RPbC8rMnJTMnlIM01h?=
 =?utf-8?B?bW1LeUZILzZnUURnT29vZjVVNU1iUUZ0Vkx1ZHJBbm9EWjVOVkxTOHVQbW1E?=
 =?utf-8?B?QUtHZHhJRk0rVUxSRnpxVHdEdm1vNmYwQWZPMS81MTFFRDFDVUdBVUVhdXRL?=
 =?utf-8?B?UWVBNEIrNVA1OFVpNGFRRFh6WFprLzRCZmtGbzZ6dnhNcmgwM2ZTVFltbkZj?=
 =?utf-8?B?aHByc3F2M2JNRHdLcTF1b2UxL1kyV2NzcWNCTkZYZE9lWUQxMURuRDF0K2dl?=
 =?utf-8?B?RWFGZnU2a2NaTi9JSU42T3h4N1JXWHdjSk1vZ1lIYkVZNFdUM0J1N3NEamJw?=
 =?utf-8?B?ZnhyZFI0K01peE1DMjFlcTVVR1lSY2xrSncyby83a0FZSFV1S3NHSUg5elFh?=
 =?utf-8?B?d2N1TnBQWmQ2TUZZZWdnaUY0OHNPcVRhV3Z5NEJrcExUeHFyQzJiN2c5bnRF?=
 =?utf-8?B?ZXBSMDN4V1ZUSW9IelZjRHJ6VXZwTkQzVkpwcmxGL2pqZ1pMeVkwTTFjMGEv?=
 =?utf-8?B?eWdONldvdTVoTWlSbDBGalBsTVhlUStIK2NvWWVUOWV5LzByZWxROXFlRU41?=
 =?utf-8?B?RjhrRnl2OHF3VC9LcGNJeGdrMWlBV0pvTTFCVm5kOGlSMTJaL1RPQy9EOUpM?=
 =?utf-8?B?dlhob1dmUjErRTN2dVZ1cC9FZWQ1bnVXWUxacWZqaE03VnNBQnFUVW9XQTd2?=
 =?utf-8?B?UEdMa3IwYS9FVWYzbWlFZGRkUHhpbWdmMkIxMWd3WjkydXFPcGx6SGJYUWRC?=
 =?utf-8?B?RXNFc0ZZTUVYbkE0ekQwSW1Mc2FtaGU3S3p1YlEzZE5CWFFycHppMWt0NjRs?=
 =?utf-8?B?ZTJJY3dWWUNNNndDajVSU2R2VGVqcDFzWXh6eFR0akdZY1BiUmgxVEtTWkVx?=
 =?utf-8?B?QWJyV0VqdnZVUm4zTmg0Z3FGeGc1dXNBNjRVeWdodHZ1RzlyT1JMbStJcDdZ?=
 =?utf-8?B?aWcvNmNqVU81MlpjK2J2ZDJVTjd0ZUdSR3pTUmdWZVBMSnkxVW80eDM1ZTJs?=
 =?utf-8?B?WXEvTXpGV1lHN01GTFlJRE9QbW1TRWd2Z0s0aFhKKzFEYlBaUzB4cTN4VWxq?=
 =?utf-8?B?aTViNVUrRThnR1RZWTladDJBbHhRYkE0SG1wMjVEY0FBNjFoZTBuMWVETjBO?=
 =?utf-8?B?emYydDlLNXBwQVpKZmJEUGhSVE1NWEpUVnRaMkNDUlRoeVNGUlVPL2t6Q0ND?=
 =?utf-8?Q?i92w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00CC1F2AA7956740A60E249129235616@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4543bfa8-2cf3-4d89-da03-08dbb9b22a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 08:18:27.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnJ9wCCnqfEFnZPmVojABFflnuHWux3N/FInvdPIVSFqYDNzj4e7j9fis4HViFiSYKi/CWdqsRyxU1igGqTn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMjMvOS8yMCAxNTo1NiwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiBIaSBKaXF1aWFu
LA0KPiANCj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IFNl
bnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6MjQgUE0NCj4+DQo+PiBIaSBMaW5n
c2hhbiwNCj4+IFBsZWFzZSByZXBseSB0byB5b3VyIG93biBlbWFpbCB0aHJlYWQsIGJlbG93IGFy
ZSBub3QgcmVsYXRlZCB0byBteSBwYXRjaGVzLg0KPj4gVGhhbmtzIGEgbG90Lg0KPiANCj4gVGhl
eSBhcmUgcmVsYXRlZCB0byB5b3VyIHBhdGNoLg0KPiAgQm90aCB0aGUgcGF0Y2hlcyBoYXZlIG92
ZXJsYXBwaW5nIGZ1bmN0aW9uYWxpdGllcy4NCkJ1dCBMaW5nc2hhbidzIHBhdGNoIGlzIG5vdCBt
ZWV0IG15IG5lZWQuIEl0IGNsZWFycyB0aGUgU1VTUEVORCBiaXQgZHVyaW5nIHJlc2V0Lg0KDQo+
IA0KPiBZb3UgcHJvYmFibHkgbWlzc2VkIG15IHByZXZpb3VzIHJlc3BvbnNlIGV4cGxhaW5pbmcg
dGhlIHNhbWUgYXQgWzFdLg0KPiANCj4gWzFdIGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcv
YXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA5L21zZzAwMjU1Lmh0bWwNClllcywgSSBkaWRu
J3QgcmVjZWl2ZSB0aGlzIHJlc3BvbnNlLiANCkFmdGVyIHJlYWRpbmcgeW91ciByZXNwb25zZXMs
IEkgdGhpbmsgeW91ciBjb25jZXJucyBhcmUgYmVsb3c6DQo+IFRoZSBwb2ludCBpcyB3aGVuIGRy
aXZlciB0ZWxscyB0byBmcmVlemUsIGl0IGlzIGZyZWV6ZSBjb21tYW5kIGFuZCBub3QgcmVzZXQu
DQo+IFNvIHJlc3VtZSgpIHNob3VsZCBub3QgaW52b2tlIGRldmljZV9yZXNldCgpIHdoZW4gRlJF
RVpFK1JFU1VNRSBzdXBwb3J0ZWQuDQpUaGUgbW9kaWZpY2F0aW9ucyBpbiBteSBRZW11IGFuZCBr
ZXJuZWwgcGF0Y2hlcywgSSBqdXN0IHNldCBmcmVlemVfbW9kZSB0byBiZSBTMywgYW5kIHRoZW4g
d2hlbiBndWVzdCByZXN1bWUgSSBjYW4gY2hhbmdlIHRoZSByZXNldCBiZWhhdmlvciBhY2NvcmRp
bmcgdGhlIFMzIG1vZGUsIHNlZSBiZWxvdyBjYWxsc3RhY2s6DQpwY2lfcG1fcmVzdW1lDQoJdmly
dGlvX3BjaV9yZXN0b3JlDQoJCXZpcnRpb19kZXZpY2VfcmVzdG9yZQ0KCQkJdmlydGlvX3Jlc2V0
X2RldmljZShzZXQgMCB0aGUgZGV2aWNlIHN0YXR1cyBhbmQgdGhlbiBjYWxsIHZpcnRpb19yZXNl
dCB0byByZXNldCBkZXZpY2UpDQoJCQlkcnYtPnJlc3RvcmUodmlydGlvX2dwdV9yZXN0b3JlKQ0K
U28sIHJlc2V0IHdpbGwgYmUgZG9uZSBkdXJpbmcgdGhlIHJlc3RvcmUgcHJvY2VzcyhyZXN1bWUg
aW52b2tlIHRoZSByZXNldCksIGFuZCBJIHdhbnQgdG8gYWZmZWN0IHRoZSByZXNldCBiZWhhdmlv
ciBkdXJpbmcgdGhlIHJlc3RvcmUgcHJvY2Vzcy4NCg0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpKaXFpYW4gQ2hlbi4NCg==
