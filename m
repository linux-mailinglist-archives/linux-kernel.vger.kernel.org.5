Return-Path: <linux-kernel+bounces-155414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBD8AEA13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF25C1F22EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C213BAC8;
	Tue, 23 Apr 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fni7gxOU"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F113B58D;
	Tue, 23 Apr 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884588; cv=fail; b=p+kAkc0IirwmRkrLKaWL0tW7m5xlJS9PZT8meatq1vx+hUqvuBOzxLqsc/belpXAcxyGlMxwuLtwIN/9+CdzKu/RHPI6xGVZ0qYIVpjsq0D965PHUmpf+31jGNC6PYQOp6v0htxfZenvobi7f0GgAy74IkpLprmr3wxdnSr6HKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884588; c=relaxed/simple;
	bh=X1kk7sbBcyoSWNZC7vnpy5/OeWRu41Ve5ce+haGAVOc=;
	h=Message-ID:Date:Subject:To:Cc:From:Content-Type:MIME-Version; b=Fgz21QX0LxLgX6SpS5iZ3c2YCf7BnSYvmLCFjZuov1lH4VcEyPnHRGi1ewUKN2rULTHwjXiyzY4/1H6tCT6/Yzv09RFQ2t3UyvnMt8pUz++oUgTZ11LsZkdZRDcoz3hz73GdxyPlH7ujr/7OKFIx+/ARjG9GUlxVLrKC8fbxVdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fni7gxOU; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ound3K0y8r3S1zZ1cHZOTrlcApn+t3ZLlBcXAirvVdA8rRAWAtF6I5peXSQ0kNiQKinJGSaN0FOI0SeOX7xwh8OgWTPfXGEYPm3Gm1rvRFXwAMwa6zT3jIhQm/yBxK5nHSpOoE0ZfW4Qsz03jjNMQZx1yx8q8Qvu3qGFUzpvmJcFoUQa4nLKTh6K+JOhPlij9DksXG+IJGEd0Guwcu8n5BH8FQRc+dhRL3loCIsBd6z8gIsTwCXLggCEWOAWm0qwt7YadMTJJ45MGHT4vhuc/55GmPky0+QO9h+Yli3TW0VpAll2iPy/FOXlqxXpkhoOuh2hjwxd+V1Q7GAjBv1Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMBRjREPagZOkoAy8UhYWN/e6O5i5eExEESYoD5IUaU=;
 b=Bu7suJAGs8lzQHIKHMuuUCLJXrfSytXiK/PQj/WhhXRid3lErAoe6GssDqghZElW1JlvBgP7jQRWC6rtrFxVUOHtksuTThzkg4HLz1TBPPHnyfnjPuvTVa3K6/jdq1PJWFt85b5QWb4NwGRdWT73UOsvtZO3L7ODa4uGg6zci2vfZNJDUm158/cgzTAUCxlVjCgUpPV4YTz4A6l867kg8z4wRWOjT93lqYF6vb9gNUjbxM0Eaziei1eHyWBQaa9WzBKldFMqObOLHX+nPRxZNDqEQVpb8ATtzbBXPnbvn2kFVpeYd9kucwEwUo5/Kg3J194rKNaTxLVvMAdLqi7hEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMBRjREPagZOkoAy8UhYWN/e6O5i5eExEESYoD5IUaU=;
 b=fni7gxOUAGGOtLZ2k03v6ACKaVMsBH0Qp3g4dNhDD68jebSnZi+Gb1JFhRa6ca7FRQvHa+TP1A4ApzQqvT88LUjQemekfSda63ravby9oNdE9RMHdXU4owximnWabs23ugdXEkbpJcYgSJj3Jaw+QHvCmgvVn/DaVWJlni7xjLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:02:53 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:02:53 +0000
