Return-Path: <linux-kernel+bounces-81815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1B867B50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F877B2D5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415C12BEB6;
	Mon, 26 Feb 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SvBJNRdn"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32F604CC;
	Mon, 26 Feb 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961719; cv=fail; b=hDmovxp/7MZQBP/93cohHrvFKIWLgjtjQhYbfcWS1KlKDv0M91Q3VPPI9GZ9dcpxEZqjYZR/rf0g0LbeJe7xhUc0G8pO9PAYhw/4jvLSv5JOXCnossXUmUvTcnhoIqmoHceMmQuEiNozzXAd5miYz0SoY1PKByPk/LB+hUbBq1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961719; c=relaxed/simple;
	bh=mY01jePIyAQaU6V33hK1ufxzu0vKjdKX5aXpFI7Wf9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQ3CfHDOQOtomiqmfbv0UgOoOqR3nFvPvS88xCwrHeO3yPDmj48B8k9DmhWcW43bp9z6p25UFm+4CB2iUiN7Cu4ehtPUEyhwr8gFOJ2mVbut6RRGyOyN/XeYaGfI0qVEnFS0X0ATD0c0ruZS9LH7aQQ+zGZW/VmCkxB4ge9tns8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SvBJNRdn; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNU02v9T6Qm+vocgIxqEln6cOOPY3QKridZ/i+0zvDJnCHVF45PeeOiP0j7AXDwWoi2nvtrnyiwudT8ws4MNtNJ+Bi4WjYMctaWthDQGxckls9jaLQcFw9cc8RevSkijEmCo9mzQO++vIeAWP1bZtzMBbymp01/Bu97EJ3fGiAW8xPR0qcYU+/IfJnyQV8oFz0FiWyW9Ud7BnBbUB+NfneqpvxVE7IYtY4k7G5TRpecLiiRpQ8bDazrlaYU+IHR0ZdO4ocu/+D2r2kdwtG/ZFJgiscrwASAXHoR+CEMcuAXEG2b91Cn/A2JlSuf+l9vMbIwSV1xjSC2JB7TbYyl/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZj678wYZICZ6Yxr32PkToR0mKaR3tXx40HHpNS3Fno=;
 b=fPaRM4ziUbsKdjcfLzbCNBwxNGSY3Efk7+JsRRcyABm+7K6GAevrLQ7kL9e0cO1+M/PSb74EMqhH07V5vi2OzW4rhB8jpMl02yIzpIxX+ZkbPvXtZAdRfposJRE6jeCVy6KQcpyCg2JHX6RCEz5b4e0nrcUjmxJFg+k+HnRKPjizQ1nPpYI4TW8bxEwsCYg6zFnohjpl1+BRISWrrtZTuzcSbpEU2vbsI1KqZ1B+FIw0JTRmFIKwDWAJffE9R2h+TQaCEno3pTyMCuedaqBHHWy+bZZRbgSgvdv+/OsFLdftN2sdgRgCXYVmUQb+wj8XZBhly5zL4TamJ+Dn9KfTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZj678wYZICZ6Yxr32PkToR0mKaR3tXx40HHpNS3Fno=;
 b=SvBJNRdn9E/XMU4dPDhUJAtuR+Vfg85Ag5/V+DV7ueMzx5paaZjx2PohO1yNP6OTb7ueoL3MVjgSkthhX8ajQMGGkGWboYilsU6W0MB53J+w5kC0hBmNgpN+su4crDaGQSfm1tXmjncU89bApuL+2U+Il4Y3CK2QYw6xoyZKkD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 15:35:15 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f295:e439:73a8:c57a]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f295:e439:73a8:c57a%5]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 15:35:14 +0000
Message-ID: <01bf2ba5-edb3-46dc-8725-93b823dc0fb1@amd.com>
Date: Mon, 26 Feb 2024 09:35:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix missing error code in
 amd_pmf_init_smart_pc()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 dan.carpenter@linaro.org
