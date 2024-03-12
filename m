Return-Path: <linux-kernel+bounces-100586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6796879A78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2451F22C27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC9138494;
	Tue, 12 Mar 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqjsJZ3u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCF137C3A;
	Tue, 12 Mar 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263801; cv=fail; b=iyLykG5ZmjggNnKSqArggtJx3Sx7ut2TKluTw5njm3jfbGHAr0Y7rVVhlQEgAQr19V4CFTCrqE+ChEU1S4pDcnDxSpLr4lDYnRoYN+9xGwMOZDTSknmEJbGkwGnzzDFzyESXiB9cJGEFl+klbVCZlEsQb/PwvJzVyCaydSh+ZqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263801; c=relaxed/simple;
	bh=1duY8Yn5D9j5ZY/1EEmXeHl0iWfQVPCFS+S5kAuGX5w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WyYb5ZTCO4N9327yKJCD8x8BJNU0qsV8ixxmYcQaYAmoV6MZMi42xjHdbAwrUgqAzHWTJeSQVnQbtqYGMDmzP1wAzy2OLc6pmHDZroO/mVOQvY+YGHm554QrnBEB4wvz019KK6hXVMxDW7z1gMCRjNAA5GFcT2D9t6zT8m47+5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqjsJZ3u; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710263800; x=1741799800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1duY8Yn5D9j5ZY/1EEmXeHl0iWfQVPCFS+S5kAuGX5w=;
  b=hqjsJZ3uGcKH7L6bdy2w+Bh4apyVXYF2vmhmgVwRwfJAWTxmlD/5hE96
   XWHTgXVcYGu4pNvx/qIdSgTAVOctJq0krb3VihDxQhY60y5y5JCDR+935
   eC7hCorgEogg1MiXcTeRajSH3SwgnhuPam56q5SLDuwXGBhA7bOffd6pN
   c3U7lnpPZwxIxfls2QxBFglbIHukrrABhQGWWhv/0Q1tMWNlpdbEoQi4B
   w0Dp6hkSXR+DH+QDERFn2v4+0k5xZG/u9WxqzAJ+Y+lAp+9SZjiokwdcY
   aVhhDuZitd0eb1FyX/JBdwaT/dewu/ZaWuWYBiyCc124GW8AGuN97XjcL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="27464655"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="27464655"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12205535"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 10:15:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 10:15:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 10:15:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 10:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8IddQOnX+NkfbMmJJEOQUFv8Xr89c7pfmk4SW6EgLxH+ecXxKV/MZVSPLMN/m/n15gfcOWS+C7ghv5TrqWGBXLnXY6D2V1qNsz1ceiR9Ebh1KpxIts3U0hquYYpH22Tf7tpz76kp4EjZdminDKHNESy9lLNIaXHfKzdZKobO75ZCeO6DHaL6i9hKyb5b43dbJJs2pzLdLvkURC3rs9dvKoqAfR8ffcceCRDSGITmnPazic23p2ZndGJyDtGApf1/lR0vzggsUR6ML7uMOQUKPlQcn9kzJaQuJD7/zkDONDucWsMKEs9M3GMnJfT0TsCVIdOVsAkbvpjZr8dnoDqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tEyXd8199aYfTgdbdPhmuKUCvr/oGvGKtlwUC7p3JE=;
 b=bsr78S47g6sxBTKbIXH8dTLm2Xrk1hLyxOv7ZFJjHYeumGLeZGc4DasLyNXz925Sj/8XmYpCl4gXYMOmfN9SAOpvnmY0pFajMCwz9xt6o+fHkPjqLgm5N7HOp/esYVgc331V3oFgSTHPldSfBV/5CwGA5MsNivPAZK/2da1+OFlBlQuwYxfRZi3RPENAAT33nhm40KKlv4ssERjuH87WSiDfyWOq8Nkr13dEDPkeomuA3ovgJX4uYh6FawziibI5+YuoNXmLqpdlB2TPPb8nYlns7swuj7TlML5go/9pQJjIhfRmYp0+YfnfV2+PgROJvlZd51o0ibJSFUrWCVf4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 17:15:37 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c%3]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 17:15:37 +0000
