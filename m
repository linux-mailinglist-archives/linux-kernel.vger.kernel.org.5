Return-Path: <linux-kernel+bounces-97133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C08765EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B8D280933
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB53FB97;
	Fri,  8 Mar 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iHCRj3aW"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28201DA5F;
	Fri,  8 Mar 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906529; cv=fail; b=gHPHB1uXjd3utYXwdC0dRFSQ+PhwMBuRzp8/j6/kR2BV25e7plZXwqCN1JRLLVRutQ6FF4Vv1Nwv8NKRLD6HIzKcNl6tboEVJYYXjFjVtJ7icW/GlRgWWJ7c1D0AKknQfrqdQY3ATIG0Zg3VqK6t372+uMmLhSiZHPCL5hdjcOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906529; c=relaxed/simple;
	bh=pbNNOWEwW0/QusyYl/+kt9Xkm0e4LrrP3tKAT32vyB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GtVssazdSfrwDSL1rl9PVvk0mukOol7GesIw9xffr/JR11xwNnOvk8tjbuOYbYw4BjTTJWMVMyXqaHXE0vOVti1pjorhjXsb67ISug9IUTdPZOzho0K9YwZRyY9mdNPokdR4zUIYNPBCFlrWAqvOAWLf8MplLcAEyeJiw2j1aLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iHCRj3aW; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsQd7OUOFlmlis8kJSq3YWbj7TUhL6ofA6JB4tGnQ/IvwzcOk5HJDUryXOmcRv3t8dgdWx1MwyXezuhcIAn0PSBG/wX5Rqa5e0EPnyh3GsRJ47yp9WNLIlTRXE47DRP7pgWVQog2OrkIb4XG1sLkZNiDTfodz4xqQ8t1zyXdjVDsZp/jKkE60rQn2bw94bw+ut7Ah3ZFOBjh9ZtZJfW7rKyMJHRljro1A8NS2snCQQA5fLw78dDc2xVazxiuSTCpK+nZESImX3r7JnYcgehQtiGstcYVCyLSC1etF/Q3m0LYw+lhZ6OUUMc2niCEw1j6csGPN+rBCRp8X1+M/Kte+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGqMaY2ruSNSscmgNKBrA88X8RjFCMeFk4TjtQEja+U=;
 b=nYFR8ZX4Ah4+XFeQ8MvfCWFn6TL9EE/aX+QeK+jU8thJbZQpvPxgs7eG/JXymXdUXI+9FR6qjrCTdbzL90N80AAz/oFp9bPYc2UrKf41egSGt0FEQZVxLqAX+o3dN/rfTbg6EM/7J2pNUgo9hHn5WIPMnm/byvm2XsxfUtrfPDbmLn+RDEjJhYl7I+7QxRxc+23/Lwkkd7c57Z5DALQGotgn/hRLjbBaMJHcTG7NfXmJ3Q9BSRpqBbyNlKoIGAPWErmILh7+nNTCyA6ncuEzLeC9CwHNrgeYX/K3X7rOSU6YFPv+htdpvKq8LZJIcrSjV/gsLrAnLiMpd4N8Ccqgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGqMaY2ruSNSscmgNKBrA88X8RjFCMeFk4TjtQEja+U=;
 b=iHCRj3aWtbFZQugtSvSOySVZ/KABwTrrnLuWjlMq+mqsJ/IY8lLzI0CTrcitX36b9U8NVmiW9P3VG58YRZ9iTD6v+1WJC931RjVfnAu0jMk523xLYvKqiCP8oEroCZkYXV4ZM98X8OveNoLljrz/ks/hmfAhO9mwFJKlo+28cr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 14:02:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 14:02:03 +0000
