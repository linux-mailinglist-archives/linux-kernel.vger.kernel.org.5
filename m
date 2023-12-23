Return-Path: <linux-kernel+bounces-10510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0781D543
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3822829F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2EF125C7;
	Sat, 23 Dec 2023 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbHQG73d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972810961;
	Sat, 23 Dec 2023 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703352540; x=1734888540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b9wXS8JUslhYIXGX2PgNncdH4z5//WhbZkMMi34ZMrI=;
  b=IbHQG73di9SUjmjivTQoVTMxH9aFORiavlfaQ2OTnHxGiqPic1OFcqnK
   4R4gExLKzw+Hpm3u3JMh7KwE8856PUo7IoCHS/co+Ugg61IWXiD6xdBif
   YZ/12S25/SskSnN/aMMVGckjoPkBnEtLOBJ6a+aefnfLPpT0OP4Zv0GE+
   iYAcS7gmLHLVYxHGIqYTpkDYoib+4SeoSQEkbpkXYEloMo/hFM8j9Tjaw
   Py33bLn5zrxjF57psmrydt00DivP4afIymOCwnwjekZdJzlGKv/jIoP4S
   4gMwrIkijvWiX7Rquh7q+9g4IMDlOBPHTvO9LHsxZ75Rg3MvJqvo97BdS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="9704251"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="9704251"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 09:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="25669466"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2023 09:28:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Dec 2023 09:28:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Dec 2023 09:28:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 23 Dec 2023 09:28:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Dec 2023 09:28:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt+epn/bGCmWjmk/KwVNNqObfrOyolWovPYIj/mkoPqwbwwUSEpmHEmltDX2DxH6F6wVbIDX6LJhg4d0aqVJWFFD0wEVFlLsZPTCX8cVOn6IzdOCx4m69gA3ImeIzsbag5GHWnXYCsFZJBjMTpxpic7NnQdcJuUfns6dBfflxmsRcpFsg5Y//BEEwbtw4OifxozcGY7XOw/a6+r1mJOC7natw9tlro4t9OY45h4+3NyzOVOrut4oxeVOf4KawMHe0BtZFOgDNxpeC+1hqr/Q51xqdr5GGlOuX+MkV2ceRF6vOogk4XOYYCcx1llMHu+bS3XIl6+WGrPi70olyE56ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THnyXxa8ewesAJ2sVkyNHpYzHijqyeEymP7vsF1LSSQ=;
 b=A3OqB7w511hlzVqOyzZ/ytNB0PN3b038ewC103lcCs7rsrfcBPkIyVKKfKGPCTzg53kuZfCsO6FREd5jQEW7MwBDWwXVKNX36MQfUBj3XJzMEsyTrzVCk9VoPC4qJAZWg1a+QnrVPS/EGNEHoDlFS2adc16CaABK5mCdYe38qaObBCpWBICJpUFAhjUUFrAlyQkbvnf3MGWhVjqrPQSU3Q7Mx/X73TCNqJorEmxwkh0qrH/dCYwpN0JUjwaE2DSYK03uwpkM8amk0QXQlgWe/LHsDbnEsOnLVGv8EIT1Y1/3HZIsennJke3gXAuPZ5kCtsLy9auRyL4ekdxyPUE4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sat, 23 Dec
 2023 17:28:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.023; Sat, 23 Dec 2023
 17:28:52 +0000
Date: Sat, 23 Dec 2023 09:28:48 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: <linan666@huaweicloud.com>, <axboe@kernel.dk>, <geliang.tang@suse.com>,
	<xni@redhat.com>, <colyli@suse.de>
CC: <ira.weiny@intel.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linan666@huaweicloud.com>,
	<yukuai3@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [PATCH 0/4] badblocks: bugfix and cleanup of _badblocks_check()
