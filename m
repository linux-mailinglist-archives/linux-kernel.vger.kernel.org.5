Return-Path: <linux-kernel+bounces-7514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB8781A91C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167DE1C22D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF254A9B0;
	Wed, 20 Dec 2023 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpLcFCXW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2664A991;
	Wed, 20 Dec 2023 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111199; x=1734647199;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/7W71AmrG8/idX8uUhFymdQD7/J+E//D7I/aU5/UmWQ=;
  b=QpLcFCXWhMa4uvZYns3shQxsXPTqWRnUsthdk3M/IM26F8DpkvoAv4cP
   PuIn3Bk+E/C5BcIr0p7iWsdzaB0JkJmpDfJfawr8rPNAYMrIctRx17sZX
   TWIfIxa9wL6/CAINDtz4lYO6h8+Thdyc7cjRMpmiFMbf+MzFWvWbCNsT1
   XQi6emxBZ4PK4BZYs2xqi4usxU5y6P8tyDfdx4NakMebQTEbB7rph0l0x
   YZhf+JoQhT1CjfZ91m+9sKzuaNJ3qWxgzbixWcF3c3xNfZiwJJRwTqPWL
   zwb4oihH2WzZqzsZl1vJnSQN+dOH/Cv+6pHJs2KbOvedOxwvfFpOOEl27
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399715417"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="399715417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776482958"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="776482958"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:26:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:26:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:26:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:26:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNIfLP7tNylLzVUgDJHwkqPHnMJnuq7qc4L0Xy4h5zou5t+Ip4DTLTih8ucpqGbxY8M1Mxe3TzVR4xZqTxFNFqlsi1jD+7Z4zLB2jo/judmHavPTUUM0q36sRxZaIFLWaMoVD8LTHyZxAJ2RoeXbkURtsaIiGbpJ0HQ7SXZ8kI9IxjD/twFaBb2utp0/56XAVp0kv93vx/vWHhi0RxpqX751AW6ORJWGALu0qQArGf9cDpQJjM4YhbEY3BDaOgxJIy7NyHoIyuH3zqfe7K72uvbvbusdD/C+6SKwnFzUPmEuc4AuEzePp8Ko+MtD6UaXNMigmgfN4yY75ZBtbDlEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/A+YX8MGsYyks7TTicJRVGX5RprzZd7e+zjZStNn5Q=;
 b=QRksXi09rbfKRuVq6Y/5Ym8qOsD76tOD1v48/VZxAJaEzCi9s1qFkzrZjboUBwXLKlIrCJbN6zboYtBffEWJ9TIPH38cOAMpsSBMJm32seG/eiOxswWfxpyWRJHg/pSX6IzPfpsZ4QLTNjMxCJespFNsG87Nw42DYzcUyEOCLaVRPP5/8fUZkhTQj9975vwLGk6AeHQa2Uno6qK6wTYY0gMH1mfPDxF2FH323Kg/pC/hLWyD+VUrtFU5A6HBfx9FvpQ9/F2vrF51FFgZfO6NJSW3Hhle8YPxaFsa7qKT9YuJDGxmRJKPaQQqHhbfJfkyQ/e/RnQXhBvZT1glXAA+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 22:26:35 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:26:35 +0000
