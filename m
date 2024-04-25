Return-Path: <linux-kernel+bounces-158250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B718B1D82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682211F2218E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1D884D06;
	Thu, 25 Apr 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFAHJlKv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE03EA86;
	Thu, 25 Apr 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036402; cv=fail; b=AjPM4FwP6OidXD+DqH16ZHUocqXV401HwreeFezZEM7BvMQ7nkIXGUI2+Rk3ALhIk1czJe3R7uxixKV6Vcablr1Rr1KhnTxEd5uRiUzBVpu35OAI6UVECod3GydK1oil3pRynbTDv/tpUi3QWZ1BPUkGH5MzKBxhiZp9Sk5fXPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036402; c=relaxed/simple;
	bh=1iEV8ca5MQtJB2bc76mFePBEw4POMBdOUDCoHfVigdY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBGW5maf19QwrTIbk4gRb97aG8rdZz0KV6m2PSFNkzSNEOks+FH6XvD58MnISEGgoJhp4CxJKuZirdagZ2jbXmHe3tMIppWE4VU4uGI28rwwrT863lsxawN96r1QJbRyeh0C7fueJ7K0zY44dTvm0Snn8kG5AvFxvb1d649mTPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFAHJlKv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714036400; x=1745572400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1iEV8ca5MQtJB2bc76mFePBEw4POMBdOUDCoHfVigdY=;
  b=WFAHJlKvMpPx0yvG0P3kwWG7BDUd56BQGA/g0/FTu9bxzp0KlpCTeQ4l
   swSzjD1BmK++gfFmojf0cmBjZCCAmKP6QgDbmtvJfJ0id7PWnK5Wf75AM
   9umnsM+ysOE02Kfe/ZoAo33rUKYe7BwNZzvWI9lt3+apY6DxPbmLDHtFH
   jzjr1aJJckTqGR9F30lYnK1DxBzIe0J8qMdrG6XPaEk55rjp65awMGeaI
   hQe8HrwRPvFcccI4JniT7MzaFVPm0ATTNS/l1Os+ojfnDvZKVN7LIL7J8
   9sdtJrVJt0BopjG56uIfywrWfbuGRMemrv6izbYOWNam546H5xIxoh4D6
   A==;
X-CSE-ConnectionGUID: 3BG4/RQbS0WhmPNeYpJxFQ==
X-CSE-MsgGUID: c+n74NEeT/GSYth7ri17VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9574472"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9574472"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:13:19 -0700
X-CSE-ConnectionGUID: x9GBZ93/Q5yF1z0LwKgDOQ==
X-CSE-MsgGUID: EzYBkyowSCGT6VgxDXeIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="48270577"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 02:13:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 02:13:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 02:13:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 02:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEGZA/c5KnIt1qcYyZHIqA7O8V3HTXA5pmXT3jqydhDpj9JjV+VVQ3bj1DyKwgT5E+GqDfUKhMzUfDt1zmMcA1HoEXQite2eib4L7FkA3dSS6yMEFhMDZodAR+HGSDU8RlL6KdUBDU8+7xImJPzJS9DibGnqGQtDslR3938GDMg5eLGufV4CC4ebZsCYrVfxZD47ApJrow99OHYJN4TaguqLfcDPpQb4WKBqvtcQHjJdw409nGaw3KCp32Mwb4N/r0sc2mvfn0UlrJM33SQHvgVuMB2nyHcd2BcHcjEiGXQbuG57V/jswD9lbeP8lh8fKCGByW7BNxTuMQdHZaKv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZyEJXj/Ru1c8O9o541CZNEcDuatLnfhYHvZNIOi3PA=;
 b=Z98BDuuLljtYNSAGTAsK4t/MdBiZKeK9LQ1SvR51OpbJh2tjjcI/IyrEsFJM7HKwAn2pVIAgKkekRlAA+bWjZzpl4sR88bXza8AayV2eOrYHb5i/P3NWO62BoSb4D4zim1aiEsZGHqnc17/61Lfrr9454evHtOsA2oENi/Uv16o10hMFcBSZrwRaFRO5KLc2sfb8MpclGhtmqejLmbFotU0JQXGncIzy3baWbgANrG8TKP06q1Lf70ZtxL+kVU7jYlGdicVcjHB1sudwzdPAr/PgWQ8xH3arg2tMTv+6vmjvKRALxjKF9pCCbPIVIPnWG1SvSIyyuxze/tvQbAyKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 09:13:11 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 09:13:11 +0000
