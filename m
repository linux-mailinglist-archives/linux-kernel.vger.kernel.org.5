Return-Path: <linux-kernel+bounces-103949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF387C6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB40F283F16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2F612E;
	Fri, 15 Mar 2024 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8FJ3eJz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867B33CA;
	Fri, 15 Mar 2024 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464648; cv=fail; b=In2D4eX2H6+sEoHUla1XI9a6L1Muf3yfVwIvvbLhr1rGfT7/r1N1nsMeo2YiqF8G/QoEXYYKNAovK/jkaOIwBinomw9tYPj6cjPpcFGIteedmYXDa7+taPXFJI1gELHbREyvvzzgyKzQXW9ws9EAyWTrVm5xQGjDkT31SXNvmws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464648; c=relaxed/simple;
	bh=Kyq1u0O+jaMe+SoCWUhAqv5UDkjLR+mP2nJukYqUNi0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MMO6YgBXyp7mtvnjj4PnpvglI28KokIJ/JU8pIc6hVDu5WoBnDkWlfSdnsTQjwrXjaZvyK1Ur1I0UZVsFOax1YosQbNugaG8BhHzTAlC46zr8Brbo4M9CrzCwr+44QjxhAVF/ww93ugIHfZKje7FW9AgvBHluxs6Trmn2VFs3YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8FJ3eJz; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710464646; x=1742000646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kyq1u0O+jaMe+SoCWUhAqv5UDkjLR+mP2nJukYqUNi0=;
  b=O8FJ3eJzpU2hkXtTyBgD4CF+28qQzr2qEysm9SXi51LLG8lGAp9K4IZP
   a71Nnj7hVpldj8SBR/er5u3eRToTrmZkDkahPHut2h1eEuip4U3WETTS/
   paQ7v3EWNv3vZpt7ZJLOozmLpLjH5YRA+nvxuDcviWVqcIqtcPnZg9Jw0
   wQGoLnHCuWQlSJpAzbMI0zKAWyDl7uC4UMmSmZTcUHsZ+xX0ZQLPvZR0m
   WvJn8Ol89Y+CJ08WYERQ+5hbWBS8tsWZdttIXdFXEH3JRIxbNguU9SHf2
   LHHkg9St7C5nOdFU9lJGjnC5AJVNSM588NN+PUddMjXgupklrbils2VBH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5446732"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5446732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="43521760"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 18:04:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 18:04:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 18:04:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 18:04:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 18:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8Zuf+5tieDFagw8RLm8u40qbC0GfbuzRZugQMEVXfhwYTJHNEH1Vg4jV1IS09xQyPwhjqNHkABYQMmEPKmYc1hJb8kt9RnogfolacPgLtiptPFW72kUkI+P05hGHV4qHUMQCSZFg0o7xw1evn6YxAjbGV4ukJnOfpEzCDN9YIKVoAcu/y2P5CGgvHtO4vm4xMq2/ePMau+Yfbe9oBpo3+gcux6PPuz+VQ8h47iSCcLssc8rra3lN0aHXO154O2zBu8QCb3zM5UNFM8uZwg2AU/0ZgmMbqfGwBtMYdSfdzMV4w9qgT0bfiEbb13UpoJ3gcGO8ktDI5M7/kK8WfANFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyq1u0O+jaMe+SoCWUhAqv5UDkjLR+mP2nJukYqUNi0=;
 b=AClILiJlZCcPT7CZ976XDQNiPnVsdhSv4oTA7I94fPthjBH1T5NYbgjLF0qz8wQetvnSxZHjMAUmL1TYJP1g/dTWulkbOcGRDsX27+ZWoamSAYzEpYeyGKYqi4TyxWv98+HsBmT/vK7LvpfyY0UJZ86+oMkHshQyQGFcTbg1TZg6nuvXuvny5laHA0D7lHnQ5GKNIIG72QgUUOux7UJ+K2edfGvNKd6vPARB8LXZiLwPBsKdeUeBnyVqan75LVFEm5wCdOyg68ACJ3sknQKswgKXFteH92Mw7zpuuhZqn0h4XiBiVcsEwPgsRtXeST0rB27XTT28+jcsWx2HZgsqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 01:04:00 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 01:04:00 +0000
