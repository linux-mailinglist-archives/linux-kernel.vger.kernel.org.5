Return-Path: <linux-kernel+bounces-94779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7BD874524
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453FF1F2569A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A32139F;
	Thu,  7 Mar 2024 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwoFe8OT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95619161;
	Thu,  7 Mar 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771285; cv=fail; b=t0ob/KOVgJ7NtLDxzzldw/JrSVK3svTEQ6/VQjPuEO/JrvYEBaLaUQLqIKN891UlohU4hCpA3GtUyx9VTWEt4i6V9g+SIUeWbT0BFnO5X9QJj+gYqRrWn/2B771v4TSnn7nHdx/vJqX5+NGSnCJV5uwZNHOD0Fh9XTUdT97OwlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771285; c=relaxed/simple;
	bh=dD/n4g9mSkAwfL8KDuAvcAKbDw4O4IeDzNTc+CEqw9U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uO2yFn3IZXUESKm7snlHdTqOaVdp9KaHw2v5Aie0FBzeVsbjivBzCvzaQVj1BRcE2IZ7MUvRlBXtixfyIJefHGJdRgiJkmK9bkMCCKxbSdgLN7rIY+nOy3thRe+Sl/iuC8Q3HubJbioUBpPFV0v23xmcDr76t7tunjqtHNkQ9R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwoFe8OT; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709771283; x=1741307283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dD/n4g9mSkAwfL8KDuAvcAKbDw4O4IeDzNTc+CEqw9U=;
  b=DwoFe8OTSqD9qV7h2Cma1xJA8rB7mnrZOTkOGsb9ygl5jOj3g1N2apN+
   ZtHOYmLpQcYxWhD+ltp+PXMk9r0JMh5r3hcD2ugNFABI1GDk3ZBa8uqVF
   KSiNgencpgnls2yL5m9rsDQD/1RVIBeSqrss56X7yGKTy1aFDY4XYWRKV
   j6uR+DToe14Joc4Ss2IQfcAUmH1q/j3+rwocp+GZ8pFVEgC9ID9JuQXXF
   2QO87xhwn+4jCQt80KNCTqwftB4pXzHRoT3Iy4cbFUHamKLuDYSxoWX/q
   tDUEEsR4HERozu8JYdyJaE5ysyc3UDda62emRV9RollKJ4b70cwNOzVZO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4999349"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4999349"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 16:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14514470"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 16:28:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 16:28:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 16:28:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 16:28:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMW0IR1C7uf8WkdKl1wS4B++L5fzjs6UdbitZDDeEzZmbX+JK2Df4NUj+7l8xXEgciAtUt21FEKIWlbXxv2S1yybwIImTZlKTnw3RZBDnfhvTc6IxdsMMUEZpGJ2dlU4xLbXj0RBfdMKmimbDqrLaGYHoYq4EmDuCC6YTmED4I+8ZDfTXq+TXGHEPiATDZLNL8zOCVvHCxwnYgmTTYtydtJJRotIBaEAfhLD7/AJD7PQgdjrJ6AG0QqlGP8s81TnOzAx0oIDtOdAW4XVS7/lP/3yl8w8EJgUEljD10EVmYdSLwegoOwWJmx4Lm1rUWqsZfeBUCdJnpTr9/n62v0oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez5Yrpuq4D4ylLyxQ099cBFFJuiLpBotaWDUS4tvHC4=;
 b=lDpquk72vZwJsYpoaczJ/wCtShs96sUgIqd5f2wTJb+2Xw2e+6G4aJe3QEi11yA3TsyJh5pJiA5sA31WK0PqTYqQMZqB7Yi+W9019o6p/07g+bNGoCXY7P+z78ogTN6aq9FHzJaDFHVcI6Sos08NAFtuA00MdMX8+xsFM2JlZ+4t2TilsXA1orMDB6sTvQ2qTPJFuy3GymwhJBeb8DY+1r/DkVDxLCose6itlLGvtH1LAu4GUfLLxIItbzZGIWF65PgnlsiLkMcRzbm3M8qQQCWdifkr2B2mFEjojiUCTaX3lZ/bn1dyJve4Lc04Nzi3vd9aD1QyJtkQzw/6izibMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 00:27:59 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 00:27:59 +0000
