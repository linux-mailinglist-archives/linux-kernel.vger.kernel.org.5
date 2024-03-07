Return-Path: <linux-kernel+bounces-95812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B989875317
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F4284584
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6A12F37E;
	Thu,  7 Mar 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuFZ5Azg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF881E4A2;
	Thu,  7 Mar 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825083; cv=fail; b=SC5f1erFL4gOXWgrneFeQnUMtFMrB9Twl9GxUzf+AmbvckEDzyKTK4M5VIN5vZITJzsuMAPHZuXeYfFlS6HAeqp9iPk6KB2pjW3AQAZgKr1Gpb0bqB2bGRNQZyjvAEW3HpmKiGKQQk1omyq7ED6tDtxC2AWXh4CQBJlAnZVnIS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825083; c=relaxed/simple;
	bh=mvK0sF5kFlzNccFn57LYI+EVORCuTLLbtujHY5+LAsA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GIRnVqwdlbk4WyZg4HSeDvUj3u4wUnZLu96QOjb7TWcBm01Ok7y8lWrtnW75ZX0rygMO44BXRYhhGln2YediuBcEW17inDMhYrXFRz5lVUWGw9WQ4DW8WSkrae9XSI22H4H3NKoZtMDdTqn3J19nASuxFJcLTCxZFgWljk9abeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuFZ5Azg; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709825081; x=1741361081;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mvK0sF5kFlzNccFn57LYI+EVORCuTLLbtujHY5+LAsA=;
  b=NuFZ5Azgf0gMIAg4tipF9R19xj88j6KVPh7JcpNFnj9g0hrm1x0Z5bWE
   t447I5VVZJ7S6qmrOUbJpRF65HMkgZjPxFP2lwv2Q/71q7Bu5Hv7Hj/z/
   vFIcJk/MHpzTezEj9I+zPMVohp9e4YL/i7aLMgKjXfw1jPlW40jN+qsAZ
   tW6HMv2deRh56gXZGkm9K06xZQjeylh5D8AuL+nWQrf6i3Cal7IxHwtkT
   8kAb6/s1cF5paKgMOhQkynNiNaFkgBtIXvzzMOieMvOHJNyd0gkJ0NGiP
   ZjNdLdvPysaNQPERgbfl2e9jbwxFZBXD+krrnZYhF007ovPuJVkuKK3dT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4364215"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4364215"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="14731489"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 07:24:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 07:24:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 07:24:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 07:24:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT9ls4f7dd5nx0oWytiN8JLNCTPMboi9/RgMdv4RrJxRrE++RGcZhxdPZWJ7deQdmtUqpk4lqsrCHU0xur8CoIkcVHhEg0LNM9czI1s77UqTC/MNtNcYZLjyjf/TBbpiG0vl075Y6zWajvpD12hWd9QGI+7dn74AerRI/kJzUsLHpHLtXkrkCgGIIksST6ZVsdlPPCpx3qIq8TT7AMl/0MjalLF7EgEITSS/1r9W1x6zOmgNFqkWrPdM17aRxe6byO/Hnp3nBbjLV8LMmqJ62R6W/lCQfHBMIVxIrU31KEQ+37Kd6f5I/EVvgg6JxRwnvtQtdVWwiRrywxD4i2yk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SvJEXO1hSlfg+e1G3NKYSmojMdBGJaBosirQHdjGBI=;
 b=KqCjobGS0jD/rauev3x2V2FSwSUj3SrpG5LxfErsPJlFqLTiPOjijsqt+Kys9Is5HLt/265hNeG47Z5VaXLg1HyBS98ZKctedWuJ7y9o9Ws8Gmm8KJQEdqkt3gHMtU5VCfTW5apf4mC+ckNTionyLn6ctP7hcfBDyS26spKJ6re3Ji8mG4/OpizYyAIadjnl6r27xEOd9p7JZg0J6ZA/82cyHB5Pf8ObYB5IiDph5I/R0OB5B8HF7zmPzCpWyiPe3qPhpkhMi0ytVlGzAD71YaX3iMSl4hr7QthIxFhtsnA6joQwhVhwakPp3yIhQRoitcmk9k8o8LxMdFLef525tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Thu, 7 Mar
 2024 15:24:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:24:37 +0000
Date: Thu, 7 Mar 2024 16:24:27 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: suresh ks <suresh2514@gmail.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl v2] i40e: print correct hw max rss count in kernel
 ring buffer
