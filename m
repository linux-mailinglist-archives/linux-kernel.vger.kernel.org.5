Return-Path: <linux-kernel+bounces-62442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F4C8520BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299411F233DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66354D59C;
	Mon, 12 Feb 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msVW6qkN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46C4D117;
	Mon, 12 Feb 2024 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774245; cv=fail; b=mYSqjyE2paVl0Xz58uJLvpC2HkCGjGJLVwGM3zvlS8xcre+Syo0B5Ld9bPtK+Gc29TV/67r2jymRdcHcXgnwMUppSxuf9lQ01h9t8F4QJMaV1uB1ZDhljrM8Kkb848eBMZIutR7rARXukDFZtBFsqkwGEsGzpyfTsekJjEkNt6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774245; c=relaxed/simple;
	bh=pfR+uHd8XFEHlk3e9iPx38dgDmabFngWm3Ki7PsWuM0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BZhaCIKDklfLMUP4YJuhjYp86tH2A1E6tkXqgDGdi3XWJEtheLwzZHvOse8oS6lrJFHfEsYG8Sp4GPxIKXn5nuNTARqndwWJgdHpXgus7PfqAVTbPBkH8teDkt+9EEEAmfBLZeHQq5uKkCiXcaIyclKwofvm+jyq9LZEx9zEStQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msVW6qkN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707774244; x=1739310244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pfR+uHd8XFEHlk3e9iPx38dgDmabFngWm3Ki7PsWuM0=;
  b=msVW6qkNN+oZ5PctMGYbSVnI/JujtAT2Og1iNEiT/n3vJwEg6ZvnI6yg
   eGIMnmwZyTG5VZUTEuImbxyIJ1xd+0AjjMUqo45PpoYBNCTbWA1A78j3Q
   nve4Yof42OyxRW3JbFvQIstd9xFbYwYAFrqC2J2eQMhYbtXyQxRv9l3yC
   mbKBnXDPPpPg5xRJa7aOoj1ia9MuUnIyfOiSScNdcWikokygghiQy5IzI
   AdvwsK7ArFOyTXuq/JcKGBfamrshMjYTHDvEM5AswZBD986CWV9ITs4yX
   PrEAQhc7957tMIuBmw0dpYjv2kqrFK+lyYvqtBiY8QFPn2iyVqy2xOm/0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12324138"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="12324138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2687452"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 13:44:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 13:44:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 13:44:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 13:44:02 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 13:44:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVfpE/Kc8IxRn+Y4w4FGzbujNiHh9naGhm8sxVZOu3FjlHNrEfuUM8I6GlFw84v6VcPwu+VQLcPgBz/yAqK08NbK8EGgtq1CFMtbjZQVo23VSb1uodYwqPRos8LbenceMHMQkVPK0GLQGBguJ6SRGv8xVFbD5HVPFzMW4t30t+WiIWf4LAzgrBsf/jOErzJd2PoDFXrBV2vMd5zuDhK4/Z8yFr6AitG1i6Qx1LHMs3HDMjYjkPnkZn/TqiAVerih5yZO5oQTqZ4uRQUrqgEzctfgzZUuJAHRHN/wwRgn1711yLIhlXOBm5eYFyR9clLcc/OSofxrX99wfNDgYwMX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfot41AYwLFN9CQoO01Xc6J2VHzfbB+d0w0EJvErUrk=;
 b=U9wGTdrn4qGD0GPDA/bj3Qn8CU0jmL2xOo+AfnjwfdJkb89OkZS/Tb1lqWfdbhZjKOozpcu3dkq8opy8BK+RFOURgQvEsl8uYtuGJyKwqVHUKizQhMhgbhnYhjw9lUPqRf8mIO0BqTWv+KS4KrvKt570mMokeQ4RaU98Q3ulfoGwwItCiXAnJkQKNP/aEJqP4NXwAYBWUTD3nBZyG1sq4ybAskgfT2n//J++XG9+SbGSE4wVC+fWl2rmNtoV5MtPAS2rg73VgimZS6dy0OwkiaR9RHLLCFW2M3qLsia4ijr7KHYCgWXzlrjzjUFWoBMvtt96lQGFtg4zYNPBmSQGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7598.namprd11.prod.outlook.com (2603:10b6:a03:4c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 12 Feb
 2024 21:43:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Mon, 12 Feb 2024
 21:43:59 +0000
