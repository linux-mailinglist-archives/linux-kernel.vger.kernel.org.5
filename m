Return-Path: <linux-kernel+bounces-156283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436828B00C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6F4285620
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695A7154BE9;
	Wed, 24 Apr 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqgZ6I20"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAC328DB;
	Wed, 24 Apr 2024 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935035; cv=fail; b=aCNOY8jWg//Hphha62XO+8kukZzgf+93B6oT+ytmHSgx6kLM4l6NH/PGDLXVQZbpNchC9kHdnSmtlsGjJioX37VrjCX8ugiwlifZiVO5M65nUQtMLJZeKu+y4fUxXHXgLrHlqqBBV5VKOjM0FZ7p+xhMP+yBztFHeMDE5oOfM3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935035; c=relaxed/simple;
	bh=IGJ6OFitoAsI7CuQ6kiUdtQO+VI6omILM8R1bh6OgqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X7JiKEOueYLr3+SwRQBk2q/fywDzJYxRbvS76E9twX/xkePdd3YoUDtB5bhoR9zwopixU8MsCTNz0vOMkA2aDSKi25oGfuevGxyJnikZrYyqKBmpTiErzYlvPrvcNXMn02H6tU3ar94Uab/laG2NobjUT7KKdgzf0wbIGSflNGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqgZ6I20; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge2cigatnh5epAK9StL4F4PPbTVjoy8mwAEfK6C1CJaCGE+Q+hU/AWNskboWL6EWXRMZf8Wsxf/Ei2AtdIZIruR0NWsS4KSsCa27ExaR2GDVnLuq1gns3eKWmeT/diezcD+Lb94PiQXx/rXO5lPZ20Hdn7KE3zrdDw4RSLaxu3UVOyjNkzhjgLIUonbEm2RhxiAuAKHqyaKYPkZzzQcYeIS0KN7nqDa1pBVUnpGvND9JxvYtUe7fekNRUsmGVv7lRq7sIUdShNt2p67tu4GB5dgT5zKcH1fG8xgb6zcz2D3ruMSHzwM702lIVVXNQI10mF2zr3b52gMK7b7WLln6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGJ6OFitoAsI7CuQ6kiUdtQO+VI6omILM8R1bh6OgqU=;
 b=OOtrKtgtJCdVU4aPiAzUz44EWHcbjSuwAoCSA/8RMTlnPjwqsjUW3eO2MEQTuwZzbEGwd1UYRqNaq/jv8WWNY3lKnergnHsYRYQPfuzP5E8GgIY8YEjLYuEtD7ZRnpmrCMstp+/GZvxiovGQK+qZApQMAh+qJUzeUIQt/8kZzLQ777f1WtfU0fMfnuzhgSzL1TmVVndNFF1EHaU4I0cVOJfHBXJjQgFSOW7+hjJR8W57XMWio9LqA8c0+WQz5zuPIBhtsus30P+4YCIYCqyW4YB01j4tJkkJDO2kUeU4Op2uvZR6EecBbrUambLhDtV7+hlkIGMtD5xvblEwi+po7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGJ6OFitoAsI7CuQ6kiUdtQO+VI6omILM8R1bh6OgqU=;
 b=DqgZ6I20zSNYX+kePG7+RZz6jokoyK7XsxgFfx3cK6hTb+rMjuETjJ6xk8954GuprRQpA2NeAPBameUdudY03HFYBdBjLQlv+Dre4IRngEnrQOQDS8CrWD32to30SncoxDeY3s6dn1Mt7bETewWBdSHRI6pD2+gAjOv00nZ/ByHb9EZQobQbA+FFObxRd5MTKwFkgEf4Ec8CS21ufPskjUEW07F2aDgXFgtwFDjfCMzm/dGy8zN+chRchVGA6Rl5jg7uhR3jjQ4QmBFf0tQ42VrvsPKSDu6c/QaxE/7ibn+B8Mhfpr4NWQdwUlxScBfAbQ+0fgzyFc5VXvqQfn77Gg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 05:03:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 05:03:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dongsheng Yang
	<dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH 5/7] cbd: introuce cbd_backend
