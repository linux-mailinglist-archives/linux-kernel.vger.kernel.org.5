Return-Path: <linux-kernel+bounces-108107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D088060F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183B0B21E95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C53BBC3;
	Tue, 19 Mar 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2ZhO1QF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DE38F99;
	Tue, 19 Mar 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880309; cv=fail; b=oqCDfj7vtSfYCC4mGTfx1yj+JMnvanP+qoEAqR8YZmjI2L8p774XBKnw9zqUJBiR2VSXdt9a7T5eBLuPOLpE7GkuskZfaq136h+qwLo+hsTEVWZ4/6j3Y3aVuFAhWEr2HXOap5ZqCEuC2RvnhjI0MqFC60O4cBECbjaW4P4d+k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880309; c=relaxed/simple;
	bh=qYUTBloi/79hiG1d8yv00AF/DtLR7whF04Lw/bhlLV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ndq8I/mpmTlLJN/G1v/I7P3pbzYzaOIJrylrMcUl7kIOCUhrvjqrcKtFW1zqFJvwRDFmFpUW1fzN62NzVubs1s1m6ADt72Vq420RE96LK0VEmsxwDgcL7TRrHGvkNnB1AoFd2CEpUICOArn0sweVqvIAh7bme+IX8u3FO7yS5hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2ZhO1QF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710880307; x=1742416307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qYUTBloi/79hiG1d8yv00AF/DtLR7whF04Lw/bhlLV4=;
  b=R2ZhO1QFXc98E2erHAC+ORQosim6HUu55M8p93ZJSNLrQTDZ0DwNyVm+
   ly9U6xYQDNinElZUk1KPhr2feNNsQuKai/W5AvNrJluDGOyoe5Bp45/ud
   oS9ZsMq/87CcbLz7BWsyvxGaPvRZHdvpInwfmZ3tdaTQPULB+R0WSBMFi
   tUWzTp1mxPIm+Y+EEJDIbZlD6QBN3CGfHySGVLFfcUwgXdnRz13+alvXf
   lTCb8iAu7DTXzJu9IZVTwIOzN1GLeHKE8lbj18S2NTIHPNZr7pAvsrHJQ
   WM63zyJODD6ZTzXHtLgRzCRcwNPSdQPgPstERsuPGN4CkqKR5YuKYCl7+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16326365"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="16326365"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 13:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14362418"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 13:31:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:31:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:31:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 13:31:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 13:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U89YgtplPs5iHadfp1ky1Z8lRk/2hNAHh1zLhcJLaB39aSgbAqg6LbSoa1pDpR7ayfCVkvYrZ+6Hae2uTvgnn7aee50TjbEJNEw8dZTj9D8m5YziHOFol2una/1/vTBWFb44dc2b01iL3sFWkf5xS+xpmVMEKtCQh50hedBY0MT1ANzENbPWE2upoXx0UwgUu1hgu/Z8/Y+O2uItPPD/DGhH0x0USbMIfi5b7tZKP/GKhyL/ynaePHUDdQQazF5xRAxfDD59e2mmLEVGW+jQq3TB34hlmMqg0jNtd0zqrriDlBEUBvkMqlne3iy8tyml0GwCvd6jigXWvStZXwOOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYUTBloi/79hiG1d8yv00AF/DtLR7whF04Lw/bhlLV4=;
 b=hRiOmASeQkHKvz4F+0D9QuzojV/3AsrLVHMI6BzI5xOnsSGDcXcK0qZHpyXsHXp8EOLk9lNKcFtWmvnoRZmFzHuR674zlQC6l/E1I0YSU/8OVlypud2sgT9NxFK9wogcwgNATKXsvinTMylVOzjq4fl9OnmRIiZBpVniOLsTDrV57+7K8DfbMbYVczs9CRJ1lo2Jzvlq2oWZuURUdV/xIj+/H+bZqYNnfjNFBM3WLfAVlrshMHzeBHmy4WzQfCUjV/Yy7J5vm/PK8+Vy9gbgz4ho/2EANcN04eifM3PbmSHDLGqjbGe5hx42KAmU0QFR/JKMEsiTMboo2jCUA7HkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 20:31:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 20:31:42 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
