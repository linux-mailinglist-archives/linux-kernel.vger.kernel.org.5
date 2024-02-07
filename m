Return-Path: <linux-kernel+bounces-56473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566984CA97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1355285418
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B559B7A;
	Wed,  7 Feb 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6O1P7i8"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05119224DA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308314; cv=fail; b=q4RfTorddKTEg5dtcvaGk05aKXagoI/2ll01w6/YnHip9/8EpEOJjObZQnwRxjrs/tFMCibePl8Pxp2blU4akDKwGJFLNqrAlXc7xnimTCkUvyx4K+rZ1rjtDhMJP+KEFIg8PV3ZAZbEdpjcX1+fIOkvLq0p0osBSeBqDGJcj8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308314; c=relaxed/simple;
	bh=QZAkAd8SeiF2jIqRdR34FoV5bMYQZhuOBsZTzVRoA3A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sR1cDCMqKZqqaydaVhJc/OrQLlqQPLytKBiyHdbOPkOsWkA5Pa5kp3WioLaUeEWUYj7JUPzZCE6E1EvnEH7IvbIhuKOb6j9tIJZw5g+zNu9oXtLRUKzrqxgNO9Ba1Eia3WY3f1ODfokPNMRgW1UlvCFnskOL8sgBfeb/FrxO1n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6O1P7i8; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707308313; x=1738844313;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QZAkAd8SeiF2jIqRdR34FoV5bMYQZhuOBsZTzVRoA3A=;
  b=J6O1P7i8oTtIl3HR6Kaq9WrEI9EAhUVWwR0jISxtnRxFRRbY6wLkeuEL
   Srw0ogb6qHb8VDJMAt8FF63bYO56xCz+aZgjgepJpkvXLdl2MnC6hRh10
   98EklpiHpF6wiD7Rwrjp4+LhSlOuYqAMfcEG5Sfd6yYnQR+KKgI/Rzowb
   qFrTyI3vuxz8Kh7lgoWzkWnMX66CM/4VNjzCqWwvcvnR8Nu7AR1ldZEEj
   OrSYY+jMLMwmsGzZeKnbEAlHIWPd0ct8o3zN541iQf5WE9TakyxNgM8m7
   1Zfnhgfk70y9Xgldjb84bTZtuMbL1QkE06spcmIKMPJKc0UZSj6GgCHWz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="395393541"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="395393541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:18:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1312925"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 04:18:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 04:18:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 04:18:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 04:18:31 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 04:18:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+01jo/osFHcWbw50+/LBvP9AaaJsmkZeeOUSUhXKhw6FPt5kyPWpWyv9nWxV9IXojulw182eyWAzacj9uWg1Vb0TAAlZ0INllGywK4RNGlU5JZAj0OjgmazXbAnleA0TYpu2tM1lzyeX/7QJ7aikO195wqGxkTnf8rOKgSASta1kvrrN8ChW5xzR1IoOxj32f6Xs+WXlYRrM4gv63yRFNGb4dBvRgM9zdkKjtgc3j2LZU748zt05zVwDYNjujJ+sbSSLAnBN09jcUVS9iSc1/lIlNfC9+5AFPuKfFmCGbY8U/iN2nGOVmpwSKtwA0K5etceANNirgiOcV99yabgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUVN7WKcVWU4ORYiNw5WC+r9m/+8X5gtiIClzeO/lBc=;
 b=gHbpNyYaNomRsuv44+ycgrkWpN8HImkQoiP+t8bTIIBi6rmysvad2rg3Xqo/hntrXN8lxlVMS+dd9lloeiVUAoPx9+POfDAss8zIEuiDLjpXZS6v9JrUeWd01jSBLMfl9qZyvaKcE7QYnWRUjuu6b//2iCI17gs6xU2LyH8eNcnTM0hi8ACrmQQFd4cKiE6Oj+MP0Rbr9+zxHP5V/9cjbpzsH30yrBETZMuInLxl3rCmUlQYZAkyJRVYBsLcdG3/8AJF5ycNQny6yjxYjZ5EXh3pgZqnjc2+RrfPNACaicz3/ciQaFq0iO3B7PCLOPtqF8l6fBJ+em6E/gN6myVhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 12:18:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 12:18:29 +0000
