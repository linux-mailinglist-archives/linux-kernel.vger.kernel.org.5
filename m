Return-Path: <linux-kernel+bounces-156260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622908B0063
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F231C22B00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130813D8AA;
	Wed, 24 Apr 2024 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HBQkoB0D"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629E1E898;
	Wed, 24 Apr 2024 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931738; cv=fail; b=pAgHlzXRkC/FXT7aL1u+HJFjJtmb+MuSAqWMfl8U5V7/E3cfC4Kka70pl9K+QhvKXfIDZSa8qPK+drWIrBsNgpnXAYp8PIAvtepR2IAvKzoY039i8do8B+1Nfsdo1BMTvPt/eBXbjj3UWZuSeV0J8FTbNhWvTggvhlUt1BgwiSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931738; c=relaxed/simple;
	bh=0bHaIes5Jg4j6NV5K5B6Vp7rfSNOmbaIIC9Modvpa74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USMz0iL9Or6iKDusagZtLY1Q/n9fcGhMzrnVA2gOwC4ACX7EFXl1YGyi5UJMgf8plNBkR5r2V8P5QVH5EZz3jhUsK3p88vYQQ7oSA+WsNztbye78fAuxK96LTRlBoottvUsncUP3WRFqrO8H792FaorTwHapo0yU4FllXwyb69Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HBQkoB0D; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuxL5nBnReg8KrshyXRoGbkYgHAUwCuf4i3jgiaxf6mi2UXqqypigYmVLk7RPVmjyRou2X60gPTlcKKAmse1jNJibB8MaENPVZxsSwBgG7tvcnvNTm3dye+nMxsW6YuDnGsITEF0eZgWc0OSGYOAV0O8PVZV214YP//hpYtX4WWDj7U8X8Zn4gBgGUhFC6uePXNLxzrBX32OnBVsyeJq20pbBojbL/IkOcxcWk0vcCLa9361oDB8WrEVvc7MAMVmCUOb/DrrW5sQW61OGNHmNuKuyPai1z4D7e/7T8vdJ0Br31EIDp5gWGU+lsr+6flHEwu1POmPVEJRttjpqoS5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bHaIes5Jg4j6NV5K5B6Vp7rfSNOmbaIIC9Modvpa74=;
 b=d+axvqPEWCD/ZhH0uXkjKleKrwYVRi33HF3DMWE9UU3mWmK/OJswgeNpxLSZEwNrnd0se/Xw0pdTcS7p5wt0jl7OLo+sEJ05vXYNSNeKkYU3+i1AZ1Ws12Gw2zljtgEqwToWykrnTLAdl1o2Dd691spbK0HM/AgKA20mn1Wxe/MHRfH1Af1RLtykyrV7RRJnI4x++kX7wvv8C8MdombX8E/xm1F5I/GwYfnS5q8A0O4+fUsbwgQdoubmYn52KwG4iUcMs4cUdFu/tSZrgIg3oJ6xtD+ZtYORporlIenF+TGpLPsfrGd0s8O3xfLfwPy39wa+dknsky7bJTeCqAH60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bHaIes5Jg4j6NV5K5B6Vp7rfSNOmbaIIC9Modvpa74=;
 b=HBQkoB0DfYVJX1N30kLdHysa+wDVpwh2YHSuyV0bsMw9vp525yfott1h3IemDfh5ZhzcRirNa6w3EGfcjFHrMSNS18FNYOcdt4Yhe90xnlyoIKQY8+E75RJq/UjWAEoCPmBmQpJqGRrNwce4QNpvyu//GKuszqypeXnaag9CJlb5oV2AW17Mg/7iSKcDaUWR8Ne8XEEnDhsTPveU6tJ+8vOCTzDXdvu3J0tbc0ZeE9XsKQWSY4Y1fykMH7Y6SJnaXJ8U2x0XsOc9nurWoAGoAk353atUuYlHVdoiLYaQ7Y24L179xMbs07mie3k1+LP4eSZHMSURhjuQugHXoDOsIw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 04:08:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 04:08:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dongsheng Yang
	<dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH 2/7] cbd: introduce cbd_transport
