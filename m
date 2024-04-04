Return-Path: <linux-kernel+bounces-132249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A4899202
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716252866C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976B13C3EB;
	Thu,  4 Apr 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drzc7IwZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE313BC38
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272630; cv=fail; b=dy9vhtqqHIVsoEH211u/4OqUQeUDFPjrrEKekJEn/DNgQsZAtWi42K3VJQHyBvB22kiwC8B4TS+N1k6wIipZTQpxao5foGraQ4iC+UwOdl0r8lgH5Qx4eSKDP7SlZcj6KZaDQCYcyGNIxo02FU8Hoy5pP9J0gE/kyguvUdH81/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272630; c=relaxed/simple;
	bh=Hsz03VblFH5ZPF1n0g06RtI7Q+9xFiCBW2tI0YBTlwY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WD0BbMbnJtLMtOyhEXLZ3auYyOHNmwRUIIvys3t/PTQS+pAZ4+8UOgAHBkR1KYAFoJuQwhWL6eFoKE26w0RPPN2TYKZ2jKcvVLZLAJhqVtUhS9iqCdvY7IIdL2zCIkgxYPtdNvfUQe88GcijaBTdBDdjOnRUjLjFEnmOVfHdzmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drzc7IwZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272629; x=1743808629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hsz03VblFH5ZPF1n0g06RtI7Q+9xFiCBW2tI0YBTlwY=;
  b=drzc7IwZ+bRI0zn6pEGtr4LPLOYSfy4aQchJhZR9yqVIvcdaurww658Z
   k4xh2f28ZTzs79sHq43qtxjsobR+ifggA2wgJtgiMCl+/SZ7wZmK77nY0
   aDoiXe5cPCzfUhsu+vexfTIAH1pwlDGl14o5RvAKctgdFQ8z7uGEeGJ/C
   Frt+PXzUkfq9bM5S7a21tgHaVLe7sV3MIWohLyD+OP65oXkWkoOPw5okK
   ouM/XnDojAg7PlzBnydrXhVdqGNPEnYzkUS31RqSAXyiMmQdrDWG5qCcM
   t14MEvh485/y4AxznIuF25Byl0PA32uj8+RggYHq7QUDbNHp4s6xsrwzH
   A==;
X-CSE-ConnectionGUID: qrwsUcH1QbuEzerJaSkh5g==
X-CSE-MsgGUID: tYwVGd4YRxinivEvKXtCGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11367160"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="11367160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:17:07 -0700
X-CSE-ConnectionGUID: lfnmwRqXQyO05XKNdBehPA==
X-CSE-MsgGUID: em9gCan1TZe4ncMdovJ9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="49900301"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:17:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:17:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:17:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:17:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCH3wu1TsOnziex18faznnTVQtmWoCI3SYfNECobJNCEvDhjptSX8pWExhOHafYRbQpgsgr7l8WHHL2XgXV39zgODx9/Nti79kRnpY8bGbsTxg71TAXoyhW6RgLcwWVpBQfp9TNNIzJ2VRHYqBWGodFauj6qKBgjKcZ6i0KPZBF/E5+qW2fWe5epSssaYrh1z3uK8jK0hMzxHT4zBxsCxmCnCrUFdxh/As5MnQPLxdPzg9Jcdv1NtVrWWeC5g7pHKgWlfsueWgjDH+dLO3LOFQhqgSu5gjvZmchQONw/F1RUE5StFhenwJJ28gFe+KdNXSdmYrjBet52OFLse9CFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnkluyMVqVMIGA7tE+7gufF/QqVvZaxVMEohX3aCwBA=;
 b=naWL1U5QLYzBjZ5jHH/flJmn6OeMRu1HpSiwB3ruAEPEgTNMZfnbGp5tmbqg08ws64y98qjS806N+QCbrKNBT7RLE//p62jJJwkZ4Vdd0LfhMcsVXxnFVu0dJ7NA40Ol5yw6zUxglBeY+Udm7dgiNzDl/1AdqnGbY3wdLWYIAzQ4y+6ZbcqAvp3Tr+2ecENuvZOCUTCwiHSEC8+/0B9Bwf208ANOPgg+KBaMxgKZJzui08/SfJJFUhPii079/14ehawxVl6mydaT9NbokPO15y96fTkjxugzIJLyl8xg14xYNMAKCeE30NqHyk3H6c0ZkrHXlPoBSFaQuVynK1in/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 4 Apr
 2024 23:17:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:17:02 +0000
