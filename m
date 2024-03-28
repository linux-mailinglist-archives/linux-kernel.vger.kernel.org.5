Return-Path: <linux-kernel+bounces-123333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B18906B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A35028ED9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068851386C7;
	Thu, 28 Mar 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oi9hbCqw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14C139571
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645264; cv=fail; b=P84oSSeRnuQen64OD/gc7wNiPflk1rAQsySWsi2s5TjQjZtg2kqGFn2nv2VWH7/Fkke9tbyk1+SlxPFzD2q9Ny63A1G+AXXsZFqtkmtDCzwFqhHyyqwC4CSY8eQESt/yl6BgvD0hWerXHr2VZLdESOkixOj97rQtIgEfTtY+SvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645264; c=relaxed/simple;
	bh=9T8NTr6I/1x8k97XkDu0NRZ+9NF90oZdG0h5ewcDRck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6Ocw+swc5cVS9/gS99qo4f9jySh2CkfrV6ABVwKwQ6Rsqbtqvv4jX3SW0FDcW9+r/rG4UlZ0X+GyJFmwtcGhv7N2Fk0n26JEkzzUjWtTISAHi3WFeWfUqjnHdCcYlNlOxIef6eTroE0e8bkbHGyYRSXnkOpeZwFk/uWp7jmPRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oi9hbCqw; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711645263; x=1743181263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9T8NTr6I/1x8k97XkDu0NRZ+9NF90oZdG0h5ewcDRck=;
  b=Oi9hbCqw5VH1quYiUE5iQDVBspXqBtpYFuKTGQw0xESqBhTIGPqvEWwW
   nrlnQfbXSQIElsDqJb8bZ5yXDaGJowMGME0QHZ9hOJm7iFdom5mAa4LDE
   1yBtyvhvsd4IvSUWakKDJrzG8JDEeFMk4mPTtf4GOJ0B6thFDLobcifgP
   twGjn/tbwTvymP/3/MShRTxHeWsdLBBBSKKvoYZQEbYwTfdRE+mst48Np
   +t814tYmoUN6g44wjYpv6FdAE8CVKVsO5M403Oly526IYr7KgCw7LVQmn
   oQc75JMjdwr4SxpDvsgCLOPEBIRy0QaFj4+qfqtcK0H5JqmjXg5e7f2Nr
   Q==;
X-CSE-ConnectionGUID: BfeiIkClRoySw/MQn2w1KA==
X-CSE-MsgGUID: 67eaDOViRiKWjKmAmGhc5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="29297564"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="29297564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17102132"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 10:01:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 10:01:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 10:01:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 10:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8ahAZoCLLHUIllWg9STraYHEl/eGfpfZpO26ir60dvSx5d6m75ZoDjQKetijF1xSF+xzwtHyV9afC9wt1lcN6zXziYdR/K01YbKDlQbf37v1faYoAjCRF7HTL77C5CvWba5n0WoKINLTcjsgdcqqzTAVgi5ECwi7NX2w0JUIb2PpxPPsoWvQcdmKgTyR/vsKGbq1neUJHj1SvbptbLrbcFfH2DR9xaxOTyP00OL7Yol38tHWINDLmD1IvHxMUv6MhyUR51kh+Hda5SsdL6cZgANDilXmLe22Eg6SNywVsWnPxWxOy2ajkclMVnrx83fpE6ScV7ay6oVuz1/Z74BJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T8NTr6I/1x8k97XkDu0NRZ+9NF90oZdG0h5ewcDRck=;
 b=hAUaVQyp0xt2yFJ6AzsWa8oVWMf3K5lyig/pBoj2oiHlXoa6/luVRXwhP0NtfXsuswzmuxNQC+DnPPvqdGhv6GQjxb7Hxy7WS3tAJbwcShMTeu2BtfDeFNQQ0CQU6pgG/IkMXWmmlgcKb+MbxT1RIZacwnJKUHn9yE72fJmx/8MXUyEL3IP2lFEWJq65k2+ib8hbp91aXXSl7TOnjxd7lrZ2dWQP2VlSW7GyPnwx4EUEDrs2y3zFkx+Yb0S0qbFXZg/G62EdbJdycbftINxrW8k8LC92aoejwIX4kOGpd85Y85iq+tsBXeCwE4r7lBD8+2An56le4KLfnxfUtHcQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Thu, 28 Mar
 2024 17:00:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 17:00:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsA==
