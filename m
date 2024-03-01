Return-Path: <linux-kernel+bounces-88873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571886E7D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680261C23192
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0118AE4;
	Fri,  1 Mar 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a86RokVp"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E412B72;
	Fri,  1 Mar 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315748; cv=fail; b=mynGDpMNJMXfE6UBHMITxLSxVaDd9FPttS5eHOq3pLISh3SDFNdWFXcGsnQhcKP81b1N0ca/qCbm34N6zbAwFa6Cw7/J2CJi978b+MQmTtkBA0YoH0H3aQwdAxAypaPVBFjlpsQWC4GLJzyHvd9xYgqt0rtRUROg675KWvJzq10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315748; c=relaxed/simple;
	bh=IzQh9p3DLgNT4gSXaUqEdulM7ZZJEwNgWYcH1OK/JyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bzKh0A7MnonB62DZV4I4Ju/T7MFJiU8Dy4LyShfVGGvvVuAgUplCGIxtNKlC1p6BGd8gSW6tvgCoXlntRI09KFNNk//gcaU9LQeV+bM0bkF0oxUY64nk+7GtVBUO0CPwH1SMMBfJV86l43uGQ4/O+7Ly/dGhzB5vjy/1/4QnKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a86RokVp; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4cODpGcdemNXGGB8D3yUVqeLFzjJPpNGjTNmKRFHQ13oxxEeYDTFdPUIwl/N3JFvEvS6Jm48kgHqK+i9HjjzD+yjLYmvGHlPgNHaALK53hGauSmlLUf/3tGwEvuUIZ1I5KHLZyDd1geYBU/2CR/3g9gECypD8b5/QeCKtWm61RGJgFhlnadmT0EoQhD+3Jx1qlHvG5ujQcxzRSjwRGAgc1pYE5MHLZrr9snDEsdYQ/SqHF8ZF9/7ILuWKWaJ/z5g5Y/EZYo/9VnZSs4F/yb1rMmWDTx9dEem3VGkkH3HU2A4wIOGz0Djs4zB4KFPX2Ma3l+kuOv4/TqNGhfOh2m6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoHcjmoInkFiH0By34KZONszypEEwKO9Cfm3UEYZVto=;
 b=Eedt6ge4TU81cXBi6BUZVsMuhCDXqczCDzaDI9IrhAJT65jWuvK9iTz8jXq81TN6WLoQRWH+7/8O+HLGJ7dHRyRI1uFColMC/MJ+1NqmECASoJ4HjAtf/L9n7wAKSRShg+wLur9QAGf2ihpcFnB6/nVKflu0cm3fVXZvT39yUO77oN/oCHYCdKgJd478V+FmFAtjTa3gJM/gDVuwgqw+ELgFtC+BHmce4pxx75TG+63ffJ4lfbnOMKBdigEWzF4beRXOUcVWI8MTLKohiVAKn/Kp1rFsgpFliX1b0Ywb5zI30BMQOImuBwrTqsx9OvWKCNM3VO0bliPQENTZq6gTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoHcjmoInkFiH0By34KZONszypEEwKO9Cfm3UEYZVto=;
 b=a86RokVpCSxi5HHLlVQfb/adhy6PHVI2qFCnjl9NpIha4ksm5//NvmAqDmihr6u2Udy/F66bVe9FsQ0AbtsrNxXOde4AQoG8OAV2/X0T3TsobNk+QqiXL4uqjbnWM8WJHXQ/TxymyGU7o4Kh6+znB1nD3WINcnYuRlePsbHLHU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.34; Fri, 1 Mar 2024 17:55:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 17:55:44 +0000
Message-ID: <333dca5e-fae7-4684-afa8-10b8fdd48bf6@amd.com>
Date: Fri, 1 Mar 2024 09:55:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_core: Fix possible double free in error handling path
Content-Language: en-US
To: hyper <hyperlyzcs@gmail.com>, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jitxie@tencent.com,
 huntazhang@tencent.com
