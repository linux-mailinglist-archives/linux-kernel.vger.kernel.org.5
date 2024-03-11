Return-Path: <linux-kernel+bounces-99496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713687892F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E461C2126A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF095677C;
	Mon, 11 Mar 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3K1vrd2t"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6E55C3B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187136; cv=fail; b=i0zstMgvxnWZTcvNWGyK5EnDai5eIIdoBMDdDKyi2Z8kpKdCx0ptfrvsyzQCb5SWqlYZNXgw7bWxHdHsD/IFlsmSYCQAIorkG1rvDI7xm2OYVMf+jkIiOd5LTjjDuB7UEBL8Ytb4kQ/3qLqiZ9YtusQdqxmAEvVmk1YcvYgeDD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187136; c=relaxed/simple;
	bh=e6yqirrnv2DIBvM4XDrcKXZYopOouwEKtslfFPcamis=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4BHXBrcMExFtqXQoEH+qDSWBBslkwIjqqLq6IC5HsZMlQ4AHIbcxQ6Fldvr1X1WKwDqqVRej8IOGgNoiYppVOPjcgNGLBNRc1dap1XW0XRx070Wa9z4R4VxkTUfTASXe6TEa7szMG/wVbS6pHYHvJ1iqCeEJIqszYiKHjylozQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3K1vrd2t; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8jCFyUK6CQRMC7SVTFK3Z31XW26UnAr5m1bLqRKtqIWLnW5O8cHn+gXNbZnz4AwaEcGwf+5/8Rk2IFFR3uJG6156CyT/dovtILXiuWJKQn18V0sdY1RpCyboWA+dq88RpjSrN0asL2P4vXb/sbU86U5rYWZB8+2lMqJE6WXjxr4wxwWGtIc95Nt9X81uN44WeMgIh4NL3szz3k63N58WA34FTFXUkI8g1YimwQ9L1Sh3TtFcLlfcWMXcfxwhDnmGGY6DF+4PSA2Sx6+PyDzRhrAR7Ocox0zU5AlCjaCjEhW86+99kW7bwA3+ilesP9zOJZnJYKMW5QWjyB9Rnzqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq/uAKUDNZzPSuKb+MaKkmD+9xkBMcQqDp8ShX0qz2E=;
 b=oUWVwlNyOMZw9RNF16EMHgNFb3jaM4KZOJDNqptC8rkv1A4pGP6ybhFtoqcA8kJbWJ1MHFR1oOPiEJ+LGNyKXx9MGV0j8NS6dHbPkPHx+aMv8+dIumBbnO/XSzpJ/HyUo7bNPHIrzwmM3alACTHOvl3spaDojTPAw4zQspIVcaK6s2LmLTfnA2w3MFZhcb/l2icCVU+TcML2ZdT8z7l1y1nOBj1GVrCLKqGe00Ze3QlswNbuV+f16ZxY78u94am9TdHyeCePNPJXcL9tBGg63WWzSLIADDHsTa6EAGYXziAZUDBq0QKhWX/9JYTvssMRiN0XxeWbEqpHVipuwrOt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq/uAKUDNZzPSuKb+MaKkmD+9xkBMcQqDp8ShX0qz2E=;
 b=3K1vrd2tR4UMMmgNWiNj6Q/NzXpqOaVmstddj2tPQdIlfv1KmVG4AZs0MnLhfXSkEf9CBt4nbLmi5bPUMBnHNZsn7fFwiCDNHfLOmGZeaKh+7ygG6CJBm6gfxipfcc9QzfyFkS5Cvuctybmx0uC14lWOjS/ShwIUHt2YjED07Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 19:58:52 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 19:58:52 +0000
