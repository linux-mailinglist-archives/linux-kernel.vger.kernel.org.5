Return-Path: <linux-kernel+bounces-77789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B462860A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647B2B25566
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934411CBC;
	Fri, 23 Feb 2024 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks6OHpsQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831D11714
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666149; cv=fail; b=dXOcTtvOa3awttnAmZsED0JBHqc7YxhMqP0h8giV3BIBzoYKN6vsGSkt/sOfertXeivaH0dB/zfAEQMShIRwg7i19edeHbZZv9dA53ec8UFnts9s13ANs7EpoR9THWbmCPTjxg7lURa3qfQnlTZNfexY8I6UmOAyxWcgDH2wM6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666149; c=relaxed/simple;
	bh=Isw28nRqlxnF937gCBXcr14DLuLIYpDTw71trs/ricU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=Pj/5R/SRXCtUqxPegLmg4EhDZJDJ0J6wraBBPZcYJnGT9oxputKBr7laNhWA0D+gCOSg685uJxQwlIdOKEbkt59LZ2foYWDKhK3GAEPDNNtb58yrLK5SYQPsUCl/AgWsJXB3/mXApHf1cvK/hluFzM2YyuCvptADIkzTiRTAujM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks6OHpsQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708666148; x=1740202148;
  h=message-id:date:from:subject:to:
   content-transfer-encoding:mime-version;
  bh=Isw28nRqlxnF937gCBXcr14DLuLIYpDTw71trs/ricU=;
  b=ks6OHpsQeY6a5yO1YKeWSvu4e6V+pI3RlqNvAksySQ8Uvb+L3QwgNtR7
   6Uf9LLs6ngvECtPv5YocBYcVHL4Lo/hc44psy+wirHgel+F0GN63sjCY5
   tJeyznePIN95/CSRI1S12QTf9AkbXiNK0hvVEvHll0mfSZ1nEtyCGViVm
   xH0eJsaMw5POlDXK6M/JboVXJwNJO46Say85av3QwaofF0+w1wypek9y8
   NiT3Mtwn32uQUoAsSTLGCIg1Zfx8sNLRNl6mXmew2aSdvNCq0tVG4wOiE
   3iAVGRxmyRKbHlQdeiSa/w7vrKvXWmJmvMN62E/IjvGvx1GRBDuMbeqCw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2850351"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2850351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28966988"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 21:29:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 21:29:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 21:29:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 21:29:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh+5ijLuGfwwfX2QUlhQnr5xgIdINKRxXV1f03Brw3wwDhVvHdrVAFpmz1/l8njlFV5+4hW7kgDyNrcwwcwPC0y73JaYs6pR4/jGhAaJtgvY4iNly507QcOxH9SLpkfwVs40oI1m63Jb2mneJiWm+nvs4Ga5nDlHPoD3GsrnK81GZm3rBU8Quco+83CzE2w9Ks6278YqAHmmxgk5VHIlOUkf8HP5Cnr3MnErsp9wqLr3lLsl6JNAi1zo2eL87OMdfRj0r6cDwsokx7KFBbf2aDNsnuO496fvqPcMvyWfb53ieytW1bpE+zX61aedB9JquyWBtucWb7q7XedDSnC7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM1dxfPrtBakJNdPVu+58bkH5C3B7jxYFAhwcPf2E+8=;
 b=Gt1b8EwLlvpHoB0JSncJKsuRJ+sa7y1y1v56APpV54Ppu3AjkIrqSbrA6l1njt23TZrjEkCWawtcP5gKqurswmqi2i1SpicvRh5UjXVN8AoTSY5ZALz2bRrH8p5YPvkDYHD/hRUTe30csIxIumHuWIQO3aCJdpD9DbEAIX55MFmXlcRrgwM48vdGxBnFqhjm0RLQ7cAZ5ZAkEIPoC1wJGgltMHc9+yMuJ5xQuCDPbTPDKHEEEysBIbniUDVrKPPia0R6cie0K0RJAujZbrkpFoEp+CgUX5Bkm+skqBAtbDQwmCqQu2e9eCF7N0JL3w5aalScMp8Rv7hXmoNxCTXnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 05:29:04 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::39aa:54eb:142:36a7]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::39aa:54eb:142:36a7%6]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 05:29:04 +0000
