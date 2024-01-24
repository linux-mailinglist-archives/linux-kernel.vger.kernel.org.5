Return-Path: <linux-kernel+bounces-37737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006883B49E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6361F24387
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1F5135A42;
	Wed, 24 Jan 2024 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2RqPf3F"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDA135A41
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135117; cv=fail; b=OYOoupaBzFjPSdt6eVx63msq99RgDk+gPiFAKsVtuX5CYlsczIuu/W3RZldGBobC4bGOys5BNkzJ/lyJRBLoMynk5R1rsmPr2asThmYaVtDDcNfzqa/ffT0x48u9m4r+OIBTT46MzEOt55BFI5+xDVdIvazOmlMgmYfUmAU9etk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135117; c=relaxed/simple;
	bh=pmELbBwifsa1IxbfpM3rHy4ocSUEtbppbsaDPpGMgwI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZpYDHse0y+b/+9bFEbWkMFTO4wqEWgi72H2EWo12IUSbzpLZnm7Hm2aj1ohKVHtILrsGnF2Kqt0uQ5sWvFQw0VmaruDzys4/3pfxHJYRDKoA25lEKRm8ZxOvsQiX3IsOrMDbUN8866AmH3zjLsjtUkdfYeplpLlWLYrO+83NtqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2RqPf3F; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706135115; x=1737671115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pmELbBwifsa1IxbfpM3rHy4ocSUEtbppbsaDPpGMgwI=;
  b=g2RqPf3FKvsK0pHr5q9CCfEkvdx5lIFusRZ8eDr1FENtCeL0adndQc2l
   OZIQJ9oeCl/Jdw0Ix7S78q20s31OnyfOOt6obtcHlT0UOIPIYhgOTWL/s
   sYYCQEZEzyJV+SJX0uZYRiADrY2KdW0fqucNwocVE7MrE9LGAEVMB7Epy
   UpUZR/DKbjgiEoimF1U4ZtIkidSyGGB3BgzZUhElvQftnNQoIFXeBRrQc
   +K6sBxuCqf5bR78C7wE5IIP6E+lHWk+rICswGUFzw2fL2KHkNs/6hfbvB
   F7ekPRtsX7zWu+ukfmZ0ejw/tCeNsYGgYWNNOSfjYBy6hI3suVDRRc2uk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405738809"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405738809"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 14:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909797852"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909797852"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 14:25:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 14:25:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 14:25:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 14:25:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 14:25:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfOYjxicE81mwRs5xrbVlMQmOoOQz1dghhIoyOdRK5RYpZLd33wewCCi1vaJIpp0Ba/25xQjeOgaZoqIF23MZi4tkPTDwJqUnmKbYzISiMH4BWzQg7OrXRfpEYcAZGLXnmFftW8FpuVbwmx7+8m08FpCZZr2H1dmk4QyZO117oefoJYF83MSZQvPE1/5qEzd5BxGXLXwqnmccr06cmZ6js7wSEXp3fjz+jy/z6M/k7q2jrVYJniOTRlxXowSkhQVZC+wxjFnc58uiFC7zUdwy9Hy+GGhmmUYBMpIcFyPyajB2OaCcTOX1O5b2A0GbL4l3CZEZW8BcyCTBM0dWPi7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIeXX0s7AM7/PbGi/Dj/8WDOdbAO5ZaxRQIYSSAmC3Y=;
 b=SQ9Mn6VVI2tYL+TBRXJKJMy8hiF4YPzt6hd6RahYgEyKFNZbRan4C616YLWjVxRz8UaPsz+uI/mEgYZBAw52iXhIwaSaE2A94mK6EozOp8ad7i4L2Z8s3N9K2G7cuYGloAvo+VO4EImFv5N2xpQTli8OCp8Hsg6p5Afe2+lwN5EPxwV1BfYYWDUBa41htgJm4IoDzNfo7Rgi36ULWj9GIFAjLP88YzEfRrzXEsNKtjn5M6eA9lrrPBygPyzNKagufH2APRvWLF7RdMiGBUrWHizG8DctdqgL7Beatm3IDImZhwBpj2APvovO8DAmhPyP3p0mP/gW7/CHpYxs6PgJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 22:25:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 22:25:10 +0000
Message-ID: <8abb0237-90e3-484e-a549-d74f540d4045@intel.com>
Date: Wed, 24 Jan 2024 14:25:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/resctrl: Display cache occupancy of busy RMIDs
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, James Morse
	<james.morse@arm.com>
