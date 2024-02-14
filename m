Return-Path: <linux-kernel+bounces-64752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73852854269
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988941C22916
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749ADC8E0;
	Wed, 14 Feb 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wJ4wzgMW"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7010A01;
	Wed, 14 Feb 2024 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888812; cv=fail; b=pkZHXTpaA81OTPxUPgL5L5jRRKnvtKEY2iWBMp3EHatdozzfF2UUeEslLNksYUFXDMGR7B03PCY4ARGj+I3MZD5JoNXFpBP39/UM8DXHon153grvbgPeTrE6fziJIhzWOWR4an3Km9egpwPMppgnB/wJNMT6NsT3HETOEQ8au/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888812; c=relaxed/simple;
	bh=8SPi39iVkNJB0yyVNgD/fTILiQ1TCquk51OltkOjoXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYN8hSagMrLXFxlz3SjdxGDshJx1jLZrUakDD/KNlcbpcoAOdxmjG3Jkw/TIAtzmBOrDkwoMUu8M8ubtfFDhgK0T48DI97gCuRG70lK5TdWifTP3pXRCPe2dnN3O6bZIDFMWeIQZhnF8rQjZg2Qw49O8RssC5azdgEfokDm09dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wJ4wzgMW; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar4tmO4u4qbKbQCTc+26FuzcQlfTg3+PMA4YnP+jP4NtksDlS9sJLGa2PPrk5AoenP/bpOVQTw1M44ikhRqM/bZE3W9SvHPxz1AoWZs9VZJnHqp03urlY1E7mDlSqeuOIiMg5ZCOkHlJ8W2xQZvvu8dVZUfWb/BPc2+QoZcnnMFCLTqlMsEZTqGPmPGNdL1TOMV5jtIzXhiM516lZ7I10Elm9D3xMjyI/RxhKQXq7yMwrR50c9BAmY+GUnXP90hfllaym6wEoHVKmHnUEG9hxYK4IartQbgW/RjfjFqGF3IXISTlqFyxMMH7Ybyn2ItkpF9xI5xiBFpuPfZUoJl9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SPi39iVkNJB0yyVNgD/fTILiQ1TCquk51OltkOjoXg=;
 b=m4THgNfiZusWRfVL5i14FuUoNb+g8H7tmBlG2dlSF590f8Tw64EVN4XWNYYMp6Y2VaYvS5GMbxDafvaM3t48R3JQd8S3jXcNU6CKLv0Rol87+ncLl1YYeRsQz/MJv2CsnkkTjb9B+0I6wdA0XEHN8Kt0gE1VjBtk8BR4ZfgcNZkWv2+uFm6HfEmSBR2kwUGiyKpg0DLsxyU48+k0EM6vTjzCQwdDHj2oCCd0KBIQB+z4XbVUovAvsqgmyxhXPYEICGkFFB3r9y77BhgWldS1DY5R0c0QmvqdV637cJIQmsG2R+0j6U0s43WuuOtJPjkF5ZsLrEvcOLIT0ibNaNEvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SPi39iVkNJB0yyVNgD/fTILiQ1TCquk51OltkOjoXg=;
 b=wJ4wzgMWccKA/Rn9N3iQyy+qZSnGkB6jpMRenaCQdtKXm6mLjDxSzGLuzcfgWs0ByicUpFzlJrZLCpSQdvKvv38xAxaZ2MCvMU3sqPnuZ8Wtj8VcUm0ONT9V4Y0dBJfRgw2XboJv0dWl4Ectxt5MhpY1NrdZBqiMdoDF+7YRmqE=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 05:33:25 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::3f68:19b3:31cc:5eae]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::3f68:19b3:31cc:5eae%4]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 05:33:25 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "Potthuri, Sai Krishna"
	<sai.krishna.potthuri@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "rric@kernel.org" <rric@kernel.org>
Subject: RE: [PATCH v3] EDAC/versal: Make the bits in error injection
 configurable
Thread-Topic: [PATCH v3] EDAC/versal: Make the bits in error injection
 configurable
