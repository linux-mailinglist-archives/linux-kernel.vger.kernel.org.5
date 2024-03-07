Return-Path: <linux-kernel+bounces-95221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C5874ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500101F294B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A283A0A;
	Thu,  7 Mar 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rMSKzGS0"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD176C8D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803745; cv=fail; b=dfWBALujyYEEufL4NXi0iYJZ+c7/VhORHy8YjsyWYMB24Wx64or0RG+pdMux4iSeMXtoD7CG/PPAR2nRq9IEnDWm0EdSgv+maCkmw2aiSA+UINSjLNGbg8+fVqRdAjuh62xtgHpYtizutFI45nZeMtZM6pH5N1MtDgaapR1je50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803745; c=relaxed/simple;
	bh=NltZbIoftRGcVf3pK0yg6Q4NsIGsrSAd4WkEdJ1YfgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZXoug/Yzm9HPYg27Ulf8UJlpzxfTpJHrfEDRvhUxpa07KAvjP+VS/316VOq7KsTzyScVnnom/AGQSXwDPXP4/mv6VGZyTAhJ9EDQGssjtbcncE+yZ6pYO1Jwbkjko23hQTWLkbd/bHKWlhnm5eSP//75hHHC4KB0lk6OK9pemM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rMSKzGS0; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKbFRDJtYDrIuM7rPHTkMtDZOcgK9VY4U1rnLnLcFVjMbigIPCx+WJJn3nLHOmxBUrUu7NNMBBX8A31LIvP+Cra8IMuwahksBur3xVs6aV36s7DdM2syD4bov7Qfq2LRd7XtvVNDqrbh8hRTJgqSWA4I83Q9gc+HPhphVK2N8UI81zCnzW++JLEihcgaGtQv5+9sdfdSxjmjVo9cyncdeRr1wG2D42sqFziS280zyNnqnFf8FYEpK42LaJ40en3aHPZAKC90T+ugur/1nZWKbz59bNzZw+60gm9icUKRUL76SAOjKs65Yi/MLSk6eeUiseRGPz4ir/BrejagJs67Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPn90cefn+KkbfnXmcUH9bYS3VAL4AEt9EhaXSuJmwI=;
 b=DQs2MdmgW3PyZJ79mPP3DKT5VDeshJ8sz0W621keaS9ElfxWOBuuP+y5fNXXbymmK/1eS4BJv00mwEzpcRlUyyUmIFO60hDBr+ujOPhAVpno2yuJ6lTUB2V1hFSjShl6tm5ZGv3BxliBa6cBoWmyUakSwnjhVx6yX8Vu6+b5Pp03B5+F6T9WgEKOPVhAEaiPsLnbZMVjsJYCowYCii5kR/3MwNNrmnG8anuVkYmDC/DBiUti2LzuO80Z/VPcmxIqizYsGvPw+waIVsYNvLl6+750CoDa7QzGLQvhrdPseJZLBrOu+hP2pW0a3N7q4h3JQMn98Dxj8nyIUqqv65WsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPn90cefn+KkbfnXmcUH9bYS3VAL4AEt9EhaXSuJmwI=;
 b=rMSKzGS0MpXqXlmlfkUpIpLP6NcYsFSfcCs9kg2Y/K38IPWZoTcY2vRoc0G6cXRV7hl5riWC2RCJ28rLoQY5HTwZ1OTQh9YzCozwymH+ZC7k7Vu/QjhwZesomjBYUNwGhofSr1J7t22HuEJq7f/M1/dIYwhjCopilwwhIkrwUXINEgkdwMCm+ApOVvcrhLVDP2cGwFEIfRW+n0qjq+yLQDED/EWdLMoJASE68xl8IpjlhNfOFsNR2D3biFwC7hMERbfD5iL3uioMqJ2qzRtvpEZGN/2TGV3KpUldBXpdgkGQDN+SX25EwQZWIaWLftkkDM7dDrwoLPSfMD/X6Dlwbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 09:29:01 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 09:29:00 +0000
