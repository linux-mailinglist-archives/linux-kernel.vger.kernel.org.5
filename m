Return-Path: <linux-kernel+bounces-31316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F161832C69
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332C11C237E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28554BC7;
	Fri, 19 Jan 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rzppu8Vy"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2B53E22
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678581; cv=fail; b=LHHequTq+rPLdTbUotA4ju2Gp2zdwC8qlL4a7in95YeP52GANl5aOemIqMVSNNff8C8aZZoZXsIAhOYx9g3dp7//pofU0Vw7gdxL9g4CpKqs2E8izjzPVIRl3Eeywtsjq3en2IDCcU5mSnohr37ANhnofyHncTgiHa6HE45dwA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678581; c=relaxed/simple;
	bh=xXWSaeIJUwgxf/EeP19LnupXc04vwb5ad9ilQnUzLS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oyy4NVUT4V8WNKnUkQGWMaMpxUBY249ns7E8nOQ8jwIWNwBuzUjejny5GHUhV9s1Y09LPNDUC6rqa0XEKpB+thXsSwLORCUWYe4dh1XH6dz2QUD36yyT1Zzaw/d8C74Ecbh1Vja2MBB+9tuf7G9bchi6w9tLcliAUX94OkiTo5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rzppu8Vy; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705678579; x=1737214579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXWSaeIJUwgxf/EeP19LnupXc04vwb5ad9ilQnUzLS8=;
  b=Rzppu8VyzTfEOuhgCtL3UnDvWwbCB2r33mCuontYX2hXEAE6wA+9hAWi
   dXfDLCZKbg9nFjG9gJ0eRymJ//sZfjT8HnBKCxhZ/lzGcxrjX/mzNd50F
   VmV1OL6nVN62RYsiw+cT9LrUaQ5c37WCEyvNXUeKyIqQFbh49loTGG1Om
   oGYHbXWDqIq88w7vAnPHHpxB1zZmYs3/M9+LtVVAD8D0C1q8KcEaDoFz9
   e4n8CVmiRdkz9ybCDo75m4K5IzGeHvHIdeOU+5PXeQ8SQXcgbI/mJ4ClZ
   JNy7RHf+GunT2Ciwi/GHKGsM2wfA4jxdxVx/r2AnoweENNiIjBacLcyzW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="391210275"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="391210275"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 07:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="788378429"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788378429"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 07:36:17 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 07:36:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 07:36:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 07:36:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVTRTEC6PJoq2uHJkw/9sVOyap3h84qRmvepO7VDxUqroxoJmccsek5VMkOHd/26Z8q7JLbASHI8YeoDgXCTDA3o65F9d/6EcD1wZQgdb6WdGvTItQ6T6R4Z6isO1iyOgDcZCl07ZBvY+xdW5b2qtu0wmxucdrqHsKddx78zn/eVSS4yxi9cc9aNbwowcfMUa52zQ3TDaBG6m1c1IxiezY/XYD5Zjnuq02j/BMEuFHOk6jJ6ozUbMmKoAgM+O+yzyO4qxCER5ZjxkFv1c9O2OGBAlP5KPQZmcohPFjMt+Am/Rokk654FYUnBJ4KPd3FJQiBctZ+97IIlVaoEi/m22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98hF6lnwghrCVHYxq7uUyB1SLJTuc7wWePBQr7MetIc=;
 b=GlZEVmKjoACFE779KoTD/IzNydeNmj6w8qi0fO8sDkKcIehx/s/toPn8vd4PO4mTfMFiWRW+7B4qwigr4jQY0D3nhqKUg5e/nO+Q9eXtZOu0m7oqvP3A6ttFwO8oCs/AIbriUknTl4lo2vrv1r6jbv/xwTDSZzWDHsyEXy/4TMn+pg8X5FCj/zXhaJKPzrl4O7lw3ACsEG45jRj5niQssiMXSRj7yn1kjF+XQGbNWShioZZOtBKVHTfoA7lAKhugKkC9TxKS6riZJryoSHMkMjbV0R7nO6hgLuvwnnzKcKIEtA181jmanjSp10f7EOAl9cy1b76yRDPilhquZG7wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 15:36:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 15:36:09 +0000
Message-ID: <ec24f943-012f-434f-8313-9c2b4e2d72e3@intel.com>
Date: Fri, 19 Jan 2024 08:36:06 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] NTB: ntb_transport: fix all kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
	<ntb@lists.linux.dev>
