Return-Path: <linux-kernel+bounces-85931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334486BCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CA2285B47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658CD17547;
	Thu, 29 Feb 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te8rNPRc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2517554;
	Thu, 29 Feb 2024 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167190; cv=fail; b=aDR/K15dNK6fgmiI3WdDqxMeT+yJLuIVtPh09/F/E5RhRLENQJSmO9nvtAuovoRjdkqr90mUQJ//euKLs6BvSnRqTIbfPC2yWlOHZlGGfzKvRlPQGclUj2o1P2gDpCG8c0lZnqEN498hgeZWGUVrw8NerARqjc9ORJisnXaT/Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167190; c=relaxed/simple;
	bh=TtOIl0lIBeTUKC6V1fA7GFlfU7EH2pmRfSoA64b7vSU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h4bGU5uTarL3jaAnqJMfavKFnr/6cjCGdYvVT4Ts9VFELSU75/RkHjwI3W+4Upcfj551AZjlM8pKB0mKRFWcz17jwm9NbDfsnt3+Er59tjJRBcxnzRYptnurADgoufvK/lIFwuzaTaH6zeCrW7I4IFqH8c1B+zsYS3FClYJgs20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te8rNPRc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167189; x=1740703189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TtOIl0lIBeTUKC6V1fA7GFlfU7EH2pmRfSoA64b7vSU=;
  b=Te8rNPRcRTgkiT4JBqpRuBhTDX2vvXneDBPMlnoIKNU3yzxOdhW8F4Ax
   hX1CUMSY06wMTcR9jgxHjIbeVFkr+YFoIy6lvZhEMo6z54e4uKbpw3uYF
   JNeEiVMX/XvDxeE/y0zRhjW5tmgukVI0tN2Hxdr7RSbZC1chwJhRHE2jb
   eZ4IhHcCIGToZi8eiZGY2kLHLaGOZkYx0UdNl4Vq57p3uujmQJPVZet9a
   sLC3EJj8SuMoxKQbnOXks/iOqFZEFVrb3SaKCDjGrW64Qpq4eNOXaTA6+
   HlwuvCQMtmR5xqbAqFbIkbY+Jz5gBXXYZDSBphTVyNAnMxxkba8BYFd9a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776041"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12189708"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 16:39:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:39:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 16:39:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 16:39:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqs+GqhxrmWJxSa0r2m/0+xgoBqh1JbceFOA8J2eETGjrPXujSttoCuD1xBYM0PtfD2jOrPgO4mOo3UFSmgp4pJ+3yaKgJvwzqRxn6ciSbjFubocDNJGyMryNbf7weJnDPQnAtCKSBFcK68V0uSx0VD6COuqjWfRKQtY1wcCJdp0QrY8qT+xztEQzNKdewzZDSd+T51Ln74WznH9cUVcYH3gcxkNxg4xdmwhTjYX3VgxPbKnpcnlPWmcn4F/x84NuDVMvfudLBtOkWuyI4h7+QV3a7gdYH+JHxIExYJNsWrjexKRlkBlDhGMjvOu3IxEWaEvO7RIHMgrzE5JpS6Pgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unRHHNV6W6xtevl/vQ7HMNeAei6fYgNrt4IaNtY3sz0=;
 b=dM33LS+flFI+uYb+f4XDivWLbROd7OkgD+bR/QxDGr9Rov1JDqbAg8W1dTVedMfiX+iDr7E9ym4VMaitsYK5YNfGBffo6FQEPfdbV2zjabP6fKutouXUDAf9L7nA00jBP9swOqZKR7w6b62RNVvJFXtDM9WDqFuYElt74EO1+sGZjUeRwuzKbpqx98lJvQtKxrZ0TFN1wIfKZSSENK+cV0zQrShLtaCWp8EoB9aCfl9CqaB9ofvZ4As5efQ1sPL4O3ethIK/b9qvaMlJVKxLREydYdWz0Bfpuxyi3rSk6rklM6Kw7J2TH7AKmsMs06Ti60ZZ4k0PbNQ5ZDrBR5Q6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BL3PR11MB5699.namprd11.prod.outlook.com (2603:10b6:208:33e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 00:39:42 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb%3]) with mapi id 15.20.7339.023; Thu, 29 Feb 2024
 00:39:42 +0000