Message-ID: <33782aa4-a47a-4c3c-9e9a-2cc222d09cb2@amd.com>
Date: Tue, 23 Apr 2024 10:02:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/MAINTAINERS: Update my email address
To: Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net,
 elena.reshetova@intel.com
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd1aa0b-3234-4441-f653-08dc63a67324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk9rbk1LUElWMDFGS0hjUTdidmJUeHc3QUlQSVdhbVlUWWhWMjZHVVovdzFs?=
 =?utf-8?B?ZmJua1g5bUhkend1MHAxRURHcGJkVENRbzhrb3Z1YlFxUm1UdU5WdWVxK2Y0?=
 =?utf-8?B?amhLVk1OVzh2OHlOeWtYbml0ZVFVN1dvcmJxYTdueVZ2QUdrSHVvNDJDc2dE?=
 =?utf-8?B?WXN3V0tZdWtMOGxub1d5ekh5M0MzR2t3TGozQi9pZUMxTHBZN3RYNzZaYm1w?=
 =?utf-8?B?eXVVekZBSHdMeXE1aXBzSkNVQmR0ci9wZUdHNG00V1ZvcGlYYWd3eXNJU2Jx?=
 =?utf-8?B?THB5cFR0TFgwV2c1QW1IQzZGd2d2OW56Yk5GN0RqaS9scVpEdzk4a0YyUitC?=
 =?utf-8?B?V29qM1BJMXFjalhhMTZlRHFhT09KN2c4UXhFVjN5YWxFRExVTXlISFJkaXZ3?=
 =?utf-8?B?UDFITnlFd05mZlBsZ2VXeTIvS0lLcUJvLy9DVEJFRGdieEdlS1VnNy9jWXZu?=
 =?utf-8?B?VUJMdWRLeUdteDlvS1RpMGFwMXkxTjUrRU1hWjFBR0Yzam5reDZpelhkWVha?=
 =?utf-8?B?TUZaelNwU1VEc0ZRWXJJUUxaODEvMWtrbjFLQUU1TFg5eXN1ZmliNnZuNDhF?=
 =?utf-8?B?Sjc0OTFPelNpYzhYTEd5RVd4QWFJTWNVUU81eCtYditzY2ErRWZLNk1qOFNH?=
 =?utf-8?B?eDNyczBKQ1RSSWtRSGtPdlFQemIrMWNMY2ZZZjl3OURMUVZmcjE2eTVxZndT?=
 =?utf-8?B?UG9sb0ZnaGZ5UG9KN1FtcnBndHlmT05sRE9JdENSS0J4WlgyVlkrMHhicDVu?=
 =?utf-8?B?ZDBjUWVvdWwrNlBHbjNqUmttYk1TTFBWbWZ5aEV0bnp5QlBvM2VkcnNJMTBT?=
 =?utf-8?B?MjBERlJWTUZYdm4rb2NnKzJTc3AyOHpQZWVNc1NTTVk0UFJLdFFabjBvU3Fs?=
 =?utf-8?B?RGNxbEFuQW5ZUUgyV3d0TTcyUnV3YVZWcmtSUi9BL25TUW85QmlBMXB4SG5G?=
 =?utf-8?B?WERRZzJtbWE2UnpDa29ZZG1peWRXa01jRUtrYTk4ckZia0o4Um1EbTZHcnF1?=
 =?utf-8?B?NEc2V2VGaUVFQUdOZ2dXdnZuNGVYeWVMa09TRmFlblhKZmd0N1MrejVUY3ND?=
 =?utf-8?B?aXZpS2JsQXl0clVhWW5KZ2s2SzQ3WjZ5emE4eENlZE9TemVoUUR5Vjd6ejc1?=
 =?utf-8?B?R1RCc2puc0o3dk51QitSVDJGSWFTMUNsYjFvVmJiZlpOKzJmZ1IwRDROWWpR?=
 =?utf-8?B?a0Z4NUNnTDBPMlV4VDZmeHZ6UEs0Zi8rVENmVGM5K0VReWpFck5lakpFL2tW?=
 =?utf-8?B?MUx2bzBsemdJUi92ZExLRmE0cmZIdlM4RUFxN0w0dDBqQkJmeGliZGZxYmp1?=
 =?utf-8?B?L1draTlubWVLV3l1VHIwdkRDMVlWNDJnK2VJODYwaGJjRzA5d0syYm50SUF1?=
 =?utf-8?B?NjI4ZUtkdmtKU0ZtSlR5VnAvbEpUUFhFUVlIcnVCR3d0UlM3ZzI1a2JGdWIz?=
 =?utf-8?B?elF0a2M1VHA5Wk5RNlZiZUJlV0I2alNUanlhbGVMOER3UHpDcGY0TmgwcEsy?=
 =?utf-8?B?aHJVd1RyV1ZWKytJSXdLM3Y5YU9FUExVZEttSGtlTnIzS1U3WTc0MWtiWS83?=
 =?utf-8?B?WFFlazM3cUNBRkhTQXhiY1dXTnNQNzRtMGF3RXhQaGN6QlFlMXIybkdpSnhS?=
 =?utf-8?Q?GWG17j/Y5Nq5rkuAkQT444TxbGxnGmiZg2zMvopTjHAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1IwM0dVRUY4aWJBSXZ2NWl1NTRoa3RPK0llbnlGcldIZ0lmaFkrV2l6K1k5?=
 =?utf-8?B?OXpCaEx2ZFlHRDFDWWo5MWwvS2lFU01WdjkzVWZBMHNhcUhzd3BtckZNTnU0?=
 =?utf-8?B?MmJRSkZvYjNTNFpKOWhhNGprVG01OEJqVnJzS0FEWlpLbEF6RmxIamlvRUNr?=
 =?utf-8?B?bkFnWVVsY2xzQ0pxZm4yNUl4TDFFdmdQMk5GRFUzcC9nVHplWUcyb1A3dzJ0?=
 =?utf-8?B?N0JXeDRicWNsRkhIeVlzdHFKencyQ1poMGwrZ245RzhTbkNIRnRBQWl2L1Zn?=
 =?utf-8?B?MzVWM2tWclRnUWtYaUd5ZWJqSzZPZ0RXR1FGcCs1b0k2VFhLVUNpK2R6Y1p1?=
 =?utf-8?B?MWNwREdRaVh2bkprajVvRmJyTG1DQUZ5ZFJybWN6aXJ6SjdXT1RFa3pWR3Zo?=
 =?utf-8?B?ZVZjYTJQVTltQmdSdHhBd0NMYkVZWlRHVXJUN3lJKzFZWmFnUlBZOWpGa2NL?=
 =?utf-8?B?NC9yK2J2dlNqTThoMUFPdVU1elBXT2t3N2FLNXlxYkxSaDhEd1VUb2hsbG5M?=
 =?utf-8?B?MCt6bU91TUZCM1F0R2RXbStjcHJpN2QyNDhjOEdTVGVtM1QrbkQ5V09MS0dq?=
 =?utf-8?B?Q0tTcWt0Sjc3UEROTjF4MllXUExVcnBTNFQwVWRLcjZCUExMOWZSd2hyZ2s2?=
 =?utf-8?B?UkY4WnhDQXMwNGRwTnovUzJBaGtYSVB4SVVnSnJDMkRIeDZCeUpDK2xQUkVK?=
 =?utf-8?B?ak04OHFNRG5TZktGV1NUeEdVVThYVFIwYVZRVmRBTW1LVnEweGZPdXJKbDUv?=
 =?utf-8?B?bUNtRGJPV3dZMzJZVkVVVmh2NmZIblRpYkdLZTVsLzZpdWV0SFlmNTFUaHNr?=
 =?utf-8?B?QXA2VEgxd0FtTW1qWDJpLzgrVXRNc3BpKzJKUHBwWFdYOVFmS2RzbHlTYUg3?=
 =?utf-8?B?RWJLa1RrcXYxRXpva3BxM3lqYXVqQ3JqZGkveXBSazhMV1hrQVRqZWhIa3pI?=
 =?utf-8?B?VlRIQVNLS1J1R3Q4Wis3Rkxray9OVWFLVHhPSTFvU1hnaVROMFRGcDNYMHBs?=
 =?utf-8?B?cHZlem51OWxkNnVPY0NCakkwaEUyYlZRMVFHYzhYbUpRZ0FGSXNsY2lSMnJS?=
 =?utf-8?B?QjNvOG4zM3o5TW4rKzAyclVkL2xSRHZENnNoTUc5ZGJ2eTFZT3FCZzdYVTF1?=
 =?utf-8?B?SzhRams1c2hnRTh1dExOSFBJaHpmRWFPaml3TElsWHNpTWZTaVd3NG9JM0dq?=
 =?utf-8?B?L0h1WWxaQVUrbmRCWmNzcG9wUTdiblZWNTlSREdyYWg5a29vUlBUbnJqNWs2?=
 =?utf-8?B?TmpYMjVxcENrM2xnOVcxZnZYMncvSC9UdzBxdVVYbitnWndwQTZYbkFGV29u?=
 =?utf-8?B?STQvRUFZT2pLNkxLZmNmUkdsbk92UFE3KzFYb0tnd2xVWVNRUGsvU2Zva3V4?=
 =?utf-8?B?bkhQMmtwL3RDSDBOcmNvTkpZNkdiYWZGTjhKaFBqTXYzcEp3NVhldElTWjBZ?=
 =?utf-8?B?NndDb3c5L0FBeEE0d3FPQ0xJNVM4NTZrMWdLQXVpV0FGdjZjRUVNNDVPNzFU?=
 =?utf-8?B?K05GR0kxSVVrSE5TWHQ0QlRxdFpBd3RsVE5RMDVtVWVPWDJVZG9aOUxZZDh5?=
 =?utf-8?B?b2JXY2kyOWdhbVZNcysrdERnRFRXT21EMCtpT1FrQ0xzOEpEcnVibzBLc3Q1?=
 =?utf-8?B?dlRYQU1rYTk1QkN0Vzd4cVovUjgzUkIvUm9qNVkvcExCWXRUVXNPUkFBeWNK?=
 =?utf-8?B?VDRVekNrMERIekgrTUZ1TTkzcTJuV2tjV08zV2k0eFBkZjgyYVdjcFBpZk5j?=
 =?utf-8?B?MmIyV3NvL3FHdm12TWlYUGVsZEpSRm45SjlNVGtoYktrWkwrdEs5cUZqclRR?=
 =?utf-8?B?di9wbE4wbjdYWnNWRTlwRmpjdUpBRUFab2s4YVJaQlJjZVczdzZScVoyZk9o?=
 =?utf-8?B?cktyMC9NZzMvaDZHM2wvNGlVL2l4UFdxRlF2OFRJbVAySVFCSjk0KzM4Nnha?=
 =?utf-8?B?T0hXNEw1V1Q3Z21ZRVFuT0c1TnJOUUo0OGQwYU41ZUEzei93MnBrdVJ2MGVB?=
 =?utf-8?B?eWxJT1NZZUl2TWwwaGtRa0xtZ1hiY3cyZFZDSVZ3RGs2QUkzc05QSkx0eG5K?=
 =?utf-8?B?T2h2ZzNkNC9kNnp3Z0VkWGJtZVJoY2ExRE93S3R4RU9SVTduMDhHRWw1TlZH?=
 =?utf-8?Q?IBafhUnKhIVEa+A2/y0Sev1t2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd1aa0b-3234-4441-f653-08dc63a67324
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:02:53.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqzIzX9/LbS8Ku4oW8JwQvfjARPV3LyjcD3EdKywAUEdKKHUEGLSNYu8D9vrBttgzqF1Y88FxOl103a0xY8MvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On 4/22/2024 10:12 AM, "Randy Dunlap" wrote:
> 
> 
> On 4/22/24 6:37 AM, Carlos Bilbao wrote:
>> In the near future, I will not have access to the email address I used as
>> maintainer of a number of things, mostly in the documentation. Update that
>> address to my personal email address (see Link) so I can continue
>> contributing.
>>
>> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  Documentation/security/snp-tdx-threat-model.rst           | 2 +-
>>  Documentation/translations/sp_SP/index.rst                | 2 +-
>>  Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
>>  .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
>>  Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
>>  .../translations/sp_SP/process/email-clients.rst          | 2 +-
>>  Documentation/translations/sp_SP/process/howto.rst        | 2 +-
>>  Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
>>  .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
>>  Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
>>  .../translations/sp_SP/process/programming-language.rst   | 2 +-
>>  .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
>>  MAINTAINERS                                               | 8 ++++----
>>  13 files changed, 17 insertions(+), 17 deletions(-)
> 
> Maybe also update .mailmap ?

Thank you Randy, I'll send v2 now updating .mailmap.

> 
> thanks.

Regards,
Carlos

