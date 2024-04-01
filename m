Return-Path: <linux-kernel+bounces-127146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90289894770
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47031C21F82
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5F5491B;
	Mon,  1 Apr 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeYjDALp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819551C2B;
	Mon,  1 Apr 2024 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011453; cv=fail; b=RKPKzUD6PeZSyzgiJY41Napl4i/S4undkluKOg9TApqy7mYoGO9f6tZP1jW3rydMY+SvHzMiG1CvfO7Etv2kJ9KpXSA9ST7tnI1q0hGsNPl7K5glD2tSEGEjHx6aqf3UEHcCOAEco7BiU6Xil4z9+On/offwYYBEBH/0+v3yQ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011453; c=relaxed/simple;
	bh=lAACaYlg1J5iOufKk6LmNDOGJuLwuV0xxlOf4CRNfgk=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRgxnqQPb/in9yCfihswIGHiGd5V9baXXsxxvPUp9gncz7pGd9ldOO11glAPjpt4tttnakSPf5J+9tTCNvjsgoZSa1CJqIFedOoaddubV4Asbp9I56r68F10CuoAZkfcCbOmEi+qUpnOx+CJVXU7LTLAkmhXJI6luABp5IDp+Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeYjDALp; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712011449; x=1743547449;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lAACaYlg1J5iOufKk6LmNDOGJuLwuV0xxlOf4CRNfgk=;
  b=eeYjDALpTUIWnp01HEs4Ssn0LCaRUI9/rmpi3GABYJFYmcVFv4bcCV+e
   6bXLQw/7Qk21+ykpz62idrrFHG3g6wK33B5hgHQR/phvKvH/WMsLq/O+H
   q1YiJ4EIPjRTLCMS7lwLfatuTeMyPe2JqDUL/nFZ48HYYB9nlxTVoARTH
   YCn3BdElagUwOrKDu6gwxvFQi8oKGWoTvntrw/qA/+ft7i1jKDtO5oR79
   ZKSprkAupu0p0m4vEc0qmEnugbPCkiyRdRXQ9f6Wff4Lpl89tpjjJyy97
   rLvQ66GRvrgLg5KM5006ibDR2uRnZHHCcZkf2r8jtq6yDD9/QJChaw2cS
   g==;
X-CSE-ConnectionGUID: Fib2mnmXTgmwkccwaMnjUQ==
X-CSE-MsgGUID: LQ+iXPvdTGmoE8l5uiMWWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18605708"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18605708"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 15:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="41012390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 15:44:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 15:44:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 15:44:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 15:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTsgsLQ3UKi6sz/wZL4jFsOnHFO6l6i4fal/Aj7Im2btUXo8pBZd4zvaAY3k74n5G8zYY3GZL/v0BetxyrIlJ02X72YUzRN+wCq7XlrTJdqcIloA61wZOF6GJ+SxGtEHKFmbg1WN41NNY0XBMutPFB4LwB5cPWFEVkmJMa1cPXZNvVA+dPEpzdiYIzOYPTOpyZADzp42jZKyo98/yOK3Shj9oSoWV8InRD+Vim5XoEfEvv/qZqASEGT8a40YP4cZ/9X5FmazbLQABtXUDXqLuKSFJhFXW0BCQOOb237sftA5B92xC17kk7Wps4sFb14ZhXPrmEC5DRGeJScdnToKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH8REjG2bMhoyHhDstBSYhKXegEXgbAVCJxVlQgA30I=;
 b=buBfiOPXk4+2JzcjniCczk/Nvf1fw/+mrqOS0yMupvTdo2CW0AKJjnfByKq5nmN0H8HsYB5FW55jWesbrD2UUYfLci/H659sOYO0Urx5IQZUpjqxLeAVzQIozp/1kAEdM+ZZiIx0Rp5l63l3v4kf2ZGleyLJPnKdD9ZE0Ueh+JADwEmYEwswlXa4eF5YCm7gBzHZuPiqiJ3EORIwUSlbyWSOFSJzhzAqNsalN7scleeP1dLYlbG4tWZjfliRHAOoekqQSh3dzF9ACzMIY/NGlVJZsduc4l/b8eiSVPuNPov4Qqtysa2Y6Yl95fEdSsMtTOdpTw86NtKde812K7RiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 1 Apr
 2024 22:44:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 22:44:06 +0000
