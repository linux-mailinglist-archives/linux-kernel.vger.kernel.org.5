Return-Path: <linux-kernel+bounces-49227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FB846765
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493B8290988
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17317996;
	Fri,  2 Feb 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANSjVNNu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF017994;
	Fri,  2 Feb 2024 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850146; cv=fail; b=IGw+P9GiX3jMx84DEzcK5eSlENf4CItLm7IEhYR0OHooou1vJl5kf+9ntTq3HfkVnxtnxxXMRmtBUJN/7B7wcmjm5r4yPKJ4vM2ysWVo+uMD6vV0gobdOu/RSkxDVrqqHHSg2McYVQACh4PW8mX7Sy0Q0qD4KeMHbleHopupMK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850146; c=relaxed/simple;
	bh=fEyH9cIo4TDxe93k6sVmiAl10A7nPxlz+rBRCpW/z7c=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a7uunel3F0f46/PNOzfqhR/CTXuRSS2gRRNoZoi0NUviSZ5j4Egec8vZ1fm+Zby+G5N/hJYDEF8qm5Xty7YVyhgTZVf9drw+e1vCATET8HRQjiUoURv5iTSE0hsFIQTsrAC6ija8gbheat5xefDZKow1zRT5ac8kVywDpF+yuzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANSjVNNu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706850145; x=1738386145;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fEyH9cIo4TDxe93k6sVmiAl10A7nPxlz+rBRCpW/z7c=;
  b=ANSjVNNu+MsFKJvD0ROWQXfK/r6uWLTeMrN3AlM64qBNCgUwsT+52GIa
   uQp0uWNvHIiHD5j3FjPuyv+2eisIdtVqY6c1tIGHYFc8xOjk3ZHcxgCcy
   1azv0zze2h+cwPO05kZq/TOtDg3r6JUJazp7RSvKbiz7Qr/om8G6+W1yd
   N5EHJ4HhpsO5I8+XxZIB71OynVoVsBQmy1X0HyXQwCJbQHbrL0mIhvVr1
   z3kr+5kxnzOBBHh/6BDcth7ZG5q0ZoyQRz3Vg3Z5h4hq9Oh+AIKFC1i6M
   18/Oww8Xl2d9rf98ZWN2LN8cIAb6QUL7xWf5MQSHNsoFQsZFwpbmaWmW8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11454173"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11454173"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 21:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4616612"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 21:02:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 21:02:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 21:02:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 21:01:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As3gZFZkYbnnkMpcPsrqalTiFJtFW3SFURQDIs/XJEtx8apsnthP8m5pz0OAingrGN7vaYxSA+aGR4Yp4UzZE4EO20rsWFQgDZt/9qY3qHyuf2/BDlDNZbqlgTRli1RQh7AJ7tvMACb1MoWDn10IUL+lQDdDBtM24KltzXz+rdGGlJzSR86Fs0sA9XeUhKZEZmHCwOeCJH/q7AxE/3zfBR+6zeihantgF3h3AIGujcwHL5pNwuMFSDrLBACm68M58UDRGfr63GWDjzC5Kxi5FzkPMUS5dOXSvHCDcsZ/Q/BjsvmjnUvhlqYnQy8r6snkWLSI2l2/tvU+Mv43HO5YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+Sbh37h7ll0/4nqSgdW1NenK9uxDRCOoe3eFt6QqHE=;
 b=Ov00eaqWc8U9xoG/rtx/NbL+HBRgUmyLRbB+etVdYvR4KrhBf/H2WC2BpZ7DUcA9yuCvyq35m6D1giziYP2/prB+/xNwlS+p0dapq0+8FThn6kxikXSQbYffYBgU9B6Wz5HjlE8qi/ls4cWEbvSJHzNgeIrBTU2FAa9UTAfm/Qz/7xcuIbNi9H+IyrmDBosqSUOQNiXSyVYgzq+xfvbxH9ukIeRXq3kV1GC6qYPLOdzaCh7kv1+DtBH1bIkgh4wjJ3YoIVIPdQ9Fvtx5tMLDwy3+uixHKzVkshPxyV05Dd80QSI9i9iARc6Pe2zjXJkEl+D5W0s9yID4d3vVujwLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 05:01:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 05:01:22 +0000
Message-ID: <0271aa74-a193-4391-84a8-c5bb527f0ce3@intel.com>
Date: Thu, 1 Feb 2024 21:01:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
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
	<eranian@google.com>, James Morse <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
