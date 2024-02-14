Return-Path: <linux-kernel+bounces-65938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7A855409
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5AD1F21164
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DDE60ED6;
	Wed, 14 Feb 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiTIQz4v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4818E0C;
	Wed, 14 Feb 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942705; cv=fail; b=FiAdi92KGiTEXTsv23mvB+B12gw4y7PNeDm/p7lQdepdlvzscsBoADu82R/IH1FEFhP6mqs0oPYMq8c4AjkozPyUPG9c4qqmNKo4zoXhGTQNypN5y6pzsB1RhIbSOPdrZPzH+BDHUR8u/pM+vV6pmiQ5xdXN7OLmAIjd2js1nYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942705; c=relaxed/simple;
	bh=6qYmFSJShC3K6Un7FkV402eIO7Z8JG2W3CcI8QNQALA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yo1sKQhkf4YpzokffQlzs5bNApj03j1KYtzPIXlagRKVb4j5MA9uL7HA5HPRTRHbmOpBVvAg8HraOJlS4ZXNc8HkjOkJvTpwDH3E+U6WSNSBUeiS2kUWuh5wzC4zH3TluBTRN/Xq0VLAbFrcqZHQWi4j8h7Y+yCndmQhtrL3cs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiTIQz4v; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707942703; x=1739478703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6qYmFSJShC3K6Un7FkV402eIO7Z8JG2W3CcI8QNQALA=;
  b=XiTIQz4vtn2NiXp9Ixg/p0SiCYtJ2ajbW92WIQes1s4LwKXZW/ivv1SP
   YZJ9XmgPn/wwy4ie5IFUToLJNynhUefLxsMVwYkdptasnJmqHDtpRIysU
   V8L03PVqoqRSbXYsW/Z1wWHn20tQ75qfvYvtl5mEpG/GvPrLPbmcOXs4x
   kTt9NLCE6Fd5zBdeHEVYbWw0FCNQQchWS7FykpYXWLfQsQjMHIVtQhsBW
   xDRFPfZEbbd6v/7rZFXJ+Kds+ktPmtWkj71WBFKVR0lfkZri3GZ5yAS/U
   PoFDhCe8wEP/etV8QCBi4zzx3+Ei6IzLerU70/zSahZEU4mqxbu6RidL0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19425265"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19425265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:31:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="34120825"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:31:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:31:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:31:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:31:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKRbcbGIk+ANTU+G7CheRQApNFD4PQSPeg3xXjkKv79x8PIMPycgtHc7kGMlSO9jH+GljpRsEA3UsaRQkt18OcEvgD44ka/0XNzTSm7QuskUfzxLvAZ5Hlf1yr5kkpBbJSFS298ea/j3DsuIiMzgXtaAGod+rkjHJz1PQ1c0nb9bI1YISC/Qh/dau72RflA/ZnnV2WPhRf/yt6q19FkmuUV+FJCwRMc/C4LFYK+swwTiMelQiRnC/VbR3MzUdLzxZcsFnph3J+vw01qUAtLVZSpp+bmPr8WgL7f0/qCraL4aYetwVxhg+xZq8MM+5GjqKPSjrVinRb2SaoonF/q+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykOJyu+KSA3tSy2zu1LC8cca31KXftmDxzzQ4MqnX9U=;
 b=cdTXdTLVEDB4w/+7mrCsTIdqoz4nfH5Q/ikjW9yuHwPoktephhDbe21uONxDoXWw6OPn58t+sSCJfyEtAycnoQgJKUxgMyfGdTVh/h1iNFdRnoUauxcaXT1jWb+YYZ+CKnTiYSG+DbEyvPaPe+N2CW6hAQurlylfeqb64tuTDVEZO15L2Cz47hnCZN55NUK1z4wmFeoTHe/7d8voawYKrlGuPMAfE7OZrxMpnFbZ8nk94pYgKR5FoAX1PFhL7Ewi0MhwFg6iEhA368yWfFt8blFnFJMEG800SkioaQYyKOV/u9sk+9m1+DK+p8MqGMymZ/Zn9AcWat+iI8WuvvONcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8673.namprd11.prod.outlook.com (2603:10b6:408:21c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 20:31:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:31:39 +0000
Message-ID: <44c29a45-86fa-4e41-b4b5-e69187f0712e@intel.com>
Date: Wed, 14 Feb 2024 12:31:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: xgmac: fix initializer element is not
 constant error
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, <linux-kernel@vger.kernel.org>
CC: <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240212154319.907447-1-shiftee@posteo.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240212154319.907447-1-shiftee@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a67577-d697-4c7a-f42a-08dc2d9bf256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FaVnHBXk/M39g019Kl3ZQUb6ED50pEuCMlWmT3m0O3LKPaZXPQzTR8fNqmMKYRAgYVJ8r7fk7vRZo34QZvvxrs8xh/kdMe5h+Rnv0hkR3c7GDU8D+/RSQpHBePCE8cJrcKoFWQd7m9/cp/7j6EtXLS3ZdlMunKwDMGJS3VhgOEn/94BT9loB4Ngekzd+A0GRs+R2WecuslYBSQPg1PEChv9+1RWsdU+3yV/NYHO8iOBfkt3ZaW2DzNwI2zlboL1o78dheSzc1pFOJxZM6Ozke3ru9Q7HwcCJ59GvHLWvxpHIshfh8KbU2gMQ2ltyK6kFInpLajtk+3TPvPdfWXwlA5OXIk+twg3eVdtcvOE5VnI0iWTt0GWxmPSby1ziLi4xOZgbk+/t4pYnquovUCUQSOewWw4BepxLoIt7adHchKgATAxyiZAPvqtsgrVI4N2Bgk99ftYEYTNMf3EjrDp7t6K+ZSXyevZ3SN2/DgtjwbsDuhuTja48MhWYdqQtrGKODYfMXCvdh3LpvDCOkscxiy5q/MbNKnEFKeaLsdk9/As=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(8936002)(2616005)(83380400001)(66946007)(66476007)(8676002)(53546011)(6512007)(66556008)(6506007)(966005)(6666004)(316002)(478600001)(6486002)(36756003)(38100700002)(82960400001)(31696002)(41300700001)(86362001)(26005)(7416002)(2906002)(5660300002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZmM1VWSDZQYkJpbmxYQXdTTExhR0FoU0xZVjgzRXRqYXZ3NkpMMmxnclpI?=
 =?utf-8?B?NlFzaVNhcmdoMjJVUVlyY3lrSHR5V2Nwcy80YmtuUnJSSjNqQk9nU0NmaXBG?=
 =?utf-8?B?ZnRZN1BSR3lLSnh0VVk2Sk9hOUpZVUFsZmxPZUNKQWw3UDFjN01QSFowMGY0?=
 =?utf-8?B?N2pzT3RnWTdVb3lPcXhlaWQ3WXErakFYeng0UUV5b2dqemUyL25OYzFsVXJC?=
 =?utf-8?B?WWJqZ1ViRHVLZm5teXFLc0pZcThzVEMvcXhoSmhxaUxLa3RreEM0NG1KQVpB?=
 =?utf-8?B?U2FFWDBQcGZ6YXoyYUFqS201MjMvcndsNGpiekllY3ZxQTZ1b21ZT3lYRmNo?=
 =?utf-8?B?bnhzYk5NbWFXVWs4eXltWjJDRVRQRHZ5U01zcXhFblowUXBXb0Q0UGdVM2N4?=
 =?utf-8?B?bHpWTEVLMjRrYzRod1hBK0Evd1BOQzVjTnloRFdtNVRaU0d2NDM3UGtqVHpO?=
 =?utf-8?B?MlhzNml1VXlrV2xtZ0g0aHBKa3RuVXczNDhvVFY0TjlPL1JDVHoxdWdkdEYv?=
 =?utf-8?B?U3dyeTFiYXZWM0VuMEFpYUQyYTV0ZXFqMjh3a2VHd21JanBHTlZpRTJtNElP?=
 =?utf-8?B?a2h0K3NxWEFqQko1ZndkMGwzeHNuMVh6K3gzOEtSYXArN3VPMmtOSVpVNXg3?=
 =?utf-8?B?TktyKzd3UWw4OWNWQTcwZDZWQ0ZGUEFZZE9OWm8zVnl0YmNiZmFic2lDU2I2?=
 =?utf-8?B?YlJjUENpVlpUZHFITzRMMlFMUFpXVUlnRWwxQ2U1MTd0Ukp6Z0FXVjlncUVF?=
 =?utf-8?B?K2dtWEFXRE9zdEpWYWhyUHN6bnhXUkUyeXVKTkQxdkRGSFU1WEE1eFNhY2pG?=
 =?utf-8?B?M3ltbVpNK1Z4OEVrbkZZbWVzVFJtaU9mbU9IR1pnbmNTOExycnhUMm5HckFJ?=
 =?utf-8?B?NjkrL0lPblZiTUwzVnNSVFdtK01kYjN3Nm1ZUlBTb1d3cUZqSGVLYWZkYUQ2?=
 =?utf-8?B?MXhZVXNWcTYxc3ZtYTh5aG84bmkwQkd1NXhYejdJQmc0Wnd1VmU2V2ZKaXhp?=
 =?utf-8?B?dFJkVTJ5UVRHcm9lVi9nc1U5L3RBcE96OUZjWGZlc1NWYUhFZXhMQWUySGtz?=
 =?utf-8?B?RnpmWjdmeDZsRXFaK1BHaGU0U1plQkdWTGllczJHSGZmQTQxUmx3ajZSYXJv?=
 =?utf-8?B?V29MWmxubTdESE8xVVpxaEUyRUh2OTNERzZncWVYWXBHeHk0YXd1bE85RzJB?=
 =?utf-8?B?d3p3SlJFVkpCaDJSdlkyOXpvb0xydlFJSndUMEFHcG1rSWdIY1Bjc2tMTFZD?=
 =?utf-8?B?TTRlTHBPeENwV2JpR0FpU2ZCNWhndzl4alA0QzhwV2pkK0M4bnN4dDJaQ3Fz?=
 =?utf-8?B?aUZob1piOGNhY21INmo1WXhhVnZkb0xxeGQveDg3MjFWR3Fha2ZiQkh2bjFm?=
 =?utf-8?B?SE9ic2FTc1ZDNHFJb3ljYU9iMWx0Y3hjOWZHaTFlbEN3U0FYZm9TRUNJUyt4?=
 =?utf-8?B?bjhrQWRjUnFCWHUxWXBhKzBram5MZDA4TFlXZUVUYVZQbzJHYXBNNE9tZVlS?=
 =?utf-8?B?b3VqbFJreiszQTFrZHJmNGwxZmpCRFYxRmdOYXRZYzEvQjN0blptaUlrRkk1?=
 =?utf-8?B?K3pFcFJmTmdBR0w2Y1A0ZVJMUHNYSjBSQk5KeFhUa0FPamM4QlZOSFFkblh1?=
 =?utf-8?B?eEk2SUs2TndnMitYOUkrTHVPV0FkbjhpemdiT2YrbWtTS2tXTnlJcjUwSWtX?=
 =?utf-8?B?MWs3Ykk1dkh0cURXYU96eDJZVDNUWDEvcko3UFNrSHBnNWtSYVdxNXZiM0xY?=
 =?utf-8?B?bWFQRTlDRUsrb3BTdVYxUHZLODVGWHlVQ2F4aG5ONjhFd1dIVWNtTHVSdDdS?=
 =?utf-8?B?VXNJbS9iaHI4NkJpUHJFODErdCtLMWx2U0EwUC9DekovTUduY20zWTdNaTB2?=
 =?utf-8?B?M0VXdXcxTVpXTlZIUG9NU2w2ZjBwUHMwUkpqRDUvV0RibFp5dUd1Qi9reUtv?=
 =?utf-8?B?MldtY3JxVlhzdktvVmhNRXlZTHpCVk1mYWZWUFowT0JPa3l0MERyUWZvemNq?=
 =?utf-8?B?U3c3eXFjNnhYT1p1Mko1V3dsbkl5RW9iU0E1N3hGWDFBNUNlRHN3dGhnSEtF?=
 =?utf-8?B?NlhDS1NsNlp0QUFFVmw5czBsUjYwSUNWNURHbXE2bURrWFF6ME9ubm4xTWYv?=
 =?utf-8?B?TkFYV1VuSlhwQTRVM1FSNkRkVjZ3a3lBTDI5aEdOMGNXUnh5K010a1F0UHkw?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a67577-d697-4c7a-f42a-08dc2d9bf256
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:31:39.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkHbytudFQkdPMeD+1l/OZmBjOqUEqmpp2m8Z3REyhp4noDf6NcymaOWOoRbDPHfPTvOy3W6j9jN+YU2/3ngaFEVnb6LXWVobzr062BjYNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8673
X-OriginatorOrg: intel.com



On 2/12/2024 7:43 AM, Mark O'Donovan wrote:
> GCC prior to 8.x gives an "initializer element is not constant"
> error for the uses of dpp_tx_err in dwxgmac3_dma_dpp_errors.
> Newer compilers accept either version.
> 
> More info here:
> https://lore.kernel.org/all/20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---

I'm not sure whether the Linux kernel project has an explicit cutoff for
what versions of GCC (or other compilers) are supported. GCC 8 was first
released in 2018.

The fix provided here is fairly straight forward, and while I do think
the benefit of using builtin types vs using the macros is nice, I don't
see that as a strong enough reason to hold up supporting the older compiler.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 323c57f03c93..c02c035b81c0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -830,8 +830,8 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>  };
>  
> -static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
> -static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
> +#define dpp_rx_err "Read Rx Descriptor Parity checker Error"
> +#define dpp_tx_err "Read Tx Descriptor Parity checker Error"
>  static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
>  	{ true, "TDPES0", dpp_tx_err },
>  	{ true, "TDPES1", dpp_tx_err },
> 
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de

