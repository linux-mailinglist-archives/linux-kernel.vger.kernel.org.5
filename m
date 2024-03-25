Return-Path: <linux-kernel+bounces-116968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6C88A5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9CA1F3F5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48ED5C61A;
	Mon, 25 Mar 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQeb6eir"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D4185F07
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368278; cv=fail; b=nif3bqBGi8l60DMDnDKDckqYem0G9q7H4SLAI4CvlwCZJW198LAGLftf6Z+2dlN/ineFCDrc7tYMLfnT5igI401mRwM/JohJkuVPLnksdMvhIZm8MFh2ZsL7+x4SbC/uF6n3WyKiHekh6Gz6PM9Ouyarfm20xv8CK4p1sIvk8O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368278; c=relaxed/simple;
	bh=hhTAGd7/eukbLaohJYzQcL/2D8rdUUCNaZZkUdTcEvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIWNmRd4SKqrvJsWc7vjexwM/tPmZ584AsnXl9ol8+1E2r5imfr1RsHw/KP6EIsHetO4FGi1len8qcCugl61bcw4c1LMdppauIefzyciqvr6VUPGfVjDxBSIOFQYmTjFjp0XyV+cWzPJLKNeJ2uCqbG7WfpUuzEnyXc4URrv9jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQeb6eir; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711368276; x=1742904276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hhTAGd7/eukbLaohJYzQcL/2D8rdUUCNaZZkUdTcEvY=;
  b=BQeb6eirHupxz3SmxdB3cOCSyXPUMKG/hC0Ki6LlJ7Giau0R7mGpMIaG
   jhZN7uQv2JgvoxSrU1hVflgEN3YGACINx5G/fwfVK2eOLhlTPQdrgWzo4
   kpWNK64QZN6svHOD1cZC4DmkmhHLUHTfIESVLBWXrvqNr9zaaI7y4+AsV
   bTzH9FZ2z6ui6oTCIehdjewJM9kLazKaWuwEN5QwL8Pr36wIQBmGKmSSu
   o9M2f9XHYfsFzfEMkKaFXPGK3EvohySLM2u8/jHfoOJX/Ply+pZRG+XPV
   EmuK3mq6dGQSRdBMBd0vj4VsVIEgwLkI/NMdpTAUeiBLWs1xymqwTrgeo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6259416"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6259416"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20262900"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 05:04:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 05:04:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 05:04:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 05:04:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 05:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCXuDJLb4vtHOJLbDNHGWFwsZOuemYk5c5hM3H9CSEU+tPDZZjwNuvG2NjXn7RzCiEi4Pf0U4pnO71cYz9x+dmb6f54+LZYyal6DlW2DEWkn1zmMq90lDBMY3TWuj5kb0s9i5ZI3whb0W0lZhj82E0gL13JOh0lSuzXxwX4aZoNCSVrMSxTTojwKhdUDo/deg3IAo4g9gUkOscjZu1b4Xqj+oAFdalqXq5tswruOAvOZdduCMYZcu4+xl7I7e/xFGcBIw1wn8ch1HbJCc0eOBI8Yute0TSlRl5WQLsGhnDkLgcO+5nG5GXT/Kq/4KdY+Z0Z05ME4ab7sidt4NqT8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhTAGd7/eukbLaohJYzQcL/2D8rdUUCNaZZkUdTcEvY=;
 b=YSY1x+ZYsYxdbBfcx5SqAczrpd+dzbYkcyk2DVcBw91ckGsJy/27YXq0mE3J1EJtyJu+aUD1h3NQ+XhB1uFsqqDjONVyneokeOOb7hYUSwyhyq9tHqp3B9IQn36IOHL+AODjICH5EYcLMYTSTv6cIJQL/MCcSTvJQ58Dp0lJmC5lsWxQCE5tPqe3Kiyn9WBrrzYKH/20XKjCa4EEnEr+A/MHZLyruU9sqQzHX84Mzh7hc5DOuE0vwWTgVZFZY2a77cJrDRPSet5k6j4FHj/lYv0pHrajl0UWA5Q11e5dhxCQCvMlyEtn+e7j+LapHv7oiFY7u5A1+bWpLWv6ymlt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 12:04:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 12:04:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "jgross@suse.com"
	<jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH 3/4] x86/boot: Explicitly pass NX enabling status
