Return-Path: <linux-kernel+bounces-79184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B818861E95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331361C23E44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D03149398;
	Fri, 23 Feb 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGN8TKqk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE61448DE;
	Fri, 23 Feb 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722793; cv=fail; b=GUX6pLe72QJOLOgKT+A9Z0YQpA2fZBmqiCHBSzgsESrl7Iz+PJQRdciw6MfMLBWdXunBQV3BEYRBlRNHoSq5PgxfLl+g5cCNblpctuDYCs5jozxkpMQhUby6YmenTADqW7J+gpKn+KMpDug9HS+Q/AIBRPhaNzXpCOCYrhuRWgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722793; c=relaxed/simple;
	bh=9YHE/2QWz0HUCH4iy2qhDFCCVNqR0nt0ypjgLb8wCz0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DZjNkgsEynQ0Lk+ZQqmFd5Hzm4TjxEwy7nEyCFtzx3VOOhk/cb7UrLtanBTuJCa6TBE1HK/qVSuP/VY1+q+GE1EgRK0csPznTc7eMypxzY0O3chxijZ70QQ/qnX9SyNfDDJIlGhDorJX7GIrnK4Cwb3ZQ+R6A6uuOAitecHLSns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGN8TKqk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708722791; x=1740258791;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9YHE/2QWz0HUCH4iy2qhDFCCVNqR0nt0ypjgLb8wCz0=;
  b=EGN8TKqkow8QMpRlU40iQxdA8LwvOtoCKLq+r9+/oVDS7+QsX6iR5agW
   vMPKSA2n/qG9wjpyx1CMB4hFfyXFkiG3Tg+DEjzbMHiaBPPURQSn27BW7
   6TrXw6Qb3vqnZJSH3XKIRLeo7feC7If67VbYkk/+/sbO+58mfvVfVpA0c
   pgAANp40QCrk7eWb79XEI3lANc/6WIg486yyR3CLATGwcwaAHrcOQAgM/
   oudohuae3+/KC+m1KAwS3Z9mHxxFjeZfExGq1wn8Rzf9zWzVePgHGb8Pl
   r9oROUmfzinkYL7kkVRDfepY/Dji8j7hRv2ikWz31C1cFxrKfD8KrXiNI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6848303"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6848303"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6389876"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 13:12:57 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:12:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 13:12:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 13:12:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq/Stv3VbosuP6l93bkQbIpG6Qx10knoGadcSGSgl4tJCIJv3ztVoEmNNlDaDEoiqhs009XrrKa2cxXhRJWHzgvUqHh4eUHG9yuUDFIJZxMLf2/6uLLDgGg8iOTkPIXpKFOLoFgFBckSk6odlCnkMilYYF0/CEaeiBuOLQ7NjhK6rMgm6tIzOQMP/y7/DjSgfAP2cYZPZ0aA6AwW3xkSAEccfSieW1Vis2qbZEPDrlwrZNgH+QCo64AlbeA9nmyecnMiPbH3a6CidYHBnY2ckZj19Bx7Qw6RxyS2gE9QQWU6PeSS2hT5m+LNcRWRk1o/+2L8BHZYu+i4vliEz2uwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4vIUfB1ihNDrkC2Lxr+dSRQ0bkjYz1EvIJCapaCpKs=;
 b=H6kx7FKpTWoFcukhtdwGyWKlulM2b3F2oL95G548EEwyH7K9EbzWJuWoYVbFfygmRFOoD+Gqpn9Zqbq4dNdo3UQsZPfvZ1xNkesklzkrzPD8NC1+prpLDwIhuTPzdPq1PcG/t46uikJh5q47wWzv1408LGr63+bfxmTi1OMnjfkEaXbcRXN0WF7mjgmj1T2HoaqMBIIaVXPXrLkX2HRhorWdt9EW6cJHAMTBwShHpSlXtiCaYa7HBg6PoOP2qylYfVgjHMbUU30gGFyMTfhloMBd+nMgjvHBUHxxkkQ/e4LsdotvtOi9Ar+UjEsiZIdrcFgHZHZaql4ksGBzzHnSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 21:12:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Fri, 23 Feb 2024
 21:12:54 +0000
Message-ID: <fb8c6ec5-05d0-46cc-8bb4-b97b3d77c02b@intel.com>
Date: Fri, 23 Feb 2024 13:12:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 0/6] ethtool HW timestamping statistics
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed
	<saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Ahmed Zaki" <ahmed.zaki@intel.com>, Alexander Lobakin
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
 <4c94d725-a903-4979-bcc6-9353e0869cd7@intel.com>
