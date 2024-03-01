Return-Path: <linux-kernel+bounces-87984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB286DBC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E33281C37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0E6930F;
	Fri,  1 Mar 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wSKwrQNO"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E503612E1;
	Fri,  1 Mar 2024 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276541; cv=fail; b=iVg6rtleNBHuKjzGIm+NEJbLJgD8fDmGobk8FksV7CXGyRv6j/uRxbVgqKOzy/F4WEc4nC3qZQ7brMPnwsozcEJ6TwSOW/jgttPATF9J1Rdp0iFG55rPVW+lizEm/QwP7IkkJDhrAU2yTiCRzZctUARwM6ox8mZ03H8slV9jvR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276541; c=relaxed/simple;
	bh=1HdE2Q7gqOKIidNmD5Ntlsa5bteTWGymBNmXKk+Tqj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tvoZZmN12iEDq1rhfeXxA8YRxIqF03W1O+2Trb9gyUPZMA9RNmXRb5121LCS6ieo/bmlf6GL8yiFbyMI+Lt5HOZyOp7C+mQkoXGRbo14z73qEqJTLMOZhLLFmP9LauYpp8LJLajR0nzWQSXWoa6Mp+8Yw4Jc51/+5MIYDapiaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wSKwrQNO; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDsb1i/XgC531nWlhyK23SC8BmeyFpa/2OIOFy0Eb7OyZG1Ip4NHYUy4118uE3QShDGAjJ3uLuA5Q+Y5StkCmu8knalgB6EtVStckCQr7KbzFUksKS1g+JnxbSOOthHFXR9cnJ0ktyOIFcqXTNQaiwzlGlLPbJhG00Rhm9PzFLM2cdwg1iQRTmpnDOAG2Jug89MGZ2jbkbDIacLqY90cRqoNEDFrxnOc0ZSas+aOIEgYqbyAuscOTUdZcZ+iMTG8vevE9sKDGbDSjp8JwztHUlApuxE6vsoR+VmmsQz41tQmbG4ojlFfE6yUyLK2ji2xYZvf+gldmMpBdjKRgKLCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hbue3eHWnNsaj9r9MCH+hFqiu5Jr7Lb1gg13QfrGis=;
 b=aj24mnJrZ3IdHFWPtdDnk2r8o7tCIdYFsHIcV3/oKdAq/B2XJ3MExlrU96Hpqc+akJVrvljo0+iym/4vKgyDA49NilFJb+FXFlmBDxfjxLSa+WQed/B4vY3Du11BFSlYBy3spzDaIrOfe8nzC5DvrZ+Znzkg0f5pv6tusHsvIJcpkUFV9sR50s3SSdGnO0uaSkXTFdfCWb4xeqb1rLFvkmmrBHWnsmgUePNY5FAtcgF5ymAf4J7cO1RIQeLzGLx4M2t9xU2C5O31KwE3nbN+NxJjwlGMMBJwFWAO/W9kDAwkaphRmmoAfVfQSqDtgwZMP6UE+xpfJFHxB6p+9Dg1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hbue3eHWnNsaj9r9MCH+hFqiu5Jr7Lb1gg13QfrGis=;
 b=wSKwrQNOi8/wGxodnGlXyrSJcy0X6+lVFG4Bjr/hJeFk4k18X/36MIREq8EvY8Ml8vQt7MPTeCb9VghKpTsQLwXzmPxpvfmpEiBC/x+acRhEwy2NEoUNuz9rviR4yQ3cI26KIh5AchOahZ/pt8OmCmQ7xPzlOLJzkitpTQCfQ3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:02:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 07:02:18 +0000
Message-ID: <ec778693-fa10-4907-95f6-3b35bc4e250c@amd.com>
Date: Fri, 1 Mar 2024 08:02:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: zynq: Prevent null pointer dereference caused by
 kmalloc failure
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Duoming Zhou <duoming@zju.edu.cn>,
 linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 mturquette@baylibre.com
