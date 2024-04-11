Return-Path: <linux-kernel+bounces-141654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE968A2139
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E441C21224
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A133D3A2;
	Thu, 11 Apr 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcYy1pgc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FB1865A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872767; cv=fail; b=tAj0blMSoPibP+rYXoc71InphRcekHbtT0haNYzQxW7QLu0J1oegvchNcIjRGTRxfHp3mE/Fpd5uiZmFaDJ/C4kIYgOIx6uB7is+6vSprpF/Sl//0GrbPHu/GPE9ZJzOYgHNuNXPbKH85jvi4x4uqZGd3JEoa44g/4yRZo25N7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872767; c=relaxed/simple;
	bh=rnRqqCgJwyF2TPg0KM8J9PDyiGgRoCaN2sv67eBtuXM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfoYzDpFuoG7tlgMMUKCP+ZvOuXdwW7zQEqq64xUsnbW/IEHKGgaeIHdvr67m/3IaZipjUbGjjHc+tWWqOvqOKsUHEv8d7stXLhFn0I5sd+oY2Z7nQu3kWKfl0fGfye2Sm2vlk9fYEea704Ogp0ikxbWdE7NLaAuP8+JNwE/SsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcYy1pgc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712872765; x=1744408765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rnRqqCgJwyF2TPg0KM8J9PDyiGgRoCaN2sv67eBtuXM=;
  b=JcYy1pgcJMlkrwsEX8wZ9jaFsGu23YZx9Q08Tk6rEoaJaNMKULUS7BrK
   kvnxO2pojBlPWzXVe/NNWKEb5W7p2VpnqI1w/72+59JN8cEc9L1FQsTG6
   oXHMIZzkUjwmdinuEhxdyZj3W9eTqIde41491mlqTNExOpuqTZ2j3NvK8
   MviBcFN2ku71Lq5oSlBO4eNgKgYveJ04DGA9r47ZcBwFH+dc2+APukS+L
   b5kNzaUEhU7oukPfom1a0Qz8ewR0sd2kj7f800Zk8A67EV7ejQOdYBzKz
   gnhS/EBvNAWsuE3YuoIcu2z8FrL8h5RHPn5ILSYPIm4ppRUvPvRW/RkzS
   w==;
X-CSE-ConnectionGUID: Pp3JUsq6SYu5peA6L7AHJQ==
X-CSE-MsgGUID: NbPkCeGzSy6SojRHDvO/gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25824676"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25824676"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 14:59:24 -0700
X-CSE-ConnectionGUID: XWn6y3qBTmeIkFm6wRx4FA==
X-CSE-MsgGUID: qL132Rb6SKClyOrzSBq3Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="52002662"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 14:59:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 14:59:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 14:59:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 14:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhR+AUrwy0EPvlGmvlXAXCr9XflphcdVUS0bVJria8BQOaWrdMb6u+nAQ/LeY+fXLdDzbH9JTghiDoHDAeoddyScjie7nZHpGvqOBQPVgzIPcKU41w43v8PTcokC3zbkDScKJZe0oBjgvRwaSBKaXUtazxJi+keyXdcDvpYtXqPETm2+NTW7hwJ/ILjVu+JNCK5TClu1fBQ8VLtDvXDvsv8d77hqF9yyJNBkpoJxs3bymUBISUi9ZiQIkeh/IfjTIyF35dCPoI1UAZVvJu3P8P2Kz9tV2tr3QRMH8tN623ENRfF/1osGrt7nm3HpvGdv/xHC2dl5e6nbzNlVMJF13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw6MvqE/19vxVmUwKhdzi3rZcJZ722jrgkHrdQtOFf8=;
 b=A0ON1trcWXRqelI28D6fTlExUmpWuBjPBU+hCof3uKCKRN9/k8hKvXnFIZ3HwmNG6DFJmKveVaJkKFToXmfJZ7NrbySTdW/rVcSWp/3QP5Rkf6j8UQ7Wsi1sqgqEKfizof+yeBizvtHwW4T4oy6naS103eE/Jnu/n3dIhXW4RZmDl3wg8YoKpnnhqjz3r5mrtmcbZk8NAjyO8oKJ+TSyJoxmfNCd86ICNJzHI5meYLHQ5QzEH0uKmQwALxfNyi0S+qXY09sOoZ4Iyyt74wYN5wgT2wPyHw+ShWPKqB+dy5uSrmCf+vUFu+7zpHMLvyGNcpuDW6DQgCfDE4dXOppVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 11 Apr
 2024 21:59:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 21:59:17 +0000
