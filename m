Return-Path: <linux-kernel+bounces-33996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413128371B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AC61C2A27B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61D856466;
	Mon, 22 Jan 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsO6/76y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7CD55C30
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948870; cv=fail; b=KoKsZApVyAtQGYihQxASt/W2+oPA0PtUkwOxMYLwII+6/xjyxBZ1j5AmelNtSw8EuNOnsAaUMB2DmW1KpHNNvfLqCFNMC4dsjYhceExUPTOBNOIys2QGSWzFwRobuqWTF4a3vXGl5BVy16XbDVvuE4Upz2jqIPPnTkyg0pkM9k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948870; c=relaxed/simple;
	bh=WTSSw+ew1ZvrBt56J3/v1jR6WhwBBnWfSiXGp4k9vKI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FO7UGX/nl/elpLtHhMm5TQzhsH9/XvCZcfLBNSbWxFUuwyoqABswUesBnfPOFfWai6TI3eUCdtpIR+xrbmhtyBhB3tQQFOAaMWWg/mnPhSGbZVcCHvo/sCRIj034CFl+x7S4fPsBL3MfZI2LekhCYIeqVx2UUrvaljE9sRWmzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsO6/76y; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705948869; x=1737484869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WTSSw+ew1ZvrBt56J3/v1jR6WhwBBnWfSiXGp4k9vKI=;
  b=CsO6/76y60OYeIiaqfKfM0b5N4UYRf9A8kFSPaXja11PPJZnAccrr+2Z
   +DTX+a1ygATcbtUDA33KlIFtdXXqMCcXCSLsn8dh9p0ZcD6bJxmdGyL15
   KcWsUkw4r+i9SXNwcnIS6oP4Y3ysoviJGA9TWb/zIZUxbb7/4myUMPE65
   GshiZx/me7WnKyVonP1SiSHlDl8vbQxldxKMYFIQ/b5AwJGKibWjbL6y2
   7n+QclV13CjWRUwhxF3bSQBsWCmioGReFDl39joFxvw2b1GthLsKPoMt5
   qOmv9cRsxoIyn1JmMW5tOocQu2FlLkcpo19n7hfwK7UlVPxK2PlHI0+oq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150202"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1150202"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="909031100"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="909031100"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 10:41:07 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 10:41:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 10:41:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 10:41:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znge9DnEQK79b+qa5/1dPO5rvTaLMJfPGtvDpt0keCXxaIEev1UHVjzz5RSrX4u0vrYzH8wBAn0SyajAjeKw0LSDj0+9Wf0kLx+xCWrT9aA768CSe892aGRT2fCfg84egYOVImEpxcQMBwQfaarEx76kupONYEyzO8ag3Tv6M/z8jGEp7SZxLr8P6M6YhFCjyC/NLSzC1ywHMCEa+yjTw82XqvUImiBQWk4l7oU9rYgtUD3Hr6+qU68hfv0K9GGipO3RVcJfm/qDSCs3OSy0KBl4js1RhKNtthLmAA6+ybAfi8/4KDRTZB2FqF9d6y+2fF4YB8UqZbnsNeObGUUqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4w1YibSDfwWM0bRUxs1sMTHeVrx4ZVV4cit8M0zTeY=;
 b=LKgr0zN2+4lg/361Q2yN8/fr+ZXPV1IsEj6eVffsLMdqx9IAX1yzy93IrzOvvvcHkH24uYZgm8Ye4AGSYA/9m8YlX6E6P7L4CXJx4hxCmHjEUS5yq4sypZ4hEcMZtKdOR5686vCxzJBdebX8Eb/8NIOpoD8FsvaT36pSV71E+W3FlwKY6tu5HX9WkLukyhoUZceQaGCjl/scmxmtTWpoqgkCqKGDvR5PQw/70CWvk9NTK/mXs0bm49218aQz3rpd4c52gczxXpya7uLFntlVpR0LwyRd+OPuQ83I9i3MbSxHsoOWk9ty2o4wvzOaD8/deVTAEhX3e795AdN18SUxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:41:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 18:41:03 +0000
