Return-Path: <linux-kernel+bounces-60187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66EA85011E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409961F26CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B31FD7;
	Sat, 10 Feb 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRkQL4W6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0F111E;
	Sat, 10 Feb 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524955; cv=fail; b=iP0GxqI9zwIOnR5XB/cngrBgOEbVriAbcMTk/SjA0Adx2jrknq0jO/n2WpQj8meKkvm2PfOFPQN1+7bvfWAF8tAYCuh2m/zRcfcKA1u5xXFRLLlep4hkuIqBBLclDzA/Qh0aPNKGeGYy5FRc4kzy3uzDxqrEiDIwI+c26HrFHMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524955; c=relaxed/simple;
	bh=AFL1DtFHH+9mGJ4wDi7Ii0BVhTd1IhlP4vudXRHbLs0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C91B4UwrEHMGk9d3GQKczy728FkPuqxQhZXBatmtlgw7MpoAPvCymnP4asToZX/3tvHaY8PRfnQu5B3m8WurWAJUK9mlkMSfL2U/GoWbA9RpIrQ8+SrPGgLb1DCtWg3wpmM9OvIgroT7gGispNM+/crg2UWBUC6LfnPoXyAfjS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRkQL4W6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707524953; x=1739060953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AFL1DtFHH+9mGJ4wDi7Ii0BVhTd1IhlP4vudXRHbLs0=;
  b=ZRkQL4W6XLMqOdlMJ1GckMT6yMoCBCzZ2kBMLDrtSNVehk9YWvT1fF0S
   PWQXdJ2IfG0kNiA0i1oUKG+QL9vdm6t3RRhOt6heG2Sz8wLHtiBibMj+8
   kb5MoHSRFKnVbB/gpzktHtsEjIWBZpFd9e9lFDgdVRsIkbps2V6AmlU+X
   dmbpUGYJ8L4kIRwoPVo7nhnGdmh33Vq6bSlc0kcL6X/OdwTy6ex4Z78EU
   80qpTQkWJfx73QU4OrZKjdiUysOXhtNqkedvbpGImyaXeca4UiMTMd3Yo
   7nAL4LXlwvI8g0kKe4iAHkXXdjjm3MD8TWN4okexI6i2l6HSqu3hVIvBN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1406504"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1406504"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 16:29:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2105617"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 16:29:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:29:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:29:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 16:29:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 16:29:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nso6QRGiOSKIXh/mvHn9Fdsy1moXGARziBLBpKqAnNtwMI/qAxVihMq7OAp7EqoKJBh5DtYO4nVXeEDDk9BCheqO84uzLec4ZJBVg3XIU0GwQz7HqSp41RTwJZ4mXS3SBqJAxCT2B/ikc5xZt+NcLWsoAAokSEI6tRNH4xap+KYvVXQpxpalN235P5uLhleJDsBCvFVU+nBSCE7Rh5AlF4bTIyF3/7LO5y7dovvUuVQsiCV4pxIIQOhSml8kj4RkWMBAKDbZY1yIMM37IbOPES/8ux88g+8656ZuIInVBIz/XDNQRKbwI5jC5kHe7zAua9PuawXAXIUWTcoc/zHnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alJ9pD7j0TUQYx1WCTJASxm7rlFAY9kMW0zYbP9Ajic=;
 b=dRWSCyqRyUnwdDUaaf282BHQ+DDiTzjFM7DgndC9t0MH2H2OguD8QbV8El0JMMzmFs+sCsHA+TftPR5N5Q0X68WJvPY5abQ1O/jvcaRLYRFN+yoN8NImxazTMgYNhaQmAe92mK9QbwAMjiq1r/4pu+hIC3YtDkvIJ+UuWSOQpujgC/p3k+Jft+tzfbwDXEPrMe/hMB5dA1sa2KCCuyEPKPY7VKKR5V970KRUWVDrOHoLyzOORrXVFxAmuMVWNEFnxxC0GrZ7EO5Ce/FYz9ul9slC2afPm4xOWyTW0X33FdzZl9tlE+3hWox3yIHTDm8TFPDYtLRUWh+TpMv8SRQqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Sat, 10 Feb
 2024 00:29:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Sat, 10 Feb 2024
 00:29:02 +0000
