Return-Path: <linux-kernel+bounces-100411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B0879717
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BA01C20F31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF607C0AF;
	Tue, 12 Mar 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J90xF/C4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AB7C08A;
	Tue, 12 Mar 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255837; cv=fail; b=m5+CD7eJTSZ6rFb8CoEpnD1x+wQxUM1gP7Dn1uBoe+o5COYUXEQ5LimemZ0ySf4salktTvDmHAxtGUU3Qj1tilKa/a5309iqjVR8xEwKv8EFBDKn5sDc3YnfV7iE7we6UedO1yVz+pS1jmUEWaR0eyWMKPI1dEpmSOJuoZsyHAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255837; c=relaxed/simple;
	bh=JsNV4+6OEzKXLbdRo1NsYJYSB8jhUvudYM0UwP4AdMM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EmE5uXzyaq9z+QXiXAt2GAo+AWQOW8xTlbumPilQA4oWFP5LzsZcku8XwMc89zh1CA4M+vmbQaLaNtUr3mcQipXNMsNx4peD5IaJJwlb/5uJQN79IWjZZadlBVFhv4H31JDPyjN/wucc7OXh/kR39KfVzzxO7sEcRL6tGU/t1iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J90xF/C4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710255835; x=1741791835;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JsNV4+6OEzKXLbdRo1NsYJYSB8jhUvudYM0UwP4AdMM=;
  b=J90xF/C4rRnsgMiR+yGDmUaAKyhi16KLrvaBEllkzaP+dQeRnYzA8pXt
   90g+ubW/c++1+FOIRbwPiBgUDaokVu+l8/DIHA1ZIWnQ6TnGidx6hA+/f
   Rs4Uz3OYCfQhm9d3dZ+/dS7sp7EObugrTVRKVkl52I1oDWkMwsaA4GOcM
   zoCZWbeeiqWlX0KLAtlarp/MGVRvAjpp+b169JRN0TBsVFKIdO+BCIE5R
   nGZQnFhtq4BYZuCejynsyXKIuKlXwRhUmSHc+7vx0yCPe+Ctc5bWbmFxe
   RhKUXN5nQjnH4q/US9W0noyy0QRJgFS6iBfsbmDV8QgLhNdJZ0zklazl6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22487950"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22487950"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16221597"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 08:03:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 08:03:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 08:03:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 08:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANk8xEUF4jrge6YAM8Yl15e9xdag5rOL8h7zb0IreR6XobWru6i11TTq5xQOd1k2OPLQmHu9lXQzsndHoHs8bjMS0p03NY9+nVetN6UmSc4h0FAi823K4Volmf9kfIeJN4MYn+V5opdjxbSg1O4hFKTxbvgOftyAbAMsmSblOZ/ZUdXOfWYfBlRpPLzetgBd1ZCzFv4jgSnRCnmv4meP9pfthGEkKK7yiMMnbuceMlp7kEJyLv57WkY7L7vgTh6R4EGMo2PHZ9tKrAB6HeyGFesteN9rFIxwA36fBhAJrvY/5CqePSseNMjC5QAd4TayT8lmwt8ZiIA7kHo9xVc8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRvKRKIH8nIZJdwv7P3/i2QPuiGL/VpusnCqCrebE0c=;
 b=FKuQeiJtoxpRYMt+kHXj4CWSVWQuFruT2D66NW5iFOTIxWm7S9+YGJY9WYYrGFpVutFHvB+Tw8JleGdXfNIMqsG+mjVZXuYVznPgVSir2o6yFCkqVyxYTj8lETABF/7K3Al4DFFpup4WZSXAeiCXrMtiRS2YGY8AbjS6oD7KRN+rLY7+UjBYdDUK5Vj5YyT3DFbqKqCCzXMsN66qRMrxwMrpbjIIlTmkp4XeikOYmXE0/zipNljGe6EF1nBB60H6lZtb2sFkDxH3kuEaYVnnJI5VzE2TEJ68tpASNK6TIlnB1V9+IYaYyxLas1PThEwNZzJcwlNLczY57nAlx0Z2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 15:03:27 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 15:03:27 +0000
Message-ID: <7d463faa-94ae-4c62-b3bc-b4d1084e4600@intel.com>
Date: Tue, 12 Mar 2024 08:03:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: x86/aesni - Update aesni_set_key() to return void
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ebiggers@kernel.org>,
	<x86@kernel.org>
