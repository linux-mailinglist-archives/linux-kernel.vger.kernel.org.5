Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0458C77E660
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjHPQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344727AbjHPQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:28:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A70173F;
        Wed, 16 Aug 2023 09:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdmVW0OoNFahYZfeeAz/OsF3RdrBGfkbN53PWhIoOOJbl7ikdNjFX/Ti+z3U0gTCRQGUXeMUABsmOeUL8bY8/3upN9684J3rXTbY/ezoTiCquY4JY2W6Kgt80YQTyJsiCjwoP25DHUc5pMqS76e5ir9O1k7RHQWwsaz/wtQ4kMANiCoGnGDX0NdHvvbS0F2HP8y4ZwOFCm9WpUur4peLqkd7VUxJRjlzAei5O7WC3o9pLn7F5neqgbOTxoxakYZ1JHyZalAfUqpz/uWN+WWgnwepLGOBw/QvozfRKXO/15D+y3qBEJGwhDZ7npY/2oBxfhMFKjEgfEeUdAKH+oMfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9kUaLP/8RNd2TVEhjyxf+jkx/nHflfh1/bxCqUp9Y0=;
 b=SmArVYJIJYfo1kq4ljdYMjtKT8PenQTntX/dHpdgElh7HP52slMQjV9cbVs4VVQB0yTbpMQ4u/tXekeOLuJcdH50ps4bfU9aYN8V40kphPS+NPyzpWt0EoPNUGTuwr5xZ/sMxqrEUHlyriQz1HGol+N3+qmladwg/omCdNtVMrHSxyKVPEsrgWEtkq87akaDnai77kEez/HrWWFCMoRv1DYLJr9zAo1oz4GZQS0th7abUahHuO2EEpBRA243OpOV8uOfymQOBzfz07KQlYbWWbx1o0vEhmXA08j6/IVawHnVbt4ll1SkQLoQWNnSSdRSdMZpb6adTbk8a0EY8O0p0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9kUaLP/8RNd2TVEhjyxf+jkx/nHflfh1/bxCqUp9Y0=;
 b=sm5aLOC3sHY6R4ruLdTExb1HCBkdTXPPxuvVKNklk2uSDBMGiwnyveZJxYb2zvkGaO7hzXDlJeYtRJumoq62nMRs6RAFQwnR/CQLG/qVxrWYwBnh8sMqDRJGIFA6QDValajKPzi1T2qy/pM9KvldtnYyqhtCc0PG2R+/9+bLMQ0SFZFomNEstMPp3dADRHOk/qfbsz8FlvhUuZ+HaDLbyQyAj4FWl8cN8BFIMYD/Gc2UWFMsC18oR2Et9woGyHDiFcWHpdqjAEDs7HpXDl/WcUqkEWK5+IZwx8Su229sQyPM+hWzZqdb1moab64yUC3wBJsjqhWWCt47ZPJwXtp1SQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 16:28:32 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:28:32 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Topic: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Index: AQHZyjY3Dytc43zD80SwdGjooQ0PA6/jMHqAgAAj+oCAACf5gIAAQFAAgADgDoCAACyNAIAIXT6Q
Date:   Wed, 16 Aug 2023 16:28:32 +0000
Message-ID: <BN9PR12MB50688191EFE9CBBD7D3A988AD315A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com>
 <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
 <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com>
 <a2f6cd0e-8429-3468-9dcf-a5022717e2ae@intel.com>
 <CAPDyKFqTWMghEAsBdLUF+K4QNEWBozNi3_a7w0+KuuO3x+wkTQ@mail.gmail.com>
 <e561174e-a5cf-9503-f47a-d6c3fc7a1719@intel.com>
 <CAPDyKFrZawSORUG6wAJoCGFJABXvadivarNJ7_3V-ajeULLitw@mail.gmail.com>
