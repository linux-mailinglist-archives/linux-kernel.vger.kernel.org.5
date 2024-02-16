Return-Path: <linux-kernel+bounces-68583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD0857CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2619AB248A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74612AACD;
	Fri, 16 Feb 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJ3omxRP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A296129A79;
	Fri, 16 Feb 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086912; cv=fail; b=qvmZZ9z3hCc8jzVG7aDxfqNrJPdp0T1hklMYXtDHCvh9sZBLpXvr3KPYFjPuGWbI0AAcwHC0jiQdjYg9ydpjbMx2/d6g/6/hdRspfmCqT/Tddfpx8/1vAHvwNj5ZlIhBFz8XTjslNWYvDt3Mlo4Cl2wqF9bH4LTZud6A/aF+YRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086912; c=relaxed/simple;
	bh=Tt8hQ+OBW3iAkpfpDq421KwXzgfP3ChrbqF9IpFp0+Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JNWW6By1VM5gW8sARxgrq4t4hNBQdfpSw/o30ohka710JIKaVU/tfVHUdNM+IWNXQUq4CBxdPCyXG0S7QhBlwXBdlbtydDQmGhh5OHr2rBlPCv2/6apHEjJV2XVu0vrnKXPfST4cdkUBBdSStXW900K4QLFO971abIUQ58RkUv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJ3omxRP; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPGyBo3BDexyHZVBVhSs25/YW9TBKVLZk4OKivJULJvyPhQIdS01A5BR+9N2NSbS8vw+NfKG6YLPey18JSRnIT3YcNRpCrCUlOcdXjmUQZe60VGdfJQIixzYjqwQ1tVSJHVeD/yTxltz3jykOyvOMJULb30Hpu4BJhxvvY/kvFdN0bdelvFxiQxGcZiOlZR3zP+HM82jv8Xmcd9I7pRj9OIqOBRjtVpkOK6VMJ70BCpZOrA8DpNgX8Z0QOt+I4BEbB6mKJx3gyNQHpGFEpCXRQxg1dxJ286IMyYpyQVX64DxXUwKtmrMGROPFwrMUhXvtYkf88AURxXYnNDTrNt62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt8hQ+OBW3iAkpfpDq421KwXzgfP3ChrbqF9IpFp0+Y=;
 b=iWfoU4SxAJyJDY5ZuTZ9Qb5IQV114APD228AdpY5tI8mSmjlG6bIN5H/QYvVxC7WG3Ep7qxDGZ9tJyz0hE6AOQkhCd4TNthqAGmtWK1Tw91uMxQvPp8Qn13DOEsSGzpgG/B6vmTox0lqOqexw/u/hkhPeOLtMU2R6O7x0V8Lq5puRx4FLMmQR73+iIzoSKy6Egj8swg+L20NNZYSC6DQXk6iwTYwz4HrRHPKDYVvBt55tugcq+575USHDcpXt/kWF4qS/gsuIDcYhLdrUC8DRGTErG60klGpOJoNLROhTlojlbu1CUWE6pBxX37YUnJrgRItiBHPVgtHWwWzO8U2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt8hQ+OBW3iAkpfpDq421KwXzgfP3ChrbqF9IpFp0+Y=;
 b=UJ3omxRPI+Fo7ZRLM/gHqvmO0kYMsTm/tfaV6BBO0feG4DZoInuaDcCbc6QUqH6lOOWNXy7pADtYDwNkcye7Iu0kpnsyZxH/8sdug4J9v+oFYI/u0PEP6Twlyqr6yfRnHjDYll5nss3AYV9FEmjrMMOUhQYFx5kGwFwBmitJiC5YvlyL2wQptymOieQsxS+j7rkzm3ygXuF5MYt6MgNLYKBY5HSASfDDaTxIBZVc9RWoCU1QEFM2p6fyGyImoitbug5cfpPXvTGP5oHvvzcdmmOxsrZ584hHsMYGseQ40+Y2/Em0kFMGzHy0v6x3EHa7ShWVl9MvIAvBr08HrK/Tuw==
Received: from IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 12:35:06 +0000
Received: from IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9]) by IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9%7]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 12:35:06 +0000
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
Thread-Index: AQHaYK7sRrXCgq4S8kiezeGwvtHyoLEM1uEAgAAN+BA=
Date: Fri, 16 Feb 2024 12:35:04 +0000
Message-ID:
 <IA0PR12MB8906755426577E8496BA65B3B54C2@IA0PR12MB8906.namprd12.prod.outlook.com>
References: <20240216080450.456135-1-petlozup@nvidia.com>
 <CZ6GZLO63NL2.3FNHFOQ3W3JSY@gmail.com>
