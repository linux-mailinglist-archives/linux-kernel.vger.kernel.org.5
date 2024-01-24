Return-Path: <linux-kernel+bounces-37510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688583B113
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6321C2257D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82BE12AADE;
	Wed, 24 Jan 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9IOxFEj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326312AAC5;
	Wed, 24 Jan 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120728; cv=fail; b=X/LqG/yNmP+AJYfSj3gLQIdpdX6s8IK0Mlh+q8HPsBz8lH3FA8I2xEakqsfQE/eQxJborXkr/rKuLSdCSrSOpujpd2Bdegj9B7LInHUXtIMyzZ7u2A/g4upYio0ECz2tnfVtvDLkh14IG8RVTfy98bzhgLoJIYn4/X7efrudTfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120728; c=relaxed/simple;
	bh=J2Qum9FDma1dzbaxsEYMsXEtxeulBszVpFJkxHk+M+4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L76R0pWHchXVC2uQzkJZKUPQ4PUGVOdGACOs09XidLX2Nmk4Invaq9VHAxVxkewIW6BOe8A9ITRNRokw4nS1PRO2+XjQSZq1ee3DyFjYUcpqc2CxxaAQuITj/GgDVKcOM/MjbUPDTMFHbg2RdfIM2rSTwupyzxLGw+aHW68dGQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9IOxFEj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706120727; x=1737656727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J2Qum9FDma1dzbaxsEYMsXEtxeulBszVpFJkxHk+M+4=;
  b=X9IOxFEj8zGLVLSCUi4bfALVAbLNnjV/ceO3NntyhLtIlGfe4/ptjwa+
   9lzG1YrtvgXDXfYBUe/q8E4KBIfTA6AI6bMB1lYJZBhbNUoYQUpTdT/B4
   cTHOHzR50P+A4Ic41xehgr7KIfJlMbPViSftVgsakp8E3Ul+lQgIh5szV
   hytHnQ7AEBOa7nQb2fdX5zBhdfBljBjMpFVj8tAG+Gmflk6peNjvLCOHR
   y8ZISd1fcgDBJWZvYIpHV3qLc9axLAMoqqk8VC3WmQNVa6eRDMOP7sRJ5
   YeyvOR/lpjXrlbmKF0fhgOIaF/6ALQfwCOTUiWEX0sd2Ds2TMYQxtPFPk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8698734"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8698734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 10:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876778044"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="876778044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 10:25:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 10:25:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 10:25:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 10:25:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 10:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqLjmVNGbVDu3sbUanIicLIorbXuRJUyRslorf8MQ7+EadF5dnFtBqKV1Ga7r8/m9BiodrWdMdkNWjcoCahv7mH5QrvIi9rrAJb1gcZTspXAnq2pimvWQvadL0SNFBjnIdpiJagQBY4boHSj9terZCyTDmqGxO5kAjLeprOorKX3N/YwcSwf356Jflil2QLQuDFx5DFDf962pR2D8s6mos7QHslJnm5XW4awrv5N5j2sP8Aflg4RugSBDQvPKyH+98Zq/o4RLtuz52AWCqycZJA9H4JgRjKqrQxsEJmaUJkmhzV8HfQzwikgrWZCG0D9R2Ru1g2aUi8FanJBn1knLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1+3dyPJds5MomOEdI15f1sQqmXff7rJ9cT8AAFS+Hs=;
 b=FufWJPPi77wA3ev2Hts2rEHkyV0JRH2j7B2hWOkzex4WpJHqXnFiCHf6ZkE5y9rL/ZSGNNeOxTgRUj0JWLWINb15bdK7ZW08dU0cM1UpY0hvsQWyoB5foqiSS4O4k5A3g9mztUB4SYNNgCQSOe0T2Xyid8zvrWIhAiJJwaJcLjONXnrHD54pF3X/c3NjmEfhP/N55ur1a8UfhvigTcDsRZ5LcJG2wOkpRTKWfnaE93gaNUn6hL5IsORUp+kZs9qE0vNjxlSsFXmtPawn7rv4tT2vdyYJeDRbuwWG0kI5W+B7kCsT+yPACP3dWcqSCOfCS4dJEyzZuXj6o/nN+9FNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 18:25:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 18:25:20 +0000
