Return-Path: <linux-kernel+bounces-93055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AA872A30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7E01F23091
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338AA12D1FF;
	Tue,  5 Mar 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3kBDrST"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13812D1E0;
	Tue,  5 Mar 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677674; cv=fail; b=HHiROcLD/qEBVTZbKX/PPElqXew+UPU1glv7sfKiykpbOgkfSzgE3HOME4EaztP/7xb5ILnDvsrLRisdJHZajqeslSNmrR/eZxtnQTZDxoyzSYF7jf0CJ0lcepZP6lGP9D+jqbwacEAneVu9E4qtAwALHTQpXZv3b8TNLkUfRjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677674; c=relaxed/simple;
	bh=edcdG2IdXMOjcOKmxiqBrifXKU/gG1zHx+n/wR+ydM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdd41qnQXRmhP9hB/Jm7cuv66VnOm/JXkum6axFxwmFtC/+qUlP55trwCZee709HcwAUTIvEWX+ziSHodbfufSwpu8MMpJtPkyui9RfRpezLLFbzrBdjhmO1K0rUqermDbj2kf5gbjYRONSAwIgiRQczwkyA13TGRb/rDL0Q9H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3kBDrST; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709677671; x=1741213671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=edcdG2IdXMOjcOKmxiqBrifXKU/gG1zHx+n/wR+ydM8=;
  b=b3kBDrSTdhrUyejcGYJFp5Q4xY/dNDg7aIgxNZY0OZh9+VYCV4vEdUGW
   MMT1ES+Zw8ffJclAmkp1EV7U/7DDgPnhAAd1/HFkUkpCESTciJ4//ndQ5
   Wmt4ja1P/PCVJHPdsInLdNgdxnL1Mb47RmcdBl9XoBPz21LinTyRbKB4l
   9BqF8Ap4ZEV2imcYxvJFawu+PEfJMlURrPR3WWgp1zG+gkDrrqS9JfTc+
   9YkIOekBqfJ1VI5FJgBozh3bcJpNnyaNNr8RJK2XsbMVaOPnuvAbT01p4
   vwejgIY/KR6HeWTFS10VM2iGuW6eq0qCQGb2OAJx3Uby0A5cP46CQkemU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15404414"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15404414"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 14:27:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9474767"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 14:27:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 14:27:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 14:27:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 14:27:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkgySpqPJZqNl6W7VIKWEH6oh6OIU02MHIss1P9lB6iEljs8B+k2xO/6osOf7kV8ORaaaT5BX6DKCNLlov85+Vg/bSDOSTk7swcqRlarrWyMHa4VIszPOuADqJTM5ZAGIZLGkzG1uesr8mA8SNr5u8zXKAtxmnm+oCzDZAEmp0+wuIVeGjARXtR/54RBg3ml+v6s3TcDraeoBhI6q62zp/BxEfE/TXtHfYgwieXZDAvKThOyOtVABrOmr3zqblRVx/NGSopZbVod1LFFk2TzoBCmYW8hpebtzbETiGzoigBlTzfkRjoCZPeAJeQOEDcDIQ4dWC+LftaKyRJ593Fa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edcdG2IdXMOjcOKmxiqBrifXKU/gG1zHx+n/wR+ydM8=;
 b=UtyLNBo/QOQlSHan/3JTbjUrswmtW4mLMa6xmFg+fxpkt2SobSGCq7SJVfZtfB13iFpdRRv5aGJ/e82bkv50Sl4/LTgChUoxv9/BF1BVG4Ob285HA+VGtHbNcLQsjzYDGSuqoD4/vchvnWVHKkyZOjNUhNjp7P8q+HCEQ0vZhdR38cimr2VPJy7KgwmgEdPzweWbMvt7myLcrIN14Hi001JsPtlCkNQms00MEdV2QtEjN0793mbENuo+Or9/gRY6gVPpYlbYm1v6LFx1M04Gso4H9Z+/YzpbNPY9mZZh72anr8f2F47RklwTXha42jV+aijgalAp3xvLeoaGzhGyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 22:27:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 22:27:47 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: Cover-cover letter for two resctrl patch sets
Thread-Topic: Cover-cover letter for two resctrl patch sets
Thread-Index: AQHabojCHkcOOZfsEkWvQoNAq+dXBLEptKgAgAAC85A=
Date: Tue, 5 Mar 2024 22:27:47 +0000
Message-ID: <SJ1PR11MB608338D24D58E61B77B423F8FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240228112215.8044-tony.luck@intel.com>
 <b11c545a-7bf4-403e-99cb-38db777fd8ab@intel.com>
 <20240305-uppish-rare-beaver-f652ce@lemur>
