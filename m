Return-Path: <linux-kernel+bounces-160336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7078B3C19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C13CB2250D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1F149E17;
	Fri, 26 Apr 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUPhDpIG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856E1487E3;
	Fri, 26 Apr 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146975; cv=fail; b=jdjViz2Rvr4qXwDv7fWKoiKDv4cnKCFgccHNiG2xLa3egHEk6NZPEuzLVRrqoAud9/M+0nqJ1FZnXX5R+JUKYf7j3691hy7Gu+P6eYn6GzALq/Ou0ezx47QPN0Be34aH7nlyeuLT4+Ydy0S3DkVL+6XwQ429jvH8FszZEhshBvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146975; c=relaxed/simple;
	bh=PtRfTJjn4XnCsDnwL4I1aUR+kcRJ2A0jk/94GZKbzSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnmJkF+qCJ3lkzlAuKB365b02IFUiBD/gccYSFhxD03phDRPbPdQSbEERMknp275p5SH8mk3HWlwUsUkGKSoxybf1zAJwfdidCACZEoRDPqJ+KG8CsE8wyiKsoHv6miVb/AvdYIi4n14nePUq9l8Cvx1t8uYS8Yq5kW6rh1cLgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUPhDpIG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714146974; x=1745682974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PtRfTJjn4XnCsDnwL4I1aUR+kcRJ2A0jk/94GZKbzSo=;
  b=nUPhDpIG/KCz55HnT3HpzxqPvuxdBFZsSdoxaSAi6WGFMSQDvUKomJ5S
   wbi6IFLdoxY9itfAc4uAAmFOMuy2wtNdPbcCxLzrq0ATQs8CRrge59KFW
   cNBXq5GsTyALvWODs9MjhbccsqAFgd32c/nKjiR3f2g+Ia23H8wHD98tu
   2ufIQqapBEAkihUj7lQzUWCyH5+OBLcfMpKW5w8qLHb4/oJbUmI5UNL1o
   YWD8QLBaqFDeDDLof1lifV/e7sSquhPqrZZo7NG7GRLHa77+kJsqaq66B
   5T7esUywUYTdjvim9iAWTTXRHeFhq44jsHbt9+3glzFox0xXkWAOihjM0
   Q==;
X-CSE-ConnectionGUID: /iVGuKvgRl65HOHgN+3dYA==
X-CSE-MsgGUID: dOpRALoCTLO2zubewjSwJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13718993"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="13718993"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:56:14 -0700
X-CSE-ConnectionGUID: HHWTd56FTwCU6NOnA3VTZA==
X-CSE-MsgGUID: /AxG6bwEQ2KLTy/vO03Xdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25426167"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 08:56:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 08:56:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 08:56:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 08:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3BG63fgTBSevhARJXiqohYdUhQlJckaB/2MGNEPiC1Zs5tkW9HlkDLuDr8XEC6GXBWS0JiZaH8dhTKQyVl+FNl4TNHV6fScmKhdLNQAlkmX07XUZUy9mOs7ZD+9Xzo6C1sCKR6PCHnRGtisH5wOAwNJaBnFIGOV+3YMervGKzHwtPPHfz2GiqEHLPRT/ZPnIMF0YWXkHD5d9qeP8GajyGpwEpCK3WNrcm7qhNW4qdhWtPaP1CElDLsWVpnhTBxnbPlLqFUX9ceZHERWTfHBkiqwz4B/Jqi6eDGBhcFi+0ciL6RYRxBgNY8QwuvddllS0P23e3x7oS0gSsm8fipVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtRfTJjn4XnCsDnwL4I1aUR+kcRJ2A0jk/94GZKbzSo=;
 b=QcuGLUpIO/7Dpsx+ab/M/R6t4wQkchj7tJpclQkR5R+gK7Bn5t29Qs9mSlMoBKxVb0G1qR+nuzqHIa6AB4SCTcD/mnGWm4+mbwTny57s5N7A194oLywiWmcGyZqQTiMlBWC7cihRwhgj29gt+VK1j3F5FYrOsfjCLq5XTUBN76WQikotWL/Cqh3h0WqSFToswZGWAOyIB58NRW/F1RFzfKI/QXzHIq+X9LC+0R0Of1cuZjW2gn7Th1NCDvMFGajXyevmGyjncMVpSpuF5dopG1g7xI0YQK4jf/6GT+e0bQzcCbnYgBsQ+FlysfcQOJlApP7PaqSVSda9QgFlbMn5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.23; Fri, 26 Apr 2024 15:56:09 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 15:56:09 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "bp@alien8.de" <bp@alien8.de>, "jdelvare@suse.com"
	<jdelvare@suse.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Thread-Topic: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Thread-Index: AQHalnNrrHLVRKMzlk+IiUw2AK/C/rF310iAgAAG0wCAAYsAAIAAVjcAgAD3j9A=
