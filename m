Return-Path: <linux-kernel+bounces-106267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7E87EBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796981F2207D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643524F1E3;
	Mon, 18 Mar 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwkgUSyv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEA4EB43;
	Mon, 18 Mar 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774446; cv=fail; b=aCVO+mI2ciyBlVL5ACHftojkcmxjFZHBEJyocbvlijQfU+51CT1Y4Jzj6OwtNVFum1dd+HQHSs51nOE2z1jPsScoQl66wQ1C/890y2t89nDRHFgCR+2OJfihuTI+UzhjgfwCvPBUj78eftH5ZI6uTLmde7RuMSDojomyWFh7MMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774446; c=relaxed/simple;
	bh=kHyvCmk/qDCs6vFnEzVVKFTwISLGXWgjmUw00qLikHU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKpj4XL8+TSRiLYDKIXZJ5uAqIzGkxPYHDwiFUZh3CU3VuXd2FwAwxXbKqLbAPYfd1Hyq+Jq0o1+OEj81EErLTrTO6cvPL+YCNFCRdLqh+zUuJ1Iot/S/atLKHZlZ3HJHFfSH+f3HvgnWzcipQ0uk9SWbH9glysn+b7X5kG7yPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwkgUSyv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710774443; x=1742310443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kHyvCmk/qDCs6vFnEzVVKFTwISLGXWgjmUw00qLikHU=;
  b=dwkgUSyvmhPGPYqCvMPEzXo2Ex3sYVvrPhBGwQL/DYL8iNaIZgLPck35
   /erVNakVhKnM4zKUUZKt8iEmSvYhG+ueHp0cry+cC6DcgNjMQxevlSyPH
   KervaispE9E7GkP2A1MBvID4lzfZ5eGu1r3X+zi3fobHhdYe5RbP4SuMd
   +wDGGSK+Mywr5BYFPpZSKSIhACbTPie99eCMSwCCIJko1X794MtjW4TpG
   yuxKM7A/Kj90DcjyiU4spLS8sMWVJgAs3sfLybYWB+JrkNbmkxC7blpLs
   Mh7TMEJkOwMXcY8wrAfXr0J49zgv1xAqIy+EdMMS1C8xD9GMBJVFbtNqD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5453909"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5453909"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP; 18 Mar 2024 08:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="18111510"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 08:07:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 08:07:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 08:07:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 08:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ/WbFg5x4ORxFhVMd7xeX7lO18pBA0hCk1QJ3NtW0aJwCKvtwJeZwwPq2VMOK1U4gU5T587xdnuMouCDHs9AbdW6t7d6qXYmdi86kIeVkP0dvclGuAqE2cNn1zEoDzgaJwwodqqae7Y7EhqC9BKSfXXaHABa7jgaDm7Mred4/UUC7NLym3ntZAPTJozleqaNKWXQvEVu0HglWj2IwGRy+2XtrYcV+7t7+vkCWcftJgi5ysG2zthv7tWNLrnIpkjvIM1bM1uXbpfmWTpjsuasg/AvpHjS3FInAwysBS1Gu/FCQyKkvbgHrTUB2znMoq22jmhBWFN1bcqioG30HqqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT2KJrMkiN1jqO8K9yjlM4ZjvWgHGqcX/dWcargP7uA=;
 b=XL9rgkamGuzm0rgLeBrPo/Uzy4io5910s3bOb22MgPD/WVfDUHFMCAAhtoeTUosZb5rCEhnLbkn9rQPFb+IgHXQHhHqe2PTw9A6zhnNd3syL++BPSsmzGJ0HHsHQdZRXWyeeaeYYpMxBYtXrBaWPqMUnbhTbZnmoeTuvLJOCNuXF/bYLa+baTHrd3Ig/2i5omPIzgtUfmvesFqoU9MuhWDT6VWI1fiOs4SAakDgHr8N0or57bnUJ59g9arFJXEqZIrbfhGymZ4hhYZJuVbuBKa4Nwz8CKXDB6OxL2i/eQdDukoHat8ZPFXbRH+55FKnmJ3HM8W4Glztkowz4HpxwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Mon, 18 Mar
 2024 15:05:03 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 15:05:03 +0000
