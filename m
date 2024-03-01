Return-Path: <linux-kernel+bounces-87941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB386DB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E301F225C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9751C3B;
	Fri,  1 Mar 2024 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft69UiqI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AE42A98;
	Fri,  1 Mar 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709272012; cv=fail; b=TrlVOOBCYhMRsciIqHRLd4UTkw3wuoDcpFADHxYjXrR3bIzRYbkZWSL0wJ7+W4k7hjY8mFxCJVsStGLXSG8wJsMe01+Snsz+Xe3yIIPHLl3jK12Oj79iUaEsUJGDW2qBa00QwIYBwEP6s6z7GqFOc0KXjJ0uICEy5npHfVeH/dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709272012; c=relaxed/simple;
	bh=Z/y8KeVlU1gvOnnRWDDSs4gX81uubn2vdNQ63VODdvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A8L1qrB4KWorpSqRRjJbKgg7POZS4rJg9vvCHuMF5g2OH6HYurCoUAV8CTJ98m2dPidK/m0tWno/NarjZoLhvpxaiUYyToUtSIjSCb6gXE2enXz4Y1b+G1f30pKHtrZFCyfTT/Aa+0x4CKoNndGOXZlDdD1garwUkPUJCp7Nrw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft69UiqI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709272010; x=1740808010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z/y8KeVlU1gvOnnRWDDSs4gX81uubn2vdNQ63VODdvA=;
  b=Ft69UiqIAFMg188uWmisPor8bmV8AIt0ihRQJEnkAMgZn0M1knr6oya3
   oqtaDz8AX8YKSvTH70kWTwvTCWOz3NCiLMBhOIMLQQ/Rn7e7Wo/gGjCA7
   FYXxr5Kd9dF12/UOPpaJapib6cyz2Wk52+yzGWRwoZpqB2UXgsXXAS2am
   y/NonV1d0I3oBwpOFKN+q7PGAgxWOfJIV3cAlr+hY8FTLO8268oJ/SLBm
   O459WpD7i+z7bhZ4RICnPRZY/Qrxs8ckm9WBPjR3LcMI2Vm4vJa+blgsb
   NVK3cqVUCPyi6zGwaqvO+yNgYF4xhHDDlvyISZzBEj9Sa5fzn8i0eW292
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3647363"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3647363"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 21:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="31269027"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 21:46:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 21:46:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 21:46:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 21:46:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 21:46:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETAyToP3oPswV197RJUdCN0McNZ2ifFzN41rhsIhg/tIHKZdK5lIyy1xNcNjUb0rBqCxHCg+jMZPeJ+w/iQwsy+MEgpe1myJbs5mzz3FTvQb/YSWzoJgOQHeQ43DQRu09EwO748CGECFQClBZzWrcoIGc33/T+wmClq59wtbx0Iy32NaJded2jWJ6yzt2YcNp0ynotXURkmncp87bKrnRDYWhkJlWXj/RYk+0yTLr9Bn1vIumrWMpTdkTWSzVX6v0oGE+gVQlpLvfRJPT8sMz4cxpLgVAdbskMYSZp7tRIGodv1fDuVMZZ6Y+guMaXOw3RRnqDot8qqmVJJ89lhHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/y8KeVlU1gvOnnRWDDSs4gX81uubn2vdNQ63VODdvA=;
 b=MOQ5dWSlf2+8E961t4M9zQnx1PuTpLvXGEowykGpyNzJvzS38pLsF03dtsble2xDsLSSWTfGuTOemkbd6Hd73/jZgovVl9jNIkq8AvaBR+BzMKov2+y0C40AIQ/Jhqu04DlVylAeu0sK0ulWnkUZVPfXpMdejggXo7cBnHD3FzmfbqcdOY1P2CThM6Jqq14goCWmOLSBtkX+1DjFDBaP+aj0egcIpLQpHbYnEbhqqK+YIpWBhWjiV2k8YJA0uuT80EKwaZ5zZs5prUbludxo4Qz3ZPF5uA7NQ50VouudK/ZA7oWlDvhPyYtqlS/BIgvz70KRWXeOimqL2zvxYJzCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.14; Fri, 1 Mar
 2024 05:46:45 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 05:46:45 +0000
