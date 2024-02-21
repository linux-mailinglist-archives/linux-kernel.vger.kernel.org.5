Return-Path: <linux-kernel+bounces-75198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0385E48D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2EA1C226C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBA83CBD;
	Wed, 21 Feb 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGTg0rEg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671280610
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536618; cv=fail; b=lBf6M4CmFp63m6vV6mmSWC3rDT5RrTCKPDlRC49lD+7BTTWdWwGXE0lMGg6a7zjJQV6dCYdNnoSucuLiBpyIRx0MKWNlVULP2Q9ktv+NHUAI7ZZpuynRBFrshGyKsOEYIHawhxVP1RNYlKU97VJG5T2wCouHP3mo56vd18fNUqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536618; c=relaxed/simple;
	bh=pKzRVSRy5bnoZOeT2nNQrkwg1hJmWLHOat6ovfcDM8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jiHJgCLdJFhPjPgXUjTNCNYqQ0tOTa/XVF5WBvY8iX9Odx9iUBpDUZpa8XzTZX9NzDK3oBJZU8zRDin3ZKC3Sl2e682ERLIuJZZHTD1LpSbUsn/Tm6Px4B96jXjOoAeZjDHrZ8YCvLNXQbBRCqNL1acwtRc983GRNvmWir+0xdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGTg0rEg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708536616; x=1740072616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pKzRVSRy5bnoZOeT2nNQrkwg1hJmWLHOat6ovfcDM8Q=;
  b=HGTg0rEgpwDsIH3KdyW125UP8gz8nM8hw1yZUHDnMXfhpdrTty0aHIOr
   S3XO0QJPoEZPYdFLwb1wnwixDbsNxljPi+48QFgIdnp+TB9AyIlsWPooe
   EWNDzcqdq3oUyQi4V+7oab73F0L7zoP1qAjqO6oPtVSmBURLofOm0wda2
   AZvf0jukUEiTl7Y3juhtvke/bY3jbc/qOYY1rfU2IUTv4WzN9vWrm5xW2
   a/AafdEA7pXB46HgxtwGE+FCO3Flc64yjWxpKa4AjNs2jkwpYSzfTzo4W
   GCzOboo4g7oAulyOuIvu1PoN4CS7hzxthKmXO5e0BW1gPF7nvaO6otRo3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2853343"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2853343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 09:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936674611"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936674611"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 09:30:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:30:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:30:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 09:30:09 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 09:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl+kPKUy3G42BSYr6nBgS/SoRz6+qseMOa4WYSqbIdftgEeSBwKQui1j2R4iT5wwi6bfuRPjoEMHt074RmDAICNEpKHC7kNNN5c1GA2P8+VQbMxLU3GVB/VrZC4bii5PtD1YVOZ0sqaS9rv1yB8HNDCkis/3h3ZDQquNUImMzjLA206YkXr73Wj3tKVC5FLLLslUuVwUrqgk7qxBONKudcBXpYgCKI6AdfwsVUmGU3EI1Ir+3Bh5P6EdUakCBXPmwFW0WMDCrV+kdtrfmQhceg/deKD+e6Ox2gp6gkK3nl8P0lV8cJWjoD/9hQEdsQ0TjAJ+15YbP+qDonWBFW3Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKzRVSRy5bnoZOeT2nNQrkwg1hJmWLHOat6ovfcDM8Q=;
 b=Ksx1XlilxQQG0EQEehEbIvJj59fdeunt8BsKAIUfZ8BYkKpPFQLmV4Q9NKp4OLp3tEhBa8V723ATo/N9rpzlFvNNt61Y1roUsV/WDzr6OXO4Ycp2OjWowDJNFBDhVEiHBOlogl8jc/W1WBV0cP7Xeuo0BaDVZmJPcoj67yBDFojRjIc0bhR61KlYAoQ9kO0hhcMWb7lmFPJ2x+bs8oPm2kBrfImq62rqR2C5uAZyM+HeWUfJX82LdcXIEHYdp9gWPpa1oqy86mI1qscQ3yvS5ZQjpud9bIGIULk5Fvwm9LF37SvPLFLRdk7b0dFTRA5BivrzLwWWCOXpclPmjhnFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 17:30:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:30:01 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
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
Thread-Index: AQHaZFBCESTTEU1QvUCD4f5WUPvlPbEUtDIAgABO2QCAAApwsA==
Date: Wed, 21 Feb 2024 17:30:01 +0000
Message-ID: <SJ1PR11MB608374C8F6AF8E643020C1CEFC572@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
 <e4dcc9b4-afa0-46c7-988f-19fd7509e608@arm.com>
 <3c132975-a516-4386-8b60-35b5f600f1ab@intel.com>