Message-ID: <343094ac-702d-4225-aa4a-7119d1484db7@intel.com>
Date: Thu, 4 Apr 2024 16:16:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] x86/resctrl: Abstract PQR_ASSOC from generic code
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, Mike
 Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-6-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-6-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4847:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7L4qjXG8AC2wydhgJRk93CylgGG3zazX6QQLz0PEWfl0vv2tL0uRK2tGmM5+xYNkEtRmd3uFOv+l44sEFlKRt2XTjpV6jEnkFll7i6UGLOQg8c3x13K+9tBA/jDhwOBsUwJZkSOYk7c6pg7iwn808ePwsAI+1KOpqtjVWDP0yFqmo+J0Q2uIOVox722lhtKHVekfqHhICdIeNJ0rCI0ftAJ+fNYFEGYVbdIIFXQ/4evZgce+iIo5ZpzO3hkLXx35pZRa4cX9WG4RD6IxWcLMoCTDGz8c0pcFFZ+XS3syk9IJOo5OuvEs85oBHQGkyj+1WJj5qGY/hY6sw/C38SyLR1imP7Akp+h2Hs/SCnSXquYglYBP/sWCC5hWs6A1CwAiyipCbHOfUTbDgOtGYfFvxw703gU4gHTg9B8p5goSkGcSwmV14uZZ0+yqN4+xtkgYo3I6yAuEW4lw0FwolEe+wfBC7uLspQ8m0jvoKd1+Z+alTEkxyofcHz31QAzVeft1CxJYs6vdXr5a1jZTPdkztecksuBhkgiYFQShVw7dc1MNuXNcO2ZoOOTMj+LWCFT5veOT92bD7OkkL8mlpn5H4VK79KGOX6Q3YoS3qyrTrqDqZdwOIrrJFHQ8XTeMj5HOmM+G0VHuHghwUFayiifpUd8IG2EJVznNkiqmhmYr0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZMUlhiYnl0NTU4NmhySS9EY2E1eThqSjJwTStZZG1XdldLTzRYSDlmVjhm?=
 =?utf-8?B?MllEdk1aMHUzajhnTklPd0tYOWNtNTFmZ3M1MGgvOTJaOWdZQ0NlSHVXenlH?=
 =?utf-8?B?eGM1dndWeXFxOWZOTGs0UHlMS0dERmlEUkM2d2dPTThaTjdUcEhDUzVNbktz?=
 =?utf-8?B?dmh3MUZXS2tvTkU5OVJSYlUvZFFQdENSRjA3eDQrdnNVcmZINWQ2WVZ3K1Zj?=
 =?utf-8?B?N21YNTFFd05QZWxSQTVqNUJ4TityZHN0a21FTk1OS0dTSmNjVWhaY21wSldn?=
 =?utf-8?B?RjFGQm5GdVdnWllMZEJRSUE5TTVDMXNjS3JuMFZvSEo1dTd4b0ZwZFpyMXhj?=
 =?utf-8?B?bzYrZDMvTjhxVUR5N202YUdEeFlFSURhdGZhZXhxZ3J4aGo3cEZNQ2lkUjcx?=
 =?utf-8?B?M0oxWHljMTJMRExBWUUyZCtlQ252eFRFcHlYblgvY21pUmQ4VHhTV1ZPT0h1?=
 =?utf-8?B?eXFFUUsxZXNOSHd1bWJLekVnYmpFU2lGSWdNWHJPRThJcjJOWWszbis3dDAr?=
 =?utf-8?B?aGIvYVZrN3YweWxha0l4QmZjMFU1V255RUFEYWhiVVR3SnJjSjJ1OVZKZGpN?=
 =?utf-8?B?RVlpemg5bjkzZTFLeUVIbko5R3R1d0k0UDFnRzZLT2ZtN1laRTVrOWExRXRt?=
 =?utf-8?B?bkwxM1FDbFVFTVBSdWNFd3VUY28yT0lCNDdxNDNaMmxHZ3M4MFZaUTVDZmc1?=
 =?utf-8?B?bE5SWlJwei94bURISVhNd3N4ZjFMN0syMURJTlBhWDNXRGNRNVJ2UHc4YWJi?=
 =?utf-8?B?VjltVG54dHhEQ2hPb2NxVTNOaThBdjBPaG15VzFScWU5MXJ2cU5CaUszL3dO?=
 =?utf-8?B?Rm5wWU0rUDhwS2VXOU5OVlRXTm1pVU1mai9mNlRmcXdzSzJkUzdCSzhTWktL?=
 =?utf-8?B?UWdCQU54c1ZjUm9JdVJ5b3pUSGNHZE40SHc4VlBlbVFtQlUvSjMza1RLem04?=
 =?utf-8?B?dWlaTW9oNmhvMis4aWg5VnhrMHU2R3V6R3Z6SEdrRExQRHdFMUg4Q0lXUXp4?=
 =?utf-8?B?cmNRazBjSGRPZVBnSm5kaFpaanJuWUZOY05ZMWliMzFNVWVnd2dvQmg1YlMr?=
 =?utf-8?B?eXhyQm9IZUIrQ253VDI3aGxyQ0RiUFVVQlRIYnVKYVQxM241SmFpUmlDeDdy?=
 =?utf-8?B?K24vUWtpZmg0QXI1Qy9PQnA0bU4xMVIwc2I4a0R2NEJlMjZUM1JTVFhxWWRL?=
 =?utf-8?B?My9saFBUbUxnQ29RZG56WE9mZ3lWMWlVNmR6YXdMU293VmhZT2ZNUHlpL2dj?=
 =?utf-8?B?RFdKSFlNVEtuSlAyQXlYUjh2ZlY5Yk5mQUVqVzU2RG9PVHFsaE1qSkh4bTBL?=
 =?utf-8?B?dG5GeU1VNXBKVzYyTkpBVUN3Y09scys4cFRFRTl4Y1VqSy9wMjdXNU0wTGE4?=
 =?utf-8?B?b3BvQ1pLNHZaNmxHZmpQVk81STQ2anNpaFdKYWZ5VUtJQVM3RlVEcDNuN2NM?=
 =?utf-8?B?c0ZneTBMN0pyNE5KN09FRUNERDBqeVp2RlpLSXJZek5jbGRET3cxK2xkUWdR?=
 =?utf-8?B?YmJTRkhYSXE1V21LTmZtYXZ3M0ErNTYrZ1hVTzBEQlhFc09RelBFV1l0OTdK?=
 =?utf-8?B?Zm9vRUt6YVdLems0L2Z4OU5YZ29UMUJmSFl5QzZpUzZyQmlycEVhbnFJaC92?=
 =?utf-8?B?cFBKSXpRTTVqQWdUdTdTdXVKVHkvNElwT1NHUFRIRlBaOWdHZm52eUk5Q3BE?=
 =?utf-8?B?c1ZzQkZRb3YrdHBnTk5KQ3Nxc2RaRjFOS2dPODRiYXpabC9reW1YYUNkMHJl?=
 =?utf-8?B?VXZId0c2dEVuUEVFZGI4UzV5WURuYzg5MjB2eVpEeHM5YjFrRitDb2N4Nk8v?=
 =?utf-8?B?VDkycnFDaFNiZHU3NmgrTTkwbFl5d3RrRFV4c3p6K1FCTUZBZU1QanBoVXhI?=
 =?utf-8?B?RWRiUmFSaVhpRGFHMFRCUldtdDU1eGFCclVxcTBKOE5PZmxaQ01wWUNmUXpV?=
 =?utf-8?B?UkUrUkpkN056ckdEK1F4WFpvYVZPdnI3K1I0WnVCbXQ4TGhqZ0xYaC9hK3g2?=
 =?utf-8?B?eGhZTjNUL3E0Nzl0dElLelRiTUdaK3AyRU5QVjl1YjZPSDdHR1hnbzh6bHBx?=
 =?utf-8?B?S280aENIblJmaW04djNzanJtYW1SdXhxYXVqTG42b0ZXbFB1czB0ZGxoc1RO?=
 =?utf-8?B?a1VkTjIyYzJ4eXZBaXlhNklCRDdVaGRjUE81Z0YzUUNXSHlwSVhOY2V6Rkpp?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae728d-e89a-40ff-4319-08dc54fd5584
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:17:01.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BflzrG+Bd4TA8nztF9Z4cngHyf8iKgnOLwrpWYGKeoM/GF6stYbNvTiMpNCvjVYswSlIq2Qe/LrVhFVuDTyNmZo0IUdB3ytHHO6KM5V9PgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> While CLOSID and RMID originated in RDT, the concept applies to other
> architectures, as it's standard to write allocation and monitoring IDs
> into per-CPU registers.
> 
>  - Rename resctrl_pqr_state and pqr_state to be more
>    architecturally-neutral.

