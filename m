Return-Path: <linux-kernel+bounces-166088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9788B960E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76651F214C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A125740;
	Thu,  2 May 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="A5LAun08"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2129.outbound.protection.outlook.com [40.107.6.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31283200A0;
	Thu,  2 May 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636887; cv=fail; b=E9A8sXf7KB37EP6zKZCkSFE4PBSVFcuO1+AFOY4aOzT/vAC2wCG2Ajxb4r/MrVUwgQy1gLzccyW7YLevSOp03s5/DIDpehAATaTzrDgV9dGlE00feOS78HddZ5vOiCUiDcdB/gEk3KVh3rBkXWEFijDo8IRAV9EWOOUrIFVENqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636887; c=relaxed/simple;
	bh=6PdaI+3M85VaG5zLn/s58/uJ3uKSYYQnyRiTmDi55xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SXJAsqlZowvi1COZBN7754W5S31kyuk5w6QOk0udfBcQIBLHd99M94KhE+EmdPhFfzYDEnJm22FwUjoVog6IL+INUOjKFmPoxhhCczwoAuZaoCX5PZMWU9ttmmhvi2fsJkht/GBzhBUeGbAtogJKsPWpOXWZhA2WQPl3mtRa7iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=A5LAun08; arc=fail smtp.client-ip=40.107.6.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy+AsHnF/xrugf/OQzitvlZN9363kl56xrHbbEpJUd7Mxt7LrvmVyCLhtIii7pDftwYD7IEwefcwDO3Qqb5kvkdaq0+vmXbJ8eHR5sa3xn97gLYbZT6O94bbZq37lhIls2Qc4rrfT7C04Ppeuste5nDDrR4lNyBg0kX+kqKLxqJEiDmmD0aDb7K8gArikYRdxcBvRHFEMYm82emKQ0WrtKgXKqzj1KH+vpI2FsogwxGgTvkjbcBN3SEA6EUlfQ4K7x+R69xiLm7ZuFiRipWARygyqyoLBRvOJA0l3OgZ8Te8V/yrIzFBCZrYQ1pQQ0/FoYgZj6+rz/xSFV9bk1Iwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3YVsWwpt8fRgi1fYRPJd0gxFGKCUTQg4ssDrOUP/qE=;
 b=RmrNG8wswkTM2GE/Y0TEGWXKThl3u+x49nrRk2O9CA+CEwnU4QSMXhssXI1EzQXk+mH6E8/R/G9PIcGDQ4mRwAKS/mwp9pd0fo+H9aflhbfufYKAF8vIW9eRLoieljO5qwBQPAMLTDkJT+dTokcKevi7WBj8yEkU90Z1u6A4FJkwK3P3QQdTYjKO2+fe+cp2OY5bmeM4VgFT15VkGJADYYlmHGFM27YxAVQwjvfDTn4tddawAi9900ZlUDog7zCow8Luiaa6lgsKjwdJhBjt2e/AAKgR37THuaFXyL2mbnCMOzIvBsaw9ruVvCn3IRsGvDxcz0oEF7HZIoATHCFgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3YVsWwpt8fRgi1fYRPJd0gxFGKCUTQg4ssDrOUP/qE=;
 b=A5LAun08C/fs9iLamVahT1Xkv7pzK5s7SRaCYu9QapGx2cIZaD2VOIV1KInt522n7iswF87QkLfU+lqqjGlu2DfC6Q+ZZ+DnJ4IeDVsWqrqVMoqkkvA3gP9BoW0oh1uEu0r7ZGdNn78xacE+KFjVtvJkNzUEUovV1aikeNKrF6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AM0PR08MB5505.eurprd08.prod.outlook.com (2603:10a6:208:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 08:01:22 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::a8d9:9c54:680:676c]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::a8d9:9c54:680:676c%3]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 08:01:21 +0000
