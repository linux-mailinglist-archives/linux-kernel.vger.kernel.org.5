Return-Path: <linux-kernel+bounces-54085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D418084AA86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888FB285C70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9E48CD1;
	Mon,  5 Feb 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpGEz8jR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897E487B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175798; cv=fail; b=Bf0rTRlkR4Fgxr9nbwadxnOoqonUvN3A4o++mz7fz43Iibox/wRmL6DqdwjNmHsrbZzj7QB8EFO6bMEDXhvkkLlDlXtIOyiM7jESrJdJY92VxcCRlh48c9iMtyI1EUWDDl18UNVh1SY+AiyrCEsLvCnNNm1Z0PFoiqShccqpeaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175798; c=relaxed/simple;
	bh=vq7FTkYMIpqCjv0i4Pd/OfiBDAOCvLdORjrfuN3R4iY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AJWsvw+ajrXOoUHEZS6O34G5eKUl2p13C0K1otAv16hHPmRGKzFF2vAZjM5ATuj84hQZ+AlcNDpE1Xzwci8fkFOb3iB23FJi0QILr0P28sQCEE7dhHU8BFP6Cl4Hxz9YuYRw83imAOaL1ihgrW/IjbRYMsMn/S+7sPM0I02FdKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpGEz8jR; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707175796; x=1738711796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vq7FTkYMIpqCjv0i4Pd/OfiBDAOCvLdORjrfuN3R4iY=;
  b=KpGEz8jRAUJYBh8Z5yMBYwNRRK+qahr0xSLt95hdpkTDDRjYUdinXSzL
   VAhJDc++c9s/Zt+VIR+bLUHhCdK8plzfEAxtwnafYNQjl3ykPNNWKUdaP
   D67g3XkoZSKTvEtoQO/Vy1Xbpbz39ALiaduvB2hI5wkYqYCU+2ViH68Y5
   z+el7CM8Vy6+JGBngODJ6GHexnJjaiOtDy2jHTfHLcuWQ3oJLb2gVHJMm
   7cgBZQe6xwcYka6qmQ7+GE7f7tKPwyrwbO6qzHrExRTRVOIDX8HgKdnL9
   c4fTA4KLTOu1YbOeS4G/PhJkgJ/smpc1wP9MoT/z/s3ICr0M0a6hNub6p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11364281"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11364281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:29:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="871401"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 15:29:55 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 15:29:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 15:29:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 15:29:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AURZY0zXpjO/EwOSG/i9fIEn4hgkeRjRv4GPPGnm6WIdDmLYtqKyF9bZWeRg8DozmFAeiJ6THFZcI1BADeGOm4Q/sGZlri3k9TdVhyzw/cZJnrKX3PJ58dn+Xz6P0sARfh7En+iMkdHikzTs9I2D6uM5AOytVqwLHl6Z4RrIy+a0QABR8vlSwRer3l7nOzsSA5iYICxVzOKOKp4gZQsRh4afwpVGcS+8Eo3aoUWfvl7xnbtbRWj/qEmAoynju5zRlBrNyqEg1HInPpSK6w0/80SPOHMszqzXYK0606RwHBMk8sR9UuNl7D8f7KsAlhGCVlyOWilQ5Of4s/HNsX4oXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GMpNFBbhx7Bwljs73qMV6Vc+dMYoThiGpPRpj05/W8=;
 b=jO94c4FMZ9KbQf//ykNv9xGVIK03ySy54m9FmZlP5hZb6MhuoKNrPLiBT7yf8F2UrVUt0wGT8Sq+n+AjhpvP3bIr1OQY8IbXyKjPE9rLC+hiFynhnFJumfPgrBZXjHC7CncEfH40/cIW3ohLfsfEycC8PjoaZdAjFoF8aIkK55YoRde9D3sr1B3hPVfySiuSiv28izekAXj/JKR/KGbYmGZmp9a03dP9+8wVjgbunElopZpVPDFR4I8nDsHWStRNMCsPUcrHnVpwyUc9+8zbXobHdNDmh2Rvo/WVvR+vJgqrHGe/YbEZDe8SwBEWFVw/3tBVMhWY7ugALTl4LFDzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 23:29:46 +0000
