Return-Path: <linux-kernel+bounces-65932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC58553ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE411C2681B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301B13EFE7;
	Wed, 14 Feb 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPl5wDPW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB95128370;
	Wed, 14 Feb 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942241; cv=fail; b=XIENQil/o3cCkzbjgm52idXlHF4r0eBwzsVC5SAHqVJLsLkYPFzcmJbk/8gjoZNqBKVj6FtbJVLShWNvcHtDkE4tQM7Fi5gTKyJKnUsyuSyw/KsRDSUw2FWOQokUJJOJhPt4FS/Wf3zlJ+7wXfSiBmlp0n2RDOiss29zs7HYUy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942241; c=relaxed/simple;
	bh=GN845PbuO+9jMy6LBPKZoFd33VDaq9Jnc1V/g0ooxbE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Asfy7Lvrg7+aRudfoEzH4cvsW2ml6NEMhE79b2gXQsNi8oUfF5YxS0AVe55XWnBMr4SXk5Koyb4Om6V9RYKhqTFJPyMAUp33ZadJrdpwwG5HVFUvwKiFvrFPSmxO+j+Suny0SrM1BNw7Q9yEUvIC2UnUU0k4YeNqSQ9622mKyek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPl5wDPW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707942239; x=1739478239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GN845PbuO+9jMy6LBPKZoFd33VDaq9Jnc1V/g0ooxbE=;
  b=gPl5wDPWGSpUWxl7Y4PEimSIYbW88RbCbjfm+4p0SpiPwdyHhcTFCQBW
   8S3BOEgMBJ2QtIa9Ff2LObqrBIMGQtKJU3ezvWnU+alWZbchER5v1A6dF
   nVJs04vJu5qB1boo49LpqTDiOdzbTB2Tf7iIx3T9W7Oc427MRDQZ+7GTs
   j5Jxsmp89RcEJWGTKSJcNpDH1wmUEhZ+a+GfO9VqPHyGPRQC0Kbr+x0eV
   /IrZkEosPkfXQnmNQUxVa/DL1xdi8uYLwrFn83I5cIPwIWW97Z8gYEwWh
   lepSuhOQtq4KxnviIL0D0VDI/OgzTpOYQ+zuggJUrFHrHobsDvEUkzHem
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24478842"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24478842"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3588475"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:23:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:23:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:23:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:23:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:23:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy8biyNz/afafqUyttO1I7uItytOpmO8/EW6xEbdW5T1cyro6wdw4C10LAhgUpl1pOCgAz/mqAm8S6D018UcMyUyrgjl/EjeIrxKghw3JDcKCyjipcmL34Awdw7E033jdLFgc9rESOLc6CJBx1Kr9Tk2Bpro0VSdu/J66uxuChUMkOuxP9TZaBtp13KCTNDSujm5yPOQfrFvma3EvXKEA6zP0zhj5Geg2KZLf70WOPMppY7ko5heWIqNOqkenb557LbADuRljWeoDSILb40n06J9oluRuYUYWLp5v74K7nDuajJ1TketWHegP9XEmS5pDEshoUOByM6tCOJSjEFBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwmIOBEKWjY87/utiA0RMGxfa/wPZ0U8es7Fmza7uZs=;
 b=giN4dPuvtqMLstXEqGd+3pJKZW2k5WhuTOTzJwZA/hmP0/1JsMQFbQzAHVMpS0k2Teo+kL/u4u/FiQlZNmslVgzRrgbCX8zQHM8pGYOPA+dsoV5enxlTBT80BiCgG0B6v92m+sEhEySfpBuoo/j+WRtiqKeefrXgzfoSLQTGIZbQR0ZTAgpepTbOYBKTiA5ylFm0R2eK1D4Ym9AToknoZQWGdVN128RmME4wXXbvDhfqNnNBLZELAbrHfKGKSPlVVvUuPz9Uy0tNVfTcCuqpdcPbAUhlmVJQaaytkpgBlercWxdJ6oT8XSyz/JcqA0/MLwuRKqp76BD6Va8QmgOE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 20:23:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:23:54 +0000
Message-ID: <db7932ed-24d6-4645-9fb3-a7c5b743e0b5@intel.com>
Date: Wed, 14 Feb 2024 12:23:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.4 v3] net: bcmgenet: Fix EEE implementation
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>, <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, Jakub Kicinski
	<kuba@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, "open
 list:BROADCOM GENET ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
