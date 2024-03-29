Return-Path: <linux-kernel+bounces-124426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DF891764
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808311C21A08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E416A026;
	Fri, 29 Mar 2024 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW92jp+F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918F13ACB;
	Fri, 29 Mar 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711710141; cv=fail; b=IOrYcO8VxkoVUl8oePKYJtlM0CWyr1qdZ/MLEeL6fR91i3ZDG2oaLGiqv7lnG6b9wHMz6dvLfmdjTm1UEupUmszfR0FknFU0vrtkcqUkn2ce6wocNwhdT9ci3JCPVzkoeRp8ico6e/yF38/9hUVQB4nFkoX8aIM+cJXR3EuKyF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711710141; c=relaxed/simple;
	bh=m9cRusMFrkXFoagFtzzW7dlWh8PDfAxeExXhafaAD8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nHbc4+AaK8mQ0n4ZWNW/xnSeCnUOBQ2lOJ0ppxbFE68twGuH9eMmTSEus8A5ydgEphGG3D7l/Yktb5VeZNb3ZFzb7YgdWFOcccrD2tAivWOYMDvwwTztJlYYOkYjie/BzuIojBTW+b6ZAnrhjZDKD4HqWBSJIUoZ0CpXKlCXHF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW92jp+F; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711710139; x=1743246139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9cRusMFrkXFoagFtzzW7dlWh8PDfAxeExXhafaAD8I=;
  b=HW92jp+F0u7seoFZdDiBksMqktoeva0e1nVfGkiFoz/aY7jMSV2kfMi0
   Gg/HFVZsTkYmaFQlSXF5U6JYstuO/RE5OJmsgByas75NU8686LjHePC5u
   ppDEquNUc4mVQNgHf96B1KNFm+P71jzHXzPcM3GJcfe3HjrhO1NTjFCQG
   5aCxxrkImrWXRU+h76z1t5yHZkpB6wUzuAY9d4qBjLPg/NcZ2EZIq53ft
   xKIZ5QhpL7j7suqJYTa18caKWH2zu34DkeH1qGtmeu57OR1fUrpSpINBG
   PywGAWN7/pWeVj3Ep/oIX+W23XGLdd9AXbdNtjCNAJ/6rZNYJV9eHZ6/S
   g==;
X-CSE-ConnectionGUID: 0qy4uXVxQJKIb0pq3TkyPA==
X-CSE-MsgGUID: TV7DjNSXRoym51wPX47kdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9853428"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="9853428"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16833475"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 04:02:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 04:02:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 04:02:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 04:02:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 04:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh3Xm41dEXZjpzlP0RUzZjTuBbXQItSeSq8oY+YkhDIq7Ki5p4yGzuk5z+3vqpjRQphlxf8UOFZNdKbK2sBTM5b6172gfH7jTpPWJBezm4AeogB4Tkp84lEER3WKrDQ/9nWJC2OkoQecvBUUt1bcL4g1AwVAfPBuE4782GvYK8MaA8aOJc6Aj6mU786mK5w/O+V2/gHFfIlkTZMVczDToiJ4YtqbkKFI1RCE6tr43v1HnGHdAe1cWfvb9kGscXX97MOwMJzrhVIt3S8IoEf580iwb7nyeEWH3LIOMmd+kdv7nTcIUDzXk2S/IsU5+VVQAU/5yDt1oOEtdVkG/iElzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9cRusMFrkXFoagFtzzW7dlWh8PDfAxeExXhafaAD8I=;
 b=aUfWfqms9rZh2tAo68CJVfjOUEIDDlA6kWrKMPf4A1HFhwEYA8ZUDSW8zY5kaTGQe8gUj12d+hua/5ngnt/WKLYxFeLsHCkImoe/qPBtUtE3NpP5PeuWB5BlBaJegJLmrt7Bi19ob1rWB2ZoP2OdTjSVYHHRc/VUAOE31mRpcdtgBrg1wH0v9itK6MCfA8dKUyhet8iMl0yayhy8Iz0YdrqRb7UDI/yLX51Tlhnx7PrKRAs6HnYug6F8UsjoSo4jZRyXJ/vlS6vOk11RrdxAwGerYC/mnX4orsoUsUNLkAUb41P4DpyFrM65i+UUtqZItayssfuYqHKbLouxMhMSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Fri, 29 Mar
 2024 11:02:04 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7409.028; Fri, 29 Mar 2024
 11:02:04 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, ivecera
	<ivecera@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/7] i40e: Refactor argument
 of i40e_detect_recover_hung()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/7] i40e: Refactor
 argument of i40e_detect_recover_hung()