References: <20230607053558.GC941@sol.localdomain>
 <20240311213232.128240-1-chang.seok.bae@intel.com>
 <CAMj1kXEQpFhDaxJ-rBb221ggdZEYWPzeoueKJr5SqRx60Ezf-w@mail.gmail.com>
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAMj1kXEQpFhDaxJ-rBb221ggdZEYWPzeoueKJr5SqRx60Ezf-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 818808c2-6e88-439c-0262-08dc42a59245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I20zBGyBYiKaca2bpDT+bs/DTeszrAwUgVqUTtc+chMB4akkQFuNfUr0TYMOKooleYA+MAshuZqr5gsOJzHrEJwgb0Tmnac3bqdEj8fF0Baq6RqGRqo3xwyXNljKUfkNtvESlnJKj6yQJN3V55b+b7O5asqdWO9heje+f74Kraw84sKW1pxmlK0QXUjcQGpY+ifAYBqaqvnipJmQIpMofDON89fpAYib9gT2Ud1ZYHdzmAwz3MhXwL60NJ3QrMFswwkB41k1ADiA3wXsdczAEzxX65tz8P+JwWxW8XLWBuVtaN6bOaDQVdGv4xph9jwr92Lt0WCYu2Z4pQcwf082YnO4EFXR1nxgz18YZMidhZ9XfZAs2RUQFy6beEwz/XkN75+cFrfT6ozo6JQqiVUTSEmUPQdii7/55WQG1Xv0aG8HkoH4+38IxR1vIHM1LkrENQxbpbx9AcEIlG71YtBOrbxDE2YoWmKlWEV02DxkC4V79KK0ivr9mTzwiu83ySuWKcJj+SrN48wsr7sLYib3AQn4lwPjeHewX7bHpY7RWTGxB/aYQ5Xw3xf0QJTA4I2/YMwrsiljk7hItXP7QuwGemWylhg9pHrgC8ED+cRzB2LlSIh5bPo1F5d/5OfVqaWbR1jbHX6Nor3FXKykhv7thiBO3FPc1hRiJh+UM+mGw4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRCRkRyT0p5YWdiTXBVNklORzhuMWl2NkdIRUtQdk1kRVIrejNRS2psd1M5?=
 =?utf-8?B?eFNKL3NTS2hEOEVNZmRBR05vS1RwYll1N0R6d1ozVGNKMjRQODRyRUJ3dEJq?=
 =?utf-8?B?cG02dUphQjhSTGZ2OGVqMzR3YnRMaUhvSGZaamdjRXhXSHcxUC94YzQ2UWZK?=
 =?utf-8?B?ekZEWUsvUkhXcFUyRjBNdUUyb0ZWRm5RMTMvR2U2TjdZbjVhTUxGWjlBeUMv?=
 =?utf-8?B?dTkyU3lKQXVCQXU4MU1ub3pLS01PRzIxZHdHQkw1RjIwdzV3dUluOTBNa2Jp?=
 =?utf-8?B?cThzbENPaThDS0dCbXQxZWFLU0tGQnA2S25jQW9MdG1lcEloM1h5K2RQMWND?=
 =?utf-8?B?RFdLcC91aTlQaVVKMEdFYXBFcm5sUUxkc2VGUDhIaFlBZUtUU2R6RmhoUkgz?=
 =?utf-8?B?dUc4VzZrc093Qnc0UXpRMkozRWI1NHBkSHkrZXM4c1h0bzRLRlE4bDdudkFJ?=
 =?utf-8?B?Q0NnRGIzVmw0TXVYSFR3anZ6OVN5TldSQjUvcnJDMHVRcjI3U1JPdC92WmRS?=
 =?utf-8?B?V2hMNlpFQi9kZWdZdzdlU1JQeFVpeFNWZzYwK0lNbjZCc3o4OG90MG1yWEs1?=
 =?utf-8?B?dXJtcmVqdWUwWDQzcEFseEgyQkJYWGpvc0thWGQwS2MxSmE4SkxFS3R4cmds?=
 =?utf-8?B?b3JJRUppVmJsZWVIWWY3L1dsU0NhYTRwazJVd2dwK2ZLQjNvWHpxUzhiTTBh?=
 =?utf-8?B?eTFXRjUyTTU0QWxWUGJ5dURFRkxMZmNQSSs5VndFSUNVOVltTm44NlRhd21w?=
 =?utf-8?B?VWh1M2FQUW5uZjZVTUxOVGs2VlpJdzNVV2tucnhkcTJOczNPelpPY285dHJX?=
 =?utf-8?B?MHFoRlIrYjY5SEplSE1rNEtHOU9wVjJ0SmpQZEFRdmloMFZTdjIrYlVPR0ZH?=
 =?utf-8?B?RUx0WEZqdFB0N0R6MVdNSnQ5TmlqcGxpU3FmWWRtY2FteTZxME5BeThMZVhY?=
 =?utf-8?B?SnVadVlmbXZuczVnVTh4S0NZaUYzN1dDcjZoOWhNTWlqVUJ3NXFzNXVMa3Uv?=
 =?utf-8?B?MkxKWEhocllUU0tzekxZbno2Z3FiSHQ0MmJEMG1hb0dtcnhpWDBlMThwZmVK?=
 =?utf-8?B?ZUM4YjNTdjN2OEhtOGdYaEVIclpFT0xTRGVTWUxwb3BxZDBYMEJVc3ByWUhG?=
 =?utf-8?B?MWx1eEhmdnlLbi9jK0NTQmlIU0N6cVBPRkRlei9CbFFWRnk5VHNXOGZxWVRr?=
 =?utf-8?B?RzB4cW56Z1hkaTlYQnlZOWVJRUZWUEJVdkFmWG52VUlqWGRRT1dCUllHSGtL?=
 =?utf-8?B?cUtCT3BjNUsxSGdhQnZZYmJ3YW1kUmNUOGlsUlgvUVYvSTdTeWFNVzgweDVX?=
 =?utf-8?B?N2ozVk9zN0xsY3F2NzJ1UjNoRjZ5dEpUMElOd2p3RFVmYW1NWmVlWlNPcEFX?=
 =?utf-8?B?dURnc2VPa0ltclpJSDQzdnVrajdHUU1QMnVYcGh1b0tOTHRMNEZUR2RId3dO?=
 =?utf-8?B?V2JMZXlUaFVQKzB0NXNseURoL24wUi9tMEQyYXVPZmlaY1JEYVBiV0NDZUVI?=
 =?utf-8?B?Z2t4QmNlUjMyV0NwZitGTHJmaTNlNnM3UWJrN2lnemxPcmlxOTVJVHppZjNR?=
 =?utf-8?B?eFB1U01OSUVQSmJBZkRvbnpMcmhYa0xOV0YweGdmU2JXdXpVTEJYSFhQbTlm?=
 =?utf-8?B?VzV0eTZET3BhcnY4bEsvdHIrV1EzYUVNY2JBRkZFRUc0Y2c3c1ZvckpGTHd3?=
 =?utf-8?B?cXpHeXdOV0dEaWk3ZmxwMUJUaXROamkrckw3emhiek1HOEsxM1k0amg4ZmVx?=
 =?utf-8?B?MTRXT21hME04YTg5TTVzMm5MOWJML3hsbWQxS1JaSDJTNFpYZEUyc1g1MjNm?=
 =?utf-8?B?RktpS09lRXZSa3NwYjhMcmhoR1dKenAySUExVEVNR2FPZDYyNGE1bkd4cEpF?=
 =?utf-8?B?aVhOMENzM25OVTlodGI4ZDZsS1UwZktKOUU1WXltNXlEb21YK09sVGRuUzF1?=
 =?utf-8?B?ZzdMdWhRcGMxeHYrR0N0cFBFM0FwNG0vM25qQ0JzSnJ6WU5GVjRNTDBjcndV?=
 =?utf-8?B?aUN1MlB3WlRzRGZWN0FMRmQyWWk4M2lNL2xNdjh4Y0JJZ2ZRY3REUDRpUDQx?=
 =?utf-8?B?bHgyRmFPT2QxMVlmUFVmcTloS2FLMWJXMTdjZmxtditZNWZvWHJQclVXUEk3?=
 =?utf-8?B?b240QWhXSTk3MVBuZjlneWZqV1VRdkhiSjMvbjgwdEpOL3hFdEtPcFlvSkxj?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 818808c2-6e88-439c-0262-08dc42a59245
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:03:27.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXHi5atmJY4/6RkGwzI1l+kfvGGI1hNJO3gy/gPXcs++/utPIXFsJPFpLgrquiniH9e0M4XSXYQekIRUdifq8dlRhpDd4fsNrqgD7RMU1GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com

