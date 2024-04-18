Return-Path: <linux-kernel+bounces-150163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427318A9B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE003285F68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706615E7E7;
	Thu, 18 Apr 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3U0+m6dz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C114291B;
	Thu, 18 Apr 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446594; cv=fail; b=o1Hhg5oP5rtnTaTrdEiTw/80pXqeF3DL7qm4Dw0Sob6hcjfJ6MhZOlMvowWiDCQDKNo0F5JWWnPPXxErWcGIqSc6LsCddnBf2YOKPmuoqT6SQ5gOEoihaFE2YHj0+oK6ZvWJUGC9QGA/Bh/5yfflSQ2fwORKsD0KSr/trk0PA/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446594; c=relaxed/simple;
	bh=MEwjz5vRMUBydyGKS2ZvWcEJtPGwZy0fTHXry5GGwk8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RvzFqikyu0b19kHhNUev2DBGC6N4/ueb1RcMAelacPQXDyASBsXd04GNlZMV99DeqEM4H5bb1m5w27TlSewX89kMLRhUu77FYVvzfjdLsyY5Ols2vyLNfdiy18vmXoCG1TWcyqJcwyYnk/v1jgaNCmGV8gXOelSBquxhNiW8RPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3U0+m6dz; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5jhQRa2rxO6hzDGgGFcPO1q9IwwfQ8jxAvyDK5hD+xPRYKcdmKzW1+tZVTsb4QSjcXd1kBswJZj+qW/487IDsWla27j4OvmUBKZoaaREv4psOaWmBx9zPQTDB4AEj80hG/YnbXudtrmquxuIaT2hoGF5NZYMbopCDuA5wmCcAyJmFpf9H21ZyIaHBqV3JKthBH8PdHhgSZvfOaFP833thYEYpVW5zwjQaXHuYQpTqAcyHuD+KH29bI3B1wBtd6h5kdQabS3TgUakMuxcyxXkkTg7Eb0YuORiNfPZHDAkqyuvD7UHJafqknwmPFpUaiggBnSDRYT5eCFKUjeEFU2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR3aUCApV4e0PnKtBOBj4Ce5gqiZvzIJeMAnVkghPrI=;
 b=RqDEgYni29I2z398PauLTP2YegVenv+Bsglakskr8ErymFofp4xACcWj7bsHsV3n2Zlp+Pne5PgEANEfIUGthg+qKmxBq1exEpVh4Lk3DF7MIhUIAimJU7zXkfrjWn9r+12W68P1lJUkiYt6Vzjmix+vfMSvmFdNiijiVl1Gar5a3f33IVJuPbSpr+ssY2IZQxmv5tOzG6SQW29UIugYr3QVSH7o8eAG4456cMAT5elz5za2o0fNO4PTMKiRoVvPTLObd4gD8iqKJ0USLfHX5UYIZnxAXce1dnCDD8FF3bb+5t9/ewi+aC6cHBwii6xx/3LvgFOw4IZ4ecbqz6/M2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR3aUCApV4e0PnKtBOBj4Ce5gqiZvzIJeMAnVkghPrI=;
 b=3U0+m6dz9MA4XBFdyTl9IzC1tCHN5m8smv1LYbbxqHDEI4xZ7LlQN2qtJrDh5+DHj+z0fld8eKWMRURtPeWXxHTGyvZulS1PFXSoOGj9ymTw+gOHFtiF7huyULP7N0FV80DG5z2o95ugMm5U50z4mgTkHcGf5dMN+O+86RRg8jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 13:23:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 13:23:09 +0000
Message-ID: <36a20694-de04-41fa-a637-1de0a4aa5da4@amd.com>
Date: Thu, 18 Apr 2024 09:23:07 -0400
User-Agent: Mozilla Thunderbird
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] x86/mce/amd: init mce severity to handle deferred memory
 failure
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: yazen.ghannam@amd.com, baolin.wang@linux.alibaba.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
 tony.luck@intel.com, x86@kernel.org, xueshuai@linux.alibaba.com
