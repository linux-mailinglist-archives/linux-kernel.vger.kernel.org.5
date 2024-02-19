Return-Path: <linux-kernel+bounces-70706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50715859B60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E201F2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D979BA42;
	Mon, 19 Feb 2024 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="knXFs2m0"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A42B64B;
	Mon, 19 Feb 2024 04:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316622; cv=fail; b=GX4CIighFZ5o1MNRfHhQCnb6s4RAxF74aphQ6wmQ7e0DgPBS6cTt4cEh1ZX6UYMZE/7fkSl7lPWJ/wv3jeo4kg90mJAgPtFXvfUQ6u35+8WdHki375scrbeF2Me9UwbRzkaNwEZp1xD0ZtFmlpJN9R6hxEytoRZoHGUAJsDypFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316622; c=relaxed/simple;
	bh=QXo2qE+puA7VgyoQtWpO70idlsz8MxVwbc7iKqAugDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OrQkjzHlNqIj7Za+RR5FtufrsU1bVqCvrnvjVM2qxUvrh6qIbrlgOQHjGJnlYSDoiRazLVQdeOxSLQskZFqS9WeVCw9ibLcs2qCVm9GoBLX+bnDpnc4Ur9TLDdXY1IuEtCBYzEtHJXCGqoaqdWEgAavPkilhN3hBEganHxG0YbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=knXFs2m0; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSuG9/19b+IDdKc93Srce3r/HfG//Agh27Wtg9LAovl1doFjyvLrLQU50qhyXVhQFxSfSignAZXhjxFHbn20bI4nHe5GPJ6hT6aZS2ntqpgCq9MoY5IrNRIf5rUiWF7bE1uzgiZ6vU9TvPg/BiOWkIApFg+dO3Zi9Ny/OvcDZf3rUi1VpGCAOzuCg5p6JfCTJEdwRetLvtOm6Ek6ayicGiLjdnIQUeD2Ln07zXj903t93Da/pOWA7strFzv7IEMgwLwxlcCFwixhxD/VLJ0RbkY5fLdriCU4vlWHpo0FthGaa5c5+fFtCRcoXQFEAPiuNArhSwQTrxndc8j9AfDRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmussR1dNdhSEu7q8W6QGNLBqiSQvpfEXadRTCvpAw4=;
 b=Vh4EtwrGhyHL2cXc5CkfG6P1+gl6FH8FIHkgH8qzPBY8DLSdtHvu94ubH7tX2k7SaLRRROgOWasp2ykq9JN02CCMb+pSyDbG9M1/ZMTPbGDCl+jj+/DZ5gAHnz8yE6gOJwJdKHLCDHzcbSUTgMWJlurEmcMDzgOP7hmqFVBcNpB0GkmgZZxHodcHJIE8+UJyDRIdDf5juE388hsVDNRbFt2wedSCMMKjgYr/AlRX300yRJuNgvIf5TR5lQyntizq0Bv8JBjS35oRAb66WWL4LTBLBLXKoJs+/1qP4U35ZBXlgl6NrvCI/YP+38SrkRDaRP1SzdJT6U22GIXUv9jKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmussR1dNdhSEu7q8W6QGNLBqiSQvpfEXadRTCvpAw4=;
 b=knXFs2m0dW02XklQ7LbtAq+e4pCbzAy9op5vxXusXNgfg9Iuwk3IEZq4lqU/s0Go1Vmk4DyXXv+rTL2Ptk+9CKjAjZ7uFF1jpBrxArB4065f9BQDTRMsAeZYFibS4mo0sXHNSYxkiTKSaYJ2T1g2JdgMdUDtipeHiHWkDYlNMU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 04:23:37 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::3476:df27:437c:12b8]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::3476:df27:437c:12b8%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 04:23:37 +0000