Message-ID: <f53ab4dc-20b6-4ada-83dc-89e2f7e8307a@intel.com>
Date: Fri, 12 Apr 2024 09:59:04 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
To: Tom Lendacky <thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Gao, Chao"
	<chao.gao@intel.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
References: <cover.1712493366.git.kai.huang@intel.com>
 <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
 <f361d574-11d6-3730-c77f-f3aabe111454@amd.com>
 <a5948fe2-afbb-4b8c-a83c-0be55a823c53@intel.com>
 <533c2f6a-9cb2-6d25-c8a0-0643c6862d9b@amd.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <533c2f6a-9cb2-6d25-c8a0-0643c6862d9b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|BY1PR11MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 034d0a6c-7495-419b-85ad-08dc5a72a272
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hfw3hlsI6+dM1Hs92Nfd1SrkSmBS70UkjiF4/d3iO8siH9SZKJDEmKhNEKYnToaSraV4cMlB0YSWXtn4hpY6Hed5lGC7I56dbT3WoWDjHQ+WZ8ljr3OWoOQtvH3QBQMpjY6+Vkf80t74pn7SHb/A6jyut3Db/dcacpVP6xgFO8kH0vDtcZasSBMgWwCTyv6vX8T4IH2zDm+fqre71M0b44SPYWjeOFiQkqOnVEmubZ7xWhLv1OesUG95TmCHwnpzrNPSyNl8qF66ui+HHIlGU5z0pr8D1qZXJ/2oxbhcQOG1kL9HnJPtvgmEv4wusiXxJ+M9fUpSQgPnGZkcWa906gbOd8vinWaCkB4VnAqwzO/RD9T8MEOmaFOvhtyAUftFg432I1JgRqP4+IX6rC4T1VENcmL25awXYicjvPx9j/KQ3N4DQWI3nBxNI0dZ412fnBspAUyU4P5JMc6NGjVZzIQrXgAPPlw3paiWHsXYxO4WOXkNbgseipmh2Y5qJYpPZPna7wEH/0pYR0H4IDdmmj/na5XSYvPLvQGlXmT69Kqinc3vHmL6LkqzijCT0aavcqQKs7c0kpnT8zjrjW7qo+EbeHkPL3XSboM9nEqekgE+zXD0SC4aoc6h7Wva7IfJ/D5qwTW0sTye9Na4BalGYpRA+dlVbZhijiTqQ0ZFVkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpmekU3aG5telhCUGVOeVI5RlBrb3FGUmR5YjFLa2xHaXE2SFVVM0dmNlBR?=
 =?utf-8?B?TmkxUDZLRmhFWVNYbHBhK216SWJnQmRzWklBWnRlbkFDN1VsT0VtRzZCbmtY?=
 =?utf-8?B?Y1RVT2drRjJwL3gvTGpQNTJmeHJramV4SzNySmRuRytsdlVHcE9kTTdET29m?=
 =?utf-8?B?NThLNTU4QzNpMjRLVmhlQkFVOWd1SmdrYnhtN3J3OVhvdlB2ZDZiWU4wNXFn?=
 =?utf-8?B?eFMrc05OeWlwT2U2VnkvZG1talRzZjVHdUhpd2xUd2dQMWRsQnZWazRrWGkr?=
 =?utf-8?B?VExCYnI0ajlXTGladVVwZnlsY1lwcTBlVmlxVWJOT3BWcWJ2VnFjWDlCekdl?=
 =?utf-8?B?YW9vZDdwd2I0ODBVdzY0K3MvZENXM21SZ0dSd2ZaeU9ZcGM4Z3ZORUJnd25I?=
 =?utf-8?B?VEk0QXlObFZsV1U0N1hRVWZKV1VNVUJ4ZlVDRndjVUJVUmdXTkFWMWNlTFFH?=
 =?utf-8?B?c2dFL2hZdGpQTGRMbTVKVlZncWY3MGRnOXNPb1g5MGxXc01MTGpwNCt2K3Nz?=
 =?utf-8?B?UGY5T2ZsOUlGcjdWNmp4US9JWksxb0tsRlJXN3dIMWpaMUw1c2JqUDA0M0di?=
 =?utf-8?B?WmhzdUtrQXZYdGFYVmlqT014NzA0c0Y1b3llTDhqeUpyYXpmc3NFK1F3MStJ?=
 =?utf-8?B?NDBRNGNrdEI1SDFOcnJnTTV5RjZQTkg0NDJzcUc0M1ZzYms4SlRlZkZRS1c5?=
 =?utf-8?B?MENSYzNEYVpiTUM3QzNnS3BxMVl1a1J4WFEvTlhXajFLZGZZbnFCVHNNVzNa?=
 =?utf-8?B?bXJXSlBNWWFzY05BK2ozZkhUemhaMWFoWnZPTlJVcm5LV1lVaEZraWZsTEQw?=
 =?utf-8?B?UHU2b2Q0YXNCOHBCaUFtaEhKT2hBK3ByWU5RQUVEVWZKbXU4WHZJU3lZbTQx?=
 =?utf-8?B?MnVXNVpFZVRvZTk5czhFY1ZCQUcxdGhZWm5iS0hhSmV5aVJQY2ZUZDlud0pN?=
 =?utf-8?B?aTkrL1p6cE1zUG8zWS9lUGZvRG0rNS8vaEoyTlkyTmQ0dncxUmhoYU82cStN?=
 =?utf-8?B?b1dvZTh4SmxJbUx5M2FrZ1VhMHQyZ0V6NmovRjdwSEUxeDBvR21FWnQ1bDVL?=
 =?utf-8?B?VGNlaTFHeWxMN2VwamRJaDNvV1BvOWRGcE9Za0pOdFZrcStjVzZqQWpXdjBq?=
 =?utf-8?B?MHBYa3BhZW16dnZKSXZNUHRwZUNsV1pUMUMzZ1ZJaXRvZHhaaDRvT3p0TjFp?=
 =?utf-8?B?bFhiQjFRV2NoRE1yaDdsVGllY2ZLdEc3R1BaZVhXbEkvNU5UQzFKRnh3NWZY?=
 =?utf-8?B?QzhkOTFnZXNRdHZPTzA2aE1DMy9ZcWt3TjFNN09JT0xBWE9FOUpJZUVLUFZw?=
 =?utf-8?B?ZGNCSHJHQ2hVODVFeDdDK09WRlRiYTVYbUw1QXFCOStqRVVHVk9sdk5DVE9V?=
 =?utf-8?B?M0hBTmRYOS96a0JMdmxXM0g0SW9mS2gzQmY2QnljOU5zaGJNMzVUTFZydTVC?=
 =?utf-8?B?R2loMnVGUmczTkMwY3JPUFN6ZzltcVFTaUY4eXhveHliMk51RUVLY09CQmhT?=
 =?utf-8?B?NmtwYnlBeGhRUG12S0VudGUyL0FUMnRuOFQvVDFUa0NMRVBiSUtBUlY0bDI1?=
 =?utf-8?B?Nmh6amRMUG5XTDZoODIySG5nQ2s3Zis0bmM5Vnh5ZzJwSm4yRGp3d3B4V1d0?=
 =?utf-8?B?VS9iaU9LaXNxY3oyUWVFR2R2OVBYS3JFckVrSnY3MjJCQmJmd0VJTmsyeVQx?=
 =?utf-8?B?UzhSa3BibjJZeitQeENQYkY0NGNBdURxb3RWKzFWb2FBeUk0Ly84eDlMZGxE?=
 =?utf-8?B?NGRpTG1HQi9FdEFRd29KSHJRSmJZM0EwQUZXU2dBRDV1U2ZUQXI0VzV5R2Z1?=
 =?utf-8?B?U1BiVkhjaFh0RWF6ajlTWjRKK2pnTVZIbzNxRGs5M2FQL2hmdTJVNTMrK3gr?=
 =?utf-8?B?cmlvL0oyaTJsTW9BRU04TkdDN3VFZVh6ZmQ2cE5mbW1OT3VCcGNKTkdKMjhV?=
 =?utf-8?B?MWh4MWNwR3IycVh0bmpUQko0aVBwYkw0cTYrWElnR2QvejFJWWxpbnZkKzNO?=
 =?utf-8?B?NlU2OE5MUFA1SmtYdzVBcklKVHRXM1huaFg3czRFTkY2VDFXeWJIV202WDV1?=
 =?utf-8?B?N0R1QXIxd01Na0d3L3V6eVR3N2VhQzM3MmdPMyt4K0ltT0hLamNLT3dYZlE2?=
 =?utf-8?Q?BZJkG2CYj2gNGQmTZ/rpQ4lfu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 034d0a6c-7495-419b-85ad-08dc5a72a272
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 21:59:17.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DPGScZAxZOh1XEJ1PmA1asVVdquWnsVgRo30K0cQ+SQ/W068lI/gv53Sbl+eBboeMgE31XjqCK7D23vbnJZbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-OriginatorOrg: intel.com



