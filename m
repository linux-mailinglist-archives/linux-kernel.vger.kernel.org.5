Return-Path: <linux-kernel+bounces-37693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6859683B3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143F428776D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD371353F1;
	Wed, 24 Jan 2024 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/IeM3KX"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109612BE96;
	Wed, 24 Jan 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131876; cv=fail; b=EMzw9fYnU3deQTkvehzHDbkO0Xsq+mP5u7KMXRJy1wbHrRp7+UoX1jaqT8wawpz00RixDhNRRwv5hMcyMvoms5YohXn4NiJXPWDfhq3gU0UW0cgn8Bg1a/u7PNbNbMZYlV7IowI8nvKsYCybn/+emf86IBIDEKMgyMMHHv/SFNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131876; c=relaxed/simple;
	bh=RP9lb9/vybBcB/O2u434ak4ud/VWe+sAAVhCDoUhxao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P3RCB8L0bZyl7zAqSTv3EjLkKqRXmOb6KfUETY3cJc+g7fMIOz3H1HO91YgtQ8mOU30J+LsiJz4J78eonDsHP6ZD3RokcinMet8z7JwAMZEiPa1AncUDOyGcfoYI6aW0VX2WNFCEbsTQA9kTHYqQXKT3m1s7NgBU454P1hmURoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/IeM3KX; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706131874; x=1737667874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RP9lb9/vybBcB/O2u434ak4ud/VWe+sAAVhCDoUhxao=;
  b=i/IeM3KXQw1LujFB0CftzlB+/m3acRULBIIz3tJ61gTWsKG0Rasl2M6n
   BAJVUtTPCUqXv3DpMj7RjRekAFsLMTppag8JescPol1Y2513YFgMJ7L3/
   fiCiMX6vwTPzWwzGGrk93I2VsbvkTqHB3lAcsES90bKWqGlCz0EyPRY7C
   oz0Bxr5XNHHSFZzXtbDq9rt44XNT8tPA6SpS3o5fIDQ9vrpS7g4hW6yNd
   QPNTTof8wUpksnNNl2ZYaUNQ0LSj/AoCslKyw1jMVX5Sj0D+z/TGhfYV+
   br/IJ4InBISmtFMUWI90N+DediqxggUb/DD1UuuiTqEzso1Wj73bHORH2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405728957"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405728957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="736080835"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736080835"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 13:31:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:31:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 13:31:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 13:31:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGFLuUiUsFOZZ+VDXKljJ3Q3jq3ThDCSd/1RQPsks5wF8wwT0VIqB9f34FMflS/V7s8LuYA4T/rWUIm++xbVdO2Td4NoHXRoRyr2i3rtJdLGbh35j6C08j6JfhvZu2tALpbr4/HnRj9/lkKsYJNL95DJGTNluVvZ3zqsBGt7St+m9EWFlpkCr8TGKmu90iXUsR/dVJ8eh46DJhnxivVVgrpHzR3Uc//0R7uOVnsS8O4SNG8QixDYxOO7n/1S4l0Dl6Ar0jLsb10X98X1fTwowvXv1Qar7waQ1g7BTglEPXGm3hmWK8rvi/O1ItGBbVXTwhYp9MnbnA6CINkHPQ65MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eghViFCOE7Jjl06KI15tE+X2KnhQUrdOf9Lhb3ihlDY=;
 b=dP5kOT1pmPjvk32QLPycmkUynnzi6er/Qpu5U1x3PRKEqlq9bw5aSvWTQiiZjWEd6YbUzEIsx5gXk7SpbeCiFD9ewbiP2RynthZek8+70MnojxsRv8vPX37l3LAVmhPds4Xpl/Woh0NyHOb46urmDj1ohSb3c0pJs8fQn+U2JdAxv1apBC59kWPGd9eOUOep7JsnefiBcrKLWtlQLBXjcYysxfthByJRmL/6JspwBy77Ay5zAp3nvaQukxLNIFJL5rHs9IfZRKysTfXCcXeBLXuCEK8V/qebwQ2yHe2WI7Y7Zm/flJSaLIKzValH+FQvXFI6678f3sZFX8ecRJrZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 21:31:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 21:31:05 +0000