Date: Fri, 26 Apr 2024 15:56:09 +0000
Message-ID: <SJ1PR11MB608388251D01FA65D48087D8FC162@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
	 <20240424181534.42216-1-tony.luck@intel.com>
	 <8b138aec-9565-4847-8c7c-8a1fe6972a04@roeck-us.net>
	 <SJ1PR11MB6083E8AFB8E001855DE4162EFC102@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <Ziq2AMcJUyikTtxK@agluck-desk3>
 <2fe8fce0d553eed5c27c51596f5bce780bbd9395.camel@intel.com>
In-Reply-To: <2fe8fce0d553eed5c27c51596f5bce780bbd9395.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7782:EE_
x-ms-office365-filtering-correlation-id: 28881829-c006-4ca0-ef5e-08dc660963d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VjlRZHUvQWdCZCtYcHRNbE1FOTJKVENBdTNmTG41bWV4QU94aUdOOVNUamw3?=
 =?utf-8?B?SFhzUmZMQWwrdmN1R2xJak1MMmpOSkVLTFZ2aCtBaktiam0zV3pKaWFJM1JQ?=
 =?utf-8?B?eGRBNVM5UkZEUmxsT1NoTHMwUVZaczFKSytjQnN1QjZnb3ZVT21NSUtoOVBB?=
 =?utf-8?B?aG1XdTlJVkN1NzZuUHIvdlo1M242K01Sa1hEQ0NPYjh3RktubHgvOVFxSXN3?=
 =?utf-8?B?enNKaFZaRGIxOWI4ZStUTmNsYzE1L1NNampYR1FGRWhmZ0N6bzlia0xEMita?=
 =?utf-8?B?K2tsd2hjYlFlejVNQXlWRXRoMFI5REw5M3g2eThEbFZUYUFwd2FUNThSUGE2?=
 =?utf-8?B?aDVwZ2lVamVJb0hJUUpmRG5Gd004TDM2NlBWT3AwVW9zN0hxcUNTYW1hYXBt?=
 =?utf-8?B?cis4SU9jZEFXNDlGL3B1U2J1cXE0SThOeHhmUUhaWmNBUThhUWl1NlFrSjJh?=
 =?utf-8?B?RXNJWWFiaWFWTEl2RElBU21PS1kvMTRMeHdPSVc2UGJ2OVYvZmR2NDB1MzNo?=
 =?utf-8?B?Nk5wSFhoQ3RBeGN5RHdQb0FXL0tlR21sSElNTW52eHhvOFA3b1kvbExtOGR0?=
 =?utf-8?B?L3c5M2RWWVk1c2NXS05DaUlPZnk5S2M3OGZ5Z1ptem53cVFKTHZqbUlZVDBw?=
 =?utf-8?B?UG8zbitQT3FCMWdjKy9Rcm1jVGRxTmMydGpmSGJrUzJVMVduWkI0Y2cvTWdP?=
 =?utf-8?B?OGRnT1JKTVkxYklRaitPVkZiK1JIdHA3TG40aExpcjZuNE5IblRsYnFoYXJK?=
 =?utf-8?B?eDRQNVVHei9uM1VVdUp5UEhJVXc1dWNIUTRLSFBuZ1BDNFNnNVBsaVVSb3Z3?=
 =?utf-8?B?R3F4TnZ4SjdOR3F2eHl0eUM4Zm8rbVRyWHNGdlRVUUhWM1IrbmQxREFkQ29P?=
 =?utf-8?B?cktDUFlpeldQNXA5OVAxc3E4bVlsc2w5a2hVb1gxTkVOL2hjbm5nK0l4bHdR?=
 =?utf-8?B?ejY1RGV1MlQrN2o3dFAyUFhwUWtTZHJ4dUt1TjRKK21rYW1tNENIRDBIVGRY?=
 =?utf-8?B?czNjL2RncUJwSjUrTFlmR3l0RHpocWZLaktqc0pxbnAxNnFSaVJJQWlHWWJm?=
 =?utf-8?B?Z3VSVmlDdmdMNmF1cG91U094QzV5eXdwUngxbk1PMFUySUZVS2V1Rm9SY2dU?=
 =?utf-8?B?TkJ6dVNJeVNUSWJJNGFoc3FaMk40U01ZTUVXdjRPOUZ2YXJVeHFqSmlNdkty?=
 =?utf-8?B?TUkrRG96dFZKSXdkdTRiSTRhbVRXWGRMMEZkdXNIR3IyUndtamg3YlgyNzJk?=
 =?utf-8?B?Zkk0TU5XaERMNjVDbm9xMHczMmNVMm5QdWtoYk1qUC9ZS1Z5ZWE1M2YrNWZB?=
 =?utf-8?B?cHRRMkFmRlZlWk5hZS96YjZmYXprdlc3dk9NODhuMmpjVi9IS29lUUhoN3Qr?=
 =?utf-8?B?bEpCS2xLTmtKa25RS3lTaTZQN2ZWWWZCeEtWL1UxVW1CZ1gzSXp3SjF1bkxo?=
 =?utf-8?B?TTNIb2FUeEpMRW5yUjU4L0hUeDdkM2d6eldTZ09QM2hQaW1MbVUzNEg0RXB5?=
 =?utf-8?B?L0syRFZJY29ac0daOGRCVjdESjFSYld4RXJ0cXByRXdITitnWjJscGFzcUQ3?=
 =?utf-8?B?NUIxWlBSMXI0Tm5XRWVRRUdkdEVqeDhRcWgvTVMyTTBUU3YrdzU3THFrQWZw?=
 =?utf-8?B?OERzaFQ3Slc5NG5jM2I1SEhJTzdIOFJ4UTNtcStCdnpDYXdaMVlIMGdwTUlR?=
 =?utf-8?B?NS9YVU9rZ0tibUc5UzYvUjVLT215RzZxRWNMYlovK1dPcXF6NHpRUERVYU5y?=
 =?utf-8?B?SHFmdHN0ZmRiRHlBalY1aTVCWHQxU0tPZUNCZ3lnazNhekczTy9FU1VKanhI?=
 =?utf-8?B?TXVhenVZVkVBYmwwM1FvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUEvL2tFM2VXaXoreWRnZldRRHBBR1NsbWhORWgyK1dOR2xBMkVqV1k1YUZj?=
 =?utf-8?B?QmQvWW42TFY5OGd2ZFJwZ2ZQMU1idE5rTFpkb1dYdlJMTEFLWXBLYmVQSXNH?=
 =?utf-8?B?c0dqSUVmbjArYk1oR2Z0M3BsK0wyRjB5VXdDZEtrTGFhYWRwbm9rcFpXUVBW?=
 =?utf-8?B?aEp6NTlqa2FDRlhYMkhWTlpMaXcyd0lyYTVJSjhmVCtxUDdJcTR0aUtjUDlV?=
 =?utf-8?B?RDVQajBnZVRrYVNkQy8zNkdwSWtFZTlTREF3VjNDaHluYVFyRFE1WE5TaWhE?=
 =?utf-8?B?anVKTGpwYXJpb3NESTRQdzVzd0NOamlyS1JZdUZkQ2VqenNjR1d3N2RrSzhL?=
 =?utf-8?B?VCt4NGRoQWZYOUs5S3llYnZMK0tlTkhETlIwTS9jZkV2RXRBMkp2Q240eWFn?=
 =?utf-8?B?Z2RwN3ZWbDdDQVgrTFd2KzMvejh4LzFDeC9rRGsyTGpESXpHQy9CWUR1cXNt?=
 =?utf-8?B?UUlxVURRQWhZSVcrT2dON2RMWXZwUlBWMkYyY3dqQUZxckM4b2trU1JZeTBq?=
 =?utf-8?B?Mlk4Wi9rZUZGeWxOQ3BnTEoySWU3WnEzS2dHWTVhbHlSRzZodFIxdkJDUzdO?=
 =?utf-8?B?bGQyMU15YkJIa3l0M2VkZWJTNzBVRVJ1Z1pBVTJlQjJqSzF0aFlmTm51bFZB?=
 =?utf-8?B?b3R2d3VzN1J4U0xvU3JWMEt3K3NvOGk1MjVPYW0ydHhHWHpXTjhmL2FlU2o1?=
 =?utf-8?B?R3orcGxqU2VHeG12aDdPVUcrNGxYSS9mamVKbS83RG1LbklqenlqWUpUSEpu?=
 =?utf-8?B?cjVuZHdxTnZNeVZDdUNBai9HZlFhZjY1MW1zbGRHYVgzRzR1ZEY4MFMxN1p5?=
 =?utf-8?B?YUtSYXFxcmJyc3pZNFF0USthQTVCaUdTQ2NINEVjQ2lqY1VxNzcweDZxZG5s?=
 =?utf-8?B?TmlGR0JtOTZ2WFRtcWNaTkkxQTdhZnNXNE9rR2d5encxN3JwSGgyZzlCaGxj?=
 =?utf-8?B?R0FMRFluN0ZCS0JaRnozUW10SlpoNkRZWlN3VzU2ZFRYS3o5WWZsYjF0VndK?=
 =?utf-8?B?Z2lKL1NScFpEVzZOc2h3WWx0WUdzR2J6RzQ1VHFPWmpsUTBlbmVHdTAyTXI3?=
 =?utf-8?B?VzVUd01vLytaa2FvSmd3QWhZbkV5bjRpUkNpblp2Z004ZXNFSGg5TTByZU80?=
 =?utf-8?B?em00Vi9qUVdrTW53bW9IU3ErOWdyVk5VN0dLeTYramRVYmRzb3p4UWtIbEhM?=
 =?utf-8?B?MHVrMEtWUXdPbnNKRHZ2ak1wc3VGNTZaNWlkOCs3RGdHTUlEVWVCaXdvVVhN?=
 =?utf-8?B?SmtkVzRYL1pkVzY3NjVUSUJqK3FUcXRlZVR5RUhsZmV0ZTJjWDVKSy91L2E1?=
 =?utf-8?B?WUpGQ2ZrK2pMVXNSVFJ4a21HY2RUM2x5cTdjYTl2cVJkWklHeURJNDdrVHRW?=
 =?utf-8?B?YkVCNVM4WUwvc2I1anVycUtrNEZPZkJLc1NZMVRLZG51SWg2SWllTU9NbWFn?=
 =?utf-8?B?ejJIRm9rVWhtVnVyWDVJSnhEeE9WdytPYWNYN1RoSG5JQ1h2ZVh2M1VVRTE4?=
 =?utf-8?B?bDV6MnBlanIvdzBGV1RnaEs3aldFZ0QrdTFlcWZSQitCNzhhbG1zdzFncnpR?=
 =?utf-8?B?aFRQRmRZZy9hQldpS1FHSzI2YjNtVXp4cXlFS3JGb3VCWVd2aUcwR0kwUXgv?=
 =?utf-8?B?QU5STG1WekpQM0cxMGIrOENtYU1KNUQ0MGlHUFR3LzFBVy9nbCtCZ0VqelJa?=
 =?utf-8?B?RVdFaHl5Q01QcjZtMzNYd1E0WEE2R0RzdHpySDIrbmVPaDVMNEdGTkVMd0lR?=
 =?utf-8?B?NngvSE4zMjdITlBjN1lqSVlJNzRUTXZTaGVjZzZxK0NBei9NOElvK1ppYWhk?=
 =?utf-8?B?UW03MHJrb1diaXV5cWszbUZLdGRwV2xjaVNwNWFxS2lrNGt4MExzR3d4Y21X?=
 =?utf-8?B?NkRJd00wejdUcXVDeXRUQitLa3B4czc0U1JkOHJWa3hhSTVaSTZqVjNkMnR4?=
 =?utf-8?B?ay9JUFdLZVRhMzRNVUNtbityYlYwZ0d4RjU5MEVyN1VaWDJ2KytrYUpUZHJT?=
 =?utf-8?B?R2pxSzN5M1ZnRkhpUFNwbDFHL3JOd1Nqa1dlVHJuekd5a0ZPRHk4akhZTGQr?=
 =?utf-8?B?Z1A2c3hiTm1NRjNpVUF0VXpRYnJXUjBQUGFXUGYvZEFqRWU4S2tPalJhbXhZ?=
 =?utf-8?Q?0iRcswzt7pRRGXzTdTqFQR1K5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28881829-c006-4ca0-ef5e-08dc660963d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 15:56:09.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ar6NmNepUMi800J2RnAcS5QyzZmUJJoQPRjBlvpiK9CBNk9lcCDNjrJlUor9jTMSrsMh1SgNl5TjchgxtM5L1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com

PiBDb21waWxlLXRlc3RlZCBmb3Igbm93LCBidXQgaXQgbG9va3MgZ29vZCB0byBtZSBpbiBnZW5l
cmFsLg0KPiBPbmUgc21hbGwgY29tbWVudCAtIHRoZSBrZXJuZWxkb2MgZm9yIHN0cnVjdCBwZWNp
X2RldmljZV9pZCBpbg0KPiBkcml2ZXJzL3BlY2kvaW50ZXJuYWwuaCBhbHNvIG5lZWRzIHRvIGJl
IHVwZGF0ZWQuDQoNCg0KSXdvbmEsDQoNClRoYW5rcyBmb3IgbG9va2luZyBhbmQgY2F0Y2hpbmcg
dGhlIGtlcm5lbGRvYyBpc3N1ZSAoSSBhbHNvDQptaXNzZWQgdXBkYXRpbmcgc3RydWN0IHBlY2lf
ZGV2aWNlICBpbiBpbmNsdWRlL2xpbnV4L3BlY2kuaCkuDQoNCkJvdGggZml4ZWQgbm93Lg0KDQot
VG9ueQ0K