In-Reply-To: <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: c1da75dd-58d7-4a9d-2a86-08dc23abfffd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P931GhSTS9pj5HCnrGuhDASHLroi2LaChU2+HRwDNwySTb6zWLT+TgCNth+33A53VKNW9NimdgCDsBRNQgHZp3usTgj1FtcjDTu2JFxhYID5kWUXPISMHbH1EY+lxpAVzh7TKHfJynakJtezZE2XrhRrfPAcbyAuYVP83r6N0JuFDf/MezhIlFw5fYzhdNyXzAq0OuSxzBTHwibUy1U6WfccpUE0qhE+FXlEt6IsukRNS77rwH0IhWetO8NagN8a6fDwolbm9dPF7Kpwu4G0JAv+uf7NzWk48bCIt2IWKo4l/U5xdv5nDOBfP/WxEIU3ojhkuGtTjPI3UN9vpUsV5XrEYOW/T2+jnY7ypyYtfbb093dN7mJQclVzvT2NFns8FqksCaAdtkfC3IMTnFKKlxA8ZJaO11yOpmrLulFdizpyaqYFlUGoz4SKTlSTsz6JSAHst/oZ0xXdmMgLskzvCIUr0jOckbKzM7ad/INWYACTfIFyBbAiZ4/mX6ojEowTV0WNlj/Ta7CtXr46cnqJH7P428Uty6vAToU++UkD8HrOhs+53YsNLiZ/bV20x+X0B+eN8ZSM3qkIweAmyjVw4MGKigBODQ5gf29Q1CegyWfanqf3NYEdwj2qsOCH0790P/Ge+VvrFM90mKJLyZ3qCWvyloWwH9VETCur7LLILjSgAuL8fUEnxskMQStxfm4b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8676002)(66556008)(966005)(66946007)(31686004)(478600001)(66476007)(6486002)(44832011)(316002)(53546011)(6666004)(8936002)(6512007)(6506007)(4326008)(2616005)(2906002)(26005)(5660300002)(38100700002)(7416002)(7406005)(41300700001)(36756003)(82960400001)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1PMkdKckZKaVRhcFZGaWEraVN3R2t2WFBEMFE2UWszeWhUQmtmYlZZdmcw?=
 =?utf-8?B?WlBWWmU1UDFzZ2cvV2V1akdFRExHdDg1TE9oUVl2ZlZZV0h1YnZsVGhjWW4y?=
 =?utf-8?B?WHlxNEZvTXdoNDRYbTFORXhpWFcwQUJiQzArRkhKejNNU1RUcUlvRzR3VUJY?=
 =?utf-8?B?UzJwRnQ5c3JIamFGZEM0UmZudFg0b0JxR3MveEhoa3kvNFQ0RmppSjhuWkV2?=
 =?utf-8?B?NjQ0UnhONXhpVm4xUUFJeXIrK3JlRlIwNFJUY2NGQmx4c212MCtUNE1CLy9H?=
 =?utf-8?B?bm13UDJPYUFsbm5NVVRsanlkTnpMYUdsTmVDWHRzYlJmcWwwRjUxbjFPRmxy?=
 =?utf-8?B?WjFJb0RtUWZCeE9PV0lQQ1VwT05YcjVYMFRXMExFdjF5M3B1WlJLeDZrQ241?=
 =?utf-8?B?UlhvT05SemZ5MVdvaHhrcUh1SGw1eGd3SE13ZU5rV08wVFN1a0NLMWg4NXRs?=
 =?utf-8?B?Z0pPQ21wcHRxbUhsdTEwTFdhRC9HVmJMaWN3MjJYdHRUWGJxR25pMi9oaGZr?=
 =?utf-8?B?Z2pRV1g5SVBTck0rT3E4Z1NuQzVoc0oxUVQxTTI5dEhVM0xzK1YvRk94OVgy?=
 =?utf-8?B?SUpocTk2MEdqWVBJMnRWODVtQmZ6RVkxKzAxbjZ4bmNEVUQ2Q3dLZVhZQ2lx?=
 =?utf-8?B?eG15TDkwQTc0bnhXb29qOEFvQUphTzVDU3F6WFB0RjU0VWlQSFl6Sy9qZnJF?=
 =?utf-8?B?ek1PclBOYTJ3ZGY1L1RNVmJTQ05YUWVISkdQNDBqTHhmYlRhQjNEOVVpUTVX?=
 =?utf-8?B?UjRZL2wrb0RYTEJDSlEzc21FVjFLOENueUp5cWdWTnh6MitXcHF0Q080RUZG?=
 =?utf-8?B?NlhvdGlOZFI4dXdHMjR6L0pnUmxwTVV3YnlxbE55VndUYmxWdXdPRFIxWWwv?=
 =?utf-8?B?WEtCeXNUOUxBU3NLRkpReG1kbVBrY2ZsbW1nYWRQVFhVUFpFL3RwenJJSldB?=
 =?utf-8?B?dk9weGVjYnVZV2pDN2xyQjU2MjBmTDRnRUV2REdoMUI3N1FJZG53bUg2ZHgz?=
 =?utf-8?B?ZVlzUWxHa1N6OVdhcnI3S3lneEJWNkZUdnZkQ2dSZTc3eHp0aUd5dk5rNmcz?=
 =?utf-8?B?QXl1NENaenI1c1J3NzBNZFpjVjJnMnZxN0JLTXBteWRQNlpmWk5pZE9SY3Az?=
 =?utf-8?B?RHZXMDNUZGt0bE90MzdLQWw0bEord05saW1IcFdxT1pvMGZtYmREY0F0K0Ny?=
 =?utf-8?B?RlZpZTd0VGhwSHcxQ3FiTWF6d3dwd3JCZ0JtanNuMFY1Z1E0UGlwU3NxaXpz?=
 =?utf-8?B?SmdRTDFyQVFFYVhXSmo1T1hvWGZLZEV6bGhkcEZtMWpNUjdyR0dUSVVXY3Iz?=
 =?utf-8?B?VDRkU3RsSUxwVkZjTnRPTG5UalpsWFBmQ3JGLzRCd3pUR09FZkRlMGZ5TFkz?=
 =?utf-8?B?SVAxQlFrYWhJSjNSODFhc3Qwd3JXUDJsbG13dnJkNExXejFldy9SeU9VYkZK?=
 =?utf-8?B?MXc0Z2t6NUhOUWNXL0pBWjZJcEVRTU1PdWs2NW83N3lmS2ZWYzhZNzlJY3o4?=
 =?utf-8?B?US8xQi9oc3RsWll5Y3JjOVJ1OTJkTlNJcGdaLy9vT3JvN0R3WWxzMW53bzRa?=
 =?utf-8?B?VFhmVVo2L21oTEFraXdKTms2NFFqbWtFdGlyaXRSakR5WnZTbjRjdmFqSjRt?=
 =?utf-8?B?L2FxL2dsY2xacE9tWXp4Q0dUcUs5azRPcHdvRjdBQk5qMk9yVVZySFFqKzVw?=
 =?utf-8?B?VElkWW0zZDhUTzA2Si9WcFFvaVJ4cnVPcTVPV3hML2RIM2c4MHpZellkR01t?=
 =?utf-8?B?YTFGVnZmanova1Z5cWhkdXE3SktpWXZJaVU0T1J1WEdxTGFpbmZNeGdpNFUy?=
 =?utf-8?B?SEdiTnpoU0Y0K3JMRyt2cVg3enJ2RXVORkNtS2cvNVdVUzZubmdkeS94Mmtp?=
 =?utf-8?B?Y3MvaUk0QlR6NHN3WDBxUGlRa1Y2MlZ2azVtVVZ0UmtmZE9pWUhUQi9keHlS?=
 =?utf-8?B?cjQ2U2xVTkVxZlpJZjZ2TGZjeTUyNTRHV3FJQW96UU4zOTlzWkk5Y3V2ZXBW?=
 =?utf-8?B?Qk5GSjhoTzdRVWNxb2JiQmk5WWF5TG1vQ1FHT3NmQ1MxMWFqQS9vMjNYNTJJ?=
 =?utf-8?B?bUhoc1BsSXBVVm82Z1hSUk4yTUNCUllua2xPN2ZJVVZTZWFCZjgzSXAySW9F?=
 =?utf-8?B?blpIa1FwTzN3U0dNMmM5VC9DRHpSaGxDSlF5MlU3bVpsaTBIRlFGZ1FDdDlu?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1da75dd-58d7-4a9d-2a86-08dc23abfffd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 05:01:22.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE9e2lOWmlesCAWHMPDbCqPr9eBzfVNy6tH+zj/1GIRuOnC5iVnpv7ytldAbV35LNgfq9FdWwxN1gRQ1aGDWPzxmlNozVXpisYXCGeXxXn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948
