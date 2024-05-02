Return-Path: <linux-kernel+bounces-166538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA78B9C07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875FB1C21834
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6813C695;
	Thu,  2 May 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Jsq8U0BY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2133.outbound.protection.outlook.com [40.107.21.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA28C8F3;
	Thu,  2 May 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658754; cv=fail; b=C1F/Sez/8refbkr+UF5iF+sXOzkNQLuPQPH07Vc98WA2va6xIaUeHqFslR+BjWPr/yVjeoXWDDe0wekMsMXgJeaGmUkfQWruSBXc6TVSxMCuA0Eyebgh4YrWtEzJFDSb0HJ5D6seNLdBm47OltmMeIXUb77qD3Qbxqe1K4Nmbdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658754; c=relaxed/simple;
	bh=OLGrxL5tULFPFhhTw/9mnVyu0/3FSNKDsW/gjfS3M78=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W5dfXJG9k5zVDUVV/6lIRhzBtSaUMCXnEwxLQrJq8dtDP0qXpJA0Q5NlAavG7glWu0Nvb3ZxpiTdYLbBGGyxQyJzh/8o7QCBOpWCABh+iKiOaWgAtQzFUETyBxWWUnpIYB1xNxK3vB/IbwWFbqYQQLDx3F6JKeHWYkGxitcmebE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=Jsq8U0BY; arc=fail smtp.client-ip=40.107.21.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ466sFloI+8TGQDW9ojjAYQuO9CvZqy7pl3/AF1anJ8v14H3pIl0u744Sj5rO3fKRIwMOZN7KENhlbF554TXpNlm2SRavfQS2sdlfFiSeCTJtrc9UQZhAH4Xk6iwMp12FVf30cOD/MRjUZJ3jAB3LY9LgXIBTGp8F8e7LmXhHrtgl4VqFO8C8iV5a8LCAtFU5OUFYu3h+tJuBj3oG08CLTrVTKJVbff/+FObdp8fXpNsdJa7/tXCQvzxeYRRufvjduGyR2DQmOAbefoys5RmI6h6utQXwOuZFAZASkEVxnIe4bkT15xaBaF2IFbUwivTbkZDqTlKbq+Ik33xc0U2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SJX1IVbglWyql3WuI/bMMx/BcY2i4CbQGccG34kXLI=;
 b=AXx521YRevlh4ef5fJoGp2GOvTLKA8mp4TxpYCFXQhG1tFtfdHqesNWjpygB2kImkE3fHVZ+LAILn+5UazGdOoHcEcrrJb3njsRf1RbF3cpmG3m54YJghuMJbQgxNbyKc6P7wfGgfs8W3eHEN2zWiPfuozHmwJDQs03cCHPAUpCTCb3zmC0dIONe4Krz8k03g/npgwH7yh6RMaOMIq7ZsW4OX2dTWxZyNGFjvl4eO5/wewjZnFIHAJala61SuiKuMP1VPqXY5Wmxi2U1fudjNYh8NHz05vGSa421seQIGYsTfNrju2CRbD7yIAkCQulmbxWjkak6XR+OV4HJwe9Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SJX1IVbglWyql3WuI/bMMx/BcY2i4CbQGccG34kXLI=;
 b=Jsq8U0BYSeR4zp2BdJDbUnPRWBGk/iExLdswHK4JBfvmLriMKKi9UNWQDTPxiRgICyr5TxacfhZYfFfPdjkjAZ492QPH9JXpksc9aa1wgr97G6Oc5428mgC5Gumxk+BBFj6dD9RAi8z0d45oJLlKRQPflMff6L8TDT0ITXtbLUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by PAWPR02MB9125.eurprd02.prod.outlook.com (2603:10a6:102:33c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 14:05:47 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 14:05:47 +0000
Message-ID: <ad190ae3-48d2-a5db-dd36-d52b1c4cf460@axentia.se>
Date: Thu, 2 May 2024 16:05:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Content-Language: sv-SE
From: Peter Rosin <peda@axentia.se>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 =?UTF-8?Q?Jo=c3=a3o_Paulo_Gon=c3=a7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 joao.goncalves@toradex.com
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
 <20240502133623.0000463e@Huawei.com>
 <44f47927-52aa-5248-6ae4-21028076fd51@axentia.se>
In-Reply-To: <44f47927-52aa-5248-6ae4-21028076fd51@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::32) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|PAWPR02MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bb5629-625e-414f-cda5-08dc6ab0f733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnRRMUNtYmg3elhtbzRpSXpoUmRyU2xqejIzQWFPdVQ3ZUR6dmgybEt1L1hr?=
 =?utf-8?B?WVRHSzZMRnBNL3d0dVo4V2tOQjBJNnRuY3dJYnJQbk8rK2pxUEhTSENheFdJ?=
 =?utf-8?B?NGZ5Vmp2WmR4SHNGc3VSOWxZSnovSHhSUjhwRllvQW5BelV2dG1UTW9EekJi?=
 =?utf-8?B?eVQ3OWxucXhGLzg4cXpESm44cHBCWGZidTFYSmNkUGd4K2o5WUt6Si96a2to?=
 =?utf-8?B?Szg1c3JJMEZualdKazlZc3A3WUpSZGtQMC81a21mcENoTFZDbXJaR3h4SlBm?=
 =?utf-8?B?MEN1Qm8zdmxIRkF6djVPVUEvLzl6ZThzYm1NWklMTE16VTY5dWpoYWg2WHpp?=
 =?utf-8?B?YVFNOXN6Z01QQWt1RUhma1RpaFF3UGVnTUdtR05sa0tHbmR3dWFMSURkUVBS?=
 =?utf-8?B?RkhtNElTOFNJY3h0M3JMS203UG9sVy82L2pIVkJDd2JEWDBZbElvVVY5dGRm?=
 =?utf-8?B?RHEwOGRNL0hsYjNScTREYzZOeHhqUnNsNjFCRXQ1ei9VOGgwUm9WaVUwaDQ2?=
 =?utf-8?B?ak5BYUI0bk5WajYwN0Rqa1VpQU01UEVtVDQ1ZjZQUEpRM1JNdlY2cVQ3S1ZP?=
 =?utf-8?B?KzAyOFJGSG1GQklWcjJUNGQ3TjdDcUtjVW9CMGVPTHpUWllSbHVvMzhwSTU0?=
 =?utf-8?B?eG4reCtjV1REWnRvbldTZGVHZ2JJTklMWmtsMDEvNFJmSmxMQWczTnR2SDVN?=
 =?utf-8?B?a2M5aWdJYVkycmNjRzBveG9RRnZPNWpoZzhYNUJRd2QvVkdQdnhEM3J1azl6?=
 =?utf-8?B?OFIrSDZJV2VZL3ViNnJlRWdNVml2WHk0RGY3dDFRZVJiSUwyNVlTVlYzV3NS?=
 =?utf-8?B?ejdiZzFYV3hUdmpySVh4UkR1Tm9RalVoaVg3T0ZlZlcrNXBybUhxQ25ZNnRn?=
 =?utf-8?B?M3JIWlZ1THI5dFY4RWt0dDdjQ2t5VGRqd3Q4bjNzeStqM0xuSjQwS0owUDNS?=
 =?utf-8?B?ZU9qQXduZ1BBRFBGM2d3TGNxMHJJUzh0MDIwTi9vZ29HVmFXYUs0REtuUEJ5?=
 =?utf-8?B?RnZ0TzVhNG91RlRnRExoUXVBVCtaWE9tdnRRTituQkF5M21PTlRTTThaenNU?=
 =?utf-8?B?VTBJbUt5YzZoNFpHQnk1ZDNYZSt3cUxWRTR0QS9NcnpxQkpVNzI2MlcrbXZS?=
 =?utf-8?B?a0tuMFZzL0p2b013OEhyakRpSmFzaFk5a1FoNk53bUpMRUEyOE9TdkJEby9N?=
 =?utf-8?B?ZlF4Z0ZtYjN0RG1QellEaXFLZThYakJhQXdWL0VWWWJHTUZRSzlObDdOcm1t?=
 =?utf-8?B?c0NuT1dwRzNkL0Rpay9WY0JlazVIRWRSWFhLVjlqVFBtWVcreHlka05Zd0dv?=
 =?utf-8?B?VFQyVkxraHhJbUErV2wzaUZoempzQTB3ZjVhUlVoSlFmcjNrcG9UL2lPekM2?=
 =?utf-8?B?MlIxZjZweFJ2YWJic0JJNXl2VVE2NGJIcGxpQUxFcUVvZC9iUVd2MmhaTVpU?=
 =?utf-8?B?SmJXOGNqQzI5Mk43VVlKeUI1emdyNVN6anE4SzN3d3dLcVBnRWJScmdkVzY4?=
 =?utf-8?B?ejcrcXkwOHZ4aTZMSW1rWS9Pd0dTMEh2c2sySXhUUTFxUHNqeGszdlVsZHFj?=
 =?utf-8?B?Ym9xTjhtR2tTRUp4Wmw3Yzd5RU0wcGJHWjV1VmZSME1DdzB3Vk1xZ3dqRXc1?=
 =?utf-8?B?T0hUbkxzQTdaaHJRMG05WkpYNW5TdEhvM0NOWHkxR3ZpZjNvUTNBT2JrdU9C?=
 =?utf-8?B?MnNmRDRuZ0dLMGYyZ1RMQWx6NU1CTDlQQTVDblo3enZFU2pZcm8vdGJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkdnZWRhMVljaTFNdWxnNTdnVDU3Rkg0cXN2b1hTcERYSnhOOWVBVTQ1NXVz?=
 =?utf-8?B?bW1QcWM0Z0hVTEFDVVJ2ZW9ZS2daMG16cXUxMGcyRG8yVEZMZkVLSEptZWRU?=
 =?utf-8?B?ZSs4bnRHbWlJREgxNk84WnFONGpJWnBmWVhCUHpRelljMTRuaVlITmswSjRW?=
 =?utf-8?B?WGN0UWVrb0ZpQ0dHQ1o0M1BHT0wwNkR4ZkZuemQzV3p3MzJlNm9WWjJkOGJl?=
 =?utf-8?B?Um1qMHlDeEhGeEI2QmxsY2MxeE96K2huNU5xTlNBdEI5R1B3SVBaT01jNXEr?=
 =?utf-8?B?Y3J4MGs4QituRnBXMjlKOWlQcER0bVdLQU5aSWc0RXVDbHpWNXh3Lys5bGFt?=
 =?utf-8?B?Qlh5bmhSQ0d5WDRhb2FFOHJ5YUoySEoyNDZjbXZuSXdFdC9PRVB0N3JRRlhR?=
 =?utf-8?B?SmFwRVdiREJCTzJjWTNHR0RnbHZWdlVXUDJoYThZWVJ4WmpwVUZRUmx1eExS?=
 =?utf-8?B?VGR3blhsVlNmbnVONHl4REdiaUdFVXZaN1hlLzgrY1A5NFA4aHpJd080UzZo?=
 =?utf-8?B?UDFScG4yQWxnN1IwRTFSemkvWGV5a0ZqbnI4VFRaRTMxbzBrY1hEeEtPMjhk?=
 =?utf-8?B?ZUNsNndwNHNvQXF3NWF2NXcvYit6bCtmbWRCcWtScFV6dkZaVEt1ZHpWWDZB?=
 =?utf-8?B?RGFGWlR2d0UvMTcyWlZNRWJTZ1NiUTdPN3ZIV3hDQUJpcWF4SnUyRTJ3V2pW?=
 =?utf-8?B?eVM2UCtmSENmUWkrSzlNNWVzTllCcGNHZ2J2cmY5aWlhM1FvQ1g3dmplTlUv?=
 =?utf-8?B?c3JGSkI5L2Q5UXpoanM1b2hsMXZOMVBTblIvNTlhWEdLcWc4dEpaSTlXUGRv?=
 =?utf-8?B?dzFLRzA4MndtUXFBZWozWWxnZHNvS1BLK3V3eThXbUNUczJ6ZXplMEFnUlZp?=
 =?utf-8?B?UElhNTIyb3NyNmRwWFBhWDdZR244YVp6MlZndncwS3RSUnVxa3BtT09mT0dQ?=
 =?utf-8?B?MWhWc3Z3TDdObVQvTnJRY200TldqZk53TWN6ZnlWeklUcytSNFVrNkw1d0pa?=
 =?utf-8?B?Qmx5THVlSjZmb001cWhObHU3RXFOTXpQZG1GejhBUDltSm11cG1tTlpQTTRZ?=
 =?utf-8?B?aXpPSjdKbEVjWXlpTlh1Q2JhZHFVWG50TENQWkM1bGRKVkpoQ2ZFY2FiR1B2?=
 =?utf-8?B?VmJRRmdPbzBLT0NneENVMXM2YnBqOFFQK2tTdnZGSVE0djg3c0cxcld3QTBI?=
 =?utf-8?B?K2NXMUFRdGp6Y2xBK2Q1OEtWNUJOK3E1NUpqNUVLa0YzUHpaMVdlc3hCMG9V?=
 =?utf-8?B?eUhVKzdhRE8zaG1yWUN3YjV5L1YxQXA2eGk3SGhwZFdRSis4WkVnUW5YQUxy?=
 =?utf-8?B?NHJvN3h6bVJMdUdhOTNtK2lWZnFrem9QelBFY3pnVkg5dE5na2U4NUJiVUZx?=
 =?utf-8?B?TGxDS2E1dCs5OWZhSjFPRlo2YlVtYnF6L2ZJSGE2YTZBVGdETWhqeGQyL2pQ?=
 =?utf-8?B?M0tKZEUxNkc0ZENRcEJiWEo3aHVEb21BYzhUUXFOaFdmUHJJeVZIUGdBR3kz?=
 =?utf-8?B?SlZZbS9Rb0luU3RPdldXQlpjU1pwY0pKdTdRWVNaVmU1RE4wYzRYclRoSHJN?=
 =?utf-8?B?Q2U3NWxpYkRVVU9wTHdoN25TNGNBbHFXS1k1Y0VTRWJIeFhUSzRMZlRtRFBU?=
 =?utf-8?B?Y1gwTDA2bzBYQ0hka1REeHM0WGFSeTdMMGRNcWZTa3NoalQ4ajNDZTNPb3Bv?=
 =?utf-8?B?R1d0VEpCWXpjM1Nzci8rWmQ4TGtreU56bnRVenQrUEtvcVBRTXhmOHdndkkw?=
 =?utf-8?B?RDFHVjJuYW9pNXdUL3NUMFhwR2FzekNKTjJDcGgyVkFWRm9jSWlEWWgrUldi?=
 =?utf-8?B?NDVjcFdnU042eVdvQ09hVGtDeVhiTEpVYVdMaE5Ubm5jS3hsUUxHVk9GQXli?=
 =?utf-8?B?d1Nqdis2T0pjZHYyT2NzQlVpUTZaVkxFZUhMT0V4RGdTQTl1Y1dMSFI2SVlL?=
 =?utf-8?B?L0dNbm9lVUFMdkhtZVY2dUtKVWFQdDRUN3lnS2dPVTV3TElvSlpxelpITGxH?=
 =?utf-8?B?a1dza3crdVE2Y0sxTGJFOWVDVjBzekg5MEJTWGUxTk5NbHVqV2JaMkZpeHhI?=
 =?utf-8?B?OXhTWXFpRWE0WElzL1RvY29JNjBZbCtyc2h5K05MRGd5c3p5bGhBeDkyRzFV?=
 =?utf-8?Q?itv4RP+GQvSUz+Xd3krDHX6/n?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bb5629-625e-414f-cda5-08dc6ab0f733
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:05:47.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYeQ9mzftDHE5vx7xdfSs8q1/nz+7UCALNPNb4u6uL8Od8RVy/kJZTFqqc52JXuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9125

2024-05-02 at 15:49, Peter Rosin wrote:
> Since you appear to need to change both the gpio pin and the io-channel, the
> mux isn't a perfect fit. The closest you can get with the current code is to
> create a gpio mux, I think. You would then use that mux twice to fan out both
> io-channels, but only expose the "left leg" on the first fan-out and only the
> "right leg" on the other. Something like this (untested, probably riddled with
> errors, use salt etc etc):
> 
> rcs: raw-current-sense {
> 	compatible = "current-sense-shunt";
> 	io-channels = <&adc 0>;
> 	io-channel-name = "raw-current";
> 	#io-channel-cells = <1>;
> 
> 	shunt-resistor-micro-ohms = <3300000>;
> };
> 
> rvs: raw-voltage-sense {
> 	compatible = "voltage-divider";
> 	io-channels = <&adc 1>;
> 	io-channel-name = "raw-voltage";
> 	#io-channel-cells = <1>;
> 
> 	output-ohms = <22>;
> 	full-ohms = <222>;
> };
> 
> mux: gpio-mux {
> 	compatible = "gpio-mux";
> 	#mux-control-cells = <0>;
> 
> 	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> };
> 
> current-sense {
> 	compatible = "io-channel-mux";
> 	io-channels = <&rcs 0>;
> 	io-channel-names = "parent";
> 
> 	mux-controls = <&mux>;
> 
> 	channels = "current", "";
> };
> 
> voltage-sense {
> 	compatible = "io-channel-mux";
> 	io-channels = <&rvs 0>;
> 	io-channel-names = "parent";
> 
> 	mux-controls = <&mux>;
> 
> 	channels = "", "voltage";
> };
> 
> What the mux solves is exclusion, so that the gpio pin is locked while
> measurement is made on either current-sense or voltage-sense.
> 
> However, the channels from the raw-{current,voltage}-sense nodes are exposed
> to user space, and it will be possible to make "raw" measurements without
> regard to how the gpio pin is set. That will of course not yield the desired
> results, but is also a user error and might not be a big problem?

I just realized that it's also possible to do this "the other way around". Maybe
that makes more sense?

Cheers,
Peter

mux: gpio-mux {
	compatible = "gpio-mux";
	#mux-control-cells = <0>;

	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
};

rcs: raw-current-sense {
	compatible = "io-channel-mux";
	io-channels = <&adc 0>;
	io-channel-names = "parent";
	#io-channel-cells = <1>;

	mux-controls = <&mux>;

	channels = "raw-current", "";
};

rvs: raw-voltage-sense {
	compatible = "io-channel-mux";
	io-channels = <&adc 1>;
	io-channel-names = "parent";
	#io-channel-cells = <1>;

	mux-controls = <&mux>;

	channels = "", "raw-voltage";
};

current-sense {
	compatible = "current-sense-shunt";
	io-channels = <&rcs 0>;
	io-channel-name = "current";

	shunt-resistor-micro-ohms = <3300000>;
};

voltage-sense {
	compatible = "voltage-divider";
	io-channels = <&rvs 1>;
	io-channel-name = "voltage";

	output-ohms = <22>;
	full-ohms = <222>;
};

Cheers,
Peter

