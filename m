Return-Path: <linux-kernel+bounces-74078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7C85CFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1C282D36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563343A1C2;
	Wed, 21 Feb 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGCGh/ln"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856B39FE0;
	Wed, 21 Feb 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493711; cv=fail; b=XCT7rQAy0g09bP0twtTJrSGo4+oL0U0wb0TDSwjCjUC7hoXLvXywpmKvOOb9S/UjAFCyFp737Qh77tgasU1nsVox/jK8bpGaiIQREu5ek8109XwQAIwPbdjp+RBFRIx0K/T34AkmfCM0vn6AY5dzIma9Ds7rc+/QDsmKE2l22Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493711; c=relaxed/simple;
	bh=nhlWk3I+GllLwOS8W9wLTyKC2Sa2Yc9YRaXb/ef7/KE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KLUrJL2wguqkMw5e2dNKPpEu6zzWDf85nbysHnMaIfW/vY4GbK/BpfYrTivUQAUCunuEIqbXhn14OVwdhWtW9JWB9kCJbL8es/1uv6ZWVVYtilTJoqFuFrLBBKiqPJOOIr/3w5guYdX3bXwPENtWVEYGt6mHzVBV7bpEmaVbjNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGCGh/ln; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708493710; x=1740029710;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nhlWk3I+GllLwOS8W9wLTyKC2Sa2Yc9YRaXb/ef7/KE=;
  b=nGCGh/lnHusSp9Fv2qycmCdOoY0AHu0jDJHTg5bXOKjRVcjOGOjQHxV+
   48jk3Ijm0BRoEZ9AZ5KInALVN/2XJ91h5LwEPesbMJa+AagvqfhrWBRc+
   2MivW1+ZJnZbQhhtqDiDCv6Mz6Diydjl+eH+AjsU0Xl9XeCr+CJku2Y6L
   brWYWo5C/Bt0+D34sOW9P6PS1DH5F25jiRNll8x1cpTA7fr+Vrejp0jf6
   oORjeRU+IXUfVNYt7a67K+TX9VQrZYHyiCdsYV2Zfu7DhOcpAI+NOA88x
   zEAN++Howa1teqnGvIp8dsEanhyTstoFLoTbU9xWWqrJLFQm1QeoCNAYu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="28076967"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="28076967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:35:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9712514"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 21:35:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 21:35:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 21:35:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 21:35:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvbkNGiRizSAOTRqq026jK5R0rIhon9RFeT9SCubh+ocytMcKxCRwW5TcH6+Ltjx9Ph65ZxfEn4t/zE3GSJ1RGU+ZYwYUe8E7MkWTtdyVC2vngXpqyHn9r3HvG0pj4jBeZllX+iRvEArKdSTtF9PqkiG5hDdjNaPnUxkwi5JcgFLiNByG0whhqtYLhttAZQ/7O/gQjJ59/23NJrOEFN3ty68SlucMOldDIvn0dgdfEuGRnxXqcJM61eF6jD8Ywq5M4fS036amjcuQ9O7IIP0fX6mdraSPRLzAn0AMAYHS+B912yEyfazwyVZWHmTfCqkVZY5kpbBlpU452y+W6cedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kzsf4jE7x9oQbhkawY6dORwMhQr/1JigZudsOHEgPA=;
 b=TG1Mwm7X+3LZ+MHl/A9QaX288nng54t+lrQ4BXW44yCYa/ODFgj3OivZT8Zh4FLMcLvmDdrzS2bOL4xJp80ZYpkj5D5kTegIb4e9ecOHND5U9LaHsIBADkMx+9ZqqF+9YRf3mosC6QwXejDrlfK/1HyVlpuUTuSpaygDseGLlIf3HMcLssebJHJ4HGMmnhZ3szgf8K2Wmc6RWMMUXaKSG78Fl2pFGdOMgQBgrXgjaxYVOpAUK0+Vkc4pywf5lzMdIE1Tv1v2RcO34NJlr5rQkYvs+tFmf0z4hs7yK/xV1fAbmPht3QQJwgYi7k+axgOCX+CpJ4SMMGyJR1TywZa9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 21 Feb
 2024 05:35:00 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::5095:2f06:f31d:95e2%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 05:35:00 +0000
