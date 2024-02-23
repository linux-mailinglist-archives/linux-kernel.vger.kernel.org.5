Return-Path: <linux-kernel+bounces-77766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828F58609FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B756B287B58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C1111BA;
	Fri, 23 Feb 2024 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFItMfhh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9DBC8DE;
	Fri, 23 Feb 2024 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663601; cv=fail; b=ryQ3bGAYN3bXUY359C0Xj2zT6S6Q5+k41Re3i9sttxWU+FDVM72AalG2skltK4BQyqDUBSMC9sTRkW3JDL0fV13F3BP8czhKD3kA3D0tp9oeAzVWxm4pkPmSoulsAsOcXYjM2umAYayebFWuTTzNywmxSfx+GVw/LCjBn6q8Zzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663601; c=relaxed/simple;
	bh=qG7rCtXi/+BQB0iReAaib26C3PyLofDDMIm8TC2A90o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GykEhGi/HNESks1+gH5frt2hMsgSm9Z5uHaztQrc/P/ik18V5FHpC4JxygD7OqM+OOiWsXxJlNvKB8INqETRIX08h1ue8SlZNEIN/fr+yabDobVcnj2jf/GV2IPMqWqT6WFsGZ2DVHq+zqcLavn7JwXQejgxN/IQctJbPZQxqAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFItMfhh; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaZNeUZlQK//1GxxiT1s59vXDj1Lm6uAeACt6Y82TWIzlZSL1aycyxY93NKnQYxCB1o63oaICib9CXvVtMJmypoWQQOVTGuHwcjgsijrQ5easC/kRXRsV1ePBFEbg1hChBBj7zFVF9NDvznTBs0MsORKTMxJIastqUoQg2xFQU/A0bOFLJC87lzYrvnDhSnGPUTns6t1Ev6u8fskM1nmAMbU80adimH5Fqqmu+TQv9SQvg1Au0NAtsW6XROkzxwOfSnnJATduvUr7ZxqntfL1B9gegFiRlUFKVBOA1VX+6kOkLgVTksFkjuTbyGSS1bJFYdPjzF6ZTofbNDppAEbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTs/X7DF7INX2lrmO7jk6w+fOYc7EzQnxXGddJH9Il0=;
 b=HZoer5HguMFzNTgSZ5+XEGT6Jxn3dyfR7HsFCnPnKGKlPti6V2DsBAfJ0vjfCb76gBGopFBCXPQaH73sjfT8xvokALyoGwp0opWXjVxyN4uaF0DJEv5DINjBa2HXTkdQSEOugzTYIVNG6iKpIipdhWvBY3pQ2WGqCrvawQYUhFLDhGbcQBXWSx9Xu/ue/84/vin73dMO+jniOA7DvKI08oPGVNa8T/0/SfM42k1jX7ZZXvoSgxiTMlZ6UGabSM1x4JeO8VVgxW8RpnKiTEdqDkpJ+JYm9TLriMN0i7+GShKo29jf96IhUfOf345q4WsdGpsD5f+eYW/yBzO9wPJv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTs/X7DF7INX2lrmO7jk6w+fOYc7EzQnxXGddJH9Il0=;
 b=EFItMfhhl2Ny4G0/xDVOS1pAGyHrAcUZ4U4BmehO48FsXCiT0fvamOWCEodG+SPN8eKgk6eUiHBVxXdFpZxE1So58quLEDScVrnBarg0hssjVz6d9re8CS3ftj7xnkv1zDoBPx5Dh0Yrkq6V7c0awMaEZXsdjhOByvjGpHrSd8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 04:46:36 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67%2]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 04:46:35 +0000
Message-ID: <03499bd0-323d-4f57-99a8-d47c5ae680ae@amd.com>
Date: Fri, 23 Feb 2024 10:16:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: macb: Add ARP support to WOL
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-3-vineeth.karumanchi@amd.com>
 <8e4a779a-22e7-4db2-b65e-69cca5e6fac5@lunn.ch>
