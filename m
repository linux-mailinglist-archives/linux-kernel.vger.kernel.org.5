Return-Path: <linux-kernel+bounces-103942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487F87C6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C661C20DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D83C35;
	Fri, 15 Mar 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gj4ijAWT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560707F9;
	Fri, 15 Mar 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464016; cv=fail; b=OUlDmu5XE+pM7dkTMKpVfwOyDZQJWMaUsJBtzxGExUvEXDIHv7csaemBvKPje0Z3qFZ5gDV5tKHkUzO24iijTexqM6gI7568tkLvlLKH9wmtHOKzfo/6NP71guGAKFV6bzncoxk9aGTnJr9YbwknXCaXTmbty26aU8PEQ/ngCTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464016; c=relaxed/simple;
	bh=36qJ78HWYqzkkFOUKAx/JGMbAAtE7oHSc0Alb/FO00M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVjjXYB4buVzGjS4aJ11qVuKi5Q5U3VdarLujCpPbR4g+rIaw290e6AaWS/hTNE2pfX472dNZw3fgPvz3cUda+A8zVhCYh0mFYHRbSd5/Tyvp3uvHxF2dB9NfANVmKrzPkcPtRboNKAS8t6DUA7g+iiEFUqUosCq80XH05WH4KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gj4ijAWT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710464014; x=1742000014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=36qJ78HWYqzkkFOUKAx/JGMbAAtE7oHSc0Alb/FO00M=;
  b=Gj4ijAWT6aN+BOKW0RfnVnZOEdY1sedoDuj1b2tzEgUIq/5nWwVYyK23
   V90e2gAcVJXjjmmVn9eglAYDYLGK2yj9jNVCQDj9eZghUoA5XNE7TMphL
   cAZYrleaKrXFelfJiMyiy0MGBXDKAMMy3vtUtpGXnXlTJqMEafPLRT6tK
   KJLesKkTrad+JIvh8MWZm5Ry0OMFhWiLP6Nz2k8mEhXr2cnIeggrTII/C
   DsBKteacvt9Ni7eAv2ZMIXnVWrXs1NoLFSCA1ATU0Lbr5Hw1Tsd/eLdzp
   V++oTaMgfYZCTIn2hB9UVKdkIHEhS6IPxpaNQ0Y+rB1TbDIhyqCKFKlm1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5451528"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5451528"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="49936498"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 17:53:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 17:53:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 17:53:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 17:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kthgWQc2MtAtUBBtMiYefsp0rZvEMpipizLnTo5ziD3ukZLE2dsJPPoCwwIgpPOham/8+JPa41VCfewhh3vsMvSNiRHknXmS+TYtOr4W1UgDMVSw+WEuNcErOMMUpBr4X9tNRe9qHRACQuuGgYIReawWrXA2opg57QMTro12MOvOFKrf62wZ+Yu69++1PXWkWv4zDscBVWpMbLJwAvKqx0xWRyuv2/pb4OBjXfo383EwgF21qmAk92CIAIi2lC+4IHPWLJjckt46adUSgfqRpmeCrpA4OQcI/HyHmObEv4cSoruA7RmqcUenxazZa8WB2S/30xRNicoLNAyXjOX1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzncVHwtNn5wdHTrxlpN8a/WePB5Al1YRYtdoe42/cc=;
 b=SAHm0qlGc4MFfRlCcy9M7iq4+4VIzH9rQC+QEeW4ZAMHm4wo9jyuvdSH9qdY/PiFTxbfcYA2vjowE+VK/Ovoc8uqqDsO9wqMXzpGeDuTydlY6oyQmdVKwU5rLVdPh3RdWtwGt8vtE8iXzkTLOVkQpeH4vLhKcDyLlt1RWkebsNtCGArSybp7suC/CrEmvK/xDYV0Dlpm2cbpoSqg+/24GaG9N4olz8fwJTp71UFSMn6lUU2yDxos95RdUtxMP/m9Ngh7iPxp1c35Kv61buMXZCIvaiG2/rlXRy1c06Z1XoaVUoH5OIPZmtkKwp007ZK3IITb30PrHpoodMq/O9kKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 00:53:27 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 00:53:27 +0000
Message-ID: <0249d506-6ab2-485a-b95f-6e32e5a92d9e@intel.com>
Date: Thu, 14 Mar 2024 17:53:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Enforce software interrupt during busy-poll
 exit
