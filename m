Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9B77653B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHIQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHIQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:40:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26771B2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHsNcIyW+0kaj/5fECYFjHPm1pPFTE2hvBxZoS3d0SvmoG2IolWZiyT4FjnnDmpmCy6am+Ij6+yKHP9MNGZKUEvjJau/Eg4FX/KjUMJkVSLDnT/grJM6zf0wgxOLXVuMCNy5nFeqlWmwLeUawmp/s9tDIf/O2bBJA1tJgoOx11rErPSECbZHA5M/9Dcsh7MKJjNeeDY0d5Kl05P3ij+Yzark3nYL/grhJ4tFZo65W0nDu9N55IJFstGt9X+r0afJf4CYGfE08DBilYdpWgJLzwOfvzczimvhxMpJ8UPFxr8tkW6gLpqQAvgdWrOiihqVILjMVyQhElvjIZUES0jqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjeb7w2pW/AKCeKC5FC/zuNHdDpatCdfa6r3KOSzleQ=;
 b=Ed4e3Vww0zLhunYmbqvyE4taWIknOpIWGTYfWhZGM6VbpN3PZ08Dp6XJU3X17BEHQettvHC3GK0XrzD34qUSvgjw3/qUrrbmi2yQxTDE2Yv8r1jB8YLZYJX69N8s028q+reGb37GYfzhbisefKMty3pEEXkd1VC6a7KFbJnA1OowX5DaCN7Y7hEvjd2RM2khBfhzEJYZVuSTJMO7GvvHVGm6VXI1xAS2ARufMQoIWb8PXN4q4crGxt13QuwK2PefnUl2RDp4p3x6MTWujnP41oiEXUaNcAA1YiKOU2aiBxuz5OTX4RDSZfbpm95CsquQQmEr5eEVIhIXUDU8KND+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjeb7w2pW/AKCeKC5FC/zuNHdDpatCdfa6r3KOSzleQ=;
 b=jwPLM/iXUNJUqwtQkZviKlqtrmUCOcD9QPWotvRUdQ2/kT/upxmoIUItaqLWuj7cOa/M4EIoQMDyr7lYUkRrU1AXhLtLGi4pnuTplpGHpmJWNkI49ApLvLr3KEK/9H9896b3MREjj1YoK9BlyuRykQBAePUxLruUE+zhUkPOSj4lEhR/IzAAgCRH1K7O6vVqm3YefKfx7bhzuy0siFax5IVJW9mDOGglHI99h9Khll6YfwbzeglajVCf/GgJxYIpF4P+x2+tTJbW50R8H3bHRgV6JI2OK3iwHHWeOS06LREmQ/cI1ZRt7P/uayguUJa7HqOUTm2BaGxB/lmp/HnJow==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:40:18 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:40:18 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] mlxbf-bootctl: Support the large icmc write/read
Thread-Topic: [PATCH v2 1/2] mlxbf-bootctl: Support the large icmc write/read
Thread-Index: AQHZyt6l11Zs7VlKe0OO3P69cymxlq/iKokg
Date:   Wed, 9 Aug 2023 16:40:18 +0000
Message-ID: <BN9PR12MB53816DDA2103189C3753FE09AF12A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230809162857.21243-1-asmaa@nvidia.com>
 <20230809162857.21243-2-asmaa@nvidia.com>