Date: Wed, 21 Feb 2024 13:29:53 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: "kuniyu@amazon.com" <kuniyu@amazon.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "dumazet@google.com" <dumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuni1840@gmail.com" <kuni1840@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, lkp <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is BUG: soft lockup after sendmsg
 syscall in v6.8-rc4
Message-ID: <ZdWKUcK+fESrcLaH@xpf.sh.intel.com>
References: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
 <CAL+tcoB_NeHpgrg7_HngiResOPhNCBTpDTJsjYsccXZMFA7VGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoB_NeHpgrg7_HngiResOPhNCBTpDTJsjYsccXZMFA7VGw@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 77063d19-64ca-4cdd-fb89-08dc329ed890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Uj73wZGh185XRj0Szzbm53JuXacWfcNpnJFKQMAUFucEYRbnXqnT2kZYG2VKu/jWui2L5negr0yS2N4y2TUNManeLYr5Tgk/XV7ulUeXjJIIf4JoySDtUv9hjxJhpsukmJTCVC8haCN5Mgc+UyP2rIB0WBAvpvyYtql1nms3k/XHIbHgrNodyfVu47zTRVKS4HXJGNdvuniywsRm6taC7+F9rRNS4XCUGQ0U51AchWwohOAuMj6fSD4ejobaYv3PXfgZdNEqysyEv2+vwnPBoDqeMI+IgCJb6i7k3Sk4c5OXhHTk1v2nfI2K9zRQ70rRb9j3LzQCR1tFVZlTtMHzlc4tPb93PvybJML6Tgs2KIVAN3+qcvyMuD8msszQ2WmykZ5cXAsbW97/z1XCgStPWjnn6Xyx7nkodu0MV0Q86fd0coj5OAWa4v7amlgTM6E6O2vh+bcREDxiCSgeG5kjWWkIfl1RlMsMyCCm2qBqBe0BBKEtsEMV/z7vUtgd41mya4gbH8/csS9tBoljIzv9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWNrMjdnY1daRy90WWlFSHVsNnhuWjlqZjdtSmJuME92OFVhRW5kOTJMb2VN?=
 =?utf-8?B?WHQ5dG5qeDBaWm5YSnV3V1gzZDRZRUFUUEhTc0FVcGJWTWJ1VGNJS0lWaWtl?=
 =?utf-8?B?Zm1ySWpKWmJ2VEdzVkk5TUl0R3VzakpCZVRMM2VtSGh1SnNOekl3S0FDTXpK?=
 =?utf-8?B?WGZjMmxEV0RabjIwYVVjZEhacERNb2hjK0x5R0d5YVNsL0JpUmlySG1TdW1p?=
 =?utf-8?B?cU1iWWZJcURlYzZtUWg5ZEY4NVQ2d1RyU2dHVlIzdFZwMkg4Q29wdTBoRGxn?=
 =?utf-8?B?TGhvOTBOMGt0NjRpaGQ4VHF6ZkpydmJJbTVrdlAxWERJajNMTWtmU1ZqNHB0?=
 =?utf-8?B?K3FGTW0xNjF3Tkp6ajZZU0pwWWRtTVRPME5PVmtjOE1pUDFhUjRWS1JzSU5l?=
 =?utf-8?B?a2k2cnlWZUFxM1VCY3MyNGQ2MDhqNmJMbnJsRjJNaE9yMDFMdTJpbWRsU2M2?=
 =?utf-8?B?eWcrVUszZWkyUXNrRm5QeG9rVThxSXNVbGNwMElIWlRuaEZRbzQ5bnExbkpy?=
 =?utf-8?B?ZHZKQ0c3cEg1NE9DdXp4akhFWGVJYmNwbEpzdyt4VVVKN0h1RmcwRVVSeWRm?=
 =?utf-8?B?Z3lVa0s4SSt1cHZiSUZJN284cGIwZUVHbUFUR3M3SHp4OGgrb21saEVlTXFp?=
 =?utf-8?B?bXN5NE1tNithT2pOdjkxb2RwL1BhRjI5L0RJUmovQWdueUQyZGRWOVd0eXRi?=
 =?utf-8?B?YVQ2cmdMcSs4U01CUkJpQVc3OURtZlFGVmJhaS9mb0luaGtJaS92NlFhaHdJ?=
 =?utf-8?B?ODhYV2RENkJpd0xhaUxGTE9Eb01oMWEvWVhlNmZ4dWFxdktpbjZWcVc0ck1W?=
 =?utf-8?B?LzRGRGd3a1Vma1B4QmV0TUtOY0lYaE4zMWVhYmZMS1BMeGljNFZ4TzZYeDZD?=
 =?utf-8?B?aXpOVUJzWll3M1lEV1pRTEZpSlYxMXlPTlhjOS9sUUhINHBqVG1jQ3FpZTN3?=
 =?utf-8?B?SlRIRjZMRFljN21JdnM4Y3Z6V0V4eTM0ZXh1alRyMEFSSnVJNWkwT0svcTcx?=
 =?utf-8?B?QVNNWHNCNmxVRTBCMXFSNFFvTEs5ZTlYT2Fiblk5MStpd2lhblFBU3VBYldn?=
 =?utf-8?B?Q0lZK255Z1UzcXl6RlAwSUdDUzJNQ0d0Yzd2QTZPYWw0alRqaVpBdU5XdGpx?=
 =?utf-8?B?ZXlBT25pQWF5THg5MGVxMnJlNU4rWEF4YnZRdmJqNXljbENCWjNNN2VETUhG?=
 =?utf-8?B?NitMckZOT0JWdWNMM1JOc09oQWE0MVArZURtcmtsU0VTMEVvZnhSZ2hNRDhK?=
 =?utf-8?B?Tng1MmRvZ0p3cWFOVGFMZGh5YW0vVmxyKzFLRkVFcEY4K2l2amR0OVZGR2Rs?=
 =?utf-8?B?YS8yREoreDZXUno5eEdGbGhFUmRZcHFleU5leVFVSUhvTkRxL2hEKzJPQlly?=
 =?utf-8?B?ZkVobUdWRERMSVhuQ2ovS3RtKzFYOFVUZVRsalZZc05VWnF6eHA5K3JGZmw2?=
 =?utf-8?B?Q2hVSjRLT1BGUjNtb3B6SWI1RU1BUzh3NHlVS0txaWZRZy8yU09oSHlzQTA0?=
 =?utf-8?B?N3R0aUdycVA4L3BRNlZwejFOTlo1WjhEai9GK3oxN3ZUYUxkTUtzNmxUendT?=
 =?utf-8?B?VkJuM0RMMDZUcTJuaE1HdC9HNmhsNWp2elZnMXdwTE9SVmJNVWhDNkYwWjhW?=
 =?utf-8?B?OHdJZ0QrMkhHWDhITHBGQTYxOStrS3hwMlhvTks5aVpicUJUWUVjdmF5QmhP?=
 =?utf-8?B?TTU0RitMTCt0blBXQU15UStoYXZlRFRDN2FBTVY2bXdBb2VlZHNQeFlzVlM4?=
 =?utf-8?B?aldYM2grZFh4dnR4K2xsVkFZNlR1UGUxMlZRL0c3M3FsM2lmSTQ2MTdxc0do?=
 =?utf-8?B?Y3Q1czlLZ0N2QTUrVDcxUXQyNmhvWVJoTmE0bEJ4d2VEL05aT3pZNFVlRnll?=
 =?utf-8?B?V2dkR0c2em9jMjlzai9zc2Mzd3VRSTQ5QWpqenZ6cEQwMGZ0N0NqRUNqMTY4?=
 =?utf-8?B?a015RlpUeU04Z1ZnNnVJTlc3OU1FUEtLYy8zUVRzcXdsRkg3cGlHSlYrdDhh?=
 =?utf-8?B?UExmUEdBcDhmY0doZmtqbHNmenF2d054RjIzS0h0VmE0cFVHZzNqYVdXVHdW?=
 =?utf-8?B?NjQ5MFRWZkF1bXFma2RmT3hzRURpVVU3b2FOekxJb29rOGJCYWRQQW5WZXp3?=
 =?utf-8?Q?j7dD7t3MqJSGQb4EEjdIFx4Xm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77063d19-64ca-4cdd-fb89-08dc329ed890
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 05:35:00.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fkm1HaLgX16z/Lo7uhY3RHnDzOmVjxYKzr8XSYiR+XjFKeC3C83CdREBBfqAkFRrpCbjAgMnz8+BDyR4oItbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-OriginatorOrg: intel.com

