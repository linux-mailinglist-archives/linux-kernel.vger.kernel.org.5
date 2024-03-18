Return-Path: <linux-kernel+bounces-105627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72B87E1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829281F221F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0921DFC7;
	Mon, 18 Mar 2024 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liQ0Q6uD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABC1DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725558; cv=fail; b=NvNrliRDw/an5/YGKcgihV304bQNz8ia9lPcVxtejq/G2H+bbF+pHMPBwNRALrkOn6ftFgumLyk9x/Vj3v/cRvqu5SK7fRFRz1jtHRWYmQWCG+dqPwdWuMp5MAnX/fgInw1i04KcSkPSNFYxxIONBLYDTuYNt00BD2rgdIA6RAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725558; c=relaxed/simple;
	bh=nKaUmSc1gXFpenYbvTToU/VogdlVtb6zlKWEzJTyp5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sOjXCFYxviYBUAnqnZ3HOtzHgwUEfec6P9wS589CBYzBpOHEoWE01VL85nRF6tS3Gc/Y9Es5QaE+Lv5PlPYXJ4ca45dFdYueD2I7ZDqVs3y/NxeKWDO74xnjHXYRm4OSRSY3SK/pGo7XvhFPoV2L4gUUMptISfyerI5iUs+0P+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liQ0Q6uD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710725557; x=1742261557;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nKaUmSc1gXFpenYbvTToU/VogdlVtb6zlKWEzJTyp5Q=;
  b=liQ0Q6uDDBFQZXx5oYIY/n0AWGvCMf21ZzPHVau6w+QSeSAh28BfN4TI
   QS/da0F4Li5Rt5KWFmPdsDMiQEaPDdJbsqCbK1278QThkD4IVqErTnLdN
   5mHDBmZ720jx9AHjIwPPOZen4HQmKbNKxTbwuShb5JbDE2psjt/e1baL7
   LraR6sE+L2khLaNWkrq/8BraL8V7kBGb+F4JoUfHiYY3Y6Gtqq3UxHqVA
   Lw5VZF0iO4CdZmSFJ6UOCzKJNFxMbVpb7N2gBj8oCUEO5ecq0Sw98zuLU
   DKeXEQHnWYOTy0fNfjvnlG8xphXczKm4tZsB/zYmTEQYDtsEgGxe9v6yr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16243100"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="16243100"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="17986411"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 18:32:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 18:32:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 18:32:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 18:32:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 18:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuwpSD3nou4XVfSMgfe4cHxG7nJBC2XJqPQABStl/Vsp2+rCOcl0HivEPhONGvMiaA0yRuXXtyY6VFQpIrQ4Hfq1E+b7B5UqC2H4d7VD3V4unp+E08eYrVCtOq16WFL3+HCOHv5uLCAQE1OohXPojgNnAUbWbr23eeMvD5IpFc9vGiQhJ1sam5wPAZuR/yOIJOVNWI+fUwxqtKn8j4LtVgIdiFze1vfNFUeQZfKzbVRb6IishK47cl1LsCs4pDNp/wtTldfdvg/WX7KqtW8UQam9YDJ88EF0AICqhcuVm/WYPcqeFN+LaAyYFnTVGx1kfHjQm46lI45kWtuugpO2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCmHid/zSM5onnA1SO8K4Ix3O9uw4Ge7v4U7NC8NHpU=;
 b=ePtLLdRlOR/zKOv93jkyRj36ysVtWS/I1KFhVI+a9rKs0Pw82Nh4RTRVqUtbGaU4QqOVyYdCDeteMYw+3WiE+z86RBVrNRZAJ1DU43Ce7XqA4NcGhnvdEF+WivEpIp4wwLEG92yppgHf/WUKsEHVjoCbPblp9oHbPazbfr6+VFHKHiRSXEBxLg1vwzV2aCAvRz47BrcKDNYZXEuNnHLGeJpZDL9ZpjVY5h3vtJT/6irhQo4+hToH5ewmUR0X+ghz7kind8d0soXLcPv1Ah5C9ZISDMY5M87or9B0twAEFUsaT1nxOxweF0kCRQ9g2WvfzizLKNNn1t65PHNmOsdUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Mon, 18 Mar
 2024 01:32:33 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 01:32:33 +0000
