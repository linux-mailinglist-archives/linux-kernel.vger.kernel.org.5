Return-Path: <linux-kernel+bounces-92744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB39872569
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE21C25E80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8A15E89;
	Tue,  5 Mar 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VX1+bZt4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECED2E6;
	Tue,  5 Mar 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658735; cv=fail; b=YRu17G231j10HLrbs8HWZ28UNNQQkAevT752FdIfi6sSaFqIzuZIqxKHImowtWAm9P5nQUbdlhTJo81yOF9WV9z9sOIakC1A5XpsuPVJZxggeygIcCDN8DQqv6hU+Q2xoYgTrvV16EE0FBMR8ahXBGxe7ddckWY2EDLQ9PEKatA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658735; c=relaxed/simple;
	bh=ll4jxBU8WTvK9j2G+oR+9zBelEl2IiUZtazNMWYmduY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hqyHZSWLadmDr0C82F00LeDVZmc6rKg8SByER2eRbxCpWOQZ6iERUigN+41jAQVQHhxXVXWLF2zUCzyO94OXorVLma8elk6UWQl31UiZ5smhw6gpqWFwBVMw3GGMHzEzGDSMX0PiYJrmf+ewFXhZzqDfXB32729LClLwUc6nop4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VX1+bZt4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709658734; x=1741194734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ll4jxBU8WTvK9j2G+oR+9zBelEl2IiUZtazNMWYmduY=;
  b=VX1+bZt4x8F7eR3FuZHCuMTqqtzjo06UZumKL2kGlq975lfg0p2WWstb
   c9kOEkyFtI0V4TWQayr0yR1l0B9+z3U5JrvBWzm+EDuzVKCFcdPSKUSXn
   H13ExD22bPXsGTiV20m+HxPWvRptw8n96JidUlewDWDMpi3nMYDkD4sV+
   IPnmN9N2OHuV/RjTtl9ZnoWBeb9mIVqvMjIIYHBJTjnzlhU99KlrfSpxy
   +fIM2+iaGL342jZ7F8C2BkZoYuV4JpcNmVsEjZ4CR7yLpSBPMSsbyuS70
   JgD33B+w9VNl+TE+3UOR5lWmr+lywyVQtcr0P63hy9dmSbaQQ9NlqC52f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="26683895"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="26683895"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9863341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 09:12:12 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 09:12:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 09:12:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 09:12:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brTRsv00b98JsTa1s47sTNiP9SViOi6l1hSzx64lRBQ5CrTDfTbf7mv8ilFfD+1wp9EL2qxT5lSdZ9TMtiDLMH8fZjQBroYqqs1ncDkhyHQHfDeXMDonmvH7EuXclUPH2u92PnTFNY3XFKiV18QTR+JzRolotEx4QdPW9NACTKUEHvgOMF120argprCwNI0U80ZrApbn3tLg6CiaFQaG1GhbqK1K38RTqN/z9MMWWMEqfVDLw9NTSB0h7RZ25HI0cZ3VTGYWLx3sBysDD2YBDqX+BaNtIc5w7cN7Bh6Uf2sAbaKxm5X5lk7ikJ0ENVmrzdU5cXJGlRWmpy6AaepuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHbRpAGciEE57w01xlnW0KmaKHUfSXsMbemONTFE5Mo=;
 b=Q4jY2CzeP8KW9zGqAG85OaoJnJfVHYPwuo5o2XCVKSHezfD80RLgYNHEfXkLiLmKeYJwZebT7QOXulwKzV1KDdZrTBot2qmOik2BN87mj6xVJqw39gHg28ajKuevXUv06qadtQI4k3Vd+Fmj7RJ9/jOnYJ8ZTkVZTJ/WJwPBnMpZ/TU34lUupCVQ7mYDOlvfrJG4yI6dQA3RbCjAW33vJrSXlcENVKtLNNGSPnbVk+YkxCV3KH9GKNm3umQJ8tovfhw2PQ6LhPIRVLEM3ZT05T/4s+oSxd6S4ePa3xELjFYhUrGJb3b5tgX6TxxDl+MVztVL8pTCbqg5qyNDBNEE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 17:12:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 17:12:07 +0000