Message-ID: <ZencK4bR0R1igXb5@boxer>
References: <20240120072806.8554-1-suresh2514@gmail.com>
 <e524c57e-fe43-4582-bb05-c50f3e529848@intel.com>
 <SJ0PR11MB5866EAA3CBAF4E28842305D5E57D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <Zc46QEBEpCOL75qN@boxer>
 <CABAyFk54urKYzroBt5ii=h8hMHJ=rgPpGwivK1DjNS+pWDFq5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABAyFk54urKYzroBt5ii=h8hMHJ=rgPpGwivK1DjNS+pWDFq5Q@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: a766fd9e-e0fe-4dd8-dc75-08dc3ebab385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBnbs5HGxEYtqeKXMmGhy0elbrel5jmbOL7tBoj46HNpmbat2eYXZnDVwUeK0H37wNIWnKRIhb1ysZ3firw1eS1rgPyfTsxBQEK9xhcqglt602NfBh6QIOxdzmxA2MFmO0HrD/zod+nWh0d45nEY8QicuE8fa4EMmVbw2j8hyiXQzIYFskBs5qXJMMqAYKdQH9jukUo0jQSL4op/Xa3VJto9UyZOiC+7iAijQEBvXEskSMnf6NxymOUq+K5VtF+UPeM8pAqVSvurv93pXndiM/DVrzUwvnmUkdX9mOra3xJPtEQdOxVA+ViDHFtbPLUNKpD/1VV/RCNU1oYeJ2znaOHe3l6kolAIcXebg0uv4jgzUa5Q+b3QKd4HCYSN1FLXMjP1+ZYZlFRKLLf+YGgDHHoVKz3QI0Cbl8q4SpZ6wEfhdsRXMBceQvV2h9q5E3UOcZ05iILPdiC1XsdhkGm3xuhz/qHjwUsNjcSwCg4ZWDM7bGeRXUKbDT0NSbTvx+WetL/3NJCosBatVPMD9IvjiTdBkDyCyp1qrhfzYeAaLp9NCTEcS4dqXVYzR5+fZjCTHskX5JkOuCYRvoXzqoLCcxtbb8oIJ4pvDV1ijINJ3Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dys4VlV1cytRNys1YkFKa3A3bEZTNE4rQi9RZlZkdmJieWo0TVdpbWZCNzRv?=
 =?utf-8?B?RElmTE9ITmUrelVQV2p3T2k4bDkrZnBNZXFqTlJRTzlHbkZncWcxQlJlOFU0?=
 =?utf-8?B?eUJWNjB1ME45WHlmdlJIVUNuU2ZqSGU1YWc1U2N1Vmxza0RGWlBpSUlPWjdz?=
 =?utf-8?B?NnkvcUc1QUVlWGthRm5oY3VpV0VmVzlqN09yMk8yYjRhRHRGMk5hcC9KYWo0?=
 =?utf-8?B?UnpJWG1aMDJHRmdwN1M2TjgxOTF4NC9TNkNPUGhRdW85VHRmN0xFeE96M0xT?=
 =?utf-8?B?b1JYS3FieDlkeWF2dmU5Uko3Z3JZdk1TYWpkekN1NG1Gck13MzhCN0ZldXpE?=
 =?utf-8?B?TXNDU1laOWVnRUpYdWV2a1BaNENIOE40ekk2Q1Q2azN4WUlER2R0d3hScVd5?=
 =?utf-8?B?bGVHTVdBNjk5d0dJNkxZdDQ5aWJ3c1ZtdUNxbWY1YnErOGNOb1J5VXdEcE1y?=
 =?utf-8?B?N1B1OTdLMmduUXNQMks5ZU5XSHJHeElJTWErOUZoWFBJS3BLNk9qNVpUbWo5?=
 =?utf-8?B?TEd0WUk2bVVqcTgrRUphMnd3ZDJqVjVOMU9FVmMyWnJaWVdoalNQQ2c2OWhJ?=
 =?utf-8?B?UGVSWHUrQ1JZcUFJMGdkWFhYNkIrUFlnU01HRmFKUStVTjlZcGJsRE0zQ3lu?=
 =?utf-8?B?UmJ0dmFoN1dBQmZGc0xGWXVzakt0bmRMRlJCRE5iQURHNVg5K2UybGY4TlFC?=
 =?utf-8?B?dCs0b1pud2QrY2pnWkVVY244RFZzMUtWY2IzaCt3ajYreTBqbXBNa3VtL3pt?=
 =?utf-8?B?OExmTFBhd3BRK2R0RWVtUDY5TC9mdmhaVDBSYTBDZnVhNjBzS3FFSnQvVXd3?=
 =?utf-8?B?eGRaOWU0MlZpNzBUWjc5L1VLZ2ZjTTFld21NUjhFS3NqTDQ5RXRnZ21oVWFZ?=
 =?utf-8?B?WmEzMm11eXVBRFpsSThaSkl4dTByZzFzU2JGZ1h0MDRHSFFqV05JTWlrSmto?=
 =?utf-8?B?NVM3akJJT2plYzNrVmEyYitQeGFzYllQMkNVK3NNMkRKNzhhK1cxZjJuWllu?=
 =?utf-8?B?T1ByWWVXT0UwSlZhVFJocllNanBQTHc3M25lYm4zaHphSWttdDlMeVdsaitP?=
 =?utf-8?B?c2lIRWJ1T29iSGJwOGsram5GakVqT3ZmbWtPTnJFUi8ySklvNnhJMFovU1RG?=
 =?utf-8?B?UDdGK0RyUjVpSEdvZHYvZFVIdzJ6b2hQZHpMSmlIOVlBTTJpYkY3cThpN2Uv?=
 =?utf-8?B?Q2s2VXVWZmFzVkRRNFU4eGM4eTFnemxiRDE0dXQ4cVlranpvUEpJNGZkSlc1?=
 =?utf-8?B?UFNHRU9WdjBsL2dZTm5DWmx4Tno3THVNdWhRUWNxRE1iRm9kSitIeDdJSHAy?=
 =?utf-8?B?ZjlabC96UitoS2JOdDBvYy9ibmd4UUo5NloxeDF2R0t2SmxXUi9MK1p3SXpM?=
 =?utf-8?B?cy85UjlyWnBGUkxoMWdjUXdJUkRpZElUQVQ0TkU1Vyt0ZWtPZHV1bWRhanE5?=
 =?utf-8?B?Y05mUFRYM0c4cjNvYlJISmtzWXFLdWw5Mmg3NjA3dzBDd1lOa2RjeGZtZjRh?=
 =?utf-8?B?SklTSjM5RVRKRjJNRHAwOElnbko1UzlJRkV6dUVVT1Nwbm8vUFV0ZVhBa3F1?=
 =?utf-8?B?ZFVzUnFXcWRJbzJBamlRZDBJczJaUzZGUHVpVi9wbDVrTzA1bXRpdnlRWVcy?=
 =?utf-8?B?aHpueUg0RDVLTytWamNqZjh6RlpwM3RmeGg1dHRwY1VWU3ltRExFS25IOTFi?=
 =?utf-8?B?ODFwY09SUzF0b0p2L2x3b3BQVkU2eEdReXdsRCtYdklzNjZuTTJPeDFmL01R?=
 =?utf-8?B?cHkvU3UzNkcweXhFa2J3b1oyajhyUVA3a1VZbEo0WTRSQytVbHhvM2xJOW5L?=
 =?utf-8?B?UTRjR2ozZXpTMmxHc01pUFQ0ZlQ4akozRVZhZlJ0akJ2M0ZjRG1IZm13T3lT?=
 =?utf-8?B?U0NIVlNKejFabmh5RmEwVlZpS3Y0Qm4rdGlJQmU3b2dub21MSzVqakNnSGNj?=
 =?utf-8?B?WWlEWDVCdWlvRmVmNW9rdkhlbEhvd2xEdGdPSzdDT1ZiVFh1anMrWlhHZkNp?=
 =?utf-8?B?eVZjcWFSODJ5OFliUXZhWTZTNU1nUkduQWE3cGxCSjhTVkxxQ0tlUjNqWnFy?=
 =?utf-8?B?YlBvS3ZzNTdNclNuZTRSNkpCK0l6V0NFWU8xajVPMnVIQ0pRL0Ryc3BaRTJl?=
 =?utf-8?B?M1l2N2FadWdZUm8vQzNKUTZpdGhVaThkOUpMQzlvaDJvK0huNEpzMEZxblFC?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a766fd9e-e0fe-4dd8-dc75-08dc3ebab385
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:24:37.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xal3yI2o52VKz2PH6j/QvdvI1peBplMcQk2unuDDcwb0IIg/bBaLE8ycnZuXnuwT6A3wyWmijVeUAt0PBGSSa9Mp4fy6bMuI2bl3dTsghvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com