Message-ID: <90138eb3-6203-4b89-b075-d0d6fd5207f7@intel.com>
Date: Wed, 7 Feb 2024 13:18:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
Content-Language: en-US
To: Yujie Liu <yujie.liu@intel.com>, "Pillai, Aurabindo"
	<Aurabindo.Pillai@amd.com>
CC: "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>, kernel test robot
	<lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Li, Roman" <Roman.Li@amd.com>
References: <202311200955.pmjdQEM1-lkp@intel.com>
 <a856cbeb-dd2e-436b-a7f2-74d3493df18e@intel.com>
 <PH7PR12MB583196EB28781C92A00970C1FB462@PH7PR12MB5831.namprd12.prod.outlook.com>
 <CH0PR12MB52845186C7D747A4547DA99A8B462@CH0PR12MB5284.namprd12.prod.outlook.com>
 <ZcL0cH1LZteapnTG@yujie-X299>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZcL0cH1LZteapnTG@yujie-X299>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 747fb8e5-0ca0-4fe1-4af7-08dc27d6e4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QO9D+/vG8Eq9WfnOxGOe8GMx8DrVgQau1Ch5CAtnSE2I3LtPvXciZ53InwZFwLzJaNCAanoUu/vHdDyyb3Mv6APX3nEggDnLj7mIya9Qll/GOcN6RHfSt39eZHn2ipXcFcMRhZfHy8I1tl4FGRmT+XNL+d67Jwep8RKsktyHPIg+aFOhgN9zUNCIdBs6B1JV92MfTFTFj4TNKWJBTikyqYlcs+auseUGpg3GY7xzoSIrFuAVVoM2F9PxJ1WjQIhRv9bboF5E7flQbTFyMI4iQLzCPlcNdlbrditPIQRc4M49QhMd7BX8/BfeGOB97AaEaT4IcZAqB/EfUV9ja2NVAQRDB//ezjnvkMjVtBwRgYrb17XbCtzyfENfrBvQweZrQqRQ75tCKz60Je75nByOcfE3hZrw/Hf1hhMVLHTl0wPjrYwOkLQH8wYNG3AdJF5DBVpsB7cQtQti7miaL6xYmmRTz/MQmZk04h+n19sSCSgEZKZy46+uCYPLCs7lxgRNEVIAU8I+JzwnioCt0pG+DdWo6DjdTIs/MgoMItzhY6k3lYy5ec030W6VT3TITH+2q8XvHo/UQp7CmvDar0wHt1nAGyDePgB5VzdoyPE4HdOxT3z1nbprhGnlyMo7A/XF4K+/TiboMDE/2sApCs/79r3OpTaLE6sB6QK3rP5qouE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82960400001)(38100700002)(31686004)(6506007)(6666004)(83380400001)(31696002)(26005)(86362001)(41300700001)(2616005)(36756003)(4326008)(8676002)(6512007)(8936002)(2906002)(6486002)(5660300002)(966005)(478600001)(54906003)(66556008)(66946007)(66476007)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ylo2QXZpSTBuMjBHS3JOOWNQK1dpdEdwc21lYmtteFZFWGNnem02QzhBTGpv?=
 =?utf-8?B?b1p2a01KeDZwdlhnRjhsY1pvOXFvRzdKNjkzUGg4aFFHb2oyTXc5WHJqRGVk?=
 =?utf-8?B?OHhlUGplM0h4TW1oa0JrQStKWUZYcGJnRmdIMXhWblh6MFo3VFc2ZUExTlhV?=
 =?utf-8?B?cFVlZGVDTDRuYTB4QnNUK1p1bnkxbGF0ZXQ1ZkRGWWQyTVJ0UTlLNHhBKzVw?=
 =?utf-8?B?bHJkZ0ZHWEpXaHlUMFZGeHFVdkFIQjBsak9QUmNmT2xwVEovSWVLVE1BUTJk?=
 =?utf-8?B?Y0FYRkg1a2NhN0FaMCtRM0tyV3p3dzN4VkxXbUlyWmdpUVdncHlEanhzeUo0?=
 =?utf-8?B?NGpLanhCb2FHanEySjNEamRSRElUZm0rOHY5VGFpSC91NUxVN3dwcUJzZ1VT?=
 =?utf-8?B?V043Rk9JSGFOVkp0U1ZNT0RFcnlkNzZTV3M2cFZJVXZtOGRtTEw5ekE5eTJv?=
 =?utf-8?B?c0k1NmQ4VG1wMWNrT2N6eElNd0JiM3BxaVVZN3VWaUI5RnRFbk1MQkpWOTJo?=
 =?utf-8?B?NWYxdGZITzZ5dFV2aml0VnhXc3c2anUzRE9TS3hNVWR6UjIwYlRDMEhDVmFL?=
 =?utf-8?B?U1pXaW9JbFdWUEx2VCtCWUJmMnFtMnhyQ1lobG9OU0xUdzZxT1llS0FaS3hi?=
 =?utf-8?B?RUFURDlSMnBjanlvK3lPWGY5QS9Eazd6L3ZSMURxSHpKYXhFZjdyRDVBdWw1?=
 =?utf-8?B?R3ZNaDZCckxydlhod0JsZWNnUkdqRDQ5anlkd2o0RWlobVlxaGtheVVrNGp0?=
 =?utf-8?B?R3d4dlUvRXQvVFN5RnM4dU04eStYNC9aYm1ObXl4MWlCSEJvTGlQakw4OGdw?=
 =?utf-8?B?SmpGbXpjTElVRC9tSWNsWTFmcDI4SjYzYk1nTWsvT2Y4ek1ZbzlFMmUzYXN3?=
 =?utf-8?B?aFZXRjZMSldoMmROekd2a2tQMnNkRGFla2VsMWlTUUZrSmVlVVJsUVIvMW1Y?=
 =?utf-8?B?SG9qN2ZvL1dxd2tZZkdGNExaUWxrU0lLb0pkbjV2Ri9QNUhmRFBIUE1PTGlH?=
 =?utf-8?B?VFNzbk5IZytCRXI5aElSV2RQanVYaWpNRk5VNWtKdU5yRGNoL2szNzNPbEIx?=
 =?utf-8?B?NEhhSlQ1V0VmcmxIV0Z3dklUUTBPdk55ZzQ0bElTUEE3UTFEZWVTYkV2VFBD?=
 =?utf-8?B?SUdVMlFOZXJQL25hcS9tcGI5OEppK29CY2FxRGNiT0RjYUhjSU9FcXFNblpI?=
 =?utf-8?B?NUhCRkdtelRVVmh3NXBqQ2RiM1p2TkFmQUo1WU4yMjRwWW5tM3R2M0xnZWdZ?=
 =?utf-8?B?MVh1a25DYklpQjZVWWxGRHFDODJjaWgyaUc4VXRDY1oraTRXc1dmMjk5YXIr?=
 =?utf-8?B?UmV4YWdxckIvMnUzYm80NDBiUFJXRUt2dVUvMk9uUHZZTkF1OFpVVjVZMkVV?=
 =?utf-8?B?WGNha3VrMnphcmpXZFVZSTlRQ24vdFR1bTRKSnZsU21mQWxkVnZRa2RpR0VI?=
 =?utf-8?B?UWYrMlBZeGN4Y1ZSL1pseitJWXJFY1ZDZ2JoRXVpYmhUQ01WbVowemt4b3Bt?=
 =?utf-8?B?eXJVWHNJeEhvMzI1aEhJMi9vZlBVSnJGUUx4S2ZpaUt4QzBWM0lTQldZcjVp?=
 =?utf-8?B?VDBIVGxzMGhoblBqbW96KzBPOVAwaVZCMlhvaVdWR0FDV0k1Y0hJQUlBdDhX?=
 =?utf-8?B?dXFRQTRMSzZsNDFwQXZVYW1hZWFPQ1hHOTJ4OTZQVXlhbEJOelgwejlpRWwz?=
 =?utf-8?B?QVA0YnlTR0VYTk5qZTBaa25aMnJxeXZhaERnVkF3UVFGcTB5OGt2clZjWHVU?=
 =?utf-8?B?WnIrWmlsMXJwSnVFTnFPcmJZRUVXQ21rdlVCc2ZSeDJOSkVDdlhaWTZuUWN0?=
 =?utf-8?B?cjEraXg4Wk1ScDJnN1hyM1VXUk5KbjlKNi9rMy8xMWJuc2ZkUTJYY0diR3B3?=
 =?utf-8?B?VmxxSGVKK2xUdkVjNU10dldQdnVoSlNaaFFnS0QwV3IxeDJ0L1ppTmtPYXZC?=
 =?utf-8?B?TU9maXdJc1BWYkJpK3hucjl0VmxIZVhPdVFFVjU4b2VNRng1SDlBMEN0emdv?=
 =?utf-8?B?UlAxeGtGZXVCczQ1VHI3aEtTTEcrbWJwbUtNZXhPcDRtc2phT1Y5bHVqUS9P?=
 =?utf-8?B?NytHMnJIbmxiUmRYWVM5R3pjUEVFaHA3UGRmNEpDV2w3TUdONDJCSWtkTUhK?=
 =?utf-8?B?OVVnQThGbHpGODBZR3ZFcm1jbUtBRlRlRW5IL2ptQ29vUEZhKzJlcjRHNWlO?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 747fb8e5-0ca0-4fe1-4af7-08dc27d6e4b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:18:29.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwNBB5BsK69Ty81L9ULSE0sJOILfqcJKvls5rcwHZLb52xqjjL2+FdlDyn8kzK6qAJQ5EG+E3Rgu/YAvPDIBEI7o9g/xbCSFg5t5ds8JXQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

