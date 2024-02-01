Return-Path: <linux-kernel+bounces-48945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09273846373
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF11C22AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A483FB37;
	Thu,  1 Feb 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL6+qfpj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB4405DB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826725; cv=fail; b=L2iMpFhzRuPGrJsB52iY7hn3BbAbJ3felJ5typCB6Da9FBgqfggPadLbmPO20fcdUeOV+N6Nhv5Guy5OnYAcSaxn5RaFOzw21iRBjH56WXM3aPagbqaNHAxW00RE45u4NR7TncsVGJBtlzh9UW0Ygc6WzXt/nOLbyLtjSwG0/Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826725; c=relaxed/simple;
	bh=sE4ZSpJzu3kTt5XpOc9g1m1GfPUSpduInwdG8KbLJeA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=suHcRZzzBLF2F8BRAnRKv0u4y+27icPqXzzJeqdD/8XlAp1N6LQ4+qxRHNzaYh90hPmTjusgt12SFsu6aNClEJILBVUlKcsXydyJ3a8j4taG9yPayyTm3S5FJEELxFZR5na9fRsNLtDncZimMrT1RqDfc6Jv+2gNQp9XtV1knQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL6+qfpj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706826724; x=1738362724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sE4ZSpJzu3kTt5XpOc9g1m1GfPUSpduInwdG8KbLJeA=;
  b=RL6+qfpjth4IlQMC4yRF4NlwURjpV/UStjgJ9JiXcDeu7/Vdo8RrQTii
   Tn9qYS5z87c6e8wm50jHDJuJbWqBZK11zE5nNrmfVNIP+DcwmV4bidUDS
   IYnegk5/xFxnqozAqa/dA1oAGdQZOfSNXY6gA5CwlqCruk21uOLIjTqSV
   xOvgq0zEnVBKrgfiEaMQsFq42BwU0TUkzcyUBdOBbo/g2+Aib0yKdurGR
   vyR6XmwtGr9lvqR0wxajqyf7JKq3OzlRPYGp/IX0stVLM05Pxs0W14/4y
   U0m/rbelMlZTiFC0XJNM8J4zHeo7bf1lf9Uie+3VspyxdQ+LsBb6xMdam
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="210132"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="210132"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 14:31:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="216505"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 14:31:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:31:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:31:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 14:31:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 14:31:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcRlf/a5p+hQEvLm02OUPrWKvrl2jCqCOZGisCdOuCfcn+kpN70ZP4VHUikNyyYumxBftBaMMatDHep8ieMVXHJGHXb9yAS1AiOQhpEAPswSBmx1ykXM3QBuMVkMKglXfFpOljd/DVUfPFtNfiri2poF89QxwCMhy+712w7Sx/2C7BEphL+KabVLrDH1pNypjnALX6fq5bJecQ2CjHpXoxHU9pHNuWTRUStJrMl7x/1V1ssoTbUZJO2nspNL6AdkVgrWTI98JcXO2Ex7l4sE7I7djNeLEHT0dgjaLe8rLXHjFCmo+u7sjv9nk2TsGWSY2qUSGXMFndJ3j35UgiLczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lT72NiGK5cKKkRNJHnDqkwMZNfcJEQAmhnrsN20Qn4=;
 b=QQ5iwMGvY4MoGZSE6Ut+sG3xdhJfvLI6xsMO/Myj7Fs5GMNKznMO862TZROyRgDTviiaqlnPZp7XdURrXyYZXGVOrLyMUUTZuPYed54xpYF1C1F8EJCKOs+AtfoxN/cwjBrtdxrwJK0KAi3OJvTo77O327IQNkRK95QRX/OBRH5dTC2hie0yQ10XCyfyNvLtMVk1HvFatrx6n5RTXa9fwTeKyZekS34XREPMRWs3/wn+CdHJ9Sz6g4q06Pl6rfIkTz4lNiXrIxpNoo5B5i9vhNOaAK/VHaaFxPajfibuqzDjTXhMnwWhma4HVdpAGmIJi5RnrZwF+UjuAdi4OmM8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 1 Feb
 2024 22:31:23 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.035; Thu, 1 Feb 2024
 22:31:23 +0000
