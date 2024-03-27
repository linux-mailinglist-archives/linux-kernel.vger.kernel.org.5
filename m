Return-Path: <linux-kernel+bounces-120341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD588D608
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83F91C23031
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EE17551;
	Wed, 27 Mar 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wTw2q6I"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2099.outbound.protection.outlook.com [40.107.237.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335ADE572;
	Wed, 27 Mar 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518452; cv=fail; b=rRdwiPSqODfZ/g/NyrWm31/N/bLRsqSIzQy97wAQEoN9Hsjz91CDIKeHr1lZhuRV8DP8o6VGoeOiZV4qTTZlh+8JgQhPz44lVfUGRYg24t7OEp5eAvY+9dpEbnUFSRBV8U/DfYFtcKXKb7fvKOWmne6ulhZIsahl8+0RkXnW7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518452; c=relaxed/simple;
	bh=iILEKhth5B62m+VcoNe8f8QWdkde5Au7fpy5nOieKU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOLp0zJClGrFQAKXDVH61SUq4XQQVKi3D7RbgO5zQ3h0oWYtwSFcZmo9ucXAyjJOUxHjRZZKuTvmMUXqnBRdURLLKYJaa77GwN9Q5JO8oyp9OWJz9uYF6fmAfXqjl9MTM9yAFAaC2rCkFUcNrB+FzjIWdRTb+x0F27gZ876Or1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wTw2q6I; arc=fail smtp.client-ip=40.107.237.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0radUQ/Bn/pP/qpQ7Tm3UiPLdG2B0PCtqWpUB9S3hh8MOv7aZE+Td4Q9rw0SvrYn9WaicYWN6AVk80dgqczCZ2eY1V2ixXG+NY/lVMY7ETnVHP1DT/N0ereQZu9rcpFUfoplJPWnbEqHbwG3XE2UQFVX7/Buyg5qktgHtyiU4TsZUZEPwcAgRTG+vTKHiR/ZgKj33ZRlYGFIBzHrY/U0u/8LJxKGQ5o005x76GCmZzfX/o+31ib7TqTRwdB0oefTrrh6PxiSOiNby00fAVEgQPcP/vwXd8CLi3bsyyqcG4bqCmLOJmGAPsP4QWCB39Cf/WipNjTxtIEMrUC2M7ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iILEKhth5B62m+VcoNe8f8QWdkde5Au7fpy5nOieKU8=;
 b=nZXpPch+57FBo/n/9KYIJtmNdHUtw7mMHfzDjpMyZHW5cQnEKez6NGl0O5cFDXY/6RsiNnDNYk76xpfoRD8BR+H/tlu3wKbJ33h+Yc83tUkhSqgJGca2NPcrBIthYRgccAPqbJ2x3Yba32nTAoKrSUSlDWte1Jy2pSm2rs4Cdn9FhV3S4lZicgSRUGs9VVmo3NThabGF1719E9KLVE77EvluEoaeOOJtUi3xZRlpTAa4rfBfQFdMnXrnvh10NKBS3LvxzG04Nomb6ogiakG3bXBG3m7Lic0fGmCqHCVtAIZlfbGUEn04pzp/kQa1msRjrW1UzzQhIVxNOHP0Yj8NaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iILEKhth5B62m+VcoNe8f8QWdkde5Au7fpy5nOieKU8=;
 b=4wTw2q6I/jgmjd1BJ+uVrpLpzHMl611jYrxebJb/UQ5x2oIA9EV8AIgvNqaUNt/QDWRHg6SkJBdcOBmpQ/hUkXHjVp/rhs9Fy+xpXX7n0cx8ZXFWO4Z3GZG9k/iBLnuq114dco2jLLzSvDUPOduMudMHvI/kZPa/VszyIvfc/RU=
Received: from PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 05:47:28 +0000
Received: from PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::60e8:2b67:3927:b3bf]) by PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::60e8:2b67:3927:b3bf%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 05:47:28 +0000
From: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>
To: Stephen Boyd <sboyd@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Topic: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Index: AQHaPhVjvmRGRPQ6SUKSkOvyusaGNLDI1osAgGNW7YCAH2plAA==
Date: Wed, 27 Mar 2024 05:47:28 +0000
Message-ID:
 <PH7PR12MB728433875E7B7DD673E8785D8A342@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
 <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
 <PH7PR12MB7284F36E51750D47102410448A202@PH7PR12MB7284.namprd12.prod.outlook.com>
