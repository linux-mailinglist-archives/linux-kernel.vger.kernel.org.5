Return-Path: <linux-kernel+bounces-88555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79AB86E356
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B9A2829F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822423AD;
	Fri,  1 Mar 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4I2sV9g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF01851;
	Fri,  1 Mar 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303454; cv=fail; b=JEcR4IN0IEzk7YrwtLZE6Pq0pYO7aW2wIydB/UPBuBAgrbwj6Vkw5v34zAzorlSrmz4UXEAsN/OoB9qSWI/j6K68oNklIisX3KdgZHSBvYk9dnStXpxE6ogV9FLkxiPlFcgW/u29RksLfZBFVnyE8lWNLaJlTy87qf+zlbpnMMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303454; c=relaxed/simple;
	bh=pf4FPjmn6ryUDVezivzYKEnzWoyk1Bd9mormZ9QgXoY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWg/g6fj454g92TJbmQv4XOL1y+qouRgRpX9o7uYNgqdgF+s9UQ+P/hP8BVPi+5KJVaijGejM9r/cMcnlioPbdwShOm7up8XxlrfyVX3Wlm1ioEUzz+lhbIRmxmybv5iUWNIFNCmy2b0q0+blju05xwBOFhtFNN6Eg0RuGEADVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4I2sV9g; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709303451; x=1740839451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pf4FPjmn6ryUDVezivzYKEnzWoyk1Bd9mormZ9QgXoY=;
  b=j4I2sV9gVdhl/clU+XESZn8dwnMYfO3pP5cfZ80jNBpeuKiPW6kK9et9
   85t1Lqp8uRnj6KfxRjZiAkwAuC7YLElKuUWbl/MRy2RNyHbQWbR9iU6Pe
   z6It3+XJxXcjfR4EEpMhSYvQB2JvzR+mUMCOYQlSLBW6TNmQbNyE+3Rnt
   Paiyp2a38DgOPVe7n1QRvfo0EOpwQToU+EF9lrYZL5oYrnp488AdWqbXs
   c5HBP+lbzi4FrJdiRrnzsMl+B2yPvaeb6gUbtK8lIELEv120KclcAw++N
   4YJM/Zd4uPbgxmvOfHMUOPfzCYEBp5N2BU/hp8Xe3NRmZhXv45OjgzL+4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="21296492"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="21296492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 06:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8634349"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 06:30:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 06:30:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 06:30:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 06:30:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 06:30:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfWK/8bRZeV0Murv0OzxvqFo8e2scvO3U6PFtx0GLt77T1SytnAu5YFEcN4LDJCkgHK3Dc+Su5pLff6tNHK3bba5NsDivwJSkS3QKwwhn5JmGjdMIhhMC7H3dZfPOH8reXmP2spTU4c9uKb99/g7NL3poZhRIDx2yu2R0Xr2+aYn3tvXHLOo53jjbr6qaAoHG/EXUjSfSB51R2kXavmJNi9DG5f3yYUoWkrl3H9yl9RqkiQY/OZLX6/xWfhQ1JSwTJNzYbAc5vRPI0jekqU4Rrh+Vn3UkdtQaS5cYf6nOcaGPI+3AFU0bBWBfS/oYZG1kG1yoyo4TGYczXxrtPjUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYZtOZmHtM8VS2lCsoEiAW+AMMpAKQtHgDzY4ePKGGI=;
 b=UpEts8YugSEhAJpANYFZ9y1SI8ivG2kvbW/Ygt71nfm1ppoeygq5bkpnybAtVmHT9KN+6jhKKYhLMWuQZgtSM9C6O8kFRtqMpqr7LS/c3Rtf7GHqis1AbVbQ3Xp2xljAkUSmKIXnESKtPhwheB98hfmWNDcp9t6eT8hhm38xbYBXc8HUFqq75S1hmTqa+Pi0w/1BHt/HB046fYVGWDaQe7+Eg+5iuyT/m4rkweVHLU2Tkgxdu3zktafJn9qWgYFY5OwF4yEJwtO5h/BwJepUn1iSgeyTqVfszv5gBcPh0pkjrpFtqvcrC9ts0XNbnULRmjB+jVp8RiaZLOlVQH06TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 14:30:45 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca%2]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 14:30:44 +0000
