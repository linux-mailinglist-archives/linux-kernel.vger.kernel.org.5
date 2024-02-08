Return-Path: <linux-kernel+bounces-58153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C284E1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B01F241E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77A76408;
	Thu,  8 Feb 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSEOjQmu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9355763F4;
	Thu,  8 Feb 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398780; cv=fail; b=L6AbK5BxI+yvWxTi623ZP6s4pzP96y4lJG2VUZaRn5Np6P8l10qIWziz4piX10S+RrpXnLpZ83bZOjq2yYeBhokUIJJHrcntvtgnpRWqoy3KVFKg6Cm82UpXVMUV7NMaR5OPSQj4189hRY1bggYPaVWcJXSjTdKLLNqP3NEQYxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398780; c=relaxed/simple;
	bh=irGGSi+nKH23aJWSQS+wxqPIU9YjQjMhhXSL8XGbZEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAYkk/X+ZRi5WB/t5siLqnEhmK3P0YXRCGMTKNv/yWx2RQrZVxMgrXjQ4qbME5QBlRvBF1lWMOvMgJPz/H+PIjfj3laJE0MbAEzfW7pJ8BwZsHB+o9y68nDWEPY5eT+TYdbERqJEWaYh5z/hBeYJazdKlJue5PasdZSX8Fc/lGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSEOjQmu; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707398779; x=1738934779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=irGGSi+nKH23aJWSQS+wxqPIU9YjQjMhhXSL8XGbZEs=;
  b=hSEOjQmuT/upQbzd2m9UpL5PjaA98trXNWm0FYSPFEfOznfeDog6JQYf
   +SAIgebkaEbp1va/QejYvIoCqj/yea/RulpwsDlrBoaYnrRR2aJSUESY4
   pad97UHaqtCoPuBOMCPrNHK62XnkZSmaATpD/sMos7xxswRiPQfpg9bW5
   SX5ROqZkAj8THZBoehuos/27ZFxxQmrFJvl0vpxoZaNg7d9rlF723seQ2
   MAW/QTzpeAUJ1nEBmVWauJxquA3uxFoTuc+zrAu19JkReiE9//lQ6SD3W
   jsV5v8xJqhkkptwd/eVA4kJHsrAB/YZ7kIVj4W3GRnVEffzU6z3GDq8kr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11949281"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="11949281"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="24897605"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 05:26:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 05:26:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 05:26:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 05:26:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 05:26:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8CnMWDZ2/xhvH9dcMkJZzm0cOu/iBnz4uEmdzVcMr3uqZvDwgi1/m9D4eoZfj/faIUQWGQlfVyio3Z17z3cZx6VabW7wzI8scYNStHQZ+i8JzR/owyn3qDm6foPuNn9mLESzpgIY9dAHTzTK+bySxNbh+PDRn0fnPpZ430zhldJM/x95sit8nrdj8+RuXGIQ/c0VRC78Yl9IT7HmAnlp7LZx1QsyW2IikWsbcKz3vQDLZZatPhTUbhn7gZuQQck9Mphh8tWtq6UIqcqPZjMPdudH5otHIBr4e4M+ELGTuOZwm2IXsETAUVCqfa46dbiDIROqAv7lAwVvioNIWfflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irGGSi+nKH23aJWSQS+wxqPIU9YjQjMhhXSL8XGbZEs=;
 b=LOzsoFID+UdHb1SHG4t8AIeE1557vYYaKVOfE5M0CDRoSBvvUfq9uCA8HIR6Egxe/jhXHSAoVL62iE4Z8HHL/sXskH64AhrOrl88YYmlo4nm6aGePfOtanMYDS8ujTT7AIPJ9v2wXUbJlAFcNY4RxHV29XG2CaJTxHO6+d8wnrnEMT/utdwIyUlGIUObPjFZhnKE4HQTxdMW8N5+xVV24J8SGngLZWV1n9V59L3+teGhAuVSznkFb7DzL4J34Rwfjmk8HkXf6lQWsO0NGIMxMUmLkYx+RH/0XEMfPAfjykqCGYs3N5VGpa0GTsyR6qoReXaNZKL/Q0H3grQc7ipXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 13:26:15 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 13:26:15 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux PM <linux-pm@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Daniel Lezcano" <daniel.lezcano@linaro.org>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>
