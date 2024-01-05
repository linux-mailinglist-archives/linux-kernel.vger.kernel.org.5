Return-Path: <linux-kernel+bounces-17564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822AE824F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D3CB222B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE02031B;
	Fri,  5 Jan 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeLlv2HI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8E20310;
	Fri,  5 Jan 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704441603; x=1735977603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g7OQ7X5V/Bjmagsegeh8c4EeSiTP18Zhfn6mMCu5jHQ=;
  b=WeLlv2HI9xFFBxhnCvlSn0Cb/f9ZWLNz3UexxR7s8oeS54T8Dy/DLkUW
   JtRN9FF6wr8MHoUgyh7v7LungcnvuwmJUDgsfvWsbj5C/yGYkYc3H5VjN
   kUt2vLAskW5EN4LO0RJXzecZPJJ6Lqnt4DRUhQhVA/ydveKIE8TXekcwl
   nKTzU8Z7z/Qo3DvNBcEWSF6B23h6/XJ05LquysWXtiNP2T1pgi5M3oeY6
   NuO1zxQ5v4htQxt7vb6Qr/j7D82GgAqjL2LwVXPAOtKHliH9kPEDfSEhC
   IhyloAEOjEORB575mnaieNJEfX5m9raOPCJ5iL9r7pZ7c0fNrdpl8uQZw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401244722"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="401244722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 00:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="756871142"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="756871142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 00:00:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 00:00:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 00:00:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 00:00:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 00:00:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/iL1qwRLoU14XVRW3zWKL0x0AaqmmJlf2V1+eTgpDeon0wP9d1rglyQpP683lF4jpPyKHPfSBFKiGUQRSzhp9fpe7uw21s6X1HAN/M4CXPVgxgPm7O5oUOwDPFG41rd9lHZIYvizgQvIPipmnqo/SZ+SNmDMmV97/vFXVafe6pw0AnyhogvVIVR8jIlsQ4d5zQMD0GhF2WzOrXEqz/+JToVxkfb/ETzF1UI+wau4WBFnHw9QOWbjBDTAvRZ3PGVTUJTj4UQ/KujLZZr01iybBeN5diLG5N/+a0VGsWhwCz7C/+zYuOeKam+sfD7A1izjxssn3rAt3Fg0GkjGOwUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNhxLu04Nj//PfvmQQu1jWGr6dxy3040/rhljSgVSbQ=;
 b=Vuy9l9JEikJ5EF/U3nmbHfGC4167CLm5fEY2qXZ7CoqSzPHynxuQPJSoVvOgWBYn8uqGuWihcYJ42TuQo0vfG9V0Og3yFL2Y3A6vwq0EK3eg8ZCrtYEm66ptA3W97qz8no1mtne3kZD4TF54hHz4w6NdmrM/UneCR97vVC/mGjdUv/aXGOUdy4v+XzcEj58ffM2YP7NAZNuuwwk7C6Qk7VxLtVwmTH3/yV1IqIzN+6awy04enI/P1+xTGkXOTAIXfbNgA7xnHDfyDPYA4rulkcs8VfhU8iE2/tVIBPn87Q77vDTtdEBKhPJpnFwL8l1BCBYqwnfzcCjw0SQVHUMS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:00:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::3c98:e2b:aeff:5041]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::3c98:e2b:aeff:5041%3]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 07:59:59 +0000
Message-ID: <ceb50c7c-b86a-422b-affe-e4a29e92fea7@intel.com>
Date: Fri, 5 Jan 2024 08:59:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] pds_core: Various improvements and AQ race
 condition cleanup
