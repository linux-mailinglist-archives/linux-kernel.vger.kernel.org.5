Return-Path: <linux-kernel+bounces-53798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E009C84A6B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6135D1F29371
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425204F895;
	Mon,  5 Feb 2024 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip+rrHGG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6154F887;
	Mon,  5 Feb 2024 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160012; cv=fail; b=c/vNz445D+HasBM6+9I3x5vcJjHvR+n9g4BMDM9bEgmS4MQuq4Cge32nchR+lemqAioei2WCozDAKcJMWKrnzQDYVW+DzdJk5VECTr3m/zr0e2Kc3fvZJycPhU1B4N0dE9SmH3eCLxWMAwkCcGrNDsBGsP8SFTDKzxs9SCdga+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160012; c=relaxed/simple;
	bh=7xONlyVI4t46SFZAwIM9vh5LZqWX38/TR3XuoNyZWSA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ihbzDdXpqrLCy79VvAXCErEcPjM7tTS5SuajaCIFY2njLp/PUoLEHKTZ5PN3+uDRwGzUj7ZaHSkc1ud3sCHD3Zd2F5FVhhL67CrnFZdgWp9XNQCHE0E+gIHXVq9PDZ5+a57PTtgezD1KxBmotkgz1QXaMsMjATKg61jSv/uToi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip+rrHGG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160011; x=1738696011;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7xONlyVI4t46SFZAwIM9vh5LZqWX38/TR3XuoNyZWSA=;
  b=ip+rrHGGO2unOJLZJtj476CzLZBxTI0gdR3XUCO88obe9dzv6iwC83nO
   4nBYDBH7fwoYwAm/Z81dkGB7IzPqoJaqFMPlBHYivX7FoVBRB9feJ0aJO
   C/rBv/XFeRoATs8G4N/F4YjYWOkPwOlfizXTpQPXC+HTOo0kHVfV9Se/I
   8coijT5hRpE448psc4rc9DkVWJPdVrbblqx/uEQQNwTNm7dx0y0cOdGOs
   rhazKDws9rAlv+y/TU5GjK+YSZGYo1A7gSQj+tjo67dlIik4DDiKZTR6y
   b5YXkIlopxG4Bw8AAmCjH9feQiiNWD98KXgc5watJLpSuRPIvk3A+J2Rl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4378251"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4378251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5398030"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 11:06:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:06:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:06:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 11:06:48 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:06:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFUoxwAIUFYiWU2EFwx9ZtJ274+XuxiUlcBFKFrppdByrY6C6z7xmJvvBCWxI69yVoO9Xos/rLgqjw7YPrVkUBqemWM8nxLqK6aPWpn7z4dfVgTvAF2D8vp51WUH6dWMQFlp3rVXV2xJ6Wto8JjiUlgVNDW1SOuulCKYmOoxBVTZYMLboNxztk+opXzYKCbj+pPlktSJqSSreHHAbtGjFwZNCmFex0VeaPtfPi8ZieuudpOuNSTVoV6jmccWsNCbBzUku9E0s8qwM48S22XnTtT2GZVl5mnpVGOK1z0HvKHB2husL0ib4vDGNOnhmzBZsAOcggL9DhnSwlucdLb5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGIogkxprXTdkx66X8+DymZIg78sywT1/vVhC0qZac4=;
 b=UYleCFa1gHnbZqy7pWs+dECmfdkJUR1tEYbgDiNw4wHTZ1z34R1DNlXhzjrolnO+/eKpRjm02hlLRds1FV2Rf9uoCjsudHZEdZ2j+j8AsZqbAtvoa6M6XbSCLihObZQhoJaw9QXam7jW7Gc6eE1qM54D3s71RL5QtNtkP3DNaWKu+mQTYNQBP8Fm3xXWyc8MGW7mNjQuKJBJioIde79NfbmJEm/gh3QDYET88Nl9ltKfcBG3QwgS41aIAux9cIeHu0YXRn/88WOlVcjP+VNs4SvRp0kVBOHlaQbNyxl7BSnb+i2d67w3OV9VqqbWP13zVFbQtLCMvOzQnzluuEcRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 19:06:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:06:45 +0000