References: <20240226144011.2100804-1-harshit.m.mogalapalli@oracle.com>
 <a7b4dfc8-8be9-911a-6c56-4f84c1b85d73@linux.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a7b4dfc8-8be9-911a-6c56-4f84c1b85d73@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::33) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: a934d5a0-2e0a-4b4a-661f-08dc36e0871f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ip+UUtPJk/rABBzMy6LT/uoc54kv2LgIGs3RDfw3A4a/S6+iMKshr6z6JObDAwZCbtLdEGe+tx5sP+ihg0iT+S4jRwRv2wLYT3moCr9BWFfW1GjZTlt4psdIyOSNUN713MkOhrbdwC4oD/+DYJHxpFzB74C6LdWfWgeyvdHp+z3k4BjRH8xcJ6e5N+EErqCCNcrgJyaYP1IIVXihZXa8s6RJpO40fji1pWHyjMkD2e/2hnwf21ixS8YBFxPql/0DfGM+01eBxsruAyIGvrv9ne7GoTyIwBj6StmPnfBYVhQiaTdNpkX0Ep+tRj+ZWgOaAZmppgwJtgIpSwEcdMXi/En0Ud0Rq/QX5N8PW9sLJAC0Y20JPfcCWOqaMwnch846i8EFDx1SC4le3Rbrfz2r/RGagzgig0mmd2RNfk6rw51CFX9VbAqAAGz9/zl0Nb5A+syQNzuGjt73hXEqK7jkx5eViIBG0BVn6J5x/dunfna7WF1ZvnP/2+k3rYXgdcNCOKwnDnKan0bMiU//NjbKhu2FYysIQoGlvpuqTKwkbpP12XyZNY/ORT4ESp0q6/0tycHjT2iiC0JcNArwJfk3z8+qq80DDn8EBJdO1FGi9fiYQN7vO2QKEuzVMC3f09cVBpFf6nXc++aPlDqQb16OzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFdIUTZIREhhcVRnai91WXVHRlRwVUVSLzJKSEtpRXE2VCtGMkRKcnVSUkFm?=
 =?utf-8?B?V1czRy9xejk1NUVsZnBHaHdVSmlOczNJSFdGaEh4czNLUXdiQjNHbEN6N0lh?=
 =?utf-8?B?ZmVIV0E0OVZsVmlTczZSclF6Q1JQbmxZVU85RG5aK1dBQ28zM3NkRFY0TzRh?=
 =?utf-8?B?TDF2aEFyTTJlM05xN296THpRR2pBSk82UjJyMXpYNTQ2WHJ4Wkt2RHpEMmIw?=
 =?utf-8?B?SHVEa0ZJMjl3MTJLeCtOd215Rk5QZjhHcHVlS016Y01JaUJiWmpSbm5qSFpi?=
 =?utf-8?B?dVVzU1Q0V3locU1ZU2xGMURocXJXaGxSWHdDV2lQanBhR01lbmFGMTlsUDZP?=
 =?utf-8?B?Tm1QYzRwdnp2QjAwclFuWElGam82V1lFZzFPc0JyaXBBeXRQWllHMTQyR3Fx?=
 =?utf-8?B?OExucSs0S3hnU0lGN1FFanA3RnFqbmFrSjdHVkNPc1Y2OEZkckhUdkFaUWhv?=
 =?utf-8?B?MXByaWttTTk3eFRNcENuMXBsU3UvVTdBaTNOWmpRUkUvQmVWSWFLaGhzMy9o?=
 =?utf-8?B?U2pQcXFjSFZsNTk5aVNkaldURzhtcmVjR0lmUXlpNmZTOWNFWG9SYnVDRGNy?=
 =?utf-8?B?MGk1L3JHcVJIdE5ia3ZrRmJLeTRYeHcvcEVzaEpsNS9TY2ZBZlVLVThGVHhM?=
 =?utf-8?B?L2daUjUrcDk1ZzZna1ZtZjcwdUZrbkJaODM0cy9HdEdpL05IK3lDdWN4WWRB?=
 =?utf-8?B?bGhiQjF0ZjFOMEZmTHJYTXZqNkJ1VWtBcDB2cFNEL0EzZytIcVQwUmJkM1ly?=
 =?utf-8?B?YUdVcXdRMEJPOUpISWFRL3lVSU5UN3U0MkV4UjVJMmg0UUJlMkJlUnNPRUQ5?=
 =?utf-8?B?b1ZldlBhUmNVK2dlUXRuSUVYRGlXaE96M0Q0bHlyYUM2OFNaS2V3Y0pYREJH?=
 =?utf-8?B?U21sUWt0UXdEME50MFlYYVlMSldXQkZmeXNXUVV3dGF0ZmErd1laSEMzUlFH?=
 =?utf-8?B?UjBYOGhoRXJBZm05MWVhOWJ1TnMyZkFYQVZSVzRueWhRMFM1aTRSRHJmelN4?=
 =?utf-8?B?RVB2bUF1emlVL2xNSW1IaklCcndJRE01TnBuKzNXWnpqWS9sVkZmc1R0Qngy?=
 =?utf-8?B?VmdWYm9PSHI1N1pVOEVjN3IyejRDMEExbVRKMGxueHZsN0V1WThndFhzTHNW?=
 =?utf-8?B?UklVMTA5T00xempUNzZ1NnZZbitOQ0tPS09mZ21zSzg1OCtoK1J5Z04xRkZQ?=
 =?utf-8?B?L1VIVi84QlBMelhJaXZ2QkpYb3VLcWliaUljelp2a3h5YmRNWjAyNWpxZnB6?=
 =?utf-8?B?OFM4Q205SkhTeEVMdEhqMk1pb1d5eUFETkM1KzFZZkV4Ykp6UFI2bTZ6T0VE?=
 =?utf-8?B?SzNpSU94VFhYQkc1eGRhWkVTdGVXUG93SzBEbEl3Ty9pVDN4Yk5OTkt5am9j?=
 =?utf-8?B?ck1jeTEyT1JDMVMzRXZjSElYQXFrY2xUaExQQTRjUFhhMk4xNnExT1pWcXhY?=
 =?utf-8?B?TzdvTzFXU0pRa1hhTWVsQU5tNHJtSHNWa29rWTF6dWlINUplYkV6TEJrVU03?=
 =?utf-8?B?UkVuTy91MVA1azdOSUlIV1NVSCtRZTlEV3h6Tjg1NFJoSnQrc1M4VVIxQ3Nk?=
 =?utf-8?B?RmpaSWtIVXluUkF3WENCcEZkOTRmSHZMODFFa0xkdnhxRXVBWG1QSGdwSGVl?=
 =?utf-8?B?Zk81amowZjF1MmZIUnhqakMraTR3QTRPSjYyeWFtY0RDK0dxbzJReEd1Ynd6?=
 =?utf-8?B?MFdYSlBSZGpwSE50QytHdWlzZEsvK25FaEZNYW4vcUsyYmlwYXM1M054Mzhx?=
 =?utf-8?B?emxQckxocmg3MG5JZW1USmczbzZOT2tsRzRqZ3FYU3JmR1E0R2NoSnFoUkU5?=
 =?utf-8?B?TE1xM2ZqT0svQ0cxR2dJMTF5b1c5RmU5ZlVMUDZmTHpSZ3hoTnBkQkxNYnRl?=
 =?utf-8?B?MFQrbWZpTGJZY3FKQXhJQjBNMjMrMHl4NmE0YlZyY2RBVmVlODh1ZDE5MkZD?=
 =?utf-8?B?WlVCMlNIRkhlTnJwdXZUUkRKMzFvU2ZOM01iSlVldHd5ZWVTaFZLcXRmNHdX?=
 =?utf-8?B?dkZGd1RsTDMyK250RWwwL3c4Qk03Rk9RdnZNdzFNL25rdlYzblVDQWxRSEtY?=
 =?utf-8?B?VUtOYTlpNE1CL1VjYXNKRFJXei9KWlhEYzFNQUo2Yjk3b1E5dFcwdjJLaUVo?=
 =?utf-8?Q?jYeo0FJGWeb4/GGHIE2EA613Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a934d5a0-2e0a-4b4a-661f-08dc36e0871f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:35:14.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOgmA+g/2G4s4oP/5DtIN2NdSvciMJFhc853x1NwYhU2i5bc/ECkLjper3q+Z31Y6ykm3dfloD7ofDthWn3g6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

On 2/26/2024 08:53, Ilpo Järvinen wrote:
> On Mon, 26 Feb 2024, Harshit Mogalapalli wrote:
> 
>> On the error path, assign -ENOMEM to ret when memory allocation of
>> "dev->prev_data" fails.
>>
>> Fixes: e70961505808 ("platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is based on static analysis with smatch, only compile tested
>> ---
>>   drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
>> index 8527dca9cf56..dcbe8f85e122 100644
>> --- a/drivers/platform/x86/amd/pmf/tee-if.c
>> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
>> @@ -458,8 +458,10 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>>   	amd_pmf_hex_dump_pb(dev);
>>   
>>   	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
>> -	if (!dev->prev_data)
>> +	if (!dev->prev_data) {
>> +		ret = -ENOMEM;
>>   		goto error;
>> +	}
>>   
>>   	ret = amd_pmf_start_policy_engine(dev);
>>   	if (ret)
>>
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 

Thanks for the patch!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>


