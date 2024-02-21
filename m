Return-Path: <linux-kernel+bounces-75629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD985EC77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB742823E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0C85268;
	Wed, 21 Feb 2024 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5FlUEge"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9727FBC2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556668; cv=fail; b=cCpXa62EIx04HQHz/L7ubQnu7HXdtJXa1YdCzdYwreclrHv5MZPf2d9ra/e73yIbj1s7Zwp/PelHzPrvle+0dxC55hQXUchf3zLBHFC8yseY1Il3mKDCoy0H2G8c3vpjjFdsJ636r+m/qvH2u8qsZtMHa+FZbRX/OVYIWmlnJpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556668; c=relaxed/simple;
	bh=kI/pMkzpn0k3z7Tb4t6xv8jqrRb5BWVdzI+iHZJ22nM=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ggcfc3ISGYNQfn9O4R02yUXTxHOM2VnKJzJP4q6go/gd3BRZmWvS/2q2OVQzvN2Fu/kaAjILfWbDQ8dBziCl+WbsCm+JifmcbPYhkDzxhpvn1RAw/uPtZIHsMDLfRSaM2pTlLRfowltohchl0GejYZlLU3Icj8zRlRqMRjUr91Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5FlUEge; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwlDAGn+wcHaUFQHTJ8OVr3pBoPRQOyYEZPqweMUJPiLA6rOvz86G/IUkIwT52U3RLn+BluW/wGpP9x06uLlIy0IR0Y22xZMUA5bx9m4j7+nVy0bdzUTpvi+8vcj30gOF5f/dsDvli+DhgHonH9vIiyN6pgtkFAMwIgAnPRkTeagpZG/cU/9WGIMInEAj96UwRUSmhXW1MPx7esUyUaSiXw4vCvFjINCtAOULv0Si2q4vaFcUzHijjbVaQqLRtqsTf28uBiPidtELCd5qokKWyQz30A7XC79s03IeOtNTfVe7CM85FSPfUrW+lcxZ86x0bxOUDZ27+CLLPeNPOGf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WplncR8qMNJq04yTm3fQi4iwGpvlF+TxwRCbzXTwAA0=;
 b=MR3BfaGWkDfOrR0V47nWsz+zpLprgdkfcuLolRXL+YrOFiV9GQZsojxW+3DzoxlAbuEyagLUeEWIquRNjdU4y2VB6doaQdpUIYXkfzAXjmHynHL78bY9unay7/0RGtTnsoK14ovuwwRbPBHJerqFIh6nYlzBGuDE7fb5KiFBNgiTTgSqSlsj2lUCKg/gO32aKr9SqTE4AsblUCVFEgdIMoDizBaD2zoM13p3UoDB/fnnMrS1lhUpAdV48wyZe6het9LUgxfkUMucsEM20hPwF2/1Ysj67Ey1lPgMd2PWtB6T8lMO3bHVL8qF9J4Egh0dNfLEWpe8j3gTx/C6fCx3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WplncR8qMNJq04yTm3fQi4iwGpvlF+TxwRCbzXTwAA0=;
 b=j5FlUEge/kxnW8lT3smfvieo/WcbNNyxNOJB9+1vcWwrFUbaATzcDY4fzXvVda2ztvEDNz0ef7E1cTE4bGKHnKLVKpe3Azb89Xj/cJvMgteJKhFGVhELDjg617bLvPbD0T4jtyEYkfVn9iMoKh1MdAmhHN5l6aT/pTokXV12gM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 23:04:23 +0000
