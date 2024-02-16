Return-Path: <linux-kernel+bounces-68588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EA857CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299EA1C221C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5BB12882B;
	Fri, 16 Feb 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkRgyJcc"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F158203;
	Fri, 16 Feb 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087207; cv=fail; b=DtQbjVMm/3qfKUmN/s8axRPOwZv7BhHaI4rc+Yo4ilxjjYJxgoU/vHd8VEjtNBklq8YuSfCDhLWdpFBLBl7SWkQU7fHlb3tIiTNILi5WdgmH/Lc6BsZS+stpH0QAll2UycF+gT1eSgYuNi2n6996tUatS6dnqqxaVXaK5mWqxrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087207; c=relaxed/simple;
	bh=1OoDRa/XWtkENgndcVGEXSS8tw/inLeF1RkwZnfrky8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ljc9LmWJ9L7gZdRClgkz6p188QKJej5YsdwdoS4C5nsUMT4WFTlMeJWAz9l+gfSGAQKDbvvpqob8nM4a6QJPNQa9C1HMWI5jz0QgbRlC2cst08e8eWZe4qMYfE0yoewclALOhn3JFI4ytIFq4ivGwgoLDn/qB+UYX2SCb51RD8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkRgyJcc; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOiG7ANEMSAAW80PWC6cxlOpO3KZ2k6g5E0X9uuqUkCaWAiD9wsRStBqbBs4GekBGFCKRz3AzFyLLTlAT1dBIDt6/Q4vd0yg5GSCKTGzElprXkhvbSgKGAvlatatU40fEui/QdYN11OgpiSDuLDA+fQbTNxzBUu8zTtzBqat2j7hCCJnlCUuwFJTVqjlqXQaTm5FkpFCwnU2mi09UROl+K3bJNAs0KhI8XSMqJz2l53SRfvLkbyfUx9MyPMrjoD68p0U2/r6QF4uygGPWlVIM52eWLAs2hSSUBbDLYM/tto+MDw5ukBGTtpHhzgOtUq7VzqrdeAGAr5rUCKVS759+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OoDRa/XWtkENgndcVGEXSS8tw/inLeF1RkwZnfrky8=;
 b=kbULJKeke3VcxM1wh2SEwrbmAy176cByg10oWLfpT1BMCqsSbGLayFq/34iunQ6tezlm3PBva5fZ8FYgdtS4RvOd/ShBJonTC9JzL84gfBMjgXwAlJnAlFYsjC1cWe+nAxq/jsyuR/9B+gP9kTrrLxV4tncTgjpYqPzRluMU+Bi3y3Dn6n6V4F9M1mo9y4l5FGfk2mNdRkCQMD+qwLcw8+0VZE6+T0VsIF6xAcrbEY+YPYPAol1z8V/wkW+AfldZ2qcon+MhXGQjobt0L72s6tEspI6LZgrIDWYBkxdO9uGzoBH2afT2tJVyWb0wgeSetrCI690YffK3NDTXauVYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OoDRa/XWtkENgndcVGEXSS8tw/inLeF1RkwZnfrky8=;
 b=gkRgyJccljg9ioAesxHf+BdiKtRyxtRmfngYp02G+hfF+PoKF8CVcJFw4hYsNLs/gzAGYrD1gap6nu8aA/aMURjYtP/1hG3CgGk8A3JuJVfEjL4o3QHxv2/TJKynQjuj8ppmGWUDWnOIsC8PYbSeN1wXH5ZHxqILyEcxj4P7WkNyqCdfFnjreDEwknFp+UCyI4e1dP1hzJbnq00iwQSkjhWTyuVJNJQiiwfbJwMGG45fW9OU/Cdj6F+cJ8VGB/eXlnflbhdjKKO4YC2jXdAx8rSv3CqR51cBywGDUsd4TXyLxOLN0KEScQNZbu7wGoMydQVWligl1Swm7jyLuwmy4g==
Received: from IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Fri, 16 Feb 2024 12:40:03 +0000
Received: from IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9]) by IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9%7]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 12:40:03 +0000
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, Prathamesh Shete <pshete@nvidia.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Kartik Rajput
	<kkartik@nvidia.com>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	Sandipan Patra <spatra@nvidia.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc/tegra: pmc: Add SD wake event for Tegra234
