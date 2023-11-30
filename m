Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B117FEFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbjK3NTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjK3NTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:19:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7170B5;
        Thu, 30 Nov 2023 05:19:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC0s+IgT9ncmqqpfsK9M4741UxlFQuLGvsfgXGptyvrAujbmXNueXqYxC2BHb2ZceA3o6DZmHxX+pVukQSXu4cYFrYHucrsKUw998cH9W9iLYo43T+EI7geuRXSYNXD6e6eXxfGUUlXW+r9EJZrqClyodDMvXN3//EROiKukv/n0CfiarJD46GQ5boTxf557iidJOF1uQ8KR46FbY3ID4hrEqo2ar0UUolnya+IHDDgoqTm2rHn44T30h0YW2MPAJgZVYour6iSYGk1eumq9mJqU4kFc0ui9+a8XJHSJWwB6YakTM1C16z8RDAMcLAIsUV5Whn5YsWQAWRJwcoPsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCRG8quVWySKQnwQeDk//Tu0qpP/hiXt6FI/SYlGN7U=;
 b=Dvp3ZXf1CEKJc7kVkLZ9KZRCI5e/sfJWlQcNjLANyatx1IjG2FXwrPfIzro+AogwVn0NScealVcxTQ4mhihTZCckkfZgowD0AurwLJcnyFtd9Yx8ow4NAIOXBHn8leqzMnS7ls1BJYiwrMi/FTf4nAjJRxnaA1BADEqrRAiXX+Kyi2ouxXqqqe8nX+vEdnFVCaG1+qjIYDOEO8a9RYWA73aSACPEnE+q/lfA2yWsbnm/gdXNGPEc0/sMsIH5as+A/W7AavMJ+YlYR4qbxSAHMjTKgFxPFlSJfr/z42IWMo4Cb6DR0FvtgplUSuw+qQhvFTDWtT+USAD5/SjAQEdzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCRG8quVWySKQnwQeDk//Tu0qpP/hiXt6FI/SYlGN7U=;
 b=O7XCsyrsAb5R7EuRYyRa6+NqlnbrPhcoOCZV4TOllecqXpEc5Uy9/LyibruXiCBBv/TmH1ygXGNkGpkxM8OjwA90+VWpCHL1wCT2snH9N3/TXETMrGOWWAe/slDIZlXI88Unf8uavuZIfZx58GO4jTkyz1fCQdA660bk3dRzJiCmueqxJnbLyFK+rQ+ExJPw3Fymi3HWyZJL46Bdkni+5ZQCIfFvKdtVv6Tt5DxYPEW28KtqnVknGX6bZLfaPXG6FRnEUzOom2gNGrsmnxcdds5m5g60NqdAoeR+cg1ELszXRqD7N+a3nWfI9Q8sosrWELNlMvN5ZtXrwK96sMVRiw==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 13:19:35 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::126b:b22c:51cc:c996]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::126b:b22c:51cc:c996%6]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 13:19:34 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Christian Loehle <christian.loehle@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Thread-Index: AQHaGiWuyqF2YA89PESSY+mtaOAx97COOQuAgASwglA=
Date:   Thu, 30 Nov 2023 13:19:34 +0000
Message-ID: <BN9PR12MB506854D38EA7E2702319F1AAD382A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
 <3912dd1e-b15b-49a9-9c91-88e00e986efd@arm.com>
