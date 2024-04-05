Return-Path: <linux-kernel+bounces-132808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD60899A81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726A4284A21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13028161928;
	Fri,  5 Apr 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6zxLZfH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D254161910;
	Fri,  5 Apr 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312165; cv=fail; b=TmvUnzk6qLmfrzcwpomo4lfZCzpEw5kKsRBSeCyIFZpOUGFcrBN+k2JO/od7pJ1e1fgNqxywdo5J3wCBbREbEJEOetsigJT6gsObLwHBirZ65jWOtRbpPB8EUvzYoAdn1hwdvlOHYhnWzUWV8EYR1/df6HgNomg/ZonjEK0eY+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312165; c=relaxed/simple;
	bh=UKjOZki7aIOQHNdfoMy7CiO0iZvypO0Vgu1GOokYTfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFNkt6P4Z9YaISPWE8VRH5ozVD+spcf6L+jq91AhcRFQrgze9IXqT/KqF70Csc+2o0YAtGT6xv19TcJc/VyKlPuNHS/ADMKWUebZuuCZr8B4X4GtMQTtkFxLsGsvfuUFoxkhnp42dcbL1ZQZatqGlPGfVHJDZzB0f3mYucA88Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6zxLZfH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712312163; x=1743848163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UKjOZki7aIOQHNdfoMy7CiO0iZvypO0Vgu1GOokYTfE=;
  b=H6zxLZfH3xailf++zwDBdsWqM2fw/+9bDlX/3tu9hcM2Cp3HUx6i8GO0
   RjshjxRP/AL5KJLPDT+vVF0kGPSETz7v5narEKV7Oku2jspRFja3mLX52
   sA7OVY93m+hDsznPbivy2auAbXc66vVH4F5DvT5uofyjQ8Zle+nwj/ODV
   7WP96VfdX1d2EywFFK2FX2o2mxfovuJ8Db/68w0ujLAhmci5V+I/UuIbr
   h4BKo3oa8kz5zMKSnkEscBwlLDa+LOvJFg1f3yLxIJVtpbMywBFDkKtq/
   Oj86ppuFzAgyDmN8BvC/vxU9OTHa3mxeWME5Drg6DR9a53Ct/I3/CUzN6
   Q==;
X-CSE-ConnectionGUID: dMHwHJvnRe6iD7jJZ9yxxg==
X-CSE-MsgGUID: f4+/o6F+RXuEKU/OnSt+lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11450570"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11450570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 03:16:01 -0700
X-CSE-ConnectionGUID: CqRxQdHmTqGfp2IaHWUVBQ==
X-CSE-MsgGUID: 05RtKhQ5RjuePTXqgqSqiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23589439"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 03:16:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 03:16:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 03:16:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 03:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqa/WADlLIVTbVTDle0m9Ol75mRmQSynh3fumyoYvfZ+4CdQ2ZWNeB4N0Jj/hBx97d2mpXxHnGzJogmkQccjx0HyzWxp0Uce72ZNHOEWVJ0/HBJt7RNsKlYqmbongzSmw9rKsNjp2WrjvHpcEPnuXBzRxyIOXWOT81oHJcYFqI7D2tugadZDqFv2NBxw+0PqSqcw6PSFiHhCECMlpWQfHWTGwzc2HN2JQTZeieG1VyBpesgh5FQUDQwqVy/wdJdjtysZy2DJkcuiqAKXTWxJbJPtbT16L8CmqimqCLr0qUdC6LA1QAqaIhoMFugKfkBktX1IuwyxCEbGpVbZdDF82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPN/R5NUVH3CcgCuDxd7xsRAzZt+ZTSIhYzyNP2RkwY=;
 b=cvLTDMSBEsixPONn2IyLBiawaAOGSYgv2f3pSaogANX+jzgQ+/jMDqllaZZCDIrgtfQoS9g2m5B5JcykmsQvSkval+hN+1prd/9nb+6U9xX8MHQPxhKF/ezQALl8VEBgHRGOmZSe02fL32/KF6eUuV0U+Yoj2KfHyIo6KtfQk3YebWf0+1apg5mWO+BIv6y4WGL3n9poPk+Y6nmSmTJB6qyI1glW3uTO3Gz6VXI+Hq1xuJ0DpIjlJX2pT1bEku+Mz7jKv59SGD4bqokxPgEg6D/WepYh0bd1sTq6T25tBIzcU4vY6hI7HEr90WKj4Im0t4szsfG1xqVHU/4HFfZTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Fri, 5 Apr
 2024 10:15:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 10:15:58 +0000