Message-ID: <15d8e520-c129-4b09-9a25-ecee5da36ca6@intel.com>
Date: Thu, 1 Feb 2024 14:31:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 25/30] x86/cpu/topology: Use topology logical mapping
 mechanism
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
 <20240118123649.971809766@linutronix.de>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240118123649.971809766@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 21470e2c-1a0e-4abf-5ab8-08dc23758552
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qGJqFdKHHmQTuwz6tREjFw4eMumm+zz8PT5dgpZpwTUAmAAz+UdA6w9JfYi0dM6+r7sbHBTCBv20/50Wjw40E7EjTbG/xg1Rq6ilLDmnrcM87eWDYvPpo9nFpFsPR3WuqjReRJYVwy/4LmuEyRCgm/BS/wbN+zhBnpBmm5tQWngdgFOX/GGtxaOSQ6Y09+grsO+CzLv3jIlbUDPgjnKF6XtSUjak3fxHbEXTKc1+J0yOUnsxCXT0HIJBmb3cEwylubuvYdQXVvqO3tjfpN+/WL3GGBUUjdwchxEuh6iqxRRyZuK+bJRLooR9HQu8m92yRSdIKdXsefPq6aK3zAzCnaC5OfOyKVFyJ/X4trhPJ/WPt84UkRulbjlmstkA2ofvac33g5wEhs5RNKLIo/4NYc6oNpMGSPoxzn3DYoJoRl5MpjJoL9Pb+ULHBGeh6Qz0zv2DunxAxcBjvYhBzf5TC+nMp5EYRa1JHROUPjrmszO1CUJjexV5I/qZL6JrxVOnCUJQ2phcPYz1gduDBUtbmeHYAHagmZD5GzbixgmO6vY1uiIUyOxzSQwhlelWXKru7F+TtUNNk55PeJGI0gZx5pM6yIr2isBegPbT5TnYSks3sL7JGRZAUfUYzB4JkWvgMVcGZpzjt1Kunc48MgcPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(478600001)(54906003)(66556008)(26005)(2906002)(8936002)(316002)(44832011)(66946007)(66476007)(8676002)(53546011)(4744005)(110136005)(6506007)(7416002)(2616005)(5660300002)(4326008)(38100700002)(6512007)(36756003)(41300700001)(86362001)(82960400001)(31696002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJuTkFlQkhhYmd0Z3Znem52VlB3MkRDZzRoWUZick9PSzdjTmxRTWQ3MUJG?=
 =?utf-8?B?R0EzOWJTU0hrK1lKcUxHTWd5WDBOQjAxTFgwTC9KZFBLanRteTB6Z1JtU3Jx?=
 =?utf-8?B?WmZlV0Y2OUJRNTBRVFNtZytSTkMvNmlRaUZsT3FrcHFkZ1oxdWhJazFnYU40?=
 =?utf-8?B?WXdndjhRZHJDLysyaVNpazZENnJhQUhCZmVEODlvRElhV1A3cG9rdDE3ZUpQ?=
 =?utf-8?B?YXJLYzYvWlhyUXoxbW9xUlJQTHBIK1pTNGdPYUpZSFN0ckxnTGFIYTFGY3k5?=
 =?utf-8?B?eHN5TWhHSFBvMUpDaG9uN1ZYK3VDajhjdFc3d3ZMZEwrL1daZUpiSUVXcE5Y?=
 =?utf-8?B?cWUyY21pNXAwYW9HU1NMUUM5WEVJRURITjlDQXpJaUtzR2RUOW43TkM3aktL?=
 =?utf-8?B?UEpuVnhFRmdVYTh3eGNOU3VVcGZrOHcrMVJNK2FPaVlKNytncG45eFJrWkhl?=
 =?utf-8?B?OHVzSXNGaDN5REplYnVZNHJaS1NNRTg0SVRWVlZsM3YydzVhVkE1ZTFhVUVo?=
 =?utf-8?B?dHFFdDUzbHVEaU8vWitMUDJoUUUwK2JsOTJVemFUcUxhM0xlU3g0dFB2aGVo?=
 =?utf-8?B?U0swOWZHdUdoUTRERm9BaWZzYWcvYnAxVTZBWjRwQVVCVzlGUlp6TVh1bTFo?=
 =?utf-8?B?VktNano5Z3VEajU2OW9xbktSUjViWVpRcDVTdUhiaXB1d2ZGQUppQ0tWWUhu?=
 =?utf-8?B?aEFZNnBJK29CSGRYNUNUdWJqNFY3azQxeHdvZVdONlVZQUplQlN2dXQ2dzN6?=
 =?utf-8?B?b0xHbXN0cGpueEh6d3FYZGhpWDRxeTIwYUE1cXd4VEZ4MjYzMmx6WkYxNjFE?=
 =?utf-8?B?TThwdSt6VDNvaWhYWVVPYVNXckxkSGYyaDI4dFZMV25OTG51VklXT3BqNmcy?=
 =?utf-8?B?TTEvczYvbUcyd21EaWFrNXpkNjcxUnQ1aFprb05tTlFDMDAvYU01VzFzbTFI?=
 =?utf-8?B?RGxVcUZYN3ZBMkRoaCswSURYV2NTOHUyZGxaaDM2T3lYRkVmdWJhTGI5UnlM?=
 =?utf-8?B?TEM4SEY1ODQ4NGdMTVMydC9DRXlXemVPNEp0RElUR3NqMklNR1F2NllyUTNo?=
 =?utf-8?B?OFRFdFQzclhkMFZmMzZLT1E3UUx3b1JEcHgySklmWVduTlNMSHBZK0FVNXJx?=
 =?utf-8?B?MVllQW9ZQU1zaEVyR1RIRGF3S2tRaE93VFluUThQamkvcEk4am5kUnpTRWo1?=
 =?utf-8?B?OG11VnBpUlZkSklaYnFRNnhGbFF6L1gzMExuTEdxejFxMWQyakNiSmxGQVhW?=
 =?utf-8?B?bUlFU3g3dGU4QTJERFhGWTR3ZldKOGtSbWFnVnRhdmdvNHpkcGRoSG1lajIz?=
 =?utf-8?B?WmhJbXBSMnQ2Q0gxeEZ2MUZiWVhNSkRScDloNjhDb0lpRWlUZ1JTeFBGVzNl?=
 =?utf-8?B?Z2trS2NCOTdyM0F6NEtNaDAvWURDdlZBYlA4L2U2Uk5nMGVNTmw4WnBkcWVB?=
 =?utf-8?B?N05Jc3NqWXVLNnFnWGpRWUpSSWhzbmtESUd2a3ZjVjlWQmVVMDZXbEs2QXRO?=
 =?utf-8?B?SEtXeGtVUEN4TFl2QUZqaC8rYXRWVVRrcFptL2lWa1dhUlZUWkE3OXhIalZy?=
 =?utf-8?B?YnY2SHpxTVd5QWMreUdwbnpFWUdaRktidVZrRjZXSlY1Yk1lY21qV2pQdWtx?=
 =?utf-8?B?NzZETjN1bkZZOUtJTStZUW1zTVBBYWR6WUdzZ2lWNmlqcTVUNGM0SVVRUTBy?=
 =?utf-8?B?QmxUcWpGNU9BcWo1NWV4YXlYb2RjQXliK2lVQUxTWEhBeWNyS2Rxd0JEcW5R?=
 =?utf-8?B?OS9ONWVJOFFjZFMxU1U4c0l0WVNQTkdGWXhhaS83bEhoaERzcENHQytoSkxI?=
 =?utf-8?B?L0ZqNG41OTM0c1NMY3F3cnNiT3RKSHVjc0FIVC9EWmt1S2NPVjZxNjl1aWZB?=
 =?utf-8?B?RE8yV041a2NQcEgzU2VQREJrbnZGU2pkWG1sa2ZkSTk3SkoraFpZUzhoYUZI?=
 =?utf-8?B?WE1FRHpnYmU4VlpKRUozQ2tjbmUzZ1hCQzlDQmhnMzdHM2trREVDcVVnTG4x?=
 =?utf-8?B?ZG5tUVRiZklMUWNtZjIzb0tLVjVCSEFjWFBkR2VzOEZiamtMME1pNlh4UFQ2?=
 =?utf-8?B?Mkl2c0FJREx3WTVDWjhTM0dKUzAydlplWEc2ZXRiQ1ExZzZSOTN1b0x6WDAr?=
 =?utf-8?Q?TdiyRON878fkuuhMpy4gVEHDZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21470e2c-1a0e-4abf-5ab8-08dc23758552
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:31:23.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBUPHFd5vGERkiFRigrMprKv+r2A9TnkQCxB/kTWE9kjkSKqxJYmKTZGCGvqmChNFc5mxLEcCQB7MWkih1CuIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
X-OriginatorOrg: intel.com

On 1/23/2024 5:11 AM, Thomas Gleixner wrote:

> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -172,6 +172,13 @@ static inline int topology_get_logical_i
>  #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
>  #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
>  
> +

This additional new line can be avoided.

> +static inline int topology_phys_to_logical_pkg(unsigned int pkg)
> +{
> +	return topology_get_logical_id(pkg << x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN],
> +				       TOPO_PKG_DOMAIN);
> +}
> +


