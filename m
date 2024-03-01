Return-Path: <linux-kernel+bounces-88425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C186E16B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209AC284786
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F36A028;
	Fri,  1 Mar 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9deOPJZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECC3E47F;
	Fri,  1 Mar 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297966; cv=fail; b=HF4Hc9wCQBfoFtu+dKWJ3uXromxLhbr6+MZan3MT4ZMW5Fzad++oi9DicHvdHU5SqSGGGxJ+bVhxx57v0wsr95EvHavKSOP1S4g4LkiTiRh/ERMv6JUN7ivHFlHejMXl/OpKEvFigs1vUPrej7eE1UjQ+Rdm35WkklAoaXx2Me0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297966; c=relaxed/simple;
	bh=I5YwmN05qOsalYE4x8z3Az5zrzXAxzfD6mVz69cQgus=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REQOEnajl8UyZCKZNHASszG8owSplzgszoIU1zlPH+tIRVTwHIPVK7BqsAyE0zJjG1Qm1GFlED3K1ezMlwMF4x1QuKsHZVfacounYJ1Qy/9WC9YaRcfTjupf4rsZMpDRo/m2UXXaGOrWoBtCaWlnqjOBVVUoZLTKliXZY86e4hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9deOPJZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709297964; x=1740833964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I5YwmN05qOsalYE4x8z3Az5zrzXAxzfD6mVz69cQgus=;
  b=L9deOPJZy3pKszFudUKdh7GrBquhgytiKhKyPxALVXPfXwaip8bxA0ZW
   2GokAxlFLUiBuuvrZjPDEBEDnIqQNpF89aY6XnIvA+leP56XZlx7zh5oZ
   OKGayf3Op07CCw/sXvhUMUL6O22sLSdaPfoc005p1KVWK+cRr1BdBzLuI
   GgPigaK/euN/PN7y1neK/js1diWGvNni9ZBIx1KeDmvXorwaHiE/fykaK
   KHY9lmG+HYMqP1nsLoH8PTQtP8VmEvEU1ECfhXmjPWJDz+TvWKLp8iIBw
   cV61O/pPXv9f09YSsooko2hKCVzxWN5jGOCKQR51HhT1C+oVBk+wkfaTB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3722637"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3722637"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8100225"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 04:59:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:59:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:59:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 04:59:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 04:59:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDsiQ1X/sjxVkeuQDHy1gRKZn2VLsonGKc3qCd16XHqyQRww2B+qCED6EF9KjlNDQKo6AEg+1/cEKxXIEMW5tUIymgSNbfrM46BqyjuHUcGDR8FWnG73uclrNyYFinNpOfk7/DtkvHEphPhtnBh+JppNw7HC7qu2L7LAH4iLEIMM7cnKa/f9mfxijKoPf+LdY3byuvTB5q2kFxwTb9Cv0IPLRWeI1B2DkD596G2U0frW+rVko07CPe7ByQm9HNwodhDtJBnqyZ2SFNRfF9M+Oqdlsd6xx8287pLWOPiWOhfGtEQqAufK+hWqRabuPEr0nJaciQWtIVmL3xW7Y31qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtCEgAYPMkvE5ZfiVdymmPuyUrV87WVuAx82e53bpn0=;
 b=LWseNBxO0vjcE8SKokOTIJEBN+CQH3q2y2ToW8o0tfRYbwhJkoYivEK/J+FvyLgwg8VXznFuTyERR2W3lnjKW0zf6PI7wanFniqsaw6lSCHsuSH10CivQD6guD17FL38RNbbEKHXqD1+V32SoVw2lir8FQGRr1ItkQFU6qE1cLIg14biFAX17YJwOZxW89+IEnYngdVGgdfAwN4wJmTW5J79W4H+QRGRInRvM3w+vxTRnuMi3SANBNskQ8zFW6c4GZcezIItyRKYpDCYk0uDBrl/xHVCyVWcn0XVkiogJcMjs1PL6juGQJR7N2gbPnFGxPmNKxnjthgXuExfBDPDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5040.namprd11.prod.outlook.com (2603:10b6:a03:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.15; Fri, 1 Mar
 2024 12:59:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca%2]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 12:59:20 +0000
