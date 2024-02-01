Return-Path: <linux-kernel+bounces-47848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50568453A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894A728FA36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3515AAD5;
	Thu,  1 Feb 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7gDVbQc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A691586FB;
	Thu,  1 Feb 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779171; cv=fail; b=mgGC4JTbkgt0ChHtNZM7CBwmYNVIdcfRJtE7jt1sU+3Fv4ykTnCI1OOxtZ21vbWtmrdLKN1vE+to9cgttH5gvIpJLXJzRSVeoAbRBKiurwlF8ELmraq5HPFIbg1swJm+rw/nSkXrqQaDJI91VsKJeLVmQ7CJeIY2aUEVCnFdYEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779171; c=relaxed/simple;
	bh=zyKZPhTNKWuAR1Wa5IzF3z9g/yBZ2OQHm7JiL81rGT0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGTbR627fFkVCMNWNRcFn07anPyLPBf1d/hPhW7aB+6p0qgLguDKkHmNqYrbEVU2cz2lwOUmV+xC9Ewfn8pYIKa/gLMeFbCu7hmIz4Vw3eBB/n56i2p9NeLol4q+DKWWlwqbtRlRJClrdghFxvp91bASDJ9/z82G19m+hmqy8fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7gDVbQc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706779170; x=1738315170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zyKZPhTNKWuAR1Wa5IzF3z9g/yBZ2OQHm7JiL81rGT0=;
  b=G7gDVbQclPO24Nr518oJumFct6Vz6Llxf1242z650x+eZjMOKXkuUPK7
   Fvjxwxmxs7h7vq1vDhJZYdHOoZiOjrMLl5nY3qAQWzVQhHCjjMbXUCjqn
   v5qO/6jck1R/eJF0MdWAbGKftAxFSo2gAGxrslt226tyB9hH6LKamqmxN
   RdNrmyhiwXBiGDhXb4SiB+DfJy7tER2BhkMkffUxTr1AuajszwXGWXS0+
   T7c+HN0plaYsHgjWQTE0Nm1LTro13FFrFmWr188TDLN3zhfUnGMwhTC1b
   rKI+36veTZN4Phs6BJiIYVCfIlCxxS3INxv7VlSgvgozJxc0/Z+e+SAAZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10483782"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10483782"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:19:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="37251"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 01:19:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 01:19:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 01:19:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 01:19:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQNHz67nEQ+O4JI8tq19YW8+1sXbsxSHfDvaSx7cg+cCiaRsvDY+UZDTxcRfzX3GjB9h0LAerxjRUeYKFdUlHRH24+9QfYZInavu6yzlkRQgDm+O5N3UASeUnPmAVyjW30A/8uRx8MGSxYwc1HpMNTmzX0jIgKq2hbF/LhihcBOkWEpL28M8345KZ34zsxwDZDpQXD7AOTflikTilJoFeTp08kKviTqb54n6UBwd0Ps1vukPlxmdyrn8su/hGxSi8R89Fht67hrW+F1QNuatd/YLniIFRfqMajT8taoKfqbUoSayg9IR9VMFu0Cax5+vTeujPNxJYjaLFuXsIwtcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6AF4SIzsfr2sjQMbXD39oOGUuHstV8AAu8BQ95FoeI=;
 b=Z4MS5AC1rK/gmu/s8lLDtdFDcH43uRCGNCBZt0mlbhdvYD/L7YeLyAxSQD6CDteUQf24uUxAUAulmSQ7bCxyhYYNVRM+ninfFe7XdOrX9/H8XHrvjpgoGEXkbfzvUoi2g+5RqRZ1fpt8dhGLqCexCS8yufY4Cs8NZd5v94EoDWlD3y7gxcQ42NR3CShsM0Ftj8VQ2Zjv/lzgUBLbBVFdhy8AgYHXj9Z3Ry4+I5CnJ3SokpO0EKv1e/2AoWH59j1Dz5BvMhKwPtnVogiUda29vsy2+3yzp38p/Lhq9s3TTdb9tvZclYAhXGAvqDf+nhc/uVMirKOwY7lsYrzqGb7eaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 1 Feb
 2024 09:19:25 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 09:19:25 +0000
