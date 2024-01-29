Return-Path: <linux-kernel+bounces-42176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AE83FD75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7266281CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C62433B4;
	Mon, 29 Jan 2024 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e52zXusi"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDFEED4;
	Mon, 29 Jan 2024 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504839; cv=fail; b=u7pLpNuBbv14SQF062sbc/7u8ZVkTr7gkbpL0BP6+0D68/METnseAe21gtjRegsH1lOfIMT/UbWW/mnzzHombwZECdYAhuNy3Bw82d/sCJ75ac0BqMYMRQOwzKNd8wQdyvi+dEP7HRZZmAGCuYFZnvSKghyjYO0z/ccjnJh99yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504839; c=relaxed/simple;
	bh=xku1cF5NV0hk+Rzk7wvp752jSZmelNlaEKszKsJpIRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCn25+n8UfZH3GWs4DlNMGylW/H9Nifc4SKqP7qp3raUZc0QQHIdWsKIvhgEcBjnPTcDd9sp77ANRzmdxP8oigPZPT2IfCSAYb3Foniz68WiFrvIIJ45r3GuSoVvZ06nWlZO0b02qRjfs3uXUqYTPyQ+aV37qtrvD89r5kDVxwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e52zXusi; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8iF7RKy1mfkiD9idk72mLSHt7Nl8GdFMzK5qzypVp+Kd6FyOgenxM1rRwkvZcYqha9MQ8GGDACDROTlgyKmw5oKkeiwLt0btbbPqcAyoe1BmX54a97b3OzhqtE/FOlXrP2NBcXFBrVkCau2p1WqFJZ54cc+309DQdhvNNGytg3/djY5SnFa2k95uqPYpZLYwjPoopGSzdfVk0bL9aaO7qAjCix6ZPjhnnvtcdMax/taOgwYU6Qy8unrQV3M6+YPNaL9JAs8FnvQulvdY2x7FyHNF1XIh6/XQfhqm1VZ9xYwVFov/rsG3t7sMIFldxfBJpQcBgxK2AKASCf1ziE6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xku1cF5NV0hk+Rzk7wvp752jSZmelNlaEKszKsJpIRk=;
 b=a9Iv7dcEVxHnqC6qK4qfdMBAF/tmQewTIGkVkDFXs/mbrFCEn7X3JVCax5t8BLUFz1gSzWF+bYrBjtn56MtpImRU8FvhUVGZEWjtjQMqve8VpEUCofJRGpcE6E1WxAFoJNfk0WrxabWbmQXxk045GAGwHVBdCuF1iPILbPM1oeyuM/ak8cpCfeHIVAqSW8S3nwm2llzdyXh2jJKb4tW0OsbYUcvL1dGjgyofsc1cJv/bAJfETdaeBtdqf3ZcJ7CRwKuYVAXOWE3hzOagAh9wqAYMrGfE2GyrJ1TqDfWg2vTRKQ6gj6cLTMnlz2brC22vxh1gdU6P//0jGVjAEAULVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xku1cF5NV0hk+Rzk7wvp752jSZmelNlaEKszKsJpIRk=;
 b=e52zXusi6YZOsUBcOL+GRd5RR7+De/QOAqp4EOtXR/G+T4x+CbE/gheqwFSkvIoYxo3xKox2Vrm0QRt8lUgJL0/Y1pZ//ftsWcx9chyqEWKlklDn1D2vWlTsjhPTVMRvhoqmZpPPEQisq9eH2eN2oXvkrjjiWYg4AmfWsTUSJpQ=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:07:12 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 05:07:12 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/7] Documentation: cpufreq: amd-pstate: introduce the new
 cpu boost control method
Thread-Topic: [PATCH 7/7] Documentation: cpufreq: amd-pstate: introduce the
 new cpu boost control method
Thread-Index: AQHaUDfRtnNhE1qcEECbv+ZVHkNfAbDsPWCAgAQDfnA=
Date: Mon, 29 Jan 2024 05:07:12 +0000
Message-ID:
 <CYYPR12MB865528E6FD5D537577749B5C9C7E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
 <1be9c97cafb1406a607184ea48dcdae883dc4cd0.1706255676.git.perry.yuan@amd.com>
 <4dd2cf49-9fd1-4ad7-81ea-8de93e8b27d1@amd.com>
