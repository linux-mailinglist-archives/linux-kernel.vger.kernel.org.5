Return-Path: <linux-kernel+bounces-7621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4281AAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1182286DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9D4AF6B;
	Wed, 20 Dec 2023 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuuN2NgQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCE4C3CC;
	Wed, 20 Dec 2023 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703113744; x=1734649744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yC4QQ3Wf/HqelFNew97zPh0N5+oLnij5fqsp8F50XXY=;
  b=OuuN2NgQ67+sWXOYbZMbXIV8DInO1upftr6+8L1+j/wGJaxbeXwWDIjK
   /qCnYB19QfS4wmr0BjfHlVfX3mjvB2b760ydFexqAk64nmxKSFYZrXNyZ
   cRQoNy0n65UIqM75TumTg3q8lBqyMbuN4FxJEBbsmbl6e64CzgoXmaufG
   YorJxmTqkk4KSIft/PguZbgYtM89th23ZkuTz7OwEsj334uzQ7nFfTlLq
   uMizIKdrvClkeU3CXF3jtO52uI314VnDjTWspF//WHx1jhNoKFIZUP56g
   xrM8YMcWpBJCejn1lxwvjNHWy2AEPCXXMSoFJzg/j3vSHVQjWyGdwRHrJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="394772884"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="394772884"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:05:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="769748093"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="769748093"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:05:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:05:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:05:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:05:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:05:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnoYDV9IcbiLC62vyg+lHpKrBq6wC0d+KdnRhq0hH0I5n1QE4pDvi9vKxEi1k34a+YKlgoqRXy9dD9f6K/1YE7Fjfa0y2+D3eU0cRO/hUL5S6MybRgVzCKMurAktmRwjk79QSAl/MozDVHKJPGSACcfM69w0nnB1F8Gg3SArO9FKTrO+o24aZ7TW0eAPEGQEtwn88s1IJ04n3YzCgkwH5c6MD8rdEhx5M9ZH45OuL6C4K6g5ol12ZhRGff020s0paEDNIXiymcXm0JknHgNJDOJXe3DO/fn2qEsuDo+D1I+TvulCZD7Pkjdz7SCDjyGnnJ/gcZTXGiCUTRWQePw77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYsnjpHLJLdKnogfKHpOcoyXgbzT3eFMNuOtBJ6Dodk=;
 b=HNRpXRcF1ygqZOUCnFHqPav/XorYd5sHlczWUyQyGAG1V0a2lC9qAlH7okwK6V7hGKu0wSlXfTdxMh+5lAlJvew3pK9TCQ1hKTSER9+cN7fhjpLMZj3R4Ew0TfNn/wba3NcTi3ksOBjfWcKxWkumKOhStmcxgnP06ohFhPYRJypN1MCXwdLAT0K3jKRp9iRpR8DJMFzYtU6ZjJ83QP4osJpHACuQvVBjRKReYsswWWrf+LjJ+jqOodWliYRs7GSyQucGIIPKEM2I8zPgKQnVpZmco/bbZwPMdrixhjexXY/Xo4iXNNK/BMJGJlo1kQQqaPzzc45t+bgep50o0WzGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by BL1PR11MB5448.namprd11.prod.outlook.com (2603:10b6:208:319::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 23:05:02 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:05:02 +0000
Message-ID: <0ecaa500-9dbf-48e1-97a9-13ba7c2563ae@intel.com>
Date: Wed, 20 Dec 2023 15:05:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/12 net-next] qca_spi: Improve SPI thread creation
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-2-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-2-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|BL1PR11MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e48c0a3-2dde-4dfc-2ba0-08dc01b01904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+sk0n5eWcJz/fL9zPIY255yHAxDGn4yK0Y5GTeb4qpnaYmOdTMISJMFVyGzwXmbm6zuAnX2dqW5hjBJeKPht8Wllph6xa8praAPJTuTFUMrAgLhargrdQap39QxPJGnUlnTvaw2viq/58gWTwZUwnNkvtC1f8yf1IG4C3jwk3XaZ7Rwb0SbINASHRs4zGoM13VtML+C6N4A7pnQsn3wzVuzDSyfR2WJ55zh+B73nWp7O0U61mLs4oSs6dVjXlaR+lZUxJ2x70301KBAN0J0foYyYaYi8KvsQpTD76grTyfXLHcjOXbq2gEzBBqhKpA88lExghiNIm6m7tcJL8kLI10h8T7Akj6GnYC6CE9v8wkUBRaR34bNjeR2nGRhnikI1YGWFetIGh+tFkIgdF+W8VsCfCcNdSuF5ibUgtpNtNNGwE7Zs/qJEaGdGvKZLN+EMFTAekz8SWSqqLEBzGjkzv8Gy5rlPrICagQPLAnf4c68tJCYwLMF2omUyzCIPw03jxBEKOhoBpWh3JAifD/8yKGjSNJyh+KBmo6brvoTXTHkNsQQ/uTYELxBu1NoZv9uhx6Pnxd2S5s1DM1nQz4N/somJVFfXtWGIIJGDz9diAir9dkuO0GoSofcoMGx0C5EseBYa+z1aIRdus3M0OIcPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(4744005)(53546011)(4326008)(26005)(5660300002)(6512007)(6506007)(8676002)(66476007)(110136005)(83380400001)(66556008)(66946007)(8936002)(6486002)(2616005)(316002)(478600001)(82960400001)(38100700002)(36756003)(2906002)(86362001)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0QrOGRPZTZzNE9EQ043WWFCV1lKSTM4ZGlZUHF6YjhRWEQrQlJxcVgwM1dn?=
 =?utf-8?B?a3A0Snh5c0ZLZzZOR3IrelBLbVVTSk5VdVA1TUswRDNFNW9Ua3pxYlJ0RlNE?=
 =?utf-8?B?UUhIbnllZm54bzY1ZTk5UlZRdHRuTWZmeVkyR0lJY3Y1OEZxOUtTSjcyRG1a?=
 =?utf-8?B?elN5Yk5xUmN3L2ViWFQwbWJOaHRkNDVyUzVXSzlhKzNzOUJDUEVSSDlIQlFM?=
 =?utf-8?B?NHJWREJLZk94TlBjdzJsdnpkbkhhdUx4dTFOK0hVV2h0VUszT25rWXphc1lH?=
 =?utf-8?B?RWc5enBWZ0VaSmJqRDN0c09WOTA1ZEN1NVpkUGNhbWtwc0hmd1lQMldZYkR5?=
 =?utf-8?B?ckJURkZjRjVHMk5yN3pJWEhPT1BOM1dsMGRvRzNQdDVPb3hLVlN6UVI3NDBD?=
 =?utf-8?B?UWs5OWhxVWF3eVFvaGc3TVJkbTIrQVpjb0x2d1dYNHl4Wmk5K1hBd2lKcGEy?=
 =?utf-8?B?TWZZSnJLSzYxWEluWDd5YU44UXNQTWx3SHNRK2M5OTVUaUlwVDBSOEVQK3VK?=
 =?utf-8?B?ZVZCL1hvbHdmb1F5aVJhSGhaemw4TWoxWUdyTUdVeVgwVGpDT2orL3VNcyth?=
 =?utf-8?B?NlNVbU9oNVI0L0I1OUFwQittblFrWVpLditNekRpcGlvY0ZjNXFQSm1UajUx?=
 =?utf-8?B?MlEzY1JXZCthRzR0ODMyQ2pYVDZDbjBNYzdqVU0vWGt5V3c1a2VDS3U2QjRK?=
 =?utf-8?B?bzJVMURSbCtNdjdyWndNQUF6VFA2c3MveEt3SnJNYjVRem0vSUdySGRXYzJi?=
 =?utf-8?B?UWlDbzhqQUpVd0FUMWFHM0dGaHRlTWtDUG9hTWJmQmtKalhwZG82N1lyWHlL?=
 =?utf-8?B?U1QyeE1ENlBmcW1MWUV1b3dBSmJ1SWdqd09GSUpVL0ZvN2RPUFdlbC9NenN6?=
 =?utf-8?B?SE1Qb2JZTmFUMlFDbEtSd1ByRlZvTnRWMmtpV2p6aFppNE9ZaGlCcHEremYv?=
 =?utf-8?B?UDFHbmtvQlhHdkc1SzZJL1ErNjFhdUZNYmNjS2tsQjZHZWFVQnZYNGsvR2Vk?=
 =?utf-8?B?MTUwRmxOMHArd1BpcGlHNlJ4bGxzYm56dDdNNGthQzNQVnVMUGVXNEZzT2tI?=
 =?utf-8?B?aG8rN0xtZUl2L2lRLzdXSS83bGdwS2svWlljN2UxMTA4T1FmUVIxTUlKUlIx?=
 =?utf-8?B?VVpMWnI2ekpXZzJESjF0RFNNUXhHSHhzczNaWmExVTJuc2lKTzd1MVFZZDkv?=
 =?utf-8?B?aDlwaUp3MG1sc3NIbWJQc0pQVUNLTFhTNVhyKzAxdEwyUVBNT2J0VDNVZFdQ?=
 =?utf-8?B?M1VvWDZjMU9scXZZTHRNTWV5SXY3SFBsZkdQTVJncXZvbDdKSkdlSnFnYVl1?=
 =?utf-8?B?Tk5xS2xKbHpUL2NhMlVrQ1E4NWNJbWJvTHJoTExpemt2SjZ2VlVKSkZqVmZD?=
 =?utf-8?B?TnQ3NUJLSnRvK0x2Y1U2K0UyM2U3L200VHhvL3JuRXl1TVpNQitXeDJoR3Nh?=
 =?utf-8?B?aHBOWWRSUkdkcU9DaDVETkdLZGVrcThCRXZCeUNPSVl1ZjFKUk8vVjBTVzNZ?=
 =?utf-8?B?S0VFeDJNeDZoL2J0TVorUi84Uk5CRzBoU3RlVVUyd2F5bnllUnkyQnMzZlR4?=
 =?utf-8?B?cW05czhXdmV4Y0xjNzdxWENEOFc0UUpEUWtpSXBad2EyNCtLdjB6NWpLeGNk?=
 =?utf-8?B?UnRGRjVSa0lqTFVnaFk5K3NReE1jMVRPUzFkeGQwSkRwRUlqd3VraUpvbjl4?=
 =?utf-8?B?SzBFaHhMck5UT3B3Z0hFKzU0QWRVM0tNd0pQVC9DdWcrWFZGNU50TGRURm50?=
 =?utf-8?B?UkVReW5FbjRYbmNaUWtSdU5hL25RbkJlUnl5WVcrdzR3T0NoL3lXVVV3dWhP?=
 =?utf-8?B?TGZUTks4VWRHNEJVejdFMmxXRlQ2Y29TNGVpb0VyOGhvc0NUWGlORGZ2enpC?=
 =?utf-8?B?MGF2ZVpVcGRNVkxCNWQxVGtvcitKMVloUkcyM202RDdVdFlud25IOTFMbTRD?=
 =?utf-8?B?M09pNDlrb3hsNnEyWlZ2dWZyNkkvN1lmY0JhNjMvTS8wSHp5L09iaDNwTzQr?=
 =?utf-8?B?NFFtSXEyOGVpc2d4bW9qbnhQcE4zdHkzNzJSNXI5T0s2T0x1UWpPbkRTU2ZG?=
 =?utf-8?B?T2ExMzVuRVJES2FyZSsrVUJtT3hmcndpNFFhRW9nOUV3ZzF1cUdHQTBrNWhG?=
 =?utf-8?B?amNKUHhUUUlhTzVDNVdBQXVraG9JcmJsYlh4NDFSOHkyMjNmZHdNSEVGaWhC?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e48c0a3-2dde-4dfc-2ba0-08dc01b01904
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:05:02.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOnJFSeWNGwdGATIOxKeXKqlZw82xVZ/J9rf0moG5xJl337PdO5D6NqK5x0JEOZ9P/ljxvt/n4adhF/VkZc3ss1TnpGAvR7CN6w/9tuHvB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5448
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> The qca_spi driver create/stop the SPI kernel thread in case
> of netdev_open/close. This isn't optimal because there is no
> need for such an expensive operation.
> 
> So improve this by moving create/stop of the SPI kernel into
> the init/uninit ops. The open/close ops could just
> 'park/unpark' the SPI kernel thread.
> 

If I understand, this is also important because kthread_stop would
ultimately result in the task being destroyed and thus user space
configuration of the task (priority, pinning, etc) would be lost too.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