I think it will be helpful to also introduce the PQR register, otherwise
it is not clear how this rename is motivated by the first paragraph.

> 
>  - Introduce resctrl_arch_update_cpu() to replace the explicit write to
>    MSR_IA32_PQR_ASSOC in __resctrl_sched_in(). In the case of MPAM,
>    PARTID[_I,D] and PMG are a simple function of closid, rmid, and an
>    internal global.

It is not obvious where this is going ... it sounds as though MPAM will
need three parameters for this function?

> 
>  - Update terminology containing explicit references to the PQR_ASSOC
>    register.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 11 ++++++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  6 +++---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 +++++++++---------
>  include/linux/resctrl.h                   | 11 +++++++++++
>  5 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index ae5878d748fc..4cc584754f8b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -37,12 +37,12 @@
>  static DEFINE_MUTEX(domain_list_lock);
>  
>  /*
> - * The cached resctrl_pqr_state is strictly per CPU and can never be
> + * The cached resctrl_cpu_state is strictly per CPU and can never be
>   * updated from a remote CPU. Functions which modify the state
>   * are called with interrupts disabled and no preemption, which
>   * is sufficient for the protection.
>   */
> -DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
> +DEFINE_PER_CPU(struct resctrl_cpu_state, resctrl_state);
>  
>  /*
>   * Used to store the max resource name width and max resource data width
> @@ -309,6 +309,11 @@ static void rdt_get_cdp_l2_config(void)
>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>  }
>  
> +void resctrl_arch_update_cpu(u32 ctrl_id, u32 mon_id)

We already started using the names ctrl_hw_id and mon_hw_id. Could this be consistent
with that?

> +{
> +	wrmsr(MSR_IA32_PQR_ASSOC, mon_id, ctrl_id);
> +}
> +
>  static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  {
> @@ -598,7 +603,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  static void clear_closid_rmid(int cpu)
>  {
> -	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
> +	struct resctrl_cpu_state *state = this_cpu_ptr(&resctrl_state);
>  
>  	state->default_group = &rdtgroup_default;
>  	state->cur_closid = RESCTRL_RESERVED_CLOSID;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 0ba0d2428780..e30f42744ac7 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -332,7 +332,7 @@ struct rftype {
>  };
>  
>  /**
> - * struct resctrl_pqr_state - State cache for the PQR MSR
> + * struct resctrl_cpu_state - State cache for allocation/monitoring group IDs
>   * @cur_rmid:		The cached Resource Monitoring ID
>   * @cur_closid:		The cached Class Of Service ID
>   * @default_group:	The user assigned rdtgroup
> @@ -340,13 +340,13 @@ struct rftype {
>   * The cache also helps to avoid pointless updates if the value does
>   * not change.
>   */
> -struct resctrl_pqr_state {
> +struct resctrl_cpu_state {
>  	u32			cur_rmid;
>  	u32			cur_closid;
>  	struct rdtgroup		*default_group;
>  };
>  
> -DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
> +DECLARE_PER_CPU(struct resctrl_cpu_state, resctrl_state);
>  
>  /**
>   * struct mbm_state - status for each MBM counter in each domain
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 884b88e25141..ca1805a566cb 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -480,8 +480,8 @@ static int pseudo_lock_fn(void *_rdtgrp)
>  	 */
>  	saved_msr = __rdmsr(MSR_MISC_FEATURE_CONTROL);
>  	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
> -	closid_p = this_cpu_read(pqr_state.cur_closid);
> -	rmid_p = this_cpu_read(pqr_state.cur_rmid);
> +	closid_p = this_cpu_read(resctrl_state.cur_closid);
> +	rmid_p = this_cpu_read(resctrl_state.cur_rmid);
>  	mem_r = plr->kmem;
>  	size = plr->size;
>  	line_size = plr->line_size;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index badf181c8cbb..bd067f7ed5b6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -112,7 +112,7 @@ void rdt_staged_configs_clear(void)
>   * + We can simply set current's closid to assign a task to a resource
>   *   group.
>   * + Context switch code can avoid extra memory references deciding which
> - *   CLOSID to load into the PQR_ASSOC MSR
> + *   CLOSID to load into the CPU
>   * - We give up some options in configuring resource groups across multi-socket
>   *   systems.
>   * - Our choices on how to configure each resource become progressively more
> @@ -347,7 +347,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>   */
>  void __resctrl_sched_in(struct task_struct *tsk)
>  {
> -	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
> +	struct resctrl_cpu_state *state = this_cpu_ptr(&resctrl_state);
>  	u32 closid = state->cur_closid;
>  	u32 rmid = state->cur_rmid;
>  	struct rdtgroup *rgrp;
> @@ -401,7 +401,7 @@ void __resctrl_sched_in(struct task_struct *tsk)
>  	if (closid != state->cur_closid || rmid != state->cur_rmid) {
>  		state->cur_closid = closid;
>  		state->cur_rmid = rmid;
> -		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
> +		resctrl_arch_update_cpu(closid, rmid);
>  	}
>  }
>  
> @@ -416,7 +416,7 @@ static void update_cpu_closid_rmid(void *info)
>  	struct rdtgroup *r = info;
>  
>  	if (r)
> -		this_cpu_write(pqr_state.default_group, r);
> +		this_cpu_write(resctrl_state.default_group, r);
>  
>  	/*
>  	 * We cannot unconditionally write the MSR because the current
> @@ -635,8 +635,8 @@ static void rdtgroup_remove(struct rdtgroup *rdtgrp)
>  static void _update_task_closid_rmid(void *task)
>  {
>  	/*
> -	 * If the task is still current on this CPU, update PQR_ASSOC MSR.
> -	 * Otherwise, the MSR is updated when the task is scheduled in.
> +	 * If the task is still current on this CPU, update the current ctrl
> +	 * group. Otherwise, the CPU is updated when the task is scheduled in.

I think control and/or monitor group could be updated, not just control group?

>  	 */
>  	if (task == current)
>  		resctrl_sched_in(task);
> @@ -3005,7 +3005,7 @@ static void rmdir_all_sub(void)
>  		else
>  			rdtgroup_remove(rdtgrp);
>  	}
> -	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
> +	/* Update online CPUs to propagate group membership changes. */
>  	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
>  
>  	kernfs_remove(kn_info);
> @@ -3688,7 +3688,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  
>  	/* Update per cpu rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> -		per_cpu(pqr_state.default_group, cpu) = prdtgrp;
> +		per_cpu(resctrl_state.default_group, cpu) = prdtgrp;
>  	/*
>  	 * Update the MSR on moved CPUs and CPUs which have moved
>  	 * task running on them.
> @@ -3732,7 +3732,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  
>  	/* Update per cpu closid and rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> -		per_cpu(pqr_state.default_group, cpu) = &rdtgroup_default;
> +		per_cpu(resctrl_state.default_group, cpu) = &rdtgroup_default;
>  
>  	/*
>  	 * Update the MSR on moved CPUs and CPUs which have moved
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b2af1fbc7aa1..a6b1b13cc769 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -306,6 +306,17 @@ extern unsigned int resctrl_rmid_realloc_limit;
>  
>  DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  
> +/*

For valid kerneldoc this needs to be /**

> + * resctrl_arch_update_cpu() - Make control and monitoring group IDs effective
> + *			       on the current CPU
> + *
> + * @ctrl_id:	An identifier for the control group which is to be used on the
> + *		current CPU.

Same comment here about naming.

> + * @mon_id:	An identifier for the monitoring group which is to be used on
> + *		the current CPU.
> + */
> +void resctrl_arch_update_cpu(u32 ctrl_id, u32 mon_id);
> +
>  void __resctrl_sched_in(struct task_struct *tsk);
>  
>  /*

Reinette

