Return-Path: <linux-kernel+bounces-43510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287158414FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A67287045
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97760158D87;
	Mon, 29 Jan 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ws8dViBD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC17605C;
	Mon, 29 Jan 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562760; cv=fail; b=KIk4cPw5lQPq6bZpTLe7jBfRcCvoe6smChO6urU6Y55eqyBcKlnz0urdLtxVwXuvSoJJnv4PwnapKAszrU42m+C9I1SP/s9jeuaDC5K4gag+3hYJmyu/+66gfBjaytEiAYO8WPwysU+7SNIyYt5n1Bl8tt1qnTuii5N29x+h8xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562760; c=relaxed/simple;
	bh=PhMK7TsmAnGtAZznUqvVPnycjoNEpkdzgWPMWXxCKSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LqdjnQXQusErSJx3bUkoR9DexQZ5qNp7/tVjgf2TdldZr5+RjAFDuWmSBK++QSqYRzPiIg0IeU1ucvx2IW/KKhwdd24B7PeuuUjc8gMCy6B/buFx6QKHgQPvxtcypM6EXvBlXgChDZyWwO+bBFmy8RCaUwn8pMiiGSNgGi9sfRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ws8dViBD; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjb6Ut9Xqg7ul4AFvhfXbCv8yGRjGBAdk047PA02gv1evmyVhrbd7dYlNhJkbIF2HO88mkv7bNTpziQOmHAofvl/Vk+061q7mJq4IgddEVvBkdNvbS6wO7h95hpS+58M9CAux0AiS957CbNb3fQ2TJY3AsJEgHuaKJeQZmH9rUGxTEERZlG+icAMAoT+4AIGHiT47ONWd9JrTF1NJ0NOp2bNToPK9Uy4P/5yCX8PRdzYZdVEr8wmuCna5QSU8lFIGxScOSi417926WfGIrT5bFthE4/jsSVUuQaPhdA3zFPwxRkgmOMgg/uXm9z9MvmT54IRhOEIzbE0MjTqxoCANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhMK7TsmAnGtAZznUqvVPnycjoNEpkdzgWPMWXxCKSU=;
 b=gBiw9SC/dU6qVQGMGRNPD1zIWrvMddG0dreZ6LPCI1iWFQffg8Sx4D2iTqs47YGdNrz+71y+YpmEOAXa5qWbhEkoK8BAvx+e0iJSt6wPUTVx3p0gKib2PCKAgWqdiciaVrjOaNthhoz1np2sd3wI0DmY788Tv9YHx6IIxOCDQMg8owI1STyhkEZXWiMg3zVoMGCqHBg08gYef6EjmqpPcheSyoKiNIkoWRPCZW5P4SYW33vVwbrtz6bgX8llf5hLGTyYysuX8cTWl+pwX7k5BB5j3AkmTy4j7AmsCUfG7DhS+ErKpcwZv03y5moaOvGCVIJTvJMI05WkmbXHzbK4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhMK7TsmAnGtAZznUqvVPnycjoNEpkdzgWPMWXxCKSU=;
 b=ws8dViBDne3CWwLk3X/KlyZrqrM7A+pOxBL75jubUcsviXDv64hvD/B8R2yqCLtRY+GDvAq+cliRdJSrWC+x8KCjRE+s64YTWb5Y6/LWozL49bjPGO0myMSmrWRQU5gTafPlnY5L5pxIvjvtG7saB1bEgTLLYSvanZe9Iez3TmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 21:12:34 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:12:33 +0000