Message-ID: <72fc647f-b9e3-4839-9529-dffa2d0bf6a9@intel.com>
Date: Wed, 28 Feb 2024 16:39:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Naik, Avadhut" <avadnaik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Zd--PJp-NbXGrb39@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BL3PR11MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fdf6af-3069-482d-5422-08dc38beeb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtyXYW1j7sScDA9Xr4yj5R+8pBKlzzlPTWiW4Jf1UjhWOwebxOwdeKePv5sdw4Xxp1vUsAKmjcm2O+eK19Hee4f/Se/VBEhBBJVXTtE1Vu4DLXQkJU/Vw243rClx/8noIabwptUS/e3oFy+cn/zHE1rU9rU3isj9KkN3SbMRhv84tEEN0pLoSfsxUSHf0sPx9YxlfK5piFM3IL5UuimivhHO5EWIjvlq+Qgj10FnK+Btz5gVBXxQEdUxVcFA5p9i3gOFX7URhDct4AnHAXkZyKjFgB9sQd9iQhcuruAyc2exbYaEAcvt+E11k2rhcIEUoBOpVLLzQAIiO29AZCx7qOur4KK3BtL/922FP56hrJkYpPS38X5Cd0R8CrYiiEnC/ci98ZRUFxiPi8OtIf+XiU+Do6r7iYxI1KOE0ffB9B4F2suRxKUIP9JSTSmzmn/jSKS811pYCPC7YfJdiuasqLrMpLsRY8Ee5P4SasX4hTQtq2Pwj9luC47V9I4ebQCO/nSPDXKEYS4ldEMQcuUwvcoHDwPW24eUYvCHn7Zguo4YhdxWI7BDjuZy9rQnf7Mad1XpE3vyIKvlcIzc9qXuCLmszRvEfOL44mrf1yV2Ij7oN235LLuFqQWBv/jWKu5Q6qF/jvE27ANelgSKSi0jQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtNQTBmczR3Wm95OExtSGJQRDQ2UkNHdUkvd0xVUHpDS1FUWjRac3NHT0h0?=
 =?utf-8?B?UzlyMzEvd29uNjZqMFJqdEtLMDdDRkR4NUVvUFJvRlo3UUVWSTRtTEowUmpp?=
 =?utf-8?B?enJzaEdIUVBDRzFjV0xiNlhsUXFKTy8zaTRiVE1iUUx0bk5jaFh5T3Z1UXYv?=
 =?utf-8?B?RUVFaVJrRi9KUkFwMkt3SDJDZzBORW52eHBQRHBKR1kvaGluSTFpOHpIVERS?=
 =?utf-8?B?TWROQm1OWWd1WEsxc2JhOExrU2MxM0lraG5DTEk5L01uUTZiTVRyWStmaC96?=
 =?utf-8?B?K2JmTGtrQnFYZGltbldTSjhvR0Z1SHNrbkdsR1hGcjVlY0NxeW9ndlpQZ1RO?=
 =?utf-8?B?NkNPRUdOQzlneE9ocFNXRG1nYitkMmxyM01zd1JnOWlldkJzTXlzOExZZjFE?=
 =?utf-8?B?ejBGa1lHd2prek5MWnIyOWk2bHZmeDRvRzNoMG83aTQyNFpSUEJGaUFsRUtp?=
 =?utf-8?B?c2ZCODY3ditad1c5WHBwblQ1OWZPdU1LNjhVdXR3QzJBS3pOSnA4dXRWSW94?=
 =?utf-8?B?UnVXSjlVZ1F4OUdISGdVOWg4VW5hRFZndHBzTExXdENwTStLZDJFVC9OekJP?=
 =?utf-8?B?REMvcDhEN3JZcUpVVGFuUTR2RHhweVRUaXBVUVZiY0F3aXdLUFo4WThRUUNa?=
 =?utf-8?B?dExJdXFTR09kVXZpMkY0MWRKVDFUb3BRRmw1Rkcyd1VSV1gwTGRqVmt6c1l5?=
 =?utf-8?B?ODRRc1pkdkI1akNLNURiMGxYOWVDLzllbjZMcDBxc2dWRUxUWWw5cXJEM0tm?=
 =?utf-8?B?MmVBdElUUmVCQmlKZ1l3dU1ZM2M0UHFTQjdPWEVvYWlSN2RsdGRJTkRaQ3dT?=
 =?utf-8?B?WFBiSnBnL05CRjFvUDRWQ2I3QVZtbWJBTjZidklTL0ZVY0lDaXljLy82aXY2?=
 =?utf-8?B?MGRacGRvK04zbWZlSWZKUXVxaVN0cDg1Nk5VSitaU2QyNW16ZmZ0U01pT1lC?=
 =?utf-8?B?QUx6a3hRdW1uczJFNDhHdis2RDY4dFhQNU1EY1RtZUw2a3lFMHZKQTR6Sm1r?=
 =?utf-8?B?bllPQjJTVCtqN2NpaDQrTmFJSzlyZHRsT3pPaXZ5KzNzZGhuSkx6V3h3SGs0?=
 =?utf-8?B?Qm9TQ2xmU2FZWlNSd0hiNmloMGRkeStiRVgxbHRRdXhBaFhUN1VNaW5FMXFM?=
 =?utf-8?B?cVJsVE5zbVJtUHpyMW1nbm1EenI1Q05IdGlDYytiZzVjRldYVzZvVGlDMjUz?=
 =?utf-8?B?M08rSk8wZi9YYTJKRjlUK3NKN0Z4dnVSajZPb3lybFkvdmZEQk40OVdkS3Nx?=
 =?utf-8?B?MDBucGdtTFpTQUdDaGFjY0RvZmNDQ0xqYW9ST1ZUaE1IOTBIQ3FackR0aVBF?=
 =?utf-8?B?NDNyYm44NGsrVGg4Wis5eGtvZW9pTWt1WDZiTW1RcUJEdlc3aGdPMlZPODNS?=
 =?utf-8?B?V3NzQ0Z5MEZFLzNGMVY3VUF3YWNoWG13V2VyZExEMGlMZHpUUXQ4STVIa2hQ?=
 =?utf-8?B?aDFxUEljRmFCUzd3WkJ3MGNEYVcwb01oOHVhRXVsQXFhR0ZDeGUwL08wUU80?=
 =?utf-8?B?emkxUkdQOEZrSnhMdGxIMy9Zdy9mVnJFYm5wMjVoQk92WjhOYkE5YmVzakJM?=
 =?utf-8?B?MjlEVkcwMHNCWlFCaGpQZklMOENGc1RrT3hYZnpVWlJtbHprMlRjZnFjZnVI?=
 =?utf-8?B?ZG4wNEczdGNwQjlaOFVIZSsxRzRlRGVhTWZoYnRTcnlOU0Z0amZPeEhBcnVG?=
 =?utf-8?B?ZkRmNTlyS1RSeWdhMDFkSWpWVTFkMmtNS2NFV1RIQlR0K1hYUnVoaE81LzNW?=
 =?utf-8?B?MU84VVZ1bys1WXdkVCttTHI3V2lwTkdxMzVhOEtFd2J6UEdNY1RZakd3TlVv?=
 =?utf-8?B?WnRUVEhEdHNwMGRSWi9Cc2pwbElMVVJBMTNiYU1ib3d3TGwwUDdYY2tIZGcy?=
 =?utf-8?B?MFBDL0szamNGYXRDallXcUtEb3VyS0Z3MHNoZ0xVYkR0aExUOG85UGV4WnZy?=
 =?utf-8?B?cFdoeVJySG5uamUwcEliUGpoa05BUVlKU01zY1NlTWdaWUlrUnZnaHpFY0wx?=
 =?utf-8?B?Q0NLVXRLOXJpbUtUdGJpNk5nSm5pQndTNHBPUlJQMjFVaWF6MVYvcTVCTGF3?=
 =?utf-8?B?ZXJSS2U4aFVFSGk1N1dkWmlIaVFsd3E4QVFHcjdOU2xYMUlWVTYzUENDNWJ4?=
 =?utf-8?Q?fRynrTwqLhlBGtTcPWre/QDWC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fdf6af-3069-482d-5422-08dc38beeb4c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 00:39:42.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUgbglHpP3J2YP80ksFUEpVpwpA8qZei9zxiwPGILUz4LZYZR12OOr2VYa9YaKjTzdJijWc6gWp2y/cS38GxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5699
X-OriginatorOrg: intel.com

On 2/28/2024 3:14 PM, Tony Luck wrote:

>  static int mce_gen_pool_create(void)
>  {
> +	int mce_numrecords, mce_poolsz;
>  	struct gen_pool *tmpp;
>  	int ret = -ENOMEM;
> +	void *mce_pool;
> +	int order;
>  
> -	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
> +	order = ilog2(sizeof(struct mce_evt_llist)) + 1;
> +	tmpp = gen_pool_create(order, -1);
>  	if (!tmpp)
>  		goto out;
>  
> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> +	mce_numrecords = max(80, num_possible_cpus() * 4);
> +	mce_poolsz = mce_numrecords * (1 << order);
> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
> +	if (!mce_pool) {
> +		gen_pool_destroy(tmpp);
> +		goto out;
> +	}
> +	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
>  		gen_pool_destroy(tmpp);

Is this missing a kfree(mce_pool) here?

>  		goto out;