Message-ID: <d6a649fd-0bd3-4777-acb3-2b9362131796@intel.com>
Date: Mon, 1 Apr 2024 15:44:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
From: Reinette Chatre <reinette.chatre@intel.com>
To: Tony Luck <tony.luck@intel.com>
CC: <linux-doc@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, James Morse <james.morse@arm.com>, "Babu
 Moger" <babu.moger@amd.com>, Drew Fustini <dfustini@baylibre.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240322182016.196544-1-tony.luck@intel.com>
 <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
 <Zgbe2FFwyHMmmsyM@agluck-desk3>
 <cf59f587-9ca2-4f0d-b412-69b559acbabb@intel.com>
Content-Language: en-US
In-Reply-To: <cf59f587-9ca2-4f0d-b412-69b559acbabb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4796:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCQu/q5Wqc1U15fIboi4N01d/l6CFObXab6KH7373pQb2Dl4e3IoFjua7NLv86FuCREHbvFRBT0zwB5OXHgk3+V8J995z8UK6G5tMemQ2w1XvH5JICg0OQ6NUbPDc+yZABqJQVITN7RzzCJMpK6dKVal4IKKK4i6dYiHL07e9EMa7tTsobGdLQva7Fw6/uzje31+kiCWVoFZdQ5tiPInZwKatdbuggyiW7YOyZdoZWcFTk33ZlNJZmAnU8YBvcuXsrim1G5G3lJLIIysohNDsLjTIMTIeQZgCrDX6EeXRBAAPNtX77vVhmmVFeKuemNUHhHalKj7loPPrk+VpfMktNcrOVqnAWD8ku5PvntW7S3L4DkIWdCdeqd0ea4CuzYMWjeVlJ7B5WrdjbrTlMnvQo0ZrIaf6JGiC5ojBJ25DDRN/emwe+4kPU2HeGseiiGPfnq0aMij4con+hLGdPPRaaFtSViUYAAjKoXVBvExZTtETJBKzaIFZwkTpRR9wgxl8FKQn1maFsTBrQiU+sJYBbAE87lJQZxL2z99FOxGcWXkHVEO1AeGB1dpFwNcTxC/nQUUCYze2pdrBHn8hezOXSKD1WLpzXJ1jC96hvlVUPjSI47Hd5pywfcPdci7/3vF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lGeFFCcmdNZTdITW1pTFJSRC9QUmcyNEF5elJKbVZId2FSaTYvK3BNVFEy?=
 =?utf-8?B?NnZjWFB0N3pnZjRMUWdMRXBDRmpURVpoRDQ2b1dMc2JoWHpOcUhkdEIrUVl0?=
 =?utf-8?B?NEFQT21qUG1HVzh0cm1RTStwQXhzV05qdjV3dElvTU1wMlVra0pZZURKZk9T?=
 =?utf-8?B?d3NrRUt4VmRNSllEUDNXTFhMNUUyWnZNVGpqYm05YnZKWW5YaXdmQXlWV29B?=
 =?utf-8?B?OW5lYll0VVh3aEtFVGFSNHBzUE1jOHptVFRPc01aMVRSSURYcEh0Z1YxbTYr?=
 =?utf-8?B?UG1RTjREM0NodXJJRkFvSkptOVo2ZzNHbjBFTGFiY0JzZzFsUGUyYlZKRU5R?=
 =?utf-8?B?S2g5RUpOSVAxSWFKTGpzZ04wSzBqREFGUzJKdjBEVmMzdzhOK3ZjbGtTSUs2?=
 =?utf-8?B?SDNwbllza0hJR0RKWFhxQUdHTzRSTWZUWXFLdDBuK0lRcVJyTmVpWjhmL3dq?=
 =?utf-8?B?Y0F1WGJOY1dHYWN2cFlIVGI5MHZiTDZuakozeHZ0ZXBUdHY3cUd4SzEydjVB?=
 =?utf-8?B?bk1UbCtPWlN4dnZBQW5jUERqeXRNaS9HWGFkcnZXb1psc3IzR0lNLzVzbWpL?=
 =?utf-8?B?dXBzMGl0Q2VKcXpydnl2a0FKTEVWd3pvMC90MmllSXdnQjBMUEZLV3l6VEJP?=
 =?utf-8?B?MUxZbk01QnFUYjgrZjJNck1HZ2dsTGFOTnhRYm1PS2hDcUVoR2JtQkdTcUNU?=
 =?utf-8?B?MmwvRVdJTS9qSm5lYll3ems1eW1LK2ZPeEI1MXNhZ21YdzZxMTlJNWVzQkVK?=
 =?utf-8?B?TTVoLy9CRlk4a2xIV3h2Q2VZeUdVM05ka25oc3ZBR25wWWVya1hPTnpLaEwv?=
 =?utf-8?B?R1VZNmc3dWtoVEZzK3JOckFiRWdoc2JzS2ZheVhLNHZ3aER4aWV4Z0c4bzBN?=
 =?utf-8?B?WnV2YmNpdHQwZitOS20vTVNkSkdmQm5rdjBRbHYwU2Z2L2dhNzRRWEUyUzZ0?=
 =?utf-8?B?N1p3SHJJMnZFN1NwaUFyZ3NzTDFQMFRjcndpTXd0Y1drTHdvU2RlN3NTeTJS?=
 =?utf-8?B?NEl3RmFFVmdxNUFFWTVGc3M0UVl0Ukh3WDF0NUgwS1crWDFWOG04bkRhWnIv?=
 =?utf-8?B?STNVbUR5OEhJMmhMVEJtamNZTTZST3A1K3ZpK1ZrcGdRU0ZuTzJoY20xVTNt?=
 =?utf-8?B?WDZQWVA0cDNFOFNDdEIyaUJnTmJENzdCUS8rdHVaeUNXU3BKRldyNFR5K3hW?=
 =?utf-8?B?bmtnMU9wdUlONTFiVFlLWTBDeC9LWUtKRE9JWkxkZC95NThSUnF6bUM5aUVq?=
 =?utf-8?B?cjIyY0VLMXhSUjhqdXB0MEpkUU5GVEt6TTIzZnAzT2cveGtINGdzQ2ZqMGw0?=
 =?utf-8?B?MUVmYlJaTnZjdzBiaVNxU24rOCtoY0E2SFMvUjhUZlVpN3FOTitEL3VMWnlT?=
 =?utf-8?B?WE92QkpPcUdmOWlVN2dFZ0wrclRQbjgrcFhJOEFoZGFaS0txRW9sdE4yQUVV?=
 =?utf-8?B?K0FpbmhkR2g3VkplTk1YckFYMmdnVHU4ajczU1dGeVBYQ0VnaFd4d2kzMDZX?=
 =?utf-8?B?enZUMHlCNjNWODBGYjI2Z3hGRWtNSUZJbHhPSmthd0VvQnNGNDVOVWdod2Ey?=
 =?utf-8?B?VndTTmx0SVVtUmZBOGlpTmc2K2xRcUhDMXZpV3dQQUlXRkdoNGxaSW5tVTFr?=
 =?utf-8?B?NThYbjJPNjFLdEEvQTlMZjN5NzY4M0pQVnl4NlVBSVVHZXBJZXFONlNOUnI0?=
 =?utf-8?B?Q3B2Y1hGRHgzdUhmdTJCcXhyclg4M3IyaHM5NHdFSjNJcGJEa1h0NlhuN1VO?=
 =?utf-8?B?bmFNNDE5K2gvRUo2MkdYQjNaNjVMYVVqUVJTMWhwaXRRM1F2MWQ1MjM5Rmcy?=
 =?utf-8?B?MWs4a0tKZzFXano1N2dsZjIxOTE4ak5zZldMQmxWNC81eUtaeEdVUnQ2RHFn?=
 =?utf-8?B?bzdpclZwVUFoWXJ0YWZtYUZDVGZBMXIzc3lSYWZzTmRBSDEyMk05bmN1NW5T?=
 =?utf-8?B?WHJLZ3dGQmkxTElnWWhKZUNxdTVwMEZUbjFXUUR0ZklRaUZZYlRobzd0RDc5?=
 =?utf-8?B?UWh0bzhuZnNyYkVuSWpacTRRU0J2L2tnYm93TnlSYnBuSWhEZDRVT1B0NCto?=
 =?utf-8?B?OEl0eVUyTXkvY0IxZC80bjg0RTEyVjd1T0EyMEN2QmRVS2QzVjNEMDYzNVBp?=
 =?utf-8?B?UVg5L04yaHVHNEVHVDBYV21PS2RaaTQyZ25ncTcrN2Mvc3ozaW9SSGhJNXNL?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ab1d05-b9da-4085-0bce-08dc529d3c79
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:44:05.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wZTkO7qPbiD+iSyoSzqyPAy8FqHK93XJrpjAg00QtC8WmKgiyb1aKjb9PeP2a56nUCfXudJcGVyj83XkYUKeee3M72wVp4j045w8DPus2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com

