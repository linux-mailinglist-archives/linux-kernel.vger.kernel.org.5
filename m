Return-Path: <linux-kernel+bounces-25748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF882D543
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA104B21089
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CA6AA3;
	Mon, 15 Jan 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfwsZnT5"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811E63B6;
	Mon, 15 Jan 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705308357; x=1736844357;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=My0uI92q84Lo6/lEX8aFg5JajQVkuOQZNbNUzVxZ0NE=;
  b=WfwsZnT5YptGUorDg0LsNX0sshpZnlqOQ5La1DlGvUAS6yNnqx60FBi9
   2lm3xQhsLPB/yueQCqAmy3+TJWfRQV14nc+LghTUZE85MsSrWgrVabKL1
   F58bzrUWlZmYK8FLJDfMqVAK6C3P30lPhhi3nr2WtimNZs5FOVPJqaV0A
   cXKNAdHyFCDmsbIq3RpGKtFLA91uy3INnBo3K8MwLOuITYyfSuozYCbPo
   GW8QMlWvLLLp+2OBOgpmt0uBdME2qU/eIpbRQXj16X1BJ5MWp9sKuS5dt
   qLQmaq0CB2oSHzQPMemeTJPeuImvzqG2NqPHc4n3FcvtsogxBxVBWpvGs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485725812"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="485725812"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 00:45:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="733244107"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="733244107"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 00:45:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 00:45:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 00:45:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 00:45:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8ZuF2az6cxMr0Di4meE/M+u771kKWR4d3lvNQXG2xDjLrqsFtIq5cHXchIC6Pld53CLUaZKDimXBVDsZByueEPMWgiMyYkTHYgrDQek25Jf/TFQos/wgZW0x9Y7Ln6UuA3/f9VqI7swE6cKXxTvEN945IfhhbGTKvjrweBZuPgr5Uc5GNNu5mAWebH2TUTrzkn2saY8MabSFhaahJO6biv8bDK35pdl4x6Y2IoxrWbC0PPJTP4NmbJplO21uMbf4q3WmHWMzFVwA9Z5alKMY3GdkVUWS7dASB2/1axyTUMkRP0Lr9486iFp9sZE2ZxIguc0seWUrfyfdXVWck7ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKea/BF354z85m8KS3l6AUvsbavpE5dfje7xCQRhDlo=;
 b=hzeB8TFA8rdv1rTLC7p9u2W2hMuWR6B22/kYJw6ZhkkPQEgTDsMP5+l26T8N2rcBpsKS3Hck6yeQ+0ftIIqXNkmnShfVOePywv0WxAdaWVWbdFy5gXnwpm/NCTMTxTBBZqP42euKqWkGGm8TwgRMmXty177ErurJwKBqKcXAIjJQMpL2vpZq+979Zj59nojWOIpCP4N06I0Wgy9kTARHOY9winl8bfyPAQFhpzszeQktz251wS7kHNxDbQtM3yEE1+7uc8y1HeoxZwOS9YWz8ib6T3ULJa1tSW6UUJKC5hBqzZce51WbQ4HDMT5zvjRpwerX0eqhtWBpvGZ1JOXu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8724.namprd11.prod.outlook.com (2603:10b6:408:1fd::5)
 by PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 08:45:53 +0000
