Return-Path: <linux-kernel+bounces-58538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118084E7CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF472854D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BC1E892;
	Thu,  8 Feb 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H78iG1KO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569E1E89E;
	Thu,  8 Feb 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417551; cv=fail; b=dnIFoN9JgNowQG834gZAHyU2oZw0BjJw/Edl7t9bFTcc4Cc9UOdAd8V806PeC842g4rfC7dxLZ0kJ8U81nK8+8t+ZKa18FWcd3+ZEv4AwKrHOHf5BthQpsV5MzBTLYVITck51Kbv0WKuJqQQPkOZ/Gh+oFfIEKk3NtjzbNNkdOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417551; c=relaxed/simple;
	bh=nWxhkRvCNMnQ/XQ1qbNA506eekzvqckvT/lZNBiXuGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CL22a0bYf6NUIcQq1OM2UqafHNttyz8+AxKjronmAqoHyVFcGpg9Rvl5E7It2cTgrgHnmrS1A9YkCPlUXGJWHV5oopdaiJ4EEDT0x5Qi1w+hQ0pQbIDApahb3NarRwUeTUpmtxRV/g7J4dBAatiCHk46admyzrOIcIXm3r86MPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H78iG1KO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417549; x=1738953549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWxhkRvCNMnQ/XQ1qbNA506eekzvqckvT/lZNBiXuGU=;
  b=H78iG1KOpKK0WeksuwoqkLohk2Q+TEmgEwtAhUnOVp/rIM55KWs9SVD8
   /kYWn9ZOCxMZaM04dRGYVHWQaA0wx5fIIBDUnOEJctm25T1z3p1Ru7yah
   W+ZQBli8aZ1RdJD7Bp6vnLX1MBjrC0Lt2E5LOZ8DHXZnYFz2BnKrWC+ev
   vv2njuyyhP5Qnp07AuYVhF46vLJh5mEBb1T72Sij8kgPQu+Qkdg7pvw8h
   ZVGDhrc2fSgCx7+Ym81TnDF9Flf23lnOYBoihjloUIU8XepHef6jExVvA
   J2EFZ0+WUVYgoPUTxzyqjwvCjW1+TeyF+Hr6ehHZvxAUh27gDEltfk4M4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1177494"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1177494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910466781"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910466781"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 10:39:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 10:39:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 10:39:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 10:39:08 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 10:39:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6aUJtukm94Zz3XlDDJrY8GkruaNxY9jcMv/3jsaHxYwNfSwUJb8Bj46lt8JPmwzVhTt9cxH4x5mjOWA7wW/xUsXFHWVlAcpCdSFPBXah6N4a3QETKlrNct6FXWfqINtdYVlLB552NnqW9aQ5XJvNHHjnpyQbsG3GV5JYVPGA1N/8nCGOJEi3VoOdZmCyIlH8NdoG9aIHoUvnwIxBso7eE3RvJ7Auh83zsngvlRcWpu6XMGg5fvkAOtOgYb2JOgckF516u48MMex6an2IC9qpqRwmwsCZeUMtxI2Z5b/rQnqr7QV88TJ07f2I6CEHAMtxWyHL7i8s0TDGvVz4YgCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWxhkRvCNMnQ/XQ1qbNA506eekzvqckvT/lZNBiXuGU=;
 b=U7F9vd0BeTcYd3gWySu7hNJWfiPhGIk7Pk90P1QV4f+XET0DQtzdW50WsfTF0ZwAlC8s1vQFV1fBXoZyCXsI0T4FVeaS2wNgMQCygguYd3/rICrwBjVmytE47iTjeRB797UnLpCORNlz3OqaN5NgXPBwq9A3JViUZbehycvycO+CXHIKqIebXtL1+gSX4VhKKg2uP90/HCt7ych0zp7YU1qmquaW+FysQQMJ62StdpdYy0A77uNKYw4V0Mk4000whQ//RYiZjjFESvCa9yNSZ5VzFIL5S04pm2sZXTr1Cf+oiuKFoOh5agu8j0RSJztI2x3rRNRR0VHIoT1yWZ85BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 18:39:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 18:39:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Subject: RE: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Thread-Topic: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Thread-Index: AQHaWhj+UP20KTudoE2h8U2CJGtjJ7D/j4dAgAEoWACAAA1mgA==
