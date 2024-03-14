Return-Path: <linux-kernel+bounces-102867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4D87B7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FC71F21F91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90BDDD9;
	Thu, 14 Mar 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1V+xBqnb"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247ED27E;
	Thu, 14 Mar 2024 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396790; cv=fail; b=hFNpAWHuuAetmMspH5AY3jAjG+cQdJbVD8NxX50M72/Ahtb7SvTOHu+1kKhnY44H1d3XTL2wfl2dglWQ2+ydPgjXg4fHW2Z7IOnWrUOyeC1x7KVEee922AgLC1zW3En86HQxwOn27w4rr1/fNfebdvspPcGNTMHzIPb79vuUxQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396790; c=relaxed/simple;
	bh=eVOsKUtBKl04LDCeui0vqxCKNS0rDR71l/2hVVoH7Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nr+VThcsqF0BXOvY/SMBt2nZ8Qoji+zNcNYnWAhAXUM14ss5liwk/TXHvp784Ynnp7ziMJggXEEmGvLYjLINjGJf95Dn+FObTDIY1/hKkFaYwiFaezXXvsjHItdR494t9DtwCFaF0HbDDobPh+7T4ZoDXHO1hPBftVq3faiz+Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1V+xBqnb; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDQ8QfPnpA9VVhqZRYvcnJQW4ohYenNQuhoOCjcsLcvX5ZYoxS/b+vNT1tFUYm+2tPeQc9DlsmxoYAmUrR50LCPk4sfHsqgoD8b4ovBk1KTMAWrCE7Xxv3b5feLVakEh0sEHKGS+GysJSdEIE13bEb0aUyBJAkmRmjYIx0s9pAucLr6J8dXRbEhXzL2f/B6PNiQ5HSLqd9gEwSV90z30SW9VPTDT1R5p2/Bvt5yluaDtual26toZKuBRcYgTQTI65J2AHXn7+EKia3JPOWlsRRs0EOjLreV2JUu/xSZUcA6kqZh6wtLbOtOIjM0zKj2HQEJv4aKqdQ+CLlxVMHutLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVOsKUtBKl04LDCeui0vqxCKNS0rDR71l/2hVVoH7Pk=;
 b=Ass3tZTyZzTIiL8V0m1zUmiQNIPq0ERHAVodJTWGa+6NdfzFFMxd6TrcjgofkCIOlI5BJnLJNjyhzh0fNMx+ODh034XugfvLKFE8rP6BDrjVU7JJSIMANdZNnIia+vQS2b6c17xVFTCN1KL5JgfFnxvUG3uxWU6rRlLPoM3qYbCsIXnuuOlKff5SmWJKpEIy9CJT6w0+nMQ6yG9ssI1XE0MtguQt7v0LnGYZ4UGxzsaPsegj2O7d7iFUDYXfqXWB+IapNoLXBLAZTbGrJJSjZoyRtUTqKn35Fa7etFzaQj+g607m2ConBtM2M1BVTr1fkj35bGGyPC60TjPWTlWVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVOsKUtBKl04LDCeui0vqxCKNS0rDR71l/2hVVoH7Pk=;
 b=1V+xBqnbOKLJWWsWP2QTZVQe/eMYhRl6Xgz1FQw5VN4efGOfk53NiwTQnvc7znEkCWjgBc2QdjvbL7WNprbvTxIvP890maFnmcjKOMFkZO+HRHIPkaWPYaeOsX2gIwQqsKXYOvqW0aJK5wr3T7OiD+XcwzzWUTpMnR60GbmJJ18=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 06:13:06 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 06:13:06 +0000
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
Subject: RE: [PATCH v4 0/7] AMD Pstate Driver Core Performance Boost
Thread-Topic: [PATCH v4 0/7] AMD Pstate Driver Core Performance Boost
Thread-Index: AQHadS3wWRW5z/A5zkGFD1ZiIWXrbbE1wMwAgAECClA=
Date: Thu, 14 Mar 2024 06:13:05 +0000
Message-ID:
 <CYYPR12MB8655E78075A6BAF61A5B36399C292@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <2721197.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2721197.mvXUDI8C0e@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d52e3669-653f-47b1-ad96-e0016fcbf5ff;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T06:12:31Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY5PR12MB6551:EE_
