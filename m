Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376887A7385
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjITG67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjITG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:58:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB192
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+J/7BSueoxz7xBbAeHFruTb8UziQrCkUP6ECctNTngibzPkNOu+P63y28cS2dVPdyI/aY1tWIHZMIqUj3cV0oXkxs8gekRzS4hv74pdPOZx1R7xJcN8Pe8q4loTjPjYjNaTC1MgIntxiHCzxhCJV0xyd8nEhhxzl67PoEwIA08nAXo62UReE/LLnxDBnoo+TCiY4Uprwj1KEm9S/Y0q1rAXnjytg7vjJr8abJ6UQdqYW32JuQrKjgFwZQjnoKY6/wzpHgW+uG/+DeS4/FNQGBk+9PitZPvRkTRRHP/QkVoPpAlhZp2y1/J8QXMI/xFxx7N1P3C/y3+FhVqDZWsjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mE/3z+Mq9PbDdaepdK5QloSQwmKh+qPD25ipnqCaMc=;
 b=lIK3s8bThJVZcBkravAMimPksgkYLJDqqHbtKaKWCunEk2o8IbMoh4iSkOCBCZJVIDkgnXbtm3qF2RpscopfMVhPif+5KbF63s7KK9eswibFDiHPl2Ejx+ywhhh7bArOAwia2n+bcvwC7eZ7Fdoad6k+Q4+R9P7X5C9IQCCeZRJhhDE3aqA3+wWamyiphMKllTW3mu1dSMsAfj0V0oelazMW3f7mliIcWKhuwaMfLD2blfbGOEEWUYOaywO/dUQqHMGW3Wn1SAHc/S0KRe7JvmVdEpIKKRybrV5rvtbbHzOVvMJZwZ8fT2dNzbnHmJ87KJusiY2be+V8/W7U+WzfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mE/3z+Mq9PbDdaepdK5QloSQwmKh+qPD25ipnqCaMc=;
 b=RS6IyuqcNoABtA5Vd2stkdwsdd+2CklYUmgi5Qze7r1tw/Ir5X/v0lzp4Zr4IMoYdInZOpzeys5HRd+IrGkhel0lHndde6Q3gbSX6E9h5UY6VNPEdAUA9Yzpg3hAFzSpp+xrS2H6Ju+XwPpIOf7PRXWtRvYEy6zBz74p8+pLe6/qayMJD3oc8nVusL0olerQgdTuXxXnm7QRl7qdIhreICg0Exob3JuEpXy4wLv1+M3SdpVYqE2V4hlbvFnluZ4tEJaxJ2yuh1YGsUpAzilpplm9TEiBPVX/ZICeq2xRUAfsCQ3FZNI314B+0/yNbKnMyS5NuhtQqkpP1edvylSWnA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 06:58:47 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:58:47 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>,
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
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWA
Date:   Wed, 20 Sep 2023 06:58:47 +0000
Message-ID: <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7625:EE_
x-ms-office365-filtering-correlation-id: a2903922-46a4-46a8-dfa2-08dbb9a70972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6V/J7edUj0nhoU+R/z7I+Ikla12yF41RlC1hKtKtBMikOe2gKqJC/+rzIMPQNvj+eyylfsfN3bbecxTWbB2TLLmAx5rBxoV0aakMjCeMxTp2UFcsu+My5N6zYWiJNzm+G+IKZQbnz+camHsonpLJ2D0n/pRd2RPL6x/VbYIvQEaT78b0MEScvYT2R/5Z++y1BPAHHEliqdfRCVqztq8e4zgBEk7c59fFabx7Y2ZG4MS2sC51dtwpcqDowh36jLamI6OcWAoXJQCx9ajw/HsWckQ+kv7PJDj/vAVYtmEEK15jiEiOxgRQXbSJJIiSbmND24EoOO5V/ockV5186okCv5XSqyddS7/4ypGrvpoSWVxhZEUAo7eDOYTMx7gHtanZGcfzDpc0pOPfRzbUS3/gFKEeH+EFtBPmtYiAirTWE+A7juAQCqp0Pxb4RysZCIocPgJeRbPUGxMRjd6iEWiF/9XcNJaLhuQZeTgEYdN6RrF9b131htEXere8IblYmRPCEjHPUYUJI9E7zgf1UXl5zaV3HOWgPaIC8zCzqAKLJTaNQMbTzFuExufR0DcJkMZaOEPUVESHFNYFOqb2215yz/WxlKOh28MpIShgvmcn+o4akjfqH/3pgYLXU7A6nMX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(1800799009)(186009)(451199024)(478600001)(83380400001)(7696005)(6506007)(9686003)(54906003)(8936002)(71200400001)(26005)(5660300002)(8676002)(2906002)(66946007)(64756008)(316002)(7416002)(76116006)(66476007)(66556008)(66446008)(4326008)(52536014)(41300700001)(110136005)(33656002)(55016003)(38070700005)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdGUXM2RFY0dFlVK3ZhM0FKTWZBRW04QTlTUlFLVGZ4bGVlOEh4MTI5U1RC?=
 =?utf-8?B?TmIvY3dUbFNiVFdpcXpTSzFwa1J2Uk96Sm1nR2lvRTZJRnlJMzdJVlVldVV6?=
 =?utf-8?B?dWJXdGYzaXBkZlBCQTAzVG1qY2luaEhFZ09melNLa1JEVmFqNEdFdHN2UXha?=
 =?utf-8?B?cWxJUFlaeXMwOVMzc0UzQnNhQVRpeGZYUTQxZkpsY0hhZHlOZi9yWHdtMjlq?=
 =?utf-8?B?Q2xlZTRzazljUzZCT2dYOWxqcUJGUFU0eEVmYzJ2TnNrcUwzUmgzOHFZeXZL?=
 =?utf-8?B?TEJjdjlzQTZCVHFSQ254T2U4clVIUjN1SWRmZVZPVHQ0b1EvQXVMVGFrS2hH?=
 =?utf-8?B?VXlBSzdvNEpvSlF2WVB4ZDBvK0FKb1VNYy9nMHFzdTFHdm5ZSTdaKzRtRzBH?=
 =?utf-8?B?cEczUEMyOHVCaTlweU9mSllLQ0FsQTRmSndiemx3aitqTi9vb1AxeWdmcEN6?=
 =?utf-8?B?WlFvclFpa0pNdVFESVIzQU5wWlhTdkNBa2pMWCtnc0MrM0U1QXNDMjVEUkdJ?=
 =?utf-8?B?NkNCWGNuVVVnMmVnRVpOVjlQZSs0M0pVUkp4ZDB1VGpydTYzajRmRWlIUFZH?=
 =?utf-8?B?ZHNqQU02d1ZQWWJJd3Q2azZ4OStjUVJYT2xMV2FVd3dUMHN5WE1GUFJKRFN3?=
 =?utf-8?B?eW1NbDdOUGZhRnBYSXlBVEtVY1dFYk5acWJSSFlSZGwyMnliVzBpQTV6ZDMz?=
 =?utf-8?B?cXJCemNVVEltaS92YW5BRFZMR2o2Ym5LanhuZ2o0TE9TSHpyRlA2bVVEeFJX?=
 =?utf-8?B?YktLY1F2eTZFWUtHSDl5VUlmbm5mMldtZVJNSmJ4LzNQTDFMM2x5UnN6Nytr?=
 =?utf-8?B?RmFwditmdXkzd3l6WFhjNkJsNzRzYlMycFNqandLcXE1Wi9XMlJ2aHZsQUFj?=
 =?utf-8?B?VUpBS1BqRHVGRVJ1NkVOTEJtdlAvSE5uMGtoSnNzbGowOFM4Rk9pdVF1VDlB?=
 =?utf-8?B?UWpoU2xhcFpxdlI4ZVdkN1ptSGJrb3lkSTJMSXFYM2FLZ2pNcHkvbmZvZWky?=
 =?utf-8?B?RVFBU0NucTFPZURLQ2tiV29lVjV5NDZocmtRUFJIS3htbEswd2J4Z0tmc3Na?=
 =?utf-8?B?WXZsWXBKZ2tBWlJIRmNXeXVaV1loVUQ4ZWJuSWxvcnlHWE8zOTZMOWZnZ0xM?=
 =?utf-8?B?eElrSTZDNWdJNVBYZ3Q5YUNEWFJhL3dmZUZmcGlXbUNxQkMrdW5zYm9XdEh1?=
 =?utf-8?B?YVBTbGFLSHpFdytNdHVOY1ZXbjdySE9WNFNuNHVmUVlqcWJ0cFNDY2RaVDl0?=
 =?utf-8?B?WjRRL1hPUmc0QmUxRmV0RytSbVA2S3VFMFEwdXZUczZrL2ljekU5ZHRTY3pv?=
 =?utf-8?B?MlVQbytzZDUzbGFxYjJOT0QwUm9kbzU2dVR4RTMwOUIwZXVJMU52eWxCbWZl?=
 =?utf-8?B?dVVIeWljcUtwWW5saVJPU25jL2hLd0crVDJRc0N6QkxWRkYyTVA2N2Y5cjV1?=
 =?utf-8?B?bU90M3gwOU91VVVqVE0rTnZFMmRaNUJlWW9YaDRLejFzSk1EYml5REZPczRr?=
 =?utf-8?B?THNHcGt1RGxCUzFnTTBZZWNlcmg0YklXeHBTRERJQ3gxU3JpU0EvVXhGNDZ1?=
 =?utf-8?B?WGg3anNKVmdXVlBuaWVvd0kvTTRZS0diUWZrREdRakx3UlpvR1FBV3RvbHdr?=
 =?utf-8?B?RTA0TWZmeG8yYjhXS2pPRnhNdlJXdktDZ3ZYaVppMEZpZTR6UnlnZXJ3azBC?=
 =?utf-8?B?U2JERFd2NUE5a0ZIU0xJc0htdWhYaHBKQ3A5YlNDaWFiOUMwb0hXUCtRQlhp?=
 =?utf-8?B?NzJxOFU2dmRKeWpJMk9KNGVlOHh2T1dodHlsZ3kwb1FycTF3WEw0L0lveFJY?=
 =?utf-8?B?ZlhFVjdIM0FKaWcxOUVkcGtoc3FtdUdIcTRNRnlvOU5Jano3dkNSbWhYb1ZJ?=
 =?utf-8?B?cm54ODNQeEdHbEMwa2Jwa2RQckszYVN2TXJKMEZLazVKQkcrMi9ZV1liMWVM?=
 =?utf-8?B?N1BvSzJFNEpPOFdLZk8vNk9uWHNraTlab2ZjYjdqYlA0UmptdDhoek9RSTZS?=
 =?utf-8?B?RzNIV3E0NFQxVnd5NmVNUmNrRnBHek9nYm54YVp0SkV5amRySzJaa3dJKzJn?=
 =?utf-8?B?NSt6VCtNRE9nOTR0VzVPU1BNTHpOd1RHSU1teWRuRHdoeDY5b2tOZCtxcnZv?=
 =?utf-8?Q?p90s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2903922-46a4-46a8-dfa2-08dbb9a70972
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:58:47.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IlnbPPPDMmxSpbvCQJDmKLckToltyr+cJn8I17KWmpmVOM1Qr4jebYvPRUPFvAtkNU6b9Y59AFXwhj8RD6v4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMjMgMTI6MDMgUE0NCg0KPiBJZiBkcml2ZXIgd3JpdGUg
MCB0byByZXNldCBkZXZpY2UsIGNhbiB0aGUgU1VTUEVORCBiaXQgYmUgY2xlYXJlZD8NCkl0IG11
c3QgYXMgcmVzZXQgb3BlcmF0aW9uLCByZXNldHMgZXZlcnl0aGluZyBlbHNlIGFuZCBzbyB0aGUg
c3VzcGVuZCB0b28uDQoNCj4gKHBjaV9wbV9yZXN1bWUtPnZpcnRpb19wY2lfcmVzdG9yZS0+dmly
dGlvX2RldmljZV9yZXN0b3JlLQ0KPiA+dmlydGlvX3Jlc2V0X2RldmljZSkNCj4gSWYgU1VTUEVO
RCBpcyBjbGVhcmVkLCB0aGVuIGR1cmluZyB0aGUgcmVzZXQgcHJvY2VzcyBpbiBRZW11LCBJIGNh
bid0IGp1ZGdlIGlmDQo+IHRoZSByZXNldCByZXF1ZXN0IGlzIGZyb20gZ3Vlc3QgcmVzdG9yZSBw
cm9jZXNzIG9yIG5vdCwgYW5kIHRoZW4gSSBjYW4ndCBjaGFuZ2UNCj4gdGhlIHJlc2V0IGJlaGF2
aW9yLg0KUmVzZXQgc2hvdWxkIG5vdCBiZSBpbmZsdWVuY2VkIGJ5IHN1c3BlbmQuDQpTdXNwZW5k
IHNob3VsZCBkbyB0aGUgd29yayBvZiBzdXNwZW5kIGFuZCByZXNldCB0byBkbyB0aGUgcmVzZXQu
DQoNClRoZSBwcm9ibGVtIHRvIG92ZXJjb21lIGluIFsxXSBpcywgcmVzdW1lIG9wZXJhdGlvbiBu
ZWVkcyB0byBiZSBzeW5jaHJvbm91cyBhcyBpdCBpbnZvbHZlcyBsYXJnZSBwYXJ0IG9mIGNvbnRl
eHQgdG8gcmVzdW1lIGJhY2ssIGFuZCBoZW5jZSBqdXN0IGFzeW5jaHJvbm91c2x5IHNldHRpbmcg
RFJJVkVSX09LIGlzIG5vdCBlbm91Z2guDQpUaGUgc3cgbXVzdCB2ZXJpZnkgYmFjayB0aGF0IGRl
dmljZSBoYXMgcmVzdW1lZCB0aGUgb3BlcmF0aW9uIGFuZCByZWFkeSB0byBhbnN3ZXIgcmVxdWVz
dHMuDQoNClRoaXMgaXMgc2xpZ2h0bHkgZGlmZmVyZW50IGZsb3cgdGhhbiBzZXR0aW5nIHRoZSBE
UklWRVJfT0sgZm9yIHRoZSBmaXJzdCB0aW1lIGRldmljZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5j
ZSBhcyBpdCBkb2VzIG5vdCBpbnZvbHZlIGxhcmdlIHJlc3RvcmF0aW9uLg0KDQpTbywgdG8gbWVy
Z2UgdHdvIGlkZWFzLCBpbnN0ZWFkIG9mIGRvaW5nIERSSVZFUl9PSyB0byByZXN1bWUsIHRoZSBk
cml2ZXIgc2hvdWxkIGNsZWFyIHRoZSBTVVNQRU5EIGJpdCBhbmQgdmVyaWZ5IHRoYXQgaXQgaXMg
b3V0IG9mIFNVU1BFTkQuDQoNCkJlY2F1c2UgZHJpdmVyIGlzIHN0aWxsIGluIF9PS18gZHJpdmlu
ZyB0aGUgZGV2aWNlIGZsaXBwaW5nIHRoZSBTVVNQRU5EIGJpdC4NCg==