On 3/12/2024 12:46 AM, Ard Biesheuvel wrote:
> On Mon, 11 Mar 2024 at 22:48, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
>> @@ -241,7 +241,7 @@ static int aes_set_key_common(struct crypto_aes_ctx *ctx,
>>                  err = aes_expandkey(ctx, in_key, key_len);
>>          else {
>>                  kernel_fpu_begin();
>> -               err = aesni_set_key(ctx, in_key, key_len);
>> +               aesni_set_key(ctx, in_key, key_len);
> 
> This will leave 'err' uninitialized.

Ah, right. Thanks for catching it.

Also, upon reviewing aes_expandkey(), I noticed there's no error case, 
except for the key length sanity check.

While addressing this, perhaps additional cleanup is considerable like:

@@ -233,19 +233,20 @@ static int aes_set_key_common(struct 
crypto_aes_ctx *ctx,
  {
         int err;

-       if (key_len != AES_KEYSIZE_128 && key_len != AES_KEYSIZE_192 &&
-           key_len != AES_KEYSIZE_256)
-               return -EINVAL;
+       err = aes_check_keylen(key_len);
+       if (err)
+               return err;

         if (!crypto_simd_usable())
-               err = aes_expandkey(ctx, in_key, key_len);
+               /* no error with a valid key length  */
+               aes_expandkey(ctx, in_key, key_len);
         else {
                 kernel_fpu_begin();
-               err = aesni_set_key(ctx, in_key, key_len);
+               aesni_set_key(ctx, in_key, key_len);
                 kernel_fpu_end();
         }

-       return err;
+       return 0;
  }

Thanks,
Chang

