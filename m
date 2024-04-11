Return-Path: <linux-kernel+bounces-141417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD318A1E05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BEE1F26A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8D12D746;
	Thu, 11 Apr 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrGcEGqd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887812C524
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857214; cv=fail; b=ltjUmO+lb6HGvVD5j5VjeYVOlDnrKXDXyCkZzd5plLeQayESaH82EHJIIABBBow36QSf3WrP1rGXZlvLi6wmp2nnZFDTZ8s+d5cOkbUQ9ZciI8QDDGolVQUv/Qj+xbDmq9LRQsRmne4uR+tl2ByMHtdkssn6dNJCJPWeeVwG9Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857214; c=relaxed/simple;
	bh=gHPmj6lSb3wGxv7rzVR+qeHiLLkb+yTy+N8+4hwBjHg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/u01ef1ET1wWShE9Y2tPhtlLJZa4+OZMV0sAvkgqdkqpuaqlW9WhdFk8nPRlAJuZ1y7XWBgyP0AYSgXn+kpfyONnkUbWlnoKDLZRup1nT6BATA7AyUhP0qouMAm6YC0Ng6bFnpVVL5IEfoxVDxFEbXw6yshR4e/5IXKZb4r+j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrGcEGqd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857213; x=1744393213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gHPmj6lSb3wGxv7rzVR+qeHiLLkb+yTy+N8+4hwBjHg=;
  b=MrGcEGqd0+WeU16QP8wsyK+rWZ3PgWkwwpCB8ErF4uun5VrBCroZzaHf
   jwsjyHgXzEvvB3BQ9082fV1NhDyaq+2yyIQJt6cD3hNpunhNsIWH6X7T5
   gw+Q4kvxgq61zC+TkLVDc3wt+QaI4hs18R0jz1hxGIe1sSMc9pCCknKYQ
   Ito0lCjmmtrr1go1yg+E+yLZyXDMphKWXz1cAwx04duJjJqOQLdPENigB
   XBOuCjlmRgkdEnSY4Vnh2BIf4BbVQ5XlmDO2AllwrJ2Uco1+xI1ebqofe
   r2Wro+IKoEcfwCWFMVVu0GhcgNOf2XJ4M770yJGKG4l0ykeyKMBSU+Dxg
   w==;
X-CSE-ConnectionGUID: gPgI07QTQAOm4htR29hYqw==
X-CSE-MsgGUID: mBBAm9nnQ62gZK+mBNxcdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8204550"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8204550"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:40:12 -0700
X-CSE-ConnectionGUID: K6+jknW5Sz6zKog9sxBiAQ==
X-CSE-MsgGUID: kOfyycprRECeBcNCQp6nhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21455433"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:40:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:40:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:40:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:40:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpkNkWLuRu7LrJAM9HYSgQM4zHkkFwe41s48WR7pTNDyBq8eNf2tWpcWcERX3puC/Wm2FXbFQvLJ8fAi+MCnLy5/GMxoU5kTYYNxK6hp4t1Txo/+B4QnmedoWr24VK6otsXAJYhA/6GyPVDzi8686K4tIrAfpgM6SLdv6zLK8gxfldg9UUmupPnze+U0XSnzEHz7lf0WgNztyjEQ383n6fl0SJq2bXwwnSSOcD5Gia+Xyp8uObjj1KXLWg7sN8x0pSmF7xvsXUOisc46z63I0xfRnHWg8EyI1MhNmOORap09q089m7rpfK22525yCL/YTkf2WCd6y+U7OSQXoNOv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiwooZw8EP89sg8X6Ui92HXUQFFT5t+wUkuvXniD0A8=;
 b=Gjq5hi3spj8nKIMPQMC/ffMyJzB7jCE9a+RYuRlaFomC6iD58+fl9ewtlUV7ONCZ8BJJpg92eZYWt9lopvriU6xeLBxFVmVQLVK2SHyzGwDWKrP+gpemEyc2bVs9Q7WvhMA2ZppiwZYrt1jeiEyzhas00Y8Th2XtH+Yl4M/G9C3hhrwpGiOBQ9uepSovfV0icmW22zX/iQg/8wGo08wk9vTN7EAR4ZY6MhL8oMo8nhP5GKzAf0Z3A+Xq6XI42H2U025oGg4RaViR9Dy9Lhr+iAQB3F+e9tJyLW8RLlamnQUyBzVqRJYdh6Q4qaqmN/e6cFqHYT10tuiKAQeIMWBi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:40:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:40:06 +0000
