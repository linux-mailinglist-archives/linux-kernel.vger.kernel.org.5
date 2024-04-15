Return-Path: <linux-kernel+bounces-145027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869668A4E75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E381C20F88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326F67C53;
	Mon, 15 Apr 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="n8I29ZR/"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A212627FC;
	Mon, 15 Apr 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182752; cv=fail; b=RZd0bqVWfglhgOdqSDUj/A8pDiSHlQjg7MAl/QTtZJJ7arC7x+enyi51OoB77df+/9sQ1P37Io1aiYolzlmcESXPcoK5lkCVDMgZXzREKyOQd6hak6d6vD2Zgpaxzl7FP/fusXCBc3f+zeWaIYnrCSBqb5pLrMfwRRUDp6G3A2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182752; c=relaxed/simple;
	bh=Irkaecu0Ah+c5ZMbI8aU2GY/UiolxcILPpCYbN9jn7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYx3oYaP6tUPZwPuV37gvXKsxkIWZJpvGypl8NCA2nnNshKamj7QwLJ2d/qvqpmS4DSdBO0oY7fToLA1hvGG0WDISeuiHUyHnyo/HAWzD8G4jwX6LxlfRXpcF2zscSr96W+8NW+XvobegigNsw9MP3c+0ZGZjmhXosgNYTjrHhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=n8I29ZR/; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXvRYhc8qPLoI6hZPr+PBVwJqAa5Mr/PUY5lSnzaIpF1ZqWOUFfduXMtkWeK/1mxjmcu+/cY4TBQxUEuMky9hi3W+B8boXhn7Iq+JxxQurMipZPG1TlIJ28MqnmoBGe4v2Vf4xCIzkrSz9pQJskchpH/8JOjJbQu2tEjhtVfsZxFV3k1aqSpUTqyZMSQu9TQDcUAwH8Hq5eDe4MO3lpQXXV/z5B/cMLIO0uajHB48/koaleT2/qui1lVXLibwJSd40xhNAjIWikm/W4XKDzer71OmTrXd0dJuVbrNnTBc0H2NvfUr5EHnXSzekDE87FUTA/xY4d5hnR1RadJnSYMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laDMX9IZGGE3T3FLSLlOPFmH7WYdRpsTxMdaZ7Dnmuc=;
 b=GKF6MYCn1lkx/LGK3ecmgrP7iUaRDRt25ODtPBSOwldQtkP2EWZU5r2rSynDpJPQlaoSmAUZ7mupNFsqIPW6q09jTJHl8v2I8iHrjMIQPojdNxT0l2ATqCWvOjUozpcMu5R+5udC5Ps1k19zax04gzzVZcl8myxLhH8Q0GA2vcohZTAd/RFDXvons+TyuH4Po8IFWigXz8PiOrsS9NqUuWBbOsrb0WFrA6sdBHiJ1jsg6XMHYI/8HwZfwmC1Sfg3PWxFzLbqfzw19XBeF6HMjptchkmiwI2wsCjUY1wR8giTX4TENL4bGaussUUNmXddkyZDHrssZ69O7mWVXAZ/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laDMX9IZGGE3T3FLSLlOPFmH7WYdRpsTxMdaZ7Dnmuc=;
 b=n8I29ZR/QmWHVrg1p16CrIhNPhfEKU2g0TdiWU53QhITBjuChJXvnm7MqoTbsFGfcNGIc+hgkbOq4vr0QtJdKFmgRiJceG9Oi6/Yt50bOyspDGawcnI3wdMDlRU1Xk5Ae7mOdXhHYbs1NRgehmg1DLlNy1VlUqODSuAraEwFEi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com (2603:10a6:20b:5a4::17)
 by GV1PR02MB8562.eurprd02.prod.outlook.com (2603:10a6:150:96::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:05:45 +0000
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::e3f0:db9c:c11:90ff]) by AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::e3f0:db9c:c11:90ff%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 12:05:45 +0000
Message-ID: <f0053de6-d96a-99b1-cb10-25a15f676cf6@axis.com>
Date: Mon, 15 Apr 2024 14:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] smb: client: Fix hang in smb2_reconnect
Content-Language: en-US
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>,
 samba-technical <samba-technical@lists.samba.org>,
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 ronnie sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 LKML <linux-kernel@vger.kernel.org>, rickard314.andersson@gmail.com,
 kernel <kernel@axis.com>
References: <20240409112758.467112-1-rickaran@axis.com>
 <20240409112758.467112-2-rickaran@axis.com>
 <CAH2r5msm+xFyMPCJV7Luf6aQ04cHOhevmjJi8J-2Bf711T1ziQ@mail.gmail.com>
 <CAH2r5mud2YyUAT+n4M5m+gZK3e=Y61O0LwTATw+BiB-oz+BBWw@mail.gmail.com>