In-Reply-To: <3c132975-a516-4386-8b60-35b5f600f1ab@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB8290:EE_
x-ms-office365-filtering-correlation-id: e35ad142-4679-4d50-20fc-08dc3302bbf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ij1Uy3A8FE55p1d1iwOI5yXGgjdstJJU8+3K6e5LAfIFWOe8vbVklFsVrjnQiMLYyNYaYASv5NRIoHLKfxaOtwYpOfSHQX1tsDBytMk9cdZT65GJsvjJvqvj2d+EW2Aub4VQGubMxXNelwf7dn0qvcXsiKnNbt7s219eY3ImgACsKzPWDwNS2j3WUPyAdj+zLj1yzKImt7G8QCIh/0weN7I89yXC5l81+WUm7/bhcOAuO18tsMaN0flKXyImAS2vLsPFHmqaamDhY/MoLwB2WISKTa4l+8UDi4jM+dqnXb0sOj16wAbVYlwBiQ3KHeY3JZvbtHMRLZn27qpRnoJkBY9PtRqWis+1BcbBmhE+spVXClzZH7cEpTV4i0yGaVz/uBp1C544mJSA1+jwHFfICeIrvRiZ/q31+VO4AQAgR5mEUojiZ7BRTJEvrkvK76P1TI8Aryyng+fyX4quEodIPzYUHCYEMqhcONhW4trdR2UfACLCcnZgyrRvahLgisWRETI4fujhCeSP0V9N5KCKDtS5OR3ve9giaq8MLq/4EsMVmkaXMAmReU201i/agZf8RfLb1K1+wemJxKazKUfdmTgGsIDbNPeTAYQSWp1FciXIDZJ3+18qhCcLvObBWiNG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhucjAvK1ZueStXU1dvL0hwRURmdG5HZkhYbmdhL3EzWnB0aFM3NjlOWlpm?=
 =?utf-8?B?NnVSeDVhYzgrcjhRRGc2aTVCMXYyNUhNWHlKNTQ0L0pVckh1Z1hJS2xZK25F?=
 =?utf-8?B?cmRqNjNyZmczREdOeHNqWWlMekl0MUkzekF4OXo5amg5TktXWmViRHZnVkNB?=
 =?utf-8?B?OFA3clNSb2w5SUxHQitaUWJZQ0lHT0RxU3ZnWFJ1bXhpRDFVSk93bXB6WHo1?=
 =?utf-8?B?U0tOdDNtNTN1eXFRZVk0a3BFOG80eVY4aU0vRUlkQm1GNzI0a2hGS21sMHRm?=
 =?utf-8?B?V1psMTU4eHovajJQVytoWEZIU2dBS21mTmoyRTVXM2dKaEQ3cUlYYXUwRHhk?=
 =?utf-8?B?WjgwMWNacDFXQmFValhSWElMRjk3OFFVZmNTMVM1M2VadmpZb2tVUit2eVBv?=
 =?utf-8?B?cm12ZVNWTkhoRmZIUDFudFFxaENjNDdhZzJNY01SenJNUUxrUXJvSTdCRzRa?=
 =?utf-8?B?ZXNkbG1vK0FjcjRpOWZjL01kVkJ4QjdUOU5mNjE2c2JzeWN0SVY0MVp0WXlo?=
 =?utf-8?B?RnJmbnZJYWg3VHdaNEt5UWtNU1VCVUtSdnNtZU1kSXdoRmdkOUNHMDEyejFa?=
 =?utf-8?B?dmFQWnpDUURNbnZpU1I0ZFJtOUx3VVhIRkdOMlBHeWh3L3NaZktHVFZWSnlY?=
 =?utf-8?B?Q2lJdFF6WXZ2TC8vUFZKY2JwTWUrWVE4Y2FjYjJlZnFxVjBlb2FzUFNCN0pX?=
 =?utf-8?B?K09vb0Vxb0ljQXVISW0veFFvd1lOR1lUNWxNMXA4UHJEVEtMYldrWllMbFll?=
 =?utf-8?B?R0MzYVBmZGtSYmxSTUphcnplVWNFT092Yy8wTjR3TmI1dUVHeEZtS0U5SDIz?=
 =?utf-8?B?MDd2OWFFK3BPZ1F4bnZBdUxZQ1FDbmRsWmhFZHpBYkNWaUQ3a1h0ODBzTFVN?=
 =?utf-8?B?WERxNkpFME1pYVhWSmdyUG5kWXdtN3I4R1ZMSFB6RVRYZ080WFhjUmptOWpZ?=
 =?utf-8?B?dkdGWVB3V05uanp3NXhCRERpWVJRSlNsdm1zZXNGMkROaGRhMVZ1RkNPZzhX?=
 =?utf-8?B?UjVaQ0FMbmdIYy9McHdQaWNVQnNJUXd6czE3cWlWYlo2MGJsaUl1dEFFeE8v?=
 =?utf-8?B?bExlVVYrS0h4Vzg1MGxJRFZMbTN0a3RZR0ZCUGxFQURpdy84TllEQnYwcUhq?=
 =?utf-8?B?NmMyNlFEQlpUcXQ3L3VxSU9jRzhXSVJydDVoUlVUQ2gvb3l2R2prUExhZ21j?=
 =?utf-8?B?SWo3TEZnQUU5eHNuNkNCdm1oV2FMbGNZOTVtZmpYNy96YVlFNnZzbDRDUGZq?=
 =?utf-8?B?RGR4ZDhhN0txM0hmbE1RdnFWVlBIMGVJTi9SazMzN1FBeUszc2JTZ3JkekNh?=
 =?utf-8?B?QzVSOStkNnlrVWpMWUY2TUF6Z0VieXV5Qkx6Q0xRRmI3ZzVLdnFoSjJ0MUlQ?=
 =?utf-8?B?VWFmaGFiYy92S2tkcHgyWW9pR0RSQ0RjK2I3dTdVTjFTbGdiV09Od2JZRUlD?=
 =?utf-8?B?M1h2K3liZnhIam9PQUVBdTVHWkhZZ0wrbWZLVXhWTmFHbjR4V0xnYWNxWnlY?=
 =?utf-8?B?dFJNcEJHYU0yY1UrSklqSjFYTzgrd0FiL0llUXlaV2JEeWtZTy85TENSNFpC?=
 =?utf-8?B?T0ZkT3lUcmQ0U3hhRzZqUmdDOWpJRm51ZzkzelB2NW1IRGUyWE9YQzhKZVBa?=
 =?utf-8?B?WW9ua0tkVXd5L2Y2dzlpRGpyMTNYNUw5M3g2T2xPZjEwOFhyZjd1Smt2bjla?=
 =?utf-8?B?Y000eklUUVpKUVFBRlUzcEVxVCs3R0NOSVhuNTlNajJZak5NWVVrVzEzOUo5?=
 =?utf-8?B?RW0vZ3ZKUjEwcjIwbkJPZk96cmdSc1VqRm9oRGg0MER4VkNZcGNHcUt2SERD?=
 =?utf-8?B?bjFaYStFYW1uVk95b3JPa3hESHJSL1EzSjBSMGE4QTI1R2lNSFNFSFhReis5?=
 =?utf-8?B?b3Y3VHBjNG5OVjk5NFk0VS8rcllSam9CUFJKeHhWdDBncnhMamM3Tm9hcFU0?=
 =?utf-8?B?Tlh0Sy9EUnkrdElqYmlTQzNpRlc1enFSTXFTQXF2NEwzNTh3SUEyOTg1Wmdr?=
 =?utf-8?B?ODB1WitHQll3NmNMdzhhQzQrWUlJbjZiaitQM2drZU12YXkzQitDK2kyclZx?=
 =?utf-8?B?RnhCL1NzTkZQcUViRTg4bi9YcVpJTDUzQUduUytvRCtRMC91Zmh2dEcvdDNM?=
 =?utf-8?Q?R5CWp4Z/7xxHQALBSKalh97dW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e35ad142-4679-4d50-20fc-08dc3302bbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 17:30:01.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xvHNgLlo6Accs2fsYjnWkMn5WDoiPRGZeSb4CNMObsAcqOal5ayEiXsQuqIiSnjgxXWY2vU6gHANQRyqHpEfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