On Thu, Mar 07, 2024 at 08:09:47PM +0530, suresh ks wrote:
> Hi Maciej,
> 
> Thanks for the links and taking time to review.

No problem, but please don't top post on linux mailing lists nor don't
respond in HTML. These are 101 rules to participate in upstream
discussions.

> 
> I was following the ethtool codes and suggested vsi->num_queue_pairs.
> Maybe vsi->alloc_queue_pairs is the right option as you suggested. I have
> not read much of i40e codes. Just that one of our customers reported this
> issue and I was reviewing the codes.
> 
> I also felt rss_size_max comes from the early i40e days. So I was not sure
> what I would add in the 'Fixes:' tag.

submitting-patches.html has it explained ;)

> 
> Sorry for getting late here. Was on a vacation.
> 
> 
> thanks....
> *Suresh KS*
> suresh2514@gmail.com
> 91-7709100053
> 
> 
> 
> On Thu, Feb 15, 2024 at 9:52 PM Maciej Fijalkowski <
> maciej.fijalkowski@intel.com> wrote:
> 
> > On Tue, Jan 30, 2024 at 08:33:43AM +0000, Loktionov, Aleksandr wrote:
> > > > -----Original Message-----
> > > > From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > > > Sent: Tuesday, January 30, 2024 9:26 AM
> > > > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > > > Subject: Fwd: [PATCH iwl v2] i40e: print correct hw max rss count
> >
> > Subject should be iwl-net and you should have Fixes: tag.
> > I also would like you to go through
> > https://docs.kernel.org/process/submitting-patches.html
> >
> > or any other document that would prepare you for your first submission.
> >
> > > > in kernel ring buffer
> > > >
> > > > FWD to Alex
> > > >
> > > >
> > > > -------- Forwarded Message --------
> > > > Subject: [PATCH iwl v2] i40e: print correct hw max rss count in
> > > > kernel ring buffer
> > > > Date: Sat, 20 Jan 2024 12:58:06 +0530
> > > > From: Suresh Kumar <suresh2514@gmail.com>
> > > > To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
> > > > davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
> > > > pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
> > > > netdev@vger.kernel.org, linux-kernel@vger.kernel.org
> > > > CC: Suresh Kumar <suresh2514@gmail.com>
> > > >
> > > > pf->rss_size_max is hardcoded and always prints max rss count as
> > > > 64.
> > > >
> > > > Eg:
> > > >    kernel: i40e 0000:af:00.1: User requested queue count/HW max RSS
> > > > count:  104/64
> > > >
> > > > whereas  ethtool reports the correct value from "vsi-
> > > > >num_queue_pairs"
> > > >
> > > > Channel parameters for eno33:
> > > > Pre-set maximums:
> > > > RX:     n/a
> > > > TX:     n/a
> > > > Other:      1
> > > > Combined:   104
> > > > Current hardware settings:
> > > > RX:     n/a
> > > > TX:     n/a
> > > > Other:      1
> > > > Combined:   104  <-------
> > > >
> > > > and is misleading.
> > > >
> > > > Change it to vsi->num_queue_pairs
> > >
> > > Please reject this patch, it breaks driver logging.
> > > The massage clearly states that it dumps max rss queues number that f/w
> > supports.
> >
> > ...which would imply that you would be able to work with anything more
> > than 64 queues. From a quick glance rss_size_max comes from early i40e
> > days and if that would be the limit indeed then driver allowing 104 queues
> > would be a disaster, no?
> >
> > >
> > > Thank you
> > >
> > > > Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
> > > > ---
> > > >   drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > index d5519af34657..f5c1ec190f7e 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > @@ -12524,7 +12524,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf
> > > > *pf, int queue_count)
> > > >             i40e_pf_config_rss(pf);
> > > >     }
> > > >     dev_info(&pf->pdev->dev, "User requested queue count/HW max
> > > > RSS
> > > > count:  %d/%d\n",
> > > > -            vsi->req_queue_pairs, pf->rss_size_max);
> > > > +            vsi->req_queue_pairs, vsi->num_queue_pairs);
> >
> > IMHO this should be vsi->alloc_queue_pairs instead.
> >
> > > >     return pf->alloc_rss_size;
> > > >   }
> > > >   -- 2.43.0
> > > >
> > >
> >

