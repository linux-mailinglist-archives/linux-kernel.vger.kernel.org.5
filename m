Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01347A742B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjITHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjITHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:32:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273079E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9V8LLIgljPYe6WVM7PNQ55KLlPQxT+UnaaISsG0K01h4HC0GFqZQhS+XEvoLknEP7q6ZRJS0yu5vmvMBHI9y4aYvuhFp1Kr2tzU+9JwgHHW3eMSbpX9tU8vYWKd6NI7Sv8vxxDrlJ6ve4omvUoogn5lpeA1vq4a7n1OofUwayfkVJtrHqf4LqeS4xCMOGjeWDGUvQ2KVNj6aJbriwV3b1nhlGauI71L+W02F2UayuaogY0U8/tGcny/1J9Sq+TBBR8IV/DtqZ99BnnoKuJ58vjbYsGOBofW2WQvgopms7sB6NwmCjKdNBMrEBbZ/67EkpccuTr5CUFIZ/jbRKYzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9NAfJNUmY1B2e97VtEkvkwuj8h7RujqNQfQLT0zlVs=;
 b=csakU0FS7fLL1Pw+71/+1cRIiy7MFlleNNawK3Os1xLlxXi6bvc9nZ4KjeF6NF6IHkwM6+u0vsejNZzk/7eHI4bYTR3Qa3nTLwWfbuUd5w587nbDvcpVVYzcmeYlzapIVhA0ADhwBzmsjHPkzFt8+nUL8a1/MK8udapocWAHCD+S65IXdyughSnNhp5ywK2oXILNL/6HTtE+uE6KMs60wqa0nXpaauHZrxuqRYMQDv6l65zGmxZ+WeMdzQqNLF5Tgc4yvrmL9wI/fXYW68tmhFOLjjVmcVQnzEWWg8H89XVQmtwiNyvZABXzn9TZOu/G8udXt4gWIIGCb4Ylv8TuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9NAfJNUmY1B2e97VtEkvkwuj8h7RujqNQfQLT0zlVs=;
 b=drawm5Geq3jmaPMbgwVUE5/7ZdYGTavnKAs24sJVojVCdC/yXuKB4+HggC8md937sQDh15KaR2rE3yyWzQN7sP2XKVTS4CV338vXSwFA1GyP9efngzNrwOl2SPkoU4vO4TUO1feFquse6e/asyFx5gxlI7+QKiBbCputfgHsm5AXaJtqxbv1Av5f878CQD7+SF82lSw0bsaHnZtHDCIlNVgb/sy6RKimvSGIlsjyQaCOBkZMYzMrHz9zEpYE0Kr6lA6INC3wPDR6KZi9X5Ck6OsRQakih2m9a80+Xm+BELof1CHfatl5qToV8RACkELZ/xsQsGqttz5WHVo/ObOrTg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:32:09 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:32:09 +0000
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
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAABRIIAABYkAgAAAuWA=
Date:   Wed, 20 Sep 2023 07:32:09 +0000
Message-ID: <PH0PR12MB548118296F71CBD9158963B0DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <91c3e7ec-d702-ee61-c420-59ddc8dac6dc@intel.com>
In-Reply-To: <91c3e7ec-d702-ee61-c420-59ddc8dac6dc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: a6acc696-fc8f-4238-41ca-08dbb9abb305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVwpcH3X8XYLwckTvW1uMzJF0MXEA62eNzzXZ02nzgBu6TPxCuv5OT+Kca3PAKah0F24EPCYZNIupdjOubth+72REO2XsePSO+LYnM0wjB4czSrTQxHqPFfq3d5ZaqWfEVcfttEPXokJGMSNFyfFX6QRO+2KEWERhlNyP+FHMmzLFNvfs+gh2F88qgJYtIHcZ+PEjVvB8f/t/tn3pMS057/Jva0ToG2AEvRxr5AXFwEfAKYjB5DpLKiZ7h2vfqCV3mb5tylSt0O/vD4+rdRlGsWsul6szYTJooMGSw97gUMhsjrl8ieaEffR0i1xr0wQZDaMWGRB3lMMbd50f4BFKkhwnghCq4ru/DLhOw1Zia6M/zkuSWTvd2zr4Y+BECMZpzp+CZICNe5yhGLX3VlHvrNOAg46EkuQydKbCOwisjlS6Fhc+KFQNzQ1v7h0LudWwtlGBDKAF77UhYRtnZEPMra1eSQrFvtYvnEJjuc7rkM6AjwlkQbwHI6m/w2lq7FWR9YMyuy0M4YD+BwO59R2uZNR5K8FbZxv89zm9IvWq2bNqO2pM5t1PDnHf9OoVGpjxpufFaVzmCXBx4KFvbJjob94EJyHJX/NRSThqcGoXA8Ldo4tZqPqWkFnaJT0PAky
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(38100700002)(55016003)(38070700005)(6506007)(7696005)(53546011)(71200400001)(478600001)(33656002)(86362001)(122000001)(2906002)(26005)(9686003)(83380400001)(64756008)(5660300002)(41300700001)(52536014)(4326008)(8676002)(110136005)(7416002)(66556008)(8936002)(66946007)(316002)(54906003)(66446008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFRZQWZnaTFyUnJZbW9BZGs2ZlNLQm9ISjBtN1EvSWM4a3hCeUVJVkdBam4y?=
 =?utf-8?B?aDcrQ1djNEdMRUdkc3JUSWVlbGlLdVFUbk9PcW04TDMybzRwQTZzUHFaRlFv?=
 =?utf-8?B?K0VzS3ZQa1Exc0dTNXBlYUtaNHQ4ZXp5QmFDdUM1UGtTMjl0NGNCa2ZYRVh3?=
 =?utf-8?B?SnlWMFk3cjVKUDNGREVLa0grMmljWXBzVEZ2dnFTN3g5R3RJZ1kvR3ZhK2hk?=
 =?utf-8?B?b1BZc1IrL2hadnZqS1k5c1N5QWdWL1RrcjFVUDI5N2c4b2JJSXVudGJiNHB4?=
 =?utf-8?B?RWVPSVo1QUZkZ2dRNVlqbFMyUWk0NWhZdllLU2c5SEVwK3lTdktMaTNxNnI2?=
 =?utf-8?B?SGxIOW9LS29YaWwwZmlNWithZGxNYWMrMTBoT09TdDhJdWcrZWpSUkJyeXVr?=
 =?utf-8?B?a0JwSTM5YjVyK3NUSnVSSTNWeU1pckZTZE9MM2c5aENCeWZ4bkpjVU9JTmhK?=
 =?utf-8?B?enNSaWdwckVqS2QxV2JJVEo4angyWjZ0czlmSlFyN2t1bVB4NVRWN1FPK0k1?=
 =?utf-8?B?UFhZNmRlZWlCT1pYRE95cDV3anhOeVpzTklsMVZYVzFTbEgwenRhMFVjMmRY?=
 =?utf-8?B?SnNwS3BPZ1VobW9tVWlyMUNpR21UOWhUYWNJdHA4S1c5RlZUVU4vcnBHYnY3?=
 =?utf-8?B?b0ZKcEtKQXhQQms1S0dYUjB1NE1LbFpCRExzVEJUd3dyeFFMZGlvbFdlK3FY?=
 =?utf-8?B?RXBMNFZpUUpJYUlYVHI5MTZHWmVNcnJ2U2I2RXlaemVKUzhMYkdQRjhMRnJH?=
 =?utf-8?B?NXI2RnZncENVWTdhZkxRNEJzTldQWjVmVEdGTi90YysvWXYwUDFkU0k0QWds?=
 =?utf-8?B?TnRmQ1gzUTNkdkMyV3JpcHBsWm1NdzF5RDVLRXNoWTVCTEJvNHJMbnFTR2h3?=
 =?utf-8?B?eGRFWG1La2lqN1l2RHRBbytZakN0NWRacHJDVCt6MFY4NEE5U0J5aWc2UVd6?=
 =?utf-8?B?d3dDaGVLRW1zTmJUd21PM1NOL0Z6R3VsK2xUblFXdFkwdFI2UTBHK3NnV1FO?=
 =?utf-8?B?Vy9rSnlIdWRZOFgzaTRFcEpzL0txbFBuRDBXcGF0ZlVodXJtdVE5c09wNjY5?=
 =?utf-8?B?dEpzOFJvbXpBaWdmemtkU3NVWWtDM1Y5dFlaTEtlSFFaRG92bmRKbTdCekNC?=
 =?utf-8?B?WTk2K1Jvb2ViT2lkaXlEZkpobURNUGptTW1BVzgrQWwyU1VQU3dwdUxJWGJq?=
 =?utf-8?B?Wi82aGtqQXNldFZPY3lOZ0RaQ0x6T2crK3NrRngreHRCWFB1MDl2ZzNDMkVw?=
 =?utf-8?B?OUFCRHoxMXJhSGQydUVBTnk0VHVjVFlCbG9kbW9nN1p6NkJFRHNFdHM1ZXRF?=
 =?utf-8?B?SnhveTlLNmRDMUEwd0FCT01ZdWJkUEIxSFZnNGVGYW1vYlkweEJYWS9HcWkv?=
 =?utf-8?B?WllrMDA4aE5vVGZPRWkzWG9Rd3lPMnk1RG95YXVDaFpqeGl4cGxrMjdEOVdk?=
 =?utf-8?B?THQ0RFJPUFQvVldKbmd0NG1IWHdGM1lYZTZERHcrYXhJbmI1K2tCb1hLTU9L?=
 =?utf-8?B?NTZZRzI0Z1M0ZU91Z0JsSm1FM3ZTS09aN3ZGbFhOUHd5RU1OQXIvUm5aR0hZ?=
 =?utf-8?B?ZVQ1ZEhVMGxKOGVBTnljY0xzZi9jSlZuRGNwUURLazlFQ0src3dNTGRISCtP?=
 =?utf-8?B?QVNESmZZd1ZxajgxSitFQWxCRE1pU3ZFMXFyUC9xaG5yQW5oeXcxU1J2NnE0?=
 =?utf-8?B?WnlzQTdGanhMN0o0WHJ6MEU1VGNENlNEeXVLU0NUN0NScDAxL2R2NnRudndB?=
 =?utf-8?B?QnVtaS8xMDF5bDZQYUJsemRxYjhvdnY2QjF0Zjl6MlowR1RTcDBEM0htbFc1?=
 =?utf-8?B?VjlYWFZwQktSQWtPd0YwUmRaLzY2dDd4Nk81Z0JlSWU0TjdVT0JnYmNvL1RL?=
 =?utf-8?B?alRHOVJvc2lPcy8rdFUxL1U4VHhYdC9CcVozdXBxM0RGTHBiOHdKK0M0TkNU?=
 =?utf-8?B?Y0FzdFBKMGVES05UcTZ3L0kvakpVMUxiOVlkcDl2V1hkTXlKVkVtSktxWUZ5?=
 =?utf-8?B?R1ZraFdoakRGZW9NSS82TXdKMjhNVkpETjJBcml0eWNNeUtBdVExRFQwR0Rw?=
 =?utf-8?B?WnFVTGNPc2VXKzc0U3NEZlBTUDEvRGpvazZ1aTFlVnltaWt0S0dITURqdzB2?=
 =?utf-8?Q?+nUM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6acc696-fc8f-4238-41ca-08dbb9abb305
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:32:09.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7JpdoS3vPKbLaDsJr0Udh6jH08ufZuEkIWZ1e8RRf/CfY2CIUkVCpvxryv1KZr3pBSF0bvlNEl5bYvVW032gw==
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

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMjMgMTI6NTggUE0NCj4gDQo+IE9uIDkvMjAv
MjAyMyAzOjEwIFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFpodSwgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDIwLCAyMDIzIDEyOjM3IFBNDQo+ID4+PiBUaGUgcHJvYmxlbSB0byBvdmVyY29tZSBpbiBb
MV0gaXMsIHJlc3VtZSBvcGVyYXRpb24gbmVlZHMgdG8gYmUNCj4gPj4+IHN5bmNocm9ub3VzDQo+
ID4+IGFzIGl0IGludm9sdmVzIGxhcmdlIHBhcnQgb2YgY29udGV4dCB0byByZXN1bWUgYmFjaywg
YW5kIGhlbmNlIGp1c3QNCj4gPj4gYXN5bmNocm9ub3VzbHkgc2V0dGluZyBEUklWRVJfT0sgaXMg
bm90IGVub3VnaC4NCj4gPj4+IFRoZSBzdyBtdXN0IHZlcmlmeSBiYWNrIHRoYXQgZGV2aWNlIGhh
cyByZXN1bWVkIHRoZSBvcGVyYXRpb24gYW5kDQo+ID4+PiByZWFkeSB0bw0KPiA+PiBhbnN3ZXIg
cmVxdWVzdHMuDQo+ID4+IHRoaXMgaXMgbm90IGxpdmUgbWlncmF0aW9uLCBhbGwgZGV2aWNlIHN0
YXR1cyBhbmQgb3RoZXIgaW5mb3JtYXRpb24NCj4gPj4gc3RpbGwgc3RheSBpbiB0aGUgZGV2aWNl
LCBubyBuZWVkIHRvICJyZXN1bWUiIGNvbnRleHQsIGp1c3QgcmVzdW1lIHJ1bm5pbmcuDQo+ID4+
DQo+ID4gSSBhbSBhd2FyZSB0aGF0IGl0IGlzIG5vdCBsaXZlIG1pZ3JhdGlvbi4gOikNCj4gPg0K
PiA+ICJKdXN0IHJlc3VtaW5nIiBpbnZvbHZlcyBsb3Qgb2YgZGV2aWNlIHNldHVwIHRhc2suIFRo
ZSBkZXZpY2UgaW1wbGVtZW50YXRpb24NCj4gZG9lcyBub3Qga25vdyBmb3IgaG93IGxvbmcgYSBk
ZXZpY2UgaXMgc3VzcGVuZGVkLg0KPiA+IFNvIGZvciBleGFtcGxlLCBhIFZNIGlzIHN1c3BlbmRl
ZCBmb3IgNiBob3VycywgaGVuY2UgdGhlIGRldmljZSBjb250ZXh0DQo+IGNvdWxkIGJlIHNhdmVk
IGluIGEgc2xvdyBkaXNrLg0KPiA+IEhlbmNlLCB3aGVuIHRoZSByZXN1bWUgaXMgZG9uZSwgaXQg
bmVlZHMgdG8gc2V0dXAgdGhpbmdzIGFnYWluIGFuZCBkcml2ZXIgZ290DQo+IHRvIHZlcmlmeSBi
ZWZvcmUgYWNjZXNzaW5nIG1vcmUgZnJvbSB0aGUgZGV2aWNlLg0KPiBUaGUgcmVzdG9yZSBwcm9j
ZWR1cmVzIHNob3VsZCBwZXJmb3JtIGJ5IHRoZSBoeXBlcnZpc29yIGFuZCBkb25lIGJlZm9yZSBz
ZXQNCj4gRFJJVkVSX09LIGFuZCB3YWtlIHVwIHRoZSBndWVzdC4NCldoaWNoIGlzIHRoZSBzaWdu
YWwgdG8gdHJpZ2dlciB0aGUgcmVzdG9yZT8gV2hpY2ggaXMgdGhlIHRyaWdnZXIgaW4gcGh5c2lj
YWwgZGV2aWNlIHdoZW4gdGhlcmUgaXMgbm8gaHlwZXJ2aXNvcj8NCg0KSW4gbXkgdmlldywgc2V0
dGluZyB0aGUgRFJJVkVSX09LIGlzIHRoZSBzaWduYWwgcmVnYXJkbGVzcyBvZiBoeXBlcnZpc29y
IG9yIHBoeXNpY2FsIGRldmljZS4NCkhlbmNlIHRoZSByZS1yZWFkIGlzIG11c3QuDQoNCj4gQW5k
IHRoZSBoeXBlcnZpc29yL2RyaXZlciBuZWVkcyB0byBjaGVjayB0aGUgZGV2aWNlIHN0YXR1cyBi
eSByZS1yZWFkaW5nLg0KPiA+DQo+ID4+IExpa2UgcmVzdW1lIGZyb20gYSBmYWlsZWQgTE0uDQo+
ID4+PiBUaGlzIGlzIHNsaWdodGx5IGRpZmZlcmVudCBmbG93IHRoYW4gc2V0dGluZyB0aGUgRFJJ
VkVSX09LIGZvciB0aGUNCj4gPj4+IGZpcnN0IHRpbWUNCj4gPj4gZGV2aWNlIGluaXRpYWxpemF0
aW9uIHNlcXVlbmNlIGFzIGl0IGRvZXMgbm90IGludm9sdmUgbGFyZ2UgcmVzdG9yYXRpb24uDQo+
ID4+PiBTbywgdG8gbWVyZ2UgdHdvIGlkZWFzLCBpbnN0ZWFkIG9mIGRvaW5nIERSSVZFUl9PSyB0
byByZXN1bWUsIHRoZQ0KPiA+Pj4gZHJpdmVyDQo+ID4+IHNob3VsZCBjbGVhciB0aGUgU1VTUEVO
RCBiaXQgYW5kIHZlcmlmeSB0aGF0IGl0IGlzIG91dCBvZiBTVVNQRU5ELg0KPiA+Pj4gQmVjYXVz
ZSBkcml2ZXIgaXMgc3RpbGwgaW4gX09LXyBkcml2aW5nIHRoZSBkZXZpY2UgZmxpcHBpbmcgdGhl
IFNVU1BFTkQgYml0Lg0KPiA+PiBQbGVhc2UgcmVhZCB0aGUgc3BlYywgaXQgc2F5czoNCj4gPj4g
VGhlIGRyaXZlciBNVVNUIE5PVCBjbGVhciBhIGRldmljZSBzdGF0dXMgYml0DQo+ID4+DQo+ID4g
WWVzLCB0aGlzIGlzIHdoeSBlaXRoZXIgRFJJRVJfT0sgdmFsaWRhdGlvbiBieSB0aGUgZHJpdmVy
IGlzIG5lZWRlZCBvciBKaXFpYW4ncw0KPiBzeW5jaHJvbm91cyBuZXcgcmVnaXN0ZXIuLg0KPiBz
byByZS1yZWFkDQpZZXMuIHJlLXJlYWQgdW50aWwgc2V0LCBUaGFua3MuDQoNCg==