Thread-Index: AQHagByHDWJ0MnczNU2MYoHcHYjITLFOKC+AgABokNA=
Date: Fri, 29 Mar 2024 11:02:04 +0000
Message-ID: <SJ0PR11MB58663A67F008BF6DFB133751E53A2@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-4-ivecera@redhat.com>
 <CAH-L+nPRUoC-f=k9CUZXjKnAcTV7L4fgkDOnK7dQ9DCeZBMMmA@mail.gmail.com>
In-Reply-To: <CAH-L+nPRUoC-f=k9CUZXjKnAcTV7L4fgkDOnK7dQ9DCeZBMMmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|SJ2PR11MB8568:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9CwMVLP21NO6WkdgkW8Gaqh1rhqBFgtQfPThqHkNpW4NMxxh9NJef2NYoU+wDESxTgftlBLkmqAzw85sBwwC1uDydDLefht3O6At4YtN4xZlGtsZHe4aVxJvEAcowb7E/i+oEPjSbW4PNPgiDgl3UaWBewq9v6bnJBJUnrO7wwqolbHXkICy8Q6hsriZtoPQjNO+BHwc7+CBJcvNfgxuZ2yTQRPafAi4z/DZatBg/C2V1nMm9cVoUp2nia26Om2sJXh4BT+yV4YaY/FHi0/t41Z5Mzh1IHnztyVIynQ5/qOEZzsoDNRx5jku/hTQAvTAlotg9U01XmAwyLfoYfF7xFxq4xQZCji3L8snKuUq/KqKVvY9jb5LEBMw7bx2F4W7N1GJ+uKoZSdk/4djiKtBFl4X7r7EOz81DznIJrMCc+0NsSCpW/rNYYZHJFai+baferGq4pz44L2DBUf4NnyqBQFWyJHRgGvO35CZJOdvEK6kHyqJS94w+UEetkzkxG4+0CgDoeUFmgtWtx6XLvoIbvjtISBpIBCIdLVAdC6XXOwEkOvaGdyyoPdxTRGaPKptirVGVRdpc3I0/tOdJBDRurLSyHIs+0rQ0aZwg3CXdMvorztfBU+c70JuGU98kv5RY2d0z4wOY3/S1l8in2L+yA9PJIfFbWoA8WJYgNCKXYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1d2TndjS0ZpcVg4ckFjR0t4bTVEVE40RzRkckljdHBTOW5YdHUrWWszV1BW?=
 =?utf-8?B?Q1FTdHRuT2VKV3Q5Yk1RU0dLRko5ajVZUHhZcjV4VTZXVU5qZUJNZVE4U1dI?=
 =?utf-8?B?ckNnWGk1YTY5SWh2R3orMkpmS0dBQ2lZN1VaTFRhUTkwaGdPd1EwZ3haWkFz?=
 =?utf-8?B?L3lqamZEWjNqSGhod2xzNmhoWklnQ1QwbzB4VzF2OEl3M2RrT2hacHZMWUVl?=
 =?utf-8?B?WkVwRytsY3RGQ2Y1K0lCUjJmZktJSU1DcnpUSUtpdzFPbEFoa1BldmhXRHdJ?=
 =?utf-8?B?SDc3N0cyMk5yalhteVdlZXMxdGtsbjBUQzJpeGEwZDg5OVdNNGxrSFpsYnZ6?=
 =?utf-8?B?eFh0UXA2a1Z1ZWZkSHgyVE9ob0JuM1N0L3pzRFZoMkdNQlR6akJQRjRBa1R0?=
 =?utf-8?B?YktrNStDQk1ia2JrSGdxdk13WHFNSzlrNW1mQVdJMEp4L0twTmFNSE9JY1Qr?=
 =?utf-8?B?YlZXVEsreUpmdjEyUUFyRStnZXhZTmxnak9HdzNMb3ZMU2JjWS9ZbEwrNUxw?=
 =?utf-8?B?MGw1MmdFTHRlbko2WU11WVM0ZUh0VnFqb0ZkdW5uSkF1NW5xeUhCOER4ZkpT?=
 =?utf-8?B?M01zaFlEQkJQUnRJeGZTcEE3TS9KZEs4Q3h0M2NNcXVzRUJFMWRBQlRteEZa?=
 =?utf-8?B?MVgzYnhnalNKOWhOR2RqM3hvSUlkay80VlI4SEFNTjA4ZUJVYVZEUzIrZ1U5?=
 =?utf-8?B?SzF2RDF6MGg0QlE0QmF0a0poZDhnU0dUSlpNTi9BdGYzaUhpZ1F2TWlJYkwz?=
 =?utf-8?B?UWM0blgwQkJCRTR0L0pWRUxJL0YzT3JvWXNIMHUvdkhMWWtzUldNalJhaHZ2?=
 =?utf-8?B?cGNsVXFWWE5MbEtyR2xNKzJVckFxLzk1UlZGcGFsMmMwN1doVERab0NUWVU4?=
 =?utf-8?B?dU53amNoVldVL0hHVnhMekZ5NHQ1ZktVcGJWRGIzVWZqMTdlMkp4NUdFM21k?=
 =?utf-8?B?SFFEVFB6Z092OHVURmhqV3NTWUhqYm9mMDRiOC9hQVU0TW1KZGdpem5YUEZ1?=
 =?utf-8?B?bW40RC93M1VFV1daRUo4Q2RZTkIyZ3RwQTdtclcyZ1paTjQycUNBbW9NcDVJ?=
 =?utf-8?B?Mkdxb2RrbEMzOTYxOS9hbmlOYzJEWXlSUCs4WjV3akI3M1pyTTE4SHhhRnV3?=
 =?utf-8?B?dFByTlVUTHdiU2NDaDQwS3NNZXp4RmJIWFVjUklWZll6YzBsdnVVRkswaHNo?=
 =?utf-8?B?ZDFFZi9rUllnTEdWVHpraEx3WTJNZHNlcWZ0MTYwRitoSzNUS3MxNXJqbEJ5?=
 =?utf-8?B?VWkxWFp2bkIvajBLM0VXUnQxVkpDRVRna1MxelRpcG1FOStTQlRwNW05VTha?=
 =?utf-8?B?UnI4UGpkOTFZWDF6QnRmNzlXTGZncWhUSjlaOURZTjV3WHVvQmZmd2xtb082?=
 =?utf-8?B?Vk11NFhBbmZVQXc5OHhuVlRrZGQraGRHNkFLMEVSSUtXZm5xaGF4aU1GRXU2?=
 =?utf-8?B?TCttUURrSk5IbVNLL3Y2OVFpZVh2ZHNMVXJkaTY3UGk3bTRndkVqSndqUVdC?=
 =?utf-8?B?dEwyOXY3eFovU3ZYVVpnRmtmZmZ4UThYenBUaTdJTXE5VTBKR2VqYXo5Nmhh?=
 =?utf-8?B?MHBYWExZSy8xZ1NxUDZYNVNsZG42SkJKR1M1NU5hNStQNzZ1ZFVlT2NURDVE?=
 =?utf-8?B?cCtBbXRiWDR3NEZ4ZGVkZk80U25VYkxCYnRLcHNrclJJemNXWTZFUFFzYnNx?=
 =?utf-8?B?cVY3VXhlTStYZ2MzV1p0UEVSbjc3eSt6dEk0cDRwVHBlNWMyL21HTDc4dStV?=
 =?utf-8?B?MEVNNy9mYzVkQ0RkLzdNNnZSSmN1M1A5KzZxL2E3bS84bVlQNHgrR3REdkhD?=
 =?utf-8?B?RnhldU8wT1lQNEMxVkR6dmZvQ0JmNlBUZCt0em45b2NJdnhITk4zOE9YT1FC?=
 =?utf-8?B?b2hJYVpQZjlUM1owWTdIckI1UjhDNkNCTHJtMDF1ZkNuV0ErdXB4Lzh3TzlM?=
 =?utf-8?B?b0JrM0ZQVmVQaW5xbks3Rm8wZXJMMjduZUE1eTNUdFNydGx6NTNhQ2FXS1Ir?=
 =?utf-8?B?M1NYa2hnTVFZYURTK0FKY0s1bmRqUk1NTkt1NFhVc0F2akR6SWZpUXh5dHdN?=
 =?utf-8?B?QzNsZDllU3ZLMU9SVWJYa09ZOWIxRUkzZTFWN21ldkFOSm5CNERtNFVwL0Uv?=
 =?utf-8?B?MlZtdjVUSEhreU5GK2kvMVNKbTN0bzlleVZES3lscFdPSnVRUHRmN2ZpS2Rx?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd035d2c-f3f0-4547-3cca-08dc4fdfab04
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 11:02:04.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjymKQTVHzCztDd4OHiLJ8YgjsSW5f00T8YiNTUNqqUZpYJ/vsKNOdLnEl+r+AYjg/932eIvRE2/MiVjatE1XrkUjyXwgaurin7oPT4BqUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbg0KPiBCZWhhbGYgT2YgS2Fs
ZXNoIEFuYWtrdXIgUHVyYXlpbA0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDI5LCAyMDI0IDU6NDcg
QU0NCj4gVG86IGl2ZWNlcmEgPGl2ZWNlcmFAcmVkaGF0LmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IExva3Rpb25vdiwg
QWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47DQo+IGVkdW1hemV0QGdv
b2dsZS5jb207IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0KPiBrdWJhQGtlcm5l
bC5vcmc7IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47DQo+
IHBhYmVuaUByZWRoYXQuY29tOyBkYXZlbUBkYXZlbWxvZnQubmV0DQo+IFN1YmplY3Q6IFJlOiBb
SW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjIgMy83XSBpNDBlOg0KPiBSZWZhY3Rv
ciBhcmd1bWVudCBvZiBpNDBlX2RldGVjdF9yZWNvdmVyX2h1bmcoKQ0KPiANCj4gT24gV2VkLCBN
YXIgMjcsIDIwMjQgYXQgMToyOOKAr1BNIEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4gQ29tbWl0IDA3ZDQ0MTkwYTM4OSAoImk0MGUvaTQwZXZmOiBE
ZXRlY3QgYW5kIHJlY292ZXIgaHVuZyBxdWV1ZQ0KPiA+IHNjZW5hcmlvIikgY2hhbmdlcyBpNDBl
X2RldGVjdF9yZWNvdmVyX2h1bmcoKSBhcmd1bWVudCB0eXBlIGZyb20NCj4gPiBpNDBlX3BmKiB0
byBpNDBlX3ZzaSogdG8gYmUgc2hhcmVhYmxlIGJ5IGJvdGggaTQwZSBhbmQgaTQwZXZmLg0KPiA+
IEJlY2F1c2UgdGhlIGk0MGV2ZiBkb2VzIG5vdCBleGlzdCBhbnltb3JlIGFuZCB0aGUgZnVuY3Rp
b24gaXMNCj4gPiBleGNsdXNpdmVseSB1c2VkIGJ5IGk0MGUgd2UgY2FuIHJldmVydCB0aGlzIGNo
YW5nZS4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBNaWNoYWwgU2NobWlkdCA8bXNjaG1pZHRAcmVk
aGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQu
Y29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEthbGVzaCBBUCA8a2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20+DQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3Nh
bmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQoNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYyB8ICAyICstDQo+ID4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV90eHJ4LmMgfCAxMCArKysrKystLS0tDQo+ID4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV90eHJ4LmggfCAgMiArLQ0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYw0KPiA+IGluZGV4
IDdmZWQ3ZmI2OWQ0ZS4uMWJhMjg4OTNmNDllIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+ID4gQEAgLTExMjc0LDcgKzExMjc0LDcg
QEAgc3RhdGljIHZvaWQgaTQwZV9zZXJ2aWNlX3Rhc2soc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3
b3JrKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4NCj4gPiAgICAgICAgIGlmICgh
dGVzdF9iaXQoX19JNDBFX1JFQ09WRVJZX01PREUsIHBmLT5zdGF0ZSkpIHsNCj4gPiAtICAgICAg
ICAgICAgICAgaTQwZV9kZXRlY3RfcmVjb3Zlcl9odW5nKHBmLT52c2lbcGYtPmxhbl92c2ldKTsN
Cj4gPiArICAgICAgICAgICAgICAgaTQwZV9kZXRlY3RfcmVjb3Zlcl9odW5nKHBmKTsNCj4gPiAg
ICAgICAgICAgICAgICAgaTQwZV9zeW5jX2ZpbHRlcnNfc3VidGFzayhwZik7DQo+ID4gICAgICAg
ICAgICAgICAgIGk0MGVfcmVzZXRfc3VidGFzayhwZik7DQo+ID4gICAgICAgICAgICAgICAgIGk0
MGVfaGFuZGxlX21kZF9ldmVudChwZik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV90eHJ4LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pNDBlL2k0MGVfdHhyeC5jDQo+ID4gaW5kZXggMWExMmI3MzI4MThlLi5lMzVhMDhkZTE2
YjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBl
X3R4cnguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV90
eHJ4LmMNCj4gPiBAQCAtODYwLDEzICs4NjAsMTUgQEAgdTMyIGk0MGVfZ2V0X3R4X3BlbmRpbmco
c3RydWN0IGk0MGVfcmluZw0KPiAqcmluZywgYm9vbCBpbl9zdykNCj4gPg0KPiA+ICAvKioNCj4g
PiAgICogaTQwZV9kZXRlY3RfcmVjb3Zlcl9odW5nIC0gRnVuY3Rpb24gdG8gZGV0ZWN0IGFuZCBy
ZWNvdmVyDQo+IGh1bmdfcXVldWVzDQo+ID4gLSAqIEB2c2k6ICBwb2ludGVyIHRvIHZzaSBzdHJ1
Y3Qgd2l0aCB0eCBxdWV1ZXMNCj4gPiArICogQHBmOiBwb2ludGVyIHRvIFBGIHN0cnVjdA0KPiA+
ICAgKg0KPiA+IC0gKiBWU0kgaGFzIG5ldGRldiBhbmQgbmV0ZGV2IGhhcyBUWCBxdWV1ZXMuIFRo
aXMgZnVuY3Rpb24gaXMgdG8NCj4gY2hlY2sgZWFjaCBvZg0KPiA+IC0gKiB0aG9zZSBUWCBxdWV1
ZXMgaWYgdGhleSBhcmUgaHVuZywgdHJpZ2dlciByZWNvdmVyeSBieSBpc3N1aW5nDQo+IFNXIGlu
dGVycnVwdC4NCj4gPiArICogTEFOIFZTSSBoYXMgbmV0ZGV2IGFuZCBuZXRkZXYgaGFzIFRYIHF1
ZXVlcy4gVGhpcyBmdW5jdGlvbiBpcw0KPiB0byBjaGVjaw0KPiA+ICsgKiBlYWNoIG9mIHRob3Nl
IFRYIHF1ZXVlcyBpZiB0aGV5IGFyZSBodW5nLCB0cmlnZ2VyIHJlY292ZXJ5IGJ5DQo+IGlzc3Vp
bmcNCj4gPiArICogU1cgaW50ZXJydXB0Lg0KPiA+ICAgKiovDQo+ID4gLXZvaWQgaTQwZV9kZXRl
Y3RfcmVjb3Zlcl9odW5nKHN0cnVjdCBpNDBlX3ZzaSAqdnNpKQ0KPiA+ICt2b2lkIGk0MGVfZGV0
ZWN0X3JlY292ZXJfaHVuZyhzdHJ1Y3QgaTQwZV9wZiAqcGYpDQo+ID4gIHsNCj4gPiArICAgICAg
IHN0cnVjdCBpNDBlX3ZzaSAqdnNpID0gcGYtPnZzaVtwZi0+bGFuX3ZzaV07DQo+ID4gICAgICAg
ICBzdHJ1Y3QgaTQwZV9yaW5nICp0eF9yaW5nID0gTlVMTDsNCj4gPiAgICAgICAgIHN0cnVjdCBu
ZXRfZGV2aWNlICpuZXRkZXY7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgaTsNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3R4cnguaA0KPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV90eHJ4LmgNCj4gPiBpbmRleCAy
Y2RjN2RlNjMwMWMuLjdjMjZjOWEyYmY2NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfdHhyeC5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3R4cnguaA0KPiA+IEBAIC00NzAsNyArNDcwLDcgQEAgdm9p
ZCBpNDBlX2ZyZWVfcnhfcmVzb3VyY2VzKHN0cnVjdCBpNDBlX3JpbmcNCj4gKnJ4X3JpbmcpOw0K
PiA+ICBpbnQgaTQwZV9uYXBpX3BvbGwoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVk
Z2V0KTsNCj4gPiAgdm9pZCBpNDBlX2ZvcmNlX3diKHN0cnVjdCBpNDBlX3ZzaSAqdnNpLCBzdHJ1
Y3QgaTQwZV9xX3ZlY3Rvcg0KPiAqcV92ZWN0b3IpOw0KPiA+ICB1MzIgaTQwZV9nZXRfdHhfcGVu
ZGluZyhzdHJ1Y3QgaTQwZV9yaW5nICpyaW5nLCBib29sIGluX3N3KTsNCj4gPiAtdm9pZCBpNDBl
X2RldGVjdF9yZWNvdmVyX2h1bmcoc3RydWN0IGk0MGVfdnNpICp2c2kpOw0KPiA+ICt2b2lkIGk0
MGVfZGV0ZWN0X3JlY292ZXJfaHVuZyhzdHJ1Y3QgaTQwZV9wZiAqcGYpOw0KPiA+ICBpbnQgX19p
NDBlX21heWJlX3N0b3BfdHgoc3RydWN0IGk0MGVfcmluZyAqdHhfcmluZywgaW50IHNpemUpOw0K
PiA+ICBib29sIF9faTQwZV9jaGtfbGluZWFyaXplKHN0cnVjdCBza19idWZmICpza2IpOw0KPiA+
ICBpbnQgaTQwZV94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgbiwgc3RydWN0
DQo+IHhkcF9mcmFtZSAqKmZyYW1lcywNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo+ID4NCj4g
DQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBLYWxlc2ggQSBQDQo=