In-Reply-To: <20230809162857.21243-2-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|CY5PR12MB6321:EE_
x-ms-office365-filtering-correlation-id: a740a436-57d5-43d4-1a64-08db98f750ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHqu49IZb9+7n0C1re/B9O7PkZSz/5zWQX1KkoqNSWyLgsn/hZKRYQLdwyOVcv/3NhT8iQWeSzrAzN87a07x6qzPVZqUl1d9ExN8jCtR6Z5VFGiOdvVawmOlsC0iNTUXkiZzEF+anUWftXbSclRV0Wtt0Ch0XH12oCjyj4ourRXP9b36p0UEHoVozkAzl3vKQLsA++wbgx44Q4kprfTfuYIhIhVeKDo19fZfqdbrmVKX+9jcVq1X10caNJ2lQqRtw16axKC865359GtCyQWlezW2q2bEdYjuVPWuQ8jhq0HoV7+iaEbY1/GqONrTEC2FZNWfPDmg9P45THjzCjjlrwXUPEboYc5K+P0yw3sgsvMxr4hwkQHe0Ic8FS/I2XaruB8SxzijHK4My07IkUlhsx353zHh499oCandb8PkQ4bSIh3eUmAmyS+Js7W8ySpLV+MbBej5kDDpUwCdyAv1Bb9G9Tu/AfM7/eIgO9/POzQbWIBBYgeoDUeJ+u/C6Q3AvDsr6+/ZRnQ+nA95GxAwJ0Z0lOrSi8EdqLDewfVsm6LN/BH8l4e6uVo7v6Ckooa5uVplZ6FwJ6uk+nvd6jGuR5auWqa7I6QPYnjFpRoSf8xlg74M7M3/HaKS7oVizVQo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(478600001)(122000001)(83380400001)(9686003)(26005)(53546011)(6506007)(55016003)(316002)(64756008)(66556008)(8936002)(41300700001)(66476007)(8676002)(76116006)(2906002)(66946007)(7696005)(71200400001)(33656002)(110136005)(52536014)(38100700002)(38070700005)(86362001)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3Rtb3ZQdUY4bGxkamFQSUlxU1JXK0xTa0gvQk9qbUc4YlM0QVAzVXpRMHph?=
 =?utf-8?B?bWlQSExwVlIzZU9yY0EyaHdSeDZpUEdwWFVhRWhBS3dKWTNMMmIxWWtrRTVO?=
 =?utf-8?B?ZFJxWWJpNGdST2JyU3FKbFJod1ZJU0NIWjdZMS9wcVhtTE4xVmgzVlBIbnUy?=
 =?utf-8?B?OVpFdGM2c1E5ZmUvbWlHempEZ2VJc3U5b2xDWUJrMmxpSlp5aEpaZFF1RHhL?=
 =?utf-8?B?MTZFQTM2WCsyZjE1cFZJZkExbUxkdzJUVTRicWJWanQ3STVlNDFDeEtra08z?=
 =?utf-8?B?L1ZRMlZyRjVMNXJmdVNyMVkybXN2a05CclhaSlBoVndYK0RtMXhFREtCbXBQ?=
 =?utf-8?B?OCtCd2NDQ3hRYzdWNG5rQjVDZDI5U2VIZkZiRFBiK2lMZlBzWC9ab2ZzMVZp?=
 =?utf-8?B?Zk9lWWNjWXN6WWFPbVF0Tm1JTXhtU1pDVmxja1ZTMjhIbTlJWE52YXM4bHpZ?=
 =?utf-8?B?U1E1L0JYTHI4MGhFV3VGcmpLc1Bsc2ZqVk9lbi9sSXJuWTdvWW16Tmpkc1dr?=
 =?utf-8?B?MU5kYW9xVXJSWnIzZ1Y5ZG9oUGtjaVMzWG9rN1RCbENuR09XVjZ1ZjFZNnZy?=
 =?utf-8?B?MVFWcUJtd1gyemRGREQzRW43Z2FKcTIwOHNLNWRrYmhNM2I1RXJGTldTWThJ?=
 =?utf-8?B?Z0JNamlSdWtZekdIS2NDWE50ZnZyVm5NQnRsTklRd3JVaFEvcXNzNG45Vi94?=
 =?utf-8?B?Mm9OQ0dtQk8zQklBRGNmcEVxeHFMZnRHMFhiOWVSUE5aYzlSWkJkSHRRYTVB?=
 =?utf-8?B?Z0xXcm43T0ZjRDF0VE5lakxXMWlUZFZIU0lYWDc4ZFAzMUc4YXlXUUxqNGo3?=
 =?utf-8?B?ck1TTEhNV3hHazVuYUZpYU1jZzVIVzJqZlZuNnFOVzRaVS8vc0F4Ym4zdFZE?=
 =?utf-8?B?TXBoeGQ5TFBXTk15d0tWU1dRc1FPOVJZVERBRVd4cUZvQzhGZXJvbkxHT3JS?=
 =?utf-8?B?V0MwVFJDRTA3dWI4RktrdmZkYWQzUUFIdmI1RWJ2N0VETXlnUmk5Z2tCWDRD?=
 =?utf-8?B?SzVyLzl5R1pTOTZCbC8zRVlKcXlKM0NGc2ZUY1VOWEs5cDltMml0LzFwNjQ2?=
 =?utf-8?B?VDZFWThFQUVXOWF0UTN5S05hNmM4Nk9sQ3dhUEVLcGI5VHBDTlAvSDY2TExT?=
 =?utf-8?B?YkhJY3RDME8zNXlkT1h6c0xHd3J5Tm1aUTM0MkFGaExVdGhGaTYyZlhJbVE0?=
 =?utf-8?B?bmpkNnRTSm4waGEzL1FxNWZMTk92bXNkTGNjNUlMZFp3TU8xUk1iSEQyWkxK?=
 =?utf-8?B?YVpNd3NNcktIR3QzaFVSYXBFMnM4MDhUVi9ZdG9SaHhVS3hCSHJXL3cwZTJq?=
 =?utf-8?B?QllVcjlRQW5YWlhMa2tVUXRoQ2FveEFnaFllVzYvU0NkdWROS0VQM1RzU3gz?=
 =?utf-8?B?Lzg2Wms3bVhvbW9KQkJ4THBkeDQvME11WTdnYUk3TmIzZm5nQnkrS2dSb01y?=
 =?utf-8?B?RkpndUJuNnlIRHNjSUZpVjNjUzNDaXVTdlI3eUpCWFRYZDZJem1jL2RhcVpO?=
 =?utf-8?B?VzJVZ2FtdHBwTDBuTTMrVnpNTTRHSG90NElEdnlvcXdiZWdzUkthemdpRkRr?=
 =?utf-8?B?UHFaWTlvdUxreUtDaW4xRzV6T0pXOHZvSmcyVzZwODgzZ1V1L0lPdmtBZlZp?=
 =?utf-8?B?Ny9jRExMQjJsSEFialB5czJXeXl5ZXdZUE8xRy8wajdIS0Yyb3NkSWpMdkJm?=
 =?utf-8?B?Z1JMeTBJaGRNYU00ZG1wbk1FWXRibTN2Vzlrd2VmMVh2aVF3WGowd004c04w?=
 =?utf-8?B?SjliTWNzZ3pndHRYMENKU1kwR0EzbDVyQWNSNEVhQ3grNy94ZFlERXdGTGNB?=
 =?utf-8?B?dnl3UXpmMW02ZjUwTWRraVU2Ui9JMVMxZ3c4Z2FFTStBNzZCeGRvOXo5THUz?=
 =?utf-8?B?QXdFR2hSWlFpQ2hPMzFhOVpJMS9hbk5mTkRDeGlCQkNFNmkvSHVma1RtRnlv?=
 =?utf-8?B?cExvUXNxVlFaT3hWWXZsSEZVK1Y4YVRvYm11N2pBeFNxODNraWtGTFhVUVhM?=
 =?utf-8?B?dWg3MjN3WFFtUUM2QW8vd2c2Nk1DOG5CUUJMWXpzK3l1dEZXRGR5azBKQkYy?=
 =?utf-8?B?OXQxQi9jTGlMb2tic1dKSU5lUE44UDArY1JMZ1JoZE1LUVRFZHJKSU45SUxQ?=
 =?utf-8?Q?/0wc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a740a436-57d5-43d4-1a64-08db98f750ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 16:40:18.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctD2+4+zi46G604z7ncTDlEoLwsz/+K+CJXavUJYl3qcmCo3/6hQNpDu8i08MdvW1zIhZ9jd9dRrzJY7BVlNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXNtYWEgTW5lYmhpIDxh