Thread-Index: AQHaWnPFmHbdAUINPkG+AzMYX0vYU7EIobOAgAC3wNA=
Date: Wed, 14 Feb 2024 05:33:25 +0000
Message-ID:
 <BY5PR12MB49024FB7BAC0CF996726E366814E2@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20240208094653.11704-1-shubhrajyoti.datta@amd.com>
 <20240213183439.GDZcu2PwWnFxsRp7x2@fat_crate.local>
In-Reply-To: <20240213183439.GDZcu2PwWnFxsRp7x2@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=476eb545-ab6d-4963-99a0-55ab9498a3f2;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-14T05:32:19Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SJ2PR12MB9161:EE_
x-ms-office365-filtering-correlation-id: 8d782641-b4b4-459a-c70b-08dc2d1e7732
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tMGXifkK1QrXTp6XaqWqfZWw5zlPNQQ1KzatzbXUyJwxIb/iRbHya55e9bsy9GOKRth9T1fQmXOYCk/oEYsQVhlWiHm50u6VIgxi4kIt20OqE+nyim1u7Eoulu9gWOg+fCgrD7VMTPYJyfIo2zrXIekE2dDLbxSygCQQDevaFS4CxOs5BPPdszRUxODhjk4WAnlA1hcllP6/69RNHo7qn2pVetEOyZolYbQ80Wdo+ij9YOO73ui7ood6e81oMyuPkg3KPPfnozptGGT/BaYX1Q0mYYpInYRkfReQx/LO8OSrDszKYuv8AgKbsudqI/4d7AbBHcjtCmCFuSQ0TJv7oF7J7RCv9couP8THou4Th+07uVpkDEqeS9/ymWzGbigJI+Uf41c0myWpV+UVeB1Hd7zbEndOiRKWSO9qLO00lELzfd1mdZEBHCqofeVbMfuni9vNAq1PYeTT+R8O2BsJyiqfRhvgWbCos2NHm1+dQSaoLv8TCmyhncOAnYAGaKMPgw9CuIMCIwgQWer1si344eHXZjU5XDpFI/6XaHIbMRIV4ny5y389Q0Z5kaHSStMbkTiBAK3OXVNVEAIZ+SCY98EVAi8bqYHtPUK2U7j4BUEmsA6/svEvcoPQYcpZsjOD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(26005)(38100700002)(122000001)(478600001)(4326008)(64756008)(53546011)(66556008)(52536014)(66446008)(66476007)(66946007)(5660300002)(8936002)(8676002)(2906002)(6506007)(7696005)(9686003)(54906003)(316002)(38070700009)(71200400001)(76116006)(6916009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGtTMEtJeWtYdXUrM0RtdzVLNXVRZ1NGUXQ3VDlIeE9vMEEwVnA0YmVYZ09F?=
 =?utf-8?B?dTJWTUlmWFFUSnEwWXBaY1JVWFFGelNiSHJZSjVNRTdQQlc5Qyt3T1R4SGQv?=
 =?utf-8?B?c0lIdGhpVEZjd3E3Wk9yaU9SQXdhaTdEU0lCN0YrQnJrdEVrYjBrbUdDVkJk?=
 =?utf-8?B?djNpWGIwVmo3SXVqZ21iYUYxN3hKL1dUcjZMMnBMWmd5OW1oMlNISE14SWYz?=
 =?utf-8?B?MExuV2l4WDFzb21qTERXTERucFljcVdaTmhid3R1eUUxdmY3WkJVdEVJaUZQ?=
 =?utf-8?B?SSs0SkJ3bmZsT2FNS2hxUkNlOERUZTFLam9STmtVUllpdFUyV2ZLR2JxSjhw?=
 =?utf-8?B?ZHFrdkRRbU5XZG95a2hmVFN6YS9teUhxL25EVDRJeGhOV0xJRE5BeFVzejEy?=
 =?utf-8?B?SFpZQkUwVTJWTzlNS3ZSVlEyUVRhTzYxTis5WlloSjVLRzNKQ3dnUEpla3M2?=
 =?utf-8?B?Q1RkQmtZaDN6S2J4NTVXV2prMUZXNkpMaElvRUhKYjh2YmxKYXNzVi9qMFlt?=
 =?utf-8?B?ZGpkSWtHOCtQa2V5S1VWY250MnVnWHYwaVE2SFBDNVc3dEcvVzRrZFZnQ2Nu?=
 =?utf-8?B?YW80SG9ISGdqYUFsSDNjUDh4OTExMlJWamVjQWdEa3pkMTlrdy91aXlUVk9n?=
 =?utf-8?B?OXBkU0d6K3JYSkhud1R5dkpXM1ZSb29CQlZzV1dzQUp1OVJHdzJmbXhnSFgz?=
 =?utf-8?B?ZHJwY3EvRjBrcUdINVgxSXplTGdySkxrcUh2bFBMTnp5b1FHejA1dnAyVmZ1?=
 =?utf-8?B?TG9MMyt5MnVjNjdvaGtsbElDWVRxUWhyd1M1R2RPZ3FNZjFpekdqWkZDQlNK?=
 =?utf-8?B?M0VCMDlyanhhWWZLb3lDSDFWRDRxMUJ5QTRZSVFvQUtoNm8vYzZmdk92Zmlu?=
 =?utf-8?B?THJscFNBOFl6WnBZWDdPWC9QVmYxRTVLbGRuNCs4TngvWGdFWkdnQ1pWZ29n?=
 =?utf-8?B?NnBza2dGdmYxeFc2cTltSTk3UHdqUEh4dnQvNGJiNWhMbW5ISGxuVEFFTGkw?=
 =?utf-8?B?WXd6ZXhrcmwrRTRtN1VoSHVBUVd0bkRnYjFacWE1YjROa0V5OTdXb3pQWmtN?=
 =?utf-8?B?QUdZdWt5aHIvcE1LU0xrVlcwV2ZmZkY3Yk5KYmZ2NnIxWXVUWDF6R3ljdzlB?=
 =?utf-8?B?U0dtaFNXaWh0SGt3MDRPa2xtNmRSek1FTGprSFVsbkZRUHdQRUIvTERyYXQw?=
 =?utf-8?B?SHpvSDFlbEt2aERRMG5obkljZVErcnRyVFhTalV5NlVsYkQvemdyY3dDdGhY?=
 =?utf-8?B?bWpOUzA0TTh1WXA2cTJ1dUFuM0RpM1R1dEVpc0Y5b1VRVHUxZElpeDJxMVQ3?=
 =?utf-8?B?YmZOSjhBZHhCTHVQZFJDWStDNXpwNmVpeDhzV2FyOStZSU5NUjJCRmtSRVg0?=
 =?utf-8?B?SGhvNzJEVGpHZDhwbVV6SWp0WUFqd0lSVndnU1MwdmVNVm9WRlM3RGVIZ0hh?=
 =?utf-8?B?UUZQKzV5UzdRQ1Y4U1A0SUN6VU1DZEpXRkhNc2thMEc3dDNQSk9JSHVZY1dm?=
 =?utf-8?B?ajc2YVowZnNDbWxvemFUR2NYUTcwS0tzZzJYWlVoQm1JL3Q3NE9KU1RpWS80?=
 =?utf-8?B?ajIrMURxM2lSNStEVTNBM3RvMjNQdEhZMUhHUjNxUUNUYW1oSmQ5TWtEczhj?=
 =?utf-8?B?QmdCYTBQT2ZXczUvVk5GTEY4UkpFdGl0U0VBbW9oN2o2bGF4VDdSaGdaUjIv?=
 =?utf-8?B?TXl0TFZBUUNjS1lRSWZUMUVwZGZjbDRzYVRSSC9ZbXhJOThwRi9ibnRWeTds?=
 =?utf-8?B?VlNXWDhrL29kem9GSnphZG5KVDhvei9Hb3NjZE9VT3QyaUwvd21BSW9kQlYy?=
 =?utf-8?B?RldFSVJGTDJoRlJOTDhvUytqTUphMVFnS1BlUnFqWTdmRlV2blhjcGl6aEJF?=
 =?utf-8?B?cFRxRS9OaGdCNWdNYkZOYzNoZjZLRHVmL09RZjZ5TUtXTlg2NDFIald3a1FE?=
 =?utf-8?B?eGcraG41MzlzM1V2WlRKRHlBUkp5U01mKzZ3THU1bm1sbzVyU1gwazU0ZW94?=
 =?utf-8?B?MTRsbHBTcCtRdDhIczFMb2JNK3NOd2dJUmVBSVdIM1FDaGtUYWYycDM5bnhj?=
 =?utf-8?B?Ti9FQlpyWTg4RkFUZHBkS0x2V3YwZzVLQnBRSGdWbnIzeU1tWmZ3VFprQXZW?=
 =?utf-8?Q?9VMU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d782641-b4b4-459a-c70b-08dc2d1e7732
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 05:33:25.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJ8Y9vouSEJyK3B5RH5c0nAOA4jWovUZHVJXKr+HRLcNnnCj+gWjFdadtuYMX9w0ogtBMSmCFoBorF1uU4XgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgRmVicnVhcnkgMTQsIDIwMjQgMTI6MDUgQU0NCj4gVG86IERhdHRhLCBTaHVi
aHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPg0KPiBDYzogbGludXgtZWRhY0B2
Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsgUG90dGh1cmks
DQo+IFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29tPjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VA
YXJtLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiBycmljQGtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2M10gRURBQy92ZXJzYWw6IE1ha2UgdGhlIGJpdHMgaW4gZXJyb3IgaW5q
ZWN0aW9uDQo+IGNvbmZpZ3VyYWJsZQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2lu
YXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4g
b3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+
DQo+IE9uIFRodSwgRmViIDA4LCAyMDI0IGF0IDAzOjE2OjUzUE0gKzA1MzAsIFNodWJocmFqeW90
aSBEYXR0YSB3cm90ZToNCj4gPiBDdXJyZW50bHkgdGhlIGVycm9yIGluamVjdGlvbiBmb3IgY29y
cmVjdGFibGUgYW5kIHVuY29ycmVjdGFibGUgZXJyb3JzDQo+ID4gYml0cyBhcmUgaGFyZGNvZGVk
LiBUbyBtYWtlIGl0IGNvbmZpZ3VyYWJsZSBhZGQgc2VwYXJhdGUgc3lzZnMgZW50cmllcw0KPiA+
IHRvIHNldCB0aGUgYml0IHBvc2l0aW9ucyBmb3IgaW5qZWN0aW5nIENFIGFuZCBVRSBlcnJvcnMu
DQo+ID4gSXQgaW5qZWN0cyBzaW5nbGUgYml0IGVycm9yIGZvciBDRSBhbmQgdHdvIGJpdHMgZXJy
b3JzIGZvciBVRS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNodWJocmFqeW90aSBEYXR0YSA8
c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQo+ID4gLS0tDQo+DQo+IERpZCBzb21lIHRvdWNo
dXBzIG9udG9wLCBlc3BlY2lhbGx5IG1ha2UgaW5qZWN0X2RhdGFfY2Vfc3RvcmUoKSB2ZXJpZnkg
dGhlDQo+IHVzZXIgaW5wdXQgZmlyc3QgYW5kIHRoZW4gZG8gdGhlIGluamVjdGlvbiwganVzdCBs
aWtlIHRoZSB1ZV9zdG9yZSBjb3VudGVycGFydA0KPiBkb2VzLg0KPg0KPiBQbHMgY2hlY2sgd2hl
dGhlciBpbmplY3Rpb24gc3RpbGwgd29ya3Mgb2suDQo+DQpUaGFua3MgdGVzdGVkIGl0IHdvcmtp
bmcgZmluZSAuDQoNClRoYW5rcyAsDQpTaHViaHJhanlvdGkNCg==

