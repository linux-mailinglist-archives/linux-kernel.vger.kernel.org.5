Return-Path: <linux-kernel+bounces-47393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7661844D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52961C229A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9793A8CB;
	Wed, 31 Jan 2024 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3xfiYsH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE03A264
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744840; cv=fail; b=PeAAIRDjti+9KaEa84zFV5txpI2/71ZaqV32cUeNvRITdfabGkxaURYNvuZeJivZmrhf9TQdOm+omuO6yssGhKYiBcb5tQJaMi2GeEsXSBrLG8U4w0PA7jlQDHN0woeUrrTq7sMSITo0m1GfYZMViy5SWJhxe4Hw0J/lxNrRDwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744840; c=relaxed/simple;
	bh=obe+LwSFzul5wr2qvWKIuKRGLdx4HkDapYnE4u/+Nfo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQsuz12xxeSncamZ2vHWnBXaQlYd1GKMGPf6dlbMnh+0r/cHN/8UDuRzHJMryy5fiHJfZnO82LknwFbCIintrbh4+QUYr1Pq3ckfS794fPJRHYE6zsJEt9B8Sd7ofbQvQrBK5TKjrDkuv2Xi1KzwN/ZAthHnJWBT4sUFz8ItoQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3xfiYsH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744839; x=1738280839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=obe+LwSFzul5wr2qvWKIuKRGLdx4HkDapYnE4u/+Nfo=;
  b=A3xfiYsH8vwppEMq+fmm3JFxMPRL4sDx1RTzOAjT79eqatsizXD6LTut
   FmPDJKr9pA6VLf/94syTVdcbqmR9p6eaRpaOjANFrMprqJKnsc1oQwnGj
   6yAJT1AeFMjIDLYJDuhwP6LsBO/HOipGoRB+ZuYAV1Bzl1l/EWZ2OoEnN
   +jtDK5wJ7rSmUJ0Ny/TVQLvAjSoDGS0Y+fskO+mugIfWcTUgxsWj0DhEt
   wBaZvMFAETFB5MsFAKKw7MTWxHoBtqMewIcX4RSMXS2n2h+919bADYYUG
   bcbx1ECyik2TtwdIo1cEIJEJSXRPO+p2C6TA/rCuXgP+HeFfaSlh8QqUr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25221964"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="25221964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="932010936"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="932010936"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 15:47:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 15:47:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 15:47:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 15:47:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElORtNn014EsmGNkJlmxvlD48gbeSOZ441l5yyrlGxYOiBVgi1n0IumNh/ZCqT2Cd+bVXRE2R9RJe0T91bKmsbb9jOvdo4IQQloISqVxOQOlJBtOyLRdE7rXi7eKMYA3FUf4AAkvT1/5a+67J/SXxLDFCTfLOBuzUQfKD2+kQxeapgovl9GSdXzyZK4AsXVxakq6MkqOXy59izaxEOhXqryjTDFQ6SYafrBYX3XOa6D7Mv0ZZoTuHq2bzR1wD/oKotU3cRVMPjw9MjUr35P8X1QuRZ6IB4QAklfE0a4ueMeVc2+CkVc74tVneO3Xn+/4Dfy8pho8uNTRYkAXLqCjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSotFAqf4BrAfgQwNVYn6H8bjR3bNBisPgdrtL8OcJ0=;
 b=WLwKtstHCYBs9OExd8Xo8BRwXvUMrj9a6kjTI5vKW+yHOziYqlgzMV9g3O96gNzv2h+Fx2cHV0Vh2FsAkpyyJkIB7tC1aVT6MRt4Jll/xNxVqoKQm8yJ4EGvUWtADL8vgXagl6HxzmmmEcXxo+l0c59EsozDPOQFFH1tN+hBiNfqvQRso1+yiN97sN9UzFySFE0lNpUkB9Kt2yGpNXzWuiMcmKFZ5WR3M+Voxk6iSG1pB+ZJAaY30J+/e1TkbGI1rIa9/rRlpBwtitbeUOzrFC8H9nXUc6+OvODxLRh0KTfwirhUKS3P/dyxJMU0a1wLLcmTU0lajyy+F06Jywh7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:47:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.035; Wed, 31 Jan 2024
 23:47:10 +0000