Message-ID: <172f4615-8943-448c-ac68-152d5bcffa76@intel.com>
Date: Thu, 11 Apr 2024 10:40:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/31] x86/resctrl: Allow an architecture to disable
 pseudo lock
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-21-james.morse@arm.com>
 <6d563361-87c0-474d-812c-b33e79eacf3a@intel.com>
 <Zhfw/uEZaYk9492j@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhfw/uEZaYk9492j@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: ad85b47f-a090-41fa-dbe5-08dc5a4e6cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHCaB6kY/xU1zJSm0vPtjdWkcIcHCgQgssegB+MO9/thoC1gRWqoCmsFpkvntUoz53KrN6rmdHJc9aaxLLdJ58b0bAUUkTrblAX4IgQQimxKkuRI+KPa95hjEiImMJ3s3P8tFmhGGUvRBWxaD422s0SUwiNj0xbc5MfIG32P8GwjUgVOZXFbhi3mhodFwOmFSFmEQEUSax0oaNL7myoEw6h6+a9WOXUBuwE5a+688mnNrUVI633WZprjJ53J4w5o8ZjRKQ5aN1igbzuWeIVmsIWp0oSO8NcvnZR7BLZJ5FtAYT+FwZo+CqGapKPdBNKI2+TSOo61WfIXq6aBACGkqoYHyLYAek8xzG4jq/uV7e8qU27kJLMBg0lB+1buV3PBBFW3F9PcuLMqe/VHWZfyY1RSbXT4Klo6ZF6QSI3oUCn6gUQlVi8WNQXi3PLyAbROfcH1qU+h39eLzbysJD+X902xIdLVQGtmUq9Z74rDuH4ESA468pwKxvEoOsblIyAQ2gDlBeg4WOjAhLxQgQytz7dNwY6Glc3+FrzlD/qhvINRM9B9mSvi1QGts59Qs+kbdJkk57fDvQ2j6+O4LwmXgeuhcaQJrj35EfH2R0Ag2ilHXkVvRh0g7RVuD3IrCrK6dfhGnJmZ2/rZe5QuanowOLMFG6SWHSQOuvJEpQ3ALG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZENJMEhSalk4SGRQTm1lTFJVcnd5c3RqOEZXR0NUbzFjZURTWnFaVVNoZUQ0?=
 =?utf-8?B?LzFySGpiSllrR1g1TG54cisyZTRUWTNUaWhIemY1cGtiWU9qb3JvSDUzdzFQ?=
 =?utf-8?B?L1NUNUxjOFE3dnNFM2d5aVNnbExObkdSWVJNVWtrcy9nVUM5Q1F5RGhvN2VI?=
 =?utf-8?B?b1k2cDNRWnNOZVVGZkFMU0NPWHluVHJSYnhNM1l2WEYzVVJ0MnhVeCt1ZGI5?=
 =?utf-8?B?SXFvMjFaaFhub2NsSnpON2lLOE1xTi9TNVd6THJVVktJWTVkYkQ1eDRud0o2?=
 =?utf-8?B?cloxUFZoQTR5NVNmYUp3NGpKbXdva2IySHhxYlp1YWZ6YTExVUlMaW16UmdJ?=
 =?utf-8?B?SjR1eVF2VmJQMHBmWW9kV1VZTWMxTzRmVUVjdnZZcFZZbVp3UCtpUFh1Z0ZF?=
 =?utf-8?B?Z0N4L0tuaWNwaU91WHI0TTJBOHZ1K3ppQXpNSEpiK3RYZU5peTkzRnQwMnd1?=
 =?utf-8?B?VzNqQ1l2RDRacXYzWmNGSDFmTFI5Z1VnY2VKbERhZjEvZERkdEhRQktld25E?=
 =?utf-8?B?OG1acmFqV3lkb1k1Q2thKzY0WVExVFFZa3k4NklwV2gvcnU1ak5TUWtFVWMy?=
 =?utf-8?B?N1lrRGFhL3BRMklwRFJqVElwTi9FZXpuTTBwQmNpcWxSY2dMUGZodlZIN2Vp?=
 =?utf-8?B?KzJhdUc0RE83cURyS2I3Y3piRUpIZmpTcTNhWTM3ZFFsTDRYcE9qeVRyQWds?=
 =?utf-8?B?UjdtRkdWb25JVml1UVhuRmtIeUxwVVcvQlF0LzhGZVhhNmh0WEd3YlVlaVQx?=
 =?utf-8?B?RjJLa3FyejNPcGRnQUFNRWx0UmtQZkpXaGZpT3MycFpFT0xRVWhMQ0RhSndn?=
 =?utf-8?B?eG12ZHdsS29TYXErTjM3RC9MYUo1Nk1sT0RCRTZTMnZzaURLb2x0VXhYd3Jr?=
 =?utf-8?B?ei9WUUJGS3VacXlnVTRZRCtGa2ZsWlRSa2JTMjYwTHM0VGxWUlFLQTArdjh0?=
 =?utf-8?B?Y3lWU014eDU5Y0Noc1FZWXhFN1lRVDRzdFpTcnhneGpZMndYd3VxOHFRZmJx?=
 =?utf-8?B?VzZnczk3VnljTU01ZTY3QVpFTjJDdmVtOHp6VlliT1NkeWE4cFVVTm4xT3Bl?=
 =?utf-8?B?dHdSR3NyWXA1ejAxS05RVTYwODlYRzhNUTBBUnZQcG9panpMY0dPMXc3UUY3?=
 =?utf-8?B?VFRMNnpnUTUyM0NCRHJNL0F6TU0wckM5VDJJbHNERFVQYzZaTlVJOW9scUFr?=
 =?utf-8?B?RGFXSUJrOFBUY0I4T3U5VzczbjZxemZOQTh5NC9ORDE4UVMyVVlqd0x3S3BP?=
 =?utf-8?B?MWE4dmF2SjF5WUxjbXNOMjlFT3VoSUdaTk1JcXBmNWRDYU9sZGUwQm03YjRU?=
 =?utf-8?B?U2ZtTGRoMHpGcEJRWVo4eDdaSi9FVU51M21heHA4UGdvcjloSnJxVFV6MjZp?=
 =?utf-8?B?Y21hUFNpZTNzWnlYSzRzNkxXS3d2MjU3QXR2a3JjNGQxWEpsdzhIdWRpZFVi?=
 =?utf-8?B?MVd0SGFzUUxjRmdSUXFCWWZ4QTR4aFRpdFgzK213S1EvcXBvWm5aZDBRc1Fa?=
 =?utf-8?B?Nk9WUHUyNHZpbHdFL21oK3hTbXY5LzNBcjlJYkd4ajRhUTZQcXV0T1lOOERQ?=
 =?utf-8?B?WDlnalVVTFRmK2Y3WUpaUUZLNW1ORFFOY2hqYkZxQ0N5dGFpZEdUR1dla3pj?=
 =?utf-8?B?SDZLM1BWNUFvWTJodTlLdXE5ZjltM2FodEpnTWdjSG9Ia0c0bFRjZVA0QlU1?=
 =?utf-8?B?NVloSFpSVzNJTFVPT0RYSmNHRktORmZDK0U5TFV2dXZTOURkUkVzYjQwOVF2?=
 =?utf-8?B?YXFKNW9lcWZLNytVbWYrc0I4WTFxQWhrVk80TnJtc1c1dUVOZmdEeEloQkhF?=
 =?utf-8?B?akZTY29OTE02RFdVVVRBdHhQcXRvV2dUbEU2c1Y4cjh6UGNaR2E5N0hNNXRh?=
 =?utf-8?B?bGNqNllnZlprazFuR3lGOVVLVU85clVjSWtkMUI3VTJTRjlIRmZ3ODZEWTlM?=
 =?utf-8?B?UDhldlBMRVJtdHlHTXhlZ3VsVTk1Q2c1b1dNYmc3Zko0c0RkaGhyZmpaUUVN?=
 =?utf-8?B?blp4OVdIcC9DclN1TzN1eUk2eEgzSExDNjdqVXNLeVFKVUZBQXdWMjNqb1lt?=
 =?utf-8?B?UEN2TjlINXBtQlRTWnNyZ2ZGaUxxazk4Sm9HTGJ2SjEzbXZZcm53UzhzQkxo?=
 =?utf-8?B?L01yQmNEVEtOZVNoVWRaUUZMZFdHN0RQSFpGY2U2czl0ZW0vWW5VQm5VeHBT?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad85b47f-a090-41fa-dbe5-08dc5a4e6cbe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:40:05.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnWRoo+ZIFFe6mwlFpuGDNgLtZOfXb9uGkmIXmSXYBSRNaSEPKPwyqErb/DUEVBKGV5vhd75vLwYi4+1s5TQZxa4s967YH7/SkBcV/z3ZVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:17 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:24:12PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> Pseudo-lock relies on knowledge of the micro-architecture to disable