References: <20240123092024.1271882-3-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240123092024.1271882-3-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8433d117-999c-460f-9243-08dc1d2b5372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1HWUOWwpv2yP+NZTVA8VUPcJQYoCPV1N1JhiZZULu9mjfbZj9swY0ZHQ2Si4S91uB44P9DeQpML5rQcj90YJgA37qL6n28WKPIktPT2Xd+K9InXa9nfd50R3LldMd5wu7+zFRkxx/NW7fFp4BGi5EQohP7a30k02xUORlBKULy9dpzQccZsFX9LdKvyAG4VnIO98TtjQTlWpECiNvWOgB/jfuOKINbHG7KHpy/bZYpeN1mUAg7PtVE5Y+ewhItvaeW4PvIxHn0mRh42+vW379q9dXa7HeRRUkd9eVSWR6JYcl+d5GdJcXtWqVbXzO6ANscjdbPHXCxgXqPlhk08I26IfiEWKhHXQgw/b3IK6JZtsiX7cgOZ5EbCBFCOz1/mX3yDgkatobqJBYEeZVtv4HeQJ9J1HAcaiS05I9P5SOwPfXJ+389OmMLFJeJ1KVNgr3Mb2/XDN3Wwd9y1q+rQXGEB88zjwNYNCxSWTcouqIPHExDgdRx5e4amh9fzeVf64duKAciHbYXuJhhijT0Mqf4l3NQYLDGmuv1qWbuMFIg6N8qXqNrI68IBSMP/umh/iK/MJS/3uQzr1toLPhHTBCZeoE1yakd8IeXa1zyBKOJfDjmYue0ZAtFI3zzrurTBAUPN/Fz3QKKPaIV6NOC8OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(83380400001)(6512007)(2616005)(6506007)(6486002)(8676002)(316002)(44832011)(8936002)(5660300002)(966005)(26005)(6916009)(66556008)(66476007)(478600001)(66946007)(4326008)(53546011)(86362001)(82960400001)(31696002)(36756003)(38100700002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdYUXdhazZLM3RmZllCZk1VNXB4dU5KOEdYVGZ3NkRJeGFVQ0VUUlBHTTkr?=
 =?utf-8?B?SnE5TDhxRkR2OUtIL3NtOWhTb0d1R1ZRYVlLNktBOURQRWxoK2ZCdlV2Mkw1?=
 =?utf-8?B?RFMxZ0hsRk9YSXVEVWJqbExjdUorNjljVk1NeEdJRVJpVi9HVFY3QmVqa0Vq?=
 =?utf-8?B?WDdJWUFKR2pmemUxajNMSlFFNjF0a2hHSEN0MG5GQmRuTzVPb29nQXk0WkNG?=
 =?utf-8?B?YmpOMVNTdG1HbGw3SkVzd0NRcmFZUTVqeGozWlZyMm1rZDc1OXAyNjFhN2tF?=
 =?utf-8?B?VVo3WlJxN24xNVJrazhoUmlJclh4dDlOcnRyN3ZvdTl0b3p0cG9kbXo1bUJl?=
 =?utf-8?B?QmhiVU5nSzZPT2VHVURjczBRdHFaWEFqMlYvNE82MEcvbUlIeHdlKzFuRHdV?=
 =?utf-8?B?d1BuRURVTFduNVF3b2RsbVlVV2VUL1dmd1hCRFFsTmFPd3JLalBuK1ZWSTg1?=
 =?utf-8?B?dzJYUFJJZDJnbEVnRkJPdDUvV2txWkxBcjBodUQ5QUE4RTlRT2ZYSDVCWEc2?=
 =?utf-8?B?Vkh1Q256U0VaU25wYkgyeXFKQnVmYnpCaXNjZHZLSkovbTF2Q3BWMHJ0VEhm?=
 =?utf-8?B?bUhZckZMZFBBSjJkZDk4aVJxUi9LRVVtWFI2MmdWRitnYTJkNDdPUXJNOUps?=
 =?utf-8?B?QnFFOWlrMkdleUhuNnpGUEU0dml4VEY0UlV3KzRxNUZoUWNzTWhUMWZsMkJV?=
 =?utf-8?B?b2ZtQURLL1VrM3d4dVNoVWNQRmp6cHR3Y1kvNlRRNEhkeElqZ0Y4aW5Ud3My?=
 =?utf-8?B?cVdKL01DVzdJNHNaVHE1am5LR0U2YzlCVEg1aVFxbC9Ub25yc1kxM3M4dVhl?=
 =?utf-8?B?S0dOWDhwZnFSSzJkQXVsbkpkMWQ0VnkwVWgyVnFvQ0tBN3NuL1B4RGZJM3l1?=
 =?utf-8?B?dmtRRld4cm9reHgrUnB1Y1hiVGVMN1hQMDA2ZVpzclBqekxSQnJTMTJ5amdn?=
 =?utf-8?B?R0NKYzluYUxpVENXV1lURnZhMmR3NTNva3hRZGI2dmF1QTJHLzdaV3hDSTdo?=
 =?utf-8?B?dFhlUSsxUk84UWcrRjJZNUpMMFFPbXNvc0RvUXJWaHlHaWppY0tmL2l3U1E1?=
 =?utf-8?B?RkhVYlpRNlpzMzdLcmxPRVBETVBxa3F0dHZoNUZ0Wk1IQnV2dnRNZDRFekdm?=
 =?utf-8?B?QzR1SnBGWHluS0hYcUtSdHpYYmJpTWRQcEhrMnZuWGwxUmhRR1VNM1hOaUVu?=
 =?utf-8?B?dUcxaWNLZkNYM0E3cXE0dDdwUmxjNmpwckliREQ1UWdmZlovSERJRlBSRTlD?=
 =?utf-8?B?cGQxWWZ3c0wrNm9CZnFDWVg5clAvZm85UkYxbXphaFJiNGpIYlI3VGwwUldL?=
 =?utf-8?B?ZzY3MzJqVHlKNWtxaE83cWtHbGRySUVTUWdlc1lDejZhOGNBa0t0WHJXejNi?=
 =?utf-8?B?Q0d4elpVQ3NXdkd2QjBLNHVPWFQvR2dSUkM5OHVqcGpXd1ZWeTdTZnYvQjMy?=
 =?utf-8?B?WVpoaHVhdEJaa3RxTTIvR0Q0MkZvTUlLZlYzUEVqNWVCaUZrdUQ0N0RNWlJS?=
 =?utf-8?B?eHFWdFkyd2hNeWFBeTNadjRWYWxYRVd4OGRORzhkUHgybGNReGlpUzdzUUJ0?=
 =?utf-8?B?RWRtMldnOE56RFk0ZzZpem1rdFNEU0oyVjNNZGw3dkRyQXM0THNRVVFENExw?=
 =?utf-8?B?cjEvNnJTc0xNWFBHWitHYmlRbzcxRzBpek9VWmR0c1JYSCthZ3g5M3Q0SkR6?=
 =?utf-8?B?OEJ1WHkxd1EyZWE4aHltOFFmdHZVR3AvR1ZVVUxLWEhrelU5WS9oYmhxTWI3?=
 =?utf-8?B?TVpaK2lqbEk3SytBeldGY0FWWWMyWXg0UE1wM0cyMWEwS0w1WWJISFl5dWZi?=
 =?utf-8?B?bncxV3FhdndjZ0xmOE9QeFN4MzFFd0d3ZlljUHdsdERTdFF5RUlrQ20zU2Rl?=
 =?utf-8?B?cjRlejNORzdzQnZwLzRtTUQ2YzN1QVBCUVNvcTR0K1BSc3BMV0dYVnpxWGxY?=
 =?utf-8?B?eFBFVXdFTExNbG1qb2oyS1RYeWEyMUpVZzNraVhYZXpZZzlFRjlnUnhIeHJk?=
 =?utf-8?B?WEwwck92eFE3QVBXaUVxZFoydHc1bGtkVWFzNEd1Q0h0RnR1aGM0dE9sTkxu?=
 =?utf-8?B?ek9oWnRndFRuSzRsbGIrdldIdVUwc0tPUk1ERVlsUnhmWjVKZXNkdnNqZDBZ?=
 =?utf-8?B?MVE1bkVmUzRzMlVTMUUxOEpxaitzWVZxWEw0Nkxyak5zTWx1blRpVnlTUTYz?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8433d117-999c-460f-9243-08dc1d2b5372
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:25:10.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIr3JNDTdy+1u5bq0g3QsApFYILNRAg/XgIgn28oZFVmvox81FrBv6WeLMp9fTEe71wcKiDRZX3MK4BKo4fdSqHqNh7vpaEc3nGntCt03dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com

(+James)

Hi Haifeng,

On 1/23/2024 1:20 AM, Haifeng Xu wrote:
> If llc_occupany is enabled, the RMID may not be freed immediately unless
> its llc_occupany is less than the resctrl_rmid_realloc_threshold.
> 
> In our production environment, those unused RMIDs get stuck in the limbo
> list forever because their llc_occupancy are larger than the threshold.
> After turning it up , we can successfully free unused RMIDs and create
> new monitor groups. In order to accquire the llc_occupancy of RMIDs in
> each rdt domain, we use perf tool to track and filter the log manually.
> 
> It's not efficient enough. Therefore, we can add a RFTYPE_TOP_INFO file
> 'busy_rmids_info' that tells users the llc_occupancy of busy RMIDs. It
> can also help to guide users how much the resctrl_rmid_realloc_threshold
> should be.

I am addressing both patch 2/3 and patch 3/3 here.

First, please note that resctrl is obtaining support for Arm's Memory 
System Resource Partitioning and Monitoring (MPAM) and MPAM's monitoring
is done with a monitoring group that is dependent on the control group,
not independent as Intel and AMD. Please see [1] for more details.

resctrl is the generic interface that will be used to interact with RDT
on Intel, PQoS on AMD, and also MPAM on Arm. We thus need to ensure that
the interface is appropriate for all. Specifically, for Arm there is
no global "free RMID list", on Arm the free RMIDs (PMG in Arm language,
but rmid is the term that made it into resctrl) are per control group.

Second, this addition seems to be purely a debugging aid. I thus don't see
this as something that users may want/need all the time, yet when users do
want/need it, accurate data is preferred. To that end, the limbo
code already walks the busy list once per second. What if there is a
new tracepoint within the limbo code that shares the exact data used during
limbo list management? From what I can tell, this data, combined with the
per-monitor-group "mon_hw_id", should give user space sufficient data to
debug the scenarios mentioned in these patches.

I did add James to this discussion to make him aware of your requirements.
Please do include him in future submissions.

Reinette

[1] https://lore.kernel.org/all/20231215174343.13872-1-james.morse@arm.com/