Message-ID: <77d3f074-8cb6-466b-ab31-a7b0bac659d0@intel.com>
Date: Fri, 1 Mar 2024 15:30:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <netdev@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
	<lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
 <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
 <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
 <CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bf8f3e-640d-4d6f-a703-08dc39fc2db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCnXak23ddAzr1UUExA2V9+OUQx62yzzIFhh8bTSQuQEvtXf6KwfC2UaJ0KRjyveqgX89Z51k0uekTbUJ0VaY3ULXj7OAnrA0wSqVrx3W5DUxCo5xKb7xExUkJWbiNAvFV/MrPHxgX6xQ7NSDTsFbwiXfaat8QQAdcezPnnPxHieMAf6RVpxKQGY4jlG6iygtpSrS4YYS4JE74RW1mfIJTs40rjQlxHl4i3GZIAnSu7gIK3jRy6NyMP4KiMYpbq1VEVOoR/Gx6ktL0WVajTVnb2Mtd6pULxrybq8Lfb8iaKsXvulM5qrz4udBWaWDzNEA+L76mq2RNUpB+q6vc9UYNOAoNRnHcf37Q3YQNeoHn9Y+jINNiLhRBAB9TuAjKPjlCQ9geFuK9Of53Qap+VWdm1pQnDX5fH80hnj5rCvcz3K1JzHIExbzo3C0TSlUpDnksrmY6q+lVL1UFsku23Wf/uiLmz9VXMTzBjlWBJZrc4IOk5tp2A33ninTLNyOgcV2h1f5GTyiApNlk+w87CRaFEV67As4fXtrlPp1eq7nNm/Ixb8eJjatzriOYIOQi330LDYkdYagFu7yJ3Xvc6dxEi+FldxuRS8P1jD1onDGt5cG4oIwEfb9GHarF3sz3LC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9BMDVHZllOSUdaMVd1WWhpd2k3dStFZTlaY3h3aThsOEtEbzJNUTZVUEdi?=
 =?utf-8?B?aDZLeUhrZDNlazNEcXRreElDL2ZHb29BblhOaUlXZEt2ajZ5MWt5MUJybmhC?=
 =?utf-8?B?dnp6V2Z2L2dqSGVRdzFGSXBXUUhuTDZLMHkvN0MyQjFMVnlVb2lsRnQybEVt?=
 =?utf-8?B?VTQwdHk5YjVpa1VzNE5yY3FRNmY0RmozT3FjeDQvK0g0OVIvOXN3K1p0c1Zt?=
 =?utf-8?B?akZOSjRPNFo2bGo4aXF4WlAySFJwTjZ3a1cvZkpqVlpHUU1uZW5QMkdtSm1Y?=
 =?utf-8?B?dloyamdTdytkSVBZV3RJVzM1aURVZENNdmpBd1UyZXR3dG9aOFM2b1I5dmxV?=
 =?utf-8?B?ZEpPN2xoazRTYjRvUWhOMFMvaU5uaWpmMEdaUU1LQ3FpWnE4RzNNMnZPdmky?=
 =?utf-8?B?eFFRby9NVkNLMzExb0lQWmtoRmk5YTE1WjFtM3RMSjZ6L3NLSGdIL051NFZZ?=
 =?utf-8?B?SzN5U1R2TDB6VzlrTFdudnNOUVo5V1BGVUJ2Qi94MHpSNUZiZms2VjgyMGZj?=
 =?utf-8?B?RFdCUXZCTjlsNWkxN2RjTVRiRlZhMEZKZkxzdlNTOVZGT3JMSkZkMjZUMkVs?=
 =?utf-8?B?dVpKaXFubHR0KzdkeVlsVmxENVRpcWFmVWlRVzlacEtKakplNFdJbFlyOWhE?=
 =?utf-8?B?RFR4TmVSTlFUV0xvNG1Vbzd6UGMrS0xvUUZ6Q0Y2Qk5sbGN6a29jNk8vQlFD?=
 =?utf-8?B?YStZVHNPVnc5OElyNm5FbHhyeFppUDJORmtzYjNYKzFkU3pUOXJ3MzZmYnV2?=
 =?utf-8?B?cWtHRHBadFRGZWQ0aWkrK1VENXdDV25CV2IxclNySzNGY2tQZytrby83Szc2?=
 =?utf-8?B?SzFjM09XeUlBSGpxdzBFOEdkS0ZiMngwcjEvMmtHcG4vQ2Rza3BmaEZFOVdw?=
 =?utf-8?B?VXpaYXhZSGJMMG5rVUUrUGpYMFVIc0k2akFHZ3R0dUljUTdCcWNwWGlSVFIy?=
 =?utf-8?B?S2tkaFcwRVU5SEhaQXJQaC9oMkNHNUxtK0J3Qmpva0FaRytER3RBNTBhQW01?=
 =?utf-8?B?NlFZL3FybFZoazU0V0JUWTNOK2xDSjVyRDJjR2wwSElKdlhGTWpjMklodGp2?=
 =?utf-8?B?T3lRNFd6dW1MTmE4NGxOc2lIVm9jM2x3ejA1aHFlMFdlWEtocDUvSUs3ZVdS?=
 =?utf-8?B?UzVGaUN3YVp2aStZaWl6OEpucEk1aFJXUVljbHV5R3JCQVBIQUxGWHJEc0pH?=
 =?utf-8?B?d3lLTzl6SEgwQXdERlhWNlhlUFREY2xUc1Jiak84VUgvTUFBMmFWY2pDVUJk?=
 =?utf-8?B?WnR5cDczS2xpMlBPRHdJZzMvOTJmZlljeFhuNTg1WjQxVk84UGpnMm0reUZB?=
 =?utf-8?B?dm9icmZudGV5MDIycEVkN29EaUYxbjZxeUdaSGJMZ3Z5TWpKQXI4M0prQnM1?=
 =?utf-8?B?bjVJcUtTSjZHbWk3SnZWczkyRzlhSnRtV3hWYm1HQnkvTzRGNFgrci9GUnlz?=
 =?utf-8?B?OUQxWTdmdHZiaGd1V3ZYY1VmYmk3aVJrbjNaZGRUQUlFN2dXMWV3T2RhbVQr?=
 =?utf-8?B?b2FXamFLSmJNbXlLL3hNSXVKZ2l0MEROT3VnVUhPVjl0YXR5cFoyblVjM1M2?=
 =?utf-8?B?akRDRGZYaWs1Ujh6MklQQ0FlS3QwMmlCQXEvcUVpWDJyZXBZRlRiRUZ0NUl5?=
 =?utf-8?B?R2llZmlKTDJwQUVmb2wrbmZuRzFMV1VOTEx4OGtOaHFTYURzYmNKSVMzTGF4?=
 =?utf-8?B?dmowdFluVE5vbkphQm5Qa0hkTUZvbnppQUpVK2UxeTE1TlpQdis0aEh1bDV2?=
 =?utf-8?B?WkFaZmU3YkJLdGpQL3ZzWUdmc0MwczFaQVBhS051b1Fiam56dXJQTE56SHhL?=
 =?utf-8?B?dlYxcnJzcXl0MENCT1hvdWNQNjF2RG95OEtPbUM1eTNKQzF4bnVUZXp5ZG1Z?=
 =?utf-8?B?WnltOHlCWDV3aUwxTWhlNXpRamVtbzdTaEdnRVhkODU5UExVR09kYUVHcFZS?=
 =?utf-8?B?Q3NvSnE1dVMrajhWdGRONnM0UlR5WEZ6WCt0Z3Y3NjdtNXovOXlXN29KajVM?=
 =?utf-8?B?VkJnY3E0dTNyaS9RM29tc0ppLzJRQmZ1V3ZGYUFwc1FDdVdOanBPclhIMld5?=
 =?utf-8?B?azVJWVRzaTZSeGszZXdmdHZ0ZWlpZFEzQnlvMVBJT0E3bUNWdnhTczRMNnVx?=
 =?utf-8?B?YVY2RTlaUWdIcytPTE5MUy9Tb243c2R3NWsvekg5b0t2cDZMeTBmR09OTnRY?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bf8f3e-640d-4d6f-a703-08dc39fc2db8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:30:44.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTUTB0KyF4gF0gCZlzxmESGW+oN1OdyGKH2SytCPLVovecMyiasP/M+1igbb+B1KraO+ght9ZxD34MVNzP8b3TQB6KosuPmZjSq1YjmcTYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 14:25:37 +0100