From: Rickard x Andersson <rickaran@axis.com>
In-Reply-To: <CAH2r5mud2YyUAT+n4M5m+gZK3e=Y61O0LwTATw+BiB-oz+BBWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::20) To AS8PR02MB9505.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a4::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9505:EE_|GV1PR02MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6cd6e6-7a70-49b7-c1be-08dc5d446134
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1EkJpIkHyGupTjkt72yIHvPFpvWaTHS1ei/3WTpk/AuS2XoZrKibDOzFS61pnLi5XazKYzbXWuxqFWqiesWM/KGTFnB6ftJHqr3Hyqq5RSXSpbakx8nS4gYSrmjBlT1ZU8ONpyeSP1bbL9s3PyhCDrVgeYwvRw4xTVJrKwwpM6KOrSLjquocNG8Sicj1lM4LYCo1fHHY8ZMUHUMGpa9k/cnjOIYB1AS3nV6EauA25VFHgivlKG1RnvSxKMq/qfvmfj3XKJ7xNrHV6GbG+8B1fb5uljI4ZfXGwmUQfcDu/ib+mHyyLtAxrg/K5SlBBdUUkuVq09G2rAWh4Tw1mC7VR5C/PmE200T93k6TCOsJKrvemsYLgmgGqmbzG45gFXO1lYinferwe9MzMy0lTMCI3uSVdtXQ2lvp9bknjajP1fUdsK7cRdMx/4GXpwKC23ToQA1FqoRgda9n+u90ih91jpFyPNu7CkJ90nWiFw/N3gRyIHJ+zmN/T46mYhPqmAjV1BpKSnatfrLcpDmVKPx36I3l4saaNMSoo9457BA8mLpgCd10FJ+HJ9jBlBn/EPJJK4GYW33OdyOhiMB0V/5PrLhbZ6mEEetzW7IYpuDKktN6i/hL99EdGN7Ij2byJ8z6dOzBSdYb3coF/I9XQwYmdimWIKcj+vpquISX6pDUM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9505.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlR1UllBUlFVajY3MDYxRzMzWURweDZnajNsNWMxcG9UVXBhWFBmUkZCRFlw?=
 =?utf-8?B?VzJzR0JadGFLL3hVUmNyQjNST2NRejFMWGcvTjlqNE1LTE5GbURmQ2p4bmRS?=
 =?utf-8?B?QnhKL09ENHR4amxIRkd5clpsNGtlSjFJTURaa0VKZnJ1R2k5MHFicVhaOVY2?=
 =?utf-8?B?WGhuZlVWV2x1d3pvRlcveHpVQlVWR3pyeU1kZ3dtM3RBN2dVZ2hzcFBhVEJE?=
 =?utf-8?B?UEVhZmVFbjhrd0pONDMrNnFWNlRnTjd0ZEdBSCtiK1VwMG9zRFFwdjFzZk9z?=
 =?utf-8?B?dG5VbW1qa1pIcno4cFZhT0lrTmEweDJzT2VTQUNHcGw1SW11LzNZNnY4RTE4?=
 =?utf-8?B?R2o0OUlSdUd6QlpQVHRhTjlYbksydi80KzhYbUI0UmRpSC92WUFqbXJ2Tlln?=
 =?utf-8?B?djdCdzVtTWs1NElqbVJrMVNLajhMc29EbnFWbTh1Y0ZnRDBzYmQ3T3g4V3g5?=
 =?utf-8?B?YlF2eE0wRDBQRDFzZmU5U2VPejRUMFNRcjNkZ2dudG5wcDVadU5lMEx6L1Zr?=
 =?utf-8?B?WEJBSTJwNWh2bFdkU08wTkdZNG9yVm5lbkkwNVFTMUNxWVhWUHNjZEgwOThJ?=
 =?utf-8?B?ZFJkNUpxQStYUU44eVc1TFpwK0RHTHF4emJUcW13Q0ErdWxrTmRSUitNWkN5?=
 =?utf-8?B?d2JPeEdJb3NZK3p6cURSOG1keUJqdGVVQXZPZlhVUUQvYldtbVRHWEdUak5I?=
 =?utf-8?B?Z01DWkVsZ3hRek1PR2h5cm9lczF4Zm9TQWxGK0xGY1Z2d2RRcWZ3anNPOXBp?=
 =?utf-8?B?VTQ0aXhHMXRuQzNTZEFnUW1mMDRnU1BYcW9iaFBweWNPOEJrL3daTG5hVWJl?=
 =?utf-8?B?b2dTaWlOZXFHMk9FZ0xDR1RnaHlRZDlMazdyRU56WHByekZldE9Ed3A5YzNt?=
 =?utf-8?B?L2NNOEZDa3hqL0RXa0NNcFVkWEx5VkU1RkdXalFEMmFIUmNOeVdTTEtkb0p6?=
 =?utf-8?B?bllDVUtyL3FlQW1DWGViTGh3bEw2WUdQNUU1WldOSFVleSsyQ0FHTGhZVFJB?=
 =?utf-8?B?dWcwbGU0ZUYvVXY0S3NKSStyQVgvSEZnMisvNXlFanhtd09mblZ0VVFERHJl?=
 =?utf-8?B?N0Mwd1pmMTdyWVdrMFZ6TDdTWkdJZHFyd0RpWlVBWFMzSjNBb1UrN3ZrejBB?=
 =?utf-8?B?eGZESVU2YnAwdTNVaWk5OE5VSmg0UDd1LzNDdFRBei9IeU5aUzJTWHVhTkp4?=
 =?utf-8?B?SHFHeHRKbmRYSTZkZ0VabDF0aXVLNlcvYm9Ralk3TytaczQwMjY4OXhGbTFn?=
 =?utf-8?B?UWVFSERkTUNVcUlmaStyanVteW9idXk0M1VqbkRuSVBUN2k2aHdvMVh0NC9T?=
 =?utf-8?B?ZFlFYUlMNlp4eE9KMXZmRDBPUGtwc2J3c2ZSRm5LdE4yQnY5WGVhOGYrZC9U?=
 =?utf-8?B?SUhuTEZpd1YyK1d3SXhxZy9ZTG10enlSUHFmcXZIWk1qZHRkcG9adS9lZEJ4?=
 =?utf-8?B?TlE3bUsvUlNCY2FJbGZNamlHYXdYU0JJbjVPRHl0andycG1UcXJEcFg5NkE0?=
 =?utf-8?B?M1hVVDBUUXpwSTQvdUlMcGpvRnkvRFRhWHprTGVwaTBFSC9GSEtjdFgvUERl?=
 =?utf-8?B?WE1aMGo2UGtjY0UyeXQrb2xkcUNpQ1hlSDVwNmllNnVPd21oY1VmcXZGazBv?=
 =?utf-8?B?Yk9XTFFoVnN3RjVsbkNIcjdDUDlvM3cySjF6N09UbkFRSFFYTTJ4U3E2R1RI?=
 =?utf-8?B?aHZWejc0MU5QdlR2cjRTK0pJMFhCQm1PdjRva0xZVk9GUkp1M21iVjk2T2sy?=
 =?utf-8?B?TUhVRlMxbFhpcE9ZWjVIcWdYdEE5VU1BdStpOGc5allvN0NJNVdqd0NmSkJh?=
 =?utf-8?B?NVlta055OS9aNEFUbjZSQm9aYWF2SHMxcVJZR1QzczBFYUs3YWkrdHVCTzl1?=
 =?utf-8?B?cHVUUUhYS2hGK1NraU91S05xRXJ0RWZ4ZWhNQWJiRENoMXVMbnNkdTVOZVpq?=
 =?utf-8?B?TlV1TW5Jbk9rSld5Si9STHpicVdJbnZOVDhXSDY3VUo3bjg0U3R6dU5HSEZn?=
 =?utf-8?B?cytJc1VkVW1LVVBqQzRVaWdHNnZTMHRreEpxVzVWa2xKMzN5RkVJV0xwU1Rt?=
 =?utf-8?B?djFLS3NzU1RaT1oxN0tqQVlyNlVBZTlYaGJaR0lGLzluRktYK0tZa25TUTFZ?=
 =?utf-8?Q?pUu2nVGzltBbmFnu1n2fFO4bF?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6cd6e6-7a70-49b7-c1be-08dc5d446134
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9505.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:05:45.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le4JU7EysnMDkfytIVJFoXP399dkUueQPtT8zpxc2MeMV4O50dVzm+S7yDZIcMa6yZ/X1EsXEd9V8wFPLITIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8562

