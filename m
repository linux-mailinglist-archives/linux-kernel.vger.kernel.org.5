Return-Path: <linux-kernel+bounces-73823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311985CC06
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338A71C226B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63E78688;
	Tue, 20 Feb 2024 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhLeFbn5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE86154C05
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471547; cv=fail; b=LnjhDzQAao6WnzKJto80txtYPMxR987CD4/5rawXOZ4FHqqbGfBqJWwN0x5gtu4jq9i2C+HrmaDtPDfIFJxVaUrQgu7YfXoaapvoVlqcJRHDa8aelOnOO2Skfwtt8AKKxvZBzcTfqb2FtorokeV+AWLE3YneWAh9B4uYr3GDoMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471547; c=relaxed/simple;
	bh=k5B0p5OHQ6dyUBEbQ4j/+PQsTt1nFsZZI8fCFY5LiNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQtbzl/vNc7eJnXKylgaaBDeCFTxadajr6t41UhHVWwNlFShaWpuaqsgnPWSl3De6cYiTvzgAJaCvk+j9pdFBT6KY8LnVuc5KEWnDoq795+lttfmTBZjBUFh85pbzJcVIl71/NkrNJGibJ8gGGP0YItSI2KDAjXTePxlETdkLm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhLeFbn5; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708471545; x=1740007545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k5B0p5OHQ6dyUBEbQ4j/+PQsTt1nFsZZI8fCFY5LiNo=;
  b=KhLeFbn5oOVAdGLIEJ48LiY9d7o4BYaVFqv5Jvs7T6IlU0EHYO7qwkrD
   lYGRYTncoYRZvpNoPnflZQI05C9lTwVvUlqFaIpAXaWPmS0yxzCaX2Xff
   /S4F93h7YEVvx1b8yQG+mNSXPZXFFPloZs0eXeps77tcfaqiFeNlp8tjO
   BDqLmgdmRhmq79uMtWgazBpVYiRSaWEIwfUva6oK5C+g2PvH9txUWf4xi
   5aecpdEcmkLefF2ubwQRld6q7ZsTAIcc0aZUxG0Ia0Xty0si7ArAHQ+Si
   JVuiHAlSUmFC4IkSSRXxHDaHK40owULyw0m3WVWUIKlKwk52gnkE6c7Sb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13164237"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13164237"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5287382"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 15:25:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:25:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:25:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 15:25:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 15:25:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W93EqNBZLjJ5NknLplL41udOoi8C7RGKaNi7EMCXl98PWcyLqY0roGaJlCrS5716axyH9hq6H2MqESJXEwZqy2MhgmkTblkemEP2EiqPIDAsnXV/9OzQ2owUXhDglKkEi1FrrNlB2labtDsXwo/trBM4bULHhlkMyaWDtiOWXWPoHsMy0kXz8mIbOFlXhCsOcUZKXRrOKRYBrnn73rbdEGXcvzeAsNGj46X+bAvzc1Fl1zqIzyA6WS/nMESfjI9nPPY2xFS04eXS4T+dr8CT525e5+zQ4SlbrOqSw6FHu1eTvUNQhi3LWmlP5zKToeCh8c8J0o6GXMdh/7HN9xfLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5B0p5OHQ6dyUBEbQ4j/+PQsTt1nFsZZI8fCFY5LiNo=;
 b=ihGL+2PsrwJUBHR0JFCFy5MDSES0+xzPzfAskrq+t13eZ07izNjehTR2mF73ekMYlXi1ubWHI0uA1b/4w0mvtY3AoRPxb73k7Pce7PODvt2SKOY+j9Sx7jVtUBckk8PEWuqzWQ9KBkptqL818nnooFEdc4l2ma/8qcaQw4vlnYzG97ASMtkCKYCXZYbUdN52UKxxKq9rpFQqnd2xEJDlSubizT7shNU8PBU6siZRi/JpXl4gVEA+lxtx9NNCyLz3qZN3cXG9v0PRi7EIPujomZjCJpyLVcDvT7swtRjEQFsZ+Qm9ifxM778SdqxSnmSyWc4GhZ3745uLywKKw95anA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:25:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:25:42 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