Message-ID: <d9529518-c6f5-c64f-d635-95da64ed6d65@intel.com>
Date: Wed, 6 Mar 2024 16:27:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] i40e: Prevent setting MTU if greater than MFS
To: Erwan Velu <erwanaliasr1@gmail.com>
CC: Erwan Velu <e.velu@criteo.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240227192704.376176-1-e.velu@criteo.com>
 <827d22da-fb32-1012-422d-d283b28ce5ec@intel.com>
 <CAL2Jzuzf54qcsCM4CAUOLaogWrBL=Mm4ma_4pRbaf8A=dZeOFQ@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CAL2Jzuzf54qcsCM4CAUOLaogWrBL=Mm4ma_4pRbaf8A=dZeOFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24)
 To BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 733c46a6-9acd-4a9e-f1fb-08dc3e3d7169
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzG8hxRNx/ha72BOmYiWDfqFpk8u6VYQ+CUtWKLxG42dxbwsaZtX/voyhVIq8tP1Ygu6pqDJgwDH4YxxMPAnqYmR8uYA14CSd1n9uuWVszJka0XHesiPUSV4Peod9SZlgm/6wnJSsDN2DRXoG1nVH4QQ3FlrQQSnxVjT1oHkLPjuSw28vIdJ3mm6Esq9oMGXfDIKYMFdFUCexA+IEBaajAAzL5OPzgYQZtI5uwNuqebHn4yHBPICfarzwx5RLWn9wRwkqENExvXyCo5gLieew4oOHc2gGOUfHeYpi/linaByhgowfGZrxkGUkgCGEXvwZcFmj4cvlGO8bTE9PDQ5fdRXIbUubDZ749oaqKreSNA4pUoWXYSJ8S56OpQGHBr6JrXOjmK3UIMuvcgYtK5RHZ1KTVYFaNsNiFHMMjaU25G62RbAPVLb7cCRG1uCObK4TRyuphMBtuWF1HVvrAz7bJKVLENX26D12Hwo9kXCEAjrcqH9U/q7VrY7OySuudTHxFEvNLa0WvCKBsIPYff0a6gwB4MyYnCAwlitJUD9NTKn/kahBpr4aZiqNkcQ1Vrr+8mxka+v7EhcN9NCR7x7F7681EoJWe6zs6HoRgu4nNDTJGu3+HWyBHSQ5izZ1xjuSlTPIGXbDTA1ALZYiBkOw/X4lul7fS0RY6ZtMIjvHrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2libFFCRzBERXVBZ0N1dGpmSXB3NkpaclpRVHFqQmFvc1lwdC8xcWdSNWhS?=
 =?utf-8?B?aS85VWgzb1ZOZVhFbWp1VWRCQjJvYUJTVkJCK2YyUzB6cjU4L2pJZXdKRzVB?=
 =?utf-8?B?UU1vSnhQOXRKMFI4WEZ1a1pxd0ZPZFVlbHhSMVhOWEJkNHpHU1pBWFJQOUto?=
 =?utf-8?B?VkFIUjlTbVQzbU8yZ05oYjhBSkJGMW8rdEQrWTdtK0toUVY0bDViV0tFMHhp?=
 =?utf-8?B?ckpVQWd3K005b3VqWEk1aHNGVEYzREJHSjNyaDdzUzRTditwNEZ0OG9LZkNl?=
 =?utf-8?B?Q0VkdjBTOW1PdnNJWDRkaXZNelJpZytTcFZYdStkVHUzVjNnL2xSd09HUE5s?=
 =?utf-8?B?a0hvSXg0Mm5ONW9Hejc3Y2pweEhsdWFjdVB2TzVUbVhlSXJ1dzVQQ1RhN2tC?=
 =?utf-8?B?Ui9ubm9KUjRtSWt3dE5Na2hYTmkzUDFVVE5DU3I0a1E0OHRYeTVZZW1SN0lB?=
 =?utf-8?B?OTJKSnQ0TjZkREtqNWM4QUIwWUUzM3RpYUdsNHprOFh1bjEvcmFYSHlTaWZ5?=
 =?utf-8?B?RW5HeU1iSXJCQUk5OE1JZCtNcThxTTFJeUZNYUFERFNLUi80TFRGcmo4L2Q4?=
 =?utf-8?B?aTB5cnplNEJXOER4RjFwZVQ0aEF6MGsvM2xGSmRIaVcvTEVuTHZUbll3S1BJ?=
 =?utf-8?B?bUtPOUpFK2ErTmJrR2tmWjVKVGEvSUg2eEpXekFTYkk1Q09tUXNPTTBrL0I4?=
 =?utf-8?B?NUkvR3R5RFZzSTVweWRNd2Vwc2FRZWpvNHB0cHhUYjcyTTlPWDlvVEtoQStX?=
 =?utf-8?B?d3BlU2Q1WHRubG5mSm9NNnpTMXJBOHc1SnlrSlROSVVKZmlvSEZmTTZ3YVV3?=
 =?utf-8?B?RTE4WkxpRHVIaTYxZzhNVXYwaGl6Y295ZVpZajRqNXZwUkxZN3pKWnl4eWRZ?=
 =?utf-8?B?QWZaTDlrRllyYm41bjZUZDFNNUNPNmkzZGttTFMvOERwZzZVRGorZUhNYXJk?=
 =?utf-8?B?MkplMkI3WkhYNnZJR05GSUVkNmdWN0NMNlFHSW1YeGV6RFZCeUt5MmV4Ky9q?=
 =?utf-8?B?c2RDaGtqem9weWZhU05UdXUwU005czd6RUxjWmRNOGxHQXpTdVNFUHNHa1FF?=
 =?utf-8?B?NTZQNG5KQUgvSG93dXc4WnRteVZlNkM5VnJOcys4L2tuc0FRUjBlM2xURnh4?=
 =?utf-8?B?WnNjU1Ura083YmgrQ0JSbXZ6dFBoUzlzbWJFTXJwUm9FcnNtdTJmNkNEamRa?=
 =?utf-8?B?ak9vRXlHQ3hBbzFvc21sd1p3QnRyQnc5OGJwRitZV3BDOG9jN0tNSFQ1ZlI4?=
 =?utf-8?B?OEFwVE5KMzlpZlNEM0lmc2dSYThqWmdFVjFBVjlaeE9xREFKRTFkOVV0YXRa?=
 =?utf-8?B?UG9yLytaRXF3bnZLZ2w3eFJNYTA4UEI0SFM2eWsvZUNETk5jZHlHd0E5MTJM?=
 =?utf-8?B?VHZEMWsxYjQxekcySEx4SnZRNytVYi83UVZQQ0cyWCthL2tUZy9FQTYrYjFV?=
 =?utf-8?B?cCtBaWd3dG1oR3FVMXRSVldqMllCNWFFaFNtN2RISlRvUCtoYkE0Z1hsUkc1?=
 =?utf-8?B?ZFM0ajU5Ymc5eGF4N0tReXo0UExKOVN6eDJnUXJBcS8zTjJ1eWtNMnpyY1Yx?=
 =?utf-8?B?M1hzZXdyT1dtc0FUcnRhbzhoQXdYKzV1T25uZVVFU0Q3Z2FBSXlNbFRGZk01?=
 =?utf-8?B?N3lQdVJMMnNMVlNXK1g1dGl5SkR4T3o3L1NiWVZQamJRaHdHTUpBLyt2N0FK?=
 =?utf-8?B?NVYwbk5HMXRiQnNVdlBmZm14TjJ1UUU2SjM4LzZNZWN3YSt2a0ZMYmlaZG5P?=
 =?utf-8?B?Z3hJdXhuelFxeFR3MWNBcWJEREp6N0tkTW0yVXRZTXFYb1ZsUlBpdlBnTlhP?=
 =?utf-8?B?V0JKVDBFQlVoY1llVzVORVZEQXlNYVBRQjN4bFZDSnA3UVZicStsYlRESFoz?=
 =?utf-8?B?VitUQVpqVFkyRWdiWmpFMUNSNlhlWjVFWHBGRXRGZVJrSUpVT0NFQkt1Z3pv?=
 =?utf-8?B?ZmxqQ2dmeEpPU05ENzFnVTdSRHZPcDVKZlN1cDB4RU9PVktJQmU5NVhULzVV?=
 =?utf-8?B?WWNTRDZBc3NtUVVSdTFKRHU0SUFiWnZyNHAxTjdEd2R2RWV1eVJRNmdMUUpB?=
 =?utf-8?B?bCtwZzJuM2JPYzZUak1vTkwzdzlZR25oZ1pUVHpPQVZqRFhQdTI4Ym1WMEt5?=
 =?utf-8?B?d2RkbzZjM2hFcDkvZGVib3orQzU3VG5DeE02cHVTZ29yaGlGbTZvd1dCV1lK?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 733c46a6-9acd-4a9e-f1fb-08dc3e3d7169
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 00:27:59.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVAUYdaRoa9XVZpZfZvLbjCrdjUoO7Rlo3SU0Pf2hNejXnMcPs55z7mDDCPjjHjBoycX4CsDtkwukfvGJQBDxSIPG0ZkXaLtj8dV/2iDdfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com

On 3/4/2024 6:22 PM, Erwan Velu wrote:
> I was also wondering if I shouldn't subtract I40E_PACKET_HDR_PAD from
> the mfs to be more accurate, can you confirm this ?

Yes, you're correct, we should take the packet header out however...

> If one can have a look at what is the exact procedure to fix the MFS
> size when too small, that would be lovely/ideal in addition to my
> patch.

.. as you allude to here, we should resolve the MFS size issue.

You were on that right track (as mentioned in your commit message)

 > To fix this case, it would have been ideal to increase the MFS,
 > via i40e_aqc_opc_set_mac_config, but I didn't found a reliable way to 
do it.

The ice driver is doing this with the ice_aq_set_mac_cfg() call. You 
should be able to model the same here.

Thanks,
Tony

