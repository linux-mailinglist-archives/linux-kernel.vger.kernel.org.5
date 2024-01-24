Return-Path: <linux-kernel+bounces-37292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026C83ADDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE01C2433B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACE7CF05;
	Wed, 24 Jan 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdyLN/L8"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA471E503;
	Wed, 24 Jan 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111821; cv=fail; b=NaoJq6GSNwTrvfExdS3VI19USTzmzzbrIc6rsDIeC8TM4k4oNKEZ/yD+wRTGUJ1+Y54LvHrn2+wu+GlpDolTMt8Z7n47VgyY1I01HP9O0cbfhuyp01SUHh0D4YTjbFvVoDX7OflFfh+QBr6JsGDqNGDwgmuZzJ0AcWQzKwdotJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111821; c=relaxed/simple;
	bh=OE+Js7+7E4nPwQ2bD1uxUNK6821HNbum9I9uDNOQT0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYq54lrXbGNgNv9DZdXXmon1wZIetPac5uUuQ3CmCmkp8toy4jAfxQ3/0xYBZ1I8OFp3DveYJqAKp3bm6wkUmIXnqYSfswWW9Yo27Kaz+kWseGkTuwgF37owL0Tn/5zeNXD/x0aR4Zi9ZA3wdVygSqIdmv2/lrxHMcC8Dpk3VeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdyLN/L8; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706111819; x=1737647819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OE+Js7+7E4nPwQ2bD1uxUNK6821HNbum9I9uDNOQT0M=;
  b=IdyLN/L86dEFvabRECQZIVekvt8/WxPylGeqlUswLVHqi+9vU5jnj6hp
   puhCB4BXKPW9L6e0u4XV4gO99f+JGie1l4hyfFT9zla2Z+x1aLfqzmUrX
   +iQb2wRyGk5i4z9j4s0uMEjMseRgpvfapfyVxM4g8HH6COV/XSMQStIYI
   Q8oBs54HmJvpkxt6q4aH4p4F1x04ihDi7A0/Xv6fr39Y3sqFOR/1+iXnn
   jI4pDJKsAuLa3dsMR0n4MPBYiCGBtFY5RaaCPlcnDABpPNGQcSq4NS0EF
   7Flmyg1J5Ve22yP6qFaok0a1cRLwOhvqqq+L/bJC5LkJbtliMX4dyt0eG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401542449"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401542449"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:56:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20757797"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 07:56:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 07:56:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 07:56:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 07:56:42 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 07:56:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvXnTxMS9FtDZfKk8+kXsRWF50Eo0bGWcHg1VbbR+pIgHIPjYdwUzb4VLKCazFrWK5lg6BWuDSDNMkdDisfHmekgqj+XPySCCDhDki1A46Q/wNp0rqCmNDCv3GGA4XR+nDK3ip9pfGQce3YMm0bjfgKMFmbThXgX7Gwpn+ooe/2Ce2vWwUnWw9GYGL6w3J2RcGuxtv+IpKCp0M+E+Djmb+xLTkzUV92hgIv3LhP7cz55h2/W46AByil2xEx7mGOq1yJOHFnYbJh5MbGu+CT514+u7DotJm1HPacPHTHZ4kJ10kGrSKTo06Ok0yyh3YJNVRXlg0Bc07UGms5kEAH5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7LylUffBwzKaEyp7ha2OVDpGfLRk4wZVnMYlnq1IDM=;
 b=bDN7p4yTtDdftQZd0eUGEItZXW3OaJz0l7/tNaz61vm3kLaJVx7p7DI3h4ONq9jj701F4mbasPonufvR52mci0nN6LaI+z9+J5UH5xh1k58M3qQw4XfTiyCr6IaxV/CQfOTilTEnwcQHevBz1+dbXP1tEweWDua6BK0VTXcnFpGSoOfgs0d4uYwG9b7vIalFwvM8N7yS4pVQto1z9WIFM7w3iRKUO5JfUD9ygahp597xMBRABXJQEaWs1tk3MxfKoV1KcwIDelqljXrI92WmehIDQbltS7IIBOSyrNonH0UeAX9MW9o99S/fWHLtWfC3DpkhqLrXewCVCPH4cOq8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:56:40 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 15:56:40 +0000