Thread-Topic: [PATCH 3/4] x86/boot: Explicitly pass NX enabling status
Thread-Index: AQHafIJhfG/jctluUkek73RTzTJDAbFIYCiA
Date: Mon, 25 Mar 2024 12:04:31 +0000
Message-ID: <dbdf6c3bbaf95cb8ce9531a66a99f8b70b6f67e1.camel@intel.com>
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
	 <20240322175633.1CF5EB0E@davehans-spike.ostc.intel.com>
In-Reply-To: <20240322175633.1CF5EB0E@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: dcb64b5f-7e75-43af-cf75-08dc4cc3bace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XPoY1s2ofutjoWSTszHjA/48Q0X/sNvUsB1i9MVTaiNhv2zmRsnu2FgLWPuNg9QHzvaqbY8IlpGAphL8OZUm+2xsEDC9r2r0IxRYHK6hwFyge4mV1Sne7O9urUb1NgJeufxDHuvBPxI7DgQ1+DlaD9IPJ99wiMqYyLWBx19mE9eeweke4xkq1b2vfJuTCh5/UoguoEjmvtKQOIak6C+HOsxnCbimnzcM80azNpgBNxs6aUDaoz2rmwwjqkLg27gY6YHP9HIIiW4TATvFIYMuEtcGzHjHngCYJDGKuPu934FEyIqjtm5xlgf82FYhrjU/XTDEBB9qIFy5VTo+lvMFABX/HV/TU0L5ZAUu+WHlvXDlCJgmxV5TbUdouNUx4+QT5YKtnbiktwxWV91Z8pGrbo8no4GtmwZl0CI6fOi2h91f9S3RC3iz6PmNMlhHuh8ScCiDqXEYSqW9LW6F+RZeAT9jHw5GBcLXnYElEb5YxdIr+HanBsQPiqfgR+Ohrli53F8YpftsftVPKFvBGRgcc2JwUBOeM8VEugnkos+WmsbrQ2n1xhurfkF7zzZ2k81s/e27ZEU8u4xQCYirREndssx+jN1/GS5cf6i8WPBycqcTUOYmMGCfhilydlCipFgmCHRGiB0QKL3uu4PCnUbaczfa9OVKedbGW6tnNcR3u2+b+2iJZ6E8pztbu7cTyzKsEI7f1HKH0NuNKP1eaBhnPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkd5WFhZSmk4eXJjZTZGT0dqNXlINS9FY2JPZUlEYUhDMDFFMWxpOXh1Ti96?=
 =?utf-8?B?QUl6U1ZRajRCMjdxOGlDOCt3bTR6ZFJ6NUttb3JUckpzWWQ0MTZTWlVnSk0y?=
 =?utf-8?B?RGZ4NDgvUDN3T3FUYlNWSk1oVGFYak9JendCTFVxOEUxZGNpZVprd0o4MGQ5?=
 =?utf-8?B?azlmaXVqT0ZaWGZONTU2SU11bE44MGx5KzkzY0xtUDZVM1hKdUV5bXQ4dks1?=
 =?utf-8?B?czh5RmJ1bjZzY3FWU21kRk1jOXhrTFpiQitWOVFtY0NJK1piNlhrbmYwMjZr?=
 =?utf-8?B?QU44a2psZDZka3NlaHNEWVNGSmFOR3lUQm4wVmk2c0FQRmdtekV2WEtVM3B6?=
 =?utf-8?B?MERYRkRORnVHaFBZU3lrSUltZHJFZnZMSUJQOXIvT3VjckJzNXg5bnhGZGcy?=
 =?utf-8?B?N0ovVmlzT1IwbnQvdFRmUjVaUWhPclVaZW8zNlNrQ3JmYnMrU1RxV2ZPbnBC?=
 =?utf-8?B?QXJpd3hCdlFzWWxpSTlib1BQU0p4Y3pNRFUzNWo1SDdzTW8yVC9ITzRnek4w?=
 =?utf-8?B?cmhtdDJHK3Zic0JWVmpUbkhwZzhmT29CTXBQbC9VRHV5SXRueHFFbFE0RlpQ?=
 =?utf-8?B?Y1gxK1RXenVMejRzRnhmNzB1dlk4L3MwM2ZyZENWeU5wRGYrT0dIeHhVb1BG?=
 =?utf-8?B?aWxkSkxlSDlnTDc3cXArMGhnNUVkbXFTNlB4bHNvV1dzbHJsN1JubytQZFpv?=
 =?utf-8?B?bVVUYUdwcmFTVGx0UUNZT3FEbU41VmIzbkVYN3NiMlRqQnZNTW92WmJ1RVJN?=
 =?utf-8?B?MFRRZ2ZXNDBTNzdqenBpUml3L3VuQnBZZG1UbU9OZ2xxdkdHakk0SCtadDJv?=
 =?utf-8?B?OXBGc2hiaFRKSDUrSlloSVRFTFQ3ZFVRRE1vMWpHV2dLZ2NUdTVCU1N5TFpk?=
 =?utf-8?B?ZXNZVU81dElRTEc1Q2g5blFWaktzS3hhSkc3VFIrQzVPWC9vYy9CQU9ZWWcr?=
 =?utf-8?B?VldFeWpBQnZNelN4WlVnOHJncGlLWHlxb2hOZ1B5d3lXRW5rVWJsQ0ZYNElZ?=
 =?utf-8?B?L1pSUmJpSjhoa25HSlg4bENPMFRrSkJrUTBuK05tRUFNWnFHZzVHQVA4YUZD?=
 =?utf-8?B?U09sVjlrbzU5TVFCMXRmNExUSXljTS9WZUdYSUxYLzBpQU9pLytKZEFxVUJE?=
 =?utf-8?B?enA5dWhRNjJnNkg4MzlmSnU2OXB6dERVME5FcnZCb0ZCeHZoQjN3UnZFaUgx?=
 =?utf-8?B?RGg0SzBwbi8rNkFkM0draWo1eW15YmJ0RzBUTi96NUNFalZrUkhDeGJTd3NG?=
 =?utf-8?B?a2dKQVJmYzJPUEkyKzQyNUVDUkhUSUVRTmp1TGFZYkk2NHJOL0tuNTlydVFH?=
 =?utf-8?B?ZjdGMkkxWjJJa3VhcEYwbEswN2ErMHFQeUJHV3l1UEJ0TVlvOE1HUFBVeGdV?=
 =?utf-8?B?WXV5QWQ3dng2UG16TFVacHM1T3pxWldUSWRCUVQ1aS8xejZDbTZvT1BrTnhi?=
 =?utf-8?B?Z3E2NXNvckdZbzZ2bmNubWpqNW9XTTV0b1JMTEpBaTdzUllyclhhYTIxZi9E?=
 =?utf-8?B?bFlaanc0eEQ0WUU2WnhzTmhENVRrNkRUMEdKRFI3eWRDbTV2K1d1ekhiSm9C?=
 =?utf-8?B?blhhRlhNcGpsQTBUM2REU0lualZJMUlZWmFYeUFFdUxVY0xVRGd5aElFbGFT?=
 =?utf-8?B?eEpFeXN5Rmxua2ZleVlIODdRa2tPL0pJNlNTWWZxVithTEg4QnhoaXlSekQw?=
 =?utf-8?B?UFQrcDhvN2FDR2Q5UUdXZGwvMlFOZzJtR2pYTEpmREVyZHZ3MW5ONFZTSGhi?=
 =?utf-8?B?Q3prOEdSajMvamZiVVY5ODZxWWpUWjBYZGtyQllXQk1kbVJhMmg2OUc3M3Rh?=
 =?utf-8?B?WUZCeWo2WVVoM1IxVEI2UXdSVWpYckNHYmZTUTFpQXFWTFJMK1c2a2J6bGd2?=
 =?utf-8?B?bFZlTjVJMy9oYWwyS3lLNUZ6R2p5dDBzQ2NtL0N2RmJ0NWxiYWVFT1ltUkxt?=
 =?utf-8?B?ZXFpMWFIMXJFTFYzdWdkTjNXOVlSK3FVSmQ2eUhzRlQreEs4TjZNQmV0Y0hJ?=
 =?utf-8?B?Z1U1ZUozd1JqcmUwd3M2dStSWTVpblNoK3kvdTdCT2c0LzFLcE1FeTBuSUVM?=
 =?utf-8?B?S3VQSWJ6Um5xVGJyZ1J1Yjl4QURkaUUydVJ1amlxRGRFT1I2RUVmWFppZ3lQ?=
 =?utf-8?B?QTFVdnBSVk4waldFbHVTaHJ0MFA4VTk1Zk1oZ1RkRjBTaFVkOVZuZFVXRmRK?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CD7E543C7D8A34EB9C68A588E178363@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb64b5f-7e75-43af-cf75-08dc4cc3bace
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:04:31.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WD9aaMd5+7iq5CKJ//WY6Uxtm4lo4/OfxVQ5RjEAKdxwwwY998VKANcLTqMRww4f/r9Gg3R40evU+XtRSlNjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDEwOjU2IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFRo
ZSBrZXJuZWwgc29tZXRpbWVzIG5lZWRzIHRvIG1hc2sgdW5zdXBwb3J0ZWQgYml0cyBvdXQgb2Yg
cGFnZQ0KPiB0YWJsZSBlbnRyaWVzLiAgSXQgZG9lcyB0aGF0IHdpdGggYSBtYXNrOiAnX19zdXBw
b3J0ZWRfcHRlX21hc2snLg0KPiANCj4gVGhhdCBtYXNrIGNhbiBvYnZpb3VzbHkgb25seSBjb250
YWluIHRoZSBOby1lWGVjdXRlIGJpdCAoIF9QQUdFX05YKQ0KDQoJCQkJCQkJICAgXiB1bm5lY2Vz
c2FyeSBzcGFjZQ0KDQo+IG9uIGhhcmR3YXJlIHdoZXJlIE5YIGlzIHN1cHBvcnRlZC4gIHg4Nl9j
b25maWd1cmVfbngoKSBjaGVja3MgdGhlDQo+IGJvb3QgQ1BVJ3MgTlggc3VwcG9ydCBhbmQgYWRq
dXN0cyB0aGUgbWFzayBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gQnV0IGl0IGRvZXNuJ3QgY2hlY2sg
c3VwcG9ydCBkaXJlY3RseS4gIEl0IHVzZXMgdGhlIHZlbmVyYWJsZQ0KPiAnYm9vdF9jcHVfZGF0
YScgd2hpY2ggaXMgYSBzb2Z0d2FyZSBhcHByb3hpbWF0aW9uIG9mIHRoZSBhY3R1YWwgQ1BVDQo+
IHN1cHBvcnQuICBVbmZvcnR1bmF0ZWx5LCBYZW4gd2FudHMgdG8gc2V0IHVwICdfX3N1cHBvcnRl
ZF9wdGVfbWFzaycNCj4gYmVmb3JlICdib290X2NwdV9kYXRhJyBoYXMgYmVlbiBpbml0aWFsaXpl
ZC4gIEl0IGhhY2tzIGFyb3VuZCB0aGlzDQo+IHByb2JsZW0gYnkgcmVwZWF0aW5nIHNvbWUgb2Yg
dGhlICdib290X2NwdV9kYXRhJyBzZXR1cCAqanVzdCogZm9yDQo+IE5YLg0KPiANCj4gSGF2ZSB4
ODZfY29uZmlndXJlX254KCkgc3RvcCBjb25zdWx0aW5nICdib290X2NwdV9kYXRhJyBhbmQgbW92
ZQ0KPiB0aGUgTlggZGV0ZWN0aW9uIHRvIHRoZSBjYWxsZXIuDQo+IA0KPiBObyBmdW5jdGlvbmFs
IGNoYW5nZS4gIFRoYXQgd2lsbCBjb21lIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2
ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEth
aSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==

