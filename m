Return-Path: <linux-kernel+bounces-65933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76C8553F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EFAB2C5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9E13EFE8;
	Wed, 14 Feb 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo0VTsyt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984513A89A;
	Wed, 14 Feb 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942267; cv=fail; b=EKTN19zS10+C1paWMVIQ8HUYqon8yyYg04I8tc5GEPzBcP0BAOM1U+3HK+Kcj6d2BSxXdDG0hguKPDuhTqjzkUwuoQgj/+SO83++sdG2ZIKnN3x4sHMpMXLv/c8dN/8gEgB1lD4iLgoMlFcEomWbSVp5d7sKyiWJ0JrSVPq7JAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942267; c=relaxed/simple;
	bh=DYjI1xKK9r5hx/+ikbCqo5NMHITTRnbeOID25yRI8FQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVL31TmYbWvoDW7UteRnDlC5hFgQWC96wcBrCtjledqOEvvOeMPRLo4c+6xc6JW4hYTN5rlxPzzsVU58Q452QkTaTHhmbLbktW/LAe16rnPHA2d9iUet8O0rUtTwwu1kHLaBy7USC8KI/9V/gsee66rg/gPVwHx7F9noiSp1wmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo0VTsyt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707942265; x=1739478265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DYjI1xKK9r5hx/+ikbCqo5NMHITTRnbeOID25yRI8FQ=;
  b=Qo0VTsyt0FJGysSBDSDwhwFFRdM2rBS9QzbsD6EXOxOI8j8BraP1xF6G
   RihHS6KalH2nW3qbFiYtk3ezowaSqpxZVTWiL+CugwMT5QyjUn5uZuHi6
   jZ5VEfiBRYGIsOw4XjDEwhBGdDjwxK5UVPlH+x+mbCSLNMl9ZX3lfvihE
   85jEMoOQczAUGllkoVbBw+uGRKy9NH0D5Gs3vxkEPBAYh3nigoHj3+jd1
   UJzCi1SvVooBw23OIDpMlDYhy3qJlx4v2tKW8JZ2EH71RZSVWXGedGxc5
   mFKP4CWqpPP3lFnOxd/bdPFXz0JbCbO+cP9Xa3DbeTBHyC33dxgxCkV5o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2130487"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="2130487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3286523"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:24:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:24:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:24:24 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ4lD6mqM07b8l3HxlXjQCc+oEsRIQPoGh9VmgwnWJm6A/nDyQIOgRcafBp2Zi+HRFj/xe9FbjrvoEv1JUD6RXVruLjD3fdfcEx3g1pC1X/srwEE2f52T/APeJYQPUul1cAEiM3bEq1hXtBIYolc1qd9R5grDYMEuAUUcXChlZmjAIumqz4xEnvZOZsITPYPUH2wb0XFtif7kKFQ8ag5fl1zQuuG7bBrg9b5GTLdi9bpnba71XdfvaVnt3LoqzE+yf0XVmBRhSCBZXTi0HB3hi9+kVFlvJC/Ap1dIEoTv/P8xfgIm/J1X1m1W/OJpKY5P6l3KLGM7ZNM89Q+6ytE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfpehTkSqOtFB75KAKiC3ug3ZW//hw6aMQ1I5csHwLs=;
 b=axqR3gqBxa0HD8rJ2hrffF1Z3cjQMxNkjXgIy4VVLD6f4he8GaHPe2HNMDIoXddX6i/fDaRZR2+N9VKbSMrI7lRvqd5eJv3fzi2QzmGWxfqkmg3ovUfIhMVsiszcTZw5PtCs6hJI7SoHldZMNq7toKW8feC/DSm/q8Gx+oXerxB+l1Hti/j/rxM1MdBoEMMZwUN+N81L2rxu6xMOmyHKWIioEhSREIjam9yVjWx+INlZokuduRq5dctXfBpFx2grxjQv55whdAStJXKnCi+CogGtJV3W0fsBZD3NS6pT7+GVwYpklc0P06FlWni1InaojxDp2W1jRSxxFnxLSprv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 20:24:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:24:17 +0000
Message-ID: <a9f22838-e90d-4013-be24-127610d64d42@intel.com>
Date: Wed, 14 Feb 2024 12:24:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.15 v3] net: bcmgenet: Fix EEE implementation
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>, <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, Jakub Kicinski
	<kuba@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, "open
 list:BROADCOM GENET ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