Received: from SA1PR12MB8722.namprd12.prod.outlook.com
 ([fe80::4b3:427e:7f83:2130]) by SA1PR12MB8722.namprd12.prod.outlook.com
 ([fe80::4b3:427e:7f83:2130%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 23:04:22 +0000
Message-ID: <bccf8567-1b5e-497f-9724-e858447216e6@amd.com>
Date: Wed, 21 Feb 2024 16:04:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Lenko Donchev <lenko.donchev@gmail.com>
References: <ZbYYpky2sb8p8hjx@nixos>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <ZbYYpky2sb8p8hjx@nixos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0631.namprd03.prod.outlook.com
 (2603:10b6:408:13b::6) To SA1PR12MB8722.namprd12.prod.outlook.com
 (2603:10b6:806:373::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8722:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a57a13-2844-4a1a-cac9-08dc3331714f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZDaMsQPIHfENyk9JqrjJGIqIlwmZteeDBEUr6W1oG/0urdVI8VLp9/7OeJg6bt5XtxAmdHei7YY9uzceUCh4pfac2kpzc3fTC8agw0o1ZK94r2Oas/rjsyANTtf0NvRevNHe0LUPDjOX6s4kAygPBZFwyeV4cOf84bvbbjmq9WjJFcQEujnoCsFs7cwutea4813v+65HnTuxuM3HYOT2DBd2FT9zhKvNMnTE/ajAYIyo2qYVettMvdSmXyN9sxAEIEA7LtRyMNlT+4IU8SSxNBGExT1oBPkHAg584hB4836U9rLQiEHghOhMKURHauog4yVmbbZKpiSo22iZYqTGB0wFeI0Hmt4F2HDwEnnc9eeNV/y8/Nh1M3LnfVm2RMzMoaxe1ZzQccZri1Kqbcq9b1BhFWAZRYSNb2kZzQkRNwAnNZmx0+E0JAwjcxwNJ2vdZVaSF4/xcejQxjL77zw7G5iESyCQiGH/pYoCr4vhPjTRBFokuKs7JFl5sdXtFJ+YclWqzaxfnTtWpbqkj2ZFtg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpvYmtpRnk0Zk9kcENxYXZqWlIzVXFmNTdkMW9JSllTa1BQNTBaWDIxNnVM?=
 =?utf-8?B?WGNwZG9SNHpkU053RTlvNlVIT0Z1MzVSamUvQmhqclFkYnk4SlZoZ0tRMVFC?=
 =?utf-8?B?VFBtV3RmR3lKblM0emJrTnZNTC93cGwzSUJkRm1VNTI1YXBlZCtPdFhEczVW?=
 =?utf-8?B?cHV6L0MwVVA0K1A3ekRiNmkxbW5SWHFQZU40OFJjVjA0TnpxU2V6UURjSG1I?=
 =?utf-8?B?OTFUS0Rlc1V6aTROZG1taHRJNUZzcW15MmRyV0FQQzZLYU85d2dOd1FMeW9V?=
 =?utf-8?B?cDVBYlluc2JOdWdMQjlJSm52ZVArc09CalZrMFZpR3BQQzlxenB1ZUkzNkto?=
 =?utf-8?B?OVNKTjA4NEVVd2JTREdCdXF1cStUU0M0SGFodVRaVDBYd3V6OTJsK3MxU0FF?=
 =?utf-8?B?WHRvYWRPcE1ML3E5Qmo4cEV0TVpzelIyR1RUWERkN0VUckt1YjM4Z2tBdGlQ?=
 =?utf-8?B?NHN6QWVBQXp4YzcwYWhnTng3RDVYMWEzWWtpNkRhZHR4aUVqUUZ5WWZoL016?=
 =?utf-8?B?K2NjTGhJZlRvdkZuL1FXWlZYY1hOYXp1bTVnamtkdzhzV29Lck9ub3gwdVVQ?=
 =?utf-8?B?MzRNSHZaYWxJb000NWVQOXlkRTlxMlNmMHRlZnJwNHo3Q3J6RGtYT3hXd3BX?=
 =?utf-8?B?YTlyNEs4WjI5UWNIbmpEMjJsVUxVOXFrOFltZ1J0OWF1QVFJKy9NYUhCOVZv?=
 =?utf-8?B?RW1BYVlEdnlvd0xQbEFsbU1BV3dkUWc1RXg5Q2dyZFhJK2RaUEJib3BPbFN3?=
 =?utf-8?B?WEZWTkhxdVlScXcreGxIQVRzRVZaRlhhZWRFa3lTRWR0d2NUQ2pmUWdNZytU?=
 =?utf-8?B?c0hmaWZFSTgvNU5DM21oS2RtVkRHdGtIbW9FWmZDZkRzc0JUUGhZMjVmL3Qw?=
 =?utf-8?B?bjYyMzgwWWJpTzlVeXRiRUtnR3Bqa1VvUE5lcVNYYjNpbkJ0UFFrZkJFYmFK?=
 =?utf-8?B?VjhOMmJZYUp1UmFqSGhtb0xKSGwramRaR0RVT0t1eDlicU5UbUZzNXZOR25K?=
 =?utf-8?B?RnA5Tmg5QlVRWHB3RFhnbXkxOXhuR1RMVksxcEpNNXRmNWdsSXl5Y1R6eGVT?=
 =?utf-8?B?YytabjJYSmZaZ3RDZ2JRQTVNYmlWTmczeHR4Mm4zY3lWZWFXVDJDbWdlejVV?=
 =?utf-8?B?MVEyZGloM21MbHBkZlhpZG5ZWTBSaXhIR2JJRUptWkMzcDFlcGxTRDZBQytW?=
 =?utf-8?B?UWZFdExhQ0JpYVMveGNwbzZjVWVBYWZMYVZ1aVUvRUlrbS8zS3VqcGFEZHN4?=
 =?utf-8?B?UWtxSlVBM2dwSkJyMWtpaThDL1lrRXZMMzRqcTZNR0tzQ0M4aWF0a0Q1Z2dI?=
 =?utf-8?B?WW5XSXFYdExlUjIzY1JEUzJ3cG1CWm5ibG1FU3FoaEp5VG1ZdzlxeG1ZdFpo?=
 =?utf-8?B?S2haQ3JCczF3bzA5Ymp4UkZZQnFVdEh2clYrc3haTXk3Nlp0K1VwbXZRZDB6?=
 =?utf-8?B?SjN2K1R2OHNqRDNGVVk5NVpIT2NNY3hQYXdoWUg3NUtVSVhzR1ZBZDhDci9x?=
 =?utf-8?B?VHRLVzhTRi9ESG14eVNvdjV4bW8xMUlZQlppMzdYOUt0WTBSZE94ZlNteVlz?=
 =?utf-8?B?NElSQ1hRL3hqRnJaSjEvWnFaY3BGRWF6Z1ZobWRMNHpNWUJVN3R3OWNuRDlI?=
 =?utf-8?B?cGEzREgyYVpPTEx2MTJhYWxyZGNpU3NRMlJzZG5mV2U3dkwvUGY0SEh4c28z?=
 =?utf-8?B?d1J1VG15UkpHUndJUzhNTTk1ZUpvcHMzWjlML1ZLUzR4VU5idVdlVlRRZ0dB?=
 =?utf-8?B?NDlva1VBai9OMkxIb3A1QWViWGJhbTlzZjFJenFXL0k2VHBMemhMejIwYnUr?=
 =?utf-8?B?ZkdYU0J4eTlZQWV2eVhXbTVBSVhDRmpMNlhDZWdjZG9vUDk5eXpra3VzM2xN?=
 =?utf-8?B?K0E4cXlMQzdsYTBxOWRwYUhsY3dTcCsxVHhZWlU2WXk0OGw2MFNJcUw0NFdM?=
 =?utf-8?B?NFBxQjNNd0pXUDFzaXFIMkcwTnptU0lzeldiT3MwczhKZ00vdU9VWkRFYW55?=
 =?utf-8?B?czlNcXZUenpZdDNwbDJNOXNkZDExbk5hWlVpZXRJV1FGc0pDRFVFOG1SdU90?=
 =?utf-8?B?VGhWTTJzTUw1dUY1SWxrTVRJUGF3UGQrVVgrZU9HZHVqY0NnOUR2V3M5ays3?=
 =?utf-8?Q?C4iP5LYwhceF/Q9lJfT6VugIP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a57a13-2844-4a1a-cac9-08dc3331714f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 23:04:22.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzCtf/D+OFOuUa2Dz/YG5hl10qFDVFe+UZV1OEK3DCqf9qVJSDcmaGTpxAShAL29FRjf5jIJsOdfR4aAMeLoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551



On 1/28/24 02:04, Lenko Donchev wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> Link: https://github.com/KSPP/linux/issues/162
> 
> Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
> index 5c9a30211c10..b67cd78e7c58 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
> @@ -164,7 +164,7 @@ static void dpcd_extend_address_range(
>   	if (new_addr_range.start != in_address || new_addr_range.end != end_address) {
>   		*out_address = new_addr_range.start;
>   		*out_size = ADDRESS_RANGE_SIZE(new_addr_range.start, new_addr_range.end);
> -		*out_data = kzalloc(*out_size * sizeof(**out_data), GFP_KERNEL);
> +		*out_data = kcalloc(*out_size, sizeof(**out_data), GFP_KERNEL);
>   	}
>   }
>   

lgtm,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

