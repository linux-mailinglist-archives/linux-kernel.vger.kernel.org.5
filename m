Return-Path: <linux-kernel+bounces-100417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6C879738
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF57A1F23212
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5D7C096;
	Tue, 12 Mar 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beV6AqNM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722826997A;
	Tue, 12 Mar 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256436; cv=fail; b=L9DD8mSojnBtqepOXUrRQ9hLiZt/B2UjDIJKmH/xHccw6MYjuAtdkxCUC4j2/TSIoao2vmAn9Qs5Z4HUv5m6q0QvgdfjLWAJKga3+QnEDq31NGQvNAKLdA2pkJKwDMDEio7cm8X/QWdxdbs6tQR+pt1+FTScCJYInPcTd8It3ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256436; c=relaxed/simple;
	bh=9+biMGPiIsKF2GhEhoUgrlnUN/OsvpkXWmoJUXjIypA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JQ33h2FNoiDrBs0vqqDmArFByWLTlz6Ef+n/7MPbCwgxsraV6dHaEr3e1K0Llw2YJ4sjd7yaZ6nnVJ4gzX1zs2SMUf+hFa6LIX2rwkyMftD5nXVs04XKmQD0xhHS45+cH+pMeKjO2H9ctcdAoIzls4h3C9ZK3Mofnd5IKOkaHYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beV6AqNM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710256435; x=1741792435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9+biMGPiIsKF2GhEhoUgrlnUN/OsvpkXWmoJUXjIypA=;
  b=beV6AqNMXe1JQE0CMo3+9iB1+1lHglQIUYGoXYJ00+q/SGP+GaVzUtB5
   yis9L7NFxj8OmXCzoPXKHAUzSsOzuruU+mCB2U2HhL0jCrxRpRVg/wz52
   c0k81s836iw1/ATIAfTIjP8gjl2xp73oWYaCtak60LIf4DMvTsC4iYuUp
   O+nUPeUk7ZZG49evaLwGlWW2OOz76rqggG1vqL97G47dc9A3kUQ0lR7vb
   NNSKM5+9MkuxfhvCN6LoNLhQToub1+bayR5wCsKvizixin6tozXXW6bt1
   YCAneSAbuncNPc0JYh76s6X2RLh4vM/r3yTYlJTB7kzx8vmIDO+K+2qGB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4823451"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4823451"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="34741383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 08:13:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 08:13:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 08:13:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 08:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjOPqpfqtj0QazoSZ4i7E1rRIThOpgWTvxSTQSDP8y7U7koN35sTmmCz+OCp1d4FsuykgUsEIj2Bc2GCiTcrk31CBSkrxg2doXj+MC5VEIC8LQzx/AUW1X2Y7uskhz9NfZOEvSxpA2NPoyD8JQxqZJ5Y0uNrO+RwDLO975ZC81fX4Y4C5j5St5/454oWs3ZYW/IthYttBrr+re65sAsl/F7JoFfZ8gv2erzv1cWAHFdZUTboo2ElEox22Gn1oPK/91tzzpWqWpF3Jj1fiJj7vkwLx3TIyBNXBiY5OGDI6k00mbdUDJamDgWqiKx1Fc9rpi2/LX2XPutDPsUebZXHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xQcQ8VEnOVNMfg2zLsvBe2yFik8pbvFOef9F6ondzo=;
 b=eTk6oPTkSJesxX+EsuvqPf9+f8l80eJTDqQzWgkdWjQpuB+SPpxamui0c/5F0wgN22+i8wlO8Eo/vF8mc8+X5ymgmIAOKm0NTfmFHbl8D1pR8Cpim7o1ZUMrTi9EDCabzi787hVcMxYgF/GVOfHQF40fL7XVTu2xWnBVNcGRMC8oMwpuWPaxViksC9ltRF7J0ZF7x/L2hefNa/BLxmsDufD6mtCz5H7LZyxJNLMypAElfkj9k/0yAsFYLeXLqWK9ZUhkAAseGml0XrnwynTIuImOmYLg/Xpbmywrh0jIiAMANKd+MaQ0Vd12qWT/8cjoKarBdewXpKjhaZuWhZrlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 15:13:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 15:13:44 +0000
