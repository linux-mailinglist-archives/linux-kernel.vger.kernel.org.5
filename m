Return-Path: <linux-kernel+bounces-37210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41283AC98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4BC1F258B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE111E868;
	Wed, 24 Jan 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CDYLMeGa"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E015B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108319; cv=fail; b=rSM3rZ/ha1vp+SoVHx71y1GzepfnOUq6ifQ8wOqeQL/00qE0z1TcEhiML4hfNDicqzEuhnWhfJGwuKACfq5HV4Mg2p8GtmapMymTvdZjGsaOXBQxSEJAOqP1Z1xkZcLKZRW+sCi6SzcNh7SY3Cs70nutU6a0IOgSYumTxvFESiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108319; c=relaxed/simple;
	bh=66HTsv3jh0J5OmT4KcXpavd+SRnpBE00tmdsvk5UklA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnrFReTgin7E6fuVX7oi1XcL1k20xZaJl47ARroj7hhNi94u+zQ9wdG2LusKPF69cClSloFHhy3j28sYqeuxZu1mAH4cStTH8z9cXWd+HSCoB4OV3s6ID0UOtQAKSV0jkauFKqthUax7yZLCYUElCbaFRlrCT/XPVYf5X8bkx9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CDYLMeGa; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXRXDvuLSWTXi4r2J1mflSNAA3EGFMk/5/GC4MoIiasGo6KmjDLsXljZwGxwdVz1uV0lFtY+m1m9wfuQ3iVbFPltk+qdOA/yHp8jdTU1yPbXflKCBil0sHQRwsZOaOytkBmzTh5ZhsRf8iL08y2Qhh3BqvOgT2+S32QwapEdR6lHZkuavYV29vo8gM7whY98MYo7CVwF4O9a6IgK7nwyecav9kTvERf7hCJiVe1UyDizUki2Lgjvp83S83I/7QQoL3gSqJAHt+ToVbUk0XZ5yp4nVwM6B4bqeQvEAXGAKO02nKX/O86m2mcN/CGxlvO0kNhIzULCztqx60E6OtBgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO2o5mKbxG1SS9vSgioM14q0EkAEnnJbWPTiDt47KCw=;
 b=fNBo1oSoAJmmLAbuX4A9EiDAx+TcXArvknbQ+7o9OA8tmiLYqush+LtIB94hVEFO9tP+eYNxjGaK69Ii5XtZgkxbx+NCEdblCxhMtCvRNi5rB/PBpl39effuPxKKGcu0PhqhDqgCgerT7TiP/lRa36wWmqAnQ4en9yDXy9vkKpV0oZqisA9xQs8YRcOtxjLCV+0Za/HAehNjQ0n99Gx+kceTKk9tK1dDD4ENeFAFDCLFQzVZCAEhkfQHiVcEwDqk+O7dRaBHF8DnQQ4iDhIdECtmvRbP2tZaCwbtS146hO++iv1m7RUIqjyyNyGoxmmWmyMNROOHT4vjy8/mTfNYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO2o5mKbxG1SS9vSgioM14q0EkAEnnJbWPTiDt47KCw=;
 b=CDYLMeGawPYPET0uPk90c2GLCYi9R+Goh2kwhupLjCYRhSyBayh0GTohaqaFEgpMDTmdr0rvCCLsSBLRrb1IfT/chOmCJ6lTNFQ+nTJSdm8vIVRs2B1PXrjEuOvh/nzWGQAfBUBPamgItSarZCG1RI+MUEjYHPsjkRqw9KlUWRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5370.namprd12.prod.outlook.com (2603:10b6:610:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 14:58:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:58:30 +0000
Message-ID: <0578da80-db4c-4c0b-8677-2875a65afd68@amd.com>
Date: Wed, 24 Jan 2024 08:58:27 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [tip:x86/cache 3/3]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret".
 Return " 0" on line 1655
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <20240124105555.GBZbDsu-zsQ8YTgXjS@fat_crate.local>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240124105555.GBZbDsu-zsQ8YTgXjS@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0147.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 81440382-91d1-4d8c-b284-08dc1ceced60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5brWnDYzQXgaW54ZPfyTD9T5pN+4MSEIOYcEWh1jphONR7E7xweUUpMm3HwDvF5JV6/jzq9nOlHCjQk031ccEdy/uFTeUWnJ1jCUIDULQgXe/KWA0zvylS/Bq8NbVaTg2fSMwrk+oxKhqIJf3O3FpfQhROyLIBmSXBtm5eD7MO2u3ELoNQrR49i5Jm+QOuuKL0CqmMDqTSKhYbCF/+QdGPFv58zAF1RA+RMwls3QeHLpVlPGkOm4idWEGyPeg74VUE4QB5JtX5vCkWOaLXSa7OJkcGUaOt0PgY67oUzITp0jbb2tSn6E7BF5HJy3ZSiyW8gGDg8QpvMGY+z3yUtGXqghrYVvb7rWOsQcI9Z43voX2V4kolCL8sapHPUBqlB4hnrMKTe2MMxFfU5EsNsbye1+VmQl8TC3ACC7/JP7mUjqRgWQpikg9zg9ArrcdNvEiwhuwZ02cjc+y6P9NI3p2CdMgDjnH6OG0XUrvJG5q5pegXRImtFIN8j5CC8ju5APWQFeZ97SqjeEYN0J6Xnu0M9m5n9FbCX7pAgD8KvAfvlh1hZ7eaSG2CNR9SAPjIYD2+s3AmH/4NvJt0cdz4FYIHdadEXEueUPVwQorR54Wga6GNl/OUEUa9FoTEYR44ZJmccEZlAEQFcvrVTH1uQAIDpaXPZk5sHT/+/VH2IuwVc/+CLVzt00aNgijjp+JqbUMfn6q6PGCyzENbMZkuDtlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8676002)(8936002)(4326008)(54906003)(3450700001)(2906002)(110136005)(6486002)(966005)(316002)(31696002)(5660300002)(86362001)(66476007)(66946007)(66556008)(36756003)(38100700002)(478600001)(2616005)(6512007)(6506007)(53546011)(6666004)(83380400001)(41300700001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bklYK2VQRjZZZ2Q0VktyaXFRVHJrVnhVNjlhcCs5bGRHMnFUWFpzT21hazY3?=
 =?utf-8?B?U25xSzFUZ2c1UWhMalZ6dmNhTFhUczVtdmlUaTF2UUh4b3BWRDNxeE5wMkRn?=
 =?utf-8?B?WU5rMGpycEVYVnUvdFN5YWd5bHNZMVhsY0FSKzVhcXJRYWc5R0NjRG1iZTNT?=
 =?utf-8?B?aUc3R01Oa3pwbmNmZHNEa0VOMlQwa096SmlBMi9EcktmY0ovODN3dkJJRWM4?=
 =?utf-8?B?R204Z01BNzJPVWJNbmFoK25zR0JmazJHZEpCUUVjRnBnSXVuTFRWblE3eFVz?=
 =?utf-8?B?NEtQWUZlWUw2LzBHYXlwcWsxZzJDUVdhbGlXMzl1L3RmcEdhQ21PenFyaGhM?=
 =?utf-8?B?NHZSWnZhUWpzSk9GdW9wRk40U1NzRXZxd2RIYmlmTlkxbzVYNFVNY1E0V0JN?=
 =?utf-8?B?TUN4eUY3THpZVVB5c3R0WWNCU1RoeFR5L2xwem1UVEtDcDNaSVlZbG8zUjYy?=
 =?utf-8?B?MDVZTDZ1Yi9hQ2NHNENTTWl6dis0c204VTBuSTVEQmZWVHU5UngrT0dtejRM?=
 =?utf-8?B?Ty9ITlRyOHA4V2NMN0ZCZjBwdjdBNmc1MStnSHdEb0ZwS2ZSYStZT0JyaGFl?=
 =?utf-8?B?U1owWExnVDVuOTRCamtReHNhS0tpOHpBMTRqY0lwV0oxcnpleTc4ak9YNUxX?=
 =?utf-8?B?VStvMWEyYy9WbzVza1B3SmlHSllTTU9USW1PcDdmS29VUnhTTkordHhmdUQ0?=
 =?utf-8?B?WHE2UlVGZUtEMDE2T1VCTnE2bXVhd1VPNVg2K1N2dHR6ZGtKS2J5QkRDQkMw?=
 =?utf-8?B?V25nN2VXY1M0b0VYSW95VnN3bXczaDNZVE94MTg5c3pQTUU1Q3NqeGJpRnpF?=
 =?utf-8?B?TVFOdnEzVFhOZGc2ZVRUZWZMM1EzYzUzWFJGakVXZXJia1YwR2Q3QUtNRDVi?=
 =?utf-8?B?TGlUY3FzK1FFczJ4clVUVkFPbHJMcERmRWhJTFpnZmlKQlpsRFFpYWswdGFx?=
 =?utf-8?B?L3hyMVRKMFRxVUNrTnFkQWpNRXloZ0VXUlVac0R0NGF0YUg2T3Z5SkdMVXIv?=
 =?utf-8?B?UGdGeGRqa1FPUWZlcndNSjlKOURCM1Z1eXlOWWR1UDYxYTQ5ZDdiK3RkRnpu?=
 =?utf-8?B?RVpCZlhYTlBaZDlZL2pNbW1HM1YrMHNuaEhBRDZqbWZ4ZjExeHlJVFdqSUI1?=
 =?utf-8?B?TVljVmxWTVp3MGtEbUVFT3R3ZE9TZldCRnpYdkVPVkZZSzJ5dUgzTjVaL3k0?=
 =?utf-8?B?V2wwMDV0N0tWZlBzNTlLZDZ5SmJERDVocGk5Zk1QVUFPekhzU2d3ckx5Zk1M?=
 =?utf-8?B?b1FiS1lyR1UrZ2xUT25LUi90eTAvanNBMFB2NEU5YnNLRnhJZ2tIWkxyVDhZ?=
 =?utf-8?B?WjhvR2xHN1MzRldhc0VKRTlnSVFBSnh0OWN5NWM0emNVNFg4NjlrVDRVNzJP?=
 =?utf-8?B?SFpUZFZvWHhlcWswWFJkU3pNS3hpSG1BWFBWNnlsbDBoOEduL2tiVW1vL2Fr?=
 =?utf-8?B?WEszM1RacFBUQktabGNObnl0WTNBc20vcjhOZjZvL1FTZnZ3MGlpdHc4M3M5?=
 =?utf-8?B?NXZlU3psVXgzMVEreHdtWDhucThCMmp0ZGc2ejZUQXV1cTJta09ZRXFJU2Zp?=
 =?utf-8?B?ak1uUUx4djdoWDZmQ2hXenRPWHF4RzI0d1FqaSs1SUVSZzQ2cTROKzRseXo0?=
 =?utf-8?B?eGNpOGVNTk9sb1M5UU8xWVJCc2dvSDdveDFwLzR1TmNUenZmbzlMQW5VL25j?=
 =?utf-8?B?ckQvczNBT1hsN3hFdFdjVVBiNk9lN3gzcHNNMFd3YVpBR1hab1FqcitUUlht?=
 =?utf-8?B?MVRXRG50ekRiQlM2OFhNaFFyempIVzAxd1VKbnBJbUtzQlk4YmFnK2hualZS?=
 =?utf-8?B?aUNMVFI0eVVTS0dtRnhmNS9yRzI1dDJ4aUo1djliNGNLSTFDM1BpOCtXLzdq?=
 =?utf-8?B?aFc5dDJicUR0WjB2OS9EMDBwUWtqTWI2UVdvck9WSkNaT3VnZi9PU3ZNK2JN?=
 =?utf-8?B?RDhKcUpMTFZwUzVvZDNoc3I2WitDS0wrRWlETVpoc1dSY0VQQzZ6YUN2S2Y5?=
 =?utf-8?B?aUkyelhGUjBCckl4RWFOUmhuSWZsVVJvV3JDRTA3elFRY1ArLzNwaGsxaVQ5?=
 =?utf-8?B?bkQrSlRoUnRhdCtMWjFrRWdEZ0ZFejFNUGtJZ1hQSFZVN2taNlAvWTFVUU42?=
 =?utf-8?Q?Ji/o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81440382-91d1-4d8c-b284-08dc1ceced60
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:58:30.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeOruuOfcrvmZ3bXffDlLO8+abOCAgpptl9A9ULm046FzZTxRJbWnfApmACclzA1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370

Hi Boris,

On 1/24/24 04:55, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 06:31:41PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
>> head:   54e35eb8611cce5550d3d7689679b1a91c864f28
>> commit: 54e35eb8611cce5550d3d7689679b1a91c864f28 [3/3] x86/resctrl: Read supported bandwidth sources from CPUID
>> config: x86_64-randconfig-102-20240124 (https://download.01.org/0day-ci/archive/20240124/202401241810.jbd8Ipa1-lkp@intel.com/config)
>> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
>>
>> cocci warnings: (new ones prefixed by >>)
>>>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655

Hmm Interesting..

Looking at the code, I see the ret variable is really not required.

The following patch should fix the problem. Let me know if you want me to
send the patch officially. Thanks

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2b69e560b05f..6057f96df73f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1618,7 +1618,6 @@ static int mbm_config_write_domain(struct
rdt_resource *r,
                                   struct rdt_domain *d, u32 evtid, u32 val)
 {
        struct mon_config_info mon_info = {0};
-       int ret = 0;

        /*
         * Read the current config value first. If both are the same then
@@ -1652,7 +1651,7 @@ static int mbm_config_write_domain(struct
rdt_resource *r,
        resctrl_arch_reset_rmid_all(r, d);

 out:
-       return ret;
+       return 0;
 }

 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)

> 
> Well, AFAICT, even with the tree checked out at
> 
> 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> 
> which is the first patch that added this function, ret is unneeded.
> 
> But scripts/coccinelle/misc/returnvar.cocci doesn't warn about it then,
> only now that that hunk with the "return -EINVAL;" is removed in the
> patch you're reporting this against.
> 
> Lemme add some cocci people to Cc for comment and leave the rest for
> reference.
> 
> Thx.
> 
>> vim +1621 arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>
>> 92bd5a1390335b Babu Moger 2023-01-13  1616  
>> 92bd5a1390335b Babu Moger 2023-01-13  1617  static int mbm_config_write_domain(struct rdt_resource *r,
>> 92bd5a1390335b Babu Moger 2023-01-13  1618  				   struct rdt_domain *d, u32 evtid, u32 val)
>> 92bd5a1390335b Babu Moger 2023-01-13  1619  {
>> 92bd5a1390335b Babu Moger 2023-01-13  1620  	struct mon_config_info mon_info = {0};
>> 92bd5a1390335b Babu Moger 2023-01-13 @1621  	int ret = 0;
>> 92bd5a1390335b Babu Moger 2023-01-13  1622  
>> 92bd5a1390335b Babu Moger 2023-01-13  1623  	/*
>> 92bd5a1390335b Babu Moger 2023-01-13  1624  	 * Read the current config value first. If both are the same then
>> 92bd5a1390335b Babu Moger 2023-01-13  1625  	 * no need to write it again.
>> 92bd5a1390335b Babu Moger 2023-01-13  1626  	 */
>> 92bd5a1390335b Babu Moger 2023-01-13  1627  	mon_info.evtid = evtid;
>> 92bd5a1390335b Babu Moger 2023-01-13  1628  	mondata_config_read(d, &mon_info);
>> 92bd5a1390335b Babu Moger 2023-01-13  1629  	if (mon_info.mon_config == val)
>> 92bd5a1390335b Babu Moger 2023-01-13  1630  		goto out;
>> 92bd5a1390335b Babu Moger 2023-01-13  1631  
>> 92bd5a1390335b Babu Moger 2023-01-13  1632  	mon_info.mon_config = val;
>> 92bd5a1390335b Babu Moger 2023-01-13  1633  
>> 92bd5a1390335b Babu Moger 2023-01-13  1634  	/*
>> 92bd5a1390335b Babu Moger 2023-01-13  1635  	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
>> 92bd5a1390335b Babu Moger 2023-01-13  1636  	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
>> 92bd5a1390335b Babu Moger 2023-01-13  1637  	 * are scoped at the domain level. Writing any of these MSRs
>> 92bd5a1390335b Babu Moger 2023-01-13  1638  	 * on one CPU is observed by all the CPUs in the domain.
>> 92bd5a1390335b Babu Moger 2023-01-13  1639  	 */
>> 92bd5a1390335b Babu Moger 2023-01-13  1640  	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
>> 92bd5a1390335b Babu Moger 2023-01-13  1641  			      &mon_info, 1);
>> 92bd5a1390335b Babu Moger 2023-01-13  1642  
>> 92bd5a1390335b Babu Moger 2023-01-13  1643  	/*
>> 92bd5a1390335b Babu Moger 2023-01-13  1644  	 * When an Event Configuration is changed, the bandwidth counters
>> 92bd5a1390335b Babu Moger 2023-01-13  1645  	 * for all RMIDs and Events will be cleared by the hardware. The
>> 92bd5a1390335b Babu Moger 2023-01-13  1646  	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>> 92bd5a1390335b Babu Moger 2023-01-13  1647  	 * every RMID on the next read to any event for every RMID.
>> 92bd5a1390335b Babu Moger 2023-01-13  1648  	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>> 92bd5a1390335b Babu Moger 2023-01-13  1649  	 * cleared while it is tracked by the hardware. Clear the
>> 92bd5a1390335b Babu Moger 2023-01-13  1650  	 * mbm_local and mbm_total counts for all the RMIDs.
>> 92bd5a1390335b Babu Moger 2023-01-13  1651  	 */
>> 92bd5a1390335b Babu Moger 2023-01-13  1652  	resctrl_arch_reset_rmid_all(r, d);
>> 92bd5a1390335b Babu Moger 2023-01-13  1653  
>> 92bd5a1390335b Babu Moger 2023-01-13  1654  out:
>> 92bd5a1390335b Babu Moger 2023-01-13 @1655  	return ret;
>> 92bd5a1390335b Babu Moger 2023-01-13  1656  }
>> 92bd5a1390335b Babu Moger 2023-01-13  1657  
>>
>> :::::: The code at line 1621 was first introduced by commit
>> :::::: 92bd5a1390335bb3cc76bdf1b4356edbc94d408d x86/resctrl: Add interface to write mbm_total_bytes_config
>>
>> :::::: TO: Babu Moger <babu.moger@amd.com>
>> :::::: CC: Borislav Petkov (AMD) <bp@alien8.de>
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> 

-- 
Thanks
Babu Moger

