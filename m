Return-Path: <linux-kernel+bounces-73498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32E85C384
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D857F1C20F91
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF29779F8;
	Tue, 20 Feb 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0beGO1a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73776C99
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453138; cv=fail; b=QcNtLgrLyJsavoBeKa7jRRyV4mfta79Mh0tBnw5eLLyVeBwRUxrhcH+b9Rix0GkzbcW1nMPrsOnXUXUoZ4XoTani37wmABuFNPgzoc+xI4qEjaahso+mL5+ULPYL37u6O6yh3U/lzd9mcH0uDY76BQ1aCEZ4epw+v7GAgIFGzMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453138; c=relaxed/simple;
	bh=k9qXOQgJBXBmBaukfobYnT4UyIXf87nlJC1zSJ+dAE4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=alV6PQ7Dp6FN/7PAmvmLuZl4d70rWj4FotFPKdD7QRk6gdIFEcxLz6P5VCozUL6TWBMKQ+FYXoe3MA7qhV3H3J+M2cWeXs8A83hoN8b/iJHdU9nD1TvociPIxR6zlb21lpKQo6ri7fD2BMsLv4gtD0bNLYlTbVYRQClpUmBILvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0beGO1a; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708453136; x=1739989136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9qXOQgJBXBmBaukfobYnT4UyIXf87nlJC1zSJ+dAE4=;
  b=C0beGO1aUamgDnzIhhoUQHE+I6/3nQaNlD+Vwr8Z4RROK3JrZx+NIICL
   aS2pLdlL/gmY/HD+4MMBEPNJRKJN8z0dymzrP59/ZpuNOt269LHwKP2t5
   K28ebTs+ABUvfIxJG/rCWeF+4GfAahuOHumGrLEaGRAdn7YxP2merMc46
   Mb7ZQNbU7oGd1hHI6FSO0aJF4pWjkv4W6I9Ke8AyzzgEe4XL/rnmjjl/+
   mdFst1Eb1/NZE4HuCKaW4ZVr2/tDSoYSx/Rafg9DqmzGWTLf7ILDZSHlm
   e8XkQkvmnyZ0DN+CZjXbeWuUIurEAjQJ5CFLy0O6DNzK12UdAYJgaY+Ot
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2484713"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2484713"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 10:18:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5148878"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 10:18:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 10:18:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 10:18:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 10:18:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 10:18:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcvVPknNg9R/rizMcMyjToQ3u7R9ARGFzx2CKr6Yb+BLa3BEKGKr7w6HaFKG+rh3Q1fs4o5WIb5uR+nqb3nbVypZWBv3j1Od7p3d+VXJaPx4OIcgGdxmVJbF1qhObZsMpFhGtm3iZ7NfO6EAxcuSOQ9WDwMcRX4NVRvYqoYwmiv/GRSaZugtxP7CxzOEfRsvojimp9oLv3Br71M4PlUlJy+QJ23cGf74c7mAtEzsXZdyhXyWW/Jg+BXP4apMSQtf/xOm5Qp8v4r6zXllTu4zCxX/Jtz3AfyDnDmznNlqU08vCYIW3YWAg1q5RBoQDdE5w2YWDAlFIRREyFXQw7srkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ThmLpmXqi8azl5Lli3R/hzLX7mDTMT++OhZg4gZ1AM=;
 b=aAOwmgHS9Ag0ToPOA/ahp6PRv5hdmUSLQ9jYGckFiu5qHxq99ppfIovo7uI7IfHEh0ZhwGp7tgn9yyW8hVGXeKkm1G0iwwN7KSeBWwj5B2JiOvMeT/5/7mRQ1ni6CS0l+ZCaG3/Bs8SwRjWgKkjF5q7xiNRBTQshDG5uCr4rvOFJFwUiRwA76lrpERnv4qYUZF7pAiW8DDiIq+mZNDKavZPAeLCO92prxiUuSgygvyKF/3g31S888Oiyxi0eS7OUB1OZlO3O/sCmV+UlvsdAwEZT/tutaLIxohgDDcIIAjvVymaI6RZs7o6SnqOSNdTD7UCCAhQD+247Cgx0Mgz+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 18:18:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:18:53 +0000