Message-ID: <658718d0b8b8d_c613d2948f@iweiny-mobl.notmuch>
References: <20231223063728.3229446-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231223063728.3229446-1-linan666@huaweicloud.com>
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa2c29e-be4d-4019-fc09-08dc03dca18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MI5G+0EzMIt9wiExE5ZCJ+IKnbCoIvUZk7G7ZH5QkCw8Yb2i6/pb+f5x4d7W1JrJSxnablM1ONAVOYeFau4RaydMAC9GwkVFG32Io1BEjwZ4DF/urHf76GjlNTRK1ApUBH6YQVNVEv3ccvXO9iUGYlJ00nGGBj5xXe1KvdMpAC0Jf5LVu5XO/t/03pQNNVvf6nbw/Mnrw1my/nxzvMjkVS9T7+pOQky3Q3pDQd2lDgWyRYx7B1ich9x+tMnhzDyrvJ95+ZiUlR8LUYJZa/wwHmWtVCZdrWHHGhxlpOlHL4b795ugJiU8JOyUEl2gIsJvEweRjfyJJ0iy8QrwlPBOh0JVVuXFcAf4yleHAMuCkItWLgHgNIdYeFL49QCZ7Rp7dE8aTpYnGHKEqRdyAH1yU8Qy0cgYwbR4oKiC94uZbXssDYHNhUPBnh/c/KbpPhIngLSKCCrOWeVlSivh6ks5Y6c5+wKrIQcnGQFSDTJbclvVYIJ92yhBvGp3aJaksUzw3J7NKUIREpHbeo58JeeH47fdDNW2+CIuZTry2+12HtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82960400001)(38100700002)(41300700001)(83380400001)(66946007)(66556008)(66476007)(316002)(4326008)(8676002)(8936002)(44832011)(5660300002)(4744005)(6486002)(7416002)(86362001)(6506007)(6512007)(9686003)(6666004)(26005)(966005)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bck9woET8FqnfN7sgfi8fBhPFjBf2cUMzK5chjJeWxGlDB5RY6VTZu1x/A/E?=
 =?us-ascii?Q?BloFtxR5qrzS9MQZXW5Umzx2Pfk2LGX+W8O8H0flfWvve/pynuPZC/x7evtU?=
 =?us-ascii?Q?VIDpxssXEUYK5UVnoppRTP1DVdSRMwwPDHGDwPFFUX5BXVTEo5ojsi8s0yVu?=
 =?us-ascii?Q?xC7U0yT5zejkYkKyaLBhWcxkusnScxfXUADBMGfQHsLGEw01kDOYQinsxBkM?=
 =?us-ascii?Q?AOptHJGc44AYyxC8RfsEPmwpc1k0t/7bHFxxjtHYVmz944kOd768BeeYDX+e?=
 =?us-ascii?Q?WNACbnsc28w3MZb8A/H4JSyTwv9Bq0qCqz0RwSkRb+qXlw5t1IyzT5xM/0Ua?=
 =?us-ascii?Q?l52HYzbxW9baMCnWnPmLNvY+AwA96yZJAzodSy3J3kkpat7i6xmBB7FkTQvN?=
 =?us-ascii?Q?yrY9T1AekUEwialJAf3VIK+7PoG5e/+aAc+ilzqak1k1nrXUDUITxFkJRnsM?=
 =?us-ascii?Q?7AMQKoYoAzbSCUBt2zOpMzQULpEo7NwiuxPwwnmWDwGp6Ic0KrxGn0+og80v?=
 =?us-ascii?Q?coljNG14RVCJFRmzQtQIbMMkqF2RzfiLT1sAJy6hzql29xzJOKtFBshvUWu0?=
 =?us-ascii?Q?0cuOck+sInhMf35y/toNJO/i7WZi+w6zggZk45ZGJm9eJR8WX9J4DHLIn0zs?=
 =?us-ascii?Q?JDZ4zecMkV99+33b7QhfbXaMk7AvSGyZzY4LW81l7Nfoj2YCXHukzCmUPdX1?=
 =?us-ascii?Q?XTmN6iLMq9lYOlHtUNie57yfXkPT80/0U7rx1aPYqkwNH9BcVCtGU2xaC9/u?=
 =?us-ascii?Q?rVDY2359vDko35DCqhnyUV9Zqn7gN5U3rFvJS0zhSbwE77C365Xb3NPSzLQb?=
 =?us-ascii?Q?gA4qY8zRn0V+v+kvpUoWi+cRmWPmgyhV/80z0sUfaVXMav+jRuEQgZ8x2wAv?=
 =?us-ascii?Q?ZaFEJaK+GdGzjIuIM//FSFARvteYakPyIApRuVyL9vjg4LVZjPr+9kVq55G7?=
 =?us-ascii?Q?gt+39xWayEFp1IXFUV8HoN+D9kil1io4tESxyTcTiSMuzPoPcFvY4T1Fgq2o?=
 =?us-ascii?Q?yBryTX7+wKolwReo1XihE3m6ZUmcPXQcCXgkB7UolGzfFK1tPyL73xuc+rT4?=
 =?us-ascii?Q?9srQiz7UPHbHoefhPoEI5Oc3Ze/Kx2a+PuQGHfXqiFPOGuCItwvIqCZPHbmI?=
 =?us-ascii?Q?tpX6grLaXBYrGm/J1houyWOZX6T395A/T+Y3Vvf9sdBzYd7qDwG6YTKmCkSx?=
 =?us-ascii?Q?F0FcQyvu3voga6dBIT62c61n3qwVdk+nNOmEE+V5nTzH97TT4s/gAJdLom7H?=
 =?us-ascii?Q?45U7t+U6M44aUHIZK7wtP7PVHRqo1I1nQi+Ice6k3T3uAKHblL/u96K+ZXay?=
 =?us-ascii?Q?M8OHLW7FcfzvX/Bi8h8N0i/piP/LCTqITw6UXe/aJQqRgAk8J4QBJmhJHgqv?=
 =?us-ascii?Q?kWQidQ8tpMXdRmStSmuqWRsuDgt9tZYMzXWwPurrVBrWRXViR1vZt5dZOwK4?=
 =?us-ascii?Q?m6wcfLP6cLvnvwzOonTL+HXSKxb1ID1djRoTeHT43qix2W6GvSj/bFmthmiJ?=
 =?us-ascii?Q?NPsIvUw4NXRbp8Cnueb5JgfEM67RIXYUAN2LNt7ECDJM2zoL+1bZeG7YjhDd?=
 =?us-ascii?Q?WxhNik+RvFHj6KZS6MZY+lNSTpFO0yDiokG/C8Vl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa2c29e-be4d-4019-fc09-08dc03dca18a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 17:28:52.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/IQ9L0dPj/Lj/Gv663cTNZ50FXdPiEoNRCg6j1yTLtqaLhHzuGU40uKZj3VVUvePeYdX5qbTnKY4cuYFS0BrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

linan666@ wrote:
> From: Li Nan <linan122@huawei.com>
> 
> Li Nan (4):
>   badblocks: goto out if find any unacked badblocks in
>     _badblocks_check()
>   badblocks: optimize _badblocks_check()
>   badblocks: fix slab-out-of-bounds in _badblocks_check()
>   badblocks: clean up prev_badblocks()
> 
>  block/badblocks.c | 48 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> -- 
> 2.39.2
> 

Thanks for the series!  Unfortunately I'm still seeing some failures with
this series.

Coly's test patch[1] fixed all my test failures.  Right off the top I'm
not seeing what you missed that he seemed to catch.

Ira

[1] https://lore.kernel.org/all/nhza4xsnbmcmka7463jxgmdvb27pqvbvcuzs7xp4vzpqlo262d@dp7laevqtaka/

