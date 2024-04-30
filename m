Return-Path: <linux-kernel+bounces-163863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C08B74C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16C51F222A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BC134402;
	Tue, 30 Apr 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sL8yaeVM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AB12838C;
	Tue, 30 Apr 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477469; cv=fail; b=EOHHJD5RNl7pBtN1N6oD/JMXOEEMm68O1MO3AJUJMFBf6hrvPt4/xnpg8IXwQxrI9fT1cV5x84pbZCKdoLzWblaK2+w9KTN+F5F44cQcT9LY/VpDXSMxnuGOdtPSB9gw3s2+NCMKmREEMaEDYULsEYaQAzbMNItfmJgxtKzj5sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477469; c=relaxed/simple;
	bh=u7XZXFzPBsvqO9AYr55a50eSlC9Gjm26WnNmKSOsPEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwMxJbf9IbzoOwipWizThW1Jpw9VB1n52xSB/Cke1TuKH+vwcEc8KiE88S+seiA3oBAEdzvuDlQNHPE++zyH4swaXqzG7CTWI2bjmJdz/ko/1eJFjyWSLtsbFnWH3lzdAF0noDnpp4dyKctaZk87ctsuGjPkMXSebvqO2hjDVw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sL8yaeVM; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7sQxAxzZJOZbO1VmSlW7sVvVPiSVc8e9pOi5ahiwo0vCRIupZZgEK3+q7WzGinYnDUESOs9n1nG2U0KXdxzC0AGPgxkVykOLbDf9bUW2l6dlXG2eDz/55maXeb8ko3Yqx1FOvbXFqXi7utqGGkBfqsz05zmZEE5RF7O3EtqcdVBH4z5mRtSDpb5XhET35ZwZOkrCUmUdVjnrk6Q75TPTH5vsndPmoInkd+QKyEcnkXw7Gd5CWQzFae2HsW5b5PeG4ORa/0cwQOJrJH48n3DHgaHszKSyDToQ5sONbuGnlX/oYRmJ/fI3Fhtyl6vvTL9qJvoTEax4tUh8QUMXpsgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7K1/XVDFejHojyFInwWDmuPtMWzFRM4YfjBHH29hgc=;
 b=Ox8LA+61tWKm3xJ2Q9a9t5//Pm75kf00i69XpqewLSmZeUudI8iN1DmnRIq5o+jdECQY7AdRrn5lCkw6KR+P0/W8mC5/+0EcssChQhSAx55dyDKvmmE8I2taRlJBVwuyFLpJdUJ4yszGWm8OUdH6ecz0jS8LC89+J8QMoYnMDsiKzzK4fvnwtrvIN8QIHJ1p7MNHm3DwCz9765yWQctdqdwrd8LYaBYyAWWZOoS2XW0TVD2uMFdUSqpk5afnPBF2j2D1i3hwNRR4VYQ/FkLrMrsS4jBiAwfXZ3QzpaCEz3mTdlniOvx83xYuHdc6j7Jno4VNtA/qwImhdUeMJgAQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7K1/XVDFejHojyFInwWDmuPtMWzFRM4YfjBHH29hgc=;
 b=sL8yaeVMFDIWlQ9sRQsByN6wbA5W48sV48qcpOuvvlHXPo8kYxvK6ayjecX5YZZGIAcmkD6jj2JLvJEbc9wKXfYU9nS0hul4qpqquFuHJtlhheibxcejK9+crJp6YH7fQ5cDpRAQHkvH1CeL45K/qvm5/+95jcyHAU8YuRG2/771jkNHdQ6SOY4wdx82EoURvzHBSAeHokOGeb3/Q7FOCHVBhbmlF534a8+A1H0yKL6e7LRNB5TEJhOagXYfg+98DBA/n12SsjnLVRDMR4NoK1fecz/nwXpuMSJxVx8hWXSdGlowRcBNWMgslDJOalYap1tD+YhyDhs9XcABpHWNJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 11:44:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 11:44:24 +0000