Message-ID: <d29a28c8-1180-45ec-bd87-d2e8a8124c42@intel.com>
Date: Tue, 5 Mar 2024 09:12:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, Peter Newman
	<peternewman@google.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
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
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 968cbdc8-5857-43a4-be16-08dc3d3762d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFj46QRT37FdbEmRrzJ7NvWvXWwPNmdA//U6u1cCQMKTQOdr2+31+JnHK9Yr8U+52dUrL3tP9ytO73kvlzkmzCNr3TCzLRh1GWjbzydib0DcdCxpc/eq4+YMKnt9HNevG4hEEkpi7tvQ8NrBc8/AWlrwjWRjW3QA2y8rkgGmYzuVBQms8h5ZdEOdkL1kIqG0KUKo4dDbBe0J2dlRuecys3nb/TFcuJpkuTt/OqzQ0XitKRHt7+3tCZxKX2YJQNJxAWe+lmizLpljaLjJkxcPy4Ex7xXGIPkaxXkQ5nmvenpsWAnBH0/b7PpYIulT5z+w+DkCvRTrmHyHWxTkA/X1LyzNDB+ATWrpRKD6akzo/8oaH3AtU6pZwVj4W0NezZ8LXvhylrOyrtllKvnAaUCnhQiMB9sBUSa0+lD2DYgMnoshet7580f75f/T7bOuVNUOamhf6ltk7SrD3+utlZyKHhOF3GqNYYnB1st7EuHv/EEYz7m2nBDbKfhidFCFg+Ryvn+Gx25B675qTcS0Xb7mojfpKtH/Busq+eT0ILq2zpx8OCQCieCjV7kWYx9323Ro/xCTUii9XCYkOBhcoli3zKCPFk9+y2tKoRlz3qEti6ZU+vOrC0J9dl2ru6ehwej0mK5pwiZyHh7kKzPgb3SZqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhYa1FCUGNSekFIYW5aOW9TTDZEYjNoM3J4akhpeUFjNTE5TWR0Y0RGeEJt?=
 =?utf-8?B?MCt6TURkVzYyeGNmZUtGWEtESVBVMmljYU5ZRzEvQ1J6NFFyRnF2aU5iREEx?=
 =?utf-8?B?cTdsNGNRTUpiUjZyNzBDV0xtVDF6RDBPa1ppNlN6b3pud0lsc3pRLzhPUjBC?=
 =?utf-8?B?MmRFZ1UveFdBb1lpbkNXQk9YT21NUGFHNGhocXYyN25jUTRxRXVsMTBhNzJs?=
 =?utf-8?B?Smw5SCtpNTZIaWFVRXQ5OXFRNHp1dU56Mm5NRDl3Z1o5ZU1YQ2ZWYlJrWUVt?=
 =?utf-8?B?eEd1dmIzWjk4R0tvS3NrdzQvYmZnaE1QWFhQYjVXU2pWUDRJQXRkTXI0WjZE?=
 =?utf-8?B?ak1iNlpMNnFTZ2hLNERiYnZHZmpYbEFPcjV3a1lYTWVpODUvYmFLeGZzMlpj?=
 =?utf-8?B?OHFpMVJHZUNtY0NXOUJOT0pnQ1QrL1FJQnRrWGcyM2liVjYwUGVzTXphVlp2?=
 =?utf-8?B?U3NhWS90Skp3QTVCSXJ6Tko1Z1RDUVpOWjJpa3ZRek45RHVNelJLZDJ6aG5D?=
 =?utf-8?B?VU9BZUFwY29RZlB2N2RLM1Y4b1o3U0hOUGFCMFlVNlhtVXlwZ3hyRU9rSGR5?=
 =?utf-8?B?M0RocFdUNkNBRUNzOW1wbCtTdW00OHprL2Y3YkQ0eTgrRHJ2VGtSUStYbUgx?=
 =?utf-8?B?S1hEcHBvdkU2TVd0VmFjYy95eG5zQnN5Mmt0RURUV2ViVU01MXIvTnBidU5i?=
 =?utf-8?B?aW5WdWtUTWZVNWZuR0ZocFd3L2Iwbms3aXFkekdRcGluZXdDV1ppVkNYdXpF?=
 =?utf-8?B?YjFJa1ZJNXRPNXhGL2xMNFFoYldmN0dKcko1dFdnMTZwamtOSTcwZjh3Wml1?=
 =?utf-8?B?cloxY1lhZWNQMVgxODdSdFYrdWtGMjMxMGlyeklXaVVLb1Q5Z0dJVTIvNTdF?=
 =?utf-8?B?OXhLZU8rYW5oaE14ckZIWjRYNTd2MENUYTAvcThSc2FPZlNyK1MzeXBxNGg4?=
 =?utf-8?B?bWRycjl6NWMxOTdWeTNoM2hNTlNyclo4TDY5eVE2dkV2d3p1bWxHS2ZOZkcz?=
 =?utf-8?B?Q2V2amptWmdwbDgyRi84dFhNdGl0by9XTlltYUFSVTNld0lCUE9SUXNGYzJU?=
 =?utf-8?B?M2l6dXpHUE54VlpCRklIT2xNeVMxeTUvYkdzdjY3allENm90YnpleGhxanN4?=
 =?utf-8?B?YVlONktyRTZZeHVXOFBPbGNHd015Rk54dEtzNkNpdmNzSzNhOE50TlQ3RHFC?=
 =?utf-8?B?bTdUY1lhUnRHRzVUZ0xsMndIVUwyZlVnZThnMlpIV1ZRMmJsa3E0WW5SWGhJ?=
 =?utf-8?B?eGZLVm85MWJDY1JRYXRvbzBzejVCSEdIcGN5WE05RERzWG0yY3krSTUrd20z?=
 =?utf-8?B?c2g3VklVT2hYazYzMUlDby8zakdhb1ZJV2pkMjdrRFBjTitaNUVUZkR5Snph?=
 =?utf-8?B?OFkxbERkT1YxeTBLaVRzTnh2MWxUUC9FWEJDMERJc3JVYnBIN01meFZJWVo2?=
 =?utf-8?B?b3hpTU5lQk0vV252OTBieHNWTmNRcjdpV2FabDd3bEdCS2Z3YXB4Z1drTVFY?=
 =?utf-8?B?d1hjNVV2VWFUTVJKUVVpNVVpSVh2eUVCRVJNYXNOclpqSW5raTUxTnk1eTc5?=
 =?utf-8?B?a3kwSzlLUjVFdHdHcGZoNmp3U1U4TnlWVUluZU40ejdoR2FvSEd2alZUUzRp?=
 =?utf-8?B?aWN2S0Zkci8yUG9seE45elNtWVRjMEZPVzkzSHpYZnJrQlR4SUFzV1lmKzJk?=
 =?utf-8?B?RUZqRm5jekVqNjF4L2cxWEZMeXJUTmVKdjFtZUtyNHJnV2dZVGFhWEQwYXpa?=
 =?utf-8?B?Ylp5VE5UVk1TQ2Y5MXFCSERFSHlDMnYxRFRyVHFHRDFwQUlFOUNZZ3EwWVNw?=
 =?utf-8?B?VlJsSU9BK0NKdGtJWGRhQXhvY2c0SnJiMCthdzN0M3BSTVpwYmlUbUZHZkxZ?=
 =?utf-8?B?YWMwRW9seTdJS1Y5aGVoKzR6L0dFWFJMNVh6TUphUFR5aWt2MGtlWi96S0tj?=
 =?utf-8?B?S3NaM1ZVYkxHWjZkVlVaS2I0QWxmNjRjeHpzNWRTbUVpbzFRT2JlRUQwanJh?=
 =?utf-8?B?Q1JIMkpyWHJxNWVGTFE1Tm95bkZwVUlKcDNndXRlTE5JSzh3NTR0aEtJeEh1?=
 =?utf-8?B?cU9GWTJRYm5QbE00RTRMVzhPejRWblpiNmlEMnNRaTRmVzZGc0ZwZTN6YzNv?=
 =?utf-8?B?MjhUVC9KbDdzVTU2NXpFcDJrZ1JrY1hjZjZsSmNocGJCc05Gcm4yWWx1THYx?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 968cbdc8-5857-43a4-be16-08dc3d3762d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:12:07.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpy23jjmjM5ZXrkfSgTUA4DUFQNXTBmNNmoRzGMerHlwqYs1zEqV6eqPq3leOh1uprP66sMYQvidTUMFK2C/5ez46PThGPOyDPFPVgAI7Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com