In-Reply-To:
 <PH7PR12MB7284F36E51750D47102410448A202@PH7PR12MB7284.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7284:EE_|BY5PR12MB4050:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CLHO9XjnNIckhY+KYzDWVQpPXV4R3CB7SXfDOI3PmB5e1Fcr9ZjHMlFrgOwEi8pison3lPv2Ks/VwSC97p94O/oj9upKaw+XSBTmScJZD2BnQQWTJu3qHyfp6ZMMyg8lNN0PrVUmZ11vpLjAWCSJFzK45Sr4JF+96jlRKD4r85pRBCTFcdfCrChS4DeLSFESFLcINuVnZhCvCi9k2akDSQGvgxu26x8zRh3NIOmLHGm79aCCZwaqhRd1+8jz+lbPT/Xc9Gz+L6ArQEWl35heoOAEBIT1xiYqxXqOhymMCmZ9boyl4KsjvEe7TQwpCN3u0Fh/m1gX7M4YXU/Tfq/7TYV6lqEsO95F/4D4zVRq6lXsdLoNYPnmwJMqemH1o3tirO6DwyebMdpBsdnsVE6CcDpNbNMgrSS+EFJhStNigSsi0l6tZFKoiEPhz5kp5QsVSVvcO7nOQfws7chxMYFSlonPULVuZ0K04vkmY4110dK29/FZQ5ToH3woxDxwL+9ROCcTdg2m6XbxZOoS0LsjWG2yXc06qYZhy2y7iGeoYEHkvfaFzOYVQUkARx+Ug8eLE7LKF6fm+1kTXklE72F8NKnirGcDKBR/BMGrln1sJU/iQ8jw9kz4XTPMn+YHM0kjp0z1DpAhtGx3dx18kOKBnIPX4w+fO6+IVDSm33KR/rM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUdydWowNVAzNGpkSkZJRk5XREJIZlJwenBMNitkMHNsM3J0WmEzbHl6VFFH?=
 =?utf-8?B?VDVLQ2lYTzlUci9hZkJvTXJ2VDBJZGNNRUJaMTdBeDZkN1dyd3NtVWJmckVh?=
 =?utf-8?B?SE4yQVFxRVFEdC8ydFZWVTFrbWZvTlROU1VzSCtZZEgwMkRkQmJlOFZxVm0r?=
 =?utf-8?B?UkdldEs5K0ZxSUhOeXVCVnlLVk4ydGI3bUZZRkh0ZS9vdmpoc1R4MEFTQnJT?=
 =?utf-8?B?MTVhcmYzM1c0WFlEMWFOeWZCZE9MZmVsMXozQVgxM2hMQkVqb0JKK05mMGNJ?=
 =?utf-8?B?UCtzYzdYM2JST25neTZ6YnIvckY3a0RkSkl2aTk1UXVFcGdSVGtqd0U2NDFm?=
 =?utf-8?B?MHhxc2E2RWtFUVppRldwV2RCYktGaDNKVS94NUxNckdUVnkwMUtlTGVrL2Zk?=
 =?utf-8?B?RmZMQ0pyWklyRkJ0ZjVwTHk1VzFsenhxMFdBSG1Cc1VNUG1DQjRUQkdtQ0pp?=
 =?utf-8?B?MXZFNTEvOGdrL01mNDRlUjdlOUxIYVQ1RVRZSERubTBubUI3d2RUdUROUTZq?=
 =?utf-8?B?OTV4UTNRTitkR1dvaG9VNVFxa2lQalo0WEx0dDFLQTZRTlNkRVJuV2FUaGRT?=
 =?utf-8?B?OElxTWtXMjBmRU9RVWZ6bm5ObG52MGVtWTNLb2ZsaFkvdTY4QUhtVHZSR0pi?=
 =?utf-8?B?ZWF6MUhKNDZwSkdnWnV5SkwvSjNZcjM1Rnh1bFM2OVhUUEZKd0dKT1Mwd0w0?=
 =?utf-8?B?dUlzb1N0clVHdzRGemFoK25SK0xxdVNNbEt5VXJZL3BuQjRhWkZPR29UcExZ?=
 =?utf-8?B?dVYwcmxCY2FpQmh4M0M1Ukd0eDlET1ZvODY5aWFtU0UweUMweThVS3lLYnBz?=
 =?utf-8?B?aUp1Z1k2d0Q2R2c4OTYyNXBwNmxQeVNLT2xod29iUTZpZ0dnVVY3NmV3Wko1?=
 =?utf-8?B?dng3Sk9qVm0rM0lIZnRndkJ5Z0ttaDBoRkZqWk5CRitXR1hzTyt3UUNlQ3l5?=
 =?utf-8?B?Wi9VaWlEM3lZZ0RkK3lwZDg0YlZxVklWeDVCOVpXYS9MSjQyTElqVjJLYXdz?=
 =?utf-8?B?aUE2NHlkNnVPbWEvREZHWXRUcm5FUEZrQjZmbUlQbUpDaHpscWxNL2RKazEy?=
 =?utf-8?B?RERsNUVmZGZSRzYxVkRWdEZFZjZHb2x6ZTNhSkRtN21Pem44ZmpxbzdreDNT?=
 =?utf-8?B?MkErdlhyamJCYnlXYkNwTjdrZHcxNEN0LzFoeG52UHhDWGlQd1NXbTNPMGZW?=
 =?utf-8?B?ZC9qYkNmYVFjV20veEJ0aml1dHQ2TVprQ2JINFhIMmt3T2I1T2JFWTV1bE5S?=
 =?utf-8?B?ZElycWxDbXdRVDdpMTJFd282MkVlMytRRmhFN3gxbzRCYTZrK2dTQmk2YWky?=
 =?utf-8?B?UTdlUnlNb2R6cEo1eXhjNS9xL1BKVVhLbmhHYTYzai9ITm1RVHlYQjV6Tnkv?=
 =?utf-8?B?YVEza3VyZHZqT3BxaDYvbE5tYXZLZ2ZnQ3Q5M1ViNUJWSnFjczVZV0NHYzdM?=
 =?utf-8?B?LytDMHpPOUwvVlQyYS9ZNUVWVk84dEg2blF3Q0F2dGVqTlREU3diYlc0ODI1?=
 =?utf-8?B?MEIwS3NHdWp2dGJaaHc2N2xUTWlMZzZNdkF0dnRZVFFQczVtMllhL1lKVS8x?=
 =?utf-8?B?TWdxVjZBWHJ3ci9Ubm1ndzg5K1ozemdhSEVkTm9iN3MyaHBzV0srNUFYeWpJ?=
 =?utf-8?B?YUIzRGpXaSsrd3lUQXNuMDhPSWV1bWtnOEdva3NVamRwS3VWWURJZ3pWMHpB?=
 =?utf-8?B?OXFHenBLN0FBeVZaOEVqN0VxWTI3REpCS01FU0pSSGhDOTk3TWhKQjhNRFN0?=
 =?utf-8?B?aHByY2VtQmZOT0g2amtQRXgvazQ0aDBnOHJJM2c4Qmh1RzNPemRZTEpyeENT?=
 =?utf-8?B?K1JEZ21JQWtVQUVpTnNlRkNjVnBUNlFnYmNuOEM4dTVDSGEwOWZuVXlqRTN1?=
 =?utf-8?B?MVlLRGVTUGxsaVAwS2RGa1dJMkhpWkpWRFVLYTlVNTBzV2ZKSXNDcndLOExm?=
 =?utf-8?B?Y3phYzgzTVRtbDNveS8xcm1wNW81djVyMFZsNFkxbUlsQmppczlrS0tCZFMv?=
 =?utf-8?B?aTU4ZlFJOVRiRlNZcmlPTFAwTzNWUmY4R1ZhU0Jldm0rT05KeXFHRmg5cC8x?=
 =?utf-8?B?YVpIdzdCNGM3akxXdUs2dlE2VTY1TXpablZ6elZ5MHZsdkJ6K3ZicjQvdUtB?=
 =?utf-8?Q?Cj0c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08281ed7-dac7-4d3e-1f2d-08dc4e216361
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 05:47:28.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjM/Z8Ishn+hy10ejqFC6TnAnYtyDxPr34oTHjmgi1x4sYaMVkQI0tZjosEKotu4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

