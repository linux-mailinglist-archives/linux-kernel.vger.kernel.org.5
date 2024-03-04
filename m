Return-Path: <linux-kernel+bounces-91354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D5870FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01B31C233C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5E7C6D5;
	Mon,  4 Mar 2024 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbTf6s++"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808247AE47;
	Mon,  4 Mar 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590210; cv=fail; b=ZO4oFvNvqz5920cuCrEYhlU3pJgJWz7wk7Zjy9rqJSPFNGIVCIFZDlINY7XO+flBeNCcXWvJlqDJxpw+E2A831KQaHM9HEVmrR7jl5L+e8F3kJPfWfRFaA9pM4k2PwiyhTYpiLcxEIKVUURg6cI3Fq/g/unI/6Nh31pJFqNkrDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590210; c=relaxed/simple;
	bh=UqwD2n/gx+v7cklMxC/zHKNWYI+LL1BgBHpLBhIE7A0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BYQECO4gLXJEHOwo9IRGYSIfppiK9c8I0UOVvOCDh6NlG/dxiS7y352i6SyRmiz32CAd5flmb/moZkKyoLYWdiRNTFBo5VAUC8dLzgpAYWg2LEMeEqhVAUeElOKI2/2yBImKTnGQ3GBCXX2i0Ul077fWE73iVopXzWKkxNiq9aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbTf6s++; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709590210; x=1741126210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UqwD2n/gx+v7cklMxC/zHKNWYI+LL1BgBHpLBhIE7A0=;
  b=MbTf6s++1XnQPIsUOW14GfnZygd5wrHQo6wLVvgI04XrE6SqqdoxCEpQ
   yARpTQpfsfqkSMdfU9WWLoy3H4krVEYZUbS8LgkwILedgnaAQ2+HXIcN0
   si48z4wYjAU4+x13fgzGQT9olA17Y81rY0dGU/XBJsdnklezNmfT2g9Gh
   ecjahRhVCle5O03pyjjUzIcTy16vmzt040u9pCu67kEiUhish5BLTRDSK
   sGMU9Y/Jui814q+ODeXpy4hbEiVynOv4RB6CXTYXQCY17IUdVa0Z2yoXS
   zni8PnsanGNuanVpOpu9vAlef6+E7ZLt6LI90qitfqZMNQGpp/vj3giID
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7929076"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7929076"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 14:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="8989126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 14:09:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 14:09:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 14:09:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 14:09:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF39dOq0XWR5PJxb+zWWcc2mboW2I/leH6u0PH43+DAheoFiRTPjowbZuI7BznRxRSDgkKLR5iYNz5RGkTMIdRhl9eUjdYe9vTySagqqhODgYslMvgHHN0lfIpDQIyEOAoAAf0oPM/JrBmmyW1xQ73yfF0CyJ5CiFegNHU0tsfW8fRahuqkKJS8RORT4diGKtbpmLm0BtanXEcDDT1PfjGB7XL7ybApudUJRoUtYNMUXYKNWc/uYAxeSX9V9Zp4HeL4Gj3NofhbPXikBbDULmTZeWRAKWrcT5PgDEO/qH9THZVNJsutwZkS1mu2+2wHeZVfNjjU7bKkp4aEtQdT+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALnQ83HWOFVyhETRtRIp9jFjscQVbnh9kHDpA0eQ9WM=;
 b=kOHafwhalBRoDY6fMyX8TQ36PYNWzPX+fZ8CmzZ8G7wNwXdJsj05vYRPW6dctJs57a0uNcSCycgb9KEAEBZ2j9D7angfPn3zHaAWPB0PbIUZEs2IHvOE3H5wqTaqaIRU2CYWYLSaciqHXyx4rUgPN/Op4JWtfya3JM5XmPsZ+DGcoc9R6L/g9UAOF0GKTD2Wtf2Iv/ul5dI+R647qrcks6MVgh2f/u4A3I/fgfnUob9ZXle/GuzBqccIxJ2rumonzVYHxFVKCHxpLxmUrcQCnxKDS+vqmlqT4WpnaDoDaT6TcstL4ICBll0uqSNmWB5dwmGJK8kccDhMpE6nyNGmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 22:09:50 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 22:09:49 +0000