Hi Jsason,

On 2024-02-21 at 11:07:44 +0800, Jason Xing wrote:
> On Wed, Feb 21, 2024 at 10:35 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Kuniyuki Iwashima and kernel experts,
> >
> > Greeting!
> > There is BUG: soft lockup after sendmsg syscall in v6.8-rc4 in guest.
> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240220_161242_softlockup
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.c
> > Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.prog
> > Kconfig(need make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/bisect_info.log
> > v6.8-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/841c35169323cd833294798e58b9bf63fa4fa1de_dmesg.log
> > bzImage_v6.8-rc4: https://github.com/xupengfe/syzkaller_logs/raw/main/240220_161242_softlockup/bzImage_v6.8-rc4.tar.gz
> >
> > Bisected and found first bad commit:
> > "
> > 1279f9d9dec2 af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> > "
> >
> > After reverted above commit on top of v6.8-rc4 kernel, this issue was gone.
> >
> > Syzkaller repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_161242_softlockup/repro.report
> > "
> > watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [gdbus:349]
> > Modules linked in:
> > irq event stamp: 25162
> > hardirqs last  enabled at (25161): [<ffffffff855dff2e>] irqentry_exit+0x3e/0xa0 kernel/entry/common.c:351
> > hardirqs last disabled at (25162): [<ffffffff855dded4>] sysvec_apic_timer_interrupt+0x14/0xc0 arch/x86/kernel/apic/apic.c:1076
> > softirqs last  enabled at (25140): [<ffffffff8127fcc8>] invoke_softirq kernel/softirq.c:427 [inline]
> > softirqs last  enabled at (25140): [<ffffffff8127fcc8>] __irq_exit_rcu+0xa8/0x110 kernel/softirq.c:632
> > softirqs last disabled at (25135): [<ffffffff8127fcc8>] invoke_softirq kernel/softirq.c:427 [inline]
> > softirqs last disabled at (25135): [<ffffffff8127fcc8>] __irq_exit_rcu+0xa8/0x110 kernel/softirq.c:632
> > CPU: 0 PID: 349 Comm: gdbus Not tainted 6.8.0-rc4-2024-02-12-intel-next-e92619743fcb+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:__sanitizer_cov_trace_pc+0x38/0x70 kernel/kcov.c:207
> > Code: 65 8b 05 73 89 a0 7e 48 89 e5 48 8b 75 08 a9 00 01 ff 00 74 0f f6 c4 01 74 35 8b 82 e4 1d 00 00 85 c0 74 2b 8b 82 c0 1d 00 00 <83> f8 02 75 20 48 8b 8a c8 1d 00 00 8b 92 c4 1d 00 00 48 8b 01 48
> > RSP: 0018:ffff88800b48f7b0 EFLAGS: 00000246
> > RAX: 0000000000000000 RBX: ffff888013018000 RCX: 1ffffffff12150bb
> > RDX: ffff888011ab8000 RSI: ffffffff8515e235 RDI: ffff888013018770
> > RBP: ffff88800b48f7b0 R08: 0000000000000001 R09: fffffbfff120f86e
> > R10: ffffffff8907c377 R11: 0000000000000001 R12: ffff888013018000
> > R13: dffffc0000000000 R14: ffff888013018630 R15: ffff88800b48f840
> > FS:  0000000000000000(0000) GS:ffff88806ca00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fffcc5fd648 CR3: 0000000006c82000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> >  <IRQ>
> >  </IRQ>
> >  <TASK>
> >  unix_gc+0x465/0xfd0 net/unix/garbage.c:319
> >  unix_release_sock+0xb8c/0xe80 net/unix/af_unix.c:683
> >  unix_release+0x9c/0x100 net/unix/af_unix.c:1064
> >  __sock_release+0xb6/0x280 net/socket.c:659
> >  sock_close+0x27/0x40 net/socket.c:1421
> >  __fput+0x284/0xb70 fs/file_table.c:376
> >  ____fput+0x1f/0x30 fs/file_table.c:404
> >  task_work_run+0x19d/0x2b0 kernel/task_work.c:180
> >  exit_task_work include/linux/task_work.h:38 [inline]
> >  do_exit+0xb51/0x28c0 kernel/exit.c:871
> >  do_group_exit+0xe5/0x2c0 kernel/exit.c:1020
> >  get_signal+0x2715/0x27d0 kernel/signal.c:2893
> >  arch_do_signal_or_restart+0x8e/0x7e0 arch/x86/kernel/signal.c:311
> >  exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
> >  syscall_exit_to_user_mode+0x129/0x190 kernel/entry/common.c:212
> >  do_syscall_64+0x82/0x150 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > RIP: 0033:0x7fe8f8b4296f
> > Code: Unable to access opcode bytes at 0x7fe8f8b42945.
> > RSP: 002b:00007fe8d7dff9c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
> > RAX: fffffffffffffdfc RBX: 00007fe8f8f73071 RCX: 00007fe8f8b4296f
> > RDX: 00000000ffffffff RSI: 0000000000000002 RDI: 00007fe8a801f3f0
> > RBP: 00007fe8a801f3f0 R08: 0000000000000000 R09: 00007fe8d7dff850
> > R10: 00007ffec9196080 R11: 0000000000000293 R12: 0000000000000002
> > R13: 0000000000000002 R14: 00007fe8d7dffa30 R15: 00007fe8a801c4c0
> >  </TASK>
> > "
> 
> Hello, did you try this one:
> 
> commit 25236c91b5ab4a26a56ba2e79b8060cf4e047839
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Fri Feb 9 14:04:53 2024 -0800
> 
>     af_unix: Fix task hung while purging oob_skb in GC.
> 
>     syzbot reported a task hung; at the same time, GC was looping infinitely
>     in list_for_each_entry_safe() for OOB skb.  [0]
> 
>     syzbot demonstrated that the list_for_each_entry_safe() was not actually
>     safe in this case.
> 
>     A single skb could have references for multiple sockets.  If we free such
>     a skb in the list_for_each_entry_safe(), the current and next sockets could
>     be unlinked in a single iteration.
> 
> It should work, I think :)