To: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <pawel.chmielewski@intel.com>, <aleksandr.loktionov@intel.com>,
	<mschmidt@redhat.com>, Hugo Ferreira <hferreir@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
References: <20240313125457.19475-1-ivecera@redhat.com>
Content-Language: en-US
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240313125457.19475-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|LV3PR11MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c18c4f-0165-49b5-ee1b-08dc448a5369
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Fjwm3i+ogMIhcJLJtVOMqBQ1y1i/G4J5es3gY7+9oy0IEUXLt96H40HqbO4H8KVartnYNwjcB7A7c2rHdH03V/4FaqJmeohgOMDb+wPlahFZZ/GP7NfAzOJmHkNkVLQ0+FQzifp/HQdbjPAOb4RBozYczChqg90CSHMq8W1BcUmnZ+ROqPi879/FDfSGG3aZeByZxpg9SXEAGwynVMbSWeaNOTVSoBGezlJb1PdMve8AfTAPtkiNor81Gq8LyK+yX/6bI70A7H+h365SU8x4t5/twZFMqeyhhRFVmc2E0vOLRCkslUIK0R/3BsTwHqdUC7IY0dtNUqowbWosHFRZgQIyZidHLc+QmkzYPKTFmUq5g/x+ar99+ZktivBYqPAyl60hDePZAGg+zQ7Ia83z5IuuF38Ca8DcvjP//qqK08kuU2MxeFnLoJYjn4bH4D50MVp3qfEoQAc7cHnVslrJimM+H1CieiJr2y2kREabhQYy+HX4U73I9/ucJ+TsLXpiYPJuIv3fwLaCvwHeGsb2EaPzmGIoe5VpcJktMfd24hpsBJPrlDVf7mz10gx7Nrs7xMCiel+akwY7YQ3SaIUkhv+BMwv3QbdiQR5b5gXcCVuUegokshWqQWhDZejUbPZxdOY2xlg+UO0M7aMODRn+xQ8Emwl3G6hHII3Z9d42FA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pjZHRsTlNkTFMvZWJUZ0piaG96bWIwSldCY2MyV2g4dlZ1S1d6Zmp0TU5F?=
 =?utf-8?B?MVo4cFZUVkV6MDUyZzRaMHNwSHUxb0ZJMjhlWEh2dHZBWENQSktDb0pYUlRQ?=
 =?utf-8?B?bEVzdlJ0bmFMUnRmZlIzd3Voc3l4SnlFeU04M2x3dDhOT2UxU0tWZzRHN29u?=
 =?utf-8?B?ZHZ3eHZSSTlzaUJkZ29YeDl4N0FsUzJiRHNtT1Y0VldlN2NiVHNFSkFDUHly?=
 =?utf-8?B?bCt6cms5NElqMGxFOW5ROFlObnMwNjNGZUNqOVRDY1EyTGlSNm84SXFOa1Fh?=
 =?utf-8?B?SldtdnlldGhuY29QYmtiRHpkZWxUMnBIQmNlbzJRRkQweUl2bkxMTWU0bFhC?=
 =?utf-8?B?NCtJMVh6L3hsdi9pWlVBamtsV2l3d3lGcTVZT0RhWXZWT2ZWVzNuSHl0M0pl?=
 =?utf-8?B?NXljTHkvSXlZaFROdU1FekVsSWt5ZUN4dU95ZnBDdGQ4czRJNjlVVDFheEZ3?=
 =?utf-8?B?d0owZEF3Uno1SmhBbml0STBWdUMvdEVqYlhJN3I1c1Q3cGxxbDd1b1I1TUVY?=
 =?utf-8?B?b1BCemdyMkZkRGoxNmZEMEZnZ2cxSm40M245dXp0RFpReThsVURVenRtMFFY?=
 =?utf-8?B?YlJBUHdRVHdGQ0VZamhTY1ZZaHQ3UjU5RitXMjY4ZGViWVlCcHR5djl4NzhM?=
 =?utf-8?B?K3QxTVFWUkZML3RIcFUyVXA3MW9vRnBqT0x3M0N3Y1p0VlBaUmZGRW5EZnha?=
 =?utf-8?B?d05kK2VKUytITTBaZE8vZUZkbk9WclRUdSttbzlkM0JnTmU5OUlZNnNPdGNk?=
 =?utf-8?B?djl1N0ljbnM1ZDFReDNIc1pRSTNzaGxuZEZmZmQxeDVIMlNJMXlBU2liUEpw?=
 =?utf-8?B?aWxUTytBSkhHVWt2elQ3UkkvTnZ1NWtiZXQ5WEJueVViMFFTSHp0RTh4N0dr?=
 =?utf-8?B?RHhWWjc4M2lWWW51cU1GTTEydWtpaENLSlp5V0UrUlNkaVBTSWdkVDNFRHV5?=
 =?utf-8?B?SXpTbGxsRnpod1hvc1NvRmJhTEpJVzZDYzZ6QXdXSWFQZUJqbnFSL2MyRWpI?=
 =?utf-8?B?MC8vdEVNa21GTCt5R2dEUDBRRnF0ZDAxVXY3cUN3RHJwYXk4Rk4wRlN1RkY2?=
 =?utf-8?B?NWJXZitmeDJLdi9yUUwwdi9wUlprbXZVZGIyM2tXOUYwR2pvd0U4VnhNT1lp?=
 =?utf-8?B?bS9ZWlAwS215YlNFUnh4T2xocWY1YnJFY3JPMzlEZW1ZSGd1b1JQU0g3T2NL?=
 =?utf-8?B?bThzRGNGWXlJZkM5dkdvRmtISDdtemxVanI3MjJROTM2ckd3eUI4NCtwbUt6?=
 =?utf-8?B?SmxsTC83aGkvUXFZR25JcW14QTdNRzNmTm5jd2ZLNlUyWGNHeEtaUGZrTnla?=
 =?utf-8?B?Q240d1QzemJwNHI4ZlNXUmVXOTdUcGwvUUNtM0VrcFR2RWhJUmUrWnNsOC8r?=
 =?utf-8?B?OVZ1MkthMEZHUmFaWlo2Rm0wbHFXQ1dDaE5EeEJJNXpiU2VMUDZqQ2l2eVIx?=
 =?utf-8?B?MXp0czM2QWRLdFVTNjFXdmpVMkczRjlkZVNzVXRuMkVYUlEyRjN4ckw3RWhk?=
 =?utf-8?B?c3UxM2RiUXF2VDVQV04vL3lIQTlONFBScEV5cnFkMU12L1pYcnNBY2FxcE9J?=
 =?utf-8?B?SCtqbWxBajVKSTUyOTI5SjJHME1PMk1jYklaWkJDY2I4UGZoRjZacXYvZmFY?=
 =?utf-8?B?Yzh5VngydnBZNU9PWXpPSllRVlRSZTFtZXNvRDNWY04zRml5Uk5wUlVqZWRM?=
 =?utf-8?B?NU15RThrRXRYRlBMN0lOVHZmKzBZcDh0cUE2SE1mL1dGOXhMVm9nY0JlNGNa?=
 =?utf-8?B?bWxad1lwTHFTVWx5d1JHZUJSOHJXWUthcEc2bGZYZFdmL09PZmRuVXp0WS9P?=
 =?utf-8?B?clNTdHNDdmZBdnBZUFZ4aGJVWS9YUDk3STJVVVJPazFNT20yTDRTNUl5dVhy?=
 =?utf-8?B?QkVkaWZoZU9YWjFTckVFVFRrNC9qT2g1STl3SVA3RE54eXFVNUdkZEpLWkcw?=
 =?utf-8?B?WjdXNnVBQ05hNklsa3AwVXc0Z2VhTCtBd3VCNWlEbXRJNU03elQ4eFlxMFBX?=
 =?utf-8?B?ZmdrL1FPZU45dWdmSW5HTyt4Q2lpbklnNjVjZlVJcDFROVVrOGJTQlBOb1dE?=
 =?utf-8?B?bytnTWloS3B3TU9TSFM5emxPK2NmdDZnWVhab3JDNFlnbkRTNzg1czV4NVZx?=
 =?utf-8?B?c1V4Q2dJblNBWW9tcTB1MXpudlNraUVVeThsL0puRFFNbGNmN0U5clNXSXJW?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c18c4f-0165-49b5-ee1b-08dc448a5369
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 00:53:27.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFx9I67pWHd65PILj1AEJy27DKcA5X+6X1ylxQzqI8kb6qaWBplfpVFDwwzGh04pc2xSRepOhYjh6RkcQGIcgq3CWR79T12OzTM7jtnPWeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com