Message-ID: <2448f18f-2f3a-4158-89c4-91415bca9eb1@intel.com>
Date: Wed, 31 Jan 2024 15:47:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 14/30] x86/cpu/topology: Rework possible CPU management
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Arjan van de Ven <arjan@linux.intel.com>, "Huang
 Rui" <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>, Dimitri Sivanich
	<dimitri.sivanich@hpe.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, "Andy
 Shevchenko" <andy@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.343911720@linutronix.de>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240118123649.343911720@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f91369-4189-48c9-e7ce-08dc22b6f134
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3ALBBMWH04j36PGGJ572hlISToUvZosS0Nmbjuk00EzZk9gPQ0WL6DluS0CEPiyRtz3XlFs7T1bU4jyXNnfQjlDoMxmhlHzMthu1LYREEhs20RCeRRXunUcwqpcSBWOrVmmRm6/+nlfrCshX67xqR/Q+j2QNmpY+ksm7UkoRCY3qywxDVlOVXrCC2NUZvi6PsldRxSnm6rshwVzItVpaKGqYfY+drnrE8IHmJyc+ZK4wASGLGLgVCWenRL2nDov8C5DFowuzRrmej9+KViT4+yBsv22BKeb3BCkvjl2bhGZHfje1TSH/6I/Va4iU7VgFknsmsZBjNLVlnCd5qSo7+P+F2Ta67br/QH1ZalfW/X9310CiwqH7CcPeEGfsnGDjob7kt8HFUyMkM2AhtaDdN2N6cq5g4PE8DeCPOqdh7Xyp9zZmPVGVgX3A57iYbZEs6zQNKdJ+ZnrVlVMNSWBUFH5wkjhm73GOHBtYWGZWb2dgsmcAk+rNI7nl3u+ubdl6/7k+7jZi/X3sslKdNh2N3iakSn5oadMo5ZAf799jzAjGbu4UW2SvEX6Jvjy+zDHiC19VAMy4eU/VnnJ+TNWFvz7gXrS1XbiJkQzzH6DAStWMt15zDlJeYLAimuaiA+xcJk+3Tndtz419Knoy6GYzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2616005)(26005)(41300700001)(36756003)(82960400001)(316002)(54906003)(83380400001)(66476007)(478600001)(53546011)(6512007)(6506007)(6486002)(38100700002)(66556008)(66946007)(110136005)(31696002)(8936002)(4744005)(5660300002)(44832011)(86362001)(4326008)(8676002)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3Y5R0gvTG1Fb1RtVzl1WENSa3FKNDRqTHJMRUR3Rml2VTZiWEIyRUpmVjlo?=
 =?utf-8?B?aHJ5WHBLbnAvMy9xVEtRa2hmREpzdWt1NXpyTTZvb0pJeERWblFKRzFoejVo?=
 =?utf-8?B?M1pUNHV0WXFRNUZqZTU0L1pYMmlZRDU4dVdUL25xWTJkelNnWE1raTNibkdL?=
 =?utf-8?B?U3NPUzVhU0tLYk5DVll5K2JnMWkyNGcySHFGYkc4eGFTVE45aVEwUXFaMEsy?=
 =?utf-8?B?bWMyb3paWnZVaXpDbXA4Z0IwdFdBcnVlYTZESFNMRTUvOWhWWmdueGdTS0M1?=
 =?utf-8?B?QkJqNjVWdVpOMWl3VS9rN2hiMDRnS3dmWUx3d21sUlAvOUZ4c0NIR1hpMWF1?=
 =?utf-8?B?Y0hMbGxlWi9xQ3VSbVllcHMzdExmM2QrUHpTeGZZYUZFb3hBNDBCeENmN1NB?=
 =?utf-8?B?NitWUW8yTmhsek9UTUxPSWdBNFovRW1UbUY3WVJ1ekRNekNVRmd4U2ZBR1R5?=
 =?utf-8?B?Q1pIS1FvK0tndEtnOFpZRHJMVCswRGViNWhKaEhvQkRDT2YzRkx4SDg0ZTRJ?=
 =?utf-8?B?WEdvQlV1K0x3Yzg2V21kQnhsSisyclBkWGhoUTdFQ0xhM2JkNlRQUVN6OHNy?=
 =?utf-8?B?QTlOU0Y4MmFiZ0EyM3llOU90YnJtZnQ2UGx3Yk0xdGxDL09ocDFJY2tzZ2dz?=
 =?utf-8?B?WW5RUll0aTZmNHA5VHZKZktHcnk4TURiTTFYVUc0Z2p3QjlYV1EzWUI5ejJQ?=
 =?utf-8?B?Wnc2UytFelZyZXI3OFJlV3d2WjhNVldxLzRscm1peSt5enhwR0hUS0pZZ3Mw?=
 =?utf-8?B?cldSb3crZy9rdmhVdWJyRTNkQ0VlUDdNZ0lxL1cvWmszRjBieVp3NE5zb3Nu?=
 =?utf-8?B?RWdLeWZWVnoxMm5XcHliSWF4THN6Z3pHVEVXYlRKZ3VqeVVKc2pZNFUydjh3?=
 =?utf-8?B?ejhDbzBGcUg1dnpmSHpPbEFIS1ZlSlFlVGhUZ1pKNENNV05Qd1N5cHVwdW1k?=
 =?utf-8?B?M1hXTVJhcDJEdXRYS1pzcjRpcHhDeXFwbTlTb0Y0N1BnVFJBZlY0SFdrSHJL?=
 =?utf-8?B?aDZpUG1nckN0bFFlRFdXdGxhYTdjODF0UnVHOVNrbnJ5NnVsTUlvS1hEbWVv?=
 =?utf-8?B?TXRxL3RxNi96aGhUWjdwL0VYQ094M3R0bVhORE4yWXIvRWNrMStvejdXaXF2?=
 =?utf-8?B?Nmd3TmpyZTJ5OHB4L1FvNHVwZDluVFRwSFk5eWdtZ1h3cVVRU0tOVENvcUJR?=
 =?utf-8?B?ajNFcXZDU0lrK1FPc2JGWGp0T0tnREM0M3l3WVBKUWkxM2lxaFRZa01GdXVp?=
 =?utf-8?B?UG80VWI5aHJqUzc3RHg5RFkvQzdpRElXVzFibmQ2TFF2OHBBdDhqRDhtTDdN?=
 =?utf-8?B?VjlFOEZsWW9BUjdZNS85VUFGa2pQeEVQdjVYOXMvMytGTnZjQXBYSllFclRY?=
 =?utf-8?B?aldPRTdsOXFiWlFaREN4Y1FNR01wQjZpZHU3NFZRdmdpWnNtRFlVdkYrZzFk?=
 =?utf-8?B?d0Nyd3ZHMXUyLzZsZjJLWk40RWhGVjdvdVJSK2NzMVdvckVhbUIzRVFqMjRV?=
 =?utf-8?B?TlRKSDkzU0tXQm9qQ3pYRGFCWVdJd0J4YXRmbUxNQStVNktacXpTaGhSUGxF?=
 =?utf-8?B?NStOSEc1VDlGUEtVbVFwRkFBNjI0NmJSTjY5Wm5WeC8zTnNxcjd5VW53Z0JK?=
 =?utf-8?B?TGZVMDI4R0VMQjFBVFYzaGxLdCtYVDM1SkxHbUxVMTB3Yi9aNi8zOWswOW0v?=
 =?utf-8?B?YzE2YjArZDJVM2tSMHBmS2xsVCtaemQ3ZDVzZUk3b3J6Skd2VnB4WCtDY3dD?=
 =?utf-8?B?emhCZ2x2ZUsrbE11Q2FxU0ZwaTd2WmZKUFl2dENoTE1YTXI4QjdZYmlFWGFT?=
 =?utf-8?B?VjRpdDJyTXdpb2pWanIwb0ZjUXhXaVlQcGYzb0d6S0tSSlpUR3ZPTG1OSG9W?=
 =?utf-8?B?UkdIRTg5d3VZZm9NUGZ5RDZxTWJNNTVJUG9NNlBDdmhqM29YKzJ0NkQra0pa?=
 =?utf-8?B?Yk5JWnhlNFZacDdkc3Y0N3NiRHRlblZ0SnFBL0pHaHMrcjFRemM0WHh0dHlG?=
 =?utf-8?B?MkVYbjFrNVhydTBsVFZhSTA1aitzbTlaNlFYS0xpMGprcWROTm43cE5OTXNB?=
 =?utf-8?B?SGpLUzBKLzlUbm1aSUJXSFlzR05FeUFJWWNFT1RKLzI5NE1VWjliUHJMMnI3?=
 =?utf-8?Q?d+mc0XoDmyqP4jTh/h0n+9UKw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f91369-4189-48c9-e7ce-08dc22b6f134
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:47:10.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyVYjvjVAwxNCPTSdQLQ1I4OzNEW7nJmmU2TnLa37SFvuypegAJlbcuD8HbILgZD9Pa7UptoARpOcrpw8GnwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com

On 1/23/2024 5:11 AM, Thomas Gleixner wrote:

> +	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
> +	if (topo_info.nr_rejected_cpus)
> +		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
> +

I encountered the same issue that Micheal mentions in the other thread.
This is how the messages show up in a 40-cpu system with:

nr_cpus=2 (correct)
-------------------
CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
CPU topo: Rejected CPUs 38

nr_cpus=1 (incorrect)
---------------------
CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
CPU topo: Rejected CPUs 40

Sohil