Message-ID: <70a433e1-eed1-4056-89de-92c614b45a0f@intel.com>
Date: Fri, 9 Feb 2024 16:28:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
 <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
 <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
 <SJ1PR11MB6083D539920A888F93902954FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <59944211-d34a-4ba3-a1de-095822c0b3f0@intel.com>
 <SJ1PR11MB60834D4876A8147286FB2284FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60834D4876A8147286FB2284FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc0d20f-975c-4de7-1d63-08dc29cf47ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Fj2I0VwC1BKkiONlMV2Vf0ZvKQF56ncY2KNcC1KD8CN3y1c1hRUQVtnhPdHCIpDLe4CBgQmWF+Qd5qPWHe6rvQdScsRYixEpzEL0og/Rhz9kA98dDn8BtpUeSLx9Qn6hdkV35EkyDp7D3uQ2/477Kom50aihYOSH6GIfWCtkMcddy8DhHyh2HObcreE6Av5WHkt9vM3DpUh3PYWh8PmaMwerco21AW1xYRXjhJeJsRiuh2F/sPy8ERVXg++8vIBwF4QrCATqSjUWDPpliCW5WeLXBFqIuX7mIKfwn5Q7uVrn4DoYzuzIcGMd+ib/PHVwDtS2RuMhsh3sQB3vpVQrcDQg+yu/xB4fs2PZV8qGqLFn14tWbD3H1rTUVS6tcLS+XcQom1nEWwWVDeVZ+KlfK/8KopEQhH4AtqaJAn4btH2OViB7BrIELymeXksrG3ajPkIoEfalSFYnGsaMsBFcw0cDRUu1MAYxBl4b9FuF2Ym/4dLBp0JqiT+eIWW7rdft3Bbrzl38PVJ0ZzUbGMqdIOZ6g4GHsLnpGZ0wtq82D29OaGyx/vFBEjiWSsinEbg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(6666004)(6506007)(53546011)(478600001)(6486002)(7416002)(5660300002)(66946007)(26005)(44832011)(2616005)(36756003)(110136005)(2906002)(66556008)(66476007)(6512007)(38100700002)(86362001)(54906003)(8936002)(316002)(8676002)(4326008)(82960400001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V25XejFHREd6VWVNV3hEaEtTZ3NVaDhLK29kb0xuNWVwdDk3ZlBweGdJUEZo?=
 =?utf-8?B?dUpzdW9IcHE1Rm0vTytvZGZUc1lXN0VDZVNGeEZRaWNMVEFlVXV2NW1sTkp2?=
 =?utf-8?B?blNwUzg0WnNPeldJU1RwaEludm9YcHAvclAwb3ZvT2hXYnB0bnJpWkpjaW9U?=
 =?utf-8?B?ejNaaWErZmtWZURXZlo1LzRXRWJWZnhDZktrK0x1OWxWOFhJL3g1US9ZVU1T?=
 =?utf-8?B?N2hZRldvYkdzd0x1akxpbTgrbDA5OGRoRS9rT3V1QS9OaTZGelJ3aWJQZUxS?=
 =?utf-8?B?Njl6NStVczNRWndKUmxaQ3lyOHVrcVhkV2YvMWRiTHJ3b2tBb2ZkTzlMYzBK?=
 =?utf-8?B?M1g1amVVdThVTnQrN1d6RHQxUHl6c2Q3QWhzbkxMYnRCY0pIWjJ4WkpObHQ0?=
 =?utf-8?B?WU1Md0ViU2lqdWJnak4wQlpCSDBlLzdCSkh4cFpaTmlVOUhQU2U4WEZURGc1?=
 =?utf-8?B?MFNwbzZlZU1wYVF4SnNsUVdWUTh4YkdEdmdmTmtobUZGcDNQV040R1BBK2J6?=
 =?utf-8?B?WitXVFBmV25pSUU3b2xZeXJCMUcvWllSem5KZDd6V1oxY0U1SFIreEluSW44?=
 =?utf-8?B?eG1ta250cVN0N2dmTGJWNmJwNDVWT1NqUSs2R0VkejFocTIxS2xiSUdhSmkr?=
 =?utf-8?B?MFRXb3BDNW9WYjJoVDdONmIvVTZKN1JsZU9YWSsxNmxzNHNPSGtlSlVLV0Fi?=
 =?utf-8?B?Q2lCcVJ0aEF6cmFKcmJoNGZuSVJJaEVXTnFvZ0NUNUc4RlloTDFmdGhvYWJk?=
 =?utf-8?B?R1Job1BGbXVwdU5nOTFJMTRxbDYrL0E4cHVjd0pPekx5U2tDZVZvMVNRSjRJ?=
 =?utf-8?B?b3oralVuZWhLMTJkQW96NkRDT0lnRW81Mjg5dHJYYUxCdUtjdFN5NzZvZ2hl?=
 =?utf-8?B?NnZiaVhrMnJEZjhub3FIUm1rSDBrWE15cUw0WlRmc3I5b05nSjh3eDdSY2N3?=
 =?utf-8?B?YXdlVTFjVzBIdVNQWGFGWHVRVXFWRnRvbXhDMmQxcmVTazB5TXpCU1pSSmt5?=
 =?utf-8?B?QWZRTnppMHBrMVF5MVVkb1oyVmhxQ0pUaG91RHdZR3JyL2t4dHY1bXlFckFX?=
 =?utf-8?B?SXRyUlloRjgvZU5TU0NkNURZQ2pHNE8rNUVoc0Zybmc3bkJZYS9hRkExQ2Zx?=
 =?utf-8?B?Y1JWVnVEdlplZGxTZFJEL1ExQ29MeSt1aVRleC9IODZyY3JYSzd4Sml0QTMr?=
 =?utf-8?B?eW1BQW9kWHM0WVg1US9GTG4waGNHYnZzbjU2SXVDYkUxdlF4dlk2TFRSWjZo?=
 =?utf-8?B?RHN1MlVQTjV1bEw5K09HNDVLSlhqT0xZV2UzMFpsMnJNc2NybmJPN1AzTDY2?=
 =?utf-8?B?dmpvV05XWUFSWDhMZDRHRElYR2hrTk94MWJVQU9TaVoyeVFIOTJTQTJLYjRX?=
 =?utf-8?B?UEd1d1BPM2FLNEVIYi9ORlRDbnBrdE9UaWRSa3N0NXRmQzhtVCtWc0N3aVVU?=
 =?utf-8?B?UXBLeTQ3clNtbkFqMmhzRnpVNklqKzFFTDhJYVYyMmRhOXBWazhPd2lBS0pq?=
 =?utf-8?B?ZmRKWmVFTGF2U2xGTHpRdjZwYXMwWkg0YTUva2dPQVhEc2FCQkp6dzVMZnh4?=
 =?utf-8?B?QU9wTFh5UFRqZlZ5NmJnVlFWMmFUNTRNbnhHWUxHYTJlNUc2N1YvL0IxNnBL?=
 =?utf-8?B?N3Q2V0J4UUZUSFowTmx5RHNiZjM0eUJYYlFCdE4yUGhkYTlkamJGYzgvOUxR?=
 =?utf-8?B?TGxpVFVsWmZPSEZKYXIvNW91SGxCd1RFN1ZleUpEQUdpWnZzaFlOZTJPZ2tl?=
 =?utf-8?B?cVBlMVBUMkJZRmcwOXk2R3QyU3oxWlhjWGV6RGY5eDJIWVZjbCtTUnRkVitD?=
 =?utf-8?B?VGp4S29qWlFveTM3WXhvaU9ZUTBIZ2Q1dGlqUkFoT0lYMjE4WXpTeHViblhV?=
 =?utf-8?B?Ly9LMkUySThHY1RNMGFWWHhSdG0xZHlOemxyWDNXUlprOHNMcEl3OFZSSExk?=
 =?utf-8?B?WExTS1ZoQjlobForQnR4SjVEM21UQmVZMWZTNzVLTmFrVk5LVUQ2bnJSaWxS?=
 =?utf-8?B?dHdOWkFIK0tCTkpqcnZRZzZNTVltbnpNMzFaVE5PTmphWmxBaDB1WlR2R29K?=
 =?utf-8?B?UkxZWlZhSCtTeWFWTTRmMDJVcytqS1FqNWx6ZUhhTUVVbENhQTZ3RkQvNU43?=
 =?utf-8?B?QnBRMVRWQUt5NFFPZnJjdmtsNjMzYks4RWNQTTZoVlNDazhvNGV2cU4xUjFa?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc0d20f-975c-4de7-1d63-08dc29cf47ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:29:02.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS1UI47pXQzVDyIPyglKK4LQLJvqNfGQT4m95KNPwBK+fDruQ6CnzHG8KhyrSpfKHBU8RSN0OTKlDKmlkT4QroGiiVryryPCDULm+e8LrdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com

Hi Tony,

On 2/9/2024 3:44 PM, Luck, Tony wrote:
>> I actually had specific points that this response also ignores.
>> Let me repeat and highlight the same points:
>>
>> 1) You claim that this series "removes the need for separate domain
>>    lists" ... but then this series does just that (create a separate
>>    domain list), but in an obfuscated way (duplicate the resource to
>>    have the monitoring domain list in there).
> 
> That was poorly worded on my part. I should have said "removes the
> need for separate domain lists within a single rdt_resource".
> 
> Adding an extra domain list to a resource may be the start of a slippery
> slope. What if there is some additional "L3"-like resctrl operation that
> acts at the socket level (Intel has made products with multiple L3
> instances per socket before). Would you be OK add a third domain
> list to every struct rdt_resource to handle this? Or would it be simpler
> to just add a new rdt_resource structure with socket scoped domains?