Subject: RE: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHaZFBCESTTEU1QvUCD4f5WUPvlPbET2r0A
Date: Tue, 20 Feb 2024 23:25:42 +0000
Message-ID: <SJ1PR11MB6083A759748EAF62EDF21D0FFC502@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
In-Reply-To: <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB8189:EE_
x-ms-office365-filtering-correlation-id: e4f47109-5318-4378-85ce-08dc326b41d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdX708TL0Z9IczjGW02Q/TzRMXxi+5xkgtnizWWx0jM/Iw0cnl/Qr3vIWUe8o7LQ8N6l7YcsV7nPQgbLcWJSq98JGSMjARDHoO5/8zTiSNPTa3suXX6oTamlvWsQmGfXZgxXZdXoOgIrTvB69av5xpQ6jZKTcq71KjqIa4yYOVTH/aCMZY8ZlHTcT8fZSvbU3GazZ1Dgb9oihcjoyopUN+O11oIHxOD7/zzU2zW6yBSihuvnyrn2Oo13W+XeMslFyWfw1P1EzjeOGHKdgptFl6bfJCtkIEmn+UwEqawAGDIblNqDrJcTlpYuAhyG3A+LEbBD0RljwRURKfPtkLP86CDiP9MBMqUMZBDJ/p26Ug6wr/02D211fgbSKmqXEYeZFRcWaagODycuRilgKrjhZjrSP3hhNqk1xHCZJLooRVvBB/ZOar80fHEOq8UVbu/PIkHVtpZ86YflMuu4vM/7wJiTzZwbPGfLSgSa1eHC3kHfb5FXh0LBf4S+45UrP96oEGtfCO+vO9QvVpFrBk4818C8p9s8WDLkytHYROJOY7y66VQotj9T5fc9HWW3CBr+culL9O3wE9xjShUKwnwu4pE4JqTyzZJAjiQzArSXnrZqIG3OjVbc8pVRIwzL8zrm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0p3WGpQd05DOHFPV21YWCtaQmVORXgxdjJ3YWNkSFppSHViTVBNNXRvcXFF?=
 =?utf-8?B?cHhjSE9oQXZTZ2pPaDkvMDFEVXhvUHVyV1RRaHZiQTJWNDZybWZseWdYcHBH?=
 =?utf-8?B?eVlzbXpOa1VmSVREb2V4ZktFOFBTYTFWb0hKaCtFd0NoTWdHbmxsS0g5cFBD?=
 =?utf-8?B?NmJTZ1lwK1YrancveFhqbnhOR0FIWTBpY2pMSWQ0U0ozdytaQ05tSG5nUHJx?=
 =?utf-8?B?SWJwQUJvaitxTHpObnMwOS9UOFpGNi9NbHI5Z1lsUmJzZ1FLTmhmV0tESHp2?=
 =?utf-8?B?bUs0Z3RRcWR3aUdVM1FTU0oyTCtSOWo5ck9CcFBYcUFUWHlJTzE2OFp4U0lv?=
 =?utf-8?B?NFZmdDVCRDg2ZGxDeE5WSXVLRHRzbDFIRzB0Z1p5dE10VlVXTFVYWGVOZ05V?=
 =?utf-8?B?dm9nWWZPTTJHT3NISVhYYzJ6UVlFazZlVzBRT3RIdGhkeFNNOG1BQmZKN0Zn?=
 =?utf-8?B?dXdsTFJJWUY2ejdyaWtsQ25OeTZEZzlQL1BVdUVGRU9CZ3dQR0pmNGJxNlBI?=
 =?utf-8?B?dzhhU28xOS9BUEQxT3A4ZTVWYXNJb24wRHUrMEphMU5OTjM0aVNyN1dSQlZQ?=
 =?utf-8?B?eVp0UWhkS2FpZktlY0N6RUhPbHVTck5zc2grR091SFhpeXZDb0x5NzdQWWd1?=
 =?utf-8?B?d3ZlQmZRUlg5QWRiVkJyMHR1K3hvcjR6a0xRK2hrNGZETGdGcy9DWlNnYmt0?=
 =?utf-8?B?cCt6Qld0M2VhY1hvZ3FxV1hUVlNicGZReXNTdklITWZZYWVtTzUzZWhjdzYv?=
 =?utf-8?B?VTA2dzNEbXdQSTFvWTF5VU9TUjg1dlhsZ2g2NXp4Z09DTmNsaGdEUDlBbzh6?=
 =?utf-8?B?Q1pXZWZMaGpDWk1DQmdEcmdIeU42V3JGMFdZVnlUSUNSMndYeGZSVE9VTlll?=
 =?utf-8?B?dFlNQXdrZW9jOHZPdnRBcWxvcjVncWZYSk9BY2YrdlUrQThtMXRoaGd3YjNk?=
 =?utf-8?B?MVRZN1pwVEc3NU5nWGdlUFo4czFXZTFoM24rQUJIWU9NZm1nQVhuZFpZamVk?=
 =?utf-8?B?SFc4SGpOcnRUMzVuYVNpaWYyK2pOWjIveFFJMlpTVUM3WWFGMXFUT3hrQUtq?=
 =?utf-8?B?cXNyTGFMNmVzYXU1VFA3TWkxL25UNkFCZXZqVENOR09xRWFWcjF2NmUrRVFw?=
 =?utf-8?B?ZlRwcm5wOWJtYjBlUXZEUGRicnBsd1R3MEZ1cmNvUVkxNk9nWGU5QTQvR2Vw?=
 =?utf-8?B?Y2E4RUVUaHNvR0V6WHhub2w0QTlDa0dsZVNES0lFVXlETE9ZTjFiZFVYa3FV?=
 =?utf-8?B?eTlKb3J0VjkwdkFkbGVLcEtNK3RnT2kyZTd5MTVZbkxFeXJsK2tsbWtZbU1p?=
 =?utf-8?B?ZWVhVzJQL1IyWHpWUVJlM0dlYlFIdjA4cndta1BEakFFUVFLQnFsMERYeFhO?=
 =?utf-8?B?WFFiWHUwR3c1UFJqY0VkYzZEamJ0aXgrcWU2OE8vL1BUekI2WVpKdjlTVFZG?=
 =?utf-8?B?SDZkcWJlaDFmZGtIdXB3NkZSVjR2aEFwdFBtNmlFVUZaeVJKOFpOZ2hhS2V0?=
 =?utf-8?B?OGd1eUJvSmhXelpMYUw4cHdJWlJ3ZFozQ2poWDF6VitOUlkzK3AvdTVjNEhl?=
 =?utf-8?B?Mm9COVpXNDBhRklPa2FRdjM0QkNNQ2h3S21nTThlRHVGbjRYK3hTejdLSE5U?=
 =?utf-8?B?K1FzYkJIQ215dmZDdHp3dS9zY2c3YVdnVnRYOVB5T0VVMnNBc3NKU1VWNTQ2?=
 =?utf-8?B?dXNyTm5UZDc2M1JIZFF5V1lFOXJxNlVBcXJMWEJYalMyanp2dUhqR2ZBT2sw?=
 =?utf-8?B?M3VmWnZ0SUV0ZW15dHpycnExNmpiZTJRZHBhQ0ZiYkp5cnZjZUVhYmpXait1?=
 =?utf-8?B?SmE0a0N3b1pHNVdlN0czTkRIdXl2aXlMZUhnOWZyeDRKOUEzaGR2ZU1oVEpQ?=
 =?utf-8?B?TURxa1ZPK1JhVTFTakU3cVNqQkdIdnZRN0FuN2NNMWtnU05jejR3SUxKbkF3?=
 =?utf-8?B?U2ZwZ1FicGoxeEYwcGlabnY1a0FBQ1ZiazB1cFRFRnVwZmNLc0JnNExmY2Ft?=
 =?utf-8?B?d2pYVytOUFYvTTRHb1JVTlVHNUtmNEgyYSt0dlVweldnVUlXMjRhWDNWd1JW?=
 =?utf-8?B?T0tBNDlQcUpGbGtTL3UwQ1d6SWVVOUF1cy9qVE1yWnhvZ2wxQjAxUDBLRWFu?=
 =?utf-8?Q?ynFxnAC/KIHSh8FmzrtPOTYAX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f47109-5318-4378-85ce-08dc326b41d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 23:25:42.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUY2cePweZvzIsGENQICI/nV66VPsZ0YiKCuwNdr9FItyMgWQYPb+zmv0SxNQLmdRhtoTgEZukVTxF+6LNKJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8189
