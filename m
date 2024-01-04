Return-Path: <linux-kernel+bounces-17314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA6824BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D1F1F23390
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048C2D044;
	Thu,  4 Jan 2024 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzE5+kcx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CC2D036
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704409507; x=1735945507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IY6Y+zNUDd3d8W+JgN5MeSLpL+uYQSsqqduTTLgXNlQ=;
  b=FzE5+kcxMlOLO6dL0VerM4dlVdR2DlYxAmgYfRJvCCwupoxS/SCyb2RL
   +q7eu1TMljDOXo1BFOrtUW81KBnDk50DH/JXTrABavtJuRo5+xm3MlXo9
   4bxjpqzP6KoGUwVUDnjTzWo5uH9NfO99w/aOxxBFVeZGO60AFzErfgSC3
   +lvoLo5wsVavDjBLtTYdVDKm84TT/+mN+jXs/AV1h3OP+oFVUUihJZGsm
   g3mFMNg9YEvNVb6qvZ1ZuXHGi9YMN3NF8hQ3YbI1xaeVc8vfgcZTMeSbg
   Q0bWlvuoSdubVhtd1BKoeub5lgOhtXIpHiv0lSXGmC/A/ovsN0nI2+axh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4491730"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="4491730"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="730304240"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="730304240"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 15:05:06 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:05:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 15:05:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 15:05:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfo3AEzcEDru1hYfd+ilO7RkGNObyUiER35sTMi9EQP6KUHPoEfwCEqRQJYC0lQCkRnoHKdZNJXd8k0YCcySffameJtFjG6rDOBZQwZeyWvNAMImw1dgszGZzkeQ9ujvQ71pnxwlWn5LjrtdoGRF2JL1K7p+z6Jd/OeT8mP+4/8tImkT0PFEEcqjNZTfvlfBastVu4chGD+WcP4WeeN2cWVL+zdgLdqNHIh/JKgQK0ep8vEDUc0L7+nzrBWLbc6YGVajGhX7CqtN9uuJMmt07wvYm1225ri5k1keUZcoJYWGZhx5lY5nJTkeqPx4jZ96WBIf2K8VxcvLYYSnQjo0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yv5Kb1obta/Y6MtpWqEHLhmtt5ecNutSnz4B/oSFPg=;
 b=YJP2JBNmgSYgBcpgSwVrwAG3tQkEFPHSwsF8c+HjW2cVFJyXr1bU8OYF7YfqryawXOkkFyj6LVSHNc5gabIp8xziP9Dqew3+ZzwhUuZURBKfqClHORMBR/XNl2a9/kIjCL1KAXr/lfDxUBtMARazZn6jHAnK3pDc1snCfy8IiCkGmqvHBUgxwnZ20pppuZaab6rlo3qEqj5f+7iyexpJfeoADhOIVx/bkyY8pJDVc7XFlWNMnYPKaBC83Rqt7RcH+J7WCAYJGH+mzSvuNlKjETv8HyoNHyw7NAsZ9iPeg+nUao8jmbtOl1HmrpVQutpShLEFLNBmPJwaCtdFwTOr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 23:05:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7135.026; Thu, 4 Jan 2024
 23:05:03 +0000
Message-ID: <ff19b03a-8c3a-43ba-8d34-bd4a218b8950@intel.com>
Date: Thu, 4 Jan 2024 16:04:58 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] x86/asm: Remove the __iomem annotation of movdir64b()'s
 dst argument
To: Kai Huang <kai.huang@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <dave.hansen@intel.com>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <rafael@kernel.org>,
	<dan.j.williams@intel.com>, <hpa@zytor.com>, <geert@linux-m68k.org>,
	<bhe@redhat.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<frederic@kernel.org>, <xin3.li@intel.com>, <rick.p.edgecombe@intel.com>,
	<isaku.yamahata@intel.com>, <yuan.yao@intel.com>