Message-ID: <16a63923-2fd2-4d44-a8a3-32d8d6eeee9e@intel.com>
Date: Mon, 12 Feb 2024 13:43:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
 <SJ1PR11MB6083036DC25D4FA55B02589AFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083036DC25D4FA55B02589AFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d16e43d-7b2c-4c51-ccac-08dc2c13b890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WT9wT0j6KuecXK7xldhwhKl1XxzYDF4wsJk6BByDtXCfH42vnM8szaA9pzQOYub41yxIkv5HvuKAF5QkoQrxOYrdMRGWlebDo8rkWZXtC4LPKUkPiMp95mUtY15fJu8umtwFJg9gIW5O/gsvAqrzZHbaFBp7FQFyqv0Rr6+BdfqLy1J4VBOhaIsR1gHpRZRt37If5lNoBOx5ycKlQdfkLwDT/NFpmYqX77aTUb0+eg9PHGTtwWR2PCN9NgIN3bcNC2AioIV6YjjNQ2v0QjfFyeEIiqFh1NczszyIzUs8XHbIdEoCSkx/mR23qXS9Gqe46KNPC0N+hu8ZCJo17efMwEfzt/UbkSaZHdbIKfLQp60xmjyVVGRL/HBJPJ7D8uD0gbRPNKCQsW7//WFAFKbcqLncU35F5H4Snm2gHf5zCLaDPNncYsxSne2/q23fp/sZDytt+ixwRLk1wvLySNwUNUTAG7oufZzr3ZJ6g09tOHb1dgXeSgLvFgPza2QKiml1o9yQE9cq5nSmzVs2Cr7Pu5AfLBYWvIYW+rXQr8FdPxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(110136005)(54906003)(66476007)(66556008)(316002)(66946007)(41300700001)(5660300002)(6666004)(7416002)(2906002)(31696002)(8676002)(8936002)(4326008)(44832011)(6486002)(966005)(478600001)(2616005)(6512007)(53546011)(36756003)(6506007)(86362001)(26005)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sjhoa0QrdGtEVkFKMlhySXJiamtSVTNINW0xbVBBZ1RLZnlpdDVzdjlEWEZQ?=
 =?utf-8?B?RzBSaHRMQk5JbldzYnZtTEhiWENPTWFidk1RaEp0VGVzS2RpRndpbFB2d2Qz?=
 =?utf-8?B?NENVek5iYks0Qng0NmpwT25NN2pGeVh2TXJBbW0vU3BBdHRpa3JyQjZML1E1?=
 =?utf-8?B?V0o2dmdwRll5SnR0SE15RzJRRnd1Y0VxaEl4OUFSWUtBZFNGNTlmMkJ3SGZ3?=
 =?utf-8?B?YUdzL3d1VUhoTFZ6OVdTQ200YmtIMjJUdEVrdXhWeEJNL1VaYlNENG5SNFZ0?=
 =?utf-8?B?ajhab0NScm4wRytIdlZpYUFzYWhtdHJXQ1c5N08yN1l6Y1FqSTdsMTRiRk9h?=
 =?utf-8?B?SU1QeFlDZFRXZHF0MnFmYlB6aC9JdnNLL1p1NWVKZURESGlsTithaTIxaUhN?=
 =?utf-8?B?a2ZrVFZmVGRwR2FnVmJobEVzMG9vUyt1Q01aODVUeTNCNGIyazJ0eGVnQVEz?=
 =?utf-8?B?T004cTRkV2IvbnBGRVBtTDY0SnQ3UTl1WEl6UUpQUVBCcTdqdDVHeS9UbjNX?=
 =?utf-8?B?Zkw3RjZSRXBKWWZ2aGtaUWFLZWFCaUFGek40ZXF1NnU2SjkrNUZJbytmUFF1?=
 =?utf-8?B?MHc3Mml3TnZTOWRLUkFWTnd0eFhjOVhnTmRsUEVhc3JtMDNqbEJYODllVkh0?=
 =?utf-8?B?NVBkbndFMU90RWRPa2NwczNtYWZmMTR3TitQNDBWTlQ4My80bk4vV0J1dlor?=
 =?utf-8?B?Zkg1SkJoTFNtVXZBYUcyV3ExQlVubTRGU3Rra0pLRVlFNDErMCtLaVJJYlcy?=
 =?utf-8?B?aE9PQk8ramdUYmVMRGpmWnNFRDN2OVk3L2lNUlRONGJxZHpHMVg1NjA4V1Rz?=
 =?utf-8?B?akcyTlhIZHdNKzd6UXRKYXNtQnMvZ3poaGNSdGhCQkpqcHpocGNZdU1ETlJJ?=
 =?utf-8?B?dUQrQ1ZxZm5EQzRyQm9yYWxDVERQKzFYN2JDU2VGeGNianE5TmhjOFlRVHF2?=
 =?utf-8?B?ZG5JMzdkMk16Mlo2NjBHNzQzaHNsazZ0NHFyaExuR3htTWNtSjNZaGJWR25V?=
 =?utf-8?B?YmR4aWJlL0hLbWYySFF1QTZZQ1g5bVRndXd0TjNTMlJLbmVOM1l1NXAxMWRk?=
 =?utf-8?B?cU5HM3IySEtYUnplNVlLK2lJbWhobnc2K29LZC9NK0VSMStnRDVhdTdyMkhT?=
 =?utf-8?B?VmVNWkp1bjV1NUx0dGFNZjlneU0vQ3hZd0dMeFViNkNHT3RzMndnQ0h1b3V6?=
 =?utf-8?B?eUJndkRDS1M5bGRrU1FEdnNERWVXekN4R2ZaQjVzMzNscWFBTU4vbkN2K3Y1?=
 =?utf-8?B?SnNOOVZBYnM0UmRnVmhaSnhQZ2NLa3BDNkZPT2U4VXN5QUZWdzB5WCs5VXU4?=
 =?utf-8?B?MWlqd29SSElUUjVHdGNDSDE1TU9NV3U5dUR6Zmc0RzRwSmcwamRXL2c0OTdU?=
 =?utf-8?B?d2lTd0tSMk5mRVZjSHJmWkloQjRvaHJQNTdVT1VMTHBFdlhoODhjUnVIV01r?=
 =?utf-8?B?MTdQNWpIYnZJTkY0VEJ0TkJYTXRqYlQ2allQd3d0ZGNhdUM4VkNTSmY3ZFhS?=
 =?utf-8?B?OHdqQk9namdrSkcwY0VwQS9YeFMyb0E3eE84QVBSTVNSd2srTHpnQTJudHlB?=
 =?utf-8?B?ZkxNNjVyNUZnbmdwV3Z4SGpCQ1diU1puS09jL3Q3ZzFQQjVSTHFIM045QWF0?=
 =?utf-8?B?T1FRY1EyYStWOGVYdFo1dXBKcXFsRnE5RURxWk9iVHF1K3k1UDRjL0hKazFw?=
 =?utf-8?B?N1RYWUtlOUZvVXdzOElsVE1zOTl4WlgreWtiRVJDU29JTG5tajVuRVRPNnFy?=
 =?utf-8?B?Ym41NUt0d25QN0JmaVQ0d2VuWEZNL0lRSDFRUHEwQVNycDI4S2REa2trWklU?=
 =?utf-8?B?MG5kdjBaNnc2bVZCdFlvczJvd1RBa1FkRmxlWXloVEJBaklaeWg4cHpMZktK?=
 =?utf-8?B?ejN6QXdTMHVZUldXY0xQVC9xdGttaVVwUytwRTlZK1A5WDIvalpSMnNlMW1N?=
 =?utf-8?B?anlXdnNTb3lpUWRRQVZ0YVpncGtCZlNXNVVxMktDZlkzZFRiVzRaRjJRMldX?=
 =?utf-8?B?TE1CZE1TU0RWWHkzaUcxOGdMQ1haRVVBR3JJcUN2R252dm9kV0w0RGxNemlW?=
 =?utf-8?B?cXFnMjFVaTViU09DTlh5Y2g2bEtNekEyeWtnbkhjMTdQa0tBZm9GYzdxbVZr?=
 =?utf-8?B?VWEyTWdSTUFmU01TRjhYSU0yUWY5Yis5NzVQejhCdThxaGkyalpUaDcya1kv?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d16e43d-7b2c-4c51-ccac-08dc2c13b890
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 21:43:59.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb5Ro9pQkauiF5TkY5c4dbyrPYJQmaZxzrhvwWs3yjfnRgKm8VK5tDWLTjA6arqQPLrHvx0IUGIgL3mVEncoXGiQE/SLWXWt0ZcwKSuXFVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7598
X-OriginatorOrg: intel.com

Hi Tony,

On 2/12/2024 11:57 AM, Luck, Tony wrote:
>>> To be honest, I like this series more than the previous series. I always
>>> thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.
>>
>> Would you prefer that your "Reviewed-by" tag be removed from the
>> previous series?
> 
> I'm thinking that I could continue splitting things and break "struct rdt_resource" into
> separate "ctrl" and "mon" structures. Then we'd have a clean split from top to bottom.

It is not obvious what you mean with "continue splitting things". Are you
speaking about "continue splitting from v14" or "continue splitting from v15-RFC"?

I think that any solution needs to consider what makes sense for resctrl
as a whole instead of how to support SNC with smallest patch possible.

There should not be any changes that makes resctrl harder to understand
and maintain, as exemplified by confusion introduced by a simple thing as
resource name choice [1].

> 
> Doing that would get rid of the rdt_resources_all[] array. Replacing with individual
> rdt_hw_ctrl_resource and rdt_hw_mon_resource declarations for each feature.
>
> Features found on a system would be added to a list of ctrl or list of mon resources.

Could you please elaborate what is architecturally wrong with v14 and how this
new proposal addresses that?

Reinette

[1] https://lore.kernel.org/lkml/ZcZyqs5hnQqZ5ZV0@agluck-desk3/