Message-ID: <827d22da-fb32-1012-422d-d283b28ce5ec@intel.com>
Date: Mon, 4 Mar 2024 14:09:46 -0800
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
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240227192704.376176-1-e.velu@criteo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cec3ba3-b35e-4be9-b15e-08dc3c97cf3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9r6ELQHYsclLDe8u/Ql1+ziYC+PFM3xbM7xwGIbb/TAHSjScsO+Ltn4xh1qWREpH+rixxLIAGO1LfLvT1I90Hd8NYul8kUfjlclkSlhHWyB/l6YXcR28w/nPuCejP/MRzwz2vl98azelLy8YUaQqikOBsryjqufNly+9c0xc80D0/QO0EC1nJM8D7ZdUuY4m8q/1u10MbXoA5Vz759RL2pMrknUTAaYCll3JlW93gjVpQCp7pEIPCHJ6EkHf4Vg4vtazzOitC21LX169B3PRkGvcYIhvdBSLjAR2aGfUTZiQMXwTR4E80vS1wNMH2HlpIAcmkPUwD3T9xcDsv8/YcPmbgQWpXBoxBuOGO5jSoGznlNfQ/FR6ZZ3SAcV8XXqQ+03ffrko5meKDgPvGy14zpxghOI2IFgtuI/Pj+ogcAq8RhokA7Fe/c+4Kazrv3Nwao4lp6CltWbki2v3s+TnVUi0P84n0+cxyj9O7em7bEswRo1hrKuWqLFaUbbtNjO/TS+H20HvVcf4coG3K5aenkP6xLWfpOs5SZn6G5x6fKm5V5X+SI5IxXOFElX+6n3JoItsVUbCSLNGiG0ZyWx5Kq9tXv69uXgqVOk2amdAOvRqTnC+Srtkg+xmGQlFziXlWAlzBaU/+Yq3xKGrdPDpYqjmfyM75R+qcxGHPwgIdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1XTm9yMjE3dm9oYWlQL1FZWUFFSzdCeDN5NGVzWXB6N3ZkNlJXRmJ2dkh6?=
 =?utf-8?B?T1p2ZzRQdjZheFFhMEw4aU5HN2lLSU1ESmpjM2hEVnkrRWlpN2dxbFRNdjF0?=
 =?utf-8?B?ZkNrMlFhUGNHTGt1MTJMVHEweE9lckJnMXBIN2x4TE8vb0ZuM2E4SFlEQ3I5?=
 =?utf-8?B?TStwRHExNEhleTFUZGEwdVRPcEpsS3B4ZkJqWU9JTjljS1lKSDlmK3c1VkZ1?=
 =?utf-8?B?Y2p3VklId2daRUR3WTMwZG50eHovTHpHSTBUMHZsS1ZEM3BYUWxzWjJiR3ds?=
 =?utf-8?B?NG1PYS9pMzhXVllIbTR5N1JLYlRGMkJJVFJZQjlrYzdSMFBZQXg3bG1zMkVQ?=
 =?utf-8?B?TVhaZXZYSXBLRzZ3VEt5RzBnL25WYkczQzBwWFB3cThsd3R3VDArVGhBeVhi?=
 =?utf-8?B?YWpEQVl0ZllYYmcvajJydStJOXdlbm1VRFg2bHYxQ2wrMkdSSUtwTXhoVXIy?=
 =?utf-8?B?aWpTQWgwNmJGT01JQTJCT2llbkNpQStiZjNhdXhra05tQyt2U3UyaVNwYXlU?=
 =?utf-8?B?L0ZUazdDYjV3THFHYVNlMmdUVFNKZ1NNLy9OU1RWYk5jWnRieG9ueThsbnVW?=
 =?utf-8?B?QjgxWlUrYVpJK0lWYmV3ckdMcWF6NkRMdlBtaFRpcUVFZG1Bb3dnQzZ5UjE3?=
 =?utf-8?B?dTk4N1Y0TW9malNoYXhQK2piUFFXbW95MHMxWnZTRXowcGdTdnRySmZHVUF5?=
 =?utf-8?B?MTVaV1pPQzZXeFFMYnZEVzRWZ3UxRkRHR2pvK25Udy9EQkJyZ05TRUw3QUgz?=
 =?utf-8?B?MWhIaXU3SDZnR3IxcnJtb2QvYkpCVGlOY2Fxb2d1c0E2eWhtS0RzRnVSYzhz?=
 =?utf-8?B?Wis2WGluTHlZZ24yVjQ1VUMvcUJ4eDFad0szVndXSTg4NkFXSlBzM3VtOTNF?=
 =?utf-8?B?dUMreXVjY1VQVStuemgrcjJaUkd4L042ZHNWakpjM2NZN3NYN1hsYS9JRDN1?=
 =?utf-8?B?WlgxUzlVRzkrSjYvQmp1Q0wwZG5UUVFSL3IvRkJkZFhDVEZnanB3dTg4dTdw?=
 =?utf-8?B?T1BCNXg1dXBaY0x1QVpnbHc0WjU0QVNHd1B2Z0F6cTc1M212c29qd3NvT3dY?=
 =?utf-8?B?RmFWY3ZIVVpydHBQQndrazFuUGdYNFBhcmRnbU10ZEM1cW1GTjFtZHlNbGdi?=
 =?utf-8?B?QnpHOUJhZ1RPRkRzNjZTcG02VUxnVDhFUElwY0w3OHJhSC9ZSmhHQnhQamJB?=
 =?utf-8?B?ZEtYRUF2bmpvRTNFaU56b1U2UXUzTy9sMmpLcXZPMVo0TXpQSEhCVkFXTmtF?=
 =?utf-8?B?SS9EWWhTMGs2UjhpTTJUWVFsQk1WR0VPaTZLenNqOFowbHdoMlh6OS9FRXZC?=
 =?utf-8?B?SlNZSTVIRXZYbDc5RFZlQjJIRHhFcE1jY01Lc2dhUDh4SVMxaEVIaHNwTjNq?=
 =?utf-8?B?dktvZlhiU003WUErdlNwcTFuK3VPeTMrdHhZVlJSZlV5Zy9ON1QvaDBITjRa?=
 =?utf-8?B?OHpCZ0d2aEVoWXNFeDlOcjEwUmxzWWxPblU4NnA1S1RiSnlYU1cybTFGTDFr?=
 =?utf-8?B?bGNrSHlJWklGN09PdWs3R0dxd1N1WGJMT3Y4b2crTW4zNHVrSndIWHYraTJ6?=
 =?utf-8?B?cGxGSG9TTlpKcVVXVlFuY3NXT0pleHVSWFcvT0JGZjcvdFdBZ2s4SlNGdU5s?=
 =?utf-8?B?UGwxYnlkalZyUFAydjk4dVRQSko1aFJFUkVWL1lDTWVxV243M012M0hHejZE?=
 =?utf-8?B?bFNKL3JPQWpVVzg0MmQwY1Rod3NCcUc5ci9tYSt5QUNSR0ZEaVJSNjUrZTc1?=
 =?utf-8?B?U21wc1o4S0hHV0owcEY0MlhkdWxhYk1XRHhjbjRONEhrK09uaVhmeUZDY1ls?=
 =?utf-8?B?OHFuS3MzSmc5M3VoS0ErWnlySllYU2pxU3l1V09zWkJjRU04SlZibnpZc2pU?=
 =?utf-8?B?cDhTMDQwaU5jcDVyaFcreHZFbS9aMnIrQ2I5OTFaUGViQm54VU9nY1pGemZZ?=
 =?utf-8?B?SWxxWVhaa0pvNExIUEpWYXhhejBuTHBpdGdZRWF3ZDJyNmJuNTZlR3N6Rjdp?=
 =?utf-8?B?NlNCSjl3YUpQSEFXOERhRm9pZFFnbGRiUGpEcGRaU2NJakJSTjlJMm1lVFdk?=
 =?utf-8?B?WmVHTG9TYm16SFZjM2t5dnp4THl4N1FSbHBiZWd2eWRDZEwveGpCLzd3VDVu?=
 =?utf-8?B?RlFHdkRFZVU2NkJjNEtVelJUS3lXd3NzbDlWZ21obFB1V2lMbWI0U0I0cXVL?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec3ba3-b35e-4be9-b15e-08dc3c97cf3b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:09:49.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmI1mQ5O7uHW5kV5fqK60RmWZ2S1io1zggLXa2qHjzbbT+VZXfdkJdn0Vs6hlw0+eRVIQPIEMQXAOFDLTEU0DkE1Pi/EdbKq87Rb8E6eMNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com