Pj4+PiBUZXN0aW5nIHRpcCB4ODYvY2FjaGUgdGhhdCBXQVJOIGZpcmVzIHdoaWxlIHJ1bm5pbmcN
Cj4+Pj4gdG9vbHMvdGVzdHMvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybF90ZXN0Lg0KPj4gDQo+
PiBJIGV2aWRlbnRseSBuZWVkIHRvIGJ1aWxkIGEgbmV3ZXIgdmVyc2lvbiBvZiB0aGF0IHRvb2wu
DQo+DQo+IFRoZXJlIGhhcyBiZWVuIGEgbG90IG9mIGNoYW5nZXMgaW4gdGhlIGxhc3QgZmV3IGN5
Y2xlcy4gWW91IGNhbiBmaW5kIHRoZQ0KPiBsYXRlc3QgdmVyc2lvbiBvbiB0aGUgIm5leHQiIGJy
YW5jaCBvZiB0aGUga3NlbGZ0ZXN0IHJlcG8gWzFdIHdoZXJlIG1vc3QgcmVjZW50DQo+IGVuaGFu
Y2VtZW50cyBhcmUgcXVldWVkIHVwIGZvciBpbmNsdXNpb24uIElmIHlvdSBhcmUgaW50ZXJlc3Rl
ZCwgdGhlcmUgaXMgb25lDQo+IG1vcmUgc2VyaWVzIFsyXSBwZW5kaW5nIG1lcmdlIHRvIHRoZSBr
c2VsZnRlc3QgcmVwbywgaXQgYWRkcyBhIG5ldyB0ZXN0IGZvcg0KPiB0aGUgcmVjZW50IG5vbi1j
b250aWd1b3VzIENCTSBzdXBwb3J0Lg0KDQpKYW1lcywNCg0KWW91IGRpZG4ndCBzZWUgdGhpcyBX
QVJOIGJlY2F1c2UgaXQgaXNuJ3QgaW4geW91ciBwYXRjaC4gRGlmZiBiZXR3ZWVuIHdoYXQNCmlz
IGluIHlvdXIgdHJlZSBhbmQgd2hhdCB3YXMgYXBwbGllZCB0byBUSVA6DQoNCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9yZXNjdHJsL2NvcmUuYw0KaW5kZXggOWYxYWE1NTVhOGVhLi44YTRlZjRmNWJkZGMgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQorKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQpAQCAtMzY4LDggKzM2OCw4IEBAIHN0cnVjdCBy
ZHRfZG9tYWluICpnZXRfZG9tYWluX2Zyb21fY3B1KGludCBjcHUsIHN0cnVjdCByZHRfcmVzb3Vy
Y2UgKnIpDQogICAgICAgICAqIGFib3V0IGxvY2tzIHRoaXMgdGhyZWFkIGhvbGRzIHdpbGwgbGVh
ZCB0byBmYWxzZSBwb3NpdGl2ZXMuIENoZWNrDQogICAgICAgICAqIHNvbWVvbmUgaXMgaG9sZGlu
ZyB0aGUgQ1BVcyBsb2NrLg0KICAgICAgICAgKi8NCi0gICAgICAgaWYgKElTX0VOQUJMRUQoQ09O
RklHX0xPQ0tERVApKQ0KLSAgICAgICAgICAgICAgIGxvY2tkZXBfaXNfY3B1c19oZWxkKCk7DQor
ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19IT1RQTFVHX0NQVSkgJiYgSVNfRU5BQkxFRChD
T05GSUdfTE9DS0RFUCkpDQorICAgICAgICAgICAgICAgV0FSTl9PTl9PTkNFKCFsb2NrZGVwX2lz
X2NwdXNfaGVsZCgpKTsNCg0KICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGQsICZyLT5kb21h
aW5zLCBsaXN0KSB7DQogICAgICAgICAgICAgICAgLyogRmluZCB0aGUgZG9tYWluIHRoYXQgY29u
dGFpbnMgdGhpcyBDUFUgKi8NCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0
cmwvY3RybG1vbmRhdGEuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jdHJsbW9uZGF0
YS5jDQppbmRleCBkYzU5NjQzNDk4YmYuLjc5OTdiNDc3NDNhMiAxMDA2NDQNCi0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jdHJsbW9uZGF0YS5jDQorKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3Jlc2N0cmwvY3RybG1vbmRhdGEuYw0KQEAgLTU2Nyw3ICs1NjcsNyBAQCB2b2lkIG1v
bl9ldmVudF9yZWFkKHN0cnVjdCBybWlkX3JlYWQgKnJyLCBzdHJ1Y3QgcmR0X3Jlc291cmNlICpy
LA0KICAgICAgICAgKiBjcHVtYXNrX2FueV9ob3VzZWtlZXBpbmcoKSBwcmVmZXJzIGhvdXNla2Vl
cGluZyBDUFVzLCBidXQNCiAgICAgICAgICogYXJlIGFsbCB0aGUgQ1BVcyBub2h6X2Z1bGw/IElm
IHllcywgcGljayBhIENQVSB0byBJUEkuDQogICAgICAgICAqIE1QQU0ncyByZXNjdHJsX2FyY2hf
cm1pZF9yZWFkKCkgaXMgdW5hYmxlIHRvIHJlYWQgdGhlDQotICAgICAgICAqIGNvdW50ZXJzIG9u
IHNvbWUgcGxhdGZvcm1zIGlmIGl0cyBjYWxsZWQgaW4gaXJxIGNvbnRleHQuDQorICAgICAgICAq
IGNvdW50ZXJzIG9uIHNvbWUgcGxhdGZvcm1zIGlmIGl0cyBjYWxsZWQgaW4gSVJRIGNvbnRleHQu
DQogICAgICAgICAqLw0KICAgICAgICBpZiAodGlja19ub2h6X2Z1bGxfY3B1KGNwdSkpDQogICAg
ICAgICAgICAgICAgc21wX2NhbGxfZnVuY3Rpb25fYW55KCZkLT5jcHVfbWFzaywgbW9uX2V2ZW50
X2NvdW50LCByciwgMSk7DQoNCi1Ub255DQo=

