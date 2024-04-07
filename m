Return-Path: <linux-kernel+bounces-134500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254D89B23E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8AE287813
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B966639AE7;
	Sun,  7 Apr 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O8nKS2BP"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2126.outbound.protection.outlook.com [40.107.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0C374F2;
	Sun,  7 Apr 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495992; cv=fail; b=UuOuoLXmiG0BPjplyFvfu4dtgqFCf+26ZZAZu5ryDwIEfYOiqd2euNunPVx5NYlnw6zr4RvjPo9nWt+0npflHw5zKfDAbeKCDp6r8BdmqmUzCyoV4K3MVbQCDTPbOjKYItlzsd69TXFf2UE4VCVGA9yH3M/DjGarZVIKR8kDvNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495992; c=relaxed/simple;
	bh=n7RqdipiJUJ+K/ELEdN5SxFel6JO/q+clIn2ET8EDTg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzTexKleRn+gDz9KY0R0UpIx8jtJ4r4yj9TOC7H9pH6VjylMHyeeVJQ9YSOqWiBwwUUr2kuqyTWJ0fAMkKaYTZV9D08hgQxbh9Uv29wfnuTJM4g5WlgMy7UhuLVFFMQU1futVMAtSSjUsyVmUH2AmhnHC5ZJVNaY0mdKiKFCMPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O8nKS2BP; arc=fail smtp.client-ip=40.107.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8l/WdPjxc7rBTSzuZ3saT3L3MC2OSlb0Z8HCxJuG0e9R6ewzrBnZy630443C9e3u+5f5orQq5ad+arVHoduG2hQms79KmA+1Bm8CFiCIV17tfm5cii8nE7lbh4psmlgcK5k0fPlIukJzGX9bObY6aWbyy22Lg2fynZDNL3zBBlHhm8N+RQEfyIujGY4DaHe7TyyCcyjWHYQDYrclw12Z8rMSGKLwe+yTS3ecuqjiXLaYCDw/1TvR2ZCq3OBntrU56AFjehu+Z0dRzRchKBShXYsP+qx029Ugygj2vZwKmk5z0ROUI5iprnfGW6BDorhNTnmtXPxxy1OE/IFPly/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVPCsTGheuHWIqJqF0WMcK/rzrPAQAylLgc2xfIk1Mk=;
 b=bT1OdZuznalNnsBeawACwFcW29xQQDCjjfHSR6m5WvdtCjtkn0cVn9UT6EcfFqph5h6kQ2aVa/L49cJkQyYEPuttoGI4bjKKUOm+DEbvPAYW/OTEzDTp97fzHLhAXAlZWQ3uBCWer1CmE+/t8RzglHsJbqhkHAwYQq3ySplLj+YsRYOJVXbE6PcLgir/YxF5LjYrtRUw92v9JNM+jS21bCGInrO4P5HxeJ19EnAj5HdH09WU9mbTp7zAsws69pvFp1UduK6gQNR9YFKhV9fnfCinYPeKQGRwPsbNqNNt2lzb/QTSqIp6BDCXsQx31B/opcab2FnfTJeyx2MbbJBlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVPCsTGheuHWIqJqF0WMcK/rzrPAQAylLgc2xfIk1Mk=;
 b=O8nKS2BPqT0IhCChWbtTfwHy1f3e7ECx3+/7HDhad+kOkSdgIVsvMO3PwAOFwI5OlraL0shVWBwB/yKygWiCI9fbLqDmc7f2ulWdEf5gN1eac6t/kaVL3K+MGca/L+wDgry6LGflcjXs6rD+RM1IvidedsxWZeWMRH6HoKxTU80=
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:19:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 13:19:48 +0000
Message-ID: <0bab8b6e-c7e8-47e3-a42c-c8798ba4b6fe@amd.com>
Date: Sun, 7 Apr 2024 09:19:44 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "Avadhut.Naik@amd.com" <Avadhut.Naik@amd.com>,
 "John.Allen@amd.com" <John.Allen@amd.com>
