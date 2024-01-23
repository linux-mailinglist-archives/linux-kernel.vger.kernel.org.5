Return-Path: <linux-kernel+bounces-35978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FEE83996A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991991C23586
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931781207;
	Tue, 23 Jan 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3Hvb+RH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59A50A64
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037593; cv=fail; b=I4bqCg6HvC+ZNZ7BVHlZu2IIfYAfQu0yKlWcmpFfbRQk4QGWxRkFiQQGSlW+JZtmRNOM63GDttOyBrIl3IAVmu/cicLwWY3CEn8PVSTeS+ogCRX27ZhDh4VDC6iLckTKgB5Kc4TPd2irhAXlg/HeqMAnxFTDe/Vt1cXdFoCgYDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037593; c=relaxed/simple;
	bh=9oHBsKuGa65Zpgqkm4VfdGizFo5s/1XMbBTQ0TFl1jo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYKp/EMRAPjBeDvkZ9YwtYYsb4/3+syELdMDCZcSu49Si1VyqxfEf7qz+ZR7GjOSBLEyq3DNWjWA/FmMcloDD2i+VEZ0Ha9GiAz+uDa5cgzvsGK2s+Zu3aFfu0LFa6DDWUxpiN+QWmK1xDOyYKwxr5QkrIhaaSNYIkk/ha+TE8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3Hvb+RH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706037592; x=1737573592;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9oHBsKuGa65Zpgqkm4VfdGizFo5s/1XMbBTQ0TFl1jo=;
  b=V3Hvb+RHHGr4QnCHTfK0Pzl5BiXfYpHEDVIFDYaIgXYv55d/1c00YMYv
   f89q9uboyb/XGz7LcIFhtriDFPHz8I5kpB3JxPDuoa0uoEKdanWx5Zgny
   gBNUgjjw8lU2PKSUy4MIlpLSkmbUt8kASkGYdBJS7ed6GDVPGZL7F7M3E
   CRn1TmAtzzzT0hX9pGyFQTEWdjAyS0TLUmiP41GR3+P3Gc1ZuMqrYZWAj
   G6Y8clvzrtfWkvskX29k3vY0Vi4nXZGUByBBro/lBLjXg+SNOFjmyfzNX
   MlkJol3Tntc6KsUHfQD+qK9HLFMmuJo5bY2RCjsgW58jMkFk26QVlwTS8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="14975977"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="14975977"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 11:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856427948"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="856427948"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 11:19:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 11:19:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 11:19:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 11:19:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6YyJ0mFP+8h/VPcj7eLIriRnzcfayqPow4XmwO12VFcs++US8cPg09mIuKPRUMK4PfsCVhpHODcalFc8tCIz7ZxQYI1LGd/vMt0rsl1tMJ3i+o983VZ84CaOADhThVbOIeF12kII8nMRK00e1LMGFcyk6ouYiqITKwr17otO9N73EGJMo7b7Wn6d8Uzi2+aNU08UXSI7QG/VWkQukUZW1GdZlQ03FnInsNzGoZC3dLAOyP+YyyveY7KQypb6E//AqXi1tUcmBRVx2N5NpHvUlXxQ1AriGxVy0Xqw9jqz08W3zg3em7h0pfDdV17XCzh6eJCvQtpz9a+WzkOPRLOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fg2RGhQdD6AWQhAvbAi576xx8GJxcZGW47Ut8JOOOA=;
 b=L5MYSVQk92n3X1bkaj/t1Y12ljo4T9W7rKqIVoRZNQuxAhAPtEundViLjmf/3O5byVB7rA5H65veeGKTWW+gJ2nwGcBUW2esbdo5gMCsvEZoCWmP9bO0J5Zk2gT+oQ/HAVDcQJUJJYhDHOqmFfJ3SO9o3ewcoyvXUsinVPiGKqCUR+sLQi0waP0tqiOQWUeWgX/hZ+XGsLqj49tg2MF9toHSNrJ2DCmcfq5uckngcKLvwUhfj2+mgb74ec3qCP+Ccc3UBkdajYgkZPmWxEX3jt6Tl0CGB5LUNe01hmRYDwk2ldtcWiFTNVrhlOdF4dzGW4bIh7Zitp54NOJXlcqYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH3PR11MB8240.namprd11.prod.outlook.com (2603:10b6:610:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38; Tue, 23 Jan
 2024 19:19:46 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 19:19:46 +0000
Message-ID: <efcf123d-ab7f-4d88-88b6-29038c0dcc05@intel.com>
Date: Tue, 23 Jan 2024 11:19:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Simplify redundant overlap calculation
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, David Binderman <dcb314@hotmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
 <AS8PR02MB10217E3448DF6D70285CA3D1D9C742@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <784a6843-c5fb-46eb-a472-5d96101478a9@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <784a6843-c5fb-46eb-a472-5d96101478a9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH3PR11MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b0192c-2230-4a97-7cd2-08dc1c4842cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CcTxGSXTchm+2Q1MgjCQWVzj6NIUyKOvLclzM4xg9SxVaseznROfw+ChcZOjY6iYhV6DZA1RZlg7DEcKctmMxjZ+0FaUHqIm1igiB6obBOny/mS6WqUn+WuTqYECRkg41QFx7qm1t4imqZPL3qTk6WhApVwRQQoveyVmiej//JAuxfh61xXX36EXy4QaazxLzKLI3peDNGPN8JRK9fslLzlYC7Pz+zaSx2EOqwI6fHo2nfLRN1kOTXFnOOfmVOyDYn1NS9dxhADtlZ6uHPrC1SstMnrqryr0QY/7mrE8GJROidnc1d1WBpWZppAcCISkgVqJmsE8zEOY37Sj/CTpFh8plEahEtI6mZwAVaTr/cnUx2z0LbDkgUWbyQc0MOb2ZkHGXPsxwvvtYSdS6NeGBa7THL5Okdt1m+nZ1p//wFdKsqJB/L//ySJ8xrlI78Fk02nRUEmjk/qidpn3WQx+KlUwQRFAjq/FrhFO4QvWVxFMTxIqoJQcnu/F7v+IKotBlWhBxNXLbB5oI8W6eDnRt4ryIsrtuedjyo8UtMAPQTfw8RdEUv8I4nHVA+34dVY3qhV0LTkOWyWoVMYema889ycXcjNGj0Oc2mjnJTcs45zF5aAvT5INCtfGJwJD0gOQWmFgbwVn5iTmCdgB7mF+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(44832011)(83380400001)(8936002)(4326008)(8676002)(86362001)(31696002)(38100700002)(82960400001)(2906002)(36756003)(41300700001)(5660300002)(66946007)(110136005)(66556008)(54906003)(66476007)(316002)(2616005)(31686004)(6506007)(53546011)(6512007)(478600001)(6486002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1nemdUOVpCZEFSY0V0VXV2c2h6TEsybXRsUWc5a3RrWXdSSC9vYStKanFG?=
 =?utf-8?B?YjZmZmJ1eHYyb0ZNMkMvcU51aXlVNXpSeFZoWEFFUlUyVWVhV1drY2k4eG9X?=
 =?utf-8?B?Zlh4L3B6TEFKZlRBbUREWkU1NmMvODBVd2lVdTBjKzExbTBYMW1OZW1VVGFT?=
 =?utf-8?B?RFhiN1JSbHBVVUtGRWhZRlVteUNTd095OTdFNEhsY0E5em9nQ1Z5QjE5Yk5U?=
 =?utf-8?B?WVdDKytGbjlrcmpMMjBJU2lGRityS3pSMjdvQVExTTJ1NEhsWk5YMGJSZlNx?=
 =?utf-8?B?MWsvOWF1WmZZMFB4WEhKNFpZVHY5NlVFY1FWS0RqVCtwZWxOUTZPNHBaZnVZ?=
 =?utf-8?B?RmorR0wrenRrTHVLaUJqZjRUQ1ErTmswekR4YmFLeDBJbzZZbEk2SHRVd2o0?=
 =?utf-8?B?VzlVTkZRVlQwakl1SGZNWHljSGRCZWdLN01GczV1NVorNmo5YnJtZDdDMVZh?=
 =?utf-8?B?M0tveHl3S042MEh1L2pMTDdvdzlrUHZGNlJkUkpsbmcxRU9rS0VyTVF4NDNa?=
 =?utf-8?B?RHBLTzdWRTB6Y09XSGhLVHJBSURMaE85aHd4Z1FqWThIMC8rMzdGM3VvOW1i?=
 =?utf-8?B?bGNlejdUV3dWa2FMTWFMTThBcWMrakdZRUFmSy8wYlpkSHNwaW42Zys1YU4x?=
 =?utf-8?B?SU9DSmEybEllOXlta2NsMEdCMThtWVBYNU40R2pCajcrdnhtWThtcmNLQlJZ?=
 =?utf-8?B?alMrbVM1Y3hacHhGbGpwaHY0blBCSWE2b1Q5M1J0a082ZkViZjRhc0RDVlJR?=
 =?utf-8?B?UDZuL29PSWNRVmYwQU9HM28vbmIySDZQME15M1BCdmRid3lWSUZRSlNvdE9H?=
 =?utf-8?B?Y2RBaXVwRFB1Y29YOUp4a0N0dUxFemFoVXJrU1lXMFRlM1dLQTMzS3BQbDQr?=
 =?utf-8?B?cEpYZHFWNXhYaGhZVFBONzFxc2I3a0liUndoSGpDNEdwWGtpelcvOHFLNkpr?=
 =?utf-8?B?RGh0eDR6RlhIZ3BsVGpFNzV1MDZBVHlEc0IrS3JUSEwxK3JFd2Y4Y0h4eVht?=
 =?utf-8?B?Q3FPRC8xRC8rWGhNaXB2NmlmVllpaDgzSEpNYVVRaGNzRnpyOXREcGZQNExa?=
 =?utf-8?B?dFpNeHJpOXFIcU96NVRDUGN4S3E4VlpFUEJPcStFb2QweHF3S1JseUtkZTJ1?=
 =?utf-8?B?K0JWSk9IK3dsM1hoaVZ3L2VNSHdUSlVYQ2U1Q3dpbTd3cFVkV0s0Mm5uc3RC?=
 =?utf-8?B?cUg0cGIyNm04akRQWDNabEs1SDU2cEZWZEcwNXNvUHE4YjRvemdwaG5hUU16?=
 =?utf-8?B?dTJzRVdKeEdVTFd3M20zeUQ4Z2pCcVl2eGQremI2MHZZRmNtZk13Ylk0S0Zn?=
 =?utf-8?B?clpPWUdDNVJ0RlpzRXVUOUN2UXpOSEF4SU9pM2t0QWRxQ1ViTUlsNFlxV1gx?=
 =?utf-8?B?VDhvVlllZmcrVGNuVlduekdiazgzR3UySVZwcmcrb1pTWmt6MTY5SjlWWVdL?=
 =?utf-8?B?OEd6UzJRSC9iSlV4SEZVTUswQWIzMVZRZ3doOEZYTEpaa0xKQWF0KzFJaE5J?=
 =?utf-8?B?ZTY0WTFWZFd6YXA4Q0M2UDY4UFJkWkpnUTZPcDdWQzg2RExWUWhlRC9LVElE?=
 =?utf-8?B?OVdBVGdaQnJNZytjZnhyaHZVdEp5K0U3SlpuMUw4c2ZVR2s0MW1NV1lOVlZF?=
 =?utf-8?B?b0hQZHR2NjdqVENRZjZraVo5aWFrbnVlN3lhRnZzemRibFdUeE5oWWRLcEZv?=
 =?utf-8?B?SFRFK0dSL1hXTDRvS3U2YnJiL0tOOUg4L2xNbjJtRlR6aFllZVVqT0JGY25Q?=
 =?utf-8?B?c2NRTG4rZXNNQm5LcVI4cEp6cW94ZGhRY1RuVlFYbGhxRWszVGtkMGFJcEI5?=
 =?utf-8?B?VWNoZUtqLzhyMGdXTDNrTkg3bFNWZysyYnVaQ2l5dHB2R0xYdVV3cWNEdEZJ?=
 =?utf-8?B?ZWo4a1JiZkJmUkswdGRHUFRhdi9TNnF4SkZ6UlMyMnI4Rk10eHljb3BqN1Rk?=
 =?utf-8?B?cFhrRlJWUmtTWGJQVkl2SStnRWxQOTlMUWl4UUZZMGZ2L3EzRElsMkpienpR?=
 =?utf-8?B?NWZxMnRNdGVHMVdBTm1vSlRCUmhxaFRTQlVnV05KdElFRmhOTWh3K0pVTjJI?=
 =?utf-8?B?Y3NHQksvUE9RSHI4azZaT01HK1J0S3dKVVRtU3d3SHNRanpNQ0VEc0hnN1Zz?=
 =?utf-8?Q?gvANabdxLW6af+dZiCOZPgLp9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0192c-2230-4a97-7cd2-08dc1c4842cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 19:19:46.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMbMgWb1BEMWVSYTlD0hNRvRhPkm1ncTdfaTe6jdEj71YZTd/HNX22bMTuUFy92AJ0DM7ErvMhQgBiCCXB4VEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8240
X-OriginatorOrg: intel.com

On 1/23/2024 9:00 AM, Dave Hansen wrote:
> On 1/23/24 08:54, David Binderman wrote:
>>> Remove the second condition.  It is exactly the same as the first.
>> I don't think the first condition is sufficient. I suspect something like
>>
>>        return (r2_start <= r1_start && r1_start <= r2_end) ||
>>                (r2_start <= r1_end && r1_end <= r2_end);
>>

This check seems accurate however Dave's single line check below also
looks accurate to me. See the analysis below.

>> Given the range [r2_start .. r2_end], then if r1_start or r1_end
>> are in that range, you have overlap.
>>
>> Unless you know different.
> 
> First of all, I've gotten these bounds checks wrong in code more times
> than I can count.  I have zero trust that I'll get them right. :)
> 
> But the compiler seems to know different at least:
> 
> int  overlaps1(unsigned long r1_start, unsigned long r1_end,
> 	      unsigned long r2_start, unsigned long r2_end)
> {
> 	return  (r1_start <= r2_end && r1_end >= r2_start) ||
> 		(r2_start <= r1_end && r2_end >= r1_start);
> }

Dave, I think if you change the order of the && in the 2nd check it
makes it easier to visually realize that both of these checks are indeed
the same:

(r1_start <= r2_end  )	&& (r1_end   >= r2_start)
			||
(r2_end   >= r1_start)	&& (r2_start <= r1_end  )

The first operation in () on both lines is exactly the same. Same is
true for the second operation after the &&.

> 
> int  overlaps2(unsigned long r1_start, unsigned long r1_end,
> 	      unsigned long r2_start, unsigned long r2_end)
> {
> 	return (r1_start <= r2_end && r1_end >= r2_start);
> }
> 

I completely agree that overlap1() and overlap2() are expected to
generate the same output for any input.

However, the next question is whether overlap2() is enough to detect
there is indeed an overlap between the ranges. I find that would be true
based on the assumption that the end is always greater than or equal to
the start in both ranges.

I have now spent way too much time on this. But if you rearrange the
check in overlaps2() as below then I find it easier to put it in words:

(r1_start <= r2_end && r2_start <= r1_end)

"Both of the ranges have to start before either of ranges end for there
to be an overlap".

Sohil