Thread-Topic: [PATCH] soc/tegra: pmc: Add SD wake event for Tegra234
Thread-Index: AQHaYK7sRrXCgq4S8kiezeGwvtHyoLEM13cAgAAQm2A=
Date: Fri, 16 Feb 2024 12:40:03 +0000
Message-ID:
 <IA0PR12MB89066D862A24C2E2BF27F2DBB54C2@IA0PR12MB8906.namprd12.prod.outlook.com>
References: <20240216080450.456135-1-petlozup@nvidia.com>
 <CZ6H177U2UI5.2451NH03W3643@gmail.com>
In-Reply-To: <CZ6H177U2UI5.2451NH03W3643@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8906:EE_|DS0PR12MB8271:EE_
x-ms-office365-filtering-correlation-id: 514cf7d1-b2ae-4c65-44f4-08dc2eec65fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /9B27HZcugkqscjbAaLtwqQbUjAg86dTWjche4su3MwWthsYsC6TQ3ZJYucvj6JFQ7o0rQeQVbHbG9flaBr6qA/u0EfC4AKJkYS1AqEkpyPoHflw2u+/j2wG6yn26dZFx5xx6eq92LKCTDYg7bP1GjxiGJHiAfKoChCBHoX9J3V2jIqxvRWbdQrudbl4fcL4BaYJSVbGq5NVjQsvP91yBLpL9rSys3B39W3m11wvmENujGM/emS0qtqB+ONJt+32ukECEzgb9Q8sZM6Uo7AeAQuWpgyHLLhs3BMkybRqYlcGULgq+j25thQ2TGcr1dVhQz4/xxX6SJvL5NSf/GqFKT1AMsWtSgvzNIRcMcU+waV+BaAjFCcupD9TBS/SyWS2Q7to8BxmfMgu68jVn3EIvYTUehQEDBfU0atmaq1ZiJfDnbXPmgP3yAbcY0v5gpY6fdZFLZ48OJf5QzglJcUKPZXsxv7EaBXF6MoTHuZjS+4xeoHFVK3A+2R1RvE4MrAvJofiKr8ZYqqGG3ITZXq78Uxk6+5cBTwDY898NrblIEgQ9MQe4Jq3qYYkrpQkNMMlzNj5Dq8YpVoG1BKfuSOUay7//PFXn3VN2UoNd/kbFnasQZJRw+p98ZAHO8GcZKLqnBp5T8fYaHrWUsC4LZoIkA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(478600001)(41300700001)(66946007)(2906002)(64756008)(66556008)(66446008)(8936002)(8676002)(5660300002)(76116006)(52536014)(38070700009)(110136005)(316002)(9686003)(7696005)(71200400001)(66476007)(6506007)(83380400001)(122000001)(921011)(26005)(33656002)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlFaWW5YWXJsMUQzM2pyUGZxcXJkMzZnRTRpWk50NTF2czJvTnN0K1V1Si8r?=
 =?utf-8?B?RlM3OGJCaFNMU2c4UGxvQjQ5QzAwTWRtVENKRm0wU0VBR29nVm0wb1pOY2ZP?=
 =?utf-8?B?WUsvUmljbERydFJjNFBra0laSGNUSi81cVVTL0JrZUhNVnp3Wm1EbkgzdDUz?=
 =?utf-8?B?QWF2UW1wTzBpbCtxREdMUGw4S3Iza240clJlSHhEYS9xdzQ5dUhNQkhiekhG?=
 =?utf-8?B?Z0JSUS9GVnhtcnhkdXRad3BDWGFCbW01d3dtZFZuNWJiRFRLSlRWVEFaRFVz?=
 =?utf-8?B?Si8yWllhK1A0VEI4dWRGN0tneXBVbFdmTjhIT01kNmZyWVpQdWFQMnliQXlm?=
 =?utf-8?B?YW9IbjdlMVNOMU16NzBKb1NkUEtjVEtha2ZhRlV1SjFUdUlIbnp5ZEtXbnBG?=
 =?utf-8?B?R2FXMEdrd2FycnpSZExES2FlQml0RExOekR0WTV5TDI0YVEyZnBYUHl0N2Fz?=
 =?utf-8?B?eGlGQllPOE8xY0grdnhveUlucUE3blNrSVlzeStUYTRKaEhoWlJKMWEwTU13?=
 =?utf-8?B?dkVtK0NTSGtQbDdyL0x6YVkvKzZhcUFySmNKVEZIT1ovbUhwL0hJeHVZcm4w?=
 =?utf-8?B?RlRBbHlKQjBFS2F2WXlkWVc0bzVSdFhqeVpQTXV5azdwYUo5ZVBPRXAxSUV0?=
 =?utf-8?B?aStLUzZHNjRSK2VPeksxVDdUSzBCd0pXaVZaUnNOWFlBcE1yM0c4L3oycVJp?=
 =?utf-8?B?Q24yUXR1V2FtY3BtOTIxeVdQQzJCS25ITUtNTno3Q3Fpa3hLMm1OS1UzTzNz?=
 =?utf-8?B?N2lCRHpBUmJxUS9sWEQyRjRQc3lOQm5OR25MOHo1NW9DbERLTWlLRDFLNmZO?=
 =?utf-8?B?blNCcEgzaytrcEFvUW1RTTE5dXpRc3laTXF0aExlQ1l6M0x1a215aGFDVzRY?=
 =?utf-8?B?RVp5T0xDMVJ0UzlwRTlkVkgxVmMzc3BrWE8vdFdyOE1rZERhUFBjeGVkc0NY?=
 =?utf-8?B?Y0E0d2Y1TXcyRmdQdDZLZ2RqcHVnOVJJY256RzJzN0U2b0VhaVlaQzVnSjN2?=
 =?utf-8?B?Y2dQZVBsc0dCS1BCTWw5V3Fad3N5RnVSb0gvNFlVNmpLYWgyTmNtbDVuMlRB?=
 =?utf-8?B?bnp3Q3p0UUJ4by9zN2dPNW1xYTNYSHFwVmk5alhRMVlBZGtxTVJ6ZlB3MW5J?=
 =?utf-8?B?T3BXakM2K3dLdkV4UTdBQnBFYUZFZUQ1M280QlZjbzNOd21HcDlML2FiTEN5?=
 =?utf-8?B?ano3dWp3WXB0MFdkK3BsN25iUkNJN1E2bU9odkQ5RG1XdnRuT0krQTNJeEoy?=
 =?utf-8?B?TmxUY25sZ1R6Y3VLMVh3UXdoZm53ejNEZVdtTFVzM0tIT2JWV1FOWTMwVkc0?=
 =?utf-8?B?YzhKbmxwTUtGUnkzUVNWZDIrcXJzdkJtdTBJb2J5blJHcE9YOTF1N3JDanVK?=
 =?utf-8?B?WlJWczcvZXFUYlNmZndCRGhqT3oweml1bFordVZrYkdia1l6TVJjb3dqM25P?=
 =?utf-8?B?U1YvS1NlVEMyMDRHVmhNdGZsaDcxRys3UWc0U1NDSlhWdC9hcWdvUnlGdjZB?=
 =?utf-8?B?OEloU1BWRFBhS1FBalBTVUpNUlV5eU5uanQxTi80US9rZmhzR2xGNHFGeWdP?=
 =?utf-8?B?dW9GZjVlUENQanRhM2Mwb3cvNzlyaHlCTnVrWkkxOU5FdnB3YTlLZkR6ZWtG?=
 =?utf-8?B?dFNBbGhkYWJLZmhSckY0U0VwM2M0Q2dOdmR1SVFZWmJFeXpCNU1CaTFUWUFn?=
 =?utf-8?B?M0lEZFRmS3NVSEM5MG1RemZYaVBLSkNDd0JoanFJNDBnZ2pPK2JZdTJ1R2J0?=
 =?utf-8?B?K3RkQ1U2OUhEWlN5d2pLQy9mS1UyUEs0ZDF2bktWUjlGcnh2ZW5GVFZlNWx6?=
 =?utf-8?B?TXhkY3ZpT0puRjh1R3N3MHdhVzR1WXpQSXZ1YjZ0ampxZDdGQ3B3UFZMM3RY?=
 =?utf-8?B?N0tMZUJhZmhzRWtTdUd0R01yQkg2T2VzYWJ5NSs2M1gwbVlFdXh5L0NsYWdJ?=
 =?utf-8?B?blhPcVkrTEhTZzFTRHBLZEsyZWswL0k3N2VaMFA4Vk0yUTM3WE92NGttMXFp?=
 =?utf-8?B?M0RYa3hWems3dEdLQzRyWUtUaGljb1BPSmlwTndiUFkvT3VrTWp5MTRiaHJV?=
 =?utf-8?B?ZU1ONjk2Y28vTGlnWkZpMThQMWFzdFdDZ1pPaksvS3hJM1YvbWRxVkRKYTFI?=
 =?utf-8?Q?L05n71ToiSu/jDrt8f+jpY0bx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514cf7d1-b2ae-4c65-44f4-08dc2eec65fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 12:40:03.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WC4uTyptzBurlR7z5rZy991V11/ieKews3tbZGEbBF5bPP4TcA/0Pl8eAr2K6G38JuaFUsGQWKtpNxXUfQF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