Message-ID: <0a152a46-3800-443a-b370-50cf071f7c13@intel.com>
Date: Mon, 18 Mar 2024 16:04:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [EXTERNAL] [PATCH v5] ice: Add get/set hw
 address for VFs using devlink commands
Content-Language: en-US
To: Karthik Sundaravel <ksundara@redhat.com>, Suman Ghosh
	<sumang@marvell.com>, Jacob Keller <jacob.e.keller@intel.com>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "aharivel@redhat.com"
	<aharivel@redhat.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"cfontain@redhat.com" <cfontain@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>, "vchundur@redhat.com" <vchundur@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "rjarry@redhat.com" <rjarry@redhat.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
References: <20240305152641.53489-1-ksundara@redhat.com>
 <SJ0PR18MB5216589DBE2D5345BD016BE0DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <CAPh+B4JH-Wb1qetsqfnCeLcxTpOM72TSTwreqP9H6sxnP9Kn9A@mail.gmail.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <CAPh+B4JH-Wb1qetsqfnCeLcxTpOM72TSTwreqP9H6sxnP9Kn9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH8PR11MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d9e52a-6bca-4033-d3d1-08dc475cca1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fU/nwER2TYLsdE3N38O/SRpl/FeDzSBtYgBZCc2hwWuzmnmxflQA8kFuiSM1bRbQPbjpt/MH+KoJTeYJhRpyOoL1c46dmazZXT+wuTVLgPLntZWGCj+27beX8i4dwXOl7lAzis/KQJLd3dE4uOFpdbr8blZWjt1UZpq1UAGyhQpB2UNx9klepW+fExyBDEqD3I3/dpXpq2VfokBJSeBLWyuOdA+zVNrMvdWuRylPSUjpoU3SEhtMVFbS7wsd6PdsldZJ/ilS6fHSevVvYMzA30QBvPm9wX26p69YUYrFAEWNBVg2F4Hd42l9dvXTTEf0Pj2FJ6h6UkVkLt3p7px2k1I1nLCDyc8WCpXX0WY+2WiuEmSshx+5wNoU9GaLLWGNl1rGhL59uSpC83enszl98vLkVm82NwLgbAJsJlL/U7jFI/1Zva2kNNIskytCSGIvMd+swkZu6zSpSpcT3qX5dAyc6vIAHyx94jkBWA9PplKh32aCmUSB+s0KiBnKRerOwqWow0Ht6aXIgWiBwm+zB2RGVTGaNx7+W8pPGpRmiKbWFMSZRvoYlVnBxEcwN9rPsE/HeOUrjIvWbQgGX2BhNMAY6CH2Jc/OqRdY4PcMbKLNikfWtGwiYvHoy09DPcG0sydVzEZWwdZHkplsgmsBKbLxqyitjBZBrffBS/74kyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEtJZlhxK0ZuMlNlL0VFei92TzgvL1ZUTXlyNWo4ZytZazUyNFFuSUJFcVdp?=
 =?utf-8?B?K3FBcmhKQ3hnRHdlUGlteC8zQWRaaURjNStDSVlkb2U2R0NXVDBiSmtIc2Jx?=
 =?utf-8?B?SUVYUTNjQTVRYUUyY2hidTJYZi9oSWlBQnVWVVQ5dUhiV1Aya2Q0RlBpaC9N?=
 =?utf-8?B?WW9wTkpXUDNBWXloRjRXT2RnQXVrSTZzZHJuV0JDL2dTbXZqbW5HdDV2R3NS?=
 =?utf-8?B?akY5bjZIaTNkRnh3czExL0xIemFyOCtRQjdGM2xxb0hxcFVZOTUrZ2prNWxG?=
 =?utf-8?B?Sll4bEhPMmJ1ZVgzNnpIZ21rVGlmWnVUMlViK1Nad0hJRFVndzVmeENvOHB6?=
 =?utf-8?B?TjNBQ2VMSTNBUjkzZGVxb0FRK3lyV1RxcHZuVmZ0cTVPNm9uQUVYTWhCb1ZI?=
 =?utf-8?B?N2hub3VQZStDaUZrN1daak0xeGVOS2l2azcvdnVOOEpwUXVPZHZVZmU1MWdq?=
 =?utf-8?B?QzV1SUQ0eHV0V3JWbVFsVHNNNDFxN0lYVzk2NWlWR1lvRGE2dE9vRFNpQ09L?=
 =?utf-8?B?bnFyaVhORzRTL2VZTDRqa1crZ3k5YmJSV3p3RVNQM0dXR3pKWU9Pc1U3NVdD?=
 =?utf-8?B?endOR1ZaaDN2ZjRKZjdRUTFpTnNZcVRFTzRNQzVtUk0vT21PM3VpTWYzMVA1?=
 =?utf-8?B?STV5RXNZdVlaMEhhUllHNDZpckcvTFU0YWovTm5MdnNiUng1cmRpU1dkY2xi?=
 =?utf-8?B?ZTZWY25Jb00xb3pLMjhVU3pxWnBXTEg5cHQ0WERKbnNkaXgwdUZDclRPQ2Zy?=
 =?utf-8?B?RVJDYU4raC9VdjNiVlVGQmY0MGdrWkJlWXk2S2lmTGtNaGVBK25CU3dqR2pk?=
 =?utf-8?B?dkF3TWFVQmJJWjdMZTBFYVZuL2N1V2o1OU5adU9wbEwvd2JrOWZyTXBJVlBy?=
 =?utf-8?B?YUw0bklOZzVXcWo4MllzSW1BYjE0ZjhMMjFwUzM4SUUwM3ZqbEVEeDNCOHNT?=
 =?utf-8?B?elJ0UG54TXIySVFpd29QblFjelVCSWFyK3o3SENNdmxvaURoZ3ZlMmp1bmVi?=
 =?utf-8?B?N1RWbEZvVXFCdW9pbm5VY0JrcnRLRVZpaUdYRDRwOE9Iak1Gcm1rZDYyQTdu?=
 =?utf-8?B?V1lTY2VEdkZtWHJEemFnTFNrTzRSNVl4eDBXRlRtOGhrMWpqV2ZnckNJYU1a?=
 =?utf-8?B?MmdWdnJVTktJUE0zdFk3MkVJTmE0Vm8wQXhTNmlTaXpoV0xyc28yNGl2anM5?=
 =?utf-8?B?U1ZzMk1abTl1WGpGNEVVNlA4R1liSS9QcjV6cnZ4TXRraXhxbXA3Q1JRektt?=
 =?utf-8?B?ekRIbTliSnByTTdDVEpJOTBCS2FHMjl6Wk1NVWJ5RlB1OWRWbnlRRW9sK3V2?=
 =?utf-8?B?cTFZV1pGS2ltZVpkcU10Y2RnclZsM3doMWVxQmF4ZVZtN0F3TTEwSFJabWEz?=
 =?utf-8?B?RkFwR1RWZFBsSGNvSlEvNUZSY09sV09pOUR0R3A4Nk5ua0RnNzBzU0Z0K2d0?=
 =?utf-8?B?ZXdHUEZpanlJTGNrTHcxQS9TdFpaQzR0TzRqTTZ3VDBmMXRIb2FyaGo4SVhL?=
 =?utf-8?B?VGRTVWFGV1dLVjNCNk1HaHVYT2lBMFYrckxqZ3RndHA3bkhYKzRpZ3JDRDZj?=
 =?utf-8?B?NzdaYWhlT1J6ekZHcXhWT0twN2ZWVmJhK3pnQjJNUnVqRHJ4OENXUGw2Z2hT?=
 =?utf-8?B?Uy9RVzVsSVNxUlRLTi9pMU1jYzRxcElhYjZZMXZiNkxHT1padUZKSVZWNjlw?=
 =?utf-8?B?dWhMWHFNZUdaMEwvTXJVcWtBeXpmZS9vcXQ1c0tJR002SlhDaDAyUnJFUkpU?=
 =?utf-8?B?TlVuRXBJdHVwWlEwQkxSRlpxLzRXbHFJbi82eTYzSFNaZjRVU1ZsZnE2MkJx?=
 =?utf-8?B?MElFVGlDcHBKMzE3L2tYRlh6Z1VoY2R2eDd6emZRUnlLeVNaQTd5U1JBZE1j?=
 =?utf-8?B?ZEU0QUxFWUdtUlJXNWh3cVJ0TXVlc1hIUG9hRm10RS81M29MbU5GVUhnVU02?=
 =?utf-8?B?MXJVWGRJMkFvTzhPUHRzNzZOMG4yRUZFTzVpV2g5Z3MyeGl5b0JzV2pkQU9Y?=
 =?utf-8?B?N3ZRUmUrMWwyN1NFWkRTd3gxU21YamVQODVLY2pVTVFTNTB2aEFRYUtrTEVM?=
 =?utf-8?B?Sk9tWS83VXQySmlVL3hGeUlkMkhlaXM3S2FCLy8rbTJIc0xzZEpvU1pVRmJk?=
 =?utf-8?B?RnNScU4xNldQdUk2MWFlUmM1dklwZENLN3h3d0M4VnlJWThSK2QvSy90aWZU?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d9e52a-6bca-4033-d3d1-08dc475cca1b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:05:03.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLG3i6+sbvdkfwNKjCE8SZ8HY/3fkAe1Cf3FsPF2QEzIYLE9nW8WHKO80S7o+pp1NWISrCnzIdfXZ4Cj+4U5SDyLzXyHouLAIVPdELH5nQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com



