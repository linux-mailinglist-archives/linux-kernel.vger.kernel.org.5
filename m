Return-Path: <linux-kernel+bounces-52090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C08493FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940F71F245C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28991C2DA;
	Mon,  5 Feb 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ogyv+ZYm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD4C133
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115770; cv=fail; b=q8dTqKIHQRUILW1pZxenHHtkm+SK0PWgx+wcx/lUSG3jwdBY6EaDfHIa7g219qP2pcKLnyEvIzj0UFjGJFSyDVDx4PNMQdvFd0wUirCBlJCkEfzW2CY9zyyjWSCDQIWnT3v3xjcSivC5IsVGnQBGbGNlg7dkRKH+rYtPsRc6JJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115770; c=relaxed/simple;
	bh=Mb+O8ysROAPrYQ0ychQ01XvvqYxCoYNZVgLfnykVXw4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nGCFfekD6FeXP4SWeDVjEaQ/tQBb8ck4WN0flBSVbfpUiXyIN1ZAFfkf+kRpV9MWjrRU77Du/UMCiUuBbwWcY6ww2igu9WmoYXNHKkyDA3pB4HztRvgn68OwgeaX+Hhu36jYPOfNKIvIyDbJ88ow6JU2mOoWFGoCfA03wxtFwW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ogyv+ZYm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707115767; x=1738651767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mb+O8ysROAPrYQ0ychQ01XvvqYxCoYNZVgLfnykVXw4=;
  b=Ogyv+ZYms3BDnAI0y9HzHwV4d9rghR7TnBhXo1Sb5EJ94cqclDvdRHaI
   1oZZFlhdJFf6oxQHGlL2ISshvgIimAvPF6gI5CoTkIkRY5TWlR+IfREyA
   di0yHM8OXvC482uaGluneyHG4jdNLDg2Qi4wCipF0d79xUK7INlQHnUz2
   1SfOmjQg1TibZV3vxWX2A5F++fe8BrXTVE5U/dHziqDizZ7SYMzxN6tJO
   9qIyqTznEOabAOmrTczfdDoizPHsXpVubOD7NG/jg4f/5qXgyJDx6L6Bw
   jZP12QMmLuP32/JczLFsskEXFprIzS+GhJT1PSG7IQE2TuaKVEVernqlz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="612206"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="612206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="635509"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2024 22:49:27 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 22:49:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 22:49:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 4 Feb 2024 22:49:26 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 22:49:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO+sV9vUgzCbKeE7da0Nv9QvOch8JNpMM+zCEmJINoL0ej+vgNAG1tKekiaQ+o2DS9BHEe2ckZx9P3mou2a4DhXM94CgrucTOTPupO4cuL7lB5LPaokaXauLzbI6AI/+6N0tDbFib5gbuy0K8BeayYwKCFUp4FlPfsPrh/0uadgmKexoVn1ezohR7y9N1eWwPd2c5vHLbSvgRUVob0Py+mazZpMuqu0A+SlXK/dYFonZCTBccFxqHPn5HYTNqmwG1SbUZtjawFKbV/G8R4IEenYUw+d4z0TKgcWsSJSzeycWAfCkeZDBWXjONpiMmDSaGqE4+sjJUmhesr/IfmqW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMX1rDgtNE+Po8Cre21xfLhcJGA3CLH5u/O/UsqzqHc=;
 b=Rr+OcORVODmTeCBwGb3Qa1YnNh3OoJZDMeVwo27mNY4dB12zNB+Up7OwFzMcpv87hSVpDih+8+RGvIuNKYgrg+CW/jx9Imvy4819seR0kErwZzOrHW/xyOUFPhgREtweCUsKDgFVGLWwbgy5SxY4EgCLdqkvletBebeioQlil1AIXUcPpY38V6nOgFtBQTwIxm9IY7faLGu4NmcNJ9Co9vbPtINvxwd5VKW8XB981ERzboMFuDraO2LQnCC/qlfUTVKDeAW0/kQGuBLkGSf0B85A+J2OVAnOQxjCjGUIRGn7fFIniWEwV450z9snM+ed/DTHJ0aXtL21wazDTDpFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 06:49:24 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 06:49:24 +0000