Message-ID: <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
Date: Wed, 24 Jan 2024 10:25:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d7ac80-1fba-4029-a21a-08dc1d09d226
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxez95GLbvSJjB58/heC8xpEZxClFN7sdaP4o4I7tBfwsU/CZ3FbMarzbMtbVVLKwrsnD/zDMDaGyDp+XZwjicuOL3mItHeBtrnrABPYf40u48t1n/xJon/eG0AoHslI2R4avl+MNn5s3RZADWrNwR3SnUQVtRGazMSARm+dDCQ4qyke7ZoWLF8f7TbUIxqS/btvrnfv9dxaCVoVBrQnjYx6qgYq1x+nP7//iLynAlBREj92vVNBMAxZl7+254lQkpAm5m9gQY5qW77WptLyTHDi4tEeeB6KA+bSnoaJ15qNgNP+J7Rwb9qla30tQJoHkcgNEUHydCbovwfdsqT0/sax/9ubMkTezBDlg0ezE3nBwGRyy+5TWVWbpEGdR1xkc+PoQ8Zg7uaqfxJCbXGlW5LeOIGyUqTQol9b9n5+qQ8ciK/nQpUmnFmJddePO0dTD3lDJZULV0sK8VIyY6tS/ilB8vUtjZKiljBi2tBi+7LYKczszDS6EXHx2gPHH6ghPxkoJOsLbpDvwBoVGKOMAA1OK3decLDcqyFONuf3AhGh70t4rvYselifw7kMHTqJG69/vs7jjrx5Zprp8ls6EYYWE50LZyOScdMLwIlD5Uzd/fFaj/QELu9483Ya8xQ+exDUVDrJZDhwufg5CF8CID+eDDhRm2wImC+tNmsyrd2z/OMXQ0lfQVVPUId/1M75
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(66556008)(82960400001)(38100700002)(478600001)(53546011)(6506007)(6486002)(86362001)(31696002)(41300700001)(36756003)(966005)(26005)(8676002)(6666004)(8936002)(2616005)(4326008)(316002)(66476007)(66946007)(7416002)(5660300002)(6512007)(2906002)(83380400001)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NytpeCtpUXJFM2k2MGdZNURvWVYvUDNBaEYzR3JwZndZZktEaU5nMmZhM2sy?=
 =?utf-8?B?a1EvSUJPaDh5OGlqekY3ZE8wYmVTZW5BK2pya1dhcmVLRHNFbVRGWmpYOHVr?=
 =?utf-8?B?Z0JZSlk1bFU1Mmh0T1ZYd1JFU1Q1eGhhVElJOEpscWlNaytwYXc3dTNCMzB6?=
 =?utf-8?B?UFdjaG0rNHpONXJJVDFTM1NWSStPVmowSmkzYlFMYWRMU3lqUW5rUWN0OGFM?=
 =?utf-8?B?Q1FKa0QyM3BadUw3Wlovem0rNUMxcmRKTUdwWU52L1VvUTMwOXpwWUhTU1Vw?=
 =?utf-8?B?ZTBFd3hGQ0ZEc2FvRHYyRVNSeEFCcTBmUklac1YwUDh1T28wdS9lNmJsVUha?=
 =?utf-8?B?Y3B0V1lPNDlZbjNqYVc2VXZINnV3bm4weFRkemUraGxxTnc4VE1ZaitZTUN4?=
 =?utf-8?B?WFJ5dXBwZ3hmQU5kRjRoTGMxbTR4TVBaV0RrbDNZblpWQkIyUURzYlR4TG5j?=
 =?utf-8?B?UzdOL3A5ckFLTVJ3aUFFdE0xaTNBNnJCMWVRZ3ptQ2YzVWJjQ1ljbXpwMkxn?=
 =?utf-8?B?TWFGdlQ1eGdycm9maUZxVkhpK2VkdlBCdW9YN1hZUjBFcndudXltamk2QU53?=
 =?utf-8?B?RWYzKzMwYzBHYklYYnBUTGxFajhCYWhxM0h4RXlYOVJrbndhYjUweUdqdjlL?=
 =?utf-8?B?Yzg5TFcrUkRNd2tBaFptTndFbTYyTVJHd05kbnJWdG5DSXZOR1FlWlVKM3Q1?=
 =?utf-8?B?eE41QnNsZmx4eFloZ3hFazc3UUdYVDNOL3lKZ1hkOUswekc0N0VOVU5ZVGV6?=
 =?utf-8?B?eUFtNmNGL3NiYlA1WkpuUDFNbEwzRVNpUmhVZk5CYSt6TFRicWdqbmhsNHlW?=
 =?utf-8?B?Z01OTncrZW1RSVVwMzlHSTlML05oaWd5Y2lMK1IrMGlzaFhyVU5udk45RGRK?=
 =?utf-8?B?N3ZnSFJLWnBzK1pheWlRNHJlL0tGSDlQNHhSeC9nVlp0TTJPU0lUTnFtL21E?=
 =?utf-8?B?VVlTdVc0RHJmQXBDajFERmRsOFpQbWo1NURoWkhNUWo2Qlk5WDJ1TFRQL0Nh?=
 =?utf-8?B?cGx2VzJRR0pmZnk0YmRDN21rMnJyanJlc2l5cUN1RVB3L0lNZjd1eGp3VG51?=
 =?utf-8?B?K3ZtcmNocDdyVGxpUk5yVnd0UjdTaHJ5bHRmNllzY0RjOWxpTVM2RVZxaGMx?=
 =?utf-8?B?dDc4L3NpTFNmMzltaTVCTnlOTFIzSWlJVlduQWgvdjA2SGkvTm16YWdRUDVL?=
 =?utf-8?B?TWo1V0xBMDdRdzdSYmRUV3pob2Q0QWc4QlE1ejVIZTBNRUdvOWI2V2tERzhK?=
 =?utf-8?B?aFdoMkk4d05ndjhNUkRDcy84NUhuSTZhQlFHMHFqL1pKUS9DTCtHbmdBbElv?=
 =?utf-8?B?V3hib2dYR2lsbUkyemtPallDZHRPSkJNRVRNejhVYVJuem9uVjJOZkpUSDBv?=
 =?utf-8?B?bnpMdlZiVnBUQVordFpVMkdzcnd5eGxGajNmek04TEtleVkvSFIxaUJlVUYz?=
 =?utf-8?B?SDR2ZzcrTEVIRktxbXMvVGQ3dUoxZk9hR21ZZElZQjhpZHVrZE5CN2N5aFg0?=
 =?utf-8?B?S0M3SmpXYXJqNFhRTFBnSjFENlllRG81bGJheklQK2hPQU81MGlGMHZsSUtx?=
 =?utf-8?B?cVM0RitvOXNpaXN3N21SQ2krdXBoNlkxRzlpQmNwb2ZNd0RhY3ltVjduMUpI?=
 =?utf-8?B?QWdCQzhRcnBqN2RVYWpHcmY3Tlo5b1RzNFhGaThCZWF3alJjK1Z6N3k1ZGNL?=
 =?utf-8?B?Z0dzb1NWaWFZVmgxRVVXbk9kbVM2UW1rNDNScms5ZnhXMTROYW1uVTlGTm1D?=
 =?utf-8?B?MDEvUEszcW9jVG9qZVE0ZkJoQXhGRXMzaWl2dGROaUJCbEoyeStBejd3VmJr?=
 =?utf-8?B?UE83Z3ZHcndOWi9ucW8xRnZrMzA1WEkrS0ZEUmRHbGl6Qk9DNnoxNllVWmNE?=
 =?utf-8?B?dytCbzYvTjZHVmUvb3ptc0pLWFhlUmVUcEpJSzFHaG92SzNmNnZqNHdlRFhx?=
 =?utf-8?B?dG5lays4amc4MytMK2lNakE3YzZuVkcxMitOSktZMHZNZytDbjJ4OFR3d0tj?=
 =?utf-8?B?TkFWSThMM3dBempIL3hmbVlSWExkdDFKWStwbjJmOVEya2pUejJTWUxRL3o3?=
 =?utf-8?B?anB4T243cElORVg2dG41bCtWUDJqMHg3VDRlMzA5OWd3Q1V0cUtQYlpicXd3?=
 =?utf-8?B?TmEwaGphTFZGZWQwU2MycEhkOVdRRHlWdmRUVVhvN2V0aUpFa3Y5S3k2M1hE?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d7ac80-1fba-4029-a21a-08dc1d09d226
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 18:25:19.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIJjYi/3sdjeP/lh9HN7R1jo0ASl877KBQVp2A3qhiF3l2B7JNh7pmfjC5h2Fcq2pYoRYz0FTcKOtl5a1Z8uEeXw9C8fueOxTssbBLGEXb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

Hi Babu,

Thank you for fixing this so promptly.

I think the subject can just be:
"x86/resctrl: Remove unneeded variable"

On 1/24/2024 9:52 AM, Babu Moger wrote:
> kernel test robot reported the following warning after the commit
> 54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").

This can be confusing since it implies that the patch you mention
introduces the issue but instead the variable has been unneeded since
the original:
92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")

To help clarify you can mention this order of events and also add an
appropriate "Fixes:" tag.

> cocci warnings: (new ones prefixed by >>)
>>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655
> 
> Fix the warning by removing the variable "ret" and returning 0 directly.

cocci warning was spot on*. This fix is not just a change to "make a
warning go away" but instead fixing an actual problem.
It can just be "Remove the unneeded variable and return 0 directly".

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reinette

* I'll add a private setup with the goal to catch these earlier.