Message-ID: <066e0dc8-0f47-4a1c-b989-f8c16f31464f@intel.com>
Date: Thu, 14 Mar 2024 18:03:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] i40e: Enforce software interrupt during busy-poll
 exit
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <pawel.chmielewski@intel.com>, <aleksandr.loktionov@intel.com>,
	<mschmidt@redhat.com>, Hugo Ferreira <hferreir@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240314120049.111241-1-ivecera@redhat.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240314120049.111241-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SA2PR11MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ed97ae-bae8-432d-e5dd-08dc448bccd0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoDAZjUVhRDSAF3VWTNJ0EFr0kHEZ1rvKjZEM5aCzF0PAPk/WJSFUiTBowuUeW7zdz0jJqBXrq8ijeclynuboIgej67Y0k0J6AhDCIbIAT06YzWp5RPHZWsfUs+hE53Bk74tB1vvzbktaSy5B1+pSPloJVqeQ6qQCsX1M22D71910INy0TiXpFQW5/E3Y3DcxRfD4WUy8iIcczH6BN3zhD8f+bg7rLbMWSpAKSIVanveAYomvt0D58ThoqcU5eeTTGpCW761L4I39a7QgMSPSdfuC6euifZrgHAmY0fS5ft/CUtdMeDNkHCeoxuS6u67Kch6XAMGPIxXe1T7cGTD49+N3jHc2+nmHRLZhyd16qXJuCQkVTfocnY77owWpBop4acRHuEJSJJIpv1SZ1GT6WA1UKqsOHp6zImlF4OnT/PYKRn8UzfBYNaQZVlw9QaMLSs0eVJB/cCNgsiLEoy9i1s1OJJ0mwoha8MmgBdz7Ov3NJQukWVpKwoqa2piBElrz7XtB6/RuHsnSNNwhAyN+N1dKOUkngpmVdX07Db2QDlsrd7jHcn1TOB5J8ng80lSegOxhbTS1g+GXkoyD2/JarjhN65IvfOGvIbFW/gyW7MJs6fcu+Mj1KsTWofpCLr+jNbUFuzvlNy1Eufd90zvY/K6fUbRsQhA7ZdDurWeecU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmcycFVPaGZMV1c4MG1EMGpJVGM0a3pxcWRMOURscEJRZGEwU2wzd0Z2UTcv?=
 =?utf-8?B?TXZWWGN3ZGl2S1BqbGt1WjFwUnp4MkQzdzlQMGhrUFpVTEtvMjllejZDd0M2?=
 =?utf-8?B?UG5iejBzN3NrU0h4QXhJdE5TcE9xRjgwMmRCOHlEWlAzU3RKSVpVMmJsamFv?=
 =?utf-8?B?QlkxWWtxODRRUUtxOG44cGgzVlF1a01NWUVIRWIxMm5iZnA4K1ZHYTBaNEZz?=
 =?utf-8?B?ZW1xc2c2Y0V5Tm1sb1FsVUdoYmR6bWp0WHA4Q1BsSEFoYTdQNHVNYndVMmhz?=
 =?utf-8?B?eVdBUkdzbmZ3dXp6RkpaeDUvS0FheU9qc0YzZ1Y1UEpRUXJZY3J2TnNjRGpJ?=
 =?utf-8?B?aWR6RzN3ZmZDMC9ubWdmSlRhakllVkQrSlNQY29Nc2hneGdqdW0vZnUvSWdQ?=
 =?utf-8?B?Vk5lWm5xSHJWK2I3QnY2Rzg2MnhtaG13bVB2NU9GUWxveWx0WnB0R2RzRWFN?=
 =?utf-8?B?QUsyeDF1UUR1ZUxncmJqaDRuWUhtZ0FUYUJBR2JGTEIzVUp3N2ZqK095b0hw?=
 =?utf-8?B?a0NiZzAvZFRLalhjZ3BTYys3WWNBUzlBQW1xdzhLeWg2em9zWlFNb21Tb2tQ?=
 =?utf-8?B?b3pYSjJ4QkJ1WGpBWm44aHF6ejhEUWRmdkRLZG5CRWgzNjQ5Yno5NzVqclFB?=
 =?utf-8?B?OEtDSXJiZVFhdjJuSVYwTTBrT1dQMlY1VUZXUkVpdjVXOW9JaXlQNURIckdx?=
 =?utf-8?B?TE0zUktZSnR3UlhGbUxLc0ZaRUFDZGtxblBhRkJYMUVvN3ZjYWc4M0lOK21X?=
 =?utf-8?B?dmZycVcvcWxKU1QrN3NhRE1EZ1RESDFQdzFiZERJTWlNVi9GcHp5UTdkUURx?=
 =?utf-8?B?ZWZ1dG02Mm5zQmY3VWpWc2lyRFR4cDVFMzVTYklHSkwvbmdPZjg3L293Nm5F?=
 =?utf-8?B?QmpKUmRaYjhXWVk5MnV2NXEwRFJNNTBmeEx0UUROTDVzT1EwREZVNGJEUlo1?=
 =?utf-8?B?NGxQck5xL09TRkl2OEVIWUJhWmFab1pNbm1lNGZIRFA0YkhXOGJCa29ueDk1?=
 =?utf-8?B?ZTRXY1hBd3BwcW5qL0hzUlIxL1Z4SjV4VENYUC8rR2gwMXVSamZuVXhrN0c1?=
 =?utf-8?B?MHlHbUlVcVYxUHc1dnN6VHlhN2t5K2wzWnVRSkM4QXM5ZGNjbVVQQlo1VGxB?=
 =?utf-8?B?Nm1EbjlrMlFjMnlDcWwyZWlEaE1ZL1djaWhEUlNDQmVFYk1xRDhtNno0SnR0?=
 =?utf-8?B?eGZaUzl0YXZiS0VEaG9pWVZaYlpuRWQ4SVlrVysxRzFjMDFHYkNHRnlmb2JV?=
 =?utf-8?B?R0t3YkU1eW5KZFN6QmZXck1CcjFzNkJVbmIwYm9sYlVJZ0xXbThYam5xVlZD?=
 =?utf-8?B?M0w4Wm9YcVFvTzFTQzgzdVZQRENPMm9hQXVocjViYi96TGxXMTllajhLUEx6?=
 =?utf-8?B?WTY0ZjF6eDZBdDR4VlRPOGVLanNHeklaUjljREZXNUd3U0NiQm5FQkRLa1du?=
 =?utf-8?B?U2F6S1o2aXVaTkVZR1kxNEhzSlUrNGRVRm54MjM5eU5yTmh0THZUU29iczNX?=
 =?utf-8?B?NkJiQnAvTlBwc0RNS2VuTDBLeUY1a0VwaGNBTWRHVFRVUFNhZnhaaFR4QXlM?=
 =?utf-8?B?d0xSYktLaEdJMHBzUWRYa0x4TThrSmZ3RXlXVkpSNXhUZ09DcEJOT0Zvditw?=
 =?utf-8?B?WlYyS3NiYURReWpWZkZ4WjIrY3ZEVFNIcVkwbXl4ZXVjVzROM281WDNlS20v?=
 =?utf-8?B?RG5jMmZ3cWlmc2pVSXlXSk5ZSXlsdCtHQ0U0dGxjT0JpTENsN2xUMDF1M29h?=
 =?utf-8?B?VUREWEwvUG1vN1o1V3BOWURBK29YTTlvOFpsMVVCVEdpVGNCTk8va0xZSDFV?=
 =?utf-8?B?UE9JNDJ6dXNMcytGMmc5eEF0N2QxNHR3V2VWb0ZtMGVJY3E4QkpQZGVCZDB3?=
 =?utf-8?B?dk1RNTk0cGJxUGlzRWdQOVNXSUZQQUJFamNPTGpnanIrNlRqbmFYM293SGEx?=
 =?utf-8?B?WlFZSnNpZGRsRFh6MkIxTzVzTkNuOG1ISGphSkFLdit6cENGNG9yb3JUdTBl?=
 =?utf-8?B?cHl6aGJEYU5TRzBrNlVudVh6aXA5K1RkMkpXNFlKL0l5dFFSQzR4YlZQbTVk?=
 =?utf-8?B?eHVTR2JENkMxSFB3Slh5MmJjQ01sYi9wN01aTFFNd3lsTWhpYjY5QmN4ci9q?=
 =?utf-8?B?N0t6elZ5MFE1OENoSGQrczhXc245OHlTQmFKenhjZnNLcmlFVHZWT3Btb2lV?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed97ae-bae8-432d-e5dd-08dc448bccd0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 01:04:00.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsEncKDM7GgT+XKh35SBxVCCV07kUEwp05w5hBtuZEOo6kgzsxXcGgeXMlowPwo/j+FT3dXcBklnedVx3U4UguSoWW6qWuw4DNuiEHL0AS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com

On 3/14/2024 5:00 AM, Ivan Vecera wrote:
> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
> during poll exit") followed by commit 23be7075b318 ("ice: fix software
> generating extra interrupts") I'm seeing the similar issue also with
> i40e driver.

Please see my comments on v1.