From: "Liu, Yujie" <yujie.liu@intel.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
CC: lkp <lkp@intel.com>, "masahiroy@kernel.org" <masahiroy@kernel.org>,
	"dalias@libc.org" <dalias@libc.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ysato@users.osdn.me" <ysato@users.osdn.me>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Schier,
 Nicolas" <n.schier@avm.de>
Subject: Re: [PATCH] sh: Fix build with CONFIG_UBSAN=y
Thread-Topic: [PATCH] sh: Fix build with CONFIG_UBSAN=y
Thread-Index: AQHaU9Q46MfoW+5GRUG6LZvxLNyB6LDzwqcAgAAEXgCAAxeWAIAACXIAgA4dkICAAhSZgIAABWUAgALCEwCAGKx1gA==
Date: Fri, 1 Mar 2024 05:46:45 +0000
Message-ID: <e7a80eeafa9b916108ee53f2fe60524554ab0fa6.camel@intel.com>
References: <20240130232717.work.088-kees@kernel.org>
	 <494586ed5a0871cf7cfd005f513577952306a0bc.camel@physik.fu-berlin.de>
	 <fe057f57aba0f8a9040d4700d27f5bd478032925.camel@physik.fu-berlin.de>
	 <202402020228.BBEF7DAC@keescook>
	 <9fda57fc1b1ba6ad9bd6f7df3fb12674d0f4f940.camel@physik.fu-berlin.de>
	 <cd1a36a234c8fc61c5febe646ae0f05ed20ae32a.camel@physik.fu-berlin.de>
	 <202402121025.B0B6E47@keescook>
	 <178e0bebb1a85efebce1f504122ee190c068e0c9.camel@physik.fu-berlin.de>
	 <93572a771cb3a0b36a9213f18dd43c034c84cf6d.camel@physik.fu-berlin.de>