Date: Mon, 18 Mar 2024 09:18:35 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <ZfeWaxlGBIO1J2Jd@feng-clx.sh.intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
 <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
 <f9da97d86e5599edca74fa859053ba9caf2b4d9c.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9da97d86e5599edca74fa859053ba9caf2b4d9c.camel@intel.com>
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0fba06-bd81-4542-c3ba-08dc46eb4891
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYEu0j+b7FKuz1bE/eVIYsJzDpCQsQaCmuFvGNtMhjIR5a+lrTZvNMdLJ6KYjyeXDun0zs8qOc9C6XOXqEpBZgui4sZ6x5mSKJFWuXiH7FVFjVMhEowMI2yh/uTSlwxglEmAKzE037VV1xTVwnXGVnaycRptxBX1Ba3ZQkYMs1fxGobxKyh0TmauJLQvdMP5IfY+AaMqdShwz5g9hV912gNLBYLBbBtXYZ6JG+E/JnBmvurOE2pwpqIvy+Rb26KPuicB8s3HroPvLsD/gNA77cdxEi0MyozryConZwe8JSqzvgbCBTF0ufMjciTFTLOWY+g+KH4RRg/F1ZQSRie45F7ul+jv2UppBI83JdEA+FgTh4Nr/mXiqlOMUfeM6Ae0pkDL+Q5KubTvNgIYdrNkrOAxYk1TsX6qmyZ9ClXdNETubb1EpPMwKyRyTbPcC0RBM100x6obkMyIEM/iQ+a1X4FkrWjggEvsnGiCw5bynSg3BvD49Y+hGPJemwfS7PIrHs5UK0YYYz3EBRmjhmN8pZnR+tXB2HOpi2pSIQzavF6CfJJ36PJ45wzyINV845E03o/XeMqaqTI8JnThROoRWbYzwm+znu2gIXpJ6DvDs3XXrdt0TovvsP4ECgnUPRqZrLMccrGvAurTMWK0Bu8ZHR1h2bgv/ZhDfdHAnbwVlqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qldzb3B6SVRKMUJaSmhsY2FSTU9ucm5WaDNRankxQjkrSHNsR3V1d0pHdjRY?=
 =?utf-8?B?eGx5cUFIbEgyc0pLbjBsNThnemtseDVhc2FqTlJsSEVOMDB6UGhLZlh2Ui9D?=
 =?utf-8?B?NnkxL3NGeElNSHhyTUZ2NjdvN1lnSkdEQ0l4dStsNElaeGpVb3dRVkVYaHc0?=
 =?utf-8?B?STFEdnVhamVIMFpnTWI4N25aVDRSUGhHd2ZnaTRpU3NoYjlrcFBFS3BEL2Rz?=
 =?utf-8?B?VytNNUFQc0dNdmJQS0dtMDY4S0FoVHlsSG5kQkFOeEthaVpjWWNRU3phem9U?=
 =?utf-8?B?N3BaZjFGclVzSGFPbmdhbmJGVkpnaHVVUkI4clpRWjBLcjhMNjJzRnlxOC8x?=
 =?utf-8?B?aWU1NzdVeVFQdkQ1TURiVkxBamM3WjE1TjN6VDJtOVZMTjNXZkk2MzYwMzVq?=
 =?utf-8?B?RGN4UHFkWHNVZTdPdjJQMFBuNHNmbi9vMW9rOTAreG5GckJnR0RnRmpzN1Yv?=
 =?utf-8?B?bWRxYmxFME9UVVJMZlU3akZ1Z1p3akVmazVIN25vcXZVZ3V2bU9uRWN3UzJU?=
 =?utf-8?B?Yk5RRkpMWlNZWUVENTY2ajN6UnV4YWloSnorODJ0Y3FaVWhKcXorb3AycXA0?=
 =?utf-8?B?em4vSk15K3hOL1dYZm5aN253bURuYVNpQ01TZmJDME5Ja2F6OUtnUDlaMlhh?=
 =?utf-8?B?amk4czQzN042dmt5VFhmbCtueVRSdjRma2gvcXBuQmQxQkZzZGM2Y1hxd2ph?=
 =?utf-8?B?NVo3QlFJTEZEbm9NczZlVHpqQklZclZJSlgrM0p2NEEvTTAyVXJ3SlNBUDJh?=
 =?utf-8?B?OTREMXNZOFJrLy93RjhCYmJUNjRJMndkVWszeUx5Tnc4L3FzV3Z6RHdUdmxS?=
 =?utf-8?B?blJpUTZYK2pITG14eVlPaStDK080bWh5b0l0bm1KRHZlRndsUEZ2b3pNV1Bq?=
 =?utf-8?B?cWNUUHozMk5razhoMytRUi92WTdjU3N1Y1kwTTY4aHlQa2M3cktLVlZTNkRr?=
 =?utf-8?B?SkJQRWdvWlRMM1FmSjBJMjdPVVJSOGtJNzU2WmQxQ2trd29lWWJ2ZzZXSm5U?=
 =?utf-8?B?aDJiYVZWSk9oSXJaemZhMERydG9VQjE1R3UrZHVuQTRpNHZkdFM2RVlmWlpX?=
 =?utf-8?B?NEZRTzQ1Sm1TeXljNHhFbEpwTmlXRlNBUGYvcUc4THVHc1BITldGRDhJSmZZ?=
 =?utf-8?B?TVY4YTNCZUtIbmJlUzVDbWxaTGRWOFJaT202NGxublBvOGpXVG5SdjZxeHo2?=
 =?utf-8?B?dTJ5cXdzRkVDRmpqanowQjAxOUNETjJUL05kcXRvVkRYRkMwNjcrT2oraXQ3?=
 =?utf-8?B?ZzFaOFJTeUEvVk9qdDNXSnd1bnRNNStyeFFDUWdRL291RitKYkpaNVdzajlN?=
 =?utf-8?B?bmdEemt5cDNaNWtrd0s5S1VSbHprak4rdEVIUDUzTjIvY3QwdkkxTElzMlZp?=
 =?utf-8?B?bU5XdjZvblgwaFpQL2Flc3RETGpVVkZNOCtUblF3VkMzbGk2UE1BZk5OTExQ?=
 =?utf-8?B?Y3J1S3NVUTYrYkxYVjVaS0RySFlJbzRsT1EzQ3RqMGZJRnAwcG8zYlY4ekw0?=
 =?utf-8?B?eXVBNWtjK1JTeGNFOWM5SXpTMnZ4TTlTbHZ0SlhrYTAwbVVEWFJCUUxtNWxw?=
 =?utf-8?B?eURCb0lnQUFjN2Ivd05WTWJPMVcyUDY3Nnc5c0I5T0ZIb0hSSkt1N1VNMTRy?=
 =?utf-8?B?RXRZL3hHajQrVDRwVEJIWnJaVU1BYTMxbVIvM0hkdzlTWTltNldNWFhKUVp2?=
 =?utf-8?B?K1kvWVkwUjd6bEYrZFZveUtPMTBuQnNVVGR5UlNIK2dYVHVOenpSQUhZL2o2?=
 =?utf-8?B?ZnZ0TUI1L1ZFc3kzQ0EzK3lxK2hMYk8xTGdJMC9uQUZlb0VocXNBWmZ6OVhv?=
 =?utf-8?B?ZzhFT0hVcExqUVBTbW1sUFN2TVpGWERKWkppVGZpdGIrWGliaStsb1FaUmlm?=
 =?utf-8?B?c3NPY05Td0dlU3k0RXEwN0NGVFVsMUhWeUdKVVRzQWpjZ2RYWDBYNGpMbHhU?=
 =?utf-8?B?ejZYbW9aR3hXUTE1ODQwUzdZZXd3R1BkN3dVYTUvcWJQS1JycTNlc29ZUlRn?=
 =?utf-8?B?ekxla25ld3pUY3lFV3ZsV2QvSytJOHFMYk9Ya3NMWjhTZlF0bW1NYkpFTG1s?=
 =?utf-8?B?aGNIVE9qTnl0ekxrT09KNzhNc0NUbllkQ3ZGUUsvVmgyZHU1QUl0U0xkZEVU?=
 =?utf-8?Q?aC8MZQ6JX5cBxkvpMCeQhYm7S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0fba06-bd81-4542-c3ba-08dc46eb4891
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 01:32:32.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWmMRhTBxXsql443qsC4ZzOeSUtBXl5/1x76kLr6IR2++spc55ZW78vOZHyeiTXH6e9y5dSogJmUqqcy3LXa1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