Subject: Re: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
To: "Luck, Tony" <tony.luck@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-17-yazen.ghannam@amd.com>
 <SJ1PR11MB6083683CAEA79F935BFA1B31FC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB6083683CAEA79F935BFA1B31FC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0464.namprd03.prod.outlook.com
 (2603:10b6:408:139::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS0PR12MB6415:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FzFWh/eqrQd/kmF5wJRxmz5f3XnS1zXUqFBibcfsNSh0PSzRkT04XufODqiXp6W1SetvmnuZcmV3UTu9goy2eiT5mc1ELCf6PIyTv3HQqgg/msG+1QU7DB/sRvp1dqJHJKMRsBeT7tCdayMIPfLthqXMkwp4AUvljzpzza6ZHjRrE8HgJwI3XfoXA+O5vVxW8zszcHxgvmK/TlRLG3/LvlzG6UrMz7hxw7OB22gU7+89KKVQKPQTZ2xljw+VLt2NSQm41CcMsU6O1QF9WbXvEcw253v1IB80DFFv1r8v4jLBs4uA4AWwotyJC6if6EI64mfmLkWaNmqFWNMDsOUXcKZiV+sH+jbWosd2O4wxXmIVU+5h01EKbKYgIr5LWO3y1m623LkhyPl98EWsBlQxGeirwTQEsiCSX+xG8Wd5z/vOl4is7AKYtNZfopIjay3ujZuc3aPVV1wSxocaa96nylwyMFWmXFRyL66wVlUWpd668EWbiFz3YFXI2ixzx70JZg1mDpW36NCkahL+Yjzwv9yQSaohYtmUpWgJMc+s/HRBChAnEojs/ALimwpSZtJSpD5mj3mknQbK8eyITLGLxGWh8u6Bza2e7UWfNZgWF51hE5Rq/u9h20+FLudS0PcJSv1V12hHJe6cYAOuLdR2N6tJ4lqwuZeAnTIFj2AeSwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHVpbm9kSnM1UDFqTXo4bG5nUk1zWEoyK1RMT1MxZ0JIOStrTlpnYjlqR05U?=
 =?utf-8?B?RDVnNWd5cjZpc1MzVEVuZWpsdmtmV0V3YTFFLzZGZ05yN0Jac3JUbThYWDQv?=
 =?utf-8?B?c0xhZ3VLVjVIVUNyQ2JodDBwMHJtWnlXM2FMamsrVStqeGExcmk4NGhJTllk?=
 =?utf-8?B?azNyOXRDWG5GQTRMeFF4TXJHTVZUYUx2MzZJdkFtWlRYTTU3SUZJU3NIVzl6?=
 =?utf-8?B?MDJ2SGFOWTZUOGxEYlViS2Y3K3RGcXd0VlMxWVlYK0xXc2JZZ3ZVZFdZMGtt?=
 =?utf-8?B?K3dyaEZHaTZ0Ui8rUlBxYjlINkp4OWp0d1l0b2pORVVkY00yYjNqMzB1SGxz?=
 =?utf-8?B?LzIzN28rU3gwMVhrQzZnd2RQbXEzR0prNmlXaUltQnRjZi9VR2dXWllDS2dy?=
 =?utf-8?B?YVFBYVQzTXJWclhMWkJHKzVzM3prUE43QzNXS3d5dkFmUDlFRkJxODRIM0xJ?=
 =?utf-8?B?aHJlVTV6Vjl0cFd3WHhrWExWcGppQXI2bEZRaityYlIxVS9aY1JUUTBuY1M2?=
 =?utf-8?B?SmlyRFdVY1VFVFZLZExKbDBQRkEwUWc4MGR0c0FOTEw3VXF2dU83RC9Xbks1?=
 =?utf-8?B?L3JDMlpmSUQ0dzNZK21BVGNiTGp0cXpreUUrVkNueVJ0Rlh0Z0dVRnNSQ0hO?=
 =?utf-8?B?QXhDbnFtUmJUdklhSUljeENrQWpqa3oxTUt3OEFWYkQwZ09hZ0t5QVNqNmt5?=
 =?utf-8?B?bmtzWFNPOTVFRnRyd0dueWp4Q1poQ1gvZ2xkUHMvckVscEJHanhoWUFwZVI0?=
 =?utf-8?B?eUFWWlFhRFZRVExYc0FyN2lzMEJyeEdHMHY1dEZSdnlnay9md1E5alo4dUMr?=
 =?utf-8?B?T0F3SlE1VzBITGduRVdMZXhyeDFvR0ZmT2dxaHlFMzBzK3JRWkxOSkNqVGZY?=
 =?utf-8?B?RUZoaTUyOWppSXdoM01IWnFzbnlUQkQ1aGVUMmRSdG5QUVRRdno0WDc1OHRj?=
 =?utf-8?B?N3RveHVOT2ZkVThpVWNIT0N0ZWNjdW81TGtQckVVemYveDJHa0NFMFF0bUFE?=
 =?utf-8?B?blowZFhuRXBvOVVIRnRsbyt2cW93V2ROS3dVdERBMkU4Y1RydVBqbk81YStS?=
 =?utf-8?B?SldLTWpXUzlBQ3QxRHFOOE5WMUxOeE14N0txSE00aVZPUVNsZVF0TXZMV1BD?=
 =?utf-8?B?YTROV1VUaWorbW5taER6SFcvY3Y3L0V0eXJWWlNMSjBOQ2JwdXltZUNXTmxI?=
 =?utf-8?B?OFdNcVZuU1JUNU1zVzJoei85YWh3d20weWpUUUg0b09meXJUZXJMS0NydWZZ?=
 =?utf-8?B?L3NQV1haaUc2YVRnejhrZ0JmMHhRbFd4SGYrVWFGNFRlb21aODZ1amF6UklQ?=
 =?utf-8?B?Y0ZiZ0JWWmdoRGkzTWxiT1FNellaUHc5SGNBZlhYMEppbGw4cmtvbGMxS2I5?=
 =?utf-8?B?QTZuSng3MFBLd1YrL01LYWg0R2luQk5FMmhHQ256aEo3NVdXK0g4U2YvTWE2?=
 =?utf-8?B?ZkF4RFFwUENwMktzem4wdXlIckZTejgxUktnaHR0aFJUKzZKcldXSzBNbU41?=
 =?utf-8?B?N3MwTHF0eXUwTjF4M0FsZzgzKyt0c1ZzWEV1aEZ6bGFLQmhQcEZRUW5mc2V4?=
 =?utf-8?B?ekZtcWpMbXBLU3FOd3BLWFBJTFFkSnFSb0M4Tllkaytxb2w3MFJhQkFFWFBH?=
 =?utf-8?B?cCtOajF3N2dsUHNvS0gyQUNqWi91SXJ2VXhGRUpYckMxY3VCZG11OHY2QitM?=
 =?utf-8?B?NHJRVjZvaUdvdnVXcHdzaHZTeXFlSDdLZGljblcvVmt6dzhVUXQ4OEV5TlFy?=
 =?utf-8?B?aXdXVmhZQW05WTQ3UlFrK0Z6dmd0TnVRZzAxOGducmc5Wm5UcFpQNFRIeHJU?=
 =?utf-8?B?M0FsTFRWSnZwZmF1WlhVZnk3ZmdVa3FKZWVaYkl3SEtHWHYzRVhzZW5Jb3FI?=
 =?utf-8?B?WUdBZVZlcHJ1eUlFRXRjRUFIZ0xQTzRqcENZU3VQSHpPT0NtNWdlTlcxMzdS?=
 =?utf-8?B?ZWV4ZGlzYXVPM0E3dzUxb3krVnBlanZTS3l4K3RUWjhobWJsb3JKN05xK05B?=
 =?utf-8?B?QmM4QlpXTUEyQ0lZY2J1bW9nNFFYUVFvbE56NUM5eHM2czcwdC9VNXM0bHI4?=
 =?utf-8?B?MEoyZXVmVEpXd2U4RUtsM0cyVm9UOVNNTDhLZ2x2SFNhZEt2Qm9uSzFKZnBj?=
 =?utf-8?Q?yB3sCZcPz+Gyk5GEdTAHJY2fB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434d3073-13c2-4477-7ec2-08dc57056604
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 13:19:47.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvKA77wE3c0CV1CvZ6xcj28PRJ4pEuIv/UlVcfzDMfqY34V/7Ztm1FdljEYxjg+CNSXvgzMkianDqOCYnlTxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415



On 4/5/24 12:06, Luck, Tony wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index aa27729f7899..a4d09dda5fae 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -207,6 +207,8 @@ static void __print_mce(struct mce_hw_err *err)
>>                        pr_cont("SYND2 %llx ", err->vi.amd.synd2);
>>                if (m->ipid)
>>                        pr_cont("IPID %llx ", m->ipid);
>> +             if (err->vi.amd.config)
> 
> This is in common code. If other vendors start adding their own stuff to the
> "vi" union you might incorrectly print this.  Add a vendor check before looking
> at values inside "m->vi".
>

Yes, agreed. Will do.

Thanks,
Yazen