Thanks for your information!
I tried the v6.8-rc5 kernel which contains the commit 25236c91b5ab4 and
the changed code in file net/unix/garbage.c was same.

The problem can still be reproduced in v6.8-rc5, seems there is still some
problem left.
"
[  192.656972] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [GUsbEventThread:601]
[  192.657524] Modules linked in:
[  192.657714] irq event stamp: 23074
[  192.657914] hardirqs last  enabled at (23073): [<ffffffff85584fce>] irqentry_exit+0x3e/0xa0
[  192.658446] hardirqs last disabled at (23074): [<ffffffff85582dc3>] sysvec_apic_timer_interrupt+0x13/0xd0
[  192.659023] softirqs last  enabled at (23058): [<ffffffff855cd1a0>] __do_softirq+0x4f0/0x791
[  192.659542] softirqs last disabled at (23053): [<ffffffff8126ab41>] irq_exit_rcu+0xc1/0x110
[  192.660058] CPU: 0 PID: 601 Comm: GUsbEventThread Not tainted 6.8.0-rc5-kvm #15
[  192.660490] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  192.661163] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70
[  192.661485] Code: 48 8b 80 d8 1d 00 00 c3 cc cc cc cc 31 c0 5d c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 8
[  192.662586] RSP: 0018:ffff888007967798 EFLAGS: 00000246
[  192.662909] RAX: ffff88800fe12500 RBX: ffffed1000f67eee RCX: ffffffff84b2f34f
[  192.663337] RDX: 0000000000000000 RSI: ffffffff85103edf RDI: 0000000000000005
[  192.663763] RBP: ffff888007967918 R08: ffff88800fe12500 R09: ffffed10035c57d5
[  192.664187] R10: ffffed10035c57d4 R11: ffff88801ae2bea7 R12: ffff888007b3f630
[  192.664611] R13: ffff888007b3f770 R14: dffffc0000000000 R15: 0000000000000000
[  192.665061] FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[  192.665549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  192.665896] CR2: 00007f34b0ccd274 CR3: 0000000006a7e000 CR4: 0000000000750ef0
[  192.666350] PKRU: 55555554
[  192.666532] Call Trace:
[  192.666690]  <IRQ>
[  192.666824]  ? show_regs+0xa2/0xb0
[  192.667056]  ? watchdog_timer_fn+0x507/0x6a0
[  192.667325]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  192.667620]  ? __hrtimer_run_queues+0x61a/0xba0
[  192.667920]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  192.668229]  ? ktime_get_update_offsets_now+0x25b/0x340
[  192.668553]  ? hrtimer_interrupt+0x326/0x7b0
[  192.668832]  ? __sysvec_apic_timer_interrupt+0x101/0x390
[  192.669163]  ? sysvec_apic_timer_interrupt+0x9c/0xd0
[  192.669466]  </IRQ>
[  192.669605]  <TASK>
[  192.669745]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  192.670092]  ? kfree_skb_reason+0x2af/0x2f0
[  192.670360]  ? unix_gc+0x98f/0x1120
[  192.670591]  ? __pfx___sanitizer_cov_trace_pc+0x10/0x10
[  192.670926]  ? unix_gc+0x9ae/0x1120
[  192.671155]  ? __pfx_unix_gc+0x10/0x10
[  192.671402]  ? mark_held_locks+0xb7/0x140
[  192.671662]  ? skb_dequeue+0x168/0x1e0
[  192.671901]  ? __this_cpu_preempt_check+0x20/0x30
[  192.672213]  ? fib_table_lookup+0xaf0/0x2590
[  192.672482]  ? skb_dequeue+0x168/0x1e0
[  192.672723]  unix_release_sock+0xb7a/0xfd0
[  192.672988]  ? __pfx_unix_release_sock+0x10/0x10
[  192.673281]  ? down_write+0x183/0x1e0
[  192.673510]  ? __pfx_down_write+0x10/0x10
[  192.673766]  unix_release+0x9c/0x100
[  192.674009]  __sock_release+0xba/0x280
[  192.674250]  ? __pfx_sock_close+0x10/0x10
[  192.674499]  sock_close+0x25/0x30
[  192.674713]  __fput+0x273/0xb70
[  192.674933]  ____fput+0x1e/0x30
[  192.675140]  task_work_run+0x1a4/0x2d0
[  192.675380]  ? __pfx_task_work_run+0x10/0x10
[  192.675644]  ? free_nsproxy+0x3c5/0x4f0
[  192.675885]  ? switch_task_namespaces+0xf7/0x130
[  192.676174]  do_exit+0xae1/0x3000
[  192.676391]  ? __this_cpu_preempt_check+0x20/0x30
[  192.676675]  ? lock_release+0x3f8/0x770
[  192.676925]  ? __this_cpu_preempt_check+0x20/0x30
[  192.677221]  ? get_signal+0xa87/0x2740
[  192.677466]  ? __pfx_do_exit+0x10/0x10
[  192.677704]  ? _raw_spin_unlock_irq+0x2b/0x60
[  192.677983]  ? get_signal+0xa87/0x2740
[  192.678227]  ? __this_cpu_preempt_check+0x20/0x30
[  192.678528]  do_group_exit+0xe0/0x2b0
[  192.678764]  get_signal+0x26f7/0x2740
[  192.679004]  ? poll_select_set_timeout+0xf5/0x160
[  192.679298]  ? __pfx_lock_release+0x10/0x10
[  192.679564]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[  192.679869]  ? __pfx_get_signal+0x10/0x10
[  192.680130]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  192.680462]  ? kvm_clock_read+0x3f/0x60
[  192.680707]  arch_do_signal_or_restart+0x87/0x930
[  192.681007]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  192.681336]  ? __this_cpu_preempt_check+0x20/0x30
[  192.681636]  ? lockdep_hardirqs_on+0x8a/0x110
[  192.681917]  syscall_exit_to_user_mode+0x178/0x260
[  192.682222]  do_syscall_64+0x83/0x150
[  192.682459]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  192.682764] RIP: 0033:0x7f34b134296f
[  192.682990] Code: Unable to access opcode bytes at 0x7f34b1342945.
[  192.683336] RSP: 002b:00007f34ae9ff9b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
[  192.683766] RAX: fffffffffffffdfc RBX: 0000564d3236d8a0 RCX: 00007f34b134296f
[  192.684183] RDX: 00000000000007d0 RSI: 0000000000000002 RDI: 00007f349c000b60
[  192.684601] RBP: 0000564d3236da48 R08: 0000000000000000 R09: 00000000000007d0
[  192.685017] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000007d0
[  192.685423] R13: 0000000000000002 R14: 00007f34b45a6340 R15: 00007f349c000b60
[  192.685846]  </TASK>
[  192.685989] Kernel panic - not syncing: softlockup: hung tasks
[  192.686326] CPU: 0 PID: 601 Comm: GUsbEventThread Tainted: G             L     6.8.0-rc5-kvm #15
[  192.686818] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  192.687464] Call Trace:
[  192.687613]  <IRQ>
[  192.687741]  dump_stack_lvl+0xa9/0x110
[  192.687979]  dump_stack+0x19/0x20
[  192.688186]  panic+0x6b9/0x720
[  192.688374]  ? __pfx_panic+0x10/0x10
[  192.688604]  ? watchdog_timer_fn+0x571/0x6a0
[  192.688867]  ? watchdog_timer_fn+0x564/0x6a0
[  192.689144]  watchdog_timer_fn+0x582/0x6a0
[  192.689390]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  192.689667]  __hrtimer_run_queues+0x61a/0xba0
[  192.689949]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  192.690241]  ? ktime_get_update_offsets_now+0x25b/0x340
[  192.690567]  hrtimer_interrupt+0x326/0x7b0
[  192.690823]  __sysvec_apic_timer_interrupt+0x101/0x390
[  192.691131]  sysvec_apic_timer_interrupt+0x9c/0xd0
[  192.691415]  </IRQ>
[  192.691543]  <TASK>
[  192.691675]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  192.691986] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70
[  192.692301] Code: 48 8b 80 d8 1d 00 00 c3 cc cc cc cc 31 c0 5d c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 8
[  192.693367] RSP: 0018:ffff888007967798 EFLAGS: 00000246
[  192.693680] RAX: ffff88800fe12500 RBX: ffffed1000f67eee RCX: ffffffff84b2f34f
[  192.694101] RDX: 0000000000000000 RSI: ffffffff85103edf RDI: 0000000000000005
[  192.694505] RBP: ffff888007967918 R08: ffff88800fe12500 R09: ffffed10035c57d5
[  192.694917] R10: ffffed10035c57d4 R11: ffff88801ae2bea7 R12: ffff888007b3f630
[  192.695338] R13: ffff888007b3f770 R14: dffffc0000000000 R15: 0000000000000000
[  192.695757]  ? kfree_skb_reason+0x2af/0x2f0
[  192.696020]  ? unix_gc+0x98f/0x1120
[  192.696237]  ? unix_gc+0x9ae/0x1120
[  192.696461]  ? __pfx_unix_gc+0x10/0x10
[  192.696701]  ? mark_held_locks+0xb7/0x140
[  192.696963]  ? skb_dequeue+0x168/0x1e0
[  192.697196]  ? __this_cpu_preempt_check+0x20/0x30
[  192.697493]  ? fib_table_lookup+0xaf0/0x2590
[  192.697757]  ? skb_dequeue+0x168/0x1e0
[  192.698000]  unix_release_sock+0xb7a/0xfd0
[  192.698264]  ? __pfx_unix_release_sock+0x10/0x10
[  192.698548]  ? down_write+0x183/0x1e0
[  192.698771]  ? __pfx_down_write+0x10/0x10
[  192.699026]  unix_release+0x9c/0x100
[  192.699254]  __sock_release+0xba/0x280
[  192.699490]  ? __pfx_sock_close+0x10/0x10
[  192.699742]  sock_close+0x25/0x30
[  192.699965]  __fput+0x273/0xb70
[  192.700170]  ____fput+0x1e/0x30
[  192.700365]  task_work_run+0x1a4/0x2d0
[  192.700603]  ? __pfx_task_work_run+0x10/0x10
[  192.700864]  ? free_nsproxy+0x3c5/0x4f0
[  192.701106]  ? switch_task_namespaces+0xf7/0x130
[  192.701387]  do_exit+0xae1/0x3000
[  192.701592]  ? __this_cpu_preempt_check+0x20/0x30
[  192.701879]  ? lock_release+0x3f8/0x770
[  192.702128]  ? __this_cpu_preempt_check+0x20/0x30
[  192.702420]  ? get_signal+0xa87/0x2740
[  192.702662]  ? __pfx_do_exit+0x10/0x10
[  192.702907]  ? _raw_spin_unlock_irq+0x2b/0x60
[  192.703185]  ? get_signal+0xa87/0x2740
[  192.703428]  ? __this_cpu_preempt_check+0x20/0x30
[  192.703723]  do_group_exit+0xe0/0x2b0
[  192.703966]  get_signal+0x26f7/0x2740
[  192.704203]  ? poll_select_set_timeout+0xf5/0x160
[  192.704490]  ? __pfx_lock_release+0x10/0x10
[  192.704763]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[  192.705072]  ? __pfx_get_signal+0x10/0x10
[  192.705324]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  192.705649]  ? kvm_clock_read+0x3f/0x60
[  192.705900]  arch_do_signal_or_restart+0x87/0x930
[  192.706207]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  192.706538]  ? __this_cpu_preempt_check+0x20/0x30
[  192.706833]  ? lockdep_hardirqs_on+0x8a/0x110
[  192.707120]  syscall_exit_to_user_mode+0x178/0x260
[  192.707418]  do_syscall_64+0x83/0x150
[  192.707652]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  192.707978] RIP: 0033:0x7f34b134296f
[  192.708199] Code: Unable to access opcode bytes at 0x7f34b1342945.
[  192.708569] RSP: 002b:00007f34ae9ff9b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
[  192.709020] RAX: fffffffffffffdfc RBX: 0000564d3236d8a0 RCX: 00007f34b134296f
[  192.709449] RDX: 00000000000007d0 RSI: 0000000000000002 RDI: 00007f349c000b60
[  192.709873] RBP: 0000564d3236da48 R08: 0000000000000000 R09: 00000000000007d0
[  192.710313] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000007d0
[  192.710746] R13: 0000000000000002 R14: 00007f34b45a6340 R15: 00007f349c000b60
[  192.711205]  </TASK>
[  192.711808] Kernel Offset: disabled
[  192.712120] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
"

Best Regards,
Thanks!


> 
> Thanks,
> Jason
> 
> >
> > Thanks!
> >
> > ---

