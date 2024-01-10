Return-Path: <linux-kernel+bounces-21641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55B829232
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2214A1F26B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8215C0;
	Wed, 10 Jan 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgqnQDuD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BE1370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704850563; x=1736386563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M/c45owsrsJgOt+5HQ8sd5fWX1V2VHA2r4CumQxdCLI=;
  b=NgqnQDuDiBiCb10m9MayLMFXgzhQg0MawVLqzARiep7RyOMeFqniM+dj
   OpIl1BmefhpAcpo/WaNWgK62/6bqMvcWKoXJjL2rg4Wghi6rJEmI/FCyw
   9M92EruGHXYGJ63CGOQObwcY3qwznPrXxOmqcgLxhW3FJWlekth0fWeap
   usJN0Ve/5dDn8f3NtFNsO9w83XG9KE3dvmovAWq9iB9iMWKMSJ6Rg+I9c
   L2DuoDyebxha3aBLY5BPxZWClPZbpYteQaTSrGtV5jToT2jT8ll8IDbpb
   flt1rtdQgWWyFVJCnJOZE3L4GvlWlRckbGvEETY8ysrKae8n7ZsGkUlWQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5124780"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5124780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 17:36:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758187114"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="758187114"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 17:36:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:36:01 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:36:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 17:36:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 17:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZdHp1DNhy6t9t+/yxblC+0oFS8VtUOXcdZdiP+IDIxOvRzBEqeDuNuxWHCD7ut55rALNfyUIcmTCpt5ZhMsdgYpnqRAraP/SpVM5ty6+u09gD3NMNGo+U8xEQAVOe3UXBvQ3jYrQiFmkejkBrT0MxGYmqTaXnnrxu4TosbWR94NU5rry/Zb6imdZWmZv1b+wDX34EhJ4XNsPX0mibvu3Z8Qb/vbaJGfYUxNtpLN1cKy8hc20MDgk4LNli32q0zrrBS0n9A7K7VcInO1gMYeKl592VM3xC9hDs8meVUi3PukOICuKPyXP9CM4oI0T2xuIjZ3TzDu6QuQiP5YJJ1b1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHhgHqXmFF+jAEAq09miO2wHjioZxMOVKOY3lCUwwzE=;
 b=Y3NCmOCBPrs+hi7m8CD1jOJavv5OKzoSIjurIcEMrYrjKguObhSnO8ENk9BQmL0aYKZZEfAKRy14EdK0HQxswdtjwvmcIxQ+jtxeMtIqwSjPaLdyBovherhzhh514Q6dzVUe+jP4o3GpOOKwEkviMbDU5Gm7IHdz5Q7tefcD67ITBxx7EubLhjYIyVk2lWx1FPwHJZSRcgUsiBJWuBMDVeWCWdKsACuy6tmbwGpGuVs4d4THJAbunbQPUGbvgBXKCcle4CJAmLyepU9wqocxlklTGWD+kZf1HyY4mNYtxI5+VXKmp6Dcw4o59drOEe5Ud2cEDFWxlqJF1IcpeZgk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 01:35:54 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 01:35:53 +0000
Message-ID: <7be41dbb-8eb7-4050-8e25-cd65018416f4@intel.com>
Date: Wed, 10 Jan 2024 09:35:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: mmap: no need to call khugepaged_enter_vma() for
 stack
