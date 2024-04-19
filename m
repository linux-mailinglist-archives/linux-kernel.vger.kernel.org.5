Return-Path: <linux-kernel+bounces-151978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E78AB697
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D881F22D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC813CFAC;
	Fri, 19 Apr 2024 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM7VhuRR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F17168C4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563120; cv=fail; b=NbSuUmh3misgcEjk9RH2Yaj2IXDxlCBZQA794MBQ7+xPXTVu63UGU9YAEkX4cmXLe5KP3oqdvg78kLWCzZYH/0cq+e6bB0x8OrKpE85Lcn/w6aKrXhgSrdsEOcTS+PJnuRUL4k03CapIp+qXwZ3tw8E3WIKL/zlAizjX/J1xcAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563120; c=relaxed/simple;
	bh=IoKd4+ThiBOyN5TB8Dc+/MPAc2NZOfa7LZ7/tatAjj8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gOL1qeM5meIAWCMQc/X11Brp3aKGHPyY4jY/znhnq7xnwv0PgNTAF4TPHKkmuRVyXGGH3sW89KNnMgTDcygVJqp6lkAgiUrDp/J2IWZ8n0Yjub0iHZDJy4AXInCy4Sn99f5GsgcthebMrQ73NiCUH5Q7/xq/tjt5M2j8CpOH7P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM7VhuRR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713563118; x=1745099118;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=IoKd4+ThiBOyN5TB8Dc+/MPAc2NZOfa7LZ7/tatAjj8=;
  b=aM7VhuRRID8HkZ7rxIpEZ/QKPjaDdu4lGc1ikkKAvyvvz9c8aXUW+upc
   KVovrIuXh1OhGvLJDGcHabFbD0rh4nJl3aVRNZoKWTjfiv2ja/2eI1uO2
   b4W0ljoAsv4URd54kDdEgRqspr/yDwVxCSrwnpwRwdojnNCspW8jIatrg
   sa5PIagXQEEuK/kquHo3mqXMJ67zrjOiE7u2MV+J717ByQHTA3RsGzBGL
   FZIzboh5VDtolOErHzLX+R+swcE3h7NIO0JSUeoF/zxLz4u64IVkeDkjo
   0fQeZuweQEMajn5Tyv9luwYVFX/hvL/nB3XVm0mJ6u/Cr5BpKNsuIlVnP
   w==;
X-CSE-ConnectionGUID: Sk+elygQTEmAl8juGnUHWw==
X-CSE-MsgGUID: qOYIgqX2RSqe5dUIrSA2aA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20606501"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="20606501"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 14:45:18 -0700
X-CSE-ConnectionGUID: ZGo9OoFOSrOOoonC6cDUqQ==
X-CSE-MsgGUID: +YLvfungS3iXvw/bdMYNkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23323697"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 14:45:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 14:45:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 14:45:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 14:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt0samzLo5yQqy7kwb+L13UMpHJMYlqbdYLU7iqSvdqsDdM2oWzWATFkT9LKwxqfHMooVkPPp3PJraItwzXiH21Wx6kv85ltsXcF/zhr8Xxk+/N7Pyau4j6iVqzH5ls8sn/0OB6eZ9wzuPnj4KNaIujUbtUf4q/HY3DFSC3ovO65wCt03WNuqVeWkIbhvv7eYcHcVstvTi6AIWOjCTPOJW8XkT1eIYsj1VuI66zcV9Gps2ur5l4SvP96iI8id6nzoLkloQB68xKlAWB68ETddZyiaNqNIyUx4cIZKlcC4mVgzcB4rpYuKa9ptNqjdejaALmmVjYmKr8XTnSFdm3lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoKd4+ThiBOyN5TB8Dc+/MPAc2NZOfa7LZ7/tatAjj8=;
 b=Ll/hJCEszB6dwlSm9G0rwssu76DUIAIHmk4FN1rXS+DY0GoYfddQYWew+TnOPTfoyhVFxBujr4DfUrmMHq2BHED8Y46JRdIUsGC4U74X47hS+ebuQ9QytmWG+OK9zV6dKVblCfPexAEGNN7bN4TY0AeEAOhzi02QgghNymC4GElTIT/Tk7YhPvnDeX3QSUQAtJh18Hoou2EScPU/WNK/ZC45HpeWHHa0HTyeGLvQIOw9OUNnPhIOYmqOxZw62EG2M8Zv4hxKqw//kYPwsoxblCWaVgrKFi6DkM7RXHB8tT+kb6cK4S/Shbp3NhlzGWuumNC7LLi3KWtwOuEgf/V6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 21:45:14 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf%6]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 21:45:09 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PECI changes for v6.10-rc1
