Return-Path: <linux-kernel+bounces-48918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E86D84632B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D2528EA50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E263FB2E;
	Thu,  1 Feb 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ale72LRL"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517083FB14
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825448; cv=fail; b=B1TSZjZs2ZkVH1fLIf2qKVPLKHoynMi5GKJGxu3jV/fn7LPMjtk+2fNHFyqst5CUpU2p0fMkwrFKc2AyTDejHf/N5pTp9hYaVwAvmAnD3ncUYgrHtic3I4QY3u+wANzs9pLP9okYSRl+0HShSaXnZCgvf5oNt4dBMG/Rk+h0qpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825448; c=relaxed/simple;
	bh=Hx6uK3PMUn12L2j1m4+hnNps0iwTLUIj/OoLENpOc18=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RY0oRZeGOeXkU8U78zO2jCt9pKXV+3j7+GhOmId+yEQAaqOlLiAcCdoGQsiE2pdN/cnwyrgmXtHJb+lE8wIlbWl9MaKs08WGdJKR4wwVpri1Lqcez0ZR7uu6H/Xb7Ts0u7vfaNIz6uqUcHfASs2aFdKu7Wom1Se4DTuutMNxr5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ale72LRL; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706825446; x=1738361446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hx6uK3PMUn12L2j1m4+hnNps0iwTLUIj/OoLENpOc18=;
  b=Ale72LRL3HTBjfVQmDO6cejzold2ZRtNITjQJ1XF1flPIXbteqzV85j0
   1QMe8d+Ge1JHo5/LDoiGUC+GbPNe2Bz2UQC6qZPdDB+TU0CeybgLfg7p9
   hHKqekQJiFS8iF1ZNECHSossMj6+1n30Vy5CuZJCtUovkjwIsl1xI2AhQ
   2bZnC1zd2dSVHuktNN+ZlGMliH+N/Nn5J7FkXFcg1mJzA+6x9i3eMUyQn
   L48AVRJfWIfPOTLW1YfFQA3gtPDKe5FOGRqNFPV710rWs7mdi0huF5BZY
   HBom1QUSXCaT+PyAv54iv+AFcySBsPhaWZmER4UpiuwZYml+RuXRar4Lo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="394461404"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="394461404"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 14:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="4640699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 14:10:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:10:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 14:10:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 14:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ew067sFzvrY7azmh3Vpx7ZH/6jxQ6TiobfmT2v5AjhDd4ftC+YSs3gg7ce75tMAr7mu2ne4uhSygKCmaPqzvQ0xJaC/YMfpEN1avgCabypx2uVr6o84QSt9mcju9GLisAmx5EIQ5EqyAjh1kS9Wu3M1qB6LkTfWT/ayGxYMkTOA1ta2CsCdPkeqDnN+s/Q8gali13pemMZiMeR2I1jE8UJlQNrYyirrDRC0rFAH3RED87O2BhwrupbC8CKF4UuEugLTTS5K9hxpM+58DAhVuq3nKj2yfYHud1c19qydsIfEukAGzDrKkHcGRl3lChNTi+4yqiSrU3iNYvbuVyqXldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxdxxG88x19W4nETcCw9vJwoPSFBzGbjEeOjrUSuRlk=;
 b=EHCcQBwxlTS9bfanrsyelVhqHnuJMT/k5E4WU/RQb+5nwGD5mzLxAXGcqkLSZAbDUchtgADUZsTo5DQqEuhrnTEuibXUvlTmFRg7XPdxxeEhJtSmM3jLAZo3mGeZSOtSdLyscaLNEDT/EvABVzrbAfvpEd/jGSPfYmwR8hCQpy67IpqKQfjOT0/FoR/3Y8G7yeo8axD1TrbIg1CWTuh4y7vHM/O3RzAJ6WuIkexPLtk3dBsU9GShYw0n9WjHhVkEMlKonpSjURw4kRbyBsOvgyKMaa/g3mTU86AfO3WdqywIlvXD1PKRmkxpJd/B1OHX3rSKBzWhOAN+pzHCWvjA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.40; Thu, 1 Feb 2024 22:10:41 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.035; Thu, 1 Feb 2024
 22:10:41 +0000