Received: from LV8PR11MB8724.namprd11.prod.outlook.com
 ([fe80::28ed:e2f9:9973:b40]) by LV8PR11MB8724.namprd11.prod.outlook.com
 ([fe80::28ed:e2f9:9973:b40%5]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 08:45:52 +0000
Message-ID: <ebb7908c-d28c-4549-8aa2-1e0e62c62e8a@intel.com>
Date: Mon, 15 Jan 2024 09:45:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: isci: request: Fix an error code problem in
 isci_io_request_build
To: Su Hui <suhui@nfschina.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <nathan@kernel.org>, <ndesaulniers@google.com>,
	<morbo@google.com>, <justinstitt@google.com>
CC: <dan.j.williams@intel.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<kernel-janitors@vger.kernel.org>
References: <20240112041926.3924315-1-suhui@nfschina.com>
Content-Language: en-US
From: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
In-Reply-To: <20240112041926.3924315-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To LV8PR11MB8724.namprd11.prod.outlook.com
 (2603:10b6:408:1fd::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8724:EE_|PH0PR11MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a638728-2408-40dd-3199-08dc15a661ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xr4UxziVfvPNTLYJWZyjd5qy18Lqll73JNfMS0fgompzINaRUYYLZsOUzSzSf6ZRGsPNIYcPOT5pE1FQeIgyciZKJyIsNtO1lhSKt/v1iSkWGWeIB6bPuP2Gp7IQ0yvnDgrSj+hrcRoF5KHISvVa3B1UQhPV2Y8fY9T9m1axJjL2jP1JwlLcrnIUk3iSgW40EHSD9GFfQV0gouljBVbOvCqE/37OZjIWM1IbU0y7hyUJ16YtOHBI4Sl2DP89sNuI/QL284hoIPIbgI22E4xERjAsFOV4+A4del/itCiU7kRQjmNIyv4e7F5p/6hKH0ZZHV+KzNgXqfuXjwE8ieq9kjm61NwICgBujFODe1Jy1rlOiA93RnVoPMl9l2k+uQDarxvh8uEp8xxoztWgH34tfhyFVAHKL6bOFRC7qv3TmyCfnPrLnoL/53WJM6Mnktw7JTodQRkPAFMYkj0SjPszB2lsiVd79PckZ5v++kf84tEBgvcgk1oj0se7Q690gHFGbnwr6fQdWaSkiERxdpzHEAgo7v6CW0f5G/irq82wfKfJ1tP3POzEeZdQc0ptkemS5uOr18hNh7ccBlIc6cyHMNlmc0F9s8YizPoDNpyYYEtuhx/RLQHzmw4sDeFv0V2qKsGRbjOYXLAN6WI9ZEFWvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8724.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(4326008)(8676002)(44832011)(31686004)(31696002)(86362001)(83380400001)(5660300002)(2906002)(4744005)(7416002)(82960400001)(6512007)(2616005)(41300700001)(478600001)(26005)(6486002)(53546011)(6666004)(6506007)(66946007)(316002)(36756003)(38100700002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUYza0VrbHVwZUUxbDVGUFIvR2J6MUphSm1yaHB1bnRpYnM1ZFYrYUNNc2Zs?=
 =?utf-8?B?a1plVEhGM3R0b3ZIZlFTSENFc0pKekhldDhKYTZwckI1L2ptaWhEMUdMbDFB?=
 =?utf-8?B?bjk4bGwrSFVUVGxtTUdSLzJML1FvbktXbS8vSXUzeDZoZUJkanNzSGlUTDZs?=
 =?utf-8?B?R0JDVUpleEVmTWtVRldqTmlZV0JOZmNxV3EyVDVVNkRaS3dmcnp3SUFxNkx5?=
 =?utf-8?B?dUowQ29hUTMwSGh1Vmd1ME0rNks4UEhjcklFVUQya0FzMXZjT3dRYUI1Q2s3?=
 =?utf-8?B?TXJIbmI1bVNqWFowR1BJeldHN2N1MnZnMkthQU9vd2ZHQlRIR2JsSXp6RXBr?=
 =?utf-8?B?bUtIQnlBK3ROWkxZN1NkK0J3UnVUQzZmS3BRcDBIbVNlcDdUVktNM3RESGRI?=
 =?utf-8?B?T0VDYjFETFBvOENQWjBydUpOalI0L3pMdE5EOWZLc3lTc05iaXVFdFlHeWFt?=
 =?utf-8?B?d0tISWs4M2tyQTJxcFkva2x6OEtxaHNZYW5GbUZBa0Ric2pGSmdKWFJqUnRV?=
 =?utf-8?B?ZEwvU2lCVzJXUzhDL01ISXdDeGM1YXVUanNKNU5YUTZmTmErWDlSKzg4UUVL?=
 =?utf-8?B?aUEvdENCS2J3YlZCdWlrRVkwWExTWm5FSGJBNVNkb3dLS3N6ZzVjcEJCV1dX?=
 =?utf-8?B?UXY4WFBCTm1iSGQwZVdBbVJ3QmNZM1JWbXM0NE9KMU9YOGtJbTI2RXh5bEM5?=
 =?utf-8?B?QllaNXQvaXhmeGRoU3BOc21DQ1ZjdEU1SnZaVzVlcDJ4TDlSVzdRVHhJRGl0?=
 =?utf-8?B?aitmcFFJaXZrRVlqakFwaHpSWGpNWG1zcWNrNG5NbUhyZ2R3SVNkODBmRTcy?=
 =?utf-8?B?Rm9kQkJQZGtWZDl6SFhhYzdRRkVKWnpKb2EySUtwbzJSaDdBSUt3bWpLMTg0?=
 =?utf-8?B?MG1QTjBRdnRMY0FwUWlLd3FNTmJNaUFHZ3MrY2pDbTRwUHE1TThmMzdYUXJJ?=
 =?utf-8?B?SS9mUFl1bUVndjVic0JSRUcvQzRINXpEa3UvaDZzNllqNkZPeFFLNEFwRzNX?=
 =?utf-8?B?MkxBRFlMblJ6VGNKbHVJWlVTWVk4d1pObi9hamEyZWxYTFNDOHFpWFFEbE5a?=
 =?utf-8?B?aUt5cWlBeU5qQ0FwNkh3blZjU1g3Zlp0eHFZUDFLaG9NaGlhZlliWFJHUmk1?=
 =?utf-8?B?NC9odHlMYWxBK2tQN1hveVdBS0lDRldqSy9aNGt6dzFWS2Uxc1NMNitXcHls?=
 =?utf-8?B?OUcvZGFtd2t5L1FadkpuU2owUmhsbC9BTVB0cVg2TEpkR1g5a3ZFYzVsMG1G?=
 =?utf-8?B?QWlKcFVSY3dOVWx6MFdLNWgzeTBQL0NWYlkzYmV6bHNwdUV6SnZ5VkJ1amVm?=
 =?utf-8?B?VEhSMTI3UzJLcVZ2RFk1anlxbUdGNk52ekRuN0YzY3Q4RG5oTHlPeGkvb0cw?=
 =?utf-8?B?aEVqNXd4OEtCQ04rY3ZDbmJyZmdBZ2xGUitTRkp1YzFRRXRNRkpBVDNMd0RD?=
 =?utf-8?B?UkFlQ3pBbTZlRWZZYS92UFJ6UHFxNnF0TlRESExzWWhYalhXL1NIZEhlOFNi?=
 =?utf-8?B?NEU2N0VPMEdId1ZqTjZrbHpsYStKSkE5Y0JKY1FFRmFKU3lyODBGeEVkNTYr?=
 =?utf-8?B?bDZSdjEvQkRwZTNKaEpmb1RrdUkyYXNsOXlyYTVUb2l4VytPK2M5MDFwWFNK?=
 =?utf-8?B?WnorTnBNM2Niekp6ZVMrMWt5dW1Sa1BXZE1vQVZRVTFRU01WMUZPdVlHTVM1?=
 =?utf-8?B?Rm9LaS9uYlNQZlRNSkJ5N09sL3BrN2pTbEFCbFk1UVN6VnAxTVRSV0NtS3JF?=
 =?utf-8?B?alp2cjNYdVd2RENrekprVzY1M2dGRG90R2c4a3Z0cDJRQmpLQTlLN2hFOUZv?=
 =?utf-8?B?VU5tRlBjb1RWWnVWUG5hVUp0Y1cwbXh5VTFRMlhwa0VFT0YreVFGZWc5NGc5?=
 =?utf-8?B?ZS82eTVsVUltN256Tk55SjVIbnUrY3RGSiswZHlCQnpLYU0yQ3ptYTRuWVhF?=
 =?utf-8?B?NUxab2VMMElNUzVuNFpGQlN3Vy9oT1hSc1BabDBRVDhqOHJScTd4bnVmLzgr?=
 =?utf-8?B?cXFYNWQzUWptNnVIVkNUUzhWWi96NVlHUWtWeWRxMHFjSVpEemgzRU9ZaUFH?=
 =?utf-8?B?VlFiWGtLQ2NsSjRQTG9iamtUaDFsaTgvLzJLUXFKT1BLOG9DeUZtWDd6OGZh?=
 =?utf-8?B?R3Qzd2NsOXNxQkFYQnphZS9rKzIrWjhQc2k1c3RWVWdJSEJRWUhCbEdrNXY1?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a638728-2408-40dd-3199-08dc15a661ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8724.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:45:52.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yXHXQK+crS4bXF7xiZBvnjBQOVSpgprdT9NxbNFhGjnunt+L1/JdlsyRNbHKJANGWeffLjivtPNKFbHU2jJpUg9A8RWQ60waUsNq8gQVzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-OriginatorOrg: intel.com

On 1/12/24 05:19, Su Hui wrote:
> Clang static complains that Value stored to 'status' is never read.
> Return 'status' rather than 'SCI_SUCCESS'.
> 
> Fixes: f1f52e75939b ("isci: uplevel request infrastructure")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>