On Sun, Mar 17, 2024 at 08:00:26PM +0800, Zhang, Rui wrote:
> On Fri, 2024-03-15 at 10:58 -0700, Dave Hansen wrote:
> > On 3/15/24 04:26, Feng Tang wrote:
> > > Thomas' recent patchset of refactoring x86 topology code introduces
> > > topology_max_package(), 
> 
> s/topology_max_package/topology_max_packages
> 
> And topology_max_packages() is not new. The patch set actually
> improves/fixes it.

Aha, you are right. Will fix the typo.

Thanks,
Feng

> 
> > 
> > I also did a big *gulp* when I saw this:
> > 
> >         #define topology_max_packages() (__max_logical_packages)
> > 
> > and:
> > 
> > >         /*
> > >          * Today neither Intel nor AMD support heterogeneous
> > > systems so
> > >          * extrapolate the boot cpu's data to all packages.
> > >          */
> > >         ncpus = cpu_data(0).booted_cores *
> > > topology_max_smt_threads();
> > >         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
> > 
> > Because Intel obviously has heterogeneous systems today.
> > 
> Dave, I think you were checking the old code.
> Please refer to commit 090610ba704a ("x86/cpu/topology: Use topology
> bitmaps for sizing"), which is just merged in this merge window.
> 
> thanks,
> rui

