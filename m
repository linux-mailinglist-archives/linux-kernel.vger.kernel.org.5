Return-Path: <linux-kernel+bounces-123222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D68904AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C5E1C2F29B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1112F5B1;
	Thu, 28 Mar 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpIzczZS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A748657D3;
	Thu, 28 Mar 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642300; cv=fail; b=mnIT3AUfYwWb7faUHFi8nD4h9DpLDep1dLBm0ZI1DFYU2Uv0bI6ZvOMmCm5oPLeOyp36GkvoMU4NMP7bmXPk14481abS5TS2dC61gsyoxUIkr/78k0v92bhuE0uaKWCVb9WPYJqHNw+hnXQ/zbHxFKqHQTRdDsx+99qbzWXA7rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642300; c=relaxed/simple;
	bh=acskBvmjEgq3YSyBHkaeADgC20B87LAhA8BqCFQK1hU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pF5YLrtQ5k5FDY6HZYkrNoGoH6TFadqD+H2vUqfxnjnkfHcWIotVzHM+EV6YA88kklpozA9+pj3PGvyfUr7FEbETLrMS4x//JuUnvLpZbrfvKfx+JvvyI3YtmQ796rtFqeqg6dD/1RgbAX5OT/USwtiCk4KqliBrREfN7bj5d2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpIzczZS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711642298; x=1743178298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acskBvmjEgq3YSyBHkaeADgC20B87LAhA8BqCFQK1hU=;
  b=JpIzczZSWTv86/+i/OmYzqja/kt85RHADmuoWprrWDM6RzWTdSpqTKEE
   p0YGRgF8LFpAwg3jtMVRZ0W7Qn4IJSn355y4LWOO7nz6XBJVcK6I0eZhC
   Ify5SE7Fkr8A6yv1h8GD98rgAXUv7MCugJo/2rNsW/A3MFdolA4+bMLO7
   olxTay4wir8y5L1K0IhXLEUNWF2b6Wwng9NoHKPdtBfh6I6Dj5FNTCuRx
   IJtS84n1Dy+D0YpmWVMKIFzE1RmlshN92FaXO3A6Hu75p7iv1uCZV+zSr
   ZihvcRiCQx3qtI2uEVJkCwuDIkfjmU4ASiaGvKBZJaKDtR4guZwLN3EkI
   w==;