Message-ID: <ac88504b-1edc-46c5-ae61-7a634b156275@intel.com>
Date: Thu, 1 Feb 2024 10:19:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] overflow: Expand check_add_overflow() for pointer
 addition
To: Kees Cook <keescook@chromium.org>, Rasmus Villemoes
	<rasmus.villemoes@prevas.dk>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, <llvm@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240130220218.it.154-kees@kernel.org>
 <20240130220614.1154497-2-keescook@chromium.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240130220614.1154497-2-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f19db9c-8150-4fb6-90cd-08dc2306e205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKOi2b8DbQ4JRCM45Z4oi5zCJFj8t5B94TlZRMKsogKUYcHq9jWPRPhgZpBfLwrsqpKUEECRnf/hn7G+ik74r+TcpELjyodDLDEUfhhdUmH4TJzH+Cf8HX+BTLcU5Y7l5AncKWM6tI3vIw6hUahDz/axvdYl5zhrNcQGsehCiUmQvKRdcNKbf/BzttNgoG0zlFUtCGBD/h4pXY9lFGqZplScoct/M252b+AogS8gzNoVQxTN/DJk5pSJwZMHka2dZgrJk0GG4gyygdeLA7Pxw9wdYIEgd6O5V0f+Nqpdk2yox7bzuNP++AN0jzNmEESK/oPzSHTMrZai+YQxCRGnNMQDbceP4K+YrSsJSKQ3D7vmbKdiPu0LprKwJbOPgLgRzjiUkQH+lDbSRGzu4SqFd23qSuQiava8vK2goZfHHNxC8O23goBfY+AghmHrBQCzok/3YNjY3/Roz0fdekJ4c8iIp6lZ2YH0QGRgFQ4A1FzAXTdyIKjgLjJyHjeOcSCh01Wa6jU9OdF8S/jiTN0cs9DHCQV4FC3pPI4dG+bPF6mtT9b2zycoRg0J4fgYm9cFgEBpK52hBykRGAhtGmO1hc3+rwiuecHUUMQISOYiW8S8L/L/wi/eC9rZMyK176AT5DkC3YN/hlxldbtbCCWIUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66476007)(36756003)(8676002)(4326008)(8936002)(316002)(31696002)(7416002)(2906002)(30864003)(5660300002)(66946007)(6486002)(66556008)(86362001)(54906003)(82960400001)(110136005)(38100700002)(53546011)(478600001)(6506007)(6666004)(26005)(2616005)(6512007)(83380400001)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdmZTdzb0ZJSUtZMFJyUXU1Q3V3TmlpZi9uc21QTjBtZHViRCtna3hUVUhn?=
 =?utf-8?B?ZmNUWHJMRENsYnVPR2JqMFl4SzlNSVdydkZRalJVWkQrdVluZlFOUEo0aGh3?=
 =?utf-8?B?NS9xMk1ScjBnUUlrV21JMDl1bUtWQncvSklnQWd4ZC82RVpZVE5NU3FJeGlP?=
 =?utf-8?B?aG9FTHBjMG1ycVNpWWF5ZUYzaHVkaUxUR09JVklJWTJyUEJzU3VIemR3WEs2?=
 =?utf-8?B?THpOSkgra0RhanVIb0NDZVo0cXUrVGFkRWlwbVAxOElFa1NsckdRTElZdHph?=
 =?utf-8?B?QVFYcDVNZ1NiZEpOY0VQc21VRzRlenZRVHhMeUt0M2tneCtzT29BSVQrQTlZ?=
 =?utf-8?B?cG5vZ1RUU3Z4cjJOdmFLRi9NVThYVlFkamNlMkJ4TzNyL2wvbXVmbHJhOVlS?=
 =?utf-8?B?eHNaR01RRncxaHcxMXBXaUtNRTd1a3F5KzJIMUZZdEtDNzdUSGxJWUdnL0tV?=
 =?utf-8?B?bkg4SERxcnpjS2I0Q2JudzFLaWdPdDUyZWhITTVOY0FZUFhUQitRSGZaQjFo?=
 =?utf-8?B?Y0VJOE1EdHBXcTJUUm4zcWlreVpxc0RHdUUrOVpiS013ZFJQTEloYis1RCt5?=
 =?utf-8?B?QW5TVFZDbkoydGtybXdvaXNQTkJDOVFIOHBVaHNzUEdzQzlTZ2VzVUV3UmE4?=
 =?utf-8?B?TUFoNEd5eFV5UHJxdFpKM2RSaGFzUDFoZmYreFYwQklwMDNETmx6VTNZSmh2?=
 =?utf-8?B?cUhuU1hvN3B1NnhYaTcwWEcrY3hIc3FmNWZHWnB6QUE1RjRJUHcwRVBQQmtO?=
 =?utf-8?B?UDFWSEE3bi9IQnpDR1V0cHh1SDJ6QzZiWXBIbzBQckZ4R3BLYlBVdlRDRU9Q?=
 =?utf-8?B?dDVwblA0UU5VbFBpcG9oRjAwcGNTRTFwclk4MTg1V2NpNG9Tb3hWcDhoblpj?=
 =?utf-8?B?bEh5VUNSeWdOdzZvaVQwejhCSC9ZUm9DQzFaQzBRdzBqcWtyeFRXNXRneWpy?=
 =?utf-8?B?SklndFNjZE9iSCt1ZjdGUEJsMkRiM2dlaUNWdDN6OGZUSmVyMldUY2dyV0hh?=
 =?utf-8?B?UVY3dmRtT09lbTIvK3M1OHE2T1FqeGROTGRaK2pZVG51emN4WnVuZUZsT1ho?=
 =?utf-8?B?MGpadXl2dVg0bUZNS2VBRlhrOU5qTnY5SU4wWXl0Z2RZQWh6eGxDTy9tUXFV?=
 =?utf-8?B?RXZZellGRFJpNXBwcWIzUkI5TFpSV3ZqblVwSmtmU0NWdkFZL3RBL1gyL2VM?=
 =?utf-8?B?cnU2NXJOQi9qeHhRYjUxUnF5UC8zUmZvVFZhd2JKUUg1MjZnS2IwWk5sdk5i?=
 =?utf-8?B?ZTVydjZVWmQ2M3MzcTVNYzJKRWlzM1FvaEtwd2JEMllLcHNRbWtRc2krYnlH?=
 =?utf-8?B?aGdpUTFVeWNENFRZZ0ZNQkpyMlJ4SDhzSE5ERjdGTVNrcmV6Q2Z6OGgrdzFR?=
 =?utf-8?B?YXVHaC9YNkhoZ1hGY2d6S1F4TCtHcjlBci93aldyU3hFQjNHUWk2dmtXVEhi?=
 =?utf-8?B?Ym53Y0hNWFpscXVWR0YzcXM3aGNvNFZGRlJBQ3EyWVhMNkFvWjRVanc3ZUZj?=
 =?utf-8?B?ZVNpa3ltRG9URFU3dW9lVlhsSU9seEF6MTRnb3M4N3Q4L29jZ2xuamtZQ3pV?=
 =?utf-8?B?L2VlQjNPcVdvL2taLy92OFJ4WkM1WnFRbWVZdFNUV2UzVWR5U3BIMmdDYksr?=
 =?utf-8?B?bUlhTjBBdURpY2hlM0ZHS0RwN085M08xV1JJQTRjVGFBOTgyWHFtbFhRODg2?=
 =?utf-8?B?MXZkU2haaDl3UEFjZ2Q0UExTTnNIcUtkdmdpU3B6UHI4Q2gyRm5NaUxPWHZU?=
 =?utf-8?B?SC92RlRZeWNINFBBTlRBdmNLSGhZLyt5ZHNpeFZTMFBoMThQMXhVTFlVKzVJ?=
 =?utf-8?B?RFk0UWg0TkNaYnFlalNKRiszZVFZeExwdzVaRys2aEp5aFB1TmcrWUpUcFJZ?=
 =?utf-8?B?L1BWU3d5Zkc5clVSRHFVYXF3U2Rzcm93YWJrL1JWTUtqWFlXcm1ESlRoV1c2?=
 =?utf-8?B?OFB6NFJFZEhBbUpKNXlNekdYb2Y1NWx4L3RVTGRibm9wUjZTRE5lb0htdktx?=
 =?utf-8?B?eEJoeFVVZSs1bnloSHJlc1Y1MXF0dmQyNVlkemN0VXhLdUJoZk9KVnpXZTB5?=
 =?utf-8?B?UHZEN0FOanRURThKQ2h6cVR6dm9HR3JhKzRROVh3eDRCMXR4YmdpZE80WFE1?=
 =?utf-8?B?cVlmMXdNNjh0NlpNOGVHdGkzRlNxenBMK2FNc2tVNnluSXFpK0ROVVFNSHF1?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f19db9c-8150-4fb6-90cd-08dc2306e205
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 09:19:24.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAN/3j16IKPgoDCap21Zebhl6nDZSTgePzI397ESFP0Px5T8cxIFUC9XefT1Gbs970W7LgJIXzqUeeDdquOzFx2ZTZOe4h7JcBpqLsIu3YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com

