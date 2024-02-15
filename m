Return-Path: <linux-kernel+bounces-67246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5E85689C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC131F232BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34913399B;
	Thu, 15 Feb 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZLenvuV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D258AAC;
	Thu, 15 Feb 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012634; cv=fail; b=E9RX/pDjxl/wzYanDQT6joiL9l7Fo079Iy0C69TI29/A9MXP+buPpAxMJIXU1so7DAEx+U0tIPzFDSoqOuUaEAz/E/iEjwHhXz4N7zC1xLR/HYZoEnjzGno2iycWB0dshXS3WufQ9lpYPr2EWOLeS0ETm/z5lezPZRBkPSZr2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012634; c=relaxed/simple;
	bh=FE0MsDLkwJSL21m8u2X3SMCSgwC2gAQHTeaoLV0Q7Vw=;
	h=Message-ID:Date:From:To:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eYJFjPDYZG5+XLUjh42jL30qHFQuHbic1E2dpD+MdXd/D6fCpbpnS71bXUVtDyuzef6jTPWE4KqGzjGfglLiRXY7GUbpg/UuPl5R+YlqVnaRYLdYJSVBgpHf6WSewt6lmm1F7P0/MxRojSv/nVQPNuSh5PerWXL/MhKG3brR8Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZLenvuV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708012632; x=1739548632;
  h=message-id:date:from:to:subject:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FE0MsDLkwJSL21m8u2X3SMCSgwC2gAQHTeaoLV0Q7Vw=;
  b=TZLenvuVvk3qsaKQXUq4S9Dbn6SvEzvCSHaP2knpyfDvGAFuUu8TTbcz
   G+8i7fcEonuaPmLO42Yr7GkVCR5eMHynRtfWCl0x4DfXynynYUx9zo/KN
   7pma7Jxvb7PpzYuLSRU3jZv3HrS42SuTEwpsz1tTNWPCQ2jo2gJqsjN9g
   1irTXvouzpa5RBqjMrGk15Xy124GVLDTgxMKGs9XyG0+mf4WOqtPNCVnF
   ell2eDURuN4pWtQOked2iWsUgeyyurY8o8sQW8Vv+8Do4g1A1g+N4oIPn
   cD/JlSuIqHeqKatwfAg29vK5OEL2FFev5mhZP8lumyBnrfCNH6Ec0xGh2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13205096"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="13205096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 07:57:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3952479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 07:57:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 07:57:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 07:57:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 07:57:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFx/rXZk4Hv4uj2BRL9hcKABdxpKWpIJFKPjxb7rvRmRjczj9Eh6IciniOF6nmJXXr0gLOtrhKDQbty/NOghlkG0Tuduo+sS+DXKnomkKm/nnsMMiAsqZpGAXTcvWRK+mOYpmG6AXFg37KOeBBgeRQXCQ39kBKWe8FcxE9tvrHLBBQ5rzeg+6myG+N7E6XLz2UzS8YLpv1Wa5PMil66eDHmp6TiaZjO3j/KFUdf6aLIrwcTG5SXSLgbsaJplmQM4WInUI7DQ0YmvLVAix4a46CSkTV75Wr7Cw5h3dSVfWPm1o+bxseIUJIBKGmmLprYokJSn2aYhFfZZSy6PPo6N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzH8ug1+MQt2JC6WhzR5MXoQy2mVdI/HBWcHb6ZtGUs=;
 b=Z5VaTqn878HgXMuSXgQVkdJ0zlHIdKg7jBSAx5GpxMbrBq1r0cS3UAQJTUNtxCt9YDbMNAvGZkJWoR3F8MZLlMjveQqXKaFaQXst0xcBqfk/kIcB688pqsZwpUAmNm1JQ25CziAFfD1/6uigo+QO33UMhDOkJBgCHLbTVRy05T/9OC0Q7/LugquGkWCHieHarV5VsYL+K9HyDtLyiZ7qTB+VjZhlCyv8jGGpVM8plAX5go3tSv4l2nR/r0ozHtoUDpsjn/DtJvBEtju+0te00rcEO5+GsTIbdehPkh7+LCFtvdMp1gyb21Nk2tcS6c1+PEba9i71UVJ/ypqPuKXtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.35; Thu, 15 Feb 2024 15:57:00 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 15:57:00 +0000
Message-ID: <bad0da2c-546b-2e05-feea-d395439a0bb0@intel.com>
Date: Thu, 15 Feb 2024 07:56:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: <anthony.l.nguyen@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Takeru Hayasaka <hayatake396@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mailhol.vincent@wanadoo.fr>, <vladimir.oltean@nxp.com>,
	<laforge@gnumonks.org>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH net-next v8 1/2] ethtool: Add GTP RSS hash options to
 ethtool.h