Message-ID: <11fc82e0-961f-4c8d-844f-ad4b99067eb3@intel.com>
Date: Mon, 22 Jan 2024 10:41:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>, "x86@kernel.org" <x86@kernel.org>,
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, "Babu
 Moger" <babu.moger@amd.com>, "Shen, Xiaochen" <xiaochen.shen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
 <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:907:1::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 076c2598-58d9-45d0-e81f-08dc1b79af9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCvQ1iCG2K6J8+HUJ+MtS+jTYDYTQ7Tg9cpmS/zue+oyMe7obLUB4p/E0KI5Kdk5k4cjjsJZOrEdHgmoH+9MFnWyXVwyIu6SvnxuWoOp9O5F22L7QH6qaagSaBy8R9D2bpw4Yu+zvZSeNAyhbMoHum7EL+XmoyBagVhWbqudVPL/bPsr/MUpzcoa9SaG6YFGoqaku9p6RehqAvqbE22jFtwVhYF6W7kvDaiAMuTfInjghaI/KlPFUIz2lzGUVXA0VnCEr4BXeRZ8+9brj9cC1H11t5yRw3VW6ZFijaIDaTpLr9xE1y86Iro3p95Um29vkw9tvNhmlSztWQ1F1MjQWmXhK8/YbWDhUedOs/fWUny0j7argLNIImS2CNjx4WiefDjkEb+P8by8Af1zevhBYGot77F8AlUFzxPST7tQ28yb3PbRgHNpBzNm8Fh+34xr8oRNfWu1J1SYbW9hLsIxqkEHnNVFr9uTFMWs4AiDquk8iRrh+734gsM+UmhCy3eUMoiwQ4/cFXtG8eATfLkZX+7vFYN7vdSAQblsbgtua9YmNzgOltxjBEZhz1mS4qIl901EO5M9hS5nIBUU9D0ZMlTGiPFtTd3q3IBWcnWnMxNo4YmE5dPnGRzWtTBazQuzxUtWlZpnCZpTW9rAIj48tdBjDSyDjdQId2Dbn5vLGNbV6pAy1gqVpbzL918wyT5Sm9kbtZEq6idTrMGd5i8PdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(2616005)(8676002)(44832011)(4326008)(26005)(2906002)(8936002)(5660300002)(478600001)(82960400001)(36756003)(31696002)(86362001)(66556008)(66476007)(54906003)(66946007)(6486002)(966005)(83380400001)(6916009)(316002)(31686004)(6506007)(6512007)(53546011)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExENmU3K1I0TlJmODFHdVZISURYYjJKdXlXWm9GTGVBeW1jbFZzV1doa3dR?=
 =?utf-8?B?QncyMWJYb0dNMGt5d1dDZG5DczB1VkJETVU3ZzFKeDFOMGEwWDhNNzFEU3hD?=
 =?utf-8?B?clkvSGZOMXFMWDdSRU9QZVNHTnRic01GRjNUOHFvWFl1NmRJdkpwSy9hV2Fs?=
 =?utf-8?B?S1dBUWhKVXNSZ3NZcGRDQWpneFFDbWZFdHVrcDN0dWVMV1NrYW5XT3pCNXRI?=
 =?utf-8?B?ZlZTdUpNOHdJRGdnbE4vNDVNSXR3SXYxZ2lIdXZBSk9vcUxUMy90VnpSRkda?=
 =?utf-8?B?Mk90bWx6MDJBcDdnWmZFNFpEcXRFNTVBZjR2Wnp0aUlBZ2t1cis3NWRyUzJW?=
 =?utf-8?B?dXVOV2x1cC9qc0U0R2J0TDNFWE9taVcxN3lTbVlpMlVFTWtHRElxVzMwNFc2?=
 =?utf-8?B?dEExc2pDelJheDRnMUwzOTlRNFZTUDlZdTBaU1pnbCswUVBMSXBwYTVSeDV1?=
 =?utf-8?B?WmdFN1dIa1dNaGREbVYxL0VHQStWNEx0TXBwSmJuVFkyc2Jma1NnMm9uN3gx?=
 =?utf-8?B?WHdjcDhua3kweFFrSHhEeVZheUlHVUhRcCtibHppZ1l5eU1tblZ1Q0piZmNR?=
 =?utf-8?B?czRmYXdXRDVtcmt3RksxMUJrSndHWEdtSW9sdUFLNExKaXJHNFN2WnpVQjNR?=
 =?utf-8?B?SzRwdWs1aDNZSGkxbW1FMXNOdWFaMEV5cEJoVEhIMlhKQm5TeUxXWGxVN2FW?=
 =?utf-8?B?VHVDeDd1WUxNQjV5cEFwY0s0V1k2VnpUeFZybEhVNTVrVDIyMXljQmpSQU9n?=
 =?utf-8?B?b0Z3Z3JUakRrWmh1bC96UkhiT3VYdGdPL0VMdDNFRXNkKzdaZzhLT0dsdUVT?=
 =?utf-8?B?UVh2a041ekdtRmZmNkRKUkdMQUxpWVJ5OWdPTHkrcVJWNDVQQnFFS1p4azBk?=
 =?utf-8?B?L3BvdDd4VitHekUvbEFnZWdMSWZCSGpiaUFTaStzQ29SYUxnWWNXaThOaVl5?=
 =?utf-8?B?TjZRZURwVmdmNFVKa1AybWtJNmZTQVE2SDhKaTUrS25HM1pBYTZaaUlUYzM3?=
 =?utf-8?B?YmR0QjJDU2pCQm1OZDFpTXJER1BXNUZ3dk9oV0ZUWjB1K0xEYTFSeUk1ZHpI?=
 =?utf-8?B?cTVZRHpwTGxmTkdWTVZUbEFQREtLNS9VeXhmWTE2UXgyZVRES1pUSVdlbTlB?=
 =?utf-8?B?ZmtUR25KSlRTNEVkamRidXdqbS9kMTdMWnpYNUVJVzlpWUNITndyR3hGdjM5?=
 =?utf-8?B?VmJ5ZnBCeTJBL2NzTUpSTjRWWFBiSU9Tck5WaHZsb21JMmR4c01tQWZrUHJU?=
 =?utf-8?B?WkRHZDdjYmgwNEpKeDFhR0xUclZpcU5BV3c3OEVMbEVpbWliZWgrVTJtL3JP?=
 =?utf-8?B?eU5SMi80NEprZEJaVmRCYjZpaUUxT2FkbkdKbEVaUE04N0hEKzIyMmVJWUMy?=
 =?utf-8?B?WjU0VjN4cWhxeTZkcDN6SmVDb3A4TTZrZ3B3V29qVUxtVU5vcVJidm8xVVlK?=
 =?utf-8?B?b0lEWk1GcnNnUkJIK25EZVUybGViYWw4RG5uR1ZBU0g0VVhtaU9lbk1heWR3?=
 =?utf-8?B?WHdpc0VTSTFPOERKZWNNQlg5RFVOT0dSNGpJdkFsVEd5ZEJsUi95L014WEoz?=
 =?utf-8?B?T0dIZW5aVkk1SHErbTJMdHZuK2R1VEd0Q29UaGlrTjg3Z3F0cmMyZjZEVTRv?=
 =?utf-8?B?MkdqUTlqQ2hNRXZiaytwU3BxN2pGbDh4ODVZVEw4QVpBK1RYOVhsWnV3dTFJ?=
 =?utf-8?B?eXorajdEbGh2QkwvRUl3bXltL1d0YUp2b1hGMjE0L1VCeGlpTjhLSlVvM3Ir?=
 =?utf-8?B?OWxkbmw2V3J5dy9ucS92S0hTdVRBZk1OTWpTdWgydnB0VzNBSUpNTlVSN2hG?=
 =?utf-8?B?bFVNQnQ5OXlOTlNuTTdtMTNOWFBIL2NabFJ0K0F2eXNMbTVTWlVPMlB0bE5Z?=
 =?utf-8?B?c1huKzZGMTVhVGdEa1psNTlnb1J3aDBwNkdQRkNtWEYwTFlNZERZdkhPZTZl?=
 =?utf-8?B?WW5acStXSHljVExMcDRQS0thZ3JEZWhaUHV6UUlMN0RDVHdKQ0IxaTZaSnFE?=
 =?utf-8?B?bXorRmM1ME5kdmw3S2FDV3JpVG9Eb1JSTEI2MUc2VjgwOTZwdTFiSXNld2p6?=
 =?utf-8?B?QmRKd0FIV3JoTTl6RlNPUnQyVTBSYmJ3NjN4Q1o3bC84Y3k0RVpLSExzTCsr?=
 =?utf-8?B?YzRXN2ZxQ2RwUnRHV092MDg5c1g0Mmw2TXZIWGFhNUpLNGtoaEhnWktnYXcz?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 076c2598-58d9-45d0-e81f-08dc1b79af9c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:41:03.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/k0y7roA+6tzzYTC9EkwsqsybS+PjsqrqZvHOJm8O3xuJjkgXMX18qQuoDP2Rx0wVOdvZL8+PdMhwh1mZvhdqeKRSS6aK5LmKTXe1WiW7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com

