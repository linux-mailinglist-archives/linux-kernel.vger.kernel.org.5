Return-Path: <linux-kernel+bounces-166640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F48B9D63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DF91C20CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA815B96E;
	Thu,  2 May 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GcUMGFYu"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB4153585
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663754; cv=fail; b=bN9orPLbdXJ3YH20IrifCV8oh/+j/DM7qcE3HmFuhibZ5K9WG+FABRwbHCJ/P3F67q8bgQBFRxe8Lm6MJg8X8zNkfqCyNeNtBnB9TfLmto/zSKJkm0PTjWeyIfP2KIE7qPrW5bwtMgtM7p/PtRgkdwWTwvFyQfc5oNyLwDMuKrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663754; c=relaxed/simple;
	bh=hQ+Z1SnhEV+W3iWvzf3wdl13B4jWOPVOluAxSIjUyuI=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=ejWgSpWrF4cfxeEQkT8MkNtAhODsGiOa3grta/wreok5/AzcktZtMRDc8mSq1oGxClM83WHSJJryB9m39zQZHlLCyBf0npOmSt6qRSZlGZCs/34XsC7ugLMV3ZO5DV4WfGUu0nb2SavsOFV4JfHr525sF8dGSN7F3RQK/wa9Fbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GcUMGFYu; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6bH5AY9EzHAvgr0pNAQbc5nMjcIrGmH/9SSHTXjQzkKsM1z68VDuEKhke0LxcFvZj22H7CLRXvyHVYVk0s0FL8EpyPakQFhz1zSi++r+hTaK5MzTzQk7MSMo8Vi7RmovG4I86byD90gfj6f53ex01cN7iZr3bP1DiVMymF7uKvZZ17burGjOxSGnZfKUpsqCjoqRbkFaTD1RuWsPuFRwKNB1Ed/bKIT5i22510sXa/WP+Tk1bfn0d1eWHnD7vKQNxyOyh0yBkWk1DbfJclriwAALDqFOeVLsszjfPlaFr8ptlQZMq1EM7HkgviIK7fmZYyXhOuAdOh3F1M1HtoM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbPYqIz+d/GKs2CemZwwcpNzRLKgkM0Qw40VH7JqDqM=;
 b=SiC6QozTFi1/3w+9rdylBtebMt5Q1kH55DqhDrIuRwoSVFwZNPJymdoTy05srqSZh5PXoX/R3vkYC/Cm9/n4LXSZM55HwMz7XmwVAzZ6e4YxOM8TaMdITFmYPp03Psctge6iu54xSZYqnHgMeKPtKILyTReXUmrcA0+lScbTYJH42La1zJH4T6lP43ro0trFkH5VUe4rawbCSzA+2+g8K6WKHM6ZUc1tzL8Ezu6MQ6jDWpgOMqAb1fQYETmQnLDDy3PEjB7zUqwC4PrsKkv/XAKB7PSF0WFYqqhl+r5xNSl6EPhTBIz0Q+JripHJ2HeZw/JOrw4i2a9i/ICeQip4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbPYqIz+d/GKs2CemZwwcpNzRLKgkM0Qw40VH7JqDqM=;
 b=GcUMGFYuJa69vZxadTC61GOP6wRK/qFlSYxRCi9q4ytWKu/pFS3epIckkjufvTy60nSj81ubO4Q3df7L7GdaDd7sqQnrkUiD/bhdaFLgY9K1eghfodptaMSFUjtSdJod0wmbapYT96HMJIvdgVgdqQRAyQzOMgIdsNT+un4eNDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:05 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 15:29:05 +0000
Message-ID: <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>
Date: Thu, 2 May 2024 10:29:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
 <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