References: <20240212020403.1639030-1-hayatake396@gmail.com>
 <CADFiAcL+2vVUHWcWS_o3Oxk67tuZeNk8+8ygjGGKK3smop595A@mail.gmail.com>
 <8eb6384a82fc4c4b9c99463a6ff956f04c9d5e33.camel@redhat.com>
In-Reply-To: <8eb6384a82fc4c4b9c99463a6ff956f04c9d5e33.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: d0178c5e-cfde-4246-6a13-08dc2e3ebe9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tp3KM4DuXRqbxAnXnTlOLYst9tXT15h046AY+R4/U3JS5RWzTvacAFjI8U0xE0cAWe2EYJ/0J2Rw/I3fIrNsF6952PyZQdaxzAkKmeMA6+r7Bl314CG11zdEcxyhKrQFNsVgvhLGUHPtFOF5OC3ulLSy/KV/pBl5ciQ8hCVLoR/XwNtMFl/jte1V/LEdQg5hxwxGcdZUWmaN3vDGtgfqkgGHX8LDMTfEFVxcKTywmCDQ7rN7xdQFafcgRX5Yy6SyRKV0MLTOwyjfGuPuyQKhzhytRqogCtNT5Rx887YbnwxN8rrhbdLobRyU9vIvfxHkEn6t+PCizVKDYedwifioAs/GixmeMGSW2JFkRw9jvRSJAQ0eWgMJ31P0cRLh8+Uh7Tl/n55Xz4FtjFrz+Ab38dU3uVDnMpZJrQW9d2H7taGe7SOnhFfV20ByeaCyKShyQ5wyHPXIUBF7ayo4CXxyVvIFfYkHQTMoW3ALuuHgYa6VKkJl+r0GLftafreo9GQmk35WzhZPyYuA5uJP8dtQAD7M/NA8ThrBRAxPkLKU3SjFI/JYVEG8MfR3ZhYp0eLuFXCmMl3xfOPyzTdnCcgL/PQrU+a9l6m4dBP36RH9jSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4744005)(8676002)(7416002)(5660300002)(2906002)(8936002)(83380400001)(31696002)(26005)(921011)(38100700002)(36756003)(86362001)(82960400001)(66476007)(110136005)(66556008)(2616005)(53546011)(6506007)(66946007)(316002)(6666004)(478600001)(6486002)(9686003)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ViRElkanpLMXZkKzB2WU9YZEsxMVFobmc3QWhxNmVLOUJjci96ZVpzWGRm?=
 =?utf-8?B?dHFmeElVYmpKNGw3MENiZXFxWFdDRGU2a2RsVCt0SU1zbHBMeThLdmdNbllx?=
 =?utf-8?B?d0h0Y2d2Q2RIQ1JNMUIyblhuSWgvN050YkFPcHpubjYxZ2RCRGEwdUl4dlQw?=
 =?utf-8?B?NndRc1hENGkvNGpzWWhmdGI0N0tGUzJUSEhza3VsM1RkeU9WQ0ZPWGlGVE5L?=
 =?utf-8?B?NHpSZlpxZ2pVMVRQalh4aWkyczM4alFOckZnNFI5T2hqL3V3QkZUNVdRUktJ?=
 =?utf-8?B?WThHc1daeVdQZmxrU1lxcXpLM0Q2TnVYRzVpTUhtRUVwWjZKVkV6NEhDTUVV?=
 =?utf-8?B?Ym1FTmsyZ0prb2V1NXJPMFFvbytkMWc3OWxZb1dacmdJbVYxcXIvTzlRQ3p4?=
 =?utf-8?B?VVZ6MVhoY252NmlZdEFvMVI2TlR6RWJDWlZlZXV1Z29jZUxjMDdPNktsaVdw?=
 =?utf-8?B?WmpSeXBsQ3Y5eURINmRPdythL2o4WVB3a1I3NnZFcXlodzQ5V2s3YW1PaUZt?=
 =?utf-8?B?MjlpcFRaQ1Z0bWxSVW84WjRMWVR4OWp5ZXVRM1NjamJ5bklvYWFLQzNiR0lE?=
 =?utf-8?B?eklxRHl6RjBJVkxZWTlCQlVjQTdJbUN4UEJueWdCTndQbUpOT1pqVmMvZVFE?=
 =?utf-8?B?WDRLUm5GU08yc3RsK1JKUTkreU5aQllRZVBKcFh2aTdWNEhCS0JxaEpLUlNt?=
 =?utf-8?B?eDg0cmNvNzUyOGozd3lIVGtMVmdBUlpaMUl6K3ZsSXhlS1JBclB0VHljKzNY?=
 =?utf-8?B?WHFBeC9LUnorTmU5S0dZL0t6YXBJOVEwZU16aUlBWE9jU2pKakZ2NUZuYytT?=
 =?utf-8?B?U3pOR0ZCSU1BZnMvQXlNMXhSN3FETmxvQk1pa1lmTVAyejVGbHJoNTJKY0pM?=
 =?utf-8?B?VjJvdG54M3pWbXV3T0sxR3ZYaDBpbytFZ01yTVJKWWZpQjhFczZJQkxVNnJx?=
 =?utf-8?B?NDh3MytCc1pKTGhPTEYvazJWSnBpMVdmOFNCekhsemVaTno0OEZibXFTMG91?=
 =?utf-8?B?QnZFWUVPWjhFSzUrSTdHZ0NnOEZYWlUybHZZL0NENkZuTFAyelUrSndwYll0?=
 =?utf-8?B?dC82bUprK2ovSkNVSVFaUWpPZEc0UlF0QVdiZkgxc3ljeWVZWFJld2NYZ2N1?=
 =?utf-8?B?UUlmTmV5K1NwQksyU01KZnhMbnJ6YmNQTWZSQ0Y1Q0JEbkNlRTBOMHFwQUg0?=
 =?utf-8?B?c1RkUkh5MFVtVTlmZG1uL1hRb21BdFl1TGhjdEJFb2RxV3pmNE9GQjVHNmpR?=
 =?utf-8?B?V1pCbU1yMk9CNWxGUjFrczRYbVlBRkh4VFRTVFFHMVQxQmlWaVJsZ1hIOGta?=
 =?utf-8?B?R3pQVjRSb0ZBanhQTXZmV003Yng4NWNXdm4zY05KRFFmMDMyMTBMQW8wbEVB?=
 =?utf-8?B?Vi8zU1BmS2NHdmxhU0dVYjJVSEhpVEZ6cWtEUDV2RXU1amZzdnU1ZVRaWGlt?=
 =?utf-8?B?Y2dKRE05US9IUENmMVp4MHBEU1oyV0U3Sms4bWVLQVdCUXZrSkpWTGFZTXRm?=
 =?utf-8?B?NnFpRmtyRUhzOEVpR2FYR0lNdGlxR3VGSnFQcmpVQ3BwQUVtUFlOVWpMUmpO?=
 =?utf-8?B?VDVuVVM4VWZSRndlU0hnOEJHZXAvNlp4K1JZbURnOFYvYlZ6S01IOVhJUVdK?=
 =?utf-8?B?NE5TbmNVRlRYbU9vM2dBNW5WQlAwSjc0dVlmWjV6dFk1TW84Rm1zL0NXam4x?=
 =?utf-8?B?N2VBZ1Q4eG5zOHBra2Z3UHhubTl1YWFiVUNQejhJSkpSem5jajVjdkdVV21m?=
 =?utf-8?B?S0VveUovME9qV0RESXBkeXlnSHAyU2RTRkhYeGFlT250M1JreG56bC9IZXBn?=
 =?utf-8?B?d29qeVova2N5Q1RGbEVZdjhEQUcrbVpNQ3RCZUlmNVFmVUNVQmduN2pCOS9j?=
 =?utf-8?B?Z0RGU1lOY2xla0g4ZitQRTAra3hYOWoyWG5OU0k4QVVaNDVQNDVFYWV2YTA4?=
 =?utf-8?B?SHNrNTF2aHMyZ3FxR1dvYUxlZS9jWGNCcHlMbmZrVlZCemRnaHZyMVMwdGpP?=
 =?utf-8?B?Vm5HQ2xsYjhDdk9oNG00TG1iKytHN25sZUVkSUtLS3IrTi9hQzVhVkxWbjFF?=
 =?utf-8?B?cTlsTkZWS01teUVZaUI2aXV5WHFXdkZYeFlpcWV2MEZmRlhib0VWYkcyOGd3?=
 =?utf-8?B?d0JxVUkwbVV5dlZ0d20yUTdBUFgvVzh1bERiN01wZm9DMVoyaktDSWw0VU1s?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0178c5e-cfde-4246-6a13-08dc2e3ebe9b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:57:00.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or5CIiOya0cZAu3qktgjXVeXOOFomAD6OaFpViFy3bWJ3PUmUYKEaGE7ScMtu4Pxm0d08DpLtPyEmcjWx7UhMhCQ/o6dEUUwlY/Poi3ZRjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com



On 2/15/24 2:26 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> Hi,
> 
> On Thu, 2024-02-15 at 17:44 +0900, Takeru Hayasaka wrote:
> > As previously advised, the patch has been divided.
> > I apologize for the inconvenience, but I would appreciate it if you
> > could take the time to review the patch.
> > I understand you may be busy, but your confirmation would be greatly
> > appreciated.
> 
> The series LGTM. I *think* the series should go first in the intel
> tree, so it can be tested on the relevant H/W. @Tony: do you agree?

I agree. I think it would make sense for this to go through IWL.

Thanks,
Tony

> Thanks,
> 
> Paolo
> 
> 