c21hYUBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDkgQXVndXN0IDIwMjMgMTk6MjkN
Cj4gVG86IG1hcmtncm9zc0BrZXJuZWwub3JnOyBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlk
aWEuY29tPjsNCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjIgMS8yXSBtbHhiZi1ib290Y3RsOiBTdXBwb3J0IHRoZSBsYXJnZSBpY21jIHdyaXRl
L3JlYWQNCj4gDQo+IEVuYWJsZSByZWFkaW5nIGFuZCB3cml0aW5nIHRoZSBzaXplIG9mIHRoZSBt
ZW1vcnkgcmVnaW9uIGFzc29jaWF0ZWQgd2l0aCB0aGUNCj4gbGFyZ2UgSUNNIGNhcnZlb3V0Lg0K
PiBUaGUgbWF4IHNpemUgb2YgdGhlIGxhcmdlIElDTSBjYXJ2ZW91dCBpcyAxVEIsIGhhcyBhIGdy
YW51bGFyaXR5IG9mIDEyOE1CIGFuZA0KPiB3aWxsIGJlIHBhc3NlZCBhbmQgcHJpbnRlZCBpbiBo
ZXguIFRoZSBzaXplIHVuaXQgaXMgTUIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBc21hYSBNbmVi
aGkgPGFzbWFhQG52aWRpYS5jb20+DQoNClJldmlld2VkLWJ5OiBWYWRpbSBQYXN0ZXJuYWsgPHZh
ZGltcEBudmlkaWEuY29tPg0KDQo+IC0tLQ0KPiB2MS0+djI6DQo+IC0gYWRkZWQgZGVmaW5lcyBm
b3IgaWNtYyByZWxhdGVkIGludGVnZXJzDQo+IC0gcmVtb3ZlZCB1bm5lY2Vzc2FyeSBwYXJlbnRo
ZXNlcy4NCj4gDQo+ICBkcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYyB8
IDQyICsrKysrKysrKysrKysrKysrKysrKysrDQo+IGRyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gv
bWx4YmYtYm9vdGN0bC5oIHwgMTQgKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gv
bWx4YmYtYm9vdGN0bC5jDQo+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290
Y3RsLmMNCj4gaW5kZXggZmI5Zjc4MTVjNmNkLi41MmQxMjcyNDc4YTQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5jDQo+ICsrKyBiL2RyaXZl
cnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5jDQo+IEBAIC03OSw2ICs3OSw4IEBA
IHN0YXRpYyB2b2lkIF9faW9tZW0gKm1seGJmX3JzaF9zY3JhdGNoX2J1Zl9kYXRhOw0KPiBzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IG1seGJmX3JzaF9sb2dfbGV2ZWxbXSA9IHsNCj4gIAkiSU5G
TyIsICJXQVJOIiwgIkVSUiIsICJBU1NFUlQifTsNCj4gDQo+ICtzdGF0aWMgREVGSU5FX01VVEVY
KGljbV9vcHNfbG9jayk7DQo+ICsNCj4gIC8qIEFSTSBTTUMgY2FsbCB3aGljaCBpcyBhdG9taWMg
YW5kIG5vIG5lZWQgZm9yIGxvY2suICovICBzdGF0aWMgaW50DQo+IG1seGJmX2Jvb3RjdGxfc21j
KHVuc2lnbmVkIGludCBzbWNfb3AsIGludCBzbWNfYXJnKSAgeyBAQCAtMzkxLDYgKzM5Myw0NA0K
PiBAQCBzdGF0aWMgc3NpemVfdCByc2hfbG9nX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
IAlyZXR1cm4gY291bnQ7DQo+ICB9DQo+IA0KPiArc3RhdGljIHNzaXplX3QgbGFyZ2VfaWNtX3No
b3coc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpIHsNCj4gKwlzdHJ1Y3QgYXJtX3NtY2NjX3JlcyByZXM7DQo+ICsNCj4g
KwltdXRleF9sb2NrKCZpY21fb3BzX2xvY2spOw0KPiArCWFybV9zbWNjY19zbWMoTUxOWF9IQU5E
TEVfR0VUX0lDTV9JTkZPLCAwLCAwLCAwLCAwLA0KPiArCQkgICAgICAwLCAwLCAwLCAmcmVzKTsN
Cj4gKwltdXRleF91bmxvY2soJmljbV9vcHNfbG9jayk7DQo+ICsJaWYgKHJlcy5hMCkNCj4gKwkJ
cmV0dXJuIC1FUEVSTTsNCj4gKw0KPiArCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwg
IjB4JWx4IiwgcmVzLmExKTsgfQ0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBsYXJnZV9pY21fc3Rv
cmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KPiArCQkJICAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KSB7
DQo+ICsJc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPiArCXVuc2lnbmVkIGxvbmcgaWNtX2Rh
dGE7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWVyciA9IGtzdHJ0b3VsKGJ1ZiwgTUxYQkZfTEFS
R0VfSUNNQ19NQVhfU1RSSU5HX1NJWkUsDQo+ICZpY21fZGF0YSk7DQo+ICsJaWYgKGVycikNCj4g
KwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCWlmICgoaWNtX2RhdGEgIT0gMCAmJiBpY21fZGF0YSA8
IE1MWEJGX0xBUkdFX0lDTUNfU0laRV9NSU4pIHx8DQo+ICsJICAgIGljbV9kYXRhID4gTUxYQkZf
TEFSR0VfSUNNQ19TSVpFX01BWCB8fCBpY21fZGF0YSAlDQo+IE1MWEJGX0xBUkdFX0lDTUNfR1JB
TlVMQVJJVFkpDQo+ICsJCXJldHVybiAtRVBFUk07DQo+ICsNCj4gKwltdXRleF9sb2NrKCZpY21f
b3BzX2xvY2spOw0KPiArCWFybV9zbWNjY19zbWMoTUxOWF9IQU5ETEVfU0VUX0lDTV9JTkZPLCBp
Y21fZGF0YSwgMCwgMCwgMCwNCj4gMCwgMCwgMCwgJnJlcyk7DQo+ICsJbXV0ZXhfdW5sb2NrKCZp
Y21fb3BzX2xvY2spOw0KPiArDQo+ICsJcmV0dXJuIHJlcy5hMCA/IC1FUEVSTSA6IGNvdW50Ow0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgREVWSUNFX0FUVFJfUlcocG9zdF9yZXNldF93ZG9nKTsgIHN0
YXRpYw0KPiBERVZJQ0VfQVRUUl9SVyhyZXNldF9hY3Rpb24pOyAgc3RhdGljDQo+IERFVklDRV9B
VFRSX1JXKHNlY29uZF9yZXNldF9hY3Rpb24pOw0KPiBAQCAtMzk4LDYgKzQzOCw3IEBAIHN0YXRp
YyBERVZJQ0VfQVRUUl9STyhsaWZlY3ljbGVfc3RhdGUpOyAgc3RhdGljDQo+IERFVklDRV9BVFRS
X1JPKHNlY3VyZV9ib290X2Z1c2Vfc3RhdGUpOw0KPiAgc3RhdGljIERFVklDRV9BVFRSX1dPKGZ3
X3Jlc2V0KTsNCj4gIHN0YXRpYyBERVZJQ0VfQVRUUl9XTyhyc2hfbG9nKTsNCj4gK3N0YXRpYyBE
RVZJQ0VfQVRUUl9SVyhsYXJnZV9pY20pOw0KPiANCj4gIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICptbHhiZl9ib290Y3RsX2F0dHJzW10gPSB7DQo+ICAJJmRldl9hdHRyX3Bvc3RfcmVzZXRfd2Rv
Zy5hdHRyLA0KPiBAQCAtNDA3LDYgKzQ0OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpt
bHhiZl9ib290Y3RsX2F0dHJzW10gPSB7DQo+ICAJJmRldl9hdHRyX3NlY3VyZV9ib290X2Z1c2Vf
c3RhdGUuYXR0ciwNCj4gIAkmZGV2X2F0dHJfZndfcmVzZXQuYXR0ciwNCj4gIAkmZGV2X2F0dHJf
cnNoX2xvZy5hdHRyLA0KPiArCSZkZXZfYXR0cl9sYXJnZV9pY20uYXR0ciwNCj4gIAlOVUxMDQo+
ICB9Ow0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYt
Ym9vdGN0bC5oDQo+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290Y3RsLmgN
Cj4gaW5kZXggYjQ4MjQzZjYwYTU5Li5mYzUwMTljOTBmYzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5oDQo+ICsrKyBiL2RyaXZlcnMvcGxh
dGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5oDQo+IEBAIC04MSw2ICs4MSwxNSBAQA0KPiAg
ICovDQo+ICAjZGVmaW5lIE1MWEJGX0JPT1RDVExfRldfUkVTRVQgIDB4ODIwMDAwMEQNCj4gDQo+
ICsvKg0KPiArICogU01DIGZ1bmN0aW9uIElEcyB0byBzZXQgYW5kIGdldCB0aGUgbGFyZ2UgSUNN
IGNhcnZlb3V0IHNpemUNCj4gKyAqIHN0b3JlZCBpbiB0aGUgZWVwcm9tLg0KPiArICovDQo+ICsj
ZGVmaW5lIE1MTlhfSEFORExFX1NFVF9JQ01fSU5GTyAgICAweDgyMDAwMDEyDQo+ICsjZGVmaW5l
IE1MTlhfSEFORExFX0dFVF9JQ01fSU5GTyAgICAweDgyMDAwMDEzDQo+ICsNCj4gKyNkZWZpbmUg
TUFYX0lDTV9CVUZGRVJfU0laRSAxMA0KPiArDQo+ICAvKiBTTUMgZnVuY3Rpb24gSURzIGZvciBT
aVAgU2VydmljZSBxdWVyaWVzICovDQo+ICAjZGVmaW5lIE1MWEJGX0JPT1RDVExfU0lQX1NWQ19D
QUxMX0NPVU5UCTB4ODIwMGZmMDANCj4gICNkZWZpbmUgTUxYQkZfQk9PVENUTF9TSVBfU1ZDX1VJ
RAkJMHg4MjAwZmYwMQ0KPiBAQCAtMTA2LDQgKzExNSw5IEBADQo+ICAvKiBBZGRpdGlvbmFsIHZh
bHVlIHRvIGRpc2FibGUgdGhlDQo+IE1MWEJGX0JPT1RDVExfU0VUX1NFQ09ORF9SRVNFVF9BQ1RJ
T04uICovDQo+ICAjZGVmaW5lIE1MWEJGX0JPT1RDVExfTk9ORQkweDdmZmZmZmZmIC8qIERvbid0
IGNoYW5nZSBuZXh0IGJvb3QNCj4gYWN0aW9uICovDQo+IA0KPiArI2RlZmluZSBNTFhCRl9MQVJH
RV9JQ01DX01BWF9TVFJJTkdfU0laRSAxNg0KPiArI2RlZmluZSBNTFhCRl9MQVJHRV9JQ01DX1NJ
WkVfTUlOICAgICAgICAweDgwDQo+ICsjZGVmaW5lIE1MWEJGX0xBUkdFX0lDTUNfU0laRV9NQVgg
ICAgICAgIDB4MTAwMDAwDQo+ICsjZGVmaW5lIE1MWEJGX0xBUkdFX0lDTUNfR1JBTlVMQVJJVFkN
Cj4gTUxYQkZfTEFSR0VfSUNNQ19TSVpFX01JTg0KPiArDQo+ICAjZW5kaWYgLyogX19NTFhCRl9C
T09UQ1RMX0hfXyAqLw0KPiAtLQ0KPiAyLjMwLjENCg0K