In-Reply-To: <CAPDyKFrZawSORUG6wAJoCGFJABXvadivarNJ7_3V-ajeULLitw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|SA0PR12MB4368:EE_
x-ms-office365-filtering-correlation-id: ddb7ef25-c650-4080-a69a-08db9e75d4fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlZiC5akwtxXd+/Gwuup7dlTGDKy02iQFKDEAzw4zU/YSwQwihNqt5V7K6f9nXnqVIuvVhB7FZsAcjSbc2OWS3koshjLfZOulkRgl62i9oPKct1MHEBHlPGg8Z0o9jDvGP/Ysd45WF1QX1vGGxawgp+8t3x+pAb+o6b4zYJjPNB1ncdSFUcpKcZyz5meTlJfzVRal03jDVr+qcSiptYII6+XZSadPj14m9X3ksMiY2Ru8SRSyU2AVxytJ2vcvTXbrBe9R1pTFBVZdqP8ZKYD2KfSJESSf+K0iJd4kOSONECcmGmBXb+4AwCI/o8CCsqx3YuLn58XhVNWdmNxX58nX3gj98aWskCkl4WAJnyl1DoeUcFPLtuxK5Y9wFVtOGdSgEKakNI0vyMXhsJU1eje5ov6KeNhLTK5A8jTmb9AoC8xdazPABUcbizGZfJfPPCKKhk4c5BS1rmp0iJ5vd4Bfv4ZCBu9tW0lyYdV6A+tyxI4DkAuvPf3fxAgibkwfFtLuJIa3RGjPzRtSUvDs13bh73//ivpCAdinLu2IR5BrqSmm0HZ/BZ8xqB4wUXCkpuj8kv1OeXnYyIrpGRMHH/RyJe6sKRxOg+vUnhHdJbPuAZ6iqYJUO0vRfHOJwdgkkuYnIGWXb140ESNa+MPcWHYKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(41300700001)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(55016003)(478600001)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm01c0pXamxjbGU3dGhrNlJFWVBQenNkRGN2T2V2dEpySU5MMTgzejl1dVFr?=
 =?utf-8?B?cnV5bndEVzFPUEE3cThlRHQ5SUZzMm9SMzJ0ZmxJOHdLNjlwcmlGelg5b0ww?=
 =?utf-8?B?R2ttN1gra3ZqcnBlMU5QVk45L3p0cEZ2d2lZZFlnR084aXROQzlFTTdPMkZt?=
 =?utf-8?B?RnBtSzUrMFlyTkdRN0RCT0NqUmtlMlRlTDhKc3ZTdHhxTkJzcHlLZGc2Vmoy?=
 =?utf-8?B?N3EvekZPd2Z1eHJhSnRBOUtVVGZDMTVCb2pyamRlL2tGUXRwaXhlUFFCOGVQ?=
 =?utf-8?B?b1FWdU56NnFmbkdicE5nVXVxQldBem1abEt4WEs5UEM2T21xOUhRY1l1UDlO?=
 =?utf-8?B?b0JQaS9zS3Z0MDZ4aWQwd1BURlVmL2ZtRFllU1NBWm9hNWlNVFZoakRXL1B6?=
 =?utf-8?B?VWFZeFcrVmZaMnlJeUI0bkNrMTVoWW81RW42RnZhZTdNa2NYVE9GbUwrQ1VX?=
 =?utf-8?B?WEdLSjJRbExKS1hLQTV4VU15Z0J0MDBhNXFtNnJNaTJiYXQyOCtSRmoyLzVF?=
 =?utf-8?B?TUVabG0xNHJTWEpLMlIwTmtRU2NCNHlaNVAyWmpxclpXVm9BUFgvL2dIRGVr?=
 =?utf-8?B?VEpQcU1SanN1dktlSHJZSlBiZUZnM0t2dkVqTFcrK1oycXJBT1U0RmNWUzUy?=
 =?utf-8?B?ejJ3MzUzSVRpeVNWdUxRVXBsZzZjR3RpV1A5WnN1U1p0NXlKNkNta3QzdDJa?=
 =?utf-8?B?bWZLbmF0dVJNTzBBdkJSZ01BY2p4ajZjNlkxbXN0Nzh2cllVb3UwdHBPUGZa?=
 =?utf-8?B?dzN2QmdVUHd4ak1EMis0eHQ0ejVKOXBad1RXbmsyRmJqenpudXB1Y1JqWTVj?=
 =?utf-8?B?eHJtdEpPM1JOTWEyOFpjcjU5aXA1NWxPZktPbTNnMFR4QlRTWHRkaDU4WEJU?=
 =?utf-8?B?cTY2eHFXWU5MVThZbzh4amhNM2xTdm1CUUJFaWpQUVF4TEZWVmwxelpjSGFY?=
 =?utf-8?B?RXNWc2tNbTBvWWRKb05HNTBBdTRFR0tkR2lpaW5tRGlQZXF0Zzd4bEVWQmpl?=
 =?utf-8?B?bE9TVzFSTkJSS0M3OWE4SWJjSkRMSXFWRk10VmR0RlRhZjhoM3NXTDREem5Y?=
 =?utf-8?B?MlF2Yk9UOVFKWUxEUER5aEV5N1JUTmJhMERKZ05GK0RBWXNOY0swYkg4NlFp?=
 =?utf-8?B?Rm4rR0RhK0l6RHU0cDRRdzhJN0tOVW9HR20xenkrbisyRitYdERVQzhTU2FW?=
 =?utf-8?B?RXEyWUFGeGg5Z29EQnREY29XaUsrZU5VODlmd0dDS1NJeGh6WGhqeHdWdmZV?=
 =?utf-8?B?OXFRaG5QL0pkUlc0cGlvSHV6eGpCQWZyS2R0TlhDdkNwZEdaRzNpVWdSOThh?=
 =?utf-8?B?Z1FOQTZPTDFHZ0lMcG5kNkxmeS9iekxjWjgyMmJuWERTTWlUTDRxdWMwUk5W?=
 =?utf-8?B?Z2RGSG00VWhFYUlmWGFxWElRc1JnSzEzYXJLVkdlMzN6c2lLaitvalppMGZT?=
 =?utf-8?B?a1JUNGFaRlMyVGhwUzEveTBmZnNvOEcxZncvVTRRUjV6a3Z3WWlVQlpmc1FD?=
 =?utf-8?B?b2VDbm5pOHVsT0tDRGQrRURHdUp1SS91QXNXWjJrbG1ZMHJlTncrcFRDUEVB?=
 =?utf-8?B?OW9pdVFPTng2TGpaSDdwZWJyTmliSU5GNG1reE9DMGxIN0xVWG1pTzd4czBV?=
 =?utf-8?B?S0xhU1B0QkFYazlRNHQ0ek15WWc0V2JzWkhJUi9KMFpvRkJjQXgyeGtFYUlw?=
 =?utf-8?B?V0pxZkJQWFlNNEtTemUzM1RwY0ZaK2hyWHNQQSsxVyswTktNTUhaZXpEZ29V?=
 =?utf-8?B?dWhsTVgwQk1LM2F5K2pFWVFIY3JKK1crdjRtMXBXRC9OTnVXRTV5aEtEc1VB?=
 =?utf-8?B?OEN6K0UzQzZHWDVBRTBHVmoyTlROcG11NDVqaGJlVGFNeWIwM0ZYNllHTjVO?=
 =?utf-8?B?Y2drZlRBUmpLZGJkV1J6RGYydjlIOWNoVHp0RkJRVFcwakh3WWpPN3Y1WmJG?=
 =?utf-8?B?dmlxbFZoZ1I2M3Y5ZzI5UkEvUXMzcDFuNld1RWtLSTZHWWd3Yjdlb3lKUE1F?=
 =?utf-8?B?VkduZWkvdnZKb2hNaUF4WWJUYXpiZG5EbmhveFBrL2lvOUppNkk2NkFoeWhq?=
 =?utf-8?B?ZWdiUnpmaGh3MGI5VGNla0dOdk5tY0s3aFVYejA5UWRGaUw5NGd4RXRyV1dr?=
 =?utf-8?Q?HR0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb7ef25-c650-4080-a69a-08db9e75d4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 16:28:32.4417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esB0QHz2xOCgFzClBWevA+7WSum/YlZWnuCONP4fncrVcUlrXcfuX4CXuL9lYytgANJnMkXay03DoOWgB6G0xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDExLCAyMDIzIDQ6
