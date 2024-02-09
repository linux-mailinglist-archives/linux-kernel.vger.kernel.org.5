Return-Path: <linux-kernel+bounces-58919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F184EE9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590891C22EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC3EBF;
	Fri,  9 Feb 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftTqHkLp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AC1366;
	Fri,  9 Feb 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707442569; cv=fail; b=Eyuya+FiXCluYkAvpMX5tcIs+AS8kx3fQPM8uyNPsL0gxUlCgKPVtG7pXhy4tzgKMHl87ll+5K53T0UXrMm93FUCoAqTYs2Zy3khPpjF+C3nKUbek+tgO5YRWSntVqTG+RwBSXNsbP3hoM2uNp8AgoXZ48oFwix2EkrybLeG/V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707442569; c=relaxed/simple;
	bh=G2glgxtob8V3uW05BPy/2G21cscc+8TjLywShBXEkQQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jy6jPBVaT/euXg7G+v5S2AzTMZxUKH6hAmdpuhTZHc72c1TorOx+saoySVqc0i4b0iMR+sWBd7OrkA+kkAY4CwlyKDVvAr9mAG4T1IehKCEIudarhprNWzjfiF3Rp2wI6XRNkSwQQcjImmC2qYva2B2eGXNvakQv1Cd/ZI10OsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftTqHkLp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707442566; x=1738978566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2glgxtob8V3uW05BPy/2G21cscc+8TjLywShBXEkQQ=;
  b=ftTqHkLpdxyd7LWOg01hjOv794byulOJs5Ui+4TJtuQxnuWyjgPZLfOE
   0w/cwW825AL8gDHp7YT/X/p+ZBZnalj1GeoQLPR4n5Gj/i8Fue4qKLRTI
   Sn4GFWfkh+vGz+3dFOpuX2DmKpQhFqQMW+KW+ezS4OaHmZrqZlBYxNOVj
   BAzvO43FPsOer8a7zzdo9t8sqNskwiU0ipTrd9dp6Tices8n3Cbllv/bR
   L99apWMOJW8tpoNHq0CO734CBUZC6sdJYmaVnaHS8miAbwizj0BvEt2lf
   NbuwLg90ElN3NudNJgiTQ1UENXdMjJAul4YZYIITLdf44A3ZEf5PpUzwa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11924379"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="11924379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 17:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="25051842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 17:36:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 17:36:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 17:36:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 17:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXabSnBFvAAR70WI82DyHlgHOE79vjWdn1B66qCxGKDPhP8muno/zNgOXj69vAMpAle3lhdHtNK2q14Tt41TDZ5Yh5rAY4m5Pc5NB8A+MT0kafz3SEyJ0MUIQGjtlcO8u5cEGWR+tMmwZZ87dnN0/lPBfjxpdFjf/ikiqC0tRWHld75du6AKuKD5yE1exJcfmRZGUfPaB/Tv7MsAjvEgredc1CiCGzfuFEC3YGGII0Au/3bl84e23ZAGbjMd5KOFpZR2HzteE2Xxid92Jzewa31H1UiQV8A2Y7UQlqTythhqhFYbyNnUbPjLMAmLFL0HKtwTMOEP7JOLU5qAtkH9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZXoFwVBdJQffFLA9/3LSmwOsrnYTeWFhUyN0XqrGAE=;
 b=j7ewFh+3mZP7zUBVbHUBguNult+6CiJOJvrTRDfXGsIY6+Zw96BhorDfYsO5vVxm2utCZlZsUozAOVQaQoHz5dv/qRdL7jSku+/+S34hOW2rIjHde4iwtkAWEfOeWjdvzpHays/dflMpkmHWdbXTBI2k5jZD+q3gFI0hOPUREBqJuEJiRgFELM8Ecl5IrnxaLKM+uwXCiav4p0v2V0AH4Ua8yWNbQdK3gkkWB2+8vjrRTLnaPIzWmTUbVtQdKkeLMl6izkwRbPPsEpTnIYyZK4ZPKwc+vZIzqZRwLiRc8ctyt63VWCnKLRVdOg8/a+sDGEsjqAf4/ZA6qGCgHlK6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB8059.namprd11.prod.outlook.com (2603:10b6:510:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 01:36:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 01:36:01 +0000
Message-ID: <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
Date: Thu, 8 Feb 2024 17:36:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
To: Avadhut Naik <avadhut.naik@amd.com>, <x86@kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240207225632.159276-3-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3ec6df-f9a2-40fd-5af0-08dc290f7950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBjwItCVFB1LziuvH9XqxBRCRjuoZxU/T2PU2h6gVPcaqjSL+ycvwjPBbPeg8TgTPACAcXAbe21/s4gLupvqI9hKuWmN7rBAtMUy2+sc2TGfXTEwn2OALIvcutEw0oQGAU85VASz5luY/eRpRg0jX99Tp7iI+A0Y/SI0+hX+Iw1Dj6kSVrdES18yD9gvJARzOvLMSDB/g66QNdtHqJtyeDm2tpQoUXDfixJomRi9Pjh8r1ADTMGE6+nqldr+G0oDhPTAS6H2LvzyEn4ebMhe4p1kRsGWezspPyu2qckoVFzm2UAMQQX6BgBCpp59aoLCoOiPWgtmYgXqXLV+ItxY5NORMWlUqkQtX4aqZPSzKvG4ltcumKJf3s6EI2HNb9c+rzFqRifot+9EIM8sShGixEPIraY+zLN/9n6yOrjOQHheOBoWMWttqWT20712y3wsBjkUygcltWN/8RdjtTH3YXT6VW+ficABhNPIYFXIM52cb/S4VvOfpeknxeVnQUhFZufkU5inH8ryBefsMYZbhWn/4uVmRLNf4shuGr6bwPS21+oTEnPyNJBD4ui5Dtyk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(38100700002)(82960400001)(6506007)(53546011)(83380400001)(86362001)(31696002)(26005)(41300700001)(2616005)(8936002)(5660300002)(8676002)(36756003)(4326008)(6512007)(6486002)(478600001)(2906002)(66946007)(66476007)(66556008)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXhUYUZ5Tm5vMWdZU3AvRThKQTRRY1dlTEtZb2RodTArb2djUW5hRitSU1RG?=
 =?utf-8?B?amN4ZkJFZTM2Mi9IamZGbkpJZncxTTZzQm5BdTM2ZFBIUmVQVEZHODdqaytl?=
 =?utf-8?B?Y3ZMNHhleVhIZU5HRkZxYkpYR0t6cW11ZkMrRUFHdUU2eW1MM1djZGRlRWRv?=
 =?utf-8?B?dWNoaisvbWpsUlZJN0JHeDBKdzhrT09zcXBSSWFhakVabHA4dVF2VVJVR011?=
 =?utf-8?B?elNUN2dxKzZkL3FUMHh3V2pmSnVVdUw0cEEwbm5ZQkpjK1RadXlqQVp2ajNU?=
 =?utf-8?B?SlVOd1ZyamNqUlI2UW16dUNMS0Z1K3gyclNWTHVkNDhIZnRPWVk0TDVNM0FI?=
 =?utf-8?B?ZHVyNGgwUE9yVU5EcFZFRHI2UDV4eDNCQzJDYzJOc2FIT21zeHZ2dENiUWZN?=
 =?utf-8?B?dkxEYzB4ajNxcllnK2JrVUNsV05vcVlRMi9FTmhzb3ZqR1RxR25sN1JwVnlQ?=
 =?utf-8?B?d1Y4eWZiOG9zdTV3cEhicnNLRmhTT3NXNWZoaElTZnhxSjhCOXBkcEh2KzBa?=
 =?utf-8?B?bG9CMms0R1piLytxQVpHTVRjSG90akt4NzFub2pCSWFwK0pVRVJNSklFcTRh?=
 =?utf-8?B?Yi9BejVTZkdUOXpySzU1M3NvSkxjb1o2T1pmcnVGL3dTL1RaYlFKdmh3Q1U0?=
 =?utf-8?B?cWxKdHdja1hCa0dLM3lSeUVMM3FIaWRDRFZoK1ZPdUhYS1ZPRnU3SlJCOGJX?=
 =?utf-8?B?d2IvUE80Ym42TjFQMUVlSTN2dlQ0aENQZTUxQk5JVEtEK3d3SFVWUU9xV29U?=
 =?utf-8?B?RVppTUdBTWdMZVZxTU1QSGFJOGZWWDF1bktpLzNqRnlCNDYrWlExV2lpVVgz?=
 =?utf-8?B?NFdSRFFQOEFIRTFnOUVTbUNMblA3K09JY2wyTXdFQlhza21ITDk3bHNLZnN1?=
 =?utf-8?B?QkpKeFVLMmxCdG5DVWtPQmZWMDVxbEZHZkN5cXhCekRLcUxFTVFwRkFpNkwv?=
 =?utf-8?B?WjY5d0tOT0YzT0xmbHZjWm92M2FERkJKNXA3b0UydWk4c2VaSW1OSXlDeXlx?=
 =?utf-8?B?ekZ3eWtDZUdERmhySHBpR2krTitwWFdyNzVUK3RKS2xlb2FZNUROQklJN2c1?=
 =?utf-8?B?U3pCdUxCTjgydVZVVUhZTjBQVmFTdjl0VEd6YnZXWnFCdDQ1RTdsblRaRkEw?=
 =?utf-8?B?YnhiN0hoZVNMajBEZEpwYW9kWmZMMzhxckt2Mmw5cW5FWnJYSUI0ekdCSXdo?=
 =?utf-8?B?cDFSUGdFekZkWmdqdUJSK2x2ZUZpQTlCKzZjakFsRmMvS0xDcWtCQjVsRERU?=
 =?utf-8?B?c0pCQ2tLTndBcHVEd3BJYmlkdEdaS3A2MCszMjF6N1N6RTMrbDdURHc3Vi9Z?=
 =?utf-8?B?bWdTc01lUy9RcENrQkxNQ2trRlkzT3crb24zd3hKSmJCcjI4KzhNUkRWOHkv?=
 =?utf-8?B?QllKQmQ0OTZ2bnMzMXFLZ0ttSWNLQ3EwUjN4SUJybC9FWUd0UlNFMitYUjBv?=
 =?utf-8?B?cVczc3RrcVJqM3RWZXJPTlVHKzZBSmdkWTBoTGdrbWZIZVVUOW5PYWJhYXFt?=
 =?utf-8?B?YVNPdXVodzZGTUNQdVErU21jYmpMU3FiUnIxdndTRzZ5WU12RjlISURmYzlz?=
 =?utf-8?B?TjVTMlVUOU1NOElYY0FYdE0zRmVzUE9udU1LZGdsRHlvZ3lLZ1hkeDVOYS82?=
 =?utf-8?B?NEVVL3pIdzBZTzFXSFUvWlE3eEZvYnRuVFJQRjRxV1kwZWlMNlUyTzBiVmNL?=
 =?utf-8?B?K2Z2VW9waDlJRXVPdmJYUElxYXFqY25teWxOTG00Q0VUeFB6d0JFZmNTTHI3?=
 =?utf-8?B?dVYrdW8zL1pEemx4bmIyVTNuOElVZGVYSFlmWTBjUTk1TlAySFd3eGJ1ZVZs?=
 =?utf-8?B?clZMOTgzejU2ZXQ0eHRBTnlWU0ZHQUxISmVHeVZxMUdpcjc5Q3k0MTB0Y1dB?=
 =?utf-8?B?cmVCa2ZXR3FXYTB4MnBCcjFHZnFNSUx2ams3bnk4bVRyUlJFSlJyQ2I2c1ZS?=
 =?utf-8?B?bDBZUStEb1BRTDdNY1I2N3NubHd6Z2VSdHMzWVNvN09paFBNbHY1blJSeEhU?=
 =?utf-8?B?YjNRUmRzZUZpK3o3Sml5bS81aVNEWHVRNGlqUXM5U2hURUZiR0F5dThvWFho?=
 =?utf-8?B?ejBCNHc0Z21OMUhhVkk0N3lnZXd4ZEZjODdzMklRVVM3ZWxvMXRTSWdBV3p2?=
 =?utf-8?Q?+F98AsWzJwI1PE9HZSvth8+o8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3ec6df-f9a2-40fd-5af0-08dc290f7950
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 01:36:01.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6+gbbsFwtZ6yhcscc+51ZDPoBFDg5HSJn4vFy4NvgS26bRMkbKx2UQWw/yq6CmbO5lsMc9dl2VLG42Amu7NcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8059
X-OriginatorOrg: intel.com

On 2/7/2024 2:56 PM, Avadhut Naik wrote:
> Extension of MCE Records pool, based on system's CPU count, was undertaken
> through the previous patch (x86/MCE: Extend size of the MCE Records pool).
> 

This statement is unnecessary.

> Add a new command line parameter "mce-genpool-extend" to set the size of
> MCE Records pool to a predetermined number of pages instead of system's
> CPU count.
> 

Like Tony, I am unsure of when this would be useful.

Also, why does it need to override the CPU count based extension
mechanism? Would just adding more pages not work for them?

If there really is a good reason to do this, how about changing
mce-genpool-extend to mce-genpool-add-pages and keeping the description
the same?

mce-genpool-add-pages=	[X86-64] Number of pages to add to MCE Records pool.

Then you can simply add these many number of additional pages to the new
CPU based mechanism.

Sohil

> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 ++
>  arch/x86/kernel/cpu/mce/genpool.c             | 22 ++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 