Hi Babu,

On 3/4/2024 2:24 PM, Moger, Babu wrote:

> Based on our discussion, I am listing few examples here. Let me know if I missed something.
> 
>   mount  -t resctrl resctrl /sys/fs/resctrl/

When creating examples it may help to accompany it with an overview of
which groups exist.

> 
> 1. Assign both local and total counters to default group on domain 0 and 1.
>    $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt

I also think it will be useful to always print a small header that guides
the interpretation. For example,

$ cat mbm_assign_control 
#control_group/monitor_group/flags
..

> 
> 2. Assign a total event to mon group inside the default group for both domain 0 and 1.
> 
>    $mkdir /sys/fs/resctrl/mon_groups/mon_a
>    $echo "/mon_a/00+t;01+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t

For an example of "+" I think understanding the output will be easier if the "before" view with
existing flags is available. For example,
if it was
   $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
   #control_group/monitor_group/flags
   /mon_a/00=l;01=l

then
   $echo "/mon_a/00+t;01+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

would result in:
   $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
   #control_group/monitor_group/flags
   /mon_a/00=lt;01=lt

An example like above would make it easier to understand how it is different
from using "=" like in example 1.

> 
> 3. Assign a local event to non-default control mon group both domain 0 and 1.
>    $mkdir /sys/fs/resctrl/ctrl_a
>    $echo "/ctrl_a/00=l;01=l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