In-Reply-To: <20240305-uppish-rare-beaver-f652ce@lemur>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB8266:EE_
x-ms-office365-filtering-correlation-id: 8270d9af-79b9-4d16-f847-08dc3d637c5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvNc17wsbFofzgq6F/k35YzAEz0x0vdkGsuOyyEkVtvQrCd38Q1VcZ08REyl24giJKuq2wls5/ub6hOV9cLzxx3Grm0hQqEK0LgjeM86GzZwPxWVERFn8LEn6tBdRZscgJvhEXTOfY2rqtJsQAILyVlyz2YVCipFu3Lq5L+lhqOSIzXiYxdT1AJILuZrCuslktm2qRctKFrgAVyMSDRKamE6Ht8s3AWXfu83gji+urez5pdnNP+Z7AJDQIgeDYDbf2kYisuVihqZjZx7vFlBvSs3O9WYMHl6WIbojSUwinwFdciZiTmNWtjMAwZEDji1In3K2NZmjd+m+5eeMqWrAOymydCLnYD+NWDCIxo5MzRd8CUB7Wz3q1CRF/yfWAi2z4c8JeBmAWVetGNSZKhecosqYeFd7+8d2vu95TdJSzQmihscvfCUwbgLqrhDthRbL1NOhiRUjGCFKk1If8xoOjqSQFSJHOeJx3Z+vCb5O/UpOpoWq6m63mQYFWEaV01gO2QyRkS3aBqF075k+SUHrUKlLgVixM+4KCi5zzR/ueYOIIuplcSzT+sGewgpH4Ykd9Qpq6keaQuzleBPW8H1H3+CkCgViyQ3j+LbA/fF7kxiiqiaY+DivhLF7chKd/uOCzeV6aK43O2LD52EZxv6h2EAy3R4awFc05VNQaxdSNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVlMdmpzY1JGVDN5MjJOaGkzV1Z5YUxWekJLTTRwK1BET2ZmMmk5TGtKL2Jv?=
 =?utf-8?B?ZTBLbWZhdm1PV2hHQ3NtUnlwYTJDczlGK0NqTXdMVDNrT0d3eEw1ZUF4am1Z?=
 =?utf-8?B?cFFpbG9nV21USHlSbTZsQXRhaHpkM1pxN0lTcGljL1drVTdWekpTUWRSTlVK?=
 =?utf-8?B?U3daNEVYNDltNFhsaGF4QThGNDJ4Ris0Q3Rhdk94dzBzNjd1Y0F2K1ladXlw?=
 =?utf-8?B?R295eG1FMHd0b2JMbC94TUJnNEFmckx6aW5ic0FVaGdIbldiOEl5ZjZnVVNO?=
 =?utf-8?B?dFRTL0h6REVhK2dRdUZHRzlmS2kza0RVampGYWRrSkhjS25xWG1nZ1A2ZnJZ?=
 =?utf-8?B?TnJ2SHJlZ0RqK1BSQUEwSEtuWHBXZWVFVGhGYkJoZmlIQVpzNVhxTk11NGxt?=
 =?utf-8?B?NlFocThlemdrekc0OFVHb3dHWXl3Z2VSZmVPQ3pRVFJ3dzFGTGo3NG51dkQy?=
 =?utf-8?B?bU8yc2lvTE02QXJrUEt6V1BhS1lna3NPQXNLM0JxSUN0UjdlK2lvTGdRZmpa?=
 =?utf-8?B?TkVSTnFiSTAycVcvR3Y4TERxUjlLL1A2NGxFODV6eFZ1amUrM2czNFdsR2sz?=
 =?utf-8?B?MmZJOEwxRUJxMi9HOU9yTUFKc0dhWGgxYUtBd2xGbmtMUWVxV3pBbGpWOHM0?=
 =?utf-8?B?U0p6VzIrT2w5dGQ0UHNJajJ5S2kvZjlPMWtXYTFudE4yQy9kdEJWWW9Ed0hM?=
 =?utf-8?B?cFJSNUVsOXQ1azEvZ25ua1NDemRPbmxHR0hmSGhyQlVBd012cU1uODh6dlN6?=
 =?utf-8?B?OGFGMEtpRWt1YWRLYTFQbGIvc2dCcytBUHRjMG5ZbmpIb2ZwMW4vdDJGR0Rt?=
 =?utf-8?B?aUc3OG9ReGFFYWZqL0NLU2tQaUgvWTNHem9vdVBXbGlmU000cjF3Y1NNWEZB?=
 =?utf-8?B?REYxZW1qQ1VEU3Rmdm5TV2dCNDh3U0pDck9oRXdUcnk4cXV5ZGlOZUw2cldp?=
 =?utf-8?B?NUdyaitTc01uaTBoKzU5UVNuUTZLNGhzNGQvcWtGUjBKMlVUSXBZTmIxZ2VP?=
 =?utf-8?B?Vis2WFRNNHFDVUxkL2FRdlhWelVyaTkxL2pwU1Z4Nk5MTWR6eU1JUUN6OTcx?=
 =?utf-8?B?MlU2Mnp1TmQyekZlZ0RaMGhyTURMeHFBOU9JMEtoemlyaW5SZ0RnTWthSlFy?=
 =?utf-8?B?UGN5TFdEbGpJaEdIb3FRY3hwSklnNmRXcU40c0R6a0VWQXMwMmUzR1IzNUtK?=
 =?utf-8?B?UzJEVkRVb3dmZmtiV3VPK1p5NEt6cmdqbUxQamZDYWJUSnZ1QURnRElJMnQy?=
 =?utf-8?B?c0tLOFVoM1dxWGxGZlI1OTF4MVZCeHRMOTYxKzJxL3E4ZjRoVzBTNnBIS3pu?=
 =?utf-8?B?cGRrM2hPUXJkMnA1NTlvQlVJa2txblQwVisrNE5RSnFMZUd4UVlYdllWdmJW?=
 =?utf-8?B?c3NsL0I5c0UrOHhGOStIZVVNMzUveGJmeHNORUxPUU5kcDBjOVdab2RrSExS?=
 =?utf-8?B?WVpRMHZWZXZqUDA4R3g0cVE2eFBMZjNHM2NKczBqZWo5MzZTcStIZWFWWjdF?=
 =?utf-8?B?VlBaOG1iTXdybllQalpka2ZDSDNRZW5KK3kvclZGdHFDU2o2K1ZleHFFbGdJ?=
 =?utf-8?B?Ui9tcXlLM096cm81c1lJdWxrSjNRRGY1NGwwS1IyZVp2UWRXTkRockJtbWNV?=
 =?utf-8?B?VmJUT1ozNXBtQTNhdTBjMEF6eFhEdklKbmNYT3REcWxKY2NhNU5tQUxyZG9G?=
 =?utf-8?B?azZka05KTlJXSW1kaXUzeGZzYytWcDA4Qjg0bS9uOTVBa3FDSlNyb2IwTmdy?=
 =?utf-8?B?YUFnajRrTFZYcmNqb25jYjcrN0NITUNScFVzaWdkYVVhSG81NUlvSnNEVUJY?=
 =?utf-8?B?UUd2MHpEaVZsTnE4SkhRVFBySWk4UmhYMXhRZ2dRcStETHBFNzdPZDNXVjVD?=
 =?utf-8?B?MUdBKzNkbGszN3RNcEsxbzFGc3BQTkgvWVRJNXJpTVpoUWZDSWZaYmdkWk1K?=
 =?utf-8?B?bDMvdUdnSGtlRGdCc1l6WjA5MU1RbzVSL0dTL0lSM0ZIV2FYM21EcEh0Wms4?=
 =?utf-8?B?bzNBdFBPZHRWTFNEL2hIS3o5UnJyNi91SDZvRzE3cXNzSEM2dU5nOCtPUURU?=
 =?utf-8?B?Z0RwYkM0QjRZVFowVENtVC9OQ1lMRElVYzUva1RLdXJrN2wvUUovQWR4STJW?=
 =?utf-8?Q?30UsvuTS/67PZ6vNxSOJdsP+v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8270d9af-79b9-4d16-f847-08dc3d637c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 22:27:47.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqJ0l0zLL94vH1bU7TKb49UuQrdp2mVxHmRFxkiinqrkDPMy0ScW8U0PCTc8m+7EJIYfV3zxM+UhvCTE1cIkYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-OriginatorOrg: intel.com