On 1/30/24 23:06, Kees Cook wrote:
> The check_add_overflow() helper is mostly a wrapper around
> __builtin_add_overflow(), but GCC and Clang refuse to operate on pointer
> arguments that would normally be allowed if the addition were open-coded.
> 
> For example, we have many places where pointer overflow is tested:
> 
> 	struct foo *ptr;
> 	...
> 	/* Check for overflow */
> 	if (ptr + count < ptr) ...
> 
> And in order to avoid running into the overflow sanitizers in the
> future, we need to rewrite these "intended" overflow checks:
> 
> 	if (check_add_overflow(ptr, count, &result)) ...
> 
> Frustratingly the argument type validation for __builtin_add_overflow()
> is done before evaluating __builtin_choose_expr(), so for arguments to
> be valid simultaneously for sizeof(*p) (when p may not be a pointer),
> and __builtin_add_overflow(a, ...) (when a may be a pointer), we must
> introduce wrappers that always produce a specific type (but they are
> only used in the places where the bogus arguments will be ignored).
> 
> To test whether a variable is a pointer or not, introduce the __is_ptr()
> helper, which uses __builtin_classify_type() to find arrays and pointers
> (via the new __is_ptr_or_array() helper), and then decays arrays into
> pointers (via the new __decay() helper), to distinguish pointers from
> arrays.