In-Reply-To: <4c94d725-a903-4979-bcc6-9353e0869cd7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: c9850344-70f3-4c56-2120-08dc34b433bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heckScMTBrl2Sh1vtnQtUJ8877x9qp5Oj53gHVCmpwnAY5+DkfFE7l2V5YgGsmegFDW/eiz+3kCysEuHV0hvXu71gZzwtAVIyj4wXiPgvMMrJq5PslIJqcOMbCLAt1hyfM4iLMJac1F2PMffHs3+4bZsfXwSsVT5rx18DSGtyxHFd2xM32yWSCrySvdgMo0K5URVi6ManYzivwP5xECqhsJvyHuuWW2out+q9m6Ip9BRN2tU4if0pxEZM5KR6VTdHZ89vT+7j18ORJ0drWzBt7UxU41pmOR++qOMYjwTPIkXdYXOWwzHyhHdruHTbCcT6sdq/nzi0TlIY6Cs8+37hsw+dVEeue7bVp0q9b11I8D07z1LU3fjrMfnYU0XJcMoNkjmo7NSxQcUydq8gwyp1SBItfNEpdsQAtJqlmd+C/D6TsoaumsYXgbC9RkTirx9cvHi/pkD47z5N4Yp2XseOCWgHjBEmk9MpkhTrGBiqYjYkuNRnjO5AXhOdtr7X2BwMVdj2Ino/7FXKk0cVsBfiPIfXC6Tv2I9P8Fq3n89m3vvaK5MRBjrGDFA13EQbKUsuilpADFIb6v2Wx24f+eOOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2c3QVc4dDdNNE11bXFaVklNTEYzV3ErTFZwRGVXaWcvVFR6M1lNb210YUM2?=
 =?utf-8?B?MHdPTEthTXVTaUhJdFFpTEd3NWJNMllzamRueVc1bDBTUzNaZjZRRDdIQ2Uz?=
 =?utf-8?B?Zk54VWxVUzdCSUNzeFJWMVpqemZXTjZOMTk5K1c3T2Q4SXIzU1JPNitsSHR1?=
 =?utf-8?B?MUhXOEE1ZEpxc3FMbmlRMHcvLzA5M2xNbjU4WGptL25SRUdtcVZKZmVDOWox?=
 =?utf-8?B?VGhwMTRsWlJwdXlqZU0wR0M2WlZzKzlNMEFEQUx0Qi9lc0I4SDArUnV0azho?=
 =?utf-8?B?Q2VJZlpCNEtTUVE1dDhZbWJWcWdNS25rRVd5elZqV1R3bnN6Q3lXNzBucXdK?=
 =?utf-8?B?N016ZkVOVWVFenhFalZxTWg4Nk1QcDRmcDdNRW5kYW9STm8rV3ZURHRaSHNQ?=
 =?utf-8?B?U0gxSXN5Mks2bFNQNEI2MVp6Z01TYTR6NlVmSUNZYk9DWkYzVVAwaHViNDdt?=
 =?utf-8?B?N2FIRmVJY3NsTjdPbE1kcU1QOXVOa2ZTdUJMN3E0YTEzd255WjNWNUZoamJS?=
 =?utf-8?B?b3ZQRWx6RHlCdEhpaC9ucHlxbXNCUTVSbGJFOHA4M1BrODJmVTcyMG9jTXFv?=
 =?utf-8?B?Y0RIN3Z3MDdHbXpialIzMmEvYzZXNEh6d2xJWG9qakRBRFozQjJ4NlpSakNh?=
 =?utf-8?B?ZDdLTkpNM1FqcWFlZWRoR3ZHSVJyWVpnd3Z1SlRGL1ZjLy9iNXo4VUwzSWtL?=
 =?utf-8?B?T1JJTk5lckVwODJqdGhnWFJpUUtqaDI5N3hPZFA2ZzE3bmlYVTVMd1ViSTlK?=
 =?utf-8?B?QTdLb2t2Q1BSa1BLcWtCSm82WWRmUVl0aER6QXVCeW1jVWRtVE9TK1dMZEdP?=
 =?utf-8?B?N29PVit3SUZUekU3TzZ1WWk2ck5PR0tZTFZuNVJUbUlSY0o0a0hVNDdBYlJG?=
 =?utf-8?B?ejBzYzJwZlExYm44RHF1ekRiK3RmbDlCeENjdHpRZER3Zjk3blZveGtkcXg5?=
 =?utf-8?B?VFlSbU1LYWhIazdLckd6NG9wWk1FcVh3V1Bsb0tCeW5DWURlcjJ3UkFaeGFq?=
 =?utf-8?B?eGp6QWdxU2lFUUxySDgxS1FMcVVxSS9vM3g4eVYzdkI0N29lMDlTcjZPYWZX?=
 =?utf-8?B?MnlzaUxOSkQwWlgvaklyVDl1eGh4K053WmozRHVEai82WDFpN2RoTHNDYUVn?=
 =?utf-8?B?OTNqd3E1TGFLaFpzUExYRkI5U0RQUkd3SmFKaFBtZ3IzNDRIcFR6NE9GRVhE?=
 =?utf-8?B?TG40RHZrZkErYXhqWE9HMFlHeGJIMXNKMmZrMmw0c0tmSzBXZXRQZEZ5akhZ?=
 =?utf-8?B?Sk02M056Ry9sTzFFdFRXdVR1QnlDMGZQUE1xUG5sZ2lUYmgvMVVZeDk1TTNI?=
 =?utf-8?B?QkdXUVFiZFlXajFGbWpwK3dabXJTcFZtaFlmZFZ0Ym4xengwWFNIYlJrVHB1?=
 =?utf-8?B?T3dxU0xzNGdTSkxHdUprbmZYOUNvTlp0OGFoM000a0xPRERmR21nUXgwODBH?=
 =?utf-8?B?QUM2OUhENlZlUmFQOEZiMkpQN05IRWlMQlAvRjJVU3NucGFnb3F6dThIbWND?=
 =?utf-8?B?V0FJT0lKVEd5by9JWFZYTzNUaXpnUFhaMmVsTDNqWWJFSXRSa0szV1FzeGhk?=
 =?utf-8?B?cTlaeGNocnBIRmVzLyt0azM3ZGRNWHJYR056U0J4SHNGeTN5QWt4NGVVaHRS?=
 =?utf-8?B?TFY0SWdxcE9xQU5iU0hTL1Evd0NxQ1hldUdkWXBMUXQ4Q01Nb0FkaDExTDZQ?=
 =?utf-8?B?S1FtMDhCdUhrN1hXVmJ0dVZkclErTUNERTlEQXJJYjdwR3Z3RzY1Z2JTbzN3?=
 =?utf-8?B?d0s2RjBrRHQyWTZ4RDlOSFlRK1hzcnN2OURFdWNITnRtWUZEQU1uV2NwUmRy?=
 =?utf-8?B?MUg1bmhKSUV3bDhvRnR0Qk92N3l1MGpRck13QWhwMGR4S3lsajg2cjFNeEl4?=
 =?utf-8?B?NXVRb3h6eG5VajlxVE9QL3k3eE1tU0dURzVJaEJ5R2dlbHlDRS9tY0lZb2JC?=
 =?utf-8?B?VWJIQ1BrN2JZNVVyaVBLM295cS9HeDVvUWhlbHdKQy8yN1N0b0xyYUVtQU82?=
 =?utf-8?B?UmR4aC9MNkdMN0dxdTN6WHh3ckY0c0dFNnZJQVlEcjI1TGxSN2JsMHpDTENI?=
 =?utf-8?B?OGNYRGpXdFE5UGM2WjJJcTR2NWdoZzZQa0lhSnBtcTRNTlk2NnJ3T1JyY3I3?=
 =?utf-8?B?TlVId1RJVy9uZk1IUmFkSklKeDJRa2UyVmFOUkVLTTNWeGpIU2tkUGVxd2VD?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9850344-70f3-4c56-2120-08dc34b433bd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:12:54.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRCyXwHe4DHXDylIlEVpwDq1idEyOcyntuXr9SVUqU1gZafnZtUW0VJfwph1hYP2MFzZf3U2B+mimXf9I6KDbaBAvgUzTMkG5MOfRVBg31o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com



On 2/23/2024 1:00 PM, Jacob Keller wrote:
> 
> 
> On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
>> The goal of this patch series is to introduce a common set of ethtool statistics
>> for hardware timestamping that a driver implementer can hook into. The
>> statistics counters added are based on what I believe are common
>> patterns/behaviors found across various hardware timestamping implementations
>> seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
>> this patch series. Other vendors are more than welcome to chim in on this
>> series.
>>
>> Statistics can be queried from either the DMA or PHY layers. I think this
>> concept of layer-based statistics selection and the general timestamping layer
>> selection work Kory Maincent is working on can be converged together [1].
>>
>> [1] https://lore.kernel.org/netdev/20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com/
>>
> 
> Makes sense! I like this direction, I had meant to work on this for the
> Intel parts, but got sidetracked by other tasks. I look forward to
> seeing what you've done here.
> 

I'm fairly happy with the series overall, and the entire thing read
pretty straight forward.

I'd be happy to follow up with patches to convert the ice driver to
report these statistics as well.

