Return-Path: <linux-kernel+bounces-119078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7688C3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF511F3FE63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6F83A05;
	Tue, 26 Mar 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2KTQQxba"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07782C96;
	Tue, 26 Mar 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460511; cv=fail; b=RlkKvQh27EgQ1G/zJ9MfRR6la30fbcSAMnvnjrZkcmSxe992N8Hkcr5697Fp7fz5nAmPqKZy2r5v1J5VrbvASJFeIvBU4TpWFOEvzfLppPQ1SiNTsFr27AogwT40s+w0DapbpU2/VoZSHmPCDNUn+/TaUY2YydBFYaazBavfnDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460511; c=relaxed/simple;
	bh=y813hl2OHanPWAfdfMDyvUiniMLghaGlppW+nYHIrSM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9JUl5hgscCv7xdvAZsx4NQ9qtPQVTzZmPFdbI88EKfkgCzAXO/dYZ34/fwF7X/DDqCVoHLFD9szPuMHq4zOiFIrGuykVAsG+as8JHz6mT6GFKQfKFUmgp4AeTsXiu8fI5FnaEn6uTNbCl+9ZAkHEv+EWphDKEPdH5lG0Av3YmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2KTQQxba; arc=fail smtp.client-ip=40.107.94.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmm5UCRcsZnPzQ/m5DGhrNFHdc3/HOzF8U4MQ0fTk/tjAgTv2eQVKDb9TfiNlqgsJStFBM+qITqPONFLI7OeJkLRu+1El4ANiH9KUCieGiSmlPhXDSHh9BXcqaLAT9g+sVurdb4ObiBgInZtbuDRlCu+tPTT6sJo7cCruHc6iFXhF2Vi/7CN6FQftZqSlOrtyEvSpQneGGK1Gz8BnN6EqDPdob7jZGH86q2Fm1YwvhC4PUHeE/0yo27kbTxlLPDBPUVTI4lgYzvF3oYBVJ8M7TKGbxwRBKBJbKHsZbdOojaB/HP3meUvNLHzyMUAjgutii2U5p7uzrpvbtqnAw9/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFzbL2QfGqplRna6KT7mIHPNXZoZR6jyLg3y5EhXz/U=;
 b=M8yuqqCLlv937jwfxSbxEZHGwQIyf+iKqJ1jlOd0gyDhZS+uppRSyKMbUr6J1Cq/itEhfExphuzeTj+Q6yHkWw6O9SPBmySamaJ1Uaun+WvL6ZuGy8toJmAK304hYYF6D2/E5m6kZv6lcmk/vbq+TqVzzaHINws81hjqi9XQo+Up/JBi6BNz2PTw2yfgwHV/r9vtuZIhz8t8UuMLoF0ZBKZWTuvABvR3HfRUUqG3BmzbvuocW5UO3Ar4vNR570IRWlO6YnOOKgMlP5PhCcMEFiaWmk4oAYu4FHIONxtDrVrLaigku3itC6H8IiGZd4iA1AueyBPWbdM+Swoc92yXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFzbL2QfGqplRna6KT7mIHPNXZoZR6jyLg3y5EhXz/U=;
 b=2KTQQxbaR6xNhCPN49wkKU1TuFJHgzG66kBpa/6oboQN0MZM/5cCaB+7GJOW63yZ7AuVamJWveupFN2fbdoaqz5f9Gr92JBEJ+xTbpWjvYBSl1DIcwZCRZKSU4SdR5aw4vA/zBxHPqA7bqH2k2DIk3vg5Gve+nUSK7h2MMFiA/s=
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 13:41:46 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 13:41:45 +0000
Message-ID: <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
Date: Tue, 26 Mar 2024 09:41:41 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, LKML <linux-kernel@vger.kernel.org>,
 "anthony s . k ." <akira.2020@protonmail.com>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