Pj4gQ291bGQgeW91IHBsZWFzZSBpbnN0ZWFkIHNlbmQgdGhlIHR3byBzZXJpZXMgc2VwYXJhdGVs
eQ0KPj4gYW5kIG5vdGUgdGhlIGRlcGVuZGVuY3kgaW4gdGhlIGNvdmVyIGxldHRlcj8NCj4NCj4g
RldJVywgd2UncmUgaW5jbHVkaW5nIGFiaWxpdHkgdG8gYXV0by1yZXRyaWV2ZSBhbmQgYXV0by1h
cHBseSBkZXBlbmRlbmNpZXMNCj4gd2l0aCBiNC4gSXQgYWxyZWFkeSB3b3JrcyB3aXRoIHByZXBy
ZXF1aXNpdGUtcGF0Y2gtaWQgdHJhaWxlcnMgKGFzIGRvY3VtZW50ZWQNCj4gYnkgZ2l0LWZvcm1h
dC1wYXRjaCksIGJ1dCB3ZSdsbCBhbHNvIGFkZCBwcmVyZXF1aXNpdGUtY2hhbmdlLWlkIGluIHRo
ZSBuZWFyDQo+IGZ1dHVyZSBhcyB3ZWxsLg0KDQpPdGhlciBpbnRlcmVzdGluZyBpbnRlcmFjdGlv
bnMgd2l0aCBiNCBpbiB0aGVzZSBwYXRjaGVzOg0KDQoxKSBCZWNhdXNlIG9mIHNpZ25pZmljYW50
IHJlYmFzZSBjaGFuZ2VzLCBJIGRyb3BwZWQgYWxsIHRoZSBSZXZpZXdlZC9UZXN0ZWQgdGFncw0K
ZnJvbSB2MTUuIEJ1dCBiNCBzZWVtcyB0byBoYXZlIG5vdGljZWQgdGhhdCBwYXJ0IDUvOCB3YXNu
J3QgY2hhbmdlZCBhdCBhbGwgc2luY2UNCnYxNCwgYW5kIHBpY2tlZCB1cCBzb21lIChidXQgbm90
IGFsbCkgb2YgdGhlIHRhZ3MgZm9yIHRoYXQgcGF0Y2g6DQoNCiAg4pyTIFtQQVRDSCB2MTUgNS84
XSB4ODYvcmVzY3RybDogQWRkIG5vZGUtc2NvcGUgdG8gdGhlIG9wdGlvbnMgZm9yIGZlYXR1cmUg
c2NvcGUNCiAgICArIFJldmlld2VkLWJ5OiBQZXRlciBOZXdtYW4gPHBldGVybmV3bWFuQGdvb2ds
ZS5jb20+ICjinJcgREtJTS9nb29nbGUuY29tKQ0KICAgICsgUmV2aWV3ZWQtYnk6IFJlaW5ldHRl
IENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbT4gKOKckyBES0lNL2ludGVsLmNvbSkN
CiAgICArIFJldmlld2VkLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+ICjinJMg
REtJTS9hbWQuY29tKQ0KDQoyKSBNeSBjb3Zlci1jb3ZlciBsZXR0ZXIgY3JlYXRlZCBzb21lIGxp
bmthZ2UgYmV0d2VlbiB0aGUgdHdvIHBhdGNoIHNlcmllcy4NClRyeWluZyB0byByZXRyaWV2ZSB0
aGUgMi1wYXJ0IHY0IHNlcmllcyB3aXRoICJnaXQgYW0iIHdvdWxkIHBpY2sgdXAgdGhlIDgtcGFy
dA0KdjE1LiBVc2luZyBhbiBleHBsaWNpdCAiLXY0IiBkb2VzIHdvcmsgdG8gcGljayB1cCBqdXN0
IHRoZSAyLXBhcnQgcGF0Y2guDQogICQgYjQgYW0gLXY0IDIwMjQwMjI4MTEyOTUyLjgwOTAtdG9u
eS5sdWNrQGludGVsLmNvbQ0KDQozKSBUaGF0IGI0IGFtIHBpY2tzIHVwIFJlaW5ldHRlJ3MgImlm
IHlvdSBtYWtlIHRoZXNlIGNoYW5nZXMiIFJldmlld2VkIGJ5IGZyb206DQogIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8xMjc2NjI2MS0yNmIyLTRhYTQtYTczNS1jMjM4MGM0OTYzZmRAaW50
ZWwuY29tLw0KW3Rob3VnaCBJIGNhbiBzZWUgd2h5IGl0IGRpZCBhbmQgcmVhbGl6ZSB0aGF0IHdl
J2xsIG5lZWQgImI0R1BUIiB0byBwYXJzZQ0Kc3Vycm91bmRpbmcgdGV4dCB0byBmaWd1cmUgb3V0
IHRoYXQgaXQgc2hvdWxkIHNraXAgdGhhdF0uDQoNClNob3VsZCBmb2xrcyB0aGF0IG9mZmVyIGEg
Y29uZGl0aW9uYWwgdGFnIG1hcmsgdGhhdCBpbiB0aGUgdGV4dCBzb21ld2hlcmUgdG8NCmxldCBi
NCBrbm93IG5vdCB0byBhdXRvLXBpY2s/DQoNCi1Ub255DQo=