In-Reply-To: <4dd2cf49-9fd1-4ad7-81ea-8de93e8b27d1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b2e70911-ed8d-433d-9eb8-12553b2c37a5;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T05:04:35Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|LV8PR12MB9183:EE_
x-ms-office365-filtering-correlation-id: 445a303f-e448-43fa-76c7-08dc20882756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2uplUUWriHifqyj3hrMCq5JGbEVJ0Ujihg2u2Fj0wAz/cUkPVGRfwSVDb875fCnOelY/wOdzPEsTLYy7Z5MWZrYLU90mo2lgHntWrf+pJqgGAKTWKIgyWmBCXs9NbODSpmyolZqJWL/I2rGgfKWKcA7+NGTCesFgFceYjCmS9+VPWeR+pe/EQ6+1+LAw6lBGshXhotBrwS5Ay0rHxRG8UOymv2zw4CpQ/5ji/7dO+jGvhWW1cRTpFXreT65Afr6ESGNyWtTMNWRPdmSDyEMz1rYKerhW7mgaUcoLmVT0H9iRb8scEZICawMTVkLv4eL09zlMWB5rX+qRCnjO4vh7hHvdFGOFrGt+a6Syad1IRHpz87jYQkDCaBaO6PjTzafXtaeeDobHG/XAvY4Uk9Zb4OXuTYvmbEz3V9W5mW8rXVafQkndrnldPVMSH2yBtYF0BQ3x0OgIafA9f3nqhb14mgEsyIw8psOHihC+bpsrm3rssK/uTv2OOoee9rADlo98hD7GwnixWic89C8gvQ4mN6ugZloQJcJj/0+AgJS4I70oPVabConx8cZE91GOZSsocbOThyILAgXpms585AbqTuaITbtUV6+RC8zISiO1WVTlF5NGyRP55/6BwZlC1BG9KIuH32/w00Lg8SobGpKQqA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38070700009)(83380400001)(921011)(54906003)(6636002)(64756008)(316002)(53546011)(66446008)(66556008)(6506007)(7696005)(110136005)(76116006)(66946007)(66476007)(8936002)(8676002)(86362001)(478600001)(4326008)(71200400001)(26005)(2906002)(9686003)(52536014)(33656002)(5660300002)(38100700002)(41300700001)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk9YSjZ3UkJsYVZnQjlkV3BhdEZld0Y3Y3N3WjZ6bGRtWTU1Rm1haWJpRHNq?=
 =?utf-8?B?S3ZiVG40R2tiZDVNcmc1UzZRcUphckUybGdaUEN3eXZhUUwxMldBMkdWTmh6?=
 =?utf-8?B?dElTcTFOaTFYZk5pSmdMK0tqaDFZemZtbzF2aTRjWHYyWlVXNkQ5VU9wMHk0?=
 =?utf-8?B?NlJmRUZ5Tk92RjFBYldFTHVYWThPeWE2OTd0WjVudENidmh4bzNUU0dHcGs5?=
 =?utf-8?B?Vkd2dDZ0MFh0RVVwcUgvMHA0SGlGNDZqVDQ2UVZYdldPNDk0ZVh3bTJiells?=
 =?utf-8?B?bGR5a1l2UFpWRmtKSG9aTWx5VGxOaGFKbEhUMnNDMkRXdTJSTjMyeStxQWha?=
 =?utf-8?B?eDhBVHJZWDl0SnAybTNGZ0Y3ZWsycG9WNEwzL3NDZFQySmVCL0F6V205K0J6?=
 =?utf-8?B?YlVXSTJQaHFRYXhYalpVNjdjYnhpcmVMclpMVFA5MVRpWFZQWTR1RndwdURr?=
 =?utf-8?B?cVBJRnl2MVJLZThCMU5oMFhDdmZudStYdFVxSkN0T050VTl3UElwdUZNT09H?=
 =?utf-8?B?YVB1RFE0YWllVEFFU2xTdy94R3VZZmJRWFp3dUg1WFRrYmNTQ08wcHYreEhz?=
 =?utf-8?B?NjIrWmgzbCtEM0xibkZ0STVxekZKb01jWnp0UlB1aXlmdVR6UjlrU2NkdFhm?=
 =?utf-8?B?YjcwQWZYN0lFby9GVDlwK0dDZXREcjZ4ZVdyTjVxQW9wcG8rQjFTelUrbGxY?=
 =?utf-8?B?TXRPdUg4Q0pDWCtQL05Tc0tWbXhtVC9pUzFmeGpKSnRRUXk2M3VIN1REVjQ5?=
 =?utf-8?B?R0lXZitBd0dxWmNXaTArS3hnQVZQSGE2UEFFUDUvOTkyUTZtak9OYUtyN1hQ?=
 =?utf-8?B?ZFZnUVFyc1RFdXRsek1LdWtMSklUbE5iVmVQdnF0TVZLVXVtZnZwK1A3UWI3?=
 =?utf-8?B?NU11MnY1WDJiZjFjemZudnIrbGg3bHRraGFnWEhyTWtiL3dxWXMyTFFkb3hy?=
 =?utf-8?B?Vkg5Tlg4L0x4VDNJQ2RZS3FSTlh6WHIra29JMVhJbzBuMk9DTlFjdkNjUzc3?=
 =?utf-8?B?ZWdyZkZmS2FjODZYR3BRT2s3eE5iWEh0QldCMUgzSTk2VkxLZkVPUEp1SFQr?=
 =?utf-8?B?VUlSdVFQMjdkc2pNcnltZjVpeklVM3JoS0wvckU5ZEFjQlJOVld1NVpQYXRQ?=
 =?utf-8?B?Skp2aVdQRURUOVYrVW50dnAxSUFLR2pDYlBESzB6Q1BZOS9tdlh2MkZhQXho?=
 =?utf-8?B?QnFqTTBkME00RW9kVFlmSTdDdkN4bm1DNVJmVFREbVk5b2xxYWpVc09rZXV5?=
 =?utf-8?B?U2h1RDBxbE4zc2lXWkhvTTNQdTIreEJabGVvNnpFbkNaeEVVNW9OVnhaQmhE?=
 =?utf-8?B?M2JoSWNEOTc1Y2FRb2VXTm5RdzZYbC9LQmZwR1dUMjJwSUlSc21Tc1pTdU5s?=
 =?utf-8?B?VjlYTzdzblZMRW1MUTRDZmtHbzlXaG9WTTdVZFZCOWJ2UnorNS9GUEtLWDNt?=
 =?utf-8?B?czhzZ1FLZExxS0h5RnEyWTZva1JTQjBqeVF3MkZISitpWStGVi9sU3VSclF3?=
 =?utf-8?B?UGNIWElzR1IyMzN5WkVCdlRqNlA1THB3UEIxZGhIdzRlRXRXSitaQjRKb0ZE?=
 =?utf-8?B?MmJXR3htWHU1aG9LMFlNQ05FRk5RSmJWUkRQZmV0RWRYVGloZ2hOOWhiRG9I?=
 =?utf-8?B?SFRpR3AxOURKcnhaMUdwTTRxZnZMS0plbDI2amhRSlA5aTlpVVJzR1ZSRGVV?=
 =?utf-8?B?bDg0dWNOSEJKZUxPVGJOQkNSeTYyb3RzSit1OTVyZ0x1cnV0c0lDcnNlM0JQ?=
 =?utf-8?B?RHVYbytDakd6MmZ0bXliSmNlQXVyd2doL09pSmdSbFRDZ1p0bE94U29kSUh2?=
 =?utf-8?B?Nm1LR1BBMUlReUVjU0gwN1F1U2ZxWUhzNi8zdGo0VVEyczAwUVFLWWY1R0pE?=
 =?utf-8?B?aFl4TnJYUWNWcDdqS0JmQW1JWVJ1U00wSEhHaVUzaGh5Umc3Ym9EOUVFdzZC?=
 =?utf-8?B?VEJTS3ZLWTUvb1lGQW81VW9ud1VKRXRSVFkwamFLMGdZclA1akRmdjJtNmgr?=
 =?utf-8?B?TTRzdys5NlVzRXdkWjFMSzJCTHpXZDd4endqVkZNN0lXL3FtR1FBTEdDZDJa?=
 =?utf-8?B?MEMyQWhmOG1KdmpEbS9SVW5uVE85NVNyb09YRmthNDlQdGNDUlhUcHZON1ox?=
 =?utf-8?Q?hNBQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445a303f-e448-43fa-76c7-08dc20882756
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 05:07:12.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTBjzzJ5nySXNW9YIW9Op2hg9h2yAGaXojf6oz5xUPBNpo6BvPXlgem4yODWvstaHfjkWzZi3FtC1HqB/ZIolg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0Bh
bWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjYsIDIwMjQgMTE6NDcgUE0NCj4gVG86
IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbTsNCj4gdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0Bh
bWQuY29tPjsgU2hlbm95LA0KPiBHYXV0aGFtIFJhbmphbCA8Z2F1dGhhbS5zaGVub3lAYW1kLmNv
bT47IFBldGtvdiwgQm9yaXNsYXYNCj4gPEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPg0KPiBDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNo
aW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4u
RHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxp
bnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCA3LzddIERvY3VtZW50YXRpb246IGNwdWZyZXE6IGFtZC1w
c3RhdGU6IGludHJvZHVjZSB0aGUNCj4gbmV3IGNwdSBib29zdCBjb250cm9sIG1ldGhvZA0KPg0K
PiBPbiAxLzI2LzIwMjQgMDI6MDgsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogUGVycnkg
WXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+DQo+ID4gSW50cm9kdWNlIEFNRCBDUFUgZnJl
cXVlbmN5IGJvb3N0aW5nIGNvbnRyb2wgc3lzZnMgZW50cnkgd2hpY2ggdXNlcmQNCj4gPiBmb3Ig
c3dpdGNoaW5nIGJvb3N0IG9uIGFuZCBib29zdCBvZmYuDQo+DQo+IFR5cG8gaW4gdGhpcyBzZW50
ZW5jZS4NCg0KRml4ZWQgYnkgVjIuDQoNCj4NCj4gPg0KPiA+IElmIGNvcmUgcGVyZm9ybWFuY2Ug
Ym9vc3QgaXMgZGlzYWJsZWQgd2hpbGUgYSBjb3JlIGlzIGluIGEgYm9vc3RlZA0KPiA+IFAtc3Rh
dGUsIHRoZSBjb3JlIGF1dG9tYXRpY2FsbHkgdHJhbnNpdGlvbnMgdG8gdGhlIGhpZ2hlc3QgcGVy
Zm9ybWFuY2UNCj4gPiBub24tYm9vc3RlZCBQLXN0YXRlIFRoZSBoaWdoZXN0IHBlcmYgYW5kIGZy
ZXF1ZW5jeSB3aWxsIGJlIGxpbWl0ZWQgYnkgdGhlDQo+IHNldHRpbmcgdmFsdWUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1wc3RhdGUucnN0IHwgMTEg
KysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRl
LnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRlLnJzdA0K
PiA+IGluZGV4IDFjZjQwZjY5Mjc4Yy4uZDcyZGM0MDdjNGRiIDEwMDY0NA0KPiA+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1wc3RhdGUucnN0DQo+ID4gQEAgLTM4NSw2ICsz
ODUsMTcgQEAgY29udHJvbCBpdHMgZnVuY3Rpb25hbGl0eSBhdCB0aGUgc3lzdGVtIGxldmVsLiAg
VGhleQ0KPiBhcmUgbG9jYXRlZCBpbiB0aGUNCj4gPiAgICAgICAgICAgdG8gdGhlIG9wZXJhdGlv
biBtb2RlIHJlcHJlc2VudGVkIGJ5IHRoYXQgc3RyaW5nIC0gb3IgdG8gYmUNCj4gPiAgICAgICAg
ICAgdW5yZWdpc3RlcmVkIGluIHRoZSAiZGlzYWJsZSIgY2FzZS4NCj4gPg0KPiA+ICtgYGNwYl9i
b29zdGBgDQo+ID4gKyAgICAgICAgU3BlY2lmaWVzIHdoZXRoZXIgY29yZSBwZXJmb3JtYW5jZSBi
b29zdCBpcyByZXF1ZXN0ZWQgdG8gYmUgZW5hYmxlZA0KPiBvciBkaXNhYmxlZA0KPiA+ICsgICAg
ICAgIElmIGNvcmUgcGVyZm9ybWFuY2UgYm9vc3QgaXMgZGlzYWJsZWQgd2hpbGUgYSBjb3JlIGlz
IGluIGEgYm9vc3RlZCBQLQ0KPiBzdGF0ZSwgdGhlDQo+ID4gKyAgICAgICAgY29yZSBhdXRvbWF0
aWNhbGx5IHRyYW5zaXRpb25zIHRvIHRoZSBoaWdoZXN0IHBlcmZvcm1hbmNlIG5vbi1ib29zdGVk
DQo+IFAtc3RhdGUuDQo+ID4gKyAgICAgICAgQU1EIENvcmUgUGVyZm9ybWFuY2UgQm9vc3QoQ1BC
KSBpcyBjb250cm9sbGVkIGJ5IHRoaXMgbmV3IGF0dHJpYnV0ZQ0KPiBmaWxlIHdoaWNoDQo+ID4g
KyAgICAgICAgYWxsb3cgdXNlciB0byBjaGFuZ2UgYWxsIGNvcmVzIGZyZXF1ZW5jeSBib29zdGlu
ZyBzdGF0ZS4gSXQgc3VwcG9ydHMNCj4gYm90aA0KPiA+ICsgICAgICAgIGBgYWN0aXZlIG1vZGVg
YCBhbmQgYGBwYXNzaXZlIG1vZGVgYCBjb250cm9sIHdpdGggYmVsb3cgdmFsdWUgd3JpdGUgdG8N
Cj4gaXQuDQo+DQo+IERvZXMgaXQgYWxzbyBzdXBwb3J0IGd1aWRlZCBtb2RlPw0KDQpZZXMsICBn
dWlkZSBtb2RlIGlzIGFsc28gc3VwcG9ydGVkIGFuZCBJIHRlc3RlZCBpdC4gIExvb2tzIGxpa2Ug
aXQgaXMgYmV0dGVyIHRvIGFkZCB0aGUgZ3VpZGUgbW9kZSBzdXBwb3J0IGluZm8NCkludG8gdGhl
IGRvYyB1cGRhdGUuICBXaWxsIHVwZGF0ZSBpbiBWMi4NCg0KIyBjYXQgL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvYW1kX3BzdGF0ZS9zdGF0dXMNCmd1aWRlZA0KDQpjaGVjayBvbiBhbmQgb2ZmIGxz
Y3B1IG91dHB1dC4NCg0KQ1BVIE5PREUgU09DS0VUIENPUkUgTDFkOkwxaTpMMjpMMyBPTkxJTkUg
ICAgTUFYTUhaICAgTUlOTUhaICAgICAgTUhaDQogIDAgICAgMCAgICAgIDAgICAgMCAwOjA6MDow
ICAgICAgICAgIHllcyA0MjAxLjAwMDAgNDAwLjAwMDAgMjk4My41NzgNCiAgMSAgICAwICAgICAg
MCAgICAxIDE6MToxOjAgICAgICAgICAgeWVzIDQyMDEuMDAwMCA0MDAuMDAwMCAyOTgzLjU3OA0K
ICAyICAgIDAgICAgICAwICAgIDIgMjoyOjI6MCAgICAgICAgICB5ZXMgNDIwMS4wMDAwIDQwMC4w
MDAwIDI5ODMuNTc4DQogIDMgICAgMCAgICAgIDAgICAgMyAzOjM6MzowICAgICAgICAgIHllcyA0
MjAxLjAwMDAgNDAwLjAwMDAgMjk4My41NzgNCiAgNCAgICAwICAgICAgMCAgICA0IDQ6NDo0OjAg
ICAgICAgICAgeWVzIDQyMDEuMDAwMCA0MDAuMDAwMCAyOTgzLjU3OA0KDQpDUFUgTk9ERSBTT0NL
RVQgQ09SRSBMMWQ6TDFpOkwyOkwzIE9OTElORSAgICBNQVhNSFogICBNSU5NSFogICAgICBNSFoN
CiAgMCAgICAwICAgICAgMCAgICAwIDA6MDowOjAgICAgICAgICAgeWVzIDU3NTkuMDAwMCA0MDAu
MDAwMCAyOTgzLjU3OA0KICAxICAgIDAgICAgICAwICAgIDEgMToxOjE6MCAgICAgICAgICB5ZXMg
NTc1OS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQogIDIgICAgMCAgICAgIDAgICAgMiAyOjI6Mjow
ICAgICAgICAgIHllcyA1NzU5LjAwMDAgNDAwLjAwMDAgMjk4My41NzgNCiAgMyAgICAwICAgICAg
MCAgICAzIDM6MzozOjAgICAgICAgICAgeWVzIDU3NTkuMDAwMCA0MDAuMDAwMCAyOTgzLjU3OA0K
ICA0ICAgIDAgICAgICAwICAgIDQgNDo0OjQ6MCAgICAgICAgICB5ZXMgNTc1OS4wMDAwIDQwMC4w
MDAwIDI5ODMuNTc4DQoNCg0KPg0KPiA+ICsNCj4gPiArICAgICAgICAiMCIgRGlzYWJsZSBDb3Jl
IHBlcmZvcm1hbmNlIEJvb3N0aW5nDQo+ID4gKyAgICAgICAgIjEiIEVuYWJsZSAgQ29yZSBwZXJm
b3JtYW5jZSBCb29zdGluZw0KPiA+ICsNCj4gPiAgIGBgY3B1cG93ZXJgYCB0b29sIHN1cHBvcnQg
Zm9yIGBgYW1kLXBzdGF0ZWBgDQo+ID4gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPiA+DQoNCg==