References: <20240104221219.572258-1-kai.huang@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240104221219.572258-1-kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: fc69d33c-3869-4f83-228f-08dc0d799557
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIDj3dH8XFJ15qoYbuzNTnDYnIZbFwsMSvG7QqUSM6qdUCn3Inka/0fEHnyFw++q2Bb224CWpwInPERi6K+cz6picm2addk7gcflD838SefioRgns9ruokGexelEZbDuy4QsVXtgjCkq9t6E/WGemXW70Kfy160zGYsOcPn8e7M/rZkfJanzptNWK3jTfMtIHpWOauncKaf+6uIM2DlHCMSCKZ/Ev24LODFGiM7kFyUJUEnC6WRN9amAUAhZni5NzvjNpvCTc1XNylsm5rU8VvR1a9QPJ/94hciMazrNQfFPNx8QhaKayK38OH4FKcOxtTlp5dYWSI5xe89QYxFJcyyamAUoPYEQuLAEFcwC8r0+uU8kmk9gbYuBJssLpBheej6iKBlLBqo7Wwg6siu2/k9U0iv/FQY8ajQ/c7hl6OhfVQDOHNNJiMpTJbwH3OCwj6pPp5vZVNQOlwTKr8X3oBodagqXkPS836+3nUDGy3N5wxcQj0U2WnzVu5akoarid2z41xa+AWO4j/HunxmXEsrXoPpBC5yG1hdCZQHfR3N9PDiKs5nCU9YNsWEPMVFt8+2VWM7bIr9qFdGOUE94ZK2T2k7oCtEj5vn2h38Z5A1WcMSdPM7eJd4J5V71enmYSwW6+qg1MyjOFoIZTqVtVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(8936002)(6666004)(6486002)(83380400001)(66476007)(66556008)(41300700001)(2616005)(53546011)(7416002)(6512007)(6506007)(4326008)(66946007)(316002)(26005)(44832011)(5660300002)(31686004)(478600001)(38100700002)(82960400001)(966005)(2906002)(36756003)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RPdEIvRXV2MUtWc05ZdGhOQ3l0bG5QOTBVV1pGSm41bVRDbE9qNmhDU0tL?=
 =?utf-8?B?TGlWWFRYSmoyS28vbjRMV242Q09LTlloaWZ6ZzVRL05DejM5Q0hOcEU3dWpp?=
 =?utf-8?B?Kzhxa0gxSGRuTnI3M1ZRZkZZL3Y1NkxaTXJyZi9UU1V4RFFOUmlRWGVlckgv?=
 =?utf-8?B?bkVGQUdXd01DdVRHZXpjN3lkS2RtSm5ZakliVy9zYXU4ZHZ0MWhJNytQcGFm?=
 =?utf-8?B?L1NEdGovaUZkc3JtK1JNT0dUT2M4cDVvTmJNeVIvamhUUFdCT3ZUMmZqWG5J?=
 =?utf-8?B?eVh3d0p6QWp2WTVkWmt0MzlnUUkwSGlHdU1FVTlWbU5qKzdvYjk2R01SUStn?=
 =?utf-8?B?TFpRc28wRlQ4RllWVjBSWWUrV0Y5ZnJNVHJKZ0FXSjZjdDBOaWV0NUNua2ov?=
 =?utf-8?B?cXhFdnFGVGd1dkZqYXZ4TmVQRjFYNFIrSExqNTlSdVlDYmlkVTNsc213c05H?=
 =?utf-8?B?RnJ0aEM2RWZUUks1UlZjanhTVGZEQ25JaEpJTVVMdWRwUmJwNzF2WVJuUHRh?=
 =?utf-8?B?aVBGbDdGazBodnZHTFNSY2o5WEllcFpwQVIwcDQvY2lGZWFLOFpibnlSNFk2?=
 =?utf-8?B?Tmh4Slh4ZStmVVJxczZTbkZTd0l2QnNjQ3UwR2xtQlQxMU5STWV3RmhHdWM4?=
 =?utf-8?B?QkoxSE5XRDFmaksxU1lZQUY4VmVMY3N3ODROTDBTU1NPaGhRcWRGMGhhd1pk?=
 =?utf-8?B?SVVvRy9OMSs4ZUQ0dVRzRmxmcUhsK0JVMnNFMUFjWk5IekpQdEhQSkVnUTRG?=
 =?utf-8?B?Q2dPSTZCZG15bzdUY1Y4VnQ2dnhLUE95VTJuL3dlM2R4aloyOWFzMm9nV2JI?=
 =?utf-8?B?QXhTU2d2VXdLekY1dHVuZndYNDA0bEpndmdJbWJXMzVCbmxDMlEvRjh2TWNT?=
 =?utf-8?B?UzJibXlJU3Y0aGd5MlVKOVNVckdRc0krTG1zSUpaazNQVUFyMWM1SlhLc0d5?=
 =?utf-8?B?WkZPR3dkTlMrY2U2elNvL0pGaUZRZ1U5cnhVZHBJMXFvM2pEeGhza3doajFZ?=
 =?utf-8?B?MmtBQnA5eVlqTEdhNVR3T0NQMHNseTR1OHVlOHRQTXRiMWdBVlV2NmxmRG9W?=
 =?utf-8?B?a2VWS3AxYjhqWHZLM0NGSi8zKzBtbWhMdENxeCtUNGVQM2lxRTkrOWpHV2t2?=
 =?utf-8?B?bnhlK2Iwdkxqa0FodCtXSDlxbnZPeHh3cjlQUjB0R1VOaVBzenY3a1ZTaldO?=
 =?utf-8?B?dURZMkozYllXVUVpY2xuZTUxY3NpT0VPbVR0S3liRnFqZlNWaWlFS254T2ow?=
 =?utf-8?B?aUJVSVFHaTBXMFErRWNpcGNpcTE2M1dpblYvWHQ0TnpBaUtXRkpNMndpNmRy?=
 =?utf-8?B?elhpakNaczViY2ZicGRsYkZjQWhqcEtOUTZrY1pkMHpTbUZXS1pKcDBNQU8z?=
 =?utf-8?B?bWxJSHpiU3VxL2N4c2Q5bUNablpjTUpwaXhoTlV2OXRHZEFiVFlVUWNqQzlv?=
 =?utf-8?B?NFMvb2Nmb1MyeGdoZVRDNGsxRGJYaE84bmNrTmp1dE5iUlpvdGh6Z2V3eXdx?=
 =?utf-8?B?Si9iRGdIaWNnVGVTQldLQk4zN2Nsb0prN3pzN3hWZDlVeWQyUG5OejVBSDIx?=
 =?utf-8?B?aDlGT3VjcFJ5Qlg2aHVNZDNiVDZWSlRFSEVWNDFuZHJObFkzb0hlRWUxZkd4?=
 =?utf-8?B?R2JGTVRYenhwY0x4QTFLejdjWXQxdVpLNTZ0Q1RjY1NFMzNtUVBrT1h4WWh6?=
 =?utf-8?B?QUt2TDIyYkpXKzl5cDVsaDY3Y1FuUCsrVCtGUHdpdU1Vdmp3ZVp2Y0FpdWla?=
 =?utf-8?B?emtIbThnZzhKUjRRZ3QvRFRpS1ZTaUYvN0dVaEdNdFoyU1FueGtMQXp3UEky?=
 =?utf-8?B?NThpa25ORGFabGVKQVcwWjVaTHRWWVBpV2ZjMGFPVGFIaTVVQlBUaHl6cm9s?=
 =?utf-8?B?Ky9ZS1hKaTBGeGp3RHpyc000RTBHZUQ3cXk1MUJhTWRQT040Rlg0SFVZRStk?=
 =?utf-8?B?Y3gwamF1VWNTNk5FV3oyWGdid08xQUt3M1Z0SmQxUFFOWCtrNnRTSWk4bmRK?=
 =?utf-8?B?NzBNVmh3elY4TXlSbUZFa1RGVGVIS0J2WmxzOWVoN0hZaHptanlGanZ1Zzgy?=
 =?utf-8?B?azQ5ZTg2RkxXZWJYWlBoZXhkR2pybTNvMTdIUlhuN1E3M0NGREFCUTJsQmtl?=
 =?utf-8?Q?RKbiuz5ZctMMn0artvj7p+4hR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc69d33c-3869-4f83-228f-08dc0d799557
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 23:05:02.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUDQudppRMGu2ntWI1ayrF47g6SUBW30o1OO8tjSswe8EQlttvuM0NYOV04aUCZlSAi3KFXckGPhui8rk8b15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com