Hi Tony,

On 3/29/2024 9:37 AM, Reinette Chatre wrote:
> On 3/29/2024 8:31 AM, Tony Luck wrote:
>> On Thu, Mar 28, 2024 at 06:01:33PM -0700, Reinette Chatre wrote:
>>> On 3/22/2024 11:20 AM, Tony Luck wrote:
>>>> The memory bandwidth software controller uses 2^20 units rather than
>>>> 10^6. See mbm_bw_count() which computes bandwidth using the "SZ_1M"
>>>> Linux define for 0x00100000.
>>>>
>>>> Update the documentation to use MiB when describing this feature.
>>>> It's too late to fix the mount option "mba_MBps" as that is now an
>>>> established user interface.
>>>
>>> I see that this is merged already but I do not think this is correct.
>>
>> I was surprised that Ingo merged it without giving folks a chance to
>> comment.
>>
>>> Shouldn't the implementation be fixed instead? Looking at the implementation
>>> the intent appears to be clear that the goal is to have bandwidth be
>>> MBps .... that is when looking from documentation to the define
>>> (MBA_MAX_MBPS) to the comments of the function you reference above
>>> mbm_bw_count(). For example, "...and delta bandwidth in MBps ..."
>>> and "...maintain values in MBps..."
>>
>> Difficult to be sure of intent. But in general when people talk about
>> "megabytes" in the context of memory they mean 2^20. Storage capacity
>> on computers was originally in 2^20 units until the marketing teams
>> at disk drive manufacturers realized they could print numbers 4.8% bigger
>> on their products by using SI unit 10^6 Mega prefix (rising to 7.3% with
>> Giga and 10% with Tera).
> 
> This is not so obvious to me. I hear what you are saying about storage
> capacity but the topic here is memory bandwidth and here I find the custom
> to be that MB/s means 10^6 bytes per second. That is looking from how DDR
> bandwidth is documented to how benchmarks like
> https://github.com/intel/memory-bandwidth-benchmarks report the data, to
> what wikipedia says in https://en.wikipedia.org/wiki/Memory_bandwidth.
> 
> I also took a sample of what the perf side of things may look like
> and, for example, when looking at;
> tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> I understand that the custom for bandwidth is MB/s. For example:
> 
>     {
>         "BriefDescription": "DDR memory read bandwidth (MB/sec)",
>         "MetricExpr": "UNC_M_CAS_COUNT.RD * 64 / 1e6 / duration_time",
>         "MetricName": "memory_bandwidth_read",
>         "ScaleUnit": "1MB/s"
>     },
> 