Subject: RE: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHadMZAfvOnE4EV7EqwgV4w9PIDb7E/YoUAgAAqeQA=
Date: Tue, 19 Mar 2024 20:31:42 +0000
Message-ID: <SJ1PR11MB6083B59F32F33C0FFBFCA1BCFC2C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
In-Reply-To: <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7858:EE_
x-ms-office365-filtering-correlation-id: 0afbc7c9-af4d-409b-393c-08dc485396ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHfABLwXaj8jK1KYgprHG55IxrYL1A2YykkoN5HbqcIWYZS06BNEqCzdCNZIRwXnYU79D7f9jJpbnUJFCiNgvDAghmYRX9QhpMqt8J/FxkppgTahD4KvAGFTEYNXigcdF0ZAjtq3ERP06eKHYWbbI2qzwKkmuxGxQ5FumJwxpTkhD3oSaXe45YhuMoPguMwiP+JVfg43FtKKOcI71rCRR1vaWpT5x9kT46vSg/rOdRbTt28P2U331berAGCRKmdNpLSjTAc+sqUNvTZB6Rp6QDqcOFmxNBiy9J84tLIhcLdJOO37z6IBsZWiKfOaWgw5VIKelNQmp0Fh68+7P/v/DZqGCyJMn2TYaFAf1bPuV4EI9DjS4xqi1+OB7nhT65T+7HzjXI17oyzhKI6kssuaG6LLlyLypb/piKLjPkAXemRbX5d0bb7YnNuZ+jCiZAycpaArBnyvVUnf9yPbSSPMoRiChS5ouCYfyW3UugIoqou5IenDNy/BC25E40Q0dewEaQVAOSRxkJDnnZTmQW980HhNzZ8DkXVElAbWxsIUXEayWzZ7j3bsO8sqLJY3wxggT9hjnPPsNGrrRQmxgTW5pBTdF9MHhedJ+lpbe5AoQsjWRB/06brQSntS6wRuUw4PAPZ//511TtuZeG8O+y4pxbNaqY6B73DwkyIz42tZ4vTl3pSAiprVN55z4hx40RUJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlZyQlpvUXBMUEVqbHljMkRxNGtKNTVpZEtFRGhwcmNsanZwbjcxQzlMRjRO?=
 =?utf-8?B?Tm5UN1dwblhPUXFGRHdmNXlLeTI3eUVTUnE1ZDFMRGVnbE5yaUFLTFhVY1FC?=
 =?utf-8?B?c1Rka3lzcjlzazE2QUNBdkowYzdQRlgvK2hqT0d5eDdQT1hrc0NUVEU1d3gw?=
 =?utf-8?B?U0gzZG4xRzdkTTVqYlA2TzVKM3lOS3BqdmJKaG1NYmVCUjRFKzk2Q1daOXdJ?=
 =?utf-8?B?QUxwYlVpdU9EQjgrK2tBQVNlalRrMDhZVlVwclJZT0tWdWZmbzNaemhBVlR3?=
 =?utf-8?B?dCtod0FMcnJJWGlTMHdGOW5HU0twWU5hSkxqVzRUQmFxTThTK0V2R3BqcFhw?=
 =?utf-8?B?NjR2R2g0RnpnRVBFRHpOck12c2tob25IMHNROXNYanV1elVNa2Y2NGZHS2hZ?=
 =?utf-8?B?OVgxdXgzdzZrQnk4LzkzN1JqRlJvKzh3NVZnenFLWGtTdWlGL0dWb1ZEOFAv?=
 =?utf-8?B?bWRpR2wxOGtHNnB0eXBxUndnVHQ2d2d2ZTFvQWNNVldFUHZtKzVEYVcxZzl0?=
 =?utf-8?B?WUdrUWl4UjIxd3JpZDIxR1dKTCttb0tzZTJiY1YwZUQ4M09yQ0N0RkZhRlhX?=
 =?utf-8?B?Ym83Q2hiSXd5SHFGVzV3K0c2ZkhjU3pXT2NwSzRvbWdOSjA5cmxraFZseUht?=
 =?utf-8?B?bGpySk1nbUs1T25QUi85RzNxbldBbTNDck5raCtmRURHaGFLbVg4S3RBb0J0?=
 =?utf-8?B?bnBLY2xTalF4RHJicGN6STlvTzg0eDY1UXlBKzV2RTFzQ0E1M2s1dTZsT1NN?=
 =?utf-8?B?ZHBXQzhyUzNmbWU3aHRDUFN5S1VrU3NFK1NFVTc3anNyckVWK0RRWWdMeFl2?=
 =?utf-8?B?SHFac1Yvek5ZTWFGS3lGZ2dpTnRvWU5jTE1GSDkwTEthbzMrRThIaGpmeUtz?=
 =?utf-8?B?bmdNdHpBdldMcDZiMWVacE1hdkxRWWM3MGNHNy9TYm1wZ2F2anRmazdzempL?=
 =?utf-8?B?bWRpT1lFM0lRcUtaVUhtRzAwM1dEU0x5RU5XTTZpRmJIbXFXMlhEOWVSZFFM?=
 =?utf-8?B?YUpPVXZteWs2Z0ZuaW5aZ0wvZXhXVmtuWjhldnUxMnU2V2VTeEpqd1ZpeXZX?=
 =?utf-8?B?bEgvTmFSU2F5czlhY0F0eDI1S3VyUW13TXBGR1drSzRXVE5YenV4aitlMS9N?=
 =?utf-8?B?T05ZSzVnMU9UWVM4MzE3VUNGaDdJZHFDbnJWZnhWSHJNQ0ZxY2NYcGl4U2hW?=
 =?utf-8?B?SzlaNVBxMDJtcWdCSVlNbUdaMkw0aFczZXRuNGdJVjdnNWdnNDZ1aU9KY1Vq?=
 =?utf-8?B?eXAyYVlyZ3JEOGxVZ01sSjRmdThoalpFaFJ1RVcyV29EekZBMEcrYnlFZ2Z2?=
 =?utf-8?B?UXFBKzlBbTA0ekh1ZVhPL0xkMmpBTzZva3BXeHo3a1pVNTBDZVMvU0VFWWxC?=
 =?utf-8?B?ZEFibmp6WC91dVcvd3hxdG10MDRuSkVsdVkyUjhMU0tlMnpSS0J1eHYremtz?=
 =?utf-8?B?Yi9zVjZzS1daMVpWUndTVDF2NDRPL1JpQzdBM3BJU2xpeGtERU1xMUJTSGZF?=
 =?utf-8?B?eXFGcWZrMld4OGJlOVNKTEN1UERBRDFSNFRxUGFZdUZWTXdHeXlDaUlTWlQ0?=
 =?utf-8?B?a1hIbDF3bi8yTTV1OG1rK1A0N1NtWGtEOTdhYW5wS2hmYSt2Y2U3N1FDKzQ1?=
 =?utf-8?B?cHM0elkyMXd6V1p2NTZRSlpEdmU0UVIvYmNOeGlwRkxnejhXbWEyd2c0SjZo?=
 =?utf-8?B?ZmtkcUFaQ3VGY2ZOdWhlZnVtR2FreW1RK1h3QUttVGd2OTBQRjE4amtUeTUy?=
 =?utf-8?B?d29FRTJ2OVJwb2k1OHAyVEhONVhRbU1FVTVaTERZZjZHa2RWYzlKYlpTeUVQ?=
 =?utf-8?B?R2VjNFZnSU9WeU4rQlZ4WHMyRGdROFZFMzFCbW9Wc2Q5eUcxb2Y0SkFQYnJW?=
 =?utf-8?B?ZW1UZkxBMVppTVRqdlJsY1hqbklWY0FOWXRHRFB2aXM0a3ZPaDdSUkdQSjRO?=
 =?utf-8?B?c1RrSFhmVHZIQ3h0VnkxODFaV3NFVUNYWGNiTFRhaDFheWhaSE9ueWZUTDAz?=
 =?utf-8?B?RVNFeTBCbHQ3bzViV3JycDR5Um0wdjBtUTE5U0I0SCs3a0phZjdtd3lDVW9X?=
 =?utf-8?B?b2hLMWhBa1hNUjgxMGNwNlVnYWhybGMxVlZUaTh0Q01qUFd6cHhpWFJaMTFy?=
 =?utf-8?Q?muIbgVWqfE4kiVqeyDMjNqLHZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afbc7c9-af4d-409b-393c-08dc485396ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 20:31:42.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GKkOosnrZXAeNeEjgSvSJAhslVcCVhPnnTKGS9HHvNy6lik2csIgdOAx6o+F+qb878VFNVJf0KT5cOHrzjUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858