In-Reply-To: <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0030.namprd05.prod.outlook.com
 (2603:10b6:803:40::43) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0f48bb-f972-44d0-b1e0-08dc6abc9a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVk3MDJBKzhLNjAzaDhVT0srMVRwc3o5NkppdDBBRDIycVY5a3RNVVRhYi9r?=
 =?utf-8?B?MTV2akswZXhoOWpYWm1BUXowM20zbVlrb0hUZTBiZVZZK1RPd1lkQlFoMzla?=
 =?utf-8?B?RGxaK3RBUlIyaWFwQzRKbVk5VTkrWHRMenptU0NyUHRmaStOeU5Pb3lFcFBF?=
 =?utf-8?B?VWhEZE1lL0l4ZDRVVlg3Wnp0UmUvQTZwUG92TnEvWVFuZG5KNzlyR3VkYXNH?=
 =?utf-8?B?czRqbW9aZHVtd2hDb0RJU3Y1Y3MrOUxzM2dYaGUwZ3RNRXY4ME8ycWtEV1pm?=
 =?utf-8?B?YUZDZXZ5M0dXbVlOeVBjdVF1bC8vZzBQVlQ1cGR4WElvSFdwMVhGUXVXMGQz?=
 =?utf-8?B?UmUvTmRybkNwZFcvYWRWTEpWd0xFYmZJaHlOS2tYSVNNL3BFZHRJZXJueTQv?=
 =?utf-8?B?bXEvOWxzQjhXWSt4ZzJaTlNBR2RmeE56WFRqdkdkY1djS3E5QXdvemNYd05U?=
 =?utf-8?B?bUhjQXAyQVJzY05oV3hkSE4zTFd3NDNEbS96NmhOOHlreDlnZDZXblR3UDFL?=
 =?utf-8?B?ODlyOVI2THVEWGMxSDhEenFNR3VwV2xGVTlWK0VIT2FTeUJJRWUwaE5sdHJv?=
 =?utf-8?B?d1hLWjljUi9EVkZlaVpwZS9SUEk5M0g0RlJ4OHRacmlKK3FUSFlDTW4yQnFG?=
 =?utf-8?B?Z3NKYThpUmRMVUFYQjFjTjFHdERkODMwMnRMUE5JRFhvM0xtbnVZUVAvLzE4?=
 =?utf-8?B?VXpFbytwcmtnWXljcFZnZ3p0aDRTTzNodU13T3ZCT0hqRnVNZ2JYSWN0YmNX?=
 =?utf-8?B?dWtONUNkU1cyWlY5NGRRZ2dadVJncVR2ZHJGTUZUWEtzUTB6U25JVXg4d3pD?=
 =?utf-8?B?NjE4NmlKckhiSUZQYlZHNDI5cWJlclRyWGttb1RsTGtLVUZTN0tZbGhuMmZp?=
 =?utf-8?B?VktueUFCczRZaFlETGhVOXY2dlNzelpmRVhnK040MFZCaFJuVGJmQW9Ud1Rm?=
 =?utf-8?B?ZW1QRzVGMWd1VkJGdDltWlhUaGM2UHNzNUFGSlBxVGhhRnJ0WG5sVkk4QzNh?=
 =?utf-8?B?WnV0ZFFFaDEwWVpwS3BlVmdIdlZVV3RuZjY1Q1F3S2dGVk1lMi9GRGEwMlRy?=
 =?utf-8?B?Q010YUxMcVIvdFFrWFlQUG03VjlXZGhWTGVTVi9NOU9HMXNLMTdzOXVJZzRx?=
 =?utf-8?B?YkZOM2w1WUVqZGpzME9PdzIzL1E0MUhzVFc2bVZLZG9WTWN5em11MVRycktU?=
 =?utf-8?B?K0EweXl2RWxlWi8rYVhLS0Q4M3pYd3FjYXhNeXFCY01qeXFueHRzZE50WE5E?=
 =?utf-8?B?dW1MYzBFSmN1czQ5TFEzeEV0NURzK1I1a3Z4bE5mUGlrd29YK0d0MnRTbEZs?=
 =?utf-8?B?SkFXTnZnMGxlS0kxUFpsLzJYZEJoRVhIc3pLYjB5Z20xSVRTeHpDQVhxL2FJ?=
 =?utf-8?B?QUNtSW9Na0ZjWmFiYm5JT1EvenZENkYzSEhVQjFQTkVibTBoVkxXRjF6Q0ow?=
 =?utf-8?B?M3hyWndoN0FnZjhQR2trOU9TWXYybWExNVVoaDIzZmRDQU9DZmM5bHYzMzZz?=
 =?utf-8?B?T0FHWVpBaUdoZzBvb1pYcmZjUGRtRTdSZnRhL2N4ODBqNVdua1VreTIyUUY2?=
 =?utf-8?B?dGkyK29ZNGZyMUMxSVlDbm80Mnhac3Q1OUpqa05RdmJTWTdvTmRxU3JLSThT?=
 =?utf-8?Q?IT4Oww2oK2C9YtPrW5e+YC5j0TS+7JjNh1e0+TCLgN5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRsK1Z0VVRMcTZwTGp4dE10azBSd0FyT1YyY1poMVhwc1JIU2MvSS95bFgv?=
 =?utf-8?B?aTIrM2kvNVRvc1pzeTFxZEJmdTN4ZnNlcDNPak10T0g1bEIwRC92blRaRFBt?=
 =?utf-8?B?czhZWm5FSE1NVXFyZWI5ZVFuUFpxWFRzY25QWVY1NUNiNkhkRmFyYUlvZTBn?=
 =?utf-8?B?YUlUbE9oN01WTHhobG8xNSs4aDllaTRtQmxKYzFIS0FZcDd5cC9mN0hYRHFB?=
 =?utf-8?B?NkVhNXJRQ2lWTHc4SE9QeWFoWUtwRXk3ZTRFK0hrREpidFRVZjdhYlhrNHp2?=
 =?utf-8?B?SHUyZ3ZDbVo0cXk4MlV1TDhoWHNzU3grRnJtdDYvQWRERFcvTkJ3eWhJL3By?=
 =?utf-8?B?KzFYUjAyQlZlNkt1OHR6bmc5K3pGWW5uYjgxdVlEOFF1c0V2aHZvUjBYL0ZD?=
 =?utf-8?B?Yjgzd2ZiN0xYNEhENW8yT0w1S2ZlRzdUcVl0c0NEemVadG9pMFhVT01lajQx?=
 =?utf-8?B?L2hIVG5HczNnQlp6ci8xaGtEMjhRTUZKTEVpdXBjN2kzNDJZTEx4UmJldUxm?=
 =?utf-8?B?aXJpTnFqL1hTV0pTM1hTOFJzUWtBYUV3QUxPaDM0NTUzSU9ZSksyQzYzQUJ0?=
 =?utf-8?B?ZlprRmdUV0FVWklQSFR3cGRiSmtCUUFhb0NhWDV6TTh3ZjRWaFFXcmUzMUFk?=
 =?utf-8?B?NWpvRkw0ZWpERkN6SGdDajRxQWJBc2szY1dxMFJoZ3RLblZRb0pvNWE0cTJZ?=
 =?utf-8?B?WjVURi9xZFJxT0NoclZ5ajBqajVTL0lXUHp2UkZSYm1OaFFsNngwNkNpSzA3?=
 =?utf-8?B?QWdlQnBydnBjelpUMjRISlIvRk1SSEg3MUhDaDQxQmRhSFBWM2FwWWwyaERa?=
 =?utf-8?B?WTNERGVKZkM3b3JpOHpTUEZUZDAvRkxpNXd5Y09PUVhtRFAxejlPVDRLalQ1?=
 =?utf-8?B?eFozSWZrenRzZjkwQmk4MkVWbjI4YWNmVnNmeUNKMUNoOU1JWlVDM3liR2w0?=
 =?utf-8?B?TDBQcUxIWVY5dFk5ZW1PTk5PRElRMEJZUGlhN1dQa3M4dEcrUDRkRE5tSEF4?=
 =?utf-8?B?MTd1M21QMnhlTERXajBVcUxXVUoxVnFVNUpwSHlHWExVS2oyVmt4MTErR2N6?=
 =?utf-8?B?RGJNalV0clBOcEo2Mjg1KzNKMUs1NkxPYVdiMjdDTEpndENhRzhKeU9lSFFa?=
 =?utf-8?B?bFhIcUhuUWtCdXdpNEVlYllRR1VZUW0yYjVCZXl0L3A4U3JtZGJOVTQ3TkxL?=
 =?utf-8?B?VjRNWW1CWTVQMlRwaTZLRGRUenFjQTMzSUIrcWtBcXBHa3B5Y0RsN1d0QWpC?=
 =?utf-8?B?cS9iak5XckdRakxtR2pHbGQ3eW1JbWNnWi9VUkJpYXo3MFV4Zk5kdWpUQUd6?=
 =?utf-8?B?bnV4Sjd3dnBueWh1T1lvSFhmUGV6YmtCRWZmazRDQ1MyVWw1eFR5NkJhWWky?=
 =?utf-8?B?V1BrRmxEeEpQMW1aNkhxaU93Ym1SWWo2VU5Ib2llSW9qQ01COFpwY1VKUGZy?=
 =?utf-8?B?T2xlUEYwcHFKZWZqeTRzWnZpM0FxZHlPVDhDSllXd3NVcE4xbyt6VVZiQTJO?=
 =?utf-8?B?QnBjSDZHRno5MnJXb3RaRDByaUdrUmNVK1gvK09USmpzN01mVFRGOFRjTm9L?=
 =?utf-8?B?SVduUUUyejJvc1Q4SGphUW0vZmF2NkovSEtaY1pxcm5BMmFRZnlJT2dUd1FD?=
 =?utf-8?B?SDVNaGxuRlN0cGtuNXNOY00xcStWRHhvakdjVTZQSE1jTmNJcVBFOFRJbm5w?=
 =?utf-8?B?WUhTN0xFZ0k3UGJINTJKN1gwREpYSUZ3TzBzVVZqb21tM0xWc2U1Q0RTRXhm?=
 =?utf-8?B?cXhvQkpUSE96R2ZCR0lVdzJia0pZd0xrMEJRSGsrUDE3eVJtSjhuMFVubFRs?=
 =?utf-8?B?R2FiZzRLYnhBVE1UQzNoazF3dEhEY3F2dEFJSkJ3UE41Rlg5WWRaUXZXc2tK?=
 =?utf-8?B?ck52amZNQ3F2cCszc2FtdVJYSkliMnRNcVV5RVdKdkdkeDhYcTV6dm1lS3Fy?=
 =?utf-8?B?TlJoc3RTT3BZWDhGaTNMZ0hLWWQ4NXU2Snl3Qm1XUWJYaGozbHRxTEV6S25t?=
 =?utf-8?B?cTJmcTNlMW5yWGMxN3lGcGdMZG90TTBQeE15eEIxVFl4TkFRVUhNdUZZQ0NC?=
 =?utf-8?B?d3VLOWV1V3lTVUJyVTREeC90cTJCUHFZTEZFYjZ0ZDdiVDJid1hGbjV3c1p4?=
 =?utf-8?Q?9F2lBlu1h4Ezt83u9qJeaYCGL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0f48bb-f972-44d0-b1e0-08dc6abc9a1c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 15:29:05.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLOUWAmh/GnOCYJVrhi6oA/c/9BLbvNmXbz/glSS97lsM8L7FnE6+Ptto2tp7cLScm17LaahToXh6xsxIA8nDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