In-Reply-To: <3912dd1e-b15b-49a9-9c91-88e00e986efd@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|SN7PR12MB8026:EE_
x-ms-office365-filtering-correlation-id: 1030a78b-f66a-4e9e-b85c-08dbf1a6ff07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArtaIjOU1URBmoo73YTFTbXeoXdi52so5kaMionJUc0aT6WNJSdusxxKKAEr13hF/0Yo4v7ED5t/GxJ7c7HG5RAZ+XPICU+lML+iqRrg/c/inegsKuR/ehZ6IyVIYw4CA1V27wM+NF29mU2Ymr15l1EeJUKY5shYpOabgTVOcsir6jpPvH0EokiPodzD6Y0IjZzXhNYQ4DbIzUt2pd4AEN/1VGPa7xib+ppu37McMfQRRNwY8pXBbFazsyAjQH6dGzKRtVIhY9b4xX2b75rZldX0jhGITiUrFQ3CfAjrMsk6r9vsQPc/zLSO9qWmoUpOQmOnexz8Jk2I218bae7eNZkBsPraK98HKKQUFxMIoNhSgFi3pCBTlF/YKf9S2fGzwLwUDJHMid/u6B5Ky/FMSdX6EToRfbueZtbl6cVtCx62byqFqvaInOtAVu/5uw7+1QuUIYBItO0MiMLiMscoPgt5apJhl3py6icVmQhTXF0PTV3bbGr6yQ/6Jly1cQuud5041ac6FgsBxUSFWRS/RJAbCKzGzp2IIunE8KkB0T2F2MjQW0o3fyA1Ue3QOOo66aJah3QLkfKqb2nS23zTTGGLW701lzF28XR2aWgtF+dAnLGuJpY1wc+48yhnxNqBBfLPde2N6tLRqLTkY+D5Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6636002)(71200400001)(38100700002)(33656002)(86362001)(122000001)(83380400001)(26005)(6506007)(9686003)(53546011)(7696005)(2906002)(110136005)(316002)(478600001)(5660300002)(8676002)(4326008)(41300700001)(52536014)(8936002)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpHZnlsY21sT1EwQUFOQzBKYXR2YUl0cE1sYzNpSTZyU253OHVhL1grSkZS?=
 =?utf-8?B?bFhmZy9NdkJVU01scDBuWDUrVlJYTlVFMnJnZmo3MWs5dGthWlVSWXBMSG9B?=
 =?utf-8?B?ajc4aE92TnNNbEMyS0xmMTF0WkMrODlzYkZjU2ZkMzAwaldoNWtkWlg5ZFR1?=
 =?utf-8?B?RVdjRkxMVThuZlJoWFlXZkRxK0dvSXZ3aC9rUXhwQkpQV1pKeS9WT3Nsb2Na?=
 =?utf-8?B?S25PMkxyZUJXd0hwZ3U1UHZ0dHVEUzBHcGI1dGw2WFo1S21JUGZhNWxtMEFN?=
 =?utf-8?B?anlUTDVOYUNwTUlGcVYrUUdYRytzVzV0V3RUSkVUVi9jMWNNV2dXdWtsZjBP?=
 =?utf-8?B?ek8xZVBvYUZJU2dWTXpmZysrZ0ZHU2V5cENvUU9Db29Cc3MxT3VLWGVRTzV1?=
 =?utf-8?B?OElTWEVKK3pNZnFQajkzOTNPS04yVHUxTGs2SEV3TGZOVVpkY09USzQ3STlM?=
 =?utf-8?B?NFRlVUFNOXFFZDRxZGc1MndqVldnTjRlTGhxWVFocjlGVXhBWTYzUm1YVS9V?=
 =?utf-8?B?MW8randLcWJuNVBFL3pkazZCWUtWa1VGZnAvWTdDZnJyaTd4c0Nram1DYXVw?=
 =?utf-8?B?ZWNGSXhhOFNmMmlyL2RKU2kzV1VoOEZQYjVRRDkrejZGY0RkeTZVQldqdGtm?=
 =?utf-8?B?WkYxU0ZaUTRRUGZXd0NHc2E0R1dHMHdSN2FpYUtvNDRvMGdPQXNMRlE2amsv?=
 =?utf-8?B?YjhkSllTL2xBT29uNC95blZXWWhmUElvb01LQ0NHb0ZDMmM1S2Y4K0RPR0dX?=
 =?utf-8?B?UDV0U3JGUVVnMUdYQzRtU1Bia1YyZ2paL3U4dGE1NU53ZlNoOVVJWXUrYW10?=
 =?utf-8?B?NldtYTQ4Qk9RMFBWUHVabExVZHhPaTgxcXJQM2ZtZGpsdnl2M01ad1hVa2pt?=
 =?utf-8?B?cUw4ZU9GR09tUHpYNEQ1VGhhWFlMK1BLMlFyOGh0LzlKWlZpUDBIcmZxQTZO?=
 =?utf-8?B?bWFnMGt6R29leEJBZnUwY3g0cUs1bjlacjFNN2ZySjlsSHQxUE1iSVZHWFZF?=
 =?utf-8?B?WE9DRExFMThZeVZkZnpuTG5ZOUt5aWxwSU1ZcjVaNVZmbEY0dTUxaHVwMmti?=
 =?utf-8?B?aGRBQTJYQ1EzNitNOU9zVmxMMW5WSVFhRkxESEVtK3Vobmk3UTVTb25ENEcr?=
 =?utf-8?B?bGRUUGNXY0ZienFSSCs4Q09IeGxRSHJkY3hWRmcwdFlwbng0RU14S2VsV1Nu?=
 =?utf-8?B?Wm9aYjBpVE53dFBrbGZtcW1lalhSc2tob3JMaUJqRWZiakg2NTRlWThRTld2?=
 =?utf-8?B?RzdNZFZ5LzBPaGVUbmFqZWZ0WEdDbTlRNmlFemVIa1pSdzVuV0ZBS0RiVUoz?=
 =?utf-8?B?TzViU3NJOHNjU3c4SkF5WnJmQXpHTUUvL2FXN2tVRXNQU3ZRanc0TGhHUGRw?=
 =?utf-8?B?UCthSlZmbWMzV09Ba2U4M2ROY1pYWXN2YzlVWTJVUmxzL09haDJKOHZ4cTZ1?=
 =?utf-8?B?cml2VXkrVXVlT1RXOE1lb2oyMWx6SDY2Um9yMWNMM1MrRXpBbkgyeFJ0OHBq?=
 =?utf-8?B?c29RcTBIUTc5aDlrbDBkb2lDOElEdlhXQXBPK2pYcTN2NmdOdWZrQURrdWFk?=
 =?utf-8?B?QVM3bXVYWnNkRXRPRSsrNGx5MUxkUWdIQXJXUk95VEt6ZStSRlZhTTBTLy9F?=
 =?utf-8?B?T1oyV0pXcjNzMzZyeE9PT1ZTU3VHeGJERzBocGZYbG5zNmtYcjRsVFZHV0RT?=
 =?utf-8?B?eUZ0cWV6WnNYci9JUk0zbUpxaE1sWFBrRjBDdEpMOWxGRU1ha3lhUzdxRnZF?=
 =?utf-8?B?RlpJOWZ4SXJqaHFGQnR2M2R0aDg1Y0g5NWt1K1ZSTmtwZWxwb3QzZVQ4blNK?=
 =?utf-8?B?K0xoK2plamlCRllFekdxQUNFQVh0aVlFREF3TVNGc05uVjlTMk54TkZRQ2pH?=
 =?utf-8?B?Z1R2Tndtbm9XZmdQSVZGVUtzVmZEcGxlTE1mQzQzV0lFdjdCSytXeHdQNHJG?=
 =?utf-8?B?WDRHZ1FzMUh4cHpycER0VnVZVS8vVmdsZytHc0ExMXlWYjB3dmNHUzFRcVFO?=
 =?utf-8?B?TUx3VllzWGVkWEowSEVDVjlXT0RyRGtzYkw2cGtOeFBjaFpTYzNSSm5lR0Vh?=
 =?utf-8?B?TThnbVVpNnpHRHkrVmduZHFLd2FNYlAvYklNb0M2T2d3VUk4WHpUV1pTRktl?=
 =?utf-8?Q?5HIg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1030a78b-f66a-4e9e-b85c-08dbf1a6ff07
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 13:19:34.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lboJZt44QIj/CEaiJ8sROU6y+kzjywNkr8qiAdTJC8+fhvsBmx8J/IJajTEjHSbnya5mCDHWzlT8osmDXIEGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIExvZWhs
ZSA8Y2hyaXN0aWFuLmxvZWhsZUBhcm0uY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI3
LCAyMDIzIDg6MzYgQU0NCj4gVG86IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT47IEFk
cmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+OyBEYXZpZA0KPiBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZp
ZGlhLmNvbT4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIG1tYzogc2RoY2kt
b2YtZHdjbXNoYzogRW5hYmxlIHRpbWVvdXQgcXVpcmsgZm9yDQo+IEJsdWVGaWVsZC0zIFNvQw0K
PiANCj4gT24gMTgvMTEvMjAyMyAxMzo0NiwgTGltaW5nIFN1biB3cm90ZToNCj4gPiBUaGlzIGNv
bW1pdCBlbmFibGVzIFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTCB0byBzb2x2ZSB0aGUN
Cj4gPiBpbnRlcm1pdHRlbnQgZU1NQyB0aW1lb3V0IGlzc3VlIHJlcG9ydGVkIG9uIHNvbWUgY2Fy
ZHMgdW5kZXIgZU1NQw0KPiA+IHN0cmVzcyB0ZXN0Lg0KPiA+DQo+ID4gUmVwb3J0ZWQgZXJyb3Ig
bWVzc2FnZToNCj4gPiAgIGR3Y21zaGMgTUxOWEJGMzA6MDA6IF9fbW1jX2Jsa19pb2N0bF9jbWQ6
IGRhdGEgZXJyb3IgLTExMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFN1biA8bGlt
aW5nc0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWR3Y21zaGMuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9mLWR3Y21zaGMuYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5j
DQo+ID4gaW5kZXggM2EzYmFlNjk0OGE4Li4zYzhmZThhZWM1NTggMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+IEBAIC0zNjUsNyArMzY1LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhDQo+IHNkaGNpX2R3Y21zaGNfcGRhdGEgPSB7
DQo+ID4gICNpZmRlZiBDT05GSUdfQUNQSQ0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNp
X3BsdGZtX2RhdGEgc2RoY2lfZHdjbXNoY19iZjNfcGRhdGEgPSB7DQo+ID4gIAkub3BzID0gJnNk
aGNpX2R3Y21zaGNfb3BzLA0KPiA+IC0JLnF1aXJrcyA9IFNESENJX1FVSVJLX0NBUF9DTE9DS19C
QVNFX0JST0tFTiwNCj4gPiArCS5xdWlya3MgPSBTREhDSV9RVUlSS19DQVBfQ0xPQ0tfQkFTRV9C
Uk9LRU4gfA0KPiA+ICsJCSAgU0RIQ0lfUVVJUktfQlJPS0VOX1RJTUVPVVRfVkFMLA0KPiA+ICAJ
LnF1aXJrczIgPSBTREhDSV9RVUlSSzJfUFJFU0VUX1ZBTFVFX0JST0tFTiB8DQo+ID4gIAkJICAg
U0RIQ0lfUVVJUksyX0FDTUQyM19CUk9LRU4sDQo+ID4gIH07DQo+IA0KPiBfX21tY19ibGtfaW9j
dGxfY21kOiBkYXRhIGVycm9yID8NCj4gV2hhdCBzdHJlc3N0ZXN0IGFyZSB5b3UgcnVubmluZyB0
aGF0IGlzc3VlcyBpb2N0bCBjb21tYW5kcz8NCj4gT24gd2hpY2ggY29tbWFuZHMgZG9lcyB0aGUg
dGltZW91dCBvY2N1cj8NCj4gQW55d2F5IHlvdSBzaG91bGQgYmUgYWJsZSB0byBpbmNyZWFzZSB0
aGUgdGltZW91dCBpbiBpb2N0bCBzdHJ1Y3R1cmUNCj4gZGlyZWN0bHksIGkuZS4gaW4gdXNlcnNw
YWNlLCBvciBkb2VzIHRoYXQgbm90IHdvcms/DQoNCkl0J3MgcnVubmluZyBzdHJlc3MgdGVzdCB3
aXRoIHRvb2wgbGlrZSAiZmlvIC0tbmFtZT1yYW5kcndfc3RyZXNzX3JvdW5kXzEgLS1pb2VuZ2lu
ZT1saWJhaW8gLS1kaXJlY3Q9MSAtLXRpbWVfYmFzZWQ9MSAtLWVuZF9mc3luYz0xIC0tcmFtcF90
aW1lPTUgLS1ub3JhbmRvbW1hcD0xIC0tcmFuZHJlcGVhdD0wIC0tZ3JvdXBfcmVwb3J0aW5nPTEg
LS1udW1qb2JzPTQgLS1pb2RlcHRoPTEyOCAtLXJ3PXJhbmRydyAtLW92ZXJ3cml0ZT0xIC0tcnVu
dGltZT0zNjAwMCAtLWJzc3BsaXQ9NEsvNDQ6OEsvMToxMksvMToxNksvMToyNEsvMToyOEsvMToz
MksvMTo0MEsvMzI6NjRLLzU6NjhLLzc6NzJLLzM6NzZLLzMgLS1maWxlbmFtZT0vZGV2L21tY2Js
azAiDQpUaGUgdG9vbChhcHBsaWNhdGlvbikgaXMgb3duZWQgYnkgdXNlciBvciB3aXRoIHNvbWUg
c3RhbmRhcmQgdG9vbC4NCg==