On 18.03.2024 12:55, Karthik Sundaravel wrote:
> On Fri, Mar 8, 2024 at 3:28 PM Suman Ghosh <sumang@marvell.com> wrote:
>>
>>> ----------------------------------------------------------------------
>>> Changing the MAC address of the VFs are not available via devlink. Add
>>> the function handlers to set and get the HW address for the VFs.
>>>
>>> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>>> ---
>>> drivers/net/ethernet/intel/ice/ice_devlink.c | 78 +++++++++++++++++++-
>>> drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++
>>> drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 ++
>>> 3 files changed, 147 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> b/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> index 80dc5445b50d..39d4d79ac731 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> @@ -1576,6 +1576,81 @@ void ice_devlink_destroy_pf_port(struct ice_pf
>>> *pf)
>>>       devlink_port_unregister(&pf->devlink_port);
>>> }
>>>
>>> +/**
>>> + * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink
>>> +handler
>>> + * @port: devlink port structure
>>> + * @hw_addr: MAC address of the port
>>> + * @hw_addr_len: length of MAC address
>>> + * @extack: extended netdev ack structure
>>> + *
>>> + * Callback for the devlink .port_fn_hw_addr_get operation
>>> + * Return: zero on success or an error code on failure.
>>> + */
>>> +
>>> +static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
>>> +                                        u8 *hw_addr, int *hw_addr_len,
>>> +                                        struct netlink_ext_ack *extack)
>>> +{
>>> +      struct devlink_port_attrs *attrs = &port->attrs;
>> [Suman] I agree with Wojciech about using container_of:
> 
> [Karthik] when I use container_of(), on some occasions I get core dump
> in get and set functions.
> These issues were not seen in the earlier versions.
> Can you please suggest any pointers on what could have gone wrong ?
> 
> struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
> 
> [  597.658325] ------------[ cut here ]------------
> [  597.658329] refcount_t: underflow; use-after-free.
> [  597.658430] CPU: 18 PID: 1926 Comm: devlink Not tainted 6.8.0-rc5-dirty #1
> [  ...]
> [  597.658506]  ? refcount_warn_saturate+0xbe/0x110
> [  597.658509]  ice_devlink_port_get_vf_fn_mac+0x39/0x70 [ice]
> [  597.658607]  ? __pfx_ice_devlink_port_get_vf_fn_mac+0x10/0x10 [ice]
> [  597.658676]  devlink_nl_port_fill+0x314/0xa30
> [  ...]
> [  597.658835] ---[ end trace 0000000000000000 ]---
> 
> 
> [  859.989482] ------------[ cut here ]------------
> [  859.989485] refcount_t: saturated; leaking memory.
> [  859.989500] WARNING: CPU: 0 PID: 1965 at lib/refcount.c:19
> refcount_warn_saturate+0x9b/0x110
> [  ...]
> [  859.989671]  ? refcount_warn_saturate+0x9b/0x110
> [  859.989674]  ice_get_vf_by_id+0x87/0xa0 [ice]
> [  859.989777]  ice_set_vf_fn_mac+0x33/0x150 [ice]
> [  859.989858]  ice_devlink_port_set_vf_fn_mac+0x61/0x90 [ice]
> [  859.989940]  devlink_nl_port_set_doit+0x1d3/0x610
> [  ...]
> [  952.413933] ---[ end trace 0000000000000000 ]---

Ok, I think we forgot about kref here.
Once you have a VF pointer you have to inc the ref count using
kref_get_unless_zero and you have to check return value because the VF
might be already freed. When you don't need the VF's pointer anymore call ice_put_vf.
Would be cool to have Jake's opinion on that though since he implemented it.

> 
>>
>>> +      struct devlink_port_pci_vf_attrs *pci_vf;
>>> +      struct devlink *devlink = port->devlink;
>>> +      struct ice_pf *pf;
>>> +      struct ice_vf *vf;
>>> +      int vf_id;
>>> +
>>> +      pf = devlink_priv(devlink);
>>> +      pci_vf = &attrs->pci_vf;
>>> +      vf_id = pci_vf->vf;
>>> +
>>> +      vf = ice_get_vf_by_id(pf, vf_id);
>>> +      if (!vf) {
>>> +              NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
>>> +              return -EINVAL;
>>> +      }
>>> +      ether_addr_copy(hw_addr, vf->dev_lan_addr);
>>> +      *hw_addr_len = ETH_ALEN;
>>> +
>>> +      ice_put_vf(vf);
>>> +      return 0;
>>> +}
>>> +
>>> +/**
>>> + * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink
>>> +handler
>>> + * @port: devlink port structure
>>> + * @hw_addr: MAC address of the port
>>> + * @hw_addr_len: length of MAC address
>>> + * @extack: extended netdev ack structure
>>> + *
>>> + * Callback for the devlink .port_fn_hw_addr_set operation
>>> + * Return: zero on success or an error code on failure.
>>> + */
>>> +static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
>>> +                                        const u8 *hw_addr,
>>> +                                        int hw_addr_len,
>>> +                                        struct netlink_ext_ack *extack)
>>> +
>>> +{
>>> +      struct devlink_port_attrs *attrs = &port->attrs;
>>> +      struct devlink_port_pci_vf_attrs *pci_vf;
>>> +      struct devlink *devlink = port->devlink;
>>> +      struct ice_pf *pf;
>>> +      u8 mac[ETH_ALEN];
>>> +      int vf_id;
>>> +
>>> +      pf = devlink_priv(devlink);
>>> +      pci_vf = &attrs->pci_vf;
>>> +      vf_id = pci_vf->vf;
>>> +
>>> +      ether_addr_copy(mac, hw_addr);
>>> +
>>> +      return ice_set_vf_fn_mac(pf, vf_id, mac); }
>>> +
>>> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>>> +      .port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
>>> +      .port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac, };
>>> +
>>> /**
>>>  * ice_devlink_create_vf_port - Create a devlink port for this VF
>>>  * @vf: the VF to create a port for
>>> @@ -1611,7 +1686,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>>>       devlink_port_attrs_set(devlink_port, &attrs);
>>>       devlink = priv_to_devlink(pf);
>>>
>>> -      err = devlink_port_register(devlink, devlink_port, vsi->idx);
>>> +      err = devlink_port_register_with_ops(devlink, devlink_port,
>>> +                                           vsi->idx, &ice_devlink_vf_port_ops);
>>>       if (err) {
>>>               dev_err(dev, "Failed to create devlink port for VF %d, error
>>> %d\n",
>>>                       vf->vf_id, err);
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
>>> b/drivers/net/ethernet/intel/ice/ice_sriov.c
>>> index 31314e7540f8..73cf1d9e9daa 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>>> @@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int
>>> vf_id, struct ifla_vf_info *ivi)
>>>       return ret;
>>> }
>>>
>>> +/**
>>> + * ice_set_vf_fn_mac
>>> + * @pf: PF to be configure
>>> + * @vf_id: VF identifier
>>> + * @mac: MAC address
>>> + *
>>> + * program VF MAC address
>>> + */
>>> +int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac) {
>>> +      struct device *dev;
>>> +      struct ice_vf *vf;
>>> +      int ret;
>>> +
>>> +      dev = ice_pf_to_dev(pf);
>>> +      if (is_multicast_ether_addr(mac)) {
>>> +              dev_err(dev, "%pM not a valid unicast address\n", mac);
>>> +              return -EINVAL;
>>> +      }
>> [Suman] I would suggest put all the validation checks at the beginning of the function.
>>> +
>>> +      vf = ice_get_vf_by_id(pf, vf_id);
>> [Suman] Any reason we are passing vf_id instead of the vf itself? If you decide to pass vf itself please move the ether_addr_equal() check at the beginning also.
>>
>>> +      if (!vf)
>>> +              return -EINVAL;
>>> +
>>> +      /* nothing left to do, unicast MAC already set */
>>> +      if (ether_addr_equal(vf->dev_lan_addr, mac) &&
>>> +          ether_addr_equal(vf->hw_lan_addr, mac)) {
>>> +              ret = 0;
>>> +              goto out_put_vf;
>>> +      }
>>> +
>>> +      ret = ice_check_vf_ready_for_cfg(vf);
>>> +      if (ret)
>>> +              goto out_put_vf;
>>> +
>>> +      mutex_lock(&vf->cfg_lock);
>>> +
>>> +      /* VF is notified of its new MAC via the PF's response to the
>>> +       * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
>>> +       */
>>> +      ether_addr_copy(vf->dev_lan_addr, mac);
>>> +      ether_addr_copy(vf->hw_lan_addr, mac);
>>> +      if (is_zero_ether_addr(mac)) {
>>> +              /* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC
>>> */
>>> +              vf->pf_set_mac = false;
>>> +              dev_info(dev, "Removing MAC on VF %d. VF driver will be
>>> reinitialized\n",
>>> +                       vf->vf_id);
>>> +      } else {
>>> +              /* PF will add MAC rule for the VF */
>>> +              vf->pf_set_mac = true;
>>> +              dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be
>>> reinitialized\n",
>>> +                       mac, vf_id);
>>> +      }
>>> +
>>> +      ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>>> +      mutex_unlock(&vf->cfg_lock);
>>> +
>>> +out_put_vf:
>>> +      ice_put_vf(vf);
>>> +      return ret;
>>> +}
>>> +
>>> /**
>>>  * ice_set_vf_mac
>>>  * @netdev: network interface device structure diff --git
>>> a/drivers/net/ethernet/intel/ice/ice_sriov.h
>>> b/drivers/net/ethernet/intel/ice/ice_sriov.h
>>> index 346cb2666f3a..a03be184a806 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
>>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
>>> @@ -28,6 +28,7 @@
>>> #ifdef CONFIG_PCI_IOV
>>> void ice_process_vflr_event(struct ice_pf *pf);  int
>>> ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
>>> +int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac);
>>> int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);  int
>>> ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info
>>> *ivi); @@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev
>>> __always_unused *pdev,
>>>       return -EOPNOTSUPP;
>>> }
>>>
>>> +static inline int
>>> +ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
>>> +                int __always_unused vf_id, u8 __always_unused *mac) {
>>> +      return -EOPNOTSUPP;
>>> +}
>>> +
>>> static inline int
>>> ice_set_vf_mac(struct net_device __always_unused *netdev,
>>>              int __always_unused vf_id, u8 __always_unused *mac)
>>> --
>>> 2.39.3 (Apple Git-145)
>>>
>>
> 