References: <20240212014859.3860032-1-florian.fainelli@broadcom.com>
 <20240212014859.3860032-2-florian.fainelli@broadcom.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240212014859.3860032-2-florian.fainelli@broadcom.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8961048c-f57e-4422-3358-08dc2d9aeb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rNWd6x3S1m4qKY/lNQmMAE/+7lWglSQpfD6cF3Xq+mcTvhjIjkKHjQSxXAw0bfjHJxrDJAG+FNrRqRk0L8F4hCzb5+0tO2rFe80v3bwWRULTNNXtX6QMqEHZPwcHdczrXcD2br9npCzpQibSr7Jg/MYiTvx1fhPjJzHmR8Z4yPTUth0t6oW+Gw/X+gQJkQJvI6Z3uX9i/m61GYPLvfg5CUoLNKH0eTKV+8/doO+p6Lj/tzHuEaUbUrNjrxB5XJ5T3vnUtlZeak6GdgzCGgiSSVInBndfMnUmTCzR5BRZOXaVHOb7G8HKHL+gm10GldQsEawZOyE8q8Ec6FNMlEApIJ6gPKONj0jfektz7EMqcZ4SIrU5RzUEAXkps4974iUkDnR0tPDhZS6ssAPe0wMAKMOfhZMnY2utHfLxarM6DSf8fmA15Na2FjQeq4NxSsPhKuhQMb91FcLUiKRfYSvJXhnR6dRW+C/v27iWq2dn3oLM+BXn37AQkGraY2/S9TxlRlbLIIkclAUWLCcPwD/RutfH6hsk4VQHa0EvuAK2TI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(83380400001)(41300700001)(2616005)(26005)(6512007)(6506007)(66476007)(66946007)(8676002)(4326008)(66556008)(53546011)(316002)(6486002)(54906003)(6666004)(36756003)(38100700002)(478600001)(31696002)(86362001)(82960400001)(966005)(7416002)(4744005)(2906002)(31686004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnNjaXFmbG0yZlZ1ZGdWeDVDU2RISG1yMjgvMDJGT2pnd2FFRG9QbTBZUEE2?=
 =?utf-8?B?K3Y1b2FYbVRJbklCSkdhUTJEQ040QVRkZzJSYWgzYkJ2UURacHhWYlgrR3l5?=
 =?utf-8?B?UmFtOWlKMVVMNXFBUUp5Qm03cHRzMnY1Q0Rqa011emJBN3dleVRMcTNLZlpE?=
 =?utf-8?B?Y2pRY0U2c3MrSk5leGRIR3UwRlI1Z25oeEs1QmlXdnpBbE1PSG02UnF1QmJn?=
 =?utf-8?B?eWZ4MjFWei9YUkZjWWc2NStoZmk3STlrNjEvY1UwYXFsb3ptTm9Yd3h2Mkgy?=
 =?utf-8?B?ckFiRnJDcmdlSDRWU2N4S1lhNFBDUmdnTTh4a1dmNmtUcWlWWVRIZEpWbWYw?=
 =?utf-8?B?RGFrRHVaOU4vMmo1RVpxTU1Edy9NVzlvZHYxdmY5bUZrY3Y0bS9hUit2ZnJJ?=
 =?utf-8?B?UWNiSGFqam5SZGVNbmp5eHJLRGZKd3kvdlQ3OElZL29UZTJZQjV3OUpVVmsx?=
 =?utf-8?B?YloyNE5Fd3ZLRllZZlk4SFpzTWpVa2lTVmt5RTR0aWRJdFQyRWMvdlZpdXE3?=
 =?utf-8?B?cU1rWjJueUE4UGpYVGpmelA3QWQzSXUyK0xaeGI5eXRDbUFxNTZqV1NpMzl5?=
 =?utf-8?B?OUJnbEw5YkFlMkFwZmVXYnIyVlZiMCtqL3BjYVRJWm4yajRnNFhKTGluUUZJ?=
 =?utf-8?B?NWIwb2x5YkplWGFFdlhuOXhvWVVVT1JVZHM4aHZUbG82NzNvSXJacUZwdE42?=
 =?utf-8?B?ZDlSMjJnZUtRQ29OUUJtRVM0YVhRVmtnMlhjYzg1cFQyTUFvU2ZyV0l6Mk1I?=
 =?utf-8?B?cTBqOXhGOUpFNWpJNlY3SXVUQVk1enRCQ3o4SWJpU0F6SVorNWhDTmZtMkt5?=
 =?utf-8?B?V2pucjNmSHRYT3U0VDdEc2tMTEF5YzdHMExaaHRBSUdOUDRxQTNGTVMybnF6?=
 =?utf-8?B?b0dVbnNrZndSSkNsazBJdEY4U0I5SVZzbWxxREpFM3gyVVJmdUJYN2FnWXNH?=
 =?utf-8?B?NEJndHduVTRQQW8yZ0FaTVVsQzFmVFE0aVJKRkRUa0pVMlhBNVQ5UzI4RU42?=
 =?utf-8?B?WnE5SXVxZW1qdGNvV1hoR2t6UThnWnh1TWd5U2VWRkxlUHdwdlM0azRzOHVI?=
 =?utf-8?B?U2lqV1ljbURNMkJiRmFpNU12b0VUa0Y4dmNyMmRZSHBwREVmd01WWktmaDgy?=
 =?utf-8?B?Wm9JRDEyTkRxcjhtek9zOUVzdmJvb016VE1ETWo3ZFgvM1FkbElpSGpuK0NT?=
 =?utf-8?B?Y3F6anlaa3d6T3BSNjFSTEhlVytLUVc3RUdobnlmc1ltakgyRXFZYkYrWm5x?=
 =?utf-8?B?ZGZFNm5JN0RzUlhJd0puNnNIbXpkU25CMm1pbTRZenc5SENaYXY5c0hsVS9q?=
 =?utf-8?B?UWZxYnM1amN4WmpIQzFQYlpBZzRXYVlEcFNVSEpmRzByd3djcXhaYUJ6ZTNv?=
 =?utf-8?B?OHpjQlVLQ3ZRWnpycHZOSUw5TkZkc3dYZmJCTzVXUFlRSXJ4bWtEZ3lCSTQ0?=
 =?utf-8?B?ZTFRZzBKTzZXczBqTytMZGpPWVc0NERVSEE5eUF5U29lM0N2dW5PU1picUVy?=
 =?utf-8?B?VzA5YVNrZ1h1LzBqaEJxdUR1OUhmOTllbUNULzd5MlNzVDMyL1YveXpPMkt1?=
 =?utf-8?B?YTRJeTRlMmNoL29KQnpmb0FhUlJtY244Q0VHY2xUaDhhZEdFS0ZNcVpSL21n?=
 =?utf-8?B?SndrdWFxTXdmOVBQWm1TODYwOGFEVnFEMENMN285ZjBMTVNBdXo4RTB1YzV6?=
 =?utf-8?B?c2s5K3RFTnE2OHlIN3pra2hEQ2s4YnJFODFKMGxGNk4zakRtSXRadWJIb0pH?=
 =?utf-8?B?WUZ2OUpXeXlhYUZKT3psMjNPU3F1Z0pHWFlaWm93bU1ZaEQvNnlUT1A3UG1y?=
 =?utf-8?B?ZUQ0dXE4VXduMWhGWTl0OFJwM3FzNUgrWXJxRVlrOG5qTWhqVVd3YjRMYjZG?=
 =?utf-8?B?NHFWaFpkUEYzK1NhN2NDUlVpbzVaYlRhaVh6TjBmSU9KWDkybzFuVlZVNXJ4?=
 =?utf-8?B?SmxYNlBYSitOY0pKVnJtbkc4MGlRS2tGMmd0UmVrd2FDV1RFN1JFa3BRZ1ht?=
 =?utf-8?B?M0t6dVBFSGJ6a2NNS2kybzByTTU2VjNobmwzYXlZb1BtZmZldnJFQVpSNkxK?=
 =?utf-8?B?Q1R1dlM5M0RWcFB6SkRWL3RaQ3RsdmhRV01ZNlNtQXRHN093OS95aFVDM20x?=
 =?utf-8?B?VmN6bWk4QThVek5TSCtDc0Z1eHI0dHFqaDFxajYvWW40OFpnQmlwYzBJN0JH?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8961048c-f57e-4422-3358-08dc2d9aeb05
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:24:17.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFLt0g/zArWkRMucfS0qJhvbTg5Sb4wOknuszRn2RlZ5bGeHxUCgtBHReHzj8qsPvhyly/fEJwiCXA8DyZWBQRKugNXMK7bv64t5uqLbHa0=
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

