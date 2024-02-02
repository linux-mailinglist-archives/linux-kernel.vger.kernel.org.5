Return-Path: <linux-kernel+bounces-50132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F08474AA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA011F27139
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4C1474CB;
	Fri,  2 Feb 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aY+SGTpC"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF71468FF;
	Fri,  2 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891282; cv=fail; b=gvmQDEkvrQUE3KbntrJXrYPqPXyp3onXnROblMnVrAKoOx/XO1LpduPkaBxNrAzI/gt/EO7FTEWidjgB2POdkhsS45Ngi7c/AV3N5l3hs39+rnx/Mo6nFlI6fqd2tpbfIAFWwV7jDb09gTakqrr+tiZeh45iklSLDP11wB13wDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891282; c=relaxed/simple;
	bh=iGSR1K6I/AjXuX8X/ch00Xo2OpKMTXZc+Ri26jRavpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0emKtUcFs1s25jljPUYZIZxphmJ/OuwnCro8UYm5rAKOKdAexEHI2WItnuxoPvAMSvk9BI9etixiZEgmAlj896bmetCy7ISPKU/xe3SFrFAKYzKBtZjBZhjERhG8r38UXVwlrxKNakwkT7CLzzi1tosmaWuiBNofyVV1vgcea4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aY+SGTpC; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDo1Q1yXqsQuREXqtjm3DM1yx2xAl7fte60kWoIbak0TEuvfukp/8PXuvbI+2+ZbQOTb8xglq0GpLz6xMwgMg2DaNEZFjPuWvxRzPI30pD8jvHcXXQWJKnVQ+/nzY2tq3avWIabb0V2hsdZGYSGOwCcoB1BXiLr3bo2PTQYgm9YultMPTrahHUjTbDPBzQuVVnEw3/SOQ+HruK5CCoDmwbOWMpxM54IkMOUsusHuSUgDRzvk+j6W9cfVUivRH+mEG+HObNjkvoDyl76iFMAg2klpLWm3440zRd0xxErbLLqylM6+IQXE33nAVY52UIMx78b1Yd2LBG1y7rAGYvg9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGSR1K6I/AjXuX8X/ch00Xo2OpKMTXZc+Ri26jRavpk=;
 b=PjOuDybu6W30IKctbAwmQDZZExrGLelabOgcyvhRziOeMKGitO6zx8eDRt0FPEA2d2iytZWMmOZTsJnEtcVY5GibTJqJ7PoRI3LPwAuZ3q5E7w+/gP3oG0OPtQvt8XSGkdeEsorWlsRbNtNtfUsOG2ahRS9VeR+d3G9JdyqZqCF4bop48BeFDgdGqTJgXBki42I0Zcke+GNyJRkY+WOLrMCKtXAVA6qs/oOQ4pu35FzrPiWehvPNZkkIf+7G0loX+Hht7BROshR7impK6G+mSp8aOD7kBqc8O1h3rbuCfPCYI5UGorSWil9fhcXKqh4yKN4TYp28+hfVrKvRjpxDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGSR1K6I/AjXuX8X/ch00Xo2OpKMTXZc+Ri26jRavpk=;
 b=aY+SGTpCRA4UqUQGt850IGpxYHHEBJVY9iLMIMfdynzc7d/ZKlr5V2Upt36EI8vyZrz8dN8cSGydIP02BAjEJM/pg7pkx5V6i+f04aY+twi27R1DoSfL0NEvO15Pln7YSfUPFtq5LTX25LeBkGC5xLRza0IXfsv/oiaPLYPgFY8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 16:27:57 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 16:27:55 +0000
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
Subject: RE: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Topic: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Index: AQHaVbXxn3uZQDIUQEWAqG1gtcTZ8LD3Kj8AgAAEkICAAAYjgIAACKQQ
Date: Fri, 2 Feb 2024 16:27:55 +0000
Message-ID:
 <CYYPR12MB865570EE996051FE190B1F5B9C422@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
 <8a55135d10cfc906616d3cd4530f9aac487c5034.1706863981.git.perry.yuan@amd.com>
 <097c6d94-2add-4c59-9ab3-8e8dbc7605c7@amd.com>
 <CYYPR12MB865553ECA464FD9BFA57D1BB9C422@CYYPR12MB8655.namprd12.prod.outlook.com>
 <7b57ceea-f6d6-4d4a-9e3c-8cdcca08121b@amd.com>