Message-ID: <b8210749-50eb-4b26-b616-38670990aba0@amd.com>
Date: Mon, 11 Mar 2024 14:58:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::35) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a187adc-89e6-4940-369f-08dc4205acb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7qHCRZ1QewmoT9EgX88mLEU2TXNtm1jY5KtleJfeeKQW9kgp4Fv3nAsUUT+dewGWCQxmuODXctrdyHyE/CPdNArPD/PTkx1NZKioC5K1moE4R+kgqyUXsh7gUPk00n3HEXXA+WjQwkN53w/NDnOBVBzURXpWF0Bh9rw96Wzev8xBCSDC7o7RmS0KwaO/PuA+Np2BjjDgzOzmyrdDFWMBQAM5IkDro3gaUhBKVB0g/L9OlvJZ24REPbOOqVd6B2qiaRv/Jr8kbJtzOqIHYNW6mxXE6fQ+l02Mgn1t+2At5v2HfN9F6mYAf962M209U5FrkLqztZ7tdCRWMjJBQ1vtac1yemQrpmdNpOdDJJXI2WK6WpLZOaOGX1E+HBs4LuK+T7iXwnbEJ3LaIYQbRX/i10AKpFfUtyxpw+HQOIRm/Behg2CP7LkutGXE9g+rnIPLqZjVVInxWbqDCsEAXgTY8c//Je06XcdSO3gGKyxCDR8uBMrPNW5rIcz6L1hs/ThKNE8rSHBn5JmcLYwf5DTCIlBMuCtI5+Ugvs+sHPeQvod032wmuEPgO9uMWPimyY6/0XuT++B6PCjutblaMEVQGO5qOWZ83XN2VUdabSr2WQHDrsdbJRnC4C0W7x9ZJc1XcFaQjctTddUO7VCKpPRACOeFUj6/gr5lQb52EIyjmsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2pwY1FiRlFPc0VsQXZKU0xRQ0diS3UrbURiQXRCaWpmc3FqQmRmRWFXTjRh?=
 =?utf-8?B?SmRNMmxhRFg3Z2tOZHdhaGhaY0paRml1blFlYi85U2g4OEhHT1RodTlYaEFD?=
 =?utf-8?B?TlBNTXZreWZwQXphdFBUNFo3cTZDb3lkdmhWUldxVXBwQ3NrUFV2QWNqM0I0?=
 =?utf-8?B?ZkZjUCs5T25qWCtMR0dTWE02SEpranRkTXlWMUZTTnlWS0YwaUcrT1N3OWtQ?=
 =?utf-8?B?ZGRHZ1hnRTBYS0dGM3lQK3o3OWM0TG9jUUNuT0JySXltUk5lYldJVDMvbUIv?=
 =?utf-8?B?WTM2L1N2ampEcE5URndJdHB3N2h5QnVwSTJTN0cvTUZnR1haSU5CelJabi8x?=
 =?utf-8?B?NFl6VG9XRDNKdE1XeTZ1eXU2b1h6S1U1ODVvQnBjQWlWYlNpcHpydHlqdHV0?=
 =?utf-8?B?RUIrSktBUXlyWTZVZTZYaWR4LzQxZmdOeUlYYlhBT1d3TlhNT0xOR296Nmw0?=
 =?utf-8?B?V0xPeCtEOWhiK1drdytKd3ZiUFdXWG5Pam54cDl6bm5ERnpMbVJSejZxYll5?=
 =?utf-8?B?a1NWbUNldHNxOElaZU9mcmxKN3NnMkZGcm1ER1pIeFVIbzRCM3lycitXMldj?=
 =?utf-8?B?S2hSRVB4TkE1SUh2NGEvNklzdjhHd0ZZR0NIV2dsaFR0TkVzay9vNkkxM0Nt?=
 =?utf-8?B?NnFnQUd2MVU2UWZjZkdEcVJTRmdORkg1WDkvYjNWSmVWODRMRHZZa3MwY3I4?=
 =?utf-8?B?YVhMczlDSnJoUGk4NUlqQWNDM0ZPNTBnQVN4c3BURjRHNllIcTJVS0Z5UWpa?=
 =?utf-8?B?d3lmMEhDUys4alFWQzRDMzA5eTJPVGtqZVFnQ2ZlUG1tYXpLWHoyU0RHSTA3?=
 =?utf-8?B?VjhlN0F2WW80OEQ3Z09PNjJra3p2QkdKVFpSSTJlQXY5WlRoSGFjWkN3VFNR?=
 =?utf-8?B?RTQwNXIxWnY1aWZqbUcrY056T05Xc0h6QW1TdUVEakpxMVVlZ0dhTkxMMXZG?=
 =?utf-8?B?Q3lRUEUrT3k0TjM0VElsdGhqV3B1VG14TWRnUjRLYmJDQzUwdTRoeUJtUnYr?=
 =?utf-8?B?U1pkTVYzSWRDSTZUbFhRdU5oekdscnUyaVUzeXlNMDQ1VGN4djVhYTR5TjZo?=
 =?utf-8?B?c0tPc21ZVHVXa3laNlFabXY5ckJBQWx5YlVSbDVMVjRBSDlsQ0RmNVNqS0lU?=
 =?utf-8?B?Z0VTaHQ2VTFYU3hYVkZQL1JSSDVSMDI0cjhucFdza0pTbnJGSnMrVWVGYnhX?=
 =?utf-8?B?NlQ0K2J5UHh4UGdDd0pBWWhTWEExdy82Q3lhenFCL1pIVEN6UEM4VEtuMk01?=
 =?utf-8?B?eWVSeFg4d0daUmk5RGNzMGI1MDlFTGlFdG96c1o4a05hcWFDdUV2ZGV2NkNY?=
 =?utf-8?B?NzZTVUJQNXBwd09OSGVtM3BwRFFUUk9lNXZNWk9XSFgzdS9teE1PRnl1c2Nw?=
 =?utf-8?B?YUJHWXY0Yi8rM2xkMUJTazNVcmVWdjlwQUhySnRCb29zVElIejQya0xjQXlV?=
 =?utf-8?B?QTlTaGZUTytseTZpcWFKR2oxalB4TkdoUE5SQjJNb2s0eHRsS3F6RmR1dHhQ?=
 =?utf-8?B?MmZlc29xNSs4Qm9mcy9qVnBYaFZZUW5Yb2Z4YTM2Y0YwUkRWWFQ2NW5Rckov?=
 =?utf-8?B?bUZPclR1M0U0K0hTNjZuUWMrd2drZjhaMWpnREZjazkrQTlPSlp2Y2twNzlK?=
 =?utf-8?B?Q0kwUXBwSVlKRFlxazJxaUlPeEZyemxlL2hRUHlEaU9GV3FLTmc2Vnh1clBp?=
 =?utf-8?B?MGE4cFlYV2xVS01WUk5tU0F3TE9tQ2c5UUlIUHJSYzA0YnY4cVAzWGg3MHpX?=
 =?utf-8?B?b1g2cEVTbmoxZlJGcFhSNDE2RGg2L0FPdTlGUERzS1R6Y21PS3R3QW13bmw0?=
 =?utf-8?B?clAzWnNRb3RtNDRnUHVDc1AxNnZOSlNnRm4rMkNPbnpHYmZrQUY2NDMyTWdh?=
 =?utf-8?B?ZmdtcjkrMlBFTDNMdTkrTnB0RDc4RWJIZTNOZEhaZy9xWXgzNWtXejRWM3lu?=
 =?utf-8?B?d3RUdGRleWhVM0RaMUJQbVdXcnVDTDdYdEJKRy94ZEd0UkhCTG9TK3NtNlE4?=
 =?utf-8?B?S3BiejlOYldGc1hvR0ZSS01Kem9aNGQxQTY5R3A5Y3NYQXQvYkdnY25oZnlL?=
 =?utf-8?B?VWxXVzRIbkFSdW5EMHViVkxlYm9VRTJINGxRRTFPR25HV2hBbU5kZFRVNUlE?=
 =?utf-8?Q?uR6kFdH+JrZEUANhDZ206j98L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a187adc-89e6-4940-369f-08dc4205acb7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 19:58:52.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0SzfEevNLlaXqjYwhrcGJXN0vHzIqmT+1Fz3Bq2TTWhzxOZBMnJV7h4Wjo10aOwuWcDfg8xNQyOuOn7RR7OUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