Thread-Topic: [PATCH 5/7] cbd: introuce cbd_backend
Thread-Index: AQHalIZXrMOAttzKPk23DXN5zswtObF24ImA
Date: Wed, 24 Apr 2024 05:03:50 +0000
Message-ID: <5166cbf7-2680-4f84-9dee-aa214862f2a8@nvidia.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-6-dongsheng.yang@easystack.cn>
In-Reply-To: <20240422071606.52637-6-dongsheng.yang@easystack.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6436:EE_
x-ms-office365-filtering-correlation-id: fae02328-78b4-455f-8dbe-08dc641bee15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2VkSUZpbWlCOC9mRG5hSW1NaDFDcU5OSWpRcXdtSzZlRXVUMW05YUJCMlhy?=
 =?utf-8?B?MUNHZjI3MnAvaVZDdVpmVUQ2a2RoaHhNOXVXenRaUlhiS3FRWGluVkpHeU9u?=
 =?utf-8?B?VWZvUituMHU1alVTQkhJRktPa2FvS1JMMlVYM2FYUGVMekxrVnRJZFhIMFpn?=
 =?utf-8?B?Y1E1TytKYzEvaFNyZnhLUTJYUEIxb0VzaVNnVmpoUmZXQ3c5ZFpyZjVDbGMz?=
 =?utf-8?B?Zlo5VDdQWHdEQmIvSTRxWElGNi9ya2orWldkWHc2eDZ1cE9kS0hXRWx5V1ls?=
 =?utf-8?B?bmdyM3FVeHYyUVRPWlgydnczUTkyVE9QS0lJMjZkSXVRcjk2YUp2ajljMUVI?=
 =?utf-8?B?NG4wMUgzOGp2MWdXV3Ixc1VHeXFGa1lpU2lCdXdieGdUY0N5MkcybkdKMmp4?=
 =?utf-8?B?QlFZN0dxZmVsbW5ObWJ1TWRwRko1bXNJRVJJRWZzNmIwaHVqcTlHd2pLWUpD?=
 =?utf-8?B?cTVCeG1pdzduOU1ab1o3TW94VjVBRThKcWdUaHY4LzRnQmM5WGkvL3hySGhL?=
 =?utf-8?B?aFBHZzR2b1NHaTdaRWNncGE5RVJ4OW5BR1ZjY3pZWXVzekZ3TGxpMCt3SUNK?=
 =?utf-8?B?aFIrQWZiMzBQUkdOVmVObmZ3bStuY2ExS25oSWUzajdnazR2QkZoVjN6dGJR?=
 =?utf-8?B?VlhyeGVMM3BhbGlieGluaVFtQ2tsMnZhQzgwMzRkWkkrMW0wcjdjL2U0RFpK?=
 =?utf-8?B?cW51MDh2N0pnRE5kd2M3MzQxekJuT3dLUWtDei8xMmNBV3plYllpdkErY0F5?=
 =?utf-8?B?OXYyb3h5TnZmdTI4WHRFY25JcHNoc1dscGNhdzlrTDJkVjdaTHYwL1UrdlR2?=
 =?utf-8?B?dTNXYzFCMG93MnlDZmY1Y3FYVFNiUHFlWTNBUzBxNWxsVldxTGlUeXhjRXYz?=
 =?utf-8?B?MmY0THppOElvNGtuQ2o4TENXbGgwWXNseGIzKzdKWUwwL1VTNjlpVVZQQUdm?=
 =?utf-8?B?Y0Z4eFJubmFrSXo0Q215NU8yUW5oYVdHZ09uQy9lYXRDQzdBc0NaTXB4OU9G?=
 =?utf-8?B?K0tDR1N5TUFRWFZSK2ppVlgvRUZPdU0zRlN3OG9UKzMrMkh5bzVpYzloemhq?=
 =?utf-8?B?TjcxL05rTVA5WGFmRGhrRWJOSGUyRWlnYjQwV2RVN0FadVNYdFdOYm5IbTMy?=
 =?utf-8?B?SHlGMFNnM3ZYWlNFejRYUmViNk05VDNtK0l0TWN5UmNZenBRaFoyd3hhQ2FU?=
 =?utf-8?B?UTVSMDM1Z0E3T1VxeFdxQjA2ZDY4VkJHaVduLzZhT3hCY1dxcWhTbVVOclFX?=
 =?utf-8?B?anBjNFhYcXBnWC9aMS9mNUkzblhnaWg5ak9qRjZDUU1VZ3BJZ3VySUVDWlJM?=
 =?utf-8?B?Wk5ScmVibkhKV0ZKd09HSDkxNFFEWWJTdzlyRkZsTnh3bEE2Y3paUnNxQWNE?=
 =?utf-8?B?VzR6THBMVC9BN3N4bmYrNjlvT09mQThhTHh0aG8zc2VYVEhNNDBXQXpKSnQ2?=
 =?utf-8?B?M2g2dGgva0s4NGNjQWtwNFdSaHgrVm9EZkx4aEUrcTZYamVFaGRyaFJBOGha?=
 =?utf-8?B?MzJzMXB2MkxEZWFJbStUYk9hcVYvTWJIbC9CL1ZkdElWUTFZZlUrOGxlQXBT?=
 =?utf-8?B?ZEppbUVlTjhRb1BndldnQ3R2dEI1RDcyQUViQVhMd1hVZitpcjlBOS96aG92?=
 =?utf-8?B?WUN4cVh4QUZOR0RnVU56ZDMrNlp5elVxTHd5V1lXWnhmaXJWYUpQQWxQNzN5?=
 =?utf-8?B?ZTIrYko5bjJrL3h2dUZGUmUzQWhNdkZteGV0YnQvWDA3Z09WTkJBeEpPcTdi?=
 =?utf-8?B?T2xyK05kQ0lMbWN6eSt6NmI4ZFN5b2h2Mk9keEUrVkFwa2oyd05RM1dyemVB?=
 =?utf-8?B?M3VGZVZ3YU1UNzBIY3JuUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnF3aXJrdE1jRHVWc01IbEszZG1EL3UxQ1dRTWJHRkxyUkRJQ2JudzNPbzlh?=
 =?utf-8?B?cVZka204OTUyOHZpOWQyb1ZPMk50bzlPTVJONmw0VHd3WFk0R0pNNU51UnJV?=
 =?utf-8?B?TE9ocTB0ZklVZ1pVdzc1SGlGVmlTRStsNVMveUdpb1p2UkZIODZ2YmZKM1Fw?=
 =?utf-8?B?ellROURmNng5UWJSQzc0Y3B2Nkl1TFMwSjQ2YmR0UDNiZUhFVEZIUkJFeHdE?=
 =?utf-8?B?TUp1UlUwdndHZEEvOHlPMkhkNGxHVEdtWC9JMTNmUG9TTlNwd3JkQk9WaDJ0?=
 =?utf-8?B?QnJoMS8vcHBoNzdpdkJVZEdPZEZxR1A2UEZqN3haRFlUTU05R3FMaWM3ZGxn?=
 =?utf-8?B?b0E0MG12aGZNNXMxaDJUQ1FsMS9mWmF6cmJIT00xb2hsK0dJSHVsTUswcVZW?=
 =?utf-8?B?UVY0dUowc1d2SUhsSk83dVBBZTBFYjdFQkJPb0k2aWN6V2xwdUZYWDNJeTZ6?=
 =?utf-8?B?NGhyanF5eU5IMTZBcEpqcWJWT2hiS1BqSVFJbnh2UEJ1akc2N1pjRU9HZ1Nx?=
 =?utf-8?B?NUZtSUhxZ3l5NEtTNVd5R2RLMDkvSTQyZTF2MEJKclJ3MTMrWDNSM0ZYOFZq?=
 =?utf-8?B?UEZYSUl2azBhQkR3aTBVNVNWRzVUbzl3UU5GK1VYSS94VVpHUlc3c2RvZFd4?=
 =?utf-8?B?c1VORDhNc0pCMEU3WWxjRHd4M3M2WHQwTTJJM0RyWVVIZG1jdXh6R1krczlB?=
 =?utf-8?B?bXNXSXh1Z3NucTRrdGNtdnFueXM5ZnVmREk2anJRYW1BYTVPR0hFeGcxMUNP?=
 =?utf-8?B?ekNmSnRNaEsxNDF4ZXcwNVpVaUh1NGdEaEQ3c3E2SmwrRHk2bTU1TU1acDJ6?=
 =?utf-8?B?RGFZWHZOWVJ2b1BIbmwwcDladUtqWjVwNnVZWHlHbU5DVXF5NDU5aGZSL3Vx?=
 =?utf-8?B?MnFIU1lsTVdvdVVSTkQ4TTUvOWtCZEQwOWU2RzhKVjBPWUt5Wk5hQU14d3lW?=
 =?utf-8?B?S2RtbmtKRHFWSmpsR2huL1RKQm9GY2t5elcxK3R6V0hlYWt2cXY3c1N6NnRx?=
 =?utf-8?B?dU9ycGZsci9US0taTEFPZUUyN3dHcWxzbEtTNk5samtlOVA0SnFSZmpBNTZL?=
 =?utf-8?B?eE1XWW1VcjlWMytPeFBOMUduYzRreklXZWZ5TjNIK2xINVIyQW1tY21WRkpj?=
 =?utf-8?B?eU5OTm1mTUU5SjV4WGJBRVE0QlVmYWZDZFhBWmJ6V2FLSEpNSTBCUkhBQ05t?=
 =?utf-8?B?V3lKMlBrRmVKaU1JMjFNV2VVQlQ1QTRLbndlOGQ2U0g5azRURWI0Y05oRGls?=
 =?utf-8?B?Vjd5bVFXS1Z2ZllBVGZaYlRWYmgzZ2pQY1ZTVnZBMHJNTXc4ZGUreDVMeWZw?=
 =?utf-8?B?Yk1rakhQbzJ1T0gvMEFIRjhTbUlneTRXK3VvSHhXd3BENmx3L0VvWGc0UEVG?=
 =?utf-8?B?UTc4RG5ObnpKTmdoNCsreEdiVTVJNFo1QWNvdXg3Z1NKNlRGVFFUMEdmZDVB?=
 =?utf-8?B?dmhhUHpkZW1yaHJTdURnd1NjV0toaGZIRUR4cGsrSDdhU090bXk4UFVFQytu?=
 =?utf-8?B?dlZGY0lKdjYyaVUrM1FsbkNxWWI0OGpNRnowdnB6QlRYQUdGS1hqbTRvYzJM?=
 =?utf-8?B?bElaZUJWcjBPNStCcUlvRSt1NlRDRzYvelNEQTVXK054TjNIdGhtK2pIUS9m?=
 =?utf-8?B?Rm9zQU5pZmplSGE5RE5BdUgwOFUrUnNKcnlGZ3dmalgrUUJrWlZaR3B0cEdD?=
 =?utf-8?B?K0VOVkU4MU9JaHRWT2g5bTJjV21FKzErdWtNQ0RQRWMrV3l1Q0xZVmVxa0la?=
 =?utf-8?B?cGpkdUt6Tk5vRzJraW9xRFpwVWNXa2pLQjZ6UFYrNGR3U2swQXM4SlllZlNB?=
 =?utf-8?B?SGY2RlhPL3ZWM3VYOERWNCt6eU9lcFI3OW1kYjVZU2tFL2U2TE50TTVNdkFJ?=
 =?utf-8?B?QVNoV3JSN080WmRUOHo3WUxwSU1YTUFmQXY3dkNZdjY5TkRNaWVTQkNEMHpv?=
 =?utf-8?B?Sm16ck0yN1o0UlIxTkxyVFZUbXMxVEJvMGRBWVdCNjY2ZEljVVk2aXE5dk1B?=
 =?utf-8?B?YTF3dnE5N0hVdXBMbUdYNzM2ZlV6Y2lzSFVrcUJtMnZyWFZ0Slc5aGNaTXFO?=
 =?utf-8?B?YnZSYVhTOGQ2UUhORmI0VUE2Vjg3VjVUWG5ZVm9DSXd1MXJGOHN3T1hUanVN?=
 =?utf-8?B?aXhxbFZRYkxkeFYzWmxJZHN0ZmR5aHoxSi82em9FNVBzcDd0VjcrWW5QSTVE?=
 =?utf-8?Q?cR8qAQdyxatqHFLLO4/3D81flOjm32OpmwQgj5n/cbeL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <895ED2F35C966A4A8F9499B21332453E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fae02328-78b4-455f-8dbe-08dc641bee15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 05:03:50.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfzRXYmjPcNn8DnR+TH0x2zFPvQitjoyEuHbm6O3bZE8eZrQOuAqqXgXqbyzBB/PijqRZrH4WvZMSEAkMA0hPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436