(Thanks to Kan Liang for explaining this to me.)

As an update on this, the perf side does not seem to be as consistent as
I first interpreted it to be. There appears to be a "kernel side" and
"user side" related to memory bandwidth data.

On the kernel side, users can refer directly to:
/sys/bus/event_source/devices/uncore_imc_*/events to read the
UNC_M_CAS_COUNT.RD and UNC_M_CAS_COUNT.WR data and this appears to
be intended to be consumed as MiB/s as per:
$ /sys/bus/event_source/devices/uncore_imc_0/events/cas_count_read.unit
MiB

On the user side, using perf from userspace the metrics are obtained
from the relevant json file as quoted above, and thus when using perf
from the command line the data is in MB/sec, for example:

$ perf list
[SNIP]
  llc_miss_local_memory_bandwidth_read
       [Bandwidth (MB/sec) of read requests that miss the last level cache (LLC) and go to local memory]
  llc_miss_local_memory_bandwidth_write
       [Bandwidth (MB/sec) of write requests that miss the last level cache (LLC) and go to local memory]
  llc_miss_remote_memory_bandwidth_read
       [Bandwidth (MB/sec) of read requests that miss the last level cache (LLC) and go to remote memory]
  llc_miss_remote_memory_bandwidth_write
       [Bandwidth (MB/sec) of write requests that miss the last level cache (LLC) and go to remote memory]
  loads_per_instr
       [The ratio of number of completed memory load instructions to the total number completed instructions]
  memory_bandwidth_read
       [DDR memory read bandwidth (MB/sec)]
  memory_bandwidth_total
       [DDR memory bandwidth (MB/sec)]
  memory_bandwidth_write
       [DDR memory write bandwidth (MB/sec)]
[SNIP]


It appears that there is no custom here and it may just be somebody's preference?

Reinette

