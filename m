Return-Path: <linux-kernel+bounces-35749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A88395EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334221F24AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCAA7F7FF;
	Tue, 23 Jan 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKlxLxTI"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976060DC6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029700; cv=fail; b=SGjtFwTv3wuzFIC7n1ULzI4Fs/xuCTVIcjTZEtrOd8/D/vEzt5Ul36QyZAVf2t6RN1t2GZYebU0gkLiUjJaDRFzr9vdlDXeaWP6rsVJJBqrGTTvmriJXQojYzy5cenjjNawex2euj7Oc6zaNS6cjyr6d1ESN4ynARNeqpYAm9kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029700; c=relaxed/simple;
	bh=tn58hiRX6kNNP/G5GcDA5/SoqExHi9fRNclYRgqwEnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRdrNNUyopXzvOlBLJfq5tqqR4DuF17iHc1GSp0CxAAKDzysOgG5YNju9syxtGUN176tCuteAH/wM/7GOu5NfTNbrRMF93/wiWktFZRJhW/q3h1AmFZi055zDn7zMKWj+MWJGz/Oh40unBIxUK8diT2JNp3rxYT7WyEnatZ1ZAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKlxLxTI; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706029698; x=1737565698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tn58hiRX6kNNP/G5GcDA5/SoqExHi9fRNclYRgqwEnQ=;
  b=gKlxLxTI4xCJTkcLK+VTPimCWfaQhb8HKKCkhpo6oXuRsQBvghqTiZEI
   aZXdJXUiavikHBPeRAsr6tbujyqIiztdnnDsV/45ngQMP5fM9L8Mf1Erd
   YSW52nE39m5zhzRQCvJIEIpn5F0PpbsaudqEx4cAEYwD8OlfNZBzm2cmj
   jRTwSrRmE+OTlLZM72TGTP8BNSeGGD5PhG0nOO23D/9Mvw8/k5ZWtqJxD
   Jys49YGsFujLJC9zQetEnzsnfYrIn3ddfV+gwDJaA4ZbzdewfmCZcPDvh
   Jsmm1MhJqhA3DNG3J84tAkZNYoU4w7tPLGCoVnUyfursP25dHhBChCGTw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405340706"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="405340706"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 09:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909365926"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="909365926"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 09:07:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 09:07:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 09:07:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 09:07:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5th9Hou94ZVfqXs0QhqCSuk5cDhoyttjUavcpERiGmuuo5+UaIaqFsIiuPtgXuqdyk9JJtewHppv/vnFTznXqABpu/V8vGNjamgowA0yUXw9MkpX+ZwAENwwM1mWqQeziE1x33xkecZO2uTm1DMB3yBS2eKPZfLEwYGfhPU94L5dOI2aTSmAVH6Xn9XGa2WcFE3tYlcp7kS7HprM82C2IYttX/oV80TdkwzPqtSKF10QGIY4yg2o0ZNOXuDjkWPILjtm+wAzOfCDAtr3beTYMyyTxnO0QyqQUd9Whqg2kSG6cp4U0kLO1o3prrUtVjgnPloyTfQmYIfCw3VrMxRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn58hiRX6kNNP/G5GcDA5/SoqExHi9fRNclYRgqwEnQ=;
 b=cG0yEEVHGpP4l84BW60a1cqmSfw9fk17WHMmloukKFS2/XhOtj35NDNUcM96YMUkl2zRnbvOnWo+hC026+e33F5hsxTnBlDogdVTq8f5TCa76lwFOsTGjlbm7dcHEISLg5GBcjCJooWAjS61jTMnCIGkiRCmrpTwo9zcPZQfxvJ6XIfiXHbKlxCaqm5x2osJOn38FSsb4mFSc+GgvCNBDXJnz1HyBKSOmi3hFXQkA6hHvokX/1BtiRU6CpM+0xbrYut+ELiu+W6O+29vw/JEY6/Ilrnz5FJCERmH21wCnk2gJsPAj5X+I/XO98N4WrFl+xsTNh0g2nHd6nu/W77b2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Tue, 23 Jan
 2024 17:07:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:07:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	"Chatre, Reinette" <reinette.chatre@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, "x86@kernel.org" <x86@kernel.org>, Jamie Iles
	<quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>, "Shen, Xiaochen"
	<xiaochen.shen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Thread-Topic: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Thread-Index: AQHaSlc7bUSCbHYfxkutH1GOiWvBRLDmHd6AgAAIRFCAAAPagIAAAO6AgAAFf4CAAAHtgIAAI0cQgAEAmwCAAFA2MA==