References: <20240301022325.20861-1-hyperlyzcs@gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240301022325.20861-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:510:f::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: afb23faa-0b64-41da-c1a5-08dc3a18d102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YItVc5u8llr8vMSeZdY5EqLapiczO61MrzRRUdqGtfz7s1XY9KijokVMSa9fS23loWsx4u+gaRDSy02tqmSfGsXcnS8OV40/GY5Do2gHII1b8anviUXlTUxeRsIgsMoexnDA2a76mSNGwC8V7xd+4PAxBpH1W1P0/Y86Sw8oJMJ+TayLaXghuh+AVl9lOotsE5QqQ502Rk1FoCadUqqIFw8XWcM/yjsG4GcjsvR/UtLBd1V4m/+iW5LtxIjHM5sfecm/4y4GvoI4j/6FJmd1wG4NISQv5DMjY5Rv57nsnxIJJbWTIudVRz/sXTpfW6oW3RUFRO1q1Mq1+rpoPj6B6QCC3MPgQstEkzS1o8LpiA5pBO14BfcH8elQOgy442StQPBrjyQsktla7ANK/3zGXZaQALh2Yq77zqfhW79cNIz2VynhBWlgBNvIrjqMNLQMKtoIAN4RFwz8766NUHm7fNvjxz7hlKWjzUHrgqz88bN2jaaYtKb+MQWy4a5PvsfYAM2HkD4DWgahEMSrVUJerLUCWcqT8viSY278a1Z1eX/D1nJoAM33yT96iR1XxfMoC9ectH7haPnyafJW7+xOZKveJaNT02Agpl7Jodc0LCL5qTDHvWQ0I8rWeHgdqoJa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmNmcjloN0pEZk9NNGtiQ0V6ZkxiYzNtcU5MY01xOG5DTmJzWGtwdFR0ZDJE?=
 =?utf-8?B?cm83cmszRkVGOVlVOFNHUDJOVlp1Sk1PRllCWTFCR3UrU2NMUWxQM0gvejFs?=
 =?utf-8?B?MU5KUUduV1JjeC9QUkhONVBSeStHYU9TMTBPK1Robk1LNkMrODBubXVFUTRP?=
 =?utf-8?B?R2pRZkNFV0tsRTNiakhzN2VkYkR2NEJLc0I2ODdMTmJkOGJXdzRHbFM0cGhh?=
 =?utf-8?B?SnlrVnc5aGZ0dEZkWXR1SU4vb2g2Z3gybnp5UVgzSW5sand1d0tFSUNDbHQ2?=
 =?utf-8?B?SkthcVF5eGZPVGlDRGtkOEhlZ25pZGFpdlZZTnlHRHhLcWRhaDlBRGdHN0ZZ?=
 =?utf-8?B?b05IQXVtYUVtN0dsWVV2RjZTeVRQdmJEY0ZISjVhWG9WMjBvU1lYakx1VCti?=
 =?utf-8?B?d3Rud25kTEl6ZWd3U2JOYUovcUlXOXRQeFY4dzhmTHc0MDl6RExqTG9HTlpL?=
 =?utf-8?B?cG03cVZWODhRbUFqZzU1K1dLMGt4KzJncXN0SGFIc0RQYmNPVWMydXN6RUlU?=
 =?utf-8?B?TnVrc1BOQ25wRWo2dVV6YUh0dnFPbkJOclpDZG0vK3hVbkt3L0o5ZExRZC8z?=
 =?utf-8?B?Zy9lbHhJTUNEL0ZONFpSeUI3TFBXd2F1aVZQeFcwVXpnR051UGIwVEpKdHY5?=
 =?utf-8?B?RG5XUUhlZHcwSGJBRTVJeHpRaWJaQzFQbkpWdG1BbUxSU2JsS1ZqSjdtTk5W?=
 =?utf-8?B?a3EyZ0NyMTNyY2xpdTkyM2N4c01LMW14V2FWa0szOU1mZUZydWppTGJVMkdt?=
 =?utf-8?B?eWhSeEIxZWo3UVRGUUJvVlRlN1RHZkFOeGViVmQ3UUJjVVFyTGdBRGZNNzZw?=
 =?utf-8?B?V3R6RXlIVVp3RFBYN1ZSTWVrYkxOMXpwb280eHdQNDZoN3VhMCttbFJkNmhu?=
 =?utf-8?B?WE80Ukh2aDY4MzBJT2s4a0g2dlRNUXFZVTNSS2hoMllEQXJ3QWw5SXBHRXBx?=
 =?utf-8?B?dnV0WUZMUE9yVit4eWw2bktRdnZTWEVVakpRZGtvTzJEUXJvZ1VPSFpNNlRW?=
 =?utf-8?B?aUY1UktJYlI2YXNrQjhmTUJmUGdWOEcvRzV1ZUlRTWJMVmNEekRGMFQ4Rndv?=
 =?utf-8?B?UE15d2NYVEZCOEdXL3FSakJHUVRPL3BPbVFlaWp6WW9RS2hvaXUrbXRQRTha?=
 =?utf-8?B?R3JjMVFQMTJXSDdmaHVMZDFVU3I3UGdQM2dCY1VJZ1REczh6YjVYck0yVExi?=
 =?utf-8?B?N3RwRFdjWVhTejNaZjRYeWJSS2c1ekJUR3AzQnQ5WHB3M3BSVDBGbGp4c1Ay?=
 =?utf-8?B?L0duUFg5YXl4QktKdzNBaTU3NnU0Sy9OeWl4M2dMZWRUaGZBUE9DSUlQbHJH?=
 =?utf-8?B?ck1zTS9naHlxTTVPZmZHbVdtWktRUktxaHAzL0t0bExQUUVmbVVyaVQwanZH?=
 =?utf-8?B?MmFJeHcrVEZBYk12UElyU2pZZGVmc3VKaCtOSHhKL1ZyNXRNcDA2Qk43eXpC?=
 =?utf-8?B?eE5wWlRtTmVzZFBXRTg5c3UrekErOXFNVUdGK3ZYMmhaT1gvb1U3a3VXcGhM?=
 =?utf-8?B?YWhtTW1GcXlkYTc3MEo1VTJ5Zk5SMWdsZG5VUGpWUDZ2b1pDaDAxbkUrcmF6?=
 =?utf-8?B?VVptZmlaNktuYUE3ZzRKMDVDQ3VuUjRlVmpCYTlRcjFaWFBSZ0YrOTh2M1Jj?=
 =?utf-8?B?cCt4UnJuNjEzWVhCQ0FJTDE1ZWxpcFpTbzZHVDN0WWxldlRoQVJBdDJpMjVp?=
 =?utf-8?B?clZhOXBUV0dJOUdrNU50LzZGOGtKVDUzZHAxc09abXJWaFgya2N3VWJpVEU1?=
 =?utf-8?B?Y0JLVFZmT09vcHVGZHVYYzcvYmZTWEhRTzJrak9KdG9DN2lSMjhOeklWcUM3?=
 =?utf-8?B?dXdnY2lYSUZ4cUZGS3A5NTVZUkkwWnpQcitEVFhod1F5VjFjTEZEVndMb0xu?=
 =?utf-8?B?ZFJDdGVyMU1MWnpBdFFtOXVyMWR1K3p0SEpMV3JITGpHWFFOSEpRTW84YVpu?=
 =?utf-8?B?NW9kYjFzaFd2aUVCUnpvaTlMS0FDdmhYaDZsTjhaYncvak5DajZwRmJwTTdz?=
 =?utf-8?B?MnJUMzRDcFJWVTZyVlZETiszTGJrVm1FWFhTU2FGMTZnaDFoTXIwdnZjYkc1?=
 =?utf-8?B?MmJ2Um8vYnJNd0x5TFNOWDRWTkxISEttRUp5N0ZsVFdUOUJBN0FqcCtWZGZj?=
 =?utf-8?Q?exGy6A7kYm3AaCzb2vAc8c7PQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb23faa-0b64-41da-c1a5-08dc3a18d102
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:55:44.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwoxJvU33sSOAtnjKRWgpCvrD5zF2BLYHOctfiAs1F6wXMgQ6gzY9Ex+rQHEYJppYpG7uDEU3x9tvmz9mTUNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