> On Fri, Mar 1, 2024 at 1:59 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Fri, 1 Mar 2024 09:03:55 +0100
>>
>>> On Fri, Mar 1, 2024 at 7:59 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
>>
>> Re WARN_ONCE() in netdev_priv(): netdev_priv() is VERY hot, I'm not sure
>> we want to add checks there. Maybe under CONFIG_DEBUG_NET?
>>
>>>
>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>> index 118c40258d07..b476809d0bae 100644
>>>>> --- a/include/linux/netdevice.h
>>>>> +++ b/include/linux/netdevice.h
>>>>> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
>>>>>       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>>>>>  };
>>>>>
>>>>> +#define      NETDEV_ALIGN            32
>>>>
>>>> Unless someone knows what this is for it should go.
>>>> Align priv to cacheline size.
>>>
>>> +2
>>>
>>
>> Maybe
>>
>>> #define NETDEV_ALIGN    L1_CACHE_BYTES
>>
>> #define NETDEV_ALIGN    max(SMP_CACHE_BYTES, 32)
> 
> Why would we care if some arches have a very small SMP_CACHE_BYTES ?

Oh sorry, I thought %SMP_CACHE_BYTES is 1 when !SMP.
We can then just add ____cacheline_aligned to both struct net_device and
its ::priv flex array and that's it.

I like the idea of declaring priv explicitly rather than doing size +
ptr magic. But maybe we could just add this flex array to struct
net_device and avoid introducing a new structure.

> Bet it !
> 
> IMO nothing in networking mandates this minimal 32 byte alignment.
> 
>>
>> ?
>>
>> (or even max(1 << INTERNODE_CACHE_SHIFT, 32))
> 
> I do not think so.
> 
> INTERNODE_CACHE_SHIFT is a bit extreme on allyesconfig on x86 :/
> (with CONFIG_X86_VSMP=y)
> 
> 
>>
>>>
>>> or a general replacement of NETDEV_ALIGN....
>>>
>>>
>>
>> + I'd align both struct net_device AND its private space to
>> %NETDEV_ALIGN and remove this weird PTR_ALIGN. {k,v}malloc ensures
>> natural alignment of allocations for at least a couple years already
>> (IOW if struct net_device is aligned to 64, {k,v}malloc will *always*
>> return a 64-byte aligned address).
> 
> I think that with SLAB or SLOB in the past with some DEBUG options
> there was no such guarantee.
> 
> But this is probably no longer the case, and heavy DEBUG options these
> days (KASAN, KFENCE...)
> do not expect fast networking anyway.

Thanks,
Olek

