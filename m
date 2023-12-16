Return-Path: <linux-kernel+bounces-2080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DC815798
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E796B1F25DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20851118B;
	Sat, 16 Dec 2023 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA8x1ZCR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8D10A1F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702702722; x=1734238722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5UqUuQtnWvHGl+XuJdvak1NXiD05/HsTo1Ownfu2zxM=;
  b=VA8x1ZCRQDH0i4TWgQOp4vMHBwFmk4eK/12S467o+QJm1IOaSOdr2rtL
   NNd8GOISFtRLuLjJCSjvtMOfNREhiGqgk0TaYUvpKqe0LNav61gLBsUya
   xBIY3OF6L0gMBeMTkSgbQgSSqb/48gjoZz912zaAs9o8RSZUKooI6YQpi
   nLILxfSZd6kzXAx19uspwYoJ4Lqpe92UHDmp2idcxzYApEroaGzzcDG1/
   t92uAfIgr1AQQB6ZIXfRg1ysnck0kqll2+Q3so8OCfmQa9Kvfe6llCMX6
   euX3bBR7ZRUJkzZiF4XNqUxC8oZywqa7aV25pZsGL/Qa+q/SdBHVbZtX5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2534713"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2534713"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 20:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="768223656"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="768223656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 20:58:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 20:58:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 20:58:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 20:58:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 20:58:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPbzA6VUn8xfA7Zgo2lgnAxsUEoDEQyldymcso7hRt72Jf6afWw6ssd/7iaDDJrMjfUjbEPMD6D1Pz+d2h+bVn0ZzptE83/1uHHGkLXzVW6QRM+P7ElL0mIG148PS8IWFx0sGKx7KGrjhuOZJAw1gtuvKea5pHLLExSn2uWONa9nVam591NHAFoBsGTY6GtlPtfUYaE9WY+N50Gn6Ixf4svqRpykbSQJwaa7/AiyzccItWEA0+a57nkhoPLgGnACBA3edkliHbr/l/Jh0fNjHX5gIZrbW5Gnh4CBCbkVbYevw4isH69QnDcsjX/mzWUt9bk2rWuQ4Yz4COOxSuZjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI094OY3f5lAnte9q7DUuMRPI3av+MrZbxS8gWSnKpg=;
 b=S8aukZky5YjRuD7nXfwZqOEWQtLnHjG5/BxJdpNudUcyXiSh/hwieD04lkyW1CGfSDYyc5YcHDSP5CWFfYyo94eIUqt7DdgN0g+Bk5vLnZ746lLAhHHMxe4vInzn36/rgnq7BM8wZOuza4i82+ePLscumRB9AK3tyvsquNj5HOlBCP6YVz8sHHaXiI2FEZHgHbI4sXYRnJZXANZpGmoOOGIl9w8XKkFFwEr99aQnYtw9TISg21za2q/ihaoRsCC+CjFJyzrPDCob1THSFuDP0q5d7O7ThhATr+sCPpL+tOy3w4XclcLGs2OFtP+uv+iz58v0y39HDj1hoQ9Xr8rBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 04:58:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Sat, 16 Dec 2023
 04:58:05 +0000