On 12/04/2024 2:25 am, Tom Lendacky wrote:
> On 4/10/24 17:55, Huang, Kai wrote:
>> On 11/04/2024 4:21 am, Tom Lendacky wrote:
>>> On 4/7/24 07:44, Kai Huang wrote:
> 
>>>> @@ -160,9 +160,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>>        movq    %r9, %cr3
>>>>        /*
>>>> -     * If SME is active, there could be old encrypted cache line
>>>> -     * entries that will conflict with the now unencrypted memory
>>>> -     * used by kexec. Flush the caches before copying the kernel.
>>>> +     * The kernel could leave caches in incoherent state on SME/TDX
>>>> +     * capable platforms.  Just do unconditional WBINVD to avoid
>>>> +     * silent memory corruption to the new kernel for these platforms.
>>>> +     *
>>>> +     * But only do WBINVD for bare-metal because TDX guests and
>>>> +     * SEV-ES/SEV-SNP guests will get #VE which the kernel is unable
>>>> +     * to handle at this stage.
>>>
>>> Similar comment here about doing an unconditional WBINVD, but then
>>> qualifying that as only on guests. This is where talking about how
>>> exception handling has been torn down would be good.
>>>
>>
>> OK.
>>
>> Thinking again, also it might be a good idea to not lose the existing
>> comment for SME, because it somehow justifies why we do WBINVD _HERE_ I
>> suppose?
>>
>> How about below?
>>
>>       /*
>>        * The kernel could leave caches in incoherent state on SME/TDX
>>        * capable platforms.  Flush cache to avoid silent memory
>>        * corruption for these platforms.
>>        *
>>        * For SME, need to flush cache here before copying the kernel.
>>        * When it is active, there could be old encrypted cache line
>>        * entries that will conflict with the now unencrypted memory
>>        * used by kexec.
>>        *
>>        * Do WBINVD for bare-metal to cover both SME and TDX, as it's
>>        * not safe to do WBINVD for TDX and SEV-ES/SEV-SNP guests.
>>        * WBINVD results in exception (#VE or #VC) for these guests, and
>>        * at this stage kernel is not able to handle such exception any
>>        * more because the kernel has torn down IDT.
>>        */
> 
> Similar to my comment in the other patch, just adding something that
> indicates that the WBINVD isn't necessary for TDX and SEV-ES/SEV-SNP
> (and maybe guests in general) would help. Maybe something like:
> 
> 	 * Do WBINVD for bare-metal only to cover both SME and TDX. It
> 	 * isn't necessary to perform a WBINVD in a guest and performing
> 	 * one could result in an exception (#VE or #VC) for a TDX or
> 	 * SEV-ES/SEV-SNP guest that can crash the guest since, at this
> 	 * stage, the kernel has torn down the IDT.
> 

Ah sure.  I will replace the 3rd paragraph in my original comment with 
yours (assuming that is what you meant).

Thanks again for providing the feedback!