Message-ID: <21be2825-167f-4357-8f6c-02fe065d7490@intel.com>
Date: Fri, 5 Apr 2024 12:15:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/9] iavf: kill "legacy-rx" for good
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
 <20240404154402.3581254-3-aleksander.lobakin@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240404154402.3581254-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYYHYR2jlrw+LtXL8hNgm0eFfi1FjDRh9iklFbv+qXqzzxxEk+EbuSjZrMveAOPVC1sMmwnXVaA2SIb59FufqnIyWK1+MGus8z3ybi5tJ+BqQn63gIbPHAVUr7fxf0WFXfsUAYtKbfF/Nd2SYaFj62egK/6pIoxu6uEDFXA6ulLdHlnKMfuQBOqlkCzV3V5mjvN/9kL7PhNGIJgDqnDCs04fvNjK4T9Khf000Itrtcf+EtH3WQJ+uKpjZSWQbhBD4+JrWdNB2XrMqdw1hIlQl1WFYC/DtKP9pND+5T8Zn/Qsyne79dcHiFEJy1KgssthjkZXGj1utdP+KKSz7CypQAao4SKOI/heAkFq05ZHtWJ8Aoe8Ji8PddYYNka8Ix+432HPIvktfVeXHtzjXgANfazC0gjkuPVB0OR6VvPylTQvSRrPOZtdizJXp+LQnPbpeKl1/A5r7t9rFMGMDUhCxuNZT71DoS3nZIgu7isYbQjjY+hf1JRwR+SHkvvPJAbabdYcZxf2+l7YjAo5ozxBl7AqDOCuAo9/zrD3wwchzkWvKXo1B+Li2pKmq7GTpkCBaby21N1pKhiMqHVYi620RgfVdMO1U2j+i1IT9e9ar01KCWxLL9qTP7PiPhAr8lQWLEu8hftOUAWZ0JtuC0zvIHrVUSwgFhXeYpew8bd07XY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxyMG1jQkNEbFhiK3JDanBEQlVYUTdVSHVrUHVnMTVpOWJOcG5tTHp2WXBY?=
 =?utf-8?B?L3FvWWdKVy82QUR5cHloMDZVK29jVjdHNEVDM3IyUHhCUXdOeWNaMVRwK2tw?=
 =?utf-8?B?VFREQTlhUHAxVm1zS1ArbnAvN0lkelhRRkJIdWJKSmsvUGRUWmlwZjNQVXY1?=
 =?utf-8?B?K2EybWhVM2tIcSsvcTN6U2NOZThDRFJvaVNicEx3YVhFUGF6bWJjNHI1L1do?=
 =?utf-8?B?Q3FEN1FObC9tckpoTENxTUpCenNTamxEeXRtWWI1L1NXTEhDU293WE1UcnRw?=
 =?utf-8?B?cDdhcEgzSkVtandnTXBQbDNYU2NGelNIb2Rwd0xCdmttTi81NHpEd0VwMnpN?=
 =?utf-8?B?MzMxbmVPY1ViK1V5QUhPMVdSREdRZWV6aHFja1hRRE42bGZ5SHJETjVITDFu?=
 =?utf-8?B?bVNOSjVlTnhBVmdhNTRsUm43Lzg0OElvN2o0elc3M2tBaVZQSGJkNEZWcmRG?=
 =?utf-8?B?SlpUS1F3MzlzQ3NPMjVSRytHOEZ5dnlCd05TYStzL3dCMFpDc1FvMVhKeHBB?=
 =?utf-8?B?SEJDQ3FkTExqV0Y2eVVpNVdVeUx2U3hLajYzd01wbTZhM05ZOVBpOHozNlpE?=
 =?utf-8?B?VlpWZlRjYVp3Yi9lYU5nUGtSeVl1dnloQVVaQ2p6QlZoeGJMSVk4NkFWdXV1?=
 =?utf-8?B?TCt1WGRQN1hFbEZNS1QwanlvREFWZXp0aXZ3aHlFQ05MV3M4SEhoQnpmOEd3?=
 =?utf-8?B?bm16cmJHeGFHYjZaS2dzcGVWd1FZaU9LWjV0TjkzYU1OSUtkU3Q2OVFGVUlp?=
 =?utf-8?B?T0pIL01VTEdINm52UHphdHdkUkFhQjJIdXh2UUxvbmE3dms2bXk3dURCQjV3?=
 =?utf-8?B?K3N5VENOMW9jM3JmN0JHclRkSGxmSjZ0bndsWnROVERMN0ZiZ0pYS1J2bHRC?=
 =?utf-8?B?S283Z2xaVDBrcTJLMjV4ZmFTTkt3cnhlQ2ZDM2ppRllVVzhuYUpURFovbWFp?=
 =?utf-8?B?WFVlUk9ZV2M5RE5oblVEVWtxZXVORXNrZDZoNDd6NUFQSDVjSmdIVkhDL3N0?=
 =?utf-8?B?R3k5SzFMSzdPaHlJeklxYVdOVzB1bU5weERQVVZOQTNHang5N29ubHhub1Ew?=
 =?utf-8?B?VGJQQ0oyLy9oN1I2TktCVGNFTDVmWEIrTVhYaWhpOTlUVmhPanZzOW9hQ21X?=
 =?utf-8?B?VUlPc0NETGlFeU9uaG5NTm0zVGdKNmJ1dGZsM1BSWVpNS1V3eTIyNFlSS0lw?=
 =?utf-8?B?OHJDWWZ3d21kTEh3RnBCbncycmg5VnJwdHZneVE1VmUxN3F1UndDdWRtTmpI?=
 =?utf-8?B?Sk0ySWI2alBjOUUwWFFZNnZORVFZSlJ6Z3pNb2Z0aUM5S1BVMm0vdTdGcnpI?=
 =?utf-8?B?OWpBL3dPYTlvVkQ1bVZ0NHFzNlErZE5qM3R4SXRDczY0Rmw0Q1pkamMyMWtB?=
 =?utf-8?B?Mkk1dDhtVXZlVStOMDNvZUhJTDBMaXVLNEFkR0ZVMkNTd1g2eDVFM1RQaDlm?=
 =?utf-8?B?dzZYdSthSzg0Q1RxQkhucTBEc21PNU56b0RSTkg5d05OQ2k3bHV2b29jbWxL?=
 =?utf-8?B?NXloVVRQM1R2RGdTK1pWTHhza1FJYW1WYnU2emlXcnkwM1hSRktDVUdGM2s1?=
 =?utf-8?B?a1pKN2c5NHE2WjFIdkhpSmplSGFWc05ML244TUF5dU5yTGwvUmw1NUpaYXpE?=
 =?utf-8?B?RHpYZjVYQktsVFhZRHJnYys0anh1YUJaM013NnB5UmsxVE12TTZNcGtTYS9K?=
 =?utf-8?B?NGZZVlVoaEJvSjlua3BTRE1Ebk5ZcjZzdXNudHNjZFgvZUlEN2tvZERrZnVR?=
 =?utf-8?B?bW1ERjQySmlRUEF6NUwxQWJ0bXZ1cnJRT2xub1UrWW1KaGw2MG9pd0NjWmJ3?=
 =?utf-8?B?bzVRTEZzNHhvSENjUXRDbWs2d2VEcDU2UE1pUUkydG16bTBsQWZxdEphT0wz?=
 =?utf-8?B?Q2cxQVNUOElqWWV1UFpkM21JS0YrMkNBanM3dG9Fd3hnaGxZcWNzQklvbUhp?=
 =?utf-8?B?SDF2RXRUWXJRYzZOUlRSeUoweHhIbU5nbko2dzllSlhadnJkZTFXeUs1cWdS?=
 =?utf-8?B?ZFpwQXc5ODVkT3hSV0E2eEJuM2NxaVVxbmwwbEtRZVZ2OWMxV3I5WFRWTnRY?=
 =?utf-8?B?Ty9IVzlHclhWN2plV3gvbHhCd0ZKUkVXdTBnYTJYb2Nyc2tPUGRLRXBxLzF3?=
 =?utf-8?B?M3ZCOVZKV3lZWnU3czg0UWlKa2dGRDNQMFpKb1U0alNzdlBqbmhhSkhzUlVG?=
 =?utf-8?Q?THh8EjWnfYM8WKLG8ovXWyY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d7ffc-344b-48e8-0aea-08dc55596333
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 10:15:58.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvEUFzDm1s/lkgxQyV1AKsXa7VMKPQl7Ltsx8uG8ld7o5SCxgfAiR5EEHEmEOxaNxN8qpPLAH/J+VjxgPw6YeXjqQryo74GWLlPuB6BU6Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