X-CSE-ConnectionGUID: KWP24ZnSSGmyjN3OCIk/8A==
X-CSE-MsgGUID: aol7/b7qRwukxn4HwK3Drg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6694397"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6694397"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16626150"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 09:11:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 09:11:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 09:11:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPBz53/EXkoxucWle9PSB+/zMCBvjnaEwM7B+nAyxBi0SzIKKcNGXGjcnj7Nxio4k+KnYzg+kagFHjXDTDh2T7fZmr053r8YVXU2TZpvRTQlXLwLROmt6MqlhZjEUwuSfsCA4adTDwgHoY7OrltUNf4o6modSG5W/7wKlHoHOpzZEdF5JLV7N+FDjmGAlATziNgTm7yMcbU7kFWu6/1G9sgmc5lL9+xgL8MsQ2tVbXfcVM2oo54BhHYhRvjDiOrIfZlF2T1sqcyzI7i7+yMdKCn+AgS96tvP7SqdFyeN1KseiCkasylbQ5Y4TQCJy4E0mwy3lH7d975GOKdOwoNuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acskBvmjEgq3YSyBHkaeADgC20B87LAhA8BqCFQK1hU=;
 b=mTeGA5dmy2Vpt8LCWHt4kLQKz1dATfbKtc1S8gTGhDvJ0FHCufTRAUNWyoXccUzSWNvFvvahIicfBQLvRPl+L+N7xBz4dh0VtvQhl27MaOkS58nZHKS1j4nO9D4IUymKRrhwoj3MoG956kjzXv5nlXrXnDS86bIlZ7yxDnQLSl7Ytk2Q66MVHs76kB13TqXWKiwfx8Sy9s0VQI/ZcrvW0Bb465kzjDbQ/cDYrvKzffxZJ4YozEuPR2NwNH4cvHjLsfTxrtuhB+RAAJsTvVxpEJ3HVu20dOVxXK1paDRpQFIkeH35TMaU8Sgo8VrnJNjNVKh7oCf04sBUQpI64J0atA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB7373.namprd11.prod.outlook.com (2603:10b6:8:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 16:10:52 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::85:b53f:9a2b:e2a9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::85:b53f:9a2b:e2a9%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 16:10:52 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Brett Creeley <bcreeley@amd.com>, ivecera <ivecera@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: Fix VF MAC filter removal
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: Fix VF MAC filter removal
Thread-Index: AQHadU5G7azxrMmA7kagb4BZSPCvCbE3ZRoAgBYFKXA=
Date: Thu, 28 Mar 2024 16:10:52 +0000
Message-ID: <PH0PR11MB588019778E6245953E0ADB188F3B2@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20240313135618.20930-1-ivecera@redhat.com>
 <d66bc516-c5b1-433c-a128-a28d657efea7@amd.com>
In-Reply-To: <d66bc516-c5b1-433c-a128-a28d657efea7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB7373:EE_
x-ms-office365-filtering-correlation-id: 79fcd133-785a-41d0-7428-08dc4f41a407
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dDLtZC/21H3sCGSlp5vjtvX6nZ5xUDcsq/fgAhLgP4SdIoOX8f6G4yjHluDcoR3Yf6zH63Unvjz4NbFzZhdthj2AQSm/h3A3Fyzk4QruhcpUepOgkxlV0w/4OfXDlSoZmO+4pOFCRnpuYzeaf9jUDfIl8L3QlF4w7wUyPOXgIlp99Ykukim0xA+5FdM4fhxwbmUIzTysR3OsnQFiTTtdox+B3RqvRt35XLaU0bGcEDBWEDZN83JLz/d2xZL4J4/aMyTg94xsADoMFX7gFIHWkEVfDwW1iQWEKo9bWicLDBYpXworagyU1+mXe3Jdjvfaik6ZuRfW2eea6urUQRdqZJpPCZiijzwRdxWj5C3dR2vIDMfLbd3bBhTM1UeVQJAMtWNeFoNx5DIIzXqljYTRdEMalcXTjIjofeBi0b1dTF1fnQEnGWL6hFsTDf8NvmjQRTselZyk8n4gFJeKa0HKqIS/HlTgYr3M0VldQxJVdcCaPWQLJ1D8TJS4xEOI7X5ciDCCNehizwqrI56arrSneAM/5gGnfZyvl4jL8X4Elz+wtAVGNRngBtDzxq9ToFQZrrcYg5GtBXnPljgZLNOytXAymjGh5P/ha5tKsix9VfEWMOd+QJ3kSfRF/lxl9jkbucbIbAvRYPoZ0gQ4W2nfwYH6QbaC7z2GPtkQZQK8GICsihWmkrUx6Caslnu1R7kjUGhFtvGDt+TB/l1cxfjOq3hCnt0yRJ0dSGC01u1UT+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2JzZFZYWGU0N0xxOUlUaHZiWjVxNUFqRzVaMGpGbFlubEI3Z3pKSVk2NTky?=
 =?utf-8?B?TXB0UXA1WXhWMjV3dTZXUEVDdnZuaWdmcWVJcUtYcHBYQzllclh4M3hYT0s3?=
 =?utf-8?B?cFBNZVZmYkhlYml6RGdEWkhvenJ6VXY2NXFoWVdGUmQycmFNa2drYlFuaVdD?=
 =?utf-8?B?bXJFbnBza3ZzbGhJdkt0TUlOM0hZTE1UWDVTUFpsUyt5OUJtclcxN3pwbHJZ?=
 =?utf-8?B?MVhwMVZCNkQ3MTNCeThRa01iWnF5QTJlYkRUc20zaS9ZMWpEV2EvOXBsRko5?=
 =?utf-8?B?eEtjemlFanlGY2FlaFg4WDB6d2djVUZSK2c2c3VCUUtRVFBlL3V5SjJVSGVV?=
 =?utf-8?B?Q2o2Umd3SUxvcE9DdC90VVVOT2RkUUFlejdacHJESzR1dytkakNyUTducXZj?=
 =?utf-8?B?RU1qMlh6K3B1ZVBtS3k1UGMrc204SUllS0ZZaG9EZ1VuZVVYcGEydEF4V0tE?=
 =?utf-8?B?WGx2QVpvT2RPMS9Dem03VERXYTIyTFdIemZudyszNGN4cFVCaGpJZUI3VlJ4?=
 =?utf-8?B?d2xTU3I2am1ZcE96K2JIclR0WWF5RWowbmgvcHlpMEU4RHdiZmF6djJleHJR?=
 =?utf-8?B?Q0ZuR24xMkg5VU1oRUJxV1k4bTFQWmFGWEM3TTFLSlhTK1k5T2FVLzFCTDRZ?=
 =?utf-8?B?MWlZNTlGZEc4V2JEK3lycTNvL2kyUVdzbjZ5SHliRWZzakRpcTRLMHZmalp2?=
 =?utf-8?B?QWJkckgrRUtRVkhsR0Q2VlU3V2JDUXJVRlptVHlFcjdLQXkwQWtrMDBLM3BP?=
 =?utf-8?B?YXBwaitaMlhCQUJTQUQ4UWVQdG1ZUU9EVkxPZ1dNT2EvdkVCMFQzdTdBVlJI?=
 =?utf-8?B?MkhkcVVZdzJpZEpiYnVSQlVlazdqTDYvM3dmTTZxbnc1RnJtZnc4bFdJaE5p?=
 =?utf-8?B?VUFjNzBWczRJK2VJdVpOU3llSzEzb05jVGRlUWR1blBYazBPdURoZ3RvVURp?=
 =?utf-8?B?MXdBNWgyWXI5N1p3bDlnbW42NlpLRHJyS0JkRk8wMlJ4K1RMVW5DMHZjUXhu?=
 =?utf-8?B?dWVLbHBaRUdOejNmaloyMWwxanJ5SDJaRGFqTk0yanhUVkhuYm52VUlyamhE?=
 =?utf-8?B?WXVnelhiSElqUCt2eStVcWFTTzFpMkg1TkVDZ2lzUTlneklJRENMUXh5L3pR?=
 =?utf-8?B?QjJYR3JlNmp1V29UdmZDZWNCOE85QkgvOWg1a1ladXBETDA5eUZkTndWV0cx?=
 =?utf-8?B?MmhRNmhCV0ZvcjVaU3hwM2Y1emZwS0RFZGhuVTVBSXRrQThyTnBXSmw4WGlo?=
 =?utf-8?B?ZXlGRjI0emszMjRQdUpXYVZUSmticW5NMGFxNDVIVUFLNkpqblRuTGpmRXpm?=
 =?utf-8?B?RmFnazFaWUZSWHZITUZUM3djUzVDSnczUTNjR3lqYVBpNUhmL1Zvc0RuVS9R?=
 =?utf-8?B?a3RIckpqNEc4SmdyeWJzN0MxMURpUSs0aWo3eEZtV2htZmNLamU1MHN2TWtr?=
 =?utf-8?B?M2diVlE3dTlqYmgrdnVnTlZacjZaNmhOZVQzVXRNQlFEdHMvWG5MVW45cHBJ?=
 =?utf-8?B?QUFyVzhmRVhEKzFQMi9IMEQyeFhIakIrbU5iV2h5WnpwL3BpYjRtTGtqekYx?=
 =?utf-8?B?R2orRS8wMVU5RnJCNWR2cGlqWnJvVlQ3aGw3S0lEblpJWUFwbWNaSHVIQ3Ro?=
 =?utf-8?B?bFFiL0NPclpvMTRyMThIWnZTbUptTkhGOHppNjZuRmdlZkIxRjE4UXRTcVZG?=
 =?utf-8?B?bi90K2ZtVVFyVU9yNndzQ2oxVi9iY2hveEtlR0o0TXlkcnRlVkl3NU9HNnZz?=
 =?utf-8?B?cUIySlBxR2dVcy9ZcjVuYWdkYm9UcGx4dFJnalAyQUNYNEZjekhoRFRsZkNJ?=
 =?utf-8?B?RUpvUUMvZGFDZXdNK3c1aGkzbkFRbXVrWHZIZGJ0SUVlZ0FEempodHhOQ2N4?=
 =?utf-8?B?cGc3UWRIT3c3TUw3YzEwcFE2VENPTngwM2JWN0l0RmduVkwxQ09rRy9GYkFF?=
 =?utf-8?B?TEFsOE44c05EaW5VSTdsNElRZVhCNEZOeWkvSDRTSVNmSEFCaG5EaXNmR2Mw?=
 =?utf-8?B?eHdOTUhRNDdZcEVTeDIydnduaGVYTVZQREZFemU2Y1MyMStnVXRWb0FMa2lv?=
 =?utf-8?B?SGpzRHVHeDRqN3JmdWY0SENRQmFnWFhpVW01TUcwM0Nydlk1ejFlL1h2c0Fa?=
 =?utf-8?Q?JNTl1IZdMxQph8LBozVcJ4Qvt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fcd133-785a-41d0-7428-08dc4f41a407
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 16:10:52.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4h8VLKv40Ls/U5BYSRRieg0psbyRpQNQtXJ8wtYZ0Uv4vmkdqAxNicIbTlYv0YiaJNW1ztf3+vTZhQNiIl0kZ6UpvHlRLa04T7RFecwdmFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7373
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBCcmV0dCBD
cmVlbGV5DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxNCwgMjAyNCA0OjU0IFBNDQo+IFRvOiBp
dmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBtb2RlcmF0ZWQgbGlzdDpJTlRFTCBFVEhFUk5FVCBEUklWRVJTIDxpbnRlbC13aXJlZC0NCj4g
bGFuQGxpc3RzLm9zdW9zbC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBMb2t0aW9ub3YsDQo+IEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBOZ3V5ZW4sIEFu
dGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBob3Jtc0BrZXJuZWwub3Jn
OyBKYWt1YiBLaWNpbnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVu
aUByZWRoYXQuY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0K
PiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldF0gaTQwZTogRml4IFZG
IE1BQyBmaWx0ZXIgcmVtb3ZhbA0KPiANCj4gT24gMy8xMy8yMDI0IDY6NTYgQU0sIEl2YW4gVmVj
ZXJhIHdyb3RlOg0KPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4g
RXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFj
aG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gPg0KPiA+DQo+ID4gQ29t
bWl0IDczZDk2MjllMWM4YyAoImk0MGU6IERvIG5vdCBhbGxvdyB1bnRydXN0ZWQgVkYgdG8gcmVt
b3ZlDQo+ID4gYWRtaW5pc3RyYXRpdmVseSBzZXQgTUFDIikgZml4ZWQgYW4gaXNzdWUgd2hlcmUg
dW50cnVzdGVkIFZGIHdhcw0KPiA+IGFsbG93ZWQgdG8gcmVtb3ZlIGl0cyBvd24gTUFDIGFkZHJl
c3MgYWx0aG91Z2ggdGhpcyB3YXMgYXNzaWduZWQNCj4gPiBhZG1pbmlzdHJhdGl2ZWx5IGZyb20g
UEYuIFVuZm9ydHVuYXRlbHkgdGhlIGludHJvZHVjZWQgY2hlY2sgaXMgd3JvbmcNCj4gPiBiZWNh
dXNlIGl0IGNhdXNlcyB0aGF0IE1BQyBmaWx0ZXJzIGZvciBvdGhlciBNQUMgYWRkcmVzc2VzIGlu
Y2x1ZGluZw0KPiA+IG11bHRpLWNhc3Qgb25lcyBhcmUgbm90IHJlbW92ZWQuDQo+ID4NCj4gPiA8
c25pcD4NCj4gPiAgICAgICAgICBpZiAoZXRoZXJfYWRkcl9lcXVhbChhZGRyLCB2Zi0+ZGVmYXVs
dF9sYW5fYWRkci5hZGRyKSAmJg0KPiA+ICAgICAgICAgICAgICBpNDBlX2Nhbl92Zl9jaGFuZ2Vf
bWFjKHZmKSkNCj4gPiAgICAgICAgICAgICAgICAgIHdhc191bmltYWNfZGVsZXRlZCA9IHRydWU7
DQo+ID4gICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4N
Cj4gPiAgICAgICAgICBpZiAoaTQwZV9kZWxfbWFjX2ZpbHRlcih2c2ksIGFsLT5saXN0W2ldLmFk
ZHIpKSB7DQo+ID4gICAgICAgICAgLi4uDQo+ID4gPC9zbmlwPg0KPiA+DQo+ID4gVGhlIGVsc2Ug
cGF0aCB3aXRoIGBjb250aW51ZWAgZWZmZWN0aXZlbHkgc2tpcHMgYW55IE1BQyBmaWx0ZXIgcmVt
b3ZhbA0KPiA+IGV4Y2VwdCBvbmUgZm9yIHByaW1hcnkgTUFDIGFkZHIgd2hlbiBWRiBpcyBhbGxv
d2VkIHRvIGRvIHNvLg0KPiA+IEZpeCB0aGUgY2hlY2sgY29uZGl0aW9uIHNvIHRoZSBgY29udGlu
dWVgIGlzIG9ubHkgZG9uZSBmb3IgcHJpbWFyeSBNQUMNCj4gPiBhZGRyZXNzLg0KPiA+DQo+ID4g
Rml4ZXM6IDczZDk2MjllMWM4YyAoImk0MGU6IERvIG5vdCBhbGxvdyB1bnRydXN0ZWQgVkYgdG8g
cmVtb3ZlDQo+ID4gYWRtaW5pc3RyYXRpdmVseSBzZXQgTUFDIikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3ZpcnRjaG5sX3BmLmMgfCAxMSArKysrKyst
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBl
L2k0MGVfdmlydGNobmxfcGYuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQw
ZS9pNDBlX3ZpcnRjaG5sX3BmLmMNCj4gPiBpbmRleCBiMzRjNzE3NzA4ODcuLjEwMjY3YTMwMDc3
MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVf
dmlydGNobmxfcGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUv
aTQwZV92aXJ0Y2hubF9wZi5jDQo+ID4gQEAgLTMxNDMsMTEgKzMxNDMsMTIgQEAgc3RhdGljIGlu
dCBpNDBlX3ZjX2RlbF9tYWNfYWRkcl9tc2coc3RydWN0DQo+IGk0MGVfdmYgKnZmLCB1OCAqbXNn
KQ0KPiA+ICAgICAgICAgICAgICAgICAgLyogQWxsb3cgdG8gZGVsZXRlIFZGIHByaW1hcnkgTUFD
IG9ubHkgaWYgaXQgd2FzIG5vdCBzZXQNCj4gPiAgICAgICAgICAgICAgICAgICAqIGFkbWluaXN0
cmF0aXZlbHkgYnkgUEYgb3IgaWYgVkYgaXMgdHJ1c3RlZC4NCj4gPiAgICAgICAgICAgICAgICAg
ICAqLw0KPiA+IC0gICAgICAgICAgICAgICBpZiAoZXRoZXJfYWRkcl9lcXVhbChhZGRyLCB2Zi0+
ZGVmYXVsdF9sYW5fYWRkci5hZGRyKSAmJg0KPiA+IC0gICAgICAgICAgICAgICAgICAgaTQwZV9j
YW5fdmZfY2hhbmdlX21hYyh2ZikpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgd2FzX3Vu
aW1hY19kZWxldGVkID0gdHJ1ZTsNCj4gPiAtICAgICAgICAgICAgICAgZWxzZQ0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXRo
ZXJfYWRkcl9lcXVhbChhZGRyLCB2Zi0+ZGVmYXVsdF9sYW5fYWRkci5hZGRyKSkgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChpNDBlX2Nhbl92Zl9jaGFuZ2VfbWFjKHZmKSkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdhc191bmltYWNfZGVsZXRlZCA9IHRy
dWU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gDQo+
IFNlZW1zIG9rYXkgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogQnJldHQgQ3JlZWxleSA8YnJl
dHQuY3JlZWxleUBhbWQuY29tPg0KPiANCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgaWYgKGk0
MGVfZGVsX21hY19maWx0ZXIodnNpLCBhbC0+bGlzdFtpXS5hZGRyKSkgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4N
Cj4gPg0KDQpUZXN0ZWQtYnk6IFJhZmFsIFJvbWFub3dza2kgPHJhZmFsLnJvbWFub3dza2lAaW50
ZWwuY29tPg0KDQo=

