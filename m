Return-Path: <linux-kernel+bounces-100337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD38795E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FF61F23B76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4987AE4B;
	Tue, 12 Mar 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WspKNwJ3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD158AD4;
	Tue, 12 Mar 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253140; cv=fail; b=Owsj2lJ2w6TG7fjcnOJcjIyxbKZkofn4J15Lgc3N0Pge9PtZw8WlPNPmNr3XBPf071zVkg3s9lpdt0iRpWJvs6VGAhzbt3AovSM56/SRc7igrmzd15hos+/g/pjSu2z8M1ByUErdS9yI5bQcAoKiifhmHrPLIDH0JapvnsDEoX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253140; c=relaxed/simple;
	bh=PTPt7rYsxtWVCmIB1pjLOrkkzAHkz/wDcLhOZcpzsMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HvIdvkTRP7mtKUeGmHrV4wE0RnU0Mqo/xAsr1wwCYfLKUIxpvGYIewXDo/UHal3y9JcI1a0iSocuEhIxNJHUaK2fOdxGhVyyDnpQq39YVAyI2sW0mgL3ub8dCAqFb7r9CgwiPGtlr5OfPYDoj4emIiTBOSmpZiZ4Z3YrAtT/1RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WspKNwJ3; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxkQhrPX+21wRglVDO1ikGDIyOxab90ojzA0izTYeOdHXRJTAbtoYDgOOIEffPQb/FTdf6aGiKQ1ivVNqZQGFcgOU1+DLtfDQPIjZ09oOR9JZcpUOZcN50hJ+DduLmXD5O3luE1bbWMTXUocB9daKhL9aIjqlvWgmtbmAHCYORvH5SS+57eR9K/9ZHLOWT+LP38ZYrlDTYLxBtQBAkXl+EdfcDJbkEQ6E4+ZQbQM16/acQrneKrKjDqOkp2+6r1ycdx1AEhixa2umAiBZWywMDoEnSJ1dS2EuZwyGvd6JLLP26lKRi81Ppy28tpsz/sH9s9TGuGuODDyYIwnUdK5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9xNeOUOpm9yPvu7EPhRA3/8+EY3Ma4Tg3EJNnJkAn0=;
 b=bzjAV0kjh0pj9OiW3JV9b4KyUl2JYYPEsRkniwlJe4ic1c606yoMJorO43fPYTIUDI8TkgRKTJSU6/zHqDXSBGZFoIFPCfCQWrYIv0hN9AeS7tPv65obT8/KM8b92R0pVmXVPxEeuSxGSG8A5ABCvfyJGUUcQj4mXzhjM6gFrKs4nY6SbJq30c1/i0N36bGbNDvKelz+9K4vTGrHXlgHfxra5SWq9wA9TDWWecy/7Zn+zASN3KK+rqM4OmQo7N/w2V4PX/1kX3fB1ZYKWfwRjEabe/u1RbBk3xKG8zorskxh0nAlTX4PXug3JTOz0LJEerR8XGqsZt0wsdkjl0oQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9xNeOUOpm9yPvu7EPhRA3/8+EY3Ma4Tg3EJNnJkAn0=;
 b=WspKNwJ3YSHNGgZoED3fLLfNg/M8g3zCLtvOaemea0eQ6xoOmXRLJP+3ZR2wVfo9g6dMk+joEJjcpvuTUBXQat+ZMigLnQRrBOSr9mn8tTEL/qGN71CxyNseaNgIiTZDx8AjB+SZFVhdPI741IWjg0pJAYZ54AQqIj6acoYl8XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 14:18:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 14:18:55 +0000