I think this should be:
	$echo "ctrl_a//00=l;01=l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

> 
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>    /ctrl_a/00=l;01=l

     ctrl_a//00=l;01=l

> 
> 4. Assign a both counters to mon group inside another control group(non-default).
>    $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/

Above will not work.

     $ mkdir /sys/fs/resctrl/ctrl_a
     $ mkdir /sys/fs/resctrl/ctrl_a/mon_groups/mon_ab

>    $echo "ctrl_a/mon_ab/00=lt;01=lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro

(watch out for typos in examples)

> 
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>    /ctrl_a/00=l;01=l
>    ctrl_a/mon_ab/00=lt;01=lt
> 
> 5. Unassign a counter to mon group inside another control group(non-default).
>    $echo "ctrl_a/mon_ab/00-l;01-l" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> 
>   $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>   //00=lt;01=lt
>   /mon_a/00=t;01=t
>   /ctrl_a/00=l;01=l
>   ctrl_a/mon_ab/00=t;01=t

ack.

> 
> 6. Unassign all the counters on a specific group.
>    $echo "ctrl_a/mon_ab/00=_" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control

(watch for typos)

Note that this only did unassign on domain 0.

> 
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>    /ctrl_a/00=l;01=l
>    ctrl_a/mon_ab/00=_;01=_

     ctrl_a/mon_ab/00=_;01=t

To address some earlier requirements I think it will be helpful to also
show an example of multiple groups changed with a single write.

Reinette