Subject: RE: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
Thread-Topic: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
Thread-Index: AQHaWfmscI0ONMIKDk+7Rq00PN9JerD/9/c5gAA2V4CAAEI1oA==
Date: Thu, 8 Feb 2024 13:26:15 +0000
Message-ID: <MW5PR11MB58101FBF45EFEC362A8A1E18A3442@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <1892445.tdWV9SEqCh@kreacher> <875xyzh4ah.fsf@kernel.org>
 <9e740b50d7798b5d01c0a3c9e328ccf90978d30c.camel@sipsolutions.net>
In-Reply-To: <9e740b50d7798b5d01c0a3c9e328ccf90978d30c.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SJ2PR11MB8371:EE_
x-ms-office365-filtering-correlation-id: afac3ce8-6c87-40e5-0f2e-08dc28a9867d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTmW8ZF1qgsGc31SHOt91z2B8dRhckUpiLMjUuTGpLnzrnhNhbbz4isaWFeckMx2riJonK1SCjSNFKTnANPVcfTyAxmqNtDUMdHShLqYFHv7kgWYyVPhf7QXsCUytHC+e9/qCAqaBkQyOaB5qLAWHqVamArhtO7Yg+EmgGKF3Y2tNsOPkSsWH5kER4mQuZAyRruRsh9KXgCMOS5VtDozCJwYwk4v9/t5woeBbullmT7D2QGBWBwwkrUbBEVIoDIaqfgGbHvUMOt+exwgz8SFBELhnMQy3F3AXe0kiHKTZs5m4RDQd2NPD6AdwWVGwwGxMYBJ3HncyBs+c+UJsuedVZsnInMS3V6LArwXOjkhXtMnfPKa+KPsK0WqnkgKk8UqUwElXnjszoBWI7BA2WknTB4ziagM+JfYOTHjZK2l8qaHtVmXXaln6iwgyc6VX8PGUcoWbCaG7CArSfqmbeDahssmdvW6kUJrxohpkrQ3i22g0LXK6jnxRZckj1KRcdqNfVsV+q4NHTfrj8tgZuUfJTQEUifu3w4gq+KE4pyEKt+692Qz5nBkIT85PApby4ebAx9k0dnKkmu4VVpblyG7/ghYl7z1amhL25cbKvzStvUFMabHNN77QQ3U0WRe6jR0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(122000001)(55016003)(38100700002)(82960400001)(66476007)(64756008)(66946007)(41300700001)(86362001)(38070700009)(26005)(110136005)(316002)(66556008)(66446008)(76116006)(54906003)(71200400001)(478600001)(4326008)(52536014)(4744005)(8936002)(8676002)(33656002)(7696005)(6506007)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzJmTUMvcXVkdXVuY1E2Ym9wb0ZJcWt4NVZyNVArdXcxYW9sSVpVNlhtVTI0?=
 =?utf-8?B?eDgwNDZOMnRZY0tpTnEySTRPRFh1RTI1M2VXSDJQOVJlREZqU3UxcUszY2NW?=
 =?utf-8?B?WVh6dTFBTUJFT2Q4cGFjeWlRUlRtaHVtdkQ5ZlAxL1NRMzhBOERmS09BeGhz?=
 =?utf-8?B?TEdBaEIvM1dSb3FaMSt2eEZqak9meWVycjE5WWlNeTk0U3VCQXQ3bUpzdkox?=
 =?utf-8?B?REFncmVqWG5Pelg0VWE2Q1AxcE5mZUFJYXlReTBRN2FmZWFmQVVUb1NjZGRh?=
 =?utf-8?B?RTlZSWdFbjRyZ3lzVDRYRllaOEs1Y2VVM0w5M2RDYUpVcDdZSlhIRHNHTEF5?=
 =?utf-8?B?a2M2YlVMdDk1dEJDZWdjbmx2VE5LOUhRTTRrTjlnSnptbnc5bEhBYkVRRjVT?=
 =?utf-8?B?Wk9MWmFCa3hKMmppS3FlVUIvbWJoSEFESGdlelVkUXc0OEFMYURFc0dmUGtj?=
 =?utf-8?B?SzlSbW1OL1VEUXZOMUl4T29uR1ZoejFsR1AyY2JYUnhwOHlPTzlUa0ltY0c3?=
 =?utf-8?B?WmhXYlZ2NnlTOUJDdHU3TmpZSDdoVGxHcVQ5dzQ5QUJKd3Ftd3kwSGJ4bnRX?=
 =?utf-8?B?cW03RWw0UXlGMzNiajZmNStuM1R3YkowQWhxYlphbUkyWWlMZXJqTGdmSnZR?=
 =?utf-8?B?VVZiK25XQTA4R3VBWVZzNGJLMUMzRXppNTBTaUtmb0pNd1VnWTRpbGF4L2ZE?=
 =?utf-8?B?MGZiaGR0Mmp2SzVnbHVjSzdMT0labzVzemJwVSt1MVcxbjkxcFpNZkNaTkx3?=
 =?utf-8?B?bVp4M25jVnRWaTFzcHd6UVE4SFl0TTF5N0UzNXJFN215UkkxaEpRcGNtVjkx?=
 =?utf-8?B?TlAyUERNSWhTRkJKWUhEYy9LZVBSeVo2R0RvOGxGQ0xOMWJhV2QyS0U5aFVt?=
 =?utf-8?B?SGdRMmgzamtlWGxRR1JmNUlrajl1b3N4RVk3VHVubUlXaXk4SExDWFgxejMw?=
 =?utf-8?B?b3lDNkpjQkNXbTlCYXd2THJ5Z2RhdkdaSHN2RHl4T0pjL2FXeFZseVA4MTFR?=
 =?utf-8?B?WkV5Z1lsa3UxUElSekVvZ0tKMU96U0JHOE4yTC9LamNGSk8zUUt5VmdLZ1pP?=
 =?utf-8?B?RWdtTnlSNm1MT0xZK2luK0ZVWTkwckZIaE9aM1FRRE5Sbks0NW1mMnM4RDIx?=
 =?utf-8?B?dDN5WFN2TithVjlOemRUK01uMWtHWkg5NU4vUkx3RnVCdCsrOU9ab1M3VVAx?=
 =?utf-8?B?SlRhZmRzUVRiUVF4NzlydXM1TTMrRDBlR3g5aG9zQjFxMHNVMlMvaG42NSsx?=
 =?utf-8?B?TVFzR1IzM0Q5eTFHSTVIejk4cTdDTXAvdmV5OXZERlNjZlIzVzlYeGlaZlpn?=
 =?utf-8?B?d2hJQ3JCR2l1V0RZYVk2bmZhRFhHNm5ibWZjTDBLcjdyd2JBbmhDUVpPYUMr?=
 =?utf-8?B?a0ZONTZ1dG5SVUNFNEVtSkFJR016RzdkUitlWFcweW0vdXpRaVVpWjBsNWNx?=
 =?utf-8?B?bjB6Q2luMFYvN3RkMk9SWFBDZzJGQVlZdVVRY2l2V0xFODNlQ2l2NWg4TWJy?=
 =?utf-8?B?QXJuSmVSNE9WckNhbVBtMjU4b04zQUZZMFltWENSVmJ5OU5qbitoczREYmk1?=
 =?utf-8?B?RXlNWUYvU1dzc3ErNjJDRjBHbVd6U2lxSW1EbE1EcWhMRWlJVjFHTERzT3Vm?=
 =?utf-8?B?alJXbW1SUkVEOGZDRkQ1eXhDY1lSajBPeXNyd1V6UVNEV3JkU3Q2WjRKSlMx?=
 =?utf-8?B?VXpxZEhSNE1iTkdid1BRWHJDV3A0dWtOb21IVE1vWFJlSTVuZjVBWERvSHF5?=
 =?utf-8?B?ZzhKcnJWa0oybU9JYi9MWll6alJDbzJlcjNucWVhT0E5TVZMaW1waWhEZmIv?=
 =?utf-8?B?M1RHR3dDS2pxd1dwbWM3d0lWNHEyNmY3M2ZYMzgzRllZbkU4KzVmanBHL2NJ?=
 =?utf-8?B?QXJiOWdWSE5YNHFxSFQ5QWhPSGMxejhxM3ZkSkcralpVTjlJckNuNVI5Qmd0?=
 =?utf-8?B?elZzUVFQMldGWTcySlJuWjk4Rm9kNVdHU0NJRVo0VnpYUTNoQ2ltRWxsU2cx?=
 =?utf-8?B?b1EwdEcxNmxJYWV4dXdMY2xxU2dSTHdyVDR5ZlFJWS93dVVubTRBRzZNUTR1?=
 =?utf-8?B?UGQyVkRLU25zZWRWQzlMSXhVTmxTTHBDS21qWnV6OUJtUEhvcmJvRUpRL3NL?=
 =?utf-8?B?cXBOM21xOTN0TmowenAyM1V3cmpOWWRrTzJoYkJXUFZuWjNheXVGeENXVVQw?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afac3ce8-6c87-40e5-0f2e-08dc28a9867d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 13:26:15.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1vlfNBiPELLLFQfyAuwNJPKPr/dGRoDDs2TZq0z8GTVZa3hvnlVF2beBNDe9qjxvELJmyG36Xg094iRO5zO4/CK8dKsaxV5zyaIOoT0tccTy+Xf1jq+4fQVaHxf8q64
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com