x-ms-office365-filtering-correlation-id: 067be2ac-0468-44b4-4d8d-08dc43edd048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CHwgwF+NoIGXMLt7if9gWlk3gh/YoXy2tmbfSkUxMnprFMH6XFDKgwqh8pmjkQugYlrxQGq3kMSLu48J9WMaOtjUS86heAzKK4owG1gFDLuoSbLgdTJGo01RFH+2i4h2RcAyZ2DnrKJ/aPCSQbH5ckhW6P0WQaBA8lRDjXqV/oo8b8aVX/Itju4+oOLsoXKwkh4HJbM85iNlg+UjLkN6nbGFB3EOn7rHB2z4sN06XUccNzqN76C+7++bBi23UDN1NxyUWO4Bgq+iHqh1pJTldchI856pBYzJmRlhlh4fPTHnz8jSM7LhRcwOmfwC+ytWrEWdFdWMrNJ6AqC6Lp7YOsUDwqhKp4nPqR8VfoJAio9u9qKQAhJ2kH4YzY7RXnoSVhaS4Pn6bs3v5M/lFc8uMp/r5gU8MkMRq0WEiX6pFnnFMOs75MmSndqhuAUf4QqkGeR7EKK9NK8/ppXIylRBzlLjmRNP5dvTY+8iUtDWK6QXIU9T1bPompJnA3MTbzZp2xTytXZf894ne0Xx2UuxB9KtV5/FpmS0XKKowLvxHFywqWIzIX8Fce7WVS7U5UWENouRtSNiNiOrYuQoAJasyoRaJKeVFWaiJ6FOERHibl3rOLQfDuQe3txnsovagwjx38PNMH1YWqokZOI/AtQulc3k7cxkLeZRpywqffFBd9sr34BschM7d61TZXm/JgyL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVk2WXZ0eUtuOFFTZTg2RW03VEw0TTR6WGVlVk5reG80aDkzVXM5U2pYMGEr?=
 =?utf-8?B?Z0RRUnBRYk1VQmV6ZHpRbktFSUFpQXJTR3VPMzFBR0RlL3lLUlE2NmxjWDhk?=
 =?utf-8?B?blpGUUtLTmI3ZzB4U3lnVUswRDI1TVBFLzhFSXdHSkxMKzljbWk4WWNGbnJ0?=
 =?utf-8?B?a0pMNVVsN1FEeDhUNzUrZHJCS3c4dDgxVGd6b1J2LytwOHpGOU50RDZRRjB6?=
 =?utf-8?B?Z0ltayt6SnI4SysvSTRHTkhRTW81aXo3bTBndlQzRnRBMFVpRHJWbWtCckNo?=
 =?utf-8?B?SmF2bThRVE8wS1RHaVFvNERKSE1YTXhvNXVMRkVUNWdoTGlJMmIvTzViU0ZL?=
 =?utf-8?B?L3Q5ekhlNEMxTGhiMGNKNjVZRkVnSVFKNVQ1V3plT2xSdS81dkFDbEovUmhl?=
 =?utf-8?B?Zmg3eThPTE84WkRhdWFWZXF0eDFCSlNoUDFqT1M4WCtiY0h5Ly84MytGQlhS?=
 =?utf-8?B?WkhGamdJZHl5cHE3VzVqZGlWSjdnbTN1T09kQzNuMm5zYStZWXVGRFJBZm1j?=
 =?utf-8?B?RmVrMFBvQlJXVnNsc3E2a2V2UkZhWldaYU41M3JxM3A5TWRyaHR6NHB4dld3?=
 =?utf-8?B?OHB5aG5qM3Y1V2lFeDRNM2g1K01ZWVpadVg1bzJHaW11dUJUdUY4Y2FOeTR2?=
 =?utf-8?B?ZU5CemFrY201UTZ0L2tCalhCRjB2ZVpPUmpRcnNyR1B0OURhMkRaOXgzWHNp?=
 =?utf-8?B?Qk9CbFZWYmRWTGJyQjh6U0Z6eTE5VnZ2MDV5b2pqdUhPVFk1ZlhVdFZxQXFF?=
 =?utf-8?B?WlF4QVVrUDNiSjlIQWxxc01KcjN5ZmkrY0tVd2FydHNPR1hlQ1F5bnlSU3A0?=
 =?utf-8?B?OFFMdk5uQk1DUURhWWN1cTVIUkNMT0xEbUVMSU9ZSy9ZZk96MTV2NzdpR01T?=
 =?utf-8?B?WmtRWGt4Y2orUFh5b0JLbFozSHhBanBFMmZ2MVBYYUExYXVBLzcwQ1J1Zm5p?=
 =?utf-8?B?eVYvSHpob3NPMlVlNHBXYklXWm1qZzZBNm4rMjlPZWs1ak1RUXRUNllhK2du?=
 =?utf-8?B?VWwyamMxUHVJWEtYUEdBSmFjek0zTVRBK2NWWk12SzBQVDBBQzRDMnZqNWM0?=
 =?utf-8?B?dmZEUHhLNUlTaGZTTFNJYnpGMGtWMkU1aitzTGxrWW5zcURtSXFvT1JnQUx6?=
 =?utf-8?B?NnFwTW1hR0FOdG96L3ZjNjZCRWo0UmZWR0ZXUGJ2MWhDUXJzVEFLWjVRMG83?=
 =?utf-8?B?d3BUaDBFeVpDZ090T3ladGpwRWtveHBUb2tjSmd6cy9jaTNMdk5KdU9ZNEpw?=
 =?utf-8?B?OUsxUXM3eDhTMkhuM2xxOXRMNmdnYisycTQ2bDJFNEo1NDF5UGRhbllrWXlQ?=
 =?utf-8?B?Z1J2cThGZGNmcExTeHlqRnNOMy9TKzBld2g2VXFRMEFVM0dNZXNyS3o2bTNB?=
 =?utf-8?B?ZkswUXRqeXdKTEJpL1dXTHZPMENaMWtsMXpPTkdZU3JvUUR3eDRKZTB6SVVz?=
 =?utf-8?B?ckNmZS9RTC9SeGpEUXh0c3h4NWR2TmpOeU8wcng5RlJWS3NwM0p4VzQzdDJD?=
 =?utf-8?B?YW12TkxtYlpjekx6YWh1S1JtNEJ3MU1YWTU0VXJsL0RHVW5qTzBKQUJtbkQ0?=
 =?utf-8?B?Sytyd3V1QTlJUSs2OEdYUHVTRVU3eHZGTTNuakNRZFdYVDRiRHYvUHJSN1BS?=
 =?utf-8?B?djAxemw1eFNLMkt5QSszTi8vR2xtSGlTMmJRTVZlb2JIeE9OOGl2YXQzSDND?=
 =?utf-8?B?Rk9FTkpWZUwyZGtId3Rkd21CRkVqUmZqbmxZVlZveHV0ZXpwNE5uNEFNdFVz?=
 =?utf-8?B?RFpMb3AxclJiKzZKclkxNG1TZEJLcEplalNYRjhtUFJZMHJvQmNxc0tIOVRM?=
 =?utf-8?B?OHVuK1BvWjJSWFlZQmsyaWl6dGtqVjFEbVdiRE9qYW93VER4clhKRnVHdkdB?=
 =?utf-8?B?QUZtcE1Id2VXZXo1L1F4ZEo2b1VSTVgxSmluYlI0UzZ1WGZReFRCblZ2Mzl5?=
 =?utf-8?B?WEpZNGw4NHpKM1QwK081bnppQkE0U0dBWFhjdmQxSWZKZGxnY3ZiRnBmajg0?=
 =?utf-8?B?YVlRUXBKdUdKS09Ud2pVOGNJQUFObHM4WSszL2RPODlBY21zZnFWRWFWVGVM?=
 =?utf-8?B?ajBKcDhkeVZpQlQ4VCtxYmhDQVF5L0Q2UWx3anlnSVhzcWpITDFNUWc2MkV1?=
 =?utf-8?Q?Bk7o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 067be2ac-0468-44b4-4d8d-08dc43edd048
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 06:13:06.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXyRIJvzQCBlbSS2NGmotWLbcnL3OdsljyUG3WNvKkIwxZ+hCUVP7bFzeqDftGwtpunP6SHym4M/+CAPkzoKOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5r
by5uYW1lPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEzLCAyMDI0IDEwOjQ5IFBNDQo+IFRv
OiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJp
by5MaW1vbmNpZWxsb0BhbWQuY29tPjsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBS
YXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgU2hlbm95LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1
dGhhbS5zaGVub3lAYW1kLmNvbT47IFBldGtvdiwgQm9yaXNsYXYgPEJvcmlzbGF2LlBldGtvdkBh
bWQuY29tPjsNCj4gWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVy
DQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFt
ZC5jb20+OyBNZW5nLCBMaQ0KPiAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1w
bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC83XSBBTUQgUHN0YXRlIERyaXZlciBDb3JlIFBlcmZvcm1h
bmNlIEJvb3N0DQo+DQo+IE9uIHN0xZllZGEgMTMuIGLFmWV6bmEgMjAyNCAxMTowNDozNywgQ0VU
IFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4NCj4gPiBIaSBhbGwsDQo+ID4gVGhlIHBhdGNoc2V0IHNl
cmllcyBhZGQgY29yZSBwZXJmb3JtYW5jZSBib29zdCBmZWF0dXJlIGZvciBBTUQgcHN0YXRlDQo+
ID4gZHJpdmVyIGluY2x1ZGluZyBwYXNzaXN2ZSAsZ3VpZGUgYW5kIGFjdGl2ZSBtb2RlIHN1cHBv
cnQuDQo+ID4NCj4gPiBVc2VyIGNhbiBjaGFuZ2UgY29yZSBmcmVxdWVuY3kgYm9vc3QgY29udHJv
bCB3aXRoIGEgbmV3IHN5c2ZzIGVudHJ5Og0KPiA+DQo+ID4gIi9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+DQo+ID4gVGhlIGxlZ2FuY3kgYm9vc3QgaW50
ZXJmYWNlIGhhcyBiZWVuIHJlbW92ZWQgZHVlIHRvIHRoZSBmdW5jdGlvbg0KPiA+IGNvbmZsaWN0
IHdpdGggbmV3IGNwYl9ib29zdCB3aGljaCBjYW4gc3VwcG9ydCBhbGwgbW9kZXMuDQo+ID4NCj4g
PiAxKS4gZW5hYmxlIGNvcmUgYm9vc3Q6DQo+ID4gJCBzdWRvIGJhc2ggLWMgImVjaG8gMCA+IC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+ICQgbHNjcHUg
LWFlDQo+ID4gQ1BVIE5PREUgU09DS0VUIENPUkUgTDFkOkwxaTpMMjpMMyBPTkxJTkUgICAgTUFY
TUhaICAgTUlOTUhaICAgICAgTUhaDQo+ID4gICAwICAgIDAgICAgICAwICAgIDAgMDowOjA6MCAg
ICAgICAgICB5ZXMgNDIwMS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+ID4gICAxICAgIDAgICAg
ICAwICAgIDEgMToxOjE6MCAgICAgICAgICB5ZXMgNDIwMS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4
DQo+ID4gICAyICAgIDAgICAgICAwICAgIDIgMjoyOjI6MCAgICAgICAgICB5ZXMgNDIwMS4wMDAw
IDQwMC4wMDAwIDI1ODMuODU1DQo+ID4gICAzICAgIDAgICAgICAwICAgIDMgMzozOjM6MCAgICAg
ICAgICB5ZXMgNDIwMS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+ID4gICA0ICAgIDAgICAgICAw
ICAgIDQgNDo0OjQ6MCAgICAgICAgICB5ZXMgNDIwMS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+
ID4NCj4gPiAyKS4gZGlzYWJibGUgY29yZSBib29zdDoNCj4gPiAkIHN1ZG8gYmFzaCAtYyAiZWNo
byAxID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvYW1kX3BzdGF0ZS9jcGJfYm9vc3QiDQo+ID4g
JCBsc2NwdSAtYWUNCj4gPiAgICAwICAgIDAgICAgICAwICAgIDAgMDowOjA6MCAgICAgICAgICB5
ZXMgNTc1OS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+ID4gICAxICAgIDAgICAgICAwICAgIDEg
MToxOjE6MCAgICAgICAgICB5ZXMgNTc1OS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+ID4gICAy
ICAgIDAgICAgICAwICAgIDIgMjoyOjI6MCAgICAgICAgICB5ZXMgNTc1OS4wMDAwIDQwMC4wMDAw
IDI5ODMuNTc4DQo+ID4gICAzICAgIDAgICAgICAwICAgIDMgMzozOjM6MCAgICAgICAgICB5ZXMg
NTc1OS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+ID4gICA0ICAgIDAgICAgICAwICAgIDQgNDo0
OjQ6MCAgICAgICAgICB5ZXMgNTc1OS4wMDAwIDQwMC4wMDAwIDI5ODMuNTc4DQo+ID4NCj4gPg0K
PiA+IFRoZSBwYXRjaGVzIGhhdmUgYmVlbiB0ZXN0ZWQgd2l0aCB0aGUgQU1EIDc5NTBYIHByb2Nl
c3NvciBhbmQgbWFueQ0KPiA+IHVzZXJzIHdvdWxkIGxpa2UgdG8gZ2V0IGNvcmUgYm9vc3QgY29u
dHJvbCBlbmFibGVkIGZvciBwb3dlciBzYXZpbmcuDQo+ID4NCj4gPiBJZiB5b3Ugd291bGQgbGlr
ZSB0byB0ZXN0IHRoaXMgcGF0Y2hzZXQsIGl0IG5lZWRzIHRvIGFwcGx5IHRoZQ0KPiA+IHBhdGNo
c2V0IGJhc2VkIG9uIGJlbG93IG9uZSBsYXRlc3QgdmVyc2lvbiBwYXRjaHNldC4NCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwMjA4MTAyMTIyLkdBWmNTcklrYlBKZklFeGRG
NkBmYXRfY3JhDQo+ID4gdGUubG9jYWwvDQo+ID4NCj4gPg0KPiA+IFBlcnJ5Lg0KPiA+DQo+ID4N
Cj4gPiBDaGFuZ2VzIGZyb20gdjM6DQo+ID4gICogcmViYXNlZCB0byBsaW51eC1wbS9ibGVlZGlu
Zy1lZGdlIHY2LjgNCj4gPiAgKiByZW5hbWUgZ2xvYmFsIHRvIGFtZF9wc3RhdGVfZ2xvYmFsX3Bh
cmFtcyhPbGVrc2FuZHIgTmF0YWxlbmtvKQ0KPg0KPiBXb3VsZCBhcHByZWNpYXRlIGJlaW5nIGlu
IENjOiB0aGVuLg0KDQpTdXJlLCB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2ssDQpXaWxsIHVwZGF0
ZSBDYyBsaXN0IGluIG5leHQgdmVyc2lvbi4NCg0KUGVycnkuDQoNCj4NCj4gPiAgKiByZW1vdmUg
Y29tbWVudHMgZm9yIGJvb3Rfc3VwcG9ydGVkIGluIGFtZF9wc3RhdGUuaA0KPiA+ICAqIGZpeCB0
aGUgY29tcGlsZXIgd2FybmluZyBmb3IgYW1kLXBzdGF0ZS11dC5rbw0KPiA+ICAqIHVzZSBmb3Jf
ZWFjaF9vbmxpbmVfY3B1IGluIGNwYl9ib29zdF9zdG9yZSB3aGljaCBmaXggdGhlIG51bGwgcG9p
bnRlcg0KPiA+ICAgIGVycm9yIGR1cmluZyB0ZXN0aW5nDQo+ID4gICogZml4IHRoZSBtYXggZnJl
cXVlbmN5IHZhbHVlIHRvIGJlIEtIeiB3aGVuIGNwYiBib29zdA0KPiA+IGRpc2FibGVkKEdhdXRo
YW0gUi4gU2hlbm95KQ0KPiA+DQo+ID4gQ2hhbmdlcyBmcm9tIHYyOg0KPiA+ICAqIG1vdmUgZ2xv
YmFsIHN0cnVjdCB0byBhbWQtcHN0YXRlLmgNCj4gPiAgKiBmaXggdGhlIGFtZC1wc3RhdGUtdXQg
d2l0aCBuZXcgY3BiIGNvbnRyb2wgaW50ZXJmYWNlDQo+ID4NCj4gPiBDaGFuZ2VzIGZyb20gdjE6
DQo+ID4gICogZHJvcCBzdXNwZW5kL3Jlc3VtZSBmaXggcGF0Y2ggNi83IGJlY2F1c2Ugb2YgdGhl
IGZpeCBzaG91bGQgYmUgaW4NCj4gPiAgICBhbm90aGVyIGZpeCBzZXJpZXMgaW5zdGVhZCBvZiBD
UEIgZmVhdHVyZQ0KPiA+ICAqIG1vdmUgdGhlIHNldF9ib29zdCByZW1vdmUgcGF0Y2ggdG8gdGhl
IGxhc3QoTWFyaW8pDQo+ID4gICogRml4IGNvbW1pdCBpbmZvIHdpdGggIkNsb3NlczoiIChNYXJp
bykNCj4gPiAgKiBzaW1wbGlmaWVkIGdsb2JhbC5jcGJfc3VwcG9ydGVkIGluaXRpYWxpemF0aW9u
KE1hcmlvKQ0KPiA+ICAqIEFkZCBndWlkZSBtb2RlIHN1cHBvcnQgZm9yIENQQiBjb250cm9sDQo+
ID4gICogRml4ZWQgc29tZSBEb2MgdHlwb3MgYW5kIGFkZCBndWlkZSBtb2RlIGluZm8gdG8gRG9j
IGFzIHdlbGwuDQo+ID4NCj4gPiB2MToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
Y292ZXIuMTcwNjI1NTY3Ni5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPiA+IHYyOg0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTcwNzA0Nzk0My5naXQucGVycnkueXVh
bkBhbWQuY29tLw0KPiA+IHYzOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292
ZXIuMTcwNzI5NzU4MS5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPiA+DQo+ID4gUGVycnkgWXVh
biAoNyk6DQo+ID4gICBjcHVmcmVxOiBhbWQtcHN0YXRlOiBpbml0aWFsaXplIG5ldyBjb3JlIHBy
ZWNpc2lvbiBib29zdCBzdGF0ZQ0KPiA+ICAgY3B1ZnJlcTogYW1kLXBzdGF0ZTogaW1wbGVtZW50
IGNwYl9ib29zdCBzeXNmcyBlbnRyeSBmb3IgYm9vc3QgY29udHJvbA0KPiA+ICAgY3B1ZnJlcTog
YW1kLXBzdGF0ZTogZml4IG1heF9wZXJmIGNhbGN1bGF0aW9uIGZvciBhbWRfZ2V0X21heF9mcmVx
KCkNCj4gPiAgIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGZpeCB0aGUgTVNSIGhpZ2hlc3QgcGVyZiB3
aWxsIGJlIHJlc2V0IGlzc3VlDQo+ID4gICAgIHdoaWxlIGNwYiBib29zdCBvZmYNCj4gPiAgIERv
Y3VtZW50YXRpb246IGNwdWZyZXE6IGFtZC1wc3RhdGU6IGludHJvZHVjZSB0aGUgbmV3IGNwdSBi
b29zdA0KPiA+ICAgICBjb250cm9sIG1ldGhvZA0KPiA+ICAgY3B1ZnJlcTogYW1kLXBzdGF0ZTog
cmVtb3ZlIGxlZ2FjeSBzZXRfYm9vc3QgY2FsbGJhY2sgZm9yIHBhc3NpdmUgbW9kZQ0KPiA+ICAg
Y3B1ZnJlcTogYW1kLXBzdGF0ZS11dDogc3VwcG9ydCBuZXcgY3BiIGJvb3N0IGNvbnRyb2wgaW50
ZXJmYWNlDQo+ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRl
LnJzdCB8ICAxMSArKw0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS11dC5jICAgICAg
ICAgICAgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgICAgICAg
ICAgICAgICAgfCAxNTcgKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9h
bWQtcHN0YXRlLmggICAgICAgICAgICAgICAgICB8ICAxNiArLQ0KPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDE0OSBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+DQo+DQo+DQo+
IC0tDQo+IE9sZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFjdHVtKQ0K