Content-Language: en-US
To: Brett Creeley <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>
References: <20240104171221.31399-1-brett.creeley@amd.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240104171221.31399-1-brett.creeley@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6017a14b-2e23-4aa2-2c34-08dc0dc4509b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryR/cHYvwXT+vXTZyQIq9ehsjo1Yvd1gZI3QorC/ouhI2PW4qzAXhPoDnnHcap2KUhlQpj7t3ivtWJQsqwN4UZLT9tbuyvzwhh2nVwVwKh8h3x4XG+q0g38zTRpGhfZ23qQi+apce2OGUoroDDm0ifO3RCc2tIlwe/sJUqXxEkXwIxMiRuoKunzb8cTm3nDMNpq5QcpAjM4lcFAJKx2jr4Vp2pm9WgQ2xPxN4tC8w2DSZ7jSl8CE9b93nL4iT7xqe1X1UJ/gas6sG7Bx9fwjGZxTeiTIODueWU4M9iyDkh0TiEzvI43neq9dqFLY3sI/8Oz/0SOaBLI2SpxQ3JJsEzNuWbKWsRO46+Lc//C6HS3+v1Oxztv97iCgTZCwwfl3D2hd+JD9Ha2DU7UncExN4aDYE9+bxOsXT6jEJO8eRj/w1eMWJPXlAkb5uWS0BkmTWpsPlUPfUoyNOwnOGQQ3niL0IOVO3hDMUBfBAYR0UGqDixasm18q+ik56Cj1zmulUyVwdW6RXcfYX0WBnG25MbawxEMHNDrjcEHnVQ+XukWdxTXbs74WhJK7Mrk4h6ragAnY7OtrWuQ9NOvJdqhpddVaChhtF93ZgvJKtguTMwGQNSwJQMEydKUuBYY7gIzAxOyQXwqnt+o6oJ5wuxfI9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66556008)(66476007)(66946007)(38100700002)(86362001)(31696002)(31686004)(82960400001)(6506007)(6512007)(6666004)(53546011)(26005)(2616005)(5660300002)(2906002)(36756003)(478600001)(6486002)(83380400001)(316002)(8936002)(8676002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lydk5Fa3N5N0JINjRseU9qbXJ2c0ZvNUEvcndmTDBFNEZoQ1hwNFd6K216?=
 =?utf-8?B?TmE3bWRnNHpCRld1VDh4NndGRm9tTDNOQVFvM2s1M3NNOTN0OU5YaS9RenNz?=
 =?utf-8?B?MjBDbmhUM1dyRHdXeXVvNVU2R0pCOWtQZ3FUdTJoUFhLZDJXbThPUllEUTRI?=
 =?utf-8?B?ZHUxeW9nY1F3a2lHYjZuOHI5UUQrdmZmWDh3NVF5aVpkZldHaTE4UHNhaVZs?=
 =?utf-8?B?UjB2YVZ0bEhONDFDNFJ1R1pEOHJSdy9SWjJjZW9pczRNOUY3TnJ2WWhUNzEv?=
 =?utf-8?B?V0FxWlVsaGhIbGFnN1c3ODExNWdXcGdoaHJqSWg3NFp6QUhPSHdpMVhhTXJB?=
 =?utf-8?B?UXg3YXZVVkJORDBVREg2TU52L1dSMG9HVmVWMFQxMGpXZHZWUHFuOFltdjdS?=
 =?utf-8?B?RzZXM3MrTU41eldJOEY0N0dqdFNyVDFPaHlKOExXS1I2bHZYZCtCditGN3F3?=
 =?utf-8?B?dmhqYXBvbEhDVmJrWTUzdlZJbzBmOUx3d2ZCMk9RQWdnOGtXRzNuOW5ZUGNP?=
 =?utf-8?B?VzU5QUFHYnJvclpJbFU5RzVmcG5xL3IvN2FaU1BlNlcrVHV3SStlYWVCVm16?=
 =?utf-8?B?VnFkUzhtbVdrSXJCNGhHWGVGT2J0SE82a0lYeWd5UXZRTFVjazA3VS9ucHRD?=
 =?utf-8?B?cHdVeHNManYvWHJGTzRjanhGOTM3dW5ldFpSaVFmVEs4ckZDUDNnZHdnTUlP?=
 =?utf-8?B?V1RuQ0VNbysyN0lrN3lLN0ZCWEZTeUttcVhydWxXYzd0dDNON2w4WEpNR00x?=
 =?utf-8?B?WkRWUGU0TzhvS3k1SnlCNGoyand0aXpEeElXdFJKeEF6azk3S1dESXptcExP?=
 =?utf-8?B?OFNVN1VTWEp0YjVrRWJYbWEvVXZaNmRpWGVFKzdFSWV1TnhqWDljU012cVFZ?=
 =?utf-8?B?cjBVREllcm9rb216dzYvbDhQOW5ha3JlejNUNVNrTWw0MWNpT1JkZGRzY3F3?=
 =?utf-8?B?emdITUViUjFJWHAxek9IdkpWL3dxTFJEcFk3VER2M3RoaVRFclI0Q0ZUMUJp?=
 =?utf-8?B?L3VWVTVCV2ZjRUxGMnZ2L0JhdEJIblBpM0JreWluTGcwNWJLcWpTR3QxZk9R?=
 =?utf-8?B?VHhNME1kamw3MWNodlcrYTQ0M3ZzNzRPWERBTjJvL0trYlJXUWQvdlp0cGY0?=
 =?utf-8?B?UWh2T2lOc2JHYm54aDZDanpUakRJeVdvNlg0Q0ZKcmRJZkMyVDVnUUJZZGRL?=
 =?utf-8?B?TUo5UWJzSTB3ejY0N29CNllweGhwbmdBc1o1LzZ5V0xHSVhzd21zUTYwelJx?=
 =?utf-8?B?eUI5K29ETm16RnczVEM2R21WQ3ZJNzA3VHplZ0UxamtPbmZmNVJVS28xd294?=
 =?utf-8?B?d3JOcEZZdEErSmhtZUFwTk9kWmNob2JpR2podlE0QUlKQjNMcE1TekJjNXZX?=
 =?utf-8?B?c3hVbzZRMVR5andkclM2YmZDSkRPNDE1VmhJRGpoaFNGdHFwS3oxT0hySTV6?=
 =?utf-8?B?K2lWcGNpaStINkRuNllXVWxrbHoxeXZIM0xRWlFmRjFRME9XUTRCaEloRWF1?=
 =?utf-8?B?cFFTS3lYN1FQeHpCU1pwUG0wcklscGlKem4rVnZ6TCt0ZjBaVXVQMU90a3RT?=
 =?utf-8?B?WjJadnJtN2txV29KQ3gxd2hSYi9JNlllYkI4dUNLVXhEZFBRdzBlRXJ1M05H?=
 =?utf-8?B?OFU4MnhaT0x3Y3hMVkMwZldLclV2RW1NTWZ1NEh4R05tdmtFZ0RsVGlNUXUz?=
 =?utf-8?B?b3Q3eXNzUmU2TzYyUStrRVZKdk5lV1ZFa0FmZlprNEVEVWdmWldWcVZPc0pp?=
 =?utf-8?B?L3p5OW9VczI3Syt2ZTQwOEwrYVk0K25mTVBOUjNveUZzbzhseUV1a0RJQlp5?=
 =?utf-8?B?b0NjU3JMdlNNNlJHZWxmdzFLSHFIeUZpTWpTazZYYldzUHc5cHJlTEJWZjJ3?=
 =?utf-8?B?QkdCVEJWeVBWckIvM1RWeE9vTU1PUDNsMklhRVBQdHpQdHZGZ3BwdUYzL1M5?=
 =?utf-8?B?REJ0NkM2YldwVzlOVC9nVWh4aSs2b0lsSFJERElVTnQzMFpzMmE5NDZnN3BE?=
 =?utf-8?B?WFRPNE00TE4xSG9nSXNWWXorTUN0TGRrcExEU3VzSHRTVEE2cHNtNkpZNWhZ?=
 =?utf-8?B?WFpGcHJ3OGoyTnd2enQwcE14QllSNzVyV2JWRlF0OEdjLzdvNXRCaUhRMHUy?=
 =?utf-8?B?VGhZeTJNMDJDdCtPZUk0bU85VzFJeXY5K2pocldUa2RqejVGeklwQ29DVFpG?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6017a14b-2e23-4aa2-2c34-08dc0dc4509b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 07:59:59.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZfiWZhfRkAFcIkOQz6cSzDRKZwPuYj+ZWoh46mbKHpEtSqmZ6wWoQxyjYPpLRMl39OGjJKCwsQEtqqVz9FKJejdO62oh7+/r2Konm2GJq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-OriginatorOrg: intel.com