Message-ID: <d594a7e0-e33e-4311-8079-14dd56f6d309@intel.com>
Date: Tue, 12 Mar 2024 08:13:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4b3418ed-751d-4e37-8d72-f2b4891eb714@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 61464892-99b8-4a36-747f-08dc42a70211
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nD8aW1SHYrGf1Sv6e3zY9GlhEeVCRi32J1roCTOpSVYP2Mewf3sDOXmvfx7Bn9a1vrjNmvFfLusRVll/Jk1uMimEyY6TDV9Hx3lSIY7U8PqSYPybnzJXPQgDFxYX9TMeEcf6e2tVctQkJY57kcz7WFz18fltZXmJvcZa5z2av0GRALqq/eADZALsI1QiECSW7axxhbaHp80/VQDTNrdirFoMSSU2e9bx9bwMxnpUaubJUUMXayvis/XqaTdiYl+gS467fYhSSZcIkBvNfb/zKpiDeaiVzbm/EGLSfmNCnzGL04MUzGEsm6kISor/cwp8pTQKqbPX4mr0tv8YHuCtH3HYQ1dmWagFSFs5At1z3VFcETGMA/WaXkzq8Be8i2bZaUmLANnzVh9hqwlvpsaqD0b/KmPS/Uqp/xbf7MRzLFWufktXkszGpW+0WMXOq+OuovU9M69QfQGQAry/tfr+0a43iEomB8JVwUrXLbvYWYhnHEansFPUSWXamoVBVaVVX5kg59rVizUwYucEMQG4bZ2abtDf+ovjhSwMDbuJUlA82naFwycMPcUY/pPq1EFERMXnd7PCgcOhr0onWW4J8Hkhhme8yUsC+L5FZdVJ6UBhyK2gNcm2vqCgZbkln9xiIRLZW3TC1hlLV8YDhpu3s7NxTw1TMe7ZjQ6YBug61A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnR2elhTSEpLN2FrV25HZjhiUy9kZHdtbHBKQ1g2TU5JOHQ4RTIwbjNkVVpz?=
 =?utf-8?B?Qk5YRUtBSG1EU1lCRjNzdmoyUGc3b3VONUgyaW5EMHp3MlhDYUlVZ0dkQTM2?=
 =?utf-8?B?VFZXV21zRTc5VnRqRlZKcFFHWDFSUElaY1N3TU5PMEVYL2RQdm11ODVwWFUz?=
 =?utf-8?B?c0xmVVJzcjRQZG0vRzFpTldBZnRDUWpqTUIrckZPc1lkTldpVnpVQ1AxK1p6?=
 =?utf-8?B?Rng2YWN4RGpGekZvWnZGd01nOS94K1YxMTBUd2xzTDRsd24wODBmWVdlVndn?=
 =?utf-8?B?c3R1SmFMUEZNK3U2SXRQTkJYU1IwaXJ5WlBISktuZSthV3VlTVU3MnZnclYx?=
 =?utf-8?B?NGkxVFhoVCtMaDBFczMyWlJCVUdVUUVQd2RsczNkQ1VBQXZlcURyZDVyYk56?=
 =?utf-8?B?V1V4UUNkUjk2SExlWmZubzRrbDdOWDJBTnZIVFJtRnVVb2dRbVJkTGU4OEE5?=
 =?utf-8?B?TTR2YXpuUkpnMFpuNVhxSmVNNEpmVERoMUo3elFuVDNhVjBWb2xiN1ZUZEdI?=
 =?utf-8?B?K0VtQ01wVmREYllnQms5TjB3Vy9XRndQVWdXQWptbnQvVHdVMUg3M3ArUVgr?=
 =?utf-8?B?L2JOVWdJWnBvbGp4VExGWkRYZFdRaGJhZzlBSXhVd2FSVGFtcnRtcVVJMmdi?=
 =?utf-8?B?VTJqMC9WQlI0NndFeE5EUGFnNHl0clFTL29lZ0p4aDY5UTFJMDROWXdaUlo4?=
 =?utf-8?B?VVA1VnlieTA3SHB5aVhqcHE5Yms3OXJYbHVNd0VYMC9PY0FhdCtVQzJST3Rq?=
 =?utf-8?B?dWFBdFdTc2N1aFF3RzlNdjF5MDFxdTlqRkhoV25aY3NrTmQwSU1HVWJpVHRp?=
 =?utf-8?B?SlZiV3o3NkRjelJFLytPb1RkR3V1Qmh0eWxTalRaNS9rbDZKS3dsODlNeVFP?=
 =?utf-8?B?aEZ2QjZUbldBVk1mWUp0QzZKN3lmbUZYQk5KWE9HZ3lNTU1YY20zWUZFVnh6?=
 =?utf-8?B?Y01WdmlBRFhFYUExUmI3WGFTMDJlWUE4RERlSnJnenJIOTN5bHN1cC9IZys4?=
 =?utf-8?B?S1UrRDRYazNkb1hhNXA0M29FSzN6RVlVelVrdVNuTWVuNXVaOEhBM0FueE1o?=
 =?utf-8?B?NEUvbHBFYnRVa0wvWGVPM3JIaXBJTTNsa0tZOFVpSFJWYWZ1b3NxUzB3Ym1q?=
 =?utf-8?B?eERWdFkzM09ZanlsRWdpcTFINUdEa081N2xXL256clRMZXFmYURveTJTWkVz?=
 =?utf-8?B?c1JJYmZGTlRqUHAzYWNCYW9XMFZLZ05nQjFUZWZuTlBOLzIrR2I5Uy9wdEdE?=
 =?utf-8?B?OE1ISHN1VzRRcHpEenEzMjh1WVpwbjM2Rk91clExblpTeGhFSnIzaThqT1lW?=
 =?utf-8?B?SmpFV1AyUU1COTI2T3dydDJOZ1c4Y0FQd055dmN0MHdEdVhCeVJxSmhNK0dv?=
 =?utf-8?B?QUUyZzllQWIwbWJ3MElPc2tnQWZQWlJidlR3bUZRb2xCNjY3cEJodEV6akxy?=
 =?utf-8?B?TTN3b3l6V1RZd3U0dEc2U2xGejAvNEZoc0lZNnVaVklGSUpZWGlrMDQxSERk?=
 =?utf-8?B?UnZhUW95K3VJK0poK3BOTXd4OVYwOWtJUHhHaVNqcU4raHRjL1BlVm9SYmpk?=
 =?utf-8?B?REI3MjkySCtOZHgyc05Tb21aTlhlZVgvREg4alVwa2lDSWR6UlgwMWIvdjF5?=
 =?utf-8?B?M0prdDhSTzVobktUYjZKUGx4VUtFcEdGL1Y4SEdLNUQxWWlqM3lGTll1TmxH?=
 =?utf-8?B?NGl5RDNUdWprTEFtYXYyZ2NBaWJEZmFtblJsTDZOWGhGUHR4NFhqUTVZNllE?=
 =?utf-8?B?UUI0ZGJlczIwVy9DUHJtQVVUVjF3L1I2QmNibExyY2phM1VCcmJEVWlQM1l2?=
 =?utf-8?B?aDR0YTV4ODdOcEp2Q3dMR1J1M2tFK29WSXhhZ01jcnBPdEtYUVBRMndaNlRQ?=
 =?utf-8?B?bjlQVEpiVlh1dC81NnBWTUtmT2c2SlJ1Z0hENU9XQ1BpNHU0d0lGNUNOR3FQ?=
 =?utf-8?B?Z0dOVkhyZWRuWXNtKy9ZU3YzSFlReWdKTEhMYm9aNlNRZERCajlQNldiZFJz?=
 =?utf-8?B?dWROazA3SERoa0t3dWZjaklpN3M3c0JrWHNyLzJFTklHUU8xUlFlblp4QllI?=
 =?utf-8?B?Y1hhc0puNE1FSWw2OHNQaitDZmR6U1N5cVJTd2JYc21RZFMzcEhoWTZ4WUFx?=
 =?utf-8?B?S284cmYrWkkzNmJvaVl1dXJhNUZySnJ3cFZIbjd4NmJiTmNybVA4MlZOalpE?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61464892-99b8-4a36-747f-08dc42a70211
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:13:44.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URLCa5LF+avQg5BwLSFyUgjhO90lbDbI3qjofiF2Py23jJ/JcyLQKPQnV2AWBQ2FmBBSpHO4ztoYisT5791YyxNWh1aD3lq/52xyko4jzw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
X-OriginatorOrg: intel.com