Message-ID: <d479cda0-3c3f-4cf7-acee-bcacbb9cc5f5@amd.com>
Date: Fri, 8 Mar 2024 15:02:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] spi: xilinx: Add necessary inclusion and forward
 declaration
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
 <a3aca544-dc6b-4812-b82e-dd1f9cc04871@amd.com>
 <ZesZKbdIo6z-AfIT@smile.fi.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZesZKbdIo6z-AfIT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 64053002-b734-4e11-ee8a-08dc3f7854b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dYnNsij7opw2sJMxzAIde0a0PH1mlGvSYVNBmI/1U199z5d7J/dodQahmr9O6sifdNstdOe8pDh/opQPPyTcSB4uGGSBDa/mMhLk2dB188ZwJ6bN+TEIRSAIQSe2fA0I6Acee3yUs4CY2pALu8fwmZItnnvvZhKHuD2rWCkgXntviZWFkdMu0uJB1cku9X04zORUz9LtwzGjXzOba4DRlyVCkjS779VI3BrsGzFnfeg7AlZP3hurwfmvYh7BR3AWUqJUIOTMsT3d1bOIPefiamU8TGf+bZCuOxvR3LUPTg1zS/F+J+2DiII4ofxUUv9MDt/zwq5VppzoC3g+Q+2XR8oTREq6qdRTjFBTVk6RVUF/BdKvPgK0gAev0fVhlY8o1807QoYsUXscNwx2kNkaAevVh46bjyuKaVtX6UabNKzZ44EWwCgwf8+FyVyIEiP8Xq0Hy7KXaSC6CMnBt6Mtuhghwl09J+EWqqAuVF/8oGEUQIU9jIggAGbCVB0S9PcMMHS31oVaEkjF4p7es4OS0Yr2LeSqaeiX8MKslpwBQYnv/kOy8TpijGnCUz42l3/n54t/2Rikv016x2swO6ST3LnMuQ3H5Cf6oQF9A/np7VEU/Dw14XcJuefyaPCv6ciY4cjREfAVSfHhTURnTqPteUKQ8A8CzA/xqx3jynGT50Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHFOQU5LK2JDQ3gvc0grWENRZytOakNOZmQrZkNQNEQ5WklicDVHN251Rmdu?=
 =?utf-8?B?aXlQb1J4ZCtpVlBPNFArNlJKM0Y3M0Yzcld1dWFzc0piN0lHYS95bll0MjNy?=
 =?utf-8?B?dkhxNll2bkd4anpmMG1GcWNiN3BMa1dyRS9NNGRiOW9FM0lGZitCSUcxQVV2?=
 =?utf-8?B?MUhVZnNqODBRMGVUNWx3cjJ4RG5XUW9PVWRZeWJDdktOeHp2ZVVQcWZtamd5?=
 =?utf-8?B?NEpJanJ3RllXSlY5WDJYSHJvVng1Y2l4Mld0cGQ3Mnl6L1FQSHNGeC9haVNs?=
 =?utf-8?B?OExLUDU1WlQySU5xOGZmS1VpL0xvY1BOa1N6dW04Zm9IZTdjaklUSG80MWtD?=
 =?utf-8?B?ZWNPaFVKVTFvMkwyRC9wY3NlOFBJSVV2L0xoemhMbGZrN2IwaDVnVVErVjIw?=
 =?utf-8?B?MGpMaWdDZFY3SVlXa2JNVU5iZzArclFKVGtpanRXQmtnVUxRUzJ6VktiaVlS?=
 =?utf-8?B?OUZFVVZzMDVvWks1VmVOWUEyekJLOG1ibEwrQXJHRVZWbUZ6WDVSOGVJTWUz?=
 =?utf-8?B?a3hVcEx3T3JxbGg4T0RNTVU1d08veE1KVmpyRDQveHVTZ1JFZUVjbXNvUFVU?=
 =?utf-8?B?N1Rod1A3dzlFbUxuK2xrdGltaXVGeDV4WmZ0elN1NzFPN1dPQ0ZVVlFxYWVm?=
 =?utf-8?B?UTV6SFRYZ3k5eXBPUmd0dVdiR1k4Vit1cG8zbFVURE55R1dkS0J2V2t1SjJZ?=
 =?utf-8?B?VmpOT0NMQ2JyemxwajBOcUJMNnlQZWN4QlYwblI5ZVVhdUt3QzN1YW5TN0R5?=
 =?utf-8?B?Nk9zYWRkK1NYRXVvbDFEZ1ZTK0hkWllEUW5mdCsrNnNxVkd2MXpPZWNHUUxT?=
 =?utf-8?B?cFdVclpXRXEydmZuU2tBTUJFc0VsTWR0aUtTU0hnQ0Zob0pESE41ZjVyYUFL?=
 =?utf-8?B?WkRRZ1dES0pyTng5c21Da2FaelFiK2Rndm1LMDFZLzUzNUpZYldkK1RROVNt?=
 =?utf-8?B?RHV2YTJPYkcxclRXellXUVBNallqRmwzT1I1cTdxZEplK2tFRHo4VHB1UVQv?=
 =?utf-8?B?L3JaVU9rdHcxVTRaeWlIVEEwY3JzNTllbDA5b3JQakZzVEd2YmlaeHFwTVdF?=
 =?utf-8?B?R3dTNWgrUzVaR0Y5K01QbFpQMWFZUTdnV1VIRnlMSXZ4MDdxdzhXS1YzZGp1?=
 =?utf-8?B?Qk4vcDZYMjdjTlh3ME92YlVrWHNVZi85M1NxY3hicFl6VTJoempzc29ES2Y4?=
 =?utf-8?B?Nms0ZEZmYzJ6SXVpRjdtdkwxcDhSSnUza0ZJelhIV05KamQ5VXFyWGFSbEpR?=
 =?utf-8?B?Wkhvc1E2RlZabzZTMk9NT1RKakxoMFJ2MWNBUDhHemsrY3VTRnpjTmtxbWRZ?=
 =?utf-8?B?SjNVd2xXTnhSZTVTb1g0NG5sZXUvVkdmTWIybk5JYWhTV1d5WnRHOGxZNzNk?=
 =?utf-8?B?dDlEWkpkelFxSmp6UmxYcGZ3K2hMZGxYaE5NVEQ1RHhtYWl1YisxaXNsamJV?=
 =?utf-8?B?ZHdWWlpFeVJZbjlaTVArdHZoVk9vYlNtTDRMMWFEOTNBS1dHaVlrUUl6cWtO?=
 =?utf-8?B?T1VkNTk0VUpIOFRqdERzTlNhZmpqUWFOMi9MZWg3Z25Ec3lZL2pmMWNlaUpS?=
 =?utf-8?B?OVZ2cGM2SGFJRXlzbnNWR05YRjViY09URzUrUVhDNWJmaU1xWlE3NEZVbE8y?=
 =?utf-8?B?RjhwYWFkSXpsUmlCN0RaNDZhaFpGQTRQVDJMU3ZNRHdKenluL2JEQkZIMnVj?=
 =?utf-8?B?TUh0K2xQUCtCUG9vZE12dUxBbzRnWndaVWxSY0JaUEFLTXFrM2tYZlBWeXZv?=
 =?utf-8?B?Nkd2aERXTFpnWm84RXFyS2hWbWU5UElRdExxbFZoMjNwUzZMRjY2R3FqNUpN?=
 =?utf-8?B?cDBaa090TFk3QlNUbWtLcmFDS0NFVVFFODBOUmM1dmJma0FrRGpVKzRuYzYx?=
 =?utf-8?B?bWxYSHc4TGEzcE1aVXBzMVFkVC9vNWh1U3dXSmVnV09nelF2NkRpVWduL1B3?=
 =?utf-8?B?V0tTRDZzbk8rMDRPNlRLR1o0VmdCV0pBVUFJNHdLSnp2VXFMS3d2M2dmd21B?=
 =?utf-8?B?SldrMHZvTXRYcExRaHMzaWlaVzRYR1o3dmhkWlVmaFBNaVNzYW5rQW9zbnl1?=
 =?utf-8?B?dWRER21CN2lzbmFvblNDTGxDMVU0aVBISDE4WUdOeld5VXZzankrQ3Rtd01I?=
 =?utf-8?Q?/jFthVQiqIQou8kPDp9VpMypw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64053002-b734-4e11-ee8a-08dc3f7854b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:02:03.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOTcFyA4TzYA1Yd9wx9VczUIg84VgvTdeRI5btfT0T48NxdLLiZdNogVkcjkOaSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331



On 3/8/24 14:56, Andy Shevchenko wrote:
> On Fri, Mar 08, 2024 at 09:21:32AM +0100, Michal Simek wrote:
>> On 3/7/24 16:43, Andy Shevchenko wrote:
>>> xilinx_spi.h is mnissing inclusion and forward declaration, add them.
> 
> ...
> 
>>> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
>>>    #define __LINUX_SPI_XILINX_SPI_H
>>> +#include <linux/types.h>
>>> +
>>> +struct spi_board_info;
>>> +
>>>    /**
>>>     * struct xspi_platform_data - Platform data of the Xilinx SPI driver
>>>     * @num_chipselect:	Number of chip select by the IP.
>>
>> Likely correct but forget how to check it with tools.
> 
> I'm not sure which tools we have to check this.
> 
> The types.h is needed for uXX
> The forward declaration for the pointer to the mentioned type.
> 
> All this has been derived from reading the file.

No issue with it. But I am quite sure there was a tool which was able to find it 
out and report it. But forgot which one was it.

M