Content-Language: en-GB
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <8e4a779a-22e7-4db2-b65e-69cca5e6fac5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::35) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e6d274-8fc8-46ac-6f66-08dc342a6a37
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vwHPx13eNCHwJ6BP1BlOTy8sAnfuwaYmooLhegUhowrb+dy+aKnDuYTKFZwYPp6H1LdF3/Dwiy98giYRS/PdmzTu8H8FmbAyPs9XONsulIwzwMjTypfIPtKQx9hxIDrgzGmN+AVovobSSVIv4W9x2u7mEWMjFaw31eSjxYIR6HJ8dfN/JeGbvlzTj6oX+hlFjaFPnOva0w3gZX5ae7Sd9jQp2ooN/9tz5BqCOHcjOW9p/5/NTQSMt2CHDJp7PntQXUsKhOCPnC7z7T1qmCrggpCPKb2geoG9LcDuAMXvgUuXRwRCTywUXFl/49y1q8oVuPRNzLxDptXwlgAm2CdzI4MmrZ3DEZ0rwkNuttwDLzUQdGoYig7U4haMRgOGJqs01PAQL9bgXXELAGlhQhYcMyZCxrA3vECLXoTtPkKaKVXIC54iyzUHknRnSrLRuQ4hO/6PwJxyg5zGuBvvCM8ALolO0lZBLYM0Hg2lQCUofX8Cv+lYCOIj0/clc8xupoOVT86JOt/IMqAPi6DBnah/CpKYa4vUO+pAgWOEyGX9J3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUR3NzVGVmVaZWR2TDZnTlNyeU5KVm90c0p5azBZUGhpR0R3bitmYkd4RXBQ?=
 =?utf-8?B?UERSZXZpalRpWWJuWmxuNGsyaG1UeElWczJiQlBvZEVyNG5OYm5Vc3o2TlVW?=
 =?utf-8?B?MnA4TUl2K2xwU2JMbjNRUDkvbDFoVWZSS0Nsb084eDZIRS9BVU41RitMOG5W?=
 =?utf-8?B?NTdzc0hKYldGdlNJSEkzdWVwZXNXdmdpWHQ1UERSU1FQN1ZuR2VwQ0dYWjMw?=
 =?utf-8?B?ZjlEdGZQdXowUFBzWHBZNFV1dHk3emYxeGRNVk5LRkN6c0FtMFZPeDB6UmdZ?=
 =?utf-8?B?dEd0Y2cxa2xCbHhZV3kzQkNaS1FIaGRrbE1nTHBQeHdaaWFadzJjY2dENVRL?=
 =?utf-8?B?SEtRMjgvTUVpdTVySHcrVUVnSlJFekM2K3p1QTZvNENleDBEVHhVNzZDcHZo?=
 =?utf-8?B?cytNcEFsa3NnQ21HWmVMZnM1RnNHTnl5YWhPTkdLZGprbEVybmNPalM4OXFN?=
 =?utf-8?B?cHlBV0xSTmYxbUU0YnB1SWloZ29mSnhvOG9NclFYZWZwRTIvV2FYaXlUeEpU?=
 =?utf-8?B?cWdLd0lnMHJnanZqTkx3K0JwaHFiMEhCZmNBR3FrbVdzcE9ZNnAxMUgxVVlX?=
 =?utf-8?B?M3pOa2dsUUZjSzk0TWVkSjUzTmd6Y2pacDFyNFRaeDFLM3R0aW1OQlhuN1FP?=
 =?utf-8?B?SUFmQmI5ak5hZ09CUitrVUh5MjJxaXozSS95ZkxRcVBOekFiSDdiTzlhZ1RG?=
 =?utf-8?B?L2M2SlA1TndNMjl0R1ZHcEEyRFNiaHJmMUVzY1laWmF4LzRISGdPN2RYajJn?=
 =?utf-8?B?Rmh4V0x0SnFGU1c2Myt3Z1JHSE93czc1dTczTDdQZVBCWktsREZvdU9PVDh6?=
 =?utf-8?B?UGViQXJvaENybkd3cnRXUWlVVGo0TmhmZXpFaEt5ZGI2NW0xWFk3VWltQjBY?=
 =?utf-8?B?MGpUWExYL0I1N0c3aXpKV1M1THRILytheHBzL3J0VnMyTy9OY2NmeFM4cTVY?=
 =?utf-8?B?ZjdQa0xBUVNkMW43MW1kM0pqZXVFZVoyaXV3d2NZaS8rMkhsOTZLS0F2L0E5?=
 =?utf-8?B?QjE2RFlVYmJyM0FJRFZmaGdOWUtFcW93ckZlYkJJRlBsNUNITXIxM0xGNGpi?=
 =?utf-8?B?bUR4M3kvQklDWEJISi9oRHlPRjhZQmIwSnQrejRyT0NWc1B1ZDYyUGFkTGZW?=
 =?utf-8?B?SkNUM0prOHQ1WXRPWjZmbDA0VFBrdzYxYkpWRFZQUzRXTUZ5SExWeGhrZEYx?=
 =?utf-8?B?Ti9jSVNMSkM0ZUQxRXRzSVgyVjdiYUVYd2J6N0hJMEZNbCtPWmxVRVkxMXBm?=
 =?utf-8?B?c0UzRWpoV3lOS1hyNlVHcENEYWVLNCtKY2JvWHpTeWRSNkVVdko5ZHlReUpT?=
 =?utf-8?B?cGFCSVAzcFRwYnVZVGU3c1NzTmtjMnYwUGhndU1iTi9NelhSZ01MbVRYT1A0?=
 =?utf-8?B?RklTTHZiNmpCeGFlYVNQb0RLTndpT2RaUnNFeDlMWUx1cm9OTEpaNUdSRGVQ?=
 =?utf-8?B?TFhMN0lGRVRBejUxQlp5STNyK3FKZi9nSUR3KzVmVUlwVG9rbVRjcnY2THBH?=
 =?utf-8?B?WXR3RVBWN3VxL3doSWlVYnVscEw0dU5QM0hCdEE2dVdZcURBeVJOKzZBY0s2?=
 =?utf-8?B?eTlZL2l1Y1pNZVlXMXFsdHROSkpDOUs3dnFmejQ2d0lVQW5iVUcvNjR4T01y?=
 =?utf-8?B?aEZqWmp3TGZBakNvWFJKNG41WE44elhuTmF3Y0o2NXZXZW41RGJlU244eWF5?=
 =?utf-8?B?YWZIMGp0cDBDRWJIMzhTRFFLR2duMGJPeTB5WXlSYjlMNTdGTWkvWDlqenNk?=
 =?utf-8?B?bkdBVkRzLzFIQzVJTHE5TDk4T1lwcm9HMDRZdFBydEJoRHphelh2cStuVUNi?=
 =?utf-8?B?Qkl0SDZaRjNvSXRDUjdqOStlQ3RVeDFBc3VSS2NCOWhrdkMxUVhzSjBjeWZx?=
 =?utf-8?B?bDZoNFB5SFlOR0lCMndteUkxYldhTUNnSExBSlBVWDVnSWhqVksyU1diRWNs?=
 =?utf-8?B?VnFDazlMcXRqaEFmVFp3NWw1RkZwcmtlOVI4RHlveXN3RDZqakVxcVV0NUxk?=
 =?utf-8?B?akh5VTR2OW0wRmFSbWl6NGhJVnRRanFRSTNIZ2VZaUw5enVaaVJYSU9vYzA0?=
 =?utf-8?B?N29TcnJFWUtYaEt6S1JuQXcwWTllLzhzRzlSa1l1WHFvcHNnWlYyaGZkUzlB?=
 =?utf-8?Q?XKQVD6cg4FMXCm0GGfxMfzG9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e6d274-8fc8-46ac-6f66-08dc342a6a37
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 04:46:35.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15krgvatj8d7U5GSybKqwV09sCF7r1ahwG/Gl5HM5WK77B5OwKt9dXAfD/jdJdRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

Hi Andrew,

On 23/02/24 1:02 am, Andrew Lunn wrote:
>>   	u32			wol;
>> +	u32			wolopts;
> 
>> +	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
>> +	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;
> 
>> +	if (bp->caps & MACB_CAPS_WOL)
>> +		bp->wol |= (MACB_WOL_HAS_ARP_PACKET | MACB_WOL_HAS_MAGIC_PACKET);
> 
> So bp->wol is the capabilities of the hardware?
> 

Yes, it holds the supported capabilities.

> And bp->wolopts is what has been enabled via ethtool?
> 

Yes, it holds the selected options through ethtool.

> I just wounder if it would be easier to understand is bp->wol was
> renamed wol_caps, similar to bp->caps?
> 
> 	Andrew

Sure, I will make the change.

🙏 vineeth