>>> prefetchers etc.
>>>
>>> On arm64 these controls are typically secure only, meaning linux can't
>>> access them. Arm's cache-lockdown feature works in a very different
>>> way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.
>>>
>>> Add a Kconfig symbol that can be selected by the architecture. This
>>> enables or disables building of the psuedo_lock.c file, and replaces
>>
>> pseudo_lock.c
> 
> Noted.
> 
>>> the functions with stubs. An additional IS_ENABLED() check is needed
>>> in rdtgroup_mode_write() so that attempting to enable pseudo-lock
>>> reports an "Unknown or unsupported mode" to user-space.
>>>
>>
>> I am missing something here. It is not obvious to me why the IS_ENABLED()
>> check is needed. Wouldn't rdtgroup_locksetup_enter()
>> return -EOPNOTSUPP if CONFIG_RESCTRL_FS_PSEUDO_LOCK is not enabled?
>>
>> Reinette
>>
> 
> Hmm, if I've understood all this correctly, then it looks like the
> existing code in rdtgroup_mode_write() relies on the dispatched
> function (rdtgroup_locksetup_enter() etc.) to do an appropriate
> rdt_last_cmd_puts() on failure.  If no function is called at all and
> the requested mode change is not a no-op or otherwise trivially
> successful, then it looks like we're supposed to fall into the else
> clause.
> 
> I'd guess James' intent here was to use the fallback else {} to write
> a suitable status string, while keeping the stub functions as trivial
> as possible.
> 
> Just taking the IS_ENABLED() away would result in error return from the
> write(), but no suitable last_cmd_status string.
> 
> For consistency with the existing x86 implementation, I wonder whether
> we should put a suitable rdt_last_cmd_puts() in the stub for
> rdtgroup_locksetup_enter().
> 
> There might be other ways to refactor or simplify this, though.
> 
> Thoughts?

Thank you for digging into this. It was not obvious to me that
the changelog referred to the last_cmd_status string. I do
not think this warrants making the stubs more complicated.

Reinette