PiArDQo+ICtzdHJ1Y3QgY2JkX2JhY2tlbmRfaW8gew0KPiArCXN0cnVjdCBjYmRfc2UJCSpzZTsN
Cj4gKwl1NjQJCQlvZmY7DQo+ICsJdTMyCQkJbGVuOw0KPiArCXN0cnVjdCBiaW8JCSpiaW87DQo+
ICsJc3RydWN0IGNiZF9oYW5kbGVyCSpoYW5kbGVyOw0KPiArfTsNCj4gKw0KDQp3aHkgbm90IHVz
ZSBpbmxpbmUgYnZlY3MgYW5kIGF2b2lkIGJpbyBwYWdlIGFsbG9jYXRpb24gZm9yIHJlYXNvbmFi
bGUNCnNpemUgPyBpbnN0ZWFkIG9mIHBlcmZvcm1pbmcgdGhlIGFsbG9jYXRpb24gZm9yIGVhY2gg
cmVxdWVzdCAuLi4NCg0KPiArc3RhdGljIGlubGluZSB2b2lkIGNvbXBsZXRlX2NtZChzdHJ1Y3Qg
Y2JkX2hhbmRsZXIgKmhhbmRsZXIsIHU2NCBwcml2X2RhdGEsIGludCByZXQpDQo+ICt7DQo+ICsJ
c3RydWN0IGNiZF9jZSAqY2UgPSBnZXRfY29tcHJfaGVhZChoYW5kbGVyKTsNCj4gKw0KPiArCW1l
bXNldChjZSwgMCwgc2l6ZW9mKCpjZSkpOw0KPiArCWNlLT5wcml2X2RhdGEgPSBwcml2X2RhdGE7
DQo+ICsJY2UtPnJlc3VsdCA9IHJldDsNCj4gKwlDQkRDX1VQREFURV9DT01QUl9IRUFEKGhhbmRs
ZXItPmNoYW5uZWxfaW5mby0+Y29tcHJfaGVhZCwNCj4gKwkJCSAgICAgICBzaXplb2Yoc3RydWN0
IGNiZF9jZSksDQo+ICsJCQkgICAgICAgaGFuZGxlci0+Y2hhbm5lbF9pbmZvLT5jb21wcl9zaXpl
KTsNCj4gKw0KPiArCWNiZGNfZmx1c2hfY3RybCgmaGFuZGxlci0+Y2hhbm5lbCk7DQo+ICsNCj4g
KwlyZXR1cm47DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGJhY2tlbmRfYmlvX2VuZChzdHJ1
Y3QgYmlvICpiaW8pDQo+ICt7DQo+ICsJc3RydWN0IGNiZF9iYWNrZW5kX2lvICpiYWNrZW5kX2lv
ID0gYmlvLT5iaV9wcml2YXRlOw0KPiArCXN0cnVjdCBjYmRfc2UgKnNlID0gYmFja2VuZF9pby0+
c2U7DQo+ICsJc3RydWN0IGNiZF9oYW5kbGVyICpoYW5kbGVyID0gYmFja2VuZF9pby0+aGFuZGxl
cjsNCj4gKw0KPiArCWlmIChiaW8tPmJpX3N0YXR1cyA9PSAwICYmDQo+ICsJICAgIGNiZF9zZV9o
ZHJfZ2V0X29wKHNlLT5oZWFkZXIubGVuX29wKSA9PSBDQkRfT1BfUkVBRCkgew0KPiArCQljYmRj
X2NvcHlfZnJvbV9iaW8oJmhhbmRsZXItPmNoYW5uZWwsIHNlLT5kYXRhX29mZiwgc2UtPmRhdGFf
bGVuLCBiaW8pOw0KPiArCX0NCj4gKw0KPiArCWNvbXBsZXRlX2NtZChoYW5kbGVyLCBzZS0+cHJp
dl9kYXRhLCBiaW8tPmJpX3N0YXR1cyk7DQo+ICsNCj4gKwliaW9fZnJlZV9wYWdlcyhiaW8pOw0K
PiArCWJpb19wdXQoYmlvKTsNCj4gKwlrZnJlZShiYWNrZW5kX2lvKTsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIGludCBjYmRfYmlvX2FsbG9jX3BhZ2VzKHN0cnVjdCBiaW8gKmJpbywgc2l6ZV90IHNp
emUsIGdmcF90IGdmcF9tYXNrKQ0KPiArew0KPiArCWludCByZXQgPSAwOw0KPiArDQo+ICsgICAg
ICAgIHdoaWxlIChzaXplKSB7DQo+ICsgICAgICAgICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2Ug
PSBhbGxvY19wYWdlcyhnZnBfbWFzaywgMCk7DQo+ICsgICAgICAgICAgICAgICAgdW5zaWduZWQg
bGVuID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUsIHNpemUpOw0KDQphbGxvY19wYWdlKCkgY2Fs
bCBzaG91bGQgYmUgY2xvc2UgdG8gYmVsb3cgY2hlY2sgLi4NCg0KPiArDQo+ICsgICAgICAgICAg
ICAgICAgaWYgKCFwYWdlKSB7DQo+ICsJCQlwcl9lcnIoImZhaWxlZCB0byBhbGxvYyBwYWdlIik7
DQo+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gKw0KPiArCQly
ZXQgPSBiaW9fYWRkX3BhZ2UoYmlvLCBwYWdlLCBsZW4sIDApOw0KPiArICAgICAgICAgICAgICAg
IGlmICh1bmxpa2VseShyZXQgIT0gbGVuKSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
X19mcmVlX3BhZ2UocGFnZSk7DQo+ICsJCQlwcl9lcnIoImZhaWxlZCB0byBhZGQgcGFnZSIpOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICAgfQ0K
PiArDQo+ICsgICAgICAgICAgICAgICAgc2l6ZSAtPSBsZW47DQo+ICsgICAgICAgIH0NCj4gKw0K
PiArCWlmIChzaXplKQ0KPiArCQliaW9fZnJlZV9wYWdlcyhiaW8pOw0KPiArCWVsc2UNCj4gKwkJ
cmV0ID0gMDsNCj4gKw0KPiArICAgICAgICByZXR1cm4gcmV0Ow0KPiArfQ0KDQpjb2RlIGZvcm1h
dHRpbmcgc2VlbXMgdG8gYmUgYnJva2VuIGZvciBhYm92ZSBmdW5jdGlvbiBwbHogY2hlY2suLg0K
DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgY2JkX2JhY2tlbmRfaW8gKmJhY2tlbmRfcHJlcGFyZV9p
byhzdHJ1Y3QgY2JkX2hhbmRsZXIgKmhhbmRsZXIsIHN0cnVjdCBjYmRfc2UgKnNlLCBibGtfb3Bm
X3Qgb3BmKQ0KPiArew0KPiArCXN0cnVjdCBjYmRfYmFja2VuZF9pbyAqYmFja2VuZF9pbzsNCj4g
KwlzdHJ1Y3QgY2JkX2JhY2tlbmQgKmNiZGIgPSBoYW5kbGVyLT5jYmRiOw0KPiArDQo+ICsJYmFj
a2VuZF9pbyA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBjYmRfYmFja2VuZF9pbyksIEdGUF9LRVJO
RUwpOw0KDQp3aWxsIGFib3ZlIGFsbG9jYXRpb24gYWx3YXlzIHN1Y2NlZWQgPyBvciBOVUxMIGNo
ZWNrIHNob3VsZCBiZSBoZXJlID8NCg0KPiArCWJhY2tlbmRfaW8tPnNlID0gc2U7DQo+ICsNCj4g
KwliYWNrZW5kX2lvLT5oYW5kbGVyID0gaGFuZGxlcjsNCj4gKwliYWNrZW5kX2lvLT5iaW8gPSBi
aW9fYWxsb2NfYmlvc2V0KGNiZGItPmJkZXYsIHJvdW5kdXAoc2UtPmxlbiwgNDA5NikgLyA0MDk2
LCBvcGYsIEdGUF9LRVJORUwsICZoYW5kbGVyLT5iaW9zZXQpOw0KPiArDQo+ICsJYmFja2VuZF9p
by0+YmlvLT5iaV9pdGVyLmJpX3NlY3RvciA9IHNlLT5vZmZzZXQgPj4gU0VDVE9SX1NISUZUOw0K
PiArCWJhY2tlbmRfaW8tPmJpby0+YmlfaXRlci5iaV9zaXplID0gMDsNCj4gKwliYWNrZW5kX2lv
LT5iaW8tPmJpX3ByaXZhdGUgPSBiYWNrZW5kX2lvOw0KPiArCWJhY2tlbmRfaW8tPmJpby0+Ymlf
ZW5kX2lvID0gYmFja2VuZF9iaW9fZW5kOw0KPiArDQo+ICsJcmV0dXJuIGJhY2tlbmRfaW87DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgaGFuZGxlX2JhY2tlbmRfY21kKHN0cnVjdCBjYmRfaGFu
ZGxlciAqaGFuZGxlciwgc3RydWN0IGNiZF9zZSAqc2UpDQo+ICt7DQo+ICsJc3RydWN0IGNiZF9i
YWNrZW5kICpjYmRiID0gaGFuZGxlci0+Y2JkYjsNCj4gKwl1MzIgbGVuID0gc2UtPmxlbjsNCj4g
KwlzdHJ1Y3QgY2JkX2JhY2tlbmRfaW8gKmJhY2tlbmRfaW8gPSBOVUxMOw0KPiArCWludCByZXQ7
DQo+ICsNCj4gKwlpZiAoY2JkX3NlX2hkcl9mbGFnc190ZXN0KHNlLCBDQkRfU0VfSERSX0RPTkUp
KSB7DQo+ICsJCXJldHVybiAwIDsNCj4gKwl9DQo+ICsNCj4gKwlzd2l0Y2ggKGNiZF9zZV9oZHJf
Z2V0X29wKHNlLT5oZWFkZXIubGVuX29wKSkgew0KPiArCWNhc2UgQ0JEX09QX1BBRDoNCj4gKwkJ
Y2JkX3NlX2hkcl9mbGFnc19zZXQoc2UsIENCRF9TRV9IRFJfRE9ORSk7DQo+ICsJCXJldHVybiAw
Ow0KPiArCWNhc2UgQ0JEX09QX1JFQUQ6DQo+ICsJCWJhY2tlbmRfaW8gPSBiYWNrZW5kX3ByZXBh
cmVfaW8oaGFuZGxlciwgc2UsIFJFUV9PUF9SRUFEKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBD
QkRfT1BfV1JJVEU6DQo+ICsJCWJhY2tlbmRfaW8gPSBiYWNrZW5kX3ByZXBhcmVfaW8oaGFuZGxl
ciwgc2UsIFJFUV9PUF9XUklURSk7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgQ0JEX09QX0RJU0NB
UkQ6DQo+ICsJCXJldCA9IGJsa2Rldl9pc3N1ZV9kaXNjYXJkKGNiZGItPmJkZXYsIHNlLT5vZmZz
ZXQgPj4gU0VDVE9SX1NISUZULA0KPiArCQkJCXNlLT5sZW4sIEdGUF9OT0lPKTsNCg0KYW55IHNw
ZWNpZmljIHJlYXNvbiB0byBub3QgdXNlIEdGUF9LRVJORUwgPw0KDQo+ICsJCWdvdG8gY29tcGxl
dGVfY21kOw0KPiArCWNhc2UgQ0JEX09QX1dSSVRFX1pFUk9TOg0KPiArCQlyZXQgPSBibGtkZXZf
aXNzdWVfemVyb291dChjYmRiLT5iZGV2LCBzZS0+b2Zmc2V0ID4+IFNFQ1RPUl9TSElGVCwNCj4g
KwkJCQlzZS0+bGVuLCBHRlBfTk9JTywgMCk7DQoNCmFueSBzcGVjaWZpYyByZWFzb24gdG8gbm90
IHVzZSBHRlBfS0VSTkVMID8NCg0KPiArCQlnb3RvIGNvbXBsZXRlX2NtZDsNCj4gKwljYXNlIENC
RF9PUF9GTFVTSDoNCj4gKwkJcmV0ID0gYmxrZGV2X2lzc3VlX2ZsdXNoKGNiZGItPmJkZXYpOw0K
PiArCQlnb3RvIGNvbXBsZXRlX2NtZDsNCj4gKwlkZWZhdWx0Og0KPiArCQlwcl9lcnIoInVucmVj
b2duaXplZCBvcDogJXgiLCBjYmRfc2VfaGRyX2dldF9vcChzZS0+aGVhZGVyLmxlbl9vcCkpOw0K
PiArCQlyZXQgPSAtRUlPOw0KPiArCQlnb3RvIGNvbXBsZXRlX2NtZDsNCj4gKwl9DQo+ICsNCj4g
KwlpZiAoIWJhY2tlbmRfaW8pDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KDQp0aGVyZSBpcyBubyBO
VUxMIGNoZWNrIGluIHRoZSBiYWNrZW5kX3ByZXBhcmVfaW8oKSBub3Qgc3VyZSBhYm91dA0KYWJv
dmUgY29uZGl0aW9uIGluIGN1cnJlbnQgY29kZSB1bmxlc3MgeW91IHJldHVybiBOVUxMIC4uLg0K
DQo+ICsNCj4gKwlyZXQgPSBjYmRfYmlvX2FsbG9jX3BhZ2VzKGJhY2tlbmRfaW8tPmJpbywgbGVu
LCBHRlBfTk9JTyk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlrZnJlZShiYWNrZW5kX2lvKTsNCj4g
KwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoY2JkX3NlX2hkcl9nZXRfb3Aoc2Ut
PmhlYWRlci5sZW5fb3ApID09IENCRF9PUF9XUklURSkgew0KPiArCQljYmRjX2NvcHlfdG9fYmlv
KCZoYW5kbGVyLT5jaGFubmVsLCBzZS0+ZGF0YV9vZmYsIHNlLT5kYXRhX2xlbiwgYmFja2VuZF9p
by0+YmlvKTsNCj4gKwl9DQo+ICsNCj4gKwlzdWJtaXRfYmlvKGJhY2tlbmRfaW8tPmJpbyk7DQo+
ICsNCg0KdW5sZXNzIEkgZGlkbid0IHVuZGVyc3RhbmQgdGhlIGNvZGUsIHlvdSBhcmUgYnVpbGRp
bmcgYSBzaW5nbGUgYmlvIGZyb20NCmluY29taW5nIHJlcXVlc3QsIHRoYXQgbWlnaHQgbm90IGhh
dmUgZW5vdWdoIHNwYWNlIHRvIGFjY29tbW9kYXRlIGFsbA0KdGhlIGRhdGEgZnJvbSBpbmNvbWlu
ZyByZXF1ZXN0LCBoZW5jZSB5b3UgYXJlIHJldHVybmluZyBhbiBlcnJvciBmcm9tDQpjYmRfYmlv
X2FsbG9jX3BhZ2VzKCkgd2hlbiBiaW9fYWRkX3BhZ2UoKSBmYWlsIC4uLg0KDQpiaW9fYWRkX3Bh
Z2UoKSBjYW4gZmFpbCBmb3IgbXVsdGlwbGUgcmVhc29ucywgaW5zdGVhZCBvZiB0cnlpbmcgdG8N
CmJ1aWxkIG9ubHkgb25lIGJpbyB0aGF0IG1pZ2h0IGJlIHNtYWxsZXIgZm9yIHRoZSBzaXplIG9m
IHRoZSBJL08gYW5kDQpyZXR1cm5pbmcgZXJyb3IsIHdoeSBub3QgdXNlIHRoZSBjaGFpbiBvZiB0
aGUgc21hbGwgc2l6ZSBiaW9zID8gdGhhdA0Kd2F5IHlvdSB3aWxsIG5vdCBydW4gb3V0IG9mIHRo
ZSBzcGFjZSBpbiBzaW5nbGUgYmlvIGFuZCBzdGlsbCBmaW5pc2gNCnRoZSBJL08gYnkgYXZvaWRp
bmcgYmlvX2FkZF9wYWdlKCkgZmFpbHVyZSB0aGF0IG1pZ2h0IGhhcHBlbiBkdWUgdG8NCmJpbyBm
dWxsID8NCg0KPiArCXJldHVybiAwOw0KPiArDQo+ICtjb21wbGV0ZV9jbWQ6DQo+ICsJY29tcGxl
dGVfY21kKGhhbmRsZXIsIHNlLT5wcml2X2RhdGEsIHJldCk7DQo+ICsJcmV0dXJuIDA7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGhhbmRsZV93b3JrX2ZuKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykNCj4gK3sNCj4gKwlzdHJ1Y3QgY2JkX2hhbmRsZXIgKmhhbmRsZXIgPSBjb250YWluZXJf
b2Yod29yaywgc3RydWN0IGNiZF9oYW5kbGVyLCBoYW5kbGVfd29yay53b3JrKTsNCj4gKwlzdHJ1
Y3QgY2JkX3NlICpzZTsNCj4gKwlpbnQgcmV0Ow0KPiArYWdhaW46DQo+ICsJLyogY2hhbm5lbCBj
dHJsIHdvdWxkIGJlIHVwZGF0ZWQgYnkgYmxrZGV2IHF1ZXVlICovDQo+ICsJY2JkY19mbHVzaF9j
dHJsKCZoYW5kbGVyLT5jaGFubmVsKTsNCj4gKwlzZSA9IGdldF9zZV90b19oYW5kbGUoaGFuZGxl
cik7DQo+ICsJaWYgKHNlID09IGdldF9zZV9oZWFkKGhhbmRsZXIpKSB7DQo+ICsJCWlmIChjYmR3
Y19uZWVkX3JldHJ5KCZoYW5kbGVyLT5oYW5kbGVfd29ya2VyX2NmZykpIHsNCj4gKwkJCWdvdG8g
YWdhaW47DQo+ICsJCX0NCj4gKw0KPiArCQljYmR3Y19taXNzKCZoYW5kbGVyLT5oYW5kbGVfd29y
a2VyX2NmZyk7DQo+ICsNCj4gKwkJcXVldWVfZGVsYXllZF93b3JrKGhhbmRsZXItPmhhbmRsZV93
cSwgJmhhbmRsZXItPmhhbmRsZV93b3JrLCB1c2Vjc190b19qaWZmaWVzKDApKTsNCj4gKwkJcmV0
dXJuOw0KPiArCX0NCj4gKw0KPiArCWNiZHdjX2hpdCgmaGFuZGxlci0+aGFuZGxlX3dvcmtlcl9j
ZmcpOw0KPiArCWNiZHRfZmx1c2hfcmFuZ2UoaGFuZGxlci0+Y2JkYi0+Y2JkdCwgc2UsIHNpemVv
Zigqc2UpKTsNCj4gKwlyZXQgPSBoYW5kbGVfYmFja2VuZF9jbWQoaGFuZGxlciwgc2UpOw0KPiAr
CWlmICghcmV0KSB7DQo+ICsJCS8qIHRoaXMgc2UgaXMgaGFuZGxlZCAqLw0KPiArCQloYW5kbGVy
LT5zZV90b19oYW5kbGUgPSAoaGFuZGxlci0+c2VfdG9faGFuZGxlICsgY2JkX3NlX2hkcl9nZXRf
bGVuKHNlLT5oZWFkZXIubGVuX29wKSkgJSBoYW5kbGVyLT5jaGFubmVsX2luZm8tPmNtZHJfc2l6
ZTsNCg0KdGhpcyBpcyBhIHJlYWxseSBsb25nIGxpbmUsIGlmIHBvc3NpYmxlIGtlZXAgY29kZSB1
bmRlciA4MCBjaGFyLCBJIGtub3cNCml0J3Mgbm90IGEgcmVxdWlyZW1lbnQgYW55bW9yZSBidXQg
aXQgd2lsbCBtYXRjaCBibG9jayBkcml2ZXJzIC4uDQoNCi1jaw0KDQoNCg==