From: Yujie Liu <yujie.liu@intel.com>
Date: Wed, 7 Feb 2024 11:09:36 +0800

> On Tue, Feb 06, 2024 at 04:18:55PM +0000, Pillai, Aurabindo wrote:
>> [AMD Official Use Only - General]
>>
>> Hi,
>>
>> I tried with LLVM16 (from Manjaro) and couldnt repro the issue on both mainline and amd-staging-drm-next. Could someone share the config used for this build ?
> 
> Hi,
> 
> There is a "reproduce" link in the original report. Hope it would be
> helpful:
> 
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/reproduce)
> 
> For a quick check, please kindly try the following steps to reproduce
> the issue:
> 
> $ git checkout v6.8-rc3
> $ wget https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/config -O .config
> $ make W=1 LLVM=1 ARCH=x86_64 olddefconfig
> $ make -j$(nproc) W=1 LLVM=1 ARCH=x86_64 drivers/gpu/drm/amd/amdgpu/

My repro is:

1. Clone and build [0]. If using Manjaro or anything else Arch-based,
   you can install llvm-git from AUR.
2. Clone the latest net-next (or mainline or linux-next or whatever).
3. Use some default distro kernel .config -- I'm using Fedora's,
   Arch/Manjaro/etc. would also work.
4. make -j$(($(nproc) + 1)) LLVM=/path/to/built/llvm-git/bin/ LLVM_IAS=1
   all

[0] https://github.com/llvm/llvm-project

Thanks,
Olek