Message-ID: <359adccd-adfe-4b48-893d-bc49a5977c81@intel.com>
Date: Thu, 25 Apr 2024 11:13:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: fix struct_group_tagged() parsing
To: Jonathan Corbet <corbet@lwn.net>
CC: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>, "Dan
 Williams" <dan.j.williams@intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Keith Packard <keithp@keithp.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <linux-doc@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
 <87r0eusgl9.fsf@meer.lwn.net>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <87r0eusgl9.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 23443dd4-a2f7-491b-92c6-08dc6507ee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkFWRXBCWFdtLzFiN2VDOUppc215V3R2ZXRVWS9BV01ZQlpheVZ6djNlRzBO?=
 =?utf-8?B?RU15S1ZXSEliMmFMUlkzZjN0TU43RWdaZXhlWUdsNnZmdkp0T0ZxU3k5ZGor?=
 =?utf-8?B?K1FENk0veVlzRkdqU2xmbm9NYkZIaUIwRzFmTEU2eEw1YTgwNUI2ODc3cmFG?=
 =?utf-8?B?SFJIZVM5dVR3anQyNEJUbTNNUXJnV0taTjhwdkZiSlpaNm9YQklhTVVNc3Ix?=
 =?utf-8?B?d0h2TkJxZFRBYkNXRlJzSUJTODZqNlZ0NDZNY1V1VFZmdjI1WkJMZE9vSEUw?=
 =?utf-8?B?WFdXVE9tSkp6UkxJUUdybmRoek85a2dCdTEwSzhyME1sT3RYSUtNNWxVUTRZ?=
 =?utf-8?B?UFBva0Z3RFRndEtpdE9aWTl1V3JmZ3VWV0JCT0hvVnVCT1JPQURnMWowS1V1?=
 =?utf-8?B?VWlnRVRwRkp4TVcySE05cDZnVzVPZVpLRmVCazRlS2xkWWk0ZWt0empKUUpD?=
 =?utf-8?B?UFU5NEI1UXBReVY2MHk5bjRCN0t5R3k1cjZIYXB6amJZV2dWWmM0eWpoU1RD?=
 =?utf-8?B?dWdNMURaU3I5SzNWdGFBY0FmOVlTWXlyZ1dqdVdyZlI3c1VNTFNEc3ozdDFS?=
 =?utf-8?B?aFFZVkdqVGNRVGU2MHdiSE0vQWRaUjN0NUZoeW1hbXVwbkpsN1MveG4vMnB3?=
 =?utf-8?B?Qm9POWF0VmVWV0lrcW00VmdRdVFxTVJ3ME4zdmwxZFptOEZwenUwRHZyTVBn?=
 =?utf-8?B?KzVwR09CVUxlYWp3M3h6ZE5ISE10T3VzT3RmQ1NuNXlzNmtueGwzWjdMSFFx?=
 =?utf-8?B?UExqZjJqaXRoNk9xSGxEcXd0b3JjUkNQNUhHaEtHL016WHdqQ3dpT0ZvNloz?=
 =?utf-8?B?NWpjSTRCMW5SRDBUK2JlR2hhZnluY3I0VVRlYk5Pa05NMlFGNDRUNmwySTN5?=
 =?utf-8?B?STJIN2g1RGZSL0taR1dESmNNUEJOTm01VkZyT1d3SWNYZ0h2ZXpzZE1NRVk4?=
 =?utf-8?B?ZHdzVjdidnJoTHZOemI2N05CeGF6TndPVnVQd1ZMRllXVG5QWHFza1FQRCtz?=
 =?utf-8?B?VDdlUmNzcmM2V0VseE9qUEZTQ2lTczVoWURxV0FpaHQzNkZTNnU5VFF3ZVZj?=
 =?utf-8?B?OGlVVktNZlA4c0l0U3hhdXpUZ25JSlNXeFd6YnF6bk9LeVFnRSt0N1pHNCtT?=
 =?utf-8?B?VU04SHNETHd5WFBuZDlTaTdjVTFLMUc4ejhMbzMwckJzV2JwdXMwM3U1aUta?=
 =?utf-8?B?SW5jWEhwOTUzanFoQkN5dDB5RnZVUm9MWVA5MERaN293cThnUmttb29keUti?=
 =?utf-8?B?czdYMVl3MUZRM1ZGcGlhSjE0aFRSam5YYnU2M1pUY3lrVm1WVHdESzdwV1di?=
 =?utf-8?B?R1A1YkVISW4yNTJKKzBFTlBCeitqa2tMYjZqL3NrVmRWZ3JuS2VDb0c3aGR3?=
 =?utf-8?B?S3B0cFNTZTk3cWsrT0lwTjluL0VBRVVVaGRYNEVLMVFmeWptdFU2VnpzTEhP?=
 =?utf-8?B?OFdFcVNnbmxsL3p0TmllSXN5N2dxSVJEQ09WRUxRTXBwN3h6ZVVqelJhb3E3?=
 =?utf-8?B?bmhWQjZUMTBnUmxmbCs3dWp3QXBsaUdaVmg1UFo1L2lvRmkrbDhISk41cmth?=
 =?utf-8?B?bWRUZ1ZFSkdZY1JVMmkzYml4VzBaL2JLYjV0eDcyVUJiWHNmZmVOY0swSkts?=
 =?utf-8?Q?uhW1USt/U85a4zW9qguMF83jcgV6N1S4Elt4q4dM+2PA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVhaWpmRHBoVUlQM0UzcXVYeStRcW5qTm5aK1lFcS9hbXFWS203OGRoY00z?=
 =?utf-8?B?RmlwRVc5ZERSMS8yMnFoVEVNUi9QQ3BxTmZaQjZXVko3QkNXRWRBdE1vMmlR?=
 =?utf-8?B?aTRlVXBXNmJmWmN2SW9tSEJXVUFIeDJoZU04T1V4aU9SOUN2VWFNWXlJcjBp?=
 =?utf-8?B?djFMaDBjZGh0T1Brc1o0bnFaSy9PTUMwTTZyRHlvcmVqcWZIRWFaMTVmZzRB?=
 =?utf-8?B?Z3JrU0g4R0hGNys4NkNnejhoSXhaZE9neFdSdFR4WHZieC9DMzBnM3J4cWZJ?=
 =?utf-8?B?eXZrNlIxelN3SGFhdEdVZk9yT0E0TXJTMHUwcDF0U2xoTEh2WHRtVWQvRDdT?=
 =?utf-8?B?WGJMWVFqMzZSRjlZUDVmL2R0TVA5RmN3bEZzK1k3WHkycmppRzVrMWVnK0t3?=
 =?utf-8?B?V1lXeDRWTzhEOW93WVZlMVdkeUpGUDYyRHpEREtYZ0YrMFhjU3RhUVNkQ3Bt?=
 =?utf-8?B?NUlzRVc1aExmalNWZ1MvQ2FoZzVYZ1krU3pRV1pFM1lKZHZoTEVlMW11V3dq?=
 =?utf-8?B?aEhUakZPRnVxcjhGOVFyVDQ5NTdCVDArdXRvd05MYTBhb2IwRmpxLzlFU2Nx?=
 =?utf-8?B?NXBTUkJQQzRhNGEvZEIwYWVjejdqUW5LM3ZEVXE2UElFUDBmN3UzNnlKNTBY?=
 =?utf-8?B?anRlSWZPV3pRK1BDczhkMzBJaEYzWHFjWVIwWWpqNUhiRk84UmpiSGF2bGdy?=
 =?utf-8?B?amNUcHRsS05IcGsvK2FHVm5yejJ1amcwblU0OEp2a1p0aGtWOU9NVml6WUF2?=
 =?utf-8?B?YUVWYVUyenRZTDVwK0w4cHI5U3RoRCtOSjRHdXgzaG1VY1hXOVJ4NjV0Yzhn?=
 =?utf-8?B?ZzhMQXRaK1RSOExZRzk5NmNoSzBUL1pHYk1ZMGFBVGhVdndpaEo5aGJ3bzZm?=
 =?utf-8?B?TWtmWE9hTGJPSmlnRjJaT1NNRG8vSGdlLzRNNms3N0ZPdnFmb0xKUzgzb09Q?=
 =?utf-8?B?YTZOTHgwV3I3a1EzL3hpVjZnQkF5UkJqWFdQR1BhelRkbmZQNzRndDZwOEVj?=
 =?utf-8?B?YWZXYUFKbndVUGdkMzU0ME4yTjRTSEprVWxpTUZhaXFoVnZ3SkNUWU1LRldj?=
 =?utf-8?B?NkVaMFcxaEVQSnBnNGZ3NkwxRlV1OW5uVVhmL0FheUJvZUp6eGNKVnd2d0JL?=
 =?utf-8?B?SmZiZW5yWk0rZ0tScWRtL0V5bEZEeVpFWGNwVFN1Q09qVVM5OHdGZzRYMVRo?=
 =?utf-8?B?R0NTQVVSYmlvVHdYZHQrWkFualF3SFlqcjJGV1g1M3dVUzMyNmtMVEtqY1BT?=
 =?utf-8?B?THlXbjJmSFhYSUdoYXBaTkhoOEgzUU5ZRGtrSnQvRTBHR3ZDZ2hhSG83eWlz?=
 =?utf-8?B?ZVRtUnZRZVhrZVZGWDNvanRrTm96a3B4Rkk3WVE4eUt6MURuK0RjYlo4emt3?=
 =?utf-8?B?ZmI1QnFBZVdQbm5uZDBVbnVnSVNNVDltNm56TmVpWWpyVktHVi9xcXVvUHF6?=
 =?utf-8?B?OEdhQStwQXoyOVY5RG1vdHErTGpsQWJuR1VkallxUk8zWDBIVjdFMVRnN21Y?=
 =?utf-8?B?Y3pIeHpCOTdJN1pkRStwUjJZanQySndUdXpUVmx5TEtPbWY5K3l6a3FMemNa?=
 =?utf-8?B?bm9PazV6VzhPVHZFb2xnNW5UTlpWVDN5YXV4TDBTNWQ1V1lhWFNvVVQyTGdR?=
 =?utf-8?B?ODVGcHZRakVYaDdGMVJhSGtjTlpmTUtMN2l5NXFPV1dsYk9iRElXQnIrejdt?=
 =?utf-8?B?VHU2Y0h1YkVXUGw0S29yOG15ZlZVLzJOeVV6VEpKNmpaY3VyMy9DTVZ6anNL?=
 =?utf-8?B?d1VjME5LOExNcnc3aGJuaUN2amtENDUyZ2syL3VXR1BPSlgxc2MvNDhPdW1R?=
 =?utf-8?B?N2tUSjF2MEJnaW9TMTlnNUo1TE5uWGtSMXJFcWZNTkVMOEVUNEkvcWlKWGFo?=
 =?utf-8?B?UTJ0cXNBckJaUTU0ZWUwSmtiZ1k4dWJFUFdhckJMYzhiaTVlMFR6OXE2YUMz?=
 =?utf-8?B?dWZQSmgrRmEwOXYvSjlPL0I5VkdCRFZtU1NkVW1ZMXg5UW50c0c4Z3JhQ2E0?=
 =?utf-8?B?SHIvemtORHprSmF0RVBMbm5CSHF4anMwYlJtWkN5TXllUU4yek53WnFSRUl3?=
 =?utf-8?B?Nk14K3A3aUV5T1RHeXlGQ2tiaXViREhSd0lrTVJMNmRkMmVXQWR1cU9Jb1cx?=
 =?utf-8?B?c2JoRW1ET3N5Zm5jTE1scjR0M05YNHNlS3owZmxoNlVpNHBiRUxobzR4YXda?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23443dd4-a2f7-491b-92c6-08dc6507ee29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:13:11.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB9XH+do6Cgq2YwqC0w2IHFLGFZSwxOv8KiNLXNpBdQ31R8K2dRVswnwPUlVrnK4T10sxna/oilVmHd0nVqllMyC4zKO72cq/DdVvbmfkc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com