Message-ID: <e54dedf6-158f-4553-b309-e4c61d69587a@intel.com>
Date: Fri, 15 Dec 2023 20:58:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/24] x86/resctrl: Track the closid with the rmid
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-6-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215174343.13872-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0b5cc8-0fee-40ac-5dc8-08dbfdf396c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cJ+jMhnPYbi9r9WxA1EOFtGOxLm/oqeEANPSoxMV5eeAY8J3gyJPy5akePJvZoZub4UeDSrV2usp0e76VUI+IreJiJP5VMjjimqugNNVRqp/kSvYrv3xqgTJbF5naFIFTNFyex7aamBCSBGy8p3aqrSDBV8Mx4AgdbCLrMCPCQBrFu+Q/WaX1bgxrY7aWPd13xBP4Ok6nDxAjIB159bqaGvJIj+y56wqScCMS8bOHG0uFypVS5mZaBuPKD63vgGLGdW+qy9t37GWsETG9akvE1knlvqsutHude1RLez610Pv+bYTKMASdbZYk0TqlxhiWqIaXXJ5uAzrFEgKMnnDks6jUU5Tdb9xWQAgty0dyZ6Jd2S2+ai96VJmhUYSaXHsO411yTKcAVKw31CvyK2W3nnTGnxL+SNbq3QJRezgG15ONeRRhCSY66taBciUXGWXTFcGrPZCW/CeB3xnPvERz2IizUFYVdJ4i57sBRxoMEmvhhtUxz4MmJMh8ianY8Y9qWZcFUdv8YZPSSx+Wp0ohKMBTp5Nj1IOJUO8vza6z5a0fUgoJ1VXSQH95CHZeNv0jYH4R1FsqzGR2jWPS6e5dSliB+ZsgGXX2ZpuFkkrBpnwZGdcshGFqM9yvBN2t4aVdDKWDPNf9/aBFT6gQGYvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(82960400001)(86362001)(31696002)(41300700001)(38100700002)(6486002)(8936002)(8676002)(4326008)(66946007)(66556008)(2616005)(66476007)(316002)(54906003)(36756003)(7416002)(2906002)(26005)(5660300002)(6506007)(44832011)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxxUVl1K09rVzh3RXBySkNucjhtM3pmQVRHTUYzaFhUZHBxTlZVVHo4VjRV?=
 =?utf-8?B?Q1cwVjRXV3pLVUlKOXd1dmRkb1EvMFVSTm5QS25pL2hsVUIvTmN6TVBQOGVR?=
 =?utf-8?B?czdhUVlVeC9zN2t6dUkwZGtBeFhTeVljMjR1M3I2VG9EZXMzMG5zTlliNHo1?=
 =?utf-8?B?TWFVOWtPcUJIMklLMFNBL0JERFJNU25tUFBhb1QyMDFUU3lXQ0pMR2Qybk9W?=
 =?utf-8?B?aERUTVBNNDNKWjdsME5rR3FoOHFHeExMR0piN0dqQjRyZklyNmxDZ3lmU1Jl?=
 =?utf-8?B?RzRsT0Zqb0FUdW5zTitSMGlYLzFiWkw2ZjBCTmpIRFd1SC9LZDlkMERXTGti?=
 =?utf-8?B?WmxEekRQVnRKNHV4MVFhR1c5M2p1S3hDV2FmZ1NhbVpxblRTV2hranN2RXpV?=
 =?utf-8?B?MXBlRnNwZmlZMnIrc1FRYlh2VFloQ3h0cWFVQmo5b1hSMklONHVEc3JLRkJ4?=
 =?utf-8?B?Zm1rdGEraldJVVJsOGlkR0xJdCthRFNxTkFYMWorR0RSMjlObExyejFzSDZM?=
 =?utf-8?B?NTR6b05XQXFKVDg1UW1XdnZyY3lZSmhVU0NMVUFjSFN0RFlKNTVnK29yaUpQ?=
 =?utf-8?B?cEZEZW4vL2U2SWZYNDRXcDBRdmwyZzJQa2hIQ2w1ZTNxTGdBT2toT0dXN3JL?=
 =?utf-8?B?WnZmSllZYTFpVjEraG4rNGFRRHN6bzBQVGR5RGhOaXlwZ1JjSTlFTnZDVFcz?=
 =?utf-8?B?a3FaYlRRZ2xyTkpxdW1ZTmU4TzM3SXJyZmhlNEZJTVNwV0ErVmpRL2owZnFv?=
 =?utf-8?B?NkhoSGhWOXBqbnhDS1I3ZnBWeXYrdFM1UVl2b2F0VUpvM0RYVlljT0RGdWdF?=
 =?utf-8?B?WXVtaEdqMU5TZ0p3RlllVnNma01mZzdhS1BqTEZTam1DektoOTR0emFHNXNV?=
 =?utf-8?B?WE1kVXI5SDlTOWQwRlIrY1Rjc1lDU1pOTjNrWHhCcmhKVnVtUUkvcHExeXdJ?=
 =?utf-8?B?Z1pGNUorcWxBdUo5VTFKTURESkpoeFlnVjlFanRpYVNTWkMxRXl5ZmQycW5s?=
 =?utf-8?B?eGYwMnpzdW1KZFlueW1xN2picUFicFBFNEtIdkY3U3pzQ1BNMHZlYU9nNjE4?=
 =?utf-8?B?cUdsNlNERFJUL2pLNnFZSEpNUm4vakI1U0FZTVQ1eURwZUxNMHp5RGh0aTZW?=
 =?utf-8?B?ZVJNaFJYSlIybjkyRUlic08xRDNXeFppZkNsVHNkaCtBdDlmckJUYk5peTh1?=
 =?utf-8?B?WThMTnZDNkJYUUVwdENiTkx1YlJsblhzeWtUVGNUTzh0M29TOUlycXhFWnJY?=
 =?utf-8?B?bk9mMENXWU1BSGFsU2t1ZnNNQzVaQzVaU28wU3ZEMWFyc0FLcG1hT2NCRVF1?=
 =?utf-8?B?STZQS0xaYUw0K0RnZlZuaFgrNGpZR3ErK1lDL3IwekdYdFpSc1RockdOcFlJ?=
 =?utf-8?B?aXZvSFBlM1F0RWRpcE5Edk9UR1l4WldyRFRXb3NFYmxOZXg5MFdQWWdlYks5?=
 =?utf-8?B?T2dPSi92SVZET2EzbXV6c2NGY2dBYWxpZmlLSGxBRzVmdHowTnU0SEY3dmEx?=
 =?utf-8?B?NFQ2bVhoeUYxS1R4K3I2eXJKZmJESnpXai9MNFVianNKY1JKZkxiVnJncUsz?=
 =?utf-8?B?V0pBRk10MUZybkUzb1FHOGFhZTYzWUM2RlVjL0JhUWlDQVRFUWJiUEhiakcz?=
 =?utf-8?B?ak5ZTnRDc1ZGR0RXMUFDWElULzRlb0hVMFhuMC9DYUoxb2pVVFFPWjN0aDJZ?=
 =?utf-8?B?dmlJZzF3VjhqdlpZK0VJQUlOdzJWNlFucHVsZ09kR1pvRmxBQnZBWUhIWTI0?=
 =?utf-8?B?K1JQUU5jbGQwaWZWZk16aGlSQUtudjVBd3BBNEV3OXplZjhNd1JvZXF1a3pm?=
 =?utf-8?B?dGVMeTlweit3VS9wL3ZidXdGWlprbDJWWmJFWHJOZHhTekY0Wllra1RYUXRQ?=
 =?utf-8?B?cFlndzU0STIwUkJnbEZkeHNCV1NVZzYrRHFzMS9Ba1FCaS9hcVVSNUFmb0NU?=
 =?utf-8?B?bjUzSUkrZ0J5ZE9ZMGJsc2VOVDVqVUI3RWVEbnpNYjBJN3FEcjY5VzhQcVZp?=
 =?utf-8?B?WXdpZ2xEejQ3bXkvY1ZUL3dHcWtudWZ2NHFMenJ5dFRNbDJwb3ZsOWV0M2Nh?=
 =?utf-8?B?SHB4SDVKa0R6REFGU3M5S3BwMnJnbjhOT05UZXMzNit1YnhEZHJYSWx6eVY1?=
 =?utf-8?B?UzVUaUxvc2RjWVBaUkdoYVZUNllId1EzbUpmRHFZbCtVcmt5STFqeXk2Q1Bt?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0b5cc8-0fee-40ac-5dc8-08dbfdf396c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 04:58:05.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMhxaqPHxv52Q1kGdNIoCBXTSYbplsV0T6h6FcIE3B2GfRleXed/ngCBvFLG1oWGq6vJtNDI+ZNRX+fwJHEbk/YLJHz1eabEGxuoog72A0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

Hi James,

On 12/15/2023 9:43 AM, James Morse wrote:
> x86's RMID are independent of the CLOSID. An RMID can be allocated,
> used and freed without considering the CLOSID.
> 
> MPAM's equivalent feature is PMG, which is not an independent number,
> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
> 'RMID' can be allocated for a single CLOSID.
> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
> monitor groups.
> 
> To allow resctrl to disambiguate RMID values for different CLOSID,
> everything in resctrl that keeps an RMID value needs to know the CLOSID
> too. This will always be ignored on x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