DQoNCj4gT24gVGh1LCAyMDI0LTAyLTA4IGF0IDA4OjEzICswMjAwLCBLYWxsZSBWYWxvIHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IElmIHBvc3NpYmxlLCBJJ2QgbGlrZSB0byByb3V0ZSB0aGUgJHN1Ympl
Y3Qgc2VyaWVzIHRocm91Z2ggdGhlDQo+ID4gPiB0aGVybWFsIHRyZWUsIGl0IGlzIHJlcXVpc2l0
ZSBmb3IgdGhlIGFib3ZlIG9uZS4NCj4gPg0KPiA+IGl3bHdpZmkgaXMgZ2V0dGluZyBhIGxvdCBv
ZiBwYXRjaGVzIGxhdGVseSwgdGhvdWdoIEkgZG9uJ3Qga25vdyBpZiBhbnkNCj4gPiBvZiB0aGVt
IHRvdWNoIHRoZSB0aGVybWFsIHN0dWZmLiBCdXQgaWYgdGhpcyBwYXRjaHNldCBnb2VzIHRvIHRo
ZQ0KPiA+IHRoZXJtYWwgSSBhbSBhIGJpdCB3b3JyaWVkIGFib3V0IGNvbmZsaWN0cy4NCj4gDQo+
IFNob3VsZCBiZSBPSywgSSBjaGVja2VkIG5vdyBhbmQgYXBhcnQgZnJvbSB0aGUgdHJpdmlhbCBj
aGFuZ2UgaW4gbXZtLmggdGhpcyBpcw0KPiBjb250YWluZWQgaW4gdHQuYywgd2hpY2ggaXNuJ3Qg
dG91Y2hlZCAoZXZlbiBpbiBvdXIgaW50ZXJuYWwgZmVlZGVyIHRyZWUpIGFmdGVyDQo+IGNvbW1p
dCAwMTA2Y2NlNWFkMGMgKCJ3aWZpOiBpd2x3aWZpOiBtdm06IGRyb3AgTlVMTCBwb2ludGVyIGNo
ZWNrIGluDQo+IGl3bF9tdm1fdHpvbmVfc2V0X3RyaXBfdGVtcCgpIikuDQo+IA0KPiBCdXQgSSds
bCBsZXQgTWlyaSBzZW5kIGFuIEFja2VkLWJ5IHRvIGdvIHRocm91Z2ggeW91ciB0cmVlLCBzaW5j
ZSBzaGUncyB0aGUNCj4gbWFpbnRhaW5lciA6LSkNCj4gDQo+IEpvaGFubmVzDQoNCkhpLA0KIA0K
VGhpcyBzZWVtcyBmaW5lIHRvIGdvIHRocm91Z2ggeW91ciB0cmVlLCBhcyBKb2hhbm5lcyBzYWlk
LCB3ZSBkb24ndCBleHBlY3QgYW55IGNvbmZsaWN0cy4NCg0KVGhhbmtzLA0KTWlyaQ0K