On 2/27/2024 11:27 AM, Erwan Velu wrote:
> Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
> setting the MFS to 0x600 = 1536.
> 
> At boot time the i40e driver complains about it with
> the following message but continues.
> 
> 	MFS for port 1 has been set below the default: 600
> 
> If the MTU size is increased, the driver accept it but large packets will not
> be processed by the firmware generating tx_errors. The issue is pretty
> silent for users. i.e doing TCP in such context will generates lots of
> retransmissions until the proper window size (below 1500) will be used.
> 
> To fix this case, it would have been ideal to increase the MFS,
> via i40e_aqc_opc_set_mac_config, but I didn't found a reliable way to do it.
> 
> At least, this commit prevents setting up an MTU greater than the current MFS.
> It will avoid being in the position of having an MTU set to 9000 on the
> netdev with a firmware refusing packets larger than 1536.
> 
> A typical trace looks like the following :
> [  377.548696] i40e 0000:5d:00.0 eno5: Error changing mtu to 9000 which is greater than the current mfs: 1536
> 
> Signed-off-by: Erwan Velu <e.velu@criteo.com>

The Author and Sign-off needs to be fixed; they don't match.

WARNING: From:/Signed-off-by: email address mismatch: 'From: Erwan Velu 
<erwanaliasr1@gmail.com>' != 'Signed-off-by: Erwan Velu <e.velu@criteo.com>'

Thanks,
Tony