On 2/29/2024 6:23 PM, hyper wrote:
> 

Please specify the networking tree in your patch subject, something like 
[PATCH net] in this case.

> 
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
> calls kfree(padev) to free memory. We shouldn't call kfree(padev)
> again in the error handling path.
> 
> Fix this by returning error directly after calling
> auxiliary_device_uninit().
> 
> Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
> Signed-off-by: hyper <hyperlyzcs@gmail.com>
> ---
>   drivers/net/ethernet/amd/pds_core/auxbus.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 11c23a7f3172..d6eedd78d5cc 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -174,6 +174,8 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
> 
>   err_out_uninit:
>          auxiliary_device_uninit(aux_dev);
> +       return ERR_PTR(err);
> +
>   err_out:
>          kfree(padev);
>          return ERR_PTR(err);
> --
> 2.36.1
> 

Yes, I think you've got the right idea here, and this is probably a 
reasonable solution.

However, usually the error handling exit code stacks on itself, but here 
it becomes two separate independent chunks - a slightly different 
pattern.  Since these are both very short bits I'd be tempted to 
"enhance" that independence by putting the error handling back to where 
the errors happened, something like

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c 
b/drivers/net/ethernet/amd/pds_core/auxbus.c
index a3c79848a69a..2babea110991 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -160,23 +160,19 @@ static struct pds_auxiliary_dev 
*pdsc_auxbus_dev_register(struct pdsc *cf,
         if (err < 0) {
                 dev_warn(cf->dev, "auxiliary_device_init of %s failed: 
%pe\n",
                          name, ERR_PTR(err));
-               goto err_out;
+               kfree(padev);
+               return ERR_PTR(err);
         }

         err = auxiliary_device_add(aux_dev);
         if (err) {
                 dev_warn(cf->dev, "auxiliary_device_add of %s failed: 
%pe\n",
                          name, ERR_PTR(err));
-               goto err_out_uninit;
+               auxiliary_device_uninit(aux_dev);
+               return ERR_PTR(err);
         }

         return padev;
-
-err_out_uninit:
-       auxiliary_device_uninit(aux_dev);
-err_out:
-       kfree(padev);
-       return ERR_PTR(err);
  }

Some might disagree. I like this a little better, but I could go either way.

Thoughts?

sln