Message-ID: <7a34f233-7de6-4e3e-bf16-4cbd8dd22a6a@amd.com>
Date: Mon, 19 Feb 2024 09:53:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Trolli Schmittlauch <t.schmittlauch@orlives.de>
References: <20240217005216.113408-1-mario.limonciello@amd.com>
 <f6cced34-087a-4593-b510-a8a728deab97@redhat.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <f6cced34-087a-4593-b510-a8a728deab97@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8775bb05-2010-47b0-8371-08dc31028b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fNKDD8qvucgSxKZnx0WjmvdXomh/eSArIJAkAacU66ltl7B9rmX12csmFDh56LTTbK8rexdLr/Mm8KLGfOLSIh/UTSawZWwO+sX51T7zA1xPuM2d6k8qZRvUJjm8ohJQVBwD+qA7ETo54rtAuS0/dpH2mjsdI3BPYUaMv+0NGiSa/jSiUQj/4Rsba7ehmkXCLUvKAwQhsLD6hp1hK/r00C/Aua8Q1ktI3Bnn1mhce0927LG2RinslIbe5qu28/QMkETxsDysCZldTzws9aFcYGEbCZ6eEKrKLpJhJxKCddaJX4Be17w3lRj/NdbW9yv+/B8ufEXxZRNvdryIUN/y/OD2VAUpUi/fY4txMFaw9HXPYgrgJE+gS/DoSSe2zZ0qZMNjHiKB5qXaiXqda1znrZXYaEh568RdthtrSjdtfFQmyASGnVOLxy3fs3sPriJx5mOEDyDY8CdiVjAxpsOTFr3wuD7MqElwBK5clFrfIa4YdgEjVPm3TpnXgrYktJvnLsZyqWyI63mJgVODNDjfMdq0K/2e/ISqaNRu+BYo9Tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(31696002)(36756003)(38100700002)(478600001)(6506007)(53546011)(8676002)(41300700001)(6636002)(54906003)(6486002)(316002)(110136005)(6666004)(83380400001)(966005)(6512007)(2616005)(26005)(8936002)(31686004)(66946007)(15650500001)(2906002)(5660300002)(66476007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJiM1BYTmFBZk9RTFhwS2pJa21sOUVHY3ZFOWFIZ2pEUlVDVkxGRVFrd2NB?=
 =?utf-8?B?aXhBOUFJeEE3M0dyeUJvakVMcHlubmdLQ05rTW4zTC80WHlnUTVVQ1pUYTNo?=
 =?utf-8?B?RlBpVUZlOXVWanpTMjkvUFlnMnNMMm5ybTZWQVdsSGU0bHNzeU1VUEMrcWJ6?=
 =?utf-8?B?OXF1d3F3Ri9XSFV1NU9Ba25QYzlWeGdUVWV0clVuOGcrRURFWFpDMWpNWjNY?=
 =?utf-8?B?L0E1WVJKRk1CR1FHbGVmb3J3bVJ0U3cyYmw3cXZZU0t3TnJlTDdUK0FZcUJo?=
 =?utf-8?B?SWtwbDZqTlVCNTl0cERYKzB1MXBRTlRwWnVrNjhzKzVBMzVhNFovR3RzYm9U?=
 =?utf-8?B?T3dVMGVGUFRtM3Y4N3J6NjNBOU91ZnFsREVjR1ppd2xlY1N6Q2tuV3gwQWQr?=
 =?utf-8?B?ZkY0clBuNUNVQnorMWpwZWhJMWxzMmJydnhibEFnOE8xZE1EekUzeFJJMHZU?=
 =?utf-8?B?bnhjSERKTXkvNVVDU0Vpd1lHYmlXLzhmRzA4TlZCZ0VhUXRFaGVrU2NacEVu?=
 =?utf-8?B?L2QvbHZXYjFEV3Fma1NweDlka2g3WTBHblRqS0hOV0RkRERoK1NpQ21tanVs?=
 =?utf-8?B?akFEYjdkR0tnbWcwdnIrZ3M1c24xNzFtenVvQ2YzcVg3V1hRbW1sZFdxM1Rj?=
 =?utf-8?B?RjdIcW9SMzYyNHJCL01MNERJV0E1VWMvZjRZNFVLUE5ndU8wSTJsaEp4Mitn?=
 =?utf-8?B?aW8xOHhSZDVFanlxVHZOUEJJNUdzRUZxN2MxdVlHVzFPS0pnaTkxQURxTDFn?=
 =?utf-8?B?K2kwMU82blBsL3V5dk9ZdTRzV0k1Z3l0bXZSc2FqcXI3OFlIL3FQK2ZMVVAz?=
 =?utf-8?B?dnBpalFyeG1iQWgwaFgrN1QyMmZUYmlzRUtDKzNxbmFxdkV0LzNMY2c4a2JB?=
 =?utf-8?B?dDlHNWJOczRpcWRHTE5tNmYyQUFZc1Y4b3VwWlp0c0RZd1d3YUY4YlExd3Jz?=
 =?utf-8?B?aEJVS2dxNEdoWFEvNnlhd2RyNkR5SjNLdHpwOUdaWUFSZnZwUCt1UjBwb3NS?=
 =?utf-8?B?S01QMmYxdkVIUGNHQURwM3VUNGpHUEtLUWRYSTBvUXRmdEhSOG9qMVRxQTRp?=
 =?utf-8?B?VzJqcUQvQnVkWTJqQlVxdXpVa0xOelJ1S1lCdGVNaStGZzlvU3o2V3hsQWZC?=
 =?utf-8?B?dTBvck1maXN6TjNFa1UyN2oyRUFLdm1mZzkrazFHSEFJR0hQVGRhWWN2dEpN?=
 =?utf-8?B?Rlk3SU4vdmgvZmp2VlBVTEtncVJyL2lsRloxbTl1WmlRWmFRaXZSNVA5Zm1v?=
 =?utf-8?B?d05kdWVNVlJWbzFjZFl0OHk2UGdOK2ppRVh3NVBRNUN4Z3N4Nk1mWThsK3FQ?=
 =?utf-8?B?bEYxcWVFNndpSEFnM0xHUHBUdEZibUxjOUpKRml1ZVdCQkxFMlhHRS9HMWFt?=
 =?utf-8?B?d1dmeEJrcXNPa1J4ZjhieUp2TUd5eTQ5ODdxSFFvUlNSd3FUSTBOL0Y1NkNs?=
 =?utf-8?B?bE9qUjJLdEQwTVpCU2xMUDFTOVNFS3VYVUtEei9rNXBmamliU2wrZU1SRkhI?=
 =?utf-8?B?RytzL0pRYWhoWTJUdFdxeFB3Vkp0aXBKNDdKL25qU0k2b1ZyWmdObnBYVW1P?=
 =?utf-8?B?dFhJTzFoWm5XUDhUd0hEallaNE0vb29rWldpOHhhbGdZZHlkR1hkU0hxOHl3?=
 =?utf-8?B?U1M0YzdlWHpzQ1FSWFo3WTlJSGVtdzJVakxDUVpHZ1pIanFUYWRkRDlFTE5W?=
 =?utf-8?B?U3ExOE5LUnpoUWRDaTcxczdJYWwyMFpCRjhETnFWVHFRNUFIUzVuSm1Qbk1l?=
 =?utf-8?B?bmhUK3hNQmFETHJFK1dmTjlLT05VMjdUa2dKVWNETmMzUDBlc1JnTzA0N1Fu?=
 =?utf-8?B?czIwdVFONE1nZmdLdEN1bFk1V2ptSDlpR3FnV2gwYlVIRVVDVVpIN1FCMmNO?=
 =?utf-8?B?S0RWNTZmT2E0Sk1Xc1N1MXFFOWErZHY3cTZjL2NISXlmcWQwS0JYWWFBVytj?=
 =?utf-8?B?dnJXNVo3UEZnbzZmdEtjV2N6bVpSdkl3YUhvcXd2V2Z3dHRHd0JnOGhkNmVD?=
 =?utf-8?B?ano4R001NmtoRmNic2RiSGlQdDNMQjhJNzF0UDVXQVZqRVBValRvLzRZWmpN?=
 =?utf-8?B?UHIxODRHQnRhY0pNd0svdDVYUHcvSEh0eEJqdDlGRG1YbWxlZVYxbGhRVExq?=
 =?utf-8?Q?eB5t2HBX8xVJrMULXlNiysctd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8775bb05-2010-47b0-8371-08dc31028b0c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 04:23:37.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfJszquQq/+RFai6mKO04fskO3iPbPXoK9Dg3kk9yDJqqg7G6/WyoSa/g+NP0t0Tt7Khnt2cFTsWXKVaU9FNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

Hi Mario,

This was super quick! Thank you for the help. Seems like lot of action
happened over the weekend :-)