Message-ID: <c0764c01-23f5-4732-a5a4-04ebe4733f22@intel.com>
Date: Tue, 12 Mar 2024 10:15:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
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
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <4b3418ed-751d-4e37-8d72-f2b4891eb714@amd.com>
 <d594a7e0-e33e-4311-8079-14dd56f6d309@intel.com>
 <34e48584-dd0f-47ce-b6e6-fad970546cca@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <34e48584-dd0f-47ce-b6e6-fad970546cca@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DM4PR11MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: a3239c61-2141-404d-af6d-08dc42b808e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rBTEZt44uH0BuASBCiNvGi8YNyMCY7yHspUw3CEQqrq+TkFifcKG1WnQp7fUScK4NFrviaeblNvmUhxaZFiLP9aouYwnZybsMjv0GzZcEzXzlN0NPNN833UfQ53XTlgmYZYIoxgLmTjGUCN0FSu32817niM4Bg4UCnwcJJufNRMiWNLov5n5LJjeTOPhGeIyqeUEIz4DyfOPR4F3z8VDgD46C/ypPIonp0Qh0dMfUojN7dMaK3a6pV+TqI86nuVGJfvebqfiUG0Uo4yiNCU4ZRsHGDyzlNLA5HSSiWkupG4tMpS5hK1TjCUBAFqIhmaohbewEunLJ/wSIxESFVLaGiAhi1ssgqI9LHpUiTAnV2mojhW0npU+v+6cdT2PNRbGV6O0+VblRynf2jXaXoq4WQNDYfMc9mYN8NQ8+EApR9j38JNLnrH99cv0lzfqU+3J9FAA/VTWCNhPyvzxaJESgwVX+/qwQYuursRXeBcTNvrtQifJNGrxcHdogMHoc91fx4sSakZrEgGNkEqZsgNWArJjtcKtdE0BOBVqUXqcxEOEzcCtH8MmfhOI9c2rjnSVHseMofGGjb3SvGz7W4OhOztAalpJ57N5QbuoKYQwscNVLiLbAhPNgxQPzriExZHxdxNogumq+QqqkxyM+TnRSIq/SaFANJAOhPGLNzZAE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05salMrZkYxbmRXaVJIRUZRdG5zTVFsOEE5QXpnbjZpSitnTWkzRHl5QVVx?=
 =?utf-8?B?V2plZHpQVnMwOFlpWWV3Zit3bVFZUUViZkJDTEp3OU9yd09ac0xGMFFxaTk3?=
 =?utf-8?B?MVZFWVRnZHJnRTB3MlhZc1JnRFJtSmJCdFRYUlZyeThTeWNqYnF0enhOeEJx?=
 =?utf-8?B?M2JyeXFTbTEvUWJMNTU4RlBIdFlUVnh6TU1Vb3BkOHcxTGlJZVptWnVYNUNS?=
 =?utf-8?B?ZlAxVC82eFgzUGlOOFFQYnV0Qnh6V0RGMVpVK2Z4Q3VQcXhEY2dGSmlEUEhF?=
 =?utf-8?B?QnIwMmZqODUrRVUwTmtjMGR5cU50SWRUMkxUNndMa0lMVU9XdXpDeVpUWnp5?=
 =?utf-8?B?a3VYZnEvaGZ0cXVCLzJUNDdzMVF1aWErTjFEcXIvRThOdGowd3JldHB3U1ND?=
 =?utf-8?B?akI2MUNnWkx0SlZjWWpnTXd6bStnZFNiU29JYU0wSUgwUDl5MWpTYUNuRXFP?=
 =?utf-8?B?enppVEtKOFBkUkpiSDZ2MEthV3hxZkptVDZtVVMyZjQ0MWdMWFRFdTlRQ2Vk?=
 =?utf-8?B?YU1sUVFKcUtGbDFxZm9ISE1MT1dvcDRtWkNPT2U0ZVVBMTdKaFBoeDZUK09F?=
 =?utf-8?B?cWRDcmZsZTNoR0dBSTJaanBlM24zU0srNHJYaHFCV2h3NVE4dk5BL081MVZP?=
 =?utf-8?B?SGdhQ3pIQjNMMVdEdTFwQWxwWXFxVVd2Mjd0UXZWTjhHNjhpRGtTYTVHTGwx?=
 =?utf-8?B?anFRajhnZU9kYzFOdXBjK2NJY3A1WkxuRlZTZ1U3enVZQURqbDA2VWdFTWN0?=
 =?utf-8?B?R3pwc25QN1RFUWlIak4xcmpiaks1TG5pekFsR3dpRlBvRzVDbFhyRDZ4RTVH?=
 =?utf-8?B?SlBRVGxGY2hTeHFZMmRpQU5QSjFCSzlEWWxCNDlKKzF6Uy9nUHk1aWxOZzF6?=
 =?utf-8?B?Njk3ZnBTTHd4RUN4d1lpbyszdlBWOFFGa2RBTWIwcEdwN0dudThodSszUWlN?=
 =?utf-8?B?blo3Sys5ZThOM2RlQjRINUxoV0lHQVU3NTcvMFJJVlAyU2NOQUpGNlFpaHRD?=
 =?utf-8?B?U2p6aHdwR0pmdG95bzVHR3g5VmJna1FPUnFmQWFYWlBlb0xFajJMaXdjSU5Z?=
 =?utf-8?B?dVQ0OCsrOW5idG5OMmtiN2pycmc4anB1QTJER1dXTmhYT2xJQjQvK0JlWDI4?=
 =?utf-8?B?OGhkeDdHL0UvcUgvNmdTcUFqdC90ZWoxMlhFVk1SLzVQaWdVUy9jZHRMSjNY?=
 =?utf-8?B?YVFvUWYrclEwc0NGVGtKTmRLOWJscTM3dHBNU1dXMEtuSGVmVldaaThUTkV3?=
 =?utf-8?B?U2tZOW9PTnl2bFRlb254eklzMDVCeWRPRWlpck1vNVYyZVhBZEhrQmRiQUh6?=
 =?utf-8?B?UVpvcmQ5V0ZQVmNnRyt6YkxJL25mMkJNaWNKVk9uMUxKR1dWcSszVmFaaFo2?=
 =?utf-8?B?Skp4Nk1BbW40cUFtazIwZ1BYbmU1MjlRbysxdFNRd2Q0WXZmc09hRVh6c0t0?=
 =?utf-8?B?aEVydjRCdThabXdMalJwTnhLc3ZDVTJETFVhU3RaNE56ZnB1dEFta2wrR1VT?=
 =?utf-8?B?MVdWaFBwM3hFR2hVL0NEMzJsMjhOWWRNUk9RUTF5Nm1jMXhDTERoUzA5d2ZI?=
 =?utf-8?B?ZUJidk03NGJySnBQNnp2VGVzUkM1RmJmMkE0bG1WUkllSjBIbFFFOVZkS0RB?=
 =?utf-8?B?S2haRzN5ZmdkL0VXd0Vma0tvdDAzSnduVENLaTFMcUh5RXBCU3ZYNEttRVdu?=
 =?utf-8?B?ejRmUlFBdUFFd1pvb29LWWU4WjdKVTFQRzZaTkRqOEJ4WFZJVzM5YTZSM29q?=
 =?utf-8?B?a05UbFVoek52dVR5cm5KbVY1a3dGdFJITXRmTnNsYU1DQXh2S3VkV1kydU5h?=
 =?utf-8?B?dnB0dkp5d2NsMzU3VndyMWtBSkVBUTNFT201d3V4V0I3aXFqdFN4d1AvRERF?=
 =?utf-8?B?L1d5aEVIU2txRWxwOVdBdnJYQ3d2M1VWMmZGeXJndlZHNWd1Q1Y3UkxnWWJt?=
 =?utf-8?B?emh3K0lUM0FoVE40cERqMVQ1aVFyWWcwRFRtL05ySkZsQmVNZDlOUEhGempI?=
 =?utf-8?B?bStqaUcyVlNteEMwTEtrWEg1dTM3UW5teTNjeEVGRVh1UHVBMEZpVmdiTzQ3?=
 =?utf-8?B?WGo5SDJOTHJvb3dsZFYrQ0ZJazJxYzRlK2RmNitDNmVaN3VyRkYrYTc0bHdL?=
 =?utf-8?B?RmdRWU5xTWhyS0NYUHNWbGpGdlNvU21YeXNicXRqYzZVTkZWT3VEakJzS3Vr?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3239c61-2141-404d-af6d-08dc42b808e1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 17:15:37.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+q8p9sktQmb7oAZ8x5adt7JLtXS8eF6bEgulFvKDuFIskq6LWB/JELgdEruhajGKT6y64t/82KG773Bt8zSo8ZNOwC0S5noPJRz4ackhUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-OriginatorOrg: intel.com