References: <20240119032845.4065-1-rdunlap@infradead.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240119032845.4065-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 56311239-5ff2-4283-eeee-08dc19045ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lmgtt7QQoqV9frD3iO8RKhpuPP4GIk3sp5RRDPohn49x2VkIBY+pMH2i1NQbm8tLsteK4CUfOJup/oWSlH68pP8ysZO8AgYxIY1gSOMxC5zvmOm1hoObNYGxZJG7/ySQOVAJQuzEj8wmtf2j9DGIrOrYJrQMMtH9E8/DadhfoVEQAxGhF+J3P/wrN6f3bjhlWpNntW2C4WpHL//4e4u2ke/P/DkcRZlVcNpbQ9DpYM89xQ9Cayd4PXU3mYBVU05CsXe78GbIk9E8hHrHuXLBlyE7jmx45x4sp9iUsq7bnnruSzAuM+3Lm6y9MJXGsu1Bi4TKK+mmK1RcIwB7YRbZmqsSuY+gummDWbNhuiMyhHkMtexLiM/oZdQqeCytnUrQZRutWfZozMWJ2YhU3V2O3fLhC9DtFUQaoI2x54wODaM5LdKJIiKLyFvnt/GFs3n5cvmZ85+A+3mOE/SG05meBPxN4vUY6rEqTTFDYmPjk8hKTImIRKgdfuEyW0wtZAPDmwm3bKgr7spXZphgcFtcU23P56nRiXVzxnWqUgKe6Gzhjmr+Saa+hiSsvxyj8Cw3tC6YfS3Qk1vegmctqpKtTmvglL5Hp2JfonB3EMg0X3NxVj/cPgpzKyp+8sKA4JAjplg4gib4PwRsBRv07Zw16UGztcw69vxPz7IIkxNyWwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(478600001)(6486002)(6666004)(41300700001)(26005)(2616005)(38100700002)(31696002)(86362001)(82960400001)(83380400001)(36756003)(53546011)(6506007)(6512007)(44832011)(5660300002)(8936002)(4326008)(8676002)(2906002)(31686004)(316002)(66476007)(66946007)(54906003)(66556008)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW0xQjVwc1d0NGR5MGM1VWkwU3NCRnp5YjcyK3NTeWFPcUxpbEpHbXVNOEhQ?=
 =?utf-8?B?UnlwcXlUTmxNUU5SWVl0RjNzWkpnL0krNzFsanZycmRnbDJRazJyeEx1d1JU?=
 =?utf-8?B?VWsyYmlTa0JBbDZFUW5LWGlIUlVTaGUrM0YzSjdOMEJDR2xoUWZCZk42YWVi?=
 =?utf-8?B?UlYxcUlUUW5pTUx1d0ZxaHY5emxrenk0QVFZWVJSZ2lFZUtjWnpBcjZvc3Jo?=
 =?utf-8?B?WnZZa0NkaTVyMG5kT0Q4czFtL0Uvek9WZ0JJRzYxMnREaFdtWXBodS93WWMr?=
 =?utf-8?B?czRVRjRKZGRGT2ROZzdSVmZ2bVl3TzF1S1UvaWNUOTJpVEUxUmxVMFNFVkN3?=
 =?utf-8?B?L01QWU5zcFhHdHA0ZTVQRktHZHdmV2FmSTZ0L3RmekFHa1Avc3NJd2ZtOHRN?=
 =?utf-8?B?RVBrTk1ha1pkZHZsV2ZYUi8zMlkweWN3UWRsb3RzeDdVRURjNkN0cS9QcytF?=
 =?utf-8?B?VFlNTUZEUXlITlQwbXdrc3EvWUc2QzVRWnNNTTdQWHJ0NDV1Q2RjUFlrRWpN?=
 =?utf-8?B?WnJRWklpV0x4dzNIN1d6Ykg0TmFzc1V3Q1dlWDBaTm1PVnBhL3pmS0NXQTVy?=
 =?utf-8?B?R29ubVFsU1NYc1pVREpGaUI0a05IT1dmUXY4NDJ4VTJFWERRaWtsaGliRzkw?=
 =?utf-8?B?dzNxblRGMUlBWHZ1M1d0ekNNK0owM2l1K28zNjNoRTlucTh3NS9Sa2NIcDNO?=
 =?utf-8?B?MTFOdmJRTjAzd1F5dUtiMWZNVGhja1YrdVNPclNCVDM0enlwQmJnejdwcTQ2?=
 =?utf-8?B?OWEyWjlUbHc1dTZUVDN3WS9BQzMxVzFMVlY2c0tzZTJLb1hleWd5Yk1UaVN4?=
 =?utf-8?B?QjNkVFBSSlhrTW5USmhjYVkwUTg0MUZkbmhkYkdzSVZpbi9BcEZFRlJpTzg2?=
 =?utf-8?B?SndjVG1PWWVPLzRJaDdGUHBDNXM0WXhtdFA0QkprcnNWZWlFNGpERDRlSUhP?=
 =?utf-8?B?VTI4TWtMUFpkWkFkbHgwSUpzRHVHL1gwaGxSN3d6ZVhMVkJ4b2VQam50OU9O?=
 =?utf-8?B?SnFQQTVHT2QvSTNFQS92c2dGWmNqTkJ1anYySTd6enR2NTUrT3hkcFJsVXND?=
 =?utf-8?B?Vm5XT3hQTnBTWHI4QzFKQTUvSS9rcUx3eWNvdUxOczNHOXZQYUpwN3dCK0lh?=
 =?utf-8?B?akRBQVpaWHdHSEhucm40TWFBMmpaUEc2eHhIdWtQMVhaUnNNUFpxMG9pS3Vn?=
 =?utf-8?B?TWpDOUp3dlFTUVZwU2tUMW8vWnZOM2o0MU8rRlRSYmU2UVoyY1hTQnhUa01h?=
 =?utf-8?B?VXlyRVFyZ3AwYnE1TncweE9HYW5RQWx3Z1NpTEZneHRBN3l6NElRcFVPQXRt?=
 =?utf-8?B?TkJ5ck9FcmR5NXREMFBNZndvcjlzN0kwcUE2aHhHaWZ2NHBiQy9uZ3JDaEtn?=
 =?utf-8?B?MmtmNDd1TVQ4SVpsUlgrMUE4STd3NFlDMHBNNldQTVRmNEhMTEdjZ2hEaFdr?=
 =?utf-8?B?THpQdVhmUTVZQVZoMG85dDJ6MHAzTm55UXlDMTRIa3oxYTUwSjhGcG1Cb1l1?=
 =?utf-8?B?Wi9Sb1ZzY2VCMjZwWGlyTDAxSEs2OGU5ejhQbFdCN3R6cFlub0V6Y3BjcnZS?=
 =?utf-8?B?Nk9QREQ3eTk2c0kwYTRnYkV3aHhCcGFkV0oxT2VNTHlEUFJOTnhabnZPSlN1?=
 =?utf-8?B?V1Z4bUVQbklKckZRZ2JKeDdKTFd6VVVwZnZLWTh6em1DZlZGWGxqeUZ5dkQy?=
 =?utf-8?B?QmlwM3lWWW9idmZhWXZQNHdWNEhsM1NRbE1vVTJqVk54YTFsWE0zaXVHcG1q?=
 =?utf-8?B?VjYrdEVOVEMwNUxOWm5XTHFGTkNMRDdCc0VuZzUrTmRwdE05eklxWXY3cWF0?=
 =?utf-8?B?bnNIWTVJa0NjaUhzdTNqZXVFN2Q4K3FHTHVxc3J5SWk4RFhMSUpiYnVrV0pk?=
 =?utf-8?B?TmJmQzkxV0xoYVFhZ3J2emI5STNUNVllWFMrSjNDYjMwdEt1ZS9KUkJ6Q0Ns?=
 =?utf-8?B?dDA2VkJoa3lVZE9iWXdTZVJ6NEFjZVdKNWR1cjN0K0pnQ1cxVmNSQUl5WEdl?=
 =?utf-8?B?cSt6Q0ltWk9CM3VMSlYwakVxSlBKTnMreGV1ZmQ1TG1weVJSQ0xONG02NGVn?=
 =?utf-8?B?UVdQcHgzcHBaQVViQ1krbTdBZUlQZUpSUE5Tb3hJcjdkMExXcG5aNHIyS1JF?=
 =?utf-8?Q?L9XoKnHDrrgCjYFSZJsHR/7oT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56311239-5ff2-4283-eeee-08dc19045ba8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 15:36:09.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUBPCW/u4CIakEBEKGGVVfqGvNTJLSDr9ksdhEOXaZRiOqFK6Tw6XL7RgBJ6+6SuX/pMYFvwhJtz+8z39FVpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