Thread-Topic: [GIT PULL] PECI changes for v6.10-rc1
Thread-Index: AQHakqLZvT5kAcb+pUegyhyruE7nCg==
Date: Fri, 19 Apr 2024 21:45:08 +0000
Message-ID: <51cf4c457f1cb77468070e3ec8c3901cd1d056da.camel@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 1fee6ddf-6f43-4304-f286-08dc60b9fbce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?NFJzZFN3RFZqakdXdW9NL213bUhKUVl0ZkhqM2FSMmc2cXZ5NXVVaGl3dHFr?=
 =?utf-8?B?VU1mQno0Z0dUd1hkdGdPUkU4eHFNNldIQnIvU25DT2xTbTlNRVk5R21TZEt4?=
 =?utf-8?B?TDVpc1dybEMzNytId0c3cUdtSVhPWHIwSzdzQTNLSHEyK1E1SWJBY0o2U1BT?=
 =?utf-8?B?ZWNuRkNFTFN0VVBrL3RSdGNTOEN0dm1CRndxSVVSSjBhanZpUXhMWnlkQ29i?=
 =?utf-8?B?UUFkQk5zemtMK2FMelQ0U0VlUk5QeFFidEtaWTBjUzJRYTJJcWZWKzBjTXFW?=
 =?utf-8?B?dUZpYzBzTjVzYUdkUHhRY3U3UXdJNHNmcHR0d3I3c2ZIZm5yUko0OGxhS2ND?=
 =?utf-8?B?MFhzU1N5SkFwcldqaGhWVmphbkJiYnNHUWo0bU9LOVU3SER1eVRkYlJQUFBw?=
 =?utf-8?B?Z0NpaWxqeldCR3dJTzNoQXBtYVpNTXNnUFE2M3dvR2tsRyttRnhvaXMwMnBJ?=
 =?utf-8?B?eVJtYnpJK09EaDlCcHpJUTBoMGpaOXlzc3JXS2QxZkhLellQNHYrT1pXODFB?=
 =?utf-8?B?VTQ0blgrYzJQZkdnbDlySE1xOWZXVXN6UXg4THhmaUxjRFp0V1VBR3B6RFc2?=
 =?utf-8?B?RnVaeVpVcWtpZWxxYUlPOXpXYjRQelJCVHNoMzBHSmI0NmRYSGIvSHEwOXBO?=
 =?utf-8?B?dFpnZWczV2ZWV2NiRW9HRXRPWG1VVUg3RHBCbXJ1SGZYZmxQU1pZWmVSdmpr?=
 =?utf-8?B?NkpvUG80RGJaQTFFUXpETkdsZk9hcS9zQ0NoM2ZWSjhkSVhoSTd3Wjc4eEZL?=
 =?utf-8?B?NmprdzVtWXE1QWhneG1Ba1llNjJweUxGTHY0bkR4SHBtM2VaQksyN2lOR2R0?=
 =?utf-8?B?SmkxUEFJRHhub3g1OFhteUF5OUdUMURQSDhZVEd4R25iUkVKd1ZBWTM0VkRv?=
 =?utf-8?B?VmdrVHowYTh3NGM1SXdVanZuM2xWYzhRQ1pEY0ZHVmRabUpXNDZ3WmEzSUtD?=
 =?utf-8?B?Z3JPYnBwUEQydlB3ckxDcUVvVUo4cm5EaVR1YnZaTkU4cDQ5WCtVWkRldmFq?=
 =?utf-8?B?MDJzR3hyejAxcXpPSTlDbjlma1VoTHd3K0lQYkxYcU10ekVJUFJ6MkkvblRz?=
 =?utf-8?B?RkFOdlliZEpFenAyVXlleVZMNUxWU2VUQnQzN0dES3ptNjR1Ymc4NWdFQ1RC?=
 =?utf-8?B?ZGZMLzhQS0luS3ViMTZTZ3FBQWVWa3pYWVU0bEMyTy9YN25MV0FYdm9iSUdC?=
 =?utf-8?B?ak5qK3JCZlBCVjVVUHUwaWU2S0hlNUVpaHV4NnV4ZmdSWTBteUFJYlJEdk1Z?=
 =?utf-8?B?OVRuYVN3OExjWUY4YWhzcmtJcy90UE5SYzZiNEdndUtiK3FOWHVyeVhxOVlJ?=
 =?utf-8?B?QzFGd3Y3YzRWWXFvbWkrdVRXQThEVko4UUVRTmpWeUVCb1dYNWV5NWVQM09P?=
 =?utf-8?B?OHNKZVNYejYzOE9Ha3JEWUxLY3RycExGQ25rRDlwYi84RXUwNGRhVW1JM0xs?=
 =?utf-8?B?MFIzK0NNV010UFFCcTBmRkVTOE13ZUsybTg5T2tYRTZhejdickFSRUhYZU9O?=
 =?utf-8?B?NXRGVDlERERMbk9Ia3drZldqMkZBQUZ0bStRK0h5Y3FxdG9udTN0c2o2ajBn?=
 =?utf-8?B?aGNGd005ejN2Tm5kbXE4ZGYrT3A5NlVLTUx3OWliNDFpcHlFaCttWUEwR2N1?=
 =?utf-8?B?RXFHdjN0Q1ROa1dwODhBbnhWNEt4eGxacm00UGJxZ1FpL1ZKSmxRRFdINk5N?=
 =?utf-8?B?b2szUkRQNGFzSmpnWm1YZ2l1emFvc2VKSkJQUHk3SjArU0RIeG0zVTg1VXBM?=
 =?utf-8?B?eVNLdlRHWVJsL2tGOFZwVXhLc0ptYy9RblZKc3REL3VDQ0xFS3pucTVraFQ4?=
 =?utf-8?B?YitlNExHa1gvREdHaGlBZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZzbWlDaldBbE8ycWtJZjNYbmdNQkxYTURUSDI5WmRvMGpDTkQrS1hHVE12?=
 =?utf-8?B?R2Y2UGdmNHVITE5leHlZb1h1Q09IY2ZhODdCL1BRSkx2ZnBxQWNJblg2eEZB?=
 =?utf-8?B?TlZ3SFZ2RStuM0k0TGRMTUtXN2pObkhNU2x3N0JWYU9LWEkzOVluUDUxUno0?=
 =?utf-8?B?dGc1V0xGVk1NRWd1bHVMdzhYdm9JaS9rWkFhdm5HSFpULzA1SVpoWHcvYy9u?=
 =?utf-8?B?SkJRVUd6MHM1NzI5bjdsNVdkL2ZBeFRLemZ0QnNSZ3d1WnFnUWp6aEZLUHpp?=
 =?utf-8?B?OFBzVzlBZ25BODV5aFRmTnhnMEJYOHZQUEJtMnBhd1M1MkpOZTd3RzNUZlVn?=
 =?utf-8?B?Q2NRSzVZYjRTWEl2ZENsamhQQWJ3dFJiTFBxbUg0SWRmcEFBTzhBMm5EaHZL?=
 =?utf-8?B?cDV3VUh2Ym1oUEZ3NkJ1Y252TUNxSll4U2tZVXB5UHgxNDY4SVgrUnE0RFRR?=
 =?utf-8?B?MHFCZU9va1BzcVBYUCtBczE2ZGFkdSt4R3g4WnppV1FGY2kwYTVEL0hnZTNm?=
 =?utf-8?B?TDMyYWNuNDhmdzQxbFg2dXZxZ2o1VGwwckVXOHgyK0oweWpTb1hwTFVFS1lD?=
 =?utf-8?B?OWttY0dQTG1iRmZ0bzRUd3Z0WWV6L2VpQlVpSEF5bENpeGJQMUFHWE5MMnVr?=
 =?utf-8?B?Rks5VmRxdnd5ZGhUSFJ5YUJXa3Vjb2VCQVNLUlFnd0NYY21SWElubHBZQUpz?=
 =?utf-8?B?ano3NG5HNzhXN1NGZzZnYkxCYWx2Y2xWMkZpUm95dGlIQmY0L0F6aGVudWFn?=
 =?utf-8?B?dXRYRGVncmcvUDBXMjVlcVMxcmI1Zk9DRGVXQ25UNmVJMjRONVk3YTg2dis3?=
 =?utf-8?B?cTlzTi9xMm9hRWdZQnBpbHVTV0JvUE40TlBzZ1ZSczc3cVg1RE9ob1JMK01F?=
 =?utf-8?B?d1VYZm5EUFhURWdvRFhsZjhvODhoZlBrYStSclRWeThQTlRTU202R1FKTEt0?=
 =?utf-8?B?MittWkFueWg4ZzFwVytxdG4xQzhrazB1dURLYXc0N0xhbXRha2lGMzg2c1Fu?=
 =?utf-8?B?ZkYzV28zb29sNlhXczZBZG5KMGp4NXZRTitsM2VvY0ZKQktOdG9KTDhLTkdk?=
 =?utf-8?B?OFIwMnI3T1hZMzBFdlhYeGZTMndQeFN0cGRmbzJRWlo1UmZrQmljMTJpT25D?=
 =?utf-8?B?OFM5NWk3eExESEwyWi9PRm1NV004RVFyWGFRUTdabHc3TGhsRDZqN291alpN?=
 =?utf-8?B?TExidTJtTFRweHE2cmZmNUtRemZKWFE1a2FFQUpPa01yVVBIMUJYbXY0K29s?=
 =?utf-8?B?ckxyaWQ0aEE0SVF5UDBzMW9qRzVrclRRdlRNRXZCaE80SEFua3c4WlNxQkxI?=
 =?utf-8?B?MDBZZ0NOSEs1Q2kxTGdSQ0VyS0p5ZU12WS9jWU5CRFhNSWFpWWVFYnF6V0wr?=
 =?utf-8?B?R05wS2ZTVTNnVk9ZL09DWUpBb2hML0xQVzI3cWFOZHAxeHBFZitRVUdBWTEx?=
 =?utf-8?B?RFNyVll4dHRtR0gwRURMd3lyc3pvN0ZlMGFaY1lmSDNUOFRLRFBScFNnaFBk?=
 =?utf-8?B?OStNM2dNY1VPQU9lY1NJQ0lhY09uaTQvVzgxR2dUUWNlYUJJenJlejdRWERT?=
 =?utf-8?B?bU5aZnZJR1FMbWVHVytUaW9Dd1JUV1FqVVFWbFVXR2Z1aXFWRGF4N3ViaDNI?=
 =?utf-8?B?Ym52OWZUK2dRTzVCRTRTYmlIZ0pJdFNkNkhwaDhkdm5iRDRTOUR6TktoQWt1?=
 =?utf-8?B?Y1NpNVdEKzd0UVFXSXpkeWdKTEQ5RmRyUGcwWDI5Uy8xWHlrSmU2UE9LdEVi?=
 =?utf-8?B?UndyYWhsKzBFNVFxK1FjNGtkQnZ6N2U4bnpFWXpNNGRGWE9IbVhYRVZ4bGRr?=
 =?utf-8?B?alFxVHltQ3NlWFNqQXhYQUZCMXhDVVppMFRsb1JRazdkTVQxQ1dIT3RsRGRn?=
 =?utf-8?B?eVVIUEU0SGYyRExobWk4Z2xXWlNLWEVoSmFHWGNmZ3dZaVRyYlk3ZndUbkpQ?=
 =?utf-8?B?Y25jNS91V3FMSWVvcldqUjlVb29obUNnaGV5ejhVbnpuQjJ5R0ZSSWUwZU5Y?=
 =?utf-8?B?N2tLZzZyQWlJU2krQVBabVpwd1pSTnlhSGRKZTlCSTloSElmUWhoTURPQ0xU?=
 =?utf-8?B?czZ1Z3JqVTIzMVNseTFBK04yWUxoNVRnSmc0TVg0b2FpTG0wNjduQ0tPQjFT?=
 =?utf-8?B?SmlaZkduVUxrN0srWGhyeE5hK29oLzVUNXlONURYcSt5N09RelNRQkVYRTFx?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0190C1F889D4C04FB6521187ACBB74CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fee6ddf-6f43-4304-f286-08dc60b9fbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 21:45:08.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YpewAmpAVcoFhumtGfe8RE49eHEVslzJg0ZHgUxEyx8yOhmPiSPk8ZhnBBbCV+8eEbLW/FB/ZD2VT/EQDLkkxB6siAu6Q494nr4B4bApME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com