Hi Babu,

On 3/12/2024 10:07 AM, Moger, Babu wrote:
> On 3/12/24 10:13, Reinette Chatre wrote:
>> On 3/11/2024 8:40 AM, Moger, Babu wrote:
>>> On 2/27/24 17:50, Reinette Chatre wrote:
>>>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>>>
>>>>>>>> Apart from the "default behavior" there are two options to consider ...
>>>>>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>>>>>     the counters are reset unpredictably ... should this still be supported
>>>>>>>>     on ABMC systems though?
>>>>>>>
>>>>>>> I would say yes. For some reason user(hardware or software issues) is not
>>>>>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>>>>>
>>>>>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
>>>>>
>>>>> The debug option gives wrong impression. It is better to keep the option
>>>>> open to enable the feature in normal mode.
>>>>
>>>> You mentioned that it would only be needed when there are hardware or
>>>> software issues ... so debug does sound appropriate. Could you please give
>>>> an example of how debug option gives wrong impression? Why would you want
>>>> users to keep using "legacy" mode on an ABMC system?
>>>
>>> We may not be able to use "-o debug" option to enable "legacy_mbm".
>>> With debug option it will always go to legcay mbm even if ABMC is supported.
>>>
>>> For example when ABMC is supported, I cannot mount the resctrl with debug
>>> option to test ABMC.
>>>
>>> I need to have a way to mount resctrl with ABMC and debug option. I can
>>> add "-o legacy_mbm" to enable lecacy_mbm.
>>
>> I do not think it is necessary to add a unique debug option for this.
> 
> It makes the code simple.
> 
>> What if instead the "-o debug" mount option exposes the "original/legacy"
> 
> Can you please elaborate on this?
> 
> Did you mean following command to enable legacy mode?
> 
> $echo "original/legacy"    /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> It feels like a overkill and confusing.

I used the "original/legacy" text to make it clear which behavior I was
referring to. It was not a proposal for a label used by user space to 
select the behavior.

Isn't /sys/fs/resctrl/info/L3_MON/mbm_assign_control the file that will
assign the counters to domains? That should not be the file used to 
select the behavior. You had /sys/fs/resctrl/info/L3_MON/mbm_assign
with which user space selects behavior, no?


Reinette