This should not be about what is simplest to patch into current resctrl.

There is no need to support a new domain list for a new scope. The domain
lists support the functionality: control or monitoring. If control has
socket scope the existing implementation supports that.
If there is another operation supported by a resource apart from 
control or monitoring then we can consider how to support it when
we know what it is. That would also be a great point to decide if
the same data structure should just grow to support an operation that
not all resources may support. That may depend on the amount of data
needed to support this hypothetical operation.

> 
>> 2) You claim this series "reduces amount of code churn", but this is
>>    because this series keeps using the same original data structures
>>    for separate monitoring and control usages. The previous series made
>>    an effort to separate the structures for the different usages
>>    but this series does not. What makes it ok in this series to
>>    use the same data structures for different usages?
> 
> Legacy resctrl has been using the same rdt_domain structure for both
> usages since the dawn of time. So it has been OK up until now.

This is not the same.

Legacy resctrl uses the same data structure in the same list for both control
and monitoring usages so it is fine to have both monitoring and control data
in the data structure.

What you are doing in both solutions is to place the same data structure
in separate lists for control and monitoring usages. In the one list only the
control data is used, on the other only the monitoring data is used.

>> Additionally:
>>
>> Regarding "Vast amounts of that just added "_mon" or "_ctrl" to structure
>> or variable names." ... that is because the structures are actually split,
>> no? It is not just renaming for unnecessary churn.
> 
> Perhaps not "unnecessary" churn. But certainly a lot of code change for
> what I perceive as very little real gain. 

ok. There may be little gain wrt saving space. One complication with
this single data structure is that its content may only be decided based
on which list it is part of. It should be obvious to developers when
which members are valid. Perhaps this can be addressed with clear
documentation of the data structures.

> 
>> What is the benefit of keeping the data structures to be shared
>> between monitor and control usages?
> 
> Benefit is no code changes. Cost is continuing to waste memory with
> structures that are slightly bigger than they need to be.
> 
>> If there is a benefit to keeping these data structures, why not just
>> address this aspect in previous solution?
> 
> The previous solution evolved to splitting these structures. But this
> happened incrementally (remember that at an early stage the monitor
> structures all got the "_mon" addition to their names, but the control
> structures kept the original names). Only when I got to the end of this
> process did I look at the magnitude of the change.

Not answering my question. 

Reinette