X-OriginatorOrg: intel.com



On 1/18/24 20:28, Randy Dunlap wrote:
> Fix all kernel-doc warnings in ntb_transport.c.
> 
> The function parameters for ntb_transport_create_queue() changed, so
> update them in the kernel-doc comments.
> Add a Returns: comment for ntb_transport_register_client_dev().
> 
> ntb_transport.c:382: warning: No description found for return value of 'ntb_transport_register_client_dev'
> ntb_transport.c:1984: warning: Excess function parameter 'rx_handler' description in 'ntb_transport_create_queue'
> ntb_transport.c:1984: warning: Excess function parameter 'tx_handler' description in 'ntb_transport_create_queue'
> ntb_transport.c:1984: warning: Excess function parameter 'event_handler' description in 'ntb_transport_create_queue'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: ntb@lists.linux.dev

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks Randy!

> ---
>  drivers/ntb/ntb_transport.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff -- a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -377,6 +377,8 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregist
>   * @device_name: Name of NTB client device
>   *
>   * Register an NTB client device with the NTB transport layer
> + *
> + * Returns: %0 on success or -errno code on error
>   */
>  int ntb_transport_register_client_dev(char *device_name)
>  {
> @@ -1966,9 +1968,9 @@ static bool ntb_dma_filter_fn(struct dma
>  
>  /**
>   * ntb_transport_create_queue - Create a new NTB transport layer queue
> - * @rx_handler: receive callback function
> - * @tx_handler: transmit callback function
> - * @event_handler: event callback function
> + * @data: pointer for callback data
> + * @client_dev: &struct device pointer
> + * @handlers: pointer to various ntb queue (callback) handlers
>   *
>   * Create a new NTB transport layer queue and provide the queue with a callback
>   * routine for both transmit and receive.  The receive callback routine will be
> 