Date: Mon, 5 Feb 2024 11:06:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH RFC] cleanup/scoped_cond_guard: Fix multiple statements
 in fail
Message-ID: <65c131c2e2ec6_4e7f529442@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240205-cond_guard-v1-1-b8d597a30cdd@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205-cond_guard-v1-1-b8d597a30cdd@intel.com>
X-ClientProxiedBy: MW4PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:303:b5::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: dd164d0a-7313-4d19-71f4-08dc267d9866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0t5NBMkVr8jQUQzUKVfalL91415bFmGKsw33opcJbwQihycZq5gQS28rtRRrR3qjvxTyJpZdxC4G0wOntndR5sz9jmEG4K3Nao8quxRRWozrsvxvbW8gghXFN8q5Xim4K36mzz9BiZ1m3ezKaDqIaoNlXJcK0h7gQcbkZwkYhu8U+QZLQ/tXSzovlxTJ4W8lSJPZJwfJn3Cd7pZaVvV3lByAe43z6gM39YGinofq+E5nUzb/DgPEq3heZml5dSK8CqZtN1CKMopWMqmJizwLC37XbV7fK3s/8df/eeErchd0Ibbo+aaa1KFjo4OLOolA0ocqINFj8Gt8lTPP4lgQbDzNeEO+VhOE8ZQTnvy524cApQPaaYRKCmC8cUIpKuqPXKO0/YfqXELUhuEQmCSvKdz4DZMWh6Iek3+H0FmoggYvZLhGIaR+J/EZRKWH73wHpQPk7XtxWBP62eZcnAI1FDbHxSA88+/8Np3nbAXcBthBaBlS/q2gy33CRXNdi0vKCClkq2BVTUaydVDpizNq9PwpYemApoh0kg46pcUJ/daHSYe/IHDBbxgS2zeanxEDcN3HWOqtP4IQ1KFDV1/i1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(82960400001)(83380400001)(26005)(6486002)(966005)(86362001)(6666004)(6506007)(478600001)(9686003)(6512007)(54906003)(110136005)(316002)(41300700001)(66476007)(66946007)(66556008)(4326008)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1ozYkE5cENFRVBjV2hYUWZXaDQvRk8xSy81YU9ydWppU0duMmVZRmFMcm5m?=
 =?utf-8?B?V2E1LzR5U2tIeGswV3YwenRUZDlxM0VCVVFFemx2cjY5YVdtMHYxeVZBSzhG?=
 =?utf-8?B?VUROYTA1bEZldlJZdjZVb042bFVCcXRGeDltYWJPakJxRk5qUEJva2JIZHJT?=
 =?utf-8?B?MzNjWXFBUDBXQ0pHblNNeS9XeXFUYktlZzBSSk8rajZQQ25kNnZyM3JMQ2k2?=
 =?utf-8?B?bk9oaFd4ZEJYa2xyZFlGTndpRmJESW44Z2J0bHpyckJzQmJrcVd1MndiWjdT?=
 =?utf-8?B?SjhqWjlkM2crZS92R1l6clhHd294V2IyR0NVVjhYRXkrUFExODRRNFlkQk51?=
 =?utf-8?B?ZVlIajVvZUdQT3poRkVNbUd1WWo2ejhIQTd1b1lHQ1M2NFJWMEtLejZEdTVC?=
 =?utf-8?B?eDNpaThjeEY0b0xIMHFiUjlRYW5iaVJvdEEreVI4LzdzN0xFWlE3MVJwNENt?=
 =?utf-8?B?QmRIaG41TFV1RlVkK1hmUm1WZXVMQUoxMmhXRG93SnJ4ellRb1FtNFk1eTUw?=
 =?utf-8?B?RzFySXhGZTlpbTVoRFJzc2VhYms0TWpoNW03SHZvWnNqT1FMUzRSS1dJMUxn?=
 =?utf-8?B?clJGN05mRVFEZ0R4SjVZNWoxMC91UWRmeEpVUWJZalhuN2w3RmxOdnN6QldL?=
 =?utf-8?B?dDFUdUdqaWhWdDloQlJhQjNCeS9GSVBHa05tcFFzenRQNDVja1IrckIvblQy?=
 =?utf-8?B?SHJwTUVMOG5vWnd6REk1VEFjMjlUdzhGd2ZzV1RYS29aZGNIOWdINXlBNCtY?=
 =?utf-8?B?WmFZdnkraTdpZmR0ZEloRHN3SDJtdTNReFhydmJ2VTZxNDNZcFg0ajRTNFRD?=
 =?utf-8?B?SDRzeGpJbUxBZ3hGcWtrdTdjUDZ5ZVJrV3d3bnlEcHZ5VTI0cHRhM3RhOGd4?=
 =?utf-8?B?NUVpQVNqM1hxaUhjbmFGYzhURHFOazR1ZEd0aWhSdjFZdGczQWVIRmtxT25r?=
 =?utf-8?B?S2lIelJ4ZmozZDhLYTg0dXA0NGc0WmFhamsvcnVsblZqNFRaODhSanZIYmpD?=
 =?utf-8?B?Ujk3VnJOMWQzUDhxeGJvcmpXbkxPZ2UzRHNleWJEVHpFbm1RSFlvZGxDTEZl?=
 =?utf-8?B?YUZHd3JBbmRoZERLWFFHQ3RnT01QYi9LVng4WmZjc1A0QlpNUDN1cWlEYlkz?=
 =?utf-8?B?SmJ5VTVEUzhDV1E1RVFVZi9rQ251R1VKZktrQ2xGRTg0ZEN4ZVdxd2QycFkz?=
 =?utf-8?B?NTR0Zk91WlBScmJKQmo4YkxXcVV2SGZJY3l2QmhnYVpnN3htdDFIYlZkbkxL?=
 =?utf-8?B?Q0NYd1oycDgwQ1RVTmRtVkxKSVFxUVJkVmo3TERCL0JyMVNWckszbERWUVQv?=
 =?utf-8?B?THZHOUQzRDRKN3dSZFlhK2NnY1RTa0FIcG9IUWxKUGZ3bVJ3cUtlTzBwTnZ0?=
 =?utf-8?B?M3JFd1QydnhDRnZydTZsUXYyMkpvbml5Uy9KTzZ0UTY2NHJWYitpb1hBa01J?=
 =?utf-8?B?dUZLd2I0ZW5Ra1VEOVFiam1OSFZ2RXU5dm5QdDJGYWhoYVZZTFd2SEpKaHZF?=
 =?utf-8?B?Uy9TRVVjeXd2M25MS2xoRG5vRXBzdm8rcTJaVWpSa2RFTzRPZ3pxTSttV3p5?=
 =?utf-8?B?WU1MeWV2aVRVRUpPb2FIc0VsaG5YRklQcWlFMmJZeG0xTzdrZU9ZRmROUTJy?=
 =?utf-8?B?Y0tWRG84T2pDdVBxV1Y4MzlmYjJhekoxeEx4Q3VBYlR5U1FRa1pqT1B5VEdj?=
 =?utf-8?B?WDBhcHc1c2hleWRzbWNNcC9xNEticGZhZTlPWmVmNFZpemdRaU5pU1hNNUlU?=
 =?utf-8?B?amw3ZnN5OGhmc1RmSjM2NnI0OVZVWTA3ZElYdjhVUDBNbGpIVnpBeVAvU3Bo?=
 =?utf-8?B?ZW1jcU5oVE1mTEhLYzRLekdZTU10TzkvRVNWejEweW1sc25RZG9icGpWUHZS?=
 =?utf-8?B?OGQwcXN2cWFyZVQxSjhBTXJxaFQrRkdsZlJLbGFPMW4zMGZlT1RNVXdqYTRz?=
 =?utf-8?B?b2xJUVZQeHNvMmUrYkIwYllkcTJCYWhIKy9nV09hL2poTHdLYVpvZWZjZlQ3?=
 =?utf-8?B?aUVONllZQkYySnJVZVp0Nm5TcXhYOFpTbFQ1L2VuNDNvV3FJZE9xd1h1T0xP?=
 =?utf-8?B?VnpyeW9VaEVOZXBhOWNsOElFbm5oOEp3YnJxWEpXMjFFQ0NrQlh1cElPV0VG?=
 =?utf-8?B?a3dkd3plSXJyRDdRYmc2ZkYxN1FDM2VTL3MvWWRSVEVsY0cySWMwdmVteXBF?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd164d0a-7313-4d19-71f4-08dc267d9866
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:06:45.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psEfhRxdMJNBKp5VCPIDHMvTxuVCiHeSig2Ng7+TzzQT9EwyfZzFuSY+8ArENjqKhG+z/4UG8ZGePlo7A1HkKNBWmKYfg3PNoCp2D4SB/3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> In attempting to create a cond_guard() macro[1] Fabio asked me to do
> some testing of the macros he was creating.  The model for this macro
> was scoped_cond_guard() and the ability to declare a block for the error
> path.
> 
> A simple test for scoped_cond_guard() was created to learn how it
> worked and to model cond_guard() after it.  Specifically compound
> statements were tested as suggested to be used in cond_guard().[2]
> 
> static int test_scoped_cond_guard(void)
> {
>         scoped_cond_guard(rwsem_write_try,
>                         { printk(KERN_DEBUG "Failed\n"); return -EINVAL; },
>                         &my_sem) {
>                 printk(KERN_DEBUG "Protected\n");
>         }
>         return 0;
> }
> 
> This test fails with the current code:
> 
> lib/test-cleanup.c: In function ‘test_scoped_cond_guard’:
> ./include/linux/cleanup.h:190:17: error: ‘else’ without a previous ‘if’
>   190 |                 else
>       |                 ^~~~
> lib/test-cleanup.c:79:9: note: in expansion of macro ‘scoped_cond_guard’
>    79 |         scoped_cond_guard(rwsem_write_try,
>       |         ^~~~~~~~~~~~~~~~~
> 
> This is due to an extra statement between the if and else blocks created
> by the ';' in the macro.

A statement-expression "({ })" builds for me, did you test that?

> 
> Ensure the if block is delineated properly for the use of compound
> statements within the macro.
> 
> [1] https://lore.kernel.org/all/20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com/
> [2] https://lore.kernel.org/all/65b938c1ad435_5cc6f294eb@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> NOTE: There is no user of this syntax yet but this is the way that Dan
> and I thought the macro worked.  An alternate syntax would be to require
> termination of the statement (ie use ';') in the use of the macro; see
> below.  But this change seemed better as the compiler should drop the
> extra statements created and allows for a bit more flexibility in the
> use of the macro.
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 88af56600325..6cc4bfe61bc7 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -186,7 +186,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  #define scoped_cond_guard(_name, _fail, args...) \
>         for (CLASS(_name, scope)(args), \
>              *done = NULL; !done; done = (void *)1) \
> -               if (!__guard_ptr(_name)(&scope)) _fail; \
> +               if (!__guard_ptr(_name)(&scope)) _fail \
>                 else
> 
>  /*
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 2fabd497d659..fae110e8b89f 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -441,7 +441,7 @@ static int ptrace_attach(struct task_struct *task, long request,
>          * SUID, SGID and LSM creds get determined differently
>          * under ptrace.
>          */
> -       scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
> +       scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR;,

..otherwise, that semicolon looks out of place and unnecessary.

>                            &task->signal->cred_guard_mutex) {
> 
>                 scoped_guard (task_lock, task) {
> ---
>  include/linux/cleanup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 88af56600325..d45452ce6222 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -186,7 +186,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  #define scoped_cond_guard(_name, _fail, args...) \
>  	for (CLASS(_name, scope)(args), \
>  	     *done = NULL; !done; done = (void *)1) \
> -		if (!__guard_ptr(_name)(&scope)) _fail; \
> +		if (!__guard_ptr(_name)(&scope)) { _fail; } \
>  		else
>  
>  /*

Why 2 changes to include/linux/cleanup.h in the same patch?