On 3/8/24 12:35, Tom Lendacky wrote:
> In order to support dynamic decisions as to whether an attribute should be
> created, add a callback that returns a bool to indicate whether the
> attribute should be display. If no callback is registered, the attribute
> is displayed by default.
> 
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   fs/configfs/file.c       |  13 +++++
>   include/linux/configfs.h | 114 +++++++++++++++++++++++++++------------
>   2 files changed, 93 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 0ad32150611e..c758bcc11235 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -451,6 +451,12 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
>   	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;

I missed making this adjustment on the returned mode parameter below. So 
this patch will change slightly to just initialize mode to attr->ca_mode 
and then after the if statement, apply the masks as done above.

Thanks,
Tom

>   	int error = 0;
>   
> +	if (attr->ca_is_visible) {
> +		mode = attr->ca_is_visible(item, attr);
> +		if (!mode)
> +			return 0;
> +	}
> +
>   	inode_lock_nested(d_inode(dir), I_MUTEX_NORMAL);
>   	error = configfs_make_dirent(parent_sd, NULL, (void *) attr, mode,
>   				     CONFIGFS_ITEM_ATTR, parent_sd->s_frag);
> @@ -470,9 +476,16 @@ int configfs_create_bin_file(struct config_item *item,
>   {
>   	struct dentry *dir = item->ci_dentry;
>   	struct configfs_dirent *parent_sd = dir->d_fsdata;
> +	const struct configfs_attribute *attr = &bin_attr->cb_attr;
>   	umode_t mode = (bin_attr->cb_attr.ca_mode & S_IALLUGO) | S_IFREG;
>   	int error = 0;
>   
> +	if (attr->ca_is_visible) {
> +		mode = attr->ca_is_visible(item, attr);
> +		if (!mode)
> +			return 0;
> +	}
> +
>   	inode_lock_nested(dir->d_inode, I_MUTEX_NORMAL);
>   	error = configfs_make_dirent(parent_sd, NULL, (void *) bin_attr, mode,
>   				     CONFIGFS_ITEM_BIN_ATTR, parent_sd->s_frag);