Thread-Topic: [PATCH 2/7] cbd: introduce cbd_transport
Thread-Index: AQHalMCdU+yhFcnT9USE0GAfwexKu7F20LaA
Date: Wed, 24 Apr 2024 04:08:49 +0000
Message-ID: <780f3ccd-5112-4948-81c3-3144c6779503@nvidia.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-3-dongsheng.yang@easystack.cn>
In-Reply-To: <20240422071606.52637-3-dongsheng.yang@easystack.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB7477:EE_
x-ms-office365-filtering-correlation-id: ffb5f144-4be0-4f6c-ee21-08dc64143efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?aG5rc2g5UTQ2Q0c1b3JXcm15Ymt3SEpIcGpjNUVkVGVuUDhHbTF4M1prOTI1?=
 =?utf-8?B?c3NUdUVuam5aNk13aFdSSUczdFFONjVDb2h0SUxWS0JxV043NEw0RGRUT21s?=
 =?utf-8?B?SEJ2OGZCbnh1c3J5aG82TDRxY1NEWGVvanB5dzF1dTVBY1JPcEJkcFd1VzQ1?=
 =?utf-8?B?Q3FweU1XbmljeVVaK2Z1c1FaVWU4ODg4aWc0dVFpbDZFNGlmMU9GMXZ2ZkRS?=
 =?utf-8?B?LzFDb2hEdm9uWklnOFp2a1RrVDlnMDBTakNSMXlBcFhacVJudnh3bkV2RVM1?=
 =?utf-8?B?bWtkcUxFalR2enR0QW9pVm1wY000RU9ES2kyOU9wSDE0d0FDNTFYQk96aWVr?=
 =?utf-8?B?SVh4b0VPOEZxNzIzK0FxQ2gvVnNiNy9RZmw4TWFhRTBscVpBRytwMTlCQWN5?=
 =?utf-8?B?RGlzNGJRelBvTUJqUDh6Z3lWcVd6Rk8relp5VWw4dzJOR3Z2TWYxRjBtVjFH?=
 =?utf-8?B?Wm5QZEtwenNPbTU0U0FIQ0hDNnJINitaME5FOWQwK2RvKzh4MUVwWUMzTk9j?=
 =?utf-8?B?bTl4U0srNG5YS2oxZFdQVTZjWDNHcFprSlU4K01OWWxzUEg4c21EK1JEWUhj?=
 =?utf-8?B?V082aXhvZS9yNmpvOVhxUGZFdkMzYzBBNDhSaUU3RzVETjV6d2dueFlaVm1h?=
 =?utf-8?B?MDVqVUFiRlM2Q090WlFPMGJlVGpvaCtXOFB0a1RWc0ZlblNkbWZkZUxRS1VR?=
 =?utf-8?B?WUR5QVZhc3VBd0FjMG5BTnpNMHFmY29TNXFNWnZpYjhpWXJnUVl5djdWV2Zm?=
 =?utf-8?B?aE9kbXl1Vzd3Q2NLTWdCVlJJODJRVjBGUEZ0dU43b2FhemxncGxSRElFcGpI?=
 =?utf-8?B?aUZaQWN2RWtON1NPdDBjaER1QW1tK01hU1lmQmJ2ZGEyTERMZUJWQ0tFUFF1?=
 =?utf-8?B?WG9lR1oyZUV4VHVwRUQzcTBhbVdXQ2dDTUEwdVppUERCU1R1YzRlK0dVNDY3?=
 =?utf-8?B?VjBJZlNnTHRNOGFpUVN5SlVWSGd6R2VEMFFsNTRNYmdrVkFRcEJ3V1M0dGp0?=
 =?utf-8?B?UGllWkN6NHRmc1k5SXJxalRFbFA0cUF6RjZoSTlyaFRJNW9Ka1E0VkpnakJ6?=
 =?utf-8?B?RWZpWjlNc3ZEWmhpeGZpc25halgzTHBvZThrbzVPUEhZZmF5UlkwdVZFeDZz?=
 =?utf-8?B?TGNRWThOZzR4aXdFVWRPVHFEYk0rdFM2NHBIM2lXdVFBYTZjdXgvWWs4SFRo?=
 =?utf-8?B?b1p0K012MzF6dk5FMWNCWEw0M2NhamNnOVdGVGpTZkFlMWNrakVORDBySmJL?=
 =?utf-8?B?SFhKWTNWZ3k5NDczQzFRTTY0SzBCNnE2c3hrV1pwWGpIbmRaVlVnZS95WUIv?=
 =?utf-8?B?dHFvRzBkMzFIWWpsY1djcWVCNm1yK3BIRWJFc2loL0JqeWlyUkVaVW9XN1lV?=
 =?utf-8?B?UmVGQnpSZ042SXNET1pKS0pkNGJMcHZEZ2FlejRWUWtLbEFzbWJsSXZaNlBj?=
 =?utf-8?B?cS9PZlFrSWU5RDl3WExXaDFIN3R5RTkwcjA0WFNPZXRuM2JTZTlIU092bStp?=
 =?utf-8?B?bVgrbDluRTVhUnNBN0VRbDJtY2E1eDJuZ0VTNlV5UnQxdjROT05LQVYrd2N1?=
 =?utf-8?B?eHE5d08vUjFNb0hDQ2VEbUlHeUR1L3VhUE1LWVp6SVRjK1pWVUU2b1ovNllY?=
 =?utf-8?B?a0QzSHBlaDducUluRlhZVlFkWW40T1dWc1h0akpsQlJFMzRGMGNmSXlBaE1s?=
 =?utf-8?B?eWRnVk1YVmkyenB4dmFMS0lqUE9oQ2JSRHA2bFRQQjZaN2hXbW5CNXNGcVVX?=
 =?utf-8?B?OGFGZ05JN21GZi9pei9MSzdGdnJ1bVNySWE0RE5QUUJBRTZjT01oMFlZemdH?=
 =?utf-8?B?QlZxa1RuQzk0WWxjUEt1Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjJ2SkhEOU9qUDQ2aVFTQ1FTcDk4UE9wbHJDT1lxM0N4elIvSWNvcUp1bURT?=
 =?utf-8?B?L2tWK0l4Ry9uZllmWURNR1phWXg4VU16Yjd0QytCM3RzQjVRYWRpbGRodkxi?=
 =?utf-8?B?b1FEcEdWL2JESkVzZ0h2OHJ1anIzR2xhakZyWHpHRnBYczVpSFFnTkVZZVVU?=
 =?utf-8?B?SVhpWjJ1TkFYRmpzNlpxbHY2RVlZeFEra0tJdHc5eFZkRTI5T0Z6b2lJeVV2?=
 =?utf-8?B?UXFzakhFdzNGbEVsVHRSQms3a3NCV21VKzVUeUREcW1lQTlLZjl6NVdOYW4z?=
 =?utf-8?B?bTlQVzZYMU55TE9qdDk4VHQxSlpiWmY0V3gvdWhRNTRNNS9nTXZyVnh5UzBs?=
 =?utf-8?B?eStwK0k1bXhqZEliaVN1c0k4Sjd3THBYZHZ3ekw0QU9RR1QxT0p1eld0UE9Q?=
 =?utf-8?B?b3dOZkhXZWNXL29ZUTNIMzJoN0RNU2RHRldKVzV5Ukx0NFVoMVFKbDBSWEps?=
 =?utf-8?B?TFgyY1l6WksxaDBiOUhVY1ZJelp0VkU5dTZXeVFCUlRITGFjQVhhU0F4LzM1?=
 =?utf-8?B?U0YwSFhSeVpPZTFyQy9vTWkvQ1psMEYzM0RJNmtzR3pEVEZEZEFPeDJjN21L?=
 =?utf-8?B?QmE0WjlVbUwyck9qbWxWOVhsQ2dyeGIrT0YzYTlYNjdQUkhES3VDL3F5M0Nl?=
 =?utf-8?B?R0ZpUnphMzhLd05Gbk5ZWlRzdm9SWHptREF6QTd2TVkzaWIwbEtMc3N2a3Jo?=
 =?utf-8?B?NTZGRWJwSkxpOVEzcksvV2RtM1hiTjQ4MlQvK0gxTTZzMVBBd091RVdEa2lC?=
 =?utf-8?B?cTlzWVdTczFkOHhYck5nY29ZTVlZMHRmL0JUN3dhQnFCWGRtc3pwR2lqRzIz?=
 =?utf-8?B?U045OWNxODN3SWQ4K24vRzVGTm5QK1Z5VStuZG11Qi9aKzJUNHFZVUlSdkFE?=
 =?utf-8?B?QWc5dUxFR0NSUEtCQzFxSGJET0Z6T05uSU1KUFVnd3grYXhhSm9QYzhrenJO?=
 =?utf-8?B?SmZwRlpSRHhPMEFSOC92cVZxVWtmTW41Ynd6aE1rSEd2bFZ2NFlpKzd3TDNQ?=
 =?utf-8?B?WGJOMVdjMExkRGovRVlyM2RWSVk2NXBCNzd4a0VVV3JDZWU3MkQ0UFF6M3RT?=
 =?utf-8?B?dDFka0R5RWtrTTR0OVMzUjZFL2dLWEZmR1FzSjNjNDV1ZjhjRzhoY3V1SlJM?=
 =?utf-8?B?cUxzM1I1dFJVZDR3aC80WmxnRjFINFVScFNSTnNDNVUwb0J5R083R21PQzR3?=
 =?utf-8?B?NHh6RUF5cWMxQlQzT3Nhb1NhWml0K0wrRno1YWFBcGNHWjZJbmw3cEkvSVNR?=
 =?utf-8?B?eTJRcGwrUi9YWlJHa1M2bHZGVWF0czVydFFrMDJzMlRmeURBZE9NSXY2MDJB?=
 =?utf-8?B?MUdTdkhVNUlqeTRmWjloWjFxUURDRmNhZHh5dkxSL1Uza1NNOXQ4NTQrV1oz?=
 =?utf-8?B?aGI4Q0djNkdtLzVsT2tvcU91Z3l0ZW1tSlJyZnNKNStrWUxVYUVnZXY3Z2hE?=
 =?utf-8?B?ZnZLVFBjeW1xTUQ4aUVVbnV5YkwycUw1d3lMcWpEZTAwZGlpdmtGbFFvakxN?=
 =?utf-8?B?UWVPb0MzcDF6bkFENTl1LzlpYzRTV1dWdFZBeWt1cjJZclRObmQ2OVBKS1kz?=
 =?utf-8?B?Rk90dEE2V1pxdWtXcXhKT0tua25mbkREZnlubXlrZmh6SG9IK2xrSm5vVnd2?=
 =?utf-8?B?UTBpd3RxRzhGT3JwVUpwQk5nYmRJUXlCZEFOODBvbXBsZUpBQURwZ25iaWpk?=
 =?utf-8?B?WmR0MGxpdm9vZzMrenIzNDVpUmlGVVB4REM4TTIxRFAwUURGanQ2ejV6UTZJ?=
 =?utf-8?B?RUFlRWRIcXo3NXpkSXMrVUYzamhOb3Q3ZzN6OEFpOVVaZGhmYmFXWFNYeEFR?=
 =?utf-8?B?OFBzZitENUpETDVETnZnelRKNjhMTEhTVkZOMUpsaHFlVllrdFNGK1ExQjBy?=
 =?utf-8?B?VUN1TzRDWGtoZFJwa2JnSHdSN1dkUGRvSTRieENYZmZCazVuNTJKUWJaTmdC?=
 =?utf-8?B?cTZySFQ1TG1kdjZNNUM0NnVQeDZVbG9Cc0ZCeVR2NzM2OFNNWkdpQURtWTZX?=
 =?utf-8?B?L3pWWnFpYjFqbVhhN3RVVlJiOURBWGllWkhCM3ZrK2E1ZDdIQzh5K3RIazNJ?=
 =?utf-8?B?RGNJUUpLT0ZQUmlveHNHdWJZbDdTTWlWbU11MXZCcEdKS0JFL3hhazgzS1Vz?=
 =?utf-8?B?d0VsR0hGWU1jZmczV09PYUZrQXNkM2Mvc0QwbWJTL2RLQXMzTmYzdkhFZE9I?=
 =?utf-8?Q?OdviE70hPMRClMOosc8PSnkLwbK7gjo0JmXYy+7nsCFB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37117C1E526D0447AF5ECB36B5C62844@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb5f144-4be0-4f6c-ee21-08dc64143efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 04:08:49.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAgmHUUorJf+Cs+cWLUrNZlXTBgBvJSjL8Wp+UPqWSOMLdHVk4EuqNIeaTwYKB756IwWwfXqEi/7HV+Nvce/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477