Date: Thu, 28 Mar 2024 17:00:59 +0000
Message-ID: <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
In-Reply-To: <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5270:EE_
x-ms-office365-filtering-correlation-id: 4dd21a96-110d-4235-f3ce-08dc4f48a499
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hB/SChNQgRRSUBmZCEqTB0/XRpFcuBR2hpKeINkzfjJvdbHEmd+CxHTsclLXXJN5MroqS7j0DTa/X9Y1cBAo7sbvv2YOjCkzg9qQynzRxwE2YBSnLBLU2OVGG8PshAOho+qNfEC0y36BPtWyfpUs5qr7HL0vwRWeBDBs9IZaqrTzhCgNCN4nzRJ9hCTx8e64gw02H/uvfLGapIB43aOKVfroTPc38bV4vClBzEU9ZJU7moGmXlGmErWcHkLi4pHgknzFXiVgmFufOJHKuIcIzmVt9MTEL/xWnMMImftc2h48K675MSGiRJRwjn6ZNQIlQysEzIdX/+tjEBHd42NGauZKJQ++VJqPCX4SaNJc+/+oYeCLk88EdaBOt0YLCpNhjd2rNk6L6VvegZ866ZbnfP/dUa9oW/wB/sCX0arGXpG/AnJiP1vFMeLIZAIQHAnS/NzJ+NXt/QEZgAm9NnGbLZbktC8uVxafGAB6HZIBolXg/pHUZaeMVjczYyp7mNeZdUFEFTnwj+J0iai10WI51EFHNw/NtySfuhfCauoXTC5eDVN2SR9PrVLU+lUtTOe88s4LrdDmtPHM/AkfqIhFM1gYwl0ZDHRJcyhyxV235f4NoJcu6N2T1sHmL5iWnBIVQ4HbZSOuE45pi0uMMrUK4Jtcgbs6/VI51idelQA8UKJZ7uc9tuYMaYN/H/5JdU/ylvSYU6mtpDuB6EoijnOuRww5SYQz6XtZRG9ID9CdqvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlNWUFEzZXNpNUJGNFhEQkN5ZjMrU0hIN1I1V045eDdsaWIrQUlsRkgrYitp?=
 =?utf-8?B?a0s0OWhqaFVSQWZhQ3VkTVQwMENYbWVIam8zU000aFdYLzVUd0pYRmtUTGkr?=
 =?utf-8?B?Ylg0S0ZwazdjczRvSTBLc3IwdUtmSW9NMXVpQ0JOd0I1WDE1YlJmcEVIRGFS?=
 =?utf-8?B?RXZldnNTWE5kNm9DaHpFSVduUVpWbWZyRzVWaWxreWtPbkQxUjcwd0xGR3o5?=
 =?utf-8?B?U1E4dWx1ZzJGOHVWTW1TdG1ySmgvUk16VVk3NUJtVERvM1NHRndyQXI1eXJZ?=
 =?utf-8?B?d2NGRkZ5WlNPQ2cySHkrNkRYU1JqK0lKUUlBeUFoVkZYMFNDVWI0QlgwQ1U5?=
 =?utf-8?B?Slg5WlpNdHFCZllGVGhIWUdLZjhsVzVZWXJRRXJPZ0RvQlpXSXdEaWlLZU9C?=
 =?utf-8?B?VEwrc0FPQ2NkRmd2bEg4Z0kyL2ZTL0hWeWRhVjBSU3h3djlNWWxiTFRMZXgy?=
 =?utf-8?B?V0d3cURNaTZTUXIrN3pJVTJ6RTh6eCtyZUk5elRDRSs3RVhrK2ROYXpiY3FZ?=
 =?utf-8?B?d0ZpaEs2RUR5UmxnVFNZSVFzSXJ0Q3lycmc1RTZ6dXQ2NXBYWC9GN25sbHgr?=
 =?utf-8?B?dUF2cktPRzFHL3NHMUFxR0JDdEM2VkplRHFHeS95NSt3UDVOcFV4eTd4M0tY?=
 =?utf-8?B?dHMwRGszY3NpWW11SDRySk1wTm9RL1ZlWExwTnI1WDV4M2lqYXFzZFRJZmNX?=
 =?utf-8?B?cCtKY1I2OUJ4ODRndXJUZVk5ckl4OE0waWNmekFSbG1lUWpHUTFzdFU2TWNw?=
 =?utf-8?B?ajEvUWUxcVZ5OFVPZXZvQ0duNnBDWEkzT3BPQUt6N0VQSVhKamlSRjZWWXk2?=
 =?utf-8?B?RTNvZDR3YmVJTjg2ZXBYeE9qM0tKT2R4REhYQ0ZXK2xmbTRic29sZHdTdWRZ?=
 =?utf-8?B?WGRBMWJhTURVRmMzVDFWN3FuZkdRcUpRN25NYVpuL2NZQXBDN2lNNzJWSWFt?=
 =?utf-8?B?RGtmbHJUOERSY3R5dG1vSG1GeVJKd2g1Y05OYkdFWk9WcGJaeFljMSswaFo1?=
 =?utf-8?B?cjZVeXgveTBadDhzLzdXbDVpVmtLbDFhOXBZNVQ5ZE95eHN3bEhWNjdBSWlZ?=
 =?utf-8?B?WHQrWUJ3T3NydWp2R3hqR09PMVAvL3VsTXMzOVJiZWR5QjZrQXF4ZHpuaVBW?=
 =?utf-8?B?T3VQK2RCejF6TGVUbVY3aGRIbElQcEZEa0VFMGFBdWhIVzIyZGhGTHI4VFlT?=
 =?utf-8?B?M2l5NmFvK2hqNS84MXdyT3pUb2JGMFo3REw0L3FyUHFNWDNzSkREa1dlM2VB?=
 =?utf-8?B?aUhYSmJ6NitNVDJsVWcxaVFZa056TFZPL0lJeHlCYmxkbGdLZzdIMWZ6R3Vz?=
 =?utf-8?B?TDVwR2hKY1lCQUxYS3VPM0JvczVXejlBTk93cXVLOVBEV0txNStxaWZpNVdB?=
 =?utf-8?B?aURmU1BCdStMOEFxQnRMUVZqNFNZTDg2UDFYd1ZWUXV0YlhocktJV0NSSitR?=
 =?utf-8?B?MVE2UHZaaFo4VE1hNG9KTUh4ZGJwNS9YMkIxcXBqa2QxUnNRaFJwZ3huKzFX?=
 =?utf-8?B?eE5IQkVySjJKREhtVitDM0pUSy9Kd2FwSkE0Z3B6a1hFdEg5bGkzd1pwOGUv?=
 =?utf-8?B?cW5WUURMMDNRKzc4Y3NJeTl6dEtZUE5zSDFaVFFKOHltbU5TTjJ2SmtWUVpu?=
 =?utf-8?B?MkhCSk81bTBWT2UvZFphbCtjVlA4T1pmTSttQkJvMXQyTWRvdERhcVpCTXIx?=
 =?utf-8?B?aG5YdmNwYnllUVpuMVhnVnpiVUtSRHRveGVlNHJod0pFeFd0ZElkNE44R2tU?=
 =?utf-8?B?TGRqTnpQejliZitpZDhPc0srRTFzT2ptaUtBaUtyZU9tSWo3WjdyOSttendV?=
 =?utf-8?B?djhXUjExWXJiOHNTTzc3ZThDbXpEQ0t0QmdCbVNFcDc3VXF2YnRRUTRuS1Vs?=
 =?utf-8?B?K25laEUvMFo3a1FORkhsSDYyaStlSGlNYTdsQjhYOGU2Q2RPMWZhZnBTZjhK?=
 =?utf-8?B?NitaU201U2NBMXRxMmtpVlBWRkxOWk5SR25VODNjOXc3VDhqczV4NjREbGZH?=
 =?utf-8?B?eVhZR3pCL3dXVUR0QmVrSDNJZzNpcUhWNnBWTFMwa2ZLTEtWSlRaVkpHa2to?=
 =?utf-8?B?VWkxeFduSS9GdTNhZ1NLZ1Y3TlhRYWh5NXoyZlFlWHJnR090aHlNVDR3YlVp?=
 =?utf-8?Q?fMjPAY3ne+yiwzJzuWS97odMe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd21a96-110d-4235-f3ce-08dc4f48a499
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 17:00:59.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjYt47FfNVmQ5tu5Nuec/E5TVfNTKW8fMwlPjoVasjdyPXrkQWlgc/Z7O05uyk1wPItwRju+v+4tz0DWQhEvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com

PiBMb29raW5nIGF0IHRoaXMgbW9yZSAtIHlvdSBkb24ndCByZWFsbHkgbmVlZCB0aGUgdmVuZG9y
IHRvIGJlIHBhcnQgb2YNCj4gdGhpcyBhcyB0aGUgQ1BVSUQgbGVhZiByYW5nZXMgc2hvdWxkICph
Y3R1YWxseSogYmUgZGlzanVuY3QuIEFjdHVhbGx5Li4uDQoNCkl0J3MgZXNzZW50aWFsbHkgZnJl
ZSB0byBkbyB0aGlzLCBhbmQgaXQgbWFrZXMgdGhlIGNvZGUgbW9yZSByb2J1c3QuIEl0DQpiZWNv
bWVzIGltcG9zc2libGUgdG8gY2hlY2sgbW9kZWwgd2l0aG91dCBhbHNvIGNoZWNraW5nIHZlbmRv
cg0KYW5kIGZhbWlseSBhdCB0aGUgc2FtZSB0aW1lLg0KDQotVG9ueQ0K