This is (not just commit msg but together with impl), at first glance, 
too complicated for regular developers to grasp (that is perhaps fine),
but could we make it simpler by, say _Generic() or other trick?

> 
> Additionally update the unit tests to cover pointer addition.
> 
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: llvm@lists.linux.dev
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/compiler_types.h | 10 +++++
>   include/linux/overflow.h       | 44 ++++++++++++++++++-
>   lib/overflow_kunit.c           | 77 ++++++++++++++++++++++++++++++----
>   3 files changed, 120 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..d27b58fddfaa 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -375,6 +375,16 @@ struct ftrace_likely_data {
>   /* Are two types/vars the same type (ignoring qualifiers)? */
>   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>   
> +/* Is variable addressable? */
> +#define __is_ptr_or_array(p)	(__builtin_classify_type(p) == 5)
> +
> +/* Return an array decayed to a pointer. */
> +#define __decay(p)		\
> +	(&*__builtin_choose_expr(__is_ptr_or_array(p), p, NULL))
> +
> +/* Report if variable is a pointer type. */
> +#define __is_ptr(p)		__same_type(p, __decay(p))
> +
>   /*
>    * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
>    *			       non-scalar types unchanged.
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 4e741ebb8005..210e5602e89b 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -51,6 +51,43 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   	return unlikely(overflow);
>   }
>   
> +/* Always produce an integral variable expression. */
> +#define __filter_integral(x)		\
> +	__builtin_choose_expr(!__is_ptr(x), (x), 0)
> +
> +/* Always produce a pointer value. */
> +#define __filter_ptr(x)			\
> +	__builtin_choose_expr(__is_ptr(x), (x), NULL)
> +
> +/* Always produce a pointer to an integral value. */
> +#define __filter_ptrint(x)		\
> +	__builtin_choose_expr(!__is_ptr(*(x)), x, &(int){ 0 })
> +
> +/**
> + * __check_ptr_add_overflow() - Calculate pointer addition with overflow checking
> + * @a: pointer addend
> + * @b: numeric addend
> + * @d: pointer to store sum
> + *
> + * Returns 0 on success, 1 on wrap-around.
> + *
> + * Do not use this function directly, use check_add_overflow() instead.
> + *
> + * *@d holds the results of the attempted addition, which may wrap-around.
> + */
> +#define __check_ptr_add_overflow(a, b, d)		\
> +	({						\
> +		typeof(a) __a = (a);			\
> +		typeof(b) __b = (b);			\
> +		size_t __bytes;				\
> +		bool __overflow;			\
> +							\
> +		/* we want to perform the wrap-around, but retain the result */ \
> +		__overflow = __builtin_mul_overflow(sizeof(*(__a)), __b, &__bytes); \
> +		__builtin_add_overflow((unsigned long)(__a), __bytes, (unsigned long *)(d)) || \
> +		__overflow;				\
> +	})
> +
>   /**
>    * check_add_overflow() - Calculate addition with overflow checking
>    * @a: first addend
> @@ -61,8 +98,11 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    *
>    * *@d holds the results of the attempted addition, which may wrap-around.
>    */
> -#define check_add_overflow(a, b, d)	\
> -	__must_check_overflow(__builtin_add_overflow(a, b, d))
> +#define check_add_overflow(a, b, d)					\
> +	__must_check_overflow(__builtin_choose_expr(__is_ptr(a),	\
> +		__check_ptr_add_overflow(__filter_ptr(a), b, d),	\
> +		__builtin_add_overflow(__filter_integral(a), b,		\
> +				       __filter_ptrint(d))))
>   
>   /**
>    * check_sub_overflow() - Calculate subtraction with overflow checking
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index c527f6b75789..2d106e880956 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -45,13 +45,18 @@
>   # define SKIP_64_ON_32(t)	do { } while (0)
>   #endif
>   
> -#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
> -	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
> +#define DEFINE_TEST_ARRAY_NAMED_TYPED(n1, n2, n, t1, t2, t)	\
> +	static const struct test_ ## n1 ## _ ## n2 ## __ ## n {	\
>   		t1 a;						\
>   		t2 b;						\
> -		t sum, diff, prod;				\
> +		t sum;						\
> +		t diff;						\
> +		t prod;						\
>   		bool s_of, d_of, p_of;				\
> -	} t1 ## _ ## t2 ## __ ## t ## _tests[]
> +	} n1 ## _ ## n2 ## __ ## n ## _tests[]
> +
> +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
> +	DEFINE_TEST_ARRAY_NAMED_TYPED(t1, t2, t, t1, t2, t)
>   
>   #define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
>   
> @@ -251,8 +256,10 @@ DEFINE_TEST_ARRAY(s64) = {
>   };
>   
>   #define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
> -	int _a_orig = a, _a_bump = a + 1;				\
> -	int _b_orig = b, _b_bump = b + 1;				\
> +	typeof(a + 0) _a_orig = a;					\
> +	typeof(a + 0) _a_bump = a + 1;					\
> +	typeof(b + 0) _b_orig = b;					\
> +	typeof(b + 0) _b_bump = b + 1;					\
>   	bool _of;							\
>   	t _r;								\
>   									\
> @@ -260,13 +267,13 @@ DEFINE_TEST_ARRAY(s64) = {
>   	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
>   		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
>   		a, b, of ? "" : " not", #t);				\
> -	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
> +	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
>   		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
>   		a, b, r, _r, #t);					\
>   	/* Check for internal macro side-effects. */			\
>   	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
> -	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> -	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
> +	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> +	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
>   } while (0)
>   
>   #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
> @@ -333,6 +340,55 @@ DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
>   };
>   DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
>   
> +#define DEFINE_TEST_PTR_FUNC_TYPED(n, t, fmt)				\
> +static void do_ptr_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
> +{									\
> +	/* we're only doing single-direction sums, no product or division */ \
> +	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);\
> +}									\
> +									\
> +static void n ## _overflow_test(struct kunit *test) {			\
> +	unsigned i;							\
> +									\
> +	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
> +		do_ptr_test_ ## n(test, &n ## _tests[i]);		\
> +	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
> +		ARRAY_SIZE(n ## _tests), #n);				\
> +}
> +
> +DEFINE_TEST_ARRAY_NAMED_TYPED(void, int, void, void *, int, void *) = {
> +	{NULL, 0, NULL, NULL, NULL, false, false, false},
> +	{(void *)0x30, 0x10, (void *)0x40, NULL, NULL, false, false, false},
> +	{(void *)ULONG_MAX, 0, (void *)ULONG_MAX, NULL, NULL, false, false, false},
> +	{(void *)ULONG_MAX, 1, NULL, NULL, NULL, true, false, false},
> +	{(void *)ULONG_MAX, INT_MAX, (void *)(INT_MAX - 1), NULL, NULL, true, false, false},
> +};
> +DEFINE_TEST_PTR_FUNC_TYPED(void_int__void, void *, "%lx");
> +
> +struct _sized {
> +	int a;
> +	char b;
> +};
> +
> +DEFINE_TEST_ARRAY_NAMED_TYPED(sized, int, sized, struct _sized *, int, struct _sized *) = {
> +	{NULL, 0, NULL, NULL, NULL, false, false, false},
> +	{NULL, 1, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, false, false, false},
> +	{NULL, 0x10, (struct _sized *)(sizeof(struct _sized) * 0x10), NULL, NULL, false, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized)), 1, (struct _sized *)ULONG_MAX, NULL, NULL, false, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 1, NULL, NULL, NULL, true, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 2, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, true, false, false},
> +	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 3, (struct _sized *)(sizeof(struct _sized) * 2), NULL, NULL, true, false, false},
> +};
> +DEFINE_TEST_PTR_FUNC_TYPED(sized_int__sized, struct _sized *, "%lx");
> +
> +DEFINE_TEST_ARRAY_NAMED_TYPED(sized, size_t, sized, struct _sized *, size_t, struct _sized *) = {
> +	{NULL, 0, NULL, NULL, NULL, false, false, false},
> +	{NULL, 1, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, false, false, false},
> +	{NULL, 0x10, (struct _sized *)(sizeof(struct _sized) * 0x10), NULL, NULL, false, false, false},
> +	{NULL, SIZE_MAX - 10, (struct _sized *)18446744073709551528UL, NULL, NULL, true, false, false},
> +};
> +DEFINE_TEST_PTR_FUNC_TYPED(sized_size_t__sized, struct _sized *, "%zu");
> +
>   /* Args are: value, shift, type, expected result, overflow expected */
>   #define TEST_ONE_SHIFT(a, s, t, expect, of)	do {			\
>   	typeof(a) __a = (a);						\
> @@ -1122,6 +1178,9 @@ static struct kunit_case overflow_test_cases[] = {
>   	KUNIT_CASE(s32_s32__s32_overflow_test),
>   	KUNIT_CASE(u64_u64__u64_overflow_test),
>   	KUNIT_CASE(s64_s64__s64_overflow_test),
> +	KUNIT_CASE(void_int__void_overflow_test),
> +	KUNIT_CASE(sized_int__sized_overflow_test),
> +	KUNIT_CASE(sized_size_t__sized_overflow_test),
>   	KUNIT_CASE(u32_u32__int_overflow_test),
>   	KUNIT_CASE(u32_u32__u8_overflow_test),
>   	KUNIT_CASE(u8_u8__int_overflow_test),