Hi Hans,


On 2/18/2024 15:56, Hans de Goede wrote:
> Hi,
> 
> On 2/17/24 01:52, Mario Limonciello wrote:
>> The buffer is cleared in the suspend handler but used in
>> the delayed work for amd_pmf_get_metrics().
>>
>> Stop clearing it to fix the hang.
>>
>> Reported-by: Trolli Schmittlauch <t.schmittlauch@orlives.de>
>> Closes: https://lore.kernel.org/regressions/ed2226ff-257b-4cfd-afd6-bf3be9785474@localhost/
>> Closes: https://community.frame.work/t/kernel-6-8-rc-system-freezes-after-resuming-from-suspend-reproducers-wanted/45381
>> Fixes: 2b3a7f06caaf ("platform/x86/amd/pmf: Change return type of amd_pmf_set_dram_addr()")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Ugh, I should have caught this during review. I especially asked
> for the alloc parameter to amd_pmf_set_dram_addr() to be added
> for this. Ah well ...
> 
> Thanks, patch looks good to me:

Thank you for the support!

Thanks,
Shyam

> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 
> 
>> ---
>>  drivers/platform/x86/amd/pmf/core.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
>> index 853158933510..4f734e049f4a 100644
>> --- a/drivers/platform/x86/amd/pmf/core.c
>> +++ b/drivers/platform/x86/amd/pmf/core.c
>> @@ -299,8 +299,6 @@ static int amd_pmf_suspend_handler(struct device *dev)
>>  	if (pdev->smart_pc_enabled)
>>  		cancel_delayed_work_sync(&pdev->pb_work);
>>  
>> -	kfree(pdev->buf);
>> -
>>  	return 0;
>>  }
>>  
> 

