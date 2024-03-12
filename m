Return-Path: <linux-kernel+bounces-100754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8B879CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D02819B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68814290D;
	Tue, 12 Mar 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmjW5Eat"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02203142658;
	Tue, 12 Mar 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274825; cv=fail; b=Sz9QDLquLpa6pHBB2h7DrvEpS6pz49qhbhdoCbpinSOOmhg3C07qOARwQiZxc0uLLpFz4bf9NtlX4Q2pD/QJST/+PNlYWON30RwG6A6LjIMnuVKy4TmjHkuyPFqoEvvDYl1LjAMhmLtXBLDSuJhWdfsKgKGAmj8TLQ/NduJPSnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274825; c=relaxed/simple;
	bh=ok/TLjhdk6hLa1d1R81im8IPs7ltW25D00NDyQsczH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMM/jZsIriZgzueqIzy5x74ZC00zDlMyRH4MIquGh0+6FUYTXA0twD39PAuyY/3QDOceZ5UTq2SryfoU8vhIpviGTwF9HCIGr23OjIrl9jxNb92DI/WuyqpKzSPTONsBWB5eRVMxXg+9jAjHIMB7OhF5dqrieWE6lST8FJIuLp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmjW5Eat; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710274823; x=1741810823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ok/TLjhdk6hLa1d1R81im8IPs7ltW25D00NDyQsczH8=;
  b=cmjW5Eat+tb76bLNpR1qzEmhy6DIAa7g/4hgmwTa+KqCcZuxvZOsRL/m
   oAVfLWDkuWoEJ0+89pBxCftQoGVtde8+99zWvkOeZr53olAPXH96s3R1o
   JBhBDWp1HhL53x4kk9EsyPthKzEoq2aze9SedQHthIdINCthlMedMfkhC
   fksW6y8etHK5fQwZTFl8jV+1Nj8zpJYlfXVtf8m/hj55R6l3yiCGmyaKp
   ifF9kUsgxx+sHDtFD5BgQiejP78m918qglUkYOhjTYDfw1mWFG2FDS/JQ
   /BW3/1JvstmXzAZCUEnQoyLYoQwXhOcO2t0NlDMOSE9ycK1aF93AweLqQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5196277"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5196277"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12264151"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 13:20:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 13:20:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 13:20:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 13:20:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj76tElM88YyosAJrcdgJuk57XzOc4lc2v64mcaS4CJr60IESKrQtSRrBMXy/ezSewtC6nNgeMMVlIAy+GzrtiB58S+HXKIMyjdPWsx/DMcWcQKV98ZNNdMqBmvpA2yZaWeCMaESYK1WGItlFctdeF5CeVnPIltTxmn0TXF3ENdI3phF1hR3Cp+APNigH/eVL/Shjns856CalPQQyE7E/rsyplEdmhNisRVAzTMVSBJN6VTrrYjTBCDs0B3mU5HyfsqaZPXoOjuvR8cRUkHVl9lnUxWHM+lK9+R6jDTwFavlUVx1d+w5fQVz8C8wH8NzC9qLirwIBTQQ46wEsSjs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok/TLjhdk6hLa1d1R81im8IPs7ltW25D00NDyQsczH8=;
 b=NYoxgwXx3tMMFiWZX0ih4s+X0bkDYY03yuAKLhdBG7aI5ULo5cGKj/X2RXu/gF0AyuBXRThaSpPmjyMNRAw7VLvzFIJilTGOfdz/aeSN/+NjDpIWP1p5o3J0DB4hRg5XcER5BFWnV9fcCt4pM4rN+0m+P9+ODVD5I07Dkrmd4jBJSO5kajLrZjPJ/i6Qkoqn0uPlb8QDn28sHsJaztW/63nk+8hztJA8+xa12zbh2HmQbbxPMjUuGxXICP8dlc0o4ub3crM7E0rC8j54veZ0gDdXzuy1gzSoaOaAi4zQ89juDGUEOWZSBiXuCyda1dfWw1IKdsWba5U0t/fb4MX6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 20:20:18 +0000
Received: from SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::f35e:21dd:97a2:2bf8]) by SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::f35e:21dd:97a2:2bf8%5]) with mapi id 15.20.7386.016; Tue, 12 Mar 2024
 20:20:18 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "osalvador@suse.de" <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "david@redhat.com" <david@redhat.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Huang, Ying" <ying.huang@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "willy@infradead.org"
	<willy@infradead.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7 1/5] dax/bus.c: replace driver-core lock usage by a
 local rwsem
Thread-Topic: [PATCH v7 1/5] dax/bus.c: replace driver-core lock usage by a
 local rwsem
