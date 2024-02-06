Return-Path: <linux-kernel+bounces-55008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44084B632
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64141F254DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA7130AED;
	Tue,  6 Feb 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M89bilGW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731012FF97
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225635; cv=fail; b=p2Whwhsl6c9baWk3OWx4wgQQQlR5OfzDY6Bg1c0uoatrVLtuRHSS0ODhmpcS5SmNYeQSxh9XClT0zNfpDZxR4aPbAnmdBkbNndu/zy+1dboTZdRYixwlhMQgxrANhlQuKMHgbbRlQUQIn37u2lb4dMvMtu21HkFoJ9FdEagyTDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225635; c=relaxed/simple;
	bh=tmqokIqCTSiKmaL9UAGlZ4n5mzuenxAaLp2/ccxeq+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHunpsHwMgQM4Zmb8vpey4+ywz5SsG75L0CbfUKylIjl+Qy07rz+oHvZlQ3s50tYWWSE69BmRzYbGN077ahoXjjvWpGYe0KaAdZsC6w6TtWu2wS35twy3yJ4mZXGpsvoOMiKXW0lpt/0sOhOxLbXylrprjGMRA579cM93ES4BNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M89bilGW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707225634; x=1738761634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tmqokIqCTSiKmaL9UAGlZ4n5mzuenxAaLp2/ccxeq+o=;
  b=M89bilGWXssvGp8eyJd4X6f94yeBCsFJceNKKVuliNOHVcR/IMl3OG3O
   lY6rg74CcK29j1EqjpXRJ/XHwxGLlig4ZOnC3eR5Unf6RIWjAxLzwZ0uu
   4KPTYFD8+J8+PwtecGAo3tah9eOe/trn8+8hpyyhk4uSY5L+riCD6SNda
   MSG0COnIFarzzp/SkSYsJSauLWSMKelRt9A9sjoaW421VRxLzebbywonI
   ToV0WSHjNksTMVWe5zMBNinKQw+gBjFJf+Bovj6xf+P1rR2NXjCfqyFWl
   ycJjqx2XhwjuEY3mp29Ti94/WdeO2+BmFzDplkyDoq0T1WEgFlXxVRtIR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="641144"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="641144"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:20:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1015351"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 05:20:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:20:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:20:31 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 05:20:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbzxfBygGup0zRtQjuSiNP/oE2RomkNEl44Z9DlqK3Igpv31wY+vmTBYa1RqfzuZ93LZybtAFDRBo0NQLara3qroHc17j/FOqP9R8sl0rmz44aO7StYjMQekFGzL+zoQKt9Xxbg2fN2ZG01G8yuTrLW4WzqfK3M7UlXOY4fKp2emC9F46GuZ0XHvdsSndG25O4j0+4wbk2TkyLppDc/FxLoVLQvh9cWAEhsCCGLBECmhqpx8dB1/8BizmYqDLMMVbc1RDK13s8/4vkCvFAEVjYokBMgtgmd2ExITepkU2ukiGOo/Yy6HElov+xngSRZaQ3jMs+f9BdLxZMBSpBSemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mqdYV8DgctzNoJB1UGwZdjFwMhgnRLo1raCT4UIGlQ=;
 b=ZI6mzRGPQoGh9vy9XKkg3e4CiWFY6ohRMHo9PBaaKo8OoZhY9PHw46ZDi1c9LOgtRQ83kiI6imBHIA0qLupe2wkdWaCO4+g5IluFoNLAH1WFKBB+7RkWptCoWtDnivGIZH9FxIc5t35Nw5lZLwh0/9XcNifkc51ZY7ifLBLAhtbWwvry2fgcKW6FCH5WK5XK6VsVKi8YgkMGQD22iylPAqDBeg7rbrNu/fSbG5TAOoBLXldWkkD1mOgIEaOCM8cebqWeDngznTgFoAGWrKbj0jxnazXlKBCjCcb+IreaKzpXmxsf+PHaFg1R6ZBCLbS5ISraWvXfE3hhwa9BQeEqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 13:20:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:20:29 +0000