MzYgQU0NCj4gVG86IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBD
YzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgRGF2aWQgVGhvbXBzb24NCj4gPGRh
dnRob21wc29uQG52aWRpYS5jb20+OyBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNv
bT47IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjddIG1tYzogc2RoY2ktb2YtZHdjbXNoYzog
QWRkIHJ1bnRpbWUgUE0gb3BlcmF0aW9ucw0KPiANCj4gT24gRnJpLCAxMSBBdWcgMjAyMyBhdCAw
Nzo1NywgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gT24gMTAvMDgvMjMgMTk6MzQsIFVsZiBIYW5zc29uIHdyb3RlOg0KPiA+ID4gT24g
VGh1LCAxMCBBdWcgMjAyMyBhdCAxNDo0NCwgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4gT24gMTAvMDgvMjMgMTM6MjEsIFVs
ZiBIYW5zc29uIHdyb3RlOg0KPiA+ID4+PiBPbiBUaHUsIDEwIEF1ZyAyMDIzIGF0IDEwOjEzLCBB
ZHJpYW4gSHVudGVyDQo+IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPj4+
Pg0KPiA+ID4+Pj4gT24gOC8wOC8yMyAyMzoyMywgTGltaW5nIFN1biB3cm90ZToNCj4gPiA+Pj4+
PiBUaGlzIGNvbW1pdCBpbXBsZW1lbnRzIHRoZSBydW50aW1lIFBNIG9wZXJhdGlvbnMgdG8gZGlz
YWJsZSBlTU1DDQo+ID4gPj4+Pj4gY2FyZCBjbG9jayB3aGVuIGlkbGUuDQo+ID4gPj4+Pj4NCj4g
PiA+Pj4+PiBSZXZpZXdlZC1ieTogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52aWRpYS5j
b20+DQo+ID4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEu
Y29tPg0KPiA+ID4+Pj4+IC0tLQ0KPiA+ID4+Pj4+IHY2LT52NzoNCj4gPiA+Pj4+PiAgICAgLSBB
ZGRyZXNzIFVsZidzIGNvbW1lbnQ7DQo+ID4gPj4+Pj4gdjUtPnY2Og0KPiA+ID4+Pj4+ICAgICAt
IEFkZHJlc3MgQWRyaWFuJ3MgbW9yZSBjb21tZW50cyBhbmQgYWRkIGNvb3JkaW5hdGlvbiBiZXR3
ZWVuDQo+ID4gPj4+Pj4gICAgICAgcnVudGltZSBQTSBhbmQgc3lzdGVtIFBNOw0KPiA+ID4+Pj4+
IHY0LT52NToNCj4gPiA+Pj4+PiAgICAgLSBBZGRyZXNzIEFkcmlhbidzIGNvbW1lbnQgdG8gbW92
ZSB0aGUgcG1fZW5hYmxlIHRvIHRoZSBlbmQgdG8NCj4gPiA+Pj4+PiAgICAgICBhdm9pZCByYWNl
Ow0KPiA+ID4+Pj4+IHYzLT52NDoNCj4gPiA+Pj4+PiAgICAgLSBGaXggY29tcGlsaW5nIHJlcG9y
dGVkIGJ5ICdrZXJuZWwgdGVzdCByb2JvdCc7DQo+ID4gPj4+Pj4gdjItPnYzOg0KPiA+ID4+Pj4+
ICAgICAtIFJldmlzZSB0aGUgY29tbWl0IG1lc3NhZ2U7DQo+ID4gPj4+Pj4gdjEtPnYyOg0KPiA+
ID4+Pj4+ICAgICBVcGRhdGVzIGZvciBjb21tZW50cyBmcm9tIFVsZjoNCj4gPiA+Pj4+PiAgICAg
LSBNYWtlIHRoZSBydW50aW1lIFBNIGxvZ2ljIGdlbmVyaWMgZm9yIHNkaGNpLW9mLWR3Y21zaGM7
DQo+ID4gPj4+Pj4gdjE6IEluaXRpYWwgdmVyc2lvbi4NCj4gPiA+Pj4+PiAtLS0NCj4gPiA+Pj4+
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgfCA3Mg0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiA+ID4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNzAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4gPj4+Pj4gaW5kZXggZTY4Y2Q4Nzk5OGM4Li5jOGUx
NDUwMzE0MjkgMTAwNjQ0DQo+ID4gPj4+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1v
Zi1kd2Ntc2hjLmMNCj4gPiA+Pj4+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3
Y21zaGMuYw0KPiA+ID4+Pj4+IEBAIC0xNSw2ICsxNSw3IEBADQo+ID4gPj4+Pj4gICNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4NCj4gPiA+Pj4+PiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4g
Pj4+Pj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiA+Pj4+PiArI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiA+Pj4+PiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+
DQo+ID4gPj4+Pj4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiA+ID4+Pj4+DQo+ID4gPj4+
Pj4gQEAgLTU0OCw5ICs1NDksMTMgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdA0K
PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiAgICAgICBob3N0
LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9XQUlUX1dISUxFX0JVU1k7DQo+ID4gPj4+Pj4NCj4gPiA+
Pj4+PiArICAgICBwbV9ydW50aW1lX2dldF9ub3Jlc3VtZShkZXYpOw0KPiA+ID4+Pj4+ICsgICAg
IHBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOw0KPiA+ID4+Pj4+ICsgICAgIHBtX3J1bnRpbWVf
ZW5hYmxlKGRldik7DQo+ID4gPj4+Pj4gKw0KPiA+ID4+Pj4+ICAgICAgIGVyciA9IHNkaGNpX3Nl
dHVwX2hvc3QoaG9zdCk7DQo+ID4gPj4+Pj4gICAgICAgaWYgKGVycikNCj4gPiA+Pj4+PiAtICAg
ICAgICAgICAgIGdvdG8gZXJyX2NsazsNCj4gPiA+Pj4+PiArICAgICAgICAgICAgIGdvdG8gZXJy
X3JwbTsNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+ICAgICAgIGlmIChya19wcml2KQ0KPiA+ID4+Pj4+
ICAgICAgICAgICAgICAgZHdjbXNoY19yazM1eHhfcG9zdGluaXQoaG9zdCwgcHJpdik7DQo+ID4g
Pj4+Pj4gQEAgLTU1OSwxMCArNTY0LDE1IEBAIHN0YXRpYyBpbnQgZHdjbXNoY19wcm9iZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4+Pj4+ICAgICAgIGlmIChlcnIpDQo+
ID4gPj4+Pj4gICAgICAgICAgICAgICBnb3RvIGVycl9zZXR1cF9ob3N0Ow0KPiA+ID4+Pj4+DQo+
ID4gPj4+Pj4gKyAgICAgcG1fcnVudGltZV9wdXQoZGV2KTsNCj4gPiA+Pj4+PiArDQo+ID4gPj4+
Pj4gICAgICAgcmV0dXJuIDA7DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiAgZXJyX3NldHVwX2hvc3Q6
DQo+ID4gPj4+Pj4gICAgICAgc2RoY2lfY2xlYW51cF9ob3N0KGhvc3QpOw0KPiA+ID4+Pj4+ICtl
cnJfcnBtOg0KPiA+ID4+Pj4+ICsgICAgIHBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiA+ID4+
Pj4+ICsgICAgIHBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOw0KPiA+ID4+Pj4+ICBlcnJfY2xr
Og0KPiA+ID4+Pj4+ICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShwbHRmbV9ob3N0LT5jbGsp
Ow0KPiA+ID4+Pj4+ICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5idXNfY2xrKTsN
Cj4gPiA+Pj4+PiBAQCAtNjA2LDYgKzYxNiwxMiBAQCBzdGF0aWMgaW50IGR3Y21zaGNfc3VzcGVu
ZChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4gPj4+Pj4gICAgICAgaWYgKHJldCkNCj4gPiA+
Pj4+PiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiArICAg
ICByZXQgPSBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQoZGV2KTsNCj4gPiA+Pj4+PiArICAgICBp
ZiAocmV0KSB7DQo+ID4gPj4+Pj4gKyAgICAgICAgICAgICBzZGhjaV9yZXN1bWVfaG9zdChob3N0
KTsNCj4gPiA+Pj4+PiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPj4+Pj4gKyAgICAg
fQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFNpbmNlIHlvdSBhcmUgb25seSB1c2luZyB0aGUgcnVudGlt
ZSBQTSBjYWxsYmFja3MgdG8gdHVybiBvZmYgdGhlIGNhcmQNCj4gPiA+Pj4+IGNsb2NrIHZpYSBT
REhDSV9DTE9DS19DT05UUk9MLCBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQoKSBhbmQNCj4gPiA+
Pj4+IHBtX3J1bnRpbWVfZm9yY2VfcmVzdW1lKCkgYXJlIG5vdCBuZWVkZWQgYXQgYWxsLg0KPiA+
ID4+Pg0KPiA+ID4+PiBSaWdodCwgaXQgY2FuIGJlIGRvbmUgd2l0aG91dCB0aGVzZSB0b28uDQo+
ID4gPj4+DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gc2RoY2lfc3VzcGVuZF9ob3N0KCkgZG9lcyBub3Qg
Y2FyZSBpZiBTREhDSV9DTE9DS19DQVJEX0VOIGlzIG9uIG9yDQo+IG9mZi4NCj4gPiA+Pj4+IChB
bmQgeW91IGFyZSBkaXNhYmxpbmcgcGx0Zm1faG9zdC0+Y2xrIGFuZCBwcml2LT5idXNfY2xrLCBz
bw0KPiBwcmVzdW1hYmx5DQo+ID4gPj4+PiB0aGUgcmVzdWx0IGlzIG5vIGNsb2NrIGVpdGhlciB3
YXkpDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gc2RoY2lfcmVzdW1lX2hvc3QoKSBkb2VzIG5vdCByZXN0
b3JlIHN0YXRlIHVubGVzcw0KPiA+ID4+Pj4gU0RIQ0lfUVVJUksyX0hPU1RfT0ZGX0NBUkRfT04g
aXMgdXNlZCwgaXQganVzdCByZXNldHMsIHNvIHRoZQ0KPiBpbnRlcm5hbCBjbG9jaw0KPiA+ID4+
Pj4gU0RIQ0lfQ0xPQ0tfSU5UX0VOIGlzIG9mZiB3aGljaCBpcyBjb25zaXN0ZW50IHdpdGggZWl0
aGVyIHJ1bnRpbWUNCj4gc3VzcGVuZGVkDQo+ID4gPj4+PiBvciBydW50aW1lIHJlc3VtZWQuDQo+
ID4gPj4+DQo+ID4gPj4+IEV2ZW4gaWYgdGhpcyBtYXkgd29yaywgdG8gbWUsIGl0IGRvZXNuJ3Qg
bG9vayBsaWtlIGdvb2QgcHJhY3RpY2UgZm9yDQo+ID4gPj4+IGhvdyB0byB1c2UgcnVudGltZSBQ
TSBpbiBjb21iaW5hdGlvbiB3aXRoIHN5c3RlbSB3aWRlDQo+IHN1c3BlbmQvcmVzdW1lLg0KPiA+
ID4+Pg0KPiA+ID4+PiBUaGUgcG9pbnQgaXMsIHNkaGNpX3N1c3BlbmR8cmVzdW1lX2hvc3QoKSBt
YXkgZW5kIHVwIHJlYWRpbmcvd3JpdGluZw0KPiA+ID4+PiB0byBzZGhjaSByZWdpc3RlcnMgLSBh
bmQgd2Ugc2hvdWxkICpub3QqIGFsbG93IHRoYXQgKGJlY2F1c2UgaXQgbWF5DQo+ID4gPj4+IG5v
dCBhbHdheXMgd29yayksIHVubGVzcyB0aGUgc2RoY2kgY29udHJvbGxlciBoYXMgYmVlbiBydW50
aW1lIHJlc3VtZWQNCj4gPiA+Pj4gZmlyc3QsIHJpZ2h0Pw0KPiA+ID4+DQo+ID4gPj4gSSBhbSBP
SyB3aXRoIGRyaXZlcnMgdGhhdCBqdXN0IHdhbnQgdG8gdXNlIHJ1bnRpbWUgUE0gdG8gdHVybiBv
ZmYgYQ0KPiA+ID4+IGZ1bmN0aW9uYWwgY2xvY2suICBzZGhjaS10ZWdyYS5jIGlzIGFsc28gZG9p
bmcgdGhhdCBhbHRob3VnaCB1c2luZyB0aGUNCj4gPiA+PiBjbG9jayBmcmFtZXdvcmsuDQo+ID4g
Pg0KPiA+ID4gWWVzLCBJIGFncmVlLiBBdCBsZWFzdCB0aGlzIHdvcmtzIGZvciBTb0Mgc3BlY2lm
aWMgZHJpdmVycy4NCj4gPiA+DQo+ID4gPj4NCj4gPiA+PiBDZXJ0YWlubHkgdGhhdCBhcHByb2Fj
aCBhc3N1bWVzIHRoYXQgdGhlIGhvc3QgY29udHJvbGxlcidzIHBvd2VyIHN0YXRlDQo+ID4gPj4g
aXMgbm90IGNoYW5nZWQgZHVlIHRvIHJ1bnRpbWUgUE0uDQo+ID4gPj4NCj4gPiA+PiBUbyBlbnN1
cmUgdGhhdCB0aGUgaG9zdCBjb250cm9sbGVyIGlzIHJ1bnRpbWUgcmVzdW1lZCBiZWZvcmUgY2Fs
bGluZw0KPiA+ID4+IHNkaGNpX3N1c3BlbmRfaG9zdCgpLCB3ZSBjYW4ganVzdCBjYWxsIHBtX3J1
bnRpbWVfcmVzdW1lKCkgSSB0aGluay4NCj4gPiA+DQo+ID4gPiBZZXMsIHRoYXQgd2FzIGtpbmQg
b2Ygd2hhdCBJIHByb3Bvc2VkIGluIHRoZSBvdGhlciB0aHJlYWQgYXMgb3B0aW9uIDEpDQo+ID4g
PiAoZXhjZXB0IGZvciB0aGUgcmVwbGFjZW1lbnQgb2YgcG1fcnVudGltZV9mb3JjZV9zdXNwZW5k
fHJlc3VtZSkuDQo+ID4gPg0KPiA+ID4gQWx0aG91Z2gsIHRvIGJlIGNsZWFyIEkgd291bGQgcHJv
YmFibHkgdXNlIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKQ0KPiA+ID4gaW5zdGVhZCwgdG8gbWFrZSBz
dXJlIHRoZSB1c2FnZSBjb3VudCBpcyBpbmNyZW1lbnRlZCB0b28uDQo+ID4NCj4gPiBJbiB0aGF0
IGNhc2UsIGEgbWF0Y2hpbmcgcG1fcnVudGltZV9wdXQoKSBpcyBuZWVkZWQgYWxzbyBhdCB0aGUN
Cj4gPiBlbmQgb2YgdGhlIHJlc3VtZSBjYWxsYmFjay4NCj4gDQo+IFllcywgb2YgY291cnNlLiBP
ciBkZXBlbmRpbmcgaWYgd2UgYXJlIHVzaW5nIHRoZSBmb3JjZV9zdXNwZW5kfHJlc3VtZQ0KPiBo
ZWxwZXIsIGEgcG1fcnVudGltZV9wdXRfbm9pZGxlIGlzIHN1ZmZpY2llbnQgYWZ0ZXINCj4gcG1f
cnVudGltZV9mb3JjZV9zdXNwZW5kKCkgaGFzIGJlZW4gY2FsbGVkLg0KDQpUaGFua3MgVWxmL0Fk
cmlhbiEgUGxhbiB0byB1cGxvYWQgdjggd2l0aCB0aGUgZm9sbG93aW5nIGNoYW5nZXM6DQotIFJl
bW92ZSBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQvcmVzdW1lKCkgZnJvbSBkd2Ntc2hjX3N1c3Bl
bmQoKS9kd2Ntc2hjX3Jlc3VtZSgpIChBZHJpYW4ncyBjb21tZW50KS4NCi0gQWRkIGNvbW1lbnRz
IGZvciBkd2Ntc2hjX3Jlc3VtZSgpL2R3Y21zaGNfc3VzcGVuZCgpOw0KKEFjY29yZGluZyB0byBB
bmRyaWFuJ3MgY29tbWVudCkuDQotIEFkZCBwbV9ydW50aW1lX2dldF9zeW5jKCkvcG1fcnVudGlt
ZV9wdXQoKSBpbiBkd2Ntc2hjX3N1c3BlbmQoKSwgd2hpY2ggaXMgVWxmIG9wdGlvbi0xLiAgT3B0
aW9uLTIgc2VlbXMgbW9yZSBlZmZpY2llbnQsIGJ1dCBpdCBpbnZvbHZlcyBtb3JlIGNoYW5nZXMg
YW5kIEkgY291bGRuJ3QgdGVzdCB0aGUgaW1wYWN0IG9uIG90aGVyIFNvQy4gTWF5YmUgZm9yIGZ1
dHVyZSBlbmhhbmNlbWVudD8NCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZm
ZQ0K