Content-Language: en-US
To: Yang Shi <shy828301@gmail.com>, <oliver.sang@intel.com>,
	<riel@surriel.com>, <willy@infradead.org>, <cl@linux.com>,
	<ying.huang@intel.com>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231221065943.2803551-1-shy828301@gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231221065943.2803551-1-shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f208a0-ef8a-4237-0fb6-08dc117c7c1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7EY19Zfo6WMRLNwkQBNTOtV7YLF0taauO5t3Lsa/BLc39PkZ15sLXbwv9fRTj9I44qHF1M/sdMf1gqqR+TkOgDZDnIQ0BK8oP/KujRv5oM6CJ9kg506kOxzl+WmZFwP41nJDxKgOeWMLhqXDFOdxTxnrFeGyLp2VTax2oLK97QJpXs5XOBAixcDo3YQYPjgyV/zwSJoLUwnVp9rYK1Pfou9PaapgDn7jjZZN1meLndJElbhoIxBjIH1ONURda6AVatZRh/VA/Ol8shnZ0Vgs+aQW1lXoFkA4ds2ah89yIPRxXoE+0aEDgkw7LSJaG/GgqchOImuVZKP+5HY5k/ixgZdy39PC9etAu4B+YvAHIADFq2a5q/x13ldM7A9Y0KNbGVfdImmEjuu8aF8Jt7zNCDnBojf3y1lEudKhy1Mo4/Qc66FG/HZpH/9saOL4+mVhRtGczStP2KH1rEnkzSy0gF2hkTppAylFQn0/N1Hw95a1PKrjenYPgSybEsRPep1BGSo4pBJdwm7RGditDVQa10iMoec1nIGmJleXAYFIMPS8FM9fuTYAivKsW/5DYzGBjh50GW/GoPhK/CxPAaT6UETTWCVA9qpijHMi7YhwaiqnjNWlHWFKqkvTgmRENykHBYTF7slAJfn9VvVrIMa2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(5660300002)(478600001)(4326008)(6512007)(53546011)(66476007)(66556008)(8936002)(6506007)(6666004)(6486002)(83380400001)(8676002)(66946007)(2616005)(26005)(38100700002)(82960400001)(316002)(86362001)(31696002)(36756003)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pGdkFuMnFOZU1sbDM0VVNtaDdpTk13Z0ZGdlROcXFOSWxBRTBJbzFHMkI1?=
 =?utf-8?B?ME1USll3NzFlVksyUzlnN3dpZW9qZGIrbEc1YVRCNFM3WmpiUWRjZWpWMWYy?=
 =?utf-8?B?UDJHamxTbFZyTFF2ZE1hcjRSUkJyK0lqQXpkMEJ1N2lKZjN4OXVWb28zdTNy?=
 =?utf-8?B?MWs0cit1b2YrT3B4QXgrQ3pWdk5FaWNPSkFtVlpEblBDWExqZmdKenBLUE1W?=
 =?utf-8?B?WVBkdGlzbWVqN2VHc0RHemRldXlaTDB2TlpoTnorQnp3Z01hR3U2S3dLWFNn?=
 =?utf-8?B?WWREZ0tIUkE4Qkc0eGhOdEZrZEloMGc2Rk4zR0JPWlMzL3hzT0xJM05BY0JP?=
 =?utf-8?B?UDhXenFwd0VrZVhONERuMjNBbTEvc0pYQ2tYRC9tL3lYSldyL1ZseXhLZWFa?=
 =?utf-8?B?Sm5KVjlMam1zVHR1dEYrRU11NHpydSt2SUtzK2lvSy96blA2T1U5VktrV1RL?=
 =?utf-8?B?V0F4VDEyVkordDNzVTg1Snc2Z21rdVFTYUVNc0xDa0tXazFiN2hQWkQ0M2Vi?=
 =?utf-8?B?aU5rdnpSMmFMT3pzVm1nbkdFWTJBS0hMZG9TWi9TbDg0bFNraDNQL3lKMytF?=
 =?utf-8?B?T0orZTFqeVIzRlVlT3hjdndkYU1KZHEzbnJGTVZsR0hkVWNMMHBBa1pxR0VP?=
 =?utf-8?B?RytsN29oTE9wZ0pWb0VOV2VoRWM1S1JrVkFuMk4yS0RkcUVjTVdkbFFYVUFX?=
 =?utf-8?B?NHZLRGFwbUhIeXo0VlQrQURTdjd1bmJJYnE0RVc0YXhmRm5rMVpCeG5vUUlT?=
 =?utf-8?B?SUpOQjlOZnRGOTlVdVIyK29TNWVVL1dWS0Q1am40UjZ4Zm1pSTJzWGo3YllV?=
 =?utf-8?B?cDFWNkxOR2w2RGFxTmRYbkcyRG91S0xvNnlEUlUyWDJPaTV2ZmNFQjhsYklz?=
 =?utf-8?B?RXZZSE11Z2NPVGFIOFZaVWpSR3dMTTdRL0l3NmpJNXZvSlRmYi9oaHVxbW01?=
 =?utf-8?B?UlNoNm1RUUxrTWFRN3BjSStUd0hGMWs0WHJtM2hnV3VtdVZzOXRNOEtZRElJ?=
 =?utf-8?B?K3doV0RVSzIzcFdZWXdyWG55RXZGNGdWSWN5a3gxNDJ6cWJCVXpsUEVOVnEz?=
 =?utf-8?B?aFpVWk1OMVJLY3hGZFY1WWQ0bzRpY2dRRDBaYkU1REpEYUpPNG9xalRtZVVx?=
 =?utf-8?B?bUJlUzRqK2VtbzVPQ29Sa1VYZFFwVG1rTlNJaDgwYm5JSm5Eckx1dW95UkdJ?=
 =?utf-8?B?NHYrQXRXOWNVaDIveHFwU0NVdHhUNml5TW9jcDYxUGtDaGV5NkZXVnlxcFJy?=
 =?utf-8?B?c2FxTHZ1d2dsUWhkT2xhVWhkaHJheTR5eTl4RGFHeEg3eVpSS2NaNnI0eEs1?=
 =?utf-8?B?RzBpRmJxWkNYSHZmYlByYVA5c1pUbDlrblhLVEU1OXdrVTQyUHdVM3VkZldx?=
 =?utf-8?B?TERCVW1yMVlEYzJDR012QUxidlc2NjVwelYremdTQXlocUJ5R2pIb2VjeHR6?=
 =?utf-8?B?cGgxL0VLUkhFU1pJb251ZjJoejdwZ3czSDNhalZMdFFGc0RleG15R3UzMUl6?=
 =?utf-8?B?L2lwaFFnRWZpL2tVMU9NMGw3NkVZeFVSY0g3cVFxcUJvcWY4TFdBN1g3cXZz?=
 =?utf-8?B?Y2ZYcGpxMG1pYUlsNkdrcFd3MkZhcWpaL0M5Z05ET2M4L0t0dkJLNStROXdR?=
 =?utf-8?B?T0NpMGtWMk9ZN0RSUjAzR21PenFBejFXYW1NY0tKR1hFWWRlNXFHWnBmdXB6?=
 =?utf-8?B?NjlJeWFyK0hZT24xZkZxYVdzdWxFdWVKSG5OZnhnTzBmZ05LRDBFOTY0bllR?=
 =?utf-8?B?bVpZSElTcGdpd0t4ZHhBUHgxam5OeEc5UDZSR3BpY3NTeW8vNlcvZ3FNNnJ1?=
 =?utf-8?B?dU9qMDVGR01naGtxRS9JeEppRGczY3VBZWdQQjM4aXhjbTg2NXVCeCt3Unh3?=
 =?utf-8?B?OC9ncGlxUldZUkV0SHl6TmtKNmxHSUdDR0M3N1BmRnArN21vYW9yRVNqZmV4?=
 =?utf-8?B?dUFQUEtHOEl5R0lQVWt3bXl4M0Z0ZHpUKzZFd3c5UmJnUWFaYzFDcVdudC8y?=
 =?utf-8?B?V21tQ3B1dlBFMDFXTm1JVGFWUmN5SEJOazV0dVZhYTRveUpBVEFDNFhuMmV0?=
 =?utf-8?B?SkJ2Tit0TjRrUzMvRkVKUklOeStuT2FSSTh4RXdxT01raXlNdjN0c3VNdE9O?=
 =?utf-8?B?aHpNNGMwaFZHZWZYYUMzVjlWR2V5S1hDVHRyTEVTbWNUWU0vRXNmdnFkT3BT?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f208a0-ef8a-4237-0fb6-08dc117c7c1a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 01:35:53.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s30xbqaE7TipACTpSjlu0JxGcgM8BG9XSf3l94vhf7XR+Ob2bd8ePIpbN/CQNiDd6R/UDKGXSFbtLgWJLXCzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com



On 2023/12/21 14:59, Yang Shi wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> We avoid allocating THP for temporary stack, even tnough
> khugepaged_enter_vma() is called for stack VMAs, it actualy returns
> false.  So no need to call it in the first place at all.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   mm/mmap.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b78e83d351d2..2ff79b1d1564 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2046,7 +2046,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>   		}
>   	}
>   	anon_vma_unlock_write(vma->anon_vma);
> -	khugepaged_enter_vma(vma, vma->vm_flags);
>   	mas_destroy(&mas);
>   	validate_mm(mm);
>   	return error;
> @@ -2140,7 +2139,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>   		}
>   	}
>   	anon_vma_unlock_write(vma->anon_vma);
> -	khugepaged_enter_vma(vma, vma->vm_flags);
>   	mas_destroy(&mas);
>   	validate_mm(mm);
>   	return error;