X-OriginatorOrg: intel.com

+James

On 2/1/2024 8:09 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 1/19/2024 10:22 AM, Babu Moger wrote:
>>
>> These series adds the support for Assignable Bandwidth Monitoring Counters
> 
> Not a good start ([1]).
> 
>> (ABMC). It is also called QoS RMID Pinning feature
>>
>> The feature details are documented in the  APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit
>> 1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)
>>
>> # Introduction
>>
>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>> feature only guarantees that RMIDs currently assigned to a processor will
>> be tracked by hardware. The counters of any other RMIDs which are no longer
>> being tracked will be reset to zero. The MBM event counters return
>> "Unavailable" for the RMIDs that are not active.
>>     
>> Users can create 256 or more monitor groups. But there can be only limited
>> number of groups that can be give guaranteed monitoring numbers.  With ever
> 
> "can be given"?
> 
>> changing configurations there is no way to definitely know which of these
>> groups will be active for certain point of time. Users do not have the
>> option to monitor a group or set of groups for certain period of time
>> without worrying about RMID being reset in between.
>>     
>> The ABMC feature provides an option to the user to assign an RMID to the
>> hardware counter and monitor the bandwidth for a longer duration.
>> The assigned RMID will be active until the user unassigns it manually.
>> There is no need to worry about counters being reset during this period.
>> Additionally, the user can specify a bitmask identifying the specific
>> bandwidth types from the given source to track with the counter.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> # Linux Implementation
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can assign a maximum
>> of 2 ABMC counters per group. User will also have the option to assign only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to unassign an already
>> assigned counter to make space for new assignments.
>>
>>
>> # Examples
>>
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_total_bytes_config
>> 	mbm_local_bytes
>> 	mbm_local_bytes_config
>> 	mbm_assign_capable ←  Linux kernel detected ABMC feature
>>
>> b. Check if ABMC is enabled. By default, ABMC feature is disabled.
>>    Monitoring works in legacy monitor mode when ABMC is not enabled.
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>> 	0
>>
> 
> With the introduction of "mbm_assign_enable" the entry in mon_features seems
> to provide duplicate information.
> 
>> c. There will be new file "monitor_state" for each monitor group when ABMC
>>    feature is supported. However, monitor_state is not available if ABMC is
>>    disabled.
>> 	
>> 	#cat /sys/fs/resctrl/monitor_state 
>> 	Unsupported
> 
> This sounds potentially confusing since users will still be able to monitor
> the groups ...
> 
>> 	
>> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>>    enabled, monitoring will work in current mode without assignment option.
>> 	
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	779247936
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>> 	765207488
>> 	
>> e. Enable ABMC mode.
>>
>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>         1
>>
>> f. Read the monitor states. By default, both total and local MBM
>> 	events are in "unassign" state.
>> 	
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	total=unassign;local=unassign
> 
> This interface does not seem to take into account that hardware
> can support assignment per domain. I understand that this is
> not something you want to implement at this time but the user interface
> has to accommodate such an enhancement. This was already mentioned, and
> you did acknowledge the point [3] to this new version that does not
> reflect this is unexpected.
> 
> My previous suggestions do seem to still stand and and I also am not able to
> see how Peter's requests [2] were considered. This same interface needs to
> accommodate usages apart from ABMC. For example, how to use this interface
> to address the same counter issue on AMD hardware without ABMC, and MPAM
> (pending James's feedback). 
> 
> I understand that until we hear from Arm we do not know all the requirements
> that this interface needs to support, but I do expect this interface to
> at least consider requirements and usage scenarios that are already known.
>  
>> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>>    the MBA events are not available until the user assigns the events
>>    explicitly.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	Unsupported
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>> 	Unsupported
>>
> 
> This needs some more thought to accommodate Peter's scenario where the counter
> can be expected to return the final count after the counter is disabled.
> 
>> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>>    read the llc_occupancy.
>>
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy 
>> 	557056
>>
>> i. Now assign the total event and read the monitor_state.
>> 	
>> 	#echo total=assign > /sys/fs/resctrl/monitor_state
>> 	#cat /sys/fs/resctrl/monitor_state 
>> 	total=assign;local=unassign
>> 	
> 
> I do not see the "global assign/unassign" scenario addressed.
> 
> This version seems to ignore (without discussion) a lot of earlier
> feedback.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com/
> [2] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/38421428-84cb-b67e-f3ce-b7a0233e016b@amd.com/