On 3/13/2024 5:54 AM, Ivan Vecera wrote:
> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
> during poll exit") I'm seeing the similar issue also with i40e driver.
> 
> In certain situation when busy-loop is enabled together with adaptive
> coalescing, the driver occasionally miss that there are outstanding
> descriptors to clean when exiting busy poll.
> 
> Try to catch the remaining work by triggering a software interrupt
> when exiting busy poll. No extra interrupts will be generated when
> busy polling is not used.
> 
> The issue was found when running sockperf ping-pong tcp test with
> adaptive coalescing and busy poll enabled (50 as value busy_pool
> and busy_read sysctl knobs) and results in huge latency spikes
> with more than 100000us.

I like the results of this fix! Thanks for working on it.

> 
> The fix is inspired from the ice driver and do the following:
> 1) During napi poll exit in case of busy-poll (napo_complete_done()
>    returns false) this is recorded to q_vector that we were in busy
>    loop.
> 2) In i40e_update_enable_itr()
>    - updates refreshed ITR intervals directly using PFINT_ITRN register
>    - if we are exiting ordinary poll then just enables the interrupt
>      using PFINT_DYN_CTLN
>    - if we are exiting busy poll then enables the interrupt and
>      additionally triggers an immediate software interrupt to catch any
>      pending clean-ups
> 3) Reuses unused 3rd ITR (interrupt throttle) index and set it to
>    20K interrupts per second to limit the number of these sw interrupts.