Message-ID: <a7457e6f-58b7-417c-8a91-c1cfc0d36437@intel.com>
Date: Mon, 5 Feb 2024 14:49:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <thomas.lendacky@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
 <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
 <0c990c7d-4df9-45c1-8c03-980d9842b963@intel.com>
 <ixp6wj4763kc5vgpmipyrijddwnxblhdn2v7hio7ze756w5f2x@6uyc7hwtrbbn>
 <b2d1e806-5bb0-44f9-a1be-498ddadd37a3@intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <b2d1e806-5bb0-44f9-a1be-498ddadd37a3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d083d41-c13a-4d86-1575-08dc2616968d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X27fgxiKCQAF1emqYq05JHhJRLH6hC8Xmz+KLrX2ZSCWfiCBPBvyMqToJXS5svwbmLUlWnL3S8cM1C0wC801Ud2Q1DUCYfbGNCw/hS0FoSI5zt5UT1/tPaehkwuLJAqOS8vVCrLSzffxLekE9i3Jjz5L1Dlu2v55111mUwtk26RWTtrXkA/5T0w3vdpRcIKtDt5xNsPMeb605YmvQ/3MZbI8n37DB2JYLphWUs7j6olIpdZf3iE8ltzpXpYNiPqRR6AAUvl0hDRJmUoORtoPABgzPm7SJtLMMl2XPWCfDorqkzOE24lhpEOFk9uoDOKGAT+5Pe+ezbFNJbq4lK/jNPggDP+nY1t9c4rhFn1z5mS9bEUh7gvL7VVIUJVsOsuRVFPWTWZq3l7ifGJ3CSmkZ2ee8/Iv0uS5CJ/gYTF5XCKEYyU2E1GjIlVbOncc0xyIQFGsMOiKHbcJO9d17vVsTtd1tsNOq/tEuWnzFDsHKXx2FTnza32yLNnfoJof/HozBpGJ9VaEgkPdAx06WYZKA++67Z1w7z8BilmBh9Hg2/NXiDdvP35qDPJlagVJ7nnIaw8E+QUZiR1MRrB0fSxR+l+l4P+vJZNchQspgpyBnRvDpEpreEAzjUOtWXvW0mZ+Bxrwm0zkuHLtj4jK0k9MXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(6512007)(6486002)(31696002)(53546011)(86362001)(36756003)(2616005)(7416002)(82960400001)(83380400001)(26005)(6506007)(478600001)(316002)(66476007)(38100700002)(8936002)(66556008)(66946007)(6666004)(5660300002)(2906002)(4326008)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU83czNTWU43OGdKYnVDY1VrTHV1SXZ0SzRRZnhlbUloams1STBvaHJGenNm?=
 =?utf-8?B?WWwyZDR3VFRMWk5Xa2VVRVdwcVp0YzIvTVJuQUlhL0RiQUZmSTFYYUl5TFV6?=
 =?utf-8?B?UHlBQzRhaG1ZNjBjM3gwRHZneUVVNm9yL3poQzFUbDVPb3JZdlROOUtjdmRo?=
 =?utf-8?B?ZitKM1UydUJBRzYwbzdRR0c4MWp1a3VkWGVXREt5ZEw0blRvSTg3YVBtZUxU?=
 =?utf-8?B?czRWVU45SGlwWUgyWnFoeGFWdTdGS25OUkRSY0w0OFYyb09CcFZHOGdwbVB0?=
 =?utf-8?B?WkVJak45TUNhQTBjZzVOM25jc3dCYVR3Q3Fia251cXJvYlFIY1BidjB1T1ZM?=
 =?utf-8?B?cjRFM0tRWXBTSVdpL25iazdhaHRJMjFVdUFDQktWMUNNK1JpVVdwNkNVUmhi?=
 =?utf-8?B?d3BCa2l6SVBpbE81Z1ZFSk9uWWxucUg2WXdaUFF6SWY1eUEyZTVaK2E5YWxH?=
 =?utf-8?B?cDZESVlPYkN0TW5LNkF4TExmR2gxQTJiSm1UVEU4MkhCR3BYd2dsVGYyRDVi?=
 =?utf-8?B?WjRmTGUwanJ3MzluUnE4TUxhVnhLR01SZEFydFQvcG1ZdkhRNnBrbE5DWStj?=
 =?utf-8?B?bE1ZSFllLzNwbmk5Y3B4dDB0aVJjdWZFNlVINXdmN3NOd0NXd1QzRE5oS00w?=
 =?utf-8?B?UXFQSFlIK25ka2dLWWd0emJ3UXZvNlRvazZKSlJVUTFGeURHRzRBTk5pMWlT?=
 =?utf-8?B?YWJZQysrcUhXVkN3bStGcHdjWU5Pdk1kYmZFRlp1Tm5aYXZuRGhrWmdXQTg3?=
 =?utf-8?B?cVBKOWRHQldUY0JpUW5IWUdodkJIWFlNZ3hIMXlxZFlxa3VhdlMzdEN0dFpm?=
 =?utf-8?B?NVQwc0NQRTJXRzlhUFBVN2p0SEltN0hJbzJBWGtBem15c29tb1gvODlMdEk2?=
 =?utf-8?B?Sjk0Uncyd0M4MTJCMmJOdm91SERZWmpoRE0xVzVXNWFhKzU5SXVEQVp2RXpo?=
 =?utf-8?B?aTl5ZFFVVEdqbnJ5aURxaDc5bEx3dS9taGVOcjdLMlFNWTRUbGtjWnJkeEs1?=
 =?utf-8?B?SHRJazQ2Z2dnN1FQd1YrVVpnQjdvZ3NVWDRqTlpmMVZRTjBhZEpyL2tkaVdU?=
 =?utf-8?B?QWxYdURZb0ZYOHRqa0NWcHlWRUQxbjNCSHNDZ1NrbVdZUEk4RnhJbmFxcjhW?=
 =?utf-8?B?N0R2bWlUcEpzR2h2UHFZS0czN1ZwdVJQTG1PQm5xRmcybWJxV0FJblRITjgx?=
 =?utf-8?B?a0c0SzlBR1V6SkJxZUwweVJ5a055QWpsN0RoZFFkZ3dHYnBOaDVRNG10UzBS?=
 =?utf-8?B?S3ZCVnBCdnl5dCtVUHN4alJZdXUzVnRKSkk4eUU4Z0F5cGUvMjh1bWkrSEdm?=
 =?utf-8?B?S1Zra2hQdE9IemhPOUpNeEErSlVkSHF3VkF4bzJhOElZR3JnM3ZQOFZNZFB1?=
 =?utf-8?B?clNvcU5sVm12SnNwNHd6RGxqaXVsUkNDejZOZHZLTTgyak5pZWw5ZVVjM2U0?=
 =?utf-8?B?S0hweU9KMWJDS2VjZ0pJOGNYNEZwaDZVYUhuR1VmdWdIRThDNmIyR1M4NUM0?=
 =?utf-8?B?OUtpbEczVFowaThweW14R3Z3NzJwZ1RzbkNOK200RXhqbHE1a0dtbDVrTUxB?=
 =?utf-8?B?MGhYa0RpdVJZOXQ5YWZJaGt3ZGYvT3lmSWdGdWltc3F2amIvK2o1TCtEc0RU?=
 =?utf-8?B?QzFkdmtpNmR0Uk9tcGJhWStlT3NvRGc0ankxekZSTWJwRlVydXFDd3kxajBC?=
 =?utf-8?B?RHZXVDVudWtFTzNXK3hSdk44cXZQZDE2eGpxQXQ1RTZmd0hFL1ZOeis2RmRM?=
 =?utf-8?B?YTNjaGttTU1vRmoxOEVabCtDVXhoU0RWTkhybjZCZS9iYXJXajZsTGRqWDUx?=
 =?utf-8?B?am5GVDdHVWpHdDBUT214NHM5WFFQanp3ZU1tVVd2THdVbTlQbURnbG52ckVp?=
 =?utf-8?B?Tmtjbkx3SGIrOHBkUnMrVFNCbmFrdWRzZkpUaFQ5bHUxbStHeFVmWlZQS0RU?=
 =?utf-8?B?c3Y5RXd2REtsRVNaVHlDVERsZ08rejNhR1U3alNyMSthZWhzY0xZUUFMUWtl?=
 =?utf-8?B?SDlEck4xYUhjNGdveTlpR1dISTl4VFRXaGFXYk9peFBOcmZCTXQycDJUc2dC?=
 =?utf-8?B?SGxwNVRQNkNyRTNvd1NGVlFXVXZ3MkhYUk5FcFhSMHgyRkJjN3h1eE1RR0RW?=
 =?utf-8?Q?gwY/JeDfKFVS10ohwlTL7v/YM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d083d41-c13a-4d86-1575-08dc2616968d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 06:49:24.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKXopTeyohZZNS6i9gb95Tk35zvbCTd4tMD9+IKEZL3Q0EDHqbP9NeygmhrNVfaqKYixYqTggw3QcTljLQh+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com



