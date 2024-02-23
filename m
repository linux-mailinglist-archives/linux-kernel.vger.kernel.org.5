Return-Path: <linux-kernel+bounces-79158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F60861E56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170A01C2559B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BD148FF5;
	Fri, 23 Feb 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRCp8MkE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8341448DE;
	Fri, 23 Feb 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722022; cv=fail; b=iUjgYgLgfyJdzkBP5QFz7Q6+hR2k/5wPww+6yOjCVmkDFwtZZww6urJKmMF7tsVtaSaLthcb7afdWamBFAzlOIoE++bqvRyoxl1uXctfbTEYn6iYoQMbNSXtrEhQLG5NbGpSMaSGLTTSCXQDp4XykSla6wmhyCTq3PVBS1lJJaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722022; c=relaxed/simple;
	bh=f6nr6LMCfZJD1Y5VXZe7l12bDMc8Rve5mZp1Kdzubuo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dg9q+ravcgqvF4PSYhofmYVUMbxU7ySG/zJyCbwAuGtR5/F/sFQxr9umbBkQIWP4VAw2k9+NJnOufNMaO1cUXMdaMCgSrSikB0DLT3ra4a4E7jzopVWFBmAYhs5tuI659MWqGkHAW3C59e35k9A82ofBLaV4gM8SrVLE7KuhuWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRCp8MkE; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708722020; x=1740258020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f6nr6LMCfZJD1Y5VXZe7l12bDMc8Rve5mZp1Kdzubuo=;
  b=SRCp8MkEtSkynhkJ5ygcEoDkMxT8RBcy9TYT1gfhi5Jh2UgHMC1z++by
   gNxziJlT4QOKlrH6tIB0F4Tvs7XrgNig97waC9EkrXE+mR4U22ciRT6p9
   yf7xSHZn6eXUYnBkdn9VmpZ7PRJfxNGW6km1clcIm74ck59lMyHyah+VJ
   Is7qoT+hh5oQDA8nrgHQ2FwioH57jCHSPvbuIJ+9j9jTo049NhDfrW3Q8
   yz2952lXCIAgPuE3n26nZ+YIqhLVDYi05zkdRUZ1bSe9hHmsB8KJ7vLXw
   Ze5HJgLdLHXaz+2S5q9Cdz4WYD33Hl9SKqzc9Ao8MGgltds6u0J9j7t9n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20604968"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20604968"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5958699"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 13:00:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:00:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:00:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 13:00:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 13:00:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmcOmBzeO/w0tmHw7kc8MW2w23YeVyBzaDl8Lfx1zBkxCBm2N2g/1B3iJjrRLrA24jRUMc7mXOI/jie9mGBN30/5hnk25sprvNb+ee+uhog5/9LR/0nDvdLFR98UUqQfXFhDXgJlFlOcnIS+rk3q2hJSnc4rl9ipFjb77rh/zbpOCPkdmg2Wq1rKuD5epVcl7KnYhAU0jzgv82OTOIQawKWwl6gvbvEqSOXdSQHwXv7W9JaMAu9T0TRJOApX8M8ftgjtZgI5AUXb5d3y2E4EKtZ9bZBuAR2tt+1A4Bwsc9H3WekNrWIQD7OUqR5NID15X1Pqq9TP6D8XyuHugl/dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWf+teZGK2X93cmrGVD2W7kg4MkjX7sF0XvYcCASCUA=;
 b=JNU1SyVBzZfXMfSalC/LqdkNc5ML4hBVrHXT/PcH02FCqzjm+PLf2uEjFQBySTQZ6SCzjfT3/CZisAdVi6+Z1JgYWu7mPlWSeQ3AAsTtOlRcNdkoGL2rtm4fVtd7lBKXbUeqSWBfYvunA+uEnajD0wvv9u6nfew1q1K6cWw2asURM6n6epd3OPmMFUtlQTnWJ/XumBXCXkC+7fzUEWFnYOe11ynaRPSjQr8c5M2E1QeuV/SKOXTV5tZnTlzEC9SW8AUGUEQeTzxzUpyPGRIVZvOgFvBteIskRwkJa5xhnDmWOtHALOnKQI5AZYYEtK4FTdAGBqJQpmZXVqrYyhKWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 21:00:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Fri, 23 Feb 2024
 21:00:14 +0000