Received: from SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::4329:b2c3:37c6:488a]) by SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::4329:b2c3:37c6:488a%7]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 23:29:46 +0000
Message-ID: <f9329bb2-9000-4988-a500-17042c0081c9@intel.com>
Date: Mon, 5 Feb 2024 15:29:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
	"Ashish Kalra" <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
In-Reply-To: <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:302:1::38) To SA1PR11MB8279.namprd11.prod.outlook.com
 (2603:10b6:806:25c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8279:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 14396eab-3e71-4979-5ace-08dc26a2568c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3uZzbZIvy2Upn9VhXCB6ZFlnvs5n+c+ZBh5s8RPRmkvteVGC8iRop0anUhvCVeZM5lC+WYoA7wDfgkQ7Fb34tJlrMBmQIR3K9A58mTiN5oL7+dLy7pXAdo1t4Lutm25gl6G6x/sK6czVL7q1n4n6bNVQF/wr/MvcXFtTCiGrf/ACRF4YBc64v6fsEORJbwMPi8mX5qejuCqGjGisyalrr+NHZe7k2FqojZtw/Tql24i/stjLh/Pycx6/Y/0I+GLRJNpX9ye45cxlo5baG+JZkOjyXWnQM8ljV9+8x0IwKq0c8XJUjmKzGae3sH6XeReFwch757+Fu5drYTjmpsZgTk3TWUdEVE54IYOUF9qogGHRP3rO4Z+KU7w/Avkx5uwoFk7zNnFL9PGDQLzbD6l6bQrdg/8U5uGoZG1pB68VqPCarINEWkLhAWJDbcmeJt255uUrX1EcTi5maeC9BdYlEMi/nOspnp8IQ5iZlqa85tM0kdTXX47lnZne0mzau7xjCFVLRCOWY3HQEWwlSU2LJDIFEKUKcwtbnXBQmK9ZXwwEjqrTeZka7ppZ+LmD8tmhdkj/MbceQqp9jBXI5WYgT9aC2/NTzOtV442VPhP28ljyRvB0TVy1qGaiVjUiOnaxjSLHfEIj1x6sxKNwVi+FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8279.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(6486002)(966005)(36756003)(8936002)(54906003)(66946007)(110136005)(6506007)(6512007)(53546011)(6666004)(66556008)(478600001)(66476007)(316002)(8676002)(4326008)(82960400001)(38100700002)(86362001)(2616005)(31696002)(83380400001)(5660300002)(7416002)(2906002)(30864003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlGUFdVS21oMnBuT1VTS0pCaDArRUZiSWozWFE2Wmt3NnJ1TjlCclV2WHRZ?=
 =?utf-8?B?d1U3WHg5aVNselg3aHpDL1U0NjNLSDZ2NU1reGJraGtEQU8yQ1NDTlhVRndQ?=
 =?utf-8?B?dEtJcm43MFcrZk5yZzh2ZzQrUE5MZEpnTlMyZkpsTlp2MTROcEV4K0k4WWtJ?=
 =?utf-8?B?aGVLaG9lRUFaT3MrTTZmWVBhcm84U3pTeDIrT2NRZEhGRDAxQ0c4NjhEb3RC?=
 =?utf-8?B?R2ZFb08xa0NTaWJna2dEY0E0MzRzbThYaEJiZzMyTHJzL1BpT0kwWHI3YWtP?=
 =?utf-8?B?VEZIZjdtZGwxN1RzdVVKcU9teHc2eC9BWlFjengwM01FK2MvNjdrdHRzZ09m?=
 =?utf-8?B?VkNYNTBrREI5QnNIa01SMTIyQUdNRU13dmljTVBpL1pnUHdNa01EeXdDdkFy?=
 =?utf-8?B?SkFhTUJGblRPZzkxc3p1aE5PNkxQWjZWUlFTU3dhMmw3QnlXT3R5bVZVeDBV?=
 =?utf-8?B?UXZTTHVXMEtlREtKWGhQazJjN0ZtNVd3M0RzS0dkM1c1bnhUZDZZTWRmR3c3?=
 =?utf-8?B?SFNnSVh5d1RFYmxyT2xCQ0V6YnR0SjlnWEc3OElnaytBaXdFWHpzUml5QTlC?=
 =?utf-8?B?NmFaakR6UUVKUERvZjVaeExGMGtuejdhN2g2aGVKOWN0RE9DSWIvVnFXQWM5?=
 =?utf-8?B?ZzREVmNFU1dmOEJIc0RIMkNiUzluNVhMSHNQR0VMNmdsUHVzODUvRVljc3h6?=
 =?utf-8?B?eG8wSTNWeVFIaSs5ekZNR1NWVENraW8vdERKdU5rYi9BYkN0L0FvQmFoQmxC?=
 =?utf-8?B?TDBweTI5dW1JSTZ5ZVF6WFVKNTVsZytkYnVJYUlaZkJ5cEJhOU5RanNKRmFD?=
 =?utf-8?B?ZS95aGwyaW5SRmw2bWJSVnc0U1l1TWFZSGJlbGNJMWljQ0RtTDZheUNybExz?=
 =?utf-8?B?YTNEakxiTHRqL3E5V3dzSlZVdituVjl3eDJ2citWTmMrWUZFdW9BSmR4dS85?=
 =?utf-8?B?M1lYc1NUUHVWMEZKSkh6Mld2VUtNOGdtbU03ejRkMm5rVitMaXc3elZxeUc4?=
 =?utf-8?B?Wkx4SHhJL1Z0dUxMcGpZT2ZNNG9rTXkyUHkvMEoxMnFRMXBpRmJlMFIvWmJk?=
 =?utf-8?B?SlpHek93eURXcTliSXBXSmNpNGh0aWdXckVvN0RqQlNlb1NGNWI0aWl2c0lZ?=
 =?utf-8?B?SjJTZmJ6VlQvbHEyS1J0ZG5xeU9tU01kV3lBRHpmanB5NjY3VEdzc3VmYkNq?=
 =?utf-8?B?ZGw5aTMyUkxaOS9IZnFCRDhVYkVmWWFNUU13MStybGZyUzFjN0E3MTFXdkpN?=
 =?utf-8?B?bmVsUVpPMENzVStaVXltcVFTTkxsRk9wdE9IS09aUkJZVVJ5T1l0TEZKWTNF?=
 =?utf-8?B?ZnZsRmdlUGF2alVkVEZZUUUvVzhDOVVqbjAxLzFLcmxOWWVOcUdQUjZXUG55?=
 =?utf-8?B?ZlNPUEtGUzVkU3JDTGEyUVk4N0J2TnVmR3JVQjh2NmNpYzk3NkcvNlkrazNH?=
 =?utf-8?B?cXlmb1FjUkZNSHoyazhveHUyMEN0WVplSXB3dHkyNWpoTklvNmcwT1BKSHBB?=
 =?utf-8?B?UGdCUHZ3QUoxelU2Nit2NWhnb2FUNUpVdjZoL0FyYkpMRk4yLzdVY3lQTm9k?=
 =?utf-8?B?ZWdKT0drQzhNOWNIR1FlQWs4aEM3WWV2Vk84aUVrK0UzL2VUd3R4YUh3cnZT?=
 =?utf-8?B?NlRZdmxJSmFFR25Wd3l1QkVnMktyNWNSODdIa0xCNG44WmloQVZ1VDY4SGQ0?=
 =?utf-8?B?Yzg0bGhHWkZYZU1aT2J5QUJqUk5xRmhvamJWUWlXY0VrTHM2MjJEd0Y5YllY?=
 =?utf-8?B?Yk9yN0xTTDIzY1BXUmxzaW1mWEFtbCtIck0vWFVLYlpFRFNocVRtRm1IOTdm?=
 =?utf-8?B?d1k2VmE5aHVJRXg5eCtISmVvSzhGWkR1ZDNSQTZlYWljRzNNZ0tvZ2ZZYUhk?=
 =?utf-8?B?SERvV1NVRlUrb1d6ZEpoVW5WTVhYU2hwTXRqWTdycVM2MmJWNFlSdTRhM05T?=
 =?utf-8?B?TDBDRXFTNWdKay9QZ2lGMVB3bjFnRSs0VXAyS1ZOQVV5dHhsaUVpRUVDcDht?=
 =?utf-8?B?TlFKUU94L3VWL3I1OC9GKzdZZTQvZGtUN1BZV2tKZGNSc3VsSVBESnJRNlJW?=
 =?utf-8?B?OHg5a3Izekw2elFER3JkYmtjWVhlaGRwZkJJdjMrNmJVWkEwUGxDdnhCaGJy?=
 =?utf-8?B?NEY5ZE1ObEJCc0dzRUZQeVpWV20rQlBqbitJODBGbUhEaGhzVndma0lWeWw0?=
 =?utf-8?B?VnpndXZobmhLVUtqMDJWZk9tbllnZmt3MURxaVlvRkx1aXRta1VFVkV4SFZp?=
 =?utf-8?Q?KvDw9Sod8uXemVP0D+/1Au+XKrs5OpUVqYG6Q8euyw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14396eab-3e71-4979-5ace-08dc26a2568c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8279.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:29:45.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WSBWX/g6/ujxhEZNmJIKptNUalnahQfxBzM1m7uabixMur2s9pZTTgsiuhGNOE/W86p5Z8er2XAPlfCzss1r2fSxeyY73V5t05HHxnogtIT5NiQ2hDcqlTyKOktxpEZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com


On 2/1/24 11:10 PM, Dan Williams wrote:
> Tom Lendacky wrote:
>> When an SVSM is present, the guest can also request attestation reports
>> from the SVSM. These SVSM attestation reports can be used to attest the
>> SVSM and any services running within the SVSM.
>>
>> Extend the config-fs attestation support to allow for an SVSM attestation
>> report. This involves creating four (4) new config-fs attributes:
>>
>>   - 'svsm' (input)
>>     This attribute is used to determine whether the attestation request
>>     should be sent to the SVSM or to the SEV firmware.
>>
>>   - 'service_guid' (input)
>>     Used for requesting the attestation of a single service within the
>>     SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>     be used to request the attestation report. A non-null GUID implies
>>     that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>
>>   - 'service_version' (input)
>>     Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>     represents a specific service manifest version be used for the
>>     attestation report.
>>
>>   - 'manifestblob' (output)
>>     Used to return the service manifest associated with the attestation
>>     report.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>>  arch/x86/include/asm/sev.h              |  31 +++++-
>>  arch/x86/kernel/sev.c                   |  50 +++++++++
>>  drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>>  drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>>  include/linux/tsm.h                     |  11 ++
>>  6 files changed, 376 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>> index dd24202b5ba5..c5423987d323 100644
>> --- a/Documentation/ABI/testing/configfs-tsm
>> +++ b/Documentation/ABI/testing/configfs-tsm
>> @@ -31,6 +31,21 @@ Description:
>>  		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>  		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>  
>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(RO) Optional supplemental data that a TSM may emit, visibility
>> +		of this attribute depends on TSM, and may be empty if no
>> +		manifest data is available.
>> +
>> +		When @provider is "sev_guest" and the "svsm" attribute is set
>> +		this file contains the service manifest used for the SVSM
>> +		attestation report from Secure VM Service Module for SEV-SNP
>> +		Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> I wish configfs had better dynamic visibility so that this could be
> hidden when not active... oh well.
>
>> +
>>  What:		/sys/kernel/config/tsm/report/$name/provider
>>  Date:		September, 2023
>>  KernelVersion:	v6.7
>> @@ -80,3 +95,43 @@ Contact:	linux-coco@lists.linux.dev
>>  Description:
>>  		(RO) Indicates the minimum permissible value that can be written
>>  		to @privlevel.
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/svsm
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Specifying any non-zero value
> Just use kstrtobool just to have a bit more form to it, and who knows
> maybe keeping some non-zero numbers reserved turns out useful someday.
>
> ...or see below, maybe this shouldn't be an "svsm" flag.
>
>> +		implies that the attestation report should come from the SVSM.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> So this affects the output format of outblob? I think @outblob should
> probably document the fact that it depends on @provider, @privlevel, and
> now @svsm. Probably all of the format links should live under @outblob
> not @provider.
>
> I worry that "svsm" is not going to be the last name for a selected
> family of services that might convey something to outblob. I wonder if
> this should just be a generic "service" attribute where "svsm" is only
> supported value to write today. Another service family could be
> introduced later and reuse the service_guid concept, or kernel gets
> lucky and a de-facto standard heads off proliferation here.
>
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_guid
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>> +		(00000000-0000-0000-0000-000000) requests all active services
>> +		within the SVSM be part of the attestation report. Specifying
>> +		a non-null GUID requests an attestation report of just the
>> +		specified service using the manifest form specified by the
>> +		service_version attribute.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> Given the small number of service GUIDs so far perhaps save someone the
> URL fetch and list it here?

How will user know about the available GUIDs? Is there a way for user to
query this list?

>
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_version
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Indicates the service manifest
>> +		version requested for the attestation report.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> Perhaps document that version 1 is assumed and is always compatible?
>
> What prompts new versions and how does that discovered by guest software?

Why user care about it? If it is going to affect manifestblob output, I
recommend adding that info there.

>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index b126e50a1358..4cafa92d1d3e 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -194,6 +194,27 @@ struct svsm_pvalidate_call {
>>  	struct svsm_pvalidate_entry entry[];
>>  };
>>  
>> +/*
>> + * The SVSM Attestation related structures
>> + */
>> +struct svsm_location_entry {
>> +	u64 pa;
>> +	u32 len;
>> +	u8 rsvd[4];
>> +};
>> +
>> +struct svsm_attestation_call {
>> +	struct svsm_location_entry report_buffer;
>> +	struct svsm_location_entry nonce;
>> +	struct svsm_location_entry manifest_buffer;
>> +	struct svsm_location_entry certificates_buffer;
>> +
>> +	/* For attesting a single service */
>> +	u8 service_guid[16];
>> +	u32 service_version;
>> +	u8 rsvd[4];
>> +};
>> +
>>  /*
>>   * SVSM protocol structure
>>   */
>> @@ -217,6 +238,10 @@ struct svsm_call {
>>  #define SVSM_CORE_CREATE_VCPU		2
>>  #define SVSM_CORE_DELETE_VCPU		3
>>  
>> +#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
>> +#define SVSM_ATTEST_SERVICES		0
>> +#define SVSM_ATTEST_SINGLE_SERVICE	1
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>  extern void __sev_es_ist_enter(struct pt_regs *regs);
>>  extern void __sev_es_ist_exit(void);
>> @@ -287,6 +312,7 @@ void snp_set_wakeup_secondary_cpu(void);
>>  bool snp_init(struct boot_params *bp);
>>  void __init __noreturn snp_abort(void);
>>  int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input);
>>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>>  u64 snp_get_unsupported_features(u64 status);
>>  u64 sev_get_status(void);
>> @@ -316,7 +342,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>>  {
>>  	return -ENOTTY;
>>  }
>> -
>> +static inline int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
>> +{
>> +	return -ENOTTY;
>> +}
>>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>>  static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>>  static inline u64 sev_get_status(void) { return 0; }
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 849df3aae4e1..83bc5efa8fcf 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -2378,6 +2378,56 @@ static int __init init_sev_config(char *str)
>>  }
>>  __setup("sev=", init_sev_config);
>>  
>> +static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
>> +{
>> +	/* If (new) lengths have been returned, propograte them up */
>> +	if (call->rcx_out != call->rcx)
>> +		input->manifest_buffer.len = call->rcx_out;
>> +
>> +	if (call->rdx_out != call->rdx)
>> +		input->certificates_buffer.len = call->rdx_out;
>> +
>> +	if (call->r8_out != call->r8)
>> +		input->report_buffer.len = call->r8_out;
>> +}
>> +
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
>> +{
>> +	struct svsm_attestation_call *attest_call;
>> +	struct svsm_call call = {};
>> +	unsigned long flags;
>> +	u64 attest_call_pa;
>> +	int ret;
>> +
>> +	if (!vmpl)
>> +		return -EINVAL;
>> +
>> +	local_irq_save(flags);
>> +
>> +	call.caa = __svsm_get_caa();
>> +
>> +	attest_call = (struct svsm_attestation_call *)call.caa->svsm_buffer;
>> +	attest_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
>> +
>> +	memcpy(attest_call, input, sizeof(*attest_call));
> *attest_call = *input? Just to save that little bit of reviewer
> brainpower wondering if these things are the same type and size?
>
>> +
>> +	/*
>> +	 * Set input registers for the request and set RDX and R8 to known
>> +	 * values in order to detect length values being returned in them.
>> +	 */
>> +	call.rax = call_id;
>> +	call.rcx = attest_call_pa;
>> +	call.rdx = -1;
>> +	call.r8 = -1;
>> +	ret = svsm_protocol(&call);
>> +	update_attestation_input(&call, input);
>> +
>> +	local_irq_restore(flags);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_issue_svsm_attestation_request);
>> +
>>  int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
>>  {
>>  	struct ghcb_state state;
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 1ff897913bf4..3693373c4227 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -783,6 +783,140 @@ struct snp_msg_cert_entry {
>>  	u32 length;
>>  };
>>  
>> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
>> +{
>> +	unsigned int report_len, manifest_len, certificates_len;
>> +	void *report_blob, *manifest_blob, *certificates_blob;
>> +	struct svsm_attestation_call attest_call = {};
>> +	struct tsm_desc *desc = &report->desc;
>> +	unsigned int size;
>> +	bool try_again;
>> +	void *buffer;
>> +	u64 call_id;
>> +	int ret;
>> +
>> +	/*
>> +	 * Allocate pages for the request:
>> +	 * - Report blob (4K)
>> +	 * - Manifest blob (4K)
>> +	 * - Certificate blob (16K)
>> +	 *
>> +	 * Above addresses must be 4K aligned
>> +	 */
>> +	report_len = SZ_4K;
>> +	manifest_len = SZ_4K;
>> +	certificates_len = SEV_FW_BLOB_MAX_SIZE;
>> +
>> +retry:
>> +	size = report_len + manifest_len + certificates_len;
>> +	buffer = alloc_pages_exact(size, __GFP_ZERO);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +
>> +	report_blob = buffer;
>> +	attest_call.report_buffer.pa = __pa(report_blob);
>> +	attest_call.report_buffer.len = report_len;
>> +
>> +	manifest_blob = report_blob + report_len;
>> +	attest_call.manifest_buffer.pa = __pa(manifest_blob);
>> +	attest_call.manifest_buffer.len = manifest_len;
>> +
>> +	certificates_blob = manifest_blob + manifest_len;
>> +	attest_call.certificates_buffer.pa = __pa(certificates_blob);
>> +	attest_call.certificates_buffer.len = certificates_len;
>> +
>> +	attest_call.nonce.pa = __pa(desc->inblob);
>> +	attest_call.nonce.len = desc->inblob_len;
>> +
>> +	if (guid_is_null(&desc->service_guid)) {
>> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
>> +	} else {
>> +		export_guid(attest_call.service_guid, &desc->service_guid);
>> +		attest_call.service_version = desc->service_version;
>> +
>> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
>> +	}
>> +
>> +	ret = snp_issue_svsm_attestation_request(call_id, &attest_call);
>> +	switch (ret) {
>> +	case SVSM_SUCCESS:
>> +		break;
>> +	case SVSM_ERR_INVALID_PARAMETER:
>> +		try_again = false;
>> +
>> +		if (attest_call.report_buffer.len > report_len) {
>> +			report_len = PAGE_ALIGN(attest_call.report_buffer.len);
>> +			try_again = true;
>> +		}
>> +
>> +		if (attest_call.manifest_buffer.len > manifest_len) {
>> +			manifest_len = PAGE_ALIGN(attest_call.manifest_buffer.len);
>> +			try_again = true;
>> +		}
>> +
>> +		if (attest_call.certificates_buffer.len > certificates_len) {
>> +			certificates_len = PAGE_ALIGN(attest_call.certificates_buffer.len);
>> +			try_again = true;
>> +		}
>> +
>> +		/* If one of the buffers wasn't large enough, retry the request */
>> +		if (try_again) {
>> +			free_pages_exact(buffer, size);
>> +			goto retry;
> Is this expected to ever go past 1 retry? Fail after that? It would seem
> suspicious if the untrusted host kept asking the guest to allocate more
> and more memory. Is there a reasonable max that can be applied to those
> buffers?
>
>> +		}
>> +
>> +		ret = -EINVAL;
>> +		goto error;
>> +	case SVSM_ERR_BUSY:
>> +		ret = -EAGAIN;
>> +		goto error;
>> +	default:
>> +		pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
>> +		ret = -EINVAL;
>> +		goto error;
>> +	}
>> +
>> +	ret = -ENOMEM;
>> +
>> +	report_len = attest_call.report_buffer.len;
>> +	void *rbuf __free(kvfree) = kvzalloc(report_len, GFP_KERNEL);
>> +	if (!rbuf)
>> +		goto error;
>> +
>> +	memcpy(rbuf, report_blob, report_len);
>> +	report->outblob = no_free_ptr(rbuf);
>> +	report->outblob_len = report_len;
>> +
>> +	manifest_len = attest_call.manifest_buffer.len;
>> +	void *mbuf __free(kvfree) = kvzalloc(manifest_len, GFP_KERNEL);
>> +	if (!mbuf)
>> +		goto error;
>> +
>> +	memcpy(mbuf, manifest_blob, manifest_len);
>> +	report->manifestblob = no_free_ptr(mbuf);
>> +	report->manifestblob_len = manifest_len;
>> +
>> +	certificates_len = attest_call.certificates_buffer.len;
>> +	if (!certificates_len)
>> +		goto success;
>> +
>> +	void *cbuf __free(kvfree) = kvzalloc(certificates_len, GFP_KERNEL);
>> +	if (!cbuf)
>> +		goto error;
>> +
>> +	memcpy(cbuf, certificates_blob, certificates_len);
>> +	report->auxblob = no_free_ptr(cbuf);
>> +	report->auxblob_len = certificates_len;
>> +
>> +success:
>> +	ret = 0;
>> +
>> +error:
>> +	free_pages_exact(buffer, size);
> I was going to comment that mixing goto and cleanup.h helpers can be a
> recipe for confusion, but this looks clean to me.
>
>> +
>> +	return ret;
>> +}
>> +
>>  static int sev_report_new(struct tsm_report *report, void *data)
>>  {
>>  	struct snp_msg_cert_entry *cert_table;
>> @@ -797,6 +931,9 @@ static int sev_report_new(struct tsm_report *report, void *data)
>>  	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
>>  		return -EINVAL;
>>  
>> +	if (desc->svsm)
>> +		return sev_svsm_report_new(report, data);
>> +
>>  	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
>>  	if (!buf)
>>  		return -ENOMEM;
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>> index d1c2db83a8ca..33fa26406bc6 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm.c
>> @@ -35,7 +35,7 @@ static DECLARE_RWSEM(tsm_rwsem);
>>   * The attestation report format is TSM provider specific, when / if a standard
>>   * materializes that can be published instead of the vendor layout. Until then
>>   * the 'provider' attribute indicates the format of 'outblob', and optionally
>> - * 'auxblob'.
>> + * 'auxblob' and 'manifestblob'.
>>   */
>>  
>>  struct tsm_report_state {
>> @@ -48,6 +48,7 @@ struct tsm_report_state {
>>  enum tsm_data_select {
>>  	TSM_REPORT,
>>  	TSM_CERTS,
>> +	TSM_MANIFEST,
>>  };
>>  
>>  static struct tsm_report *to_tsm_report(struct config_item *cfg)
>> @@ -119,6 +120,77 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
>>  }
>>  CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
>>  
>> +static ssize_t tsm_report_svsm_store(struct config_item *cfg,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct tsm_report *report = to_tsm_report(cfg);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	guard(rwsem_write)(&tsm_rwsem);
>> +	rc = try_advance_write_generation(report);
>> +	if (rc)
>> +		return rc;
>> +	report->desc.svsm = !!val;
>> +
>> +	return len;
>> +}
>> +CONFIGFS_ATTR_WO(tsm_report_, svsm);
> Modulo whether this should become "service" per above the rest of the
> configfs interface changes look good to me.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