In-Reply-To: <7b57ceea-f6d6-4d4a-9e3c-8cdcca08121b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ddb84d1b-f574-4ef7-b8ca-18c416c18e21;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T16:25:58Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB7186:EE_
x-ms-office365-filtering-correlation-id: fb02c57b-eda9-42c2-9aa1-08dc240be932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6C1E2H1fNB+ZTG+/Pk6JJIoOpNSxr+BhmkD4KzATKJuJvpU+4GS4ExGlybrjhZRJjXJFsvjn/u4OX3dH1V05JpYCie+Q90guR4dNUswgQjQtAMtIiIfcbZM5Ua+DHCZI7UZUpu3nEE/dcsPQ0IKZBsAODouc5XBjQD44QX5pVnAuUkHUJ28vBZ7DeEqOUIaW4yv4NjL1yXg8PpldjY/hVitwd5XuDTWhfYSZG2SlcW1AD96Be6N7PNAshyVV2ls/oOHCzedk2zBboCTRffEcfey2odU+Cy9NdPImJoGTH5HSQJuGwVEldyatJbNTqWxnWlcsHPt1Rep0IGTgtuCYN4LBjEGHHGX34LOAhMfLFwQIo51Q/taNxHX/fZLXp2vrxmF/1e0yPiXE/u0OThK2PNAe8G5L37as1cw0w3QSeSLvLm0Gsrz6i/sXFR13PcUPuB4twJR+KGH606jf/CYgvhKEH/xM48FRNIz3MQ7sDncUcX6olfK383J3SRlekDi3BSuUMaWGuzPlxKGJJ9Exrhj9BFnCnKx6CjrODxYqEzF24bVgW/ht/CNJqOkDbJY8PNPiYvxWCkezSdaEmGmTzU+4V5T2tgjKQyAaXie5hfLwArEr9/r4BZKBL88RaUWKrBSQbCMwUKEJf8rGle9FzA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(53546011)(38070700009)(86362001)(26005)(38100700002)(54906003)(316002)(122000001)(66476007)(66446008)(66556008)(5660300002)(66946007)(76116006)(8936002)(64756008)(110136005)(52536014)(71200400001)(83380400001)(8676002)(4326008)(478600001)(7696005)(2906002)(6506007)(6636002)(9686003)(41300700001)(921011)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWZpdW9jMkQ2S0ZWL2dZOEc3b3hIL283bW5aMXFEZjZMbkNYVGV2dWNlaUg2?=
 =?utf-8?B?QTFvYmtmSG1tVTk0Z0lvNVdSd3oyMEZNaEE3bXhOazVxZGp3Y2N0QjR1dC9v?=
 =?utf-8?B?RHFISUF3dFlHY2gwU3J5T3Z6NjllTkgyQzNZN01ibThYVGRhd3ZoYTM2T24y?=
 =?utf-8?B?VmUydHNXSFVtQ0hEV2wwZTk1a09ZTTVhY2VkNDlPTlRLbVMzUGZkZmZqUnpa?=
 =?utf-8?B?ckxwTmxHa0VjK1JUcDVCbkZtYXl1djF3TDlGZXZoMVFWaDBTVWdrVVJtd0Fx?=
 =?utf-8?B?NldTT3ZoUzJURHU4RTgvZmlZcWVEYnhhOEtVamJJSU5yUHhCemZRWTZvYXN2?=
 =?utf-8?B?Sk9adFkzc1plcnYrNktUa0krZStvc1JXZGpvMkQxbmZ6NHpMeVpOdFphUVc2?=
 =?utf-8?B?SDRjSE5lQzJ4OHVLYlpHMHNpdStYb3NwQlBEUVBFT2w2WHlSWk5XVS9sY0NK?=
 =?utf-8?B?cFUrbzZvdXdjR3pLUmlkc1FuVE5xd1I4UFUzeUY2aU5xVnpRQ3ZIZnNpTUlo?=
 =?utf-8?B?bW54TnRQR1FCQmZrbXNCbXJ3ZHFZbHRTMFhNSWkxRFc1MnI4VWNSK2IrWkZO?=
 =?utf-8?B?RzAyNjZmekI1Sy9IWGphdGRTYXQ0dmNCYU1FaE1tRjZTdDd1a3daZW9pTjJJ?=
 =?utf-8?B?TVRIQklhUEN0b1pLMk1TZ0liRlhyYUM1dkt0RGJKcXpJb2F5dTNiVHhtVDM4?=
 =?utf-8?B?MmJpa2ZNN0U2T0N1WmxGN0t5ajlCQWdORWtYSUZxZGRjVElhZ1puU0Rkblg5?=
 =?utf-8?B?aC9vV1JCRUpVOUo1T0NjeDFvT3BwUTkzNURFekhQOVF5UXNRU21tMHZmNzJs?=
 =?utf-8?B?cnJqczZjcGo0amJwbFFTbmpVUGUrVDVtQ1NsMzEvL1k4UVVMdmIvWitKZjEz?=
 =?utf-8?B?eU00SUYwQ1ZId0RBeG9pZnVnNGNvMDQyN1B6YjBYWUtyTXAyRkprTktMRXF2?=
 =?utf-8?B?YmNtVTNQMVJpc00rWVJNZG83RG9JdDlKMmFYa3F4bHdQYnZtWHIvWU9OOEo0?=
 =?utf-8?B?Uzl2dzYybzZTSlU1RCszejFUU0l0dEVDOGswQlJucnRhdTdVcGgwNkZWeDYx?=
 =?utf-8?B?ZnFNT3lHSkhJYUg4eHBmREdRaERSNm9tTkhqemZkRjlOZGdrbzc0aDZWL2Z5?=
 =?utf-8?B?NGppSXhyRE9TVXpNeEg3RGFGWXFqc2UxWFdBMXRubFJGT1IzRXo0WmtxeUlW?=
 =?utf-8?B?cHVYVlF5V3hYWkQvTXFKY1ovc2U5MFQxR1RVaGhSbHJVWndWNG5uajF2eWVC?=
 =?utf-8?B?Z3JkS3FwVjh2V1U0eEtVbUVTbCtDVXdHVW1FcVBWZXRENUlmU0crT0ZESVVQ?=
 =?utf-8?B?VmxJaGtTLzNyeWxHeiszLzJRTDBsNzdoelp4VVVhUEJ0WlQ3V1JtaWovTzVH?=
 =?utf-8?B?dTJUOG1lSHF3TUY0MUNpeU1McVR0QVhLNmtMK2dCSWQ3dFUrL09OMzR0c3ZV?=
 =?utf-8?B?Y2xCNlU1NnFhRnBMNDJaREllTjE1d0s2aTQ3dHZneStDZnlUNmk0SS9udU5w?=
 =?utf-8?B?emNRRGVhNVJTa093ci9ibDkzOWRxYUxaNkQ0aFpHcjdqd3hXcExUSVBFN0pv?=
 =?utf-8?B?VXZDeTRIZlZkeDg3Vjh3enZvNGFoSjZYZm1Eb1hBNklIR3NHcFpueXRZZ25Q?=
 =?utf-8?B?ZU9jM1psZ2t0TjhyS3NYb3RaSmF0VlFaZkFWcjdMWDlxeHUxbFNjU2ZHNVM2?=
 =?utf-8?B?SkIxV0dVRzB5NGFLT0Y4R1BkY1NkdXNnTjUrSVQ5T09kTDhtZ1o2cnQvV3Mz?=
 =?utf-8?B?KzZiK29ocFdZVTdGa1JLd2l1M3g1eGdHeHZzYWhQUVV4S0dqVHJUSTNtRHlI?=
 =?utf-8?B?Q2pvSkg0V2FVVlBRUk52Q0JuSnowRktOQzBGV0x6bnBLODhBc1FDUVI0aEJq?=
 =?utf-8?B?KzczcjlZVGV1d29qMEJ6cXczMWdUT05CY3lPM1JWa1JWY0NoZmtEK2s5Yjlx?=
 =?utf-8?B?SlBYNGxBM0czWHRKRkFOeGpPd003dHcyK0xyQ3ROQ0RIVThqdWpWUlJsdWFj?=
 =?utf-8?B?OC9ocTRUSk5ocEpkckhhL2NtcVRFR1RyN0NkUzRKY1pHVVl3T243cllnVUdo?=
 =?utf-8?B?SEtoc3IvdEFBUUNIVTJEZjh6RXVVOWRTRWlRb0laRFNnRWpUMUhsd0RBM3Zs?=
 =?utf-8?Q?MAeE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb02c57b-eda9-42c2-9aa1-08dc240be932
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 16:27:55.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvP0nwgb/zI6zpfKMlN1fr43rLjbYgxNtShPjX0O6BcqovZFymV7Ro4GXISLBkyuhgRj29hh25o0TFcxN+zNTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0Bh
bWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIsIDIwMjQgMTE6NTUgUE0NCj4gVG86
IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbTsNCj4gdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0Bh
bWQuY29tPjsgU2hlbm95LA0KPiBHYXV0aGFtIFJhbmphbCA8Z2F1dGhhbS5zaGVub3lAYW1kLmNv
bT47IFBldGtvdiwgQm9yaXNsYXYNCj4gPEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPg0KPiBDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNo
aW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4u
RHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxp
bnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzZdIGNwdWZyZXE6YW1kLXBzdGF0ZTogYWRkIHF1
aXJrIGZvciB0aGUgcHN0YXRlDQo+IENQUEMgY2FwYWJpbGl0aWVzIG1pc3NpbmcNCj4NCj4gT24g
Mi8yLzIwMjQgMDk6MzUsIFl1YW4sIFBlcnJ5IHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4gICBIaSBNYXJpbywNCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMiwgMjAy
NCAxMToxNyBQTQ0KPiA+PiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOw0KPiA+PiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsg
SHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksDQo+ID4+IEdhdXRoYW0gUmFu
amFsIDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA+PiA8Qm9y
aXNsYXYuUGV0a292QGFtZC5jb20+DQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywNCj4gU2hpbW1lcg0KPiA+PiA8U2hpbW1lci5I
dWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsNCj4gTWVu
ZywgTGkNCj4gPj4gKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDYvNl0gY3B1ZnJlcTphbWQtcHN0YXRlOiBhZGQgcXVpcmsgZm9y
IHRoZQ0KPiA+PiBwc3RhdGUgQ1BQQyBjYXBhYmlsaXRpZXMgbWlzc2luZw0KPiA+Pg0KPiA+PiBP
biAyLzIvMjAyNCAwMjo1NSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPj4+IEFkZCBxdWlyayB0YWJs
ZSB0byBnZXQgQ1BQQyBjYXBhYmlsaXRpZXMgaXNzdWUgZml4ZWQgYnkgcHJvdmlkaW5nDQo+ID4+
PiBjb3JyZWN0IHBlcmYgb3IgZnJlcXVlbmN5IHZhbHVlcyB3aGlsZSBkcml2ZXIgbG9hZGluZy4N
Cj4gPj4+DQo+ID4+PiBJZiBDUFBDIGNhcGFiaWxpdGllcyBhcmUgbm90IGRlZmluZWQgaW4gdGhl
IEFDUEkgdGFibGVzIG9yIHdyb25nbHkNCj4gPj4+IGRlZmluZWQgYnkgcGxhdGZvcm0gZmlybXdh
cmUsIGl0IG5lZWRzIHRvIHVzZSBxdWljayB0byBnZXQgdGhvc2UNCj4gPj4+IGlzc3VlcyBmaXhl
ZCB3aXRoIGNvcnJlY3Qgd29ya2Fyb3VuZCB2YWx1ZXMgdG8gbWFrZSBwc3RhdGUgZHJpdmVyDQo+
ID4+PiBjYW4gYmUgbG9hZGVkIGV2ZW4gdGhvdWdoIHRoZXJlIGFyZSBDUFBDIGNhcGFiaWxpdGll
cyBlcnJvcnMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnku
eXVhbkBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS5jIHwgNDkNCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+
ID4+PiAgICBpbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCAgIHwgIDYgKysrKysNCj4gPj4+ICAg
IDIgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+Pj4g
Yi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDc3ZWZmYzNjYWY2Yy4uNGQ0MjY1
MTZhYmI5DQo+ID4+PiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPj4+IEBA
IC02Nyw2ICs2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXINCj4gYW1kX3BzdGF0
ZV9lcHBfZHJpdmVyOw0KPiA+Pj4gICAgc3RhdGljIGludCBjcHBjX3N0YXRlID0gQU1EX1BTVEFU
RV9VTkRFRklORUQ7DQo+ID4+PiAgICBzdGF0aWMgYm9vbCBjcHBjX2VuYWJsZWQ7DQo+ID4+PiAg
ICBzdGF0aWMgYm9vbCBhbWRfcHN0YXRlX3ByZWZjb3JlID0gdHJ1ZTsNCj4gPj4+ICtzdGF0aWMg
c3RydWN0IHF1aXJrX2VudHJ5ICpxdWlya3M7DQo+ID4+Pg0KPiA+Pj4gICAgLyoNCj4gPj4+ICAg
ICAqIEFNRCBFbmVyZ3kgUHJlZmVyZW5jZSBQZXJmb3JtYW5jZSAoRVBQKSBAQCAtMTExLDYgKzEx
MiwzMyBAQA0KPiA+Pj4gc3RhdGljIHVuc2lnbmVkIGludCBlcHBfdmFsdWVzW10gPSB7DQo+ID4+
Pg0KPiA+Pj4gICAgdHlwZWRlZiBpbnQgKCpjcHBjX21vZGVfdHJhbnNpdGlvbl9mbikoaW50KTsN
Cj4gPj4+DQo+ID4+PiArc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19hbWRfN2s2MiA9
IHsNCj4gPj4+ICsgICAubm9taW5hbF9mcmVxID0gMjYwMCwNCj4gPj4+ICsgICAubG93ZXN0X2Zy
ZXEgPSA1NTAsDQo+ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4+ICtzdGF0aWMgaW50IF9faW5pdCBk
bWlfbWF0Y2hlZChjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCAqZG1pKSB7DQo+ID4+PiArICAg
cXVpcmtzID0gZG1pLT5kcml2ZXJfZGF0YTsNCj4gPj4+ICsgICBwcl9pbmZvKCJoYXJkd2FyZSB0
eXBlICVzIGZvdW5kXG4iLCBkbWktPmlkZW50KTsNCj4gPj4+ICsNCj4gPj4+ICsgICByZXR1cm4g
MTsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lz
dGVtX2lkIGFtZF9wc3RhdGVfcXVpcmtzX3RhYmxlW10NCj4gPj4+ICtfX2luaXRjb25zdA0KPiA+
PiA9IHsNCj4gPj4+ICsgICB7DQo+ID4+PiArICAgICAgICAgICAuY2FsbGJhY2sgPSBkbWlfbWF0
Y2hlZCwNCj4gPj4+ICsgICAgICAgICAgIC5pZGVudCA9ICJBTUQgRVBZQyA3SzYyIiwNCj4gPj4+
ICsgICAgICAgICAgIC5tYXRjaGVzID0gew0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICBETUlf
TUFUQ0goRE1JX1BST0RVQ1RfVkVSU0lPTiwgIkMxIiksDQo+ID4+PiArICAgICAgICAgICAgICAg
ICAgIERNSV9NQVRDSChETUlfUFJPRFVDVF9TRVJJQUwsDQo+ID4+ICJGWDE5OTExMDAwMDI4IikN
Cj4gPj4NCj4gPj4gSSBzYXcgeW91ciByZXNwb25zZSB0byB2MSwgYnV0IHJlYWxseSB0aGlzIGlz
IHRvbyBuYXJyb3cgZm9yIHVwc3RyZWFtLg0KPiA+PiBJdCdzIGxpdGVyYWxseSBhcHBseWluZyB0
byBhIFNJTkdMRSBzeXN0ZW0uDQo+ID4+DQo+ID4+IEkgZmVlbCB0aGUgcmVzdCBvZiB0aGUgcGF0
Y2ggaXMgZmluZSwgYnV0IHdlIHNob3VsZG4ndCBiZSBhZGRpbmcNCj4gPj4gc2luZ2xlIHN5c3Rl
bSBxdWlya3MuDQo+ID4NCj4gPiBIb3cgYWJvdXQgY2hhbmdlIHRvIG1hdGNoIHRoZSBCSU9TIHZl
cnNpb24gPw0KPiA+IEFjdHVhbGx5LCB0aGUgaXNzdWUgc2hvdWxkIGJlIGltcGFjdGluZyBhbGwg
dGhlIHN5c3RlbXMgd2hpY2ggaGF2ZSB0aGUNCj4gc2FtZSBicm9rZW4gQklPUy4NCj4gPg0KPg0K
PiBZZWFoIGl0IGRvZXMgc291bmQgbGlrZSBhIEJJT1MgZGVmZWN0OyBzbyB0aGlzIGlzIGEgcmVh
c29uYWJsZSBhbHRlcm5hdGl2ZS4gIEp1c3QNCj4gbWFrZSBzdXJlIHRoYXQgeW91IG9ubHkgYXBw
bHkgaXQgdG8gdGhlIG5lY2Vzc2FyeSBzeXN0ZW1zIHdpdGggdGhpcyBjaGFuZ2UuDQo+DQoNCkFn
cmVlZCwgIGxldCBtZSBjaGFuZ2UgdG8gbWF0Y2ggQklPUyB2ZXJzaW9uIGluIFYzLg0KVGhhbmtz
IGZvciB0aGUgZmVlZGJhY2shDQoNClBlcnJ5Lg0KDQo+ID4gUGVycnkuDQo+ID4NCj4gPg0KPiA+
Pg0KPiA+Pj4gKyAgICAgICAgICAgfSwNCj4gPj4+ICsgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9
ICZxdWlya19hbWRfN2s2MiwNCj4gPj4+ICsgICB9LA0KPiA+Pj4gKyAgIHt9DQo+ID4+PiArfTsN
Cj4gPj4+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGRtaSwgYW1kX3BzdGF0ZV9xdWlya3NfdGFibGUp
Ow0KPiA+Pj4gKw0KPiA+Pj4gICAgc3RhdGljIGlubGluZSBpbnQgZ2V0X21vZGVfaWR4X2Zyb21f
c3RyKGNvbnN0IGNoYXIgKnN0ciwgc2l6ZV90IHNpemUpDQo+ID4+PiAgICB7DQo+ID4+PiAgICAg
IGludCBpOw0KPiA+Pj4gQEAgLTYwMCwxMyArNjI4LDE5IEBAIHN0YXRpYyB2b2lkIGFtZF9wc3Rh
dGVfYWRqdXN0X3BlcmYodW5zaWduZWQNCj4gPj4+IGludA0KPiA+PiBjcHUsDQo+ID4+PiAgICBz
dGF0aWMgaW50IGFtZF9nZXRfbWluX2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0K
PiA+Pj4gICAgew0KPiA+Pj4gICAgICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19wZXJmOw0K
PiA+Pj4gKyAgIHUzMiBsb3dlc3RfZnJlcTsNCj4gPj4+DQo+ID4+PiAgICAgIGludCByZXQgPSBj
cHBjX2dldF9wZXJmX2NhcHMoY3B1ZGF0YS0+Y3B1LCAmY3BwY19wZXJmKTsNCj4gPj4+ICAgICAg
aWYgKHJldCkNCj4gPj4+ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+Pj4NCj4gPj4+ICsg
ICBpZiAocXVpcmtzICYmIHF1aXJrcy0+bG93ZXN0X2ZyZXEpDQo+ID4+PiArICAgICAgICAgICBs
b3dlc3RfZnJlcSA9IHF1aXJrcy0+bG93ZXN0X2ZyZXE7DQo+ID4+PiArICAgZWxzZQ0KPiA+Pj4g
KyAgICAgICAgICAgbG93ZXN0X2ZyZXEgPSBjcHBjX3BlcmYubG93ZXN0X2ZyZXE7DQo+ID4+PiAr
DQo+ID4+PiAgICAgIC8qIFN3aXRjaCB0byBraHogKi8NCj4gPj4+IC0gICByZXR1cm4gY3BwY19w
ZXJmLmxvd2VzdF9mcmVxICogMTAwMDsNCj4gPj4+ICsgICByZXR1cm4gbG93ZXN0X2ZyZXEgKiAx
MDAwOw0KPiA+Pj4gICAgfQ0KPiA+Pj4NCj4gPj4+ICAgIHN0YXRpYyBpbnQgYW1kX2dldF9tYXhf
ZnJlcShzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpIEBADQo+ID4+PiAtNjM1LDEyDQo+ID4+
PiArNjY5LDE4IEBAIHN0YXRpYyBpbnQgYW1kX2dldF9tYXhfZnJlcShzdHJ1Y3QgYW1kX2NwdWRh
dGEgKmNwdWRhdGEpDQo+ID4+PiAgICBzdGF0aWMgaW50IGFtZF9nZXRfbm9taW5hbF9mcmVxKHN0
cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkNCj4gPj4+ICAgIHsNCj4gPj4+ICAgICAgc3RydWN0
IGNwcGNfcGVyZl9jYXBzIGNwcGNfcGVyZjsNCj4gPj4+ICsgICB1MzIgbm9taW5hbF9mcmVxOw0K
PiA+Pj4NCj4gPj4+ICAgICAgaW50IHJldCA9IGNwcGNfZ2V0X3BlcmZfY2FwcyhjcHVkYXRhLT5j
cHUsICZjcHBjX3BlcmYpOw0KPiA+Pj4gICAgICBpZiAocmV0KQ0KPiA+Pj4gICAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+ID4+Pg0KPiA+Pj4gLSAgIHJldHVybiBjcHBjX3BlcmYubm9taW5hbF9m
cmVxOw0KPiA+Pj4gKyAgIGlmIChxdWlya3MgJiYgcXVpcmtzLT5ub21pbmFsX2ZyZXEpDQo+ID4+
PiArICAgICAgICAgICBub21pbmFsX2ZyZXEgPSBxdWlya3MtPm5vbWluYWxfZnJlcTsNCj4gPj4+
ICsgICBlbHNlDQo+ID4+PiArICAgICAgICAgICBub21pbmFsX2ZyZXEgPSBjcHBjX3BlcmYubm9t
aW5hbF9mcmVxOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgIHJldHVybiBub21pbmFsX2ZyZXE7DQo+ID4+
PiAgICB9DQo+ID4+Pg0KPiA+Pj4gICAgc3RhdGljIGludCBhbWRfZ2V0X2xvd2VzdF9ub25saW5l
YXJfZnJlcShzdHJ1Y3QgYW1kX2NwdWRhdGENCj4gPj4+ICpjcHVkYXRhKSBAQCAtMTY3Miw2ICsx
NzEyLDExIEBAIHN0YXRpYyBpbnQgX19pbml0DQo+IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+
Pj4gICAgICBpZiAoY3B1ZnJlcV9nZXRfY3VycmVudF9kcml2ZXIoKSkNCj4gPj4+ICAgICAgICAg
ICAgICByZXR1cm4gLUVFWElTVDsNCj4gPj4+DQo+ID4+PiArICAgcXVpcmtzID0gTlVMTDsNCj4g
Pj4+ICsNCj4gPj4+ICsgICAvKiBjaGVjayBpZiB0aGlzIG1hY2hpbmUgbmVlZCBDUFBDIHF1aXJr
cyAqLw0KPiA+Pj4gKyAgIGRtaV9jaGVja19zeXN0ZW0oYW1kX3BzdGF0ZV9xdWlya3NfdGFibGUp
Ow0KPiA+Pj4gKw0KPiA+Pj4gICAgICBzd2l0Y2ggKGNwcGNfc3RhdGUpIHsNCj4gPj4+ICAgICAg
Y2FzZSBBTURfUFNUQVRFX1VOREVGSU5FRDoNCj4gPj4+ICAgICAgICAgICAgICAvKiBEaXNhYmxl
IG9uIHRoZSBmb2xsb3dpbmcgY29uZmlncyBieSBkZWZhdWx0Og0KPiA+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oIGIvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmgN
Cj4gPj4+IGluZGV4IGQyMTgzODgzNWFiZC4uN2IyY2JiODkyZmQ5IDEwMDY0NA0KPiA+Pj4gLS0t
IGEvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmgNCj4gPj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
YW1kLXBzdGF0ZS5oDQo+ID4+PiBAQCAtMTI0LDQgKzEyNCwxMCBAQCBzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0DQo+ID4+IGFtZF9wc3RhdGVfbW9kZV9zdHJpbmdbXSA9IHsNCj4gPj4+ICAgICAg
W0FNRF9QU1RBVEVfR1VJREVEXSAgICAgID0gImd1aWRlZCIsDQo+ID4+PiAgICAgIE5VTEwsDQo+
ID4+PiAgICB9Ow0KPiA+Pj4gKw0KPiA+Pj4gK3N0cnVjdCBxdWlya19lbnRyeSB7DQo+ID4+PiAr
ICAgdTMyIG5vbWluYWxfZnJlcTsNCj4gPj4+ICsgICB1MzIgbG93ZXN0X2ZyZXE7DQo+ID4+PiAr
fTsNCj4gPj4+ICsNCj4gPj4+ICAgICNlbmRpZiAvKiBfTElOVVhfQU1EX1BTVEFURV9IICovDQo+
ID4NCg0K