On 5/2/24 04:35, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:00AM -0500, Tom Lendacky wrote:
>> During early boot phases, check for the presence of an SVSM when running
>> as an SEV-SNP guest.
>>
>> An SVSM is present if not running at VMPL0 and the 64-bit value at offset
>> 0x148 into the secrets page is non-zero. If an SVSM is present, save the
>> SVSM Calling Area address (CAA), located at offset 0x150 into the secrets
>> page, and set the VMPL level of the guest, which should be non-zero, to
>> indicate the presence of an SVSM.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   .../arch/x86/amd-memory-encryption.rst        | 22 ++++++
>>   arch/x86/boot/compressed/sev.c                |  8 +++
>>   arch/x86/include/asm/sev-common.h             |  4 ++
>>   arch/x86/include/asm/sev.h                    | 25 ++++++-
>>   arch/x86/kernel/sev-shared.c                  | 70 +++++++++++++++++++
>>   arch/x86/kernel/sev.c                         |  7 ++
>>   6 files changed, 135 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
>> index 414bc7402ae7..32737718d4a2 100644
>> --- a/Documentation/arch/x86/amd-memory-encryption.rst
>> +++ b/Documentation/arch/x86/amd-memory-encryption.rst
>> @@ -130,4 +130,26 @@ SNP feature support.
>>   
>>   More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
>>   
>> +Secure VM Service Module (SVSM)
>> +===============================
>> +
>> +SNP provides a feature called Virtual Machine Privilege Levels (VMPL). The most
>> +privileged VMPL is 0 with numerically higher numbers having lesser privileges.
>> +More details in AMD64 APM[1] Vol 2: 15.35.7 Virtual Machine Privilege Levels.
>> +
>> +The VMPL feature provides the ability to run software services at a more
>> +privileged level than the guest OS is running at. This provides a secure
> 
> Too many "provides".
> 
>> +environment for services within the guest's SNP environment, while protecting
>> +the service from hypervisor interference. An example of a secure service
>> +would be a virtual TPM (vTPM). Additionally, certain operations require the
>> +guest to be running at VMPL0 in order for them to be performed. For example,
>> +the PVALIDATE instruction is required to be executed at VMPL0.
>> +
>> +When a guest is not running at VMPL0, it needs to communicate with the software
>> +running at VMPL0 to perform privileged operations or to interact with secure
>> +services. This software running at VMPL0 is known as a Secure VM Service Module
>> +(SVSM). Discovery of an SVSM and the API used to communicate with it is
>> +documented in Secure VM Service Module for SEV-SNP Guests[2].
> 
> This paragraph needs to go second, not third.
> 
> Somehow that text is missing "restraint" and is all over the place.
> Lemme try to restructure it:
> 
> "SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
> defines four privilege levels at which guest software can run. The most
> privileged level is 0 and numerically higher numbers have lesser privileges.
> More details in the AMD64 APM[1] Vol 2, section "15.35.7 Virtual Machine
> Privilege Levels", docID: 24593.
> 
> When using that feature, different services can run at different protection
> levels, apart from the guest OS but still within the secure SNP environment.
> They can provide services to the guest, like a vTPM, for example.
> 
> When a guest is not running at VMPL0, it needs to communicate with the software
> running at VMPL0 to perform privileged operations or to interact with secure
> services. An example fur such a privileged operation is PVALIDATE which is
> *required* to be executed at VMPL0.
> 
> In this scenario, the software running at VMPL0 is usually called a Secure VM
> Service Module (SVSM). Discovery of an SVSM and the API used to communicate
> with it is documented in "Secure VM Service Module for SEV-SNP Guests", docID:
> 58019."
> 
> How's that?