Message-ID: <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
Date: Thu, 7 Mar 2024 11:28:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Content-Language: en-US
To: Len Brown <lenb@kernel.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0601.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: be61e20f-ea3c-4c00-93ff-08dc3e8905bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pT/aTAzuNJRh0zDpjAYekuu7gWPKXCAOJpE3vpMddM3iMhiGBtuOmtt6PGEBJOriqaqB7l9b6yhSHZnkJJrC+ZUXK4M4yA+80iOu2iFo0HgQZFk2q7ZJKlv/6+3hedHzjgwFdm9HuRdkyhTpdPDNbvlMfm96IGDaF4KOlRTDw8NTzwoI8YvDkhzdKIl8WWtCX6VdW5N3s0j7Gu6M1OX+ksybC9i/dtCfEOz0D0N/+LkjULDG2cAQrdpSPbB82RLKZ3HusdN3YpQ1tRAvfm0UY4TW5cAXVd8VMu4cOKddO3WlfTjVY9nQc75LooA9EUCBD3Upv4kPozpLdigxPTS0K9FiA/MfdpTBgMdy20dCwJY5TE7Zuyb/oyZ9bi318xSY7ECouPmKkiBJn47tklrRoxPDw7ojvj+RKS+wHTomPgCZyU1+kP1WsIC4l2wxLot3/EBmLisit+181h7JDTeLoLsZthi4dOkdWHJqIyhnHfe1EFWjWLKAHq4PCWnhLIEngodkBVb2PShRMPdljJCY1g0+UrLp3O1E7Gwx+a7CyWjXdZj+06wOSfpbCEAvm6LGMIlvkrMlG9KXHZswkLkF/cmuKgqfZOHpptulREUoM6Wi1VuOiVVLUCfeVHS9CP14RYS4Se8cr0triuEypZQRfhemd1T0FvmJlUJ9zj6qIAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW4ySDJMeURwWmtRRHVUMk4rbXduNlNKUFQ1Nzg2SFBwL1UrT3J5NnJxRHlF?=
 =?utf-8?B?YjVqaFVHRjVmSHhxV1FZMnVHWDlHZjg3ZnY2MTF2RmhLRmpxUGNLZm9ORmw2?=
 =?utf-8?B?TFE2RWJzczc2ZStiYmdheElkRElGVFAzMStsSVlncGRsQjF6bDRqOUgwend0?=
 =?utf-8?B?WklRQVpnWmlFNUMwNGtvSm9CTFNhUDdBLzhSQi9YZzRjQjB2YnFIVllYM24x?=
 =?utf-8?B?Y3RrYVJFRTRuRkpKWEc4c3luNXRhYUV5OUJ2YVgralJhMzdwZVVIU0ZGTDF3?=
 =?utf-8?B?aXhuQjE5UWlQTkY2TFNsWGdKLy9xK21xYzdiRXYrQmlsQmJIY2pNaEVsN1U1?=
 =?utf-8?B?TC8yQmdiNVhRZ3pXN0Z1VTh5ZzlTeEpUaDlBYlFpWURtSzRoRFhOZ1czeU1o?=
 =?utf-8?B?cUVPUE5aQTlDTzc0OUF5dWhQVFdFaHgrRldnMjZNTlJHb1BxV09RNEViTHhB?=
 =?utf-8?B?N2piUFY3MTdhYVFNN1kxb1p6M0xHQzJOZTlOaURxSDIyV1BNYnBhamdUWndS?=
 =?utf-8?B?bW5nd2FkMW9xcTNpOUkzZnlzS0sxbEFQZkFLV2V4aDkwV3NqV25QQVpkMG5z?=
 =?utf-8?B?dVN4UFVPcnpYdUpCUjJEbmcybi9QTnZHRnFOTks2WkpSdkx1RXB4NXc5aWZr?=
 =?utf-8?B?VjRtMGJUMlJuQldvd0ZtWGpEdTlid0ppTGZ6NFJOeThHUi9hZ1BibGhKZlBz?=
 =?utf-8?B?dDM2Z01HUTlTcmpZS2pDaE5hSVBNOU0xZmdqOUlEZTVwc1Z4QmtxbmxiNFpo?=
 =?utf-8?B?MGh6T0xhdTlRZk5VNnFKQ3puZ2F0Um5URklWLzhQV1U5VjUxT3o2YUFVMEJN?=
 =?utf-8?B?NXJWc0lQemdLaXA2dDlCd0hyTnpRZWRlN05ZdWxCY3RrYXVkQkw1ZXBKK2Nn?=
 =?utf-8?B?NTVIeVBkSGNpT2dxS1liY3VKZjg3RnZ2Tk5SeUc0K0RucFVsbzJUb0VkWmd2?=
 =?utf-8?B?b01ZM3NJakxzam9mYjkzbENHWVZNemUzSTc3TGMzSkJVcUVtTmZoMlg1UUgy?=
 =?utf-8?B?N3l4d1lEWG44YjhxNVkrakZSYjh1a2VjMURKSE00MEVoZExiNFlvaURZUEsy?=
 =?utf-8?B?a1MrakoyMGJkcXpkOUpjV2FSRGdpd1QvSEJhRFpacWI4cnJMVzcrV3VDYlQ1?=
 =?utf-8?B?bGdHM1NYTnpzTGhMcnJ0OUl5a2llcjd3VmtaOHZ0a25rRWwwMTRCQTNMSk5a?=
 =?utf-8?B?M1kvWVJkMzlpTmtpVWkrdnNSaFFQclFQVzk1OTBWK3ZQaFVYUXNLN2g5Q1RD?=
 =?utf-8?B?azBSUm1LQ2F1cmcvU25wQzNEOHZBWStxeEVnczVhY2dGVkIzbU14allKU0RD?=
 =?utf-8?B?VmJ5djdqZ2pMY29GVWYyNXc2TUszVUxGMS9wa0FHMEJ1VVBnRGZhTHR5ZWtK?=
 =?utf-8?B?cWVkUkRqSUJzZU01NWF6bWk0eDdnTHhHVkMwU3F6MXZZdGcwRDNxVGloTUdN?=
 =?utf-8?B?b0JXQ09yakZJZ1FFYThtd0ZySnU0WjRBalhpZkU5b25UdEhkZ0w5OUljajZq?=
 =?utf-8?B?aWlIcXZuRWlKNWdaM09GYndnaEhsTll2Sjd2eGF5OVJYWTFrVnJMUFZwYTBi?=
 =?utf-8?B?a2VSUlBXTlFzTHAwYXMybDRQRTIraExnNmRtai9FekQzU3VrUTc5aTRNQlly?=
 =?utf-8?B?UnpUWmM3RFB1dGMyNUVCNXkxWDVoQS9SQmVHWC9qMmFDZzE0WE1Ld3hPdmoy?=
 =?utf-8?B?dXVsYSs0ckZ1UDVUWC9pa2p2eXFsbTU1UGRqVjFiczA0UjlrVDRwL09GSVJu?=
 =?utf-8?B?cmxQRHBmU05kcURXTGhTR2ZJQ0o1Z3dXMXQ5VzV5cDNzcUNnNWZWTldkRjJu?=
 =?utf-8?B?K0ZCOVpiYnNVNG4ydW9yOFFGZEh5Ymt6cXRNdkdueTRJSHNMN2U1RTFITmVj?=
 =?utf-8?B?NVNPNEY3ZXJuT0pWcVFkMVFCNnRiQnplUzBUWi9UOEg0K2ZsTHZSOTRRSDRl?=
 =?utf-8?B?bHZxNUtIOVlSWXZnRjR2VzVaU3UrZUdSTkd0bHh2bVN6S2xlYXpON1c5Nzg1?=
 =?utf-8?B?UFBCWXZXQWZDS2dnZUU3QllTcURmZWorcDYrVE04SklMbDZhdzlpSTlwdXZG?=
 =?utf-8?B?VjZpSlFuTHZFSVlmVW9YMGlkZUEremw0OHVjT1B3YXNVSUV0L3Y3TUxMYk5U?=
 =?utf-8?Q?pkgtqdD6QZ9o8LkJNV4Vhr1Lj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be61e20f-ea3c-4c00-93ff-08dc3e8905bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:29:00.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xTbVm4hs3KVeMGa4dt414hNVp9VAZoqvQX22dc8mzLn8I6P1+sqwS7CctC5sAJJK7piFdQBMNTYqgdfNNr8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227



On 07/03/2024 3:05, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Some words are alarming in routine kernel messages.
> "timeout" is one of them...
> 
> Here NVME is routinely setting a timeout value,
> rather than reporting that a timeout has occurred.

No.
see the original commit message

"When an NVMe controller reports RTD3 Entry Latency larger than the 
value of shutdown_timeout module parameter, we update the 
shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an 
informational debug level instead of a warning level for it."

So this is not a routine flow. This informs users about using a 
different value than the module param they set.



> 
> Assuming this message is actually useful to somebody somewhere,
> let's make it DEBUG level...

why ?
I don't think it is necessary.
> 
> Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")

This doesn't sounds like a bug fix to me.

> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0a96362912ce..e361af1953a4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3205,7 +3205,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   						 shutdown_timeout, 60);
>   
>   		if (ctrl->shutdown_timeout != shutdown_timeout)
> -			dev_info(ctrl->device,
> +			dev_dbg(ctrl->device,
>   				 "Shutdown timeout set to %u seconds\n",
>   				 ctrl->shutdown_timeout);
>   	} else