To: Borislav Petkov <bp@alien8.de>, linux-edac <linux-edac@vger.kernel.org>
References: <20240325183755.776-1-bp@alien8.de>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240325183755.776-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|DS0PR12MB9400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kmD9vqrmKWiX4eXz9daFwgFSjGlws1CtQ2P89BFVnLpfCKZw8Jp8AivBosPxYj+niUgvNbyYDvIbW0TKCJWj7t/bEN3eI6hFHPnMMEDMkM2fIhR2XW1IU0qqHwd62RBK2Z05V1ck8suJN06tI4bCJ2WPREiHD/cZIenkSkWjClkD7QHyqiLAwzvD5etnzLgVjopmkC/h4vJDvSBlWJs5utsVoTxog+WBM4Tog4xg2Q+9/mvTuRNrepiqM6UuUPlJq9wzKcWAlv4//g2wCp33lDfEk12wf2aed+t64lu97Z5WbzP47heLta/4qEbiTPhjo61HVp7lC79hnzadrH1wu0psIMTy7uUXajGxEs/4+QBXeZR8V5Ll+TxlZYBrM/97ipS3c3YQ7S8mYUfadkycUQx4XqkU0qBfnn9A4uVqt4H/Vf/ZbG5vq5ZrdbCTJa5WCxZESk6asNNHa7S5kqWYzH4uLYyTtYGw1Wh4az37QvU4vt5pmaLTkCLBGn0vkWr5kGS9JzRCwERCRxtDKmSgvyX/cTnJ+v3RzUn4S0Cc5BpbvD3ZuPbbD8niMrn4Wg+NxFbDgvynIJjZBytcBf+I631Mn440jRFx9BApHWEtSaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3AzWUd4YWFQQWlKV3YxTmQyUnZJaHVHaGpnV1VkY0FxYlB4cDU4alJiRDR0?=
 =?utf-8?B?VEljWlRsbXZwUUlTeFFPNTBXeEVNVGl6S2JaUDhXU3l4dStjdlhQdTcwL1NS?=
 =?utf-8?B?ZjEvdlgxbmJxaEZoWHp4ZW9OdVE5dEtnWjFtd0NUaUR0d3kzaHNDUFg2aEF0?=
 =?utf-8?B?SHFPajdWWi9BcFI3Tm9TY2plNUtDMlphTG9NWERpdndtMHM5eUNEVllGeHR1?=
 =?utf-8?B?Q1Yyc2t6NXZoTndwM1JoWEhicnpTZTdrZ01hSXpvdDBDdmpUd1B2R1R2OHR0?=
 =?utf-8?B?enV3clFSOW5CT1NlTHROSFp3OGpvclMrbCs3MmdKL1NlVDVaWjZWUE9IVmsr?=
 =?utf-8?B?RkMyYnE3RHFFRE80d3VmMlhwVW5PclNjOGc2WElwbWtmUmFLSXFKZUpURGlE?=
 =?utf-8?B?TlEwWS84VHZuZDVranU1QlZwVUcxZDJBeGpmWVFxWE42QUJKd3VMZ3k4ZkVS?=
 =?utf-8?B?bFdVWEo3Ui9SdGk2VER0ZUFvL2ZMcTcrd05ueGdPeEYxMHFCYmlCdkM2Ujhu?=
 =?utf-8?B?NDlCWFNVSWVGR2hnckFMaFRIbk0zNUJ2bEE3dCtHRDVuMlJGTEN4V3VHSWdi?=
 =?utf-8?B?cHFzTE1hN0U2VjU4QmpMYzNQZUQ2RFFuTWw1b2NiV21ROWMvaDRPTDdxaGcx?=
 =?utf-8?B?UkJIMXJpa3Y5cHNWUzd5aURuUG5CejE4RXZqR2p6cWpZK2U2N0ZDa253WEh5?=
 =?utf-8?B?TlZtUmdHU09tcHNqM1pDY2kwSlhSaThVb2VMQkpMWWwvSDNDUVZDZmJhQ0th?=
 =?utf-8?B?ZE5UK3h2aE9WcWtDdzUxSi9TWFpKVC9KTkVPd0hKL2ZlU2ZFa3B1QWkyQUhQ?=
 =?utf-8?B?bDhucytXNVRSK2RVZzBoeFFXV0pTc2JPTnVvTU5WREVEZkNBRUNmTEovL2lp?=
 =?utf-8?B?MFRXQXdCVGdlOUEvWHFhTHJYdyt0dUtJREZtdzBLR2hkTFZuZU9zUGpqZmpS?=
 =?utf-8?B?Qml6WGZoUzFuejN5MWN4ZGdhSnh6YXdTMTdDM3dZRWdsMFVZSStWZFl6dENZ?=
 =?utf-8?B?dVRMRzZuTU9yMjBYdG1HMWxkK1ViS2cyRXhlSG9RdGRYai9BbnB5TGZmQW9n?=
 =?utf-8?B?LzFqNG9sUjZTZ1V5Q1JDOHFjbmNNZzR1WUNRSFc1U0xDL21ERndFaHl3RWNk?=
 =?utf-8?B?dlZzdU55NEJkYmlaL01NeXBDSlA3aVVTYmpXQjBYMUJZL3E3enZzR0IyQWFC?=
 =?utf-8?B?RnFZdnJJSElUSnVuclFzclAvK1NuWVJ2ZU9BNTJUWEVNQUlUbmlJV1ZUYVN2?=
 =?utf-8?B?K3ZYZGY4LzhnZVVqTnR5YXZSVzdZVndRSFNRYjVSRzRKcUNBMnUvZGVIaUFO?=
 =?utf-8?B?QTBFOWxTL1MyQUxnV3Z1MCt6cWFlbEFYMGZrVk8xOWkxQkZ1V0h1TFdZVC92?=
 =?utf-8?B?L3NhbkdOZDhHeERxUkc1Yi93emV2bE1lR0hrMTNQMmN1TnVCWjZIRHo4VGIr?=
 =?utf-8?B?WUhjOU5EdTNwbHg4VytldVJPcTBXckViWXA3QmtmdzAzU2hLSjBXRncveE5t?=
 =?utf-8?B?aFowaWZ0RkEvd2hmdHhTbXZCOW8xVFhSVTdqTVdqam1KWHVrN3o3YWVVYVJu?=
 =?utf-8?B?U3JBMVVsdlZmVS9PL3NGZkJtbXZCZWplT0lYMk1DVjZZQTdhdmptVFpiemps?=
 =?utf-8?B?Vy9JWEI3Skx1enJXbVJqaHAvNFpNTTVya3duQzlxZzRmVVZnT2Q2UVNVUmdx?=
 =?utf-8?B?bXZyL1g4VHhzRGFoR3RaSHV1SUxOKzlYZFAxbG84Q1daMkMydmtCSERicWxF?=
 =?utf-8?B?NThwZnlzWHZWTFVRaXFvM1R1ME9qTWE0eTdzT08vcW8xS21HeU9ZeitmeDJK?=
 =?utf-8?B?N2txd0loY1ZYam9JWm9CbFk0SSswMnhSQ24zODIvRVRETWhIQzE3TjNZdjgx?=
 =?utf-8?B?S1plZUlnRmYydlBpT0hCbGJvZWxYdmt3U2VyNHFxend3ODBnYkFSOG13Y1FC?=
 =?utf-8?B?ZlB4eEhnUDVsVVlabFlmcW1tdEZrV1Aya04wTHlBZ0FYWGFJN3FIVjdDVnBD?=
 =?utf-8?B?clFXWWtuUEQ0angvWUVKRitGenlCRE5oWHZwUU9IWUdXSktIeWg1Y3o5VkFN?=
 =?utf-8?B?Y1E0Rnl2RDA1bFB0eWNMM1FEM2xsWEcvdUt5dWJ0R0FjZnlGUFBpamZKRVhQ?=
 =?utf-8?Q?oiTKq7moUZxt3x5a20nemysLq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddef6c6f-04ec-4d15-ce1e-08dc4d9a7a67
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 13:41:45.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPtClsGl+Rv3PXP2qm5e/ZOQ96NzGNHE5sTD86yncYVF84U9nFZIgkeLn5QFyg1YZ14xMG/gBs8mR8Sr+L3e0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400