From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 24 Apr 2024 13:31:14 -0600

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> From: Kees Cook <keescook@chromium.org>
>>
>> kernel-doc emits a warning on struct_group_tagged() if you describe your
>> struct group member:
>>
>> include/net/libeth/rx.h:69: warning: Excess struct member 'fp' description in 'libeth_fq'
>>
>> The code:
>>
>> /**
>>  * struct libeth_fq - structure representing a buffer queue
>>  * @fp: hotpath part of the structure
>>  * @pp: &page_pool for buffer management
>> [...]
>>  */
>> struct libeth_fq {
>> 	struct_group_tagged(libeth_fq_fp, fp,
>> 		struct page_pool	*pp;
>> [...]
>> 	);
>>
>> When a struct_group_tagged() is encountered, we need to build a
>> `struct TAG NAME;` from it, so that it will be treated as a valid
>> embedded struct.
>> Decouple the regex and do the replacement there. As far as I can see,
>> this doesn't produce any new warnings on the current mainline tree.
>>
>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>> Closes: https://lore.kernel.org/netdev/20240405212513.0d189968@kernel.org
>> Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  scripts/kernel-doc | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> So, in docs-next, applying this *adds* two warnings:
> 
>> ./include/net/page_pool/types.h:77: warning: Function parameter or struct member 'fast' not described in 'page_pool_params'
>> ./include/net/page_pool/types.h:77: warning: Function parameter or struct member 'slow' not described in 'page_pool_params'
> 
> In truth, the warnings look correct.  I guess I'll leave this applied,
> but perhaps a fix for the warnings should go into the net tree?

Sure, we'll fix this. Thanks!

> 
> Thanks,
> 
> jon

Olek