Hi Boris,

On 1/22/2024 10:21 AM, Borislav Petkov wrote:
> On Mon, Jan 22, 2024 at 10:18:01AM -0800, Reinette Chatre wrote:
>> The fixes I have as pending are:
>>
>> [PATCH v2] x86/resctrl: Fix unused variable warning in cache_alloc_hsw_probe()
>> 	https://lore.kernel.org/lkml/ZULCd%2FTGJL9Dmncf@agluck-desk3/
>>
>> [PATCH v5 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
>> 	https://lore.kernel.org/lkml/c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com/
>>
>> [PATCH v5 2/2] x86/resctrl: Read supported bandwidth sources using CPUID command
>> 	https://lore.kernel.org/lkml/669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com/
>>
>> [PATCH v3] x86/resctrl: Implement new mba_MBps throttling heuristic
>> 	https://lore.kernel.org/lkml/20240122180807.70518-1-tony.luck@intel.com/
> 
> Is that the order I should start queueing them in?

Thank you for noting this exchange. Yes, this order applies cleanly.
This is the list of pending resctrl fixes. There is also one
pending resctrl feature, the SNC work [1], that Tony plans to rebase
on these fixes.

As a side note: I did have a conversation with James about the
MPAM work and his expectation is that the SNC work goes first.

> If not, pls send me a note and I can start picking up stuff.

I was working on a separate note to you but we can continue discussing
the pending resctrl work here.

Reinette

[1] https://lore.kernel.org/lkml/20231204185357.120501-1-tony.luck@intel.com/