SGkgR3JlZyENCg0KUGxlYXNlIHB1bGwgUEVDSSB1cGRhdGUgZm9yIExpbnV4IHY2LjEwLg0KDQpU
aGFua3MNCi1Jd29uYQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDBiYmFj
M2ZhY2I1ZDZjYzAxNzFjNDVjOTg3M2EyZGM5NmJlYTk2ODA6DQoNCiAgTGludXggNi45LXJjNCAo
MjAyNC0wNC0xNCAxMzozODozOSAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJl
cG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2l3aS9saW51eC5naXQgdGFncy9wZWNpLW5leHQtNi4xMC1yYzENCg0KZm9yIHlvdSB0
byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGU2ZmFmMmI3NTBlYmYzODM3YTYzZWJlNDY1ZTdiNzkzMzUw
MmJkYzQ6DQoNCiAgcGVjaTogY29uc3RpZnkgdGhlIHN0cnVjdCBkZXZpY2VfdHlwZSB1c2FnZSAo
MjAyNC0wNC0xNiAwMDoxNDo0MyArMDIwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVXBkYXRlIHBlY2ktbmV4dCBm
b3IgdjYuMTAtcmMxDQoNCi0gTW92ZSBwZWNpX2J1c190eXBlLCBwZWNpX2NvbnRyb2xsZXJfdHlw
ZSBhbmQgcGVjaV9kZXZpY2VfdHlwZSB0byBiZQ0KICBjb25zdGFudC4NCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUmlj
YXJkbyBCLiBNYXJsaWVyZSAoMik6DQogICAgICBwZWNpOiBNYWtlIHBlY2lfYnVzX3R5cGUgY29u
c3QNCiAgICAgIHBlY2k6IGNvbnN0aWZ5IHRoZSBzdHJ1Y3QgZGV2aWNlX3R5cGUgdXNhZ2UNCg0K
IGRyaXZlcnMvcGVjaS9jb3JlLmMgICAgIHwgNCArKy0tDQogZHJpdmVycy9wZWNpL2RldmljZS5j
ICAgfCAyICstDQogZHJpdmVycy9wZWNpL2ludGVybmFsLmggfCA2ICsrKy0tLQ0KIDMgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K