Message-ID: <a24f00ed-460c-4ba2-bcf9-c767aacda70c@intel.com>
Date: Wed, 20 Dec 2023 14:26:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/12 net-next] qca_spi: Introduce QCASPI_RX_MAX_FRAMES
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-8-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-8-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM4PR11MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: dbada0ef-1af3-4147-ca96-08dc01aab996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au85FOsw6SLJygFsPwRAmi7cjb4DPzj1NvICLhPOR81tYtUMrOzLKfFsot+sXx26AQeP+uZ7x4pt1FGfMbvCuH1K8o7BYFpqjR9VzZ0YJ3EPJS+cQelq/cf7sLhW0Zsze8m8VfLEPe1F1JnKoH7Ez50dsWLYoAtdxtww2LI7mJSk9AcJHYce0/qB/7Ajqspy7luSCk/rKGOozHSFoTZ2mdY/dTSE20WDYWFWmjY6A106enV5SYW2/+nXw/2YkwEg0xJm8TGb/brCXrkFmhYV1DF0g8D3cTmiqlfbdVHxGYp1fEjxz+CWnAdmv7wbmmoA2RZAiAr/hsJB5MSs88IVN+QrMI0qXIJ6FV/UmaAqv6/jS7+28TT2wouBKmtQbBlkSMacedeF/7vf1OEaRERr1CaSfhaHQCe19m8UvamGrFiLZnozwYWUp8rIU3WqzkotGeC4Tw0+lwWTtx8t4Ob3SiacrG0sEbEgw7V+BNznPGSNakxZ6LAK27kV/VEYzbp7whWhB53NJxIrmx+DUZO+K5YeD5AJf1OOv+yXoZJcF+rd2f9vmwzYaOh4l9HDygjwqp1pbL1KYRZ/Cbrlg4OPM5da3ZN47ykF564FOiVulvYzYVwd+gG9ZtedTNQfwQpZBfrRoQko4zoqIKKGpfaLnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(6486002)(478600001)(26005)(5660300002)(4326008)(2906002)(8676002)(2616005)(4744005)(8936002)(66556008)(66476007)(316002)(66946007)(110136005)(38100700002)(86362001)(31696002)(41300700001)(6512007)(53546011)(6506007)(82960400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdjY1FKdFJIVFFjdkFjZFp1OWF2bXZJME5LbUg0OFlJUVM1R3R4VW0yNVFJ?=
 =?utf-8?B?OXFrcm5ETWs5RWJXRHlmaTgybGtoRXg3VjR3NEVkTzViZmFLeGg4Z2gxakF6?=
 =?utf-8?B?bS8wcVZ0Q1NYckRtSE04T0kra3NxRW9KOWZNLzYyRCtHUTczZGZjbzBwZkhu?=
 =?utf-8?B?WjROc3ZTNnlWaWd3SWhqWGVQdWtwRjE0eWkrTDNaNXJxbTJ6RUdHRStmMUxi?=
 =?utf-8?B?c2tNOXMzOXN6YTYzQ2YxQ3M1VFlhRE01bnV1TmVXNDdsUC9zY21hT2VibkVD?=
 =?utf-8?B?bC9KTUFwT1B4YVIyZFNUWEZySm12VlJrZWpoUWN5WUlZbEp5OTlMZnBZWTZQ?=
 =?utf-8?B?Uk1ZSVNzUEE0clN0K0UwRTcxUSthczVnKzIzTHhTZElyNzJMdnpCamlTMFdJ?=
 =?utf-8?B?YUl0M2p5bCtVTG9ocmg4NUtTNnJ1Q2JvN1R2TmhaSW9oQ0wrN1phenpVNHpW?=
 =?utf-8?B?OG4yVERTMTMxN3kxQlhjVWhLM29BUUUwWm8rTWxxakFpUGxLNy83YUIwVjVL?=
 =?utf-8?B?T0s1TzFsUUIzMUVKeEs3bm1oZjQ0OXdXcHEwT2EvNGFGV2h6NkEySWwySWVZ?=
 =?utf-8?B?THRZVEJGQk8rdGlYU0xDOGgwYmNlUWhZOUVlWVZJeVlUejJKS3haYy9Mdi81?=
 =?utf-8?B?UWg0UWgyMyt6R0tSU09DSkRjbUNBRzBuMXlLYWFqaXZFZ3dKalFOUEFXamJ2?=
 =?utf-8?B?S0kwWlhLbHdKS3JKZGNTckFyQ3VlMFptNnBvWUQzLzNYWHY3cHNoK2dLbDJB?=
 =?utf-8?B?S0IxQ0RuVnFqN1kvYjRMK2xtL3lJNnl5UkFueW9FZnhSTWV2a1FEcEE3aGFU?=
 =?utf-8?B?UmQxeTdkUDBPbkxqS2NwUWNyb0RzYWxwUi9rVVhlMHM2aWFiMGcrSDlSS1Zl?=
 =?utf-8?B?NnNNeDhZUnNiK29NSzY5K1doWFMzTVduS3JscWVpOTMzYVFPTWZicEhnWFdP?=
 =?utf-8?B?N1VoYWx5Zm9uNkVZUTQzUlJadUNZUjV3dlVuMVgyZ0VjYUdOTkpvNE52TGt2?=
 =?utf-8?B?RjJDZU1xa0xKbHdXbDRpWCswRndpdWQ4R3NpejAvYVhzYnJqWWE1Q3dRMVJO?=
 =?utf-8?B?amFHVnN2YUlzUDk2aGFqak1kV1paNDdvcWxvdlVXYzB5eVRQcmloMjhseVdU?=
 =?utf-8?B?OVB6ZHJ6TjArL0Fyci9jRjVMcFV0TktpcktOQk9EUC9HSC9rSkZRMnk1bWcw?=
 =?utf-8?B?WFZpRFVZMmtlRFZMTlpIaWRtNmp1NG4wTU55SDIvNmE1ZE93R3ExM0hOWHlz?=
 =?utf-8?B?VFp0QVQvTlJRWWlmQjlkRGM0bWpHdkhWejh6b2ZKdThRL2VFc1AyY1hvWE1N?=
 =?utf-8?B?THcwcTljTkVZeEwyN3lVdncrTy92ZGxyS01JUUhIZlFFNEgrT1VrNGZpSDU4?=
 =?utf-8?B?UnV3UU1QcS94dXN2Z0p6a054NXVDN0xYU1hKbU9ORDZmMmJVYXNGcjBpSmUv?=
 =?utf-8?B?bTJZM1NjUndic3YzZnEwamlPTHk1STBDRWlxSzlpOWtSTUh1RUhwcUU5UWJW?=
 =?utf-8?B?T282Q29ieVZTbTVvOU4yTHpwaWFiTFVCc05qWUVnd3gySU1JanhNa3o3eHNK?=
 =?utf-8?B?VE9yczcwYytPZnFjL20xVGY3bEltdDduNFFiZlJqdlVEM1l5Y1NVR3N6QVZ4?=
 =?utf-8?B?VTFzNjNKWTVUYU5YM1FJSW5IYlhXTFlVbUJrQ3YwSmNuUUpoMWFPVUtMWEJU?=
 =?utf-8?B?c0NNYWJ4SWZlU1AxQ3JIK0l2WkpXaXBhV3N2bldoblhJaWJ6UW1JRGFoamdN?=
 =?utf-8?B?NlU0M0FoRC9zZmx0TFJtdWV2TTZvNEF3akc2ZWhES082Qjl1ZHQxcUplcHhX?=
 =?utf-8?B?WHUrM1lrWkluS20vNHZhZXZLRjlZY2tyMUo3VEFHb2xYdHJQSHBUVHdJZDBm?=
 =?utf-8?B?R3ZHdTVsZmFUcnVIZGtHZzFPMlpMVTZLZkM4QldWSGdGbFNGMWVvdGt3dllT?=
 =?utf-8?B?MzltamJCcTlwRVVEY0hKSmEyZDJCU1lDMkdqUlBueWZPZ052c1pTK1N5SUZw?=
 =?utf-8?B?L09UNmlMZ093aTFmT1VONGJsNlV4N2dvMGJoc1RrdUgwQ0o0b09IcXlaMXlM?=
 =?utf-8?B?YW40MkpEaUdVREZmN0o0d2UwY3ZPSS9IajJvci9oTStpWmcwSElwbkVKYThw?=
 =?utf-8?B?OHVZTk5RWmlZM0g0ei9UalNpbWNwQUhkWUlsa1l2T1ZJREVSVjV4RUxIbldn?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbada0ef-1af3-4147-ca96-08dc01aab996
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:26:35.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dF5LD8q43Iuxn3TG6VjefZHHmdwRpD2/FfEbxArWGe71AqsjA4BB2ryFiR8M7z1q+QfAk6noRA6X/1kPaAjnRclW89bHHanM0bwpI9aA65E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> Currently qca_spi reserves enough space for 4 complete Ethernet over SPI
> frames in the receive buffer. Unfortunately this is hidden under a magic
> number. So replace it with a more self explaining define.
> 

Yea, this is lot more descriptive to say "RX_MAX_FRAMES", rather than
just 4.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---