Message-ID: <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
Date: Fri, 1 Mar 2024 13:58:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Kees
 Cook <keescook@chromium.org>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <netdev@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
	<lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
 <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe26bb7-83db-4400-b010-08dc39ef68d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIFyE1MscidEFAGTQX3gIa6WMqZge6W0Z5IDp0h1/LWHSFNaV6p6phiYRxLsvL56Hd9dkqVr5cOmseU6VWdIKuaB3IFCA9dp6LelF094PvVemD3hlbmh0gOiEAWdTUC6znjFSSdQuW93UATe9TW8m3Lz36jkTUR+TWHJMnrUmzPomvO1hdG2Ae1efE0FXjEcfrChQxMjNGf3soHDVzTBN3XV+DHuk+Wsb7Doo1DLb70RxFGMVSRBw7XCJGMWi13Pi5cNLlX2p8toO+ke435pQzv1ijxD2SX1m60LrCfgwJWjgkn0F2ljyXwdE248qBoMshQhwQSrHZRyf0RnbEaB5YH8EHL+esJHmcYXXT7Jn1CO6rQnuQNgVwyvL0GjRlNd9ynPHbxuW0nZPe7AlH0wL7luWoANkpqaUyfAanDDd0OBmToHaJ/YDJMsHlKHvPhxlloDA7LNyLz8TNjPeULHAGEUd7zJgYV8nU4XYBqsoh7pQdRkJcICIZ/DCdc2LSo9A/O7fOHzCbMjJsnNpkpHtUvcNu54ZdSeDdchLkYNFGaYQFwS0PzWyRRmMlwKEgDv12vXLmGMWMP0UWwe0dfkmGJ3ME1/jM65a013PCGdyzjpG8H36Fn+Y5KUePMPKguD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTVMUDlnYnhwSWIwc2F6eExaK3B6ckFQTmhzdVNSUkhVdnNpdWlTNnZlaGFz?=
 =?utf-8?B?eDZWSTllNnBsT0RPMlFxTXQwVHkxZWVoMG11V2V3UG51cFRSOHRXdGFxa0hQ?=
 =?utf-8?B?Z3dKM05nd3U0SzVFU2lHSGZrcjhKdWxCblp6T3FmemxvdE1SS2Z2eEdQQ1Yx?=
 =?utf-8?B?NThKakladXNWaW1TMFRGS1lPRURsN0hxbnpPL29aaFhCTjU5RXRHQnRXb2Vl?=
 =?utf-8?B?ejNrRDdWelNQNGZiYzhzYmtlY0owd0xVV2FUaW5NVXZ0MTJYRm5oL1BXUEha?=
 =?utf-8?B?cXRGUnN0SW1Oc1VCMEswUTRiRGRwV0RHSDdnc1I5VFBnNkpkTEpyS3U2T0Ir?=
 =?utf-8?B?Um5sejdmdTcydWFSdHdvcUtIYUpZemRRZW9OaFpQSjgxOGRMMW9YVWlXUU5Y?=
 =?utf-8?B?TzAvR2FtbzhlbTZ2ZG1pS01acU8rRS9HZGFXOFpSYkVZdGwzMlR0QndaNjFG?=
 =?utf-8?B?YnY5SmZvclVEMGgxak5iSkJ0TWJ5K2E3SlJMdmZxb3d1OXZzdkJLRjVoMzQ4?=
 =?utf-8?B?QlRPSGltekFISXozTmx0c0lGcHVxaFRHRWQ3eHZHcTZLTW1WcFpYM0I3elJq?=
 =?utf-8?B?WmpWT2RaaFBCTzVtQktlS3ZURXhiRGplU0U2aXRKeTdpUnBkRWVlRldTUGJ2?=
 =?utf-8?B?dE0zWDdRdTNrVEhsWGZSSWhzMFNBS1I4WVNZMkFBdTg5QkZycm15YWZ3WmFL?=
 =?utf-8?B?cktZdVh3c3FaaGlXU2NremtrbFZqc09IL2laNHFqT0g2dkRCcytjZTFxVXFT?=
 =?utf-8?B?V2FUdjZJbElWMVJZeVJleDl4UG90SUEycWltalp2ZDErdXVYM1htY2lpNHdx?=
 =?utf-8?B?bC8vQjd5OE5WY2k0VnpqdzJaQVV1eFJXUzRyeW5YajU3ajBYOEJmR0J1WDlD?=
 =?utf-8?B?SWV1ZDNNd3pzTmJlOGlIVlZad0VjQ0NLS0crZzZab0FaUjVzUEJBVUtBOG1h?=
 =?utf-8?B?VUhwcEl0WlBia2xKbHJ0T1gyaHQxeHprbWVVaXhiY0NFclhKSEVDQnViOUVM?=
 =?utf-8?B?T0Z5WEFYZko3clYrT3QvZUwxTU0yWmo1VXlxbFhnY21jTkVDQXFwT1ZIRFFO?=
 =?utf-8?B?eFhJalF2dXY1UFIydFlldlZRRUM0VGJpLzh2cS9wUVJ4Y0dwL1c5dmI4MU9K?=
 =?utf-8?B?ejNKaHNsTTNnQ0w4WkJwZ0ViYmdUVXBoY3Z2WjJxcEZ6UGhJU0Mvc3p2MmFY?=
 =?utf-8?B?akFRMWJ4MnpVTTJKVk83YXl5SGhSeHIxYXlmNWw3VzJSZXBhcEZVMGRXdjJ0?=
 =?utf-8?B?WEszWW8wbTJZeGJvQUtjZWFNUHlWUC82eTNZZ2dTS0lCTmR6bnhNVmZYVjNy?=
 =?utf-8?B?RzVIVnFzZGFadmlrUDJiTEdzWjZZUkJpbFRoVFkvNy83UGIzYkRPS3UvYTZy?=
 =?utf-8?B?bXIvS2RFT0xlVkk5cFJlcllFN2g2azQwQkEwUE1RSGF2TG5pWDFKcnVIMU1W?=
 =?utf-8?B?eXZ3clFMR2p5VEorNU1MODRteVkweW9FbVljOU1GUDNuVGVVaFdaVjJTR3M0?=
 =?utf-8?B?Z00zWGpLOXhmT0VMK2lrKzV3Vmh4MEVYZUI1TENDKzVvRlFGakd4aEtZb3pj?=
 =?utf-8?B?ZTlnZVJDVE5ETDFMaGN0bWtrc0o0YTc1dHpDc3FNdklIdk1BWklOcDh2YXZX?=
 =?utf-8?B?UGRJOWpUNncrZUEvWERHUGI3elY5dXVVa01WVVBRcnFid3ZvUWk0d1ZOa3ll?=
 =?utf-8?B?NEJSTDBQTjl5R1BqamNvM1RFUkVNaUJtNzVLNEFGajVTMGgwUHhVK05rd0hn?=
 =?utf-8?B?V3BmQ1JlcUVXckJjeUlMREEydXI3S1NjRTIzTUlkNkFuUWo0M0dITHRMb2NV?=
 =?utf-8?B?aGE4bnVEVUtrc1YvTXBiMnk4UFI4ZTgrM3cvUHJXeTd1Q2RGTml1S2xlY2Rk?=
 =?utf-8?B?dlZBY1JGNHFoRTJ1WFBzQjhnMG9CQ2RyNDN1SGJraVRSK1Nvd0ltU1JFWCtO?=
 =?utf-8?B?Tml2aXpMVlM3c3NCc3o0NHNnRGhGNFM0ZkRSekFLVStFb1JYVW5UNmlrOG1p?=
 =?utf-8?B?S2I2cEkzYVFsOGM1bHJkdEZHeExmaDdzS0c2Y2pxdnVNMXNBTUI0cWVqeXdl?=
 =?utf-8?B?ZG9XeWVqSGpqWWVGNWR3VUN4Sk1ja0xaQXBibkhyd2wvV3VpOWJnUkxBckpG?=
 =?utf-8?B?L2U3cE5BWlNYRTV6UGRYeVNaempISVZpWVVralBOMldwTzUxSlRyUmViUGlQ?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe26bb7-83db-4400-b010-08dc39ef68d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:59:20.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4cH6Csu8MVbA5qqKzAgXsWEX3dEjo8epnVd7dvbRn25dkXHYUy9kEkhuIn7akOWh+BJ2jdF35T/FRXkxRFtllkf+IHd5vaR98cO56Wd5t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5040
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:03:55 +0100

> On Fri, Mar 1, 2024 at 7:59 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:

Re WARN_ONCE() in netdev_priv(): netdev_priv() is VERY hot, I'm not sure
we want to add checks there. Maybe under CONFIG_DEBUG_NET?

> 
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 118c40258d07..b476809d0bae 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
>>>       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>>>  };
>>>
>>> +#define      NETDEV_ALIGN            32
>>
>> Unless someone knows what this is for it should go.
>> Align priv to cacheline size.
> 
> +2
> 

Maybe

> #define NETDEV_ALIGN    L1_CACHE_BYTES

#define NETDEV_ALIGN	max(SMP_CACHE_BYTES, 32)

?

(or even max(1 << INTERNODE_CACHE_SHIFT, 32))

> 
> or a general replacement of NETDEV_ALIGN....
> 
> 

+ I'd align both struct net_device AND its private space to
%NETDEV_ALIGN and remove this weird PTR_ALIGN. {k,v}malloc ensures
natural alignment of allocations for at least a couple years already
(IOW if struct net_device is aligned to 64, {k,v}malloc will *always*
return a 64-byte aligned address).

Thanks,
Olek