Message-ID: <56d4b666-23ea-4faf-8320-5006c0bcf937@amd.com>
Date: Tue, 12 Mar 2024 15:18:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: xilinx: Add necessary inclusion and forward
 declaration
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
References: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
 <20240308162920.46816-3-andriy.shevchenko@linux.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240308162920.46816-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 575b40f8-78e3-4060-f168-08dc429f5a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	95mw2FX607YS0LBtXf9WoqPbV1NzsyIm0ubGgAQcRBLrgHg0nFhVmk0qroU1oaKFbAUNh5cMbS3t9SofZh2vlo/F3+ge/yEauSGQjLur31jjMBKWJZsGbC6XzNCtC2/fUobokvuSN3ZBZjmezuFEciqq1qSDHY7XjNoN3wmjAJjE3QsoDiqtJfdwMWLrLjp0FdtRdK7tgK/6JUkFeADwPVvpSo4OnkeW0rRJmj7FFZVX+PjH41L5bCqaswCY4gCFkmm1EEiGgoHHMmO5CXqjOepG4uRtUxS+UoExPkkkMGMK9MAYS27G/16KG8Dd+0djP1vt2T0zqo4ntXhEWT3HREfyvQGErHkiiTPHJr4pkGXtzvNTlKSvni2Vn/q1DIWYSQ0pSvKPvj3lIo1dt6u8uOT2BSNsoBvUxFNoxlyx5VDG6U+DZOfCfOTGG9ejDPGWRIdQERIxgXsUUO2XUB3Vvh3R+T2RbYR2c5v6Zw6WcJezB5vlLnXu3/aC9ttoRQ3zuk3MBycgrV9DEsnMtAj3c/BDElXgj2aL1OWt/3YI5k9v6C6NcSWzZSSAYXXOkNrL7GrpvViiXk5GU+76UkpURc81uNm8SGIoPT/+NJ3zvLEfZCdyJVpFhF+1ph4FhYPkTdlmLRRRw0nYs28ROG8O9LASjj8aNmbvPzKA8VXyKAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm9PTlFNTXI3emw5QUhkYUZzN2g0U3RNeThQKzRZd285WUE0cEFIWWxiR0tU?=
 =?utf-8?B?VDhiU0l5SldodmVQSEZRMmI3YWczeTF1dlM2UkFvVHo0UFN5TFFkOUUvTlhi?=
 =?utf-8?B?cTJUTlhDN2xBVzFreUc3bDJvNE12emo2S3ZCODNOeTdKbTZBaktRekIrQi9h?=
 =?utf-8?B?dnhMU0RuczRiYVgzaTh5SWdIdGZzQzhjZGZNbUhoa1NVVGliY3dRSlljdjF0?=
 =?utf-8?B?VnRkN1FJK0JDblpRaWRWS1NzVzJOQ3NnYjlxbWNIQ2JhNFFiMG42QUZLeWdi?=
 =?utf-8?B?RUNRNUI1blhMdWR4OWh5dFF2UjNHdk1hY09wVUVYZ3k0NVdsU0hsZWlUempw?=
 =?utf-8?B?dmpmZytWY3FSQW1aS01LWXdRY1ZuazJ0VUIvTHFHaGE1NmJyUTFoRm1JQUpn?=
 =?utf-8?B?dVlRNFd1Z0RZUjlHRGhpWHptTDdkdjYvMnE5VDQrVmE3VlF3T3Rlc0EvVitT?=
 =?utf-8?B?MUE3dUtwZThlR0lyZk1ibmVuSlcrWllDNHNDN3JnZHVjN1NEL3JvQ0RQZTlh?=
 =?utf-8?B?OWtzSGtXaHgxbEtYN0QxQ1UvNm12dWY4T2Q2RUZQRE5tTFN0RCtZZmRqU3hM?=
 =?utf-8?B?RVcyNDRvazNEOVVpZ0hlTmRCZGlybmZTWTUvemQxeHRXbWtlYS9sU05MNUoz?=
 =?utf-8?B?Q0pMQ3I4aEdDSGEwTjFlS2ltdUwrdWVYNE5nN1VrNWxNc3ZzZVpTamQ5dUwx?=
 =?utf-8?B?aitwbVpxd0F4ajFlQW5ISmpaNzM2N2ZCRVdvVkdUcFJmUEFPTitQVjlSUXk2?=
 =?utf-8?B?MURhbGxpR1laTVM3elVwMG9xTWRQdEZvNUlYQzNCNjA4SDdtVmtpWExDeW9B?=
 =?utf-8?B?d3RmQzdVdE82SEp5RkloWEVXMFNENmJZL3ZWSG9ENWFxbnRUMTZJQTNlazlN?=
 =?utf-8?B?aU44aDJTUmdrRVhDSHg0NXhyNVUrTklzbHhyaXBwVHVIems1aTFaZTMwM0x2?=
 =?utf-8?B?anQxamlleEtSK0tEU2lzTFA0Z0dxelhjc1B1U3hPT0VBTnZ0RW9ZTEMwWmVW?=
 =?utf-8?B?ZVhFbzZ5Vm1rbFlLQjhwLzBMWE1zTDRGR280NnlGa3M3TXc5cUNkcXBBNmZJ?=
 =?utf-8?B?UmRwUnFodEt3WWJMT2xBQ3VLQ2RuQ0VnSTFmN0E0WEdyUVlZaXJ1L3FscDdq?=
 =?utf-8?B?OUIvQVJUUjM1cmwxZkZOMmZzcEFVWDMxeTVqSVZMaS9UcXB4eFNmaUpVZ2tr?=
 =?utf-8?B?VXM2c0lqUmg3UjNXMWJ2NjRiMVNMemtpbmZxMnNHdE1nV2RLUDdFRGJPOFZQ?=
 =?utf-8?B?VS9MemVWZXVWQmd6Zmo0YnhqMDcvejlYMWN4QUdxZlFIejQwZ2ZkYWc3cGhx?=
 =?utf-8?B?b2pVLzdSbnBVa2kxeFFlSVhQaEJVNFBYTkdHMnJhT0lJcU1wT21MZEFjc2JU?=
 =?utf-8?B?ZHliNmZlZ29SUDZkcG1xSlRob0xiMG5qbTJHeFI0SkpCa2dIa0pzb0dwcjdS?=
 =?utf-8?B?aHBHbGsxYk92OWwwTEZMZVc0TldQVWxjS09GU1pEMzJ5VUl6RkhSekhRTjhy?=
 =?utf-8?B?azd5aDZsYldyRFkxeUxWVmdwaUJoaFpOT3JDTndDVDl0OW04L1kxMmRXY2FW?=
 =?utf-8?B?ajgxeE1VODhEVmJEbTdxQStkM2pFMXEzT2RadnNDN1BxUEJsb2ppTnl1WkNo?=
 =?utf-8?B?V280ZkQxRDBEQ3ZvbkhsSmtZb05wZ3F6Vk4vdmV1Q1hZMHNlSXN4Tm5lQzFJ?=
 =?utf-8?B?UEhHMytSSkY0ak9NS1hEMmptUk50d040SW0xSlhQakdJQTYvVzNXcHUvZzI4?=
 =?utf-8?B?eEhoUGl1Y0tiWWhBRWFBb2xxOFJCVDVZc3JEMnE1QllPNDdqYkVyYzZManJh?=
 =?utf-8?B?L0FkT1BPU1lPTXNCdlkwZjJ0TFlTNzg4a0hTQWdGaDhpai9wTnZqenAya2dM?=
 =?utf-8?B?cTk4Y015ZloyN2pNUTlJcDJyM05YcDdRc1Z4TEMzbjJBTkFpd1lLYVljQW05?=
 =?utf-8?B?M2dVMjZFYS9RK21MVyttWVE4ZTJibzNvMW8wQm1qd1JVb0R1cXVLTjZFdGhl?=
 =?utf-8?B?MU5rZ1BYOFVFSkQwL2lzd3VYOHJwRjVFTmttZHMxY2RQN2xsOEZMUC9WTHVU?=
 =?utf-8?B?Q1NzRlRmdjI5aGNwRGlCekdoQXVhSEViRGRtOXhPQ0kxR0VUMUdzZDNydjhr?=
 =?utf-8?Q?WCu5zzzycQDUti7bbntZUXD4a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575b40f8-78e3-4060-f168-08dc429f5a05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 14:18:55.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1b5aUBlwBBXS69zEbk76u26EbkE0/5axNT2McUxVV2EeE0eUWtv86m3zDLns0t3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008



On 3/8/24 17:27, Andy Shevchenko wrote:
> xilinx_spi.h is mnissing inclusion and forward declaration, add them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/spi/xilinx_spi.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
> index fd6add419e94..4ba8f53ce570 100644
> --- a/include/linux/spi/xilinx_spi.h
> +++ b/include/linux/spi/xilinx_spi.h
> @@ -2,6 +2,10 @@
>   #ifndef __LINUX_SPI_XILINX_SPI_H
>   #define __LINUX_SPI_XILINX_SPI_H
>   
> +#include <linux/types.h>
> +
> +struct spi_board_info;
> +
>   /**
>    * struct xspi_platform_data - Platform data of the Xilinx SPI driver
>    * @num_chipselect:	Number of chip select by the IP.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