References: <20240229122250.24786-1-duoming@zju.edu.cn>
 <2b274111-e65a-4b99-8f07-220324f1e214@amd.com>
 <6bfce5ec26a26c327c4196dbe57b63d5.sboyd@kernel.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6bfce5ec26a26c327c4196dbe57b63d5.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:803:104::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d75749-d4f8-44f8-38ff-08dc39bd8850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y3F2c8rUbvXDjO/+8RcIZ6DQB+OpB/Z8b/+bxvQ+Q2bIw3m644uBQE9qjrsQg+FXYsjyIhq6kbmHxZQzXDWUCxmw8TL/606Z4soV8oHBUX/IrKlb4G644jZ2a/WwRUQ+7se0RLZfNtFDvDf/yXzTixUhxxOda5hY0hY8nX52aHe1io1EWgzMtDv02jSnzNJ0ir5A1Zk9tMxTxscHBQ6frUoJ6Bf3bxzCtu7c37sEwj3MAoHVjoX1Ycf0zyBR6IeQg1oJlLwqFkKtMm4v6Ne0RrOjTTNPLxYLwVi+coQJso2HhQsVcgjZJZ/78DIdZb7x6FU7nceBAjQgyzHgQE2k/ugOP2cU1B92QlHLhUHOiaUcFKxUQ8jIlNUNr+9itj89QYyeBuu+nfbrr3xiilS/M41//E0ft35GkqRKquPHS1iwObdf2QPOXNjbhUR3ljWPqGNIxKBNqcOiZtOGjPivque3YbPa/dwTqTjxTBSd6V0p3hBYGDo/MBaWdeX3n+FYkD6Y7YtIZKxUFedPYk1jMEv1AQyHgUAckSEBcoFBLoXrvz/AVtKqT5bWJYaWfU6Cf2mNI2QfkFsO4y/YsDh86KkbDQQPIMU7AN/SAEvv7i0oLIy7VuckuzHYFyQ7/e9i/K22vjsn8QQJqX75kVKw0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0lGWXpOS01vbUtmb3M1cmF6ckg5ZVltVDBWNjFKaUlrcUpSMk1zSWsyemNy?=
 =?utf-8?B?NksxTmFBN1ZnTTdYM2ZGYzBLcG9mV29ZMDBibWRoak5CUWE0VWRiY0MzZktr?=
 =?utf-8?B?MFVtN3p4WHB2U09YN2Y0QUJBTjBIdnY1ZXY4OVVwTXhuTUtxbWw0eVB4NTVO?=
 =?utf-8?B?eUUxMml4K0FiWUUrall4Nit3YVZwT1NBWEtpbDNRY25tQVhUbEV1R1E2UlFF?=
 =?utf-8?B?bTZ1TjdQdnVGbXFGM3JQVlpjd2lvdzMrVGpZSXdtVWJ3Mkx4WTVpekdJcGto?=
 =?utf-8?B?YkMwTmpvbUFYdVgzU2JwbzVhK3g4VWRibXZEUTdVK2IzMUYyWlNja3BuNFVj?=
 =?utf-8?B?UFdOTFc3Vm53Y2xaejk0OFF5bzZLWjFyN1krd0cza0NSRFJVQm1PZytrbkdF?=
 =?utf-8?B?UnZhYVJSaEpzYnNDSVAwakwwS2UwMm1oWTNEaDI0bkZmRWtLSnZtWEZ1VVdT?=
 =?utf-8?B?OS9QUEtSRVB0TUZFejJTVUtKNDZoVCtYODA5YTIwMlBYT0pudXcrMUlhZng0?=
 =?utf-8?B?bkw1c0t2ZFhQSFpCUFV6K1lSeExPSTVMdlVXb05DUWMyNC9OYzJPb1ROdzhU?=
 =?utf-8?B?UWlseWdoaHJVY1R6aHlQS1o0cWNURnBEdTh6UjVzbWllQzFYekVXM05xWVZm?=
 =?utf-8?B?dnM2VWN5WjdLQXZSMXphSk9DWmNPZ0RqZ0dJQmFRUng1cUxraythc3l1MXhE?=
 =?utf-8?B?NGdRa1N1KytRWGtKTnJvQVNRRVA4N04wUlJTUzhETzQzQnFRNlA3SnhZRlB2?=
 =?utf-8?B?aDdKL283eDBVaEdHQVVqNTRoZzNSK2FFYlRwMnJuY1JRRGI2eVZFTFcrTU1j?=
 =?utf-8?B?diswdndtWlVWNVhUN2hZMkJPS0JMQ0VYdmwyM2tWL2l1MnVLbG11SjdFMlpW?=
 =?utf-8?B?V1dPcDRya0sxTGxzdGJrSDBYcnBFZHlDbC95Z05wZHNwYnhqdHFEQk82QXp0?=
 =?utf-8?B?QzNzeDQvR2swZ2svMTZRWk1rUTliWE9UNWRtaC9aa3JKcDEvcTFwc0RTYlRj?=
 =?utf-8?B?c0QxQ3hpUWhRZkIwbXVmQlJhVEFnVzhFYUFDUklkekc2T2owZGhMVXFPd25j?=
 =?utf-8?B?UHNTTWJ0UFZQU0N2cU4wb3RPanQ4SkFkRmVuaE5OZy9OZ0pCV0JleVdqN0Zo?=
 =?utf-8?B?VngwV1QwZ0U0ZXR6SlhRa0JJSXpxMDdGWGdYZFZYZ0hKZG1wL3JHUWg1VDNa?=
 =?utf-8?B?UFRxRng0OWRMVGluRjRRSTRUYWViYjRlaGN2S2doTGNmTU1LTnk0QUNsT0p3?=
 =?utf-8?B?R1BxdDU4MzdORjRjS2J5S2xFZW5UQVo4RmpiZnJISlVHT2o0NU9JaWxGOFND?=
 =?utf-8?B?MW5Fa1dCTDZ2SWtFY09UN1g2SmNSNjV1STNLWkJpNGhJb1BZSTBvcE5uYnR4?=
 =?utf-8?B?Wm9LYnR2akRBSzVjbnpWQlRyRnRWQkxmQUc2VkJ4MWdPUWs0TGtxQzlFMDcr?=
 =?utf-8?B?WGFlMFVhUmtheHdEYTF6MTBleVdaa0NLdVkzM0ZXb2xBY28zcU1xL3JMWjJ1?=
 =?utf-8?B?aVhwaVR5ckhFRGlKanV4REIyVVhheFdMMnRMZHU5NzFsTWdRUWwzd0NmNmI5?=
 =?utf-8?B?RUs1c1d0YTAyaTg0c2VqWnlTU1g2RzMwdUNlYXk5ZHBheTY1UEdzc0hVZ0Nz?=
 =?utf-8?B?NzVabE55UW1FMDh0WUNPTHFVY1J3ejFZaHpGRDN5TG52VXc0Q1FhQTNmeDNz?=
 =?utf-8?B?OEhsMGZDWmZaWmZmNUgwTENHb1pwdTVQRHM2SXBFSUdqdG4rai82K1AwZ0tk?=
 =?utf-8?B?cjZWbk5KQTk4U2hLQnpoVFByMGlLdlVmZ0FnSGlmWkFEM2NiL2xITURTNWRG?=
 =?utf-8?B?UjVOeUhDVWowT0JuaHVwZkFnQVZnMkZKVTJxd240SFhRZElQdGVBRUp1U2U0?=
 =?utf-8?B?MERNSnpQa3VuSWV5TDM3b09SdFoxc0tzemlWZXdxQzYzcjRrUW9LT2RnMVdX?=
 =?utf-8?B?dHdzU2ozVG4wb0JZMVpESk1uVkxzMnVMQU42ekFuVThWM0p3L2t5TG1xNkhE?=
 =?utf-8?B?Y1pPTDhrQmdCS2todm53eUcxVW9pTzE5T2dzNXVqb3dXSDB6cmttYzkrWVFJ?=
 =?utf-8?B?TnVDMzBzUTMzd0VJOE51Y3M0NVpGUHlQQnBWQ3h1bGlaaUFRR0FPZkdQYzlp?=
 =?utf-8?Q?c4fIBUftx4a5u21cQyQMfEtTQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d75749-d4f8-44f8-38ff-08dc39bd8850
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:02:18.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mBdEJXnwqqYd1BxF9O1VDbnBFO967+lvb1WcRbHeMUH+pTbkumelVdDExd+7t3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443



On 3/1/24 02:21, Stephen Boyd wrote:
> Quoting Michal Simek (2024-02-29 04:45:54)
>> On 2/29/24 13:22, Duoming Zhou wrote:
>>> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
>>> index 7bdeaff2bfd..e4c4c9adf79 100644
>>> --- a/drivers/clk/zynq/clkc.c
>>> +++ b/drivers/clk/zynq/clkc.c
>>> @@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>>>                        SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>>>    
>>>        tmp = strlen("mio_clk_00x");
>>> -     clk_name = kmalloc(tmp, GFP_KERNEL);
>>> +     char clk_name[tmp];
>>
>> I know that Stephen asked for it but variable with variable length in the middle
>> of code doesn't look good or useful.
> 
> I didn't ask for it to be in the middle of the function :)

I didn't say it. :-)
I know it was about putting it on the stack instead.

M