In-Reply-To: <93572a771cb3a0b36a9213f18dd43c034c84cf6d.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: 69997197-c19b-4683-1ca0-08dc39b2fabb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRV19JNrsyL4/wQ1WkC3c9pLWDjHpUzRGulmeXqa7c4EWJ1t71NW7rXWZn3TrXLLAIutUthcL72CpfABkn04YbCfIAwAuqyTNnv+EqqZbSzexhJDjJb3sRIXZRmEqewoNALKOaxF7gS6dNX0ISxPdIIfdxMEUCN8gBheX4NxJOBhyrl3Z5rrcZg16egVVkw8TBv0DiBpOnnKOPgcaHmVBv5sNq2+VS6vhia9I2vKsErkOrxIjTSRGgFVPtI6X95ZRaum/ShFyaibS1Mdpjx/At0VwKF1X+XvTkzxURj4vmIkMbCuVFr8z68VSsZVtUQuzHkkldU/hpPi9MJ68t1b+rxzofzPwS7H9ZRxncdls6qjW139eVukKkR3TkQtSuAiHvxWOPnryj06hG7qHecWdf7RfTPGK5GbYTKzp8o3QLaYatiHou8PCrEaeIjSwWjHsTNLQXOYf9WdEQVWITgvYgr3oX7ydZessrNcCcpNAXcPDxtQBl+MZpZ1Ro5bq9/AASBtvqhCFBxL2SudNYVdSilmkBvBE+seppBj4Nijn9cMuVKNHYjaa7URmSrCTkTiKTWZagAvjYNl1jSNTxMB6Ui0FWFURM8ewErz09AD/xfIXzi2/d+bcjl5u25N9BiK/xSuJzSnHQay/KnWHNOG2DKbzI2K8Au5ZUTM/4/SuW15I67l9cLjXqkTYN3pOM8H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1V0Q05NU25DTGU3M0g1bE54S2NOV0pUcFBNa0h1cUY1cWtqZEc4UTNZQlkx?=
 =?utf-8?B?L2dIWW4zRDhYbWNNd1lROTVLdW1nR2lLMTdoblRmRzgwc0ltTUVOeW51UFdF?=
 =?utf-8?B?SHR4ZmZYNiswMU5kbExJbGFKY0hsNkVRRWkzdXExN1VNK3VpZXVrSHFySkFs?=
 =?utf-8?B?UWdNR0E5SlVuN2YveEVIQmJnb2Q0amRBVlFoT3crYjRicUhxSDdqS0xUSnlr?=
 =?utf-8?B?N1h5MjRpU0JDNks3dkxGOXg5eGp2QkFwQ0J4aFRYd1NnQjRVK0QrZERoTldW?=
 =?utf-8?B?Mld0YVpEaURFUlF1Rm1yTjg2MDJiVlgvSlA1VkZsTkJJR2x4VEhoQmYwY0ZR?=
 =?utf-8?B?Ynl5bkpNVTF0YmRnOForcGZFUHpDZ1FIUWg0aEt6RFhmRURiU0ZEM0o3OEV2?=
 =?utf-8?B?Qy9Wc3RuNVJtNVpmL1FyVU51bEViTFhBZUYxbXhCNTNsN0RHLzZrOG4xRVIw?=
 =?utf-8?B?dEI4SFBXOEdQcGFGV1FsTzRjTm82MjJ2NGhnK3g3M29yYit6VWNCc0lkZEt0?=
 =?utf-8?B?aU1Ha1djTnZnbFNMbXJheHZuUytxdWNOYzZUQkcrNHBpUnJQMWE2NUxhbmFQ?=
 =?utf-8?B?VTh4VEQ2SEdsN3NJeEltekMvdFZqeTh5UWxITnJwelZXMnV4RVd3L1UxTWo2?=
 =?utf-8?B?c2xrMzBDVDlRR2psWS8vNmJFZmQxQVIzVXRRL2xDTU5HU0V5QkFOMmR5b0hJ?=
 =?utf-8?B?UFpFV1c4bENFcmxVOTV0VHVleDdSeUZwU1BMeEw2Wmx0WEJWbS9ucG9jOVV0?=
 =?utf-8?B?NlFmV3c1N1BSOFJ3cWtiNFJWVFdYall6OUU2cjZxWGoxajdRaXRxMFpoYzF6?=
 =?utf-8?B?eUZNNlJEb0hyVGlTcDJDQVFpN0ExZk1rem40M0hyeGFZZ0pQQmZoRVp5Z0gw?=
 =?utf-8?B?UkY3MnNRQ1gyTHczL2VucklveXdJc1RYcjExTXJGMGRkUTdzZ3ZsRWRyZmlo?=
 =?utf-8?B?d3kwZEpHUHdSSlBJRzJ5Szc4L1g1NXlwaW5JTzRRWlN1MTZBbkI1cDJZbWta?=
 =?utf-8?B?cnRBaWpQeUNQOVE5QzUxUmJ3a1Y5bk1sSTZEbWN5ZnZ1Q2lkOVkyMGwvb3px?=
 =?utf-8?B?ZUx0cU8zOGcvZnJKd2RZU0VDV1hBZHVzd3ZxRHphK3FVYnY3SklTYk5XcVll?=
 =?utf-8?B?anRyMHNKdDdnaXVFWW5Ia2wzc0JETCtyZWthUXo2N29hcW5YRkt1SEh2VVo5?=
 =?utf-8?B?VC9ZTTFhTDYxTWY1NUZCeWtmOXBrZE9ybFQyWllJMDhPYSt5MUNWd2lkVUpN?=
 =?utf-8?B?RU9IbnhLR1lzelpkc2MvQzlYdExNckNqM1hlTlJsMytoZ29ma3k5S3ZWTEF5?=
 =?utf-8?B?d3Y0QkpWMGpWTTBvWXl5SUJtVTNkK1lVVVE1WitVak05R1hxTHlEU1JpWFJT?=
 =?utf-8?B?T2VQYmVWU1N0WnMweVBoRjdwcWVvbDFIY2hob0hqRjZDZXhsL2RQMTZKNlVr?=
 =?utf-8?B?OEY5T1ZWNXpkVUJWMHNrbW56Q1hoQnU5RDdlRnRRY1p5UzI3TVZvSkNWU2Z0?=
 =?utf-8?B?N1VHNS9jbTRpY1YrWDU5SUxPWUN3V0xFSVNPbnE3Zlc0Ulc1M2dXY2FvNDZ5?=
 =?utf-8?B?akhwN1o3NGFMWWE5NjdlZjhTa3NzQU5jazl0VytPNWl5UXhBdTdMRks5QXl1?=
 =?utf-8?B?TnVSTDFiRU5iT3JhTWpicVBJNW9Td3hNVzREVFZuSDIwMDE0T2d3emlVYW5l?=
 =?utf-8?B?cnlvVDV0bWxRWjJUUHNmQjNUdkZBY3BGMndxTXMvZTJiZUZUZjk4S0phclds?=
 =?utf-8?B?VkxrMDc5VnRVcHpHTmVvUjUrVG9CUWVEcWU2ckFpV29LZFJuZ0ZsbFJ4dDhi?=
 =?utf-8?B?Q2l5RUZYUVVBK1dZWHJXZ3gwSVFXY1hiSytVQzVvZU4vOU1jUkxvbm1IaVlx?=
 =?utf-8?B?YlVVUWtWMVVwL3JZNDFKdmpSRGI5YzRrZnZtYmlyR01meGN3aU93Zkt4Ykdj?=
 =?utf-8?B?VWgvaXpaSjQrdmNKR1ZRVmhVeWJHMXVZLzI3cnlqLzA2cFlIQUVudHJwVCt1?=
 =?utf-8?B?Z2M0eURMaHpjVnZmL1p3NHloaXlvQ09IWVl6RzRINFRpV2VFYit5SitmY3ZZ?=
 =?utf-8?B?TXhWYkJGTnpiR0dKTVgxY2pzT2FJZU50NmdMVStVRXR3ZkVMZmxGNlEwdVY2?=
 =?utf-8?Q?GCx9rOdkSBXvfYUblZZQyFdtn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1B4F5277F0ED4FA49D9A6755471140@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69997197-c19b-4683-1ca0-08dc39b2fabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 05:46:45.3033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1vgOOLo/Q+9hzD5W02wT7ilOx5NuWfhdZ2/znd242hpzGQQGpLQ6Hvpci4COmjMNl1JRVPeDsZQqqIn8Sb9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