X-OriginatorOrg: intel.com

PiBTbyBldmVuIHRob3VnaCBpdCBpcyBjb25maXJtZWQgdmlhIGxvY2tkZXBfYXNzZXJ0X2NwdXNf
aGVsZCgpIHRoYXQNCj4gcmVzY3RybF9hcmNoX3VwZGF0ZV9kb21haW5zKCkgaG9sZHMgY3B1X2hv
dHBsdWdfbG9jaywgaXQgZG9lcyBub3Qgc2VlbSBwb3NzaWJsZQ0KPiB0byBoYXZlIGEgc2ltaWxh
ciBsb2NrZGVwIGNoZWNrIGluIHRoZSBmdW5jdGlvbiBjYWxsZWQgYnkgaXQgKHJlc2N0cmxfYXJj
aF91cGRhdGVfZG9tYWlucygpKQ0KPiB2aWEgSVBJLiBJdCB0aHVzIGRvZXMgbm90IGxvb2sgbGlr
ZSB0aGF0IGxvY2tkZXAgY2hlY2tpbmcgd2l0aGluDQo+IGdldF9kb21haW5fZnJvbV9jcHUoKSBj
YW4gYmUgYWNjdXJhdGUgYW5kIEkgY2Fubm90IHNlZSB3aGF0IGl0IGNhbiBiZSByZXBsYWNlZCB3
aXRoDQo+IHRvIG1ha2UgaXQgYWNjdXJhdGUuIEFueSBndWlkYW5jZSB3aWxsIGJlIGFwcHJlY2lh
dGVkLiBQZXJoYXBzIHdlIHNob3VsZCBqdXN0IGRyb3AgKGJ1dA0KPiB3aXRoIGRldGFpbGVkIGNv
bnRleHQgY29tbWVudHMgcmVtYWluaW5nKSB0aGUgbG9ja2RlcCBjaGVjayBpbiBnZXRfZG9tYWlu
X2Zyb21fY3B1KCk/IA0KDQpSZWluZXR0ZQ0KDQpCb3RoIHRoZSBwbGFjZXMgd2hlcmUgdGhpcyBo
YXMgcHJvYmxlbXMgKHJlc2V0X2FsbF9jdHJscygpIGFuZA0KcmVzY3RybF9hcmNoX3VwZGF0ZV9k
b21haW5zKCkpIGhhdmUgc2ltaWxhciBzdHJ1Y3R1cmU6DQoNCg0KCSBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGQsICZyLT5kb21haW5zLCBsaXN0KSB7DQoJCWFkZCBzb21lIGJpdHMgdG8gYSBjcHVtYXNr
DQoJfQ0KDQoJb25fZWFjaF9jcHVfbWFzayhjcHVfbWFzaywgcmR0X2N0cmxfdXBkYXRlLCAmbXNy
X3BhcmFtLCAxKTsNCg0KDQpNYXliZSBpbnN0ZWFkIG9mIGNvbGxlY3RpbmcgYWxsIENQVXMgdGhh
dCBuZWVkIHRvIGRvIHNvbWV0aGluZywgYW5kIHRoZW4gZWFjaA0Kb2YgdGhlbSBiYWNrdHJhY2sg
YW5kIHNlYXJjaCBmb3IgdGhlIGRvbWFpbiBmcm9tIGEgcmVzb3VyY2UgKHRoYXQgaXMgcGFzc2Vk
DQppbiB0aGUgbXNyX3BhcmFtIGFyZ3VtZW50KS4gVGhlIGNvZGUgY291bGQgYmUgcmVzdHJ1Y3R1
cmVkIHRvIHBhc3MgdGhlIGRvbWFpbg0KdG8gdGhlIHRhcmdldCBmdW5jdGlvbi4gTGlrZSB0aGlz
Og0KDQoNCglsaXN0X2Zvcl9lYWNoX2VudHJ5KGQsICZyLT5kb21haW5zLCBsaXN0KSB7DQoJCW1z
cl9wYXJhbS5kb20gPSBkOw0KCQlzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUoc29tZWNwdSwgcmR0
X2N0cmxfdXBkYXRlLCAmbXNyX3BhcmFtLCAxKTsNCgl9DQoNCkknbGwgdHJ5IGNvZGluZyB0aGlz
IHVwIHRvIHNlZSBpZiBpdCB3b3Jrcy4NCg0KLVRvbnkNCg==