Works for me.

> 
>> +
>>   [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>> +[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> Yeah, about those links - they get stale pretty quickly. I think it suffices to
> explain what the document is and what it is called so that one can find it by
> searching the web. See what I did above.
> 
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index 0457a9d7e515..cb771b380a6b 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -12,6 +12,7 @@
>>    */
>>   #include "misc.h"
>>   
>> +#include <linux/mm.h>
> 
> Please do not include a kernel-proper header into the decompresssor.
> Those things are solved by exposing the shared *minimal* functionality
> into

Right, should've known that.

> 
> arch/x86/include/asm/shared/
> 
> There are examples there.
> 
> By the looks of it:
> 
> In file included from arch/x86/boot/compressed/sev.c:130:
> arch/x86/boot/compressed/../../kernel/sev-shared.c: In function ‘setup_svsm_ca’:
> arch/x86/boot/compressed/../../kernel/sev-shared.c:1332:14: warning: implicit declaration of function ‘PAGE_ALIGNED’; did you mean ‘IS_ALIGNED’? [-Wimplicit-function-declaration]
>   1332 |         if (!PAGE_ALIGNED(caa))
>        |              ^~~~~~~~~~~~
>        |              IS_ALIGNED
> 
> it'll need PAGE_ALIGNED and IS_ALIGNED into an arch/x86/include/asm/shared/mm.h
> header.

PAGE_ALIGNED and IS_ALIGNED are from two separate header files (mm.h and 
align.h) which seems like a lot of extra changes for just one check.

Any objection to either adding this define to sev-shared.c on the "else" 
patch of the "#ifndef __BOOT_COMPRESSED" check:

#define PAGE_ALIGNED(x) IS_ALIGNED((x), PAGE_SIZE)

or just changing the above check to:

	if (!IS_ALIGNED(caa, PAGE_SIZE))

> 
>>   #include <asm/bootparam.h>
>>   #include <asm/pgtable_types.h>
>>   #include <asm/sev.h>
> 
> ..
> 
>> +static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>> +{
>> +	struct snp_secrets_page *secrets_page;
>> +	u64 caa;
>> +
>> +	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
>> +
>> +	/*
>> +	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
>> +	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
>> +	 * GHCB page. If the guest is not running at VMPL0, this will fail.
>> +	 *
>> +	 * If the guest is running at VMPL0, it will succeed. Even if that operation
>> +	 * modifies permission bits, it is still ok to do so currently because Linux
>> +	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
>> +	 * permission mask changes are a don't-care.
>> +	 *
>> +	 * Use __pa() since this routine is running identity mapped when called,
>> +	 * both by the decompressor code and the early kernel code.
>> +	 */
> 
> Let's not replicate that comment. Diff ontop:
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index cb771b380a6b..cde1890c8843 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -576,18 +576,7 @@ void sev_enable(struct boot_params *bp)
>   		if (!(get_hv_features() & GHCB_HV_FT_SNP))
>   			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>   
> -		/*
> -		 * Enforce running at VMPL0.
> -		 *
> -		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
> -		 * higher) privilege level. Here, clear the VMPL1 permission mask of the
> -		 * GHCB page. If the guest is not running at VMPL0, this will fail.
> -		 *
> -		 * If the guest is running at VMPL0, it will succeed. Even if that operation
> -		 * modifies permission bits, it is still ok to do so currently because Linux
> -		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> -		 * permission mask changes are a don't-care.
> -		 */
> +		/* Enforce running at VMPL0 - see comment above rmpadjust(). */

Not sure I agree. I'd prefer to keep the comment here because it is 
specific to this rmpadjust() call. See below.

>   		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
>   			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
>   	}
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 350db22e66be..b168403c07be 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -204,6 +204,17 @@ static __always_inline void sev_es_nmi_complete(void)
>   extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
>   extern void sev_enable(struct boot_params *bp);
>   
> +/*
> + * RMPADJUST modifies RMP permissions of a lesser-privileged
> + * (numerically higher) privilege level. If @attrs==0, it will attempt
> + * to clear the VMPL1 permission mask of @vaddr. If the guest is not
> + * running at VMPL0, this will fail.
> + *
> + * If the guest is running at VMPL0, it will succeed. Even if that operation
> + * modifies permission bits, it is still ok to do so currently because Linux
> + * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> + * permission mask changes are a don't-care.

If you want to put a comment here, then it needs to be more generic. The 
attrs value would be 1 if VMPL0 was attempting to clear VMPL1 
permissions. Also, you could be running at VMPL2 and successfully clear 
or set VMPL3 permissions. So this comment doesn't really flow with a 
generic RMPADJUST function.

/*
  * RMPAJDUST modifies the RMP permissions of a lesser-privileged
  * (numerically higher) VMPL. The @attrs option contains the VMPL
  * level to be modified for @vaddr. The operation will succeed only
  * if the guest is running at a higher-privileged (numerically lower)
  * VMPL.
  */

> + */
>   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
>   {
>   	int rc;
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 46ea4e5e118a..9ca54bcf0e99 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -1297,17 +1297,9 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>   	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
>   
>   	/*
> -	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
> -	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
> -	 * GHCB page. If the guest is not running at VMPL0, this will fail.
> -	 *
> -	 * If the guest is running at VMPL0, it will succeed. Even if that operation
> -	 * modifies permission bits, it is still ok to do so currently because Linux
> -	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> -	 * permission mask changes are a don't-care.
> -	 *
> -	 * Use __pa() since this routine is running identity mapped when called,
> -	 * both by the decompressor code and the early kernel code.
> +	 * See comment above rmpadjust() for details. Use __pa() since
> +	 * this routine is running identity mapped when called both by
> +	 * the decompressor code and the early kernel code.
>   	 */
>   	if (!rmpadjust((unsigned long)__pa(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
>   		return;
> 
>> +	if (!rmpadjust((unsigned long)__pa(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
>> +		return;
>> +
>> +	/*
>> +	 * Not running at VMPL0, ensure everything has been properly supplied
>> +	 * for running under an SVSM.
>> +	 */
>> +	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
>> +
>> +	secrets_page = (struct snp_secrets_page *)cc_info->secrets_phys;
>> +	if (!secrets_page->svsm_size)
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
>> +
>> +	if (!secrets_page->svsm_guest_vmpl)
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
> 
> 0x15C	1 byte	SVSM_GUEST_VMPL		Indicates the VMPL at which the guest is executing.
> 
> Do I understand it correctly that this contains the VMPL of the guest and  the
> SVSM is running below it?

Right, the SVSM is supposed to place the VMPL level that it starts the 
guest at in this location.

> 
> IOW, SVSM should be at VMPL0 and the guest should be a at a level determined by
> that value and it cannot be 0.

Right. Not sure about the "cannot", more like "must not." The 
specification states that the guest should run at a VMPL other than 0. 
If an SVSM starts the guest at VMPL0, then the SVSM would not be 
protected from guest.

Thanks,
Tom

> 
> Just making sure I'm reading it right.
> 
> Thx.
> 