Hi Babu,

On 3/11/2024 8:40 AM, Moger, Babu wrote:
> On 2/27/24 17:50, Reinette Chatre wrote:
>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>
>>>>>> Apart from the "default behavior" there are two options to consider ...
>>>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>>>     the counters are reset unpredictably ... should this still be supported
>>>>>>     on ABMC systems though?
>>>>>
>>>>> I would say yes. For some reason user(hardware or software issues) is not
>>>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>>>
>>>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
>>>
>>> The debug option gives wrong impression. It is better to keep the option
>>> open to enable the feature in normal mode.
>>
>> You mentioned that it would only be needed when there are hardware or
>> software issues ... so debug does sound appropriate. Could you please give
>> an example of how debug option gives wrong impression? Why would you want
>> users to keep using "legacy" mode on an ABMC system?
> 
> We may not be able to use "-o debug" option to enable "legacy_mbm".
> With debug option it will always go to legcay mbm even if ABMC is supported.
> 
> For example when ABMC is supported, I cannot mount the resctrl with debug
> option to test ABMC.
> 
> I need to have a way to mount resctrl with ABMC and debug option. I can
> add "-o legacy_mbm" to enable lecacy_mbm.

I do not think it is necessary to add a unique debug option for this.
What if instead the "-o debug" mount option exposes the "original/legacy"
behavior in the control file? This would enable users to only use this
behavior when in "debug" mode while still able to switch between
legacy and assigned counters.

Reinette