Date: Thu, 8 Feb 2024 18:39:05 +0000
Message-ID: <SJ1PR11MB6083F74E1C45F06860A29A38FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
 <SJ1PR11MB6083E1876B8CFBA76F1B3806FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3281ec05-60cb-4fa2-8562-afa93e770159@amd.com>
In-Reply-To: <3281ec05-60cb-4fa2-8562-afa93e770159@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6672:EE_
x-ms-office365-filtering-correlation-id: 5b64864d-c2cf-4840-b638-08dc28d53a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umCYwy25IoH9nCFe80WtA8nDKJqPesO5D/Pbfujt7Okj1RDbVZUG6/0ld95bJQmNgOlh0dbP41P5W/39dOy0t2wB+KZd80PUPbVonRyk8Gv0qpAgIPlKkyqCBeEvSgGz0tDWqYIcYy7bEqZjkehJRRKnEOQXb5DaA9UWlSMPXzTqIjzU3qWAOU4ITkW/r+rgVQSqRUz67af0+XKye/LoIE8iBckpgoMT703toKFvkMqCmbjRtodBAZyFwtAn4jkm/NOXG6+nAibf3uwQT+0b8j1BrGIjj72A9H4i2AhOWtoNK5rmP7aOzX6+wo9d86+UlykSZ4MZk2fWzavF9XwGaDhjdJOQLfagqHwLWXCYpLcmRMXYWIefKm51qOBWQFF6k74yV8PPNKzsQhToqI+cb4MDm3OXqwQRWpGO+SBaNlPWWefERnKIZsGCFc/5R1SAqA0YLLZoffFDwH3xmJZulYM1XtnccHmqkGbtjhyM7Qx4FMg6n9Gh2jZYpwSBvSteVRgvM7zTZsHnZtOMu5JCAwlBHnzWyZVIb8rTegS1g9uJ3VTXNjSXshHl25H9WirV/fsx/+3pxgoWIL+hCSfxj4oiERZW18kouLuuPJAJjVTSTxKAGJCjIeVkWxOMZO13
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4744005)(2906002)(55016003)(41300700001)(5660300002)(9686003)(6506007)(122000001)(4326008)(54906003)(64756008)(82960400001)(478600001)(110136005)(316002)(83380400001)(33656002)(71200400001)(66446008)(26005)(38100700002)(8936002)(86362001)(7696005)(8676002)(52536014)(76116006)(38070700009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhiWkkyUmJGN3Q5bkV5OHBFNnhPTlZBWUJKZm8rcmE1UDZUbU5QckZBeU14?=
 =?utf-8?B?STVXVFJyaTFjQ1h0SmNmYVNlSGhFMCtUazBhY2Z6bzNPMGszV3JscVBiNk1D?=
 =?utf-8?B?Nkt5UWtQRFRPelZhekRGb09BdjZmbzhLVmd0ZHdnZllWbFZlUzRFOU1kSTVO?=
 =?utf-8?B?QjYxZ2JLc012OEZoQkpKOHVoNitvVGpmVG90ODhJOTFHRmxjMDM1OWVNWlVs?=
 =?utf-8?B?Q3RhVmRWRGlDY2p2ZGNBNURNT1YzTWk0aDhaV3VkamtnbFh0TGg2djBlaTlq?=
 =?utf-8?B?ZXZtQWprbFBGSFAwN3IxbkFnVXBBMTBGU3c1bnJZSlA4V3ROMnpQZE1pcnJO?=
 =?utf-8?B?aFhuYldkM3ZIczhlSDVRNFdNMWhsUUJWcjRNR2FBWUJseTltVGRDM0lkSE04?=
 =?utf-8?B?ZGthdk15MGtLbGdZK1Bha3U1L0Z3SFRHRHNJaVQ5dGZWR3FaRFFVZE9jTzVG?=
 =?utf-8?B?TE5IMWIzUGd6a0UrdnkzRzVMbUdlQlJDbitZV2ZJMDZJTjZWa3ZFS3VMd08y?=
 =?utf-8?B?MEZGeXFjQ3VKZStaR3lqQUUySlNWNmpka1h4dStKUHE3N1VvNU45MXlDdUNn?=
 =?utf-8?B?cm1xV3o0VndFMDlycSs0VzRDdzBYUHYybWFnZVQxZEk4UW4rbGp4WXU2b3FI?=
 =?utf-8?B?bWIyTmdQQksyOVJ4RFUwNGEvTU8zMEdqM0FIazFXOWhXWHBoTFJsNmhaY2VB?=
 =?utf-8?B?bUxuOEFFVjN6aVZ2T2ozS1pHdUpNMlU0NDk3OWliRkxzUmFlU3hJNVVqR2tT?=
 =?utf-8?B?R2xDQnFCT1FURUlKMFJLUm1BN2RIL0FWWWRXeG9vRDNlUSsvMFJmN3ZjYTB2?=
 =?utf-8?B?MGFoV0lIRXBuRml6RGVsSlA1Wm4xNzdIcENpWTArbFBFMjZEM3ZDQ2VwQkVW?=
 =?utf-8?B?TW9lVG9pN0hicWxEY3FzcjV3UVNNenlXMnpUTWxXWEFlc1k5eC9sSk1ORkUx?=
 =?utf-8?B?TUJPd3dQdDdBRGpSR3l1OFRwekRYMkFlZkZuQjl4bHg0T1diUms4Yk1nRVRW?=
 =?utf-8?B?S2QyREtwL2JOWndwK3oydFNXRmljSUtuMWxSM0JuZWRSWW1aL3NYaGtybW55?=
 =?utf-8?B?QUxOVkRSWXFpamRoYlhtSzR4VkVMQnJCWm00SXN4OXEyZFJnQWRHSEpwNENv?=
 =?utf-8?B?dnVsbDlKSUlkKzFYNzdQUUZrSkdnd0IvV242dXZNcWlzWU5EMUdhMTdtNG0r?=
 =?utf-8?B?Zk03YnZxNUVsNE5jRVArM0w4RFBwWUJ1Q1R6aDltMzNCd1RNQUxTaFE3Ulcz?=
 =?utf-8?B?aGxweXJaMDk2TkNTb1l1Y3pZQ2ZGMlUzRUg4c25qWWNDcjIxTHE2ZytYMEdL?=
 =?utf-8?B?UGFRbkV2LzFBampQZWNJK2tQWVZvNU9IRjFnOFp0TTNCMjJIbldkRUJlUlZH?=
 =?utf-8?B?Y2ZEL3VZb0wwTUI2V2F1ZE93R0ZpL2hmdURtb3B0YkhuSWZMdStEOG5VV2gv?=
 =?utf-8?B?MVpxYVh2aWN3b09pTk12MCtLR1dxNk0wRUgyQzhNUGFySEduYVFIUnRXMnpZ?=
 =?utf-8?B?dGUrUnlMYlRwMVNLVEZBV05qMTJtRFVXTk1PSzlFRTNSOHJRV0kvTDA0U0xq?=
 =?utf-8?B?QU16ZzNVTFBHZCtMeUNIQ1ZEOHhYRGYybndualI3TER5a05PMyszRjNmekhq?=
 =?utf-8?B?M0hRNjQxbU1ieG80aU1vN3lFcUFSUkZPVnNVU0NSSVFnQ1pHUG94OS9MN2FR?=
 =?utf-8?B?M3l2b1NXZ2pGNTB4enRCTjRiZTUvbWhmV1ArbHhZc3VIMVpmMkVNVUgwWm0x?=
 =?utf-8?B?TUtQZlNSdGIweFlqSTh2bzRUTUZMNHBuTm1wU2NMS21ZQVE2OERRSlJJVEg5?=
 =?utf-8?B?SWh3SUhCdVFVSXI5TmxYTXE2dXEranE2aktiQU1pSzVpOU1VNzZYZFFaSVl5?=
 =?utf-8?B?VlBTdFluVkV2R25rL1dZaXZkSGZFVDgza3J0aUhiQ1JmYzErbHdvMnFWQVhU?=
 =?utf-8?B?QzJRZnFlV2pweFBtRjZ5dElBZXBKaVdOMGJQci95K3J6c0tMSXdDUnpCSWIx?=
 =?utf-8?B?MTlhbk9VYUVjZTlONjNvZXhkSGVCUHVRVVRZZ3EvTTRNWUkzSDlmb2FkYitn?=
 =?utf-8?B?TGhkeWJCQ3FuR09VZWhaTUxKY1MwblFlcitDK0VlTU5rNkJWd2lpU2xnelBw?=
 =?utf-8?Q?pHEskAc10hdda9j6ChXZUsf/I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b64864d-c2cf-4840-b638-08dc28d53a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 18:39:05.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yft9Y8RA2oZZgf/9iGgwbrl7UnLnHpmVTKV4rsPeNhhl88NgKYAPIe56ngOD0ZCwXfZVtO8sfvc13PdDRbGxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672
X-OriginatorOrg: intel.com

PiBXaWxsIGNoYW5nZSBpdCB0byAoMiAqIHNpemVvZihzdHJ1Y3QgbWNlKSkgdGhvdWdoLiBGZWVs
cyBtb3JlDQo+IGFjY3VyYXRlLiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIQ0KDQpUaGFua3Mu
DQoNCj4gRG8geW91IGhhdmUgYW55IGFkZGl0aW9uYWwgY29uY2VybnMvY29tbWVudHMgb24gdGhp
cyBwYXRjaHNldD8NCg0KT3ZlcmFsbCB0aGlzIGlzIGFuIGV4Y2VsbGVudCBhZGRpdGlvbi4gUmVz
ZXJ2ZWQgc3BhY2UgdG8gbG9nIGVycm9ycyBkb2VzIG5lZWQgdG8gc2NhbGUNCnVwIHdpdGggdGhl
IENQVSBjb3VudC4NCg0KSSB0aGluayBwYXJ0IDEgKHVuY29uZGl0aW9uYWwgaW5jcmVhc2UgYmFz
ZWQgb24gQ1BVIGNvdW50KSBpcyBhICJtdXN0IGhhdmUiIGVuaGFuY2VtZW50Lg0KV2l0aCB0aGUg
Y2hhbmdlIHRvIENQVV9HRU5fTUVNU1ogI2RlZmluZToNCg0KUmV2aWV3ZWQtYnk6IFRvbnkgTHVj
ayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCg0KDQpJJ20gbGVzcyBlbnRodXNpYXN0aWMgYWJvdXQg
cGFydCAyIGFkZGluZyBhIGNvbW1hbmQgbGluZSBvcHRpb24gdG8gb3ZlcnJpZGUgdGhlIGNvZGUg
aW4NCnBhcnQgMSB3aXRoIGEgYmlnZ2VyIChvciBzbWFsbGVyPykgYW1vdW50LiBDYW4geW91IGRl
c2NyaWJlIHNvbWUgc2l0dWF0aW9uIHdoZXJlIGEgdXNlcg0Kd291bGQgbmVlZCB0byB1c2UgdGhp
cz8NCg0KLVRvbnkNCg==