On 4/4/24 17:43, Alexander Lobakin wrote:
> Ever since build_skb() became stable, the old way with allocating an skb
> for storing the headers separately, which will be then copied manually,
> was slower, less flexible, and thus obsolete.
> 
> * It had higher pressure on MM since it actually allocates new pages,
>    which then get split and refcount-biased (NAPI page cache);
> * It implies memcpy() of packet headers (40+ bytes per each frame);
> * the actual header length was calculated via eth_get_headlen(), which
>    invokes Flow Dissector and thus wastes a bunch of CPU cycles;
> * XDP makes it even more weird since it requires headroom for long and
>    also tailroom for some time (since mbuf landed). Take a look at the
>    ice driver, which is built around work-arounds to make XDP work with
>    it.
> 
> Even on some quite low-end hardware (not a common case for 100G NICs) it
> was performing worse.
> The only advantage "legacy-rx" had is that it didn't require any
> reserved headroom and tailroom. But iavf didn't use this, as it always
> splits pages into two halves of 2k, while that save would only be useful
> when striding. And again, XDP effectively removes that sole pro.
> 
> There's a train of features to land in IAVF soon: Page Pool, XDP, XSk,
> multi-buffer etc. Each new would require adding more and more Danse
> Macabre for absolutely no reason, besides making hotpath less and less
> effective.
> Remove the "feature" with all the related code. This includes at least
> one very hot branch (typically hit on each new frame), which was either
> always-true or always-false at least for a complete NAPI bulk of 64
> frames, the whole private flags cruft, and so on. Some stats:
> 
> Function: add/remove: 0/4 grow/shrink: 0/7 up/down: 0/-721 (-721)
> RO Data: add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-40 (-40)
> 
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  27 +---
>   .../net/ethernet/intel/iavf/iavf_ethtool.c    | 140 ------------------
>   drivers/net/ethernet/intel/iavf/iavf_main.c   |  10 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  82 +---------
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   3 +-
>   6 files changed, 8 insertions(+), 256 deletions(-)
> 
Awesome!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