References: <34fa94f5-359f-f3e7-92ae-fcdc06ff19b8@amd.com>
 <9f9b0af3-669e-493b-9a26-475115410435@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <9f9b0af3-669e-493b-9a26-475115410435@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d4282f-9850-4ffe-1b3a-08dc5faab0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXoap1Tf0XDxu8pLV+wPP2vcpttPuScOHxWKuql1UTMucn6FDn03Nit7niu9+iB0Ca4XXy57XRzdUAUrXuebVfthwd2MjhDNejd1VRAjjaApxpw05DSf9nxAg10hRk75aV/Oe9U1pJuYd0586mat3n8voX3PBTsTBdooNDxHRbtihIujPRGHn489T5iI/6RTR3QcYkX08sF8omJxkCi4YrG39FNNXMFurpYhSTpm62MDLpu4NTIbn2JDGlukE1wEQv4g4X+gwY/1zbVA/kKXV797mRIk41xNO0DuErcpA1B8/5gbqakfMrENZmBIikhppsXsWU2wTFE7N8O802WvMV/KM8NbuqeAIJeL9AYtL30YiVVR/7dt+TRVx++lQBDu4mQ+wEhnrySTVkio+vhqvvICnycsX8ChtSNoTW58dvm0bwhc9jxakDwQmuUFaWlI/dIydClph8IFy5d82ByF1vU4YgcP+h8sV0X0teJanjtayXe8IlZZwZN0Zkj9EgK0DS93aigIKMw7l9+MSAS5sRhJ9m08hYc619oaGHNOpSEkoQsYYJkAR1JAk4im9JC7eqstBKD1LRha7q2q6sCmy9QysxwL3UfnMd8qB/Yn/VsbgFXPzshmczNWlpNhlJpM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2YwL2lLNDMxTGRxQi9Ha2Z2dmU3THZjc1VjL0dpUzFieXhqUXZ2b0JYN3lz?=
 =?utf-8?B?TFNPZ0QyK2Y5bCt5S1RHVVc5SGRlZVZqN2pLbzQ4QUo5MGFNc3RVMEZ6UGU1?=
 =?utf-8?B?c2REbElIQ1V3Um1nMm85bG54bER1NkNWNFNiemM2Z3FiUGlhVzJpSXAwNVc1?=
 =?utf-8?B?cnEyQ3lqcno0YnduSWdzVEJKZ0pjeE15dkhod2NhU0hWK1pMK1ZHQXFnL1Js?=
 =?utf-8?B?TWJkR2FHRW5UWUhURDdFVU9qbndzRFNacFZYT3ROaFFPMWhici9CRUIyYUVZ?=
 =?utf-8?B?NUNwN2YzdGZSS0xDYlpCZzltUE41TUg0SVAwbndLU1k3dGU0MFl3b3NLbmJQ?=
 =?utf-8?B?Y0xJbStwWXE0OExLSHJQcnZKVEFNaFNlaFFaVC9MZVl5V3hwSzNhdHZQVVJi?=
 =?utf-8?B?dmJhRnlob1RPYno4VVpwTEZKNjhDVmpDNWxSWi91bFpYREhIR3NjQVZTV1Rw?=
 =?utf-8?B?NU9NUXI0Rk1FZlEzd00yeFpwWDhxMVNkYnNRTE92bjMyUlZpZzVUK05yRFEy?=
 =?utf-8?B?QnVTaHBpSDJ1THN5b3Z0L05nMG1BekdFVjdIUnh6Z2FjdkZIRjhZeHR1TzIx?=
 =?utf-8?B?amIxcUdPdFJQQVNUMVFyZWpmZEI3L0ZBL1lGSHBuUnpRb241bStOM0ZmSCtU?=
 =?utf-8?B?Q3V1Wk9PNGVrRSsxbTdZVW8rOGxuaEs2bW9xRlJXZGZKd2lndTZMaVJXRHF4?=
 =?utf-8?B?SkFlUnFPVjAza1BlcnlEelo5c3dxNGQwTjB4K3MxWEZyMmdBSWxqK1F6N0Vo?=
 =?utf-8?B?bVFsSUFkKzdPU2g0cWk5T1dYeUVtWjU5a0krMG5zZHVWYk5WU1dmNmhlclAz?=
 =?utf-8?B?OUxJYXZETExTWG5FVzBYY2d6T1FtMVlQcXplSzVtejZtbzBSOG9pQS9HV1h6?=
 =?utf-8?B?WWNQa1VCUjNVaTUvMkg3ZVpEVUhOZkZRZGhEQkF4cExYRVVjR1VGZ252YW1l?=
 =?utf-8?B?a211TllETit3ZkJyTEk1MHVTNmVqdVhsRkVhVW5wUWJzLzRhdnBvSmNwQUs2?=
 =?utf-8?B?Tkp6cDZUTEFWVDl4d3lqalRMSjh2blY2Z0lHTG9GVEcwc08zZWVJRVhwVU80?=
 =?utf-8?B?NmNJYVhOTXV3cXVxYmlrOERKNlFaY1BzQXU0ODhNNUdieFNUYlpUamdYdjF6?=
 =?utf-8?B?Z3ZaTXlKNlppV1VrNTFYRkVDdWUycEhaS3ZSdXYwUjYwSE1tZnJCZXNOeGdr?=
 =?utf-8?B?d3B1RDZWMmVpTnpISytRY2RnVkhMaGRvT1FGc3lOTlRNZkJLVlkvNklLOE9T?=
 =?utf-8?B?OGs0Tmx0aVFGeG5SdXlOQzdvV05RQnNZN01ERE5Nb1JxSWU4WG9QTlZiZVhH?=
 =?utf-8?B?SER0cWJVV2trR0lMSEhQbEUycmJTN29KV3h1QUVFVmlZbWpGdnAySjRrYmtZ?=
 =?utf-8?B?S0ZwZWU0SHZjTnFnWHh1aFU0a2Q5MFp4anYxSUxOYmh6TGNZaDZtY0d3TjBq?=
 =?utf-8?B?Y08wTlJSd3JWUUV3c01yMVRCYXJUckhlT1Exd3BjTDdEVmhZSGQxd1Z1STVM?=
 =?utf-8?B?SUR5czliZkV4Y2ttRnVTci9nZ1hTTXRYRE1iSWEvWXc2UlZnRlVNVXNhZkZF?=
 =?utf-8?B?K2FkZ2dRbnV1ek5JWXZ2alpDTldMMHV3RFlEUkhQYkR1OXVZaFBTUWhiYzRm?=
 =?utf-8?B?bXU0NWx1NGNJUERwVyt5ZCtCdUlKL1RvdUFxQjdsTkRFRStxNnJOemIwS2s2?=
 =?utf-8?B?Z2RyMEVnMnQ2ekVkVzhWZ1RwMHhMTWR4a1BVNTFISXdRZTJ2YWxERU9CSUJT?=
 =?utf-8?B?MUhDWUQyNU56NmMyUEY2ZkdGaVFRbnpHazk1ekVnTXlxdmgxcU5PbGU1RDBv?=
 =?utf-8?B?YW5ob2doSzBwTmFhMVY3dW9iM1FTTnRXNEh0WDRobFczM0xZUVZMYlpSQmdT?=
 =?utf-8?B?QWlHRGxqdE1GdnNSMW1NUXZtR1hTdmMzRzFadkw5MFVJdEM2QXM2QmxDM1ZW?=
 =?utf-8?B?TFk3NVJ3VHFQQ09YNXcvMC9KRDAvSjlSSEMrNzVFR2VzdGdWVlFDVUdZL3VE?=
 =?utf-8?B?VFVBZ2VIM0J6WHZka2VLUUE5YTE2a2hiakUvYVY3WW5YWmprWmdkVjV6Yitr?=
 =?utf-8?B?dlc5NHQ4Wjh2cFcxbmgvOEdJenhxS0toRjZ2TzhsQUhESnBoVHVXbjNMU0Z4?=
 =?utf-8?Q?/ooorQ5NcyFrj/ykLbzbth6Qn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d4282f-9850-4ffe-1b3a-08dc5faab0e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:23:09.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2JGsHBWKfAuwu8XOGzqDgfDGgHyLgNfTuAY7OgKd6wyB1S8MqCZQc6rSsBa6xuYy+4HYVA5agmDjxxD6yoKXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

On 4/18/24 04:42, Ruidong Tian wrote:
> 
> AMD ATL has merged to upstream, can we merge this patch to process 
> deferred error with memory_failure()?
>

Hi Ruidong,

Thanks for the follow up.

This patch is made redundant by the following patch in review.
https://lore.kernel.org/linux-edac/20240404151359.47970-11-yazen.ghannam@amd.com/

Also, this is still not sufficient. The address translation still needs
to be invoked in order for memory_failure() to have a valid system
physical address.

Please see the following work-in-progress patch.
https://github.com/AMDESE/linux/commit/6ddd8e90d08edb4a2730ccd02981baef4645bb43

Thanks,
Yazen