Message-ID: <d6132fa9-94dc-4e0a-a4e9-2a287265578e@intel.com>
Date: Tue, 20 Feb 2024 10:18:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
To: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <Zc_9tPkfvqRkedrb@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zc_9tPkfvqRkedrb@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0365.namprd04.prod.outlook.com
 (2603:10b6:303:81::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ede734-9916-40f7-b411-08dc324064ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 273Puos5UEQ+doxd2mivBsdeN7xt6JCs7GVxFYt/8AlOkMDCIf9PvRg8sSVO6J6gsCdi37NVHAWDuWy7YZYYBI2SwCyAzdCIuYaK+sF+u8BV353QRI6qKEGQBBgHccYS0ToCOsRe5x5RTRPH/zzyPEvKrEXZEyJd2HKm95dBEDJahA1+sNYUocTGIofcC34iJztH2Xu4jrFrYmVyGVNc9ZelINLYTVKTo3wj34nPCpiftW+7zzeaaExEsltrAHUzVzynAwI4ujRP25huX0reRK9+SW0jr0K9uGcyHV9mhjS/MP0IQGQv65sgOIxkf/gjxltrdWyWB+D512NXluD2ft4o7oFJSIEwNBHuh5daOOfBURj1WN07OiaMqYm0OIqbpBS6ybxmeU+r8u3PySXjZtNjen5hl/qnE5QURuxalhhqYTUZB4T/36833iiuoGkz4/FKO8CsaB64NuVK9ryHwj7rm0i4CjLwjU3gRopAVUXKNUiF/fvZ+BWkiN0cWDNQAOQJjGZqYsmWkc+/t2qmDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdoVUF0VSsvTVJjNU9LSEUyZlRSKzdaOU9hTTJsRzJSSlYyTGUwL1RRY1NS?=
 =?utf-8?B?ei9WNXJVenppdE8rd0Z6eHBwcUFKOUsyc1J3THloN25HM1F1V0F4cVR2Rm94?=
 =?utf-8?B?QUozQlJuY2MyYVpWTmFzdWhrUTFrV1pXWG5pUU5sT3Z5NThoelZWYkRhR0tt?=
 =?utf-8?B?VnJSSGVUZExhSEJlSmFVSnhtS012NzJ4aXV2U2ZlMCtIazlXN1JFWTN3aUZV?=
 =?utf-8?B?alJla3V3Mk1Gcmh6S0QyQVM4enFBaW9mZmdHeGVOdUk5UXRrTXBsMllLMEJj?=
 =?utf-8?B?aEVveUFkMXF4elN6b3hVcEZOanMwTHZFNGxVTVFCcUZUU3A0d0cwbmNZZURp?=
 =?utf-8?B?ZTI0Sm1SdWF3aE9JbUtSV2ZBVnBqU0tlbjZyaXdETzIxRU1Bd243c3l3YStS?=
 =?utf-8?B?NmNpM3BweUFBVVFqamlTUXg3N1pnSURyenZadkhuY01LNGdORlpzN0FzM1U4?=
 =?utf-8?B?K3hEbGRMMnBPKytjQ0ZyMW9OMFphbzhNRkRrQkIybnJWMEdoY0lGRlZwT2RL?=
 =?utf-8?B?M1k4UmEvWSs3L3ZJWjZDT2R2U3VTdkVSN2EwMnN5dFVKcnJRWFVuQW15Yk54?=
 =?utf-8?B?VFBGWTR3MzhBN2N6OFVJb0tSUXByUXRNSWhiSzhXK0xtVXh6WS9zQ1ZPUkI2?=
 =?utf-8?B?Y3NxYjhpZHNuc25UYmdrRTF6OWM2eUdaOWVkK29qUklQaHdraG9ONFBkS1dx?=
 =?utf-8?B?WENSY3BsS3BZN3NRVGk0MVRsODZtQXl2NUZZdURpS09xNXdOMlVMYis0ZXlJ?=
 =?utf-8?B?YU1BRER3bzF5MGlsekcxeDlqZkxmY0ljOTJVeUFZc1QvQWZ4MTM4OEZFelZL?=
 =?utf-8?B?VWM2dlhFVFN6MkRhck9WRFdSdjR0NlJyVG5ISEJNNCtjWlBlZVpGUGpzWW9u?=
 =?utf-8?B?RWRwOU5GMnpmQ1QyNHVGVmlNQnFjNk1HakxmcWpUU0xkZ2l2b20wL0xETytE?=
 =?utf-8?B?QVBwL0RGSWhzcFlTZmFkbmhWMHU5R1JVRElBUDVaZHRsOVZXeFp1RWlNY2hR?=
 =?utf-8?B?VEZ2RC9aM1dNSUI0SXVUc1g4OUZZelZ6VjBHekNWVWhUQnROZy9NR29uUDJw?=
 =?utf-8?B?cmxaU3hvVVkzVDZGVUZGQ01sS1JBSjBlRUczZklBblh5T1NYOEpUalEzVWky?=
 =?utf-8?B?cVBSUnVhNzNoTXk3N0RQT0YrYXRPQnErUkJMOG9KWjBQckJuR0UrUXpRcnZh?=
 =?utf-8?B?aXFrTVRiWjhiaHZPa2tvR3FSVUZ1L1IyMmxRTFNXUDRpajNGTWpSZXFiQXRO?=
 =?utf-8?B?eXJjMU1hOVp1YzdrQ0hvVzNQYmkzdjV5ZmR2a0dobkh5UDlyTVpoaXhmdkhq?=
 =?utf-8?B?eW9RZVRXRUxhVnRRc3Biams1cndtaVhVMzZhWnBPWkJ0blB5QytpVjBJV080?=
 =?utf-8?B?V1BBRmsrM05PUGZNUnpJMDFZUjZOMUZ5REVOR2x0MWxYbTJ3Z2JsM1AvYmo2?=
 =?utf-8?B?UVQ4eWxhUEREVlNSL1ZQL0toTXpNeGl5OHpwYmQvL2VpYmZFMzBRSVNMS3hF?=
 =?utf-8?B?TTlLYmdGMzN1YWZoemhuMm83QndTV29sTEFWak0wanJQeXFCaDB5R2J6cEpR?=
 =?utf-8?B?Q3FIQW9ESFBqNlA1Y0twK0RMYTlmTXRyWVNQMnZnZk5PNlZ4TkFHS2dhS3Iy?=
 =?utf-8?B?MmZha0lQOFZxWUMwUUV6TFRWK1drSElTdnN2Wk9ncE5uMEk4dWNvcDI2R2JZ?=
 =?utf-8?B?UURKT2x1cUM2UTlpNEp5SEhIdWtJVFhONXg4MXR6Y3JWVzF1NTZtaEVaQi90?=
 =?utf-8?B?ZDZ3cXZEczBHWDB0Tk5LVG55eVZ5NmFIb2JzUlNlUERRT0pxcVFiK1ZtTDhG?=
 =?utf-8?B?MlR3S0dkUzlzaENLWkxMUkV6Z215YlVPVWh5WHJOQm8ycDlCTjl0M1R2cnB6?=
 =?utf-8?B?WTEzQStqUmE1cEdoT0xxVXlYOGRXUnQwWWROWC8zbWlYOFExbVFpZXZ2QzF4?=
 =?utf-8?B?Q0k0MyttbXM5R0FKd1Uydnk2S0hpbkRkM1pweURERUNqakpLOC9jTTZ3a2hn?=
 =?utf-8?B?dFczSlZCQ1R6d2o5UkNyWW5STGdLK3pVQTlWYW5EcUFEN3FueFBYM1dGVWs0?=
 =?utf-8?B?ZkROWXJVKzB5Si9NSjdpWHFBR21OSVAxeSsrVVlMVi9BbFZXN3lrWkd1WkJD?=
 =?utf-8?B?cXNEdW5rN1BFMzQrdFlXaEZIak15azZrQ3hXanVwOFlvOFB1THdudEJTTk9y?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ede734-9916-40f7-b411-08dc324064ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:18:53.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R966JfAKe0+H/kaNfuG3OgdD+HUv3bvK6BahsvfeKgEBwioEMiG7fPMjLGJ2FU+1Gs5chdEaanKVz10YjJayx2AsnGVe/ehdZzYI5S6bFgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-OriginatorOrg: intel.com

Hi Tony,

On 2/16/2024 4:28 PM, Tony Luck wrote:
> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>> Hello!
>>
>> It's been back and forth for whether this series should be rebased onto Tony's
>> SNC series. This version isn't, its based on tip/x86/cache.
>> (I have the rebased-and-tested versions if anyone needs them)
> 
> In case James' patches go first, I took a crack at basing my SNC series
> on top of his patches (specifically the mpam/monitors_and_locking/v9
> branch of git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git).
> 
> Result is here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
> Branch: james_then_snc
> 
> The end result of which ought to be pretty similar to the
> "rebased-and-tested" versions that James mentions above.

As I understand Babu withdrew his "Reviewed-by" tag [1]. Will you
be posting this new version (with tip tag ordering)?

Reinette

[1] https://lore.kernel.org/lkml/e94db745-9454-4a10-8398-f3b0bc0128e8@amd.com/