Message-ID: <a4c179fa-f1aa-4d1d-a4ae-6506dd5d633f@amd.com>
Date: Mon, 29 Jan 2024 13:12:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 0/10] pds_core: Various improvements and AQ
 race condition cleanup
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Brett Creeley <brett.creeley@amd.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shannon.nelson@amd.com
References: <20240126174255.17052-1-brett.creeley@amd.com>
 <20240126204423.47c20ef6@kernel.org>
 <7da8652f-a466-4b38-8d0b-6494e9901a98@amd.com>
 <20240129120542.39757c00@kernel.org>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240129120542.39757c00@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eeb3db3-ecc2-4a55-e863-08dc210f02f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cSeOC4HtCu00nlVbIjPqWgJgmDu1gGozfY3lG9VPjYjWD+nhZwuLNp/0S5fCznePuDPrz7XomscWxc6KxfQ07vxyi1LBFtgYzIUeqeQevf040MPhSvk3czmKl/VUX2+3pnlvb1FQW+dmmUuuG35m+sWiVzyolXEJitbEMGM+DJqMz4GrUvbBl1rxv/gma5P4femgCgifA5eNGWaqmqPvaEsJVCxzG2VJqYgWowX9W1sl07I/+TyFwdFwrlbedA3r/NPOyVFEGZg4GGygfSOTIcRgM/WOSznIqaMqn4QVcdcXMYnxUoFHV1vzTMb+ICbNNFo/6NT2N3mgWs2SEO8e9XeMo/oxvav2l1U3rABvAz0MbE+iFtP8kMZ2inAzr79bQrbpq6/jwfFRWf1szOJbb3pwBPH34gwGCAgZUJPeSC0k2O0ZOdisergHGf/9nIZIfhrWEbMKaK0iA0qB/8vLLk3ypJbdsXgvx/jnk7rdhN9BzOJ51oOfsBKcu7rMBbLLP6YKPcuJ7cCZPzTwXAoC2ObsuJwCtXSJajq65TU9fmFFkCutV27VNmVZn1/YT8MwtVIVx/DzhTK+mEwzvpJDlOm84NUnWnCyf3CtTSD01HPOXcABkCkRn/idHX8YZkhA46VoQshgd3yi9rKu34dLVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(5660300002)(4326008)(6512007)(6506007)(53546011)(8936002)(66556008)(8676002)(316002)(66946007)(2616005)(26005)(66476007)(6916009)(38100700002)(6486002)(41300700001)(478600001)(31696002)(558084003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdqTEVtMDZrZlY3L25aTlV1UUlCYVZNZTNIL09FU0pQbVVINGRxU3orVloy?=
 =?utf-8?B?VzhiWFNtUlhyY1l2a0lOaGxrSnFWeGlPOS8yT3g5Qnl5dWdRV3ZPZ0tDZHpn?=
 =?utf-8?B?NGNzN2xOazNHdGV6MFphNDkwYjFvMDFkZkhOcDNLVVJaQTRkR2JxWFpyWHBG?=
 =?utf-8?B?Z0sreFBFSlY1K0pLNlA5WVNqZWVPZjllVmZMa1dIN1oySVliNTFxQUU5b0VC?=
 =?utf-8?B?cjl1Yk0yRmd3a0xLcG0zS21BNmNaNG9JUVNRQmlHMlZ5WTdIS0JvV2o0ZHUr?=
 =?utf-8?B?YkdkbnMvdGpOK3IzREtlMzRndk9wSU5CZXJBa3k0VlRIQlJUZGZtS3lIVGg4?=
 =?utf-8?B?WGUyalpoSjJTUERJbzRPRDE0WnJ3VEh4cTQyYjhYNnFEZHNUZGF3UzJvQklI?=
 =?utf-8?B?c1hZd1EwNjY4amlrM0RlT2ZaZ0Q2OVdmeEphRXRwRWZJVlpuejhIM29pNWMx?=
 =?utf-8?B?USswUndaYndxcytEclNMam0wRTAxYmJBTXlXeDlHNUFjRTJzd0ZxTFZ6dTdM?=
 =?utf-8?B?NHF5a1lHNmpnQ0Q2RmxBeTlTMFk5c3VpZDVjZnQ2N0Z0Tnd5L2x0REdqS21F?=
 =?utf-8?B?UURNdzlCY0xDYTkxL0dkR0JKTWtSamVDYVpzdDY3N2V5ZUpFdWwwZ0JrQTdP?=
 =?utf-8?B?eUVKY2NSM0EzMUNTV1RESmZhNElkYk9LZkp6NmxPdEtNZE9yL0w0RE1uVHUv?=
 =?utf-8?B?dDJSVk1LVGgyamRySjRIUGk0RDV1ZmdFUjBuWk52K1FjTzBQMVhta0hNOGZH?=
 =?utf-8?B?OVZvNnJkbHNsZWMrUlZIWFo3MXR3YzRyMVNCb0lobHhsRG9vTDVKSTRZcDJl?=
 =?utf-8?B?TjdUK3orNDJRd3ZldGZqUmRZWU5ZdFJXTkRXa3MxWGxXdUJoenhmTmpIdkZl?=
 =?utf-8?B?c0tBNUhiSzRTSGQvU2IrQ3hwS0pRVnVhejg1ekxrWHdCL2Nra1o5Y1N1elVn?=
 =?utf-8?B?bE1vd1Q1WmNnQ3ZZVVU5dnF6bWdYQjJyd1pCcHozWkI0M0VVRWVYbHVObUJw?=
 =?utf-8?B?b2JLQnZRaTBNTjlzaE1iSjRaaDB5bWE5VmRLWmZYUUJFZ0xVOFA4ak5VazZT?=
 =?utf-8?B?TTROSEd0WnI5ZERYa2F6eWdRUS92aGhaM0cxbzVoMDhsV2RtNXR6bjVmUEN5?=
 =?utf-8?B?eTQ1V1cyNWVCdUZGNGxlL1RCTnNDRXIvTVBDZU5hN29iWWcrd3NwVHJWNUFO?=
 =?utf-8?B?VTdiczdadkxYSEdlUHE4eTUzTDVvOGNkSDA0K28xRTIwanpTVGtDT0tCTWZ1?=
 =?utf-8?B?QUl5UGwvalViU2l0N1N0allabzJnVXVidjdLZ1pxOVJIaG1PZ3FJcG1oZGlm?=
 =?utf-8?B?WDdBdHFEVWMxdThqN3VIMm9sazg2UTE4aUt2bEx3RW5EUVYwMWJGU0JmMFVq?=
 =?utf-8?B?NWVWdEJQSFhSZTZENC9HNXdqNDcyTE1rNjUzUjh3MmpLOVVzcHk1R3U4aUt5?=
 =?utf-8?B?blk0MXU3ck1uelZUWmcxeUVmb21sL2RBcHZyOEkvRmpmOTc0VkVzUVNsNzFt?=
 =?utf-8?B?c05xZEpSakdYOVZ4MTVkZ205emprdFpiNVpLRzlYQ1B0K3dWR2ZtTU1pUlJT?=
 =?utf-8?B?cHY0SjNHdkVqcVZrU1lhdGgwRkFHMnd0UkFjUFM0a2ZuTnpMZGk5S2duZ1Z5?=
 =?utf-8?B?eElLZnUzK29tVjhDM0VlV1h4bGwrazd0OE9YZzBWUndYTk5CWjlJdGFYRGtv?=
 =?utf-8?B?aDdvNWJVOVRrdWFsZzRoZkhUYVFodVh5ZzM5Snd6L09jQndOdDJKSGlQOW1G?=
 =?utf-8?B?M0ZLQ1N5RkowdEwvRytydEYvUVNZOCtLY0FRa0JtQ01pRHdRM3o2N1BLcUpk?=
 =?utf-8?B?Rkt6dlpRUjkyUXFGUTRMYXVSajVqNW1IOUVJWjEzOE1kbWJmbFNwbkNVWkFL?=
 =?utf-8?B?QVBNR012d3BTN3lzdm9UUzNBNDVZZkNxSTY3NUhhOFh4SVlDRjNwNGNZbFFs?=
 =?utf-8?B?dXN6NzkwWnVreGhiQlkvQitGMTJKTEZIa2w3N0swUjFxQlpqR0g2bmYxcVFj?=
 =?utf-8?B?MEtKc1luLzJGOVcwOUY5eHF3M0tyR2hBMTZJMlQxRVdmbnNnSzYzVWcxUGpu?=
 =?utf-8?B?MitNOUpzSVdwcFc3eSthOXdEY1RvQXJVb01aOCt5YjNBeGZzRUJoY0dOOXQv?=
 =?utf-8?Q?beVHzlNcbxa7TbxeRtMjAARh5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeb3db3-ecc2-4a55-e863-08dc210f02f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:12:33.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1gbh1a4sFZs62MV1/vPWvyIjA5lKOqzImNzbMulLUhAp/nOSIMcQCDXG4rO4Snxr+LWrAGh1QNVhTAx62JBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

On 1/29/2024 12:05 PM, Jakub Kicinski wrote:
> net gets merged into net-next very Thursday, exact timing depends on how
> quickly Linus pulls from us

Okay, then I will work on splitting this series up between net and net-next.

Thanks again,

Brett