Message-ID: <4c94d725-a903-4979-bcc6-9353e0869cd7@intel.com>
Date: Fri, 23 Feb 2024 13:00:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 0/6] ethtool HW timestamping statistics
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed
	<saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D1B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d771c86-2f9a-4301-c016-08dc34b26e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gJYalRs2yMedGy8KaDQWfHjarNMfbNDH09vHe7w81kL9irg2yVJwi3TYgtdC91mbaOH+xC6bm1Q6OzG+zBd5xpkqNdkV8x6bGs1Nai4FQfrSih8NFKm12mKKC93gJeeE0fx87sMOhzT82O/ovKxsbb582SBrELCt+/ZiWOWrwH88wBsogKZQ2MWDg9hrgCnZC/4G4i3K92DHGVzi8oflXXY9zt+vOcT3mPGckPJq4Ia6CHWmozkUt7IZQWrm2utZx/l4FeM2eZD94mmJg6Z1PYUyZgnTk7oPYhCFG3qFMC/8bNYzA7op/FS/9Hu1+ezzrzLnX0G6xGfLND/4Dxu/REKbkraw+9qE1DKA4E/+JraMQH+6QGhLLkXM/pvZqdxRwhcPzm/eKIOu5vatcWSCMVBn5IRBEYUudnT8sPB5CYwhZy8TTxXycX8FChtaNn4ux/3BdGqqTDlK3QLovTE1V5zjkNuZTq02ajLamLJynvouTntZlEzbL2qTDDd7zrJmR9YG7K6vd/HxMI5G0y2LdEMya4aXP3HdCQ1A+nR3fnkLfk4aGAuiLVLh1zkEc6Sf3b3fSyB9/4Z/ibNKUAMnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkw3dG9hZUUwUmRJRXhXeHBEaHY5M25EdldJb3BSQXI0K2dFWDBNcHFlTmhS?=
 =?utf-8?B?T0tLSU1tVTJiamtPajV1eFZNTGZqZ0J4ZVdzdC8yRVBpcXZoOWdOS0lTMlpG?=
 =?utf-8?B?d1R5TnRuUkIyWHV0WXB3blNjM3h6eDZ3UVdYdzZVb3FnekdIT0lpMnZyME55?=
 =?utf-8?B?ZDNTMzJkRkthK3ZhWE1vcWNYdk1kdm4wSmMySUIxR0RPTGlXYnBWZjhZUG8r?=
 =?utf-8?B?ZXkrMVU3QlNHNVhURXptNFFFZmdjdjFxODB1Qkt5cXRhRk9pRzVaUDdOdGcw?=
 =?utf-8?B?YlE4M3FjdzdrTTM1R3R0SkVSZmNUaTV2dEN2UzhsL3JoNUtkWVhyY3FqV1VY?=
 =?utf-8?B?WVNZQjVHeis0ZFo2SGJJRVhDaXBjcGtjd3dxZ2lSZ2YydDhZa0FwR3djZjEz?=
 =?utf-8?B?Z3orNkdLNDQ4NlRYK1ZIMVBnQTBibkVTeDZtaEtoUm1pTUswMm5hTkpJbzlH?=
 =?utf-8?B?ZVFPT0Z5bWxoTzdFT0F5R3JLZEJ5bS9Rbmw0VTZrNUsvSkI1Y0ZCQmhTMG9B?=
 =?utf-8?B?NzRuRzJ6eGplK0lCYnFkM2x1NmNaNEJoU3FFMWNVN3B6bUhCbFJKK1JJalpu?=
 =?utf-8?B?UEZXRWpUaUNmc3NheVFIVHpXSVBSSmF3cFlBNFlITktBbHNMWlEzTXc0UlZv?=
 =?utf-8?B?cVR4UzhiaDdhTVdQQm1GckNSNjVseUtlL09sWXp5ajRzbXo0cnh6NVoyWE5k?=
 =?utf-8?B?aGE4TGt2bmRtQUVYWnRtTk1sWnhlbHFMQXc1UU0ybm9Ra3d6WmtWMC9sNzQ0?=
 =?utf-8?B?cEFiZ2NmNFdUeWhBelFWTTBUbUZ0RVoramRraVlLaEs0eDdHYlNNWlFoMEdh?=
 =?utf-8?B?MTY5TW5VeWwxWUFrTWFMOHZ5OEYzN3B4eHNFQ2x2QnFPTHRtYkZBYXVObGVa?=
 =?utf-8?B?aEx0QUQ1U2xjV1l4TVZHUHVIMjd6aDc4MEc3MGMvaldTQ1lFSm1ORU5LQlBV?=
 =?utf-8?B?QU0raVl6dTBpemRlaWlCc0FOcTViM3pIVlFnS2hQN1pwd0krVHhtRWs0dFlT?=
 =?utf-8?B?UGtCYmZJTFFHNXJxRENGeU53TWlPRGZNVW43UktCS0JObi9QWGFzVDBHWXkw?=
 =?utf-8?B?dkRXa2k5Y1p0M3dWZW5pV1RkNWRhWE5ESkNvdHVmKzgvc1J2N09DMjdZUXhL?=
 =?utf-8?B?MnNsM3FyYU9tOERyTGpPQ29HbEJDakJCeFBHeEZlQU9iQ1g4ZzQ0NVNWWFd5?=
 =?utf-8?B?QlFqSmZ5NENPanZ0WjRvcGFNWG9xUWZQTHc0UVloSmFtU3IvdVo0T0RYWDJv?=
 =?utf-8?B?Sk5yNWkvQlBvNkxzbm9WM0RTeDVqYm1NVXd5ZGh6NDk5czQ0VWExUUN2bG9Z?=
 =?utf-8?B?UUVuNjRMOVN5UTIyYkVYbjRmVnZsa2VZenIzdHFJWU5yUW1CK3hLNzlXWjdR?=
 =?utf-8?B?bFFOcm9QMTdoZVBWT0xjaFNjRURHdkVrVFZ3SnJXMXJqdEI5bGtqMHdVa1Y0?=
 =?utf-8?B?Q3pqSWtBZkpLcnhCZHBuQ1AyekNLakdiaThtZk9od1d3TjQvcDRWbkxLVkRo?=
 =?utf-8?B?dGdDRkxGZC9FK1R3VlpjdDk0UWVsQm5qVUZmTStNYWhxSjdPeWtNVVhLR1k2?=
 =?utf-8?B?aFdaU1V5aHZsRitxOWtPdXlMdlpsejB3WkJEL2NpcGJ5WjEzdCtMdUlMNWJK?=
 =?utf-8?B?aFp6OCt5a3VHL1FodGNTRTREN1VWUURNbkZxRjE2QVROc1Y4K0IrUGc5Vkpr?=
 =?utf-8?B?ejRiOEtQOFI5R3V0YklMWG5UU1VoRVBuNXN1cmJiTmJSeEtsSTR3STBvTE0w?=
 =?utf-8?B?SkVCNUFZemd6d1Rvdit4d1BtOGJ6Z01jYTVuWkY1bDVHTDVjekhnVnkwOUFa?=
 =?utf-8?B?WG5WajFIbVd3Z0FVM2I5MnYycDQza3daOTlNMktWdURrM3pQTGk3OHl0QTJo?=
 =?utf-8?B?RGs0ejROUFRyKzN5aGxnZ2FXMWdwZmpZc3hGZVZrUllVWlNURldjTG5iRGR0?=
 =?utf-8?B?TnBvT2V5RDNMZjZQM1pHbDVKSHh0NmZXclVubHNja2M5Mms3b29zbnpWSVEx?=
 =?utf-8?B?aVkzNlVPaTl6RVdlWnVNWmpyTFRQcWVZSi9zNTJNMmdHS2R5UkgweUd6S0lY?=
 =?utf-8?B?N1BIRGR1UUdwbWNkelBTYWZyazE0Mm1qOStkZE5KeUpFdXRvdzdYWStHZzk4?=
 =?utf-8?B?alErNTAwWWZicmNlTThEMjB2UWN6NkFsYnhaTGl6R3ZLTUZTaDBXdzV2bXl6?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d771c86-2f9a-4301-c016-08dc34b26e7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:00:14.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1livH4CdwJ4gx8oDPUON8i+8EZye6+veGSu6aDAQwgV+yctpIeP8KevKORzDQQa8fOQ4xvTNycP1XDD0BfaH3AHdoa0xJ0Fb723Tn+oKSxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com



On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
> The goal of this patch series is to introduce a common set of ethtool statistics
> for hardware timestamping that a driver implementer can hook into. The
> statistics counters added are based on what I believe are common
> patterns/behaviors found across various hardware timestamping implementations
> seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
> this patch series. Other vendors are more than welcome to chim in on this
> series.
> 
> Statistics can be queried from either the DMA or PHY layers. I think this
> concept of layer-based statistics selection and the general timestamping layer
> selection work Kory Maincent is working on can be converged together [1].
> 
> [1] https://lore.kernel.org/netdev/20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com/
> 

Makes sense! I like this direction, I had meant to work on this for the
Intel parts, but got sidetracked by other tasks. I look forward to
seeing what you've done here.