PiBPbiBGcmkgRmViIDE2LCAyMDI0IGF0IDk6MDQgQU0gQ0VULCBQZXRsb3p1IFByYXZhcmVzaHdh
ciB3cm90ZToNCj4gPiBGcm9tOiBQcmF0aGFtZXNoIFNoZXRlIDxwc2hldGVAbnZpZGlhLmNvbT4N
Cj4gPg0KPiA+IEFkZCBTRCB3YWtlIGV2ZW50IGZvciBUZWdyYTIzNCBzbyB0aGF0IHN5c3RlbSBj
YW4gYmUgd29rZW4gdXAgZnJvbQ0KPiA+IHN1c3BlbmQgd2hlbiBTRCBjYXJkIGhvdC1wbHVnL3Vu
cGx1ZyBldmVudCBpcyBkZXRlY3RlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXRoYW1l
c2ggU2hldGUgPHBzaGV0ZUBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGxvenUg
UHJhdmFyZXNod2FyIDxwZXRsb3p1cEBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3NvYy90ZWdyYS9wbWMuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy90
ZWdyYS9wbWMuYyBiL2RyaXZlcnMvc29jL3RlZ3JhL3BtYy5jIGluZGV4DQo+ID4gNmRmY2M3ZjUw
ZWNlLi5kYzRlYWIzMTkxYzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvdGVncmEvcG1j
LmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy90ZWdyYS9wbWMuYw0KPiA+IEBAIC0zLDcgKzMsNyBA
QA0KPiA+ICAgKiBkcml2ZXJzL3NvYy90ZWdyYS9wbWMuYw0KPiA+ICAgKg0KPiA+ICAgKiBDb3B5
cmlnaHQgKGMpIDIwMTAgR29vZ2xlLCBJbmMNCj4gPiAtICogQ29weXJpZ2h0IChjKSAyMDE4LTIw
MjMsIE5WSURJQSBDT1JQT1JBVElPTi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4gPiArICogQ29w
eXJpZ2h0IChjKSAyMDE4LTIwMjQsIE5WSURJQSBDT1JQT1JBVElPTi4gQWxsIHJpZ2h0cyByZXNl
cnZlZC4NCj4gPiAgICoNCj4gPiAgICogQXV0aG9yOg0KPiA+ICAgKglDb2xpbiBDcm9zcyA8Y2Ny
b3NzQGdvb2dsZS5jb20+DQo+ID4gQEAgLTQxOTksNiArNDE5OSw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdGVncmFfd2FrZV9ldmVudA0KPiB0ZWdyYTIzNF93YWtlX2V2ZW50c1tdID0gew0KPiA+
ICAJVEVHUkFfV0FLRV9JUlEoInBtdSIsIDI0LCAyMDkpLA0KPiA+ICAJVEVHUkFfV0FLRV9HUElP
KCJwb3dlciIsIDI5LCAxLCBURUdSQTIzNF9BT05fR1BJTyhFRSwgNCkpLA0KPiA+ICAJVEVHUkFf
V0FLRV9HUElPKCJtZ2JlIiwgNTYsIDAsIFRFR1JBMjM0X01BSU5fR1BJTyhZLCAzKSksDQo+ID4g
KwlURUdSQV9XQUtFX0dQSU8oInNkX3dha2UiLCA4LCAwLCBURUdSQTIzNF9NQUlOX0dQSU8oRywg
NykpLA0KPiANCj4gVGhlc2UgYXJlIGFsc28gbWVhbnQgdG8gYmUgb3JkZXJlZCBieSB3YWtlIElE
LCBzbyBJJ3ZlIG1vdmVkIHRoaXMgdXAgdG8NCj4gd2hlcmUgaXQgYmVsb25ncy4NCj4gDQo+IFRo
aWVycnkNCkdvdCBpdC4gVGhhbmtzIGZvciB0YWtpbmcgY2FyZSBvZiB0aGlzLg0KDQo=