X-OriginatorOrg: intel.com

SGkgQWRyaWFuLA0KDQpPbiBXZWQsIDIwMjQtMDItMTQgYXQgMTM6NTIgKzAxMDAsIEpvaG4gUGF1
bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+IEhpIEtlZXMsDQo+IA0KPiBPbiBNb24sIDIwMjQt
MDItMTIgYXQgMTk6NDUgKzAxMDAsIEpvaG4gUGF1bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+
ID4gT24gTW9uLCAyMDI0LTAyLTEyIGF0IDEwOjI2IC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+
ID4gPiA+IEkganVzdCB3YW50ZWQgdG8gdHJ5IHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBhZ2FpbiB3
aXRoIHRoZSByZXByb2R1Y2VyIGluIFsxXSBhcyB3ZWxsDQo+ID4gPiA+IGFzIHdpdGggZ2NjLTEz
LjIuMCwgYnV0IHlvdXIgYnJhbmNoIGRldmVsL292ZXJmbG93L3Vic2FuLW9ubHkgbm8gbG9uZ2Vy
IGV4aXN0cy4NCj4gPiA+ID4gDQo+ID4gPiA+IENhbiB5b3UgdGVsbCBtZSB3aGVyZSB0byBmaW5k
IHRoZSBwYXRjaGVzIG5vdz8NCj4gPiA+IA0KPiA+ID4gU3VyZSwgdGhleSdyZSBpbiAtbmV4dCwg
YnV0IGZvciBhbiAtcmMyIGJhc2VkIHRyZWUsIHNlZToNCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tlZXMvbGludXguZ2l0L2xvZy8/aD1mb3It
bmV4dC9rc3BwDQo+ID4gDQo+ID4gT0ssIHRoYW5rcy4gSSB3aWxsIGdpdmUgaXQgYSB0cnkgd2l0
aCBnY2MtMTMuDQo+IA0KPiBJJ20gc3RpbGwgdW5hYmxlIHRvIHJlcHJvZHVjZSB0aGUgZXJyb3Ig
dGhhdCB0aGUga2VybmVsIHRlc3Qgcm9ib3QgcmVwb3J0ZWQuDQo+IA0KPiBJJ20gdXNpbmcgZ2Nj
LTEzOg0KPiANCj4gZ2xhdWJpdHpAbm9kZTU0Oi9kYXRhL2hvbWUvZ2xhdWJpdHovbGludXgta2Vl
cz4gc2g0LWxpbnV4LWdjYw0KPiBzaDQtbGludXgtZ2NjOiBmYXRhbCBlcnJvcjogbm8gaW5wdXQg
ZmlsZXMNCj4gY29tcGlsYXRpb24gdGVybWluYXRlZC4NCj4gZ2xhdWJpdHpAbm9kZTU0Oi9kYXRh
L2hvbWUvZ2xhdWJpdHovbGludXgta2Vlcz4gc2g0LWxpbnV4LWdjYyAtLXZlcnNpb24NCj4gc2g0
LWxpbnV4LWdjYyAoR0NDKSAxMy4yLjANCj4gQ29weXJpZ2h0IChDKSAyMDIzIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbiwgSW5jLg0KPiBUaGlzIGlzIGZyZWUgc29mdHdhcmU7IHNlZSB0aGUgc291
cmNlIGZvciBjb3B5aW5nIGNvbmRpdGlvbnMuwqAgVGhlcmUgaXMgTk8NCj4gd2FycmFudHk7IG5v
dCBldmVuIGZvciBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBV
UlBPU0UuDQo+IA0KPiBnbGF1Yml0ekBub2RlNTQ6L2RhdGEvaG9tZS9nbGF1Yml0ei9saW51eC1r
ZWVzPg0KPiANCj4gSSBjaGVja2VkIG91dCB5b3VyIHRyZWUgYW5kIHRoZSBmb3ItbmV4dC9rc3Bw
IGJyYW5jaC4NCj4gDQo+IFRoZW4gZmV0Y2hlZCB0aGUgY29uZmlnIHRoYXQgdHJpZ2dlcmVkIHRo
ZSBidWcgbGlrZSB0aGlzOg0KPiANCj4gJCB3Z2V0IGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBk
YXktY2kvYXJjaGl2ZS8yMDI0MDEzMS8yMDI0MDEzMTA0MTYuczhITGlMbkMtbGtwQGludGVsLmNv
bS9jb25maWfCoC1PIC5jb25maWcNCj4gDQo+IEJ1aWxkaW5nIHRoZSBrZXJuZWwgd2l0aCAibWFr
ZSAtajMyIHVJbWFnZSIgd29ya3MgZmluZS4gTm8gZXJyb3JzIGV4Y2VwdCBmb3INCj4gc29tZSB1
bnJlbGVhdGVkIHdhcm5pbmdzIHRoYXQgc3RpbGwgbmVlZCB0byBiZSBmaXhlZC4NCg0KU29ycnkg
Zm9yIGxhdGUgcmVwbHkuIFNlZW1zIGxpa2UgdGhlIHdhcm5pbmdzIGNhbiBiZSByZXByb2R1Y2Vk
IGJ5DQoibWFrZSB6SW1hZ2UiIHdoaWNoIGlzIHRoZSBkZWZhdWx0IG1ha2UgdGFyZ2V0LCBidXQg
Y2Fubm90IGJlDQpyZXByb2R1Y2VkIGJ5ICJtYWtlIHVJbWFnZSIuDQoNCkhFQUQgaXMgbm93IGF0
IDkxODMyN2U5YjdmZmIgdWJzYW46IFJlbW92ZSBDT05GSUdfVUJTQU5fU0FOSVRJWkVfQUxMDQoN
CiQgd2dldCBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyNDAxMzEv
MjAyNDAxMzEwNDE2LnM4SExpTG5DLWxrcEBpbnRlbC5jb20vY29uZmlnIC1PIC5jb25maWcNCiQg
c2g0LWxpbnV4LWdjYyAtLXZlcnNpb24NCnNoNC1saW51eC1nY2MgKEdDQykgMTMuMi4wDQoNCiQg
bWFrZSAtajcyIENST1NTX0NPTVBJTEU9c2g0LWxpbnV4LSBBUkNIPXNoIG9sZGRlZmNvbmZpZw0K
JCBtYWtlIC1qNzIgQ1JPU1NfQ09NUElMRT1zaDQtbGludXgtIEFSQ0g9c2gNCi4uLg0KICBMRCAg
ICAgIGFyY2gvc2gvYm9vdC9jb21wcmVzc2VkL3ZtbGludXgNCnNoNC1saW51eC1sZDogYXJjaC9z
aC9ib290L2NvbXByZXNzZWQvbWlzYy5vOiBpbiBmdW5jdGlvbiBgemxpYl9pbmZsYXRlX3RhYmxl
JzoNCm1pc2MuYzooLnRleHQrMHg2NzApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX3Vic2Fu
X2hhbmRsZV9zaGlmdF9vdXRfb2ZfYm91bmRzJw0Kc2g0LWxpbnV4LWxkOiBhcmNoL3NoL2Jvb3Qv
Y29tcHJlc3NlZC9taXNjLm86IGluIGZ1bmN0aW9uIGBpbmZsYXRlX2Zhc3QnOg0KbWlzYy5jOigu
dGV4dCsweGM1Yyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fdWJzYW5faGFuZGxlX3NoaWZ0
X291dF9vZl9ib3VuZHMnDQpzaDQtbGludXgtbGQ6IGFyY2gvc2gvYm9vdC9jb21wcmVzc2VkL21p
c2MubzogaW4gZnVuY3Rpb24gYHpsaWJfaW5mbGF0ZVJlc2V0JzoNCm1pc2MuYzooLnRleHQrMHhk
MDApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX3Vic2FuX2hhbmRsZV9zaGlmdF9vdXRfb2Zf
Ym91bmRzJw0Kc2g0LWxpbnV4LWxkOiBhcmNoL3NoL2Jvb3QvY29tcHJlc3NlZC9taXNjLm86IGlu
IGZ1bmN0aW9uIGB6bGliX2luZmxhdGUnOg0KbWlzYy5jOigudGV4dCsweDIzZmMpOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBfX3Vic2FuX2hhbmRsZV9zaGlmdF9vdXRfb2ZfYm91bmRzJw0Kc2g0
LWxpbnV4LWxkOiBhcmNoL3NoL2Jvb3QvY29tcHJlc3NlZC9hc2hsZGkzLm86IGluIGZ1bmN0aW9u
IGBfX2FzaGxkaTMnOg0KYXNobGRpMy5jOigudGV4dCsweGM4KTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgX191YnNhbl9oYW5kbGVfc2hpZnRfb3V0X29mX2JvdW5kcycNCm1ha2VbM106ICoqKiBb
YXJjaC9zaC9ib290L2NvbXByZXNzZWQvTWFrZWZpbGU6Mzg6IGFyY2gvc2gvYm9vdC9jb21wcmVz
c2VkL3ZtbGludXhdIEVycm9yIDENCm1ha2VbMl06ICoqKiBbYXJjaC9zaC9ib290L01ha2VmaWxl
OjQwOiBhcmNoL3NoL2Jvb3QvY29tcHJlc3NlZC92bWxpbnV4XSBFcnJvciAyDQptYWtlWzFdOiAq
KiogW2FyY2gvc2gvTWFrZWZpbGU6MTcwOiB6SW1hZ2VdIEVycm9yIDINCm1ha2U6ICoqKiBbTWFr
ZWZpbGU6MjQwOiBfX3N1Yi1tYWtlXSBFcnJvciAyDQoNCiQgbWFrZSAtajcyIENST1NTX0NPTVBJ
TEU9c2g0LWxpbnV4LSBBUkNIPXNoIHVJbWFnZQ0KLi4uDQogIE9CSkNPUFkgYXJjaC9zaC9ib290
L3ZtbGludXguYmluDQogIEdaSVAgICAgYXJjaC9zaC9ib290L3ZtbGludXguYmluLmd6DQogIFVJ
TUFHRSAgYXJjaC9zaC9ib290L3VJbWFnZS5neg0KSW1hZ2UgTmFtZTogICBMaW51eC02LjguMC1y
YzIrDQpDcmVhdGVkOiAgICAgIEZyaSBNYXIgIDEgMTM6MzE6MzYgMjAyNA0KSW1hZ2UgVHlwZTog
ICBTdXBlckggTGludXggS2VybmVsIEltYWdlIChnemlwIGNvbXByZXNzZWQpDQpEYXRhIFNpemU6
ICAgIDkyOTcxNDEgQnl0ZXMgPSA5MDc5LjI0IEtpQiA9IDguODcgTWlCDQpMb2FkIEFkZHJlc3M6
IDA4MDAxMDAwDQpFbnRyeSBQb2ludDogIDA4MDAyMDAwDQogIEltYWdlIGFyY2gvc2gvYm9vdC91
SW1hZ2UgaXMgcmVhZHkNCg0KLS0NCkJlc3QgUmVnYXJkcywNCll1amllDQoNCg==