On 2/02/2024 12:57 am, Dave Hansen wrote:
> On 2/1/24 06:39, Kirill A. Shutemov wrote:
>>> On 1/02/2024 6:03 am, Kirill A. Shutemov wrote:
>>>> On Wed, Jan 31, 2024 at 01:21:39PM -0800, Dave Hansen wrote:
>>>>>>    #ifdef CONFIG_KEXEC_JUMP
>>>>>>    	if (image->preserve_context)
>>>>>>    		save_processor_state();
>>>>>> +	else
>>>>>> +		tdx_reset_memory();
>>>>>> +#else
>>>>>> +	tdx_reset_memory();
>>>>>>    #endif
> ...
>> +void save_processor_state(void);
>> +void restore_processor_state(void);
>> +
>>   #ifdef CONFIG_SUSPEND
>>   extern suspend_state_t pm_suspend_target_state;
>>   extern suspend_state_t mem_sleep_current;
>> @@ -491,8 +494,6 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>>   extern struct mutex system_transition_mutex;
>>   
>>   #ifdef CONFIG_PM_SLEEP
>> -void save_processor_state(void);
>> -void restore_processor_state(void);
> 
> It's a little funky that we've got a #ifdef CONFIG_KEXEC_JUMP in the .c
> file and then we're dodging around an #ifdef CONFIG_PM_SLEEP in the
> header.  This is one of the reasons we shouldn't be putting #ifdefs in
> .c files in the first place.  But I digress...
> 
> Either way, if you focus on getting the dang #ifdef out of the main code
> flow, the rest will fall in place easily.  Heck, if you even do this in
> the x86 kexec code:
> 
> static void kexec_save_processor_start(image)
> {
> #ifdef CONFIG_KEXEC_JUMP
> 	if (image->preserve_context)
> 		save_processor_state();
> #endif
> }
> 
> it'll leave you with:
> 
> 	kexec_save_processor_start(image);
> 
> 	/* Give a good reason here */
> 	if (!image->preserve_context)
> 		tdx_reset_memory();
> 
> which is *FINE*.  No funky #ifdefs, indentation or else's dangling about.
> 
> 

Thanks for the insight and explanation!  I'll use this in the new version.