PiArc3RhdGljIHNzaXplX3QgY2JkX215aG9zdF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
KwkJCSAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gKwkJCSAgICAgICBj
aGFyICpidWYpDQo+ICt7DQo+ICsJc3RydWN0IGNiZF90cmFuc3BvcnQgKmNiZHQ7DQo+ICsJc3Ry
dWN0IGNiZF9ob3N0ICpob3N0Ow0KPiArDQo+ICsJY2JkdCA9IGNvbnRhaW5lcl9vZihkZXYsIHN0
cnVjdCBjYmRfdHJhbnNwb3J0LCBkZXZpY2UpOw0KPiArDQo+ICsJaG9zdCA9IGNiZHQtPmhvc3Q7
DQo+ICsJaWYgKCFob3N0KQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXJldHVybiBzcHJpbnRm
KGJ1ZiwgIiVkXG4iLCBob3N0LT5ob3N0X2lkKTsNCg0Kc25wcmludGYoKSA/DQoNCj4gK30NCj4g
Kw0KPiArc3RhdGljIERFVklDRV9BVFRSKG15X2hvc3RfaWQsIDA0MDAsIGNiZF9teWhvc3Rfc2hv
dywgTlVMTCk7DQo+ICsNCj4gK2VudW0gew0KDQpbLi4uXQ0KDQo+ICsNCj4gK3N0YXRpYyBzc2l6
ZV90IGNiZF9hZG1fc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJCSBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gKwkJCQkgY29uc3QgY2hhciAqdWJ1ZiwNCj4gKwkJCQkg
c2l6ZV90IHNpemUpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKwljaGFyICpidWY7DQo+ICsJc3Ry
dWN0IGNiZF9hZG1fb3B0aW9ucyBvcHRzID0geyAwIH07DQo+ICsJc3RydWN0IGNiZF90cmFuc3Bv
cnQgKmNiZHQ7DQo+ICsNCg0KcmV2ZXJzZSB0cmVlIG9yZGVyIHRoYXQgbWF0Y2hlcyByZXN0IG9m
IHlvdXIgY29kZSA/DQoNCj4gKwlpZiAoIWNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQo+ICsJCXJl
dHVybiAtRVBFUk07DQo+ICsNCj4gKwljYmR0ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGNi
ZF90cmFuc3BvcnQsIGRldmljZSk7DQo+ICsNCj4gKwlidWYgPSBrbWVtZHVwKHVidWYsIHNpemUg
KyAxLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoSVNfRVJSKGJ1ZikpIHsNCj4gKwkJcHJfZXJyKCJm
YWlsZWQgdG8gZHVwIGJ1ZiBmb3IgYWRtIG9wdGlvbjogJWQiLCAoaW50KVBUUl9FUlIoYnVmKSk7
DQo+ICsJCXJldHVybiBQVFJfRVJSKGJ1Zik7DQo+ICsJfQ0KPiArCWJ1ZltzaXplXSA9ICdcMCc7
DQo+ICsJcmV0ID0gcGFyc2VfYWRtX29wdGlvbnMoY2JkdCwgYnVmLCAmb3B0cyk7DQo+ICsJaWYg
KHJldCA8IDApIHsNCj4gKwkJa2ZyZWUoYnVmKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+
ICsJa2ZyZWUoYnVmKTsNCj4gKw0KDQpzdGFuZGFyZCBmb3JtYXQgaXMgdXNpbmcgZ290byBvdXQg
YW5kIGhhdmluZyBvbmx5IG9uIGtmcmVlKCkNCmF0IHRoZSBlbmQgb2YgdGhlIGZ1bmN0aW9uIC4u
Lg0KDQo+ICsJc3dpdGNoIChvcHRzLm9wKSB7DQo+ICsJY2FzZSBDQkRUX0FETV9PUF9CX1NUQVJU
Og0KPiArCQlicmVhazsNCj4gKwljYXNlIENCRFRfQURNX09QX0JfU1RPUDoNCj4gKwkJYnJlYWs7
DQo+ICsJY2FzZSBDQkRUX0FETV9PUF9CX0NMRUFSOg0KPiArCQlicmVhazsNCj4gKwljYXNlIENC
RFRfQURNX09QX0RFVl9TVEFSVDoNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBDQkRUX0FETV9PUF9E
RVZfU1RPUDoNCj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJcHJfZXJyKCJpbnZhbGlk
IG9wOiAlZFxuIiwgb3B0cy5vcCk7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0K
PiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIHNpemU7
DQo+ICt9DQo+ICsNCg0KWy4uLl0NCg0KPiArc3RhdGljIHN0cnVjdCBjYmRfdHJhbnNwb3J0ICpj
YmR0X2FsbG9jKHZvaWQpDQo+ICt7DQo+ICsJc3RydWN0IGNiZF90cmFuc3BvcnQgKmNiZHQ7DQo+
ICsJaW50IHJldDsNCj4gKw0KPiArCWNiZHQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgY2JkX3Ry
YW5zcG9ydCksIEdGUF9LRVJORUwpOw0KPiArCWlmICghY2JkdCkgew0KPiArCQlyZXR1cm4gTlVM
TDsNCj4gKwl9DQoNCm5vIGJyYWNlcyBuZWVkZWQgZm9yIHNpbmdsZSBzdGF0ZW1lbnRzIGluIGlm
IC4uLiBhcHBsaWVzIHJlc3Qgb2YNCnRoZSBjb2RlIC4uLg0KDQotY2sNCg0KDQo=