Message-ID: <c9d0c12a-b3f1-4a84-864c-dac6573ca859@nvidia.com>
Date: Tue, 30 Apr 2024 12:44:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/107] 5.4.275-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240430103044.655968143@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::29) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ded682-339b-44d8-a958-08dc690ae1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkgyZGZ5TGxCdk5nVkxsdFY3V0JqYkZ3dlRjMGo1a21RWVdpa0RTaFhvQzRC?=
 =?utf-8?B?NUY3cHNBSWlUNTAvMWFVcjRraCtFK2VQdmdRbStyaEJOdDBnUGxxb0pNZCs4?=
 =?utf-8?B?eFFwSi8wQjdxUGorMm03M1hjVDhuaU92WFZsQWxrWUdCajFzajBLRmxGK1lL?=
 =?utf-8?B?VXlPYmlwRlBxM0hWd2YyMXdxODlZZDgvOWh2K0FTc21qZVNNMnJlWi9nTXVQ?=
 =?utf-8?B?bFBrcDliYWM1Rko1SzFLbmZnd0s2Nm9rSWlwTTZtNXN6RkdwSVoyemh6dmVj?=
 =?utf-8?B?aXdZdEtSU3NMcytyaGRWaXU0RmZUZ3NobittV25iK3EwZy9mMjVUaytyOGl5?=
 =?utf-8?B?Z29Cam5jZlVxMEY0bEJ6a2FQM01FSnpwUkorcUUzeTRGWFVIb0RhaGV0VmhI?=
 =?utf-8?B?Tmk2c2k4S2wzUnNiYlhyaGxhdXNHSlZFTEZWcFBMRm4veUowUTlERUxIY1oz?=
 =?utf-8?B?aTdUK2RsR1lRZk1icnBrYTJHU0NGYkNjVnB5alFZL2d6bDk1MlBYN204L0dq?=
 =?utf-8?B?U1A2ZS85WC9QV01yNUN1MUJtZ0tlaDdUMmxmMFd4NFc3WUVGT1dKZDcwVHg2?=
 =?utf-8?B?YjhZUGVRdHk4SlV3NTkwQzFYNjRTeTBmV1dJaE9Iai9LNHpPQ3BzMGZrZSs5?=
 =?utf-8?B?YndlWFVGNlh4STVZRHg5UndlcjVjZ3RZTkVYbFZrTjJMZ2FvZmF5b2JzZW85?=
 =?utf-8?B?RE52aUFOaFVENUZIV1R4WThkMWhpa2lyWVBteEg0dXBWd09URjhxZGFMMGR1?=
 =?utf-8?B?Z0R5UFF1cGhlbEQ3ZDhLclFoSVJuV1JGeXlhUm5yNmxjL3IrbWt6M0Yxc2l4?=
 =?utf-8?B?MEd5TUd5dlNQek9mRkxTT1o5VUx4dTczbXg5all2ODVMenhMMTZwOGcxK3hD?=
 =?utf-8?B?dUdjNEV3VEErYUF2TE5VeGU1aE5rcVppR0llU3MxbTFvbjhkWVo4aE1DWGR2?=
 =?utf-8?B?V3dPclJma2k3NGE3aURhUS85UXhtQ2xHdHlGREJVS2pSUlg2bklWTURJdHFG?=
 =?utf-8?B?ellLUnc5MVFVd21ub29GeVVjQ2FKSyt6QlJuMkhiblpQZEtXeFpmVVROTXNh?=
 =?utf-8?B?T0dGTjJXdk9qUStudFNpamxaU2g1RDBwanpta0JMVTNVeEdQNnBSS0ZmL2x3?=
 =?utf-8?B?dWpqdVVHVFZJUnFYN0tDODNROGNvanA4aGNlZXZEOFU2WmlKZG9pNysxcktW?=
 =?utf-8?B?dU1YOFRXR0kzVFZ2dDJtWjl4Vjk3U2F3bFkwOER0NnpsQmw5bkxaYXhsQXNW?=
 =?utf-8?B?MHdSUlNIdDM0QytPQU14QXNBWkFKNHdYTGtVS1c2K3kzMlZsZ090M2dXbGRG?=
 =?utf-8?B?Y2l5a1hUb3AxSE9iblh1NitWT2gwK3hhYlhzVWNxaCtZc2lZamd2ZHdRalJk?=
 =?utf-8?B?RjhmSUt5SkhWM3p5dWNyRVBrSEw5OEVHU0Z2MEEyK01SYktab1hMU2ZvNklV?=
 =?utf-8?B?Vm82Tk1QTVp0OUdDQVZtMEd1Z0tLZ2NoK1JMc3BKd2Y4N1hGN01POVZvdVVa?=
 =?utf-8?B?Q1pmSFREYVBpbUdPYWV0VXJUQjRGNkxvUFFSRWtsRWpCdVFMam5PU1ZadXdw?=
 =?utf-8?B?L0lsMERubHFCdjVKSmpocTcwaHp0UEZ0bCtONkpoelQzTWZ2QmxnSkQ3aFh4?=
 =?utf-8?B?OFppNS9GQXhPTUdxamtURVR1S3d3c0lPM2FMdjk0RmFHZ2xFZWVURVZQaVZJ?=
 =?utf-8?B?aExFOWx1ZmNQcTEvb1JDMGtSYjUxT0FnRlUvUmdvRTNabGlzaHdZcC9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdyVDEvRmZLTnFYaTdxbllSY0EySHczVDdtUnlUNDhiSzFhaUl0S3ZKNHpM?=
 =?utf-8?B?cFR1bVYrZVdPM2pvaFFvSm5EOTdvT0w2L2dNbzRzcHpFZWlRK0RobFFPbVR3?=
 =?utf-8?B?NU9GdXdmQXVyMlVoVk5rUy9SUDRuOExCQ0JTcHJWNEFVbjQ3NGxoOHY0Z2Ez?=
 =?utf-8?B?dnpCZ3hUZ25VenVTUzVsRkxFY0loeEtrbHFSZ0taQmJ5T24xTDNBQlB6dWZF?=
 =?utf-8?B?Mm9scVhSbzVERzJWdXREVS96TDg1L0RHNlkrc1ZyTnlGUmNTV29JeEdKbzdS?=
 =?utf-8?B?OSszOVpRR1ZkbXhzbVJ6US9ETWNacW5VcFpGNEJqRDlzNzE4U0FxZTVRVU9P?=
 =?utf-8?B?UUFPSDhzTWNQenNpL0RqdVpaSnBsbW51TU4ybWkzZ0Y2cnRUekFhNmVXUlFM?=
 =?utf-8?B?cjFveWlEVjlCeEtFcFNEN1A5OHo4bzVIRHovbkpoT3NEZFRNU1pHOCt6dHMy?=
 =?utf-8?B?eEJzaGhKM0F5WUtIWWI3MVU0dGRiWG5vVTVtNXgzT3p5QjN0WDVPajg0d3Iv?=
 =?utf-8?B?V1h3WHg5c3laSVV5Z2plNmZrYm9iTW5QeU8wcklpcnNYMWEvQUNuMW4yOWh1?=
 =?utf-8?B?d1lWTEFCV0tENXF6dnFKTERHUmM3TG9qajU0cUtESzBsRnM3OG5udmhlWW4y?=
 =?utf-8?B?OFVMRU9od1dRSXI0cW90eU5yb05xK1UzQUNDMUFKWDJGT3R2dnJYMUtzbXFQ?=
 =?utf-8?B?UHlDV0lUandCQ3d1T3cxQ2NyMlRYR0RLUnhoSUhyM1RId1pMbW8wZ3Q1eUFn?=
 =?utf-8?B?dEd0Zitnd1FJZVlZcTlraXRIMW15cFVrYml4OFdydWgyODc5WDc2UXNXL3g5?=
 =?utf-8?B?Y1UzdVp0TCtkNFNXbEZHMnY2d3NIYS84dit4STcwdURqNXBCYm1IVmRCanJy?=
 =?utf-8?B?dEFETEtHR29Td3JNZlZSOEk0TU1XT0hnL2pPZVRldlIwWjFBamVSSGdnVTdT?=
 =?utf-8?B?RE9HUUVxanlLRkFEQXJuT1Z6TXA2UUZJcWhjSm5BWHlXUG5acTFkV2dsaHMz?=
 =?utf-8?B?ZG9ENXk1RWNWRzZVSDluVkJzTXEvN0VOcFJuTTZJUmZPN2lhaUo3Zk91QS9k?=
 =?utf-8?B?VHdhR0xsMEhNcDZTSFZOWFJ0UmltMHR5TFNQbllZRDNiNlFzVldkaWtFR1c5?=
 =?utf-8?B?Zk5vZVhsb0ZGalBsQVcxaGkvakd2R3lFakJnWjhxZ2lZazVydTYwQVAwU3Jo?=
 =?utf-8?B?alU3aCtyMk9ONDBrZHY2OW1ETzAxdHdvckl6cy8xRXhBS1RMUG5zS0U3ZDhB?=
 =?utf-8?B?OU5jSFlONFFBMXkzMVlURUtGNmExa0Eva1BaRDRnNHQwbExqekhYNUU2eDIw?=
 =?utf-8?B?UU50cjE2OGowNWpCVEQ4TWtmeXpQWVo4bS9aTWpDNmF0ZVlwWTllSXBZVEFj?=
 =?utf-8?B?cGJuSE5POGE2dVVnbGVWRjZ5cXRxVHVZR09haDhUR3pNejNpSS9aRFZ3cVBl?=
 =?utf-8?B?TVZ0OVdicjcvVzMzMmZtdzVYVUVHZENNeDM4N0prNXRrZFp5Sk8xNS9SZVY1?=
 =?utf-8?B?MWRiYVNCeTEzWnVleEdCK25pOEJtVkRETnRhVEdxL21Ydi9pNHEvZkxOb1M3?=
 =?utf-8?B?RndUVGZCMWE0WG9mODI1YzJQREh1eTMyUFdSVE8yeXRuTkdxT29wTnpuYzIx?=
 =?utf-8?B?d3A1Tm5BWDBBVjlGN3JQODVHdmsySHArZ3FPZGs1NTBrUnFLaG5SWHNYaE02?=
 =?utf-8?B?SWNUc1U0VlFXYXA1SXdRUC9QQ1RjNUg3akI2MU03L3JoOXJKcm1tRGJOd3Va?=
 =?utf-8?B?KzNoaEpXcEZSNUpiQ0ZucFlTSHJJbGloQ3FYVUthaTgwVXdVTEVCaW9rS1RS?=
 =?utf-8?B?R2dWbFVENXo4LytiL2VleDhJS2lIR1BiMTNIODZGM2VkWTBpMEZhYlEyaVF6?=
 =?utf-8?B?bGlhTVpBME1aUkdSamdOMnVXZXhPN3Y1aHUzd2hiQ0p0RUpTYVNoTHhUemVi?=
 =?utf-8?B?QzkwZFpQanVvRTloN2VqWVRqV3gzeVpBdlJVYWpDRzJZYm9OeVFjV2lhdms5?=
 =?utf-8?B?VUR3WDM5Q3BkUmJDUmRRNDhOOEJWMldsNGFpZ1loNDJNRldmalNCTXVmVlV0?=
 =?utf-8?B?cUF5ZzFLT05TUlRUVGx4ZUs4SEg5bFh2cHV4T0pjT0xPR1RVU0pOV05tSk5T?=
 =?utf-8?B?OUh2MWxsRG9teEtndFdLN2UrVkxYenZJVWV3UTB5S1FBTXV5Tjl3VFBVb1gx?=
 =?utf-8?Q?xN/YB2+otzRR/Ej7AQAuu3Yag0HkTbgATMhWTuopBJce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ded682-339b-44d8-a958-08dc690ae1e8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 11:44:24.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGc9e31pGnFcAyitXHQslAzOB076+oVrSgk6y1YVDb7w8bYL4Jnga5Pxbb6Cmj3yf+J1T9xpAfoKX1I3SlSPtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

Hi Greg,

On 30/04/2024 11:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.275 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:

..

> Ikjoon Jang <ikjn@chromium.org>
>      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg


Same build break for ARM64 as linux-5.10.y due the to above commit.

Jon

-- 
nvpublic