Message-ID: <738d3b74-1e10-4eb5-8c0d-1db33feb740a@intel.com>
Date: Fri, 23 Feb 2024 13:28:57 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
Subject: riscv syscall performance regression
To: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<guoren@kernel.org>, <fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|BL1PR11MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dee9088-60e8-42ea-bf78-08dc343058f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO0NfJX2UZhoKHNOC/lBlVzlzeMgLoJQWoAOp1x1wl+9sANPxneHd84IoBOX7grrrNsfwfqS7OKKd8vuApXedNrEhewTbNTRK52iLjtfZrZbJg+GKHysP4yGLIYQb6QRa+e3EUnna3h8xSk30QjES0a0ho3Cp71mW7NIVT7JxEdpUAnJ4vLNXIagIwQvQlwtjzNkhVu3VUOzkZ0lU8glvk4oPLCnh+bFaxT79y0DR60dhSdnTkyQT3W8yzDOnkFECDaixfuRmh+eyPlRPq1NeMqqQrrtg9uBB8ElSFwbVkQvie5NJgfjIz+Ui0Sn08Fw5VfQ/yWgby0iimMmsDTxdqeaZ/sl1iiN+6UE0mlyQT+MEB4Mu14mxsB2VVvtVwOgAXcLqSVcEMWJ8eZCkDp2su8Qln3Chi88mOI4IVuQfKmdJ5dzj1ml/26zGlaN/AKpWAiC0WhFCy6c2ZBd9uZ0+X5080Xi+VBbxGwFTJvM8QWTa5f+5QessODRR9GfZrLQRoQVGi+iG2N2QKaZYcMXIywZ86Adm4cg46wTBpIXJUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhiSUhYVWpjSndvRS9mWkw0UXIvVE5uM29jd3RqWUZ0WGREbkVZS05qOFdD?=
 =?utf-8?B?THV2bDdxRjZCSUhvSC9VVDNOVy9lN3hNdEVWOGxFRkRMU0FLak1heTNwMFpY?=
 =?utf-8?B?dkZqNUpTMkdEaEp0UXZpYW05M0FZSHNUM2JnVWIyaWYwdWpGTThMV3JzM1RD?=
 =?utf-8?B?ZEJ1T2RaenhOenQ1UFZjV0xUUTl6c2FQME9xQ3h4NUJoL1orYmM0TW5PdG8z?=
 =?utf-8?B?c0JlTjZhU3FmZ2psY1ZaV1M3RmYzM0I3NnVxS1R3NFd5RW45WFJNOUhxTUxr?=
 =?utf-8?B?WnI1RHNHWEh0MlNQa2ZoYnNIRWJoOEIrNURVWTZMRzRQdFBDSFFVUWFjSnRj?=
 =?utf-8?B?S0hYQnZKa3RqT0VPT1JzazN4SzQvRHdzdkVTSFdkMHhNRlFFVm1lcUpEd0w2?=
 =?utf-8?B?YVd0Wk1LUDRzd3VQVVpSN0dRLzZ2dHFzTnBDR2NZSXNVNUgraGV0ZlhjT3Vp?=
 =?utf-8?B?bGYwNVZYZG9CcXQzZ2RYK0hVNUNzM2pMaTJia05qdGNxK0d6T2hyNzBaZjBU?=
 =?utf-8?B?aDdqbW80NmNQQllzd2pyeGtqZ0VqS1FTckFVdTlkelM1c2QvRkc0Q1FSa1Rx?=
 =?utf-8?B?RlhPRy9RTEVNaXJxZk9rVUtLWjBVanZLdXc0cjEwM0VYRGNrVnRnTFcvZTFZ?=
 =?utf-8?B?N2VOeVBLNFllZVJHbXRWN2ZRdzVKbm5qT2J1OXYwZ09RRmVCNTZydGtBajFs?=
 =?utf-8?B?WUpicGZkUTBMQnROUnFqTk1EcXc1bDJQelF1dEJNak10U0xNZktNUGdEZE1a?=
 =?utf-8?B?VnhhVkRSQjMzekNGYWVWMExmem4vY3k3ODIrUFNUeGZPT1FvM3RrNVFlbHhQ?=
 =?utf-8?B?OW1IV2V0S2VibitFcTBlNHJBdHI2b3QwQkRHOCtsMzRNeWZ6QU1CZEkxU29B?=
 =?utf-8?B?cUE4cTB1blpYWjFET1o0bFNuZVZoeCtOOU50VEx3ZEdWWjJiNmxrY2hoWmox?=
 =?utf-8?B?NUtWNGJoSVBKTXU1bFdEOVhIZUUzeWpVZGhlOXV1VUZhRWtnMUlWcXVJck45?=
 =?utf-8?B?aEQ0VEtWVTViL29pNnlKSWNnUFF1Vk44UlZIYklGbkVvd3VBTGJZSVlYclBn?=
 =?utf-8?B?cTliT09xSkNJbEtNb0QwZDZxSUl6UnV0SXVlVS82RVkxaDlzQ0Q4UTIxVHJk?=
 =?utf-8?B?VyszbjZ5TU0rS3M2UnpsNURUTWdXSVA5LzZUNHpWUityK0JkOVRFSmhCUmdn?=
 =?utf-8?B?U3lQQkl4SmZWc0EzRllIdEwxN3k2NVdUeEd2K203V2JFVHdmYklSaGpERjdS?=
 =?utf-8?B?RzBFc3U1aDdsSWQxNk5FaW5yNmhvNTJTRHpBMGtMY1hrZjBmMkd5eUdZYUdD?=
 =?utf-8?B?NTZHVzJKN3lQSXBVLytVZnVUaVltemZWOTF3T1ZPa1owS0kvS0xyYUFQMUFV?=
 =?utf-8?B?QmQwZmR5cHFZOTNVYXh2RklJc3lzdlQ2bHpaZUFyOUV3UWVrUHR0MWpPR2Zp?=
 =?utf-8?B?UzZtMDkxd0V5aXpiRTVYb2NTR3lWUSt4ZFpRRWRiUWJrU0Mrc056RTAwamhS?=
 =?utf-8?B?cDRxMklHRUZNMHF1Rm53elJUclZHak5LenpwU3dKWkZ0R3FydGtVeWg3SHZV?=
 =?utf-8?B?Z0o4bExGYjZ5RVFkMFY5b2pYV1ppZzdkU0dxMlozb1kwbk16cmJpd0J3MnNm?=
 =?utf-8?B?MWpMM0g0UkZiek1kWE9CbVlYcnJMaGFyRTRDWFdLRHRaM1o0TGg5dGZCMENZ?=
 =?utf-8?B?aHU3TVNOYUdUdVQrTitLREUyOGo2TThjSC9TSXk5bDF5ZVo4NzVyZ25SRkUx?=
 =?utf-8?B?bkJoNWpmbUx3TnpJZU1RZ0VSRFJEQ2sxdFRCekgrYXF3OXhqTGJlS1JGOFZl?=
 =?utf-8?B?cmMwczAxMnBnUUxxazU0NjcrN3kwZ2lQRWRIcGtBaXIrZFhVSHQ3VnAvOGRE?=
 =?utf-8?B?emYrRG1vcWgwNW94Z3JESS9QYXpHVEhEeFN5VFMyUVlDM0U1Mkt3di95OWlX?=
 =?utf-8?B?U1Y2RzM4cUNieGx1OWM4VVRvOGlMVmU4MFBGQnFmYVFIN3VJblBsaFBFeHc5?=
 =?utf-8?B?Q0cvMHU4clZVLzkyRTJYMnN2VnNIWUZwdTdTWjIvWDVDTGJpajJrdWgxdHJS?=
 =?utf-8?B?bVNNUUhVM09ObWM2L2RyTjMwVDRCMWxkLzhYT1ZQeGE3Ryt2b0t0czJrc05x?=
 =?utf-8?Q?ep5TCFneQW2kCTMVbpp4QAbW0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dee9088-60e8-42ea-bf78-08dc343058f9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:29:04.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLIcSnKyeYauj2a98VNzgHo9OX7iWnZfdkEEx3CyusBF8jMz/yRzRHmYFCCFrHcyuZwHXBapMNEl74eMfnf1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5302
X-OriginatorOrg: intel.com

Hi All,

I am doing some performance regression testing on a sophgo machine, the
unixbench syscall benchmark drops 14% from 6.1 to 6.6. This change
should be due to commit f0bddf50 riscv: entry: Convert to generic entry.
I know it's a tradeoff, just checking if it's been discussed already and
any improvement can be done.

The unixbench benchmark I used is:
	$ ./syscall 10 getpid

The dynamic instruction count per syscall is increased from ~200 to
~250, this should be the key factor so I switch to test it on system
QEMU to avoid porting different versions on sophgo, and use plugin
libinsn.so to count the instructions. There are a few background noises
during test but the impact should be limited. This is dyninst count per
syscall I got:

* commit d0db02c6 (right before the change): ~200
* commit f0bddf50 (the change): ~250
* commit ffd2cb6b (latest upstream): ~250

Any comment?

Thanks,
Fei.