SGkgU3RlcGhlbiwNCg0KSSBhbSBhd2FpdGluZyB5b3VyIHJlc3BvbnNlIGZvciB0aGUgYmVsb3cg
cXVlcnkuIENhbiB5b3UgcGxlYXNlIGhlbHAgbWUgd2l0aCB0aGUgc2FtZT8NCg0KVGhhbmtzLA0K
TmFtYW4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVHJpdmVkaSBNYW5v
amJoYWksIE5hbWFuDQo+U2VudDogVGh1cnNkYXksIE1hcmNoIDcsIDIwMjQgMTE6MzcgQU0NCj5U
bzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgU2ltZWssIE1pY2hhbA0KPjxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IHJvYmhAa2VybmVsLm9yZw0KPkNjOiBsaW51eC1jbGtAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
Pmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSRTogW1BBVENIXSBkcml2ZXJzOiBj
bGs6IHp5bnFtcDogcmVtb3ZlIGNsb2NrIG5hbWUgZGVwZW5kZW5jeQ0KPg0KPkhpIFN0ZXBoZW4s
DQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IFN0ZXBoZW4gQm95ZCA8
c2JveWRAa2VybmVsLm9yZz4NCj4+U2VudDogVGh1cnNkYXksIEphbnVhcnkgNCwgMjAyNCA2OjMw
IEFNDQo+PlRvOiBUcml2ZWRpIE1hbm9qYmhhaSwgTmFtYW4gPE5hbWFuLlRyaXZlZGlNYW5vamJo
YWlAYW1kLmNvbT47DQo+PmFiZWwudmVzYUBsaW5hcm8ub3JnOyBhbmdlbG9naW9hY2NoaW5vLmRl
bHJlZ25vQGNvbGxhYm9yYS5jb207DQo+PmtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsg
U2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPj5tdHVycXVldHRlQGJheWxp
YnJlLmNvbTsgcm9iaEBrZXJuZWwub3JnDQo+PkNjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+PmxpbnV4LSBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBUcml2ZWRpIE1hbm9qYmhhaSwgTmFtYW4NCj4+PE5hbWFuLlRyaXZl
ZGlNYW5vamJoYWlAYW1kLmNvbT4NCj4+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJpdmVyczogY2xr
OiB6eW5xbXA6IHJlbW92ZSBjbG9jayBuYW1lIGRlcGVuZGVuY3kNCj4+DQo+PkNhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
DQo+PmNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4+DQo+Pg0KPj5RdW90aW5nIE5hbWFuIFRyaXZlZGkgTWFub2piaGFpICgy
MDI0LTAxLTAyIDIzOjIwOjE3KQ0KPj4+IEN1cnJlbnRseSwgZnJvbSB6eW5xbXBfZ2V0X3BhcmVu
dF9saXN0KCkgZnVuY3Rpb24gdGhlIGNsb2NrIGRyaXZlcg0KPj4+IHJlZmVyZW5jZXMgdGhlIGNs
b2NrIGJ5IG5hbWUgaW5zdGVhZCBvZiBpdHMgcmVmZXJlbmNlIGZyb20gZGV2aWNlIHRyZWUuDQo+
Pj4gVGhpcyBjYXVzZXMgcHJvYmxlbSB3aGVuIHRoZSBjbG9jayBuYW1lIGluIHRoZSBkZXZpY2Ug
dHJlZSBpcyBjaGFuZ2VkLg0KPj4+DQo+Pj4gUmVtb3ZlIGhhcmQgZGVwZW5kZW5jeSBvZiBjbG9j
ayBuYW1lIGFuZCB1cGRhdGUgdGhlIGxvZ2ljIHRvIHVzZQ0KPj4+IGNsb2NrIHJlZmVyZW5jZSBm
cm9tIGRldmljZSB0cmVlIGluc3RlYWQgb2YgY2xvY2sgbmFtZS4NCj4+DQo+PlBsZWFzZSB1c2Ug
c3RydWN0IGNsa19wYXJlbnRfZGF0YSBpbnN0ZWFkLg0KPlRoYW5rcyBmb3IgcmV2aWV3LiBBcyBw
ZXIgbXkgdW5kZXJzdGFuZGluZywgeW91IHN1Z2dlc3QgdG8gcmVwbGFjZSB0aGUNCj5wcm9wb3Nl
ZCBsb2dpYywgYW5kIHVzZSAic3RydWN0IGNsa19wYXJlbnRfZGF0YSIgdG8gZ2V0IHRoZSBjbG9j
ayBuYW1lIGZyb20NCj5kZXZpY2UgdHJlZS4NCj4NCj5JIGhhdmUgZ29uZSB0aHJvdWdoIG90aGVy
IGRyaXZlcnMgd2hpY2ggdXNlIHRoZSAic3RydWN0IGNsa19wYXJlbnRfZGF0YSINCj5zdHJ1Y3R1
cmUsIHRoZXkgaGF2ZSBoYXJkIGNvZGVkIGNsb2NrIG5hbWVzIGluIHRoZSBkcml2ZXIuIEluIHp5
bnFtcCwgdGhlDQo+ZHJpdmVyIHJlY2VpdmVzIGNsb2NrIG5hbWUgZnJvbSBmaXJtd2FyZS4NCj4N
Cj5BbHNvLCB0aGUgInp5bnFtcF9nZXRfcGFyZW50X2xpc3QiIGZ1bmN0aW9uIGlzIGNhbGxlZCBi
ZWZvcmUgY2xvY2tzIGFyZQ0KPnJlZ2lzdGVyZWQuIFNvIGF0IHRoaXMgcG9pbnQsIHdlIGRvbid0
IGhhdmUgdGhlIGh3IHN0cnVjdHVyZSB3aGljaCBoYXMNCj5jbGtfcGFyZW50X2RhdGEuDQo+DQo+
U28sIEkgZGlkIG5vdCBnZXQgaG93IHRvIHVzZSB0aGUgc3RydWN0IGNsa19wYXJlbnRfZGF0YSBp
biB0aGlzIGNhc2UuIENhbiB5b3UNCj5wbGVhc2UgcHJvdmlkZSBhbiBleGFtcGxlIHdoaWNoIEkg
Y2FuIGxvb2sgYXQgYXMgYSByZWZlcmVuY2U/DQo+DQo+VGhhbmtzLA0KPk5hbWFuDQo=