Message-ID: <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>
Date: Wed, 24 Jan 2024 13:31:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
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
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
 <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fed8084-6e3f-45b2-d0cf-08dc1d23c5a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a72HPGO2XXYJpZ27UdMvziA3NQbWknXycUEAzeAHiNb9vVCb4NsRbY+7RINabApui9TXsHmTTbdCp53CX6tizxWJxKSd0D0oDKQaorxtVoL92feqe94nG5QUzijmPI+xhQqLKr9gtCSdRlt9SVlDrsQg2VfxwDOf6MrNyp6FXQs/Ywa3qEpNbdAxPr3y8P6O8nkS2fM4K5a9XFu4qFRQUsr8phvl/0Q5KZ0NYiCDaGSSqR7Lkk/Pe4qTx4/GP98HR14pFL6K+CE8bDibTrDBHzZEGP71qKeq5BMlcXChSHMv2Mb4klJ44/dmZGR9ILpEwfmGCljbSaquCzPpKSggZ4oqLwDwcVzQxRCZ+Ki1awmmem+FJzK3FlGhM1jHJN4SvGpAy1/XjnxWlyznAER6UUCY1FFCbZy+1LkpZ3y6CPzrx4Ejr63l83IR/awiPWEb8VCWb2kXSR8SJ0zwucPQfKU82IoHR5QGYMmIF6EiGlVjdR4zjfSO4mdlwZ6NwM9CNa5Up+rxhhPMOerCUpQvHGbDLU/97F/k6OJqjnbq4Vb+h7aC8XAmuRI4e8eRvzXFRb1Q8cNNwRJAjqP4CnQHhxmvpmz1ScXJLt5KJNMcs2Bay22sYvkZaAlPMagkiYvu76/ZXo8fAFsCORY0dxwcTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(82960400001)(36756003)(86362001)(31696002)(26005)(41300700001)(38100700002)(6486002)(2616005)(6512007)(966005)(6506007)(66946007)(478600001)(4744005)(6666004)(53546011)(66476007)(66556008)(6916009)(316002)(4326008)(2906002)(8936002)(44832011)(5660300002)(7416002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFxQ2RTcmlMa0ZLV3hRN2RWRzNLTjQyT1lnK0VtQlA4ZkNqdHhjUFh5UzlL?=
 =?utf-8?B?TnE3dTlvYlRYOTM3T0NTaGhSSURycnFkMm81dUlyWEJJcjVibFJxMXIremJy?=
 =?utf-8?B?NFUyV1FEOEViWCtleGtTdVhhbkVoRkdHMTh2TlZvcXFhaWNyc2Fra1EwZk1y?=
 =?utf-8?B?MXdNcmxlZk9rQk1UQ3lIL09pczl6enVmRklwR0FXN1pnMmIvNkJWaHhjZVpM?=
 =?utf-8?B?R2xObDZKL09BZmUzdW1nNTlGd0FBdzRJclYzc1dXaFNZZVRKbWFFalNmazFI?=
 =?utf-8?B?Kzh4eHBnQ2lDRU9obGsxc0NKZVVuakwzWHlKdUxOVWE5NXNaWDFPL2NTYjds?=
 =?utf-8?B?Z2I0SGRRY1pTcE5jc0tqRmI1djNDT05xbDZhc2FtdlJwdzBxb1dHaCtOb3M0?=
 =?utf-8?B?WDdaTXd4cExCY1BiVVI3QjB1OGUwZHFxajlzNFdZMnNlbGJqOUV0TEZ6NkV4?=
 =?utf-8?B?MFY2MC93Q3QxV095TXlZTTR4RHhMWm9tZ0VhekJtNnZRZURWMjgyOG81TldB?=
 =?utf-8?B?dktKc0tiYlNHSmI5T3phcXN1Q3hZOUZVMEZLQjlreUdrUjJ3STF3c05tdDlm?=
 =?utf-8?B?OFZsM2FBUFl1OWRpRys5N1EwUmVUaTllLzgzVlRVYXNBb2pSWCs2aEtycGl2?=
 =?utf-8?B?UzQ2aG4yc0IvUmlNNHJESE02b2E0eWdlbjIrTFA1TVZ5K05YUzRmdkFrUncy?=
 =?utf-8?B?aENOaUtqUGZvZHM4UzZBOGE2Z3pxSFVFL1NjYm1RaTA2aVFKWk5rUElrRFdo?=
 =?utf-8?B?QmJmYUhSTXlnbGFGN2lGdzJFcnNNVWJqMlJ2dWlmYUQ5R0xibGdtSkpXRnZW?=
 =?utf-8?B?L0tJUXdDaWpjUHFYZlFadHZDbkR6ZktNM3p2ODFmY2ZmdXZ1NnN4R1pnY2Zl?=
 =?utf-8?B?T2h0ZkgvclFRSE1JeW1WS1BvdFo5WnVRK1lIekRSWGw5aS9vaUJsOXBzQnhM?=
 =?utf-8?B?UkE2OXliNThmWTZseW84OXVNT0huZnpNOTNabU5WZnZKTUgrbDF0ZUd3d1lZ?=
 =?utf-8?B?cEZSeHdsenFqUXRQZDN3YjlQaG1KZVlGcXZSSGczNUNaSUM3ZGdnZXlrejRW?=
 =?utf-8?B?dVNFbjhBb096U0lva2ptblNOVGRVUGsyK1I5TUZNMFpHOGVkVThXSVdwd1NN?=
 =?utf-8?B?V2FPbUEvN1Bma2JBVlFEUDNGemEvOE5jMkZJR1hKbTZsUHVoZU5ucjZaQTA4?=
 =?utf-8?B?MXpxQWJvaHZKK01QUFNLVVdrcEhrNjJGNXJLTm54ZUVJMzNESThPeHJjbVBm?=
 =?utf-8?B?QlBiRUxYZURNU01QVWhkc3NyWFRTTFVXVWJQdnJuZUF5Z3RQK2p4ZFZGL3Av?=
 =?utf-8?B?L0RXb0pzRlliYzZRWWxhaXI2bldkQ1dEOFM0cWxvSklpdzVQbkg5VGlsZjRS?=
 =?utf-8?B?RDNtTDFuT21GUURpVUVHUGtxY2pYc0xGK1NMY2ZEZ2ZmQUx4LzZScGtTcG9X?=
 =?utf-8?B?elZFN0p5NTRkODkvcUFiNFNwTnh2eWJ0dUtQaStaZ3lXc2ZDWHhsL2FNKzBN?=
 =?utf-8?B?cnBYUzM2eFRYRGNUbWJ0NEpSMHpGUituYWJ0cXFLTDVtYllkY0lvTy9RVXp4?=
 =?utf-8?B?RGttUXBvbVV2QksxTjNwNEJnRjdNZjRCMXN6ZkNzaDUzeWs4cy95RHRsKzUv?=
 =?utf-8?B?R1BncU1lSVFtNGs2UHNXd0tVZ0tQOW1YRTB2NktwakJ1elZxU1pOTzlZTTIy?=
 =?utf-8?B?K1FPOUZNL3I3M1haY3JsUmh0SDhVK2ltbXpDS0dHbHBQeG9QMjZlbkx1MERJ?=
 =?utf-8?B?YTNGd2NaZ3phNmdjZ1FmN0RMZW5tNHhzQTZGV3BNRitmTWF3UEp6b2Z1dEFR?=
 =?utf-8?B?d0FSdzZGTlorVGVUUk5GSU1JajdEczR0NEIzTnUvbTdKaTZCa05VNVFNSGFK?=
 =?utf-8?B?QUpSUnhabSt6Z1pXNUdXeFJ3V2YrVVUwRzNPUlFLR3o5M3JBcE9EZ0VldWZx?=
 =?utf-8?B?OFo0V3crc3JjSDZQUFl2RWFYUXJxZlZzbHJVaG1tYWxRUDJGY1BIY0IrRU9V?=
 =?utf-8?B?aytQRC9Vbmw2cTVYQ0RNeDNKa1RNL1JWcm9BVGJoQTRtUUx6ckxxaDhzNGs1?=
 =?utf-8?B?TTJyUmJNS3hzMFI2MHJhb2IydVJ6RUpQVXFMTjRudUhpQXNuVUdUMnkwYUhv?=
 =?utf-8?B?R25GTEdtM3l3d1pLaUVWVitSMy9aZG1uUEJ2UVJncklaY2ZrODNuMGkybk5p?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fed8084-6e3f-45b2-d0cf-08dc1d23c5a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 21:31:05.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0TUfOp2oTL3Vsd/U4T42QteIGItiL+Iuv2OhUherhEhJamJJKGLGB5YYgphy0U1kPJoKTMWgnasxg+1M/b/mLEDA+wja0oG28FzoRDggSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

Hi Boris,

On 1/24/2024 12:45 PM, Borislav Petkov wrote:
> Hi,
> 
> On Wed, Jan 24, 2024 at 12:04:31PM -0800, Reinette Chatre wrote:
>>>   54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").
>>
>> I think a "commit" prefix is required here and below.
> 
> Yeah, but if you see a 12-char sha1 followed by a title in (" "), that
> is a commit and nothing else, right?
> 
> If I say "commit" too it is kinda redundant.

I do not know the motivation for that requirement. From what I can tell the
change [1] that added that check went in as first version without discussion.
[1] starts by saying that the format is "preferred" so I assume there is
some history that I am not familiar with.

Reinette

[1] https://lore.kernel.org/all/976c6cdd680db4b55ae31b5fc2d1779da5c0dc66.camel@perches.com/