This is a good idea.

> 
> @@ -2702,8 +2716,8 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>  	 */
>  	if (q_vector->rx.target_itr < q_vector->rx.current_itr) {
>  		/* Rx ITR needs to be reduced, this is highest priority */
> -		intval = i40e_buildreg_itr(I40E_RX_ITR,
> -					   q_vector->rx.target_itr);
> +		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
> +		     q_vector->rx.target_itr >> 1);

so here you write (this is a new write)

>  		q_vector->rx.current_itr = q_vector->rx.target_itr;
>  		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>  	} else if ((q_vector->tx.target_itr < q_vector->tx.current_itr) ||
> @@ -2712,25 +2726,33 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>  		/* Tx ITR needs to be reduced, this is second priority
>  		 * Tx ITR needs to be increased more than Rx, fourth priority
>  		 */
> -		intval = i40e_buildreg_itr(I40E_TX_ITR,
> -					   q_vector->tx.target_itr);
> +		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, q_vector->reg_idx),
> +		     q_vector->tx.target_itr >> 1);
>  		q_vector->tx.current_itr = q_vector->tx.target_itr;
>  		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>  	} else if (q_vector->rx.current_itr != q_vector->rx.target_itr) {
>  		/* Rx ITR needs to be increased, third priority */
> -		intval = i40e_buildreg_itr(I40E_RX_ITR,
> -					   q_vector->rx.target_itr);
> +		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
> +		     q_vector->rx.target_itr >> 1);

or here (new write)

>  		q_vector->rx.current_itr = q_vector->rx.target_itr;
>  		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>  	} else {
>  		/* No ITR update, lowest priority */
> -		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
>  		if (q_vector->itr_countdown)
>  			q_vector->itr_countdown--;
>  	}
>  
> -	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
> -		wr32(hw, INTREG(q_vector->reg_idx), intval);

The above used to be the *only* write.

> +	/* Do not enable interrupt if VSI is down */
> +	if (test_bit(__I40E_VSI_DOWN, vsi->state))
> +		return;
> +
> +	if (!q_vector->in_busy_poll) {
> +		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
> +	} else {
> +		q_vector->in_busy_poll = false;
> +		intval = i40e_buildreg_swint(I40E_SW_ITR);
> +	}
> +	wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->reg_idx), intval);

and then you write again here.

So this function will now regularly have two writes in hot-path. Before
it was very carefully crafted to reduce the number of writes to 1.

This is made possible because the PFINT_DYN_CTLN register can do
multiple tasks at once with a single write.

Can you just modify intval to *both* trigger a software interrupt, and
update the ITR simultaneously? I'm really not sure that's even possible.

It may make more sense to only do the second write when exiting busy
poll, what do you think?

If there is no way to get the functionality without the two writes
everytime I'd put up with it, but we can have a lot of interrupts per
second, per queue (especially with adaptive disabled and rate set to a
small number like 2us or 0) and doubling the number of writes will have
a performance effect.