In-Reply-To: <CZ6GZLO63NL2.3FNHFOQ3W3JSY@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8906:EE_|IA1PR12MB8556:EE_
x-ms-office365-filtering-correlation-id: e8a99f00-9aa0-4e53-24da-08dc2eebb3bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qg8z2ID5k4Udoq/hX6BmxroKC6Un07e+qTq+gE0yC2f80cUSx1MLCON4C+76INw/wV+P72qVLsIlGhagtQeDHktXE0my6vN+yf7yNa6Xw0pQLZymErgNkDEIQBvRA8p0/m+UUB1PVB4Adt1p3xT4l7Gb9ugHMv5e75ZV3OHEhLSGenXcrxe6jIq8Wj7HpmKucffs7+xZzoJvq2mM3QUyKLH3k2N2Jk5JSDiKkGF1hCMiZtJakUpzp5o+tVrH70s03Es8/y1LHkSgOpnWG3GvDBI+WUgt9yBs94pwr/LvacZM+/1hyClqzkV/h3r5EYjGJNWrWK8Ihw7LYDRZoJ46mpGeqVEspjiIkl4nMRIZnX0RjYLk8xrMTdq5dH08lospZspXkrPScUCO+808H9Vpya/YVioHwKeyap7+8QnVxMKeVJYa10zt4U03XNWpiZMnPYPv6/E5dkm+TefPvUpjrbuzkaLwO4XqeOavbrFw8o9vuEmoQgkdSntTrC9ubpcFEH58x2ovs3GLxh9pSD6B0S3kPrrlTbmrOAtAII2psuYpdyoyBlvbvSda4fYPxhMgdz1jzG60rkfxa4SM539jWtCzgdt7WBtBXigc/n1iRwWx8Qg1/jqYT90okPzKYlAo11f+bWg7HEiGbnVgvMgEDw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(55016003)(5660300002)(2906002)(83380400001)(41300700001)(8936002)(66476007)(8676002)(66446008)(64756008)(52536014)(66556008)(478600001)(76116006)(316002)(66946007)(921011)(38070700009)(26005)(33656002)(9686003)(7696005)(6506007)(71200400001)(110136005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEc2a04xUitIMmlEaTZKcW43Z2R4Qk9oOXJXSkh3Q2lsSVFURDVzbzZ5bWpq?=
 =?utf-8?B?R2RHMXUzK083RGpacWo3V2hpWmpmWHBnWnhWcmFOUFlIZXRVdG1UM2IzWmhs?=
 =?utf-8?B?T0M3bkF2QjcwcWwvSHRHenAwMllDV1dZcUNsdTdSTnVEQVJwbFpNQ3UzYzVo?=
 =?utf-8?B?SHI0YzNOcWEzZzFERURCWjh1K3dvZFNIdmp5ZnliUEVWMFNSVm8xRGJjdjdp?=
 =?utf-8?B?aWJvaytpN1R5Znk0blZpUGh0aWF0K1BIM1RHYkNSRzBDTVdWTGpVcHNaeWtC?=
 =?utf-8?B?M0tGemMrRDhraUUvZFVPZUFKSjJveXp5aTdKc1pvV0tXcUd3S05taDVKTFdF?=
 =?utf-8?B?d1YwdDBid210OGpnblI2eFgzcThOajZUbjRBQWp0L2hRQVhydnJ0eGJSOStG?=
 =?utf-8?B?cVg5YkJ3YjE5NG1CajQ5SlRTcHphY1c5SjlOanpqa3ZWdGNOeEVTMUl2NVJn?=
 =?utf-8?B?NzJ0ejJsdmZTUzMxdGUzemdnWkY1WjUwM04yV2RMRjhyampsb1Q3ZmdPdS9n?=
 =?utf-8?B?V0ZnMWM4Ym9ZTGgvbzU5MkJqcXVTMTdsUFFqN1FGSWlFNXc1OU5aWnZKK2pM?=
 =?utf-8?B?dzVPTDFHTXN3NFBINGp2VEoxRmU1R3A2MmFoOUo2cFBCYkVsVnA1WENlT25Q?=
 =?utf-8?B?Ynp0RGV0NmFNVDhqWDBPL1hid0ltdTJPTzIvSWFoSzRsRmZWTW1LZDJ3aktV?=
 =?utf-8?B?RFU5MGFtQjVjVUtReklOTDJPa2VJWXNJNEVTWXlBUEh2NHRIaXBjem1HSlgw?=
 =?utf-8?B?cE9BcnFlVmFMQ2xhODlpOE5aTnRmVWhGSXpDNTVrSStlaE1HeFpYR05rUFVx?=
 =?utf-8?B?K3VjNjF4Nkx0emk4ZGkxcWZNNmcxTUlweCtaSXlkbThDQi8zWmhyWlE2dzFW?=
 =?utf-8?B?YWVWQXcrOVZHVU1BSTRBaVVJcmlLMUg4clRyaXlJajIxMFlwOEZZZ2hxK3Bz?=
 =?utf-8?B?TWVKSC9DMnRCMVprWG5qbUkwT2tCMmNDWDVzaWlnK3VGZ2sxSXI1Y2phcDJ6?=
 =?utf-8?B?NGdndndmem5WYzhvSzlFa01uZ2ZQeEVJUWxYRlYxRmIzM1BKY3YyYVhiS293?=
 =?utf-8?B?RFdTOGV6UDRQUDNqZmVhQUZRRVFnaFdhV2MrcFp5cjlkV2R3ODZuSXRzQ1ZH?=
 =?utf-8?B?bnB3UE1mSTR1YlhhRFRFbzFtYVluTStWazZYcGlERndIUVR0VGQzYmwvMHdo?=
 =?utf-8?B?aCtJQUw5djErUTJvTGZYNUhCeWdQOERteHVsalplZkUrYWsreUpXRTBEQlJO?=
 =?utf-8?B?OGQ5SEdaY1VRalBCZnhHMTRMNnhYMHNCWlprTDJQUDZJZVluRVVvc0xxbHMv?=
 =?utf-8?B?SmRSUG9IRFZld2psOWtkdXo1TTAzeUlRaHpsYXBUT2k4TTduWjB1WFh1SDkx?=
 =?utf-8?B?Mm1jWFdhOXN3ak1zdFdjMUVLc1pmU2NsenhjUWhpd1dheHhpSGdYeTd2Q1Rt?=
 =?utf-8?B?MTFlWkhuR1ZQZ25rOEM1Qk9EY2txNGxpVzhBUXpIa0R3dGROUVZUWUV0UXV4?=
 =?utf-8?B?Y0l4QmtYTHAxTWtpUDhSMzg2QlIwcDJZeHowZWZzWE1Jbm0wNW12OHNRYjlI?=
 =?utf-8?B?NUZxZjZUUXVaclM0Q3NOeC9JUUd4N3dlL2lUUUcyMHFLaTZJWWk0RmZ2QjRC?=
 =?utf-8?B?SGo3Z2lQbVVlZG1DdjlnS2Y2T1g4YXdPOS9JNTI4UW1CQW9vNTdCa3NNay9E?=
 =?utf-8?B?d0k2bjhJV3JqTEpzeEhGMHpvV0xvYXB5VExvaWk2Q1lEbE8rYnJFMUU1QVJ0?=
 =?utf-8?B?MHJJYzFrYlVZVUMrQXFyZlRFRXFEWG9BZDNPa2VWeUtkeEVReHAyQmJVSE9a?=
 =?utf-8?B?OXppeDBYZjRYMGxYaUZDdVRGdUNaUkFZdU1sajBHQ29hb05KbVorb005UkRD?=
 =?utf-8?B?amtRN1pseGtxKzE5SFozd2FuY1lZZC93c2FYaEFnUTJtNS9PNHQrcTRaZ293?=
 =?utf-8?B?Nzc0MUtTRDdlRnFtOVJWdEdFUkZkQnRwVmhzenJ1T2cyNmxWSVVsUHZOM3p2?=
 =?utf-8?B?Tjk2T0Z2ZTZ4b3ZNeFEzN1poS1lQOHROdnJBa0xtQ0U2ZVczeGFXQnFGT3FT?=
 =?utf-8?B?UFo3b3hIUHRNUVVyUEdWYXN4anhmN2duRnVvaE1uTTlvK0tzbEtUWmVBOFVM?=
 =?utf-8?Q?Wo7kGVOtIzmsq93WUa8S9tlX4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a99f00-9aa0-4e53-24da-08dc2eebb3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 12:35:04.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfP+OjW67q7FdEjSilkJjgqMQ+33ITyhiKqOYL5u1Jb5iZ/Sf8IJQ8IDKywCoUB0lR06hKwTfrsw4V9dmraJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

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
NykpLA0KPiANCj4gSSdkIHByZWZlciB0byBzdGljayB3aXRoIC0gaW5zdGVhZCBvZiBfIGluIHRo
ZXNlIG5hbWVzLCBsaWtlIHdlIGRvIHdpdGggc3ctd2FrZS4NCj4gTm8gbmVlZCB0byByZXNlbmQs
IEkgY2FuIG1ha2UgdGhhdCBjaGFuZ2Ugd2hlbiBhcHBseWluZywgcHJvdmlkZWQgeW91DQo+IGRv
bid0IGhhdmUgYW55IG9iamVjdGlvbnMuDQo+IA0KWWVzLCBsZXQncyBzdGljayB3aXRoIC0gb25s
eSBpbnN0ZWFkIG9mIF8gaW4gdGhlIG5hbWVzIGZvciBjb25zaXN0ZW5jeS4NClRoYW5rcy4NCiAN
Cj4gVGhpZXJyeQ0KPiANCj4gPiAgCVRFR1JBX1dBS0VfSVJRKCJydGMiLCA3MywgMTApLA0KPiA+
ICAJVEVHUkFfV0FLRV9JUlEoInN3LXdha2UiLCBTV19XQUtFX0lELCAxNzkpLCAgfTsNCg0K