Message-ID: <eb055cc8-dfbc-48f6-9a65-31bdb35c8661@intel.com>
Date: Wed, 24 Jan 2024 16:56:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the pm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
References: <20240124115152.0806fc05@canb.auug.org.au>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20240124115152.0806fc05@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d00743-05b0-4a24-6184-08dc1cf50de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uONOGCvOpAVWIfFKK+xAyle2X+gCWujyh8NYCbRBsIGFVJSMNVZeiwvNE++0F2jqM+wdXBgnHTBxAs0fHz6AsTQ+5hUus8RdGT2bRn8B5NixXa5sn1oAa+H2jgmVf/gF5+rrZTJq2SHGC/sJdFFpbhmv0880MaPJqnnH+a2SUjXF1VSjgO/nAARrXcVWiSsMUUfKCGXFhayQ1pZyGxiRTEYKmDHnTgTG849KzRfEFrQGjIjmToknimFPPiFuRw7z/Q5aExSFq5uIjeU9TnFc25jqbsl7heqJVY3kDz7cn7vvsOSTvgmYNllNbcGIJig2wjWJH9rQ7n7G9LSi/fIcy8+D/++SCQoCaoUtt2GY6hplW/PkYweAef7wOlTFxeUsrcvRBC8JLQmSN8Ry/kh/UcZ0mS/X+++Wpzipy7++q1++ao1dF42g2K/IArJTCLU+pC5uLxJyL/wHobKjCiVIT+sP6Sun4B8K/WY/YRMxLCOSVIZcRj4Ox7nOAwj2NmeCEvW5BLxDbVoOTpUIJTBbitXKRmDGE+v2GmE3wDjLs4yvKFCBobfssvxneYfxl2+jDP/iB/d4EY4cYjqlFScx6Dw1BSVQBqLPF39f8qW7WQ4VsfTMe5BZee7RoIsWuJgRC26fllbIie7YtRYnId4G5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(110136005)(4744005)(2906002)(5660300002)(66476007)(66556008)(66946007)(4326008)(54906003)(8676002)(8936002)(6486002)(478600001)(86362001)(82960400001)(38100700002)(31696002)(53546011)(6666004)(6512007)(26005)(316002)(41300700001)(36756003)(2616005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTgvZEQxRWhmcHZhZXlHdm1FTm5rY2xTSE0zeDdaU1JRRkNVQ1NJbHpseE8v?=
 =?utf-8?B?N3dFQ0plREJoQ1RQZGlUNWFjY01tazhhS2h3clRNTEVYckVMZitja0RzNmlG?=
 =?utf-8?B?UVp0S0xiZ2ZOQXNjZzdscTcrVW95UlZVaUtmbVRZOXREUEJUWXNaUGxCa0tu?=
 =?utf-8?B?T1dFN0EwZ1gwSlZsQXQ2OVFqcnQ0TDNsZjFPd2NGWkMrZE5sQkFEM2FOdWRH?=
 =?utf-8?B?UEV6bnl0cE5hRmN4T0ZMdURZMmhkRlBPdk0wUkFvRWMwYW5MSDVac0NJYzJJ?=
 =?utf-8?B?VUVBdG13dHZtemVLajJLZS82NkFxVFhkMVdNckkwSGhvRmNMWjFnNWMvTTdR?=
 =?utf-8?B?bG5lT2d4ZzQySmxBeXUyNVRYc2JTNzhRVXdYVUZXcUpQRUdwN2UyTHB2dTAz?=
 =?utf-8?B?bWh0OEs2TFlOd3BTZDdsd2llZ2RyZTFNN0lEWnk1UEMwU2ZkaDJqWmI1RjJ3?=
 =?utf-8?B?MDRLWWZnbTlaZjhYQXZjT0hHemRNYzBKbzBIN2krZGJ2Q1BuRk9Md0daOGpH?=
 =?utf-8?B?TFpubGJ2cE1EeWs4MU0wOHphOURaK1hsdVg0ZVFERExyK005R0U1MmhUVXo5?=
 =?utf-8?B?N2Z5STZPV0RMaE1uRTBYRGFBdFltQnJwcGNQVzNWdUVLd2lvOTFOY1lRdEVl?=
 =?utf-8?B?cUJmU3R2Q3pxQlkvL05kMlYwcUkxaVhzTUQ4YndQQU9IWjVGQ3pnVzlWVTJF?=
 =?utf-8?B?NGk1QjMxanl6V01mZHpweWJOUmhWVWJNK3diSURWZjNRLzRNODBYakFKT01N?=
 =?utf-8?B?aWpCRFAxa1p6cWlPb285Q1BSb3dhVXB3ZE9YeU1XK3J3WkRjT2kza29KcHNx?=
 =?utf-8?B?K0N3d1VtY0hKb080dVlHczJVMVZJQ0YvNnJ5NmkrZVdYQWtBa1V3ZWRTa0hn?=
 =?utf-8?B?U2o0Yi90bHh2dXhXKzAwZ1I2dlhlUmdITU16b3B1Nk5JNjdMVUVMSUF6Tmlu?=
 =?utf-8?B?aUtyNHlVdHlnaXllaWtpN1hnNEVaK28vbXBWOFJzV2poNlNZY296dDlBM1Jm?=
 =?utf-8?B?a0U0MlY2N1ljY01ZSUphZWkvQjg3cnNleFpRaTV5V0ZUbHZLd0Q3Y2hjdzRX?=
 =?utf-8?B?QXF1SnF3R3BNRE4ySTJRM2hYaTgycWRtKytMRVhXNnlTdDFldktrQnFYWjBr?=
 =?utf-8?B?WW1FQTgyaWtwVGtDYzU0UElUclMyalI3NllFd1RTblczQzhvV2tQK2JPdTY0?=
 =?utf-8?B?UURabCtUckJpZVlvOVpaMjlSaTI4aWNsK2JqZS92cHovemY5TUs3WnJyb2pR?=
 =?utf-8?B?SmJWbmFraThXYVZKVG8xQlFoQlZBQW1aclYyYlFEbkMzS2ZML1NGWStSNDNh?=
 =?utf-8?B?NW12VmdvQlRHcDNhdmNFY05JcTE4aWlWQlNyVElNT1lnZjdaOU1oQmFBbWxT?=
 =?utf-8?B?WkpMVEtHdU5CZ0pKQUlZR0hRKzVXWkxQVnFVQ0EzZVhBQXZSSytWU1JTN09a?=
 =?utf-8?B?b0pYTUJ2c1BNMHRkNFJmTm5uRUdScXJvS2RlUWJ6RkFSaU96cFg3ZlNVa2lI?=
 =?utf-8?B?eVNDcEtoWHp4RDZTZ3FyQitCa2NtSm9TSklLM3ZMRUdpWGFCZ3B4NE8xNWI2?=
 =?utf-8?B?c21CK0hVWStDK3R2Rktyb1NsNVJWYThuZFJPd3VyaFg0NXA2N2pTZEM5OC9H?=
 =?utf-8?B?Znl1MFJBbXF1dS9uQjJ5SmticGJObGIrTXFXWjZzR0Q3RjRTK1ZlRlFvYmxq?=
 =?utf-8?B?elJlakVUVERLa2VZNjhRa0YzN01NdXk1M1hPaWRCcWpyMzJJU3A2aG42dXFu?=
 =?utf-8?B?QXEwRmI4SFdhV0ptaVN5QlV0K0Q3enBQakFRZ3lEc3MyT05jaEFyZzM1TDRZ?=
 =?utf-8?B?Z2NMYXhXQ2daMHdzd2xXNUVlWjROazVlaVNIUUI4dlpyeHpHVEtEa1F1c3Uv?=
 =?utf-8?B?R2hxN05CUGg4RENkWkpteHBTYi9pNEwybFpiYW8zWGVjMFhlVlRJQ0lYM0ZS?=
 =?utf-8?B?dW10RUNCRXBHL2ViVkhwa1diNDdpMUJpMmNzZHB5UFFaTUxUTlQ5Y05RYXRB?=
 =?utf-8?B?R3orcG1LWFNLUVh2RTVFZ3lkRnovSkdmdVRHVnhsM1Z2ZmQ5c1pkbGF5Z0pP?=
 =?utf-8?B?MW0rVkg0b1BNNURWRW91YTNKdEsydjVRUlI3blNQOGJiOXYrbkJ0VnVSZFBK?=
 =?utf-8?B?RTB6RGNteTlVK0tZTDN4dHIwSFcyL0pnUXhlRmlIQ3hGSHBLdUNjMEVGWXJj?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d00743-05b0-4a24-6184-08dc1cf50de0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:56:40.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUD/w43v0JAwtQR+GGN6KtGrvGFu90FEdwABnhZzhHpXQKtLcbrQwv4gw/iIkFDCr/pF1T/31xdt/JjNoJ9S8WquMRLQd5rnsI8d1CktRxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com

On 1/24/2024 1:51 AM, Stephen Rothwell wrote:
> Hi all,
>
> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> drivers/base/power/runtime.c: In function 'pm_runtime_new_link':
> drivers/base/power/runtime.c:1815:31: error: increment of a boolean expression [-Werror=bool-operation]
>   1815 |         dev->power.links_count++;
>        |                               ^~
> drivers/base/power/runtime.c: In function 'pm_runtime_drop_link_count':
> drivers/base/power/runtime.c:1823:31: error: decrement of a boolean expression [-Werror=bool-operation]
>   1823 |         dev->power.links_count--;
>        |                               ^~
>
> Caused by commit
>
>    5d872146e7f5 ("PM: sleep: Use bool for all 1-bit fields in struct dev_pm_info")
>
> I have used the pm tree from next-20240123 for today.

Thanks for the report, I've dropped the above commit.

A fixed version of it will be added later.



