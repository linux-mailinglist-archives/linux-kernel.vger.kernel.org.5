Return-Path: <linux-kernel+bounces-86713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68A86C96A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422031F22EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8247D40D;
	Thu, 29 Feb 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pTgNnuXT"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDD1DFE3;
	Thu, 29 Feb 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210771; cv=fail; b=aU6l1hJBOOZSRhVH8DcoIjZGRd3oGnII0mYSEQwdIWHZaCxJysXBPMNzivuBJ7EcqVwzX3JuIR/6dV0eT/2MJoLTHK5R7kj9olPv1wwfFGHw4Xb8eT5WTRhdMgM+nn/3cLbwcHSRKz1LUb1BXPVUKnyqZtLEy+IAUv2Dn1c4V5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210771; c=relaxed/simple;
	bh=ss8G5Kt7xEUKHY10nEPQG4HpBsPwsdU1QHNBvP9KQEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVV4P0I6Km01TFpuFmAhNeCnPh56KDqDKOLFi81XVAfNfeRTElqE1n65V/SbaCyObqsIhjHyXvs3DX1maAvirMN5GQp7fKmACBbbOCj3Aon3IDAYTwh3t+WV9t+DsoS8WzeQ+pBh5vF2TKnFbRN0hllsNE0XE8Vu4wtmajsWM98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pTgNnuXT; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAbShlMoBN9r3xcSKiJM5SqmCMdIaQvCG+I/kyFre7luyK45dLQrq6UF3RUKmJt8gfP0zywtjuyHBfCtfOMtlFmn8Db4cnbUWdjiPkRbgnDz1B7uSEoQhSFfcTCdxkdl8zOt7/nCTdOjgY1W+HVEy3IBoO++gvBSS3fkc/Mv/Pa8EPYjJ+9uFbaPEmEpOMHeCj+3B6iUx3kCbV1Qun/Zt+dsTCwMbLOkUQ3q9h9vnIu6z/gm1oxe+Uw4sKmB7qhxOCFkk6OoTokSv+VJEOSSnJ0umIhnBZYgBpTt/CbQi0jPWHJxP8QSl1rX/HELom0nY68iYQNdRcUOb4vuflFhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YoBnbsp4vOPMIEMgKovnBtOUsXH5Mwte+a9paJ1/Ek=;
 b=BcURUpLhLmI8YyUBFRGRXFdKFhHiH0VYzz8g/8Z8UZr5ziFVmSooB3EdrUkvX/Zxeij92fc4R8KpOtQGlEJnQ/caWLTYfI4akpntie5K0sK9rJqW2hZV4tG+8+GIZ2H9pl9sBW566a0s+KMQB7g5FYiIAfjdj7nNa9OiHytz22sdbm/ZWBohA8sYXiHkVVPZc9taGsd8oNpThldsjDR1hJwgL23fdbgk1Ffysvyl3kIAGVy72Nws1FD2Ejdn4p4TiYGbbfOpEyWg8ssdWVh3XTsiSckTiNtfDW/rT7RczfaCV54efbMDdP4voFu9MvbQH8mX+raV+ul6VZ2IQQ8gXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YoBnbsp4vOPMIEMgKovnBtOUsXH5Mwte+a9paJ1/Ek=;
 b=pTgNnuXTzWg6iB5oNNmN4YuEWVNnGw4AjMJFbiBOaspEtRGzXVCM2HJ/kc+GBxOry5vrYAZhLg6sA5AbdvJOO4LNti0iK7aNW8en2DZHLplC8oD+Z19/bcQM7w6x6HMQaFsfLf11OAnHWYUj7sH3Bxylbwv5FXHn3+xsawMmbWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 12:46:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 12:46:06 +0000
