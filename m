Return-Path: <linux-kernel+bounces-51992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D55B849265
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2486E281427
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409379E0;
	Mon,  5 Feb 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lI3oqi9j"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B263AD4C;
	Mon,  5 Feb 2024 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100156; cv=fail; b=EPjCjKVVvDAMGx1AMBkQlVAix3EJmBI7NllhwOrJk9uz0QkJEJ12MedmuQY4NT/WEokninczz48iNHNeT3RZrRAXVpltMmGvOR76XV6FB/YW/VOjy3HNF9H+TM4WSlpbD4d3dRvx1G8VZrKLg/5+WUyv7L36j9H70/SdlNnj07c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100156; c=relaxed/simple;
	bh=od8nnf0ufytT5u32T9g14JxBMiQyPCZ59W0IsFyWaQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlyAb65RPm2PMz87vv6uZwRmzbqN8qyOFUC5KH0419k6rxFD+6BXm8Fn+OJvgj96w/v0oIOQMPRW48bZsU0Ljhrj42JdnYaQGxtkSP97D0Z4XRACcBUW7S6QcRYcaW++wXGPHCHBLwr628PDW8gKajyW/M6cOnxatIeJEsn/fQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lI3oqi9j; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyjYqv5094amzeTftmK3YONygX/1KyHRZWSjRIzCjE5lZ1hudBQqwoKvk7ZlQdLpvhYF4/aG/Dd638BxT06aUpGk5yWbyXajOfEg8M3K4i2xuZHY9yTHwLYCZJ/2tba+YQ7IthqZKV4VOpEd7virMGrSZVKQvTKzCZh1FgV5KR0lDNy5bGuz53nOOC6ZwGN8VB1OHTc7aAlevIezme8zyjOpOfuUhONwI2WhSoHSckf2ULNOnHI8gqdhXz7htDFSdUdGIAauA96zhwFZ3yGdPlGX0juJjUtvIv3UJqV7XssHSEhX5CrupdHosW0FFdqH5XhDq1dZyeRsiuFSVI/omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od8nnf0ufytT5u32T9g14JxBMiQyPCZ59W0IsFyWaQ4=;
 b=UMCI9FAKUmOINxJ+CAh+WKv1zUOne+2QPtOfLSwP8FedZehyabRBiOg2esKz7VJ5YMDrsPukMbv/ltzrZIK70f+M7zxxvTFOvj6qrqD4PBwOg06pAPTN9i+L0JETIEGAxCEvOy+Q4BFcwBE93mtXNzcMlnE+1VujSA0ZhTTqu2QMOLaP9quoCMtpu0WqwQnSfz29U52e/6nfhZF1//pjG7AGKNuO22NuatIrTYcNtfK5fFiHWvDhGMSqKuK/hTTMGRv3Enyx1x8f/QVdOBKsxx3lPrd46C8w3WJlj5lE4qtc2x2y2bN9mohtEdlaOw7PeCn2wYbtHR8183Uhsu/ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od8nnf0ufytT5u32T9g14JxBMiQyPCZ59W0IsFyWaQ4=;
 b=lI3oqi9jKHsgLEulzQclfKxLo5nvS5smKWNsNBpQ18RniOdryLAIZBtYM1iSCV7PNkHZHjjr5joAhMbL0kT7htFCMNrg81XMd5gPf5/AJ8rfcbCU7Dn8mzxLa68Dm/ExgG1yFH0ONNQ3hP+i3/+uyBDRKM2v7Z2WtAuAjBUmooQ=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 02:29:10 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::69b9:e23:ec27:6dd0]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::69b9:e23:ec27:6dd0%3]) with mapi id 15.20.7270.015; Mon, 5 Feb 2024
 02:29:10 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Topic: [PATCH v3 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Index: AQHaVxo3qlgZyfm8w0qvGghzLuIQ/7D6Q1eAgADDpuA=
Date: Mon, 5 Feb 2024 02:29:10 +0000
Message-ID:
 <CH3PR12MB8657029084397762A2ADD6249C472@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
 <dc7fc753b596a4e262b21d2c2e8eec3570e4a97c.1707016927.git.perry.yuan@amd.com>
 <2719030.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2719030.mvXUDI8C0e@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4045d797-ef88-41bd-bfc2-dcf7f474d1fe;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-05T02:25:33Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|MW4PR12MB7238:EE_
x-ms-office365-filtering-correlation-id: e5ffab89-8f02-456e-6282-08dc25f23c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XbQe/lTvY/a7o3bmm5vzmO9SdhBJALfQoGMxjb7b1kfBVE6ANEh6+B6NkXDpAxr7J9QUZuek+dQ73hEmKAjUbK7trTjSdyv/UvxFCU+mSodK6HuCiN0BUyywPgCzwXsXHGQi9DrNpWw36ay9/QCNpHAVUZxdgy5Xoiia7ZsM2uHfV+l8XxaQsj0N+jT0KrWmtA3tnMv/Stmb3pKRpy7kEAM0Uv1PATokcNhTkcYkObk9U6Kb9UQ+1/64hq87j55s8NOsda+KVUPR45aBoLkAEPWrt+vF+czZw/PnR1SPmGH8IFDJL22VsJXNhQ+89+lTduW664qwkeARrRrOLZR7G+okIssAoCb/bGKN7FdhSWCYTpHyMcdwbv+ANcr38b36oUjxcCe6kg7hys5+wus31VqHlfI+sFNkzpLbiBydQGtYQ+KhAuJX6JduYZuxd3pZvIJ5CR3cU7yCS4AOKef71l324xRoamiRTzt/lqB2I8+gM1lHpDyyo1nBdHN1s6Qh2VTwtpozDbX8+TlTLhxSFL6u7yjJMqnTFa85E8fhSejkSYBdckr/ahf5xvjmDk1FUXckw9AM8F3gp5KsRH9vQHhy8A//4cgM7tINdNRDojnDjNBCidEhNJEJOFh9eCz25N+5LreweEXQKXI8pgBLaA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(4326008)(8936002)(8676002)(52536014)(316002)(6636002)(64756008)(66556008)(66946007)(54906003)(76116006)(66446008)(110136005)(66476007)(38070700009)(5660300002)(122000001)(2906002)(38100700002)(53546011)(9686003)(86362001)(6506007)(478600001)(7696005)(83380400001)(26005)(33656002)(66574015)(71200400001)(921011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVlKWkZWS011NW9tWUYvR3JoQXlYOWNkc0NLNHN2TEpxV3dNOFJFZTNMTU5M?=
 =?utf-8?B?WHpoaWZBWkRHRFpXRHdaS3N5OFBjdGR2dmV5NGs3cnpvb0lPTkgxcVQxMC95?=
 =?utf-8?B?TUNodjBoME51UmJwbHlqMWdKVkVJd0ljbXpRWS9KTVhQQnVwOHR4RmtvMkw2?=
 =?utf-8?B?OXROQVNPNVNUQU5Lb2hmU2pVSk5ueThiQWdUWm03RWs4SHZwZVp6cVIwaDZF?=
 =?utf-8?B?RjB3SytzWlEwTTg4VjhISi81Q0V2ajlDbk1TOE9CVDkrNlFDOW16YVhkb2Z1?=
 =?utf-8?B?WkdFd1Z3a1l1WVoydC9mYnQ5MU5PaDRRTW5ySHNLL3ZkYmZSTnUyVlZJMnpQ?=
 =?utf-8?B?aHlqSlI3REZIY0tqMld5cElmM01ZWmJRM0Nqc0RsTEQzbkFkTVpvcExveUkz?=
 =?utf-8?B?TUF1RWhmb2ZQdnVydDRJNFlCeXRJRmRYMEM0b2R2WjRTaEhYYVM0MERIN0Zu?=
 =?utf-8?B?dE5pTW5oeDdSZVNUMENqY0FTS0dQQjBPcUY3K29PeFoxb2tVVFhqdkhHL285?=
 =?utf-8?B?MDZaNkFwc2RRcGlIRHE5SUdNS2QyRTBGVjlTbHprRFJxVG1ySEd4RGRicUIw?=
 =?utf-8?B?ajVKMkFVRm1YcXhIaTcxVENQeFV3YjR0YTVWR20veWt4WHkxVjZSSjdEWTRQ?=
 =?utf-8?B?WVpDeDBnNEFldmh6TEVMNmhsZzhDSEJNMVRRcWNpNll1eEtFMEhZZHRtbk5H?=
 =?utf-8?B?OTZONG5XVUp2ZnpKQXZROEtLRHJHZnBmQ2pDMnczNmlTaUZRelJHZDJPSFRt?=
 =?utf-8?B?UTlkRTJwT3dmaVl1WS9YZUpPVGU0aFFGbGhpNW03aVVnVlNrSXlKTTV1TFZP?=
 =?utf-8?B?ZjFQRjRncUVOV20rZURrRjEyRTZRZXFlaFU0dzlLM0N3ZWFwSHl6Nm1GVlo2?=
 =?utf-8?B?dXU1b0RUa1IrdFZBRXdGMnRBYXZPZEJWMGNJQVdZM1d3VzExeFgvT0VyUURV?=
 =?utf-8?B?UW5KUVBycnhDRkVRTDA5R3RpUmtUQUo3Q2piZ1NsTUdFdVRHenBlMDY5MW1J?=
 =?utf-8?B?RlROdnNsbWplckY2UkYyaGp6L0ttaHBmcG81T3Z1RWF5U2QrbldpQk9icENI?=
 =?utf-8?B?OW5scElKNWlrSHdIOVRMdUlOaVRvaFJ6c0NIRGNZYUdtMmRFOW11cHpHSjRG?=
 =?utf-8?B?QTRHeDBTTXM0YTRYZzlBdWdSa282d0haUVNlaHltaWt2UkFQVTJWMGVlZnRM?=
 =?utf-8?B?U2dqVjNycThYbWpPTEVwN1dnOEd0cFFqYVB5SFVGNE96dFlCSC9pU3VxY3NO?=
 =?utf-8?B?NXhSS3F3M0hvcUdDd2VSdFBNYmwvYnlLNVlPdUM0SjVVQTJ6VjZ4Ynkva2hV?=
 =?utf-8?B?eWNlSU5DbzNpUThCUi94VzJTME56bnlZR1N1WGVKSzFUKytEVmxXUUpIUlpq?=
 =?utf-8?B?TWVXRE9WT2oyQXgxeFJlYkw3K3JwWFo2Y3M1MHlkaTc2UnlTRVhtUTg2ZU1D?=
 =?utf-8?B?QnF2Yi9qL2psZWFUVzdvcUc4V0VlRzlSR244RkRYK2ZyRzBIbXpTWWxoclRx?=
 =?utf-8?B?RkxvNGhTVnowRC9weHlHeGo5cTB4c1FTSzJuekp4bWpZRkFuMjNuM1JDYmNG?=
 =?utf-8?B?Vy9DY1VuSEJXVzZ1R05sTHM1bmdoSVRrelpEWVJuQndDaVZEbDlXNVFUeUFU?=
 =?utf-8?B?Sm4yemhNMHVqQTZnM09NOWFwYjMzdk5WdlZUUE5XQUxrcGVlSUsyTGlxQjRn?=
 =?utf-8?B?YzVqcWFnSEJrR1JhZXE0Nks3UzhPOXJGM3k2cFVRVzB1WlcvSEtkZkRqbTR3?=
 =?utf-8?B?Z3BpSWd0T1VkZmRmcGdBbGNyTjg3VlRhZGtpSWlKcklJZEVCL3plS2RCOWh3?=
 =?utf-8?B?bjJEZ1VRc1dNWncvYUpHZyt0U25Dd0hTUW41RGFBNEJtRzZBUW5iVG5yNVRj?=
 =?utf-8?B?SjhxN3R6Wm05aGZrcFNPOGVEOXcyS05oWGJOOGgydThVTmFsNkhXTGRIZ2F1?=
 =?utf-8?B?UFJONXhjTXEwbU45ZWVyS25SanFRREF5NDZCUWpObkdPR2NEU0E3OGEwTFpr?=
 =?utf-8?B?ZVpJWEs5SDZrVlhxNm1Zb0NZdlpTaDhRZEY2UXRieUd1SjFBS09HNHZUYVlP?=
 =?utf-8?B?cGhid0FXQUhieVdjTk40aEV3UHB4eFJFQlVleVg2UFNlZXFUQTZDcTJ4a09N?=
 =?utf-8?Q?FMPk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ffab89-8f02-456e-6282-08dc25f23c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 02:29:10.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhTg5xaOA1Vqa2jTyJwvRQYsx5t6SgEyBzFppAZTE4gPjqgr7/4a2IkqKT2s/yna8/XkOi5nYcE4aOmDkps9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5r
by5uYW1lPg0KPiBTZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDQsIDIwMjQgMTA6NDUgUE0NCj4gVG86
IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJh
eQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0
aGFtLnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292
QGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXIN
Cj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1k
LmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA2LzZdIGNwdWZyZXE6YW1kLXBzdGF0ZTogYWRkIHF1aXJrIGZv
ciB0aGUgcHN0YXRlDQo+IENQUEMgY2FwYWJpbGl0aWVzIG1pc3NpbmcNCj4NCj4gSGVsbG8uDQo+
DQo+IE9uIG5lZMSbbGUgNC4gw7pub3JhIDIwMjQgNDoyNjoxNCBDRVQgUGVycnkgWXVhbiB3cm90
ZToNCj4gPiBBZGQgcXVpcmtzIHRhYmxlIHRvIGdldCBDUFBDIGNhcGFiaWxpdGllcyBpc3N1ZSBm
aXhlZCBieSBwcm92aWRpbmcNCj4gPiBjb3JyZWN0IHBlcmYgb3IgZnJlcXVlbmN5IHZhbHVlcyB3
aGlsZSBkcml2ZXIgbG9hZGluZy4NCj4gPg0KPiA+IElmIENQUEMgY2FwYWJpbGl0aWVzIGFyZSBu
b3QgZGVmaW5lZCBpbiB0aGUgQUNQSSB0YWJsZXMgb3Igd3JvbmdseQ0KPiA+IGRlZmluZWQgYnkg
cGxhdGZvcm0gZmlybXdhcmUsIGl0IG5lZWRzIHRvIHVzZSBxdWljayB0byBnZXQgdGhvc2UNCj4g
PiBpc3N1ZXMgZml4ZWQgd2l0aCBjb3JyZWN0IHdvcmthcm91bmQgdmFsdWVzIHRvIG1ha2UgcHN0
YXRlIGRyaXZlciBjYW4NCj4gPiBiZSBsb2FkZWQgZXZlbiB0aG91Z2ggdGhlcmUgYXJlIENQUEMg
Y2FwYWJpbGl0aWVzIGVycm9ycy4NCj4gPg0KPiA+IFRoZSB3b3JrYXJvdW5kIHdpbGwgbWF0Y2gg
dGhlIGJyb2tlbiBCSU9TIHdoaWNoIGxhY2sgb2YgQ1BQQw0KPiA+IGNhcGFiaWxpdGllcyBub21p
bmFsX2ZyZXEgYW5kIGxvd2VzdF9mcmVxIGRlZmluaXRpb24gaW4gdGhlIEFDUEkgdGFibGUuDQo+
ID4NCj4gPiAkIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2FjcGlfY3BwYy9sb3dl
c3RfZnJlcQ0KPiA+IDANCj4gPiAkIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2Fj
cGlfY3BwYy9ub21pbmFsX2ZyZXENCj4gPiAwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJy
eSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMgfCA0OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0NCj4gPiAgaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmggICB8ICA2ICsrKysrDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDc3ZWZmYzNjYWY2Yy4uMjVhNmQ4YTgwOGM0IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9k
cml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTY3LDYgKzY3LDcgQEAgc3RhdGlj
IHN0cnVjdCBjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRlX2VwcF9kcml2ZXI7DQo+ID4gc3RhdGlj
IGludCBjcHBjX3N0YXRlID0gQU1EX1BTVEFURV9VTkRFRklORUQ7ICBzdGF0aWMgYm9vbA0KPiA+
IGNwcGNfZW5hYmxlZDsgIHN0YXRpYyBib29sIGFtZF9wc3RhdGVfcHJlZmNvcmUgPSB0cnVlOw0K
PiA+ICtzdGF0aWMgc3RydWN0IHF1aXJrX2VudHJ5ICpxdWlya3M7DQo+ID4NCj4gPiAgLyoNCj4g
PiAgICogQU1EIEVuZXJneSBQcmVmZXJlbmNlIFBlcmZvcm1hbmNlIChFUFApIEBAIC0xMTEsNiAr
MTEyLDMzIEBADQo+ID4gc3RhdGljIHVuc2lnbmVkIGludCBlcHBfdmFsdWVzW10gPSB7DQo+ID4N
Cj4gPiAgdHlwZWRlZiBpbnQgKCpjcHBjX21vZGVfdHJhbnNpdGlvbl9mbikoaW50KTsNCj4gPg0K
PiA+ICtzdGF0aWMgc3RydWN0IHF1aXJrX2VudHJ5IHF1aXJrX2FtZF83azYyID0gew0KPiA+ICsg
ICAubm9taW5hbF9mcmVxID0gMjYwMCwNCj4gPiArICAgLmxvd2VzdF9mcmVxID0gNTUwLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBfX2luaXQgZG1pX21hdGNoZWQoY29uc3Qgc3Ry
dWN0IGRtaV9zeXN0ZW1faWQgKmRtaSkgew0KPiA+ICsgICBxdWlya3MgPSBkbWktPmRyaXZlcl9k
YXRhOw0KPiA+ICsgICBwcl9pbmZvKCJoYXJkd2FyZSB0eXBlICVzIGZvdW5kXG4iLCBkbWktPmlk
ZW50KTsNCj4gPiArDQo+ID4gKyAgIHJldHVybiAxOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgYW1kX3BzdGF0ZV9xdWlya3NfdGFibGVbXSBf
X2luaXRjb25zdA0KPiA9IHsNCj4gPiArICAgew0KPiA+ICsgICAgICAgICAgIC5jYWxsYmFjayA9
IGRtaV9tYXRjaGVkLA0KPiA+ICsgICAgICAgICAgIC5pZGVudCA9ICJBTUQgRVBZQyA3SzYyIiwN
Cj4gPiArICAgICAgICAgICAubWF0Y2hlcyA9IHsNCj4gPiArICAgICAgICAgICAgICAgICAgIERN
SV9NQVRDSChETUlfQklPU19WRVJTSU9OLCAiNS4xNCIpLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgRE1JX01BVENIKERNSV9CSU9TX1JFTEVBU0UsICIxMi8xMi8yMDE5Iik7DQo+DQo+IEkgdGhp
bmsgdGhpcyBpcyBpbmNvcnJlY3QsIGFuZCB0aGVyZSBzaG91bGQgYmUgYSBjb21tYSAiLCIgaW5z
dGVhZCBvZg0KPiBzZW1pY29sb24gIjsiIGF0IHRoZSBlbmQgb2YgdGhlIHN0cmluZy4gT3RoZXJ3
aXNlIHRoZSBidWlsZCB3aWxsIGZhaWwuDQoNCkdvb2QgY2F0Y2gsIEkgbWFkZSBhIG1pc3Rha2Ug
aGVyZSwgSSBmb3VuZCB0aGlzIGFmdGVyIEkgc2VudCBpdCBvdXQsICBoYXZlIGl0IGZpeGVkIGlu
IFY0Lg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpQZXJyeS4NCg0KPg0KPiA+ICsgICAgICAg
ICAgIH0sDQo+ID4gKyAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gJnF1aXJrX2FtZF83azYyLA0K
PiA+ICsgICB9LA0KPiA+ICsgICB7fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxF
KGRtaSwgYW1kX3BzdGF0ZV9xdWlya3NfdGFibGUpOw0KPiA+ICsNCj4gPiAgc3RhdGljIGlubGlu
ZSBpbnQgZ2V0X21vZGVfaWR4X2Zyb21fc3RyKGNvbnN0IGNoYXIgKnN0ciwgc2l6ZV90IHNpemUp
DQo+ID4gew0KPiA+ICAgICBpbnQgaTsNCj4gPiBAQCAtNjAwLDEzICs2MjgsMTkgQEAgc3RhdGlj
IHZvaWQgYW1kX3BzdGF0ZV9hZGp1c3RfcGVyZih1bnNpZ25lZCBpbnQNCj4gPiBjcHUsICBzdGF0
aWMgaW50IGFtZF9nZXRfbWluX2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKSAgew0K
PiA+ICAgICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19wZXJmOw0KPiA+ICsgICB1MzIgbG93
ZXN0X2ZyZXE7DQo+ID4NCj4gPiAgICAgaW50IHJldCA9IGNwcGNfZ2V0X3BlcmZfY2FwcyhjcHVk
YXRhLT5jcHUsICZjcHBjX3BlcmYpOw0KPiA+ICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+ID4NCj4gPiArICAgaWYgKHF1aXJrcyAmJiBxdWlya3MtPmxvd2VzdF9m
cmVxKQ0KPiA+ICsgICAgICAgICAgIGxvd2VzdF9mcmVxID0gcXVpcmtzLT5sb3dlc3RfZnJlcTsN
Cj4gPiArICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIGxvd2VzdF9mcmVxID0gY3BwY19wZXJmLmxv
d2VzdF9mcmVxOw0KPiA+ICsNCj4gPiAgICAgLyogU3dpdGNoIHRvIGtoeiAqLw0KPiA+IC0gICBy
ZXR1cm4gY3BwY19wZXJmLmxvd2VzdF9mcmVxICogMTAwMDsNCj4gPiArICAgcmV0dXJuIGxvd2Vz
dF9mcmVxICogMTAwMDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgYW1kX2dldF9tYXhf
ZnJlcShzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpIEBAIC02MzUsMTINCj4gPiArNjY5LDE4
IEBAIHN0YXRpYyBpbnQgYW1kX2dldF9tYXhfZnJlcShzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRh
dGEpDQo+ID4gc3RhdGljIGludCBhbWRfZ2V0X25vbWluYWxfZnJlcShzdHJ1Y3QgYW1kX2NwdWRh
dGEgKmNwdWRhdGEpICB7DQo+ID4gICAgIHN0cnVjdCBjcHBjX3BlcmZfY2FwcyBjcHBjX3BlcmY7
DQo+ID4gKyAgIHUzMiBub21pbmFsX2ZyZXE7DQo+ID4NCj4gPiAgICAgaW50IHJldCA9IGNwcGNf
Z2V0X3BlcmZfY2FwcyhjcHVkYXRhLT5jcHUsICZjcHBjX3BlcmYpOw0KPiA+ICAgICBpZiAocmV0
KQ0KPiA+ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4NCj4gPiAtICAgcmV0dXJuIGNwcGNf
cGVyZi5ub21pbmFsX2ZyZXE7DQo+ID4gKyAgIGlmIChxdWlya3MgJiYgcXVpcmtzLT5ub21pbmFs
X2ZyZXEpDQo+ID4gKyAgICAgICAgICAgbm9taW5hbF9mcmVxID0gcXVpcmtzLT5ub21pbmFsX2Zy
ZXE7DQo+ID4gKyAgIGVsc2UNCj4gPiArICAgICAgICAgICBub21pbmFsX2ZyZXEgPSBjcHBjX3Bl
cmYubm9taW5hbF9mcmVxOw0KPiA+ICsNCj4gPiArICAgcmV0dXJuIG5vbWluYWxfZnJlcTsNCj4g
PiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgYW1kX2dldF9sb3dlc3Rfbm9ubGluZWFyX2ZyZXEo
c3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+IEBAIC0xNjcyLDYgKzE3MTIsMTEgQEAg
c3RhdGljIGludCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gICAgIGlmIChjcHVm
cmVxX2dldF9jdXJyZW50X2RyaXZlcigpKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUVYSVNU
Ow0KPiA+DQo+ID4gKyAgIHF1aXJrcyA9IE5VTEw7DQo+ID4gKw0KPiA+ICsgICAvKiBjaGVjayBp
ZiB0aGlzIG1hY2hpbmUgbmVlZCBDUFBDIHF1aXJrcyAqLw0KPiA+ICsgICBkbWlfY2hlY2tfc3lz
dGVtKGFtZF9wc3RhdGVfcXVpcmtzX3RhYmxlKTsNCj4gPiArDQo+ID4gICAgIHN3aXRjaCAoY3Bw
Y19zdGF0ZSkgew0KPiA+ICAgICBjYXNlIEFNRF9QU1RBVEVfVU5ERUZJTkVEOg0KPiA+ICAgICAg
ICAgICAgIC8qIERpc2FibGUgb24gdGhlIGZvbGxvd2luZyBjb25maWdzIGJ5IGRlZmF1bHQ6DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oIGIvaW5jbHVkZS9saW51
eC9hbWQtcHN0YXRlLmgNCj4gPiBpbmRleCBkMjE4Mzg4MzVhYmQuLjdiMmNiYjg5MmZkOSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvYW1kLXBzdGF0ZS5oDQo+ID4gQEAgLTEyNCw0ICsxMjQsMTAgQEAgc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdA0KPiBhbWRfcHN0YXRlX21vZGVfc3RyaW5nW10gPSB7DQo+ID4gICAg
IFtBTURfUFNUQVRFX0dVSURFRF0gICAgICA9ICJndWlkZWQiLA0KPiA+ICAgICBOVUxMLA0KPiA+
ICB9Ow0KPiA+ICsNCj4gPiArc3RydWN0IHF1aXJrX2VudHJ5IHsNCj4gPiArICAgdTMyIG5vbWlu
YWxfZnJlcTsNCj4gPiArICAgdTMyIGxvd2VzdF9mcmVxOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAg
I2VuZGlmIC8qIF9MSU5VWF9BTURfUFNUQVRFX0ggKi8NCj4gPg0KPg0KPg0KPiAtLQ0KPiBPbGVr
c2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkNCg==