Date: Tue, 23 Jan 2024 17:07:50 +0000
Message-ID: <SJ1PR11MB60830483DCBE64EB726CF7E6FC742@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
 <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
 <11fc82e0-961f-4c8d-844f-ad4b99067eb3@intel.com>
 <20240122184755.GCZa64W02KXyeaVXJg@fat_crate.local>
 <SJ1PR11MB6083A27C628E17FB8BBC4922FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b6ce3e79-aa4a-57e9-8b43-b5be45f75462@arm.com>
In-Reply-To: <b6ce3e79-aa4a-57e9-8b43-b5be45f75462@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7444:EE_
x-ms-office365-filtering-correlation-id: 5cf591eb-3daa-4c04-92e3-08dc1c35d494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgWL3CF8i2RR6t7dHTSG4SIlMuPTJ5jmo868nbfuRfM7/A+/EuadtXWpMoFPEA/dk72z7/p4sdtJzOZJDHYjRt2rDI1I6aXgZJ50ZqjhGK4qlIFX2JfLbeL8opJnlZjxoInA0nnStvjfjhY4C21P77kXW5nJUAPF7hc5zP/NUIBePpDAUGmjCrdZRQh+sdvkpupWUJuMutvDC+AyttV7rEEtnGeIn/xqL0We/nce6ew7+91wF6fWCR/M5uV8h5nyor9WbH8UyrElKp898Ohq4zh0gPf8f9kD1yfTWoF92jt4/5o3NLZ4wG5J7Xp1BEcm31+BPTGVZEagq8ALuYpk1L4JMfNUUY7jKQD4z60C9X1gSlSDtzUzvAPOkamWFDWAbuBS29PlnMcYlovtzV/Migrlq3YzhaoI8YAlpln6GqGfd2ZlWp5BKyHQjT2UBornDWdSX62l/G0Ihobv0g8Kx8mPaasvJ5KeAvevTFSj9y1hx+vuZydZ5SyFPvq4ibyy3zY+gyB1yEPL5G+ix3xsgj9cREEZ+uqrr7afs7Zk6u3ORbPcIvw2mdE2rQyM/LkQvupaJqmBNRvX1ica5mqpwgnJv9zFsYnZ9OvIe5pkr+oxlVGvnDZJdQQ7wVYl17HCxHvh/WI2KIvNOWpdDEpdok3KVxtRskYQRvoRync3oro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(316002)(38100700002)(71200400001)(8676002)(26005)(4326008)(8936002)(41300700001)(478600001)(2906002)(6506007)(7696005)(66446008)(52536014)(64756008)(76116006)(5660300002)(122000001)(66946007)(6636002)(66476007)(66556008)(110136005)(54906003)(9686003)(82960400001)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEVQVmVSZUN2L3dMaVRYcmp5L0dCM2JoWXlsQkdFYjVETExLRlBGUjhXTnNV?=
 =?utf-8?B?MGFXcW9wUTZUL2VOSG8wMVhUSGxValc3TVpSM3Z2aUtYUGticVluUkh0WGtN?=
 =?utf-8?B?bmNTay9LeTRpRnRoV1VpcUdwKy9yZFF1bUNwZ25BeHJDZHg0V1pSVVJ0Yk1K?=
 =?utf-8?B?cjA0by91Q3FPN0FqMVlESVpFbE5KRG80UkpJYzRlTUhIa0czMnVMdEpIaVJh?=
 =?utf-8?B?WTZ0dVdJbkxTQVJSZUVQKy8wRmtleWhWci8zUEVoMjRESzJoanRBWkhFRDhD?=
 =?utf-8?B?czh5a3lQZHR3WlR0cFM3OGxqTFh4bTJObGdidCsva2ZXSmhzUlJJcHpvYzhj?=
 =?utf-8?B?STRDbmhmVUJpRmQ2ZlFmYnBaaE5kakVUUDNkR1NDTld2ODB1QURkTTJiOS96?=
 =?utf-8?B?aFY0aTk4WHdWQjZ3UndkT29tZEhnRWJ0U2pZVktSelBmM3JiemNyQU44TFhO?=
 =?utf-8?B?QXN3TVpWYndEVXZKRkVrK2o1cVd4WGlySmIvTXlPYmZhMVY2dEV5eHR6dkt2?=
 =?utf-8?B?akx3UHEzT0xBTTZqYXExZ1phK0NzN1o0VGZGL253Lzh6T0hSVXVzTUpEUUNs?=
 =?utf-8?B?d2VJdnBici9OdVkwTWJvVVp1U241SG85U0FQK2N3Y050REs0emNmQmI0bkhr?=
 =?utf-8?B?YUlwV0JKN0I0V2Q5MXNqaEREOTR0NldNcHZScFdtVzZWd3RrS04rUEppZFl5?=
 =?utf-8?B?dmc0bVgvRTZPck5YSXFaSDFGWExRRVNUVVl5bVlSRjJiK0c0dVNtNkwxYlRp?=
 =?utf-8?B?bkZHMUtma056a1RiSG1mQlhnZzlqV1RCL29XLzB5dlp4dmwzREUxUjM4bFp2?=
 =?utf-8?B?bjUxQ1dFb1cvR2wzcEVTRm5xOFR6Q0ptQlFTejBXQTFabjRGR1ZzOEFleXNm?=
 =?utf-8?B?bDhoeGk0Ly9Fa0VOakFGemJnRS9hSEc5MDROTHFveWVzK29KRlZ6NUU3MFFz?=
 =?utf-8?B?L3VjVnZwUTFkRGU0L1UzZzF2U01MWkxQSjFSZUJCSHlyZlhvclRTb1dDUmZD?=
 =?utf-8?B?Tmp2WkJmVjI4MVBVMVlhdlR3MDNmTVFZcFNlaE5EQzAwVWh6bmN2aFMwTGY3?=
 =?utf-8?B?blFxUVNhL1YyaGRXbHg0bWw5RVNnTHJSdmVoaDBlaU9qcW1KUVdiRkU0WmlW?=
 =?utf-8?B?ZHY1cHVEQldmVE1kMmJld0tyc21rOEVxNkZTdyt3Rlp0NnlMRmgzcTdnUHhT?=
 =?utf-8?B?ak1Ta0Vibmp5MThoMmdwNVo1N29MM05Kdmo3L1RmcU5EeXhmMnYvYXM3d3d5?=
 =?utf-8?B?UmdrUnJLNnlKTWpCbmtwUHVaOE9VSU9ub2hyMis1V0pXZ2d0KzZlbVFjTTZM?=
 =?utf-8?B?YVZGcHJzTWpNWm5LSEwyV015dy9SdFVyUlRickpCR2dDamRyMkNhMHRlSFFF?=
 =?utf-8?B?TE1xcjhLVnRQMzU3a3hrOENVZFRiRERHTWQ4bHkvaVdnMEQxeGhWeStQTnd3?=
 =?utf-8?B?SFFXeUIxNjBBNmVXaUFKVlBnenhodTd3eGJaNWhPUTJmbUgxM0xaMHdFYzBX?=
 =?utf-8?B?WFJId1Zvd0dhNjBvanptVUhvL25sWklNYXlNbys3QmNWVDJOUHJhNXpIZ2RS?=
 =?utf-8?B?N1JtVTJCTGNsY0N1Q0podHUzNUpRd2pVZlRSNkhrVzNtQU5oM1N1SXZpcUxU?=
 =?utf-8?B?eURwU0lRcm1MZU5rem11STAvSHlQRHRCWFliWkhDN2k2ekZraFJBaTR6R1dH?=
 =?utf-8?B?V0tXU1o2aTZRZEdHYzQwQ05GOXpsdThRNTZudHZ5YmpsL2VSV1VPbCtnU3RH?=
 =?utf-8?B?K28zR0VqcExMc3VpcVp3MDRGWllQYjVFWjNuUkpadklhSjdTRVVHSnI5TU1B?=
 =?utf-8?B?MEVoa1I3MzcrdE93RW9ySHVwNzkvTUk3MGJVY3NadkNjdDJISmRRU3B1WlFo?=
 =?utf-8?B?MllNUTlqMFhmZjAraGhTaDBhNlJzd3Y3dC83aWtTNGh0a1VFZkpVYVNPbERU?=
 =?utf-8?B?U0JLNDBzN2xscTJDTnZWUHgzRzk0TVRrR3MvQ2VTU0pYWlFiYlUvcXl1dFdW?=
 =?utf-8?B?UFRkWFRNejNXZldENEhCU0ZRY3o1VzE3cFVWYVYvRVVPMUtDVGRmRUZFYlll?=
 =?utf-8?B?azVQOXhRMnBOK2xpNUJpMUFxRVlGTWF6bk1MVkZqWExsbEtsM1FGQUdNUE9z?=
 =?utf-8?Q?6ez59P5qkDzMv3f8AGr78UkTh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf591eb-3daa-4c04-92e3-08dc1c35d494
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 17:07:50.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43pfBKnGYiTkTaXyyyAqzw3/h8kSIWI2fmRAAK+1MRsEXApaaL2cm/nyfANrxNqgFRwF7FLH2E3rDT0la0P+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com