On 1/4/24 15:12, Kai Huang wrote:
> Commit e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all
> packages") causes below sparse check warning:
> 
>   arch/x86/virt/vmx/tdx/tdx.c:683:27: warning: incorrect type in argument 1 (different address spaces)
>   arch/x86/virt/vmx/tdx/tdx.c:683:27:    expected void [noderef] __iomem *dst
>   arch/x86/virt/vmx/tdx/tdx.c:683:27:    got void *
> 
> The reason is TDX must use the MOVDIR64B instruction to convert TDX
> private memory (which is normal RAM but not MMIO) back to normal.  The
> TDX code uses existing movdir64b() helper to do that, but the first
> argument @dst of movdir64b() is annotated with __iomem.
> 
> When movdir64b() was firstly introduced in commit 0888e1030d3e
> ("x86/asm: Carve out a generic movdir64b() helper for general usage"),
> it didn't have the __iomem annotation.  But this commit also introduced
> the same "incorrect type" sparse warning because the iosubmit_cmds512(),
> which was the solo caller of movdir64b(), has the __iomem annotation.
> 
> This was later fixed by commit 6ae58d871319 ("x86/asm: Annotate
> movdir64b()'s dst argument with __iomem").  That fix was reasonable
> because until TDX code the movdir64b() was only used to move data to
> MMIO location, as described by the commit message:
> 
>   ... The current usages send a 64-bytes command descriptor to an MMIO
>   location (portal) on a device for consumption. When future usages for
>   the MOVDIR64B instruction warrant a separate variant of a memory to
>   memory operation, the argument annotation can be revisited.
> 
> Now TDX code uses MOVDIR64B to move data to normal memory so it's time
> to revisit.
> 
> The SDM says the destination of MOVDIR64B is "memory location specified
> in a general register", thus it's more reasonable that movdir64b() does
> not have the __iomem annotation on the @dst.
> 
> Remove the __iomem annotation from the @dst argument of movdir64b() to
> fix the sparse warning in TDX code.  Similar to memset_io(), introduce a
> new movdir64b_io() to cover the case where the destination is an MMIO
> location, and change the solo caller iosubmit_cmds512() to use the new
> movdir64b_io().
> 
> In movdir64b_io() explicitly use __force in the type casting otherwise
> there will be below sparse warning:
> 
>   warning: cast removes address space '__iomem' of expression
> 
> Fixes: e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all packages")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312311924.tGjsBIQD-lkp@intel.com/
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  arch/x86/include/asm/io.h            | 2 +-
>  arch/x86/include/asm/special_insns.h | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 76238842406a..de2dc9837f11 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -379,7 +379,7 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>  	const u8 *end = from + count * 64;
>  
>  	while (from < end) {
> -		movdir64b(dst, from);
> +		movdir64b_io(dst, from);
>  		from += 64;
>  	}
>  }
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index d6cd9344f6c7..f661277e52d6 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -224,10 +224,10 @@ static inline void serialize(void)
>  }
>  
>  /* The dst parameter must be 64-bytes aligned */
> -static inline void movdir64b(void __iomem *dst, const void *src)
> +static inline void movdir64b(void *dst, const void *src)
>  {
>  	const struct { char _[64]; } *__src = src;
> -	struct { char _[64]; } __iomem *__dst = dst;
> +	struct { char _[64]; } *__dst = dst;
>  
>  	/*
>  	 * MOVDIR64B %(rdx), rax.
> @@ -245,6 +245,11 @@ static inline void movdir64b(void __iomem *dst, const void *src)
>  		     :  "m" (*__src), "a" (__dst), "d" (__src));
>  }
>  
> +static inline void movdir64b_io(void __iomem *dst, const void *src)
> +{
> +	movdir64b((void __force *)dst, src);
> +}
> +
>  /**
>   * enqcmds - Enqueue a command in supervisor (CPL0) mode
>   * @dst: destination, in MMIO space (must be 512-bit aligned)
> 
> base-commit: 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8