Message-ID: <785c080e-c133-40f1-9b15-2854827a0a0d@wolfvision.net>
Date: Thu, 2 May 2024 10:01:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: tmag5273: Remove some unused field in struct
 tmag5273_data
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <7bd16d7fea12c64b6b3dc3cd32839cfce145bcf3.1714562912.git.christophe.jaillet@wanadoo.fr>
From: Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <7bd16d7fea12c64b6b3dc3cd32839cfce145bcf3.1714562912.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AM0PR08MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: ce88a02f-0748-4d0a-eafd-08dc6a7e0de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlNZREtCOFdCTERSWFpuWHR0N2VaR2dGQVlvL0xxem14VGZUNjZGejVzTFdp?=
 =?utf-8?B?TDhqQmVZU1E0TzNjK0RrZkdPaUNZYTZGaGxnRXFNYkxTSk9LWFUrbHF4SE55?=
 =?utf-8?B?OUJCTGs5QW5IdThGMi9rK0o2S1RSYUtVZVNIRGNwYWFlTFQ4SGhaSDNqaWxx?=
 =?utf-8?B?Q2Uya1ZHNGRZWXRTbjhGNXFTcWhNY2RLc2RLc3V2UnVkdWlQRFdIU1FKcVNR?=
 =?utf-8?B?cUs1eWRmNERJbWhvaUtBN2MyaTUrSmVXcE9xaCtyKzJyYWtIdXFXSFMrWG01?=
 =?utf-8?B?Vlp4SGw1bGRxcG5paW52YjFnbk9mbk14NGFQOSt0eVd0VmdNZlJGQVF5ekFx?=
 =?utf-8?B?TDYwK0ZiUGZuakNvUk1SVVc2eEk1d09QZnRXM0FRaktjVnlNeWJKUVMyUUZa?=
 =?utf-8?B?MGxNN0dYbWJEdm80N241akoxMldyRndhL1lLSXFoeHF2bWltODI2WWtqWkhI?=
 =?utf-8?B?eGZkWFVCVkFhMzE4dDRaQnZQcDFjYmlmNmVJNWFUN01JZVZVbnQzQ2ZFV3Ju?=
 =?utf-8?B?d2NsWkNoQjA0VWhFNU1tcy9BN1drR0YxU1VreGx6TkxKMG5leVFWcEt6WFR1?=
 =?utf-8?B?N3VlVE04a0I4WDZNNmtnVWlsTzNoUVVNRU5nL1hDV3k3WWV3ak02aExFMGJY?=
 =?utf-8?B?bFFWZlBBWi8vWlNOK0VKOUYvSDB6LzZydlpYMVgvQ0FaZ2toZ2VsNGQyTS9Y?=
 =?utf-8?B?VFEvMFowUVJCNW1oQ1prMk4vT3lKbHhlRHlodEpENVUyS3RXei8zd1dSUXJQ?=
 =?utf-8?B?TEZJZmdxbHV1QzZzb01sTytGandwR2UySGwyUUpad1Z3R3d1ME5SeTlFc282?=
 =?utf-8?B?Wm1TNFJRY2o0Mjk4ajZGN3VjdXZXVXYyNnRLbjZEL0dja2NTcmZBNGU3UDhZ?=
 =?utf-8?B?MktPSTBYWmUzQkRSOHpINlFMRTEzWkxIZ2hkUGNHK3gyeFVpcGJGVTNKaG9v?=
 =?utf-8?B?TGtSVXBaSVNQMUFkZ0Y5RXhzRGZXcWthdzZoaDNCazk2QUJjSVlBUDZodTdN?=
 =?utf-8?B?RTNVRFpUZ1VNSnI4ekQzNmVTOFk3aUs4VGYwci93Z2JBODZsS0NOS1c5ajZ4?=
 =?utf-8?B?MFB0a3VUdVRhbWFOQy9vMEdGY3NIWWZvaGNhN3cvRWNIUnVmZGJURW9GSXNB?=
 =?utf-8?B?ZGVmYUErRlVQSWVNRGhXamtNOWpDOWRCREpDRzBYckVuZXFQM1I1cVlQS1lL?=
 =?utf-8?B?d0RJYmpXRmZycjJJd0RBd0RHMWxpY0NuYjZWZWFibUVha1pLK2JQd1NTMjZT?=
 =?utf-8?B?cTFRNGVENmI2VnlaajYwR05nSDQ0UFRROWJtUHFpK0pnTFJ6enFabUV0TnZ0?=
 =?utf-8?B?Q0h2U3ZSRWhxZm5EWExnaXBlSjNleVlvc1d4aW5nY0lUM2xVU2psblRUaUdy?=
 =?utf-8?B?Ylh2M3ZqYldNN3VPS2lFdjFDSFZCajNiV3FSRUR6NlZJWWxDWlJtdnF3MFBt?=
 =?utf-8?B?QUF4Nm5xa2lrcCtoaXRPanZiL1FtQVZoZi84akFQdGxkUkFKOFNJM05FNDZS?=
 =?utf-8?B?SXRtUXJxU2F4Ukk1Szg2TkNMVm1ESmczSUpkS284ekNkYkowV2NzYitLYXcz?=
 =?utf-8?B?MmxKWk44M0dJTHRTRkJKSk1STEZGMkZtb3pKNyt1ZDB0ZkNUMDY0SHVEQ2JC?=
 =?utf-8?B?dmRZV3lJQWh5RzRBeU1MUDBNY1VyMlZLN3l0RGhEYy9Vbm5hUU9MQ0RSNERz?=
 =?utf-8?B?M25yVDBwUFpraUN6VmVUSmxReFNDc0FYNElST3VEVVBNNzcwM2YydEx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnJoVDBlOHYxcys4SXVUU3lkZERwRVF5b3M3OVR4RHRFTkkyZTd1SGgvdGhL?=
 =?utf-8?B?dUpqa3BCSUgra2hYYWx3ZmdqbldCU2NENjJybXFxeFE4MGNSZDRVY3FPcm9P?=
 =?utf-8?B?a2FabjhFQWtUakpReDJHTXpqbDNCemx6WHo5TlZRcVdYWGFzVTM4bzNYZEpj?=
 =?utf-8?B?emo4UXprVnp4QlhoV1ZzOWs3dlZvTkR4aC9seTc1ZzlmK2VPdFNwYWdMOG1P?=
 =?utf-8?B?eUdRSXdsaUs1aC9sL0FBVGM2QkRWRk1qWVNoRFZtSm5vaDRHNFA1dXBLNzR1?=
 =?utf-8?B?U3Ztd09mYzZ2SElqZEVKM1VHY3hwdk9tdTlxV21kZXFmUGxwcmcrZkVhcllR?=
 =?utf-8?B?UmdGSHBWYkdBWWRmOEExa0pCb093UmdsSnppRi8ySHJyZStES0FXSVFRQ3FQ?=
 =?utf-8?B?WGpDLzdOZkVpZGRpdmxicWNZdFYrc3FjTVpINlJ5enFSSXhDakJ5aTJ6YkNr?=
 =?utf-8?B?TDBOeVdydC9sV3JCV0NoV1BpWDBEbElESDlUUWorQk9BTXZrTXJ4dGZwZlRQ?=
 =?utf-8?B?a0d1WFVLZ1lrQ3p3NWVnUGljMHhOWmpQb2V4eVVJSTZvblF1UU00WlZKZDFP?=
 =?utf-8?B?cW5WYWtBd2xJTEF3azZ5aEpzMVZ1dmUwWVVodG0rRlpWRWVNZlhwbUUrYm81?=
 =?utf-8?B?UmpBNVhQanBaVSsxRGdHTE9NSkZOWHk5ZVQvUkdva1VnaGx3NENDRjVOcTF4?=
 =?utf-8?B?ZWs3cWVGK1dZVWhpS090S2ZWRlNyTWt0bmhSL2xCSnFIcXAwKzVNL2RsL1RB?=
 =?utf-8?B?YmFjZHEzSmRDQmFFLy93ZTZLbEhzRnpXYXl0eHlXbWRQUTFrbVoxbDVXVUtk?=
 =?utf-8?B?Zis3aXd4TEJ3c05obHZDbDQwMzlsSkg3bk0vRmRiaVJkVG90NG8zOTdGRW9M?=
 =?utf-8?B?eTJwYWZIYVBKUk1rZnpxSzZTWGw3TmIxYk1GZ3Rna0xCZzlkN0k4cEZVK0Vs?=
 =?utf-8?B?bVVoWEZOZ0NjY3hjbnk1WnQ2QW1nVURBeXB5Y3pPT1BwVmdyMTVNeDBYNHVE?=
 =?utf-8?B?dHVtSXFYSVlNME1YbHpMTk9WdnBKNzZ5Z0hOMFE0UGhNUTk0OEh2OVBvTUU0?=
 =?utf-8?B?MU1IcTlJekM3dHdLT09NKzNtdGdRMHhoVlhWbUpiYzdOanJhdkR6N0dmd2xi?=
 =?utf-8?B?aE5tUTdFa1MxUjFxM2lRRXJhdVhpYnZ3amIxc0F0Rjl1UmpHQnpOTEkrNmdH?=
 =?utf-8?B?Vk13VG8yaDlmZmxXVUxlS2RCRlpCSWlsQjQwYU9ydFRwWUhZUmhNenZ4ZVRX?=
 =?utf-8?B?SUd2U1lYZ1FQNnoyUUVZVUtydmNWaFdoY2pPWVgwOE0rL0s4RmEvMStoMzIy?=
 =?utf-8?B?aTZnMTE5UG5pM1E4VXRrWUlvdTFjQmNFRlgyN2lQQnlvM1NJZkdzWlY4ZDE5?=
 =?utf-8?B?UHNWL1hrcmM3TkV0LzFXMTJtanJvb2JTMGJTMlU2ZlppaXlDNVBIaThOMkNq?=
 =?utf-8?B?eElmYXdoUFRmcWZJRmtRTlBtdERoalRScWVzWU8yYlNHeHJPTGdhb2pzeG5o?=
 =?utf-8?B?V3l2QkN0YnFrOVRPZjl4V3dCOTVKdjg1ZUZoY0QwYXdzYkN2KzZjNDBnckpw?=
 =?utf-8?B?M0FaajRxaE0vczRGaUZDeko4NnlXSGlhQ3VSZkRNWUNtSmh4enJIc1JsK0J1?=
 =?utf-8?B?NloxeW9sWERtSzUvZUZpbFEwb3lySlRFVnVJK1lGQ0ZCRmdMbHVCZjBhQkMr?=
 =?utf-8?B?Mms0d3AvQW4rNnhjalVkaGFhdEVGWDVMRnp2NnVpbFgzT2VNKzJKRGhpdUpz?=
 =?utf-8?B?bmhGRERHYnhSOUdBa1hvTXlnVTJ2NHBqY2RpbGd5M0oyVjJsUnZNbTBId1VM?=
 =?utf-8?B?Q1JHNG5KWUxpRXBrNFM4TGwxTXFiRm9sUlV6S3BHOWloU2pwYmphV2JmQkdQ?=
 =?utf-8?B?ck4xelVYK3hZR3Y1cnlNMEtEMnBheXpvblJHWFllWXBVdURidGtEa043bW5S?=
 =?utf-8?B?QndnU3k3MlhTaXp2Ynd6bm4zYUMySVJOSlZNcmNlMVowOG5KSFNGNVUzeno1?=
 =?utf-8?B?eTVQcDZVVTVBRWc5eExTc25YOVpaQkcybnBqL2FxanBjMXN2OHNNdUVLbGhT?=
 =?utf-8?B?b1pBOFZWZUNFRXBONC9BNHZOaElDQVM0RjI3ZEI4UDk1OFVzUE1UcVpoNlBN?=
 =?utf-8?B?SkJ0YytjelVXWFJ2eDZ6TllLNGIzRUNENGlvTXp6bGVhYkV0NFRIYnV2L3FF?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ce88a02f-0748-4d0a-eafd-08dc6a7e0de0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 08:01:21.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAkUuobaQzMOuTRYGbSPA1MfrGKWI6OcCQrlkBbzU+BUlxN9pV8XqdYW38t8wIlptT2YT5OFE0/AeEzRQ1d0OEHWqoTuBd0aBg2714nUk1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5505

Hi Christophe,

Am 01.05.2024 um 13:28 schrieb Christophe JAILLET:
> In "struct tmag5273_data", the 'scale' and 'vcc' fields are unused.
> Remove them.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> It was added in the initial commit 866a1389174b ("iio: magnetometer: add
> ti tmag5273 driver") but was never used.
> ---
>  drivers/iio/magnetometer/tmag5273.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
> index 218b1ce076c1..4187abe12784 100644
> --- a/drivers/iio/magnetometer/tmag5273.c
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -118,11 +118,9 @@ struct tmag5273_data {
>  	unsigned int version;
>  	char name[16];
>  	unsigned int conv_avg;
> -	unsigned int scale;
>  	enum tmag5273_scale_index scale_index;
>  	unsigned int angle_measurement;
>  	struct regmap *map;
> -	struct regulator *vcc;
>  
>  	/*
>  	 * Locks the sensor for exclusive use during a measurement (which

Thanks for cleaning up.

Reviewed-by: Gerald Loacker <gerald.loacker@wolfvision.net>

Regards,
Gerald