Message-ID: <2b274111-e65a-4b99-8f07-220324f1e214@amd.com>
Date: Thu, 29 Feb 2024 13:45:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: zynq: Prevent null pointer dereference caused by
 kmalloc failure
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 sboyd@kernel.org, mturquette@baylibre.com
References: <20240229122250.24786-1-duoming@zju.edu.cn>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240229122250.24786-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0208.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 638b1e31-d530-4a74-219f-08dc392465a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Su9zM4/Hkm1ik7fhPw7w6I6I3hS5LNVlvz5XcqI5tLfWUuAm704O5+xY95s7NENzzBcKfLIhiOlNYm7h6XBkLsrYB1rbntAlZV3UrXhJHNn5PUKOEeFgJLaVor4TshWyQPg3DSYFfkZHvPGA512I2zIVCQu7LF8H5JuDF6U1A664EgbD/TYH6i3xvFMx8yiUfU7tblyiHjWx5ZIHaN320VohqW43VvYYm7dCpEUC4YjLzptHkiiM+w+VfsbH2hkR3xrV72odKK71wToNKHQWOIxVA4i9B9AcwnEhRRBjw52zp7JCHIlBC2yTNMmt/BgiUFV5HKKrw+ivrDs+wl/dLv/rxC1Cij46AaKLUOVdmr0ptHS78eH+x5CO4UmTPvezS1MATSesTafqyLikuFTLeCqCr6Yugj+9OejL3rZKd+2s2eNQEM1wOzgkr44rGANAJgNUnaan3W3F71w4yzBTIJ/qhV4B+Iw/yS5o76TDS3BKXTEsapyPTXnjNd83pxrgd+0NxNZbrgCPw43QB5XByWPs3bqd5pVQ5APySsbXcicq1nevYp6CbezMlgq4sZe2HSdoH0qiCYalItSA/uf14nVTZ1NNwNL5PWmg2S0tQhxtE5lJ3PqqdU/OxXTBBt5E/EUsruiR+4kaeisEruRmLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFk0Znh4ZzFKSjBIc3ZDNW5oOEE1OWRBMnZTWHYzWktMSVZVV0JyakJwemw5?=
 =?utf-8?B?SnJXb1QxUjhZWmxKcTVJZVcvQ1J0c0JBMVNnZndpSXZ1RDdBVElkcm9oUCtW?=
 =?utf-8?B?T1FHcFJjZkQ5Qklrd2d0UmN3YVFSbFNIbEkwc3BDMUZPa0dWendTUGU1Ri8z?=
 =?utf-8?B?bWpscGVUOHU2SVUrajZtVUk0azN0NWVqN3NWQVByandldlhKaXRrZmZKSGhz?=
 =?utf-8?B?TEhjdTQyVENEZmFCdWQ3VWc0WnUwV3J0cEhzVHVVWkZjUThnZ2UrczBwQ2lw?=
 =?utf-8?B?Ymxnd25zb2wrOWxVMVU2TzhSaEViT2ZRWTRQWEVHWGh0cFhqTXlQMkFjc2Zm?=
 =?utf-8?B?U2daUlJ6VXVpTURyV05IQ0VtZ0dXK2tJMkN4cENKYmVCWFhrOCsxTTJuVVZq?=
 =?utf-8?B?TlJmSmI4TzRPd081VitzcEVKNmRCYStHL3BBa1Jvd2FsNTBhRzlwQ0h5bE1a?=
 =?utf-8?B?S3c1OVNTTkRLNjVNd0lPengyTEZZYUNEQlZPUXBKdVJZODhzQlpTc2pwL1ZR?=
 =?utf-8?B?TGpSd3BzMHFOQTZHckljTC82VEtpVmZEZ3c2Wms2dm5MemY2OXR0V1gvQkp0?=
 =?utf-8?B?WTg1YXV0VmZYZlBPUi9sVTMxTDFrNk9CWmk2aFRWSXRQcEh4eEF4WkFNQUN2?=
 =?utf-8?B?U1ptVHlVdDl2a1RlTEErb1lJYTIxMzM5alBNSmR2WmN0UEtxSk9kSFFSU1ln?=
 =?utf-8?B?cC9pUzVxbU9NQzBPZkRwbFVzUERueWNFVXJxTkIyZVVQSWwzQWtNSkkxTDUz?=
 =?utf-8?B?ZjJQUlFOZDdDK3ZWSjJvTm9oLzFlRkEwa0Q2ZmJGaEU4U3B6VEkrRHR6c1gv?=
 =?utf-8?B?VVRzUVFHNi8xYXhMY1JWSzFaZzgvVnZSVisreU1WakQxNC81bU5GT09na1RZ?=
 =?utf-8?B?OUtZREg5VkJpeVliMnRVc1FxN0U4R2RyS1U0QzJnMitwdGh5MDhuQ3pWdUF1?=
 =?utf-8?B?SFNLUENXbFYrVXVpUzAvRm5vN0hRc0QyeFJXSW9ZMndLSXhZWVFMSEFlQU9u?=
 =?utf-8?B?VjYySVpIUWpCSDdoSy9wSERCbm5vdzB6VDd0VUVmR212MmNQNU1rSVdGa2Vt?=
 =?utf-8?B?TjFBY3FNREplRWRNdStEdnVDTGJ1bzNCOTVsVFJLS3ZPcWFYR0VON1NSK3Vv?=
 =?utf-8?B?ZU9tZzlUUXlYK1hBY3ZGdkpoT1ErMk1TV0o1SDFJWC96eFMyMUNVUk1lbUJK?=
 =?utf-8?B?S2pnL3NJQ3d0YTdDeEVOMERiaVZqMkxXdWxtRGplM3ltajdqUCtrR0hGMmZp?=
 =?utf-8?B?SW5yZC9BWU5WK0FLRDRvSmlKbTNaZTVoSDhsaGc1RlFzQzBRMXpLc2w2UW5X?=
 =?utf-8?B?TU5IeSt0TmI2c2Qybm9EdEdKUWk0d0t5cTk3SHNFcC9udkU4UGFxL2hqcmM1?=
 =?utf-8?B?VHhJVXNtZ0UxVTF3dnJPTHovZzhleWdMMGVWNE9hblhISDREWnp2Skl6aFZy?=
 =?utf-8?B?UGVydTZxdzFuRTQ2OXdLTisxbGgyYTRSdTRUTHhUL1Q2WUIrc2hrQ0hWUEtU?=
 =?utf-8?B?UXlCeHNQTFQraUVKZ2MrTTVVK1Q5WEk0RjdQOWNpUWdlMnJrR2orYzBkYldI?=
 =?utf-8?B?UXVvYnFzYXdlQmJieitrZGhGbjVQZ2ZYQlI5NmlEa0srSXlnd3g2YnVLWi9H?=
 =?utf-8?B?T2huWVZoSldYckVGN21Jcnd0NlNzTVVTR3pnL2VUcmhIcGFzMi9yZFBKNEVB?=
 =?utf-8?B?MGdTQWd3THd6OThydmdBelJqdW1GaTdZMXM1bmdyRG41L09HK282WmZ0Sis3?=
 =?utf-8?B?cjk3akpjWGtZZm05SzFWRUhFNDltVVFxSng2blpVMmpVWFErT0k2Y0xPRUlh?=
 =?utf-8?B?VTVzWVJnbXVmKzV5dUpwaWV5RXpqL0NweEQzOWpkbC9jQlBYN2p5S1I5dmlm?=
 =?utf-8?B?S0xqN2VlZlZWeE1saEcwYXhZR1k3Z0ZuZ2hFMEJrUE5MRHJlZXNyOVJQdHRE?=
 =?utf-8?B?MkIyV21BL3ZGNXVJTm1Kb0xvWis2cVRBUmdRVEgvMjRoOGxhT2QvbEdlblFt?=
 =?utf-8?B?QVBFNEJNdTFwVHhHSzJEZXlxb3VsMGJ0ckdQYUtMUkpKSUZaQm9WRFA5TnQ5?=
 =?utf-8?B?cy9TL3pqWUNhRCtyNmNzRkU1Vk1pUk5YclZyS3BFc2ZycEsvaS9qejQyZDNt?=
 =?utf-8?Q?teQS6EwxfNbH/A6WN8BWLbYm9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638b1e31-d530-4a74-219f-08dc392465a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 12:46:06.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72aK0QroiEaO9otszceAyS3wi0QZC9p9e7WZxMzVRC+I74MsKsqPwqWSsQm9IEe0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231



On 2/29/24 13:22, Duoming Zhou wrote:
> The kmalloc() in zynq_clk_setup() will return null if the
> physical memory has run out. As a result, if we use snprintf
> to write data to the null address, the null pointer dereference
> bug will happen.
> 
> This patch adds a stack variable to replace the kmalloc().
> 
> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>    - Use stack variable to replace kmalloc().
> 
>   drivers/clk/zynq/clkc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 7bdeaff2bfd..e4c4c9adf79 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>   			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>   
>   	tmp = strlen("mio_clk_00x");
> -	clk_name = kmalloc(tmp, GFP_KERNEL);
> +	char clk_name[tmp];

I know that Stephen asked for it but variable with variable length in the middle 
of code doesn't look good or useful.
I would allocate rather bigger array on stack with size bigger than max length 
which will use it.

Thanks,
Michal