On 4/13/24 21:40, Steve French wrote:
> Is there any way to verify if the same problem can be reproduced with 
> 6.9-rc3 or later


I have now reproduced the problem also on 6.9.0-rc3:


  INFO: task umount:511 blocked for more than 614 seconds.
        Not tainted 6.9.0-rc3-axis9-devel #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:umount          state:D stack:0     pid:511   tgid:511   ppid:509 
    flags:0x00000004
  Call trace:
   __schedule from schedule+0x34/0x14c
   schedule from schedule_preempt_disabled+0x24/0x34
  schedule_preempt_disabled from __mutex_lock.constprop.0+0x330/0x8b0
   __mutex_lock.constprop.0 from smb2_reconnect+0x114/0x8fc [cifs]
   smb2_reconnect [cifs] from SMB2_open_init+0x58/0xa5c [cifs]
   SMB2_open_init [cifs] from smb2_query_info_compound+0x1a4/0x50c [cifs]
   smb2_query_info_compound [cifs] from smb2_queryfs+0x64/0x134 [cifs]
   smb2_queryfs [cifs] from cifs_statfs+0xc8/0x318 [cifs]
   cifs_statfs [cifs] from statfs_by_dentry+0x60/0x84
   statfs_by_dentry from fd_statfs+0x30/0x74
   fd_statfs from sys_fstatfs64+0x40/0x6c
   sys_fstatfs64 from ret_fast_syscall+0x0/0x54
  Exception stack(0xc749ffa8 to 0xc749fff0)
  ffa0:                   01716218 00000000 00000003 00000058 beb62b90 
00000000
  ffc0: 01716218 00000000 00000003 0000010b b6fbd138 01716448 017162a4 
beb62b90
  ffe0: 0000010b beb62ad4 b6f0861f b6e87866


Best regards,
Rickard