On 1/4/24 18:12, Brett Creeley wrote:
> There can be many users of the pds_core's adminq. This includes
> pds_core's uses and any clients that depend on it. When the pds_core
> device goes through a reset for any reason the adminq is freed
> and reconfigured. There are some gaps in the current implementation
> that will cause crashes during reset if any of the previously mentioned
> users of the adminq attempt to use it after it's been freed. This series
> addresses these issues.
> 
> This series also includes some general cleanups.
> 
> Brett Creeley (8):
>    pds_core: Prevent health thread from running during reset/remove
>    pds_core: Cancel AQ work on teardown
>    pds_core: Use struct pdsc for the pdsc_adminq_isr private data
>    pds_core: Prevent race issues involving the adminq
>    pds_core: Clear BARs on reset
>    pds_core: Don't assign interrupt index/bound_intr to notifyq
>    pds_core: Unmask adminq interrupt in work thread
>    pds_core: Fix up some RCT issues
> 
>   drivers/net/ethernet/amd/pds_core/adminq.c  | 74 ++++++++++++++-------
>   drivers/net/ethernet/amd/pds_core/core.c    | 38 +++++++++--
>   drivers/net/ethernet/amd/pds_core/core.h    |  1 +
>   drivers/net/ethernet/amd/pds_core/debugfs.c |  8 +--
>   drivers/net/ethernet/amd/pds_core/dev.c     |  9 ++-
>   drivers/net/ethernet/amd/pds_core/devlink.c |  3 +-
>   drivers/net/ethernet/amd/pds_core/fw.c      |  3 +
>   drivers/net/ethernet/amd/pds_core/main.c    | 24 ++++++-
>   8 files changed, 123 insertions(+), 37 deletions(-)
> 

very nice series, I didn't spot any problems with the code,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