References: <20240212014859.3860032-1-florian.fainelli@broadcom.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240212014859.3860032-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a626b04-a733-487e-70fa-08dc2d9add4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHhupn4TRAVLFbTEurpLN6MNMmmhye8+E6CkW1d0rqURzS3z58adwG+F1GlXCk+Bl4JokJYgOgVd/Dd6dfxZd+mhfzm72z+wWR8cGoQSfybMlPQAQJSGimZcoiIwn0ZGGW+jVmoMILhdhvsPlvQr1jdsX5a+3c+0ggDwK7bn1LL8+IfRC2bOqriwoUvpId2DVZ9C59XIWVAYRhzgIJ8aViSvRTGnpfdho6E6kpHhWKBM3a3eUbcSjYX6gJaAGuL+ojg4MZy5SACfTiqmfYOPgUqqMvESN0VCfwczRXq5dyI7SbNEg2tgIduxjeOc3/cJeBK/+Fz+oW8vKmJITs6qvxkPxsz3CYq6ilHTEoxfn6dtBL9k2gxki6DxnxxFpOWN+E7AU2uvO+rkFQhwlk8epFW+oLuh6P7Nz5kEt3LAgOH1KBscJhnHSNi8m5aYPzJlcWW2T7n/j6nYrwM9mkX0HxRWPuZCJ5SJwkeTfh/E+P6v1hdrli8G+Bgm9a0WJwbbTdPqkTWBtFUa1Kit9vE6N2g6K/92WLGpigJdsuMLniY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(83380400001)(41300700001)(2616005)(26005)(6512007)(6506007)(66476007)(66946007)(8676002)(4326008)(66556008)(53546011)(316002)(6486002)(54906003)(36756003)(38100700002)(478600001)(31696002)(86362001)(82960400001)(966005)(7416002)(4744005)(2906002)(31686004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hEWTR6ZW4yN2lUVFhSK01TeDBaUTlUeHYybFFwRjdkR1ZJaEdaQmFNd0Jh?=
 =?utf-8?B?Z3dIKzU4NHNObkg3SUsxMzJ4NGJDYkNkTHdZc050KzhiU2NsNU5hWXdnUnZE?=
 =?utf-8?B?aFg5WGZTMjhFNVFMdThqSnBUKytvZXc0YURaeS84Z1dtOE80QkxRbjhVSDBj?=
 =?utf-8?B?bGs1Qk91L3F6dlVCL0hYeG5GSThMc2gza1BWajZ5ek5qZ3l0djR1dTcrOFQv?=
 =?utf-8?B?KzdpZEQ3S0VoMVZabE5nVlFIbGpRQWUrd0sxVHBubnZYbmdFbUxzR3I4OXNK?=
 =?utf-8?B?QW1ZdnR6STJkdjJ2ei8yeGNWSUZUK21xeERNZFdERE5yTy9EYU1ranNFYU9m?=
 =?utf-8?B?K3FZbmp3UytjNjZuRENVbjZXL2ozYytVQUxtSUNVVUNqaUpqdVUvcS9PeHdp?=
 =?utf-8?B?YU1LV25YNEFGNG03VWkzaGtRQS85Rys5dUFDaElSZUw4YTFmUWFYcEZnTnp3?=
 =?utf-8?B?OXVSZWM5ZGdiNTE5WW9TRmgxTkhXVU1CWnJzaDQwOFkxemNzU2pKaG1kdWw4?=
 =?utf-8?B?Mld6WXRZQTBEazdMODdNeHNaUkNZRlA4WExxQjJXUU9GZ1o1eE5oeHIvR2xv?=
 =?utf-8?B?aFVHMTdZOTVldnU0MTJPamZ3NEtVdW5hcytPV2NmQlNvQ0R3MDNESmQ3SmdM?=
 =?utf-8?B?UlZrOTVtQmJZU0duR3FvaVJMUkJRbTUyNXEzaXpRNkNibmRxL2NSTkdnOVNp?=
 =?utf-8?B?eUFsQ2RvZWtPdzA4ekE2dkxPMFNKYnZ5RXdJTXBEcVhxSE5hcTNkZStqYVZZ?=
 =?utf-8?B?NHNzenA1ZkltYW5IckhaR2wyRENwUTR6ZmYvRWl5Z3NSWUVOaU4wZG9yMjh2?=
 =?utf-8?B?VWZTeCtMcVNSYTdzZWZYR0N0R3lGOXlsL3VVOElNMFZHUFJBcm9JbDd0Yzlq?=
 =?utf-8?B?QkR1cDBFMm1FaHVxcXVQOHZpMEN5bFJnNkx4OEY5ZzlUZXNCVks0R0F4Nld1?=
 =?utf-8?B?TWI0eTMvSEsxdFg5ZWlOcFJxMHpqRHFEYnF2VC8xVmgzaDZjWncyZGwzaW9i?=
 =?utf-8?B?TWtYVGdKRWE0dWxJeis0ZC93SjdObnVpQkdyMzhUVkRWV1Vkem13eWlHa0c1?=
 =?utf-8?B?U3ZWMWhpbG1DeHhZNlYxU1E3T1ZMOGtKNHNiQW1iQVRpN2RoSS9RZmFEVlBt?=
 =?utf-8?B?QWR3dHYyWkJ4Sm9wWjcxRHZYeTNNcmdrTldmekVrWTFwVVFRcklzMllLbnhC?=
 =?utf-8?B?QjZRc25tM09rZWRiKzVBOUFNWXdXY1hMUUN5cThVRXRJb3I0NVVQWUY1cDJH?=
 =?utf-8?B?ZjhsVGQ0TFZGZmRhN1dnMC91aDFlMW1sVGFaZnVjVWhqZTArdHlvNjIzcUc5?=
 =?utf-8?B?ekxnRTk5TWk2b0hUVFZJaUl4WEdrMnFudEtKRGtOSkw0V2hKc1FxL0ZvTXM3?=
 =?utf-8?B?MlVGSW0yWUpObytqRXVubEh4bmJvZEllNVUra1N6Ty9vaWVSRFNONzhQYkxI?=
 =?utf-8?B?N1gwb0t2SkNEZjJsa3pYcGQ2MXQya25kQmdRaTNoUnRabkdYUnNVek9SRzhw?=
 =?utf-8?B?NlNMVGN5ejhZdVlwbzMyWTVUckIxVGVUVHdQUGFNcTM5Z1YzSVZ2YlRiRUpT?=
 =?utf-8?B?Q2c5NEVlZldlWXBNQmFBUm54K1U3MmVrRHg2WDFpQlVjV0pwbDlBbytKbmFm?=
 =?utf-8?B?QW5oNkV4OTVrT0srYXBmcTdyQTk5K1VCaHZJVEsySlJuS2YyWXYyc05McUdD?=
 =?utf-8?B?VUo5UFUwb1hncEhYdXBLTDBrVEZTSjlRbDVuR0RpVmM5NUlXTWQ4UmxrT2o3?=
 =?utf-8?B?aHpVbjFhbmxqUGh3T0kySGIvZCthS1IvaTRIOWpGRmFERzBZYUh3YndOOGxY?=
 =?utf-8?B?WEMvTjZKdnc5YkVBOS9oQ0h5T1hZbjZBa2JtSEU4eTR6UE5WdFk4d0o0SWUy?=
 =?utf-8?B?Tis0YmRuQ3B1VEh2WHJaZDZwMFM0QjExT3YreG5RdUtqcEN1M090Z1BLTElk?=
 =?utf-8?B?RlFhK0ZMOTBBRVVjM05sT2kyU09QTjlRSFRQN2RuOUNGNHNhUmNFa2lzek9P?=
 =?utf-8?B?ZGxBeUlBdWhMcnpwQlIwMFZIMlV0ZVlEdmtZaXRwMjYxU2R3OHlCYkx3a3gy?=
 =?utf-8?B?R3cwZmlmdk4rUkVOdUxRYWdpVFpYa0VEVDJNbUx3azJNSVcyWEZNZ2FVcGlV?=
 =?utf-8?B?NTFVaTBNSU5VcTFISTFxdDJPSDBEUDI0aEtYbm9PR0lRaEU2dHdLSW1uRnpR?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a626b04-a733-487e-70fa-08dc2d9add4b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:23:54.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H68fmAgI365o/d6RC2D+mEi/1SrapETfvHlb9YG+Ir6tmswPjZtXhweBMx7rjOhlqUlDPeEbQG799R1J5e74wUxjJmzFB3j9TFYraY825/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com



On 2/11/2024 5:48 PM, Florian Fainelli wrote:
> commit a9f31047baca57d47440c879cf259b86f900260c upstream
> 
> We had a number of short comings:
> 
> - EEE must be re-evaluated whenever the state machine detects a link
>   change as wight be switching from a link partner with EEE
>   enabled/disabled
> 
> - tx_lpi_enabled controls whether EEE should be enabled/disabled for the
>   transmit path, which applies to the TBUF block
> 
> - We do not need to forcibly enable EEE upon system resume, as the PHY
>   state machine will trigger a link event that will do that, too
> 
> Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Link: https://lore.kernel.org/r/20230606214348.2408018-1-florian.fainelli@broadcom.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Changes in v2:
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