Pj4gSSBuZWVkIHRvIGdyYWIgYW4gU05DIHN5c3RlbSB0byByZS1jaGVjayB0aGF0IGV2ZXJ5dGhp
bmcgc3RpbGwgd29ya3Mgd2hlbiByZS1iYXNlZC4NCj4+IEJ1dCByaWdodCBub3csIHRoaXMgbG9v
a3MgbGlrZSBhZGRpbmcgdGhlIFNOQyBzZXJpZXMgd2lsbCBiZSBlYXN5IChmYW1vdXMgbGFzdCB3
b3JkcyEpLg0KPg0KPiBPbmNlIHlvdSdyZSByZWFkeSAtIGNhbiB5b3UgcG9pbnQgbWUgYXQgc29t
ZXRoaW5nIEkgY2FuIHVzZSBhcyBhIHN0YWJsZSBicmFuY2ggdG8gcmViYXNlIG9udG8/DQoNCkkn
bGwgYmUgcnVubmluZyB0aGUgdGVzdHMgdGhpcyBhZnRlcm5vb24uIEJ1dCBJJ20gc29tZXdoYXQg
Y29uZmlkZW50IHRoYXQgdGhleSB3aWxsIHBhc3MuDQoNClRyZWUgaXMgaGVyZTogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FlZ2wvbGludXguZ2l0IGJyYW5j
aCAiaG9wZWZ1bF9zbmMiDQoNCkNvbW1pdHMgYXJlOg0KDQo3OTM2MzVmMTBhZWIgeDg2L3Jlc2N0
cmw6IFVwZGF0ZSBkb2N1bWVudGF0aW9uIHdpdGggU3ViLU5VTUEgY2x1c3RlciBjaGFuZ2VzDQpk
Y2E3YmE3ODVkNmYgeDg2L3Jlc2N0cmw6IFN1YiBOVU1BIENsdXN0ZXIgZGV0ZWN0aW9uIGFuZCBl
bmFibGUNCmU0MWJkODgxMDFjOCB4ODYvcmVzY3RybDogSW50cm9kdWNlIHNuY19ub2Rlc19wZXJf
bDNfY2FjaGUNCmNjYmFiNzg3NTE5NyB4ODYvcmVzY3RybDogQWRkIG5vZGUtc2NvcGUgdG8gdGhl
IG9wdGlvbnMgZm9yIGZlYXR1cmUgc2NvcGUNCjJmMGRiOGM3MDcyYiB4ODYvcmVzY3RybDogU3Bs
aXQgdGhlIHJkdF9kb21haW4gYW5kIHJkdF9od19kb21haW4gc3RydWN0dXJlcw0KMjI2OTc2Mjdj
YzVmIHg4Ni9yZXNjdHJsOiBQcmVwYXJlIGZvciBkaWZmZXJlbnQgc2NvcGUgZm9yIGNvbnRyb2wv
bW9uaXRvciBvcGVyYXRpb25zDQpmM2ZmODMxYTkwNDIgeDg2L3Jlc2N0cmw6IFByZXBhcmUgdG8g
c3BsaXQgcmR0X2RvbWFpbiBzdHJ1Y3R1cmUNCmMwNjc5ODY4ZWU3OCB4ODYvcmVzY3RybDogUHJl
cGFyZSBmb3IgbmV3IGRvbWFpbiBzY29wZQ0KMzI3YjQzOTRmMzA5IHg4Ni9yZXNjdHJsOiBJbXBs
ZW1lbnQgbmV3IG1iYV9NQnBzIHRocm90dGxpbmcgaGV1cmlzdGljDQo1YjE0ODE3Y2Y4N2UgeDg2
L3Jlc2N0cmw6IFJlYWQgc3VwcG9ydGVkIGJhbmR3aWR0aCBzb3VyY2VzIHVzaW5nIENQVUlEIGNv
bW1hbmQNCjU2OTljZDA4MmUxZiB4ODYvcmVzY3RybDogUmVtb3ZlIGhhcmQtY29kZWQgbWVtb3J5
IGJhbmR3aWR0aCBsaW1pdA0KMWI5MDhkZWJmNTNmIHg4Ni9yZXNjdHJsOiBGaXggdW51c2VkIHZh
cmlhYmxlIHdhcm5pbmcgaW4gY2FjaGVfYWxsb2NfaHN3X3Byb2JlKCkNCg0KT25seSB0aGUgbGFz
dCBvZiB0aGVzZSAoMWI5MDhkZWJmNTNmKSBoYWQgYmVlbiBhY2NlcHRlZCBieSBCb3JpcyBpbnRv
IFRJUCB4ODYvY2FjaGUNCndoZW4gSSBjdXQgdGhpcyB0cmVlIHllc3RlcmRheS4NCg0KVHdvIG1v
cmUgYXBwbGllZCBieSBCb3JpcyB0b2RheSB3aXRob3V0IGFueSBjaGFuZ2VzIGZyb20gd2hhdCBp
cyBpbiBteSB0cmVlLCBidXQgdGhlDQpjb21taXQgSURzIGluIFRJUCBhcmUgb2J2aW91c2x5IGRp
ZmZlcmVudCBmcm9tIGluIG15IHRyZWUuDQoNCjU0ZTM1ZWI4NjExYyB4ODYvcmVzY3RybDogUmVh
ZCBzdXBwb3J0ZWQgYmFuZHdpZHRoIHNvdXJjZXMgZnJvbSBDUFVJRA0KMDk3Njc4M2JiMTIzIHg4
Ni9yZXNjdHJsOiBSZW1vdmUgaGFyZC1jb2RlZCBtZW1vcnkgYmFuZHdpZHRoIGxpbWl0DQoNCkFs
bCB0aGUgb3RoZXJzIGhhdmUgdGhlIG5vcm1hbCByaXNrIHRoYXQgQm9yaXMgd2lsbCBmaW5kIHNv
bWUgd2F5IHRvIG1ha2UgdGhlbSBiZXR0ZXIuDQoNCi1Ub255DQo=