On 3/25/24 14:37, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Have the driver depend on DEBUG_FS as it is useless without it.

This isn't true which is why the module doesn't fail to load if debugfs
is not available.

> 
> Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218640
> Reported-by: anthony s.k. <akira.2020@protonmail.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>   drivers/ras/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..41697e326fa6 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -37,7 +37,7 @@ source "drivers/ras/amd/atl/Kconfig"
>   config RAS_FMPM
>   	tristate "FRU Memory Poison Manager"
>   	default m
> -	depends on AMD_ATL && ACPI_APEI
> +	depends on AMD_ATL && ACPI_APEI && DEBUG_FS

This was my first thought too. However, besides not true as stated
above, this also leaves the issue open for others to hit.

I think the fix below (not tested) would be more appropriate.

What do you think?

Thanks,
Yazen

diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
index 4749ccdeeba1..ab95831e7710 100644
--- a/drivers/ras/debugfs.h
+++ b/drivers/ras/debugfs.h
@@ -4,6 +4,10 @@

  #include <linux/debugfs.h>

+#if IS_ENABLED(DEBUG_FS)
  struct dentry *ras_get_debugfs_root(void);
+#else
+static inline struct dentry *ras_get_debugfs_root(void) { return NULL; }
+#endif /* DEBUG_FS */

  #endif /* __RAS_DEBUGFS_H__ */