Message-ID: <117b03ed-b75a-4c27-a758-144516b05917@intel.com>
Date: Thu, 1 Feb 2024 14:10:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 00/30] x86/apic: Rework APIC registration
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
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240118123127.055361964@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc1e490-3255-4887-37bd-08dc2372a0f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sDF2f/5HoSsUmZrCDi/qcMHG9WJyehnEHt4+YI3pyXoMQfuYf62aP1hZF5g0u6GNn4Dtzp3WoAY/u+w09lAXrYLr9gsIb1E1tbiVMKv+UBWrc5zX/1GitQsSP+N474mqKqR6HW6riqVonGkspYffx0O5pd9OZFrlsVTKaoiijJ48pBRUnRTXNjLKu4DUCSwDDfUq1GvMLDCMgC0QtmB+mivCCXsPwABme16AsAbkLzEMu99j7S9O4gkojsuh6XXCjkFdqcq2VUcq3oPVgwOUsIm2xf0kCpnuFG39P44qwMOzcE/QlSNf25/ST7TIuGj+YbdpTpDFeVeEH6JpdG/YjpXymsOhX6NwUOmf5jMjosyj87VqKO4jL3Ss6ZD9N+M5JgprOmwKm8B3kdxEWpkAJiZX5UQOEodCHav5D0JcXMyKPEToUSwJjeuplqkWDIipdh9V1XrBUA70PB3qcJDKfCHqLCzhzaoPciBj8vWCxpi5BZ3SfTIo2ud5HujZoga2MOBVEujB0sNiICeIiVryU/nigeVWIL3Qrv52XQCvqjuwiusBf/XTgjePw9QqqpT0JwFh0piix+ycXgtREzVz1d73LR/Le1pvhPZXxfuqhZjmGswhRuTWRtzYFiAOeJfEBl0+8Oop0rYyIGFEkHGX7LLrJrlpJkCw5swZFXd1l+IR3rUDWtgVyMKqN/PdI2X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(53546011)(6512007)(478600001)(86362001)(31696002)(36756003)(6486002)(41300700001)(82960400001)(83380400001)(26005)(5660300002)(54906003)(66476007)(316002)(66556008)(7416002)(2906002)(6506007)(2616005)(4744005)(44832011)(4326008)(38100700002)(110136005)(66946007)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlgvZCtGc0hocWdiZS9Ja1MyaGNCeFVsSVQ2RWVwMDNoRS9SbVpHVlV6MHlu?=
 =?utf-8?B?NVg4NnB1anBNZXlsbHRja1czeldhbEI5cHlVdThpaUtXd3VUcU9aUGhSVUVp?=
 =?utf-8?B?TXN0Y3VLMmpGSVB5ZjNMRXIydTMxbDVKODdGTXlxZnJyczZvaEFsMWw3SThs?=
 =?utf-8?B?OUJYN3ZSZzIrRVV4c21ndEM4SGliWjdUMTJYeEJRbDZ5SWozTzZ0T1EzRDkw?=
 =?utf-8?B?Vy8wZ2xyUVpCZy9kQnJ6Ui9sN1ZYNmJpZE93ak1WNnlZSjl0dW16ZlJZbnJr?=
 =?utf-8?B?czE5a3lTYnR3aTA2aEZzVFZaVWYyaFhTdmN3UDJtOWhHMDFWUzV0dTdycXlJ?=
 =?utf-8?B?ZWdRaGtJUUdhUjAzN3I0ZlZqNnJOVXFqK29Mc1hpcDFFamlVeWR1Z1huQ3hk?=
 =?utf-8?B?S1ZPV056ekkveThuM2tKWXoremZkeFF3dmVWdE13cWxSaW5LRzZVei8yTUhy?=
 =?utf-8?B?UitiRGlkamNUZXl4c0VGTy9hQjFIcStwUGNwTE5qc1NETXloamhTdXovNitp?=
 =?utf-8?B?QlhJd0JhbUVFdzRoM2Qra25LQmhCeXFCMDNLYzd5L1F5YTVjRTdETVJMREhR?=
 =?utf-8?B?bWVqcWxPMHFYRFU1VEdadTVFSXhMdFh3N3VFUE1zeHprUzI5cFpsMWJTNUVP?=
 =?utf-8?B?SVVrZDhLSUpna3JQOEFuekdRaTcyVnhCSW5sYlpOcVlyQUpjMzdMMXZiSW05?=
 =?utf-8?B?SVU0Q2N6eFFFdTBPQTBlZUs0S0JoMUJWcy9ZRndYelBubFJtQjBwREFob2JB?=
 =?utf-8?B?NUw5enJQNmxrYmRUQXVRSi90SUl1UmdNWHBQQ0tmdVJZdUV1ck9YcUY5NFJH?=
 =?utf-8?B?elFscCt1T245U29TWVU3YVQrb0VDeXhpRG9sV3laUXd1VmVJU3ZyRnB4ajNR?=
 =?utf-8?B?R0RsVVNRY0o3bnpMT0UrM0Y5RmVDL2lFMnJ0R0Ztd2FKZnlDREhhMXZ0UmhZ?=
 =?utf-8?B?YTlRNFlTNXJkT0JJaXlwaE5xQXBUNlk3UFcvcE9naUVMMElQd2xEVjZSRUxR?=
 =?utf-8?B?cUxWby8vS3N4b3ptc0MrSVE3dkc4TUF4WTNBWVNCV2pDZXdWRGc0Qy80akp1?=
 =?utf-8?B?cE84MTlPeDNsL1gyaWcyam40MXl3MDBHSHBLYUNSUjI4VG00YWM1T3RJNSta?=
 =?utf-8?B?elc2bFEwcnE4aGRORnFsUkFpVEVJT0Fxd2dsUldnYnJDdnZKSHNIU2hEejVt?=
 =?utf-8?B?SElmMGxPbUgrTVdZSE4wL1hPbTZnSm9oZHE4VVp3K1BzSWhSS2JSMkhkbkNW?=
 =?utf-8?B?UUdOSTJucUdKVXJKd0NBbEQrVnB3czQxdHNRUFhkZGRKQUVsVWxpTWhRYTQv?=
 =?utf-8?B?ZVJHMFJETzVpNVQyaFgvU1R2czRvVitybGNGMk95VHdoTExWS055ZzlxWlpS?=
 =?utf-8?B?clFJSHNQK3pRUmlvWlgxSG0xQ2RMT3NGazZwbkFHRmxBd3RyQ21hS1lHSi8z?=
 =?utf-8?B?YVlYTmhjbnR2R2VHWXVjQ0pyc0lDbjR4V3BhT20wZWJHUUlHcDhQRnRPRE5I?=
 =?utf-8?B?c2xLTkliNmhVRVc1VVpiZlp2ZnVGQ3ZNakVTVGpFOHM0VlQyRmdVZG42WWtK?=
 =?utf-8?B?by9zNERRQlY5M0xzRDhYTGZlc3dSSTlyYmtLNmN6QS9OYmdtanBOc1doa1B6?=
 =?utf-8?B?ZWVPY0FtTC8va2Uvb0J1OE0rbWUvYmFPa3doanQwQjRvekt6WUVVMm1Dd1Ez?=
 =?utf-8?B?Sjh0ZGhsSm5ZM09vWW9Jb3FweGs4RTJJWk5rN1FtbCt4c0ZVOGd6K1RXTzBv?=
 =?utf-8?B?ZGZ4b2FmVENIVEJ5cmtVZEtNNW9ML2FMZkFGM1ZOMys4VVVkcTBtdFdQTmQr?=
 =?utf-8?B?ZHJvZktLdDVKUWVVVW1pYXdtbVNNdEhsYUZCdmtXNUNlbUJhRXZyUjNwYXFh?=
 =?utf-8?B?ZW5OYitDMWdBT3I3MnlLSGNoNG1VUVBUWVhDKzZuZUFHdHZ5ZXU0YU5lYlUw?=
 =?utf-8?B?YXdCZWR2M1VRdFhZOWwyUFN2QmVBakVsMGNHNUJhRzBQQzJLZzgzQVE4ZkpG?=
 =?utf-8?B?ZEhpdk9Meld0Z2gyd24vdWhCUzllTGJCOUlxZEZkVVRXZ3hIeXpodkV1eU5j?=
 =?utf-8?B?YXJoQ0F1MFFMV3NpQ3N5QWk1WDB3S0w1NDZaSk5xN2Z0MTQ4ektjb2tIc29Y?=
 =?utf-8?Q?oFPfaTkE+PL9mLVkbNEzxsJVW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc1e490-3255-4887-37bd-08dc2372a0f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:10:41.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUHxvIqOwBw10ZmACnUQsVlrGEK64Qu0ETASzr8Q/PB50OY4I+J/Dc3092iR7bf3QpcN7sPI92CLhXbZXnnlkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
X-OriginatorOrg: intel.com

On 1/23/2024 5:10 AM, Thomas Gleixner wrote:

> and is available from git here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v2
> 

I have been testing these patches on an Ivy Bridge and a Kaby Lake
machine. They seem to be working fine for the most part (except for the
nr_cpus=1 issue).

I also went through the checkpatch errors/warnings for all the patches
and nothing noteworthy stood out. There were a couple of white-space
errors that might be worth fixing. I'll reply inline on the patches to
make it easier to fix.

Sohil