X-OriginatorOrg: intel.com

PiBJIGFncmVlIHRvIGRyb3AgcGF0Y2ggIzkuDQo+DQo+IFRoZSBjb3JlIHN1cHBvcnQgZm9yIFNO
QyBjb250aW51ZSB0byBsb29rIGdvb2QgdG8gbWUgKEkganVzdCBoYWQgYSBmZXcgbml0cGlja3Mp
Lg0KPg0KPiBXaGF0IHJlbWFpbnMgaXMgdGhlIHVzZXIgaW50ZXJmYWNlIHRoYXQgY29udGludWVz
IHRvIGdhdGhlciBvcGluaW9ucyBbM10uIFRoZXNlIG5ldw0KPiBkaXNjdXNzaW9ucyB3ZXJlIHBy
b21wdGVkIGJ5IHVzZXIgc3BhY2UgbmVlZGluZyBhIHdheSB0byBkZXRlcm1pbmUgaWYgcmVzY3Ry
bCBzdXBwb3J0cw0KPiBTTkMuIFRoaXMgc3RhcnRlZCBieSB1c2luZyB0aGUgInNpemUiIGZpbGUg
YnV0IHRoaW5raW5nIGFib3V0IGl0IG1vcmUgdXNlciBzcGFjZSBjb3VsZA0KPiBhbHNvIGxvb2sg
YXQgd2hldGhlciB0aGUgbnVtYmVyIG9mIEwzIGNvbnRyb2wgZG9tYWlucyBhcmUgZGlmZmVyZW50
IGZyb20gdGhlIG51bWJlcg0KPiBvZiBMMyBtb25pdG9yaW5nIGRvbWFpbnM/IEkgYW0gYWRkaW5n
IE1hY2llaiBmb3IgaGlzIG9waW5pb24gKHBsZWFzZSBhbHNvIGluY2x1ZGUgaGltDQo+IGluIGZ1
dHVyZSB2ZXJzaW9ucyBvZiB0aGlzIHNlcmllcykuDQoNCkltcGxlbWVudGluZyB0aGUgcmV2aXNl
ZCB1c2VyIGludGVyZmFjZSB3aWxsIG1ha2Ugc2lnbmlmaWNhbnQgY2hhbmdlcyB0byB0aGUNCnBh
dGNoZXMgbmVlZGVkIHRvIHN1cHBvcnQgU05DLiBXb3JraW5nIG9uIHRoZW0gbm93Lg0KDQpNaW5v
ciBzdHVmZiBpcyB0aGUgdGhhdCAic2l6ZSIgZmlsZSB3b24ndCBuZWVkIHRvIGNoYW5nZSAoYmVj
YXVzZSBzdW1taW5nIGFjcm9zcw0KYWxsIFNOQyBkb21haW5zIG1lYW4gdGhhdCBhbGwgb2YgdGhl
IGNhY2hlIGlzIGNvdW50ZWQgaW4gbW9uX2RhdGEvbW9uX0wzX3h4L2xsY19vY2N1cGFuY3kuDQpU
aGUgbmV3IG1vbl9kYXRhL21vbl9MM194eC9tb25fTk9ERV94eGxsY19vY2N1cGFuY3kgZmlsZXMg
YXJlIHRoZSBvbmVzIGxpbWl0ZWQNCnRvIDEvc25jX3dheXMgb2YgTDMgY2FwYWNpdHkuDQoNCk1h
am9yIHN0dWZmIGlzIHRoYXQgd2Ugbm93IG5lZWQgYm90aCB0aGUgTDMtc2NvcGVkIGRvbWFpbiBs
aXN0IGFzIHdlbGwgYXMgdGhlIE5PREUNCnNjb3BlZCBkb21haW4gbGlzdC4gU28gbm8gbG9uZ2Vy
IGp1c3QgY2hhbmdpbmcgdGhlICJtb25fc2NvcGUiIGZpZWxkIGluIHRoZSBMMw0KcmR0X3Jlc291
cmNlIGZyb20gb25lIHZhbHVlIHRvIGFub3RoZXIuDQoNCkknbGwgbWF5YmUgaGF2ZSBhIGRyYWZ0
IHNldCBvZiBwYXRjaGVzIGluIGEgZGF5IG9yIHR3by4NCg0KPiBBcGFydCBmcm9tIHRoZSB1c2Vy
IHNwYWNlIHJlcXVpcmVtZW50IHRvIGtub3cgaWYgU05DIGlzIHN1cHBvcnRlZCBieSByZXNjdHJs
IHRoZXJlDQo+IGlzIGFsc28gdGhlIGludGVyZmFjZSB3aXRoIHdoaWNoIHVzZXIgc3BhY2Ugb2J0
YWlucyB0aGUgbW9uaXRvcmluZyBkYXRhLg0KPiBKYW1lcyBoaWdobGlnaHRlZCBbMV0gdGhhdCB0
aGUgaW50ZXJmYWNlIHVzZWQgaW4gdGhpcyBzZXJpZXMgdXNlcyBleGlzdGluZyBmaWxlcyB0bw0K
PiByZXByZXNlbnQgZGlmZmVyZW50IGNvbnRlbnQsIGFuZCBjYW4gdGh1cyBiZSBjb25zaWRlcmVk
IGFzICJicm9rZW4iLiBJdCBpcyBub3Qgb2J2aW91cw0KPiB0byBtZSBob3cgdG8gImZpeCIgdGhp
cy4gU2hvdWxkIHdlIGNvbnRpbnVlIHRvIGV4cGxvcmUgaW50ZXJmYWNlcyBsaWtlIFsyXSB0aGF0
DQo+IGF0dGVtcHRzIHRvIGFkZCBTTkMgc3VwcG9ydCBpbnRvIHJlc2N0cmwgb3Igc2hvdWxkIHRo
ZSBtZXNzYWdlIGNvbnRpbnVlIHRvIGJlDQo+IHRoYXQgU05DICJwbGF5cyBoYXZvYyB3aXRoIHRo
ZSBSRFQgbW9uaXRvcmluZyBmZWF0dXJlcyIgYW5kIHVzZXJzIHdhbnRpbmcgdG8gdXNlDQo+IFNO
QyBhbmQgUkRUIGF0IHRoZSBzYW1lIHRpbWUgYXJlIGV4cGVjdGVkIHRvIGFkYXB0IHRvIHRoZSBw
ZWN1bGlhciBpbnRlcmZhY2UgLi4uDQo+IG9yIGlzIHRoZSBwcmVmZXJlbmNlIHRoYXQgYWZ0ZXIg
dGhpcyBzZXJpZXMgIlNOQyBhbmQgUkRUIGFyZSBjb21wYXRpYmxlIiBhbmQNCj4gdGh1cyBwcmVz
ZW50ZWQgd2l0aCBhbiBpbnR1aXRpdmUgaW50ZXJmYWNlPw0KPg0KPiBSZWluZXR0ZQ0KPg0KPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC84ODQzMDcyMi02N2IzLTRmN2QtOGRiMi05
NWVlNTJiNmYwYjBAYXJtLmNvbS8NCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
U0oxUFIxMU1CNjA4MzA5RjQ3QzAwRjk2NEUxNjIwNUQ2RkMyRDJAU0oxUFIxMU1CNjA4My5uYW1w
cmQxMS5wcm9kLm91dGxvb2suY29tLw0KPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9TSjFQUjExTUI2MDgzMTBDNzJENzE4OUMxMzlFQTYzMDJGQzIxMkBTSjFQUjExTUI2MDgzLm5h
bXByZDExLnByb2Qub3V0bG9vay5jb20vDQo=