Message-ID: <a856cbeb-dd2e-436b-a7f2-74d3493df18e@intel.com>
Date: Tue, 6 Feb 2024 14:20:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
Content-Language: en-US
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>
References: <202311200955.pmjdQEM1-lkp@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202311200955.pmjdQEM1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 013dd58b-c1c2-4d2c-7149-08dc2716637b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+DFMA93piyYctYXdJ9sAprXOzZL8n0BHjm0L05NcRjm+NOz4eajDtDda2zGMHdkNY/3AWDwZZwyXq4t7OsxJhKNL7/9gntrDaFmtZ5+2+TRpoVxtnT5nA9ULgofE2FKUFvLa1iXkvaWQBlNJ88riDCmARLJdrwqjGX8HJA7WEToVh0/F6pW6BTIRzo4zOb+q5nO33GyWeKaZAqHdU+sxOAtFVm7govYu4pF9t3yxM4lU0NxiHcxmB0V5dTpSae777/BM4hF1KH61aa1Zy84885Cn0242z0kIIVg01fvaPQ88Kw84vMUT6/f+WQSKZGQ9kcvAyajHkod5xsNfMQsHHP6PUFsJsLp5ITGK+k+ykwkz35x7UsbM4u/7aBqPRk1AIhHptnMQCwkv/4a/HrN2vhks6N4oPHZpqv5jXNr6zx0L3a9MbqEvvP7uRncR4LsugwCm5VlFFy5ruH4woNT3KIRCOMZ1Y2UGQB8Z1PNembjTf3OxkLj2TOApmfTu9lW4u7M6cHHIzNvlZK6/cvIOIeOr6scdt6fLHj03a+esyZRa/So1AEUIpguPx6D6f9KMxOHQUdVO/v8/74GwH7Dq/K9NMXacdaj3uyl4qBi1p4QpECm6HsDth1WQJqzMgcautR1aHLl0hQPyjPGlblbsTDkFkEoxAJF1DWyANRT/+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(2616005)(26005)(86362001)(966005)(6486002)(5660300002)(478600001)(2906002)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(36756003)(6512007)(6666004)(6506007)(31686004)(31696002)(38100700002)(83380400001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlYrL2VKSmxtSFRhaWJDTmZnbGVxc1NmUk5XaUFpZ2dRZ0lablN4UHJvOGVx?=
 =?utf-8?B?L0NZdWxOZlRwN2tjSENxL0hDM1hIT01IUHZiNWF5TzBjRjM3V1VzUXhKT3hT?=
 =?utf-8?B?RzJBSXdUVm15Zk1IdmJ6em1WRUxSK09KSUo1QXJYS0c3R2FWOUZOdEx6VzNN?=
 =?utf-8?B?MUdsamtkODRkenFTTW45TUdzNzJReC83aEhJUTNHVlpTQ214eHpNbTYxS1M2?=
 =?utf-8?B?S043ZC90OXZlMEZrZ2dUekt1TDJOSVRieThnQy80MnpUSERPc3ppSTV1OW10?=
 =?utf-8?B?UG5vckN6cXhHWEQxeTE2bzBBWHp6dVpmVjFRN0Y0eG5DQWhkdGpZcE41Nm5x?=
 =?utf-8?B?b1dBS2lsS1RZUGd1WjFoRDA3STVFOWVyMlpmUXB0bTVTTWttN2xMQkdhNkpD?=
 =?utf-8?B?MG9VQkoybEw2NzFFSVdNSTVSK3ROTmZoYmpqc2lzWDB1QmNjNHZ1ODBabmZs?=
 =?utf-8?B?SVFhMWcxVFJFdzdNQjFsTXdRWWpBTi9vZnhpZC9BY3hJNEF2U3ZqZE5OZ05Y?=
 =?utf-8?B?TXRyQWNXSCtVRzVEV3RCenRDUUFwRnRLUU9XVlBmYzFSejA4ZmYrYldNNDBY?=
 =?utf-8?B?bnJxa0xZY1hKR05mN2YwWVRFa2xFQ1BXaTVuZG1tOXdUcGp3ME51cU43c2c5?=
 =?utf-8?B?b0l0R0Izc2JXd3lTVWx3Zk5qWmtPMmNmMm1RbjR4dEdNZFlWWHZDK09tckdS?=
 =?utf-8?B?ZFF3ZWtoU1lKU1NXaWh1c0hWeU8xSFNJa1A5QlhreXR2cGl6TlBJS1l5a05P?=
 =?utf-8?B?TDhRL21LaUZITFQwaGtUa2p6TDZaRU1TSEpVc01WWVpzQWluUTBIQ1hlNVhX?=
 =?utf-8?B?S0lhWjhqa3F6ZkNxVFd1alNyOVJyK2J1TTRuV0lrQmJ1UHpZVVp6Zm55RUVX?=
 =?utf-8?B?ZnhReWJiYzV6QWhaSkhPYWszYUdmczFKd1B5SjJSdURBKzJoTHZoN0wwYzND?=
 =?utf-8?B?WGhzQVNZRThRSU5KSGh0OGtGbTl5cUFvS3k4U29FNEtIN1BNaVlIUER3YVNP?=
 =?utf-8?B?VTliVlVHMTFta0YyTTNTbzJheFdNMjVUczlHNWRKRmNLRFVDcVMxT1IyWFdl?=
 =?utf-8?B?a0lac3ZBYmFtY3BxdWhMR3VnN0xscGQrOTdLZTAyY28vczQ3YWs3TTFhVTdN?=
 =?utf-8?B?c0NTY3pjaVNCMk1aRnRxdU40Ym85T0xhbEdWWUMxVkQrT0JGUGJySGVkT2J5?=
 =?utf-8?B?Y21ET1MrRWsxL2FIS1FlZzVNR2lNdXdYbGFMdmo5YTRsL0JUVFB5Sk80WmIr?=
 =?utf-8?B?dXdSNUdsc3Qxc0owai9QMEsxMlB1WHA2SGhNaVVUVnppSWJZNk9Ta0NWTFRJ?=
 =?utf-8?B?Z1lsa3lBN2hzMDFQZzMxRWhWaVQ3a0xtQ1BBS0dOK084cGxJeUJZZ1dKUkk4?=
 =?utf-8?B?STFpa0RSenBKTFI3UjF3ZUhkZW42eTl1eDJscnBUZ3BzNWJoWjNjTW1Wa3pH?=
 =?utf-8?B?cFh0TlJPRWJQRzk4R2s1K0tMMzk3OVFVYS82SklVa0ZNdTN0dmFIbGZSWW5L?=
 =?utf-8?B?VHlPdkY0NVd3N0pTR1JZWUw5cVFjZ0YwUzFMeW9EVHFoL1dySFhKUFhCRHM5?=
 =?utf-8?B?aHU3a0RQZWx3MlVWRnQ3RG92L01uWjRMZlVXMVZERjFobGVwQlhRUmx2RFk0?=
 =?utf-8?B?MW9ZTUFRQjBGTnY3cG9wMmhGdzF2VXBKREUrNU4yck16UnJRMnFpM2lqK0ov?=
 =?utf-8?B?SWozSTFOT0w2bFdXNUJNcnhrQTVnSFlLajlJYWhiRXBnVEZsMXhCaThxL3Vn?=
 =?utf-8?B?ek1jbkdtcW00YlNob2lrUWZUL3BZdDBDc29kN3ZPOGg3K3VEVkx0WlViWk5l?=
 =?utf-8?B?dk1IOERsVXNYc3lpY3c3NEEwVGtGRmMyT1p2UjJLRXA2L3VCVC8zYzRWa2NI?=
 =?utf-8?B?c3BuTzdoRTJBakVhR2dGamtwVDY2WjVGeFc0cUNuZWF1T2VBOHphSEkyTW5N?=
 =?utf-8?B?UEJHc0UxeHpGaW8ycm5CcTNBZ2lUVlZQdDlYeWZvVHVvcS9qdHlqUjdaU0hS?=
 =?utf-8?B?VXdaT0E3NEtjbyt4bndyWE5yV0xnR3VTWG9tNnZ6RjVreW0xYXN6T1M3TUhx?=
 =?utf-8?B?Y3l0MGFBRGErOHoxeHZidGJlNFhteXRKem5xNFVSOTBoSHFwdTVEZjVodjJq?=
 =?utf-8?B?QUFoMTRMRHovaXBNZEtqYW9IcG12NHF1TzBlbnZ1Y1ZaVk95eUtORjlhS3kr?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 013dd58b-c1c2-4d2c-7149-08dc2716637b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:20:29.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuJfMu1VVMye6az40yZMeMd5RZf/zgPqo4yYLOU4OSn/dIiDNQCJ9f4j4cum18fPdsor1Cb/L/lnIMId2F3LPOcvGXsQh4DOqG2yLznRWWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

From: Kernel Test Robot <lkp@intel.com>
Date: Mon, 20 Nov 2023 10:01:21 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   037266a5f7239ead1530266f7d7af153d2a867fa
> commit: 7966f319c66d9468623c6a6a017ecbc0dd79be75 drm/amd/display: Introduce DML2
> date:   6 weeks ago
> config: x86_64-randconfig-121-20231119 (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311200955.pmjdQEM1-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
>    warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12: warning: stack frame size (3368) exceeds limit (2048) in 'dml_core_mode_support' [-Wframe-larger-than]
>    dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)

Ping? This still happens on the latest RC and linux-next on LLVM 19 at
least (-O2) and breaks CONFIG_WERROR builds.

>               ^
>    2183/3368 (64.82%) spills, 1185/3368 (35.18%) variables
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8241:6: warning: stack frame size (2232) exceeds limit (2048) in 'dml_core_mode_programming' [-Wframe-larger-than]
>    void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struct dml_clk_cfg_st *clk_cfg)
>         ^
>    1441/2232 (64.56%) spills, 791/2232 (35.44%) variables
>    4 warnings generated.
Thanks,
Olek