Thread-Index: AQHaTwCNXZpT35WtB0GDpuTqa8NBabE007uAgAADpwA=
Date: Tue, 12 Mar 2024 20:20:17 +0000
Message-ID: <ebc79448a1fdb47ff16144c12cd5d8dfc733dee8.camel@intel.com>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
	 <20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com>
	 <65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7109:EE_|SJ2PR11MB8469:EE_
x-ms-office365-filtering-correlation-id: 34d97d5b-5be1-481b-eea9-08dc42d1d5c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJRfvRzjEDRB4lR0sab/9OKYg2TkD9xqB0BumTcv+AeAhUYEBd8uDZvlfnWLj4rQ9zmSmBCo8W3A/gtV2NDklbvolpIVz6Lb0k+ZoQdQpqUAH9M7+hl9a/TYmRimpGrOKC3eSbKgeBY/fXTz7hFKE2XeNqxj+ybpuhuiNnSPzFcGYN/tCbIs8y5XIiC5zl3Er6V+hVFUc0DBDz6371zzGeBUTxmMihrKUwJo7lZtk7mxwrygLEOgzMY1DGebNJlZMty8MVJXoGptISCZbOjRe+4Q8fKFoY2gg63r97DnaCBypg385E92sd6AWQvfJ+xHWRuo8xFs8LNrkuHuCcCs2d5lMSpJiSLBlkoIh7LdAO0Pct12uobMuMwxJvPedOp5qPv/pjDikmIthtZY2aIfgMUiIqXm/NScuOJO1eUunwk4y9aLjNL6iuXAez32HDa4O7qTXEYIy8+36oUU6S+wvCYeqb3P/cq95GCKMxXugDb1YpUpc1oSYldBCJUg7wd/kk0ivwmnvv/ZEcnS7yMYXdqk/Whs/a2llTwLGcfjutRgbSO3l3TchSKs+w9zPYylsqH3SmpTLwXikUZldrYXQ3NCeAdVNl/tSE9sWLUDLeJsx4dzUwRgjji2X9QDGnWjnsVGZd3CLQgyHF1dyYiZ0gmFrODcYxjl/wZ4TGVbDC6l37jiP1rgKGufyvZpIBVhYy26L+lifoJSU92JdZIYVe2MOKX/V12QwxveUDaPhqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEZmMURuaGJzT3RrTGFlU3ZCd1ZtL3NUODlOODRuRlByazEzbkVWdXdtZXZ4?=
 =?utf-8?B?a3JUNng5NmNuTDdmMlBua1NsSmdLSjdodVluc0FDNHhZazY1VkRqWUpPMmJV?=
 =?utf-8?B?d2FxRFlmUDRtUEJNRDNEZk4yWEptVXR4eVNGOUpsbGJ6WmZMalZoSUxXeVM3?=
 =?utf-8?B?dlZiMXptL3pkZU44ZlJsQmh2dmxoWlR3bWFJYXpreWdEdlEwc01qYVc2eUNp?=
 =?utf-8?B?Umh5eUUrOWp6VDZqK2NLZFhsNVdmK3h2bWlGbDRBQ25PQ1JMK3pQWG92Tlp6?=
 =?utf-8?B?ZkFtMnpIRGY4N2Q2VzdyMEZPendlaFJHT2xUTFVrWDYyK2Z3MEVzMnJSam1a?=
 =?utf-8?B?VERoVjZoVTA4TythREN2TDdKeEJJcVdYTzFKbk82R3p0YlNmZ0ZnNHhZcnZ1?=
 =?utf-8?B?OUoxUDZKakF1eUl5NE0vUUNCZVdkb3VMN2wzT2RobDBEbnZySHhuekVFOWlU?=
 =?utf-8?B?OVBDWEdkNHZXdWQ1S1NIOFNsM1N4UnMxMHJVcTBrNzIxV0FNcm1kUjNPSmMr?=
 =?utf-8?B?QzJ0MHdmcG94S0xzbHBDSHA3U21XUE9YQWVpTXh1ZHUzeU5DV055eGlMbWFl?=
 =?utf-8?B?ck1SL0RjZ1c5Ry9Gam1TUlVQRytJb0hObjlnSllySDhvWUdQSUl0elpMekRx?=
 =?utf-8?B?TzBUOEY0eUpPMTJUazAzN1pvUlViVFZXZXhpNG5HcW4zQllsWElyZE9HTUQw?=
 =?utf-8?B?QjJWTlNOMkwvaHY0L091MHlMNkdhd1ltZ0hEU1IrVWdITVNPVWVkQ1QzUkpI?=
 =?utf-8?B?OVFZc0pKQTRUY0NDM3cxb0JPZGk3VldhL1lEUFBLN0ZUWTdZY3hyeUFhdUxy?=
 =?utf-8?B?Q2hTRkV3eW5Xd1lWbGZqVDd5Rzhxbm00bWJBQVAzVGRQYlpHNXk1Njg4TC9B?=
 =?utf-8?B?TG9YRnpWZUpNZ2R4NXQ1WTZZRVZHa0dUQ0ZjeGJKVjdsdjFqQ2FXMTlFdjJI?=
 =?utf-8?B?VXo1N2ltUU9SUFUwNjVYcVVSYTNBenUwVmlpMEtaeDBla0tBdVkxRmtWUDJJ?=
 =?utf-8?B?aENTb21DcmNENmpSZnExbjdwZmh5Y21ZMk83bTBDQXl2b3RJdXovL0ZUS1Bn?=
 =?utf-8?B?MEE0eDRmblhHYllsRHcweXRsTTFGa0Z3cmc5YnVLTnNHQkNVWElvL2NDZXB3?=
 =?utf-8?B?MG0veGhvWEFBNSt6U09RQzBoN0M2cXVoNzNXRW1Fb1NmcW1qODFmZmlSVXlQ?=
 =?utf-8?B?WEoxbzdITDlxRHNYT1pWei9xNzJ5WFpVTldmVG9TdTg4RjVQNGtMMEtIWnV6?=
 =?utf-8?B?bzVtZ2RUSXFCNVRBSUdiVzByRmJhSVoxa1VzSkJubDRpNXR0Nlg1T2Y1QWhz?=
 =?utf-8?B?NURwOUJpL1o3am9oV3lGaEpzT3VvVHN6ZUc3eVdqYktvWDEvRlcrcDJLdFZt?=
 =?utf-8?B?WDR6Z2xoQk1UM0dRUGFMOU93cGZpZytmZWJkUGpBamY5dkRlZUpSVko2RnZz?=
 =?utf-8?B?MkxQQVRlN21RbzZwMHJyV2k4QmtkNStMeWhBOXZMUjRyS2FOaityeTZYSHF2?=
 =?utf-8?B?K0U4VDg3Ry9oV0N4SThYZnRsWEFEU3ZFOTh1S3dhVG1MWW9NOFNOeEZKTWtS?=
 =?utf-8?B?QmlCcCt0VTNRS2Qwa0V1NDdNeGZib1Z2SVQvSFF2YVZjcVhUb3FIWlhtc2NI?=
 =?utf-8?B?bk85OWljUGtFUDFpQnRIVkd3RFJrWnBnWUlDZ0x3bTFKdUdZU2gzVlc1Q0dS?=
 =?utf-8?B?RDNiNjhrR2hYVlp2Z2dBL012RUxIQmlHaWRQRXJ5OFlOZm1na2Zmc2RWcDZH?=
 =?utf-8?B?ckFUZlcwUEwybnBJSEZmRlROWkVrMUxBRWVOQVVHc2pBeW93dEJpdXBYOXR3?=
 =?utf-8?B?THpHaVpaS1pvajVkQUxaUkNEdDc1Zk5mbEpGMlBvUDdSY0w4MlZnR05WTlN3?=
 =?utf-8?B?OVJ1R0pVcHd1OGxGKzhWbWJBTkFnZFZ1OUpmaW44VHRwVGtodEFoc1U2S3Nq?=
 =?utf-8?B?U2FnZ2pPM2FnL05Yd085TDcrWFpZYS9PVFRNNkRwQjQ5UWx6Mmx4VmhsdGNP?=
 =?utf-8?B?Tkx5N0s4YWJyZXpjckVCZWthQnBNYkZ4Y0Z2ZkswQUxNMVl6SzZvOXo2aUkv?=
 =?utf-8?B?V05HQTA2Y1pkVFZxZVJZMHRhOVFVN21YSGdQRWdpTXVHb1ZVc3dMNHNKRGJo?=
 =?utf-8?B?d3B0dG1TMmNmUlZDb1cyQlBaNDUwLytTKzhkSTY1blJsVmpLSDlLT1NtR2gr?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62DDFA721A4F3D43B81711AE99137EC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d97d5b-5be1-481b-eea9-08dc42d1d5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 20:20:18.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOOPSAF0m2QhvFlpf7ZEX98rvk79RSNmsTCHPRDUxWfTrbBkOvvRyUwMphbFOAFvrYqoXxHsU9qTK1EntZSFjfYV2iIfa0hw4KFnGyOUH5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8469
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAzLTEyIGF0IDEzOjA3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiBUaGUgZGF4IGRyaXZlciBpbmNvcnJlY3RseSB1c2Vk
IGRyaXZlci1jb3JlIGRldmljZSBsb2NrcyB0byBwcm90ZWN0DQo+ID4gaW50ZXJuYWwgZGF4IHJl
Z2lvbiBhbmQgZGF4IGRldmljZSBjb25maWd1cmF0aW9uIHN0cnVjdHVyZXMuIFJlcGxhY2UgdGhl
DQo+ID4gZGV2aWNlIGxvY2sgdXNhZ2Ugd2l0aCBhIGxvY2FsIHJ3c2VtLCBvbmUgZWFjaCBmb3Ig
ZGF4IHJlZ2lvbg0KPiA+IGNvbmZpZ3VyYXRpb24gYW5kIGRheCBkZXZpY2UgY29uZmlndXJhdGlv
bi4gQXMgYSByZXN1bHQgb2YgdGhpcw0KPiA+IGNvbnZlcnNpb24sIG5vIGRldmljZV9sb2NrKCkg
dXNhZ2UgcmVtYWlucyBpbiBkYXgvYnVzLmMuDQo+ID4gDQo+ID4gQ2M6IERhbiBXaWxsaWFtcyA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJp
dmVycy9kYXgvYnVzLmMgfCAyMjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTU3IGluc2VydGlvbnMo
KyksIDYzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9i
dXMuYyBiL2RyaXZlcnMvZGF4L2J1cy5jDQo+ID4gaW5kZXggMWZmMWFiNWZhMTA1Li5jYjE0OGY3
NGNlZGEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kYXgvYnVzLmMNCj4gPiArKysgYi9kcml2
ZXJzL2RheC9idXMuYw0KPiA+IEBAIC0xMiw2ICsxMiwxOCBAQA0KPiA+IMKgDQo+ID4gwqBzdGF0
aWMgREVGSU5FX01VVEVYKGRheF9idXNfbG9jayk7DQo+ID4gwqANCj4gPiArLyoNCj4gPiArICog
QWxsIGNoYW5nZXMgdG8gdGhlIGRheCByZWdpb24gY29uZmlndXJhdGlvbiBvY2N1ciB3aXRoIHRo
aXMgbG9jayBoZWxkDQo+ID4gKyAqIGZvciB3cml0ZS4NCj4gPiArICovDQo+ID4gK0RFQ0xBUkVf
UldTRU0oZGF4X3JlZ2lvbl9yd3NlbSk7DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBBbGwgY2hh
bmdlcyB0byB0aGUgZGF4IGRldmljZSBjb25maWd1cmF0aW9uIG9jY3VyIHdpdGggdGhpcyBsb2Nr
IGhlbGQNCj4gPiArICogZm9yIHdyaXRlLg0KPiA+ICsgKi8NCj4gPiArREVDTEFSRV9SV1NFTShk
YXhfZGV2X3J3c2VtKTsNCj4gPiArDQo+ID4gwqAjZGVmaW5lIERBWF9OQU1FX0xFTiAzMA0KPiA+
IMKgc3RydWN0IGRheF9pZCB7DQo+ID4gwqAJc3RydWN0IGxpc3RfaGVhZCBsaXN0Ow0KPiA+IEBA
IC0xODAsNyArMTkyLDcgQEAgc3RhdGljIHU2NCBkZXZfZGF4X3NpemUoc3RydWN0IGRldl9kYXgg
KmRldl9kYXgpDQo+ID4gwqAJdTY0IHNpemUgPSAwOw0KPiA+IMKgCWludCBpOw0KPiA+IMKgDQo+
ID4gLQlkZXZpY2VfbG9ja19hc3NlcnQoJmRldl9kYXgtPmRldik7DQo+ID4gKwlXQVJOX09OX09O
Q0UoIXJ3c2VtX2lzX2xvY2tlZCgmZGF4X2Rldl9yd3NlbSkpOw0KPiANCj4gQXBvbG9naWVzIGZv
ciB0aGUgbGF0ZSByZXZpZXcsIGJ1dC4uLg0KPiANCj4gQWxsIG9mIHRoZXNlIFdBUk5fT05fT05D
RSgpIHVzYWdlcyBzaG91bGQgYmUgcmVwbGFjZWQgd2l0aA0KPiBsb2NrZGVwX2Fzc2VydF9oZWxk
KCkgYW5kIGxvY2tkZXBfYXNzZXJ0X2hlbGRfd3JpdGUoKSB3aGVyZSBhcHByb3ByaWF0ZS4NCg0K
TWFrZXMgc2Vuc2UgLSBJIGNhbiBzZW5kIGEgcGF0Y2ggcG9zdCAtcmMxIHRvIGNoYW5nZSB0aGVz
ZSBpZiB0aGF0J3Mgb2theSBBbmRyZXc/DQo=

